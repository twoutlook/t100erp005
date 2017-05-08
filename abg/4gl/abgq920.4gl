#該程式未解開Section, 採用最新樣板產出!
{<section id="abgq920.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-12-13 10:35:32), PR版次:0002(2017-01-10 16:32:35)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgq920
#+ Description: 應收應付查詢
#+ Creator....: 06821(2016-12-12 11:00:02)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="abgq920.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#170104-00017#3   170106  By 06821    1.預算細項區分應收付時以 bgae008 預算分類為 key值區分 2.條件無發生應收付, 但有期初金額時仍應顯示期初金額
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
PRIVATE TYPE type_g_bgie_d RECORD
       #statepic       LIKE type_t.chr1,
       
       bgieseq LIKE bgie_t.bgieseq, 
   bgie003 LIKE bgie_t.bgie003, 
   bgie003_1_desc LIKE type_t.chr100, 
   bgie004 LIKE bgie_t.bgie004, 
   bgie004_desc LIKE type_t.chr100, 
   bgie007 LIKE bgie_t.bgie007, 
   bgie007_desc LIKE type_t.chr100, 
   bgie008 LIKE bgie_t.bgie008, 
   bgie008_desc LIKE type_t.chr100, 
   bgie009 LIKE bgie_t.bgie009, 
   bgie009_desc LIKE type_t.chr10, 
   bgie010 LIKE bgie_t.bgie010, 
   bgie010_desc LIKE type_t.chr100, 
   bgie011 LIKE bgie_t.bgie011, 
   bgie011_desc LIKE type_t.chr100, 
   bgie012 LIKE bgie_t.bgie012, 
   bgie012_desc LIKE type_t.chr100, 
   bgie013 LIKE bgie_t.bgie013, 
   bgie013_desc LIKE type_t.chr100, 
   bgie014 LIKE bgie_t.bgie014, 
   bgie014_desc LIKE type_t.chr100, 
   bgie015 LIKE bgie_t.bgie015, 
   bgie015_desc LIKE type_t.chr100, 
   bgie016 LIKE bgie_t.bgie016, 
   bgie016_desc LIKE type_t.chr100, 
   bgie017 LIKE bgie_t.bgie017, 
   bgie018 LIKE bgie_t.bgie018, 
   bgie018_desc LIKE type_t.chr10, 
   bgie019 LIKE bgie_t.bgie019, 
   bgie019_desc LIKE type_t.chr100, 
   bgie100 LIKE bgie_t.bgie100, 
   l_begin_amt LIKE type_t.num20_6, 
   l_bgie103_d LIKE type_t.num20_6, 
   l_bgie103_c LIKE type_t.num20_6, 
   l_sum LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
PRIVATE TYPE type_g_bgie2_d RECORD
   bgieseq        LIKE bgie_t.bgieseq, 
   bgie003        LIKE bgie_t.bgie003, 
   bgie003_2_desc LIKE type_t.chr100, 
   l_begin_amt1   LIKE type_t.num20_6,
   l_amt_1        LIKE type_t.num20_6, 
   l_amt_2        LIKE type_t.num20_6, 
   l_amt_3        LIKE type_t.num20_6, 
   l_amt_4        LIKE type_t.num20_6, 
   l_amt_5        LIKE type_t.num20_6, 
   l_amt_6        LIKE type_t.num20_6, 
   l_amt_7        LIKE type_t.num20_6, 
   l_amt_8        LIKE type_t.num20_6, 
   l_amt_9        LIKE type_t.num20_6, 
   l_amt_10       LIKE type_t.num20_6, 
   l_amt_11       LIKE type_t.num20_6, 
   l_amt_12       LIKE type_t.num20_6, 
   l_amt_13       LIKE type_t.num20_6, 
   l_amt_14       LIKE type_t.num20_6, 
   l_amt_sum      LIKE type_t.num20_6
                  END RECORD
DEFINE g_bgie2_d   DYNAMIC ARRAY OF type_g_bgie2_d

#單頭欄位定義
PRIVATE TYPE type_input  RECORD
         bgie001         LIKE bgie_t.bgie001,   
         bgie001_desc    LIKE type_t.chr100,   
         bgie002         LIKE bgie_t.bgie002, 
         bgie003         LIKE bgie_t.bgie003, 
         bgie003_desc    LIKE type_t.chr100, 
         l_lowersite     LIKE type_t.chr1,
         l_bgie033       LIKE type_t.chr1,   
         l_bgap004       LIKE type_t.chr1,
         l_bgaa003       LIKE bgaa_t.bgaa003,
         l_curr          LIKE type_t.chr1,
         l_periods       LIKE type_t.chr1,   
         hsx_bgie004     LIKE type_t.chr1, #核算項顯示否 --s
         hsx_bgie007     LIKE type_t.chr1,
         hsx_bgie008     LIKE type_t.chr1,
         hsx_bgie009     LIKE type_t.chr1,
         hsx_bgie010     LIKE type_t.chr1,
         hsx_bgie011     LIKE type_t.chr1,
         hsx_bgie012     LIKE type_t.chr1,
         hsx_bgie013     LIKE type_t.chr1,
         hsx_bgie014     LIKE type_t.chr1,
         hsx_bgie015     LIKE type_t.chr1,
         hsx_bgie016     LIKE type_t.chr1,
         hsx_bgie017     LIKE type_t.chr1,
         hsx_bgie018     LIKE type_t.chr1,
         hsx_bgie019     LIKE type_t.chr1  #核算項顯示否 --e
                         END RECORD
#展組織樹欄位定義         
DEFINE g_tree_idx        LIKE type_t.num10
DEFINE g_tree            DYNAMIC ARRAY OF RECORD
         show            LIKE type_t.chr100,    #外顯欄位
         pid             LIKE type_t.chr100,    #父節點id
         id              LIKE type_t.chr100,    #本身節點id
         exp             LIKE type_t.chr100,    #是否展開
         hasC            LIKE type_t.num5,      #是否有子節點
         isExp           LIKE type_t.num5,      #是否已展開
         expcode         LIKE type_t.num5,      #展開值
         bgie035         LIKE bgie_t.bgie035,   #KEY1
         bgie003         LIKE bgie_t.bgie003    #KEY1
                         END RECORD
DEFINE g_tree_pid        LIKE type_t.chr100      
DEFINE g_wc3             STRING
DEFINE g_input           type_input
DEFINE g_input_o         type_input
#資料瀏覽之欄位           
DEFINE g_bgie            DYNAMIC ARRAY OF RECORD
         bgie003         LIKE bgie_t.bgie003
      END RECORD        
      
DEFINE g_hsx_wc          STRING  
DEFINE g_select_field    STRING  
DEFINE g_forselect_field STRING
DEFINE g_doselect_field  STRING

DEFINE g_bgie003         STRING 
DEFINE g_bgie035         LIKE bgie_t.bgie035
DEFINE g_flag            LIKE type_t.num5     #紀錄是否為根節點
DEFINE g_detail_idx3     LIKE type_t.num10
DEFINE g_xgrid_visible_column  STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_bgie_d
DEFINE g_master_t                   type_g_bgie_d
DEFINE g_bgie_d          DYNAMIC ARRAY OF type_g_bgie_d
DEFINE g_bgie_d_t        type_g_bgie_d
 
      
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
 
{<section id="abgq920.main" >}
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
   CALL cl_ap_init("abg","")
 
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
   DECLARE abgq920_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abgq920_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgq920_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgq920 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgq920_init()   
 
      #進入選單 Menu (="N")
      CALL abgq920_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      DROP TABLE abgq920_tmp;
      DROP TABLE abgq920_currtmp;
      DROP TABLE abgq920_x01_tmp;
      DROP TABLE abgq920_x01_tmp1;
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgq920
      
   END IF 
   
   CLOSE abgq920_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgq920.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION abgq920_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   LET g_detail_idx3 = 1
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL abgq920_default()
   CALL abgq920_creat_temp()
   #end add-point
 
   CALL abgq920_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="abgq920.default_search" >}
PRIVATE FUNCTION abgq920_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " bgiedocno = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " bgieseq = '", g_argv[02], "' AND "
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
 
{<section id="abgq920.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION abgq920_ui_dialog()
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
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx3 = 1
   END IF
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL abgq920_b_fill()
   ELSE
      CALL abgq920_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_bgie_d.clear()
 
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
 
         CALL abgq920_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_bgie_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL abgq920_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL abgq920_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_bgie_d.getLength() TO FORMONLY.h_count               
               #show 第二單身
               IF g_detail_idx > 0 THEN
                  CALL g_bgie2_d.clear() 
                  CALL abgq920_b_fill2(g_detail_idx)
               END IF      
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #第二單身ARRAY
         DISPLAY ARRAY g_bgie2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt2)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index               
              
               DISPLAY g_bgie2_d.getLength() TO FORMONLY.h_count
               CALL abgq920_fetch()
               LET g_master_idx = l_ac
 
         END DISPLAY
         
         #組織樹ARRAY
         DISPLAY ARRAY g_tree TO s_detail3.* ATTRIBUTES(COUNT=g_tree_idx)
            BEFORE ROW        
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx3
               DISPLAY g_detail_idx3 TO FORMONLY.h_index                   
               CALL abgq920_tree_fetch(l_ac)
               IF NOT cl_null(g_bgie003) THEN
                  CALL abgq920_b_fill()
               END IF
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL abgq920_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
 
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL abgq920_print()
               CALL abgq920_x01('1=1','abgq920_x01_tmp','abgq920_x01_tmp1',g_xgrid_visible_column) 
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL abgq920_print()
               CALL abgq920_x01('1=1','abgq920_x01_tmp','abgq920_x01_tmp1',g_xgrid_visible_column) 
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgq920_query()
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
            CALL abgq920_filter()
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
            CALL abgq920_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_bgie_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_bgie2_d)
               LET g_export_id[2]   = "s_detail2"
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
            CALL abgq920_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL abgq920_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL abgq920_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL abgq920_b_fill()
 
         
         
 
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
 
{<section id="abgq920.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION abgq920_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_site_str  STRING
   DEFINE l_bgaa006   LIKE bgaa_t.bgaa006
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   CALL g_bgie2_d.clear()
   LET g_detail_idx3 = 1
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_bgie_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON bgie004
           FROM s_detail1[1].b_bgie004
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_bgieseq>>----
         #----<<bgie003_1_desc>>----
         #----<<b_bgie004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bgie004
            #add-point:BEFORE FIELD b_bgie004 name="construct.b.page1.b_bgie004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bgie004
            
            #add-point:AFTER FIELD b_bgie004 name="construct.a.page1.b_bgie004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_bgie004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bgie004
            #add-point:ON ACTION controlp INFIELD b_bgie004 name="construct.c.page1.b_bgie004"
            
            #END add-point
 
 
         #----<<bgie004_desc>>----
         #----<<b_bgie007>>----
         #----<<bgie007_desc>>----
         #----<<b_bgie008>>----
         #----<<bgie008_desc>>----
         #----<<b_bgie009>>----
         #----<<bgie009_desc>>----
         #----<<b_bgie010>>----
         #----<<bgie010_desc>>----
         #----<<b_bgie011>>----
         #----<<bgie011_desc>>----
         #----<<b_bgie012>>----
         #----<<bgie012_desc>>----
         #----<<b_bgie013>>----
         #----<<bgie013_desc>>----
         #----<<b_bgie014>>----
         #----<<bgie014_desc>>----
         #----<<b_bgie015>>----
         #----<<bgie015_desc>>----
         #----<<b_bgie016>>----
         #----<<bgie016_desc>>----
         #----<<b_bgie017>>----
         #----<<b_bgie018>>----
         #----<<bgie018_desc>>----
         #----<<b_bgie019>>----
         #----<<bgie019_desc>>----
         #----<<b_bgie100>>----
         #----<<l_begin_amt>>----
         #----<<l_bgie103_d>>----
         #----<<l_bgie103_c>>----
         #----<<l_sum>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      #QBE
      CONSTRUCT BY NAME g_wc3 ON bgie011,bgie004
         BEFORE CONSTRUCT

         ON ACTION controlp INFIELD bgie011
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgapstus = 'Y' "
            CALL q_bgap001() 
            DISPLAY g_qryparam.return1 TO bgie011      #顯示到畫面上
            NEXT FIELD bgie011                         #返回原欄位       

         
         ON ACTION controlp INFIELD bgie004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgae006 IN (SELECT bgaa008 FROM bgaa_t ",
                                   "              WHERE bgaaent = ",g_enterprise,
                                   "                AND bgaa001 = '",g_input.bgie001,"') "   #存在預算編號的預算項目參照表          
            CALL q_bgae001()
            DISPLAY g_qryparam.return1 TO bgie004
            NEXT FIELD bgie004         
      END CONSTRUCT 
      
      #INPUT
      INPUT g_input.bgie001,g_input.bgie001_desc,g_input.bgie002,g_input.bgie003,
            g_input.bgie003_desc,g_input.l_lowersite,g_input.l_bgie033,g_input.l_bgap004,
            g_input.l_bgaa003,g_input.l_curr,g_input.l_periods,g_input.hsx_bgie004,
            g_input.hsx_bgie007,g_input.hsx_bgie008,g_input.hsx_bgie009,g_input.hsx_bgie010,
            g_input.hsx_bgie011,g_input.hsx_bgie012,g_input.hsx_bgie013,g_input.hsx_bgie014,
            g_input.hsx_bgie015,g_input.hsx_bgie016,g_input.hsx_bgie017,g_input.hsx_bgie018,
            g_input.hsx_bgie019 
       FROM b_bgie001,bgie001_desc,b_bgie002,b_bgie003,
            bgie003_desc,l_lowersite,l_bgie033,l_bgap004,
            l_bgaa003,l_curr,l_periods,hsx_bgie004,
            hsx_bgie007,hsx_bgie008,hsx_bgie009,hsx_bgie010,
            hsx_bgie011,hsx_bgie012,hsx_bgie013,hsx_bgie014,
            hsx_bgie015,hsx_bgie016,hsx_bgie017,hsx_bgie018,
            hsx_bgie019 
         ATTRIBUTE(WITHOUT DEFAULTS)

         AFTER FIELD b_bgie001
            LET g_input.bgie001_desc = ''
            DISPLAY BY NAME g_input.bgie001_desc
            IF NOT cl_null(g_input.bgie001) THEN
               IF g_input.bgie001 != g_input_o.bgie001 OR cl_null(g_input_o.bgie001) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_input.bgie001
                  LET g_errshow = TRUE
                  LET g_chkparam.err_str[1] = "abg-00008:sub-01302|abgi010|",cl_get_progname("abgi010",g_lang,"2"),"|:EXEPROGabgi010"
                  IF cl_chk_exist("v_bgaa001") THEN
                     #是否使用預測
                     LET l_bgaa006 = ''
                     SELECT bgaa006 INTO l_bgaa006 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_input.bgie001 AND bgaastus = 'Y'
                     IF l_bgaa006 <> '1' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'abg-00292'
                        LET g_errparam.extend = g_input.bgie001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_input.bgie001 = g_input_o.bgie001
                        CALL s_desc_get_budget_desc(g_input.bgie001) RETURNING g_input.bgie001_desc
                        DISPLAY BY NAME g_input.bgie001_desc
                        NEXT FIELD CURRENT
                     END IF                  
                  
                     IF NOT cl_null(g_input.bgie003) THEN
                        CALL s_abg2_bgai004_chk(g_input.bgie001,'',g_input.bgie003,'')
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = g_input.bgie001," + ",g_input.bgie003
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_input.bgie001 = g_input_o.bgie001
                           CALL s_desc_get_budget_desc(g_input.bgie001) RETURNING g_input.bgie001_desc
                           DISPLAY BY NAME g_input.bgie001_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     LET g_input.bgie001 = g_input_o.bgie001
                     CALL s_desc_get_budget_desc(g_input.bgie001) RETURNING g_input.bgie001_desc
                     DISPLAY BY NAME g_input.bgie001_desc
                     NEXT FIELD CURRENT
                  END IF
                  #預算幣別
                  LET g_input.l_bgaa003 = ''
                  SELECT bgaa003 INTO g_input.l_bgaa003 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_input.bgie001
                  DISPLAY g_input.l_bgaa003 TO l_bgaa003                  
               END IF                
            END IF                
            CALL s_desc_get_budget_desc(g_input.bgie001) RETURNING g_input.bgie001_desc
            DISPLAY BY NAME g_input.bgie001_desc       
            LET g_input_o.* = g_input.*          
      
         ON ACTION controlp INFIELD b_bgie001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.bgie001
            LET g_qryparam.where = "bgaastus = 'Y' AND bgaa006 = '1' "   #使用預測才可以開 
            CALL q_bgaa001()
            LET g_input.bgie001 = g_qryparam.return1
            DISPLAY g_input.bgie001 TO b_bgie001
            NEXT FIELD b_bgie001
            
         AFTER FIELD b_bgie003
            #預算組織
            LET g_input.bgie003_desc = ''
            DISPLAY BY NAME g_input.bgie003_desc
            IF NOT cl_null(g_input.bgie003) THEN
               IF g_input.bgie003 != g_input_o.bgie003 OR cl_null(g_input_o.bgie003) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_input.bgie003
                  LET g_errshow = TRUE
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  IF NOT cl_chk_exist("v_ooef001_24") THEN
                     LET g_input.bgie003 = g_input_o.bgie003
                     CALL s_desc_get_department_desc(g_input.bgie003) RETURNING g_input.bgie003_desc
                     DISPLAY BY NAME g_input.bgie003_desc
                     NEXT FIELD CURRENT
                  END IF

                  CALL s_abg2_bgai004_chk(g_input.bgie001,'',g_input.bgie003,'')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_input.bgie003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.bgie003 = g_input_o.bgie003
                     CALL s_desc_get_department_desc(g_input.bgie003) RETURNING g_input.bgie003_desc
                     DISPLAY BY NAME g_input.bgie003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_input.bgie003_desc = s_desc_get_department_desc(g_input.bgie003)
            DISPLAY BY NAME g_input.bgie003_desc
            LET g_input_o.* = g_input.*
      
         ON ACTION controlp INFIELD b_bgie003
            #預算組織
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.bgie003
            LET g_qryparam.where = " ooef001 IN (SELECT bgaj002 FROM bgaj_t ",
                                   "              WHERE bgajent = ooefent AND bgajent = ",g_enterprise,
                                   "                AND bgaj001 = '",g_input.bgie001,"' AND bgajstus = 'Y') "
            CALL s_abg2_get_budget_site(g_input.bgie001,'',g_user,'') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            LET g_qryparam.where = g_qryparam.where CLIPPED," AND ooef001 IN ",l_site_str
            CALL q_ooef001()
            LET g_input.bgie003 = g_qryparam.return1
            DISPLAY g_input.bgie003 TO b_bgie003
            NEXT FIELD b_bgie003       
            
         AFTER INPUT
            CALL abgq920_set_title()          
            
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
         CALL abgq920_default()
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
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
   CALL abgq920_grow_tree()
   CALL abgq920_tree_fetch('1')   
   #end add-point
        
   LET g_error_show = 1
   CALL abgq920_b_fill()
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
 
{<section id="abgq920.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgq920_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   #DEFINE l_bgae002       LIKE bgae_t.bgae002   #170104-00017#3 mark
   DEFINE l_bgaa008       LIKE bgaa_t.bgaa008
   DEFINE l_bgie003_str   STRING
   DEFINE l_sql           STRING
   DEFINE l_bgie100_cur   LIKE bgie_t.bgie100
   DEFINE l_begin_amt_cur LIKE bgie_t.bgie103
   DEFINE l_bgie103_d_cur LIKE bgie_t.bgie103
   DEFINE l_bgie103_c_cur LIKE bgie_t.bgie103
   DEFINE l_sum_cur       LIKE bgie_t.bgie103  
   DEFINE l_n             LIKE type_t.num10  
   DEFINE l_bg_sql        STRING               #170104-00017#3 add
   DEFINE l_bgie033_str   STRING               #170104-00017#3 add
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #如不展下層,則直接展畫面上預算組織
   IF g_input.l_lowersite = 'N' THEN
      LET l_bgie003_str = g_input.bgie003
      LET g_bgie003 = g_input.bgie003
   END IF
   
   #組合組織條件
   IF cl_null(g_bgie003) THEN 
      CALL abgq920_tree_fetch('1')
   END IF
   LET l_bgie003_str = "('",g_bgie003,"')" 
   
   #使用預算細項參照表
   LET l_bgaa008 = ''
   SELECT bgaa008 INTO l_bgaa008 FROM bgaa_t 
    WHERE bgaaent = g_enterprise AND bgaa001 = g_input.bgie001 AND bgaastus = 'Y'
   
   #QBE 條件
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
   LET g_hsx_wc = g_hsx_wc.trim()
   LET g_hsx_wc = cl_replace_str(g_hsx_wc,'1=1,','')
   LET g_hsx_wc = cl_replace_str(g_hsx_wc,'1=1','')  #170104-00017#3 add 表示核算項都沒有勾的情況,逗號也不要

   #170104-00017#3 --s add
   #期初金額
   IF g_input.l_bgie033 = '1' THEN
      LET l_bgie033_str = " bgae008 = '71' " #1.AR應收
   ELSE
      LET l_bgie033_str = " bgae008 = '72' " #2.AP應付
   END IF    
   LET l_bg_sql = " SELECT CASE '",g_input.l_curr,"' WHEN '1' THEN SUM(bgbj032) ELSE SUM(bgbj033) END FROM bgbj_t ",
                  "  WHERE bgbjent = ",g_enterprise," AND bgbj001 = '",g_input.bgie001,"' ",
                  "    AND bgbj002 = ? ",
                  "    AND bgbj003 IN (SELECT bgae001 FROM bgae_t WHERE bgaeent = ",g_enterprise," ",
                  "                       AND bgae006 = (SELECT bgaa008 FROM bgaa_t  WHERE bgaaent = ",g_enterprise," ",
                  "                                         AND bgaa001 = '",g_input.bgie001,"' AND bgaastus = 'Y') AND ",l_bgie033_str,") ",
                  "    AND bgbj028 = ? "
   PREPARE b_fill_get_bg FROM l_bg_sql
   #170104-00017#3 --e add
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
 
   LET ls_sql_rank = "SELECT  UNIQUE bgieseq,'','',bgie004,'',bgie007,'',bgie008,'',bgie009,'',bgie010, 
       '',bgie011,'',bgie012,'',bgie013,'',bgie014,'',bgie015,'',bgie016,'',bgie017,bgie018,'',bgie019, 
       '',bgie100,'','','',''  ,DENSE_RANK() OVER( ORDER BY bgie_t.bgiedocno,bgie_t.bgieseq) AS RANK FROM bgie_t", 
 
 
 
                     "",
                     " WHERE bgieent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("bgie_t"),
                     " ORDER BY bgie_t.bgiedocno,bgie_t.bgieseq"
 
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
 
   LET g_sql = "SELECT bgieseq,'','',bgie004,'',bgie007,'',bgie008,'',bgie009,'',bgie010,'',bgie011, 
       '',bgie012,'',bgie013,'',bgie014,'',bgie015,'',bgie016,'',bgie017,bgie018,'',bgie019,'',bgie100, 
       '','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   CALL abgq920_insert_temp()
   
   LET g_sql = "  SELECT ",g_doselect_field," ",
               "    FROM (SELECT ",g_forselect_field," FROM abgq920_tmp ",
               "           WHERE bgieent = ? AND bgie003 IN ",l_bgie003_str,"  ",
               "           GROUP BY bgie003,bgie004,bgie007,bgie008,bgie009,bgie010,bgie011,bgie012,  ",
               "                    bgie013,bgie014,bgie015,bgie016,bgie017,bgie018,bgie019,bgie100 ) "
               #170104-00017#3 --s mark
               #"   GROUP BY ",g_hsx_wc,",bgie100 ",
               #"   ORDER BY ",g_hsx_wc,",bgie100 "                
               #170104-00017#3 --e mark
               
   #170104-00017#3 --s add
   IF NOT cl_null(g_hsx_wc) THEN                
      LET g_sql = g_sql," GROUP BY ",g_hsx_wc,",bgie100 ",
                        " ORDER BY ",g_hsx_wc,",bgie100 "      
   ELSE
      LET g_sql = g_sql," GROUP BY bgie100 ",
                        " ORDER BY bgie100 "
   END IF
   #170104-00017#3 --e add
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE abgq920_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR abgq920_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_bgie_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_bgie2_d.clear() 
   DELETE FROM abgq920_currtmp
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_bgie_d[l_ac].bgieseq,g_bgie_d[l_ac].bgie003,g_bgie_d[l_ac].bgie003_1_desc, 
       g_bgie_d[l_ac].bgie004,g_bgie_d[l_ac].bgie004_desc,g_bgie_d[l_ac].bgie007,g_bgie_d[l_ac].bgie007_desc, 
       g_bgie_d[l_ac].bgie008,g_bgie_d[l_ac].bgie008_desc,g_bgie_d[l_ac].bgie009,g_bgie_d[l_ac].bgie009_desc, 
       g_bgie_d[l_ac].bgie010,g_bgie_d[l_ac].bgie010_desc,g_bgie_d[l_ac].bgie011,g_bgie_d[l_ac].bgie011_desc, 
       g_bgie_d[l_ac].bgie012,g_bgie_d[l_ac].bgie012_desc,g_bgie_d[l_ac].bgie013,g_bgie_d[l_ac].bgie013_desc, 
       g_bgie_d[l_ac].bgie014,g_bgie_d[l_ac].bgie014_desc,g_bgie_d[l_ac].bgie015,g_bgie_d[l_ac].bgie015_desc, 
       g_bgie_d[l_ac].bgie016,g_bgie_d[l_ac].bgie016_desc,g_bgie_d[l_ac].bgie017,g_bgie_d[l_ac].bgie018, 
       g_bgie_d[l_ac].bgie018_desc,g_bgie_d[l_ac].bgie019,g_bgie_d[l_ac].bgie019_desc,g_bgie_d[l_ac].bgie100, 
       g_bgie_d[l_ac].l_begin_amt,g_bgie_d[l_ac].l_bgie103_d,g_bgie_d[l_ac].l_bgie103_c,g_bgie_d[l_ac].l_sum 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_bgie_d[l_ac].statepic = cl_get_actipic(g_bgie_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #項次
      LET g_bgie_d[l_ac].bgieseq = l_ac

      #組織
      IF g_flag THEN
         LET g_bgie_d[l_ac].bgie003 = g_bgie035
      ELSE
         LET g_bgie_d[l_ac].bgie003 = g_bgie003
      END IF
      
      #170104-00017#3 --s add
      IF cl_null(g_hsx_wc) THEN 
         LET g_bgie_d[l_ac].l_begin_amt = 0
         EXECUTE b_fill_get_bg USING g_bgie_d[l_ac].bgie003,g_bgie_d[l_ac].bgie100 
            INTO g_bgie_d[l_ac].l_begin_amt
      END IF
      IF cl_null(g_bgie_d[l_ac].l_begin_amt) THEN LET g_bgie_d[l_ac].l_begin_amt = 0 END IF
      #170104-00017#3 --e add
      
      #餘額
      #170104-00017#3 --s mark
      #LET l_bgae002 = ''  #借貸方向 1.借方 2.貸方
      #SELECT bgae002 INTO l_bgae002
      #  FROM bgae_t
      # WHERE bgaeent = g_enterprise 
      #   AND bgae006 = (SELECT bgaa008 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_input.bgie001 AND bgaastus = 'Y')
      #   AND bgae001 = g_bgie_d[l_ac].bgie004
      #   
      #IF l_bgae002 = '1' THEN
      #   LET g_bgie_d[l_ac].l_bgie103_c = g_bgie_d[l_ac].l_bgie103_c * -1
      #   LET g_bgie_d[l_ac].l_sum = g_bgie_d[l_ac].l_begin_amt + g_bgie_d[l_ac].l_bgie103_d + g_bgie_d[l_ac].l_bgie103_c
      #ELSE
      #   LET g_bgie_d[l_ac].l_bgie103_d = g_bgie_d[l_ac].l_bgie103_d * -1
      #170104-00017#3 --e mark
         LET g_bgie_d[l_ac].l_sum = g_bgie_d[l_ac].l_begin_amt + g_bgie_d[l_ac].l_bgie103_d + g_bgie_d[l_ac].l_bgie103_c
      #END IF   #170104-00017#3 mark
      
      LET g_bgie_d[l_ac].bgie003_1_desc = s_desc_get_department_desc(g_bgie_d[l_ac].bgie003)
      
      ####核算項  -------------s
      #預算細項
      CALL s_abg_bgae001_desc(l_bgaa008,g_bgie_d[l_ac].bgie004) RETURNING g_bgie_d[l_ac].bgie004_desc  
      LET g_bgie_d[l_ac].bgie004_desc = s_desc_show1(g_bgie_d[l_ac].bgie004,g_bgie_d[l_ac].bgie004_desc)   
      #人員
      CALL s_desc_get_person_desc(g_bgie_d[l_ac].bgie007) RETURNING g_bgie_d[l_ac].bgie007_desc
      LET g_bgie_d[l_ac].bgie007_desc = s_desc_show1(g_bgie_d[l_ac].bgie007,g_bgie_d[l_ac].bgie007_desc)
      #部門
      CALL s_desc_get_department_desc(g_bgie_d[l_ac].bgie008) RETURNING g_bgie_d[l_ac].bgie008_desc
      LET g_bgie_d[l_ac].bgie008_desc = s_desc_show1(g_bgie_d[l_ac].bgie008,g_bgie_d[l_ac].bgie008_desc)
      #成本利潤中心
      CALL s_desc_get_department_desc(g_bgie_d[l_ac].bgie009) RETURNING g_bgie_d[l_ac].bgie009_desc
      LET g_bgie_d[l_ac].bgie009_desc = s_desc_show1(g_bgie_d[l_ac].bgie009,g_bgie_d[l_ac].bgie009_desc)
      #區域
      CALL s_desc_get_acc_desc('287',g_bgie_d[l_ac].bgie010) RETURNING g_bgie_d[l_ac].bgie010_desc
      LET g_bgie_d[l_ac].bgie010_desc = s_desc_show1(g_bgie_d[l_ac].bgie010,g_bgie_d[l_ac].bgie010_desc)
      #收付款客商
      CALL s_desc_get_bgap001_desc(g_bgie_d[l_ac].bgie011) RETURNING g_bgie_d[l_ac].bgie011_desc
      LET g_bgie_d[l_ac].bgie011_desc = s_desc_show1(g_bgie_d[l_ac].bgie011,g_bgie_d[l_ac].bgie011_desc)
      #收款客商
      CALL s_desc_get_bgap001_desc(g_bgie_d[l_ac].bgie012) RETURNING g_bgie_d[l_ac].bgie012_desc
      LET g_bgie_d[l_ac].bgie012_desc = s_desc_show1(g_bgie_d[l_ac].bgie012,g_bgie_d[l_ac].bgie012_desc)
      #客群
      CALL s_desc_get_acc_desc('281',g_bgie_d[l_ac].bgie013) RETURNING g_bgie_d[l_ac].bgie013_desc
      LET g_bgie_d[l_ac].bgie013_desc = s_desc_show1(g_bgie_d[l_ac].bgie013,g_bgie_d[l_ac].bgie013_desc)
      #產品類別
      CALL s_desc_get_rtaxl003_desc(g_bgie_d[l_ac].bgie014) RETURNING g_bgie_d[l_ac].bgie014_desc
      LET g_bgie_d[l_ac].bgie014_desc = s_desc_show1(g_bgie_d[l_ac].bgie014,g_bgie_d[l_ac].bgie014_desc)
      #專案編號
      CALL s_desc_get_project_desc(g_bgie_d[l_ac].bgie015) RETURNING g_bgie_d[l_ac].bgie015_desc
      LET g_bgie_d[l_ac].bgie015_desc = s_desc_show1(g_bgie_d[l_ac].bgie015,g_bgie_d[l_ac].bgie015_desc)
      #WBS
      CALL s_desc_get_wbs_desc(g_bgie_d[l_ac].bgie015,g_bgie_d[l_ac].bgie016) RETURNING g_bgie_d[l_ac].bgie016_desc
      LET g_bgie_d[l_ac].bgie016_desc = s_desc_show1(g_bgie_d[l_ac].bgie016,g_bgie_d[l_ac].bgie016_desc)
      #經營方式
      LET g_bgie_d[l_ac].bgie017 = g_bgie_d[l_ac].bgie017
      #通路
      CALL s_desc_get_oojdl003_desc(g_bgie_d[l_ac].bgie018) RETURNING g_bgie_d[l_ac].bgie018_desc
      LET g_bgie_d[l_ac].bgie018_desc = s_desc_show1(g_bgie_d[l_ac].bgie018,g_bgie_d[l_ac].bgie018_desc)
      #品牌
      CALL s_desc_get_acc_desc('2002',g_bgie_d[l_ac].bgie019) RETURNING g_bgie_d[l_ac].bgie019_desc
      LET g_bgie_d[l_ac].bgie019_desc = s_desc_show1(g_bgie_d[l_ac].bgie019,g_bgie_d[l_ac].bgie019_desc)
      ####-------------e
      
      #小計
      INSERT INTO abgq920_currtmp 
           VALUES(g_bgie_d[l_ac].bgie100,g_bgie_d[l_ac].l_begin_amt,g_bgie_d[l_ac].l_bgie103_d,
                  g_bgie_d[l_ac].l_bgie103_c,g_bgie_d[l_ac].l_sum)      
      #end add-point
 
      CALL abgq920_detail_show("'1'")      
 
      CALL abgq920_bgie_t_mask()
 
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
   
 
   
   CALL g_bgie_d.deleteElement(g_bgie_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   IF g_bgie_d.getLength() > 0 THEN    
      LET l_bgie100_cur = 0
      LET l_begin_amt_cur = 0 
      LET l_bgie103_d_cur = 0
      LET l_bgie103_c_cur = 0
      LET l_sum_cur = 0    
      LET l_sql = "  SELECT bgie100,SUM(l_begin_amt),SUM(l_bgie103_d),SUM(l_bgie103_c),SUM(l_sum) ",
                  "    FROM abgq920_currtmp ",
                  "   GROUP BY bgie100 ",
                  "   ORDER BY bgie100 "    
      PREPARE abgq920_currsum_p FROM l_sql
      DECLARE abgq920_currsum_c CURSOR FOR abgq920_currsum_p                    
      FOREACH abgq920_currsum_c INTO l_bgie100_cur,l_begin_amt_cur,l_bgie103_d_cur,l_bgie103_c_cur,l_sum_cur
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:abgq920_currsum_c"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF 
         
         LET g_bgie_d[l_ac].bgie003_1_desc = cl_getmsg('aap-00287',g_lang)
         LET g_bgie_d[l_ac].bgie100 = l_bgie100_cur
         LET g_bgie_d[l_ac].l_begin_amt = l_begin_amt_cur
         LET g_bgie_d[l_ac].l_bgie103_d = l_bgie103_d_cur
         LET g_bgie_d[l_ac].l_bgie103_c = l_bgie103_c_cur
         LET g_bgie_d[l_ac].l_sum = l_sum_cur
         LET l_ac = l_ac + 1
      END FOREACH
   END IF
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
 
   #end add-point
 
   LET g_detail_cnt = g_bgie_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE abgq920_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL abgq920_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL abgq920_detail_action_trans()
 
   IF g_bgie_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL abgq920_fetch()
   END IF
   
      CALL abgq920_filter_show('bgie004','b_bgie004')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   #show 第二單身
   IF g_bgie_d.getLength() > 0 THEN
      CALL g_bgie2_d.clear() 
      CALL abgq920_b_fill2('1')
   END IF  
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abgq920.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abgq920_fetch()
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
 
{<section id="abgq920.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION abgq920_detail_show(ps_page)
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
 
{<section id="abgq920.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION abgq920_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="filter.before_function"
   LET g_detail_idx3 = 1
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
      CONSTRUCT g_wc_filter ON bgie004
                          FROM s_detail1[1].b_bgie004
 
         BEFORE CONSTRUCT
                     DISPLAY abgq920_filter_parser('bgie004') TO s_detail1[1].b_bgie004
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_bgieseq>>----
         #----<<bgie003_1_desc>>----
         #----<<b_bgie004>>----
         #Ctrlp:construct.c.filter.page1.b_bgie004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bgie004
            #add-point:ON ACTION controlp INFIELD b_bgie004 name="construct.c.filter.page1.b_bgie004"
            
            #END add-point
 
 
         #----<<bgie004_desc>>----
         #----<<b_bgie007>>----
         #----<<bgie007_desc>>----
         #----<<b_bgie008>>----
         #----<<bgie008_desc>>----
         #----<<b_bgie009>>----
         #----<<bgie009_desc>>----
         #----<<b_bgie010>>----
         #----<<bgie010_desc>>----
         #----<<b_bgie011>>----
         #----<<bgie011_desc>>----
         #----<<b_bgie012>>----
         #----<<bgie012_desc>>----
         #----<<b_bgie013>>----
         #----<<bgie013_desc>>----
         #----<<b_bgie014>>----
         #----<<bgie014_desc>>----
         #----<<b_bgie015>>----
         #----<<bgie015_desc>>----
         #----<<b_bgie016>>----
         #----<<bgie016_desc>>----
         #----<<b_bgie017>>----
         #----<<b_bgie018>>----
         #----<<bgie018_desc>>----
         #----<<b_bgie019>>----
         #----<<bgie019_desc>>----
         #----<<b_bgie100>>----
         #----<<l_begin_amt>>----
         #----<<l_bgie103_d>>----
         #----<<l_bgie103_c>>----
         #----<<l_sum>>----
   
 
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
   
      CALL abgq920_filter_show('bgie004','b_bgie004')
 
    
   CALL abgq920_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="abgq920.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION abgq920_filter_parser(ps_field)
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
 
{<section id="abgq920.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION abgq920_filter_show(ps_field,ps_object)
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
   LET ls_condition = abgq920_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abgq920.insert" >}
#+ insert
PRIVATE FUNCTION abgq920_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgq920.modify" >}
#+ modify
PRIVATE FUNCTION abgq920_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="abgq920.reproduce" >}
#+ reproduce
PRIVATE FUNCTION abgq920_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="abgq920.delete" >}
#+ delete
PRIVATE FUNCTION abgq920_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="abgq920.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION abgq920_detail_action_trans()
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
 
{<section id="abgq920.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION abgq920_detail_index_setting()
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
            IF g_bgie_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_bgie_d.getLength() AND g_bgie_d.getLength() > 0
            LET g_detail_idx = g_bgie_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_bgie_d.getLength() THEN
               LET g_detail_idx = g_bgie_d.getLength()
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
 
{<section id="abgq920.mask_functions" >}
 &include "erp/abg/abgq920_mask.4gl"
 
{</section>}
 
{<section id="abgq920.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL abgq920_default()
# Date & Author..: 161212 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq920_default()
  
   CALL cl_set_combo_scc('bgie017','6013')      #經營方式

   LET g_input.l_lowersite = 'Y' #含下層組織
   #LET g_input.l_bgap004 = '1'   #關係人選項  #170104-00017#3 mark
   LET g_input.l_bgap004 = '3'   #關係人選項   #170104-00017#3 add 改為預設:全部
   LET g_input.l_curr = '1'      #顯示交易原幣
   LET g_input.l_periods = '1'   #期別選項
   LET g_input.l_bgie033 = '1'   #往來類型
   LET g_input.hsx_bgie004 = 'Y' #核算項 --s
   LET g_input.hsx_bgie007 = 'N'
   LET g_input.hsx_bgie008 = 'N'
   LET g_input.hsx_bgie009 = 'N'
   LET g_input.hsx_bgie010 = 'N'
   LET g_input.hsx_bgie011 = 'Y'
   LET g_input.hsx_bgie012 = 'N'
   LET g_input.hsx_bgie013 = 'N'
   LET g_input.hsx_bgie014 = 'N'
   LET g_input.hsx_bgie015 = 'N'
   LET g_input.hsx_bgie016 = 'N'
   LET g_input.hsx_bgie017 = 'N'
   LET g_input.hsx_bgie018 = 'N'
   LET g_input.hsx_bgie019 = 'N' #核算項 --e

   DISPLAY BY NAME g_input.l_lowersite,g_input.l_bgap004,g_input.l_curr,g_input.l_periods,
                   g_input.hsx_bgie004,g_input.hsx_bgie007,g_input.hsx_bgie008,g_input.hsx_bgie009,
                   g_input.hsx_bgie010,g_input.hsx_bgie011,g_input.hsx_bgie012,g_input.hsx_bgie013,
                   g_input.hsx_bgie014,g_input.hsx_bgie015,g_input.hsx_bgie016,g_input.hsx_bgie017,
                   g_input.hsx_bgie018,g_input.hsx_bgie019
END FUNCTION

################################################################################
# Descriptions...: 依條件展tree
# Memo...........:
# Usage..........: CALL abgq920_grow_tree()
# Date & Author..: 161212 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq920_grow_tree()
DEFINE l_root    DYNAMIC ARRAY OF RECORD
         bgie035 LIKE bgie_t.bgie035, #上層組織
         bgie003 LIKE bgie_t.bgie003  #預算組織
                 END RECORD
DEFINE l_idx     LIKE type_t.num5     #array index
DEFINE l_sql     STRING
#從pid串取得實際pid用-----s
DEFINE l_iddummy LIKE type_t.num5
DEFINE l_idroot  LIKE type_t.num5
DEFINE l_string  STRING   
DEFINE l_pid     LIKE type_t.num5
#從pid串取得實際pid用-----e        
   
   #如不展下層組織,隱藏組織樹結構區塊
   CALL cl_set_comp_visible('vbox_2',TRUE)
   IF g_input.l_lowersite = 'N' THEN 
      CALL cl_set_comp_visible('vbox_2',FALSE)
      RETURN 
   END IF
   
   #畫面上key資訊為空則不展樹
   IF cl_null(g_input.bgie001) OR cl_null(g_input.bgie002) OR cl_null(g_input.bgie003) THEN
      RETURN
   END IF
   
   CALL g_tree.clear()
   #FOREACH 根節點 存成ARRAY
   LET l_sql = "SELECT UNIQUE ooed005,ooed004 FROM ooed_t ",
               " WHERE ooedent = ",g_enterprise,
               "   AND ooed001  = '4'",
               "   AND ooed002 = (SELECT bgaa011 FROM bgaa_t WHERE bgaaent = ",g_enterprise," AND bgaa001 = '",g_input.bgie001,"' AND bgaastus = 'Y' ) ", #最上層組織
               "   AND ooed003 = (SELECT bgaa010 FROM bgaa_t WHERE bgaaent = ",g_enterprise," AND bgaa001 = '",g_input.bgie001,"' AND bgaastus = 'Y' ) ", #版本
               "   AND ooed004 = '",g_input.bgie003,"' ",
               "   AND ooed005 = '",g_input.bgie003,"' " #上級組織編號
               
   PREPARE sel_abgq920_rootp1 FROM l_sql
   DECLARE sel_abgq920_rootc1 CURSOR FOR sel_abgq920_rootp1
   
   LET l_idx = 1 
   FOREACH sel_abgq920_rootc1 INTO l_root[l_idx].*
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF
      
      LET l_idx = l_idx + 1
   END FOREACH
   CALL l_root.deleteElement(l_idx)
   
   IF l_root.getLength() <= 0 THEN
      LET g_tree[1].show = g_input.bgie003,'-',s_desc_get_department_desc(g_input.bgie003)
      LET g_tree[1].pid  = g_tree_pid CLIPPED
      LET g_tree[1].id   = g_tree_pid CLIPPED,'.',g_tree_idx USING '<<<<<<<<<<<<<<<<'
      LET g_tree[1].exp  = 'TRUE'
      LET g_tree[1].isExp = FALSE
      LET g_tree[1].expcode = FALSE  
      LET g_tree[1].hasC = TRUE
      LET g_tree[1].bgie035 = g_input.bgie003   
      LET l_root[1].bgie003 = g_input.bgie003
      RETURN
   END IF
   #用存起來的根節點呼叫遞迴
   LET g_tree_idx = 1
   
   FOR l_idx = 1 TO l_root.getLength()
      LET g_tree_pid = '0'    #代表是起始節點
      CALL abgq920_grow_tree_node(l_root[l_idx].bgie035)
   END FOR

   #如果是最根節點時KEY值會為空
   #此時就要把上層節點的資料KEY給進去
   #方便後續重show畫面
   FOR l_idx = 1 TO g_tree.getLength()
      IF cl_null(g_tree[l_idx].bgie035)THEN
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
            LET g_tree[l_idx].bgie035 = g_tree[l_pid].bgie035 
         END IF
      END IF
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 根節點以外往下長節點
# Memo...........:
# Usage..........: CALL abgq920_grow_tree_node(p_ooed005)
# Date & Author..: 161212 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq920_grow_tree_node(p_ooed005)
DEFINE p_ooed005  LIKE ooed_t.ooed005
DEFINE l_node     DYNAMIC ARRAY OF RECORD
         bgie035  LIKE bgie_t.bgie035, #上層組織
         bgie003  LIKE bgie_t.bgie003  #預算組織
                  END RECORD                    
DEFINE l_idx      LIKE type_t.num10
DEFINE l_id       LIKE type_t.chr100
DEFINE l_sql      STRING
DEFINE l_field    LIKE type_t.chr100

   #用傳入的根節點 FOREACH 抓下節點放入l_node
   LET l_sql = "SELECT UNIQUE ooed005,ooed004 FROM ooed_t ",
               " WHERE ooedent = ",g_enterprise,
               "   AND ooed001  = '4'",
               "   AND ooed002 = (SELECT bgaa011 FROM bgaa_t WHERE bgaaent = ",g_enterprise," AND bgaa001 = '",g_input.bgie001,"' AND bgaastus = 'Y' ) ", #最上層組織
               "   AND ooed003 = (SELECT bgaa010 FROM bgaa_t WHERE bgaaent = ",g_enterprise," AND bgaa001 = '",g_input.bgie001,"' AND bgaastus = 'Y' ) ", #版本
               "   AND ooed005 = '",p_ooed005,"' ",  #上級組織編號
               "   AND ooed004 <> '",p_ooed005,"'  " #排除自己,以免落無窮迴圈  
               
   PREPARE sel_abgq920_nodep1 FROM l_sql
   DECLARE sel_abgq920_nodec1 CURSOR FOR sel_abgq920_nodep1
          
   CALL l_node.clear()
   LET l_idx = 1    
   FOREACH sel_abgq920_nodec1 INTO l_node[l_idx].*
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF

      LET l_idx = l_idx + 1
   END FOREACH

   #如果l_idx = 1 代表沒往下的節點
   #          > 1 代表有往下的節點
   #把上層節點給到g_tree去
   #g_tree_idx + 1
   LET g_tree[g_tree_idx].show = p_ooed005,'-',s_desc_get_department_desc(p_ooed005)
   LET g_tree[g_tree_idx].pid  = g_tree_pid CLIPPED
   LET g_tree[g_tree_idx].id   = g_tree_pid CLIPPED,'.',g_tree_idx USING '<<<<<<<<<<<<<<<<'
   LET g_tree[g_tree_idx].exp  = 'TRUE'
   LET g_tree[g_tree_idx].isExp = FALSE
   LET g_tree[g_tree_idx].expcode = FALSE   #每個節點都收起來
   
   IF l_idx = 1 THEN
   ELSE
      LET g_tree[g_tree_idx].hasC = TRUE
      LET g_tree[g_tree_idx].bgie035 = p_ooed005
   END IF
   IF g_tree_pid = '0' THEN
      LET g_tree[g_tree_idx].hasC = TRUE
      LET g_tree[g_tree_idx].bgie035 = p_ooed005
   END IF
   LET l_id = g_tree[g_tree_idx].id    #自己是誰要記錄
   LET g_tree_idx = g_tree_idx + 1
  
   CALL l_node.deleteElement(l_idx)   

   #FOR 跑遞迴 再往下找節點
   FOR l_idx = 1 TO l_node.getLength()   
      LET g_tree_pid = l_id CLIPPED 
      LET g_tree[g_tree_idx].bgie035 = l_node[l_idx].bgie035      
      LET g_tree[g_tree_idx].bgie003 = l_node[l_idx].bgie003      
      CALL abgq920_grow_tree_node(l_node[l_idx].bgie003)
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 核算項顯示否
# Memo...........:
# Usage..........: CALL abgq920_set_title()
# Date & Author..: 161214 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq920_set_title()
DEFINE l_title           LIKE gzzd_t.gzzd005
DEFINE l_yy              LIKE type_t.num5
DEFINE l_i               LIKE type_t.num5
DEFINE l_title_name      STRING
DEFINE l_title_1         STRING
DEFINE l_bgac002         LIKE bgac_t.bgac002
DEFINE l_i_str           STRING
DEFINE l_yy_str          STRING
DEFINE l_bg_sql          STRING
DEFINE l_bgie033_str     STRING  #170104-00017#3 add


   #核算項顯示否----------------
   CALL cl_set_comp_visible("bgie004_desc,bgie007_desc,bgie008_desc",TRUE)
   CALL cl_set_comp_visible("bgie009_desc,bgie010_desc,bgie011_desc",TRUE)
   CALL cl_set_comp_visible("bgie012_desc,bgie013_desc,bgie014_desc",TRUE)
   CALL cl_set_comp_visible("bgie015_desc,bgie016_desc,b_bgie017",TRUE)
   CALL cl_set_comp_visible("bgie018_desc,bgie019_desc",TRUE)
   
   LET l_bg_sql = ''
   LET g_hsx_wc = " 1=1"
   LET g_xgrid_visible_column = "#@!" #核算項隱顯
   
   LET g_select_field = "'','','',bgie004,'',",
                        "bgie007,'',bgie008,'',bgie009,",
                        "'',bgie010,'',bgie011,'',",
                        "bgie012,'',bgie013,'',bgie014,",
                        "'',bgie015,'',bgie016,'',",
                        "bgie017,bgie018,'',bgie019,'',",
                        "bgie100,'#@!' l_bg,SUM(l_amt_d) l_amt_d,SUM(l_amt_c) l_amt_c,''"                            
    
   #預算細項
   IF g_input.hsx_bgie004 = 'Y' THEN
      LET g_hsx_wc = g_hsx_wc CLIPPED,",bgie004"
   ELSE
      CALL cl_set_comp_visible("bgie004_desc",FALSE)
      LET g_select_field = cl_replace_str(g_select_field,'bgie004',"''")
      LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bgie004_desc"
   END IF 
   #人員
   IF g_input.hsx_bgie007 = 'Y' THEN 
      LET g_hsx_wc = g_hsx_wc CLIPPED,",bgie007"
   ELSE
      CALL cl_set_comp_visible("bgie007_desc",FALSE)
      LET g_select_field = cl_replace_str(g_select_field,'bgie007',"''")
      LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bgie007_desc"
   END IF   
   #部門
   IF g_input.hsx_bgie008 = 'Y' THEN 
      LET g_hsx_wc = g_hsx_wc CLIPPED,",bgie008"
   ELSE
      CALL cl_set_comp_visible("bgie008_desc",FALSE)
      LET g_select_field = cl_replace_str(g_select_field,'bgie008',"''")
      LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bgie008_desc"
   END IF   
   #成本利潤中心
   IF g_input.hsx_bgie009 = 'Y' THEN 
      LET g_hsx_wc = g_hsx_wc CLIPPED,",bgie009"
   ELSE
      CALL cl_set_comp_visible("bgie009_desc",FALSE)
      LET g_select_field = cl_replace_str(g_select_field,'bgie009',"''")
      LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bgie009_desc"
   END IF
   #區域
   IF g_input.hsx_bgie010 = 'Y' THEN 
      LET g_hsx_wc = g_hsx_wc CLIPPED,",bgie010"
   ELSE
      CALL cl_set_comp_visible("bgie010_desc",FALSE)
      LET g_select_field = cl_replace_str(g_select_field,'bgie010',"''")
      LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bgie010_desc"
   END IF   
   #收付款客商
   IF g_input.hsx_bgie011 = 'Y' THEN 
      LET g_hsx_wc = g_hsx_wc CLIPPED,",bgie011"
   ELSE
      CALL cl_set_comp_visible("bgie011_desc",FALSE)
      LET g_select_field = cl_replace_str(g_select_field,'bgie011',"''")
      LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bgie011_desc"
   END IF   
   #帳款客商
   IF g_input.hsx_bgie012 = 'Y' THEN 
      LET g_hsx_wc = g_hsx_wc CLIPPED,",bgie012"
   ELSE
      CALL cl_set_comp_visible("bgie012_desc",FALSE)
      LET g_select_field = cl_replace_str(g_select_field,'bgie012',"''")
      LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bgie012_desc"
   END IF  
   #客群
   IF g_input.hsx_bgie013 = 'Y' THEN
      LET g_hsx_wc = g_hsx_wc CLIPPED,",bgie013"
   ELSE
      CALL cl_set_comp_visible("bgie013_desc",FALSE)
      LET g_select_field = cl_replace_str(g_select_field,'bgie013',"''")
      LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bgie013_desc"
   END IF     
   #產品類別
   IF g_input.hsx_bgie014 = 'Y' THEN 
      LET g_hsx_wc = g_hsx_wc CLIPPED,",bgie014"
   ELSE
      CALL cl_set_comp_visible("bgie014_desc",FALSE)
      LET g_select_field = cl_replace_str(g_select_field,'bgie014',"''")
      LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bgie014_desc"
   END IF  
   #專案編號
   IF g_input.hsx_bgie015 = 'Y' THEN 
      LET g_hsx_wc = g_hsx_wc CLIPPED,",bgie015"
   ELSE
      CALL cl_set_comp_visible("bgie015_desc",FALSE)
      LET g_select_field = cl_replace_str(g_select_field,'bgie015',"''")
      LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bgie015_desc"
   END IF  
   #WBS
   IF g_input.hsx_bgie016 = 'Y' THEN 
      LET g_hsx_wc = g_hsx_wc CLIPPED,",bgie016"
   ELSE
      CALL cl_set_comp_visible("bgie016_desc",FALSE)
      LET g_select_field = cl_replace_str(g_select_field,'bgie016',"''")
      LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bgie016_desc"
   END IF  
   #經營方式
   IF g_input.hsx_bgie017 = 'Y' THEN 
      LET g_hsx_wc = g_hsx_wc CLIPPED,",bgie017"
   ELSE
      CALL cl_set_comp_visible("b_bgie017",FALSE)
      LET g_select_field = cl_replace_str(g_select_field,'bgie017',"''")
      LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bgie017_desc"
   END IF  
   #通路
   IF g_input.hsx_bgie018 = 'Y' THEN 
      LET g_hsx_wc = g_hsx_wc CLIPPED,",bgie018"
   ELSE
      CALL cl_set_comp_visible("bgie018_desc",FALSE)
      LET g_select_field = cl_replace_str(g_select_field,'bgie018',"''")
      LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bgie018_desc"
   END IF  
   #品牌
   IF g_input.hsx_bgie019 = 'Y' THEN 
      LET g_hsx_wc = g_hsx_wc CLIPPED,",bgie019"
   ELSE
      CALL cl_set_comp_visible("bgie019_desc",FALSE)
      LET g_select_field = cl_replace_str(g_select_field,'bgie019',"''")
      LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bgie019_desc"
   END IF  
   
   #xg核算項
   LET g_xgrid_visible_column = cl_replace_str(g_xgrid_visible_column,'#@!|','')
   LET g_xgrid_visible_column = cl_replace_str(g_xgrid_visible_column,'#@!','')

   #往來類型
   #170104-00017#3 --s add
   LET l_bgie033_str = ' 1=1'
   IF g_input.l_bgie033 = '1' THEN 
      #1.AR應收
      LET l_bgie033_str = " bgbj003 IN (SELECT bgae001 FROM bgae_t WHERE bgaeent = ",g_enterprise," ",
                          "                AND bgae006 = (SELECT bgaa008 FROM bgaa_t  WHERE bgaaent = ",g_enterprise," ",
                          "                AND bgaa001 = '",g_input.bgie001,"' AND bgaastus = 'Y')AND bgae008 = '71') " 
   ELSE
      #2.AP應付
      LET l_bgie033_str = " bgbj003 IN (SELECT bgae001 FROM bgae_t WHERE bgaeent = ",g_enterprise," ",
                          "                AND bgae006 = (SELECT bgaa008 FROM bgaa_t  WHERE bgaaent = ",g_enterprise," ",
                          "                AND bgaa001 = '",g_input.bgie001,"' AND bgaastus = 'Y')AND bgae008 = '72') " 
   END IF 
   #170104-00017#3 --e add


   #取t040期初金額重組SQL
   LET l_bg_sql = " COALESCE((SELECT CASE '",g_input.l_curr,"' WHEN '1' THEN bgbj032 ELSE bgbj033 END FROM bgbj_t ",
                  "    WHERE bgbjent = ",g_enterprise," AND bgbj001 = '",g_input.bgie001,"' AND bgbj002 = bgie003 AND bgbj028 = bgie100  ",
                  "      AND bgbj003 = bgie004 AND bgbj012 = bgie007 AND bgbj005 = bgie008  AND bgbj006 = bgie009 AND bgbj007 = bgie010 AND bgbj008 = bgie011  ",
                  "      AND bgbj009 = bgie012 AND bgbj010 = bgie013 AND bgbj011 = bgie014  AND bgbj013 = bgie015 AND bgbj014 = bgie016 AND bgbj015 = bgie017  ",
                  "      AND ",l_bgie033_str," ", #170104-00017#3 add 僅撈是AP or AR類的細項
                  "      AND bgbj016 = bgie018 AND bgbj017 = bgie019 ),0) "  
   
   #170104-00017#3 --s add
   #當核算項有勾其他核算項但無勾選細項,則不串入細項條件
   IF NOT cl_null(g_hsx_wc) AND g_input.hsx_bgie004 = 'N' THEN
      LET l_bg_sql = cl_replace_str(l_bg_sql," AND bgbj003 = bgie004 ",'')
   END IF
   #170104-00017#3 --e add   
   
   LET g_forselect_field = cl_replace_str(g_select_field,"'#@!'",l_bg_sql)
   LET g_doselect_field = cl_replace_str(g_select_field,"'#@!'",'SUM(l_bg)')

   #期別明細資訊欄位title--------------------------------
   #取預算週期
   LET l_yy = ''
   LET l_bgac002 = ''
   SELECT MIN(bgac002) INTO l_bgac002 FROM bgac_t 
    WHERE bgacent = g_enterprise 
      AND bgac001 = (SELECT bgaa002 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_input.bgie001)

   IF cl_null(l_bgac002) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = g_input.bgie001
      LET g_errparam.code   = 'abg-00082'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()      
   END IF
   
   #取得預算週期年度
   LET l_yy = YEAR(l_bgac002)
   LET l_yy_str = l_yy
   LET l_yy_str = l_yy_str.trim()
   
   FOR l_i = 1 TO 13
      LET l_i_str = l_i
      LET l_i_str = l_i_str.trim()
      LET l_title_name = "l_amt_",l_i_str
      IF l_i < 10 THEN
         LET l_title_1 = l_yy_str,"/0" CLIPPED,l_i_str
      ELSE
         LET l_title_1 = l_yy_str,"/" CLIPPED,l_i_str
      END IF
      CALL cl_set_comp_att_text(l_title_name,l_title_1)   
   END FOR
   
   LET l_title = ''
   SELECT gzzd005 INTO l_title FROM gzzd_t WHERE gzzd003 = 'l_title_14' AND gzzd002 = g_dlang AND gzzd001 = 'abgq920'
   CALL cl_set_comp_att_text('l_amt_14',l_title)   
   
   
END FUNCTION

################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL abgq920_creat_temp()
# Date & Author..: 161215 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq920_creat_temp()
   DROP TABLE abgq920_tmp;
   CREATE TEMP TABLE abgq920_tmp(
      bgieent   LIKE bgie_t.bgieent, #企業編號
      bgie003   LIKE bgie_t.bgie003, #預算組織
      bgie004   LIKE bgie_t.bgie004, #預算細項    
      bgie007   LIKE bgie_t.bgie007, #人員
      bgie008   LIKE bgie_t.bgie008, #部門
      bgie009   LIKE bgie_t.bgie009, #成本利潤中心
      bgie010   LIKE bgie_t.bgie010, #區域
      bgie011   LIKE bgie_t.bgie011, #收付款客商
      bgie012   LIKE bgie_t.bgie012, #帳款客商
      bgie013   LIKE bgie_t.bgie013, #客群
      bgie014   LIKE bgie_t.bgie014, #產品類別
      bgie015   LIKE bgie_t.bgie015, #專案編號
      bgie016   LIKE bgie_t.bgie016, #WBS
      bgie017   LIKE bgie_t.bgie017, #經營方式
      bgie018   LIKE bgie_t.bgie018, #通路
      bgie019   LIKE bgie_t.bgie019, #品牌
      bgie034   LIKE bgie_t.bgie034, #借貸別
      l_amt_d   LIKE bgie_t.bgie103, #借方金額 
      l_amt_c   LIKE bgie_t.bgie103, #貸方金額 
      bgie100   LIKE bgie_t.bgie100, #交易幣別
      bgie103   LIKE bgie_t.bgie103, #本幣交易金額
      bgie104   LIKE bgie_t.bgie104, #原幣交易金額
      l_yymm    LIKE type_t.chr100   #年度月份
                )
                
   #幣別小計
   DROP TABLE abgq920_currtmp;
   CREATE TEMP TABLE abgq920_currtmp(
      bgie100     LIKE bgie_t.bgie100, 
      l_begin_amt LIKE type_t.num20_6, 
      l_bgie103_d LIKE type_t.num20_6, 
      l_bgie103_c LIKE type_t.num20_6, 
      l_sum       LIKE type_t.num20_6       
                )                 
       
   #xg列印    
   DROP TABLE abgq920_x01_tmp;
   CREATE TEMP TABLE abgq920_x01_tmp(
      bgieent         LIKE bgie_t.bgieent,  #企業編號
      l_bgie001_desc  LIKE type_t.chr100,   #單頭
      bgie002         LIKE bgie_t.bgie002, 
      l_bgie003_desc  LIKE type_t.chr100, 
      l_lowersite     LIKE type_t.chr1,
      l_bgie033_desc  LIKE type_t.chr100,  
      l_bgap004_desc  LIKE type_t.chr100, 
      l_bgaa003       LIKE bgaa_t.bgaa003,
      l_curr_desc     LIKE type_t.chr100, 
      l_periods_desc  LIKE type_t.chr100,
      bgieseq         LIKE bgie_t.bgieseq,  #第一單身
      l_bgie0032_desc LIKE type_t.chr100, 
      l_bgie004_desc  LIKE type_t.chr100, 
      l_bgie007_desc  LIKE type_t.chr100, 
      l_bgie008_desc  LIKE type_t.chr100, 
      l_bgie009_desc  LIKE type_t.chr100, 
      l_bgie010_desc  LIKE type_t.chr100, 
      l_bgie011_desc  LIKE type_t.chr100, 
      l_bgie012_desc  LIKE type_t.chr100, 
      l_bgie013_desc  LIKE type_t.chr100, 
      l_bgie014_desc  LIKE type_t.chr100, 
      l_bgie015_desc  LIKE type_t.chr100, 
      l_bgie016_desc  LIKE type_t.chr100, 
      l_bgie017_desc  LIKE type_t.chr100, 
      l_bgie018_desc  LIKE type_t.chr500, 
      l_bgie019_desc  LIKE type_t.chr100, 
      bgie100         LIKE bgie_t.bgie100, 
      l_begin_amt     LIKE type_t.num20_6, 
      l_bgie103_d     LIKE type_t.num20_6, 
      l_bgie103_c     LIKE type_t.num20_6, 
      l_sum           LIKE type_t.num20_6 
      )       
       
   #xg列印-子報表
   DROP TABLE abgq920_x01_tmp1;
   CREATE TEMP TABLE abgq920_x01_tmp1(
      l_bgieseq2       LIKE bgie_t.bgieseq, #連接第一單身
      l_bgieseq        LIKE bgie_t.bgieseq, 
      l_bgie003_2_desc LIKE type_t.chr100, 
      l_begin_amt1     LIKE type_t.num20_6,
      l_amt_1          LIKE type_t.num20_6, 
      l_amt_2          LIKE type_t.num20_6, 
      l_amt_3          LIKE type_t.num20_6, 
      l_amt_4          LIKE type_t.num20_6, 
      l_amt_5          LIKE type_t.num20_6, 
      l_amt_6          LIKE type_t.num20_6, 
      l_amt_7          LIKE type_t.num20_6, 
      l_amt_8          LIKE type_t.num20_6, 
      l_amt_9          LIKE type_t.num20_6, 
      l_amt_10         LIKE type_t.num20_6, 
      l_amt_11         LIKE type_t.num20_6, 
      l_amt_12         LIKE type_t.num20_6, 
      l_amt_13         LIKE type_t.num20_6, 
      l_amt_14         LIKE type_t.num20_6, 
      l_amt_sum        LIKE type_t.num20_6
      )       
       
END FUNCTION

################################################################################
# Descriptions...: 寫入tmp
# Memo...........:
# Usage..........: CALL abgq920_insert_temp()
# Date & Author..: 161215 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq920_insert_temp()
DEFINE l_sql         STRING
DEFINE l_bgie003_str STRING
DEFINE l_periods     STRING
DEFINE l_bgap004_str STRING               #關係人選項
#DEFINE l_bgie033     LIKE bgie_t.bgie033  #往來類型 #170104-00017#3 mark
DEFINE l_bgie033_str STRING                         #170104-00017#3 add
DEFINE l_cnt         LIKE type_t.num10
DEFINE l_tmp         RECORD
         bgie003     LIKE bgie_t.bgie003, #預算組織
         bgie004     LIKE bgie_t.bgie004, #預算細項      
         bgie007     LIKE bgie_t.bgie007, #人員
         bgie008     LIKE bgie_t.bgie008, #部門
         bgie009     LIKE bgie_t.bgie009, #成本利潤中心
         bgie010     LIKE bgie_t.bgie010, #區域
         bgie011     LIKE bgie_t.bgie011, #收付款客商
         bgie012     LIKE bgie_t.bgie012, #帳款客商
         bgie013     LIKE bgie_t.bgie013, #客群
         bgie014     LIKE bgie_t.bgie014, #產品類別
         bgie015     LIKE bgie_t.bgie015, #專案編號
         bgie016     LIKE bgie_t.bgie016, #WBS
         bgie017     LIKE bgie_t.bgie017, #經營方式
         bgie018     LIKE bgie_t.bgie018, #通路
         bgie019     LIKE bgie_t.bgie019, #品牌
         bgie034     LIKE bgie_t.bgie034, #借貸別
         l_amt_d     LIKE bgie_t.bgie103, #借方金額 
         l_amt_c     LIKE bgie_t.bgie103, #貸方金額 
         bgie100     LIKE bgie_t.bgie100, #交易幣別
         bgie103     LIKE bgie_t.bgie103, #本幣交易金額
         bgie104     LIKE bgie_t.bgie104, #原幣交易金額
         l_yymm      LIKE type_t.chr100   #年度月份
                     END RECORD
DEFINE l_bgae002     LIKE bgae_t.bgae002   #170104-00017#3 add                   

   #前置條件處理--------------------------------------------------s
   IF cl_null(g_bgie003) THEN 
      RETURN 
   ELSE
      LET l_bgie003_str = "('",g_bgie003,"')" 
   END IF
   
   #往來類型
   #170104-00017#3 --s add
   LET l_bgie033_str = ' 1=1'
   IF g_input.l_bgie033 = '1' THEN
      LET l_bgie033_str = " bgae008 = '71' " #1.AR應收
   ELSE
      LET l_bgie033_str = " bgae008 = '72' " #2.AP應付
   END IF 
   #170104-00017#3 --e add
   #170104-00017#3 --s mark
   #LET l_bgie033 = ''
   #IF g_input.l_bgie033 = '1' THEN
   #   LET l_bgie033 = 'AR' #1.AR應收
   #ELSE
   #   LET l_bgie033 = 'AP' #2.AP應付
   #END IF 
   #170104-00017#3 --e mark
   
   #關係人選項
   LET l_bgap004_str = ''
   CASE g_input.l_bgap004
      WHEN 1
         #企業關係人
         LET l_bgap004_str = " bgie011 IN (SELECT UNIQUE bgap001 FROM bgap_t ",
                             "              WHERE bgapent = ",g_enterprise," AND bgap004 = 'Y' ) "     
         
      WHEN 2       
         #非企業關係人      
         LET l_bgap004_str = " bgie011 IN (SELECT UNIQUE bgap001 FROM bgap_t ",
                             "              WHERE bgapent = ",g_enterprise," AND bgap004 = 'N' ) "    
      WHEN 3
         LET l_bgap004_str = " 1=1"   #全部
   END CASE

   #年度期別
   CASE g_input.l_periods 
      WHEN 1 #預算期別         
         LET l_periods = "((SELECT TO_CHAR(MIN(bgac002),'yyyy') FROM bgac_t WHERE bgacent = ",g_enterprise," ",
                         "     AND bgac001 = (SELECT bgaa002 FROM bgaa_t WHERE bgaaent = ",g_enterprise," AND bgaa001 = '",g_input.bgie001,"'))||'/'||bgie005) "
      WHEN 2 #帳款期別                                
         LET l_periods = "TO_CHAR(bgie031,'yyyy/mm')"
      WHEN 3 #現金收支期別                            
         LET l_periods = "TO_CHAR(bgie032,'yyyy/mm')"
   END CASE
   
   #170104-00017#3 --s add
   LET l_sql = " SELECT bgae002 ",
               "   FROM bgae_t ",
               "  WHERE bgaeent = ",g_enterprise,"  ",
               "    AND bgae006 = (SELECT bgaa008 FROM bgaa_t WHERE bgaaent = ",g_enterprise," AND bgaa001 = '",g_input.bgie001,"' AND bgaastus = 'Y') ",
               "    AND bgae001 = ?  "
      
   PREPARE abgq920_get_bgae002 FROM l_sql  
   #170104-00017#3 --e add   

   #前置條件處理--------------------------------------------------e
   
   
   DELETE FROM abgq920_tmp   
               #預算組織/預算細項/人員/部門/成本利潤中心
   LET l_sql = " SELECT bgie003,bgie004,bgie007,bgie008,bgie009, ",
               #區域/收付款客商/帳款客商/客群/產品類別
               "        bgie010,bgie011,bgie012,bgie013,bgie014, ",
               #專案編號/WBS/經營方式/通路/品牌
               "        bgie015,bgie016,bgie017,bgie018,bgie019, ",
               #借貸別/借方金額/貸方金額/交易幣別/本幣交易金額
               "        bgie034,bgie103,bgie103,bgie100,bgie103, ",
               #原幣交易金額/年度期別
               "        bgie104,",l_periods,"  ",    
               "   FROM bgie_t ",
               "  WHERE bgieent = ",g_enterprise," ",        #企業編號
               "    AND bgie001 = '",g_input.bgie001,"' ",   #預算編號
               "    AND bgie002 = '",g_input.bgie002,"' ",   #預算版本
               "    AND bgie003 IN ",l_bgie003_str," ",      #預算組織
               #"    AND bgie033 = '",l_bgie033,"' ",         #往來類型  #170104-00017#3 mark
               #170104-00017#3 --s add
               "    AND bgie004 IN (SELECT bgae001 FROM bgae_t WHERE bgaeent = ",g_enterprise," ",
               "                       AND bgae006 = (SELECT bgaa008 FROM bgaa_t  WHERE bgaaent = ",g_enterprise," ",
               "                       AND bgaa001 = '",g_input.bgie001,"' AND bgaastus = 'Y') AND ",l_bgie033_str,")",   
               #170104-00017#3 --e add
               "    AND ",l_bgap004_str," ",                 #關係人選項
               "    AND ",g_wc3                              #QBE條件

   PREPARE abgq920_pb1 FROM l_sql
   DECLARE abgq920_c1 CURSOR FOR abgq920_pb1   
   FOREACH abgq920_c1 INTO l_tmp.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:abgq920_c1"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF  
     
      #檢核abgi090權限
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt
        FROM bgai_t
       WHERE bgaient = g_enterprise
         AND bgai001 = g_input.bgie001
         AND bgai003 = g_user
         AND bgai004 = l_tmp.bgie003
         AND ((bgai005 = '00' AND bgai006 = 'ALL') OR (bgai005 = '07' AND bgai006 IN ('ALL',l_tmp.bgie004)))
         AND bgaistus = 'Y'
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 0 THEN CONTINUE FOREACH END IF

      #借貸方向 1.借方 2.貸方    
      IF g_input.l_curr = '1' THEN  
         #顯示交易原幣
         IF l_tmp.bgie034 = '1' THEN
            #1.借方
            LET l_tmp.l_amt_d = l_tmp.bgie104
            LET l_tmp.l_amt_c = 0
         ELSE
            #2.貸方
            LET l_tmp.l_amt_d = 0
            LET l_tmp.l_amt_c = l_tmp.bgie104         
         END IF
      ELSE
         #顯示預算幣別
         IF l_tmp.bgie034 = '1' THEN
            #1.借方
            LET l_tmp.l_amt_d = l_tmp.bgie103 
            LET l_tmp.l_amt_c = 0
         ELSE
            #2.貸方
            LET l_tmp.l_amt_d = 0
            LET l_tmp.l_amt_c = l_tmp.bgie103           
         END IF
      END IF
      
      #170104-00017#3 --s add      
      LET l_bgae002 = ''        
      EXECUTE abgq920_get_bgae002 USING l_tmp.bgie004 INTO l_bgae002      
      IF l_bgae002 = '1' THEN
         LET l_tmp.l_amt_c = l_tmp.l_amt_c * -1
      ELSE
         LET l_tmp.l_amt_d = l_tmp.l_amt_d * -1      
      END IF
      #170104-00017#3 --e add       
      
      INSERT INTO abgq920_tmp VALUES(g_enterprise,l_tmp.*)

   END FOREACH
   
END FUNCTION

################################################################################
# Descriptions...: 第二單身
# Memo...........: 如調整則須同步修改 :abgq920_b_fill2xg 子報表function
# Usage..........: CALL abgq920_b_fill2(p_idx)
# Date & Author..: 161215 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq920_b_fill2(p_idx)
DEFINE p_idx          LIKE type_t.num5
DEFINE l_hsx_wc2      STRING               #bgie組核算項
DEFINE l_t040_hsx_wc  STRING               #bgbj組核算項
DEFINE l_bgie003_str  STRING
DEFINE l_sql          STRING
DEFINE l_begin_amt_sql STRING
DEFINE l_bgac002      LIKE bgac_t.bgac002  
DEFINE l_bgie003      LIKE bgie_t.bgie003  
DEFINE l_amt_d        LIKE bgie_t.bgie103  
DEFINE l_amt_c        LIKE bgie_t.bgie103  
#DEFINE l_bgae002      LIKE bgae_t.bgae002   #170104-00017#3 mark
DEFINE l_yymm         LIKE type_t.chr100   
DEFINE l_abg_yy       LIKE type_t.chr100   #預算週期當年年度
DEFINE l_yy           LIKE type_t.chr100   #來源資料年度
DEFINE l_mm           LIKE type_t.chr100   #來源資料月份
DEFINE l_sum_bgbj033  LIKE bgie_t.bgie103 
DEFINE l_amt          LIKE bgie_t.bgie103 
DEFINE l_bgie033_str  STRING               #170104-00017#3 add


   IF cl_null(p_idx) OR p_idx <= 0 THEN RETURN END IF
   IF cl_null(g_bgie_d[p_idx].bgieseq) THEN RETURN END IF
  
   ##前置資料-----------------------------------------------------
   #取得核算項條件
   LET l_hsx_wc2 = ''
   LET l_t040_hsx_wc = ''
   CALL abgq920_get_hsx_wc(p_idx) RETURNING l_hsx_wc2,l_t040_hsx_wc
   IF cl_null(l_hsx_wc2) THEN LET l_hsx_wc2 = " 1=1" END IF           #bgie組核算項
   IF cl_null(l_t040_hsx_wc) THEN LET l_t040_hsx_wc = " 1=1" END IF   #bgbj組核算項
              
   LET l_bgie003_str = g_bgie003
   LET l_bgie003_str = "('",l_bgie003_str,"')" 
           
   #預算週期當年年度
   LET l_bgac002 = ''
   SELECT MIN(bgac002) INTO l_bgac002  FROM bgac_t 
    WHERE bgacent = g_enterprise AND bgac001 = (SELECT bgaa002 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_input.bgie001)           
            
   #撈取組織資料      
   LET l_sql = " SELECT UNIQUE bgie003 ",
               "   FROM abgq920_tmp ",
               "  WHERE bgieent = ",g_enterprise,"  ",
               "    AND ",l_hsx_wc2," ",
               "    AND bgie003 IN ",l_bgie003_str," ",
               "    AND bgie100 = '",g_bgie_d[p_idx].bgie100,"' "
   PREPARE abgq920_p1 FROM l_sql
   DECLARE abgq920_pc1 CURSOR FOR abgq920_p1              
            
   #撈出各期別金額           
   LET l_sql = " SELECT l_yymm,SUM(l_amt_d),SUM(l_amt_c) ",
               "   FROM abgq920_tmp ",
               "  WHERE bgieent = ",g_enterprise,"  ",
               "    AND ",l_hsx_wc2," ",
               "    AND bgie003 = ? ",
               "    AND bgie100 = '",g_bgie_d[p_idx].bgie100,"' ",
               "  GROUP BY l_yymm ",
               "  ORDER BY l_yymm "
   
   PREPARE abgq920_p2 FROM l_sql
   DECLARE abgq920_c2 CURSOR FOR abgq920_p2              
  
   #170104-00017#3 --s mark
   ##借貸方向 1.借方 2.貸方            
   #LET l_bgae002 = ''  
   #SELECT bgae002 INTO l_bgae002
   #  FROM bgae_t
   # WHERE bgaeent = g_enterprise 
   #   AND bgae006 = (SELECT bgaa008 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_input.bgie001 AND bgaastus = 'Y')
   #   AND bgae001 = g_bgie_d[p_idx].bgie004            
   #170104-00017#3 --e mark

   #170104-00017#3 --s add
   #期初金額
   LET l_bgie033_str = ' 1=1'
   IF g_input.l_bgie033 = '1' THEN 
      #1.AR應收
      LET l_bgie033_str = " bgbj003 IN (SELECT bgae001 FROM bgae_t WHERE bgaeent = ",g_enterprise," ",
                          "                AND bgae006 = (SELECT bgaa008 FROM bgaa_t  WHERE bgaaent = ",g_enterprise," ",
                          "                AND bgaa001 = '",g_input.bgie001,"' AND bgaastus = 'Y')AND bgae008 = '71') " 
   ELSE
      #2.AP應付
      LET l_bgie033_str = " bgbj003 IN (SELECT bgae001 FROM bgae_t WHERE bgaeent = ",g_enterprise," ",
                          "                AND bgae006 = (SELECT bgaa008 FROM bgaa_t  WHERE bgaaent = ",g_enterprise," ",
                          "                AND bgaa001 = '",g_input.bgie001,"' AND bgaastus = 'Y')AND bgae008 = '72') " 
   END IF 
   
   LET l_begin_amt_sql = " SELECT CASE '",g_input.l_curr,"' WHEN '1' THEN SUM(bgbj032) ELSE SUM(bgbj033) END ",
                         "   FROM bgbj_t ",
                         "  WHERE bgbjent = ",g_enterprise,"  ",
                         "    AND bgbj001 = '",g_input.bgie001,"'  ",
                         "    AND bgbj002 = ? ",
                         "    AND ",l_bgie033_str," ", #類型 
                         "    AND bgbj028 = '",g_bgie_d[p_idx].bgie100,"' "
                         
   IF NOT cl_null(g_hsx_wc) THEN
      LET l_begin_amt_sql = l_begin_amt_sql," AND ",l_t040_hsx_wc #核算項
   END IF

   PREPARE l_begin_amt_pre FROM l_begin_amt_sql   
   #170104-00017#3 --e add

   ##-----------------------------------------------------------

   CALL g_bgie2_d.clear() 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
   LET l_bgie003 = ''
   FOREACH abgq920_pc1 INTO l_bgie003 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:abgq920_pc1"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF      
      
      LET g_bgie2_d[l_ac].bgieseq = l_ac
      LET g_bgie2_d[l_ac].bgie003 = l_bgie003
      LET g_bgie2_d[l_ac].bgie003_2_desc = s_desc_get_department_desc(l_bgie003)
      
      #SQL FOR 期初金額
      LET l_sum_bgbj033 = 0
      #170104-00017#3 --s mark 搬到迴圈外
      #LET l_begin_amt_sql = " SELECT CASE '",g_input.l_curr,"' WHEN '1' THEN SUM(bgbj032) ELSE SUM(bgbj033) END ",
      #                      "   FROM bgbj_t ",
      #                      "  WHERE bgbjent = ",g_enterprise,"  ",
      #                      "    AND bgbj001 = '",g_input.bgie001,"'  ",
      #                      "    AND bgbj002 = '",l_bgie003,"' ",
      #                      "    AND ",l_t040_hsx_wc," ", #核算項
      #                      "    AND bgbj028 = '",g_bgie_d[p_idx].bgie100,"' "
      #PREPARE l_begin_amt_pre FROM l_begin_amt_sql   
      #EXECUTE l_begin_amt_pre INTO l_sum_bgbj033
      #170104-00017#3 --e mark
      
      EXECUTE l_begin_amt_pre USING l_bgie003 INTO l_sum_bgbj033  #170104-00017#3 add
      IF cl_null(l_sum_bgbj033)THEN LET l_sum_bgbj033 = 0 END IF          
      LET g_bgie2_d[l_ac].l_begin_amt1 =  l_sum_bgbj033    

      LET g_bgie2_d[l_ac].l_amt_1 = 0
      LET g_bgie2_d[l_ac].l_amt_2 = 0
      LET g_bgie2_d[l_ac].l_amt_3 = 0
      LET g_bgie2_d[l_ac].l_amt_4 = 0
      LET g_bgie2_d[l_ac].l_amt_5 = 0
      LET g_bgie2_d[l_ac].l_amt_6 = 0
      LET g_bgie2_d[l_ac].l_amt_7 = 0
      LET g_bgie2_d[l_ac].l_amt_8 = 0
      LET g_bgie2_d[l_ac].l_amt_9 = 0
      LET g_bgie2_d[l_ac].l_amt_10 = 0
      LET g_bgie2_d[l_ac].l_amt_11 = 0
      LET g_bgie2_d[l_ac].l_amt_12 = 0
      LET g_bgie2_d[l_ac].l_amt_13 = 0
      LET g_bgie2_d[l_ac].l_amt_14 = 0  
         
      FOREACH abgq920_c2 USING l_bgie003 INTO l_yymm,l_amt_d,l_amt_c 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:abgq920_c2" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         IF cl_null(l_amt_d) THEN LET l_amt_d = 0 END IF
         IF cl_null(l_amt_c) THEN LET l_amt_c = 0 END IF
 
         LET l_amt = 0
         #170104-00017#3 --s mark
         #IF l_bgae002 = '1' THEN
         #   LET l_amt = l_amt_d - l_amt_c
         #ELSE
         #   LET l_amt = l_amt_c - l_amt_d
         #END IF          
         #170104-00017#3 --e mark
         LET l_amt = l_amt_c + l_amt_d #170104-00017#3 add
         
         LET l_yymm = l_yymm CLIPPED,"/01"
         LET l_yy = YEAR(l_yymm)
         LET l_mm = MONTH(l_yymm)
         LET l_abg_yy = YEAR(l_bgac002)
         
         IF l_yy = l_abg_yy THEN
            CASE l_mm
               WHEN 1  LET g_bgie2_d[l_ac].l_amt_1  =  l_amt 
               WHEN 2  LET g_bgie2_d[l_ac].l_amt_2  =  l_amt 
               WHEN 3  LET g_bgie2_d[l_ac].l_amt_3  =  l_amt 
               WHEN 4  LET g_bgie2_d[l_ac].l_amt_4  =  l_amt 
               WHEN 5  LET g_bgie2_d[l_ac].l_amt_5  =  l_amt 
               WHEN 6  LET g_bgie2_d[l_ac].l_amt_6  =  l_amt 
               WHEN 7  LET g_bgie2_d[l_ac].l_amt_7  =  l_amt 
               WHEN 8  LET g_bgie2_d[l_ac].l_amt_8  =  l_amt 
               WHEN 9  LET g_bgie2_d[l_ac].l_amt_9  =  l_amt 
               WHEN 10 LET g_bgie2_d[l_ac].l_amt_10 =  l_amt 
               WHEN 11 LET g_bgie2_d[l_ac].l_amt_11 =  l_amt 
               WHEN 12 LET g_bgie2_d[l_ac].l_amt_12 =  l_amt 
               WHEN 13 LET g_bgie2_d[l_ac].l_amt_13 =  l_amt 
            END CASE             
         ELSE
            LET g_bgie2_d[l_ac].l_amt_14 = l_amt 
         END IF
      END FOREACH      
 
      LET g_bgie2_d[l_ac].l_amt_sum = g_bgie2_d[l_ac].l_begin_amt1 + g_bgie2_d[l_ac].l_amt_1 + g_bgie2_d[l_ac].l_amt_2 + 
                                      g_bgie2_d[l_ac].l_amt_3 + g_bgie2_d[l_ac].l_amt_4 + g_bgie2_d[l_ac].l_amt_5 + 
                                      g_bgie2_d[l_ac].l_amt_6 + g_bgie2_d[l_ac].l_amt_7 + g_bgie2_d[l_ac].l_amt_8 + 
                                      g_bgie2_d[l_ac].l_amt_9 + g_bgie2_d[l_ac].l_amt_10 + g_bgie2_d[l_ac].l_amt_11 + 
                                      g_bgie2_d[l_ac].l_amt_12 + g_bgie2_d[l_ac].l_amt_13 + g_bgie2_d[l_ac].l_amt_14
          
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

   LET g_detail_cnt2 = g_bgie2_d.getLength()
   LET l_ac = g_detail_cnt2


END FUNCTION

################################################################################
# Descriptions...: Tree選取點
# Memo...........:
# Usage..........: CALL abgq920_tree_fetch(p_idx)
# Date & Author..: 161219 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq920_tree_fetch(p_idx)
   DEFINE p_idx     LIKE type_t.num5
   DEFINE l_idx     LIKE type_t.num5
   

   IF cl_null(p_idx) OR p_idx <= 0 THEN RETURN END IF
   
   LET g_bgie003 = ''
   LET g_bgie035 = ''
   LET g_flag = FALSE
   
   #根節點
   IF cl_null(g_tree[p_idx].bgie003) AND NOT cl_null(g_tree[p_idx].bgie035) THEN
      LET g_bgie035 = g_tree[p_idx].bgie035 #存取根節點
      LET g_flag = TRUE
      FOR l_idx = 1 TO g_tree.getLength()
         #將旗下子節點接上
         IF g_bgie035 = g_tree[l_idx].bgie035 THEN
            IF cl_null(g_bgie003) THEN
               LET g_bgie003 = g_bgie035
            ELSE
               LET g_bgie003 = g_bgie003,"','",g_tree[l_idx].bgie003
            END IF
         END IF
      END FOR
   ELSE
   #本身為子節點
      LET g_bgie003 = g_tree[p_idx].bgie003
   END IF 
   
END FUNCTION

################################################################################
# Descriptions...: 取得第一單身核算項條件
# Memo...........:
# Usage..........: CALL abgq920_get_hsx_wc(p_idx)
# Date & Author..: 161219 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq920_get_hsx_wc(p_idx)
DEFINE p_idx         LIKE type_t.num5
DEFINE r_hsx_wc2     STRING 
DEFINE r_t040_hsx_wc STRING 

   LET r_hsx_wc2 = " 1=1"
   LET r_t040_hsx_wc = " 1=1"
   
   #預算細項
   #170104-00017#3 --s add
   #當核算項有勾其他核算項但無勾選細項,則不串入細項條件
   IF NOT cl_null(g_hsx_wc) AND g_input.hsx_bgie004 = 'N' THEN
   ELSE
   #170104-00017#3 --e add
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj003 = '",g_bgie_d[p_idx].bgie004,"' "  
   END IF  #170104-00017#3  add
   
   #人員
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj012 = '",g_bgie_d[p_idx].bgie007,"' "
   #部門
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj005 = '",g_bgie_d[p_idx].bgie008,"' "     
   #成本利潤中心
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj006 = '",g_bgie_d[p_idx].bgie009,"' "     
   #區域
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj007 = '",g_bgie_d[p_idx].bgie010,"' "      
   #收付款客商
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj008 = '",g_bgie_d[p_idx].bgie011,"' "      
   #帳款客商
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj009 = '",g_bgie_d[p_idx].bgie012,"' "     
   #客群
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj010 = '",g_bgie_d[p_idx].bgie013,"' "     
   #產品類別
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj011 = '",g_bgie_d[p_idx].bgie014,"' "      
   #專案編號
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj013 = '",g_bgie_d[p_idx].bgie015,"' "      
   #WBS
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj014 = '",g_bgie_d[p_idx].bgie016,"' "      
   #經營方式
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj015 = '",g_bgie_d[p_idx].bgie017,"' "      
   #通路
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj016 = '",g_bgie_d[p_idx].bgie018,"' "     
   #品牌
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj017 = '",g_bgie_d[p_idx].bgie019,"' "     
   

   IF g_input.hsx_bgie004 = 'Y' THEN
      LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bgie004 = '",g_bgie_d[p_idx].bgie004,"' "
   END IF
   IF g_input.hsx_bgie007 = 'Y' THEN
      LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bgie007 = '",g_bgie_d[p_idx].bgie007,"' "
   END IF
   IF g_input.hsx_bgie008 = 'Y' THEN
      LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bgie008 = '",g_bgie_d[p_idx].bgie008,"' "
   END IF
   IF g_input.hsx_bgie009 = 'Y' THEN
      LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bgie009 = '",g_bgie_d[p_idx].bgie009,"' "
   END IF
   IF g_input.hsx_bgie010 = 'Y' THEN
      LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bgie010 = '",g_bgie_d[p_idx].bgie010,"' "
   END IF
   IF g_input.hsx_bgie011 = 'Y' THEN
      LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bgie011 = '",g_bgie_d[p_idx].bgie011,"' "
   END IF
   IF g_input.hsx_bgie012 = 'Y' THEN
      LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bgie012 = '",g_bgie_d[p_idx].bgie012,"' "
   END IF
   IF g_input.hsx_bgie013 = 'Y' THEN
      LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bgie013 = '",g_bgie_d[p_idx].bgie013,"' "
   END IF
   IF g_input.hsx_bgie014 = 'Y' THEN
      LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bgie014 = '",g_bgie_d[p_idx].bgie014,"' "
   END IF
   IF g_input.hsx_bgie015 = 'Y' THEN
      LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bgie015 = '",g_bgie_d[p_idx].bgie015,"' "
   END IF
   IF g_input.hsx_bgie016 = 'Y' THEN
      LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bgie016 = '",g_bgie_d[p_idx].bgie016,"' "
   END IF
   IF g_input.hsx_bgie017 = 'Y' THEN
      LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bgie017 = '",g_bgie_d[p_idx].bgie017,"' "
   END IF
   
   RETURN r_hsx_wc2,r_t040_hsx_wc
END FUNCTION

################################################################################
# Descriptions...: 列印
# Memo...........:
# Usage..........: CALL abgq920_print()
# Date & Author..: 161221 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq920_print()
DEFINE l_title           LIKE gzzd_t.gzzd005
DEFINE l_bgie001_desc    LIKE type_t.chr100
DEFINE l_bgie002         LIKE bgie_t.bgie002
DEFINE l_bgie003_desc    LIKE type_t.chr100
DEFINE l_lowersite       LIKE type_t.chr100
DEFINE l_bgaa003         LIKE bgaa_t.bgaa003
DEFINE l_bgie033_desc    LIKE type_t.chr100
DEFINE l_bgap004_desc    LIKE type_t.chr100
DEFINE l_curr_desc       LIKE type_t.chr100
DEFINE l_periods_desc    LIKE type_t.chr100
DEFINE l_i               LIKE type_t.num10
DEFINE l_bgie0032_desc   LIKE type_t.chr100
DEFINE l_bgie017_desc    LIKE type_t.chr100

   #單頭資料--------------------
   LET l_bgie001_desc = g_input.bgie001,':',g_input.bgie001_desc
   LET l_bgie002      = g_input.bgie002
   LET l_bgie003_desc = g_input.bgie003,':',g_input.bgie003_desc
   LET l_lowersite    = g_input.l_lowersite
   LET l_bgaa003      = g_input.l_bgaa003
   
   LET l_bgie033_desc = ''
   CASE g_input.l_bgie033
      WHEN '1'
         SELECT gzzd005 INTO l_bgie033_desc FROM gzzd_t WHERE gzzd003 = 'cbo_b_bgie033.1' AND gzzd002 = g_dlang AND gzzd001 = 'abgq920'
      WHEN '2'
         SELECT gzzd005 INTO l_bgie033_desc FROM gzzd_t WHERE gzzd003 = 'cbo_b_bgie033.2' AND gzzd002 = g_dlang AND gzzd001 = 'abgq920'
   END CASE
   
   LET l_bgap004_desc = ''
   CASE g_input.l_bgap004
      WHEN '1'
         SELECT gzzd005 INTO l_bgap004_desc FROM gzzd_t WHERE gzzd003 = 'cbo_l_bgap004.1' AND gzzd002 = g_dlang AND gzzd001 = 'abgq920'
      WHEN '2'
         SELECT gzzd005 INTO l_bgap004_desc FROM gzzd_t WHERE gzzd003 = 'cbo_l_bgap004.2' AND gzzd002 = g_dlang AND gzzd001 = 'abgq920'
      WHEN '3'
         SELECT gzzd005 INTO l_bgap004_desc FROM gzzd_t WHERE gzzd003 = 'cbo_l_bgap004.3' AND gzzd002 = g_dlang AND gzzd001 = 'abgq920'
   END CASE  
   
   LET l_curr_desc = ''
   CASE g_input.l_curr
      WHEN '1'
         SELECT gzzd005 INTO l_curr_desc FROM gzzd_t WHERE gzzd003 = 'rdo_radiogroup_1.1' AND gzzd002 = g_dlang AND gzzd001 = 'abgq920'
      WHEN '2'
         SELECT gzzd005 INTO l_curr_desc FROM gzzd_t WHERE gzzd003 = 'rdo_radiogroup_1.2' AND gzzd002 = g_dlang AND gzzd001 = 'abgq920'
   END CASE    
   LET l_curr_desc = l_curr_desc,":Y"

   LET l_periods_desc = ''
   CASE g_input.l_periods
      WHEN '1'
         SELECT gzzd005 INTO l_periods_desc FROM gzzd_t WHERE gzzd003 = 'cbo_l_periods.1' AND gzzd002 = g_dlang AND gzzd001 = 'abgq920'
      WHEN '2'
         SELECT gzzd005 INTO l_periods_desc FROM gzzd_t WHERE gzzd003 = 'cbo_l_periods.2' AND gzzd002 = g_dlang AND gzzd001 = 'abgq920'
      WHEN '3'
         SELECT gzzd005 INTO l_periods_desc FROM gzzd_t WHERE gzzd003 = 'cbo_l_periods.3' AND gzzd002 = g_dlang AND gzzd001 = 'abgq920'
   END CASE  

   #第一單身資料--------------------
   DELETE FROM abgq920_x01_tmp
   DELETE FROM abgq920_x01_tmp1
   LET l_i = 1
   FOR l_i = 1 TO g_bgie_d.getLength() 
      LET l_bgie0032_desc = ''   
      IF NOT cl_null(g_bgie_d[l_i].bgieseq) THEN
         LET l_bgie0032_desc = g_bgie_d[l_i].bgie003,':',g_bgie_d[l_i].bgie003_1_desc
      ELSE
         LET l_bgie0032_desc = g_bgie_d[l_i].bgie003_1_desc
      END IF
      LET l_bgie017_desc = ''
      LET l_bgie017_desc = s_desc_gzcbl004_desc('6013',g_bgie_d[l_i].bgie017)
      IF NOT cl_null(l_bgie017_desc) THEN
         LET l_bgie017_desc = g_bgie_d[l_i].bgie017,':',l_bgie017_desc
      ELSE
         LET l_bgie017_desc = g_bgie_d[l_i].bgie017
      END IF
      INSERT INTO abgq920_x01_tmp 
          VALUES(g_enterprise,l_bgie001_desc,l_bgie002,l_bgie003_desc,l_lowersite,l_bgie033_desc,
                 l_bgap004_desc,l_bgaa003,l_curr_desc,l_periods_desc,g_bgie_d[l_i].bgieseq,l_bgie0032_desc,
                 g_bgie_d[l_i].bgie004_desc,g_bgie_d[l_i].bgie007_desc,g_bgie_d[l_i].bgie008_desc,g_bgie_d[l_i].bgie009_desc,g_bgie_d[l_i].bgie010_desc,
                 g_bgie_d[l_i].bgie011_desc,g_bgie_d[l_i].bgie012_desc,g_bgie_d[l_i].bgie013_desc,g_bgie_d[l_i].bgie014_desc,g_bgie_d[l_i].bgie015_desc,
                 g_bgie_d[l_i].bgie016_desc,l_bgie017_desc,g_bgie_d[l_i].bgie018_desc,g_bgie_d[l_i].bgie019_desc,g_bgie_d[l_i].bgie100, 
                 g_bgie_d[l_i].l_begin_amt,g_bgie_d[l_i].l_bgie103_d,g_bgie_d[l_i].l_bgie103_c,g_bgie_d[l_i].l_sum)
                 
      IF NOT cl_null(g_bgie_d[l_i].bgieseq) THEN
         CALL abgq920_b_fill2xg(l_i)         
      END IF
   END FOR

END FUNCTION

################################################################################
# Descriptions...: 第二單身
# Memo...........:
# Usage..........: CALL abgq920_b_fill2xg(p_idx)
# Date & Author..: 161222 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq920_b_fill2xg(p_idx)
DEFINE p_idx              LIKE type_t.num5
DEFINE l_hsx_wc2          STRING               #bgie組核算項
DEFINE l_t040_hsx_wc      STRING               #bgbj組核算項
DEFINE l_bgie003_str      STRING
DEFINE l_sql              STRING
DEFINE l_begin_amt_sql    STRING
DEFINE l_bgac002          LIKE bgac_t.bgac002  
DEFINE l_bgie003          LIKE bgie_t.bgie003  
DEFINE l_amt_d            LIKE bgie_t.bgie103  
DEFINE l_amt_c            LIKE bgie_t.bgie103  
#DEFINE l_bgae002          LIKE bgae_t.bgae002   #170104-00017#3 mark
DEFINE l_yymm             LIKE type_t.chr100   
DEFINE l_abg_yy           LIKE type_t.chr100   #預算週期當年年度
DEFINE l_yy               LIKE type_t.chr100   #來源資料年度
DEFINE l_mm               LIKE type_t.chr100   #來源資料月份
DEFINE l_sum_bgbj033      LIKE bgie_t.bgie103 
DEFINE l_amt              LIKE bgie_t.bgie103 
DEFINE l_seq              LIKE type_t.num5
DEFINE l_tmp              RECORD
         l_bgieseq2       LIKE bgie_t.bgieseq, #連接第一單身
         bgieseq          LIKE bgie_t.bgieseq, 
         bgie003_2_desc   LIKE type_t.chr100, 
         l_begin_amt1     LIKE type_t.num20_6,
         l_amt_1          LIKE type_t.num20_6, 
         l_amt_2          LIKE type_t.num20_6, 
         l_amt_3          LIKE type_t.num20_6, 
         l_amt_4          LIKE type_t.num20_6, 
         l_amt_5          LIKE type_t.num20_6, 
         l_amt_6          LIKE type_t.num20_6, 
         l_amt_7          LIKE type_t.num20_6, 
         l_amt_8          LIKE type_t.num20_6, 
         l_amt_9          LIKE type_t.num20_6, 
         l_amt_10         LIKE type_t.num20_6, 
         l_amt_11         LIKE type_t.num20_6, 
         l_amt_12         LIKE type_t.num20_6, 
         l_amt_13         LIKE type_t.num20_6, 
         l_amt_14         LIKE type_t.num20_6, 
         l_amt_sum        LIKE type_t.num20_6
                          END RECORD
DEFINE l_bgie033_str      STRING               #170104-00017#3 add                          


   IF cl_null(p_idx) OR p_idx <= 0 THEN RETURN END IF
  
   ##前置資料-----------------------------------------------------
   #取得核算項條件
   LET l_hsx_wc2 = ''
   LET l_t040_hsx_wc = ''
   CALL abgq920_get_hsx_wc(p_idx) RETURNING l_hsx_wc2,l_t040_hsx_wc
              
   LET l_bgie003_str = g_bgie003
   LET l_bgie003_str = "('",l_bgie003_str,"')" 
           
   #預算週期當年年度
   LET l_bgac002 = ''
   SELECT MIN(bgac002) INTO l_bgac002  FROM bgac_t 
    WHERE bgacent = g_enterprise AND bgac001 = (SELECT bgaa002 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_input.bgie001)           
            
   #撈取組織資料      
   LET l_sql = " SELECT UNIQUE bgie003 ",
               "   FROM abgq920_tmp ",
               "  WHERE bgieent = ",g_enterprise,"  ",
               "    AND ",l_hsx_wc2," ",
               "    AND bgie003 IN ",l_bgie003_str," ",
               "    AND bgie100 = '",g_bgie_d[p_idx].bgie100,"' "
   PREPARE abgq920_p3 FROM l_sql
   DECLARE abgq920_pc3 CURSOR FOR abgq920_p3             
            
   #撈出各期別金額           
   LET l_sql = " SELECT l_yymm,SUM(l_amt_d),SUM(l_amt_c) ",
               "   FROM abgq920_tmp ",
               "  WHERE bgieent = ",g_enterprise,"  ",
               "    AND ",l_hsx_wc2," ",
               "    AND bgie003 = ? ",
               "    AND bgie100 = '",g_bgie_d[p_idx].bgie100,"' ",
               "  GROUP BY l_yymm ",
               "  ORDER BY l_yymm "
   
   PREPARE abgq920_p4 FROM l_sql
   DECLARE abgq920_c4 CURSOR FOR abgq920_p4              
  
   #170104-00017#3 --s mark
   ##借貸方向 1.借方 2.貸方            
   #LET l_bgae002 = ''  
   #SELECT bgae002 INTO l_bgae002
   #  FROM bgae_t
   # WHERE bgaeent = g_enterprise 
   #   AND bgae006 = (SELECT bgaa008 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_input.bgie001 AND bgaastus = 'Y')
   #   AND bgae001 = g_bgie_d[p_idx].bgie004            
   #170104-00017#3 --e mark
      
   #170104-00017#3 --s add
   #期初金額
   LET l_bgie033_str = ' 1=1'
   IF g_input.l_bgie033 = '1' THEN 
      #1.AR應收
      LET l_bgie033_str = " bgbj003 IN (SELECT bgae001 FROM bgae_t WHERE bgaeent = ",g_enterprise," ",
                          "                AND bgae006 = (SELECT bgaa008 FROM bgaa_t  WHERE bgaaent = ",g_enterprise," ",
                          "                AND bgaa001 = '",g_input.bgie001,"' AND bgaastus = 'Y')AND bgae008 = '71') " 
   ELSE
      #2.AP應付
      LET l_bgie033_str = " bgbj003 IN (SELECT bgae001 FROM bgae_t WHERE bgaeent = ",g_enterprise," ",
                          "                AND bgae006 = (SELECT bgaa008 FROM bgaa_t  WHERE bgaaent = ",g_enterprise," ",
                          "                AND bgaa001 = '",g_input.bgie001,"' AND bgaastus = 'Y')AND bgae008 = '72') " 
   END IF 
   
   LET l_begin_amt_sql = " SELECT CASE '",g_input.l_curr,"' WHEN '1' THEN SUM(bgbj032) ELSE SUM(bgbj033) END ",
                         "   FROM bgbj_t ",
                         "  WHERE bgbjent = ",g_enterprise,"  ",
                         "    AND bgbj001 = '",g_input.bgie001,"'  ",
                         "    AND bgbj002 = ? ",
                         "    AND ",l_bgie033_str," ", #類型 
                         "    AND bgbj028 = '",g_bgie_d[p_idx].bgie100,"' "
                         
   IF NOT cl_null(g_hsx_wc) THEN
      LET l_begin_amt_sql = l_begin_amt_sql," AND ",l_t040_hsx_wc #核算項
   END IF

   PREPARE l_begin_amt_pre1 FROM l_begin_amt_sql   
   #170104-00017#3 --e add
      
      
   ##-----------------------------------------------------------
 
   LET l_bgie003 = ''
   LET l_seq = 1
   FOREACH abgq920_pc3 INTO l_bgie003 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:abgq920_pc3"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF      
      
      LET l_tmp.bgieseq = l_seq
      LET l_tmp.bgie003_2_desc = l_bgie003,":",s_desc_get_department_desc(l_bgie003)
      
      #SQL FOR 期初金額
      LET l_sum_bgbj033 = 0
      #170104-00017#3 --s mark
      #LET l_begin_amt_sql = " SELECT CASE '",g_input.l_curr,"' WHEN '1' THEN SUM(bgbj032) ELSE SUM(bgbj033) END ",
      #                      "   FROM bgbj_t ",
      #                      "  WHERE bgbjent = ",g_enterprise,"  ",
      #                      "    AND bgbj001 = '",g_input.bgie001,"'  ",
      #                      "    AND bgbj002 = '",l_bgie003,"' ",
      #                      "    AND ",l_t040_hsx_wc," ", #核算項
      #                      "    AND bgbj028 = '",g_bgie_d[p_idx].bgie100,"' "
      #PREPARE l_begin_amt_pre1 FROM l_begin_amt_sql  
      #EXECUTE l_begin_amt_pre1 INTO l_sum_bgbj033
      #170104-00017#3 --e mark      
      
      EXECUTE l_begin_amt_pre1 USING l_bgie003 INTO l_sum_bgbj033  #170104-00017#3 add
      IF cl_null(l_sum_bgbj033)THEN LET l_sum_bgbj033 = 0 END IF          
      LET l_tmp.l_begin_amt1 =  l_sum_bgbj033    

      LET l_tmp.l_amt_1 = 0
      LET l_tmp.l_amt_2 = 0
      LET l_tmp.l_amt_3 = 0
      LET l_tmp.l_amt_4 = 0
      LET l_tmp.l_amt_5 = 0
      LET l_tmp.l_amt_6 = 0
      LET l_tmp.l_amt_7 = 0
      LET l_tmp.l_amt_8 = 0
      LET l_tmp.l_amt_9 = 0
      LET l_tmp.l_amt_10 = 0
      LET l_tmp.l_amt_11 = 0
      LET l_tmp.l_amt_12 = 0
      LET l_tmp.l_amt_13 = 0
      LET l_tmp.l_amt_14 = 0  
         
      FOREACH abgq920_c4 USING l_bgie003 INTO l_yymm,l_amt_d,l_amt_c 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:abgq920_c4" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         IF cl_null(l_amt_d) THEN LET l_amt_d = 0 END IF
         IF cl_null(l_amt_c) THEN LET l_amt_c = 0 END IF
 
         LET l_amt = 0
         #170104-00017#3 --s mark
         #IF l_bgae002 = '1' THEN
         #   LET l_amt = l_amt_d - l_amt_c
         #ELSE
         #   LET l_amt = l_amt_c - l_amt_d
         #END IF          
         #170104-00017#3 --e mark
         LET l_amt = l_amt_c + l_amt_d #170104-00017#3 add
         
         LET l_yymm = l_yymm CLIPPED,"/01"
         LET l_yy = YEAR(l_yymm)
         LET l_mm = MONTH(l_yymm)
         LET l_abg_yy = YEAR(l_bgac002)
         
         IF l_yy = l_abg_yy THEN
            CASE l_mm
               WHEN 1  LET l_tmp.l_amt_1  =  l_amt 
               WHEN 2  LET l_tmp.l_amt_2  =  l_amt 
               WHEN 3  LET l_tmp.l_amt_3  =  l_amt 
               WHEN 4  LET l_tmp.l_amt_4  =  l_amt 
               WHEN 5  LET l_tmp.l_amt_5  =  l_amt 
               WHEN 6  LET l_tmp.l_amt_6  =  l_amt 
               WHEN 7  LET l_tmp.l_amt_7  =  l_amt 
               WHEN 8  LET l_tmp.l_amt_8  =  l_amt 
               WHEN 9  LET l_tmp.l_amt_9  =  l_amt 
               WHEN 10 LET l_tmp.l_amt_10 =  l_amt 
               WHEN 11 LET l_tmp.l_amt_11 =  l_amt 
               WHEN 12 LET l_tmp.l_amt_12 =  l_amt 
               WHEN 13 LET l_tmp.l_amt_13 =  l_amt 
            END CASE             
         ELSE
            LET l_tmp.l_amt_14 = l_amt 
         END IF
      END FOREACH      
 
      LET l_tmp.l_amt_sum = l_tmp.l_begin_amt1 + l_tmp.l_amt_1 + l_tmp.l_amt_2 + 
                                      l_tmp.l_amt_3 + l_tmp.l_amt_4 + l_tmp.l_amt_5 + 
                                      l_tmp.l_amt_6 + l_tmp.l_amt_7 + l_tmp.l_amt_8 + 
                                      l_tmp.l_amt_9 + l_tmp.l_amt_10 + l_tmp.l_amt_11 + 
                                      l_tmp.l_amt_12 + l_tmp.l_amt_13 + l_tmp.l_amt_14
      #寫入子報表
      INSERT INTO abgq920_x01_tmp1 
          VALUES(p_idx,l_tmp.bgieseq,l_tmp.bgie003_2_desc,l_tmp.l_begin_amt1,
                 l_tmp.l_amt_1,l_tmp.l_amt_2,l_tmp.l_amt_3,l_tmp.l_amt_4,
                 l_tmp.l_amt_5,l_tmp.l_amt_6,l_tmp.l_amt_7,l_tmp.l_amt_8,
                 l_tmp.l_amt_9,l_tmp.l_amt_10,l_tmp.l_amt_11,l_tmp.l_amt_12,
                 l_tmp.l_amt_13,l_tmp.l_amt_14,l_tmp.l_amt_sum)

      LET l_seq = l_seq +1
   END FOREACH   


END FUNCTION

 
{</section>}
 
