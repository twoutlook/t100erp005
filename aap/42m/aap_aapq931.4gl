#該程式未解開Section, 採用最新樣板產出!
{<section id="aapq931.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-02-03 09:24:05), PR版次:0002(2015-03-17 10:35:48)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000088
#+ Filename...: aapq931
#+ Description: 集團應付帳齡查詢
#+ Creator....: 05016(2015-01-27 14:32:28)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="aapq931.global" >}
#應用 q02 樣板自動產生(Version:36)
#add-point:填寫註解說明 name="global.memo"
#150215            By Belle   修正計算規則
#150227            By albireo 修正SQL問題
#01727             By Hans    增加欄位 是否顯示壞帳 
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
PRIVATE TYPE type_g_xrea_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   xrea001 LIKE xrea_t.xrea001, 
   xrea002 LIKE xrea_t.xrea002, 
   xreald LIKE xrea_t.xreald, 
   xreald_desc LIKE type_t.chr500, 
   xrea009 LIKE xrea_t.xrea009, 
   xrea009_desc LIKE type_t.chr500, 
   xrea004 LIKE xrea_t.xrea004, 
   xrea005 LIKE xrea_t.xrea005, 
   xrea006 LIKE xrea_t.xrea006, 
   xrea007 LIKE xrea_t.xrea007, 
   xrea008 LIKE xrea_t.xrea008, 
   l_apcc004 LIKE type_t.dat, 
   day LIKE type_t.chr500, 
   day2 LIKE type_t.chr500, 
   xrea100 LIKE xrea_t.xrea100, 
   xrea103 LIKE xrea_t.xrea103, 
   xrea113 LIKE xrea_t.xrea113, 
   l_debt LIKE type_t.num20_6, 
   l_xrea103_debt LIKE type_t.num20_6, 
   l_xrea113_debt LIKE type_t.num20_6, 
   xrea003 LIKE xrea_t.xrea003 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input     RECORD #單頭input
        xreasite       LIKE xrea_t.xreasite,
        xreasite_desc  LIKE type_t.chr80,
        year           LIKE xrea_t.xrea001,
        strmon         LIKE type_t.chr80,
        endmon         LIKE type_t.chr80,
        group          LIKE type_t.chr80,
        xrad001        LIKE xrad_t.xrad001,
        xrad001_desc   LIKE type_t.chr80,
        xrad004        LIKE xrad_t.xrad004,
        apca0010       LIKE type_t.chr1,
        apca0012       LIKE type_t.chr1,
        dedtype        LIKE glcb_t.glcb008,
        curr           LIKE type_t.chr1,
        b_check        LIKE type_t.chr1   #01727
                   END RECORD
                   
TYPE type_g_xrea2_d RECORD #第二單身Array
      group1         LIKE type_t.chr80,      
      group1_desc    LIKE type_t.chr80,      
      group2         LIKE type_t.chr80,
      group2_desc    LIKE type_t.chr80,      
      group3         LIKE type_t.chr80,
      group3_desc    LIKE type_t.chr80,
      xrea011        LIKE xrea_t.xrea011, #部門
      xrea011_desc   LIKE type_t.chr80,
      xrea016        LIKE xrea_t.xrea016, #人員
      xrea016_desc   LIKE type_t.chr80,    
      pmab053        LIKE pmab_t.pmab053, #交易條件
      pmab053_desc   LIKE type_t.chr80,      
      xrea100        LIKE xrea_t.xrea100, #幣別 
      xrea1031       LIKE xrea_t.xrea103, #原幣期初金額
      xrea1032       LIKE xrea_t.xrea103, #原幣本期增加金額
      xrea1033       LIKE xrea_t.xrea103, #原幣本期減少金額 
      xrea1034       LIKE xrea_t.xrea103, #原幣期末金額
      xrea1131       LIKE xrea_t.xrea113, #本幣期初金額
      xrea1132       LIKE xrea_t.xrea113, #本幣本期增加金額
      xrea1133       LIKE xrea_t.xrea103, #本幣本期減少金額
      xrea1134       LIKE xrea_t.xrea103, #本幣期末金額  
      xrea1035       LIKE xrea_t.xrea103, #原幣壞帳數
      xrea1135       LIKE xrea_t.xrea113, #本幣壞帳數
      xrea103_01     LIKE xrea_t.xrea103, #未沖本幣
      xrea113_01     LIKE xrea_t.xrea113, #本幣壞帳
      xrea103_02     LIKE xrea_t.xrea103,
      xrea113_02     LIKE xrea_t.xrea113,
      xrea103_03     LIKE xrea_t.xrea103,
      xrea113_03     LIKE xrea_t.xrea113,
      xrea103_04     LIKE xrea_t.xrea103,
      xrea113_04     LIKE xrea_t.xrea113,
      xrea103_05     LIKE xrea_t.xrea103,
      xrea113_05     LIKE xrea_t.xrea113,
      xrea103_06     LIKE xrea_t.xrea103,
      xrea113_06     LIKE xrea_t.xrea113,
      xrea103_07     LIKE xrea_t.xrea103,
      xrea113_07     LIKE xrea_t.xrea113,
      xrea103_08     LIKE xrea_t.xrea103,
      xrea113_08     LIKE xrea_t.xrea113,
      xrea103_09     LIKE xrea_t.xrea103,
      xrea113_09     LIKE xrea_t.xrea113,
      xrea103_10     LIKE xrea_t.xrea103,
      xrea113_10     LIKE xrea_t.xrea113,
      xrea103_11     LIKE xrea_t.xrea103,
      xrea113_11     LIKE xrea_t.xrea113,
      xrea103_12     LIKE xrea_t.xrea103,
      xrea113_12     LIKE xrea_t.xrea113,
      xrea103_13     LIKE xrea_t.xrea103,
      xrea113_13     LIKE xrea_t.xrea113,
      xrea103_14     LIKE xrea_t.xrea103,
      xrea113_14     LIKE xrea_t.xrea113,
      xrea103_15     LIKE xrea_t.xrea103,
      xrea113_15     LIKE xrea_t.xrea113,
      xrea103_16     LIKE xrea_t.xrea103,
      xrea113_16     LIKE xrea_t.xrea113,
      xrea103_17     LIKE xrea_t.xrea103,
      xrea113_17     LIKE xrea_t.xrea113,
      xrea103_18     LIKE xrea_t.xrea103,
      xrea113_18     LIKE xrea_t.xrea113,
      xrea103_19     LIKE xrea_t.xrea103,
      xrea113_19     LIKE xrea_t.xrea113,
      xrea103_20     LIKE xrea_t.xrea103,
      xrea113_20     LIKE xrea_t.xrea113,
      xrea103_21     LIKE xrea_t.xrea103,
      xrea113_21     LIKE xrea_t.xrea113
                    END RECORD               
DEFINE g_xrea2_d   DYNAMIC ARRAY OF type_g_xrea2_d
DEFINE g_wc_xreald   STRING
DEFINE g_wc_xreasite STRING
#資料瀏覽之欄位 
DEFINE g_xrea3_d       DYNAMIC ARRAY OF RECORD    
       xrea002         LIKE xrea_t.xrea002
      END RECORD
      
DEFINE g_current_row   LIKE type_t.num5
DEFINE g_current_idx   LIKE type_t.num10
DEFINE g_jump          LIKE type_t.num10
DEFINE g_no_ask        LIKE type_t.num5
DEFINE g_rec_b         LIKE type_t.num5      
            
DEFINE g_xrea002       LIKE xrea_t.xrea002        #期別跳頁  
DEFINE g_xreald        LIKE xrea_t.xreald
DEFINE g_xreacomp      LIKE xrea_t.xreacomp

DEFINE g_strdate         LIKE glav_t.glav004 #會計日期
DEFINE g_enddate         LIKE glav_t.glav004 #會計日期

#日期區間使用的Array
DEFINE g_xrae      DYNAMIC ARRAY OF RECORD 
       str      LIKE xrae_t.xrae003,
       end      LIKE xrae_t.xrae004 
       END RECORD
DEFINE g_end_day    LIKE type_t.num5  #最後一天
DEFINE g_b2_wc      STRING #單身二所使用的條件
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_xrea_d
DEFINE g_master_t                   type_g_xrea_d
DEFINE g_xrea_d          DYNAMIC ARRAY OF type_g_xrea_d
DEFINE g_xrea_d_t        type_g_xrea_d
 
      
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
 
{<section id="aapq931.main" >}
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
   CALL cl_ap_init("aap","")
 
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
   DECLARE aapq931_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapq931_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapq931_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapq931 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapq931_init()   
 
      #進入選單 Menu (="N")
      CALL aapq931_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapq931
      
   END IF 
   
   CLOSE aapq931_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapq931.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapq931_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_sql         STRING
   DEFINE l_str         STRING
   DEFINE l_gzcb002     LIKE gzcb_t.gzcb002
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_create_account_center_tmp()
   CALL aapq931_create_tmp()
   
   CALL s_fin_set_comp_scc('year','43')      #年度
   CALL s_fin_set_comp_scc('strmon','111')   #13期  
   CALL s_fin_set_comp_scc('endmon','111')  
   CALL cl_set_combo_scc('group','8330')     #彙總條件
   CALL cl_set_combo_scc('dedtype','8328')   #扣除方式
   IF g_prog = 'aapq931' THEN
      CALL cl_set_combo_scc('b_xrea004','8502')     #帳款單性質
   ELSE
      CALL cl_set_combo_scc('b_xrea004','8302')
   END IF    
   #帳齡起算日基準
   LET l_sql = "SELECT gzcb002 FROM gzcb_t  ",
               " WHERE gzcb001 = '",8312,"' ",
               "   AND gzcb003  ='Y'        ",          
               " ORDER BY gzcb002           "
   PREPARE sel_s_fin_gzcb002p FROM l_sql
   DECLARE sel_s_fin_gzcb002c CURSOR FOR sel_s_fin_gzcb002p
   LET l_gzcb002 = NULL
   FOREACH sel_s_fin_gzcb002c INTO l_gzcb002
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      IF cl_null(l_str)THEN
         LET l_str = l_gzcb002 CLIPPED
      ELSE
         LET l_str = l_str CLIPPED,",",l_gzcb002 CLIPPED
      END IF
   END FOREACH   
   CALL cl_set_combo_scc_part('xrad004','8312',l_str)  
   
   #end add-point
 
   CALL aapq931_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aapq931.default_search" >}
PRIVATE FUNCTION aapq931_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xreald = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xrea001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xrea002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xrea003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xrea004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xrea005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " xrea006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " xrea007 = '", g_argv[08], "' AND "
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
 
{<section id="aapq931.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aapq931_ui_dialog()
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
   ELSE
      CALL aapq931_default()
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
      CALL aapq931_b_fill()
   ELSE
      CALL aapq931_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xrea_d.clear()
 
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
 
         CALL aapq931_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xrea_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aapq931_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aapq931_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               #筆數設定             
               DISPLAY g_current_idx TO FORMONLY.h_index
               DISPLAY g_xrea3_d.getLength() TO FORMONLY.h_count
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_xrea_d.getLength() TO FORMONLY.cnt
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_xrea2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt) 
         
         BEFORE DISPLAY 
            LET g_current_page = 1
            CALL ui.Interface.refresh()
         BEFORE ROW
            CALL ui.Interface.refresh()          
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aapq931_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
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
               CALL aapq931_query()
               #add-point:ON ACTION query name="menu.query"
               CALL cl_set_comp_visible('sel', FALSE)
               CALL cl_set_act_visible('selall,selnone,unsel,sel',FALSE)
               EXIT DIALOG
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
            CALL aapq931_filter()
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
            CALL aapq931_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xrea_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_xrea2_d)
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
            CALL aapq931_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aapq931_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aapq931_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aapq931_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xrea_d.getLength()
               LET g_xrea_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xrea_d.getLength()
               LET g_xrea_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xrea_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xrea_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xrea_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xrea_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
             
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION previous
            LET g_action_choice="previous"
            CALL aapq931_fetch1('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
 
         ON ACTION first
            LET g_action_choice="first"
            CALL aapq931_fetch1('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG

         ON ACTION jump
            LET g_action_choice="jump"
            CALL aapq931_fetch1('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
            
         ON ACTION next
            LET g_action_choice="next"
            CALL aapq931_fetch1('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
            
         ON ACTION last
            LET g_action_choice="last"
            CALL aapq931_fetch1('L')
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
 
{<section id="aapq931.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapq931_query()
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
   CALL g_xrea_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON xrea001,xrea002,xreald,xrea009,xrea004,xrea005,xrea006,xrea007,xrea008, 
          xrea100,xrea103,xrea113,xrea003
           FROM s_detail1[1].b_xrea001,s_detail1[1].b_xrea002,s_detail1[1].b_xreald,s_detail1[1].b_xrea009, 
               s_detail1[1].b_xrea004,s_detail1[1].b_xrea005,s_detail1[1].b_xrea006,s_detail1[1].b_xrea007, 
               s_detail1[1].b_xrea008,s_detail1[1].b_xrea100,s_detail1[1].b_xrea103,s_detail1[1].b_xrea113, 
               s_detail1[1].b_xrea003
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_xrea001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrea001
            #add-point:BEFORE FIELD b_xrea001 name="construct.b.page1.b_xrea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrea001
            
            #add-point:AFTER FIELD b_xrea001 name="construct.a.page1.b_xrea001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrea001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea001
            #add-point:ON ACTION controlp INFIELD b_xrea001 name="construct.c.page1.b_xrea001"
            
            #END add-point
 
 
         #----<<b_xrea002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrea002
            #add-point:BEFORE FIELD b_xrea002 name="construct.b.page1.b_xrea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrea002
            
            #add-point:AFTER FIELD b_xrea002 name="construct.a.page1.b_xrea002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrea002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea002
            #add-point:ON ACTION controlp INFIELD b_xrea002 name="construct.c.page1.b_xrea002"
            
            #END add-point
 
 
         #----<<b_xreald>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreald
            #add-point:BEFORE FIELD b_xreald name="construct.b.page1.b_xreald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreald
            
            #add-point:AFTER FIELD b_xreald name="construct.a.page1.b_xreald"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreald
            #add-point:ON ACTION controlp INFIELD b_xreald name="construct.c.page1.b_xreald"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_xreald
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept      
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO b_xreald
            NEXT FIELD b_xreald
            #END add-point
 
 
         #----<<xreald_desc>>----
         #----<<b_xrea009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrea009
            #add-point:BEFORE FIELD b_xrea009 name="construct.b.page1.b_xrea009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrea009
            
            #add-point:AFTER FIELD b_xrea009 name="construct.a.page1.b_xrea009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrea009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea009
            #add-point:ON ACTION controlp INFIELD b_xrea009 name="construct.c.page1.b_xrea009"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"
            CALL q_pmaa001_1()
            DISPLAY g_qryparam.return1 TO b_xrea009            
            NEXT FIELD b_xrea009   
            #END add-point
 
 
         #----<<xrea009_desc>>----
         #----<<b_xrea004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrea004
            #add-point:BEFORE FIELD b_xrea004 name="construct.b.page1.b_xrea004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrea004
            
            #add-point:AFTER FIELD b_xrea004 name="construct.a.page1.b_xrea004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrea004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea004
            #add-point:ON ACTION controlp INFIELD b_xrea004 name="construct.c.page1.b_xrea004"
          
            #END add-point
 
 
         #----<<b_xrea005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrea005
            #add-point:BEFORE FIELD b_xrea005 name="construct.b.page1.b_xrea005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrea005
            
            #add-point:AFTER FIELD b_xrea005 name="construct.a.page1.b_xrea005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrea005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea005
            #add-point:ON ACTION controlp INFIELD b_xrea005 name="construct.c.page1.b_xrea005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF g_prog = 'aapq931' THEN
               LET g_qryparam.where = " apcasite  IN  ",g_wc_xreasite, 
                                      " AND apcald IN ",g_wc_xreald
               CALL q_apcadocno()
            ELSE
               LET g_qryparam.where = " xrcasite  IN  ",g_wc_xreasite, 
                                      " AND xrcald IN ",g_wc_xreald
               CALL q_xrcadocno()
            
            END IF                      
            DISPLAY g_qryparam.return1 TO b_xrea004
            NEXT FIELD b_xrea004
            #END add-point
 
 
         #----<<b_xrea006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrea006
            #add-point:BEFORE FIELD b_xrea006 name="construct.b.page1.b_xrea006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrea006
            
            #add-point:AFTER FIELD b_xrea006 name="construct.a.page1.b_xrea006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrea006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea006
            #add-point:ON ACTION controlp INFIELD b_xrea006 name="construct.c.page1.b_xrea006"
            
            #END add-point
 
 
         #----<<b_xrea007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrea007
            #add-point:BEFORE FIELD b_xrea007 name="construct.b.page1.b_xrea007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrea007
            
            #add-point:AFTER FIELD b_xrea007 name="construct.a.page1.b_xrea007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrea007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea007
            #add-point:ON ACTION controlp INFIELD b_xrea007 name="construct.c.page1.b_xrea007"
            
            #END add-point
 
 
         #----<<b_xrea008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrea008
            #add-point:BEFORE FIELD b_xrea008 name="construct.b.page1.b_xrea008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrea008
            
            #add-point:AFTER FIELD b_xrea008 name="construct.a.page1.b_xrea008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrea008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea008
            #add-point:ON ACTION controlp INFIELD b_xrea008 name="construct.c.page1.b_xrea008"
            
            #END add-point
 
 
         #----<<l_apcc004>>----
         #----<<day>>----
         #----<<day2>>----
         #----<<b_xrea100>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrea100
            #add-point:BEFORE FIELD b_xrea100 name="construct.b.page1.b_xrea100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrea100
            
            #add-point:AFTER FIELD b_xrea100 name="construct.a.page1.b_xrea100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrea100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea100
            #add-point:ON ACTION controlp INFIELD b_xrea100 name="construct.c.page1.b_xrea100"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO b_xrea100     
            NEXT FIELD b_xrea100  
            #END add-point
 
 
         #----<<b_xrea103>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrea103
            #add-point:BEFORE FIELD b_xrea103 name="construct.b.page1.b_xrea103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrea103
            
            #add-point:AFTER FIELD b_xrea103 name="construct.a.page1.b_xrea103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrea103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea103
            #add-point:ON ACTION controlp INFIELD b_xrea103 name="construct.c.page1.b_xrea103"
            
            #END add-point
 
 
         #----<<b_xrea113>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrea113
            #add-point:BEFORE FIELD b_xrea113 name="construct.b.page1.b_xrea113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrea113
            
            #add-point:AFTER FIELD b_xrea113 name="construct.a.page1.b_xrea113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrea113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea113
            #add-point:ON ACTION controlp INFIELD b_xrea113 name="construct.c.page1.b_xrea113"
            
            #END add-point
 
 
         #----<<l_debt>>----
         #----<<l_xrea103_debt>>----
         #----<<l_xrea113_debt>>----
         #----<<b_xrea003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrea003
            #add-point:BEFORE FIELD b_xrea003 name="construct.b.page1.b_xrea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrea003
            
            #add-point:AFTER FIELD b_xrea003 name="construct.a.page1.b_xrea003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrea003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea003
            #add-point:ON ACTION controlp INFIELD b_xrea003 name="construct.c.page1.b_xrea003"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_input.xreasite,g_input.xreasite_desc,g_input.year,
                    g_input.strmon,g_input.endmon,g_input.group,
                    g_input.xrad001,g_input.xrad001_desc,g_input.xrad004,
                    g_input.apca0010,g_input.apca0012,
                    g_input.dedtype,g_input.curr,g_input.b_check   #01727 Add           g_input.b_check                                                                               
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         AFTER FIELD xreasite
            LET g_input.xreasite_desc = ''
            IF NOT cl_null(g_input.xreasite) THEN   
               CALL s_fin_account_center_with_ld_chk(g_input.xreasite,'',g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF                               
               #取得所屬法人+帳別
               CALL s_fin_orga_get_comp_ld(g_input.xreasite) RETURNING g_sub_success,g_errno,g_xreacomp,g_xreald
               CALL s_fin_account_center_sons_query('3',g_input.xreasite,g_today,'1')
               #取得帳務中心底下之組織範圍
               CALL s_fin_account_center_sons_str() RETURNING g_wc_xreasite
               CALL s_fin_get_wc_str(g_wc_xreasite) RETURNING g_wc_xreasite
               #取得帳務中心底下的帳套範圍               
               CALL s_fin_account_center_ld_str() RETURNING g_wc_xreald
               CALL s_fin_get_wc_str(g_wc_xreald) RETURNING g_wc_xreald                  
               LET g_input.xreasite_desc = s_desc_get_department_desc(g_input.xreasite)
               DISPLAY BY NAME g_input.xreasite_desc
               CALL aapq931_dedtype_def() #扣除方式
            END IF
             
         AFTER FIELD xrad001
            LET g_input.xrad001_desc = '' 
            IF NOT cl_null(g_input.xrad001) THEN                 
               LET g_chkparam.arg1 = g_input.xrad001
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_xrad001") THEN
                  LET g_input.xrad001 =''  
                  NEXT FIELD CURRENT                  
               END IF  
            END IF                  
            CALL aapq931_xrad001_ref() 
            # 重新取得帳齡基準日                             
            SELECT xrad004 INTO g_input.xrad004
              FROM xrad_t
             WHERE xradent = g_enterprise
               AND xrad001 = g_input.xrad001
            IF cl_null(g_input.xrad004) THEN LET g_input.xrad004 = '90' END IF
            DISPLAY BY NAME g_input.xrad004

         ON CHANGE curr
            IF g_input.curr ='Y' THEN
               CALL cl_set_comp_visible('b_xrea103,b_xrea100,xrea100,l_xrea103_debt,xrea1031,xrea1032,xrea1033,xrea1034',TRUE)
            ELSE
               CALL cl_set_comp_visible('b_xrea103,b_xrea100,xrea100,l_xrea103_debt,xrea1031,xrea1032,xrea1033,xrea1034',FALSE)
            END IF             
            
         ON CHANGE strmon
            IF g_input.endmon < g_input.strmon THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.code = 'agl-00227'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()                                             
               LET g_input.endmon = g_input.strmon
            END IF
            DISPLAY BY NAME g_input.endmon,g_input.strmon

         ON CHANGE endmon
            IF g_input.endmon < g_input.strmon THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agl-00228'
               LET g_errparam.extend =''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_input.strmon = g_input.endmon
            END IF
            DISPLAY BY NAME g_input.endmon,g_input.strmon
            
         ON CHANGE group
            CALL cl_set_comp_visible('group1,group2,group3,xrea011,xrea016,pmab053',FALSE)
            CALL cl_set_comp_visible('group1_desc,group2_desc,group3_desc,xrea011_desc,xrea016_desc,pmab053_desc',FALSE)
            CALL aapq931_get_type()
            CASE        
               WHEN g_input.group = '1' #會計科目 
                  CALL cl_set_comp_visible('group1',TRUE)         
                  CALL cl_set_comp_visible('group1_desc',TRUE)         
               WHEN g_input.group = '2' # 交易對象
                  CALL cl_set_comp_visible('group1,xrea011,xrea016,pmab053',TRUE)  
                  CALL cl_set_comp_visible('group1_desc,xrea011_desc,xrea016_desc,pmab053_desc',TRUE)         
               WHEN g_input.group = '3' # 業務對象
                  CALL cl_set_comp_visible('group1',TRUE)  
                  CALL cl_set_comp_visible('group1_desc',TRUE)         
               WHEN g_input.group = '4' # 業務人員
                  CALL cl_set_comp_visible('group1',TRUE)  
                  CALL cl_set_comp_visible('group1_desc',TRUE)         
               WHEN g_input.group = '5' #交易對象+科目 
                  CALL cl_set_comp_visible('group1,group2,xrea011,xrea016,pmab053',TRUE)                                         
                  CALL cl_set_comp_visible('group1_desc,group2_desc,xrea011_desc,xrea016_desc,pmab053_desc',TRUE)         
               WHEN g_input.group = '6' #帳套+交易對象
                  CALL cl_set_comp_visible('group1,group2,xrea011,xrea016,pmab053',TRUE) 
                  CALL cl_set_comp_visible('group1_desc,group2_desc,xrea011_desc,xrea016_desc,pmab053_desc',TRUE)         
               WHEN g_input.group = '7' #帳套+交易對象+科目
                  CALL cl_set_comp_visible('group1,group2,group3,xrea011,xrea016,pmab053',TRUE)             
                  CALL cl_set_comp_visible('group1_desc,group2_desc,group3_desc,xrea011_desc,xrea016_desc,pmab053_desc',TRUE)         
            END CASE
            
         AFTER FIELD apca0012
            IF g_input.apca0012 = 'Y' THEN
               LET g_input.dedtype = '4'
            END IF
            
         ON CHANGE apca0012
            IF g_input.apca0012 = 'Y' THEN
               LET g_input.dedtype ='4'
            END IF   
        
        ON CHANGE b_check   #01727
            CALL aapq931_dis()            
         
                
         ON ACTION controlp INFIELD xreasite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.xreasite
            LET g_qryparam.where = " ooef201 = 'Y' "
            CALL q_ooef001()
            LET g_input.xreasite = g_qryparam.return1
            CALL s_fin_account_center_sons_query('3',g_input.xreasite,g_today,'1')
            #取得帳務中心底下之組織範圍
            CALL s_fin_account_center_sons_str() RETURNING g_wc_xreasite
            CALL s_fin_get_wc_str(g_wc_xreasite) RETURNING g_wc_xreasite
            #取得帳務中心底下的帳套範圍               
            CALL s_fin_account_center_ld_str() RETURNING g_wc_xreald
            CALL s_fin_get_wc_str(g_wc_xreald) RETURNING g_wc_xreald      
            CALL s_desc_get_department_desc(g_input.xreasite) RETURNING g_input.xreasite_desc
            DISPLAY BY NAME  g_input.xreasite_desc
            NEXT FIELD xreasite

         ON ACTION controlp INFIELD xrad001
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.default1 = g_input.xrad001
            CALL q_xrad001()    
            LET g_input.xrad001 = g_qryparam.return1                               
            CALL aapq931_xrad001_ref()
            SELECT xrad004 INTO g_input.xrad004
              FROM xrad_t
             WHERE xradent = g_enterprise
               AND xrad001 = g_input.xrad001
            IF cl_null(g_input.xrad004)THEN LET g_input.xrad004  = '90' END IF
            DISPLAY BY NAME g_input.xrad001_desc,g_input.xrad004,g_input.xrad001,g_input.xrad004 
            NEXT FIELD xrad001     
         
      ENd INPUT
      
     
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
      CALL aapq931_default()
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
   CALL aapq931_insert_tmp()
   CALL aapq931_set_page()
   CALL aapq931_fetch1('F')
   LET g_error_show = 1
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = -100
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN
   END IF
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   RETURN
   #end add-point
        
   LET g_error_show = 1
   CALL aapq931_b_fill()
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
 
{</section>}
 
{<section id="aapq931.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapq931_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_day2            DATE #計算帳齡天數
   DEFINE l_glaa003         LIKE glaa_t.glaa003
   DEFINE l_apcc004         LIKE apcc_t.apcc004  # 90 應收付款日 
   DEFINE l_apcc010         LIKE apcc_t.apcc010  # 03 發票日期     
   DEFINE l_apcc011         LIKE apcc_t.apcc011  # 01 交易單據日期
   DEFINE l_apcc012         LIKE apcc_t.apcc012  # 05 立帳日期
   DEFINE l_apcc013         LIKE apcc_t.apcc013  # 09 交易認定日期
   DEFINE l_apcc014         LIKE apcc_t.apcc014  # 07 出入庫扣帳日期 
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL aapq931_insert_tmp()
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
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   
   LET ls_sql_rank = "SELECT  UNIQUE '',xrea001,xrea002,xreald,'',xrea009,'',xrea004,xrea005,xrea006, 
       xrea007,xrea008,'','','',xrea100,xrea103,xrea113,'','','',xrea003  ,DENSE_RANK() OVER( ORDER BY xrea_t.xreald, 
       xrea_t.xrea001,xrea_t.xrea002,xrea_t.xrea003,xrea_t.xrea004,xrea_t.xrea005,xrea_t.xrea006,xrea_t.xrea007) AS RANK FROM xrea_t", 
 
 
 
                     "",
                     " WHERE xreaent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xrea_t"),
                     " ORDER BY xrea_t.xreald,xrea_t.xrea001,xrea_t.xrea002,xrea_t.xrea003,xrea_t.xrea004,xrea_t.xrea005,xrea_t.xrea006,xrea_t.xrea007"
 
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
 
   LET g_sql = "SELECT '',xrea001,xrea002,xreald,'',xrea009,'',xrea004,xrea005,xrea006,xrea007,xrea008, 
       '','','',xrea100,xrea103,xrea113,'','','',xrea003",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = " SELECT ''    ,xrea001,xrea002,xreald,'',xrea009,'',xrea004,xrea005,xrea006,xrea007,     ",
               "       xrea008,apcc004,'','',xrea100,xrea103,xrea113,'',xrea103_debt,xrea113_debt,'' ",
               " FROM aapq931_tmp                                                                    ",
               " WHERE xreaent= ? AND xrea002 = '",g_xrea002,"' AND 1=1 AND ", ls_wc,cl_sql_add_filter("xrea_t") 
    LET g_b2_wc = ls_wc
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapq931_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapq931_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xrea_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_xrea_d[l_ac].sel,g_xrea_d[l_ac].xrea001,g_xrea_d[l_ac].xrea002,g_xrea_d[l_ac].xreald, 
       g_xrea_d[l_ac].xreald_desc,g_xrea_d[l_ac].xrea009,g_xrea_d[l_ac].xrea009_desc,g_xrea_d[l_ac].xrea004, 
       g_xrea_d[l_ac].xrea005,g_xrea_d[l_ac].xrea006,g_xrea_d[l_ac].xrea007,g_xrea_d[l_ac].xrea008,g_xrea_d[l_ac].l_apcc004, 
       g_xrea_d[l_ac].day,g_xrea_d[l_ac].day2,g_xrea_d[l_ac].xrea100,g_xrea_d[l_ac].xrea103,g_xrea_d[l_ac].xrea113, 
       g_xrea_d[l_ac].l_debt,g_xrea_d[l_ac].l_xrea103_debt,g_xrea_d[l_ac].l_xrea113_debt,g_xrea_d[l_ac].xrea003 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_xrea_d[l_ac].statepic = cl_get_actipic(g_xrea_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #取得會計週期參照表
      CALL s_ld_sel_glaa(g_xrea_d[l_ac].xreald,'glaa003') RETURNING g_sub_success,l_glaa003
      #本期起始結束日期      
      CALL s_fin_date_get_period_range(l_glaa003,g_input.year,g_xrea002)RETURNING g_strdate,g_enddate       
      #逾期天數
      LET g_xrea_d[l_ac].day = g_enddate - g_xrea_d[l_ac].l_apcc004 
      IF g_xrea_d[l_ac].day  < 0 OR cl_null(g_xrea_d[l_ac].day) THEN 
         LET  g_xrea_d[l_ac].day  = 0 
      END IF 
      
      #帳齡天數
      LET l_day2 = ''
      IF g_prog = 'aapq931' THEN   
         SELECT apcc011,  apcc010  ,apcc012  ,apcc014  ,apcc013  ,apcc004
           INTO l_apcc011,l_apcc010,l_apcc012,l_apcc014,l_apcc013,l_apcc004
           FROM apcc_t
          WHERE apccent    = g_enterprise
            AND apccdocno  = g_xrea_d[l_ac].xrea005
            AND apccseq    = g_xrea_d[l_ac].xrea006
            AND apcc001    = g_xrea_d[l_ac].xrea007
       ELSE    
          SELECT xrcc011,  xrcc010  ,xrcc012  ,xrcc014  ,xrcc013  ,xrcc004
            INTO l_apcc011,l_apcc010,l_apcc012,l_apcc014,l_apcc013,l_apcc004
            FROM xrcc_t
           WHERE xrccent    = g_enterprise
             AND xrccdocno  = g_xrea_d[l_ac].xrea005
             AND xrccseq    = g_xrea_d[l_ac].xrea006
             AND xrcc001    = g_xrea_d[l_ac].xrea007
      END IF
      
      CASE  #取帳齡天數 --> l_endate - 立帳日期
         WHEN g_input.xrad004 = '01' 
            IF cl_null(l_apcc011) THEN #01 交易單據日期
               LET g_xrea_d[l_ac].day2 = g_enddate - g_xrea_d[l_ac].xrea008
            ELSE   
               LET g_xrea_d[l_ac].day2 = g_enddate - l_apcc011   
            END IF 
         WHEN g_input.xrad004 = '03' #發票日期     
           IF cl_null(l_apcc010) THEN
              LET g_xrea_d[l_ac].day2 = g_enddate - g_xrea_d[l_ac].xrea008
           ELSE   
              LET g_xrea_d[l_ac].day2 = g_enddate - l_apcc010 
           END IF            
         WHEN  g_input.xrad004 = '05' #入庫日期 
             IF cl_null(l_apcc012) THEN
              LET g_xrea_d[l_ac].day2 = g_enddate - g_xrea_d[l_ac].xrea008
           ELSE   
              LET g_xrea_d[l_ac].day2 = g_enddate - l_apcc012 
           END IF                          
         WHEN g_input.xrad004 = '07' 
            #07 出入庫扣帳日期 
            IF cl_null(l_apcc014) THEN
              LET g_xrea_d[l_ac].day2 = g_enddate - g_xrea_d[l_ac].xrea008
            ELSE   
              LET g_xrea_d[l_ac].day2 = g_enddate - l_apcc014 
            END IF      
         WHEN g_input.xrad004 = '09'
            #09 交易認定日期
            IF cl_null(l_apcc013) THEN
              LET g_xrea_d[l_ac].day2 = g_enddate - g_xrea_d[l_ac].xrea008
            ELSE   
              LET g_xrea_d[l_ac].day2 = g_enddate - l_apcc013 
            END IF          
         WHEN g_input.xrad004 = '90'      
           #09 應收付款日           
           IF cl_null(l_apcc004) THEN
             LET g_xrea_d[l_ac].day2 = g_enddate - g_xrea_d[l_ac].xrea008
           ELSE   
             LET g_xrea_d[l_ac].day2 = g_enddate - l_apcc004 
           END IF               
      END CASE   
      #負的天數給0天
      IF g_xrea_d[l_ac].day2 < 0 THEN LET g_xrea_d[l_ac].day2 = 0 END IF
      #壞帳提列比率
      CALL aapq931_debt_ref()      
      #壞帳原幣金額
      LET g_xrea_d[l_ac].l_xrea103_debt = g_xrea_d[l_ac].l_xrea103_debt * g_xrea_d[l_ac].l_debt  /100
      #壞帳本幣金額
      LET g_xrea_d[l_ac].l_xrea113_debt = g_xrea_d[l_ac].l_xrea113_debt * g_xrea_d[l_ac].l_debt  /100         
      
      #交易對象/帳套             
      CALL s_desc_get_trading_partner_abbr_desc(g_xrea_d[l_ac].xrea009)RETURNING g_xrea_d[l_ac].xrea009_desc 
      CALL s_desc_get_ld_desc(g_xrea_d[l_ac].xreald) RETURNING g_xrea_d[l_ac].xreald_desc        
      
      #更新temp_taple
      UPDATE aapq931_tmp 
         SET (day2,debt
              ,xrea103_debt,xrea113_debt)  =     
             (g_xrea_d[l_ac].day2,g_xrea_d[l_ac].l_debt,
              g_xrea_d[l_ac].l_xrea103_debt,g_xrea_d[l_ac].l_xrea113_debt )
       WHERE xrea002   = g_xrea002
         AND xrea005   = g_xrea_d[l_ac].xrea005
         AND xrea006   = g_xrea_d[l_ac].xrea006
         AND xrea007   = g_xrea_d[l_ac].xrea007
         AND xrea004   = g_xrea_d[l_ac].xrea004  
               
      #end add-point
 
      CALL aapq931_detail_show("'1'")      
 
      CALL aapq931_xrea_t_mask()
 
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
   
 
   
   CALL g_xrea_d.deleteElement(g_xrea_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   CALL aapq931_b_fill2()
   #end add-point
 
   LET g_detail_cnt = g_xrea_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aapq931_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aapq931_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aapq931_detail_action_trans()
 
   IF g_xrea_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aapq931_fetch()
   END IF
   
      CALL aapq931_filter_show('xrea001','b_xrea001')
   CALL aapq931_filter_show('xrea002','b_xrea002')
   CALL aapq931_filter_show('xreald','b_xreald')
   CALL aapq931_filter_show('xrea009','b_xrea009')
   CALL aapq931_filter_show('xrea004','b_xrea004')
   CALL aapq931_filter_show('xrea005','b_xrea005')
   CALL aapq931_filter_show('xrea006','b_xrea006')
   CALL aapq931_filter_show('xrea007','b_xrea007')
   CALL aapq931_filter_show('xrea008','b_xrea008')
   CALL aapq931_filter_show('xrea100','b_xrea100')
   CALL aapq931_filter_show('xrea103','b_xrea103')
   CALL aapq931_filter_show('xrea113','b_xrea113')
   CALL aapq931_filter_show('xrea003','b_xrea003')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq931.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapq931_fetch()
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
 
{<section id="aapq931.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapq931_detail_show(ps_page)
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
 
{<section id="aapq931.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapq931_filter()
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
      CONSTRUCT g_wc_filter ON xrea001,xrea002,xreald,xrea009,xrea004,xrea005,xrea006,xrea007,xrea008, 
          xrea100,xrea103,xrea113,xrea003
                          FROM s_detail1[1].b_xrea001,s_detail1[1].b_xrea002,s_detail1[1].b_xreald,s_detail1[1].b_xrea009, 
                              s_detail1[1].b_xrea004,s_detail1[1].b_xrea005,s_detail1[1].b_xrea006,s_detail1[1].b_xrea007, 
                              s_detail1[1].b_xrea008,s_detail1[1].b_xrea100,s_detail1[1].b_xrea103,s_detail1[1].b_xrea113, 
                              s_detail1[1].b_xrea003
 
         BEFORE CONSTRUCT
                     DISPLAY aapq931_filter_parser('xrea001') TO s_detail1[1].b_xrea001
            DISPLAY aapq931_filter_parser('xrea002') TO s_detail1[1].b_xrea002
            DISPLAY aapq931_filter_parser('xreald') TO s_detail1[1].b_xreald
            DISPLAY aapq931_filter_parser('xrea009') TO s_detail1[1].b_xrea009
            DISPLAY aapq931_filter_parser('xrea004') TO s_detail1[1].b_xrea004
            DISPLAY aapq931_filter_parser('xrea005') TO s_detail1[1].b_xrea005
            DISPLAY aapq931_filter_parser('xrea006') TO s_detail1[1].b_xrea006
            DISPLAY aapq931_filter_parser('xrea007') TO s_detail1[1].b_xrea007
            DISPLAY aapq931_filter_parser('xrea008') TO s_detail1[1].b_xrea008
            DISPLAY aapq931_filter_parser('xrea100') TO s_detail1[1].b_xrea100
            DISPLAY aapq931_filter_parser('xrea103') TO s_detail1[1].b_xrea103
            DISPLAY aapq931_filter_parser('xrea113') TO s_detail1[1].b_xrea113
            DISPLAY aapq931_filter_parser('xrea003') TO s_detail1[1].b_xrea003
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xrea001>>----
         #Ctrlp:construct.c.filter.page1.b_xrea001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea001
            #add-point:ON ACTION controlp INFIELD b_xrea001 name="construct.c.filter.page1.b_xrea001"
            
            #END add-point
 
 
         #----<<b_xrea002>>----
         #Ctrlp:construct.c.filter.page1.b_xrea002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea002
            #add-point:ON ACTION controlp INFIELD b_xrea002 name="construct.c.filter.page1.b_xrea002"
            
            #END add-point
 
 
         #----<<b_xreald>>----
         #Ctrlp:construct.c.filter.page1.b_xreald
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreald
            #add-point:ON ACTION controlp INFIELD b_xreald name="construct.c.filter.page1.b_xreald"
            
            #END add-point
 
 
         #----<<xreald_desc>>----
         #----<<b_xrea009>>----
         #Ctrlp:construct.c.filter.page1.b_xrea009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea009
            #add-point:ON ACTION controlp INFIELD b_xrea009 name="construct.c.filter.page1.b_xrea009"
            
            #END add-point
 
 
         #----<<xrea009_desc>>----
         #----<<b_xrea004>>----
         #Ctrlp:construct.c.filter.page1.b_xrea004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea004
            #add-point:ON ACTION controlp INFIELD b_xrea004 name="construct.c.filter.page1.b_xrea004"
            
            #END add-point
 
 
         #----<<b_xrea005>>----
         #Ctrlp:construct.c.filter.page1.b_xrea005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea005
            #add-point:ON ACTION controlp INFIELD b_xrea005 name="construct.c.filter.page1.b_xrea005"
            
            #END add-point
 
 
         #----<<b_xrea006>>----
         #Ctrlp:construct.c.filter.page1.b_xrea006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea006
            #add-point:ON ACTION controlp INFIELD b_xrea006 name="construct.c.filter.page1.b_xrea006"
            
            #END add-point
 
 
         #----<<b_xrea007>>----
         #Ctrlp:construct.c.filter.page1.b_xrea007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea007
            #add-point:ON ACTION controlp INFIELD b_xrea007 name="construct.c.filter.page1.b_xrea007"
            
            #END add-point
 
 
         #----<<b_xrea008>>----
         #Ctrlp:construct.c.filter.page1.b_xrea008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea008
            #add-point:ON ACTION controlp INFIELD b_xrea008 name="construct.c.filter.page1.b_xrea008"
            
            #END add-point
 
 
         #----<<l_apcc004>>----
         #----<<day>>----
         #----<<day2>>----
         #----<<b_xrea100>>----
         #Ctrlp:construct.c.filter.page1.b_xrea100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea100
            #add-point:ON ACTION controlp INFIELD b_xrea100 name="construct.c.filter.page1.b_xrea100"
            
            #END add-point
 
 
         #----<<b_xrea103>>----
         #Ctrlp:construct.c.filter.page1.b_xrea103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea103
            #add-point:ON ACTION controlp INFIELD b_xrea103 name="construct.c.filter.page1.b_xrea103"
            
            #END add-point
 
 
         #----<<b_xrea113>>----
         #Ctrlp:construct.c.filter.page1.b_xrea113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea113
            #add-point:ON ACTION controlp INFIELD b_xrea113 name="construct.c.filter.page1.b_xrea113"
            
            #END add-point
 
 
         #----<<l_debt>>----
         #----<<l_xrea103_debt>>----
         #----<<l_xrea113_debt>>----
         #----<<b_xrea003>>----
         #Ctrlp:construct.c.filter.page1.b_xrea003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea003
            #add-point:ON ACTION controlp INFIELD b_xrea003 name="construct.c.filter.page1.b_xrea003"
            
            #END add-point
 
 
   
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      ON ACTION controlp
         CASE
            WHEN INFIELD(b_xreald)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_xreald
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               CALL q_authorised_ld()
               DISPLAY g_qryparam.return1 TO b_xreald
               NEXT FIELD b_xreald
               
           WHEN INFIELD(b_xrea009)
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
              LET g_qryparam.reqry = FALSE
              LET g_qryparam.arg1 = "('1','3')"
              CALL q_pmaa001_1()
              DISPLAY g_qryparam.return1 TO b_xrea009
              NEXT FIELD b_xrea009
      
           WHEN INFIELD (b_xrea005)
              LET g_qryparam.state = 'c'
              LET g_qryparam.reqry = FALSE
              IF g_prog = 'aapq931' THEN
                 LET g_qryparam.where = " apcasite  IN  ",g_wc_xreasite,
                                        " AND apcald IN ",g_wc_xreald
                 CALL q_apcadocno()
              ELSE
                 LET g_qryparam.where = " xrcasite  IN  ",g_wc_xreasite,
                                        " AND xrcald IN ",g_wc_xreald
                 CALL q_xrcadocno()              
              END IF
              DISPLAY g_qryparam.return1 TO b_xrea005
              NEXT FIELD b_xrea004
           
           WHEN INFIELD (b_xrea100)
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
              LET g_qryparam.reqry = FALSE
              CALL q_ooai001()
              DISPLAY g_qryparam.return1 TO b_xrea100
              NEXT FIELD b_xrea100
         END CASE
           
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
   
      CALL aapq931_filter_show('xrea001','b_xrea001')
   CALL aapq931_filter_show('xrea002','b_xrea002')
   CALL aapq931_filter_show('xreald','b_xreald')
   CALL aapq931_filter_show('xrea009','b_xrea009')
   CALL aapq931_filter_show('xrea004','b_xrea004')
   CALL aapq931_filter_show('xrea005','b_xrea005')
   CALL aapq931_filter_show('xrea006','b_xrea006')
   CALL aapq931_filter_show('xrea007','b_xrea007')
   CALL aapq931_filter_show('xrea008','b_xrea008')
   CALL aapq931_filter_show('xrea100','b_xrea100')
   CALL aapq931_filter_show('xrea103','b_xrea103')
   CALL aapq931_filter_show('xrea113','b_xrea113')
   CALL aapq931_filter_show('xrea003','b_xrea003')
 
    
   CALL aapq931_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq931.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapq931_filter_parser(ps_field)
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
 
{<section id="aapq931.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapq931_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapq931_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq931.insert" >}
#+ insert
PRIVATE FUNCTION aapq931_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapq931.modify" >}
#+ modify
PRIVATE FUNCTION aapq931_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq931.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aapq931_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq931.delete" >}
#+ delete
PRIVATE FUNCTION aapq931_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq931.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aapq931_detail_action_trans()
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
 
{<section id="aapq931.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aapq931_detail_index_setting()
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
            IF g_xrea_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xrea_d.getLength() AND g_xrea_d.getLength() > 0
            LET g_detail_idx = g_xrea_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xrea_d.getLength() THEN
               LET g_detail_idx = g_xrea_d.getLength()
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
 
{<section id="aapq931.mask_functions" >}
 &include "erp/aap/aapq931_mask.4gl"
 
{</section>}
 
{<section id="aapq931.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 新增臨時表
# Memo...........:
# Usage..........: CALL aapq931_create_tmp()
# Date & Author..: 2015/01/27 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq931_create_tmp()

   DROP TABLE aapq931_tmp;
      CREATE TEMP TABLE aapq931_tmp(
             xrea001        SMALLINT,          #年度
             xrea002        SMALLINT,          #期別
             xreald         VARCHAR(5),
             xrea009        VARCHAR(10),          #交易對象
             xrea004        VARCHAR(10),          #帳款單性質
             xrea005        VARCHAR(20),          #單據號碼
             xrea006        INTEGER,          #項次
             xrea007        SMALLINT,          #項序
             xrea008        DATE,          #立帳日期
             apcc004        DATE,          #應兌現日
             day2           VARCHAR(500),           #帳齡天數
             xrea100        VARCHAR(10),          #幣別   
             xrea103        DECIMAL(20,6),          #原幣未沖金額
             xrea113        DECIMAL(20,6),          #本幣未沖金額
             debt           DECIMAL(20,6),          #壞帳提列比率
             xrea103_debt   DECIMAL(20,6),          #壞帳原幣金額
             xrea113_debt   DECIMAL(20,6),          #壞帳本幣金額
             xrea019        VARCHAR(24),          #應付科目      1
             xrea011        VARCHAR(10),          #業務部門      3
             xrea016        VARCHAR(20),          #業務人員          
             per            VARCHAR(1),             #上期資料flag
             xreaent        SMALLINT,
             apcc108        DECIMAL(20,6),
             apcc118        DECIMAL(20,6)
              )       
   CREATE INDEX aap_ix1 ON aapq931_temp (xrea002)
   
   
   
END FUNCTION

################################################################################
# Descriptions...: 插入臨時表
# Memo...........:
# Usage..........: CALL aapq931_insert_tmp()
# Date & Author..: 2015/01/27 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq931_insert_tmp()
DEFINE l_cnt           LIKE type_t.num5
DEFINE l_glaa003       LIKE glaa_t.glaa003
DEFINE l_ld            LIKE glaa_t.glaald  
DEFINE l_preyear       LIKE xrea_t.xrea001 #上期年
DEFINE l_premon        LIKE xrea_t.xrea002 #上期月
DEFINE l_strdate       LIKE apca_t.apcadocdt
DEFINE l_enddate       LIKE apca_t.apcadocdt
DEFINE l_date1         LIKE apca_t.apcadocdt
DEFINE l_date2         LIKE apca_t.apcadocdt 
DEFINE l_xrea001  LIKE xrea_t.xrea001
DEFINE l_xrea002  LIKE xrea_t.xrea002
   
   DELETE FROM aapq931_tmp   
   LET g_sql = " SELECT glaald FROM glaa_t ",
               "  WHERE glaaent = ",g_enterprise,"  ",
               "    AND glaald IN ",g_wc_xreald CLIPPED,
               "    AND (glaa008 = 'Y' OR glaa014 = 'Y') " 
   PREPARE aapq931_ldp1 FROM g_sql
   DECLARE aapq931_ldc1 CURSOR FOR aapq931_ldp1      
   FOREACH aapq931_ldc1 INTO l_ld
      CALL s_ld_sel_glaa(l_ld,'glaa003') RETURNING g_sub_success,l_glaa003     
      #取上期會計年月
      CALL s_fin_date_get_last_period(l_glaa003,l_ld,g_input.year,g_input.strmon)
                        RETURNING g_sub_success,l_preyear,l_premon
      IF g_prog = 'aapq931' THEN
         LET g_sql =   "   INSERT INTO aapq931_tmp                                      ", #上期年月
                       "   SELECT  xrea001,xrea002,xreald,xrea009,xrea004,              ",
                       "           xrea005,xrea006,xrea007,xrea008,apcc004,0,xrea100,   ",                                                                              
                       "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea103 *-1 ELSE xrea103 END), ",
                       "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea113 *-1 ELSE xrea113 END), ",
                       "           0,                                                                                                    ",      
                       "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea103 *-1 ELSE xrea103 END), ",
                       "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea113 *-1 ELSE xrea113 END), ",                                                                 
                       "           xrea019,xrea011,xrea016,1,xreaent,0,0                                          ",
                       "      FROM xrea_t,apcc_t                                                                ", 
                       "     WHERE xrea005 = apccdocno AND xrea006 = apccseq AND xrea007 = apcc001              ",       
                       "       AND xreaent = apccent AND xreaent = '",g_enterprise,"'                           ",
                       "       AND xreald = '",l_ld,"'                                                          ",
                       "       AND xrea003 = 'AP'                                                               ",
                       "       AND xrea001 = '",l_preyear,"'                                                    ",
                       "       AND xrea002 = '",l_premon,"'                                                     ",
                       "       AND xreasite IN  ", g_wc_xreasite                          
         LET g_sql = g_sql CLIPPED,
                     " AND ((xrea004 NOT LIKE '2%' AND xrea004 NOT LIKE '0%') "         
         IF g_input.apca0010 = 'Y' THEN
            LET g_sql = g_sql CLIPPED,
                    " OR (xrea004 LIKE '0%' ) "
         END IF         
         IF g_input.apca0012 = 'Y' THEN
            LET g_sql = g_sql CLIPPED,
                     " OR (xrea004 LIKE '2%') "
         END IF   
         LET g_sql = g_sql CLIPPED,")",
                          "     UNION  ",           # 本期區間
                          "   SELECT  xrea001,xrea002,xreald,xrea009,xrea004,              ",  
                          "           xrea005,xrea006,xrea007,xrea008,apcc004,0,xrea100,   ",                                                    
                          "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea103 *-1 ELSE xrea103 END), ",
                          "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea113 *-1 ELSE xrea113 END), ",
                          "           0,                                                                                                    ",   
                          "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea103 *-1 ELSE xrea103 END), ",
                          "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea113 *-1 ELSE xrea113 END), ",   
                          "           xrea019,xrea011,xrea016,2,xreaent,0,0                                         ",
                          "      FROM xrea_t,apcc_t                                                               ", 
                          "     WHERE xrea005 = apccdocno AND xrea006 = apccseq AND xrea007 = apcc001             ",       
                          "       AND xreaent = apccent AND xreaent = '",g_enterprise,"'                          ",
                          "       AND xreald = '",l_ld,"'                                                         ",
                          "       AND xrea003 = 'AP'                                                              ",
                          "       AND xrea001 = '",g_input.year,"'                                                ",
                          "       AND xrea002 BETWEEN  '",g_input.strmon,"' AND '",g_input.endmon,"'              ",
                          "       AND xreasite IN  ", g_wc_xreasite
         LET g_sql = g_sql CLIPPED,
                          " AND ((xrea004 NOT LIKE '2%' AND xrea004 NOT LIKE '0%') "         
         IF g_input.apca0010 = 'Y' THEN
            LET g_sql = g_sql CLIPPED,
                          " OR (xrea004 LIKE '0%' ) "
         END IF         
         IF g_input.apca0012 = 'Y' THEN
            LET g_sql = g_sql CLIPPED,
                         " OR (xrea004 LIKE '2%') "
         END IF    
         LET g_sql = g_sql CLIPPED,")"      
      ELSE
         LET g_sql =   "   INSERT INTO aapq931_tmp ", #上期年月
                       "   SELECT  xrea001,xrea002,xreald,xrea009,xrea004,              ",
                       "           xrea005,xrea006,xrea007,xrea008,xrcc004,0,xrea100,   ",                                                    
                       "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea103 *-1 ELSE xrea103 END), ",
                       "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea113 *-1 ELSE xrea113 END), ",
                       "           0,                                                                                                    ",   
                       "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea103 *-1 ELSE xrea103 END), ",
                       "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea113 *-1 ELSE xrea113 END), ",   
                       "           xrea019,xrea011,xrea016,1,xreaent,0,0                                          ",
                       "      FROM xrea_t,xrcc_t                                                                ", 
                       "     WHERE xrea005 = xrccdocno AND xrea006 = xrccseq AND xrea007 = xrcc001              ",       
                       "       AND xreaent = xrccent AND xreaent = '",g_enterprise,"'                           ",
                       "       AND xreald = '",l_ld,"'                                                          ",
                       "       AND xrea003 = 'AR'                                                               ",
                       "       AND xrea001 = '",l_preyear,"'                                                    ",
                       "       AND xrea002 = '",l_premon,"'                                                     ",
                       "       AND xreasite IN  ", g_wc_xreasite    
         LET g_sql = g_sql CLIPPED,
                     " AND ((xrea004 NOT LIKE '2%' AND xrea004 NOT LIKE '0%') "         
         IF g_input.apca0010 = 'Y' THEN
            LET g_sql = g_sql CLIPPED,
                    " OR (xrea004 LIKE '0%' ) "
         END IF         
         IF g_input.apca0012 = 'Y' THEN
            LET g_sql = g_sql CLIPPED,
                     " OR (xrea004 LIKE '2%') "
         END IF       
         LET g_sql = g_sql CLIPPED,")",
                           "     UNION  ",           # 本期區間
                           "   SELECT  xrea001,xrea002,xreald,xrea009,xrea004,              ",
                           "           xrea005,xrea006,xrea007,xrea008,xrcc004,0,xrea100,   ",                                                    
                           "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea103 *-1 ELSE xrea103 END), ",
                           "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea113 *-1 ELSE xrea113 END), ",
                           "           0,                                                                                                    ",   
                           "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea103 *-1 ELSE xrea103 END), ",
                           "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea113 *-1 ELSE xrea113 END), ",   
                           "           xrea019,xrea011,xrea016,2,xreaent,0,0                                         ",                        
                           "      FROM xrea_t,xrcc_t                                                               ", 
                           "     WHERE xrea005 = xrccdocno AND xrea006 = xrccseq AND xrea007 = xrcc001             ",       
                           "       AND xreaent = xrccent AND xreaent = '",g_enterprise,"'                          ",
                           "       AND xreald = '",l_ld,"'                                                         ",
                           "       AND xrea003 = 'AR'                                                              ",
                           "       AND xrea001 = '",g_input.year,"'                                                ",
                           "       AND xrea002 BETWEEN  '",g_input.strmon,"' AND '",g_input.endmon,"'              ",
                           "       AND xreasite IN  ", g_wc_xreasite                         
         #暫估類帳款納入分析否
         LET g_sql = g_sql CLIPPED,
                     " AND ((xrea004 NOT LIKE '2%' AND xrea004 NOT LIKE '0%') "       
         IF g_input.apca0010 = 'Y' THEN
            LET g_sql = g_sql CLIPPED,
                     " OR (xrea004 LIKE '0%' ) "
         END IF       
         IF g_input.apca0012 = 'Y' THEN
            LET g_sql = g_sql CLIPPED,
                     " OR (xrea004 LIKE '2%') "
         END IF       
         LET g_sql = g_sql CLIPPED,")"
      END IF
   
      PREPARE aapq931_ins_tmp_1 FROM g_sql
      EXECUTE aapq931_ins_tmp_1 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF    
   
#     CALL s_ld_sel_glaa(l_ld,'glaa003') RETURNING g_sub_success,l_glaa003
#     CALL s_fin_date_get_period_range(l_glaa003,g_input.year,g_input.strmon)RETURNING l_strdate,l_date1 #開始日期
#     #如果取不到取上期會計日期的起始日期
#     IF cl_null(l_strdate) THEN
#        CALL s_fin_date_get_last_period(l_glaa003,l_ld,g_input.year,g_input.strmon)
#                         RETURNING g_sub_success,l_xrea001,l_xrea002
#        CALL s_fin_date_get_period_range(l_glaa003,l_xrea001,l_xrea002)RETURNING l_strdate,l_date1 #開始日期                    
#     END IF
#     CALL s_fin_date_get_period_range(l_glaa003,g_input.year,g_input.endmon)RETURNING l_date2,l_enddate #結束日期
#     IF cl_null(l_enddate) THEN
#        CALL s_fin_date_get_last_period(l_glaa003,l_ld,g_input.year,g_input.endmon)
#                         RETURNING g_sub_success,l_xrea001,l_xrea002
#        CALL s_fin_date_get_period_range(l_glaa003,l_xrea001,l_xrea002)RETURNING l_date2,l_enddate #結束日期                    
#     END IF
#     
#     IF g_prog = 'aapq931' THEN
#      LET g_sql =        "   INSERT INTO aapq931_tmp ", 
#                         "   SELECT  to_char(apcadocdt,'yyyy'),to_char(apcadocdt,'mm'),apccld,apca004,apca001,    ",
#                         "           apccdocno,apccseq,apcc001,apcadocdt,apcc004,0,apca100,                       ",
#                         "           0,0,0,0,0,                                                                   ",
#                         "           apca035,apca015,apca014,2,apcaent,            ",
#                         "(CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN apcc108 *-1 ELSE apcc108 END),  ",
#                         "(CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN apcc118 *-1 ELSE apcc118 END)  ",
#                         "      FROM apca_t,apcc_t                                                                ",
#                         "    WHERE apcaent = apccent AND apcaent = '",g_enterprise,"'                            ",
#                         "      AND apcadocno = apccdocno AND apcald = apccld                                     ",
#                         "      AND apcadocno NOT IN (SELECT xrea005 FROM aapq931_tmp)                           ",
#                         "      AND apcastus = 'Y'                                                               ",
#                         "      AND apcadocdt BETWEEN '",l_strdate,"' AND '",l_enddate,"'                    ",      
#                         "      AND apcald = '",l_ld,"'                                                          ",
#                         "      AND apcasite IN  ", g_wc_xreasite    
#      LET g_sql = g_sql CLIPPED,
#                         " AND ((apca001 NOT LIKE '2%' AND apca001 NOT LIKE '0%') "         
#      IF g_input.apca0010 = 'Y' THEN
#         LET g_sql = g_sql CLIPPED,
#                        " OR (apca001 LIKE '0%' ) "
#      END IF         
#      IF g_input.apca0012 = 'Y' THEN
#         LET g_sql = g_sql CLIPPED,
#                  " OR (apca004 LIKE '2%') "
#      END IF       
#      LET g_sql = g_sql CLIPPED,")"
#      PREPARE aapq931_ins_tmp_2 FROM g_sql
#      EXECUTE aapq931_ins_tmp_2 
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = ""
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#      END IF 
#   ELSE
#      LET g_sql =     "   INSERT INTO aapq931_tmp ", 
#                      "   SELECT  to_char(xrcadocdt,'yyyy'),to_char(xrcadocdt,'MM'),xrccld,xrca004,xrca001,                ",    #150227 albireo ap->xr
#                      "           xrccdocno,xrccseq,xrcc001,xrcadocdt,xrcc004,0,xrca100,                  ",   #albireo 150227 xrca005->xrca100
#                      "           0,0,0,0,0,                                                               ",
#                      "           xrca035,xrca015,xrca014,2,xrcaent,                                      ",
#                      "(CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN xrcc108 *-1 ELSE xrcc108 END),  ",
#                      "(CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN xrcc118 * -1 ELSE xrcc118 END)  ", #150227 albireo ap->xr    
#                      "      FROM xrca_t,xrcc_t                                                                ",
#                      "    WHERE xrcaent = xrccent AND xrcaent = '",g_enterprise,"'                            ",
#                      "      AND xrcadocno = xrccdocno AND xrcald = xrccld                                     ",
#                      "      AND xrcadocno NOT IN (SELECT xrea005 FROM aapq931_tmp)                           ",
#                      "      AND xrcastus = 'Y'                                                               ",
#                      "      AND xrcadocdt BETWEEN '",l_strdate,"' AND '",l_enddate,"'                    ",      
#                      "      AND xrcald = '",l_ld,"'                                                          ",
#                      "      AND xrcasite IN  ", g_wc_xreasite    
#      LET g_sql = g_sql CLIPPED,
#                      " AND ((xrca001 NOT LIKE '2%' AND xrca001 NOT LIKE '0%') "         
#      IF g_input.apca0010 = 'Y' THEN
#         LET g_sql = g_sql CLIPPED,
#                      " OR (xrca001 LIKE '0%' ) "
#      END IF         
#      IF g_input.apca0012 = 'Y' THEN
#         LET g_sql = g_sql CLIPPED,
#                      " OR (xrca004 LIKE '2%') "
#      END IF       
#      LET g_sql = g_sql CLIPPED,")"          
#         SELECT COUNT(*) INTO l_cnt FROM aapq931_tmp
#      PREPARE aapq931_ins_tmp_3 FROM g_sql
#      EXECUTE aapq931_ins_tmp_3 
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = ""
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#      END IF 
#     END IF
   END FOREACH  
   
   SELECT COUNT(*) INTO l_cnt FROM aapq931_tmp
END FUNCTION

################################################################################
# Descriptions...: 設置翻頁
# Memo...........:
# Usage..........: CALL aapq931_set_page
# Date & Author..: 2015/01/27 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq931_set_page()
DEFINE l_idx    LIKE type_t.num5
DEFINE l_sql    STRING
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   CALL g_xrea3_d.clear()
   #只依照期別跳頁
   LET l_sql="   SELECT DISTINCT xrea002 ",
             "     FROM aapq931_tmp ",
             "    WHERE 1=1  AND ", g_wc ,
             "      AND per = '2' ",
             " ORDER BY xrea002 "      
   
   PREPARE aapq931_pr FROM l_sql
   DECLARE aapq931_cr CURSOR FOR aapq931_pr      
   LET l_idx=1  
   FOREACH aapq931_cr INTO g_xrea3_d[l_idx].xrea002
      IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = 'FOREACH aapq931_cr'
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
      IF cl_null(g_xrea3_d[l_idx].xrea002) THEN
         CALL g_xrea3_d.deleteElement(l_idx)
      ELSE
         LET l_idx=l_idx+1
      END IF        
     
   END FOREACH 
   
   LET l_idx=l_idx - 1
   CALL g_xrea3_d.deleteElement(g_xrea3_d.getLength())
   LET g_header_cnt = g_xrea3_d.getLength()
   LET g_rec_b = l_idx   
   DISPLAY g_header_cnt TO FORMONLY.h_count     
END FUNCTION

################################################################################
# Descriptions...: 抓取分頁資料
# Memo...........:
# Usage..........: CALL aapq931_fetch1(p_flag)
# Input parameter: p_flag    所在筆數 
# Date & Author..: 2014/01/27 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq931_fetch1(p_flag)
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

         IF g_jump > 0 AND g_jump <= g_xrea3_d.getLength() THEN
             LET g_current_idx = g_jump
         END IF

         LET g_no_ask = FALSE
   END CASE
   #代表沒有資料
   IF g_current_idx = 0 OR g_xrea3_d.getLength() = 0 THEN
      RETURN
   END IF

   #超出範圍
   IF g_current_idx > g_xrea3_d.getLength() THEN
      LET g_current_idx = g_xrea3_d.getLength()
   END IF
   
   DISPLAY g_current_idx TO FORMONLY.h_index                                 
   LET g_xrea002 = g_xrea3_d[g_current_idx].xrea002
   
   CALL aapq931_b_fill()        
END FUNCTION

################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL aapq931_default()
# Date & Author..: 2015/01/27 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq931_default()
   
   #帳務組織/帳套/法人預設
   CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,
                                                       g_input.xreasite,g_xreald,g_xreacomp   
   CALL s_fin_account_center_sons_query('3',g_input.xreasite,g_today,'1')
   #取得帳務中心底下之組織範圍
   CALL s_fin_account_center_sons_str() RETURNING g_wc_xreasite
   CALL s_fin_get_wc_str(g_wc_xreasite) RETURNING g_wc_xreasite
   #取得帳務中心底下的帳套範圍   
   CALL s_fin_account_center_ld_str() RETURNING g_wc_xreald
   CALL s_fin_get_wc_str(g_wc_xreald) RETURNING g_wc_xreald

   CALL s_desc_get_department_desc(g_input.xreasite) RETURNING g_input.xreasite_desc     
   #帳齡預設
   IF g_prog = 'aapq931' THEN
      SELECT glcb003 INTO g_input.xrad001
        FROM glcb_t
       WHERE glcbent = g_enterprise
         AND glcbld  = g_xreald
         AND glcb001 = 'AP'
   ELSE
      SELECT glcb003 INTO g_input.xrad001
        FROM glcb_t
       WHERE glcbent = g_enterprise
         AND glcbld  = g_xreald
         AND glcb001 = 'AR'
   END IF
   
   IF NOT cl_null(g_input.xrad001)THEN
      #帳齡起算日基準  
      SELECT xrad004 INTO g_input.xrad004
        FROM xrad_t
       WHERE xradent = g_enterprise
         AND xrad001 = g_input.xrad001       
   END IF
   CALL aapq931_dedtype_def() #扣除方式
   CALL aapq931_xrad001_ref()
   IF cl_null(g_input.xrad004)THEN LET g_input.xrad004 = '90' END IF   
   LET g_input.group = '2'     #彙總方式
   LET g_input.apca0010 = 'Y'
   LET g_input.apca0012 = 'Y'
   LET g_input.year = YEAR(g_today)
   LET g_input.strmon = MONTH(g_today)
   LET g_input.endmon = MONTH(g_today)
   LET g_input.curr ='Y'
   LET g_input.b_check ='N'      #01727
   CALL aapq931_get_type()       #150215 
   CALL cl_set_comp_visible('b_xrea103,b_xrea100,xrea100,xrea1031,xrea1032,xrea1033,xrea1034',TRUE)
   CALL cl_set_comp_visible('group1,group2,group3,xrea011,xrea016,pmab053',FALSE) #先全部關閉
   CALL cl_set_comp_visible('group1_desc,group2_desc,group3_desc,xrea011_desc,xrea016_desc,pmab053_desc',FALSE) #先全部關閉
   CALL cl_set_comp_visible('group1,group1_desc',TRUE) #預設為以會計科目匯總，打開第一個欄位  #150215 add group1_desc
   
   CALL aapq931_dis() #01727
   
   DISPLAY BY NAME g_input.xreasite_desc,g_input.xrad001_desc,
                   g_input.group,g_input.dedtype,   
                   g_input.apca0010,g_input.apca0012,g_input.xrad004 
END FUNCTION

################################################################################
# Descriptions...: 取得帳齡類型名稱
# Memo...........:
# Usage..........: CALL aapq931_xrad001_ref()
# Date & Author..: 2014/01/27 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq931_xrad001_ref()
 #帳齡類型
     SELECT xradl003 INTO g_input.xrad001_desc
       FROM xradl_t
      WHERE xradlent = g_enterprise
        AND xradl001 = g_input.xrad001
        AND xradl002 = g_dlang
    
    DISPLAY BY NAME g_input.xrad001_desc
END FUNCTION

################################################################################
# Descriptions...: 壞帳提列比率
# Memo...........:
# Usage..........: CALL aapq931_debt_ref()
# Date & Author..: 2015/01/28 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq931_debt_ref()
   DEFINE l_xrae003 LIKE xrae_t.xrae003
   DEFINE l_xrae004 LIKE xrae_t.xrae004
   DEFINE l_xrae005 LIKE xrae_t.xrae005

   LET g_sql = " SELECT xrae003,xrae004,xrae005     ",
                "   FROM xrae_t                     ",
                "  WHERE xraeent = ",g_enterprise," ",
                "    AND xrae001 = '",g_input.xrad001,"' "
   PREPARE aapq931_pre_1  FROM g_sql
   DECLARE aapq931_curs CURSOR FOR aapq931_pre_1 
   
   FOREACH aapq931_curs INTO l_xrae003,l_xrae004,l_xrae005
      IF g_xrea_d[l_ac].day2 >= l_xrae003 AND g_xrea_d[l_ac].day2 <= l_xrae004 THEN
         LET g_xrea_d[l_ac].l_debt = l_xrae005         
      END IF
      #帳齡天數大於起始天數，不再範圍者
      IF g_xrea_d[l_ac].day2 > l_xrae004 THEN
         LET g_xrea_d[l_ac].l_debt = l_xrae005
      END IF
      #帳齡天數小於起始天數，不再範圍者
      IF g_xrea_d[l_ac].day2  < l_xrae003 THEN 
         LET g_xrea_d[l_ac].l_debt = l_xrae005 
      END IF
   END FOREACH

END FUNCTION

################################################################################
# Descriptions...: 填充第二單身
# Memo...........:
# Usage..........: CALL aapq931_b_fill2()
# Date & Author..: 2015/01/28 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq931_b_fill2()
   DEFINE ls_wc2           STRING
   DEFINE l_glaa003       LIKE glaa_t.glaa003 #主帳套之會計週期參照表
   DEFINE l_xrea009       LIKE type_t.chr100  #交易對象
   DEFINE l_xrea019       LIKE type_t.chr100  #應收付科目
   DEFINE l_xreaald       LIKE type_t.chr100
   DEFINE l_xrea100       LIKE type_t.chr100
   DEFINE l_preyear       LIKE xrea_t.xrea001 #上期年
   DEFINE l_premon        LIKE xrea_t.xrea002 #上期月
   DEFINE l_group1        LIKE type_t.chr100
   DEFINE l_group2        LIKE type_t.chr100
   DEFINE l_group3        LIKE type_t.chr100  
   DEFINE l_xrea011       LIKE type_t.chr100  #部門
   DEFINE l_xrea016       LIKE type_t.chr100  #人員 
   DEFINE l_xrea0112      LIKE xrea_t.xrea011 #部門
   DEFINE l_pmab031       LIKE pmab_t.pmab031 #人員   
   DEFINE l_group         STRING
   DEFINE l_count      LIKE type_t.num5 
   DEFINE l_str           LIKE type_t.chr100
   DEFINE l_str2          LIKE type_t.chr100
   DEFINE l_pmabsite      LIKE pmab_t.pmabsite   #20150308 add
   DEFINE l_pmab109       LIKE pmab_t.pmab109    #20150308 add
   DEFINE l_xrea     DYNAMIC ARRAY OF RECORD
          xrea113      LIKE xrea_t.xrea113,  #各區間的本幣
          xrea113_debt LIKE xrea_t.xrea113   #各區間本幣壞帳
          END RECORD 
   #扣除方式使用Array   
   DEFINE l_sum DYNAMIC ARRAY OF RECORD
        type          LIKE type_t.chr500,      #條件 
        xrea005       LIKE xrea_t.xrea005,     #正項條件
        xrea006       LIKE xrea_t.xrea006,
        xrea007       LIKE xrea_t.xrea007,
        xrea0052      LIKE xrea_t.xrea005,     #負項條件
        xrea0062      LIKE xrea_t.xrea006,
        xrea0072      LIKE xrea_t.xrea007,
        xrea103       LIKE xrea_t.xrea103,      #原幣未沖金額
        xrea113       LIKE xrea_t.xrea113,      #本幣未沖金額
        xrea1032      LIKE xrea_t.xrea103,      #原幣未沖金額
        xrea1132      LIKE xrea_t.xrea113,      #本幣未沖金額
        xrea100       LIKE xrea_t.xrea100      #幣別 
   END RECORD        
      
   CALL g_xrea2_d.clear()
   CALL aapq931_title_change()
   CASE    
     WHEN g_input.group = 1
        LET l_str    = 'xrea019' #應收付科目
        LET l_group1 = "''"
        LET l_group2 = "''"
        LET l_group3 =  "''"
        LET l_xrea011 = "''"
        LET l_xrea016 = "''"
        LET l_group = " GROUP BY xrea019 "
     WHEN g_input.group = 2
       LET l_str  = "xrea009"#交易對象
       LET l_group1 = "''"
       LET l_group2 = "''"
       LET l_group3 =  "''"
       LET l_xrea011 = "''"
       LET l_xrea016 = "''"
       LET l_group = " GROUP BY xrea009 "
     WHEN g_input.group = 3
        LET l_str = 'xrea011' #部門
        LET l_group1 = "''"
        LET l_group2 = "''"
        LET l_group3 =  "''"
        LET l_xrea011 = "''"
        LET l_xrea016 = "''"
        LET l_group = " GROUP BY xrea011 "
     WHEN g_input.group = 4 #業務人員
        LET l_str = 'xrea016'
        LET l_group1 = "''"
        LET l_group2 = "''"
        LET l_group3 =  "''"
        LET l_xrea011 = "''"
        LET l_xrea016 = "''"
        LET l_group = " GROUP BY xrea016 "
     WHEN g_input.group = 5 #交易對象+科目
        LET l_str = " xrea009||'@'||xrea019 "
        LET l_group1 = 'xrea009'
        LET l_group2 = 'xrea019'
        LET l_group3 =   "''"
        LET l_xrea011 = "''"
        LET l_xrea016 = "''"
        LET l_group = " GROUP BY xrea009||'@'||xrea019,xrea009,xrea019 "
     WHEN g_input.group = 6
        LET l_str = " xreald||'@'||xrea009 "
        LET l_group1  = 'xreald'
        LET l_group2 = 'xrea009'
        LET l_group3 = "''"
        LET l_xrea011 = "''"
        LET l_xrea016 = "''"
        LET l_group = " GROUP BY xreald||'@'||xrea009,xreald,xrea009 "
     WHEN g_input.group = 7
        LET l_str = " xreald||'@'||xrea009||'@'||xrea019 "
        LET l_group1  = 'xreald'
        LET l_group2  = 'xrea009'
        LET l_group3  = 'xrea019'
        LET l_xrea011 = "''"
        LET l_xrea016 = "''"
        LET l_group = " GROUP BY xreald||'@'||xrea009||'@'||xrea019,xreald,xrea009,xrea019 "
   END CASE
   
   IF g_input.curr = 'Y' THEN
      LET l_xrea100 = 'xrea100'
      LET l_group = l_group,',xrea100 ' 
   ELSE
      LET l_xrea100 = "''"
   END IF  
   
   IF g_input.dedtype = '2' OR g_input.dedtype = '3' OR g_input.dedtype = '5' THEN  
      LET l_ac = 1
      #找出類型 匯總
      LET g_sql =  "  SELECT DISTINCT ",l_str,"  ",
                   "    FROM  aapq931_tmp       "                   
      PREPARE aapq931_pb_prep8 FROM g_sql
      DECLARE aapq931_pb_curs8 CURSOR FOR aapq931_pb_prep8
      
      FOREACH aapq931_pb_curs8 INTO l_sum[l_ac].type
         #把全部1類的資料都抓進來(正)
         LET g_sql =  "   SELECT  xrea103,xrea113,                   ",
                      "           xrea005,xrea006,xrea007,xrea100    ",
                      "     FROM aapq931_tmp                         ",
                      "    WHERE xrea004 LIKE '1%'                   ",
                      "      AND xrea002 ='",g_xrea002,"'            ",                 #150313 
                      "      AND ",l_str," = '",l_sum[l_ac].type,"'  "
         LET g_sql = g_sql, "AND ", g_b2_wc
         CASE
            WHEN g_input.dedtype = '2'   #先進先出
              #LET g_sql  = g_sql, "   ORDER BY xrea008           "
              LET g_sql  = g_sql, "   ORDER BY day2 DESC         " #150316 帳齡天數大的正項 去扣除帳齡天數大的負項
            WHEN g_input.dedtype = '3'   #先進後出
              #LET g_sql  = g_sql, "   ORDER BY xrea008 DESC      "
              LET g_sql  = g_sql, "   ORDER BY day2               "
            WHEN g_input.dedtype = '5'   #先進先出 
              #LET g_sql  = g_sql, "   ORDER BY xrea008            "   
              LET g_sql  = g_sql, "   ORDER BY day2 DESC         " #150316 帳齡天數大的正項 去扣除帳齡天數大的負項              
         END CASE
         PREPARE aapq931_pb_prep6 FROM g_sql
         DECLARE aapq931_pb_curs6 CURSOR FOR aapq931_pb_prep6
          
         FOREACH aapq931_pb_curs6 INTO l_sum[l_ac].xrea103   , l_sum[l_ac].xrea113,
                                       l_sum[l_ac].xrea005 , l_sum[l_ac].xrea006, l_sum[l_ac].xrea007,
                                       l_sum[l_ac].xrea100
            #找出二類交易對象的金額 /相同匯總條件相同幣別                                                      
            LET g_sql = "   SELECT xrea103,xrea113,                    ",
                        "          xrea005,xrea006,xrea007             ",
                        "     FROM aapq931_tmp                         ",
                        "    WHERE xrea004 LIKE '2%'                   ",
                        "      AND xrea100 = '",l_sum[l_ac].xrea100,"' ",
                        "      AND xrea002 ='",g_xrea002,"'            ",                 #150313 
                        "      AND ",l_str," = '",l_sum[l_ac].type,"'  "
            LET g_sql = g_sql,"AND ", g_b2_wc
            CASE 
              WHEN g_input.dedtype = '2'  
                #LET g_sql  = g_sql, "   ORDER BY xrea008            "
                 LET g_sql  = g_sql, "   ORDER BY day2 DESC          " #150316 帳齡天數大的正項 去扣除帳齡天數大的負項
              WHEN g_input.dedtype = '3' 
                 #LET g_sql  = g_sql, "   ORDER BY xrea008 DESC       " 
                 LET g_sql  = g_sql, "   ORDER BY day2                " 
              WHEN g_input.dedtype = '5' #per 期間flag
                 #LET g_sql  = g_sql, "   ORDER BY per DESC,xrea008      "                 
                 LET g_sql  = g_sql, "   ORDER BY per DESC,day2 DESC     " 
            END CASE                                          
            PREPARE aapq931_pb_prep7 FROM g_sql
            DECLARE aapq931_pb_curs7 CURSOR FOR aapq931_pb_prep7

            FOREACH aapq931_pb_curs7 INTO  l_sum[l_ac].xrea1032, l_sum[l_ac].xrea1132,
                                           l_sum[l_ac].xrea0052, l_sum[l_ac].xrea0062,   l_sum[l_ac].xrea0072                                                       
               #判斷少的扣除
#               IF s_math_abs(l_sum[l_ac].xrea1032) > s_math_abs(l_sum[l_ac].xrea103) THEN
#                  LET l_sum[l_ac].xrea1032  = l_sum[l_ac].xrea1032  + l_sum[l_ac].xrea103 #二類+一類
#                  LET l_sum[l_ac].xrea103   = l_sum[l_ac].xrea103   - l_sum[l_ac].xrea103 #一類歸零
#               ELSE
#                  LET l_sum[l_ac].xrea103   = l_sum[l_ac].xrea103   + l_sum[l_ac].xrea1032  #一類-二類 
#                  LET l_sum[l_ac].xrea1032  = l_sum[l_ac].xrea1032  - l_sum[l_ac].xrea1032  #二類歸零         
#               END IF     
               
               IF s_math_abs(l_sum[l_ac].xrea1132) > s_math_abs(l_sum[l_ac].xrea113) THEN
                  LET l_sum[l_ac].xrea1132  = l_sum[l_ac].xrea1132  + l_sum[l_ac].xrea113 #二類+一類
                  LET l_sum[l_ac].xrea113   = l_sum[l_ac].xrea113   - l_sum[l_ac].xrea113 #一類歸零
               ELSE
                  LET l_sum[l_ac].xrea113   = l_sum[l_ac].xrea113   + l_sum[l_ac].xrea1132  #一類-二類 
                  LET l_sum[l_ac].xrea1132  = l_sum[l_ac].xrea1132  - l_sum[l_ac].xrea1132  #二類歸零         
               END IF               
                  
               #更新資料
               UPDATE aapq931_tmp
                 #SET xrea103   = l_sum[l_ac].xrea103
                  SET xrea113   = l_sum[l_ac].xrea113
                WHERE xrea005   = l_sum[l_ac].xrea005
                  AND xrea006   = l_sum[l_ac].xrea006
                  AND xrea007   = l_sum[l_ac].xrea007                    
                  AND xrea100   = l_sum[l_ac].xrea100
                  AND xrea002   = g_xrea002                 #150313
                  
               UPDATE aapq931_tmp
                 #SET xrea103   = l_sum[l_ac].xrea1032
                  SET xrea113   = l_sum[l_ac].xrea1132
                WHERE xrea005   = l_sum[l_ac].xrea0052 
                  AND xrea006   = l_sum[l_ac].xrea0062
                  AND xrea007   = l_sum[l_ac].xrea0072   
                  AND xrea100   = l_sum[l_ac].xrea100 
                  AND xrea002   = g_xrea002                 #150313

               #正的攤完就跑下一筆正的
               IF l_sum[l_ac].xrea113 = 0 THEN
                  EXIT FOREACH
               END IF
                                                                           
            END FOREACH     
         END FOREACH
         LET l_ac = l_ac+ 1
      END FOREACH
   END IF  
    
   LET l_ac = 1
   #150215--(S)--應該抓全部得出來
   LET g_sql = "   SELECT ",l_str," ,                                  ",
               "          ",l_group1," , ",l_group2," , ",l_group3," , ",
               "          ",l_xrea011,", ",l_xrea016,",                ",
               "          ",l_xrea100,
              #"           SUM(xrea103),SUM(xrea113),                  ",  #原幣未沖，本幣別未沖 #150215 Belle Mark
              #"           SUM(xrea103_debt),SUM(xrea113_debt)         ",  #原幣壞帳，本幣別壞帳 #150215 Belle Mark              
               "     FROM aapq931_tmp                                  ",
               "    WHERE 1=1 AND " ,g_b2_wc#,
              #"      AND xrea002 =  '",g_xrea002,"'                   "   #150215 Belle Mark     
  #IF g_input.dedtype = '1' THEN  #不扣除　二類不算                          #150215 Belle Mark    
   IF g_input.apca0012 = 'N' OR g_input.dedtype = '1' THEN  #不扣除　二類不算  
      LET g_sql = g_sql, " AND  xrea004 NOT LIKE '2%' "
   END IF   
   LET g_sql = g_sql,l_group," ORDER BY ",l_str,"  "
                                                              
   PREPARE aapq931_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR aapq931_pb3     

   FOREACH b_fill_curs3 INTO l_str2,
                             g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3,
                             g_xrea2_d[l_ac].xrea011,g_xrea2_d[l_ac].xrea016,
                             g_xrea2_d[l_ac].xrea100#,
                            #g_xrea2_d[l_ac].xrea1034,g_xrea2_d[l_ac].xrea1134,     #150215 Belle Mark 
                            #g_xrea2_d[l_ac].xrea1035,g_xrea2_d[l_ac].xrea1135      #150215 Belle Mark 
      #本期增加金額         
      LET g_sql =  " SELECT SUM(xrea103+apcc108),SUM(xrea113+apcc118)            ",                                                                             
                   "   FROM aapq931_tmp                                          ",
                   "   WHERE xrea008 BETWEEN '",g_strdate,"' AND '",g_enddate,"' ",                    
                   "     AND ",l_str," = '",l_str2,"'                            ",
                   "     AND ",g_b2_wc
          IF g_input.curr = 'Y' THEN          
             LET g_sql = g_sql CLIPPED , "  AND xrea100 =  '",g_xrea2_d[l_ac].xrea100,"'  "
          END IF
         #IF g_input.dedtype = '1' THEN                        #150215 Belle Mark 
          IF g_input.apca0012 = 'N' OR g_input.dedtype = '1' THEN  #不扣除　二類不算      #150215 Belle Mark         
             LET g_sql = g_sql, " AND  xrea004 NOT LIKE '2%' "
          END IF   
          LET g_sql = g_sql,l_group," ORDER BY ",l_str,"  "
      PREPARE aapq931_sum_ori_loc FROM g_sql
      EXECUTE aapq931_sum_ori_loc INTO g_xrea2_d[l_ac].xrea1032,g_xrea2_d[l_ac].xrea1132    
      IF cl_null(g_xrea2_d[l_ac].xrea1032) THEN LET g_xrea2_d[l_ac].xrea1032 = 0 END IF        
      IF cl_null(g_xrea2_d[l_ac].xrea1132) THEN LET g_xrea2_d[l_ac].xrea1132 = 0 END IF 
      
      #Belle 150215
      LET g_sql = "   SELECT ",#l_str," ,                                  ",
                  "           SUM(xrea103),SUM(xrea113),                  ", #原幣未沖，本幣別未沖 ,
                  "           SUM(xrea103_debt),SUM(xrea113_debt)         ", #原幣壞帳，本幣別壞帳               
                  "     FROM aapq931_tmp                                  ",
                  "    WHERE 1=1 AND " ,g_b2_wc  ,
                  "      AND xrea002 =  '",g_xrea002,"'                   "    
               ,  "     AND ",l_str," = '",l_str2,"'                            ",
                      "     AND ",g_b2_wc
     #IF g_input.dedtype = '1' THEN  #不扣除　二類不算     #150215 Belle Mark    
      IF g_input.apca0012 = 'N' OR g_input.dedtype = '1' THEN  #不扣除　二類不算    #150215 Belle Mark    
         LET g_sql = g_sql, " AND  xrea004 NOT LIKE '2%' "
      END IF
         IF g_input.curr = 'Y' THEN          
            LET g_sql = g_sql CLIPPED , "  AND xrea100 =  '",g_xrea2_d[l_ac].xrea100,"'  "
         END IF            
      LET g_sql = g_sql,l_group," ORDER BY ",l_str,"  "
      PREPARE aapq931_sum_ori_lo1 FROM g_sql
      EXECUTE aapq931_sum_ori_lo1 INTO g_xrea2_d[l_ac].xrea1034,g_xrea2_d[l_ac].xrea1134,
                                       g_xrea2_d[l_ac].xrea1035,g_xrea2_d[l_ac].xrea1135   
      IF cl_null(g_xrea2_d[l_ac].xrea1034) THEN LET g_xrea2_d[l_ac].xrea1034 = 0 END IF        
      IF cl_null(g_xrea2_d[l_ac].xrea1134) THEN LET g_xrea2_d[l_ac].xrea1134 = 0 END IF 
      IF cl_null(g_xrea2_d[l_ac].xrea1035) THEN LET g_xrea2_d[l_ac].xrea1035 = 0 END IF        
      IF cl_null(g_xrea2_d[l_ac].xrea1135) THEN LET g_xrea2_d[l_ac].xrea1135 = 0 END IF 
      #Belle 150215
      #取得會計週期參照表
      CALL s_ld_sel_glaa(g_xreald,'glaa003') RETURNING g_sub_success,l_glaa003
      #期初金額/月結檔上一期的金額匯總
      CALL s_fin_date_get_last_period(l_glaa003,g_xreald,g_input.year,g_xrea002)
                     RETURNING g_sub_success,l_preyear,l_premon    
      LET g_sql =  "   SELECT SUM(xrea103),SUM(xrea113)                                ",                                                                             
                   "     FROM aapq931_tmp                                              ",
                   "    WHERE 1=1 AND " ,g_b2_wc,
                   "      AND ",l_str," = '",l_str2,"'                                 ",
                   "      AND xrea001 =  '",l_preyear,"' AND xrea002 = '",l_premon,"'  "
      IF g_input.curr = 'Y' THEN          
         LET g_sql = g_sql CLIPPED , "  AND xrea100 =  '",g_xrea2_d[l_ac].xrea100,"'  "
      END IF            
      #IF g_input.dedtype = '1' THEN                     #150215 Belle Mark    
      IF g_input.apca0012 = 'N' OR g_input.dedtype = '1' THEN  #不扣除　二類不算    #150215 Belle Mark    
         LET g_sql = g_sql, " AND  xrea004 NOT LIKE '2%' "
   　 END IF   
      LET g_sql = g_sql,l_group
      
      PREPARE aapq931_pb4 FROM g_sql
      EXECUTE aapq931_pb4 INTO g_xrea2_d[l_ac].xrea1031,g_xrea2_d[l_ac].xrea1131
      
      IF cl_null(g_xrea2_d[l_ac].xrea1031) THEN LET g_xrea2_d[l_ac].xrea1031 = 0 END IF
      IF cl_null(g_xrea2_d[l_ac].xrea1131) THEN LET g_xrea2_d[l_ac].xrea1131 = 0 END IF
      #本期減少金額 = 期初 + 本期新增金额 - 期末
      LET g_xrea2_d[l_ac].xrea1033 = g_xrea2_d[l_ac].xrea1031 + g_xrea2_d[l_ac].xrea1032 - g_xrea2_d[l_ac].xrea1034
      LET g_xrea2_d[l_ac].xrea1133 = g_xrea2_d[l_ac].xrea1131 + g_xrea2_d[l_ac].xrea1132 - g_xrea2_d[l_ac].xrea1134
      CALL l_xrea.clear()
      FOR l_count = 1 TO 20
         #本幣各個金額所在的區間
         LET g_sql =  "   SELECT SUM(xrea113),SUM(xrea113_debt)                                   ",                      
                      "     FROM aapq931_tmp                                                      ",        
                      "    WHERE day2 BETWEEN ",g_xrae[l_count].str," AND ",g_xrae[l_count].end,"  ",
                      "      AND ",l_str," = '",l_str2,"'                                         ", 
                      "      AND xrea002 ='",g_xrea002,"'                                         ",                      
                      "      AND " , g_b2_wc
          IF g_input.curr = 'Y' THEN          
             LET g_sql = g_sql CLIPPED , "  AND xrea100 =  '",g_xrea2_d[l_ac].xrea100,"'  "
          END IF            
          IF g_input.apca0012 = 'N' OR g_input.dedtype = '1' THEN 
             LET g_sql = g_sql, " AND  xrea004 NOT LIKE '2%' "
          END IF   
          LET g_sql = g_sql,l_group
                   
          PREPARE aapq931_pb3_prep5 FROM g_sql           
          EXECUTE aapq931_pb3_prep5 INTO l_xrea[l_count].xrea113,l_xrea[l_count].xrea113_debt
          IF cl_null(l_xrea[l_count].xrea113) THEN LET l_xrea[l_count].xrea113 = 0 END IF
          IF cl_null(l_xrea[l_count].xrea113_debt) THEN LET l_xrea[l_count].xrea113_debt = 0 END IF
          
          IF l_count > 1 THEN
             IF l_xrea[l_count].xrea113 < 0 THEN
                LET l_xrea[1].xrea113 = l_xrea[1].xrea113 + l_xrea[l_count].xrea113           
                LET l_xrea[l_count].xrea113 = 0
             END IF
             IF l_xrea[l_count].xrea113_debt < 0 THEN
                LET l_xrea[1].xrea113_debt = l_xrea[1].xrea113_debt + l_xrea[l_count].xrea113_debt             
                LET l_xrea[l_count].xrea113_debt = 0
             END IF  
          END IF             
      END FOR
      
      #不在範圍內的天數#固定塞到第21格
      LET g_sql =  "   SELECT SUM(xrea113),SUM(xrea113_debt)            ",                      
                   "     FROM aapq931_tmp                               ",        
                   "    WHERE day2 >  ",g_end_day,"                     ",
                   "      AND ",l_str," = '",l_str2,"'                  ", 
                   "      AND xrea002 ='",g_xrea002,"'                  ",                      
                   "      AND " , g_b2_wc
      IF g_input.curr = 'Y' THEN          
         LET g_sql = g_sql CLIPPED , "  AND xrea100 =  '",g_xrea2_d[l_ac].xrea100,"'  "
      END IF            
      #IF g_input.dedtype = '1' THEN                     #150215 Belle Mark    
      IF g_input.apca0012 = 'N' THEN  #不扣除　二類不算    #150215 Belle Mark 
         LET g_sql = g_sql, " AND  xrea004 NOT LIKE '2%' "
      END IF   
      LET g_sql = g_sql,l_group     
      PREPARE aapq931_pb3_prep6 FROM g_sql           
      EXECUTE aapq931_pb3_prep6 INTO l_xrea[21].xrea113,l_xrea[21].xrea113_debt
      IF cl_null( l_xrea[21].xrea113)THEN LET  l_xrea[21].xrea113 = 0 END IF  
      IF cl_null( l_xrea[21].xrea113_debt)THEN LET  l_xrea[21].xrea113_debt = 0 END IF
      IF l_xrea[21].xrea113 < 0 THEN
             LET l_xrea[1].xrea113 = l_xrea[1].xrea113 + l_xrea[21].xrea113             
             LET l_xrea[21].xrea113 = 0          
      END IF
      IF l_xrea[21].xrea113_debt < 0 THEN
         LET l_xrea[1].xrea113_debt = l_xrea[1].xrea113_debt + l_xrea[21].xrea113_debt
         LET l_xrea[21].xrea113_debt = 0
      END IF              
      LET g_xrea2_d[l_ac].xrea103_01 = l_xrea[1].xrea113       
      LET g_xrea2_d[l_ac].xrea103_02 = l_xrea[2].xrea113  
      LET g_xrea2_d[l_ac].xrea103_03 = l_xrea[3].xrea113  
      LET g_xrea2_d[l_ac].xrea103_04 = l_xrea[4].xrea113  
      LET g_xrea2_d[l_ac].xrea103_05 = l_xrea[5].xrea113  
      LET g_xrea2_d[l_ac].xrea103_06 = l_xrea[6].xrea113  
      LET g_xrea2_d[l_ac].xrea103_07 = l_xrea[7].xrea113  
      LET g_xrea2_d[l_ac].xrea103_08 = l_xrea[8].xrea113  
      LET g_xrea2_d[l_ac].xrea103_09 = l_xrea[9].xrea113  
      LET g_xrea2_d[l_ac].xrea103_10 = l_xrea[10].xrea113
      LET g_xrea2_d[l_ac].xrea103_11 = l_xrea[11].xrea113 
      LET g_xrea2_d[l_ac].xrea103_12 = l_xrea[12].xrea113 
      LET g_xrea2_d[l_ac].xrea103_13 = l_xrea[13].xrea113 
      LET g_xrea2_d[l_ac].xrea103_14 = l_xrea[14].xrea113 
      LET g_xrea2_d[l_ac].xrea103_15 = l_xrea[15].xrea113 
      LET g_xrea2_d[l_ac].xrea103_16 = l_xrea[16].xrea113 
      LET g_xrea2_d[l_ac].xrea103_17 = l_xrea[17].xrea113 
      LET g_xrea2_d[l_ac].xrea103_18 = l_xrea[18].xrea113 
      LET g_xrea2_d[l_ac].xrea103_19 = l_xrea[19].xrea113 
      LET g_xrea2_d[l_ac].xrea103_20 = l_xrea[20].xrea113 
      LET g_xrea2_d[l_ac].xrea103_21 = l_xrea[21].xrea113
      LET g_xrea2_d[l_ac].xrea113_01 = l_xrea[1].xrea113_debt       
      LET g_xrea2_d[l_ac].xrea113_02 = l_xrea[2].xrea113_debt 
      LET g_xrea2_d[l_ac].xrea113_03 = l_xrea[3].xrea113_debt 
      LET g_xrea2_d[l_ac].xrea113_04 = l_xrea[4].xrea113_debt 
      LET g_xrea2_d[l_ac].xrea113_05 = l_xrea[5].xrea113_debt 
      LET g_xrea2_d[l_ac].xrea113_06 = l_xrea[6].xrea113_debt 
      LET g_xrea2_d[l_ac].xrea113_07 = l_xrea[7].xrea113_debt 
      LET g_xrea2_d[l_ac].xrea113_08 = l_xrea[8].xrea113_debt 
      LET g_xrea2_d[l_ac].xrea113_09 = l_xrea[9].xrea113_debt 
      LET g_xrea2_d[l_ac].xrea113_10 = l_xrea[10].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_11 = l_xrea[11].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_12 = l_xrea[12].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_13 = l_xrea[13].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_14 = l_xrea[14].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_15 = l_xrea[15].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_16 = l_xrea[16].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_17 = l_xrea[17].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_18 = l_xrea[18].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_19 = l_xrea[19].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_20 = l_xrea[20].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_21 = l_xrea[21].xrea113_debt 
      
      #CALL cl_set_comp_visible('group1,group2,group3',FALSE)
      LET l_pmab031 =''      
      CASE        
         WHEN g_input.group = '1' #會計科目         
            LET g_xrea2_d[l_ac].group1 = l_str2
            LET g_xrea2_d[l_ac].group1_desc = s_desc_get_account_desc(g_xreald,l_str2)
         WHEN g_input.group = '2' # 交易對象 + 部門 + 人員
            IF g_prog = 'aapq931' THEN
               LET g_xrea2_d[l_ac].group1 = l_str2
               SELECT pmab031,pmab037 #人員 交易條件
                 INTO l_pmab031,g_xrea2_d[l_ac].pmab053
                 FROM pmab_t
                WHERE pmabent = g_enterprise
                  AND pmabsite = g_input.xreasite
                  AND pmab001 = g_xrea2_d[l_ac].group1 #交易對象
            ELSE
               LET g_xrea2_d[l_ac].group1 = l_str2
               SELECT pmab081,pmab087 #人員 交易條件
                 INTO l_pmab031,g_xrea2_d[l_ac].pmab053
                 FROM pmab_t
                WHERE pmabent = g_enterprise
                  AND pmabsite = g_input.xreasite
                  AND pmab001 = g_xrea2_d[l_ac].group1 #交易對象                  
            END IF
            LET g_xrea2_d[l_ac].xrea016 = l_pmab031
            CALL s_employee_get_dept(l_pmab031)RETURNING g_sub_success,g_errno,g_xrea2_d[l_ac].xrea011,g_xrea2_d[l_ac].xrea011_desc
            LET g_xrea2_d[l_ac].group1_desc = s_desc_get_trading_partner_abbr_desc(g_xrea2_d[l_ac].group1)
            LET g_xrea2_d[l_ac].xrea011_desc = s_desc_get_department_desc(g_xrea2_d[l_ac].xrea011)
            LET g_xrea2_d[l_ac].xrea016_desc = s_desc_get_person_desc(g_xrea2_d[l_ac].xrea016)
            CALL s_desc_get_ooib002_desc(g_xrea2_d[l_ac].pmab053) RETURNING g_xrea2_d[l_ac].pmab053_desc           
         WHEN g_input.group = '3' # 交易部門 
            LET g_xrea2_d[l_ac].group1 = l_str2
            LET g_xrea2_d[l_ac].group1_desc = s_desc_get_department_desc(l_str2)
         WHEN g_input.group = '4' # 業務人員
            LET g_xrea2_d[l_ac].group1 = l_str2
            LET g_xrea2_d[l_ac].group1_desc = s_desc_get_person_desc(l_str2)
         WHEN g_input.group = '5' #交易對象+科目   + 部門 + 人員                    
            IF g_prog = 'aapq931' THEN
               SELECT pmab031,pmab037 #人員 交易條件
                 INTO l_pmab031,g_xrea2_d[l_ac].pmab053
                 FROM pmab_t
                WHERE pmabent = g_enterprise
                  AND pmabsite = g_input.xreasite
                  AND pmab001 = g_xrea2_d[l_ac].group1 #交易對象
            ELSE
               SELECT pmab081,pmab087 #人員 交易條件
                 INTO l_pmab031,g_xrea2_d[l_ac].pmab053
                 FROM pmab_t
                WHERE pmabent = g_enterprise
                  AND pmabsite = g_input.xreasite
                  AND pmab001 = g_xrea2_d[l_ac].group1 #交易對象                  
            END IF         
            LET g_xrea2_d[l_ac].xrea016 = l_pmab031
            CALL s_employee_get_dept(l_pmab031)RETURNING g_sub_success,g_errno,g_xrea2_d[l_ac].xrea011,g_xrea2_d[l_ac].xrea011_desc
            LET g_xrea2_d[l_ac].group1_desc = s_desc_get_trading_partner_abbr_desc(g_xrea2_d[l_ac].group1)
            LET g_xrea2_d[l_ac].group2_desc = s_desc_get_account_desc(g_xreald,g_xrea2_d[l_ac].group2)
            LET g_xrea2_d[l_ac].xrea011_desc = s_desc_get_department_desc(g_xrea2_d[l_ac].xrea011)
            LET g_xrea2_d[l_ac].xrea016_desc = s_desc_get_person_desc(g_xrea2_d[l_ac].xrea016)
            CALL s_desc_get_ooib002_desc(g_xrea2_d[l_ac].pmab053) RETURNING g_xrea2_d[l_ac].pmab053_desc
         WHEN g_input.group = '6' #帳套+交易對象   + 部門 + 人員 
               IF g_prog = 'aapq931' THEN
               SELECT pmab031,pmab037 #人員 交易條件
                 INTO l_pmab031,g_xrea2_d[l_ac].pmab053
                 FROM pmab_t
                WHERE pmabent = g_enterprise
                  AND pmabsite = g_input.xreasite
                  AND pmab001 = g_xrea2_d[l_ac].group2 #交易對象
            ELSE
               SELECT pmab081,pmab087 #人員 交易條件
                 INTO l_pmab031,g_xrea2_d[l_ac].pmab053
                 FROM pmab_t
                WHERE pmabent = g_enterprise
                  AND pmabsite = g_input.xreasite
                  AND pmab001 = g_xrea2_d[l_ac].group2 #交易對象                   
            END IF       
            LET g_xrea2_d[l_ac].xrea016 = l_pmab031
            #20150308--add--str--
            SELECT pmab109 INTO g_xrea2_d[l_ac].xrea011
              FROM pmab_t
             WHERE pmabent = g_enterprise
               AND pmabsite = g_input.xreasite
               AND pmab001 = g_xrea2_d[l_ac].group2
            #20150308--add--end--
            #CALL s_employee_get_dept(l_pmab031)RETURNING g_sub_success,g_errno,g_xrea2_d[l_ac].xrea011,g_xrea2_d[l_ac].xrea011_desc #20150308 mark
            LET g_xrea2_d[l_ac].group1_desc = s_desc_get_ld_desc(g_xrea2_d[l_ac].group1)
            LET g_xrea2_d[l_ac].group2_desc = s_desc_get_trading_partner_abbr_desc(g_xrea2_d[l_ac].group2)
            LET g_xrea2_d[l_ac].xrea011_desc = s_desc_get_department_desc(g_xrea2_d[l_ac].xrea011)
            LET g_xrea2_d[l_ac].xrea016_desc = s_desc_get_person_desc(g_xrea2_d[l_ac].xrea016)
            CALL s_desc_get_ooib002_desc(g_xrea2_d[l_ac].pmab053) RETURNING g_xrea2_d[l_ac].pmab053_desc
          WHEN g_input.group = '7' #帳套+交易對象+科目  + 部門 + 人員
                           IF g_prog = 'aapq931' THEN
               SELECT pmab031,pmab037 #人員 交易條件
                 INTO l_pmab031,g_xrea2_d[l_ac].pmab053
                 FROM pmab_t
                WHERE pmabent = g_enterprise
                  AND pmabsite = g_input.xreasite
                  AND pmab001 = g_xrea2_d[l_ac].group2 #交易對象
            ELSE
               SELECT pmab081,pmab087 #人員 交易條件
                 INTO l_pmab031,g_xrea2_d[l_ac].pmab053
                 FROM pmab_t
                WHERE pmabent = g_enterprise
                  AND pmabsite = g_input.xreasite
                  AND pmab001 = g_xrea2_d[l_ac].group2 #交易對象                    
            END IF  
            LET g_xrea2_d[l_ac].xrea016 = l_pmab031
            CALL s_employee_get_dept(l_pmab031)RETURNING g_sub_success,g_errno,g_xrea2_d[l_ac].xrea011,g_xrea2_d[l_ac].xrea011_desc            
            LET g_xrea2_d[l_ac].group1_desc = s_desc_get_ld_desc(g_xrea2_d[l_ac].group1)
            LET g_xrea2_d[l_ac].group2_desc = s_desc_get_trading_partner_abbr_desc(g_xrea2_d[l_ac].group2)     
            LET g_xrea2_d[l_ac].group3_desc = s_desc_get_account_desc(g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group3) 
            LET g_xrea2_d[l_ac].xrea011_desc = s_desc_get_department_desc(g_xrea2_d[l_ac].xrea011)
            LET g_xrea2_d[l_ac].xrea016_desc = s_desc_get_person_desc(g_xrea2_d[l_ac].xrea016) 
            CALL s_desc_get_ooib002_desc(g_xrea2_d[l_ac].pmab053) RETURNING g_xrea2_d[l_ac].pmab053_desc            
      END CASE
      
      LET l_ac = l_ac + 1       
   END FOREACH    
   CALL g_xrea2_d.deleteElement(g_xrea2_d.getLength())    
   CALL aapq931_get_type()   
END FUNCTION

################################################################################
# Descriptions...: 帳齡天數區間置換
# Memo...........:
# Usage..........: CALL aapq931_title_change()
# Date & Author..: 2015/01/28 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq931_title_change()
   DEFINE l_i          LIKE type_t.num5   
   DEFINE l_title1     LIKE gzzd_t.gzzd005
   DEFINE l_title2     LIKE gzzd_t.gzzd005
   DEFINE l_title DYNAMIC ARRAY OF RECORD
          title1   LIKE type_t.chr500,
          title2   LIKE type_t.chr500
          END RECORD
   CALL l_title.clear()
   IF cl_null(g_input.xrad001) THEN RETURN END IF
   #儲存Table_Name,為了動態隱藏欄位
   FOR l_i = 1 TO 9
      LET l_title[l_i].title1 = 'xrea103_0'||l_i
      LET l_title[l_i].title2 = 'xrea113_0'||l_i      
   END FOR
   FOR l_i = 10 TO 20
      LET l_title[l_i].title1 = 'xrea103_'||l_i
      LET l_title[l_i].title2 = 'xrea113_'||l_i      
   END FOR
   
   #找出日期區間
   LET l_ac = 1 
   LET g_sql = " SELECT xrae003,xrae004                 ",     
               "   FROM xrae_t                          ",
               "  WHERE xraeent = ",g_enterprise,"      ",
               "    AND xrae001 = '",g_input.xrad001,"' "  
   PREPARE aapq931_pb2_prep2 FROM g_sql
   DECLARE aapq931_pb2_curs2 CURSOR FOR  aapq931_pb2_prep2
   FOREACH aapq931_pb2_curs2 INTO g_xrae[l_ac].str,g_xrae[l_ac].end            
      LET l_ac = l_ac + 1      
   END FOREACH   
   CALL g_xrae.deleteElement(g_xrae.getLength())
   #Title 置換  
   FOR l_i = 1 TO 20
      LET l_title1 = ''
      SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'title1' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
      SELECT gzzd005 INTO l_title2 FROM gzzd_t WHERE gzzd003 = 'title2' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'   
      LET l_title1 = g_xrae[l_i].str||'-'||g_xrae[l_i].end,l_title1
      LET l_title2 = g_xrae[l_i].str||'-'||g_xrae[l_i].end,l_title2
      CALL cl_set_comp_att_text(l_title[l_i].title1,l_title1)
      CALL cl_set_comp_att_text(l_title[l_i].title2,l_title2)   
      IF NOT cl_null(g_xrae[l_i].str) THEN
         CALL cl_set_comp_visible(l_title[l_i].title1,TRUE)
         CALL cl_set_comp_visible(l_title[l_i].title2,TRUE)
     ELSE
         CALL cl_set_comp_visible(l_title[l_i].title1,FALSE)
         CALL cl_set_comp_visible(l_title[l_i].title2,FALSE)
      END IF      
     #取得最後天數            
     IF NOT cl_null(g_xrae[l_i].end) THEN
        LET g_end_day = g_xrae[l_i].end
     END IF  
   END FOR
   #最後一欄
   
   SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'title1' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
   SELECT gzzd005 INTO l_title2 FROM gzzd_t WHERE gzzd003 = 'title2' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'   
   LET l_title1 = '>'||g_end_day,l_title1
   LET l_title2 = '>'||g_end_day,l_title2
   CALL cl_set_comp_att_text('xrea103_21',l_title1)
   CALL cl_set_comp_att_text('xrea113_21',l_title2)
   #LET g_endday = l_title1
   CALL aapq931_dis() #01727  
   
END FUNCTION

################################################################################
# Descriptions...: 匯總條件置換
# Memo...........:
# Usage..........: CALL aapq931_get_type()
# Date & Author..: 2014/01/25 By Hans 
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq931_get_type()
DEFINE l_title1       LIKE gzzd_t.gzzd005
DEFINE l_title2       LIKE gzzd_t.gzzd005
DEFINE l_title3       LIKE gzzd_t.gzzd005
DEFINE l_tital1_desc  LIKE gzzd_t.gzzd005
DEFINE l_tital2_desc  LIKE gzzd_t.gzzd005
DEFINE l_tital3_desc  LIKE gzzd_t.gzzd005
   
   LET l_title1 = ''
   LET l_title2 = ''
   LET l_title3 = ''
   LET l_tital1_desc = ''
   LET l_tital2_desc = ''
   LET l_tital3_desc = ''
   
   CASE
      WHEN g_input.group = '1' #應付科目
         SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'group_11' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         SELECT gzzd005 INTO l_tital1_desc  FROM gzzd_t WHERE gzzd003 = 'group_11_desc' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         CALL cl_set_comp_att_text('group1',l_title1)
         CALL cl_set_comp_att_text('group1_desc',l_tital1_desc)
      WHEN g_input.group = '2' #交易對象
         SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'group_21' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         SELECT gzzd005 INTO l_tital1_desc  FROM gzzd_t WHERE gzzd003 = 'group_21_desc' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         CALL cl_set_comp_att_text('group1',l_title1)
         CALL cl_set_comp_att_text('group1_desc',l_tital1_desc)
      WHEN g_input.group = '3' #業務部門
         SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'group_31' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         SELECT gzzd005 INTO l_tital1_desc  FROM gzzd_t WHERE gzzd003 = 'group_31_desc' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         CALL cl_set_comp_att_text('group1',l_title1)
         CALL cl_set_comp_att_text('group1_desc',l_tital1_desc)
      WHEN g_input.group = '4' #業務人員
         SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'group_41' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         SELECT gzzd005 INTO l_tital1_desc  FROM gzzd_t WHERE gzzd003 = 'group_41_desc' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         CALL cl_set_comp_att_text('group1',l_title1)
         CALL cl_set_comp_att_text('group1_desc',l_tital1_desc)
      WHEN g_input.group = '5' #交易對象+科目
         SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'group_21' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         SELECT gzzd005 INTO l_title2 FROM gzzd_t WHERE gzzd003 = 'group_11' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         SELECT gzzd005 INTO l_tital1_desc  FROM gzzd_t WHERE gzzd003 = 'group_21_desc' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         SELECT gzzd005 INTO l_tital2_desc  FROM gzzd_t WHERE gzzd003 = 'group_11_desc' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         CALL cl_set_comp_att_text('group1',l_title1)
         CALL cl_set_comp_att_text('group2',l_title2)
         CALL cl_set_comp_att_text('group1_desc',l_tital1_desc)
         CALL cl_set_comp_att_text('group2_desc',l_tital2_desc)
      WHEN g_input.group = '6' #帳套+交易對象
         SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'group_61' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         SELECT gzzd005 INTO l_title2 FROM gzzd_t WHERE gzzd003 = 'group_21' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         SELECT gzzd005 INTO l_tital1_desc  FROM gzzd_t WHERE gzzd003 = 'group_61_desc' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         SELECT gzzd005 INTO l_tital2_desc  FROM gzzd_t WHERE gzzd003 = 'group_21_desc' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         CALL cl_set_comp_att_text('group1',l_title1)
         CALL cl_set_comp_att_text('group2',l_title2)
         CALL cl_set_comp_att_text('group1_desc',l_tital1_desc)
         CALL cl_set_comp_att_text('group2_desc',l_tital2_desc)
      WHEN g_input.group = '7' #帳套+交易對象+科目
         SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'group_61' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931' 
         SELECT gzzd005 INTO l_title2 FROM gzzd_t WHERE gzzd003 = 'group_21' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         SELECT gzzd005 INTO l_title3 FROM gzzd_t WHERE gzzd003 = 'group_11' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         SELECT gzzd005 INTO l_tital1_desc  FROM gzzd_t WHERE gzzd003 = 'group_61_desc' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         SELECT gzzd005 INTO l_tital2_desc  FROM gzzd_t WHERE gzzd003 = 'group_21_desc' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         SELECT gzzd005 INTO l_tital3_desc  FROM gzzd_t WHERE gzzd003 = 'group_11_desc' AND gzzd002 = g_dlang AND gzzd001 = 'aapq931'
         CALL cl_set_comp_att_text('group1',l_title1)
         CALL cl_set_comp_att_text('group2',l_title2)
         CALL cl_set_comp_att_text('group3',l_title3)
         CALL cl_set_comp_att_text('group1_desc',l_tital1_desc)
         CALL cl_set_comp_att_text('group2_desc',l_tital2_desc)
         CALL cl_set_comp_att_text('group3_desc',l_tital3_desc)
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 是否顯示壞帳
# Memo...........:
# Usage..........: CALL aapq931_dis()
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq931_dis()
DEFINE l_flag      LIKE type_t.chr1

   IF cl_null(g_input.b_check) THEN
      RETURN
   END IF

   IF g_input.b_check = 'Y' THEN
      LET l_flag = TRUE
   ELSE
      LET l_flag = FALSE
   END IF

      CALL cl_set_comp_visible('l_xrea103_debt,l_xrea113_debt,xrea1035,xrea1135',l_flag)
      CALL cl_set_comp_visible('xrea113_01,xrea113_02,xrea113_03,xrea113_04,xrea113_05',l_flag)
      CALL cl_set_comp_visible('xrea113_06,xrea113_07,xrea113_08,xrea113_09,xrea113_10',l_flag)
      CALL cl_set_comp_visible('xrea113_11,xrea113_12,xrea113_13,xrea113_14,xrea113_15',l_flag)
      CALL cl_set_comp_visible('xrea113_16,xrea113_17,xrea113_18,xrea113_19,xrea113_20,xrea113_21',l_flag)
      
END FUNCTION

################################################################################
# Descriptions...: 根據agli172設定扣除方式
# Memo...........:
# Usage..........: CALL aapq931_dedtype_def()
# Date & Author..: 2015/3/17 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq931_dedtype_def()
DEFINE l_comp    LIKE ooef_t.ooef001
DEFINE l_ld      LIKE glaa_t.glaald


   #根據營運據點取得所屬帳套
   CALL s_fin_orga_get_comp_ld(g_input.xreasite)RETURNING g_sub_success,g_errno,l_comp,l_ld
   
   IF g_prog = 'aapq931' THEN
      SELECT glcb008 INTO g_input.dedtype
        FROM glcb_t
       WHERE glcbent = g_enterprise
         AND glcbld  = l_ld
         AND glcb001 = 'AP'
   ELSE
       SELECT glcb008 INTO g_input.dedtype
         FROM glcb_t
        WHERE glcbent = g_enterprise
          AND glcbld  = l_ld
          AND glcb001 = 'AR'
   END IF
   IF cl_null( g_input.dedtype) THEN LET  g_input.dedtype = '2' END IF
   DISPLAY BY NAME g_input.dedtype

END FUNCTION

 
{</section>}
 
