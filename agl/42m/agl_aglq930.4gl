#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq930.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-12-21 16:51:35), PR版次:0003(2016-11-29 11:19:03)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: aglq930
#+ Description: 合併報表資產負債工作底稿查詢
#+ Creator....: 05016(2015-12-14 10:18:35)
#+ Modifier...: 05016 -SD/PR- 02481
 
{</section>}
 
{<section id="aglq930.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160705-00042#8   2016/07/12  By sakura   程式中寫死g_prog部分改寫MATCHES方式
#161128-00061#1   2016/11/29  by 02481  标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE TYPE type_g_gldn_d RECORD
       #statepic       LIKE type_t.chr1,
       
       l_assest1 LIKE type_t.chr500, 
   l_glfb0311 LIKE type_t.num5, 
   l_gldn010_01 LIKE type_t.num20_6, 
   l_gldn010_02 LIKE type_t.num20_6, 
   l_gldn010_03 LIKE type_t.num20_6, 
   l_gldn010_04 LIKE type_t.num20_6, 
   l_gldn010_05 LIKE type_t.num20_6, 
   l_gldn010_06 LIKE type_t.num20_6, 
   l_gldn010_07 LIKE type_t.num20_6, 
   l_gldn010_08 LIKE type_t.num20_6, 
   l_gldn010_09 LIKE type_t.num20_6, 
   l_gldn010_10 LIKE type_t.num20_6, 
   l_gldn010_11 LIKE type_t.num20_6, 
   l_gldn010_12 LIKE type_t.num20_6, 
   l_gldn010_13 LIKE type_t.num20_6, 
   l_gldn010_14 LIKE type_t.num20_6, 
   l_gldn010_15 LIKE type_t.num20_6, 
   l_gldn010_16 LIKE type_t.num20_6, 
   l_gldn010_17 LIKE type_t.num20_6, 
   l_gldn010_18 LIKE type_t.num20_6, 
   l_gldn010_19 LIKE type_t.num20_6, 
   l_gldn010_20 LIKE type_t.num20_6, 
   l_gldq0171 LIKE type_t.num20_6, 
   l_gldq0181 LIKE type_t.num20_6, 
   l_gldq0172 LIKE type_t.num20_6, 
   l_gldq0182 LIKE type_t.num20_6, 
   l_gldq0173 LIKE type_t.num20_6, 
   l_gldq0183 LIKE type_t.num20_6, 
   l_amt1 LIKE type_t.num20_6, 
   l_assest2 LIKE type_t.chr500, 
   l_glfb0312 LIKE type_t.num5, 
   l_gldn010_21 LIKE type_t.num20_6, 
   l_gldn010_22 LIKE type_t.num20_6, 
   l_gldn010_23 LIKE type_t.num20_6, 
   l_gldn010_24 LIKE type_t.num20_6, 
   l_gldn010_25 LIKE type_t.num20_6, 
   l_gldn010_26 LIKE type_t.num20_6, 
   l_gldn010_27 LIKE type_t.num20_6, 
   l_gldn010_28 LIKE type_t.num20_6, 
   l_gldn010_29 LIKE type_t.num20_6, 
   l_gldn010_30 LIKE type_t.num20_6, 
   l_gldn010_31 LIKE type_t.num20_6, 
   l_gldn010_32 LIKE type_t.num20_6, 
   l_gldn010_33 LIKE type_t.num20_6, 
   l_gldn010_34 LIKE type_t.num20_6, 
   l_gldn010_35 LIKE type_t.num20_6, 
   l_gldn010_36 LIKE type_t.num20_6, 
   l_gldn010_37 LIKE type_t.num20_6, 
   l_gldn010_38 LIKE type_t.num20_6, 
   l_gldn010_39 LIKE type_t.num20_6, 
   l_gldn010_40 LIKE type_t.num20_6, 
   l_gldq0174 LIKE type_t.num20_6, 
   l_gldq0184 LIKE type_t.num20_6, 
   l_gldq0175 LIKE type_t.num20_6, 
   l_gldq0185 LIKE type_t.num20_6, 
   l_gldq0176 LIKE type_t.num20_6, 
   l_gldq0186 LIKE type_t.num20_6, 
   l_amt2 LIKE type_t.num20_6, 
   gldn001 LIKE gldn_t.gldn001, 
   gldn002 LIKE gldn_t.gldn002, 
   gldn003 LIKE gldn_t.gldn003, 
   gldn004 LIKE gldn_t.gldn004, 
   gldn005 LIKE gldn_t.gldn005, 
   gldn006 LIKE gldn_t.gldn006, 
   gldn007 LIKE gldn_t.gldn007, 
   gldn008 LIKE gldn_t.gldn008, 
   gldn032 LIKE gldn_t.gldn032, 
   gldn033 LIKE gldn_t.gldn033, 
   gldn040 LIKE gldn_t.gldn040, 
   gldn041 LIKE gldn_t.gldn041, 
   gldnld LIKE gldn_t.gldnld, 
   l_glfbseq LIKE type_t.num10 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input RECORD
   l_glfa001      LIKE glfa_t.glfa001,    #報表模板編號
   l_glfa002      LIKE glfa_t.glfa002,    #報表類型
   l_glfa005      LIKE glfa_t.glfa005,    #合併帳別
   l_glfa006      LIKE glfa_t.glfa006,    #年度
   l_glfa007      LIKE glfa_t.glfa007,    #期別
   l_glfa008      LIKE glfa_t.glfa008,    #單位
   l_glfa009      LIKE glfa_t.glfa009,    #小數位數
   l_glfa005_desc LIKE type_t.chr100,
   l_glfa001_desc LIKE type_t.chr100
END RECORD

DEFINE g_tree_idx   LIKE type_t.num10
DEFINE g_tree       DYNAMIC ARRAY OF RECORD
         show          LIKE type_t.chr100,    #外顯欄位
         pid           LIKE type_t.chr100,    #父節點id
         id            LIKE type_t.chr100,    #本身節點id
         exp           LIKE type_t.chr100,    #是否展開
         hasC          LIKE type_t.num5,      #是否有子節點
         isExp         LIKE type_t.num5,      #是否已展開
         expcode       LIKE type_t.num5,      #展開值
         gldbld        LIKE gldb_t.gldbld,    #跟雙檔g_browser對的KEY1
         gldb001       LIKE gldb_t.gldb001,   #跟雙檔g_browser對的KEY2
         gldc002       LIKE gldc_t.gldc002,   #下層公司編號
         glec005       LIKE type_t.chr500     #編制進度 
                    END RECORD
DEFINE g_tree_pid   LIKE type_t.chr100
DEFINE g_glfa004    LIKE glfa_t.glfa004 #科目參照表
DEFINE g_gldn_d2          DYNAMIC ARRAY OF type_g_gldn_d
DEFINE g_gldn_d3          DYNAMIC ARRAY OF type_g_gldn_d
DEFINE g_glaa015    LIKE glaa_t.glaa015 #本位幣二是否開啟
DEFINE g_glaa019    LIKE glaa_t.glaa019 #本位幣三是否開啟
#資料瀏覽之欄位 
DEFINE g_gldc_d       DYNAMIC ARRAY OF RECORD    
        gldcld         LIKE gldc_t.gldcld
      END RECORD

DEFINE g_current_row   LIKE type_t.num5
DEFINE g_current_idx   LIKE type_t.num10
DEFINE g_jump          LIKE type_t.num10
DEFINE g_no_ask        LIKE type_t.num5
DEFINE g_rec_b         LIKE type_t.num5 

DEFINE g_gldcld LIKE gldc_t.gldcld
DEFINE g_wc3 STRING
DEFINE g_glfa003 LIKE glfa_t.glfa003
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_gldn_d
DEFINE g_master_t                   type_g_gldn_d
DEFINE g_gldn_d          DYNAMIC ARRAY OF type_g_gldn_d
DEFINE g_gldn_d_t        type_g_gldn_d
 
      
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
 
{<section id="aglq930.main" >}
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
   DECLARE aglq930_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq930_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq930_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq930 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq930_init()   
 
      #進入選單 Menu (="N")
      CALL aglq930_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq930
      
   END IF 
   
   CLOSE aglq930_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq930.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq930_init()
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
   CALL cl_set_combo_scc_part('l_glfa002','9930','1') 
   CALL cl_set_combo_scc('l_glfa008','8705') 
   CALL aglq930_default()
   #end add-point
 
   CALL aglq930_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aglq930.default_search" >}
PRIVATE FUNCTION aglq930_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " gldnld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " gldn001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " gldn002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " gldn003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " gldn004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " gldn005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " gldn006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " gldn007 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " gldn008 = '", g_argv[09], "' AND "
   END IF
   IF NOT cl_null(g_argv[10]) THEN
      LET g_wc = g_wc, " gldn032 = '", g_argv[10], "' AND "
   END IF
   IF NOT cl_null(g_argv[11]) THEN
      LET g_wc = g_wc, " gldn033 = '", g_argv[11], "' AND "
   END IF
   IF NOT cl_null(g_argv[12]) THEN
      LET g_wc = g_wc, " gldn040 = '", g_argv[12], "' AND "
   END IF
   IF NOT cl_null(g_argv[13]) THEN
      LET g_wc = g_wc, " gldn041 = '", g_argv[13], "' AND "
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
 
{<section id="aglq930.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq930_ui_dialog()
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
      CALL aglq930_b_fill()
   ELSE
      CALL aglq930_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_gldn_d.clear()
 
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
 
         CALL aglq930_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_gldn_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq930_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq930_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               IF g_header_cnt=1 THEN
                  CALL cl_set_act_visible("first,previous,jump,next,last",FALSE)
               ELSE
                  IF g_current_idx=1 THEN
                     CALL cl_set_act_visible("first,previous", FALSE)
                     CALL cl_set_act_visible("jump,next,last", TRUE)
                  ELSE
                     IF g_current_idx<>g_header_cnt THEN
                        CALL cl_set_act_visible("first,previous,jump,next,last",TRUE)
                     ELSE
                        CALL cl_set_act_visible("first,previous,jump",TRUE)
                        CALL cl_set_act_visible("next,last", FALSE)
                     END IF
                  END IF
               END IF
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
 
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_tree TO s_detail2.* ATTRIBUTES(COUNT=g_tree_idx)
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")          
               LET l_ac = 1
            IF g_header_cnt=1 THEN
               CALL cl_set_act_visible("first,previous,jump,next,last",FALSE)
            ELSE
               IF g_current_idx=1 THEN
                  CALL cl_set_act_visible("first,previous", FALSE)
                  CALL cl_set_act_visible("jump,next,last", TRUE)
               ELSE
                  IF g_current_idx<>g_header_cnt THEN
                     CALL cl_set_act_visible("first,previous,jump,next,last",TRUE)
                  ELSE
                     CALL cl_set_act_visible("first,previous,jump",TRUE)
                     CALL cl_set_act_visible("next,last", FALSE)
                  END IF
               END IF
            END IF
         END DISPLAY
        
         DISPLAY ARRAY g_gldn_d2 TO s_detail3.* ATTRIBUTES(COUNT=g_tree_idx)
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")          
               LET l_ac = 1
         END DISPLAY
        
         DISPLAY ARRAY g_gldn_d3 TO s_detail4.* ATTRIBUTES(COUNT=g_tree_idx)
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail4")          
               LET l_ac = 1
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aglq930_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible('filter',FALSE)
            IF g_header_cnt=1 THEN
               CALL cl_set_act_visible("first,previous,jump,next,last",FALSE)
            ELSE
               IF g_current_idx=1 THEN
                  CALL cl_set_act_visible("first,previous", FALSE)
                  CALL cl_set_act_visible("jump,next,last", TRUE)
               ELSE
                  IF g_current_idx<>g_header_cnt THEN
                     CALL cl_set_act_visible("first,previous,jump,next,last",TRUE)
                  ELSE
                     CALL cl_set_act_visible("first,previous,jump",TRUE)
                     CALL cl_set_act_visible("next,last", FALSE)
                  END IF
               END IF
            END IF
            CALL cl_set_comp_visible('sel', FALSE)
            CALL cl_set_act_visible('selall,selnone,unsel,sel',FALSE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglq930_query()
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
            CALL aglq930_filter()
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
            CALL aglq930_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_gldn_d)
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
            CALL aglq930_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq930_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq930_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq930_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION previous
            LET g_action_choice="previous"
            CALL aglq930_fetch1('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
            
         ON ACTION first
            LET g_action_choice="first"
            CALL aglq930_fetch1('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
         
         ON ACTION jump
            LET g_action_choice="jump"
            CALL aglq930_fetch1('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
            
         ON ACTION next
            LET g_action_choice="next"
            CALL aglq930_fetch1('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
            
         ON ACTION last
            LET g_action_choice="last"
            CALL aglq930_fetch1('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
         
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
 
{<section id="aglq930.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq930_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_gldn_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn007,gldn008,gldn032, 
          gldn033,gldn040,gldn041,gldnld
           FROM s_detail1[1].b_gldn001,s_detail1[1].b_gldn002,s_detail1[1].b_gldn003,s_detail1[1].b_gldn004, 
               s_detail1[1].b_gldn005,s_detail1[1].b_gldn006,s_detail1[1].b_gldn007,s_detail1[1].b_gldn008, 
               s_detail1[1].b_gldn032,s_detail1[1].b_gldn033,s_detail1[1].b_gldn040,s_detail1[1].b_gldn041, 
               s_detail1[1].b_gldnld
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            NEXT FIELD l_glfa002
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<l_assest1>>----
         #----<<l_glfb0311>>----
         #----<<l_gldn010_01>>----
         #----<<l_gldn010_02>>----
         #----<<l_gldn010_03>>----
         #----<<l_gldn010_04>>----
         #----<<l_gldn010_05>>----
         #----<<l_gldn010_06>>----
         #----<<l_gldn010_07>>----
         #----<<l_gldn010_08>>----
         #----<<l_gldn010_09>>----
         #----<<l_gldn010_10>>----
         #----<<l_gldn010_11>>----
         #----<<l_gldn010_12>>----
         #----<<l_gldn010_13>>----
         #----<<l_gldn010_14>>----
         #----<<l_gldn010_15>>----
         #----<<l_gldn010_16>>----
         #----<<l_gldn010_17>>----
         #----<<l_gldn010_18>>----
         #----<<l_gldn010_19>>----
         #----<<l_gldn010_20>>----
         #----<<l_gldq0171>>----
         #----<<l_gldq0181>>----
         #----<<l_gldq0172>>----
         #----<<l_gldq0182>>----
         #----<<l_gldq0173>>----
         #----<<l_gldq0183>>----
         #----<<l_amt1>>----
         #----<<l_assest2>>----
         #----<<l_glfb0312>>----
         #----<<l_gldn010_21>>----
         #----<<l_gldn010_22>>----
         #----<<l_gldn010_23>>----
         #----<<l_gldn010_24>>----
         #----<<l_gldn010_25>>----
         #----<<l_gldn010_26>>----
         #----<<l_gldn010_27>>----
         #----<<l_gldn010_28>>----
         #----<<l_gldn010_29>>----
         #----<<l_gldn010_30>>----
         #----<<l_gldn010_31>>----
         #----<<l_gldn010_32>>----
         #----<<l_gldn010_33>>----
         #----<<l_gldn010_34>>----
         #----<<l_gldn010_35>>----
         #----<<l_gldn010_36>>----
         #----<<l_gldn010_37>>----
         #----<<l_gldn010_38>>----
         #----<<l_gldn010_39>>----
         #----<<l_gldn010_40>>----
         #----<<l_gldq0174>>----
         #----<<l_gldq0184>>----
         #----<<l_gldq0175>>----
         #----<<l_gldq0185>>----
         #----<<l_gldq0176>>----
         #----<<l_gldq0186>>----
         #----<<l_amt2>>----
         #----<<b_gldn001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gldn001
            #add-point:BEFORE FIELD b_gldn001 name="construct.b.page1.b_gldn001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gldn001
            
            #add-point:AFTER FIELD b_gldn001 name="construct.a.page1.b_gldn001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gldn001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn001
            #add-point:ON ACTION controlp INFIELD b_gldn001 name="construct.c.page1.b_gldn001"
            
            #END add-point
 
 
         #----<<b_gldn002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gldn002
            #add-point:BEFORE FIELD b_gldn002 name="construct.b.page1.b_gldn002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gldn002
            
            #add-point:AFTER FIELD b_gldn002 name="construct.a.page1.b_gldn002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gldn002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn002
            #add-point:ON ACTION controlp INFIELD b_gldn002 name="construct.c.page1.b_gldn002"
            
            #END add-point
 
 
         #----<<b_gldn003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gldn003
            #add-point:BEFORE FIELD b_gldn003 name="construct.b.page1.b_gldn003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gldn003
            
            #add-point:AFTER FIELD b_gldn003 name="construct.a.page1.b_gldn003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gldn003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn003
            #add-point:ON ACTION controlp INFIELD b_gldn003 name="construct.c.page1.b_gldn003"
            
            #END add-point
 
 
         #----<<b_gldn004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gldn004
            #add-point:BEFORE FIELD b_gldn004 name="construct.b.page1.b_gldn004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gldn004
            
            #add-point:AFTER FIELD b_gldn004 name="construct.a.page1.b_gldn004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gldn004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn004
            #add-point:ON ACTION controlp INFIELD b_gldn004 name="construct.c.page1.b_gldn004"
            
            #END add-point
 
 
         #----<<b_gldn005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gldn005
            #add-point:BEFORE FIELD b_gldn005 name="construct.b.page1.b_gldn005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gldn005
            
            #add-point:AFTER FIELD b_gldn005 name="construct.a.page1.b_gldn005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gldn005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn005
            #add-point:ON ACTION controlp INFIELD b_gldn005 name="construct.c.page1.b_gldn005"
            
            #END add-point
 
 
         #----<<b_gldn006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gldn006
            #add-point:BEFORE FIELD b_gldn006 name="construct.b.page1.b_gldn006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gldn006
            
            #add-point:AFTER FIELD b_gldn006 name="construct.a.page1.b_gldn006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gldn006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn006
            #add-point:ON ACTION controlp INFIELD b_gldn006 name="construct.c.page1.b_gldn006"
            
            #END add-point
 
 
         #----<<b_gldn007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gldn007
            #add-point:BEFORE FIELD b_gldn007 name="construct.b.page1.b_gldn007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gldn007
            
            #add-point:AFTER FIELD b_gldn007 name="construct.a.page1.b_gldn007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gldn007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn007
            #add-point:ON ACTION controlp INFIELD b_gldn007 name="construct.c.page1.b_gldn007"
            
            #END add-point
 
 
         #----<<b_gldn008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gldn008
            #add-point:BEFORE FIELD b_gldn008 name="construct.b.page1.b_gldn008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gldn008
            
            #add-point:AFTER FIELD b_gldn008 name="construct.a.page1.b_gldn008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gldn008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn008
            #add-point:ON ACTION controlp INFIELD b_gldn008 name="construct.c.page1.b_gldn008"
            
            #END add-point
 
 
         #----<<b_gldn032>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gldn032
            #add-point:BEFORE FIELD b_gldn032 name="construct.b.page1.b_gldn032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gldn032
            
            #add-point:AFTER FIELD b_gldn032 name="construct.a.page1.b_gldn032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gldn032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn032
            #add-point:ON ACTION controlp INFIELD b_gldn032 name="construct.c.page1.b_gldn032"
            
            #END add-point
 
 
         #----<<b_gldn033>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gldn033
            #add-point:BEFORE FIELD b_gldn033 name="construct.b.page1.b_gldn033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gldn033
            
            #add-point:AFTER FIELD b_gldn033 name="construct.a.page1.b_gldn033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gldn033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn033
            #add-point:ON ACTION controlp INFIELD b_gldn033 name="construct.c.page1.b_gldn033"
            
            #END add-point
 
 
         #----<<b_gldn040>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gldn040
            #add-point:BEFORE FIELD b_gldn040 name="construct.b.page1.b_gldn040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gldn040
            
            #add-point:AFTER FIELD b_gldn040 name="construct.a.page1.b_gldn040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gldn040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn040
            #add-point:ON ACTION controlp INFIELD b_gldn040 name="construct.c.page1.b_gldn040"
            
            #END add-point
 
 
         #----<<b_gldn041>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gldn041
            #add-point:BEFORE FIELD b_gldn041 name="construct.b.page1.b_gldn041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gldn041
            
            #add-point:AFTER FIELD b_gldn041 name="construct.a.page1.b_gldn041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gldn041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn041
            #add-point:ON ACTION controlp INFIELD b_gldn041 name="construct.c.page1.b_gldn041"
            
            #END add-point
 
 
         #----<<b_gldnld>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gldnld
            #add-point:BEFORE FIELD b_gldnld name="construct.b.page1.b_gldnld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gldnld
            
            #add-point:AFTER FIELD b_gldnld name="construct.a.page1.b_gldnld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gldnld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldnld
            #add-point:ON ACTION controlp INFIELD b_gldnld name="construct.c.page1.b_gldnld"
            
            #END add-point
 
 
         #----<<l_glfbseq>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      CONSTRUCT BY NAME g_wc3 ON gldcld
            BEFORE CONSTRUCT

         END CONSTRUCT 
      
      
      INPUT BY NAME g_input.l_glfa001,g_input.l_glfa002,g_input.l_glfa005,g_input.l_glfa006,
                    g_input.l_glfa007,g_input.l_glfa008,g_input.l_glfa009,g_input.l_glfa005_desc,
                    g_input.l_glfa001_desc
         ATTRIBUTE(WITHOUT DEFAULTS)
       
         AFTER FIELD l_glfa001
            IF NOT cl_null(g_input.l_glfa001) THEN
               CALL aglq930_glfa001_chk(g_input.l_glfa001) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_input.l_glfa001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.l_glfa001 = ''
                  NEXT FIELD l_glfa001                                                                                        
               END IF                             
            END IF            
            CALL aglq930_glfa001_ref(g_input.l_glfa001) RETURNING g_input.l_glfa001_desc
            DISPLAY BY NAME g_input.l_glfa001_desc
      
      AFTER FIELD l_glfa005
         IF NOT cl_null(g_input.l_glfa005) THEN
            CALL aglq930_glfa005_chk(g_input.l_glfa005) RETURNING g_sub_success,g_errno
            IF NOT g_sub_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_input.l_glfa005
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_input.l_glfa005 = ''
               NEXT FIELD l_glfa005                                                                                        
            END IF          
             CALL s_ld_sel_glaa(g_input.l_glfa005,'glaa015|glaa019')      
                RETURNING g_sub_success,g_glaa015,g_glaa019            
             CALL cl_set_comp_visible('page_2,page_3',FALSE)
             IF g_glaa015 = 'Y' THEN
                CALL cl_set_comp_visible('page_2',TRUE)
             END IF
             IF g_glaa019 = 'Y' THEN
                CALL cl_set_comp_visible('page_3',TRUE)
             END IF
          END IF
          LET g_input.l_glfa005_desc =  s_desc_get_ld_desc(g_input.l_glfa005)
          DISPLAY BY NAME g_input.l_glfa005_desc
      
      ON ACTION controlp INFIELD l_glfa001
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_input.l_glfa001
         #IF g_prog = 'aglq931' THEN        #160705-00042#8 160712 by sakura mark
         IF g_prog MATCHES 'aglq931' THEN   #160705-00042#8 160712 by sakura add
             LET g_qryparam.where = " glfa002='2' AND glfa016 = '2' "
         ELSE
             LET g_qryparam.where = " glfa002='1' AND glfa016 = '2' "
         END IF
         CALL q_glfa001()                          #呼叫開窗
         LET g_input.l_glfa001 = g_qryparam.return1
         DISPLAY g_input.l_glfa001 TO l_glfa001  #顯示到畫面上
         NEXT FIELD l_glfa001 
   
    ON ACTION controlp INFIELD l_glfa005
       LET g_qryparam.state = 'i'
       LET g_qryparam.reqry = FALSE       
       LET g_qryparam.default1 = g_input.l_glfa005        #給予default值
       LET g_qryparam.default2 = "" #glaald #帳別編號
       LET g_qryparam.arg1 = g_user
       LET g_qryparam.arg2 = g_dept
       LET g_qryparam.where =  " glaald IN (SELECT DISTINCT glfa005 FROM glfa_t      ",
                               "             WHERE glfaent = '",g_enterprise,"'      ",
                               "               AND glfa001 = '",g_input.l_glfa001,"' ",
                               "               AND glfa016 = '2'                 )   ",
                               " AND glaald IN (SELECT DISTINCT gldcld FROM gldc_t         ",
                               "                 WHERE gldcent = '",g_enterprise,"'     )  "                             
                       
                               
       CALL q_authorised_ld()                                #呼叫開窗
        
       LET g_input.l_glfa005 = g_qryparam.return1              
       DISPLAY g_input.l_glfa005 TO l_glfa005            
       NEXT FIELD l_glfa005



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
         CALL aglq930_default()
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
#   CALL aglq930_set_page()
#   CALL aglq930_fetch1('F')
#   LET g_error_show = 1
#   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.extend = ""
#      LET g_errparam.code   = -100
#      LET g_errparam.popup  = TRUE
#      CALL cl_err()
#      RETURN
#   END IF
#   RETURN
  
   #end add-point
        
   LET g_error_show = 1
   CALL aglq930_b_fill()
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
 
{<section id="aglq930.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq930_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_glfb004 LIKE glfb_t.glfb004
   DEFINE l_glfb005 LIKE glfb_t.glfb005
   DEFINE l_i       LIKE type_t.num5
   DEFINE l_amt1    LIKE gldq_t.gldq017
   DEFINE l_amt2    LIKE gldq_t.gldq017
   DEFINE l_amt3    LIKE gldq_t.gldq017
   DEFINE l_format        STRING
   DEFINE l_str           STRING
   DEFINE l_flag    LIKE type_t.chr1
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
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:40) add cl_sql_auth_filter()
 
   LET ls_sql_rank = "SELECT  UNIQUE '','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','',gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn007,gldn008,gldn032,gldn033, 
       gldn040,gldn041,gldnld,''  ,DENSE_RANK() OVER( ORDER BY gldn_t.gldnld,gldn_t.gldn001,gldn_t.gldn002, 
       gldn_t.gldn003,gldn_t.gldn004,gldn_t.gldn005,gldn_t.gldn006,gldn_t.gldn007,gldn_t.gldn008,gldn_t.gldn032, 
       gldn_t.gldn033,gldn_t.gldn040,gldn_t.gldn041) AS RANK FROM gldn_t",
 
 
                     "",
                     " WHERE gldnent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("gldn_t"),
                     " ORDER BY gldn_t.gldnld,gldn_t.gldn001,gldn_t.gldn002,gldn_t.gldn003,gldn_t.gldn004,gldn_t.gldn005,gldn_t.gldn006,gldn_t.gldn007,gldn_t.gldn008,gldn_t.gldn032,gldn_t.gldn033,gldn_t.gldn040,gldn_t.gldn041"
 
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
 
   LET g_sql = "SELECT '','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '',gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn007,gldn008,gldn032,gldn033,gldn040,gldn041, 
       gldnld,''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   CALL aglq930_grow_tree()
   CALL aglq930_set_title()

   SELECT glfa004 INTO g_glfa004 FROM glfa_t
    WHERE glfaent = g_enterprise AND glfa001 = g_input.l_glfa001   
    
   LET g_sql =  "   SELECT DISTINCT glfb002,glfb003,                        ",
                "                   '','','','','','','','','','',          ",
                "                   '','','','','','','','','','',          ",
                "                   '','','','','','','',                   ",               
                "                   '','',                                  ",
                "                   '','','','','','','','','','',          ",
                "                   '','','','','','','','','','',          ",
                "                   '','','','','','','',                   ",
                "                   '','','','','','','','','','','','','', ",
                "                   glfbseq                                 ",
                "  FROM glfb_t                                              ",
                " WHERE glfbent= ? AND glfbseq1 IN ('A','B')                ",
                "   AND glfb001 = '",g_input.l_glfa001,"'                   ",
                " ORDER BY glfb003                                          "
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq930_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq930_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_gldn_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_gldn_d[l_ac].l_assest1,g_gldn_d[l_ac].l_glfb0311,g_gldn_d[l_ac].l_gldn010_01, 
       g_gldn_d[l_ac].l_gldn010_02,g_gldn_d[l_ac].l_gldn010_03,g_gldn_d[l_ac].l_gldn010_04,g_gldn_d[l_ac].l_gldn010_05, 
       g_gldn_d[l_ac].l_gldn010_06,g_gldn_d[l_ac].l_gldn010_07,g_gldn_d[l_ac].l_gldn010_08,g_gldn_d[l_ac].l_gldn010_09, 
       g_gldn_d[l_ac].l_gldn010_10,g_gldn_d[l_ac].l_gldn010_11,g_gldn_d[l_ac].l_gldn010_12,g_gldn_d[l_ac].l_gldn010_13, 
       g_gldn_d[l_ac].l_gldn010_14,g_gldn_d[l_ac].l_gldn010_15,g_gldn_d[l_ac].l_gldn010_16,g_gldn_d[l_ac].l_gldn010_17, 
       g_gldn_d[l_ac].l_gldn010_18,g_gldn_d[l_ac].l_gldn010_19,g_gldn_d[l_ac].l_gldn010_20,g_gldn_d[l_ac].l_gldq0171, 
       g_gldn_d[l_ac].l_gldq0181,g_gldn_d[l_ac].l_gldq0172,g_gldn_d[l_ac].l_gldq0182,g_gldn_d[l_ac].l_gldq0173, 
       g_gldn_d[l_ac].l_gldq0183,g_gldn_d[l_ac].l_amt1,g_gldn_d[l_ac].l_assest2,g_gldn_d[l_ac].l_glfb0312, 
       g_gldn_d[l_ac].l_gldn010_21,g_gldn_d[l_ac].l_gldn010_22,g_gldn_d[l_ac].l_gldn010_23,g_gldn_d[l_ac].l_gldn010_24, 
       g_gldn_d[l_ac].l_gldn010_25,g_gldn_d[l_ac].l_gldn010_26,g_gldn_d[l_ac].l_gldn010_27,g_gldn_d[l_ac].l_gldn010_28, 
       g_gldn_d[l_ac].l_gldn010_29,g_gldn_d[l_ac].l_gldn010_30,g_gldn_d[l_ac].l_gldn010_31,g_gldn_d[l_ac].l_gldn010_32, 
       g_gldn_d[l_ac].l_gldn010_33,g_gldn_d[l_ac].l_gldn010_34,g_gldn_d[l_ac].l_gldn010_35,g_gldn_d[l_ac].l_gldn010_36, 
       g_gldn_d[l_ac].l_gldn010_37,g_gldn_d[l_ac].l_gldn010_38,g_gldn_d[l_ac].l_gldn010_39,g_gldn_d[l_ac].l_gldn010_40, 
       g_gldn_d[l_ac].l_gldq0174,g_gldn_d[l_ac].l_gldq0184,g_gldn_d[l_ac].l_gldq0175,g_gldn_d[l_ac].l_gldq0185, 
       g_gldn_d[l_ac].l_gldq0176,g_gldn_d[l_ac].l_gldq0186,g_gldn_d[l_ac].l_amt2,g_gldn_d[l_ac].gldn001, 
       g_gldn_d[l_ac].gldn002,g_gldn_d[l_ac].gldn003,g_gldn_d[l_ac].gldn004,g_gldn_d[l_ac].gldn005,g_gldn_d[l_ac].gldn006, 
       g_gldn_d[l_ac].gldn007,g_gldn_d[l_ac].gldn008,g_gldn_d[l_ac].gldn032,g_gldn_d[l_ac].gldn033,g_gldn_d[l_ac].gldn040, 
       g_gldn_d[l_ac].gldn041,g_gldn_d[l_ac].gldnld,g_gldn_d[l_ac].l_glfbseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_gldn_d[l_ac].statepic = cl_get_actipic(g_gldn_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #取數公式來源#數值取數公式
      SELECT glfb004,glfb005 INTO l_glfb004,l_glfb005
        FROM glfb_t
       WHERE glfbent = g_enterprise
         AND glfb001 = g_input.l_glfa001
         AND glfbseq = g_gldn_d[l_ac].l_glfbseq      
         AND glfbseq1 = 'B' 
             
      #預算金額      
      IF NOT cl_null(l_glfb005) THEN
         IF l_glfb004 = '1' THEN #取表內公式
            CALL s_analy_form_get_coordinate(g_input.l_glfa001,l_glfb005)
               RETURNING  g_sub_success,l_glfb005             
         END IF
         FOR l_i = 1 TO g_tree.getLength()
            CASE l_i
               WHEN 1                  
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_01                 
               WHEN 2                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_02
               WHEN 3                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_03
               WHEN 4                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_04
               WHEN 5                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_05
               WHEN 6                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_06
               WHEN 7                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_07
               WHEN 8                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_08
               WHEN 9                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_09
               WHEN 10                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_10
               WHEN 11                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_11
               WHEN 12                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_12
               WHEN 13                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_13
               WHEN 14                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_14
               WHEN 15                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_15
               WHEN 16                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_16
               WHEN 17                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_17
               WHEN 18
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_18
               WHEN 19
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_19
               WHEN 20
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_20
            END CASE             
         END FOR
      END IF        
      IF cl_null(g_gldn_d[l_ac].l_gldn010_01) THEN LET g_gldn_d[l_ac].l_gldn010_01 = 0 END IF
      IF cl_null(g_gldn_d[l_ac].l_gldn010_02) THEN LET g_gldn_d[l_ac].l_gldn010_02 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_03) THEN LET g_gldn_d[l_ac].l_gldn010_03 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_04) THEN LET g_gldn_d[l_ac].l_gldn010_04 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_05) THEN LET g_gldn_d[l_ac].l_gldn010_05 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_06) THEN LET g_gldn_d[l_ac].l_gldn010_06 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_07) THEN LET g_gldn_d[l_ac].l_gldn010_07 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_08) THEN LET g_gldn_d[l_ac].l_gldn010_08 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_09) THEN LET g_gldn_d[l_ac].l_gldn010_09 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_10) THEN LET g_gldn_d[l_ac].l_gldn010_10 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_11) THEN LET g_gldn_d[l_ac].l_gldn010_11 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_12) THEN LET g_gldn_d[l_ac].l_gldn010_12 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_13) THEN LET g_gldn_d[l_ac].l_gldn010_13 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_14) THEN LET g_gldn_d[l_ac].l_gldn010_14 = 0 END IF
      IF cl_null(g_gldn_d[l_ac].l_gldn010_15) THEN LET g_gldn_d[l_ac].l_gldn010_15 = 0 END IF       
      IF cl_null(g_gldn_d[l_ac].l_gldn010_16) THEN LET g_gldn_d[l_ac].l_gldn010_16 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_17) THEN LET g_gldn_d[l_ac].l_gldn010_17 = 0 END IF 
      IF cl_null(g_gldn_d[l_ac].l_gldn010_18) THEN LET g_gldn_d[l_ac].l_gldn010_18 = 0 END IF 
      IF cl_null(g_gldn_d[l_ac].l_gldn010_19) THEN LET g_gldn_d[l_ac].l_gldn010_19 = 0 END IF 
      IF cl_null(g_gldn_d[l_ac].l_gldn010_20) THEN LET g_gldn_d[l_ac].l_gldn010_20 = 0 END IF 

      #調整借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,2,1)RETURNING
         g_gldn_d[l_ac].l_gldq0171
      #調整貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,3,1)RETURNING
         g_gldn_d[l_ac].l_gldq0181      
      #沖銷借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,4,1)RETURNING
         g_gldn_d[l_ac].l_gldq0172
      #沖銷貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,5,1)RETURNING
         g_gldn_d[l_ac].l_gldq0182
      #會計師借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,6,1)RETURNING
         g_gldn_d[l_ac].l_gldq0173
      #會計師貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,7,1)RETURNING
         g_gldn_d[l_ac].l_gldq0183
      
      LET l_amt1 = g_gldn_d[l_ac].l_gldq0171 - g_gldn_d[l_ac].l_gldq0181
      LET l_amt2 = g_gldn_d[l_ac].l_gldq0172 - g_gldn_d[l_ac].l_gldq0182
      LET l_amt3 = g_gldn_d[l_ac].l_gldq0173 - g_gldn_d[l_ac].l_gldq0183     
      LET g_gldn_d[l_ac].l_amt1 = g_gldn_d[l_ac].l_gldn010_01 + g_gldn_d[l_ac].l_gldn010_02 + g_gldn_d[l_ac].l_gldn010_03
                                + g_gldn_d[l_ac].l_gldn010_04 + g_gldn_d[l_ac].l_gldn010_05 + g_gldn_d[l_ac].l_gldn010_06
                                + g_gldn_d[l_ac].l_gldn010_07 + g_gldn_d[l_ac].l_gldn010_08 + g_gldn_d[l_ac].l_gldn010_09
                                + g_gldn_d[l_ac].l_gldn010_10 + g_gldn_d[l_ac].l_gldn010_11 + g_gldn_d[l_ac].l_gldn010_12
                                + g_gldn_d[l_ac].l_gldn010_13 + g_gldn_d[l_ac].l_gldn010_14 + g_gldn_d[l_ac].l_gldn010_15
                                + g_gldn_d[l_ac].l_gldn010_16 + g_gldn_d[l_ac].l_gldn010_17 + g_gldn_d[l_ac].l_gldn010_18
                                + g_gldn_d[l_ac].l_gldn010_19 + g_gldn_d[l_ac].l_gldn010_20 + l_amt1 +l_amt2 + l_amt3                                
             
      CALL aglq930_glfb004_ref(g_gldn_d[l_ac].l_assest1,g_gldn_d[l_ac].l_glfbseq)
         RETURNING g_gldn_d[l_ac].l_assest1 
        
      #end add-point
 
      CALL aglq930_detail_show("'1'")      
 
      CALL aglq930_gldn_t_mask()
 
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
   
 
   
   CALL g_gldn_d.deleteElement(g_gldn_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   LET l_flag = 'N'
   LET g_sql =  "   SELECT DISTINCT glfb002,glfb003,                        ",
                 "                   '','','','','','','','','','',          ",
                 "                   '','','','','','','','','','',          ",
                 "                   '','','','','','','',                   ",
                 "                   glfbseq                                 ",
                 "  FROM glfb_t                                              ",
                 " WHERE glfbent= ? AND glfbseq1 IN ('C','D')                ",
                 "   AND glfb001 = '",g_input.l_glfa001,"'                   ",
                 " ORDER BY glfb003                                          "
                
   PREPARE aglq930_pb02  FROM g_sql
   DECLARE b_fill_curs02 CURSOR FOR aglq930_pb02
   LET l_ac = 1 
   OPEN b_fill_curs02 USING g_enterprise
   FOREACH b_fill_curs02 INTO g_gldn_d[l_ac].l_assest2,g_gldn_d[l_ac].l_glfb0312, 
       g_gldn_d[l_ac].l_gldn010_21,g_gldn_d[l_ac].l_gldn010_22,g_gldn_d[l_ac].l_gldn010_23,g_gldn_d[l_ac].l_gldn010_24, 
       g_gldn_d[l_ac].l_gldn010_25,g_gldn_d[l_ac].l_gldn010_26,g_gldn_d[l_ac].l_gldn010_27,g_gldn_d[l_ac].l_gldn010_28, 
       g_gldn_d[l_ac].l_gldn010_29,g_gldn_d[l_ac].l_gldn010_30,g_gldn_d[l_ac].l_gldn010_31,g_gldn_d[l_ac].l_gldn010_32, 
       g_gldn_d[l_ac].l_gldn010_33,g_gldn_d[l_ac].l_gldn010_34,g_gldn_d[l_ac].l_gldn010_35,g_gldn_d[l_ac].l_gldn010_36, 
       g_gldn_d[l_ac].l_gldn010_37,g_gldn_d[l_ac].l_gldn010_38,g_gldn_d[l_ac].l_gldn010_39,g_gldn_d[l_ac].l_gldn010_40, 
       g_gldn_d[l_ac].l_gldq0174,g_gldn_d[l_ac].l_gldq0184,g_gldn_d[l_ac].l_gldq0175,g_gldn_d[l_ac].l_gldq0185, 
       g_gldn_d[l_ac].l_gldq0176,g_gldn_d[l_ac].l_gldq0186,g_gldn_d[l_ac].l_amt2,
       g_gldn_d[l_ac].l_glfbseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF      
      #IF g_prog = 'aglq931' THEN EXIT FOREACH END IF        #160705-00042#8 160712 by sakura mark
      IF g_prog MATCHES 'aglq931' THEN EXIT FOREACH END IF   #160705-00042#8 160712 by sakura add
      SELECT glfb004,glfb005 INTO l_glfb004,l_glfb005
        FROM glfb_t
       WHERE glfbent = g_enterprise
         AND glfb001 = g_input.l_glfa001
         AND glfbseq = g_gldn_d[l_ac].l_glfbseq      
         AND glfbseq1 = 'D' 
         
      #預算金額      
      IF NOT cl_null(l_glfb005) THEN
         IF l_glfb004 = '1' THEN #取表內公式
            CALL s_analy_form_get_coordinate(g_input.l_glfa001,l_glfb005)
               RETURNING  g_sub_success,l_glfb005             
         END IF
         FOR l_i = 1 TO g_tree.getLength()
            CASE l_i
               WHEN 1                  
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_21                 
               WHEN 2                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_22
               WHEN 3                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_23
               WHEN 4                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_24
               WHEN 5                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_25
               WHEN 6                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_26
               WHEN 7                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_27
               WHEN 8                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_28
               WHEN 9                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_29
               WHEN 10                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_30
               WHEN 11                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_31
               WHEN 12                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_32
               WHEN 13                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_33
               WHEN 14                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_34
               WHEN 15                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_35
               WHEN 16                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_36
               WHEN 17                           
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_37
               WHEN 18
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_38
               WHEN 19
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_39
               WHEN 20
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,1)RETURNING
                     g_gldn_d[l_ac].l_gldn010_40
            END CASE             
         END FOR
      END IF        
      IF cl_null(g_gldn_d[l_ac].l_gldn010_21) THEN LET g_gldn_d[l_ac].l_gldn010_21 = 0 END IF
      IF cl_null(g_gldn_d[l_ac].l_gldn010_22) THEN LET g_gldn_d[l_ac].l_gldn010_22 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_23) THEN LET g_gldn_d[l_ac].l_gldn010_23 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_24) THEN LET g_gldn_d[l_ac].l_gldn010_24 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_25) THEN LET g_gldn_d[l_ac].l_gldn010_25 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_26) THEN LET g_gldn_d[l_ac].l_gldn010_26 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_27) THEN LET g_gldn_d[l_ac].l_gldn010_27 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_28) THEN LET g_gldn_d[l_ac].l_gldn010_28 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_29) THEN LET g_gldn_d[l_ac].l_gldn010_29 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_30) THEN LET g_gldn_d[l_ac].l_gldn010_30 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_31) THEN LET g_gldn_d[l_ac].l_gldn010_31 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_32) THEN LET g_gldn_d[l_ac].l_gldn010_32 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_33) THEN LET g_gldn_d[l_ac].l_gldn010_33 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_34) THEN LET g_gldn_d[l_ac].l_gldn010_34 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_35) THEN LET g_gldn_d[l_ac].l_gldn010_35 = 0 END IF
      IF cl_null(g_gldn_d[l_ac].l_gldn010_36) THEN LET g_gldn_d[l_ac].l_gldn010_36 = 0 END IF  
      IF cl_null(g_gldn_d[l_ac].l_gldn010_37) THEN LET g_gldn_d[l_ac].l_gldn010_37 = 0 END IF 
      IF cl_null(g_gldn_d[l_ac].l_gldn010_38) THEN LET g_gldn_d[l_ac].l_gldn010_38 = 0 END IF 
      IF cl_null(g_gldn_d[l_ac].l_gldn010_39) THEN LET g_gldn_d[l_ac].l_gldn010_39 = 0 END IF 
      IF cl_null(g_gldn_d[l_ac].l_gldn010_40) THEN LET g_gldn_d[l_ac].l_gldn010_40 = 0 END IF 
      
      
       #調整借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,2,1)RETURNING
         g_gldn_d[l_ac].l_gldq0174
      #調整貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,3,1)RETURNING
         g_gldn_d[l_ac].l_gldq0184      
      #沖銷借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,4,1)RETURNING
         g_gldn_d[l_ac].l_gldq0175
      #沖銷貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,5,1)RETURNING
         g_gldn_d[l_ac].l_gldq0185
      #會計師借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,6,1)RETURNING
         g_gldn_d[l_ac].l_gldq0176
      #會計師貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,7,1)RETURNING
         g_gldn_d[l_ac].l_gldq0186
      
      LET l_amt1 = g_gldn_d[l_ac].l_gldq0174 - g_gldn_d[l_ac].l_gldq0184
      LET l_amt2 = g_gldn_d[l_ac].l_gldq0175 - g_gldn_d[l_ac].l_gldq0185
      LET l_amt3 = g_gldn_d[l_ac].l_gldq0176 - g_gldn_d[l_ac].l_gldq0186
      
      LET g_gldn_d[l_ac].l_amt2 = g_gldn_d[l_ac].l_gldn010_21 + g_gldn_d[l_ac].l_gldn010_22 + g_gldn_d[l_ac].l_gldn010_23
                                + g_gldn_d[l_ac].l_gldn010_24 + g_gldn_d[l_ac].l_gldn010_25 + g_gldn_d[l_ac].l_gldn010_26
                                + g_gldn_d[l_ac].l_gldn010_27 + g_gldn_d[l_ac].l_gldn010_28 + g_gldn_d[l_ac].l_gldn010_29
                                + g_gldn_d[l_ac].l_gldn010_30 + g_gldn_d[l_ac].l_gldn010_31 + g_gldn_d[l_ac].l_gldn010_32
                                + g_gldn_d[l_ac].l_gldn010_33 + g_gldn_d[l_ac].l_gldn010_34 + g_gldn_d[l_ac].l_gldn010_35
                                + g_gldn_d[l_ac].l_gldn010_36 + g_gldn_d[l_ac].l_gldn010_37 + g_gldn_d[l_ac].l_gldn010_38
                                + g_gldn_d[l_ac].l_gldn010_39 + g_gldn_d[l_ac].l_gldn010_40 + l_amt1 +l_amt2 + l_amt3                                
             
      CALL aglq930_glfb004_ref(g_gldn_d[l_ac].l_assest2,g_gldn_d[l_ac].l_glfbseq)
         RETURNING g_gldn_d[l_ac].l_assest2
      
      LET l_ac = l_ac + 1
      LET l_flag = 'Y'
   END FOREACH
   #IF g_prog = 'aglq931' OR g_glfa003 = '2' OR l_flag = 'N'THEN        #160705-00042#8 160712 by sakura mark
   IF g_prog MATCHES 'aglq931' OR g_glfa003 = '2' OR l_flag = 'N'THEN   #160705-00042#8 160712 by sakura add
   ELSE
      CALL g_gldn_d.deleteElement(g_gldn_d.getLength())  
   END IF
   LET g_tot_cnt = g_gldn_d.getLength()

   #設置單身金額欄位格式
   LET l_format = "---,---,---,--&"
   LET l_str = ""
   FOR l_i=1 TO g_input.l_glfa009
       LET l_str = l_str,"&"
   END FOR
   IF NOT cl_null(l_str) THEN
      LET l_format = l_format,'.',l_str
   END IF
   CALL cl_set_comp_format("l_gldn010_01,l_gldn010_02,l_gldn010_03,l_gldn010_04,l_gldn010_05",l_format)
   CALL cl_set_comp_format("l_gldn010_06,l_gldn010_07,l_gldn010_08,l_gldn010_09,l_gldn010_10",l_format)
   CALL cl_set_comp_format("l_gldn010_11,l_gldn010_12,l_gldn010_13,l_gldn010_14,l_gldn010_15",l_format)
   CALL cl_set_comp_format("l_gldn010_16,l_gldn010_17,l_gldn010_18,l_gldn010_19,l_gldn010_20",l_format)
   CALL cl_set_comp_format("l_gldq0171,l_gldq0172,l_gldq0173,l_gldq0181,l_gldq0182,l_gldq0183,l_amt1",l_format)
   
   CALL cl_set_comp_format("l_gldn010_21,l_gldn010_22,l_gldn010_23,l_gldn010_24,l_gldn010_25",l_format)
   CALL cl_set_comp_format("l_gldn010_26,l_gldn010_27,l_gldn010_28,l_gldn010_29,l_gldn010_30",l_format)
   CALL cl_set_comp_format("l_gldn010_31,l_gldn010_32,l_gldn010_33,l_gldn010_34,l_gldn010_35",l_format)
   CALL cl_set_comp_format("l_gldn010_36,l_gldn010_37,l_gldn010_38,l_gldn010_39,l_gldn010_40",l_format)
   CALL cl_set_comp_format("l_gldq0174,l_gldq0175,l_gldq0176,l_gldq0184,l_gldq0185,l_gldq0186,l_amt2",l_format)


   CALL cl_set_comp_visible('page_2,page_3',FALSE)
   IF g_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible('page_2',TRUE)
      CALL aglq930_b_fill2()
   END IF
   IF g_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible('page_2',TRUE)
      CALL aglq930_b_fill3()
   END IF
   #end add-point
 
   LET g_detail_cnt = g_gldn_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq930_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq930_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq930_detail_action_trans()
 
   IF g_gldn_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq930_fetch()
   END IF
   
      CALL aglq930_filter_show('gldn001','b_gldn001')
   CALL aglq930_filter_show('gldn002','b_gldn002')
   CALL aglq930_filter_show('gldn003','b_gldn003')
   CALL aglq930_filter_show('gldn004','b_gldn004')
   CALL aglq930_filter_show('gldn005','b_gldn005')
   CALL aglq930_filter_show('gldn006','b_gldn006')
   CALL aglq930_filter_show('gldn007','b_gldn007')
   CALL aglq930_filter_show('gldn008','b_gldn008')
   CALL aglq930_filter_show('gldn032','b_gldn032')
   CALL aglq930_filter_show('gldn033','b_gldn033')
   CALL aglq930_filter_show('gldn040','b_gldn040')
   CALL aglq930_filter_show('gldn041','b_gldn041')
   CALL aglq930_filter_show('gldnld','b_gldnld')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq930.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq930_fetch()
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
 
{<section id="aglq930.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq930_detail_show(ps_page)
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
 
{<section id="aglq930.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq930_filter()
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
      CONSTRUCT g_wc_filter ON gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn007,gldn008,gldn032, 
          gldn033,gldn040,gldn041,gldnld
                          FROM s_detail1[1].b_gldn001,s_detail1[1].b_gldn002,s_detail1[1].b_gldn003, 
                              s_detail1[1].b_gldn004,s_detail1[1].b_gldn005,s_detail1[1].b_gldn006,s_detail1[1].b_gldn007, 
                              s_detail1[1].b_gldn008,s_detail1[1].b_gldn032,s_detail1[1].b_gldn033,s_detail1[1].b_gldn040, 
                              s_detail1[1].b_gldn041,s_detail1[1].b_gldnld
 
         BEFORE CONSTRUCT
                     DISPLAY aglq930_filter_parser('gldn001') TO s_detail1[1].b_gldn001
            DISPLAY aglq930_filter_parser('gldn002') TO s_detail1[1].b_gldn002
            DISPLAY aglq930_filter_parser('gldn003') TO s_detail1[1].b_gldn003
            DISPLAY aglq930_filter_parser('gldn004') TO s_detail1[1].b_gldn004
            DISPLAY aglq930_filter_parser('gldn005') TO s_detail1[1].b_gldn005
            DISPLAY aglq930_filter_parser('gldn006') TO s_detail1[1].b_gldn006
            DISPLAY aglq930_filter_parser('gldn007') TO s_detail1[1].b_gldn007
            DISPLAY aglq930_filter_parser('gldn008') TO s_detail1[1].b_gldn008
            DISPLAY aglq930_filter_parser('gldn032') TO s_detail1[1].b_gldn032
            DISPLAY aglq930_filter_parser('gldn033') TO s_detail1[1].b_gldn033
            DISPLAY aglq930_filter_parser('gldn040') TO s_detail1[1].b_gldn040
            DISPLAY aglq930_filter_parser('gldn041') TO s_detail1[1].b_gldn041
            DISPLAY aglq930_filter_parser('gldnld') TO s_detail1[1].b_gldnld
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<l_assest1>>----
         #----<<l_glfb0311>>----
         #----<<l_gldn010_01>>----
         #----<<l_gldn010_02>>----
         #----<<l_gldn010_03>>----
         #----<<l_gldn010_04>>----
         #----<<l_gldn010_05>>----
         #----<<l_gldn010_06>>----
         #----<<l_gldn010_07>>----
         #----<<l_gldn010_08>>----
         #----<<l_gldn010_09>>----
         #----<<l_gldn010_10>>----
         #----<<l_gldn010_11>>----
         #----<<l_gldn010_12>>----
         #----<<l_gldn010_13>>----
         #----<<l_gldn010_14>>----
         #----<<l_gldn010_15>>----
         #----<<l_gldn010_16>>----
         #----<<l_gldn010_17>>----
         #----<<l_gldn010_18>>----
         #----<<l_gldn010_19>>----
         #----<<l_gldn010_20>>----
         #----<<l_gldq0171>>----
         #----<<l_gldq0181>>----
         #----<<l_gldq0172>>----
         #----<<l_gldq0182>>----
         #----<<l_gldq0173>>----
         #----<<l_gldq0183>>----
         #----<<l_amt1>>----
         #----<<l_assest2>>----
         #----<<l_glfb0312>>----
         #----<<l_gldn010_21>>----
         #----<<l_gldn010_22>>----
         #----<<l_gldn010_23>>----
         #----<<l_gldn010_24>>----
         #----<<l_gldn010_25>>----
         #----<<l_gldn010_26>>----
         #----<<l_gldn010_27>>----
         #----<<l_gldn010_28>>----
         #----<<l_gldn010_29>>----
         #----<<l_gldn010_30>>----
         #----<<l_gldn010_31>>----
         #----<<l_gldn010_32>>----
         #----<<l_gldn010_33>>----
         #----<<l_gldn010_34>>----
         #----<<l_gldn010_35>>----
         #----<<l_gldn010_36>>----
         #----<<l_gldn010_37>>----
         #----<<l_gldn010_38>>----
         #----<<l_gldn010_39>>----
         #----<<l_gldn010_40>>----
         #----<<l_gldq0174>>----
         #----<<l_gldq0184>>----
         #----<<l_gldq0175>>----
         #----<<l_gldq0185>>----
         #----<<l_gldq0176>>----
         #----<<l_gldq0186>>----
         #----<<l_amt2>>----
         #----<<b_gldn001>>----
         #Ctrlp:construct.c.filter.page1.b_gldn001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn001
            #add-point:ON ACTION controlp INFIELD b_gldn001 name="construct.c.filter.page1.b_gldn001"
            
            #END add-point
 
 
         #----<<b_gldn002>>----
         #Ctrlp:construct.c.filter.page1.b_gldn002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn002
            #add-point:ON ACTION controlp INFIELD b_gldn002 name="construct.c.filter.page1.b_gldn002"
            
            #END add-point
 
 
         #----<<b_gldn003>>----
         #Ctrlp:construct.c.filter.page1.b_gldn003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn003
            #add-point:ON ACTION controlp INFIELD b_gldn003 name="construct.c.filter.page1.b_gldn003"
            
            #END add-point
 
 
         #----<<b_gldn004>>----
         #Ctrlp:construct.c.filter.page1.b_gldn004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn004
            #add-point:ON ACTION controlp INFIELD b_gldn004 name="construct.c.filter.page1.b_gldn004"
            
            #END add-point
 
 
         #----<<b_gldn005>>----
         #Ctrlp:construct.c.filter.page1.b_gldn005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn005
            #add-point:ON ACTION controlp INFIELD b_gldn005 name="construct.c.filter.page1.b_gldn005"
            
            #END add-point
 
 
         #----<<b_gldn006>>----
         #Ctrlp:construct.c.filter.page1.b_gldn006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn006
            #add-point:ON ACTION controlp INFIELD b_gldn006 name="construct.c.filter.page1.b_gldn006"
            
            #END add-point
 
 
         #----<<b_gldn007>>----
         #Ctrlp:construct.c.filter.page1.b_gldn007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn007
            #add-point:ON ACTION controlp INFIELD b_gldn007 name="construct.c.filter.page1.b_gldn007"
            
            #END add-point
 
 
         #----<<b_gldn008>>----
         #Ctrlp:construct.c.filter.page1.b_gldn008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn008
            #add-point:ON ACTION controlp INFIELD b_gldn008 name="construct.c.filter.page1.b_gldn008"
            
            #END add-point
 
 
         #----<<b_gldn032>>----
         #Ctrlp:construct.c.filter.page1.b_gldn032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn032
            #add-point:ON ACTION controlp INFIELD b_gldn032 name="construct.c.filter.page1.b_gldn032"
            
            #END add-point
 
 
         #----<<b_gldn033>>----
         #Ctrlp:construct.c.filter.page1.b_gldn033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn033
            #add-point:ON ACTION controlp INFIELD b_gldn033 name="construct.c.filter.page1.b_gldn033"
            
            #END add-point
 
 
         #----<<b_gldn040>>----
         #Ctrlp:construct.c.filter.page1.b_gldn040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn040
            #add-point:ON ACTION controlp INFIELD b_gldn040 name="construct.c.filter.page1.b_gldn040"
            
            #END add-point
 
 
         #----<<b_gldn041>>----
         #Ctrlp:construct.c.filter.page1.b_gldn041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldn041
            #add-point:ON ACTION controlp INFIELD b_gldn041 name="construct.c.filter.page1.b_gldn041"
            
            #END add-point
 
 
         #----<<b_gldnld>>----
         #Ctrlp:construct.c.filter.page1.b_gldnld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gldnld
            #add-point:ON ACTION controlp INFIELD b_gldnld name="construct.c.filter.page1.b_gldnld"
            
            #END add-point
 
 
         #----<<l_glfbseq>>----
   
 
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
   
      CALL aglq930_filter_show('gldn001','b_gldn001')
   CALL aglq930_filter_show('gldn002','b_gldn002')
   CALL aglq930_filter_show('gldn003','b_gldn003')
   CALL aglq930_filter_show('gldn004','b_gldn004')
   CALL aglq930_filter_show('gldn005','b_gldn005')
   CALL aglq930_filter_show('gldn006','b_gldn006')
   CALL aglq930_filter_show('gldn007','b_gldn007')
   CALL aglq930_filter_show('gldn008','b_gldn008')
   CALL aglq930_filter_show('gldn032','b_gldn032')
   CALL aglq930_filter_show('gldn033','b_gldn033')
   CALL aglq930_filter_show('gldn040','b_gldn040')
   CALL aglq930_filter_show('gldn041','b_gldn041')
   CALL aglq930_filter_show('gldnld','b_gldnld')
 
    
   CALL aglq930_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq930.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq930_filter_parser(ps_field)
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
 
{<section id="aglq930.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq930_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq930_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq930.insert" >}
#+ insert
PRIVATE FUNCTION aglq930_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq930.modify" >}
#+ modify
PRIVATE FUNCTION aglq930_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq930.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq930_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq930.delete" >}
#+ delete
PRIVATE FUNCTION aglq930_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq930.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq930_detail_action_trans()
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
 
{<section id="aglq930.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq930_detail_index_setting()
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
            IF g_gldn_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_gldn_d.getLength() AND g_gldn_d.getLength() > 0
            LET g_detail_idx = g_gldn_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_gldn_d.getLength() THEN
               LET g_detail_idx = g_gldn_d.getLength()
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
 
{<section id="aglq930.mask_functions" >}
 &include "erp/agl/aglq930_mask.4gl"
 
{</section>}
 
{<section id="aglq930.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 預設
# Memo...........:
# Usage..........: CALL aglq930_default()
# Date & Author..: 2015/12/14 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq930_default()
   
   #IF g_prog = 'aglq931' THEN        #160705-00042#8 160712 by sakura mark
   IF g_prog MATCHES 'aglq931' THEN   #160705-00042#8 160712 by sakura add
      CALL cl_set_comp_visible('l_assest2,l_glfb0312,l_gldq0174,l_gldq0184,l_gldq0175,l_gldq0185,l_gldq0176,l_gldq0186,l_amt2',FALSE)
      CALL cl_set_comp_visible('l_assest2_2,l_glfb0312_2,l_gldq0174_2,l_gldq0184_2,l_gldq0175_2,l_gldq0185_2,l_gldq0176_2,l_gldq0186_2,l_amt2_2',FALSE)      
      CALL cl_set_comp_visible('l_assest2_3,l_glfb0312_3,l_gldq0174_3,l_gldq0184_3,l_gldq0175_3,l_gldq0185_3,l_gldq0176_3,l_gldq0186_3,l_amt2_3',FALSE)      
      CALL cl_set_comp_visible('l_gldn010_21,l_gldn010_22,l_gldn010_23,l_gldn010_24,l_gldn010_25',FALSE)
      CALL cl_set_comp_visible('l_gldn010_26,l_gldn010_27,l_gldn010_28,l_gldn010_29,l_gldn010_30',FALSE)
      CALL cl_set_comp_visible('l_gldn010_31,l_gldn010_32,l_gldn010_33,l_gldn010_34,l_gldn010_35',FALSE)
      CALL cl_set_comp_visible('l_gldn010_36,l_gldn010_37,l_gldn010_38,l_gldn010_39,l_gldn010_40',FALSE)
      CALL cl_set_comp_visible('l_gldn010_21_2,l_gldn010_22_2,l_gldn010_23_2,l_gldn010_24_2,l_gldn010_25_2',FALSE)
      CALL cl_set_comp_visible('l_gldn010_26_2,l_gldn010_27_2,l_gldn010_28_2,l_gldn010_29_2,l_gldn010_30_2',FALSE)
      CALL cl_set_comp_visible('l_gldn010_31_2,l_gldn010_32_2,l_gldn010_33_2,l_gldn010_34_2,l_gldn010_35_2',FALSE)
      CALL cl_set_comp_visible('l_gldn010_36_2,l_gldn010_37_2,l_gldn010_38_2,l_gldn010_39_2,l_gldn010_40_2',FALSE)
      CALL cl_set_comp_visible('l_gldn010_21_3,l_gldn010_22_3,l_gldn010_23_3,l_gldn010_24_3,l_gldn010_25_3',FALSE)
      CALL cl_set_comp_visible('l_gldn010_26_3,l_gldn010_27_3,l_gldn010_28_3,l_gldn010_29_3,l_gldn010_30_3',FALSE)
      CALL cl_set_comp_visible('l_gldn010_31_3,l_gldn010_32_3,l_gldn010_33_3,l_gldn010_34_3,l_gldn010_35_3',FALSE)
      CALL cl_set_comp_visible('l_gldn010_36_3,l_gldn010_37_3,l_gldn010_38_3,l_gldn010_39_3,l_gldn010_40_3',FALSE)                  
   END IF
   LET g_input.l_glfa002 = '1'
   LET g_input.l_glfa006 = YEAR(g_today)
   LET g_input.l_glfa007 = MONTH(g_today)
   LET g_input.l_glfa008 = '1'
   LET g_input.l_glfa009 = '2'
   
   DISPLAY BY NAME g_input.l_glfa002,g_input.l_glfa006,g_input.l_glfa007,
                   g_input.l_glfa008,g_input.l_glfa009

END FUNCTION

################################################################################
# Descriptions...: 樣板檢核
# Memo...........:
# Usage..........: CALL aglq930_glfa001_chk(p_glfa001,p_glfa002)
# Input parameter: p_glfa001   樣板編號
# Date & Author..: 2015/12/14 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq930_glfa001_chk(p_glfa001)
DEFINE r_success LIKE type_t.num5
DEFINE r_errno   LIKE gzze_t.gzze001
DEFINE l_count   LIKE type_t.num5
DEFINE p_glfa001 LIKE glfa_t.glfa001

   
   LET r_success = TRUE LET r_errno = ''
   #IF g_prog = 'aglq931' THEN        #160705-00042#8 160712 by sakura mark
   IF g_prog MATCHES 'aglq931' THEN   #160705-00042#8 160712 by sakura add
    SELECT COUNT(*) INTO l_count
        FROM glfa_t
       WHERE glfaent = g_enterprise AND glfa001 = p_glfa001
         AND glfa002 = '2'   #資產負債表
         AND glfa016 = '2'   #屬於合併財報的樣板
   ELSE
      SELECT COUNT(*) INTO l_count
        FROM glfa_t
       WHERE glfaent = g_enterprise AND glfa001 = p_glfa001
         AND glfa002 = '1'   #樣板種類 損益表
         AND glfa016 = '2'   #屬於合併財報的樣板
   END IF

   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN 
      LET r_success = FALSE
      LET r_errno = 'agl-00249'
   END IF
   
   RETURN r_success,r_errno

END FUNCTION

################################################################################
# Descriptions...: 合併帳套檢查
# Memo...........:
# Usage..........: CALL aglq930_glfa005_chk(p_glfa005)
# Date & Author..: 2015/12/14
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq930_glfa005_chk(p_glfa005)
DEFINE r_success LIKE type_t.num5
DEFINE r_errno   LIKE gzze_t.gzze001
DEFINE l_count   LIKE type_t.num5
DEFINE p_glfa005 LIKE glfa_t.glfa001

   LET r_success = TRUE LET r_errno = ''
   LET l_count = 0
   #IF g_prog = 'aglq931' THEN        #160705-00042#8 160712 by sakura mark
   IF g_prog MATCHES 'aglq931' THEN   #160705-00042#8 160712 by sakura add
       SELECT COUNT(*) INTO l_count
        FROM glfa_t
       WHERE glfaent = g_enterprise AND glfa005 = p_glfa005
         AND glfa002 = '2'   #樣板種類 資產負債表
         AND glfa016 = '2'   #屬於合併財報的樣板
         AND glfa001 = g_input.l_glfa001      
   ELSE
      SELECT COUNT(*) INTO l_count
        FROM glfa_t
       WHERE glfaent = g_enterprise AND glfa005 = p_glfa005
         AND glfa002 = '1'   #樣板種類 損益表
         AND glfa016 = '2'   #屬於合併財報的樣板
         AND glfa001 = g_input.l_glfa001
   END IF
      
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN 
      LET r_success = FALSE
      LET r_errno = 'agl-00409'
      RETURN r_success,r_errno
   END IF
   
   #agli510是否存在合併帳套
   LET l_count = 0
   SELECT COUNT(*)  INTO l_count FROM gldc_t
    WHERE gldcent = g_enterprise
      AND gldcld = p_glfa005
   
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN 
      LET r_success = FALSE
      LET r_errno = 'agl-00326'
      RETURN r_success,r_errno
   END IF
   
   
   RETURN r_success,r_errno

END FUNCTION

################################################################################
# Descriptions...: 依造帳套條件展樹
# Memo...........:
# Usage..........: CALL aglq930_grow_tree()
# Date & Author..: 2015/12/14 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq930_grow_tree()
DEFINE l_root DYNAMIC ARRAY OF RECORD
                 gldcld  LIKE type_t.chr100,
                 gldc001 LIKE gldc_t.gldc001
                 END RECORD
DEFINE l_idx  LIKE type_t.num5    #array index
DEFINE l_sql  STRING
#從pid串取得實際pid用-----s
DEFINE l_iddummy  LIKE type_t.num5
DEFINE l_idroot   LIKE type_t.num5
DEFINE l_string   STRING   
DEFINE l_pid      LIKE type_t.num5
#從pid串取得實際pid用-----e        

DEFINE l_count    LIKE type_t.num5
DEFINE l_field    LIKE type_t.chr100

   IF cl_null(g_input.l_glfa005) THEN 
      LET l_field =" 1 =1"
   ELSE    
      LET l_field = " gldbld = '",g_input.l_glfa005,"' "  
      #LET l_field = "gldbld = '",g_gldcld,"' "
   END IF
   CALL g_tree.clear()
   #FOREACH 根節點 存成ARRAY
   LET l_sql = " SELECT DISTINCT gldbld,gldb001 FROM gldc_t ,gldb_t  ",
               "  WHERE gldcent = ",g_enterprise," ",
               "    AND gldcent = gldbent ",
               "    AND gldc001 = gldb001 ",
               "    AND gldcld  = gldbld  ",
               "    AND gldbstus = 'Y' ",
               "    AND ",l_field," ",
               "    AND (gldcld,gldc001) NOT IN (SELECT gldc003,gldc002 FROM gldc_t ,gldb_t  ",
               "                    WHERE gldcent = gldbent ",
               "                      AND gldcld  = gldbld  ",
               "                      AND gldc001 = gldb001 ",
               "                      AND gldc009 = 'N' ",
               "                      AND gldbstus = 'Y' ",
               "                      AND ",l_field," ",
               "                      AND gldcent = ",g_enterprise," ) "
   PREPARE sel_aglq930_rootp1 FROM l_sql
   DECLARE sel_aglq930_rootc1 CURSOR FOR sel_aglq930_rootp1
   
   LET l_idx = 1 
   FOREACH sel_aglq930_rootc1 INTO l_root[l_idx].*
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF            
      LET l_idx = l_idx + 1
   END FOREACH
   CALL l_root.deleteElement(l_idx)
   
   IF l_root.getLength() <= 0 THEN
      RETURN
   END IF
   #用存起來的根節點呼叫遞迴
   LET g_tree_idx = 1

   FOR l_idx = 1 TO l_root.getLength()
      LET g_tree_pid = '0'    #代表是起始節點
      CALL aglq930_grow_tree_node(l_root[l_idx].gldcld,l_root[l_idx].gldc001)
   END FOR
   
   #如果是最根節點時KEY值會為空
   #此時就要把上層節點的資料KEY給進去
   #方便後續重show畫面
   FOR l_idx = 1 TO g_tree.getLength()
      IF cl_null(g_tree[l_idx].gldbld) AND cl_null(g_tree[l_idx].gldb001) THEN
         LET l_string = g_tree[l_idx].pid
         LET l_iddummy = 1
         LET l_idroot = 0
         WHILE TRUE
            LET l_iddummy = l_string.getIndexOf('.',l_iddummy)
            IF l_iddummy = 0 THEN 
               EXIT WHILE
            ELSE
               LET l_idroot = l_iddummy + 1
            END IF
            LET l_iddummy = l_iddummy + 1
         END WHILE

         LET l_string = l_string.substring(l_idroot,l_string.getLength())
         LET l_pid = l_string
         IF NOT cl_null(l_pid) AND l_pid > 0 THEN 
            LET g_tree[l_idx].gldbld = g_tree[l_pid].gldbld
            LET g_tree[l_idx].gldb001 = g_tree[l_pid].gldb001
         END IF
      END IF
   END FOR

END FUNCTION

################################################################################
# Descriptions...: 根節點以外往下長節點
# Memo...........:
# Usage..........: CALL aglq930_grow_tree_node(p_ld,p_gldc001))
# Date & Author..: 2015/12/15 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq930_grow_tree_node(p_ld,p_gldc001)
DEFINE l_node    DYNAMIC ARRAY OF RECORD
                    gldcld  LIKE type_t.chr100,
                    gldc001 LIKE gldc_t.gldc001
                    END RECORD
DEFINE l_idx      LIKE type_t.num10
DEFINE l_id       LIKE type_t.chr100
DEFINE l_sql      STRING
DEFINE p_gldc001  LIKE gldn_t.gldn001
DEFINE p_ld       LIKE glaa_t.glaald
DEFINE l_field    LIKE type_t.chr100

   IF cl_null(g_input.l_glfa005) THEN 
      LET l_field =" 1 =1"
   ELSE    
      LET l_field = " gldbld = '",g_input.l_glfa005,"' "  
   END IF
  
   #用傳入的根節點 FOREACH 抓下節點放入l_node
   LET l_sql = "SELECT gldc003,gldc002 FROM gldc_t,gldb_t ",
               " WHERE gldc009 = 'N' ",
               "   AND gldcent = ",g_enterprise,"         ",
               "   AND gldcld  = '",p_ld,"'               ",
               "   AND gldc001 = '",p_gldc001,"'          ",
               "   AND gldcent = gldbent                  ",
               "   AND gldcld  = gldbld                   ",
               "   AND gldc001 = gldb001  AND ",l_field," "
               
   PREPARE sel_aglq930_nodep1 FROM l_sql
   DECLARE sel_aglq930_nodec1 CURSOR FOR sel_aglq930_nodep1
          
   CALL l_node.clear()
   LET l_idx = 1    
   FOREACH sel_aglq930_nodec1 INTO l_node[l_idx].gldcld,l_node[l_idx].gldc001
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF

      LET l_idx = l_idx + 1
   END FOREACH
   #如果l_idx = 1 代表沒往下的節點
   #          > 1 代表有往下的節點
   #把上層節點給到g_tree去
   #g_tree_idx + 1
   
   LET g_tree[g_tree_idx].show = p_gldc001,'-',s_desc_glda001_desc(p_gldc001)
   LET g_tree[g_tree_idx].pid  = g_tree_pid CLIPPED
   LET g_tree[g_tree_idx].id   = g_tree_pid CLIPPED,'.',g_tree_idx USING '<<<<<<<<<<<<<<<<'
   LET g_tree[g_tree_idx].exp  = 'TRUE'
   LET g_tree[g_tree_idx].isExp = FALSE
   LET g_tree[g_tree_idx].expcode = FALSE   #每個節點都收起來
   LET g_tree[g_tree_idx].gldc002 = p_gldc001
   CALL aglq930_get_glec005(g_input.l_glfa005,p_gldc001) RETURNING g_tree[g_tree_idx].glec005

   IF l_idx = 1 THEN
      LET g_tree[g_tree_idx].glec005 = '' 
   ELSE
      LET g_tree[g_tree_idx].hasC = TRUE
      LET g_tree[g_tree_idx].gldbld  = p_ld  
      LET g_tree[g_tree_idx].gldb001 = p_gldc001
   END IF
   IF g_tree_pid = '0' THEN
      LET g_tree[g_tree_idx].hasC = TRUE
   END IF
   LET l_id = g_tree[g_tree_idx].id    #自己是誰要記錄
   LET g_tree_idx = g_tree_idx + 1
  
   CALL l_node.deleteElement(l_idx)   
  
   #FOR 跑遞迴 再往下找節點
   FOR l_idx = 1 TO l_node.getLength()
      LET g_tree_pid = l_id CLIPPED 
      CALL aglq930_grow_tree_node(l_node[l_idx].gldcld,l_node[l_idx].gldc001)
   END FOR
  

END FUNCTION

################################################################################
# Descriptions...: 設置隱顯/title置換
# Memo...........:
# Usage..........: CALL aglq930_set_title()
# Date & Author..: 2015/12/15 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq930_set_title()
DEFINE l_i LIKE type_t.num5
DEFINE l_j LIKE type_t.num5
DEFINE l_title DYNAMIC ARRAY OF RECORD
          title1   LIKE type_t.chr500,
          title1_2 LIKE type_t.chr500,
          title1_3 LIKE type_t.chr500
          END RECORD

DEFINE l_title1     LIKE gzzd_t.gzzd005          
   
   #取得類型
   SELECT glfa003 INTO g_glfa003 FROM glfa_t WHERE glfaent = g_enterprise AND glfa001 = g_input.l_glfa001   
   #設定title名稱
   SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'lbl_assest' AND gzzd002 = g_dlang AND gzzd001 = 'aglq930' #資產
   CALL cl_set_comp_att_text('l_assest1',l_title1)
   
   #儲存table name
   FOR l_i = 1 TO 9
      LET l_title[l_i].title1   = 'l_gldn010_0'||l_i
      LET l_title[l_i].title1_2 = 'l_gldn010_0'||l_i||'_2'
      LET l_title[l_i].title1_3 = 'l_gldn010_0'||l_i||'_3'
   END FOR
   FOR l_i = 10 TO 40
      LET l_title[l_i].title1   = 'l_gldn010_'||l_i
      LET l_title[l_i].title1_2 = 'l_gldn010_'||l_i||'_2'
      LET l_title[l_i].title1_3 = 'l_gldn010_'||l_i||'_3'
   END FOR

   CALL cl_set_comp_visible('l_gldn010_01,l_gldn010_02,l_gldn010_03,l_gldn010_04,l_gldn010_05',FALSE)
   CALL cl_set_comp_visible('l_gldn010_06,l_gldn010_07,l_gldn010_08,l_gldn010_09,l_gldn010_10',FALSE)
   CALL cl_set_comp_visible('l_gldn010_11,l_gldn010_12,l_gldn010_13,l_gldn010_14,l_gldn010_15',FALSE)
   CALL cl_set_comp_visible('l_gldn010_16,l_gldn010_17,l_gldn010_18,l_gldn010_19,l_gldn010_20',FALSE)
   CALL cl_set_comp_visible('l_gldn010_21,l_gldn010_22,l_gldn010_23,l_gldn010_24,l_gldn010_25',FALSE)
   CALL cl_set_comp_visible('l_gldn010_26,l_gldn010_27,l_gldn010_28,l_gldn010_29,l_gldn010_30',FALSE)
   CALL cl_set_comp_visible('l_gldn010_31,l_gldn010_32,l_gldn010_33,l_gldn010_34,l_gldn010_35',FALSE)
   CALL cl_set_comp_visible('l_gldn010_36,l_gldn010_37,l_gldn010_38,l_gldn010_39,l_gldn010_40',FALSE)

   CALL cl_set_comp_visible('l_gldn010_01_2,l_gldn010_02_2,l_gldn010_03_2,l_gldn010_04_2,l_gldn010_05_2',FALSE)
   CALL cl_set_comp_visible('l_gldn010_06_2,l_gldn010_07_2,l_gldn010_08_2,l_gldn010_09_2,l_gldn010_10_2',FALSE)
   CALL cl_set_comp_visible('l_gldn010_11_2,l_gldn010_12_2,l_gldn010_13_2,l_gldn010_14_2,l_gldn010_15_2',FALSE)
   CALL cl_set_comp_visible('l_gldn010_16_2,l_gldn010_17_2,l_gldn010_18_2,l_gldn010_19_2,l_gldn010_20_2',FALSE)
   CALL cl_set_comp_visible('l_gldn010_21_2,l_gldn010_22_2,l_gldn010_23_2,l_gldn010_24_2,l_gldn010_25_2',FALSE)
   CALL cl_set_comp_visible('l_gldn010_26_2,l_gldn010_27_2,l_gldn010_28_2,l_gldn010_29_2,l_gldn010_30_2',FALSE)
   CALL cl_set_comp_visible('l_gldn010_31_2,l_gldn010_32_2,l_gldn010_33_2,l_gldn010_34_2,l_gldn010_35_2',FALSE)
   CALL cl_set_comp_visible('l_gldn010_36_2,l_gldn010_37_2,l_gldn010_38_2,l_gldn010_39_2,l_gldn010_40_2',FALSE) 
   
   CALL cl_set_comp_visible('l_gldn010_01_3,l_gldn010_02_3,l_gldn010_03_3,l_gldn010_04_3,l_gldn010_05_3',FALSE)
   CALL cl_set_comp_visible('l_gldn010_06_3,l_gldn010_07_3,l_gldn010_08_3,l_gldn010_09_3,l_gldn010_10_3',FALSE)
   CALL cl_set_comp_visible('l_gldn010_11_3,l_gldn010_12_3,l_gldn010_13_3,l_gldn010_14_3,l_gldn010_15_3',FALSE)
   CALL cl_set_comp_visible('l_gldn010_16_3,l_gldn010_17_3,l_gldn010_18_3,l_gldn010_19_3,l_gldn010_20_3',FALSE)
   CALL cl_set_comp_visible('l_gldn010_21_3,l_gldn010_22_3,l_gldn010_23_3,l_gldn010_24_3,l_gldn010_25_3',FALSE)
   CALL cl_set_comp_visible('l_gldn010_26_3,l_gldn010_27_3,l_gldn010_28_3,l_gldn010_29_3,l_gldn010_30_3',FALSE)
   CALL cl_set_comp_visible('l_gldn010_31_3,l_gldn010_32_3,l_gldn010_33_3,l_gldn010_34_3,l_gldn010_35_3',FALSE)
   CALL cl_set_comp_visible('l_gldn010_36_3,l_gldn010_37_3,l_gldn010_38_3,l_gldn010_39_3,l_gldn010_40_3',FALSE) 
   
   LET l_j =   g_tree.getLength()    
   FOR l_i = 1 TO l_j  
      CALL cl_set_comp_visible(l_title[l_i].title1,TRUE)
      CALL cl_set_comp_att_text(l_title[l_i].title1,g_tree[l_i].show)
      CALL cl_set_comp_visible(l_title[l_i].title1_2,TRUE)
      CALL cl_set_comp_att_text(l_title[l_i].title1_2,g_tree[l_i].show)
      CALL cl_set_comp_visible(l_title[l_i].title1_3,TRUE)
      CALL cl_set_comp_att_text(l_title[l_i].title1_3,g_tree[l_i].show)
   END FOR  
   #IF g_prog <> 'aglq931' THEN           #160705-00042#8 160712 by sakura mark
   IF g_prog NOT MATCHES 'aglq931' THEN   #160705-00042#8 160712 by sakura add
      FOR l_i = 21 TO (l_j + 20)
         CALL cl_set_comp_visible(l_title[l_i].title1,TRUE)
         CALL cl_set_comp_att_text(l_title[l_i].title1,g_tree[l_i-20].show)
         CALL cl_set_comp_visible(l_title[l_i].title1_2,TRUE)
         CALL cl_set_comp_att_text(l_title[l_i].title1_2,g_tree[l_i-20].show)
         CALL cl_set_comp_visible(l_title[l_i].title1_3,TRUE)
         CALL cl_set_comp_att_text(l_title[l_i].title1_3,g_tree[l_i-20].show)
      END FOR
   END IF
   
   IF g_glfa003 = 2 THEN
      SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'lbl_assest3' AND gzzd002 = g_dlang AND gzzd001 = 'aglq930' #項目
      CALL cl_set_comp_att_text('l_assest1',l_title1)
      CALL cl_set_comp_visible('l_assest2,l_glfb0312,l_gldq0174,l_gldq0184,l_gldq0175,l_gldq0185,l_gldq0176,l_gldq0186,l_amt2',FALSE)
      CALL cl_set_comp_visible('l_assest2_2,l_glfb0312_2,l_gldq0174_2,l_gldq0184_2,l_gldq0175_2,l_gldq0185_2,l_gldq0176_2,l_gldq0186_2,l_amt2_2',FALSE)      
      CALL cl_set_comp_visible('l_assest2_3,l_glfb0312_3,l_gldq0174_3,l_gldq0184_3,l_gldq0175_3,l_gldq0185_3,l_gldq0176_3,l_gldq0186_3,l_amt2_3',FALSE)      
      CALL cl_set_comp_visible('l_gldn010_21,l_gldn010_22,l_gldn010_23,l_gldn010_24,l_gldn010_25',FALSE)
      CALL cl_set_comp_visible('l_gldn010_26,l_gldn010_27,l_gldn010_28,l_gldn010_29,l_gldn010_30',FALSE)
      CALL cl_set_comp_visible('l_gldn010_31,l_gldn010_32,l_gldn010_33,l_gldn010_34,l_gldn010_35',FALSE)
      CALL cl_set_comp_visible('l_gldn010_36,l_gldn010_37,l_gldn010_38,l_gldn010_39,l_gldn010_40',FALSE)
      CALL cl_set_comp_visible('l_gldn010_21_2,l_gldn010_22_2,l_gldn010_23_2,l_gldn010_24_2,l_gldn010_25_2',FALSE)
      CALL cl_set_comp_visible('l_gldn010_26_2,l_gldn010_27_2,l_gldn010_28_2,l_gldn010_29_2,l_gldn010_30_2',FALSE)
      CALL cl_set_comp_visible('l_gldn010_31_2,l_gldn010_32_2,l_gldn010_33_2,l_gldn010_34_2,l_gldn010_35_2',FALSE)
      CALL cl_set_comp_visible('l_gldn010_36_2,l_gldn010_37_2,l_gldn010_38_2,l_gldn010_39_2,l_gldn010_40_2',FALSE)
      CALL cl_set_comp_visible('l_gldn010_21_3,l_gldn010_22_3,l_gldn010_23_3,l_gldn010_24_3,l_gldn010_25_3',FALSE)
      CALL cl_set_comp_visible('l_gldn010_26_3,l_gldn010_27_3,l_gldn010_28_3,l_gldn010_29_3,l_gldn010_30_3',FALSE)
      CALL cl_set_comp_visible('l_gldn010_31_3,l_gldn010_32_3,l_gldn010_33_3,l_gldn010_34_3,l_gldn010_35_3',FALSE)
      CALL cl_set_comp_visible('l_gldn010_36_3,l_gldn010_37_3,l_gldn010_38_3,l_gldn010_39_3,l_gldn010_40_3',FALSE)                  
   END IF
   
   
   


END FUNCTION

################################################################################
# Descriptions...: 計算公式
# Memo...........:
# Usage..........: CALL aglq930_formula(p_str,p_gldb001,p_gldc002)
# Date & Author..: 2015/12/15 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq930_formula(p_str,p_gldb001,p_gldc002,p_type,p_curr)
DEFINE p_str           STRING    
DEFINE p_gldb001       LIKE gldb_t.gldb001 #上層公司
DEFINE p_gldc002       LIKE gldc_t.gldc002 #下層公司
DEFINE p_type          LIKE type_t.chr1 #金額欄位
DEFINE p_curr          LIKE type_t.chr1 #記帳/功能/報告

DEFINE r_success       LIKE type_t.num5
DEFINE r_amount        LIKE glar_t.glar005
DEFINE l_glfc013       LIKE glfc_t.glfc013
DEFINE l_str           STRING
DEFINE l_str1          LIKE type_t.chr100
DEFINE l_str2          LIKE type_t.chr1
DEFINE l_str3          STRING
DEFINE l_str4          STRING    
DEFINE l_sql           STRING
DEFINE l_i             LIKE type_t.num5
DEFINE l_j             LIKE type_t.num5
DEFINE l_amt           LIKE glar_t.glar005
DEFINE l_delimiter1    STRING   #分隔符
DEFINE l_delimiter2    STRING   #分隔符
DEFINE l_operator      DYNAMIC ARRAY OF RECORD  #存儲運算符
                    symbol  LIKE type_t.chr80
                          END RECORD 
DEFINE tok3 base.StringTokenizer
DEFINE tok4 base.StringTokenizer

   LET r_success = TRUE
   LET r_amount = 0

   #去掉公式左右兩邊的空格
   LET p_str = p_str.trim()

   LET l_str  = ''
   LET l_str1 = ''
   LET l_str2 = ''
   CALL l_operator.clear()
   
   #抓取第一位字符是變量還是"("
   LET l_str2 = p_str.substring(1,1)

   LET l_delimiter1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"   #字母數字當做分隔符
   LET l_delimiter2 = "+-*/()"                                                           #運算符、括號作為分隔符
   LET tok3 = base.StringTokenizer.create(p_str,l_delimiter2)     #運算符、括號作為分隔符,取出字母數字   
   LET tok4 = base.StringTokenizer.create(p_str,l_delimiter1)     #字母數字當做分隔符,取出運算符、括號

   #將公式里的運算符存放到數組里
   LET l_i = 1
   WHILE tok4.hasMoreTokens()
     LET l_str3 = tok4.nextToken()
     LET l_str3 = l_str3.trim()
     LET l_operator[l_i].symbol = l_str3
     IF cl_null(l_operator[l_i].symbol) THEN  #去除掉空格
        CALL l_operator.deleteElement(l_i)
     ELSE
        LET l_i = l_i + 1
     END IF
   END WHILE

   CALL l_operator.deleteElement(l_i)
   LET l_i = l_i - 1
   
   LET l_j = 1
   WHILE tok3.hasMoreTokens()
     LET l_str1 = tok3.nextToken()

     #去除掉空格
     IF cl_null(l_str1) THEN
        CONTINUE WHILE
     END IF

     LET l_str4 = l_str1   
     LET l_amt = 0
     #取得金額傳入glfb005解析後的字串
     LET l_glfc013 = ''     
     SELECT glfc013 INTO l_glfc013 FROM glfc_t WHERE glfcent = g_enterprise AND glfc001 = l_str1
     CASE l_glfc013        
        WHEN 3     
           CALL aglq930_get_amt(l_str1,p_gldb001,p_gldc002,p_type,p_curr) RETURNING l_amt
        OTHERWISE
           CALL s_analy_form_get_glfc(g_input.l_glfa005,g_input.l_glfa006,g_input.l_glfa007,g_input.l_glfa007,l_str1,'','','') 
              RETURNING g_sub_success,l_amt
     END CASE
     IF cl_null(l_amt) THEN LET l_amt = 0 END IF

     IF l_str4.substring(1,1)  MATCHES '[0123456789]' THEN
        LET l_amt = l_str1
     END IF
 
     IF l_str2 = '(' THEN
        IF cl_null(l_str) THEN
           LET l_str = l_operator[l_j].symbol CLIPPED,l_amt CLIPPED
        ELSE
           LET l_str = l_str CLIPPED,l_operator[l_j].symbol CLIPPED,l_amt CLIPPED
        END IF
     ELSE
        IF cl_null(l_str) THEN
           LET l_str = l_amt CLIPPED,l_operator[l_j].symbol CLIPPED
        ELSE
           LET l_str = l_str CLIPPED, l_amt CLIPPED,l_operator[l_j].symbol CLIPPED
        END IF
     END IF
     LET l_j = l_j + 1
   END WHILE
   
   #如果運算符比變量多一位，遍歷變量時會少加最後一位運算符
   IF l_i = l_j THEN
      LET l_str = l_str CLIPPED, l_operator[l_j].symbol CLIPPED
   END IF

   IF cl_null(l_str) THEN
      RETURN r_amount
   END IF

   LET l_sql = "SELECT ",l_str CLIPPED," FROM DUAL"
   PREPARE l_sql_pre FROM l_sql
   EXECUTE l_sql_pre INTO r_amount
   
   #除數不可為0
   IF SQLCA.sqlerrd[2] = -1476 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00237'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_amount
   END IF

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00559'
      LET g_errparam.extend = l_str
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_amount
   END IF
   
   IF cl_null(r_amount) THEN
      LET r_amount = 0
   END IF 
   
   #根據金額單位對金額進行處理
   CASE g_input.l_glfa008
      WHEN '1'  #元
         LET r_amount = r_amount
      WHEN '2'  #千
         LET r_amount = r_amount / 1000
      WHEN '3'  #萬
         LET r_amount = r_amount / 10000
      OTHERWISE
         LET r_amount = r_amount
   END CASE


   RETURN r_amount
END FUNCTION

################################################################################
# Descriptions...: 取得金額
# Memo...........:
# Usage..........: CALL aglq930_get_amt(p_glfc001,p_gldb001,p_gldc002,p_type,p_curr)
# Date & Author..: 2015/12/16 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq930_get_amt(p_glfc001,p_gldb001,p_gldc002,p_type,p_curr)
DEFINE p_glfc001       STRING
DEFINE p_gldb001       LIKE gldb_t.gldb001
DEFINE p_gldc002       LIKE gldc_t.gldc002
DEFINE p_type          LIKE type_t.chr1 #金額欄位
DEFINE p_curr          LIKE type_t.chr1 #記帳/功能/報告
DEFINE r_amount        LIKE glar_t.glar005
DEFINE l_amt           LIKE glar_t.glar005
#161128-00061#1----modify------begin-----------
#DEFINE l_glfc          RECORD  LIKE glfc_t.*
DEFINE l_glfc RECORD  #公式設定檔
       glfcent LIKE glfc_t.glfcent, #企業編號
       glfcownid LIKE glfc_t.glfcownid, #資料所有者
       glfcowndp LIKE glfc_t.glfcowndp, #資料所屬部門
       glfccrtid LIKE glfc_t.glfccrtid, #資料建立者
       glfccrtdp LIKE glfc_t.glfccrtdp, #資料建立部門
       glfccrtdt LIKE glfc_t.glfccrtdt, #資料創建日
       glfcmodid LIKE glfc_t.glfcmodid, #資料修改者
       glfcmoddt LIKE glfc_t.glfcmoddt, #最近修改日
       glfc001 LIKE glfc_t.glfc001, #公式編號
       glfcseq LIKE glfc_t.glfcseq, #項次
       glfc002 LIKE glfc_t.glfc002, #科目參照表
       glfc003 LIKE glfc_t.glfc003, #起始科目
       glfc004 LIKE glfc_t.glfc004, #截止科目
       glfc005 LIKE glfc_t.glfc005, #選用核算項
       glfc006 LIKE glfc_t.glfc006, #起始核算項值
       glfc007 LIKE glfc_t.glfc007, #截止核算項值
       glfc008 LIKE glfc_t.glfc008, #取值方式
       glfc009 LIKE glfc_t.glfc009, #運算方式
       glfc010 LIKE glfc_t.glfc010, #額外條件
       glfc011 LIKE glfc_t.glfc011, #左括號
       glfc012 LIKE glfc_t.glfc012, #右括號
       glfc013 LIKE glfc_t.glfc013  #數據來源
       END RECORD

#161128-00061#1----modify------end-----------
DEFINE l_sql           STRING
DEFINE l_sql2          STRING
DEFINE l_str           STRING
DEFINE l_glfc009       STRING
DEFINE l_bgbj033       LIKE bgbj_t.bgbj033 #期初
DEFINE l_bgbc016       LIKE bgbc_t.bgbc016 #期間異動
DEFINE l_bgbd034       LIKE bgbd_t.bgbd034 #挪用追加
DEFINE l_glac008       LIKE glac_t.glac008
DEFINE l_field1        LIKE type_t.chr100
DEFINE l_field2        LIKE type_t.chr100
DEFINE l_field3        LIKE type_t.chr100
DEFINE l_field4        LIKE type_t.chr100
DEFINE l_field5        LIKE type_t.chr100
   
   
   LET l_str = ''
   LET r_amount = 0
   
   CASE p_curr 
      WHEN 1 #記帳
         LET l_field1 = " SELECT (gldn010-gldn011) " #借-貸
         LET l_field2 = " SELECT SUM(gldq017)      " #借
         LET l_field3 = " SELECT SUM(gldq018)      " #貸
      WHEN 2 #功能
         LET l_field1 = " SELECT (gldn027-gldn028) "
         LET l_field2 = " SELECT SUM(gldq019)      "
         LET l_field3 = " SELECT SUM(gldq020)      "
      WHEN 3 #報告
         LET l_field1 = " SELECT (gldn030-gldn031 )"
         LET l_field2 = " SELECT SUM(gldq021)      "
         LET l_field3 = " SELECT SUM(gldq022)      "
   
   END CASE
   LET p_glfc001 = p_glfc001.trim()
   #抓取變量設置/公式設定檔(agli201)
   #161128-00061#1----modify------begin-----------
   #LET l_sql = "SELECT * FROM glfc_t ",
   LET l_sql = "SELECT glfcent,glfcownid,glfcowndp,glfccrtid,glfccrtdp,glfccrtdt,glfcmodid,glfcmoddt,",
               "glfc001,glfcseq,glfc002,glfc003,glfc004,glfc005,glfc006,glfc007,glfc008,glfc009,glfc010,",
               "glfc011,glfc012,glfc013 FROM glfc_t ",
   #161128-00061#1----modify------end-----------
               " WHERE glfcent = '",g_enterprise,"'",
               "   AND glfc001 = '",p_glfc001,"'" 
   PREPARE glfc_pre FROM l_sql
   DECLARE glfc_cur CURSOR FOR glfc_pre
   FOREACH glfc_cur INTO l_glfc.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      IF cl_null(l_glfc.glfc004) THEN 
         LET l_glfc.glfc004 = l_glfc.glfc003
      END IF
    
      #左括號
      IF l_glfc.glfc011 = 'Y' THEN
         IF cl_null(l_str) THEN
            LET l_str = "(" CLIPPED
         ELSE
            LET l_str = l_str CLIPPED ," ( " CLIPPED
         END IF
      END IF
      
      #計算金額
      LET l_amt = 0
      CASE p_type
         WHEN '1'
            LET l_sql = l_field1 CLIPPED ,
                         "    FROM gldn_t                            ",
                         "   WHERE gldnent = '",g_enterprise,"'      ",
                         "     AND gldnld = '",g_input.l_glfa005,"'  ",
                         "     AND gldn001 = '",p_gldb001,"' AND gldn040 = '",p_gldc002,"'         ",
                         "     AND gldn005 = '",g_input.l_glfa006,"' AND gldn006 = '",g_input.l_glfa007,"' ", 
                         "     AND gldn007 BETWEEN '",l_glfc.glfc003,"' AND '",l_glfc.glfc004,"' ",  #科目 
                         "     AND gldn007 IN (SELECT glac002 FROM glac_t ",
                         "                      WHERE glac002 BETWEEN '",l_glfc.glfc003,"' AND '",l_glfc.glfc004,"' ",
                         "                        AND glac003 <> '1'  AND glac001 = '",g_glfa004,"')                " #科目參照表
          WHEN '2' #調整借方
             LET l_sql = l_field2 CLIPPED ,
                         "   FROM gldq_t,gldp_t                    ",
                         "  WHERE gldpent = gldqent AND gldpent = '",g_enterprise,"'          ",
                         "    AND gldpstus = 'Y' AND gldp005 = '1'                            ",
                         "    AND gldpdocno = gldqdocno  AND gldpld ='",g_input.l_glfa005,"'  ",
                         "    AND gldq001 BETWEEN '",l_glfc.glfc003,"' AND '",l_glfc.glfc004,"' ",
                         "    AND gldq001 IN (SELECT glac002 FROM glac_t ",
                         "                      WHERE glac002 BETWEEN '",l_glfc.glfc003,"' AND '",l_glfc.glfc004,"' ",
                         "                        AND glac003 <> '1'  AND glac001 = '",g_glfa004,"')                " #科目參照表                                                                                                       
          WHEN '3' #調整貸方
             LET l_sql = l_field3 CLIPPED ,
                         "   FROM gldq_t,gldp_t                    ",
                         "  WHERE gldpent = gldqent AND gldpent = '",g_enterprise,"' ",
                         "    AND gldpstus = 'Y' AND gldp005 = '1'                   ",
                         "    AND gldpdocno = gldqdocno  AND gldpld ='",g_input.l_glfa005,"'  ",
                         "    AND gldq001 BETWEEN '",l_glfc.glfc003,"' AND '",l_glfc.glfc004,"' ",
                         "    AND gldq001 IN (SELECT glac002 FROM glac_t ",
                         "                      WHERE glac002 BETWEEN '",l_glfc.glfc003,"' AND '",l_glfc.glfc004,"' ",
                         "                        AND glac003 <> '1'  AND glac001 = '",g_glfa004,"')                " #科目參照表 
         WHEN '4' #沖銷借方
             LET l_sql = l_field2 CLIPPED ,
                         "   FROM gldq_t,gldp_t                    ",
                         "  WHERE gldpent = gldqent AND gldpent = '",g_enterprise,"' ",
                         "    AND gldpstus = 'Y' AND gldp005 = '2'                   ",
                         "    AND gldpdocno = gldqdocno  AND gldpld ='",g_input.l_glfa005,"'  ",
                         "    AND gldq001 BETWEEN '",l_glfc.glfc003,"' AND '",l_glfc.glfc004,"' ",
                         "    AND gldq001 IN (SELECT glac002 FROM glac_t ",
                         "                      WHERE glac002 BETWEEN '",l_glfc.glfc003,"' AND '",l_glfc.glfc004,"' ",
                         "                        AND glac003 <> '1'  AND glac001 = '",g_glfa004,"')                " #科目參照表
         WHEN '5' #沖銷貸方
             LET l_sql = l_field3 CLIPPED ,
                         "   FROM gldq_t,gldp_t                    ",
                         "  WHERE gldpent = gldqent AND gldpent = '",g_enterprise,"' ",
                         "    AND gldpstus = 'Y' AND gldp005 = '2'                   ",
                         "    AND gldpdocno = gldqdocno  AND gldpld ='",g_input.l_glfa005,"'  ",
                         "    AND gldq001 BETWEEN '",l_glfc.glfc003,"' AND '",l_glfc.glfc004,"' ",
                         "    AND gldq001 IN (SELECT glac002 FROM glac_t ",
                         "                      WHERE glac002 BETWEEN '",l_glfc.glfc003,"' AND '",l_glfc.glfc004,"' ",
                         "                        AND glac003 <> '1'  AND glac001 = '",g_glfa004,"')                " #科目參照表                          
         WHEN '6' #會計師借方
             LET l_sql = l_field2 CLIPPED ,
                         "   FROM gldq_t,gldp_t                    ",
                         "  WHERE gldpent = gldqent AND gldpent = '",g_enterprise,"' ",
                         "    AND gldpstus = 'Y' AND gldp005 = '3'                   ",
                         "    AND gldpdocno = gldqdocno  AND gldpld ='",g_input.l_glfa005,"'  ",
                         "    AND gldq001 BETWEEN '",l_glfc.glfc003,"' AND '",l_glfc.glfc004,"' ",
                         "    AND gldq001 IN (SELECT glac002 FROM glac_t ",
                         "                      WHERE glac002 BETWEEN '",l_glfc.glfc003,"' AND '",l_glfc.glfc004,"' ",
                         "                        AND glac003 <> '1'  AND glac001 = '",g_glfa004,"')                " #科目參照表  
         WHEN '7' #會計師借方
             LET l_sql = l_field3 CLIPPED ,
                         "   FROM gldq_t,gldp_t                    ",
                         "  WHERE gldpent = gldqent AND gldpent = '",g_enterprise,"' ",
                         "    AND gldpstus = 'Y' AND gldp005 = '3'                   ",
                         "    AND gldpdocno = gldqdocno  AND gldpld ='",g_input.l_glfa005,"'  ",
                         "    AND gldq001 BETWEEN '",l_glfc.glfc003,"' AND '",l_glfc.glfc004,"' ",
                         "    AND gldq001 IN (SELECT glac002 FROM glac_t ",
                         "                      WHERE glac002 BETWEEN '",l_glfc.glfc003,"' AND '",l_glfc.glfc004,"' ",
                         "                        AND glac003 <> '1'  AND glac001 = '",g_glfa004,"')                " #科目參照表  
                    
      END CASE   
        #選定核算項
      CASE l_glfc.glfc005
         WHEN '1'   #營運據點
            LET l_field4 = 'gldn014'
            LET l_field5 = 'gldq003'
         WHEN '2'   #部門
            LET l_field4 = 'gldn015'
            LET l_field5 = 'gldq004'
         WHEN '3'   #利潤/成本中心
            LET l_field4 = 'gldn016'
            LET l_field5 = 'gldq005'
         WHEN '4'   #區域
            LET l_field4 = 'gldn017'
            LET l_field5 = 'gldq006'
         WHEN '5'   #交易客商
            LET l_field4 = 'gldn018'
            LET l_field5 = 'gldq007'
         WHEN '6'   #帳款客商
            LET l_field4 = 'gldn019'
            LET l_field5 = 'gldq008'
         WHEN '7'   #客群
            LET l_field4 = 'gldn020'          
            LET l_field5 = 'gldq009'
         WHEN '8'   #產品類別
            LET l_field4 = 'gldn021'         
            LET l_field5 = 'gldq010'
         WHEN '9'   #經營方式
            LET l_field4 = 'gldn037'        
            LET l_field5 = 'gldq011'
         WHEN '10'   #渠道
            LET l_field4 = 'gldn038'         
            LET l_field5 = 'gldq012'
         WHEN '11'   #品牌
            LET l_field4 = 'gldn039'
            LET l_field5 = 'gldq013'            
         WHEN '12'   #人員
            LET l_field4 = 'gldn022'           
            LET l_field5 = 'gldq014'
         WHEN '13'  #專案編號
            LET l_field4 = 'gldn024'           
            LET l_field5 = 'gldq015'
         WHEN '14'  #WBS
            LET l_field4 = 'gldn025'                  
            LET l_field5 = 'gldq016'
         OTHERWISE
            LET l_field4 = ''
      END CASE
     
      IF p_type = '1' THEN     
         LET l_sql = l_sql," AND gldn007 IN (SELECT glac002 FROM glac_t ",
                           "                  WHERE glac002 BETWEEN '",l_glfc.glfc003,"' AND '",l_glfc.glfc004,"'",
                           "                    AND glac003 <> '1'  AND glac001 = '",g_glfa004,"')"
      ELSE
         LET l_sql = l_sql," AND gldq001 IN (SELECT glac002 FROM glac_t ",
                           "                  WHERE glac002 BETWEEN '",l_glfc.glfc003,"' AND '",l_glfc.glfc004,"'",
                           "                    AND glac003 <> '1'  AND glac001 = '",g_glfa004,"')"
      
      END IF
     
      CASE p_type
        WHEN 1
           IF NOT cl_null(l_field4) THEN       
              IF NOT cl_null(l_glfc.glfc006) AND NOT cl_null(l_glfc.glfc007) THEN 
                 LET l_sql = l_sql," AND ",l_field4," BETWEEN '",l_glfc.glfc006,"' AND '",l_glfc.glfc007,"'"
              END IF         
              IF NOT cl_null(l_glfc.glfc006) AND cl_null(l_glfc.glfc007) THEN 
                 LET l_sql = l_sql," AND ",l_field4," BETWEEN '",l_glfc.glfc006,"' AND '",l_glfc.glfc006,"'"
              END IF
              IF cl_null(l_glfc.glfc006) AND NOT cl_null(l_glfc.glfc007) THEN 
                 LET l_sql = l_sql," AND ",l_field4," BETWEEN '",l_glfc.glfc007,"' AND '",l_glfc.glfc007,"'"
              END IF
           END IF
        OTHERWISE
           IF NOT cl_null(l_field5) THEN       
              IF NOT cl_null(l_glfc.glfc006) AND NOT cl_null(l_glfc.glfc007) THEN 
                 LET l_sql = l_sql," AND ",l_field5," BETWEEN '",l_glfc.glfc006,"' AND '",l_glfc.glfc007,"'"
              END IF         
              IF NOT cl_null(l_glfc.glfc006) AND cl_null(l_glfc.glfc007) THEN 
                 LET l_sql = l_sql," AND ",l_field5," BETWEEN '",l_glfc.glfc006,"' AND '",l_glfc.glfc006,"'"
              END IF
              IF cl_null(l_glfc.glfc006) AND NOT cl_null(l_glfc.glfc007) THEN 
                 LET l_sql = l_sql," AND ",l_field5," BETWEEN '",l_glfc.glfc007,"' AND '",l_glfc.glfc007,"'"
              END IF
           END IF        
      
      END CASE
      PREPARE aglq930_prep01 FROM l_sql  
      EXECUTE aglq930_prep01 INTO l_amt
      IF cl_null(l_amt) THEN LET  l_amt = 0 END IF   
              
      LET l_str = l_str CLIPPED,l_amt CLIPPED
      #右括號
      IF l_glfc.glfc012 = 'Y' THEN
         LET l_str = l_str CLIPPED ," ) " CLIPPED
      END IF
       
      #運算符
      CASE l_glfc.glfc009
         WHEN 1   LET l_glfc009 = ' + '
         WHEN 2   LET l_glfc009 = ' - '
         WHEN 3   LET l_glfc009 = ' * '
         WHEN 4   LET l_glfc009 = ' / '
      END CASE
      
      IF NOT cl_null(l_glfc.glfc009) THEN
         LET l_str = l_str CLIPPED,l_glfc009 CLIPPED
      END IF
      
   END FOREACH
   IF cl_null(l_str) THEN
      RETURN r_amount
   END IF
   
   LET l_sql = "SELECT ",l_str CLIPPED," FROM DUAL"
   PREPARE l_sql_pre1 FROM l_sql
   EXECUTE l_sql_pre1 INTO r_amount

   #除數不可為0
   IF SQLCA.sqlerrd[2] = -1476 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00237'
      LET g_errparam.extend = p_glfc001
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_amount
   END IF

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00559'
      LET g_errparam.extend = l_str
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_amount
   END IF

   IF cl_null(r_amount) THEN
      LET r_amount = 0
   END IF
   
   RETURN r_amount
END FUNCTION

################################################################################
# Descriptions...: 項目說明
# Memo...........:
# Usage..........: CALL aglq930_glfb004_ref(p_glfb002,p_glfbseq)
# Date & Author..: 2015/12/16 By HAns
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq930_glfb004_ref(p_glfb002,p_glfbseq)

DEFINE p_glfb002  LIKE glfb_t.glfb002
DEFINE p_glfbseq  LIKE glfb_t.glfbseq
DEFINE r_glfbl004 LIKE glfbl_t.glfbl004


   SELECT glfbl004 INTO r_glfbl004
     FROM glfbl_t
    WHERE glfblent = g_enterprise
      AND glfbl001 = g_input.l_glfa001
      AND glfbl002 = p_glfb002
      AND glfblseq = p_glfbseq
      AND glfbl003 = g_dlang
      
         RETURN r_glfbl004
END FUNCTION

################################################################################
# Descriptions...: 報告幣單身填充
# Memo...........:
# Usage..........: CALL aglq930_b_fill2()
# Date & Author..: 2015/12/17 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq930_b_fill2()
DEFINE l_glfb004 LIKE glfb_t.glfb004
DEFINE l_glfb005 LIKE glfb_t.glfb005
DEFINE l_i       LIKE type_t.num5
DEFINE l_amt1    LIKE gldq_t.gldq017
DEFINE l_amt2    LIKE gldq_t.gldq017
DEFINE l_amt3    LIKE gldq_t.gldq017
DEFINE l_format        STRING
DEFINE l_str           STRING
DEFINE l_flag    LIKE type_t.chr1
  
  
   LET g_sql =  "   SELECT DISTINCT glfb002,glfb003,                        ",
                "                   '','','','','','','','','','',          ",
                "                   '','','','','','','','','','',          ",
                "                   '','','','','','','',                   ",               
                "                   '','',                                  ",
                "                   '','','','','','','','','','',          ",
                "                   '','','','','','','','','','',          ",
                "                   '','','','','','','',                   ",
                "                   '','','','','','','','','','','','','', ",
                "                   glfbseq                                 ",
                "  FROM glfb_t                                              ",
                " WHERE glfbent= ? AND glfbseq1 IN ('A','B')                ",
                "   AND glfb001 = '",g_input.l_glfa001,"'                   ",
                " ORDER BY glfb003                                          "
 
   PREPARE aglq930_pb03 FROM g_sql
   DECLARE b_fill_curs03 CURSOR FOR aglq930_pb03
   
   OPEN b_fill_curs03 USING g_enterprise
   #陣列清空
   CALL g_gldn_d2.clear()

   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs03 INTO g_gldn_d2[l_ac].l_assest1,g_gldn_d2[l_ac].l_glfb0311,g_gldn_d2[l_ac].l_gldn010_01, 
       g_gldn_d2[l_ac].l_gldn010_02,g_gldn_d2[l_ac].l_gldn010_03,g_gldn_d2[l_ac].l_gldn010_04,g_gldn_d2[l_ac].l_gldn010_05, 
       g_gldn_d2[l_ac].l_gldn010_06,g_gldn_d2[l_ac].l_gldn010_07,g_gldn_d2[l_ac].l_gldn010_08,g_gldn_d2[l_ac].l_gldn010_09, 
       g_gldn_d2[l_ac].l_gldn010_10,g_gldn_d2[l_ac].l_gldn010_11,g_gldn_d2[l_ac].l_gldn010_12,g_gldn_d2[l_ac].l_gldn010_13, 
       g_gldn_d2[l_ac].l_gldn010_14,g_gldn_d2[l_ac].l_gldn010_15,g_gldn_d2[l_ac].l_gldn010_16,g_gldn_d2[l_ac].l_gldn010_17, 
       g_gldn_d2[l_ac].l_gldn010_18,g_gldn_d2[l_ac].l_gldn010_19,g_gldn_d2[l_ac].l_gldn010_20,g_gldn_d2[l_ac].l_gldq0171, 
       g_gldn_d2[l_ac].l_gldq0181,g_gldn_d2[l_ac].l_gldq0172,g_gldn_d2[l_ac].l_gldq0182,g_gldn_d2[l_ac].l_gldq0173, 
       g_gldn_d2[l_ac].l_gldq0183,g_gldn_d2[l_ac].l_amt1,g_gldn_d2[l_ac].l_assest2,g_gldn_d2[l_ac].l_glfb0312, 
       g_gldn_d2[l_ac].l_gldn010_21,g_gldn_d2[l_ac].l_gldn010_22,g_gldn_d2[l_ac].l_gldn010_23,g_gldn_d2[l_ac].l_gldn010_24, 
       g_gldn_d2[l_ac].l_gldn010_25,g_gldn_d2[l_ac].l_gldn010_26,g_gldn_d2[l_ac].l_gldn010_27,g_gldn_d2[l_ac].l_gldn010_28, 
       g_gldn_d2[l_ac].l_gldn010_29,g_gldn_d2[l_ac].l_gldn010_30,g_gldn_d2[l_ac].l_gldn010_31,g_gldn_d2[l_ac].l_gldn010_32, 
       g_gldn_d2[l_ac].l_gldn010_33,g_gldn_d2[l_ac].l_gldn010_34,g_gldn_d2[l_ac].l_gldn010_35,g_gldn_d2[l_ac].l_gldn010_36, 
       g_gldn_d2[l_ac].l_gldn010_37,g_gldn_d2[l_ac].l_gldn010_38,g_gldn_d2[l_ac].l_gldn010_39,g_gldn_d2[l_ac].l_gldn010_40, 
       g_gldn_d2[l_ac].l_gldq0174,g_gldn_d2[l_ac].l_gldq0184,g_gldn_d2[l_ac].l_gldq0175,g_gldn_d2[l_ac].l_gldq0185, 
       g_gldn_d2[l_ac].l_gldq0176,g_gldn_d2[l_ac].l_gldq0186,g_gldn_d2[l_ac].l_amt2,g_gldn_d2[l_ac].gldn001, 
       g_gldn_d2[l_ac].gldn002,g_gldn_d2[l_ac].gldn003,g_gldn_d2[l_ac].gldn004,g_gldn_d2[l_ac].gldn005,g_gldn_d2[l_ac].gldn006, 
       g_gldn_d2[l_ac].gldn007,g_gldn_d2[l_ac].gldn008,g_gldn_d2[l_ac].gldn032,g_gldn_d2[l_ac].gldn033,g_gldn_d2[l_ac].gldn040, 
       g_gldn_d2[l_ac].gldn041,g_gldn_d2[l_ac].gldnld,g_gldn_d2[l_ac].l_glfbseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      SELECT glfb004,glfb005 INTO l_glfb004,l_glfb005
        FROM glfb_t
       WHERE glfbent = g_enterprise
         AND glfb001 = g_input.l_glfa001
         AND glfbseq = g_gldn_d2[l_ac].l_glfbseq      
         AND glfbseq1 = 'B' 
             
      #預算金額      
      IF NOT cl_null(l_glfb005) THEN
         IF l_glfb004 = '1' THEN #取表內公式
            CALL s_analy_form_get_coordinate(g_input.l_glfa001,l_glfb005)
               RETURNING  g_sub_success,l_glfb005             
         END IF
         FOR l_i = 1 TO g_tree.getLength()
            CASE l_i
               WHEN 1                  
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_01                 
               WHEN 2                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_02
               WHEN 3                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_03
               WHEN 4                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_04
               WHEN 5                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_05
               WHEN 6                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_06
               WHEN 7                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_07
               WHEN 8                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_08
               WHEN 9                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_09
               WHEN 10                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_10
               WHEN 11                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_11
               WHEN 11                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_11
               WHEN 13                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_13
               WHEN 14                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_14
               WHEN 15                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_15
               WHEN 16                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_16
               WHEN 17                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_17
               WHEN 18
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_18
               WHEN 19
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_19
               WHEN 20
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_20
            END CASE             
         END FOR
      END IF        
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_01) THEN LET g_gldn_d2[l_ac].l_gldn010_01 = 0 END IF
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_02) THEN LET g_gldn_d2[l_ac].l_gldn010_02 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_03) THEN LET g_gldn_d2[l_ac].l_gldn010_03 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_04) THEN LET g_gldn_d2[l_ac].l_gldn010_04 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_05) THEN LET g_gldn_d2[l_ac].l_gldn010_05 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_06) THEN LET g_gldn_d2[l_ac].l_gldn010_06 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_07) THEN LET g_gldn_d2[l_ac].l_gldn010_07 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_08) THEN LET g_gldn_d2[l_ac].l_gldn010_08 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_09) THEN LET g_gldn_d2[l_ac].l_gldn010_09 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_10) THEN LET g_gldn_d2[l_ac].l_gldn010_10 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_11) THEN LET g_gldn_d2[l_ac].l_gldn010_11 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_12) THEN LET g_gldn_d2[l_ac].l_gldn010_12 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_13) THEN LET g_gldn_d2[l_ac].l_gldn010_13 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_14) THEN LET g_gldn_d2[l_ac].l_gldn010_14 = 0 END IF
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_15) THEN LET g_gldn_d2[l_ac].l_gldn010_15 = 0 END IF       
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_16) THEN LET g_gldn_d2[l_ac].l_gldn010_16 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_17) THEN LET g_gldn_d2[l_ac].l_gldn010_17 = 0 END IF 
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_18) THEN LET g_gldn_d2[l_ac].l_gldn010_18 = 0 END IF 
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_19) THEN LET g_gldn_d2[l_ac].l_gldn010_19 = 0 END IF 
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_20) THEN LET g_gldn_d2[l_ac].l_gldn010_20 = 0 END IF 

      #調整借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,2,2)RETURNING
         g_gldn_d2[l_ac].l_gldq0171
      #調整貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,3,2)RETURNING
         g_gldn_d2[l_ac].l_gldq0181      
      #沖銷借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,4,2)RETURNING
         g_gldn_d2[l_ac].l_gldq0172
      #沖銷貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,5,2)RETURNING
         g_gldn_d2[l_ac].l_gldq0182
      #會計師借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,6,2)RETURNING
         g_gldn_d2[l_ac].l_gldq0173
      #會計師貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,7,2)RETURNING
         g_gldn_d2[l_ac].l_gldq0183
      
      LET l_amt1 = g_gldn_d2[l_ac].l_gldq0171 - g_gldn_d2[l_ac].l_gldq0181
      LET l_amt2 = g_gldn_d2[l_ac].l_gldq0172 - g_gldn_d2[l_ac].l_gldq0182
      LET l_amt3 = g_gldn_d2[l_ac].l_gldq0173 - g_gldn_d2[l_ac].l_gldq0183     
      LET g_gldn_d2[l_ac].l_amt1 = g_gldn_d2[l_ac].l_gldn010_01 + g_gldn_d2[l_ac].l_gldn010_02 + g_gldn_d2[l_ac].l_gldn010_03
                                 + g_gldn_d2[l_ac].l_gldn010_04 + g_gldn_d2[l_ac].l_gldn010_05 + g_gldn_d2[l_ac].l_gldn010_06
                                 + g_gldn_d2[l_ac].l_gldn010_07 + g_gldn_d2[l_ac].l_gldn010_08 + g_gldn_d2[l_ac].l_gldn010_09
                                 + g_gldn_d2[l_ac].l_gldn010_10 + g_gldn_d2[l_ac].l_gldn010_11 + g_gldn_d2[l_ac].l_gldn010_12
                                 + g_gldn_d2[l_ac].l_gldn010_13 + g_gldn_d2[l_ac].l_gldn010_14 + g_gldn_d2[l_ac].l_gldn010_15
                                 + g_gldn_d2[l_ac].l_gldn010_16 + g_gldn_d2[l_ac].l_gldn010_17 + g_gldn_d2[l_ac].l_gldn010_18
                                 + g_gldn_d2[l_ac].l_gldn010_19 + g_gldn_d2[l_ac].l_gldn010_20 + l_amt1 +l_amt2 + l_amt3                                
             
      CALL aglq930_glfb004_ref(g_gldn_d2[l_ac].l_assest1,g_gldn_d2[l_ac].l_glfbseq)
         RETURNING g_gldn_d2[l_ac].l_assest1 
        

      LET l_ac = l_ac + 1
      
   END FOREACH
   
   CALL g_gldn_d2.deleteElement(g_gldn_d2.getLength())   

   LET g_sql =  "   SELECT DISTINCT glfb002,glfb003,                        ",
                 "                   '','','','','','','','','','',          ",
                 "                   '','','','','','','','','','',          ",
                 "                   '','','','','','','',                   ",
                 "                   glfbseq                                 ",
                 "  FROM glfb_t                                              ",
                 " WHERE glfbent= ? AND glfbseq1 IN ('C','D')                ",
                 "   AND glfb001 = '",g_input.l_glfa001,"'                   ",
                 " ORDER BY glfb003                                          "
                
   PREPARE aglq930_pb04  FROM g_sql
   DECLARE b_fill_curs04 CURSOR FOR aglq930_pb04
   LET l_ac = 1 
   OPEN b_fill_curs02 USING g_enterprise
   FOREACH b_fill_curs02 INTO g_gldn_d2[l_ac].l_assest2,g_gldn_d2[l_ac].l_glfb0312, 
       g_gldn_d2[l_ac].l_gldn010_21,g_gldn_d2[l_ac].l_gldn010_22,g_gldn_d2[l_ac].l_gldn010_23,g_gldn_d2[l_ac].l_gldn010_24, 
       g_gldn_d2[l_ac].l_gldn010_25,g_gldn_d2[l_ac].l_gldn010_26,g_gldn_d2[l_ac].l_gldn010_27,g_gldn_d2[l_ac].l_gldn010_28, 
       g_gldn_d2[l_ac].l_gldn010_29,g_gldn_d2[l_ac].l_gldn010_30,g_gldn_d2[l_ac].l_gldn010_31,g_gldn_d2[l_ac].l_gldn010_32, 
       g_gldn_d2[l_ac].l_gldn010_33,g_gldn_d2[l_ac].l_gldn010_34,g_gldn_d2[l_ac].l_gldn010_35,g_gldn_d2[l_ac].l_gldn010_36, 
       g_gldn_d2[l_ac].l_gldn010_37,g_gldn_d2[l_ac].l_gldn010_38,g_gldn_d2[l_ac].l_gldn010_39,g_gldn_d2[l_ac].l_gldn010_40, 
       g_gldn_d2[l_ac].l_gldq0174,g_gldn_d2[l_ac].l_gldq0184,g_gldn_d2[l_ac].l_gldq0175,g_gldn_d2[l_ac].l_gldq0185, 
       g_gldn_d2[l_ac].l_gldq0176,g_gldn_d2[l_ac].l_gldq0186,g_gldn_d2[l_ac].l_amt2,
       g_gldn_d2[l_ac].l_glfbseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF      
      #IF g_prog = 'aglq931' THEN EXIT FOREACH END IF        #160705-00042#8 160712 by sakura mark
      IF g_prog MATCHES 'aglq931' THEN EXIT FOREACH END IF   #160705-00042#8 160712 by sakura add
      SELECT glfb004,glfb005 INTO l_glfb004,l_glfb005
        FROM glfb_t
       WHERE glfbent = g_enterprise
         AND glfb001 = g_input.l_glfa001
         AND glfbseq = g_gldn_d2[l_ac].l_glfbseq      
         AND glfbseq1 = 'D' 
         
      #預算金額      
      IF NOT cl_null(l_glfb005) THEN
         IF l_glfb004 = '1' THEN #取表內公式
            CALL s_analy_form_get_coordinate(g_input.l_glfa001,l_glfb005)
               RETURNING  g_sub_success,l_glfb005             
         END IF
         FOR l_i = 1 TO g_tree.getLength()
            CASE l_i
               WHEN 1                  
                  CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_21                 
               WHEN 2                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_22
               WHEN 3                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_23
               WHEN 4                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_24
               WHEN 5                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_25
               WHEN 6                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_26
               WHEN 7                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_27
               WHEN 8                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_28
               WHEN 9                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_29
               WHEN 10                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_30
               WHEN 11                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_31
               WHEN 12                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_32
               WHEN 13                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_33
               WHEN 14                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_34
               WHEN 15                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_35
               WHEN 16                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_36
               WHEN 17                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_37
               WHEN 18
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_38
               WHEN 19
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_39
               WHEN 20
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d2[l_ac].l_gldn010_40
            END CASE             
         END FOR
      END IF        
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_21) THEN LET g_gldn_d2[l_ac].l_gldn010_21 = 0 END IF
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_22) THEN LET g_gldn_d2[l_ac].l_gldn010_22 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_23) THEN LET g_gldn_d2[l_ac].l_gldn010_23 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_24) THEN LET g_gldn_d2[l_ac].l_gldn010_24 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_25) THEN LET g_gldn_d2[l_ac].l_gldn010_25 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_26) THEN LET g_gldn_d2[l_ac].l_gldn010_26 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_27) THEN LET g_gldn_d2[l_ac].l_gldn010_27 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_28) THEN LET g_gldn_d2[l_ac].l_gldn010_28 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_29) THEN LET g_gldn_d2[l_ac].l_gldn010_29 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_30) THEN LET g_gldn_d2[l_ac].l_gldn010_30 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_31) THEN LET g_gldn_d2[l_ac].l_gldn010_31 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_32) THEN LET g_gldn_d2[l_ac].l_gldn010_32 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_33) THEN LET g_gldn_d2[l_ac].l_gldn010_33 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_34) THEN LET g_gldn_d2[l_ac].l_gldn010_34 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_35) THEN LET g_gldn_d2[l_ac].l_gldn010_35 = 0 END IF
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_36) THEN LET g_gldn_d2[l_ac].l_gldn010_36 = 0 END IF  
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_37) THEN LET g_gldn_d2[l_ac].l_gldn010_37 = 0 END IF 
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_38) THEN LET g_gldn_d2[l_ac].l_gldn010_38 = 0 END IF 
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_39) THEN LET g_gldn_d2[l_ac].l_gldn010_39 = 0 END IF 
      IF cl_null(g_gldn_d2[l_ac].l_gldn010_40) THEN LET g_gldn_d2[l_ac].l_gldn010_40 = 0 END IF 
      
      
       #調整借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,2,1)RETURNING
         g_gldn_d2[l_ac].l_gldq0174
      #調整貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,3,1)RETURNING
         g_gldn_d2[l_ac].l_gldq0184      
      #沖銷借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,4,1)RETURNING
         g_gldn_d2[l_ac].l_gldq0175
      #沖銷貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,5,1)RETURNING
         g_gldn_d2[l_ac].l_gldq0185
      #會計師借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,6,1)RETURNING
         g_gldn_d2[l_ac].l_gldq0176
      #會計師貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,7,1)RETURNING
         g_gldn_d2[l_ac].l_gldq0186
      
      LET l_amt1 = g_gldn_d2[l_ac].l_gldq0174 - g_gldn_d2[l_ac].l_gldq0184
      LET l_amt2 = g_gldn_d2[l_ac].l_gldq0175 - g_gldn_d2[l_ac].l_gldq0185
      LET l_amt3 = g_gldn_d2[l_ac].l_gldq0176 - g_gldn_d2[l_ac].l_gldq0186
      
      LET g_gldn_d2[l_ac].l_amt2 = g_gldn_d2[l_ac].l_gldn010_21 + g_gldn_d2[l_ac].l_gldn010_22 + g_gldn_d2[l_ac].l_gldn010_23
                                 + g_gldn_d2[l_ac].l_gldn010_24 + g_gldn_d2[l_ac].l_gldn010_25 + g_gldn_d2[l_ac].l_gldn010_26
                                 + g_gldn_d2[l_ac].l_gldn010_27 + g_gldn_d2[l_ac].l_gldn010_28 + g_gldn_d2[l_ac].l_gldn010_29
                                 + g_gldn_d2[l_ac].l_gldn010_30 + g_gldn_d2[l_ac].l_gldn010_31 + g_gldn_d2[l_ac].l_gldn010_32
                                 + g_gldn_d2[l_ac].l_gldn010_33 + g_gldn_d2[l_ac].l_gldn010_34 + g_gldn_d2[l_ac].l_gldn010_35
                                 + g_gldn_d2[l_ac].l_gldn010_36 + g_gldn_d2[l_ac].l_gldn010_37 + g_gldn_d2[l_ac].l_gldn010_38
                                 + g_gldn_d2[l_ac].l_gldn010_39 + g_gldn_d2[l_ac].l_gldn010_40 + l_amt1 +l_amt2 + l_amt3                                
                                 
      CALL aglq930_glfb004_ref(g_gldn_d2[l_ac].l_assest2,g_gldn_d2[l_ac].l_glfbseq)
         RETURNING g_gldn_d2[l_ac].l_assest2
      
      LET l_ac = l_ac + 1
   END FOREACH
   #IF g_prog = 'aglq931' OR g_glfa003 = '2' OR l_flag = 'N'THEN        #160705-00042#8 160712 by sakura mark
   IF g_prog MATCHES 'aglq931' OR g_glfa003 = '2' OR l_flag = 'N'THEN   #160705-00042#8 160712 by sakura add
   ELSE
      CALL g_gldn_d2.deleteElement(g_gldn_d2.getLength()) 
   END IF
   LET g_tot_cnt = g_gldn_d2.getLength()

   #設置單身金額欄位格式
   LET l_format = "---,---,---,--&"
   LET l_str = ""
   FOR l_i=1 TO g_input.l_glfa009
       LET l_str = l_str,"&"
   END FOR
   IF NOT cl_null(l_str) THEN
      LET l_format = l_format,'.',l_str
   END IF
   CALL cl_set_comp_format("l_gldn010_01_2,l_gldn010_02_2,l_gldn010_03_2,l_gldn010_04_2,l_gldn010_05_2",l_format)
   CALL cl_set_comp_format("l_gldn010_06_2,l_gldn010_07_2,l_gldn010_08_2,l_gldn010_09_2,l_gldn010_10_2",l_format)
   CALL cl_set_comp_format("l_gldn010_11_2,l_gldn010_12_2,l_gldn010_13_2,l_gldn010_14_2,l_gldn010_15_2",l_format)
   CALL cl_set_comp_format("l_gldn010_16_2,l_gldn010_17_2,l_gldn010_18_2,l_gldn010_19_2,l_gldn010_20_2",l_format)
   CALL cl_set_comp_format("l_gldq0171_2,l_gldq0172_2,l_gldq0173_2,l_gldq0181_2,l_gldq0182_2,l_gldq0183_2,l_amt1_2",l_format)
   
   CALL cl_set_comp_format("l_gldn010_21_2,l_gldn010_22_2,l_gldn010_23_2,l_gldn010_24_2,l_gldn010_25_2",l_format)
   CALL cl_set_comp_format("l_gldn010_26_2,l_gldn010_27_2,l_gldn010_28_2,l_gldn010_29_2,l_gldn010_30_2",l_format)
   CALL cl_set_comp_format("l_gldn010_31_2,l_gldn010_32_2,l_gldn010_33_2,l_gldn010_34_2,l_gldn010_35_2",l_format)
   CALL cl_set_comp_format("l_gldn010_36_2,l_gldn010_37_2,l_gldn010_38_2,l_gldn010_39_2,l_gldn010_40_2",l_format)
   CALL cl_set_comp_format("l_gldq0174_2,l_gldq0175_2,l_gldq0176_2,l_gldq0184_2,l_gldq0185_2,l_gldq0186_2,l_amt2_2",l_format)


END FUNCTION

################################################################################
# Descriptions...: 報告幣單身填充
# Memo...........:
# Usage..........: CALL aglq930_b_fill3()
# Date & Author..: 2015/12/18 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq930_b_fill3()
DEFINE l_glfb004 LIKE glfb_t.glfb004
DEFINE l_glfb005 LIKE glfb_t.glfb005
DEFINE l_i       LIKE type_t.num5
DEFINE l_amt1    LIKE gldq_t.gldq017
DEFINE l_amt2    LIKE gldq_t.gldq017
DEFINE l_amt3    LIKE gldq_t.gldq017
DEFINE l_format        STRING
DEFINE l_str           STRING
DEFINE l_flag    LIKE type_t.chr1  
  
   LET g_sql =  "   SELECT DISTINCT glfb002,glfb003,                        ",
                "                   '','','','','','','','','','',          ",
                "                   '','','','','','','','','','',          ",
                "                   '','','','','','','',                   ",               
                "                   '','',                                  ",
                "                   '','','','','','','','','','',          ",
                "                   '','','','','','','','','','',          ",
                "                   '','','','','','','',                   ",
                "                   '','','','','','','','','','','','','', ",
                "                   glfbseq                                 ",
                "  FROM glfb_t                                              ",
                " WHERE glfbent= ? AND glfbseq1 IN ('A','B')                ",
                "   AND glfb001 = '",g_input.l_glfa001,"'                   ",
                " ORDER BY glfb003                                          "
 
   PREPARE aglq930_pb05 FROM g_sql
   DECLARE b_fill_curs05 CURSOR FOR aglq930_pb05
   
   OPEN b_fill_curs05 USING g_enterprise
   #陣列清空
   CALL g_gldn_d3.clear()

   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs05 INTO g_gldn_d3[l_ac].l_assest1,g_gldn_d3[l_ac].l_glfb0311,g_gldn_d3[l_ac].l_gldn010_01, 
       g_gldn_d3[l_ac].l_gldn010_02,g_gldn_d3[l_ac].l_gldn010_03,g_gldn_d3[l_ac].l_gldn010_04,g_gldn_d3[l_ac].l_gldn010_05, 
       g_gldn_d3[l_ac].l_gldn010_06,g_gldn_d3[l_ac].l_gldn010_07,g_gldn_d3[l_ac].l_gldn010_08,g_gldn_d3[l_ac].l_gldn010_09, 
       g_gldn_d3[l_ac].l_gldn010_10,g_gldn_d3[l_ac].l_gldn010_11,g_gldn_d3[l_ac].l_gldn010_12,g_gldn_d3[l_ac].l_gldn010_13, 
       g_gldn_d3[l_ac].l_gldn010_14,g_gldn_d3[l_ac].l_gldn010_15,g_gldn_d3[l_ac].l_gldn010_16,g_gldn_d3[l_ac].l_gldn010_17, 
       g_gldn_d3[l_ac].l_gldn010_18,g_gldn_d3[l_ac].l_gldn010_19,g_gldn_d3[l_ac].l_gldn010_20,
       g_gldn_d3[l_ac].l_gldq0171,g_gldn_d3[l_ac].l_gldq0181,g_gldn_d3[l_ac].l_gldq0172,g_gldn_d3[l_ac].l_gldq0182,
       g_gldn_d3[l_ac].l_gldq0173,g_gldn_d3[l_ac].l_gldq0183,
       g_gldn_d3[l_ac].l_amt1,g_gldn_d3[l_ac].l_assest2,g_gldn_d3[l_ac].l_glfb0312, 
       g_gldn_d3[l_ac].l_gldn010_21,g_gldn_d3[l_ac].l_gldn010_22,g_gldn_d3[l_ac].l_gldn010_23,g_gldn_d3[l_ac].l_gldn010_24, 
       g_gldn_d3[l_ac].l_gldn010_25,g_gldn_d3[l_ac].l_gldn010_26,g_gldn_d3[l_ac].l_gldn010_27,g_gldn_d3[l_ac].l_gldn010_28, 
       g_gldn_d3[l_ac].l_gldn010_29,g_gldn_d3[l_ac].l_gldn010_30,g_gldn_d3[l_ac].l_gldn010_31,g_gldn_d3[l_ac].l_gldn010_32, 
       g_gldn_d3[l_ac].l_gldn010_33,g_gldn_d3[l_ac].l_gldn010_34,g_gldn_d3[l_ac].l_gldn010_35,g_gldn_d3[l_ac].l_gldn010_36, 
       g_gldn_d3[l_ac].l_gldn010_37,g_gldn_d3[l_ac].l_gldn010_38,g_gldn_d3[l_ac].l_gldn010_39,g_gldn_d3[l_ac].l_gldn010_40, 
       g_gldn_d3[l_ac].l_gldq0174,g_gldn_d3[l_ac].l_gldq0184,g_gldn_d3[l_ac].l_gldq0175,g_gldn_d3[l_ac].l_gldq0185, 
       g_gldn_d3[l_ac].l_gldq0176,g_gldn_d3[l_ac].l_gldq0186,g_gldn_d3[l_ac].l_amt2,g_gldn_d3[l_ac].gldn001, 
       g_gldn_d3[l_ac].gldn002,g_gldn_d3[l_ac].gldn003,g_gldn_d3[l_ac].gldn004,g_gldn_d3[l_ac].gldn005,g_gldn_d3[l_ac].gldn006, 
       g_gldn_d3[l_ac].gldn007,g_gldn_d3[l_ac].gldn008,g_gldn_d3[l_ac].gldn032,g_gldn_d3[l_ac].gldn033,g_gldn_d3[l_ac].gldn040, 
       g_gldn_d3[l_ac].gldn041,g_gldn_d3[l_ac].gldnld,g_gldn_d3[l_ac].l_glfbseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      SELECT glfb004,glfb005 INTO l_glfb004,l_glfb005
        FROM glfb_t
       WHERE glfbent = g_enterprise
         AND glfb001 = g_input.l_glfa001
         AND glfbseq = g_gldn_d3[l_ac].l_glfbseq      
         AND glfbseq1 = 'B' 
             
      #預算金額      
      IF NOT cl_null(l_glfb005) THEN
         IF l_glfb004 = '1' THEN #取表內公式
            CALL s_analy_form_get_coordinate(g_input.l_glfa001,l_glfb005)
               RETURNING  g_sub_success,l_glfb005             
         END IF
         FOR l_i = 1 TO g_tree.getLength()
            CASE l_i
               WHEN 1                  
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_01                 
               WHEN 2                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_02
               WHEN 3                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_03
               WHEN 4                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_04
               WHEN 5                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_05
               WHEN 6                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,2)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_06
               WHEN 7                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_07
               WHEN 8                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_08
               WHEN 9                          
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_09
               WHEN 10                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_10
               WHEN 11                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_11
               WHEN 11                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_11
               WHEN 13                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_13
               WHEN 14                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_14
               WHEN 15                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_15
               WHEN 16                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_16
               WHEN 17                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_17
               WHEN 18
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_18
               WHEN 19
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_19
               WHEN 20
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_20
            END CASE             
         END FOR
      END IF        
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_01) THEN LET g_gldn_d3[l_ac].l_gldn010_01 = 0 END IF
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_02) THEN LET g_gldn_d3[l_ac].l_gldn010_02 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_03) THEN LET g_gldn_d3[l_ac].l_gldn010_03 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_04) THEN LET g_gldn_d3[l_ac].l_gldn010_04 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_05) THEN LET g_gldn_d3[l_ac].l_gldn010_05 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_06) THEN LET g_gldn_d3[l_ac].l_gldn010_06 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_07) THEN LET g_gldn_d3[l_ac].l_gldn010_07 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_08) THEN LET g_gldn_d3[l_ac].l_gldn010_08 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_09) THEN LET g_gldn_d3[l_ac].l_gldn010_09 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_10) THEN LET g_gldn_d3[l_ac].l_gldn010_10 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_11) THEN LET g_gldn_d3[l_ac].l_gldn010_11 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_12) THEN LET g_gldn_d3[l_ac].l_gldn010_12 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_13) THEN LET g_gldn_d3[l_ac].l_gldn010_13 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_14) THEN LET g_gldn_d3[l_ac].l_gldn010_14 = 0 END IF
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_15) THEN LET g_gldn_d3[l_ac].l_gldn010_15 = 0 END IF       
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_16) THEN LET g_gldn_d3[l_ac].l_gldn010_16 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_17) THEN LET g_gldn_d3[l_ac].l_gldn010_17 = 0 END IF 
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_18) THEN LET g_gldn_d3[l_ac].l_gldn010_18 = 0 END IF 
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_19) THEN LET g_gldn_d3[l_ac].l_gldn010_19 = 0 END IF 
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_20) THEN LET g_gldn_d3[l_ac].l_gldn010_20 = 0 END IF 

      #調整借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,2,3)RETURNING
         g_gldn_d3[l_ac].l_gldq0171
      #調整貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,3,3)RETURNING
         g_gldn_d3[l_ac].l_gldq0181      
      #沖銷借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,4,3)RETURNING
         g_gldn_d3[l_ac].l_gldq0172
      #沖銷貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,5,3)RETURNING
         g_gldn_d3[l_ac].l_gldq0182
      #會計師借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,6,3)RETURNING
         g_gldn_d3[l_ac].l_gldq0173
      #會計師貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,7,3)RETURNING
         g_gldn_d3[l_ac].l_gldq0183
      
      LET l_amt1 = g_gldn_d3[l_ac].l_gldq0171 - g_gldn_d3[l_ac].l_gldq0181
      LET l_amt2 = g_gldn_d3[l_ac].l_gldq0172 - g_gldn_d3[l_ac].l_gldq0182
      LET l_amt3 = g_gldn_d3[l_ac].l_gldq0173 - g_gldn_d3[l_ac].l_gldq0183     
      LET g_gldn_d3[l_ac].l_amt1 = g_gldn_d3[l_ac].l_gldn010_01 + g_gldn_d3[l_ac].l_gldn010_02 + g_gldn_d3[l_ac].l_gldn010_03
                                 + g_gldn_d3[l_ac].l_gldn010_04 + g_gldn_d3[l_ac].l_gldn010_05 + g_gldn_d3[l_ac].l_gldn010_06
                                 + g_gldn_d3[l_ac].l_gldn010_07 + g_gldn_d3[l_ac].l_gldn010_08 + g_gldn_d3[l_ac].l_gldn010_09
                                 + g_gldn_d3[l_ac].l_gldn010_10 + g_gldn_d3[l_ac].l_gldn010_11 + g_gldn_d3[l_ac].l_gldn010_12
                                 + g_gldn_d3[l_ac].l_gldn010_13 + g_gldn_d3[l_ac].l_gldn010_14 + g_gldn_d3[l_ac].l_gldn010_15
                                 + g_gldn_d3[l_ac].l_gldn010_16 + g_gldn_d3[l_ac].l_gldn010_17 + g_gldn_d3[l_ac].l_gldn010_18
                                 + g_gldn_d3[l_ac].l_gldn010_19 + g_gldn_d3[l_ac].l_gldn010_20 + l_amt1 +l_amt2 + l_amt3                                
             
      CALL aglq930_glfb004_ref(g_gldn_d3[l_ac].l_assest1,g_gldn_d3[l_ac].l_glfbseq)
         RETURNING g_gldn_d3[l_ac].l_assest1 
        

      LET l_ac = l_ac + 1
      
   END FOREACH
   
   CALL g_gldn_d2.deleteElement(g_gldn_d3.getLength())   

   LET g_sql =  "   SELECT DISTINCT glfb002,glfb003,                        ",
                 "                   '','','','','','','','','','',          ",
                 "                   '','','','','','','','','','',          ",
                 "                   '','','','','','','',                   ",
                 "                   glfbseq                                 ",
                 "  FROM glfb_t                                              ",
                 " WHERE glfbent= ? AND glfbseq1 IN ('C','D')                ",
                 "   AND glfb001 = '",g_input.l_glfa001,"'                   ",
                 " ORDER BY glfb003                                          "
                
   PREPARE aglq930_pb06  FROM g_sql
   DECLARE b_fill_curs06 CURSOR FOR aglq930_pb06
   LET l_ac = 1 
   OPEN b_fill_curs06 USING g_enterprise
   FOREACH b_fill_curs06 INTO g_gldn_d3[l_ac].l_assest2,g_gldn_d3[l_ac].l_glfb0312, 
       g_gldn_d3[l_ac].l_gldn010_21,g_gldn_d3[l_ac].l_gldn010_22,g_gldn_d3[l_ac].l_gldn010_23,g_gldn_d3[l_ac].l_gldn010_24, 
       g_gldn_d3[l_ac].l_gldn010_25,g_gldn_d3[l_ac].l_gldn010_26,g_gldn_d3[l_ac].l_gldn010_27,g_gldn_d3[l_ac].l_gldn010_28, 
       g_gldn_d3[l_ac].l_gldn010_29,g_gldn_d3[l_ac].l_gldn010_30,g_gldn_d3[l_ac].l_gldn010_31,g_gldn_d3[l_ac].l_gldn010_32, 
       g_gldn_d3[l_ac].l_gldn010_33,g_gldn_d3[l_ac].l_gldn010_34,g_gldn_d3[l_ac].l_gldn010_35,g_gldn_d3[l_ac].l_gldn010_36, 
       g_gldn_d3[l_ac].l_gldn010_37,g_gldn_d3[l_ac].l_gldn010_38,g_gldn_d3[l_ac].l_gldn010_39,g_gldn_d3[l_ac].l_gldn010_40, 
       g_gldn_d3[l_ac].l_gldq0174,g_gldn_d3[l_ac].l_gldq0184,g_gldn_d3[l_ac].l_gldq0175,g_gldn_d3[l_ac].l_gldq0185, 
       g_gldn_d3[l_ac].l_gldq0176,g_gldn_d3[l_ac].l_gldq0186,g_gldn_d3[l_ac].l_amt2,
       g_gldn_d3[l_ac].l_glfbseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF      
      #IF g_prog = 'aglq931' THEN EXIT FOREACH END IF        #160705-00042#8 160712 by sakura mark
      IF g_prog MATCHES 'aglq931' THEN EXIT FOREACH END IF   #160705-00042#8 160712 by sakura add
      SELECT glfb004,glfb005 INTO l_glfb004,l_glfb005
        FROM glfb_t
       WHERE glfbent = g_enterprise
         AND glfb001 = g_input.l_glfa001
         AND glfbseq = g_gldn_d2[l_ac].l_glfbseq      
         AND glfbseq1 = 'D' 
         
      #預算金額      
      IF NOT cl_null(l_glfb005) THEN
         IF l_glfb004 = '1' THEN #取表內公式
            CALL s_analy_form_get_coordinate(g_input.l_glfa001,l_glfb005)
               RETURNING  g_sub_success,l_glfb005             
         END IF
         FOR l_i = 1 TO g_tree.getLength()
            CASE l_i
               WHEN 1                  
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_21                 
               WHEN 2                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_22
               WHEN 3                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_23
               WHEN 4                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_24
               WHEN 5                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_25
               WHEN 6                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_26
               WHEN 7                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_27
               WHEN 8                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_28
               WHEN 9                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_29
               WHEN 10                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_30
               WHEN 11                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_31
               WHEN 12                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_32
               WHEN 13                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_33
               WHEN 14                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_34
               WHEN 15                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_35
               WHEN 16                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_36
               WHEN 17                           
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_37
               WHEN 18
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_38
               WHEN 19
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_39
               WHEN 20
                 CALL aglq930_formula(l_glfb005,g_tree[l_i].gldb001,g_tree[l_i].gldc002,1,3)RETURNING
                     g_gldn_d3[l_ac].l_gldn010_40
            END CASE             
         END FOR
      END IF        
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_21) THEN LET g_gldn_d3[l_ac].l_gldn010_21 = 0 END IF
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_22) THEN LET g_gldn_d3[l_ac].l_gldn010_22 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_23) THEN LET g_gldn_d3[l_ac].l_gldn010_23 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_24) THEN LET g_gldn_d3[l_ac].l_gldn010_24 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_25) THEN LET g_gldn_d3[l_ac].l_gldn010_25 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_26) THEN LET g_gldn_d3[l_ac].l_gldn010_26 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_27) THEN LET g_gldn_d3[l_ac].l_gldn010_27 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_28) THEN LET g_gldn_d3[l_ac].l_gldn010_28 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_29) THEN LET g_gldn_d3[l_ac].l_gldn010_29 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_30) THEN LET g_gldn_d3[l_ac].l_gldn010_30 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_31) THEN LET g_gldn_d3[l_ac].l_gldn010_31 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_32) THEN LET g_gldn_d3[l_ac].l_gldn010_32 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_33) THEN LET g_gldn_d3[l_ac].l_gldn010_33 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_34) THEN LET g_gldn_d3[l_ac].l_gldn010_34 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_35) THEN LET g_gldn_d3[l_ac].l_gldn010_35 = 0 END IF
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_36) THEN LET g_gldn_d3[l_ac].l_gldn010_36 = 0 END IF  
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_37) THEN LET g_gldn_d3[l_ac].l_gldn010_37 = 0 END IF 
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_38) THEN LET g_gldn_d3[l_ac].l_gldn010_38 = 0 END IF 
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_39) THEN LET g_gldn_d3[l_ac].l_gldn010_39 = 0 END IF 
      IF cl_null(g_gldn_d3[l_ac].l_gldn010_40) THEN LET g_gldn_d3[l_ac].l_gldn010_40 = 0 END IF 
      
      
       #調整借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,2,3)RETURNING
         g_gldn_d3[l_ac].l_gldq0174
      #調整貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,3,3)RETURNING
         g_gldn_d3[l_ac].l_gldq0184      
      #沖銷借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,4,3)RETURNING
         g_gldn_d3[l_ac].l_gldq0175
      #沖銷貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,5,3)RETURNING
         g_gldn_d3[l_ac].l_gldq0185
      #會計師借方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,6,3)RETURNING
         g_gldn_d3[l_ac].l_gldq0176
      #會計師貸方
      CALL aglq930_formula(l_glfb005,g_tree[1].gldb001,g_tree[1].gldc002,7,3)RETURNING
         g_gldn_d3[l_ac].l_gldq0186
      
      LET l_amt1 = g_gldn_d3[l_ac].l_gldq0174 - g_gldn_d3[l_ac].l_gldq0184
      LET l_amt2 = g_gldn_d3[l_ac].l_gldq0175 - g_gldn_d3[l_ac].l_gldq0185
      LET l_amt3 = g_gldn_d3[l_ac].l_gldq0176 - g_gldn_d3[l_ac].l_gldq0186
      
      LET g_gldn_d3[l_ac].l_amt2 = g_gldn_d3[l_ac].l_gldn010_21 + g_gldn_d3[l_ac].l_gldn010_22 + g_gldn_d3[l_ac].l_gldn010_23
                                 + g_gldn_d3[l_ac].l_gldn010_24 + g_gldn_d3[l_ac].l_gldn010_25 + g_gldn_d3[l_ac].l_gldn010_26
                                 + g_gldn_d3[l_ac].l_gldn010_27 + g_gldn_d3[l_ac].l_gldn010_28 + g_gldn_d3[l_ac].l_gldn010_29
                                 + g_gldn_d3[l_ac].l_gldn010_30 + g_gldn_d3[l_ac].l_gldn010_31 + g_gldn_d3[l_ac].l_gldn010_32
                                 + g_gldn_d3[l_ac].l_gldn010_33 + g_gldn_d3[l_ac].l_gldn010_34 + g_gldn_d3[l_ac].l_gldn010_35
                                 + g_gldn_d3[l_ac].l_gldn010_36 + g_gldn_d3[l_ac].l_gldn010_37 + g_gldn_d3[l_ac].l_gldn010_38
                                 + g_gldn_d3[l_ac].l_gldn010_39 + g_gldn_d3[l_ac].l_gldn010_40 + l_amt1 +l_amt2 + l_amt3                                
                                 
      CALL aglq930_glfb004_ref(g_gldn_d3[l_ac].l_assest2,g_gldn_d3[l_ac].l_glfbseq)
         RETURNING g_gldn_d3[l_ac].l_assest2
      
      LET l_ac = l_ac + 1
   END FOREACH
   #IF g_prog = 'aglq931' OR g_glfa003 = '2' OR l_flag = 'N'THEN        #160705-00042#8 160712 by sakura mark
   IF g_prog MATCHES 'aglq931' OR g_glfa003 = '2' OR l_flag = 'N'THEN   #160705-00042#8 160712 by sakura add
   ELSE
      CALL g_gldn_d3.deleteElement(g_gldn_d3.getLength()) 
   END IF
   LET g_tot_cnt = g_gldn_d2.getLength()

   #設置單身金額欄位格式
   LET l_format = "---,---,---,--&"
   LET l_str = ""
   FOR l_i=1 TO g_input.l_glfa009
       LET l_str = l_str,"&"
   END FOR
   IF NOT cl_null(l_str) THEN
      LET l_format = l_format,'.',l_str
   END IF
   CALL cl_set_comp_format("l_gldn010_01_3,l_gldn010_02_3,l_gldn010_03_3,l_gldn010_04_3,l_gldn010_05_3",l_format)
   CALL cl_set_comp_format("l_gldn010_06_3,l_gldn010_07_3,l_gldn010_08_3,l_gldn010_09_3,l_gldn010_10_3",l_format)
   CALL cl_set_comp_format("l_gldn010_11_3,l_gldn010_12_3,l_gldn010_13_3,l_gldn010_14_3,l_gldn010_15_3",l_format)
   CALL cl_set_comp_format("l_gldn010_16_3,l_gldn010_17_3,l_gldn010_18_3,l_gldn010_19_3,l_gldn010_20_3",l_format)
   CALL cl_set_comp_format("l_gldq0171_3,l_gldq0172_3,l_gldq0173_3,l_gldq0181_3,l_gldq0182_3,l_gldq0183_3,l_amt1_3",l_format)
   
   CALL cl_set_comp_format("l_gldn010_21_3,l_gldn010_22_3,l_gldn010_23_3,l_gldn010_24_2,l_gldn010_25_3",l_format)
   CALL cl_set_comp_format("l_gldn010_26_3,l_gldn010_27_3,l_gldn010_28_3,l_gldn010_29_2,l_gldn010_30_3",l_format)
   CALL cl_set_comp_format("l_gldn010_31_3,l_gldn010_32_3,l_gldn010_33_3,l_gldn010_34_2,l_gldn010_35_3",l_format)
   CALL cl_set_comp_format("l_gldn010_36_3,l_gldn010_37_3,l_gldn010_38_3,l_gldn010_39_2,l_gldn010_40_3",l_format)
   CALL cl_set_comp_format("l_gldq0174_3,l_gldq0175_3,l_gldq0176_3,l_gldq0184_3,l_gldq0185_3,l_gldq0186_3,l_amt2_3",l_format)
   
END FUNCTION

################################################################################
# Descriptions...: 設定分頁
# Memo...........:
# Usage..........: CALL aglq930_set_page()
# Date & Author..: 2015/15/18 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq930_set_page()
DEFINE l_idx    LIKE type_t.num5
DEFINE l_sql    STRING
DEFINE i        LIKE type_t.num5
   
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
   
   CALL g_gldc_d.clear()
   #只依合併帳套別跳頁

   LET l_sql="   SELECT DISTINCT gldcld ",
             "     FROM gldc_t ",
             "    WHERE 1=1  AND ", g_wc3 ,
             " ORDER BY gldcld   "      
   
   PREPARE aglq930_pr FROM l_sql
   DECLARE aglq930_cr CURSOR FOR aglq930_pr      
   LET l_idx=1  
   FOREACH aglq930_cr INTO g_gldc_d[l_idx].gldcld
      IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = 'FOREACH aapq932_cr'
           LET g_errparam.popup = FALSE
           CALL cl_err()
           EXIT FOREACH
      END IF
      IF l_idx > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
         EXIT FOREACH
      END IF
      IF cl_null(g_gldc_d[l_idx].gldcld) THEN
         CALL g_gldc_d.deleteElement(l_idx)
      ELSE
         LET l_idx=l_idx+1
      END IF        
    
   END FOREACH 
   
   LET l_idx = l_idx - 1
   CALL g_gldc_d.deleteElement(g_gldc_d.getLength())
   LET g_header_cnt = g_gldc_d.getLength()
   LET g_rec_b = l_idx   
   DISPLAY g_header_cnt TO FORMONLY.h_count     
END FUNCTION

################################################################################
# Descriptions...: 資料所在筆數
# Memo...........:
# Usage..........: CALL aglq930_fetch1(p_flag)
# Date & Author..: 2015/12/18 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq930_fetch1(p_flag)
DEFINE p_flag   LIKE type_t.chr1
DEFINE ls_msg     STRING

   IF g_header_cnt = 0 THEN
      RETURN
   END IF

   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'L' LET g_current_idx = g_header_cnt
      WHEN 'P'
         IF g_current_idx > 1 THEN
            LET g_current_idx = g_current_idx - 1
         END IF
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF

      WHEN '/'
         IF (NOT g_no_ask) THEN
            CALL cl_set_act_visible("accept,cancel", TRUE)
            CALL cl_getmsg('fetch',g_dlang) RETURNING ls_msg
            LET INT_FLAG = 0

            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT
             
            CALL cl_set_act_visible("accept,cancel", FALSE)
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE
            END IF
         END IF

         IF g_jump > 0 AND g_jump <= g_gldc_d.getLength() THEN
             LET g_current_idx = g_jump
         END IF

         LET g_no_ask = FALSE
   END CASE
   #代表沒有資料
   IF g_current_idx = 0 OR g_gldc_d.getLength() = 0 THEN
      RETURN
   END IF

   #超出範圍
   IF g_current_idx > g_gldc_d.getLength() THEN
      LET g_current_idx = g_gldc_d.getLength()
   END IF
   
   DISPLAY g_current_idx TO FORMONLY.h_index                                 
   LET g_gldcld = g_gldc_d[g_current_idx].gldcld
   
   CALL aglq930_b_fill()        
END FUNCTION

################################################################################
# Descriptions...: 取得目前編制進度
# Memo...........:
# Usage..........: CALL aglq930_get_glec005(p_glecld,p_glec001)
# Date & Author..: 2016/01/04 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq930_get_glec005(p_glecld,p_glec001)
DEFINE p_glecld       LIKE glec_t.glecld
DEFINE p_glec001      LIKE glec_t.glec001
DEFINE r_glec005      LIKE type_t.chr500



   LET r_glec005 = ''

   SELECT DISTINCT glec005 INTO r_glec005
     FROM glec_t 
    WHERE glecent = g_enterprise
      AND glecld  = p_glecld
      AND glec001 = p_glec001
      AND glec004 =  (SELECT MAX(glec004) FROM glec_t
                         WHERE glecent = g_enterprise
                           AND glecld = p_glecld
                           AND glec001 = p_glec001) 
                                             
                        
   IF cl_null(r_glec005) THEN LET r_glec005 = '0' END IF
   
   RETURN r_glec005
   
END FUNCTION

################################################################################
# Descriptions...: 樣板代號說明
# Memo...........:
# Usage..........: CALL aglq930_glfa001_ref(p_glfa001)
# Date & Author..: 2015/01/04 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq930_glfa001_ref(p_glfa001)
DEFINE p_glfa001       LIKE glfa_t.glfa001
DEFINE r_glfa001_desc  LIKE type_t.chr100


   LET r_glfa001_desc = ''
   SELECT glfal003 INTO r_glfa001_desc FROM glfal_t
    WHERE glfalent = g_enterprise
      AND glfal001 = p_glfa001
      AND glfal002 = g_dlang
    
    RETURN r_glfa001_desc

END FUNCTION

 
{</section>}
 
