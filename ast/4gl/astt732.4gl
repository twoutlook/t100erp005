#該程式未解開Section, 採用最新樣板產出!
{<section id="astt732.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2015-12-25 15:21:12), PR版次:0004(2016-10-25 10:04:37)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000067
#+ Filename...: astt732
#+ Description: 內部結算底稿查詢作業
#+ Creator....: 03247(2014-11-21 10:51:11)
#+ Modifier...: 06189 -SD/PR- 08172
 
{</section>}
 
{<section id="astt732.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#161024-00025#4   2016/10/24 by 08172   组织调整
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
PRIVATE TYPE type_g_stdf_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   stdfstus LIKE stdf_t.stdfstus, 
   stdfsite LIKE stdf_t.stdfsite, 
   stdfsite_desc LIKE type_t.chr500, 
   stdf001 LIKE stdf_t.stdf001, 
   stdf001_desc LIKE type_t.chr500, 
   stdf002 LIKE stdf_t.stdf002, 
   stdf003 LIKE stdf_t.stdf003, 
   stdf004 LIKE stdf_t.stdf004, 
   ltype LIKE type_t.chr500, 
   stdf005 LIKE stdf_t.stdf005, 
   stdf006 LIKE stdf_t.stdf006, 
   stdf007 LIKE stdf_t.stdf007, 
   stdf037 LIKE stdf_t.stdf037, 
   stdf038 LIKE stdf_t.stdf038, 
   stdf008 LIKE stdf_t.stdf008, 
   stdf008_desc LIKE type_t.chr500, 
   stdf008_desc_desc LIKE type_t.chr500, 
   stdf009 LIKE stdf_t.stdf009, 
   stdf010 LIKE stdf_t.stdf010, 
   stdf011 LIKE stdf_t.stdf011, 
   stdf011_desc LIKE type_t.chr500, 
   stdf012 LIKE stdf_t.stdf012, 
   stdf013 LIKE stdf_t.stdf013, 
   stdf013_desc LIKE type_t.chr500, 
   stdf014 LIKE stdf_t.stdf014, 
   stdf014_desc LIKE type_t.chr500, 
   stdf015 LIKE stdf_t.stdf015, 
   stdf015_desc LIKE type_t.chr500, 
   stdf016 LIKE stdf_t.stdf016, 
   stdf017 LIKE stdf_t.stdf017, 
   stdf018 LIKE stdf_t.stdf018, 
   stdf019 LIKE stdf_t.stdf019, 
   stdf029 LIKE stdf_t.stdf029, 
   stdf030 LIKE stdf_t.stdf030, 
   stdf031 LIKE stdf_t.stdf031, 
   stdf032 LIKE stdf_t.stdf032, 
   stdf033 LIKE stdf_t.stdf033, 
   stdf034 LIKE stdf_t.stdf034, 
   stdf020 LIKE stdf_t.stdf020, 
   stdf020_desc LIKE type_t.chr500, 
   stdf021 LIKE stdf_t.stdf021, 
   stdf021_desc LIKE type_t.chr500, 
   stdf022 LIKE stdf_t.stdf022, 
   stdf022_desc LIKE type_t.chr500, 
   stdf023 LIKE stdf_t.stdf023, 
   stdf023_desc LIKE type_t.chr500, 
   stdf024 LIKE stdf_t.stdf024, 
   stdf024_desc LIKE type_t.chr500, 
   stdf025 LIKE stdf_t.stdf025, 
   stdf025_desc LIKE type_t.chr500, 
   stdf026 LIKE stdf_t.stdf026, 
   stdf026_desc LIKE type_t.chr500, 
   stdf027 LIKE stdf_t.stdf027, 
   stdf027_desc LIKE type_t.chr500, 
   stdf039 LIKE stdf_t.stdf039, 
   stdf039_desc LIKE type_t.chr500, 
   stdf040 LIKE stdf_t.stdf040, 
   stdf040_desc LIKE type_t.chr500, 
   stdf041 LIKE stdf_t.stdf041, 
   stdf041_desc LIKE type_t.chr500, 
   stdf028 LIKE stdf_t.stdf028, 
   stdf035 LIKE stdf_t.stdf035, 
   stdf036 LIKE stdf_t.stdf036 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_stdf2_d RECORD
   stde001 LIKE stde_t.stde001,
   stde001_desc LIKE type_t.chr500,
   stde002 LIKE stde_t.stde002, 
   stde003 LIKE stde_t.stde003, 
   stde004 LIKE stde_t.stde004, 
   stde005 LIKE stde_t.stde005, 
   stde006 LIKE stde_t.stde006, 
   stde007 LIKE stde_t.stde007, 
   stde008 LIKE stde_t.stde008,
   stde008_desc LIKE type_t.chr500, 
   stde008_desc_desc LIKE type_t.chr500, 
   stde009 LIKE stde_t.stde009, 
   stde010 LIKE stde_t.stde010, 
   stde011 LIKE stde_t.stde011, 
   stde011_desc LIKE type_t.chr500,
   stde012 LIKE stde_t.stde012, 
   stde013 LIKE stde_t.stde013,
   stde013_desc LIKE type_t.chr500,   
   stde014 LIKE stde_t.stde014, 
   stde014_desc LIKE type_t.chr500,
   stde015 LIKE stde_t.stde015, 
   stde015_desc LIKE type_t.chr500,
   stde016 LIKE stde_t.stde016, 
   stde017 LIKE stde_t.stde017, 
   stde018 LIKE stde_t.stde018, 
   stde019 LIKE stde_t.stde019, 
   stde020 LIKE stde_t.stde020, 
   stde020_desc LIKE type_t.chr500,
   stde021 LIKE stde_t.stde021, 
   stde021_desc LIKE type_t.chr500,
   stde022 LIKE stde_t.stde022, 
   stde022_desc LIKE type_t.chr500,
   stde023 LIKE stde_t.stde023, 
   stde023_desc LIKE type_t.chr500,
   stde024 LIKE stde_t.stde024, 
   stde024_desc LIKE type_t.chr500,
   stde025 LIKE stde_t.stde025, 
   stde025_desc LIKE type_t.chr500,
   stde026 LIKE stde_t.stde026, 
   stde026_desc LIKE type_t.chr500,
   stde027 LIKE stde_t.stde027, 
   stde027_desc LIKE type_t.chr500,
   stde028 LIKE stde_t.stde028, 
   stde029 LIKE stde_t.stde029, 
   stde030 LIKE stde_t.stde030, 
   stdestus LIKE stde_t.stdestus
       END RECORD
 
 TYPE type_g_stdf3_d RECORD
   inaj201 LIKE inaj_t.inaj201, 
   inaj202 LIKE inaj_t.inaj202, 
   inaj001 LIKE inaj_t.inaj001, 
   inaj002 LIKE inaj_t.inaj002, 
   inaj003 LIKE inaj_t.inaj003,          #add by geza 20151218 
   inaj004 LIKE inaj_t.inaj004,          #add by geza 20151218  
   inaj005 LIKE inaj_t.inaj005,
   inaj005_desc LIKE type_t.chr500,
   inaj005_desc_desc LIKE type_t.chr500, 
   inaj211 LIKE inaj_t.inaj211,          #add by geza 20151218
   inaj211_desc LIKE type_t.chr500,      #add by geza 20151218
   inaj008 LIKE inaj_t.inaj008, 
   inaj008_desc LIKE type_t.chr500,
   inaj203 LIKE inaj_t.inaj203, 
   inaj203_desc LIKE type_t.chr500,
   inaj204 LIKE inaj_t.inaj204, 
   inaj204_desc LIKE type_t.chr500,
   inaj012 LIKE inaj_t.inaj012,  
   inaj012_desc LIKE type_t.chr500,
   inaj011 LIKE inaj_t.inaj011, 
   inaj210 LIKE inaj_t.inaj210,          #add by geza 20151218
   inaj205 LIKE inaj_t.inaj205, 
   inaj206 LIKE inaj_t.inaj206, 
   inajsite LIKE inaj_t.inajsite, 
   inajsite_desc LIKE type_t.chr500,
   inaj207 LIKE inaj_t.inaj207, 
   inaj207_desc LIKE type_t.chr500,
   inaj208 LIKE inaj_t.inaj208, 
   inaj208_desc LIKE type_t.chr500,
   inaj209 LIKE inaj_t.inaj209,
   inaj209_desc LIKE type_t.chr500
       END RECORD
       
DEFINE g_stdf2_d   DYNAMIC ARRAY OF type_g_stdf2_d
DEFINE g_stdf2_d_t type_g_stdf2_d
 
DEFINE g_stdf3_d   DYNAMIC ARRAY OF type_g_stdf3_d
DEFINE g_stdf3_d_t type_g_stdf3_d
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_stdf_d
DEFINE g_master_t                   type_g_stdf_d
DEFINE g_stdf_d          DYNAMIC ARRAY OF type_g_stdf_d
DEFINE g_stdf_d_t        type_g_stdf_d
 
      
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
 
{<section id="astt732.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
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
   DECLARE astt732_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE astt732_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astt732_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astt732 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astt732_init()   
 
      #進入選單 Menu (="N")
      CALL astt732_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_astt732
      
   END IF 
   
   CLOSE astt732_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#5  By benson 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="astt732.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION astt732_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("b_stdf003",'6082')
   CALL cl_set_combo_scc("b_stdf004",'6083')
   CALL cl_set_combo_scc("b_stde003",'6082')
   CALL cl_set_combo_scc("b_stde004",'6083')
   CALL cl_set_combo_scc("b_stdestus",'6084')
   CALL cl_set_combo_scc("b_inaj201",'6082')
   CALL cl_set_combo_scc("b_inaj202",'6083')
   CALL cl_set_combo_scc("b_ltype",'6737')
   CALL cl_set_combo_scc("b_stdfstus",'6704')  #add by geza 20151218
   CALL cl_set_combo_scc("b_stdf035",'6882')  #add by geza 20151218
   CALL cl_set_combo_scc("b_stdf036",'6737')  #add by geza 20151225
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#5  By benson 150309
   #end add-point
 
   CALL astt732_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="astt732.default_search" >}
PRIVATE FUNCTION astt732_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " stdfsite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " stdf006 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " stdf007 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " stdf037 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " stdf038 = '", g_argv[05], "' AND "
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
 
{<section id="astt732.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION astt732_ui_dialog()
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
      CALL astt732_b_fill()
   ELSE
      CALL astt732_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_stdf_d.clear()
 
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
 
         CALL astt732_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_stdf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL astt732_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL astt732_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_stdf2_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_stdf2_d.getLength() TO FORMONLY.h_count
               #add-point:input段before row

               #end add-point 
 
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
         DISPLAY ARRAY g_stdf3_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_stdf3_d.getLength() TO FORMONLY.h_count
               #add-point:input段before row

               #end add-point 
 
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL astt732_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
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
               CALL astt732_query()
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
            CALL astt732_filter()
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
            CALL astt732_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_stdf_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_stdf3_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_stdf2_d)
               LET g_export_id[3]   = "s_detail3"
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
            CALL astt732_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL astt732_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL astt732_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL astt732_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_stdf_d.getLength()
               LET g_stdf_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_stdf_d.getLength()
               LET g_stdf_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_stdf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_stdf_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_stdf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_stdf_d[li_idx].sel = "N"
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
 
{<section id="astt732.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION astt732_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   CALL g_stdf2_d.clear()  #add by geza 20151225
   CALL g_stdf3_d.clear()  #add by geza 20151225
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_stdf_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON stdfstus,stdfsite,stdf001,stdf002,stdf003,stdf004,stdf005,stdf006,stdf007, 
          stdf037,stdf038,stdf008,stdf009,stdf010,stdf011,stdf012,stdf013,stdf014,stdf015,stdf016,stdf017, 
          stdf018,stdf019,stdf029,stdf030,stdf031,stdf032,stdf033,stdf034,stdf020,stdf021,stdf022,stdf023, 
          stdf024,stdf025,stdf026,stdf027,stdf039,stdf040,stdf041,stdf028,stdf035,stdf036
           FROM s_detail1[1].b_stdfstus,s_detail1[1].b_stdfsite,s_detail1[1].b_stdf001,s_detail1[1].b_stdf002, 
               s_detail1[1].b_stdf003,s_detail1[1].b_stdf004,s_detail1[1].b_stdf005,s_detail1[1].b_stdf006, 
               s_detail1[1].b_stdf007,s_detail1[1].b_stdf037,s_detail1[1].b_stdf038,s_detail1[1].b_stdf008, 
               s_detail1[1].b_stdf009,s_detail1[1].b_stdf010,s_detail1[1].b_stdf011,s_detail1[1].b_stdf012, 
               s_detail1[1].b_stdf013,s_detail1[1].b_stdf014,s_detail1[1].b_stdf015,s_detail1[1].b_stdf016, 
               s_detail1[1].b_stdf017,s_detail1[1].b_stdf018,s_detail1[1].b_stdf019,s_detail1[1].b_stdf029, 
               s_detail1[1].b_stdf030,s_detail1[1].b_stdf031,s_detail1[1].b_stdf032,s_detail1[1].b_stdf033, 
               s_detail1[1].b_stdf034,s_detail1[1].b_stdf020,s_detail1[1].b_stdf021,s_detail1[1].b_stdf022, 
               s_detail1[1].b_stdf023,s_detail1[1].b_stdf024,s_detail1[1].b_stdf025,s_detail1[1].b_stdf026, 
               s_detail1[1].b_stdf027,s_detail1[1].b_stdf039,s_detail1[1].b_stdf040,s_detail1[1].b_stdf041, 
               s_detail1[1].b_stdf028,s_detail1[1].b_stdf035,s_detail1[1].b_stdf036
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<stdfcrtdt>>----
         #AFTER FIELD stdfcrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<stdfmoddt>>----
         #AFTER FIELD stdfmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stdfcnfdt>>----
         #AFTER FIELD stdfcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stdfpstdt>>----
         #AFTER FIELD stdfpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_stdfstus>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdfstus
            #add-point:BEFORE FIELD b_stdfstus name="construct.b.page1.b_stdfstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdfstus
            
            #add-point:AFTER FIELD b_stdfstus name="construct.a.page1.b_stdfstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdfstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdfstus
            #add-point:ON ACTION controlp INFIELD b_stdfstus name="construct.c.page1.b_stdfstus"
            
            #END add-point
 
 
         #----<<b_stdfsite>>----
         #Ctrlp:construct.c.page1.b_stdfsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdfsite
            #add-point:ON ACTION controlp INFIELD b_stdfsite name="construct.c.page1.b_stdfsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stdfsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdfsite  #顯示到畫面上
            NEXT FIELD b_stdfsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdfsite
            #add-point:BEFORE FIELD b_stdfsite name="construct.b.page1.b_stdfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdfsite
            
            #add-point:AFTER FIELD b_stdfsite name="construct.a.page1.b_stdfsite"
            
            #END add-point
            
 
 
         #----<<b_stdfsite_desc>>----
         #----<<b_stdf001>>----
         #Ctrlp:construct.c.page1.b_stdf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf001
            #add-point:ON ACTION controlp INFIELD b_stdf001 name="construct.c.page1.b_stdf001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " ooef212 = 'Y' "
#            CALL q_ooef001()                           #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stdf001') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stdf001',g_site,'c')   #150308-00001#5  By benson add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef212 = 'Y' "
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO b_stdf001  #顯示到畫面上
            NEXT FIELD b_stdf001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf001
            #add-point:BEFORE FIELD b_stdf001 name="construct.b.page1.b_stdf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf001
            
            #add-point:AFTER FIELD b_stdf001 name="construct.a.page1.b_stdf001"
            
            #END add-point
            
 
 
         #----<<b_stdf001_desc>>----
         #----<<b_stdf002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf002
            #add-point:BEFORE FIELD b_stdf002 name="construct.b.page1.b_stdf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf002
            
            #add-point:AFTER FIELD b_stdf002 name="construct.a.page1.b_stdf002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf002
            #add-point:ON ACTION controlp INFIELD b_stdf002 name="construct.c.page1.b_stdf002"
            
            #END add-point
 
 
         #----<<b_stdf003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf003
            #add-point:BEFORE FIELD b_stdf003 name="construct.b.page1.b_stdf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf003
            
            #add-point:AFTER FIELD b_stdf003 name="construct.a.page1.b_stdf003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf003
            #add-point:ON ACTION controlp INFIELD b_stdf003 name="construct.c.page1.b_stdf003"
            
            #END add-point
 
 
         #----<<b_stdf004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf004
            #add-point:BEFORE FIELD b_stdf004 name="construct.b.page1.b_stdf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf004
            
            #add-point:AFTER FIELD b_stdf004 name="construct.a.page1.b_stdf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf004
            #add-point:ON ACTION controlp INFIELD b_stdf004 name="construct.c.page1.b_stdf004"
            
            #END add-point
 
 
         #----<<b_ltype>>----
         #----<<b_stdf005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf005
            #add-point:BEFORE FIELD b_stdf005 name="construct.b.page1.b_stdf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf005
            
            #add-point:AFTER FIELD b_stdf005 name="construct.a.page1.b_stdf005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf005
            #add-point:ON ACTION controlp INFIELD b_stdf005 name="construct.c.page1.b_stdf005"
            
            #END add-point
 
 
         #----<<b_stdf006>>----
         #Ctrlp:construct.c.page1.b_stdf006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf006
            #add-point:ON ACTION controlp INFIELD b_stdf006 name="construct.c.page1.b_stdf006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_stdf006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf006  #顯示到畫面上
            NEXT FIELD b_stdf006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf006
            #add-point:BEFORE FIELD b_stdf006 name="construct.b.page1.b_stdf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf006
            
            #add-point:AFTER FIELD b_stdf006 name="construct.a.page1.b_stdf006"
            
            #END add-point
            
 
 
         #----<<b_stdf007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf007
            #add-point:BEFORE FIELD b_stdf007 name="construct.b.page1.b_stdf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf007
            
            #add-point:AFTER FIELD b_stdf007 name="construct.a.page1.b_stdf007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf007
            #add-point:ON ACTION controlp INFIELD b_stdf007 name="construct.c.page1.b_stdf007"
            
            #END add-point
 
 
         #----<<b_stdf037>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf037
            #add-point:BEFORE FIELD b_stdf037 name="construct.b.page1.b_stdf037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf037
            
            #add-point:AFTER FIELD b_stdf037 name="construct.a.page1.b_stdf037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf037
            #add-point:ON ACTION controlp INFIELD b_stdf037 name="construct.c.page1.b_stdf037"
            
            #END add-point
 
 
         #----<<b_stdf038>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf038
            #add-point:BEFORE FIELD b_stdf038 name="construct.b.page1.b_stdf038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf038
            
            #add-point:AFTER FIELD b_stdf038 name="construct.a.page1.b_stdf038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf038
            #add-point:ON ACTION controlp INFIELD b_stdf038 name="construct.c.page1.b_stdf038"
            
            #END add-point
 
 
         #----<<b_stdf008>>----
         #Ctrlp:construct.c.page1.b_stdf008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf008
            #add-point:ON ACTION controlp INFIELD b_stdf008 name="construct.c.page1.b_stdf008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf008  #顯示到畫面上
            NEXT FIELD b_stdf008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf008
            #add-point:BEFORE FIELD b_stdf008 name="construct.b.page1.b_stdf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf008
            
            #add-point:AFTER FIELD b_stdf008 name="construct.a.page1.b_stdf008"
            
            #END add-point
            
 
 
         #----<<b_stdf008_desc>>----
         #----<<b_stdf008_desc_desc>>----
         #----<<b_stdf009>>----
         #Ctrlp:construct.c.page1.b_stdf009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf009
            #add-point:ON ACTION controlp INFIELD b_stdf009 name="construct.c.page1.b_stdf009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf009  #顯示到畫面上
            NEXT FIELD b_stdf009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf009
            #add-point:BEFORE FIELD b_stdf009 name="construct.b.page1.b_stdf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf009
            
            #add-point:AFTER FIELD b_stdf009 name="construct.a.page1.b_stdf009"
            
            #END add-point
            
 
 
         #----<<b_stdf010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf010
            #add-point:BEFORE FIELD b_stdf010 name="construct.b.page1.b_stdf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf010
            
            #add-point:AFTER FIELD b_stdf010 name="construct.a.page1.b_stdf010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf010
            #add-point:ON ACTION controlp INFIELD b_stdf010 name="construct.c.page1.b_stdf010"
            
            #END add-point
 
 
         #----<<b_stdf011>>----
         #Ctrlp:construct.c.page1.b_stdf011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf011
            #add-point:ON ACTION controlp INFIELD b_stdf011 name="construct.c.page1.b_stdf011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf011  #顯示到畫面上
            NEXT FIELD b_stdf011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf011
            #add-point:BEFORE FIELD b_stdf011 name="construct.b.page1.b_stdf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf011
            
            #add-point:AFTER FIELD b_stdf011 name="construct.a.page1.b_stdf011"
            
            #END add-point
            
 
 
         #----<<b_stdf011_desc>>----
         #----<<b_stdf012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf012
            #add-point:BEFORE FIELD b_stdf012 name="construct.b.page1.b_stdf012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf012
            
            #add-point:AFTER FIELD b_stdf012 name="construct.a.page1.b_stdf012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf012
            #add-point:ON ACTION controlp INFIELD b_stdf012 name="construct.c.page1.b_stdf012"
            
            #END add-point
 
 
         #----<<b_stdf013>>----
         #Ctrlp:construct.c.page1.b_stdf013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf013
            #add-point:ON ACTION controlp INFIELD b_stdf013 name="construct.c.page1.b_stdf013"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_stae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf013  #顯示到畫面上
            NEXT FIELD b_stdf013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf013
            #add-point:BEFORE FIELD b_stdf013 name="construct.b.page1.b_stdf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf013
            
            #add-point:AFTER FIELD b_stdf013 name="construct.a.page1.b_stdf013"
            
            #END add-point
            
 
 
         #----<<b_stdf013_desc>>----
         #----<<b_stdf014>>----
         #Ctrlp:construct.c.page1.b_stdf014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf014
            #add-point:ON ACTION controlp INFIELD b_stdf014 name="construct.c.page1.b_stdf014"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf014  #顯示到畫面上
            NEXT FIELD b_stdf014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf014
            #add-point:BEFORE FIELD b_stdf014 name="construct.b.page1.b_stdf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf014
            
            #add-point:AFTER FIELD b_stdf014 name="construct.a.page1.b_stdf014"
            
            #END add-point
            
 
 
         #----<<b_stdf014_desc>>----
         #----<<b_stdf015>>----
         #Ctrlp:construct.c.page1.b_stdf015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf015
            #add-point:ON ACTION controlp INFIELD b_stdf015 name="construct.c.page1.b_stdf015"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf015  #顯示到畫面上
            NEXT FIELD b_stdf015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf015
            #add-point:BEFORE FIELD b_stdf015 name="construct.b.page1.b_stdf015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf015
            
            #add-point:AFTER FIELD b_stdf015 name="construct.a.page1.b_stdf015"
            
            #END add-point
            
 
 
         #----<<b_stdf015_desc>>----
         #----<<b_stdf016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf016
            #add-point:BEFORE FIELD b_stdf016 name="construct.b.page1.b_stdf016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf016
            
            #add-point:AFTER FIELD b_stdf016 name="construct.a.page1.b_stdf016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf016
            #add-point:ON ACTION controlp INFIELD b_stdf016 name="construct.c.page1.b_stdf016"
            
            #END add-point
 
 
         #----<<b_stdf017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf017
            #add-point:BEFORE FIELD b_stdf017 name="construct.b.page1.b_stdf017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf017
            
            #add-point:AFTER FIELD b_stdf017 name="construct.a.page1.b_stdf017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf017
            #add-point:ON ACTION controlp INFIELD b_stdf017 name="construct.c.page1.b_stdf017"
            
            #END add-point
 
 
         #----<<b_stdf018>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf018
            #add-point:BEFORE FIELD b_stdf018 name="construct.b.page1.b_stdf018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf018
            
            #add-point:AFTER FIELD b_stdf018 name="construct.a.page1.b_stdf018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf018
            #add-point:ON ACTION controlp INFIELD b_stdf018 name="construct.c.page1.b_stdf018"
            
            #END add-point
 
 
         #----<<b_stdf019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf019
            #add-point:BEFORE FIELD b_stdf019 name="construct.b.page1.b_stdf019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf019
            
            #add-point:AFTER FIELD b_stdf019 name="construct.a.page1.b_stdf019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf019
            #add-point:ON ACTION controlp INFIELD b_stdf019 name="construct.c.page1.b_stdf019"
            
            #END add-point
 
 
         #----<<b_stdf029>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf029
            #add-point:BEFORE FIELD b_stdf029 name="construct.b.page1.b_stdf029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf029
            
            #add-point:AFTER FIELD b_stdf029 name="construct.a.page1.b_stdf029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf029
            #add-point:ON ACTION controlp INFIELD b_stdf029 name="construct.c.page1.b_stdf029"
            
            #END add-point
 
 
         #----<<b_stdf030>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf030
            #add-point:BEFORE FIELD b_stdf030 name="construct.b.page1.b_stdf030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf030
            
            #add-point:AFTER FIELD b_stdf030 name="construct.a.page1.b_stdf030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf030
            #add-point:ON ACTION controlp INFIELD b_stdf030 name="construct.c.page1.b_stdf030"
            
            #END add-point
 
 
         #----<<b_stdf031>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf031
            #add-point:BEFORE FIELD b_stdf031 name="construct.b.page1.b_stdf031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf031
            
            #add-point:AFTER FIELD b_stdf031 name="construct.a.page1.b_stdf031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf031
            #add-point:ON ACTION controlp INFIELD b_stdf031 name="construct.c.page1.b_stdf031"
            
            #END add-point
 
 
         #----<<b_stdf032>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf032
            #add-point:BEFORE FIELD b_stdf032 name="construct.b.page1.b_stdf032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf032
            
            #add-point:AFTER FIELD b_stdf032 name="construct.a.page1.b_stdf032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf032
            #add-point:ON ACTION controlp INFIELD b_stdf032 name="construct.c.page1.b_stdf032"
            
            #END add-point
 
 
         #----<<b_stdf033>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf033
            #add-point:BEFORE FIELD b_stdf033 name="construct.b.page1.b_stdf033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf033
            
            #add-point:AFTER FIELD b_stdf033 name="construct.a.page1.b_stdf033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf033
            #add-point:ON ACTION controlp INFIELD b_stdf033 name="construct.c.page1.b_stdf033"
            
            #END add-point
 
 
         #----<<b_stdf034>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf034
            #add-point:BEFORE FIELD b_stdf034 name="construct.b.page1.b_stdf034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf034
            
            #add-point:AFTER FIELD b_stdf034 name="construct.a.page1.b_stdf034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf034
            #add-point:ON ACTION controlp INFIELD b_stdf034 name="construct.c.page1.b_stdf034"
            
            #END add-point
 
 
         #----<<b_stdf020>>----
         #Ctrlp:construct.c.page1.b_stdf020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf020
            #add-point:ON ACTION controlp INFIELD b_stdf020 name="construct.c.page1.b_stdf020"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stdf020') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stdf020',g_site,'c')   #150308-00001#5  By benson add 'c'
               CALL q_ooef001_24()
            ELSE
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO b_stdf020  #顯示到畫面上
            NEXT FIELD b_stdf020                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf020
            #add-point:BEFORE FIELD b_stdf020 name="construct.b.page1.b_stdf020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf020
            
            #add-point:AFTER FIELD b_stdf020 name="construct.a.page1.b_stdf020"
            
            #END add-point
            
 
 
         #----<<b_stdf020_desc>>----
         #----<<b_stdf021>>----
         #Ctrlp:construct.c.page1.b_stdf021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf021
            #add-point:ON ACTION controlp INFIELD b_stdf021 name="construct.c.page1.b_stdf021"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161024-00025#4 -s by 08172
            LET g_qryparam.where = " ooef003='Y'"
            CALL q_ooef001_24()
#            CALL q_ooef001_2()                           #呼叫開窗
            #161024-00025#4 -e by 08172
            DISPLAY g_qryparam.return1 TO b_stdf021  #顯示到畫面上
            NEXT FIELD b_stdf021                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf021
            #add-point:BEFORE FIELD b_stdf021 name="construct.b.page1.b_stdf021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf021
            
            #add-point:AFTER FIELD b_stdf021 name="construct.a.page1.b_stdf021"
            
            #END add-point
            
 
 
         #----<<b_stdf021_desc>>----
         #----<<b_stdf022>>----
         #Ctrlp:construct.c.page1.b_stdf022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf022
            #add-point:ON ACTION controlp INFIELD b_stdf022 name="construct.c.page1.b_stdf022"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf022  #顯示到畫面上
            NEXT FIELD b_stdf022                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf022
            #add-point:BEFORE FIELD b_stdf022 name="construct.b.page1.b_stdf022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf022
            
            #add-point:AFTER FIELD b_stdf022 name="construct.a.page1.b_stdf022"
            
            #END add-point
            
 
 
         #----<<b_stdf022_desc>>----
         #----<<b_stdf023>>----
         #Ctrlp:construct.c.page1.b_stdf023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf023
            #add-point:ON ACTION controlp INFIELD b_stdf023 name="construct.c.page1.b_stdf023"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stdf023') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stdf023',g_site,'c')   #150308-00001#5  By benson add 'c'
               CALL q_ooef001_24()
            ELSE
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO b_stdf023  #顯示到畫面上
            NEXT FIELD b_stdf023                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf023
            #add-point:BEFORE FIELD b_stdf023 name="construct.b.page1.b_stdf023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf023
            
            #add-point:AFTER FIELD b_stdf023 name="construct.a.page1.b_stdf023"
            
            #END add-point
            
 
 
         #----<<b_stdf023_desc>>----
         #----<<b_stdf024>>----
         #Ctrlp:construct.c.page1.b_stdf024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf024
            #add-point:ON ACTION controlp INFIELD b_stdf024 name="construct.c.page1.b_stdf024"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161024-00025#4 -s by 08172
            LET g_qryparam.where = " ooef003='Y'"
            CALL q_ooef001_24()
#            CALL q_ooef001_2()                           #呼叫開窗
            #161024-00025#4 -e by 08172
            DISPLAY g_qryparam.return1 TO b_stdf024  #顯示到畫面上
            NEXT FIELD b_stdf024                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf024
            #add-point:BEFORE FIELD b_stdf024 name="construct.b.page1.b_stdf024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf024
            
            #add-point:AFTER FIELD b_stdf024 name="construct.a.page1.b_stdf024"
            
            #END add-point
            
 
 
         #----<<b_stdf024_desc>>----
         #----<<b_stdf025>>----
         #Ctrlp:construct.c.page1.b_stdf025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf025
            #add-point:ON ACTION controlp INFIELD b_stdf025 name="construct.c.page1.b_stdf025"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf025  #顯示到畫面上
            NEXT FIELD b_stdf025                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf025
            #add-point:BEFORE FIELD b_stdf025 name="construct.b.page1.b_stdf025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf025
            
            #add-point:AFTER FIELD b_stdf025 name="construct.a.page1.b_stdf025"
            
            #END add-point
            
 
 
         #----<<b_stdf025_desc>>----
         #----<<b_stdf026>>----
         #Ctrlp:construct.c.page1.b_stdf026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf026
            #add-point:ON ACTION controlp INFIELD b_stdf026 name="construct.c.page1.b_stdf026"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stdf026') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stdf026',g_site,'c')   #150308-00001#5  By benson add 'c'
               CALL q_ooef001_24()
            ELSE
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO b_stdf026  #顯示到畫面上
            NEXT FIELD b_stdf026                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf026
            #add-point:BEFORE FIELD b_stdf026 name="construct.b.page1.b_stdf026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf026
            
            #add-point:AFTER FIELD b_stdf026 name="construct.a.page1.b_stdf026"
            
            #END add-point
            
 
 
         #----<<b_stdf026_desc>>----
         #----<<b_stdf027>>----
         #Ctrlp:construct.c.page1.b_stdf027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf027
            #add-point:ON ACTION controlp INFIELD b_stdf027 name="construct.c.page1.b_stdf027"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161024-00025#4 -s by 08172
            LET g_qryparam.where = " ooef003='Y'"
            CALL q_ooef001_24()
#            CALL q_ooef001_2()                           #呼叫開窗
            #161024-00025#4 -e by 08172
            DISPLAY g_qryparam.return1 TO b_stdf027  #顯示到畫面上
            NEXT FIELD b_stdf027                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf027
            #add-point:BEFORE FIELD b_stdf027 name="construct.b.page1.b_stdf027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf027
            
            #add-point:AFTER FIELD b_stdf027 name="construct.a.page1.b_stdf027"
            
            #END add-point
            
 
 
         #----<<b_stdf027_desc>>----
         #----<<b_stdf039>>----
         #Ctrlp:construct.c.page1.b_stdf039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf039
            #add-point:ON ACTION controlp INFIELD b_stdf039 name="construct.c.page1.b_stdf039"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161024-00025#4 -s by 08172
            LET g_qryparam.where = " ooef003='Y'"
            CALL q_ooef001_24()
#            CALL q_ooef001_2()                           #呼叫開窗
            #161024-00025#4 -e by 08172
            DISPLAY g_qryparam.return1 TO b_stdf039  #顯示到畫面上
            NEXT FIELD b_stdf039                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf039
            #add-point:BEFORE FIELD b_stdf039 name="construct.b.page1.b_stdf039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf039
            
            #add-point:AFTER FIELD b_stdf039 name="construct.a.page1.b_stdf039"
            
            #END add-point
            
 
 
         #----<<b_stdf039_desc>>----
         #----<<b_stdf040>>----
         #Ctrlp:construct.c.page1.b_stdf040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf040
            #add-point:ON ACTION controlp INFIELD b_stdf040 name="construct.c.page1.b_stdf040"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'stdf040') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stdf040',g_site,'c')   #150308-00001#5  By benson add 'c'
               CALL q_ooef001_24()
            ELSE
               CALL q_ooef001()
            END IF                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf040  #顯示到畫面上
            NEXT FIELD b_stdf040                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf040
            #add-point:BEFORE FIELD b_stdf040 name="construct.b.page1.b_stdf040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf040
            
            #add-point:AFTER FIELD b_stdf040 name="construct.a.page1.b_stdf040"
            
            #END add-point
            
 
 
         #----<<b_stdf040_desc>>----
         #----<<b_stdf041>>----
         #Ctrlp:construct.c.page1.b_stdf041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf041
            #add-point:ON ACTION controlp INFIELD b_stdf041 name="construct.c.page1.b_stdf041"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161024-00025#4 -s by 08172
            LET g_qryparam.where = " ooef003='Y'"
            CALL q_ooef001_24()
#            CALL q_ooef001_2()                           #呼叫開窗
            #161024-00025#4 -e by 08172
            DISPLAY g_qryparam.return1 TO b_stdf041  #顯示到畫面上
            NEXT FIELD b_stdf041                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf041
            #add-point:BEFORE FIELD b_stdf041 name="construct.b.page1.b_stdf041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf041
            
            #add-point:AFTER FIELD b_stdf041 name="construct.a.page1.b_stdf041"
            
            #END add-point
            
 
 
         #----<<b_stdf041_desc>>----
         #----<<b_stdf028>>----
         #Ctrlp:construct.c.page1.b_stdf028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf028
            #add-point:ON ACTION controlp INFIELD b_stdf028 name="construct.c.page1.b_stdf028"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_stdb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf028  #顯示到畫面上
            NEXT FIELD b_stdf028                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf028
            #add-point:BEFORE FIELD b_stdf028 name="construct.b.page1.b_stdf028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf028
            
            #add-point:AFTER FIELD b_stdf028 name="construct.a.page1.b_stdf028"
            
            #END add-point
            
 
 
         #----<<b_stdf035>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf035
            #add-point:BEFORE FIELD b_stdf035 name="construct.b.page1.b_stdf035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf035
            
            #add-point:AFTER FIELD b_stdf035 name="construct.a.page1.b_stdf035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf035
            #add-point:ON ACTION controlp INFIELD b_stdf035 name="construct.c.page1.b_stdf035"
            
            #END add-point
 
 
         #----<<b_stdf036>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stdf036
            #add-point:BEFORE FIELD b_stdf036 name="construct.b.page1.b_stdf036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stdf036
            
            #add-point:AFTER FIELD b_stdf036 name="construct.a.page1.b_stdf036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stdf036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf036
            #add-point:ON ACTION controlp INFIELD b_stdf036 name="construct.c.page1.b_stdf036"
            
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
   CALL astt732_b_fill()
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
 
{<section id="astt732.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astt732_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where           STRING #add by geza 20151218
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #add by geza 20151218(S)
   CALL s_aooi500_sql_where(g_prog,'stdfsite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   #add by geza 20151218(E)
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',stdfstus,stdfsite,'',stdf001,'',stdf002,stdf003,stdf004,'',stdf005, 
       stdf006,stdf007,stdf037,stdf038,stdf008,'','',stdf009,stdf010,stdf011,'',stdf012,stdf013,'',stdf014, 
       '',stdf015,'',stdf016,stdf017,stdf018,stdf019,stdf029,stdf030,stdf031,stdf032,stdf033,stdf034, 
       stdf020,'',stdf021,'',stdf022,'',stdf023,'',stdf024,'',stdf025,'',stdf026,'',stdf027,'',stdf039, 
       '',stdf040,'',stdf041,'',stdf028,stdf035,stdf036  ,DENSE_RANK() OVER( ORDER BY stdf_t.stdfsite, 
       stdf_t.stdf006,stdf_t.stdf007,stdf_t.stdf037,stdf_t.stdf038) AS RANK FROM stdf_t",
 
 
                     "",
                     " WHERE stdfent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("stdf_t"),
                     " ORDER BY stdf_t.stdfsite,stdf_t.stdf006,stdf_t.stdf007,stdf_t.stdf037,stdf_t.stdf038"
 
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
 
   LET g_sql = "SELECT '',stdfstus,stdfsite,'',stdf001,'',stdf002,stdf003,stdf004,'',stdf005,stdf006, 
       stdf007,stdf037,stdf038,stdf008,'','',stdf009,stdf010,stdf011,'',stdf012,stdf013,'',stdf014,'', 
       stdf015,'',stdf016,stdf017,stdf018,stdf019,stdf029,stdf030,stdf031,stdf032,stdf033,stdf034,stdf020, 
       '',stdf021,'',stdf022,'',stdf023,'',stdf024,'',stdf025,'',stdf026,'',stdf027,'',stdf039,'',stdf040, 
       '',stdf041,'',stdf028,stdf035,stdf036",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #mark by geza 20151218(S)
#   IF NOT cl_null(ls_wc) AND ls_wc <> " 1=1" THEN
#      LET ls_wc2 = cl_replace_str(ls_wc,'stdf','stde')
#   END IF
#   LET g_sql = "SELECT  UNIQUE '',stdf001,'',stdf002,stdf003,stdf004,'',stdf005,stdf006,stdf007,stdf008, 
#       '','',stdf009,stdf010,stdf011,'',stdf012,stdf013,'',stdf014,'',stdf015,'',stdf016,stdf017,stdf018, 
#       stdf019,stdf020,'',stdf021,'',stdf022,'',stdf023,'',stdf024,'',stdf025,'',stdf026,'',stdf027, 
#       '',stdf028,stdfstus FROM stdf_t",
# 
# 
#               "",
#               " WHERE stdfent= ? AND 1=1 AND ", ls_wc,cl_sql_add_filter("stdf_t")
#   LET g_sql = g_sql," UNION ALL ",
#               " SELECT UNIQUE '',stde001,'',stde002,stde003,stde004,'',stde005,stde006,stde007,stde008, ",
#               "               '','',stde009,stde010,stde011,'',stde012,stde013,'',stde014,'',stde015,'',stde016,stde017,stde018, ",
#               "               stde019,stde020,'',stde021,'',stde022,'',stde023,'',stde024,'',stde025,'',stde026,'',stde027, ",
#               "               '',stde028,stdestus FROM stde_t ",
#               "  WHERE stdeent= '",g_enterprise,"' ",
#               "    AND stdestus = '2' AND ",ls_wc2,cl_sql_add_filter("stde_t")
#   LET g_sql = g_sql," ORDER BY stdf006,stdf007"
   #mark by geza 20151218(E)
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE astt732_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR astt732_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_stdf_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_stdf_d[l_ac].sel,g_stdf_d[l_ac].stdfstus,g_stdf_d[l_ac].stdfsite,g_stdf_d[l_ac].stdfsite_desc, 
       g_stdf_d[l_ac].stdf001,g_stdf_d[l_ac].stdf001_desc,g_stdf_d[l_ac].stdf002,g_stdf_d[l_ac].stdf003, 
       g_stdf_d[l_ac].stdf004,g_stdf_d[l_ac].ltype,g_stdf_d[l_ac].stdf005,g_stdf_d[l_ac].stdf006,g_stdf_d[l_ac].stdf007, 
       g_stdf_d[l_ac].stdf037,g_stdf_d[l_ac].stdf038,g_stdf_d[l_ac].stdf008,g_stdf_d[l_ac].stdf008_desc, 
       g_stdf_d[l_ac].stdf008_desc_desc,g_stdf_d[l_ac].stdf009,g_stdf_d[l_ac].stdf010,g_stdf_d[l_ac].stdf011, 
       g_stdf_d[l_ac].stdf011_desc,g_stdf_d[l_ac].stdf012,g_stdf_d[l_ac].stdf013,g_stdf_d[l_ac].stdf013_desc, 
       g_stdf_d[l_ac].stdf014,g_stdf_d[l_ac].stdf014_desc,g_stdf_d[l_ac].stdf015,g_stdf_d[l_ac].stdf015_desc, 
       g_stdf_d[l_ac].stdf016,g_stdf_d[l_ac].stdf017,g_stdf_d[l_ac].stdf018,g_stdf_d[l_ac].stdf019,g_stdf_d[l_ac].stdf029, 
       g_stdf_d[l_ac].stdf030,g_stdf_d[l_ac].stdf031,g_stdf_d[l_ac].stdf032,g_stdf_d[l_ac].stdf033,g_stdf_d[l_ac].stdf034, 
       g_stdf_d[l_ac].stdf020,g_stdf_d[l_ac].stdf020_desc,g_stdf_d[l_ac].stdf021,g_stdf_d[l_ac].stdf021_desc, 
       g_stdf_d[l_ac].stdf022,g_stdf_d[l_ac].stdf022_desc,g_stdf_d[l_ac].stdf023,g_stdf_d[l_ac].stdf023_desc, 
       g_stdf_d[l_ac].stdf024,g_stdf_d[l_ac].stdf024_desc,g_stdf_d[l_ac].stdf025,g_stdf_d[l_ac].stdf025_desc, 
       g_stdf_d[l_ac].stdf026,g_stdf_d[l_ac].stdf026_desc,g_stdf_d[l_ac].stdf027,g_stdf_d[l_ac].stdf027_desc, 
       g_stdf_d[l_ac].stdf039,g_stdf_d[l_ac].stdf039_desc,g_stdf_d[l_ac].stdf040,g_stdf_d[l_ac].stdf040_desc, 
       g_stdf_d[l_ac].stdf041,g_stdf_d[l_ac].stdf041_desc,g_stdf_d[l_ac].stdf028,g_stdf_d[l_ac].stdf035, 
       g_stdf_d[l_ac].stdf036
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_stdf_d[l_ac].statepic = cl_get_actipic(g_stdf_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #mark by geza 20151218(S)
#      IF g_stdf_d[l_ac].stdfstus = '2' THEN
#         LET g_stdf_d[l_ac].ltype = '1'
#      ELSE
#         LET g_stdf_d[l_ac].ltype = '2'
#      END IF
      #mark by geza 20151218(E)
      #add by geza 20151218(S)
      SELECT stdb007 INTO  g_stdf_d[l_ac].ltype
        FROM stdb_t
       WHERE stdbent = g_enterprise
         AND stdb001 = g_stdf_d[l_ac].stdf028
      #add by geza 20151218(E)
      LET g_stdf_d[l_ac].sel = 'N'
      #end add-point
 
      CALL astt732_detail_show("'1'")      
 
      CALL astt732_stdf_t_mask()
 
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
   
 
   
   CALL g_stdf_d.deleteElement(g_stdf_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_stdf_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE astt732_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL astt732_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL astt732_detail_action_trans()
 
   IF g_stdf_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL astt732_fetch()
   END IF
   
      CALL astt732_filter_show('stdfstus','b_stdfstus')
   CALL astt732_filter_show('stdfsite','b_stdfsite')
   CALL astt732_filter_show('stdf001','b_stdf001')
   CALL astt732_filter_show('stdf002','b_stdf002')
   CALL astt732_filter_show('stdf003','b_stdf003')
   CALL astt732_filter_show('stdf004','b_stdf004')
   CALL astt732_filter_show('stdf005','b_stdf005')
   CALL astt732_filter_show('stdf006','b_stdf006')
   CALL astt732_filter_show('stdf007','b_stdf007')
   CALL astt732_filter_show('stdf037','b_stdf037')
   CALL astt732_filter_show('stdf038','b_stdf038')
   CALL astt732_filter_show('stdf008','b_stdf008')
   CALL astt732_filter_show('stdf009','b_stdf009')
   CALL astt732_filter_show('stdf010','b_stdf010')
   CALL astt732_filter_show('stdf011','b_stdf011')
   CALL astt732_filter_show('stdf012','b_stdf012')
   CALL astt732_filter_show('stdf013','b_stdf013')
   CALL astt732_filter_show('stdf014','b_stdf014')
   CALL astt732_filter_show('stdf015','b_stdf015')
   CALL astt732_filter_show('stdf016','b_stdf016')
   CALL astt732_filter_show('stdf017','b_stdf017')
   CALL astt732_filter_show('stdf018','b_stdf018')
   CALL astt732_filter_show('stdf019','b_stdf019')
   CALL astt732_filter_show('stdf029','b_stdf029')
   CALL astt732_filter_show('stdf030','b_stdf030')
   CALL astt732_filter_show('stdf031','b_stdf031')
   CALL astt732_filter_show('stdf032','b_stdf032')
   CALL astt732_filter_show('stdf033','b_stdf033')
   CALL astt732_filter_show('stdf034','b_stdf034')
   CALL astt732_filter_show('stdf020','b_stdf020')
   CALL astt732_filter_show('stdf021','b_stdf021')
   CALL astt732_filter_show('stdf022','b_stdf022')
   CALL astt732_filter_show('stdf023','b_stdf023')
   CALL astt732_filter_show('stdf024','b_stdf024')
   CALL astt732_filter_show('stdf025','b_stdf025')
   CALL astt732_filter_show('stdf026','b_stdf026')
   CALL astt732_filter_show('stdf027','b_stdf027')
   CALL astt732_filter_show('stdf039','b_stdf039')
   CALL astt732_filter_show('stdf040','b_stdf040')
   CALL astt732_filter_show('stdf041','b_stdf041')
   CALL astt732_filter_show('stdf028','b_stdf028')
   CALL astt732_filter_show('stdf035','b_stdf035')
   CALL astt732_filter_show('stdf036','b_stdf036')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astt732.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astt732_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   CALL g_stdf2_d.clear() 
   CALL g_stdf3_d.clear()
   LET g_detail_idx = l_ac
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   #mark by geza 20151218(S)
#   LET g_sql = "SELECT  UNIQUE stde001,'',stde002,stde003,stde004,stde005,stde006,stde007,stde008,'','',stde009, 
#       stde010,stde011,'',stde012,stde013,'',stde014,'',stde015,'',stde016,stde017,stde018,stde019,stde020,'',stde021,'', 
#       stde022,'',stde023,'',stde024,'',stde025,'',stde026,'',stde027,'',stde028,stde029,stde030,stdestus FROM stde_t", 
#           
#               "",
#               " WHERE stdeent = ? AND stde029 = ? AND stde030 = ? "
# 
#   LET g_sql = g_sql, " ORDER BY stde_t.stde006,stde_t.stde007" 
#                      
#   #add-point:單身填充前
#
#   #end add-point
# 
#   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
#   PREPARE astt732_pb2 FROM g_sql
#   DECLARE b_fill_curs2 CURSOR FOR astt732_pb2
#   
#   OPEN b_fill_curs2 USING g_enterprise,g_stdf_d[g_detail_idx].stdf006
#                                  ,g_stdf_d[g_detail_idx].stdf007
# 
# 
#   LET l_ac = 1
#   FOREACH b_fill_curs2 INTO g_stdf2_d[l_ac].stde001,g_stdf2_d[l_ac].stde001_desc,g_stdf2_d[l_ac].stde002,
#       g_stdf2_d[l_ac].stde003,g_stdf2_d[l_ac].stde004,g_stdf2_d[l_ac].stde005,g_stdf2_d[l_ac].stde006,g_stdf2_d[l_ac].stde007, 
#       g_stdf2_d[l_ac].stde008,g_stdf2_d[l_ac].stde008_desc,g_stdf2_d[l_ac].stde008_desc_desc,g_stdf2_d[l_ac].stde009, 
#       g_stdf2_d[l_ac].stde010,g_stdf2_d[l_ac].stde011,g_stdf2_d[l_ac].stde011_desc,g_stdf2_d[l_ac].stde012,
#       g_stdf2_d[l_ac].stde013,g_stdf2_d[l_ac].stde013_desc,g_stdf2_d[l_ac].stde014,g_stdf2_d[l_ac].stde014_desc, 
#       g_stdf2_d[l_ac].stde015,g_stdf2_d[l_ac].stde015_desc,g_stdf2_d[l_ac].stde016,g_stdf2_d[l_ac].stde017,g_stdf2_d[l_ac].stde018, 
#       g_stdf2_d[l_ac].stde019,g_stdf2_d[l_ac].stde020,g_stdf2_d[l_ac].stde020_desc,g_stdf2_d[l_ac].stde021,g_stdf2_d[l_ac].stde021_desc,
#       g_stdf2_d[l_ac].stde022,g_stdf2_d[l_ac].stde022_desc,g_stdf2_d[l_ac].stde023,g_stdf2_d[l_ac].stde023_desc,
#       g_stdf2_d[l_ac].stde024,g_stdf2_d[l_ac].stde024_desc,g_stdf2_d[l_ac].stde025,g_stdf2_d[l_ac].stde025_desc,
#       g_stdf2_d[l_ac].stde026,g_stdf2_d[l_ac].stde026_desc,g_stdf2_d[l_ac].stde027,g_stdf2_d[l_ac].stde027_desc, 
#       g_stdf2_d[l_ac].stde028,g_stdf2_d[l_ac].stde029,g_stdf2_d[l_ac].stde030,g_stdf2_d[l_ac].stdestus 
#
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         EXIT FOREACH
#      END IF
#      
#      
# 
#      #add-point:b_fill段資料填充
#
#      #end add-point
#      
#      CALL astt732_detail_show("'2'")      
# 
#      LET l_ac = l_ac + 1
#      IF l_ac > g_max_rec THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend =  "" 
#         LET g_errparam.code   =  9035 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         EXIT FOREACH
#      END IF
#      
#   END FOREACH
   #mark by geza 20151218(E)
   LET g_sql = "SELECT  UNIQUE inaj201,inaj202,inaj001,inaj002,inaj003,inaj004,inaj005,'','',inaj211,'',inaj008,'',inaj203,'',inaj204,'',inaj012,'', 
       inaj011,inaj210,inaj205,inaj206,inajsite,'',inaj207,'',inaj208,'',inaj209,'' FROM inaj_t",    #add by geza 20151218 inaj210,inaj211  
               "",
               #" WHERE inajent = ? AND inaj044 = ? AND inaj002 = ? AND inaj200 = 'Y' "  #mark by geza 20151218
               " WHERE inajent = ? AND inaj001 = ? AND inajsite = ? "  #add by geza 20151218
   LET g_sql = g_sql, " ORDER BY inaj_t.inajsite,inaj_t.inaj001,inaj_t.inaj002,inaj003,inaj004" 
                      
   #add-point:單身填充前

   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
   PREPARE astt732_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR astt732_pb3
   
   OPEN b_fill_curs3 USING g_enterprise,g_stdf_d[g_detail_idx].stdf006,g_stdf_d[g_detail_idx].stdfsite
                                  #,g_stdf_d[g_detail_idx].stdf007   #mark by geza 20151218
 
 
   LET l_ac = 1
   FOREACH b_fill_curs3 INTO g_stdf3_d[l_ac].inaj201,g_stdf3_d[l_ac].inaj202,g_stdf3_d[l_ac].inaj001,g_stdf3_d[l_ac].inaj002,g_stdf3_d[l_ac].inaj003,g_stdf3_d[l_ac].inaj004,  #add by geza 20151218 inaj003,inaj004 
       g_stdf3_d[l_ac].inaj005,g_stdf3_d[l_ac].inaj005_desc,g_stdf3_d[l_ac].inaj005_desc_desc,g_stdf3_d[l_ac].inaj211,g_stdf3_d[l_ac].inaj211_desc,  #add by geza 20151218 inaj211   
       g_stdf3_d[l_ac].inaj008,g_stdf3_d[l_ac].inaj008_desc,g_stdf3_d[l_ac].inaj203,g_stdf3_d[l_ac].inaj203_desc,
       g_stdf3_d[l_ac].inaj204,g_stdf3_d[l_ac].inaj204_desc,g_stdf3_d[l_ac].inaj012,g_stdf3_d[l_ac].inaj012_desc,
       g_stdf3_d[l_ac].inaj011,g_stdf3_d[l_ac].inaj210,g_stdf3_d[l_ac].inaj205,g_stdf3_d[l_ac].inaj206,g_stdf3_d[l_ac].inajsite,  #add by geza 20151218 inaj210
       g_stdf3_d[l_ac].inajsite_desc,g_stdf3_d[l_ac].inaj207,g_stdf3_d[l_ac].inaj207_desc,g_stdf3_d[l_ac].inaj208, 
       g_stdf3_d[l_ac].inaj208_desc,g_stdf3_d[l_ac].inaj209,g_stdf3_d[l_ac].inaj209_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      
 
      #add-point:b_fill段資料填充

      #end add-point
      
      CALL astt732_detail_show("'3'")      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
   END FOREACH 
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
#   CALL g_stdf2_d.deleteElement(g_stdf2_d.getLength())   
# 
#   #單身總筆數顯示
#   LET g_detail_cnt2 = g_stdf2_d.getLength()
#   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
#   IF g_detail_cnt2 > 0 THEN
#      LET g_detail_idx2 = 1
#      DISPLAY g_detail_idx2 TO FORMONLY.idx
#   ELSE
#      LET g_detail_idx2 = 0
#      DISPLAY ' ' TO FORMONLY.idx
#   END IF
# 
#   CALL g_stdf3_d.deleteElement(g_stdf3_d.getLength())   
# 
#   #單身總筆數顯示
#   LET g_detail_cnt2 = g_stdf3_d.getLength()
#   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
#   IF g_detail_cnt2 > 0 THEN
#      LET g_detail_idx2 = 1
#      DISPLAY g_detail_idx2 TO FORMONLY.idx
#   ELSE
#      LET g_detail_idx2 = 0
#      DISPLAY ' ' TO FORMONLY.idx
#   END IF
   CALL g_stdf2_d.deleteElement(g_stdf2_d.getLength()) 
   CALL g_stdf3_d.deleteElement(g_stdf3_d.getLength()) 
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="astt732.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION astt732_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   DEFINE l_ooef019  LIKE ooef_t.ooef019
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf_d[l_ac].stdf001
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf_d[l_ac].stdf001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf_d[l_ac].stdf001_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf_d[l_ac].stdf008
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf_d[l_ac].stdf008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf_d[l_ac].stdf008_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf_d[l_ac].stdf008
            LET ls_sql = "SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf_d[l_ac].stdf008_desc_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf_d[l_ac].stdf008_desc_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf_d[l_ac].stdf011
            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf_d[l_ac].stdf011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf_d[l_ac].stdf011_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf_d[l_ac].stdf013
            LET ls_sql = "SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf_d[l_ac].stdf013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf_d[l_ac].stdf013_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf_d[l_ac].stdf014
            LET ls_sql = "SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf_d[l_ac].stdf014_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf_d[l_ac].stdf014_desc
            
            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_ooef019
            LET g_ref_fields[2] = g_stdf_d[l_ac].stdf015
            LET ls_sql = "SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf_d[l_ac].stdf015_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf_d[l_ac].stdf015_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf_d[l_ac].stdf020
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf_d[l_ac].stdf020_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf_d[l_ac].stdf020_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf_d[l_ac].stdf021
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf_d[l_ac].stdf021_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf_d[l_ac].stdf021_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stdf_d[l_ac].stdf020
#            LET g_ref_fields[2] = g_stdf_d[l_ac].stdf022
#            LET ls_sql = "SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite=? AND inaa001=? "
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stdf_d[l_ac].stdf022_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stdf_d[l_ac].stdf022_desc
            CALL s_desc_get_stock_desc(g_stdf_d[l_ac].stdf020,g_stdf_d[l_ac].stdf022) RETURNING g_stdf_d[l_ac].stdf022_desc
            DISPLAY BY NAME g_stdf_d[l_ac].stdf022_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf_d[l_ac].stdf023
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf_d[l_ac].stdf023_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf_d[l_ac].stdf023_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf_d[l_ac].stdf024
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf_d[l_ac].stdf024_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf_d[l_ac].stdf024_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stdf_d[l_ac].stdf023
#            LET g_ref_fields[2] = g_stdf_d[l_ac].stdf025
#            LET ls_sql = "SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite=? AND inaa001=? "
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stdf_d[l_ac].stdf025_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stdf_d[l_ac].stdf025_desc
            CALL s_desc_get_stock_desc(g_stdf_d[l_ac].stdf023,g_stdf_d[l_ac].stdf025) RETURNING g_stdf_d[l_ac].stdf025_desc
            DISPLAY BY NAME g_stdf_d[l_ac].stdf025_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf_d[l_ac].stdf026
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf_d[l_ac].stdf026_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf_d[l_ac].stdf026_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf_d[l_ac].stdf027
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf_d[l_ac].stdf027_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf_d[l_ac].stdf027_desc
            
            #add by geza 20151218(S)
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf_d[l_ac].stdfsite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf_d[l_ac].stdfsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf_d[l_ac].stdfsite_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf_d[l_ac].stdf039
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf_d[l_ac].stdf039_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf_d[l_ac].stdf039_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf_d[l_ac].stdf040
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf_d[l_ac].stdf040_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf_d[l_ac].stdf040_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf_d[l_ac].stdf041
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf_d[l_ac].stdf041_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf_d[l_ac].stdf041_desc
            
            #add by geza 20151218(E)
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf2_d[l_ac].stde001
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf2_d[l_ac].stde001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf2_d[l_ac].stde001_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf2_d[l_ac].stde008
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf2_d[l_ac].stde008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf2_d[l_ac].stde008_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf2_d[l_ac].stde008
            LET ls_sql = "SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf2_d[l_ac].stde008_desc_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf2_d[l_ac].stde008_desc_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf2_d[l_ac].stde011
            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf2_d[l_ac].stde011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf2_d[l_ac].stde011_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf2_d[l_ac].stde013
            LET ls_sql = "SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf2_d[l_ac].stde013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf2_d[l_ac].stde013_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf2_d[l_ac].stde014
            LET ls_sql = "SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf2_d[l_ac].stde014_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf2_d[l_ac].stde014_desc
            
            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_ooef019
            LET g_ref_fields[2] = g_stdf2_d[l_ac].stde015
            LET ls_sql = "SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf2_d[l_ac].stde015_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf2_d[l_ac].stde015_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf2_d[l_ac].stde020
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf2_d[l_ac].stde020_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf2_d[l_ac].stde020_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf2_d[l_ac].stde021
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf2_d[l_ac].stde021_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf2_d[l_ac].stde021_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stdf2_d[l_ac].stde020
#            LET g_ref_fields[2] = g_stdf2_d[l_ac].stde022
#            LET ls_sql = "SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite=? AND inaa001=? "
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stdf2_d[l_ac].stde022_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stdf2_d[l_ac].stde022_desc
            CALL s_desc_get_stock_desc(g_stdf2_d[l_ac].stde020,g_stdf2_d[l_ac].stde022) RETURNING g_stdf2_d[l_ac].stde022_desc
            DISPLAY BY NAME g_stdf2_d[l_ac].stde022_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf2_d[l_ac].stde023
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf2_d[l_ac].stde023_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf2_d[l_ac].stde023_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf2_d[l_ac].stde024
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf2_d[l_ac].stde024_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf2_d[l_ac].stde024_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stdf2_d[l_ac].stde023
#            LET g_ref_fields[2] = g_stdf2_d[l_ac].stde025
#            LET ls_sql = "SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite=? AND inaa001=? "
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stdf2_d[l_ac].stde025_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stdf2_d[l_ac].stde025_desc
            CALL s_desc_get_stock_desc(g_stdf2_d[l_ac].stde023,g_stdf2_d[l_ac].stde025) RETURNING g_stdf2_d[l_ac].stde025_desc
            DISPLAY BY NAME g_stdf2_d[l_ac].stde025_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf2_d[l_ac].stde026
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf2_d[l_ac].stde026_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf2_d[l_ac].stde026_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf2_d[l_ac].stde027
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf2_d[l_ac].stde027_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf2_d[l_ac].stde027_desc

   END IF
   
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf3_d[l_ac].inaj005
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf3_d[l_ac].inaj005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf3_d[l_ac].inaj005_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf3_d[l_ac].inaj005
            LET ls_sql = "SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf3_d[l_ac].inaj005_desc_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf3_d[l_ac].inaj005_desc_desc
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stdf3_d[l_ac].inajsite
#            LET g_ref_fields[2] = g_stdf3_d[l_ac].inaj008
#            LET ls_sql = "SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite=? AND inaa001=? "
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stdf3_d[l_ac].inaj008_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stdf3_d[l_ac].inaj008_desc
            CALL s_desc_get_stock_desc(g_stdf3_d[l_ac].inajsite,g_stdf3_d[l_ac].inaj008) RETURNING g_stdf3_d[l_ac].inaj008_desc
            DISPLAY BY NAME g_stdf3_d[l_ac].inaj008_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf3_d[l_ac].inaj203
            LET ls_sql = "SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf3_d[l_ac].inaj203_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf3_d[l_ac].inaj203_desc
            
            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_ooef019
            LET g_ref_fields[2] = g_stdf3_d[l_ac].inaj204
            LET ls_sql = "SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf3_d[l_ac].inaj204_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf3_d[l_ac].inaj204_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf3_d[l_ac].inaj012
            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf3_d[l_ac].inaj012_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf3_d[l_ac].inaj012_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf3_d[l_ac].inajsite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf3_d[l_ac].inajsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf3_d[l_ac].inajsite_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf3_d[l_ac].inaj207
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf3_d[l_ac].inaj207_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf3_d[l_ac].inaj207_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf3_d[l_ac].inaj208
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf3_d[l_ac].inaj208_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf3_d[l_ac].inaj208_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf3_d[l_ac].inaj209
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf3_d[l_ac].inaj209_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf3_d[l_ac].inaj209_desc
            
            #add by geza 20151218(S)
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdf3_d[l_ac].inaj211
            LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stdf3_d[l_ac].inaj211_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdf3_d[l_ac].inaj211_desc
            #add by geza 20151218(E)

   END IF
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astt732.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION astt732_filter()
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
      CONSTRUCT g_wc_filter ON stdfstus,stdfsite,stdf001,stdf002,stdf003,stdf004,stdf005,stdf006,stdf007, 
          stdf037,stdf038,stdf008,stdf009,stdf010,stdf011,stdf012,stdf013,stdf014,stdf015,stdf016,stdf017, 
          stdf018,stdf019,stdf029,stdf030,stdf031,stdf032,stdf033,stdf034,stdf020,stdf021,stdf022,stdf023, 
          stdf024,stdf025,stdf026,stdf027,stdf039,stdf040,stdf041,stdf028,stdf035,stdf036
                          FROM s_detail1[1].b_stdfstus,s_detail1[1].b_stdfsite,s_detail1[1].b_stdf001, 
                              s_detail1[1].b_stdf002,s_detail1[1].b_stdf003,s_detail1[1].b_stdf004,s_detail1[1].b_stdf005, 
                              s_detail1[1].b_stdf006,s_detail1[1].b_stdf007,s_detail1[1].b_stdf037,s_detail1[1].b_stdf038, 
                              s_detail1[1].b_stdf008,s_detail1[1].b_stdf009,s_detail1[1].b_stdf010,s_detail1[1].b_stdf011, 
                              s_detail1[1].b_stdf012,s_detail1[1].b_stdf013,s_detail1[1].b_stdf014,s_detail1[1].b_stdf015, 
                              s_detail1[1].b_stdf016,s_detail1[1].b_stdf017,s_detail1[1].b_stdf018,s_detail1[1].b_stdf019, 
                              s_detail1[1].b_stdf029,s_detail1[1].b_stdf030,s_detail1[1].b_stdf031,s_detail1[1].b_stdf032, 
                              s_detail1[1].b_stdf033,s_detail1[1].b_stdf034,s_detail1[1].b_stdf020,s_detail1[1].b_stdf021, 
                              s_detail1[1].b_stdf022,s_detail1[1].b_stdf023,s_detail1[1].b_stdf024,s_detail1[1].b_stdf025, 
                              s_detail1[1].b_stdf026,s_detail1[1].b_stdf027,s_detail1[1].b_stdf039,s_detail1[1].b_stdf040, 
                              s_detail1[1].b_stdf041,s_detail1[1].b_stdf028,s_detail1[1].b_stdf035,s_detail1[1].b_stdf036 
 
 
         BEFORE CONSTRUCT
                     DISPLAY astt732_filter_parser('stdfstus') TO s_detail1[1].b_stdfstus
            DISPLAY astt732_filter_parser('stdfsite') TO s_detail1[1].b_stdfsite
            DISPLAY astt732_filter_parser('stdf001') TO s_detail1[1].b_stdf001
            DISPLAY astt732_filter_parser('stdf002') TO s_detail1[1].b_stdf002
            DISPLAY astt732_filter_parser('stdf003') TO s_detail1[1].b_stdf003
            DISPLAY astt732_filter_parser('stdf004') TO s_detail1[1].b_stdf004
            DISPLAY astt732_filter_parser('stdf005') TO s_detail1[1].b_stdf005
            DISPLAY astt732_filter_parser('stdf006') TO s_detail1[1].b_stdf006
            DISPLAY astt732_filter_parser('stdf007') TO s_detail1[1].b_stdf007
            DISPLAY astt732_filter_parser('stdf037') TO s_detail1[1].b_stdf037
            DISPLAY astt732_filter_parser('stdf038') TO s_detail1[1].b_stdf038
            DISPLAY astt732_filter_parser('stdf008') TO s_detail1[1].b_stdf008
            DISPLAY astt732_filter_parser('stdf009') TO s_detail1[1].b_stdf009
            DISPLAY astt732_filter_parser('stdf010') TO s_detail1[1].b_stdf010
            DISPLAY astt732_filter_parser('stdf011') TO s_detail1[1].b_stdf011
            DISPLAY astt732_filter_parser('stdf012') TO s_detail1[1].b_stdf012
            DISPLAY astt732_filter_parser('stdf013') TO s_detail1[1].b_stdf013
            DISPLAY astt732_filter_parser('stdf014') TO s_detail1[1].b_stdf014
            DISPLAY astt732_filter_parser('stdf015') TO s_detail1[1].b_stdf015
            DISPLAY astt732_filter_parser('stdf016') TO s_detail1[1].b_stdf016
            DISPLAY astt732_filter_parser('stdf017') TO s_detail1[1].b_stdf017
            DISPLAY astt732_filter_parser('stdf018') TO s_detail1[1].b_stdf018
            DISPLAY astt732_filter_parser('stdf019') TO s_detail1[1].b_stdf019
            DISPLAY astt732_filter_parser('stdf029') TO s_detail1[1].b_stdf029
            DISPLAY astt732_filter_parser('stdf030') TO s_detail1[1].b_stdf030
            DISPLAY astt732_filter_parser('stdf031') TO s_detail1[1].b_stdf031
            DISPLAY astt732_filter_parser('stdf032') TO s_detail1[1].b_stdf032
            DISPLAY astt732_filter_parser('stdf033') TO s_detail1[1].b_stdf033
            DISPLAY astt732_filter_parser('stdf034') TO s_detail1[1].b_stdf034
            DISPLAY astt732_filter_parser('stdf020') TO s_detail1[1].b_stdf020
            DISPLAY astt732_filter_parser('stdf021') TO s_detail1[1].b_stdf021
            DISPLAY astt732_filter_parser('stdf022') TO s_detail1[1].b_stdf022
            DISPLAY astt732_filter_parser('stdf023') TO s_detail1[1].b_stdf023
            DISPLAY astt732_filter_parser('stdf024') TO s_detail1[1].b_stdf024
            DISPLAY astt732_filter_parser('stdf025') TO s_detail1[1].b_stdf025
            DISPLAY astt732_filter_parser('stdf026') TO s_detail1[1].b_stdf026
            DISPLAY astt732_filter_parser('stdf027') TO s_detail1[1].b_stdf027
            DISPLAY astt732_filter_parser('stdf039') TO s_detail1[1].b_stdf039
            DISPLAY astt732_filter_parser('stdf040') TO s_detail1[1].b_stdf040
            DISPLAY astt732_filter_parser('stdf041') TO s_detail1[1].b_stdf041
            DISPLAY astt732_filter_parser('stdf028') TO s_detail1[1].b_stdf028
            DISPLAY astt732_filter_parser('stdf035') TO s_detail1[1].b_stdf035
            DISPLAY astt732_filter_parser('stdf036') TO s_detail1[1].b_stdf036
 
 
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<stdfcrtdt>>----
         #AFTER FIELD stdfcrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<stdfmoddt>>----
         #AFTER FIELD stdfmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stdfcnfdt>>----
         #AFTER FIELD stdfcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stdfpstdt>>----
         #AFTER FIELD stdfpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_stdfstus>>----
         #Ctrlp:construct.c.filter.page1.b_stdfstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdfstus
            #add-point:ON ACTION controlp INFIELD b_stdfstus name="construct.c.filter.page1.b_stdfstus"
            
            #END add-point
 
 
         #----<<b_stdfsite>>----
         #Ctrlp:construct.c.page1.b_stdfsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdfsite
            #add-point:ON ACTION controlp INFIELD b_stdfsite name="construct.c.filter.page1.b_stdfsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stdfsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdfsite  #顯示到畫面上
            NEXT FIELD b_stdfsite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdfsite_desc>>----
         #----<<b_stdf001>>----
         #Ctrlp:construct.c.page1.b_stdf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf001
            #add-point:ON ACTION controlp INFIELD b_stdf001 name="construct.c.filter.page1.b_stdf001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf001  #顯示到畫面上
            NEXT FIELD b_stdf001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf001_desc>>----
         #----<<b_stdf002>>----
         #Ctrlp:construct.c.filter.page1.b_stdf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf002
            #add-point:ON ACTION controlp INFIELD b_stdf002 name="construct.c.filter.page1.b_stdf002"
            
            #END add-point
 
 
         #----<<b_stdf003>>----
         #Ctrlp:construct.c.filter.page1.b_stdf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf003
            #add-point:ON ACTION controlp INFIELD b_stdf003 name="construct.c.filter.page1.b_stdf003"
            
            #END add-point
 
 
         #----<<b_stdf004>>----
         #Ctrlp:construct.c.filter.page1.b_stdf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf004
            #add-point:ON ACTION controlp INFIELD b_stdf004 name="construct.c.filter.page1.b_stdf004"
            
            #END add-point
 
 
         #----<<b_ltype>>----
         #----<<b_stdf005>>----
         #Ctrlp:construct.c.filter.page1.b_stdf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf005
            #add-point:ON ACTION controlp INFIELD b_stdf005 name="construct.c.filter.page1.b_stdf005"
            
            #END add-point
 
 
         #----<<b_stdf006>>----
         #Ctrlp:construct.c.page1.b_stdf006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf006
            #add-point:ON ACTION controlp INFIELD b_stdf006 name="construct.c.filter.page1.b_stdf006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stdf006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf006  #顯示到畫面上
            NEXT FIELD b_stdf006                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf007>>----
         #Ctrlp:construct.c.filter.page1.b_stdf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf007
            #add-point:ON ACTION controlp INFIELD b_stdf007 name="construct.c.filter.page1.b_stdf007"
            
            #END add-point
 
 
         #----<<b_stdf037>>----
         #Ctrlp:construct.c.filter.page1.b_stdf037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf037
            #add-point:ON ACTION controlp INFIELD b_stdf037 name="construct.c.filter.page1.b_stdf037"
            
            #END add-point
 
 
         #----<<b_stdf038>>----
         #Ctrlp:construct.c.filter.page1.b_stdf038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf038
            #add-point:ON ACTION controlp INFIELD b_stdf038 name="construct.c.filter.page1.b_stdf038"
            
            #END add-point
 
 
         #----<<b_stdf008>>----
         #Ctrlp:construct.c.page1.b_stdf008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf008
            #add-point:ON ACTION controlp INFIELD b_stdf008 name="construct.c.filter.page1.b_stdf008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf008  #顯示到畫面上
            NEXT FIELD b_stdf008                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf008_desc>>----
         #----<<b_stdf008_desc_desc>>----
         #----<<b_stdf009>>----
         #Ctrlp:construct.c.page1.b_stdf009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf009
            #add-point:ON ACTION controlp INFIELD b_stdf009 name="construct.c.filter.page1.b_stdf009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf009  #顯示到畫面上
            NEXT FIELD b_stdf009                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf010>>----
         #Ctrlp:construct.c.filter.page1.b_stdf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf010
            #add-point:ON ACTION controlp INFIELD b_stdf010 name="construct.c.filter.page1.b_stdf010"
            
            #END add-point
 
 
         #----<<b_stdf011>>----
         #Ctrlp:construct.c.page1.b_stdf011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf011
            #add-point:ON ACTION controlp INFIELD b_stdf011 name="construct.c.filter.page1.b_stdf011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf011  #顯示到畫面上
            NEXT FIELD b_stdf011                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf011_desc>>----
         #----<<b_stdf012>>----
         #Ctrlp:construct.c.filter.page1.b_stdf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf012
            #add-point:ON ACTION controlp INFIELD b_stdf012 name="construct.c.filter.page1.b_stdf012"
            
            #END add-point
 
 
         #----<<b_stdf013>>----
         #Ctrlp:construct.c.page1.b_stdf013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf013
            #add-point:ON ACTION controlp INFIELD b_stdf013 name="construct.c.filter.page1.b_stdf013"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf013  #顯示到畫面上
            NEXT FIELD b_stdf013                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf013_desc>>----
         #----<<b_stdf014>>----
         #Ctrlp:construct.c.page1.b_stdf014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf014
            #add-point:ON ACTION controlp INFIELD b_stdf014 name="construct.c.filter.page1.b_stdf014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf014  #顯示到畫面上
            NEXT FIELD b_stdf014                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf014_desc>>----
         #----<<b_stdf015>>----
         #Ctrlp:construct.c.page1.b_stdf015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf015
            #add-point:ON ACTION controlp INFIELD b_stdf015 name="construct.c.filter.page1.b_stdf015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf015  #顯示到畫面上
            NEXT FIELD b_stdf015                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf015_desc>>----
         #----<<b_stdf016>>----
         #Ctrlp:construct.c.filter.page1.b_stdf016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf016
            #add-point:ON ACTION controlp INFIELD b_stdf016 name="construct.c.filter.page1.b_stdf016"
            
            #END add-point
 
 
         #----<<b_stdf017>>----
         #Ctrlp:construct.c.filter.page1.b_stdf017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf017
            #add-point:ON ACTION controlp INFIELD b_stdf017 name="construct.c.filter.page1.b_stdf017"
            
            #END add-point
 
 
         #----<<b_stdf018>>----
         #Ctrlp:construct.c.filter.page1.b_stdf018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf018
            #add-point:ON ACTION controlp INFIELD b_stdf018 name="construct.c.filter.page1.b_stdf018"
            
            #END add-point
 
 
         #----<<b_stdf019>>----
         #Ctrlp:construct.c.filter.page1.b_stdf019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf019
            #add-point:ON ACTION controlp INFIELD b_stdf019 name="construct.c.filter.page1.b_stdf019"
            
            #END add-point
 
 
         #----<<b_stdf029>>----
         #Ctrlp:construct.c.filter.page1.b_stdf029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf029
            #add-point:ON ACTION controlp INFIELD b_stdf029 name="construct.c.filter.page1.b_stdf029"
            
            #END add-point
 
 
         #----<<b_stdf030>>----
         #Ctrlp:construct.c.filter.page1.b_stdf030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf030
            #add-point:ON ACTION controlp INFIELD b_stdf030 name="construct.c.filter.page1.b_stdf030"
            
            #END add-point
 
 
         #----<<b_stdf031>>----
         #Ctrlp:construct.c.filter.page1.b_stdf031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf031
            #add-point:ON ACTION controlp INFIELD b_stdf031 name="construct.c.filter.page1.b_stdf031"
            
            #END add-point
 
 
         #----<<b_stdf032>>----
         #Ctrlp:construct.c.filter.page1.b_stdf032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf032
            #add-point:ON ACTION controlp INFIELD b_stdf032 name="construct.c.filter.page1.b_stdf032"
            
            #END add-point
 
 
         #----<<b_stdf033>>----
         #Ctrlp:construct.c.filter.page1.b_stdf033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf033
            #add-point:ON ACTION controlp INFIELD b_stdf033 name="construct.c.filter.page1.b_stdf033"
            
            #END add-point
 
 
         #----<<b_stdf034>>----
         #Ctrlp:construct.c.filter.page1.b_stdf034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf034
            #add-point:ON ACTION controlp INFIELD b_stdf034 name="construct.c.filter.page1.b_stdf034"
            
            #END add-point
 
 
         #----<<b_stdf020>>----
         #Ctrlp:construct.c.page1.b_stdf020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf020
            #add-point:ON ACTION controlp INFIELD b_stdf020 name="construct.c.filter.page1.b_stdf020"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf020  #顯示到畫面上
            NEXT FIELD b_stdf020                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf020_desc>>----
         #----<<b_stdf021>>----
         #Ctrlp:construct.c.page1.b_stdf021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf021
            #add-point:ON ACTION controlp INFIELD b_stdf021 name="construct.c.filter.page1.b_stdf021"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161024-00025#4 -s by 08172
            LET g_qryparam.where = " ooef003='Y'"
            CALL q_ooef001_24()
#            CALL q_ooef001_2()                           #呼叫開窗
            #161024-00025#4 -e by 08172
            DISPLAY g_qryparam.return1 TO b_stdf021  #顯示到畫面上
            NEXT FIELD b_stdf021                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf021_desc>>----
         #----<<b_stdf022>>----
         #Ctrlp:construct.c.page1.b_stdf022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf022
            #add-point:ON ACTION controlp INFIELD b_stdf022 name="construct.c.filter.page1.b_stdf022"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf022  #顯示到畫面上
            NEXT FIELD b_stdf022                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf022_desc>>----
         #----<<b_stdf023>>----
         #Ctrlp:construct.c.page1.b_stdf023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf023
            #add-point:ON ACTION controlp INFIELD b_stdf023 name="construct.c.filter.page1.b_stdf023"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf023  #顯示到畫面上
            NEXT FIELD b_stdf023                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf023_desc>>----
         #----<<b_stdf024>>----
         #Ctrlp:construct.c.page1.b_stdf024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf024
            #add-point:ON ACTION controlp INFIELD b_stdf024 name="construct.c.filter.page1.b_stdf024"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161024-00025#4 -s by 08172
            LET g_qryparam.where = " ooef003='Y'"
            CALL q_ooef001_24()
#            CALL q_ooef001_2()                           #呼叫開窗
            #161024-00025#4 -e by 08172
            DISPLAY g_qryparam.return1 TO b_stdf024  #顯示到畫面上
            NEXT FIELD b_stdf024                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf024_desc>>----
         #----<<b_stdf025>>----
         #Ctrlp:construct.c.page1.b_stdf025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf025
            #add-point:ON ACTION controlp INFIELD b_stdf025 name="construct.c.filter.page1.b_stdf025"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf025  #顯示到畫面上
            NEXT FIELD b_stdf025                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf025_desc>>----
         #----<<b_stdf026>>----
         #Ctrlp:construct.c.page1.b_stdf026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf026
            #add-point:ON ACTION controlp INFIELD b_stdf026 name="construct.c.filter.page1.b_stdf026"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf026  #顯示到畫面上
            NEXT FIELD b_stdf026                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf026_desc>>----
         #----<<b_stdf027>>----
         #Ctrlp:construct.c.page1.b_stdf027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf027
            #add-point:ON ACTION controlp INFIELD b_stdf027 name="construct.c.filter.page1.b_stdf027"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161024-00025#4 -s by 08172
            LET g_qryparam.where = " ooef003='Y'"
            CALL q_ooef001_24()
#            CALL q_ooef001_2()                           #呼叫開窗
            #161024-00025#4 -s by 08172
            DISPLAY g_qryparam.return1 TO b_stdf027  #顯示到畫面上
            NEXT FIELD b_stdf027                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf027_desc>>----
         #----<<b_stdf039>>----
         #Ctrlp:construct.c.page1.b_stdf039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf039
            #add-point:ON ACTION controlp INFIELD b_stdf039 name="construct.c.filter.page1.b_stdf039"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161024-00025#4 -s by 08172
            LET g_qryparam.where = " ooef003='Y'"
            CALL q_ooef001_24()
#            CALL q_ooef001_2()                           #呼叫開窗
            #161024-00025#4 -e by 08172
            DISPLAY g_qryparam.return1 TO b_stdf039  #顯示到畫面上
            NEXT FIELD b_stdf039                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf039_desc>>----
         #----<<b_stdf040>>----
         #Ctrlp:construct.c.page1.b_stdf040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf040
            #add-point:ON ACTION controlp INFIELD b_stdf040 name="construct.c.filter.page1.b_stdf040"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'stdf040') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stdf040',g_site,'c')   #150308-00001#5  By benson add 'c'
               CALL q_ooef001_24()
            ELSE
               CALL q_ooef001()
            END IF                               #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf040  #顯示到畫面上
            NEXT FIELD b_stdf040                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf040_desc>>----
         #----<<b_stdf041>>----
         #Ctrlp:construct.c.page1.b_stdf041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf041
            #add-point:ON ACTION controlp INFIELD b_stdf041 name="construct.c.filter.page1.b_stdf041"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161024-00025#4 -s by 08172
            LET g_qryparam.where = " ooef003='Y'"
            CALL q_ooef001_24()
#            CALL q_ooef001_2()                           #呼叫開窗
            #161024-00025#4 -e by 08172
            DISPLAY g_qryparam.return1 TO b_stdf041  #顯示到畫面上
            NEXT FIELD b_stdf041                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf041_desc>>----
         #----<<b_stdf028>>----
         #Ctrlp:construct.c.page1.b_stdf028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf028
            #add-point:ON ACTION controlp INFIELD b_stdf028 name="construct.c.filter.page1.b_stdf028"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stdb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stdf028  #顯示到畫面上
            NEXT FIELD b_stdf028                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stdf035>>----
         #Ctrlp:construct.c.filter.page1.b_stdf035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf035
            #add-point:ON ACTION controlp INFIELD b_stdf035 name="construct.c.filter.page1.b_stdf035"
            
            #END add-point
 
 
         #----<<b_stdf036>>----
         #Ctrlp:construct.c.filter.page1.b_stdf036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stdf036
            #add-point:ON ACTION controlp INFIELD b_stdf036 name="construct.c.filter.page1.b_stdf036"
            
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
   
      CALL astt732_filter_show('stdfstus','b_stdfstus')
   CALL astt732_filter_show('stdfsite','b_stdfsite')
   CALL astt732_filter_show('stdf001','b_stdf001')
   CALL astt732_filter_show('stdf002','b_stdf002')
   CALL astt732_filter_show('stdf003','b_stdf003')
   CALL astt732_filter_show('stdf004','b_stdf004')
   CALL astt732_filter_show('stdf005','b_stdf005')
   CALL astt732_filter_show('stdf006','b_stdf006')
   CALL astt732_filter_show('stdf007','b_stdf007')
   CALL astt732_filter_show('stdf037','b_stdf037')
   CALL astt732_filter_show('stdf038','b_stdf038')
   CALL astt732_filter_show('stdf008','b_stdf008')
   CALL astt732_filter_show('stdf009','b_stdf009')
   CALL astt732_filter_show('stdf010','b_stdf010')
   CALL astt732_filter_show('stdf011','b_stdf011')
   CALL astt732_filter_show('stdf012','b_stdf012')
   CALL astt732_filter_show('stdf013','b_stdf013')
   CALL astt732_filter_show('stdf014','b_stdf014')
   CALL astt732_filter_show('stdf015','b_stdf015')
   CALL astt732_filter_show('stdf016','b_stdf016')
   CALL astt732_filter_show('stdf017','b_stdf017')
   CALL astt732_filter_show('stdf018','b_stdf018')
   CALL astt732_filter_show('stdf019','b_stdf019')
   CALL astt732_filter_show('stdf029','b_stdf029')
   CALL astt732_filter_show('stdf030','b_stdf030')
   CALL astt732_filter_show('stdf031','b_stdf031')
   CALL astt732_filter_show('stdf032','b_stdf032')
   CALL astt732_filter_show('stdf033','b_stdf033')
   CALL astt732_filter_show('stdf034','b_stdf034')
   CALL astt732_filter_show('stdf020','b_stdf020')
   CALL astt732_filter_show('stdf021','b_stdf021')
   CALL astt732_filter_show('stdf022','b_stdf022')
   CALL astt732_filter_show('stdf023','b_stdf023')
   CALL astt732_filter_show('stdf024','b_stdf024')
   CALL astt732_filter_show('stdf025','b_stdf025')
   CALL astt732_filter_show('stdf026','b_stdf026')
   CALL astt732_filter_show('stdf027','b_stdf027')
   CALL astt732_filter_show('stdf039','b_stdf039')
   CALL astt732_filter_show('stdf040','b_stdf040')
   CALL astt732_filter_show('stdf041','b_stdf041')
   CALL astt732_filter_show('stdf028','b_stdf028')
   CALL astt732_filter_show('stdf035','b_stdf035')
   CALL astt732_filter_show('stdf036','b_stdf036')
 
    
   CALL astt732_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="astt732.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION astt732_filter_parser(ps_field)
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
 
{<section id="astt732.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION astt732_filter_show(ps_field,ps_object)
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
   LET ls_condition = astt732_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="astt732.insert" >}
#+ insert
PRIVATE FUNCTION astt732_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="astt732.modify" >}
#+ modify
PRIVATE FUNCTION astt732_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astt732.reproduce" >}
#+ reproduce
PRIVATE FUNCTION astt732_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astt732.delete" >}
#+ delete
PRIVATE FUNCTION astt732_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astt732.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION astt732_detail_action_trans()
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
 
{<section id="astt732.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION astt732_detail_index_setting()
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
            IF g_stdf_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_stdf_d.getLength() AND g_stdf_d.getLength() > 0
            LET g_detail_idx = g_stdf_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_stdf_d.getLength() THEN
               LET g_detail_idx = g_stdf_d.getLength()
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
 
{<section id="astt732.mask_functions" >}
 &include "erp/ast/astt732_mask.4gl"
 
{</section>}
 
{<section id="astt732.other_function" readonly="Y" >}

 
{</section>}
 
