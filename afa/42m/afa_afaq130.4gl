#該程式未解開Section, 採用最新樣板產出!
{<section id="afaq130.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:17(2015-11-17 15:19:23), PR版次:0017(2016-11-30 10:20:04)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000121
#+ Filename...: afaq130
#+ Description: 折舊查詢
#+ Creator....: 02291(2014-08-27 08:57:28)
#+ Modifier...: 06821 -SD/PR- 01531
 
{</section>}
 
{<section id="afaq130.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#150923           15/09/28   By 03538 將資產主類型欄位改為非FORMONLY,以便可在單身下條件
#150908-00002#3   15/10/05   By 06816 加欄位 入帳年月 中文名稱 本年累折 未折減餘額 會計科目
#151105-00001#1   15/11/05   By Jessy 會計科目欄位前,增加一欄【耐用年限】faaj004,輸出到XG一併加入
#160318-00025#7   16/04/20   By 07675 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160505-00007#1   16/05/05   By 02114 查詢效能優化
#160125-00005#7   16/08/09   By 01531 查詢時加上帳套人員權限條件過濾
#160426-00014#6   16/09/02   By 01531 新增依标签部门分摊查询
#161006-00005#22  16/10/24   By 06137 組織類型與職能開窗清單需測試及調整開窗內容
#161111-00049#5   16/11/16   By 01531 固资栏位过
#161111-00028#6   2016/11/23 by 06189 标准程式定义采用宣告模式,弃用.*写
#161111-00049#11  16/11/30   By 01531 固资栏位过滤（修复调整：以账套法人限制)
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
PRIVATE TYPE type_g_faam_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   faam001 LIKE faam_t.faam001, 
   faam002 LIKE faam_t.faam002, 
   faam000 LIKE faam_t.faam000, 
   faah006 LIKE faah_t.faah006, 
   faah006_desc LIKE type_t.chr500, 
   faah007 LIKE type_t.chr500, 
   faah007_desc LIKE type_t.chr500, 
   faam009 LIKE faam_t.faam009, 
   faam009_desc LIKE type_t.chr500, 
   faah028 LIKE type_t.chr500, 
   faah028_desc LIKE type_t.chr500, 
   faah005 LIKE type_t.chr500, 
   faah042 LIKE type_t.chr500, 
   faah008 LIKE type_t.chr500, 
   faah008_desc LIKE type_t.chr500, 
   faah018 LIKE type_t.chr500, 
   faam014 LIKE faam_t.faam014, 
   faam003 LIKE faam_t.faam003, 
   faaj019 LIKE type_t.num20_6, 
   faam007 LIKE faam_t.faam007, 
   faam010 LIKE faam_t.faam010, 
   faam010_desc LIKE type_t.chr500, 
   faam017 LIKE faam_t.faam017, 
   faam015 LIKE faam_t.faam015, 
   faam013 LIKE faam_t.faam013, 
   faah043 LIKE type_t.chr500, 
   faam024 LIKE type_t.chr20, 
   l_faaj008 LIKE type_t.chr10, 
   l_faah012 LIKE type_t.chr500, 
   faam016 LIKE faam_t.faam016, 
   l_faam014_015 LIKE type_t.num20_6, 
   l_faaj004 LIKE type_t.num10, 
   faam022 LIKE faam_t.faam022, 
   l_faam022_desc LIKE type_t.chr500 
       END RECORD
PRIVATE TYPE type_g_faam2_d RECORD
       faam001 LIKE faam_t.faam001, 
   faam002 LIKE faam_t.faam002, 
   faam000 LIKE faam_t.faam000, 
   faam009 LIKE faam_t.faam009, 
   faah028 LIKE faah_t.faah028, 
   faah005 LIKE faah_t.faah005, 
   faah042 LIKE faah_t.faah042, 
   faah008 LIKE faah_t.faah008, 
   faah018 LIKE faah_t.faah018, 
   faam103 LIKE faam_t.faam103, 
   faam003 LIKE faam_t.faam003, 
   faaj019 LIKE faaj_t.faaj019, 
   faam007 LIKE faam_t.faam007, 
   faam010 LIKE faam_t.faam010, 
   faam010_1_desc LIKE type_t.chr500, 
   faam017 LIKE faam_t.faam017, 
   faam105 LIKE faam_t.faam105, 
   faam104 LIKE faam_t.faam104, 
   faah043 LIKE faah_t.faah043, 
   faam024 LIKE faam_t.faam024
       END RECORD
 
PRIVATE TYPE type_g_faam3_d RECORD
       faam001 LIKE faam_t.faam001, 
   faam002 LIKE faam_t.faam002, 
   faam000 LIKE faam_t.faam000, 
   faam009 LIKE faam_t.faam009, 
   faah028 LIKE faah_t.faah028, 
   faah005 LIKE faah_t.faah005, 
   faah042 LIKE faah_t.faah042, 
   faah008 LIKE faah_t.faah008, 
   faah018 LIKE faah_t.faah018, 
   faam153 LIKE faam_t.faam153, 
   faam003 LIKE faam_t.faam003, 
   faaj019 LIKE faaj_t.faaj019, 
   faam007 LIKE faam_t.faam007, 
   faam010 LIKE faam_t.faam010, 
   faam010_3_desc LIKE type_t.chr500, 
   faam017 LIKE faam_t.faam017, 
   faam155 LIKE faam_t.faam155, 
   faam154 LIKE faam_t.faam154, 
   faah043 LIKE faah_t.faah043, 
   faam024 LIKE faam_t.faam024
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_table1           STRING
DEFINE g_glaa015             LIKE glaa_t.glaa015
DEFINE g_glaa019             LIKE glaa_t.glaa019
DEFINE tm                    RECORD
       site       LIKE faaj_t.faajsite,
       site_desc   LIKE type_t.chr80,
       faamld     LIKE faam_t.faamld,
       faamld_desc   LIKE type_t.chr80,
       faamcomp      LIKE faam_t.faamcomp,
       faamcomp_desc LIKE type_t.chr80,
       curr1         LIKE faam_t.faam011,
       curr2         LIKE faam_t.faam011,
       curr3         LIKE faam_t.faam011,
       faam004       LIKE faam_t.faam004,
       faam005       LIKE faam_t.faam005,
       b             LIKE type_t.chr1,
       a             LIKE type_t.chr1
      END RECORD 
DEFINE g_bookno      LIKE faam_t.faamld
DEFINE g_glaa001            LIKE glaa_t.glaa001
DEFINE g_glaa004            LIKE glaa_t.glaa004
DEFINE g_glaa016            LIKE glaa_t.glaa016
DEFINE g_glaa017            LIKE glaa_t.glaa017
DEFINE g_glaa018            LIKE glaa_t.glaa018
DEFINE g_glaacomp           LIKE glaa_t.glaacomp
DEFINE g_glaa020            LIKE glaa_t.glaa020
DEFINE g_glaa021            LIKE glaa_t.glaa021
DEFINE g_glaa022            LIKE glaa_t.glaa022
DEFINE g_xg_wc              STRING   #150923
DEFINE g_wc_cs_ld           STRING      #160125-00005#7
DEFINE g_wc_cs_orga         STRING      #160125-00005#7
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_faam_d
DEFINE g_master_t                   type_g_faam_d
DEFINE g_faam_d          DYNAMIC ARRAY OF type_g_faam_d
DEFINE g_faam_d_t        type_g_faam_d
DEFINE g_faam2_d   DYNAMIC ARRAY OF type_g_faam2_d
DEFINE g_faam2_d_t type_g_faam2_d
 
DEFINE g_faam3_d   DYNAMIC ARRAY OF type_g_faam3_d
DEFINE g_faam3_d_t type_g_faam3_d
 
 
      
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
 
{<section id="afaq130.main" >}
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
   CALL cl_ap_init("afa","")
 
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
   DECLARE afaq130_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afaq130_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afaq130_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afaq130 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afaq130_init()   
 
      #進入選單 Menu (="N")
      CALL afaq130_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afaq130
      
   END IF 
   
   CLOSE afaq130_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afaq130.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afaq130_init()
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
   LET tm.a = '1'
   LET tm.b = '1'    #预设折旧 #20141211 add by chenying
   DISPLAY tm.a TO a
   DISPLAY tm.b TO b #20141211 add by chenying
   CALL cl_set_combo_scc('faah005','9903')
   CALL cl_set_combo_scc('faah042','9917')
   CALL cl_set_combo_scc('faah005_1','9903')
   CALL cl_set_combo_scc('faah042_1','9917')
   CALL cl_set_combo_scc('faah005_3','9903')
   CALL cl_set_combo_scc('faah042_3','9917')
   CALL cl_set_combo_scc('b_faam007','9912')
   CALL cl_set_combo_scc('b_faam003','9904')
   CALL cl_set_combo_scc('faam007_2','9912')
   CALL cl_set_combo_scc('faam003_1','9904')
   CALL cl_set_combo_scc('faam007_3','9912')
   CALL cl_set_combo_scc('faam003_3','9904')
   CALL afaq130_x01_tmp()               #150908-00002#3 
   CALL s_fin_create_account_center_tmp() 
   #营运据点范围
   CALL s_axrt300_get_site(g_user,'','1') RETURNING g_wc_cs_orga #160125-00005#7   
   #end add-point
 
   CALL afaq130_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="afaq130.default_search" >}
PRIVATE FUNCTION afaq130_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " faamld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " faam000 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " faam001 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " faam002 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " faam004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " faam005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " faam006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " faam007 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " faam009 = '", g_argv[09], "' AND "
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
 
{<section id="afaq130.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION afaq130_ui_dialog()
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
      CALL afaq130_b_fill()
   ELSE
      CALL afaq130_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_faam_d.clear()
         CALL g_faam2_d.clear()
 
         CALL g_faam3_d.clear()
 
 
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
 
         CALL afaq130_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_faam_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL afaq130_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL afaq130_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
         DISPLAY ARRAY g_faam2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_faam2_d.getLength() TO FORMONLY.h_count
               CALL afaq130_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point  
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_faam3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_faam3_d.getLength() TO FORMONLY.h_count
               CALL afaq130_fetch()
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
            CALL afaq130_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afaq130_01
            LET g_action_choice="open_afaq130_01"
            IF cl_auth_chk_act("open_afaq130_01") THEN
               
               #add-point:ON ACTION open_afaq130_01 name="menu.open_afaq130_01"
               CALL afaq130_01(tm.faamld,tm.site) RETURNING g_bookno
               LET tm.faamld = g_bookno
               DISPLAY tm.faamld TO b_faamld
               #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
               CALL afaq130_faamld_ref()

                IF cl_null(g_wc) THEN
                   LET g_wc = '1=1'
                END IF
                CALL afaq130_b_fill()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
              #CALL afar001_g01(g_wc_table1,tm.site,tm.faamld,tm.faam004,tm.faam005,tm.a,tm.b,'N','N','N','N','N')   #150923 mark
              #CALL afar001_g01(g_xg_wc,tm.site,tm.faamld,tm.faam004,tm.faam005,tm.a,tm.b,'N','N','N','N','N')       #150923                
               #150908-00002#3-----s
               CALL afaq130_ins_tmp()
               CALL afaq130_x01(" 1 = 1","afaq130_x01_tmp")
               #150908-00002#3-----e
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
              #CALL afar001_g01(g_wc_table1,tm.site,tm.faamld,tm.faam004,tm.faam005,tm.a,tm.b,'N','N','N','N','N')   #150923 mark
              #CALL afar001_g01(g_xg_wc,tm.site,tm.faamld,tm.faam004,tm.faam005,tm.a,tm.b,'N','N','N','N','N')       #150923                
               #150908-00002#3-----s
               CALL afaq130_ins_tmp()
               CALL afaq130_x01(" 1 = 1","afaq130_x01_tmp")
               #150908-00002#3-----e
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afaq130_query()
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
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION afaq130_02
            LET g_action_choice="afaq130_02"
            IF cl_auth_chk_act("afaq130_02") THEN
               
               #add-point:ON ACTION afaq130_02 name="menu.afaq130_02"
               #151105-00001#1 --s
               #151105 carol:產生折舊action移除
               #IF afaq130_afat509_chk() THEN 
               #   #产生afat509
               #    CALL afaq130_ins_fabh()                  
               #END IF 
               #151105-00001#1 --e
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL afaq130_filter()
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
            CALL afaq130_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_faam_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_faam2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_faam3_d)
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
            CALL afaq130_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL afaq130_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL afaq130_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL afaq130_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_faam_d.getLength()
               LET g_faam_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_faam_d.getLength()
               LET g_faam_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_faam_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_faam_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_faam_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_faam_d[li_idx].sel = "N"
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
 
{<section id="afaq130.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afaq130_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE g_bookno   LIKE glaa_t.glaald  #20141117
   DEFINE  l_origin_str          STRING   #組織範圍
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_comp_str            STRING  #161111-00049#5
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_faam_d.clear()
   CALL g_faam2_d.clear()
 
   CALL g_faam3_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON faam001,faam002,faam000,faah006,faam009,faam014,faam003,faam007,faam010, 
          faam017,faam015,faam013,faam016,faam022,faam103,faam105,faam104,faam153,faam155,faam154
           FROM s_detail1[1].b_faam001,s_detail1[1].b_faam002,s_detail1[1].b_faam000,s_detail1[1].b_faah006, 
               s_detail1[1].b_faam009,s_detail1[1].b_faam014,s_detail1[1].b_faam003,s_detail1[1].b_faam007, 
               s_detail1[1].b_faam010,s_detail1[1].b_faam017,s_detail1[1].b_faam015,s_detail1[1].b_faam013, 
               s_detail1[1].b_faam016,s_detail1[1].b_faam022,s_detail2[1].b_faam103,s_detail2[1].b_faam105, 
               s_detail2[1].b_faam104,s_detail3[1].b_faam153,s_detail3[1].b_faam155,s_detail3[1].b_faam154 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_faam001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam001
            #add-point:BEFORE FIELD b_faam001 name="construct.b.page1.b_faam001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam001
            
            #add-point:AFTER FIELD b_faam001 name="construct.a.page1.b_faam001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faam001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam001
            #add-point:ON ACTION controlp INFIELD b_faam001 name="construct.c.page1.b_faam001"
            
            #END add-point
 
 
         #----<<b_faam002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam002
            #add-point:BEFORE FIELD b_faam002 name="construct.b.page1.b_faam002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam002
            
            #add-point:AFTER FIELD b_faam002 name="construct.a.page1.b_faam002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faam002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam002
            #add-point:ON ACTION controlp INFIELD b_faam002 name="construct.c.page1.b_faam002"
            
            #END add-point
 
 
         #----<<b_faam000>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam000
            #add-point:BEFORE FIELD b_faam000 name="construct.b.page1.b_faam000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam000
            
            #add-point:AFTER FIELD b_faam000 name="construct.a.page1.b_faam000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faam000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam000
            #add-point:ON ACTION controlp INFIELD b_faam000 name="construct.c.page1.b_faam000"
            
            #END add-point
 
 
         #----<<b_faah006>>----
         #Ctrlp:construct.c.page1.b_faah006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah006
            #add-point:ON ACTION controlp INFIELD b_faah006 name="construct.c.page1.b_faah006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
			   #161111-00049#5 add s---			   
            #LET g_qryparam.where = " faalld = ",tm.faamld #161111-00049#11  mark
            LET g_qryparam.where = " faalld = '",tm.faamld,"'" #161111-00049#11 add
            CALL q_faal001_1() 
            #161111-00049#5 add e---             
            #CALL q_faac001()    #161111-00049#5  mark
            DISPLAY g_qryparam.return1 TO b_faah006  #顯示到畫面上
            NEXT FIELD b_faah006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah006
            #add-point:BEFORE FIELD b_faah006 name="construct.b.page1.b_faah006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah006
            
            #add-point:AFTER FIELD b_faah006 name="construct.a.page1.b_faah006"
            
            #END add-point
            
 
 
         #----<<faah006_desc>>----
         #----<<faah007>>----
         #----<<faah007_desc>>----
         #----<<b_faam009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam009
            #add-point:BEFORE FIELD b_faam009 name="construct.b.page1.b_faam009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam009
            
            #add-point:AFTER FIELD b_faam009 name="construct.a.page1.b_faam009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faam009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam009
            #add-point:ON ACTION controlp INFIELD b_faam009 name="construct.c.page1.b_faam009"
            
            #END add-point
 
 
         #----<<b_faam009_desc>>----
         #----<<faah028>>----
         #----<<faah028_desc>>----
         #----<<faah005>>----
         #----<<faah042>>----
         #----<<faah008>>----
         #----<<faah008_desc>>----
         #----<<faah018>>----
         #----<<b_faam014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam014
            #add-point:BEFORE FIELD b_faam014 name="construct.b.page1.b_faam014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam014
            
            #add-point:AFTER FIELD b_faam014 name="construct.a.page1.b_faam014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faam014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam014
            #add-point:ON ACTION controlp INFIELD b_faam014 name="construct.c.page1.b_faam014"
            
            #END add-point
 
 
         #----<<b_faam003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam003
            #add-point:BEFORE FIELD b_faam003 name="construct.b.page1.b_faam003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam003
            
            #add-point:AFTER FIELD b_faam003 name="construct.a.page1.b_faam003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faam003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam003
            #add-point:ON ACTION controlp INFIELD b_faam003 name="construct.c.page1.b_faam003"
            
            #END add-point
 
 
         #----<<faaj019>>----
         #----<<b_faam007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam007
            #add-point:BEFORE FIELD b_faam007 name="construct.b.page1.b_faam007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam007
            
            #add-point:AFTER FIELD b_faam007 name="construct.a.page1.b_faam007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faam007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam007
            #add-point:ON ACTION controlp INFIELD b_faam007 name="construct.c.page1.b_faam007"
            
            #END add-point
 
 
         #----<<b_faam010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam010
            #add-point:BEFORE FIELD b_faam010 name="construct.b.page1.b_faam010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam010
            
            #add-point:AFTER FIELD b_faam010 name="construct.a.page1.b_faam010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faam010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam010
            #add-point:ON ACTION controlp INFIELD b_faam010 name="construct.c.page1.b_faam010"
            
            #END add-point
 
 
         #----<<b_faam010_desc>>----
         #----<<b_faam017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam017
            #add-point:BEFORE FIELD b_faam017 name="construct.b.page1.b_faam017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam017
            
            #add-point:AFTER FIELD b_faam017 name="construct.a.page1.b_faam017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faam017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam017
            #add-point:ON ACTION controlp INFIELD b_faam017 name="construct.c.page1.b_faam017"
            
            #END add-point
 
 
         #----<<b_faam015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam015
            #add-point:BEFORE FIELD b_faam015 name="construct.b.page1.b_faam015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam015
            
            #add-point:AFTER FIELD b_faam015 name="construct.a.page1.b_faam015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faam015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam015
            #add-point:ON ACTION controlp INFIELD b_faam015 name="construct.c.page1.b_faam015"
            
            #END add-point
 
 
         #----<<b_faam013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam013
            #add-point:BEFORE FIELD b_faam013 name="construct.b.page1.b_faam013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam013
            
            #add-point:AFTER FIELD b_faam013 name="construct.a.page1.b_faam013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faam013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam013
            #add-point:ON ACTION controlp INFIELD b_faam013 name="construct.c.page1.b_faam013"
            
            #END add-point
 
 
         #----<<faah043>>----
         #----<<faam024>>----
         #----<<l_faaj008>>----
         #----<<l_faah012>>----
         #----<<b_faam016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam016
            #add-point:BEFORE FIELD b_faam016 name="construct.b.page1.b_faam016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam016
            
            #add-point:AFTER FIELD b_faam016 name="construct.a.page1.b_faam016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faam016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam016
            #add-point:ON ACTION controlp INFIELD b_faam016 name="construct.c.page1.b_faam016"
            
            #END add-point
 
 
         #----<<l_faam014_015>>----
         #----<<l_faaj004>>----
         #----<<b_faam022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam022
            #add-point:BEFORE FIELD b_faam022 name="construct.b.page1.b_faam022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam022
            
            #add-point:AFTER FIELD b_faam022 name="construct.a.page1.b_faam022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faam022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam022
            #add-point:ON ACTION controlp INFIELD b_faam022 name="construct.c.page1.b_faam022"
            
            #END add-point
 
 
         #----<<l_faam022_desc>>----
         #----<<faah028_1>>----
         #----<<faah005_1>>----
         #----<<faah042_1>>----
         #----<<faah008_1>>----
         #----<<faah018_1>>----
         #----<<b_faam103>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam103
            #add-point:BEFORE FIELD b_faam103 name="construct.b.page2.b_faam103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam103
            
            #add-point:AFTER FIELD b_faam103 name="construct.a.page2.b_faam103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_faam103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam103
            #add-point:ON ACTION controlp INFIELD b_faam103 name="construct.c.page2.b_faam103"
            
            #END add-point
 
 
         #----<<faam003_1>>----
         #----<<faaj019_1>>----
         #----<<faam010_1>>----
         #----<<faam010_1_desc>>----
         #----<<faam017_1>>----
         #----<<b_faam105>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam105
            #add-point:BEFORE FIELD b_faam105 name="construct.b.page2.b_faam105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam105
            
            #add-point:AFTER FIELD b_faam105 name="construct.a.page2.b_faam105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_faam105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam105
            #add-point:ON ACTION controlp INFIELD b_faam105 name="construct.c.page2.b_faam105"
            
            #END add-point
 
 
         #----<<b_faam104>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam104
            #add-point:BEFORE FIELD b_faam104 name="construct.b.page2.b_faam104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam104
            
            #add-point:AFTER FIELD b_faam104 name="construct.a.page2.b_faam104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_faam104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam104
            #add-point:ON ACTION controlp INFIELD b_faam104 name="construct.c.page2.b_faam104"
            
            #END add-point
 
 
         #----<<faah043_1>>----
         #----<<faam024_1>>----
         #----<<b_faam153>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam153
            #add-point:BEFORE FIELD b_faam153 name="construct.b.page3.b_faam153"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam153
            
            #add-point:AFTER FIELD b_faam153 name="construct.a.page3.b_faam153"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_faam153
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam153
            #add-point:ON ACTION controlp INFIELD b_faam153 name="construct.c.page3.b_faam153"
            
            #END add-point
 
 
         #----<<faam010_3_desc>>----
         #----<<b_faam155>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam155
            #add-point:BEFORE FIELD b_faam155 name="construct.b.page3.b_faam155"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam155
            
            #add-point:AFTER FIELD b_faam155 name="construct.a.page3.b_faam155"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_faam155
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam155
            #add-point:ON ACTION controlp INFIELD b_faam155 name="construct.c.page3.b_faam155"
            
            #END add-point
 
 
         #----<<b_faam154>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faam154
            #add-point:BEFORE FIELD b_faam154 name="construct.b.page3.b_faam154"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faam154
            
            #add-point:AFTER FIELD b_faam154 name="construct.a.page3.b_faam154"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_faam154
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam154
            #add-point:ON ACTION controlp INFIELD b_faam154 name="construct.c.page3.b_faam154"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT tm.site,tm.faamld,tm.faam004,tm.faam005 FROM b_site,b_faamld,b_faam004,b_faam005
         BEFORE INPUT
           # LET tm.a = '1'
           # DISPLAY tm.a TO a
           # #20141211 add by chenying
           # LET tm.b = '1'
           # DISPLAY tm.b TO b
           # #20141211 add by chenying
##20141117 mod--str--            
##            LET tm.site = g_site
#            CALL s_afat503_default(g_bookno) RETURNING l_success,tm.site,tm.faamld,tm.faamcomp 
#            SELECT ooefl003 INTO tm.faamcomp_desc FROM ooefl_t
#             WHERE ooeflent = g_enterprise AND ooefl001 = tm.faamcomp
#               AND ooefl002 = g_dlang               
##20141117 mod--end--
#            CALL afaq130_site_desc()
##20141117 mark--str--            
##            SELECT glaald INTO tm.faamld FROM glaa_t
##             WHERE glaaent = g_enterprise AND glaacomp = g_site
##               AND glaa014 = 'Y'
##20141117 mark--end--  
#            DISPLAY tm.faamld TO b_faamld
#            CALL afaq130_faamld_ref()
#            LET tm.faam004 = YEAR(g_today)
#            LET tm.faam005 = MONTH(g_today)
#            DISPLAY tm.faam004 TO b_faam004
#            DISPLAY tm.faam005 TO b_faam005
#            CALL afaq130_get_glaa()  #21041217 add by chenying
         AFTER FIELD b_faamld
           CALL afaq130_faamld_ref()
           IF NOT cl_null(tm.faamld) THEN
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=tm.faamld
               #160318-00025#7--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#7--add--end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_glaald") THEN
                  #檢查失敗時後續處理
                  LET tm.faamld = ''
                  NEXT FIELD CURRENT
               END IF
               CALL afaq130_set_curr()
            END IF
            IF NOT cl_null(tm.faamld) AND NOT cl_null(tm.site) THEN
               CALL s_fin_account_center_with_ld_chk(tm.site,tm.faamld,g_user,'5','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET tm.faamld = ''
                  DISPLAY tm.faamld TO b_faaml
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL afaq130_faamld_ref()
            CALL afaq130_get_glaa()  #21041217 add by chenying
         AFTER FIELD b_site
             IF NOT cl_null(tm.faamld) AND NOT cl_null(tm.site) THEN
               CALL s_fin_account_center_with_ld_chk(tm.site,tm.faamld,g_user,'5','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET tm.site = ''
                  DISPLAY tm.site TO b_site
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL afaq130_site_desc()
             
         ON ACTION controlp INFIELD b_site
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = tm.site  #20141117 
            LET g_qryparam.where = " ooef207 = 'Y' "  #20141211 add by chenying  
            #160426-00014#33--mark--str--lujh
            ##160125-00005#7--add--str--
            #IF NOT cl_null(g_wc_cs_orga) THEN
			   #   LET g_qryparam.where = g_wc_cs_orga
			   #END IF
			   ##160125-00005#7--add--end     
            #160426-00014#33--mark--end--lujh			   
#            CALL q_ooed002()         #呼叫開窗        #20141211 mark by chenying
            #CALL q_ooef001()         #161006-00005#22 Mark By Ken 161024                 #20141211 add by chenying
            CALL q_ooef001_47()       #161006-00005#22 Add By Ken 161024 
            LET tm.site = g_qryparam.return1
            DISPLAY tm.site TO b_site  #顯示到畫面上
            CALL afaq130_site_desc()
            NEXT FIELD b_site                     #返回原欄位
            
         ON ACTION controlp INFIELD b_faamld
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = tm.faamld  #20141117
            
            #20141117
            #取得资产組織下所屬成員
#            CALL s_fin_account_center_sons_query('5',tm.site,'','1')   #20141211 mark by chenying
            CALL s_fin_account_center_sons_query('5',tm.site,g_today,'1')    #20141211 add by chenying        
            #取得资产中心下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL afaq130_change_to_sql(l_origin_str) RETURNING l_origin_str
            LET l_origin_str=l_origin_str.substring(2,l_origin_str.getLength()-1) #160125-00005#7 add 
            #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )" #160125-00005#7 add
            LET g_qryparam.where = "(glaa008 = 'Y' OR glaa014 = 'Y') " #160125-00005#7 add
            #給予arg
            #20141117
 
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #160125-00005#7--add--str--
            #账套范围
            CALL s_axrt300_get_site(g_user,l_origin_str,'2')  RETURNING g_wc_cs_ld
            IF NOT cl_null(g_wc_cs_ld) THEN   
               LET g_qryparam.where = g_qryparam.where," AND ",g_wc_cs_ld
            END IF
            #160125-00005#7--add--end             
            CALL q_authorised_ld()                                #呼叫開窗
            LET tm.faamld = g_qryparam.return1
            DISPLAY tm.faamld TO b_faamld    #顯示到畫面上
            CALL afaq130_faamld_ref()
            CALL afaq130_set_curr()
            NEXT FIELD b_faamld                       #返回原欄位
      END INPUT
      
       CONSTRUCT BY NAME g_wc_table1 ON faam001,faam002,faam000,faam009
         BEFORE CONSTRUCT
            
         
         ON ACTION controlp INFIELD faam001
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
			   #161111-00049#5 add s--- 
#161111-00049#11 mod s---			   
#            CALL s_fin_account_center_sons_query('5',tm.site,g_today,'1')
#            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
#            CALL s_fin_get_wc_str(l_origin_str) RETURNING l_origin_str
#            LET g_qryparam.where = " faah032 IN ",l_origin_str CLIPPED		   
              IF NOT cl_null(tm.faamld) THEN
                 LET g_qryparam.where = " faah032 IN(SELECT glaacomp FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",tm.faamld,"')"
              END IF
#161111-00049#11 mod e---  
			   #161111-00049#5 add e---             
            CALL q_faah003_8()                        #呼叫開窗
            LET g_qryparam.where = ""
            DISPLAY g_qryparam.return1 TO faam001  #顯示到畫面上
            NEXT FIELD faam001                     #返回原欄位
            
         ON ACTION controlp INFIELD faam002
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#161111-00049#11 mod s---            
#			   #161111-00049#5 add s---  
#            CALL s_fin_account_center_sons_query('5',tm.site,g_today,'1')
#            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
#            CALL s_fin_get_wc_str(l_origin_str) RETURNING l_origin_str
#            LET g_qryparam.where = " faah032 IN ",l_origin_str CLIPPED		
#			   #161111-00049#5 add e--- 
              IF NOT cl_null(tm.faamld) THEN
                 LET g_qryparam.where = " faah032 IN(SELECT glaacomp FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",tm.faamld,"')"
              END IF
#161111-00049#11 mod e---  			   
            CALL q_faah004_2()                                #呼叫開窗
            
            DISPLAY g_qryparam.return1 TO faam002    #顯示到畫面上
            NEXT FIELD faam002                       #返回原欄位
        
             
          ON ACTION controlp INFIELD faam000
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#161111-00049#11 mod s---              
#			   #161111-00049#5 add s---  
#            CALL s_fin_account_center_sons_query('5',tm.site,g_today,'1')
#            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
#            CALL s_fin_get_wc_str(l_origin_str) RETURNING l_origin_str
#            LET g_qryparam.where = " faah032 IN ",l_origin_str CLIPPED		   
#			   #161111-00049#5 add e---     
              IF NOT cl_null(tm.faamld) THEN
                 LET g_qryparam.where = " faah032 IN(SELECT glaacomp FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",tm.faamld,"')"
              END IF
#161111-00049#11 mod e---  			   
            CALL q_faah003_7()                        #呼叫開窗
            LET g_qryparam.where = ""
            DISPLAY g_qryparam.return1 TO faam000  #顯示到畫面上
            NEXT FIELD faam000                     #返回原欄位
            
         ON ACTION controlp INFIELD faam009
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO faam009    #顯示到畫面上
            NEXT FIELD faam009                       #返回原欄位
            
      END CONSTRUCT 

#20141211 mod by chenying
#      INPUT tm.a FROM a
#         BEFORE INPUT
      INPUT tm.a,tm.b FROM a,b
         BEFORE INPUT
#20141211 mod by chenying         
         
      END INPUT
     
      BEFORE DIALOG 
         #150923--s
         CALL cl_qbe_init()
         LET g_faam_d[1].faam001 = ''
         DISPLAY ARRAY g_faam_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         #150923--e      
         LET tm.a = '1'
         DISPLAY tm.a TO a
         LET tm.b = '1'
         DISPLAY tm.b TO b
         
        CALL s_afat503_default(g_bookno) RETURNING l_success,tm.site,tm.faamld,tm.faamcomp 
         SELECT ooefl003 INTO tm.faamcomp_desc FROM ooefl_t
          WHERE ooeflent = g_enterprise AND ooefl001 = tm.faamcomp
            AND ooefl002 = g_dlang               
       
         CALL afaq130_site_desc()
       
         DISPLAY tm.faamld TO b_faamld
         CALL afaq130_faamld_ref()
         
        
        CALL cl_get_para(g_enterprise,tm.faamcomp,'S-FIN-9018') RETURNING tm.faam004
        CALL cl_get_para(g_enterprise,tm.faamcomp,'S-FIN-9019') RETURNING tm.faam005
        IF cl_null(tm.faam004) OR cl_null(tm.faam005) THEN
           LET tm.faam004 = YEAR(g_today)
           LET tm.faam005 = MONTH(g_today)
        END IF
         DISPLAY tm.faam004 TO b_faam004
         DISPLAY tm.faam005 TO b_faam005
         CALL afaq130_get_glaa()  

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
   CALL afaq130_b_fill()
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
 
{<section id="afaq130.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afaq130_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_faam022_desc  STRING   #160505-00007#1 add lujh
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc_table1) THEN 
      LET g_wc_table1 = " 1=1" 
   END IF 
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',faam001,faam002,faam000,'','','','',faam009,'','','','','','', 
       '','',faam014,faam003,'',faam007,faam010,'',faam017,faam015,faam013,'','','','',faam016,'','', 
       faam022,'','','','','','','','','','',faam103,'','','','','','',faam105,faam104,'','','','','', 
       '','','','','','',faam153,'','','','','','',faam155,faam154,'',''  ,DENSE_RANK() OVER( ORDER BY faam_t.faamld, 
       faam_t.faam000,faam_t.faam001,faam_t.faam002,faam_t.faam004,faam_t.faam005,faam_t.faam006,faam_t.faam007, 
       faam_t.faam009) AS RANK FROM faam_t",
 
 
                     "",
                     " WHERE faament= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("faam_t"),
                     " ORDER BY faam_t.faamld,faam_t.faam000,faam_t.faam001,faam_t.faam002,faam_t.faam004,faam_t.faam005,faam_t.faam006,faam_t.faam007,faam_t.faam009"
 
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
 
   LET g_sql = "SELECT '',faam001,faam002,faam000,'','','','',faam009,'','','','','','','','',faam014, 
       faam003,'',faam007,faam010,'',faam017,faam015,faam013,'','','','',faam016,'','',faam022,'','', 
       '','','','','','','','',faam103,'','','','','','',faam105,faam104,'','','','','','','','','', 
       '','',faam153,'','','','','','',faam155,faam154,'',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET l_faam022_desc = "(SELECT glacl004 FROM glacl_t WHERE glaclent = '",g_enterprise,"' AND glacl001 = '",g_glaa004,"' AND glacl002 = faam022 AND glacl003 ='",g_dlang,"')"  #160505-00007#1 add lujh
   
   LET g_sql = "SELECT UNIQUE '',faam001,faam002,faam000,faah006,faacl003,faah007,faadl003,",
               "       faam009,t1.ooefl003,faah028,t2.ooefl003,faah005,faah042,faah008,oocql004,",
               "       faah018,faam014,faam003,faaj019,faam007,faam010,t3.ooefl003,faam017,",
               "       faam015,faam013,faah043,faam024,faaj008,faah012,faam016,faam014-faam015,faaj004,", #150908-00002#4 add faaj008~faam022   #151105-00001#1 add faaj004
               "       faam022,",l_faam022_desc,",faam001,faam002,faam000,faam009,faah028,faah005,faah042,faah008,",   #160505-00007#1 change '' to l_faam022_desc
               "       faah018,faam103,faam003,faaj019,faam007,faam010,t4.ooefl003,faam017,faam105,",
               "       faam104,faah043,faam024,faam001,faam002,faam000,faam009,faah028,faah005,",
               "       faah042,faah008,faah018,faam153,faam003,faaj019,faam007,faam010,t5.ooefl003,",
               "       faam017,faam155,faam154,faah043,faam024 ", #20150618 add faah007,faadl003 lujh      
               " FROM faam_t  ",
               " LEFT JOIN ooefl_t t1 ON faament = t1.ooeflent AND faam009 = t1.ooefl001 AND t1.ooefl002 = '",g_lang,"'",
               " LEFT JOIN ooefl_t t3 ON faament = t3.ooeflent AND faam010 = t3.ooefl001 AND t3.ooefl002 = '",g_lang,"'",
               " LEFT JOIN ooefl_t t4 ON faament = t4.ooeflent AND faam010 = t4.ooefl001 AND t4.ooefl002 = '",g_lang,"'",
               " LEFT JOIN ooefl_t t5 ON faament = t5.ooeflent AND faam010 = t5.ooefl001 AND t5.ooefl002 = '",g_lang,"'",
               " ,faaj_t,faah_t",
               " LEFT JOIN ooefl_t t2 ON faahent = t2.ooeflent AND faah028 = t2.ooefl001 AND t2.ooefl002 = '",g_lang,"'",
               " LEFT JOIN oocql_t ON oocqlent = faahent AND oocql001 = '3903' AND oocql002 = faah008 AND oocql003 = '",g_lang,"'",
               #################
               " LEFT JOIN faacl_t ON faah006 = faacl001 AND faacl002 = '",g_lang,"' AND faaclent = faahent AND faaclent = '",g_enterprise,"'",
               " LEFT JOIN faadl_t ON faah007 = faadl001 AND faadl002 = '",g_lang,"' AND faadlent = faahent AND faadlent = '",g_enterprise,"'",   #20150618 add lujh
               #################
               "",
               " WHERE faahent = faajent AND faajent = faament ",
               "   AND faah003 = faaj001 AND faah004 = faaj002 ",
               "   AND faaj001 = faam001 AND faaj002 = faam002 ",  
               "   AND faah001 = faaj037 AND faaj037 = faam000 ", #20141217 add by chenying
               "   AND faajld = faamld AND faah000 = faaj000 ",#150908-00002#3 add faah000
               "   AND faahstus = 'Y' ",
               "   AND faament= ? AND 1=1  AND faamld = '",tm.faamld,"' AND faam004 = ",tm.faam004,
               "   AND faam005 = ",tm.faam005,
               "   AND ", ls_wc,
               " AND ",g_wc_table1,cl_sql_add_filter("faam_t")
               
   
   IF tm.a = '1' THEN
      #LET g_sql = g_sql CLIPPED," AND (faam007 = '1' OR faam007 = '2' )"                 #160426-00014#6 mark
      LET g_sql = g_sql CLIPPED," AND (faam007 = '1' OR faam007 = '2' OR faam007 = '4')"  #160426-00014#6 add 
   ELSE
      LET g_sql = g_sql CLIPPED," AND (faam007 = '1' OR faam007 = '3' )" 
   END IF   
   
   #20141211 add by chenying
   IF tm.b = '1' THEN
      LET g_sql = g_sql CLIPPED," AND faam006 = '1' " 
   ELSE
      LET g_sql = g_sql CLIPPED," AND faam006 = '0' " 
   END IF    
   #20141211 add by chenying
   
   LET g_sql = g_sql, cl_sql_add_filter("faam_t"),
                      " ORDER BY faam_t.faam000,faam_t.faam001,faam_t.faam002,faam_t.faam007,faam_t.faam009"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afaq130_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afaq130_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_faam_d.clear()
   CALL g_faam2_d.clear()   
 
   CALL g_faam3_d.clear()   
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET g_xg_wc = g_wc_table1," AND ", ls_wc   #150923
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_faam_d[l_ac].sel,g_faam_d[l_ac].faam001,g_faam_d[l_ac].faam002,g_faam_d[l_ac].faam000, 
       g_faam_d[l_ac].faah006,g_faam_d[l_ac].faah006_desc,g_faam_d[l_ac].faah007,g_faam_d[l_ac].faah007_desc, 
       g_faam_d[l_ac].faam009,g_faam_d[l_ac].faam009_desc,g_faam_d[l_ac].faah028,g_faam_d[l_ac].faah028_desc, 
       g_faam_d[l_ac].faah005,g_faam_d[l_ac].faah042,g_faam_d[l_ac].faah008,g_faam_d[l_ac].faah008_desc, 
       g_faam_d[l_ac].faah018,g_faam_d[l_ac].faam014,g_faam_d[l_ac].faam003,g_faam_d[l_ac].faaj019,g_faam_d[l_ac].faam007, 
       g_faam_d[l_ac].faam010,g_faam_d[l_ac].faam010_desc,g_faam_d[l_ac].faam017,g_faam_d[l_ac].faam015, 
       g_faam_d[l_ac].faam013,g_faam_d[l_ac].faah043,g_faam_d[l_ac].faam024,g_faam_d[l_ac].l_faaj008, 
       g_faam_d[l_ac].l_faah012,g_faam_d[l_ac].faam016,g_faam_d[l_ac].l_faam014_015,g_faam_d[l_ac].l_faaj004, 
       g_faam_d[l_ac].faam022,g_faam_d[l_ac].l_faam022_desc,g_faam2_d[l_ac].faam001,g_faam2_d[l_ac].faam002, 
       g_faam2_d[l_ac].faam000,g_faam2_d[l_ac].faam009,g_faam2_d[l_ac].faah028,g_faam2_d[l_ac].faah005, 
       g_faam2_d[l_ac].faah042,g_faam2_d[l_ac].faah008,g_faam2_d[l_ac].faah018,g_faam2_d[l_ac].faam103, 
       g_faam2_d[l_ac].faam003,g_faam2_d[l_ac].faaj019,g_faam2_d[l_ac].faam007,g_faam2_d[l_ac].faam010, 
       g_faam2_d[l_ac].faam010_1_desc,g_faam2_d[l_ac].faam017,g_faam2_d[l_ac].faam105,g_faam2_d[l_ac].faam104, 
       g_faam2_d[l_ac].faah043,g_faam2_d[l_ac].faam024,g_faam3_d[l_ac].faam001,g_faam3_d[l_ac].faam002, 
       g_faam3_d[l_ac].faam000,g_faam3_d[l_ac].faam009,g_faam3_d[l_ac].faah028,g_faam3_d[l_ac].faah005, 
       g_faam3_d[l_ac].faah042,g_faam3_d[l_ac].faah008,g_faam3_d[l_ac].faah018,g_faam3_d[l_ac].faam153, 
       g_faam3_d[l_ac].faam003,g_faam3_d[l_ac].faaj019,g_faam3_d[l_ac].faam007,g_faam3_d[l_ac].faam010, 
       g_faam3_d[l_ac].faam010_3_desc,g_faam3_d[l_ac].faam017,g_faam3_d[l_ac].faam155,g_faam3_d[l_ac].faam154, 
       g_faam3_d[l_ac].faah043,g_faam3_d[l_ac].faam024
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_faam_d[l_ac].statepic = cl_get_actipic(g_faam_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #CALL s_desc_get_account_desc(tm.faamld,g_faam_d[l_ac].faam022) RETURNING g_faam_d[l_ac].l_faam022_desc  #160505-00007#1 mark lujh
      #end add-point
 
      CALL afaq130_detail_show("'1'")      
 
      CALL afaq130_faam_t_mask()
 
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
   
 
   
   CALL g_faam_d.deleteElement(g_faam_d.getLength())   
   CALL g_faam2_d.deleteElement(g_faam2_d.getLength())
 
   CALL g_faam3_d.deleteElement(g_faam3_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_faam_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE afaq130_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL afaq130_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL afaq130_detail_action_trans()
 
   IF g_faam_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL afaq130_fetch()
   END IF
   
      CALL afaq130_filter_show('faam001','b_faam001')
   CALL afaq130_filter_show('faam002','b_faam002')
   CALL afaq130_filter_show('faam000','b_faam000')
   CALL afaq130_filter_show('faah006','b_faah006')
   CALL afaq130_filter_show('faam009','b_faam009')
   CALL afaq130_filter_show('faam014','b_faam014')
   CALL afaq130_filter_show('faam003','b_faam003')
   CALL afaq130_filter_show('faam007','b_faam007')
   CALL afaq130_filter_show('faam010','b_faam010')
   CALL afaq130_filter_show('faam017','b_faam017')
   CALL afaq130_filter_show('faam015','b_faam015')
   CALL afaq130_filter_show('faam013','b_faam013')
   CALL afaq130_filter_show('faam016','b_faam016')
   CALL afaq130_filter_show('faam022','b_faam022')
   CALL afaq130_filter_show('faam103','b_faam103')
   CALL afaq130_filter_show('faam105','b_faam105')
   CALL afaq130_filter_show('faam104','b_faam104')
   CALL afaq130_filter_show('faam153','b_faam153')
   CALL afaq130_filter_show('faam155','b_faam155')
   CALL afaq130_filter_show('faam154','b_faam154')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afaq130.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afaq130_fetch()
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
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="afaq130.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afaq130_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_faam_d[l_ac].faam009
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_faam_d[l_ac].faam009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faam_d[l_ac].faam009_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faam_d[l_ac].faam010
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_faam_d[l_ac].faam010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faam_d[l_ac].faam010_desc

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
 
{<section id="afaq130.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afaq130_filter()
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
      CONSTRUCT g_wc_filter ON faam001,faam002,faam000,faah006,faam009,faam014,faam003,faam007,faam010, 
          faam017,faam015,faam013,faam016,faam022,faam103,faam105,faam104,faam153,faam155,faam154
                          FROM s_detail1[1].b_faam001,s_detail1[1].b_faam002,s_detail1[1].b_faam000, 
                              s_detail1[1].b_faah006,s_detail1[1].b_faam009,s_detail1[1].b_faam014,s_detail1[1].b_faam003, 
                              s_detail1[1].b_faam007,s_detail1[1].b_faam010,s_detail1[1].b_faam017,s_detail1[1].b_faam015, 
                              s_detail1[1].b_faam013,s_detail1[1].b_faam016,s_detail1[1].b_faam022,s_detail2[1].b_faam103, 
                              s_detail2[1].b_faam105,s_detail2[1].b_faam104,s_detail3[1].b_faam153,s_detail3[1].b_faam155, 
                              s_detail3[1].b_faam154
 
         BEFORE CONSTRUCT
                     DISPLAY afaq130_filter_parser('faam001') TO s_detail1[1].b_faam001
            DISPLAY afaq130_filter_parser('faam002') TO s_detail1[1].b_faam002
            DISPLAY afaq130_filter_parser('faam000') TO s_detail1[1].b_faam000
            DISPLAY afaq130_filter_parser('faah006') TO s_detail1[1].b_faah006
            DISPLAY afaq130_filter_parser('faam009') TO s_detail1[1].b_faam009
            DISPLAY afaq130_filter_parser('faam014') TO s_detail1[1].b_faam014
            DISPLAY afaq130_filter_parser('faam003') TO s_detail1[1].b_faam003
            DISPLAY afaq130_filter_parser('faam007') TO s_detail1[1].b_faam007
            DISPLAY afaq130_filter_parser('faam010') TO s_detail1[1].b_faam010
            DISPLAY afaq130_filter_parser('faam017') TO s_detail1[1].b_faam017
            DISPLAY afaq130_filter_parser('faam015') TO s_detail1[1].b_faam015
            DISPLAY afaq130_filter_parser('faam013') TO s_detail1[1].b_faam013
            DISPLAY afaq130_filter_parser('faam016') TO s_detail1[1].b_faam016
            DISPLAY afaq130_filter_parser('faam022') TO s_detail1[1].b_faam022
            DISPLAY afaq130_filter_parser('faam103') TO s_detail2[1].b_faam103
            DISPLAY afaq130_filter_parser('faam105') TO s_detail2[1].b_faam105
            DISPLAY afaq130_filter_parser('faam104') TO s_detail2[1].b_faam104
            DISPLAY afaq130_filter_parser('faam153') TO s_detail3[1].b_faam153
            DISPLAY afaq130_filter_parser('faam155') TO s_detail3[1].b_faam155
            DISPLAY afaq130_filter_parser('faam154') TO s_detail3[1].b_faam154
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_faam001>>----
         #Ctrlp:construct.c.filter.page1.b_faam001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam001
            #add-point:ON ACTION controlp INFIELD b_faam001 name="construct.c.filter.page1.b_faam001"
            
            #END add-point
 
 
         #----<<b_faam002>>----
         #Ctrlp:construct.c.filter.page1.b_faam002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam002
            #add-point:ON ACTION controlp INFIELD b_faam002 name="construct.c.filter.page1.b_faam002"
            
            #END add-point
 
 
         #----<<b_faam000>>----
         #Ctrlp:construct.c.filter.page1.b_faam000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam000
            #add-point:ON ACTION controlp INFIELD b_faam000 name="construct.c.filter.page1.b_faam000"
            
            #END add-point
 
 
         #----<<b_faah006>>----
         #Ctrlp:construct.c.page1.b_faah006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah006
            #add-point:ON ACTION controlp INFIELD b_faah006 name="construct.c.filter.page1.b_faah006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faac001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah006  #顯示到畫面上
            NEXT FIELD b_faah006                     #返回原欄位
    


            #END add-point
 
 
         #----<<faah006_desc>>----
         #----<<faah007>>----
         #----<<faah007_desc>>----
         #----<<b_faam009>>----
         #Ctrlp:construct.c.filter.page1.b_faam009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam009
            #add-point:ON ACTION controlp INFIELD b_faam009 name="construct.c.filter.page1.b_faam009"
            
            #END add-point
 
 
         #----<<b_faam009_desc>>----
         #----<<faah028>>----
         #----<<faah028_desc>>----
         #----<<faah005>>----
         #----<<faah042>>----
         #----<<faah008>>----
         #----<<faah008_desc>>----
         #----<<faah018>>----
         #----<<b_faam014>>----
         #Ctrlp:construct.c.filter.page1.b_faam014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam014
            #add-point:ON ACTION controlp INFIELD b_faam014 name="construct.c.filter.page1.b_faam014"
            
            #END add-point
 
 
         #----<<b_faam003>>----
         #Ctrlp:construct.c.filter.page1.b_faam003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam003
            #add-point:ON ACTION controlp INFIELD b_faam003 name="construct.c.filter.page1.b_faam003"
            
            #END add-point
 
 
         #----<<faaj019>>----
         #----<<b_faam007>>----
         #Ctrlp:construct.c.filter.page1.b_faam007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam007
            #add-point:ON ACTION controlp INFIELD b_faam007 name="construct.c.filter.page1.b_faam007"
            
            #END add-point
 
 
         #----<<b_faam010>>----
         #Ctrlp:construct.c.filter.page1.b_faam010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam010
            #add-point:ON ACTION controlp INFIELD b_faam010 name="construct.c.filter.page1.b_faam010"
            
            #END add-point
 
 
         #----<<b_faam010_desc>>----
         #----<<b_faam017>>----
         #Ctrlp:construct.c.filter.page1.b_faam017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam017
            #add-point:ON ACTION controlp INFIELD b_faam017 name="construct.c.filter.page1.b_faam017"
            
            #END add-point
 
 
         #----<<b_faam015>>----
         #Ctrlp:construct.c.filter.page1.b_faam015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam015
            #add-point:ON ACTION controlp INFIELD b_faam015 name="construct.c.filter.page1.b_faam015"
            
            #END add-point
 
 
         #----<<b_faam013>>----
         #Ctrlp:construct.c.filter.page1.b_faam013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam013
            #add-point:ON ACTION controlp INFIELD b_faam013 name="construct.c.filter.page1.b_faam013"
            
            #END add-point
 
 
         #----<<faah043>>----
         #----<<faam024>>----
         #----<<l_faaj008>>----
         #----<<l_faah012>>----
         #----<<b_faam016>>----
         #Ctrlp:construct.c.filter.page1.b_faam016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam016
            #add-point:ON ACTION controlp INFIELD b_faam016 name="construct.c.filter.page1.b_faam016"
            
            #END add-point
 
 
         #----<<l_faam014_015>>----
         #----<<l_faaj004>>----
         #----<<b_faam022>>----
         #Ctrlp:construct.c.filter.page1.b_faam022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam022
            #add-point:ON ACTION controlp INFIELD b_faam022 name="construct.c.filter.page1.b_faam022"
            
            #END add-point
 
 
         #----<<l_faam022_desc>>----
         #----<<faah028_1>>----
         #----<<faah005_1>>----
         #----<<faah042_1>>----
         #----<<faah008_1>>----
         #----<<faah018_1>>----
         #----<<b_faam103>>----
         #Ctrlp:construct.c.filter.page2.b_faam103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam103
            #add-point:ON ACTION controlp INFIELD b_faam103 name="construct.c.filter.page2.b_faam103"
            
            #END add-point
 
 
         #----<<faam003_1>>----
         #----<<faaj019_1>>----
         #----<<faam010_1>>----
         #----<<faam010_1_desc>>----
         #----<<faam017_1>>----
         #----<<b_faam105>>----
         #Ctrlp:construct.c.filter.page2.b_faam105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam105
            #add-point:ON ACTION controlp INFIELD b_faam105 name="construct.c.filter.page2.b_faam105"
            
            #END add-point
 
 
         #----<<b_faam104>>----
         #Ctrlp:construct.c.filter.page2.b_faam104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam104
            #add-point:ON ACTION controlp INFIELD b_faam104 name="construct.c.filter.page2.b_faam104"
            
            #END add-point
 
 
         #----<<faah043_1>>----
         #----<<faam024_1>>----
         #----<<b_faam153>>----
         #Ctrlp:construct.c.filter.page3.b_faam153
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam153
            #add-point:ON ACTION controlp INFIELD b_faam153 name="construct.c.filter.page3.b_faam153"
            
            #END add-point
 
 
         #----<<faam010_3_desc>>----
         #----<<b_faam155>>----
         #Ctrlp:construct.c.filter.page3.b_faam155
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam155
            #add-point:ON ACTION controlp INFIELD b_faam155 name="construct.c.filter.page3.b_faam155"
            
            #END add-point
 
 
         #----<<b_faam154>>----
         #Ctrlp:construct.c.filter.page3.b_faam154
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faam154
            #add-point:ON ACTION controlp INFIELD b_faam154 name="construct.c.filter.page3.b_faam154"
            
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
   
      CALL afaq130_filter_show('faam001','b_faam001')
   CALL afaq130_filter_show('faam002','b_faam002')
   CALL afaq130_filter_show('faam000','b_faam000')
   CALL afaq130_filter_show('faah006','b_faah006')
   CALL afaq130_filter_show('faam009','b_faam009')
   CALL afaq130_filter_show('faam014','b_faam014')
   CALL afaq130_filter_show('faam003','b_faam003')
   CALL afaq130_filter_show('faam007','b_faam007')
   CALL afaq130_filter_show('faam010','b_faam010')
   CALL afaq130_filter_show('faam017','b_faam017')
   CALL afaq130_filter_show('faam015','b_faam015')
   CALL afaq130_filter_show('faam013','b_faam013')
   CALL afaq130_filter_show('faam016','b_faam016')
   CALL afaq130_filter_show('faam022','b_faam022')
   CALL afaq130_filter_show('faam103','b_faam103')
   CALL afaq130_filter_show('faam105','b_faam105')
   CALL afaq130_filter_show('faam104','b_faam104')
   CALL afaq130_filter_show('faam153','b_faam153')
   CALL afaq130_filter_show('faam155','b_faam155')
   CALL afaq130_filter_show('faam154','b_faam154')
 
    
   CALL afaq130_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="afaq130.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afaq130_filter_parser(ps_field)
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
 
{<section id="afaq130.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afaq130_filter_show(ps_field,ps_object)
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
   LET ls_condition = afaq130_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afaq130.insert" >}
#+ insert
PRIVATE FUNCTION afaq130_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afaq130.modify" >}
#+ modify
PRIVATE FUNCTION afaq130_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afaq130.reproduce" >}
#+ reproduce
PRIVATE FUNCTION afaq130_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afaq130.delete" >}
#+ delete
PRIVATE FUNCTION afaq130_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afaq130.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION afaq130_detail_action_trans()
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
 
{<section id="afaq130.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION afaq130_detail_index_setting()
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
            IF g_faam_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_faam_d.getLength() AND g_faam_d.getLength() > 0
            LET g_detail_idx = g_faam_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_faam_d.getLength() THEN
               LET g_detail_idx = g_faam_d.getLength()
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
 
{<section id="afaq130.mask_functions" >}
 &include "erp/afa/afaq130_mask.4gl"
 
{</section>}
 
{<section id="afaq130.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq130_faamld_ref()
  LET tm.faamld_desc = ''
  SELECT glaal002 INTO tm.faamld_desc FROM glaal_t
   WHERE glaalent = g_enterprise AND glaalld = tm.faamld
     AND glaal001 = g_dlang
#20141117     
#  SELECT glaacomp,glaa001,glaa016,glaa020,glaa015,glaa019 
#    INTO tm.faamcomp,tm.curr1,tm.curr2,tm.curr3,g_glaa015,g_glaa019 
#    FROM glaa_t
  LET tm.curr1 ='' 
  LET tm.curr2 ='' 
  LET tm.curr3 ='' 
  LET g_glaa015 ='' 
  LET g_glaa019 ='' 
  LET tm.faamcomp =''
  SELECT glaa001,glaa016,glaa020,glaa015,glaa019,glaacomp
    INTO tm.curr1,tm.curr2,tm.curr3,g_glaa015,g_glaa019,tm.faamcomp
    FROM glaa_t 
#20141117    
   WHERE glaaent = g_enterprise AND glaald = tm.faamld
  LET tm.faamcomp_desc = ''
  SELECT ooefl003 INTO tm.faamcomp_desc FROM ooefl_t
   WHERE ooeflent = g_enterprise AND ooefl001 = tm.faamcomp
     AND ooefl002 = g_dlang   
  DISPLAY tm.faamcomp,tm.faamcomp_desc,tm.curr1,tm.curr2,tm.curr3
       TO b_faamcomp,b_faamcomp_desc,b_curr1,b_curr2,b_curr3
  DISPLAY tm.faamld_desc TO b_faamld_desc
END FUNCTION

################################################################################
# Descriptions...: 設置其他本位幣頁簽的顯示
# Memo...........:
# Usage..........: afaq130_set_curr()
################################################################################
PRIVATE FUNCTION afaq130_set_curr()
  IF g_glaa015 = 'Y' THEN
     CALL cl_set_comp_visible("page_3",TRUE)
  ELSE
     CALL cl_set_comp_visible("page_3",FALSE)
  END IF
  IF g_glaa019 = 'Y' THEN
     CALL cl_set_comp_visible("page_4",TRUE)
  ELSE
     CALL cl_set_comp_visible("page_4",FALSE)
  END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq130_site_desc()
   LET tm.site_desc = ''
   SELECT ooefl003 INTO tm.site_desc FROM ooefl_t
    WHERE ooeflent = g_enterprise AND ooefl001 = tm.site
      AND ooefl002 = g_dlang  
   DISPLAY tm.site_desc TO b_site_desc
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afaq130_change_to_sql(p_wc)
# Input parameter:  
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq130_change_to_sql(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF
   END WHILE
   LET r_wc = "'",l_str,"'"

   RETURN r_wc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq130_fetch1(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   
#   CALL cl_set_comp_visible('sel',FALSE)
#   CASE p_flag
#      WHEN 'F' LET g_current_idx = 1
#      WHEN 'L' LET g_current_idx = g_header_cnt        
#      WHEN 'P'
#         IF g_current_idx > 1 THEN               
#            LET g_current_idx = g_current_idx - 1
#         END IF 
#      WHEN 'N'
#         IF g_current_idx < g_header_cnt THEN
#            LET g_current_idx =  g_current_idx + 1
#         END IF        
#      WHEN '/'
#         IF (NOT g_no_ask) THEN    
#            CALL cl_set_act_visible("accept,cancel", TRUE)    
#            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
#            LET INT_FLAG = 0
# 
#            PROMPT ls_msg CLIPPED,': ' FOR g_jump
#               #交談指令共用ACTION
#               &include "common_action.4gl" 
#            END PROMPT
# 
#            CALL cl_set_act_visible("accept,cancel", FALSE)    
#            IF INT_FLAG THEN
#               LET INT_FLAG = 0
#               EXIT CASE  
#            END IF
#            
#         END IF
#         
#         IF g_jump > 0 AND g_jump <= g_nmde_s.getLength() THEN
#            LET g_current_idx = g_jump
#         END IF
# 
#         LET g_no_ask = FALSE  
#   END CASE    
#   
#   #代表沒有資料
#   IF g_current_idx = 0 OR g_nmde_s.getLength() = 0 THEN
#      RETURN
#   END IF
#   
#   #超出範圍
#   IF g_current_idx > g_nmde_s.getLength() THEN
#      LET g_current_idx = g_nmde_s.getLength()
#   END IF
#   
#   DISPLAY g_current_idx TO FORMONLY.h_index
#   CALL afaq130_faamld_ref()
#   CALL afaq130_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 设置分页
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq130_set_page()
#   DEFINE l_sql    STRING
#   DEFINE l_idx    LIKE type_t.num5
#   DEFINE ls_wc           STRING
#   
#    CALL g_nmde_s.clear()  
#    IF cl_null(g_wc_filter) THEN
#      LET g_wc_filter = " 1=1"
#   END IF
#   IF cl_null(g_wc) THEN
#      LET g_wc = " 1=1"
#   END IF
#   IF cl_null(g_wc2) THEN
#      LET g_wc2 = " 1=1"
#   END IF
#   IF cl_null(g_wc_table1 ) THEN
#      LET g_wc_table1  = " 1=1"
#   END IF    
#    LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter," AND ",g_wc_table1   
#    LET l_sql=" SELECT DISTINCT nmdesite,nmdeld FROM nmde_t ",
#              "  WHERE nmdeent = ",g_enterprise," AND ",ls_wc CLIPPED,
#              "    AND nmde001 = ",tm.nmde001," AND nmde002 = ",tm.nmde002,
#               " ORDER BY nmdesite,nmdeld "
#    PREPARE afaq130_sel_s_pr FROM l_sql
#    DECLARE afaq130_sel_s_cr CURSOR FOR afaq130_sel_s_pr
#    LET l_idx=1
#    FOREACH afaq130_sel_s_cr INTO g_nmde_s[l_idx].nmdesite,g_nmde_s[l_idx].nmdeld
#       IF SQLCA.sqlcode THEN
#          INITIALIZE g_errparam TO NULL
#          LET g_errparam.code = SQLCA.sqlcode
#          LET g_errparam.extend = 'FOREACH afaq130_sel_s_cr'
#          LET g_errparam.popup = FALSE
#          CALL cl_err()
#
#          EXIT FOREACH
#       END IF
#       LET l_idx=l_idx+1
#       IF l_idx > g_max_rec THEN
#          INITIALIZE g_errparam TO NULL
#          LET g_errparam.code = 9035
#          LET g_errparam.extend = ''
#          LET g_errparam.popup = FALSE
#          CALL cl_err()
#
#          EXIT FOREACH
#       END IF
#    END FOREACH
#    LET l_idx=l_idx - 1
#    CALL g_nmde_s.deleteElement(g_nmde_s.getLength())
#    LET g_header_cnt = g_nmde_s.getLength()
#    LET g_rec_b = l_idx
#   DISPLAY g_header_cnt TO FORMONLY.h_count
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL afaq130_get_glaa()
# Input parameter:  
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq130_get_glaa()
   SELECT glaa001,glaa004,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaacomp
     INTO g_glaa001,g_glaa004,g_glaa015,g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,g_glaa021,g_glaa022,g_glaacomp
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = tm.faamld
   CALL cl_set_comp_visible('page_3,page_4',TRUE)

   IF NOT cl_null(tm.faamld) THEN  
      IF g_glaa015 = 'Y' THEN
         CALL cl_set_comp_visible('page_3',TRUE)
      ELSE
         CALL cl_set_comp_visible('page_3',FALSE)
      END IF
      IF g_glaa019 = 'Y' THEN
         CALL cl_set_comp_visible('page_4',TRUE)
      ELSE
         CALL cl_set_comp_visible('page_4',FALSE)
      END IF
   END IF      
END FUNCTION

################################################################################
# Descriptions...: 检查折旧年月是否已经产生
# Memo...........:
# Usage..........: CALL afaq130_afat509_chk()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq130_afat509_chk()
   DEFINE l_n      LIKE type_t.num5
   DEFINE l_first  LIKE fabg_t.fabgdocdt
   DEFINE l_last   LIKE fabg_t.fabgdocdt
   
   #获取当前月第一天
   SELECT to_date(tm.faam004||tm.faam005,'yyyymm') INTO l_first from dual
   #获取当前月最后一天
   CALL s_date_get_last_date(l_first) RETURNING l_last 
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM fabg_t
    WHERE fabgent = g_enterprise
      AND fabgld = tm.faamld
      AND fabgsite = tm.site
      AND fabg005 = '0'
      AND fabgdocdt BETWEEN l_first AND l_last
   IF l_n > 0 THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ""
      LET g_errparam.code   = "afa-00453"
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF 
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 产生折旧资料
# Memo...........:
# Usage..........: CALL afaq130_ins_fabh()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq130_ins_fabh()
   DEFINE i     LIKE type_t.num5
   DEFINE l_n   LIKE type_t.num5
   #DEFINE l_fabh     RECORD LIKE fabh_t.* #mark by geza 20161123 #161111-00028#6 
   DEFINE l_glaacomp LIKE glaa_t.glaacomp  
   DEFINE l_faaj003  LIKE faaj_t.faaj003
   DEFINE l_faaj012  LIKE faaj_t.faaj012
   DEFINE l_faaj013  LIKE faaj_t.faaj013
   DEFINE l_faah006  LIKE faah_t.faah006
   DEFINE l_faac016  LIKE faac_t.faac016
   DEFINE l_str      STRING 
   DEFINE l_fabh000   LIKE fabh_t.fabh000
   DEFINE l_fabh001   LIKE fabh_t.fabh001
   DEFINE l_fabh002   LIKE fabh_t.fabh002
   DEFINE l_faaj006   LIKE faaj_t.faaj006
   DEFINE l_faaj007   LIKE faaj_t.faaj007
   DEFINE l_faaj025   LIKE faaj_t.faaj025
   DEFINE l_para_data STRING
   DEFINE l_glaa001   LIKE glaa_t.glaa001
   DEFINE l_glaa024   LIKE glaa_t.glaa024   
   DEFINE l_fabg005   LIKE fabg_t.fabg005   
   #DEFINE l_fabg      RECORD LIKE fabg_t.* #mark by geza 20161123 #161111-00028#6
   #add by geza 20161123 #161111-00028#6(S)
   DEFINE l_fabh RECORD  #資產異動單身檔
       fabhent LIKE fabh_t.fabhent, #企业编号
       fabhld LIKE fabh_t.fabhld, #账套
       fabhsite LIKE fabh_t.fabhsite, #营运据点
       fabhdocno LIKE fabh_t.fabhdocno, #异动单号
       fabhseq LIKE fabh_t.fabhseq, #项次
       fabh000 LIKE fabh_t.fabh000, #卡片编号
       fabh001 LIKE fabh_t.fabh001, #财产编号
       fabh002 LIKE fabh_t.fabh002, #附号
       fabh003 LIKE fabh_t.fabh003, #资产状态
       fabh004 LIKE fabh_t.fabh004, #未折减余额
       fabh005 LIKE fabh_t.fabh005, #单位
       fabh006 LIKE fabh_t.fabh006, #数量
       fabh007 LIKE fabh_t.fabh007, #处置数量
       fabh008 LIKE fabh_t.fabh008, #成本
       fabh009 LIKE fabh_t.fabh009, #累计调整成本
       fabh010 LIKE fabh_t.fabh010, #调整成本/公允价值
       fabh011 LIKE fabh_t.fabh011, #累折
       fabh012 LIKE fabh_t.fabh012, #重估累计折旧
       fabh013 LIKE fabh_t.fabh013, #未用年限
       fabh014 LIKE fabh_t.fabh014, #重估未用年限
       fabh015 LIKE fabh_t.fabh015, #预留残值
       fabh016 LIKE fabh_t.fabh016, #重估预留残值
       fabh017 LIKE fabh_t.fabh017, #已计提减值准备
       fabh018 LIKE fabh_t.fabh018, #异动
       fabh019 LIKE fabh_t.fabh019, #减值准备金额
       fabh020 LIKE fabh_t.fabh020, #异动原因
       fabh021 LIKE fabh_t.fabh021, #异动科目
       fabh022 LIKE fabh_t.fabh022, #调整成本
       fabh023 LIKE fabh_t.fabh023, #累计折旧科目
       fabh024 LIKE fabh_t.fabh024, #资产科目
       fabh025 LIKE fabh_t.fabh025, #减值准备科目
       fabh026 LIKE fabh_t.fabh026, #营运据点
       fabh027 LIKE fabh_t.fabh027, #部门
       fabh028 LIKE fabh_t.fabh028, #利润/成本中心
       fabh029 LIKE fabh_t.fabh029, #区域
       fabh030 LIKE fabh_t.fabh030, #交易客商
       fabh031 LIKE fabh_t.fabh031, #账款客商
       fabh032 LIKE fabh_t.fabh032, #客群
       fabh033 LIKE fabh_t.fabh033, #人员
       fabh034 LIKE fabh_t.fabh034, #项目编号
       fabh035 LIKE fabh_t.fabh035, #WBS
       fabh036 LIKE fabh_t.fabh036, #摘要
       fabh037 LIKE fabh_t.fabh037, #来源编号
       fabh038 LIKE fabh_t.fabh038, #来源项次
       fabh039 LIKE fabh_t.fabh039, #盘点编号
       fabh040 LIKE fabh_t.fabh040, #盘点序号
       fabh041 LIKE fabh_t.fabh041, #经营方式
       fabh042 LIKE fabh_t.fabh042, #渠道
       fabh043 LIKE fabh_t.fabh043, #品牌
       fabh060 LIKE fabh_t.fabh060, #自由核算项一
       fabh061 LIKE fabh_t.fabh061, #自由核算项二
       fabh062 LIKE fabh_t.fabh062, #自由核算项三
       fabh063 LIKE fabh_t.fabh063, #自由核算项四
       fabh064 LIKE fabh_t.fabh064, #自由核算项五
       fabh065 LIKE fabh_t.fabh065, #自由核算项六
       fabh066 LIKE fabh_t.fabh066, #自由核算项七
       fabh067 LIKE fabh_t.fabh067, #自由核算项八
       fabh068 LIKE fabh_t.fabh068, #自由核算项九
       fabh069 LIKE fabh_t.fabh069, #自由核算项十
       fabh100 LIKE fabh_t.fabh100, #本位币二币种
       fabh101 LIKE fabh_t.fabh101, #本位币二汇率
       fabh102 LIKE fabh_t.fabh102, #本位币二成本
       fabh103 LIKE fabh_t.fabh103, #本位币二调整成本
       fabh104 LIKE fabh_t.fabh104, #本位币二累折
       fabh105 LIKE fabh_t.fabh105, #本位币二重估累折
       fabh106 LIKE fabh_t.fabh106, #本位币二预留残值
       fabh107 LIKE fabh_t.fabh107, #本位币二重估残值
       fabh108 LIKE fabh_t.fabh108, #本位币二未折减额
       fabh109 LIKE fabh_t.fabh109, #本位币二已计提减值准备
       fabh110 LIKE fabh_t.fabh110, #本位币二减值准备金额
       fabh150 LIKE fabh_t.fabh150, #本位币三币种
       fabh151 LIKE fabh_t.fabh151, #本位币三汇率
       fabh152 LIKE fabh_t.fabh152, #本位币三成本
       fabh153 LIKE fabh_t.fabh153, #本位币三调整成本
       fabh154 LIKE fabh_t.fabh154, #本位币三累折
       fabh155 LIKE fabh_t.fabh155, #本位币三重估累折
       fabh156 LIKE fabh_t.fabh156, #本位币三预留残值
       fabh157 LIKE fabh_t.fabh157, #本位币三重估残值
       fabh158 LIKE fabh_t.fabh158, #本位币三未折减额
       fabh159 LIKE fabh_t.fabh159, #本位币三已计提减值准备
       fabh160 LIKE fabh_t.fabh160, #本位币三减值准备金额
       fabh070 LIKE fabh_t.fabh070, #累计折旧科目(旧)
       fabh071 LIKE fabh_t.fabh071, #资产科目(旧)
       fabh072 LIKE fabh_t.fabh072, #减值准备科目(旧)
       fabh073 LIKE fabh_t.fabh073, #处置本年累折
       fabh111 LIKE fabh_t.fabh111, #本位币二处置本年累折
       fabh161 LIKE fabh_t.fabh161, #本位币三处置本年累折
       fabh074 LIKE fabh_t.fabh074, #保险费用科目
       fabh075 LIKE fabh_t.fabh075, #主要类别
       fabh076 LIKE fabh_t.fabh076  #主要类别新
   END RECORD
   DEFINE l_fabg RECORD  #資產異動單頭檔(一帳套)
       fabgent LIKE fabg_t.fabgent, #企業編號
       fabgcomp LIKE fabg_t.fabgcomp, #法人
       fabgld LIKE fabg_t.fabgld, #帳套
       fabgdocno LIKE fabg_t.fabgdocno, #來源單號
       fabgdocdt LIKE fabg_t.fabgdocdt, #單據日期
       fabgsite LIKE fabg_t.fabgsite, #資產中心
       fabg001 LIKE fabg_t.fabg001, #帳務人員
       fabg002 LIKE fabg_t.fabg002, #申請人員
       fabg003 LIKE fabg_t.fabg003, #申請部門
       fabg004 LIKE fabg_t.fabg004, #申請日期
       fabg005 LIKE fabg_t.fabg005, #異動類型
       fabg006 LIKE fabg_t.fabg006, #帳款客戶
       fabg007 LIKE fabg_t.fabg007, #收款客戶
       fabg008 LIKE fabg_t.fabg008, #傳票號碼
       fabg009 LIKE fabg_t.fabg009, #傳票日期
       fabg010 LIKE fabg_t.fabg010, #所有組織
       fabg011 LIKE fabg_t.fabg011, #產生應收帳款編號
       fabg012 LIKE fabg_t.fabg012, #產生應付帳款編號
       fabg013 LIKE fabg_t.fabg013, #稅別
       fabg014 LIKE fabg_t.fabg014, #稅率
       fabg015 LIKE fabg_t.fabg015, #幣別
       fabg016 LIKE fabg_t.fabg016, #匯率
       fabg017 LIKE fabg_t.fabg017, #調撥流水碼
       fabg018 LIKE fabg_t.fabg018, #核算組織
       fabg019 LIKE fabg_t.fabg019, #來源單號
       fabgstus LIKE fabg_t.fabgstus, #狀態碼
       fabgownid LIKE fabg_t.fabgownid, #資料所有者
       fabgowndp LIKE fabg_t.fabgowndp, #資料所屬部門
       fabgcrtid LIKE fabg_t.fabgcrtid, #資料建立者
       fabgcrtdp LIKE fabg_t.fabgcrtdp, #資料建立部門
       fabgcrtdt LIKE fabg_t.fabgcrtdt, #資料創建日
       fabgmodid LIKE fabg_t.fabgmodid, #資料修改者
       fabgmoddt LIKE fabg_t.fabgmoddt, #最近修改日
       fabgcnfid LIKE fabg_t.fabgcnfid, #資料確認者
       fabgcnfdt LIKE fabg_t.fabgcnfdt, #資料確認日
       fabgpstid LIKE fabg_t.fabgpstid, #資料過帳者
       fabgpstdt LIKE fabg_t.fabgpstdt, #資料過帳日
       fabg020 LIKE fabg_t.fabg020  #資產性質
   END RECORD
   #add by geza 20161123 #161111-00028#6(E)
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_glaa121   LIKE glaa_t.glaa121
   DEFINE l_ooba002  LIKE ooba_t.ooba002
   DEFINE l_slip     LIKE type_t.chr20
   DEFINE l_ooac004  LIKE ooac_t.ooac004 
   
   WHENEVER ERROR CONTINUE
   INITIALIZE l_fabg TO NULL 
   CALL s_transaction_begin()
   #新增单头fabg段
   SELECT glaa001,glaa024 INTO l_glaa001,l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = tm.faamld
   LET l_fabg.fabgownid = g_user
   LET l_fabg.fabgowndp = g_dept
   LET l_fabg.fabgcrtid = g_user
   LET l_fabg.fabgcrtdp = g_dept 
   LET l_fabg.fabgcrtdt = cl_get_current()
   LET l_fabg.fabgmodid = g_user
   LET l_fabg.fabgmoddt = cl_get_current()
   LET l_fabg.fabgent = g_enterprise
   LET l_fabg.fabgstus = 'N'
   LET l_fabg.fabg005 = "0"
   SELECT to_date(tm.faam004||tm.faam005,'yyyymm') INTO l_fabg.fabgdocdt FROM dual
   LET l_fabg.fabg001 = g_user
   LET l_fabg.fabg002 = g_user
   LET l_fabg.fabg003 = g_dept 
   LET l_fabg.fabg004 = g_today
   LET l_fabg.fabg015 = l_glaa001
   LET l_fabg.fabg016 = 1
   LET l_fabg.fabgsite = tm.site
   LET l_fabg.fabgld = tm.faamld
   #获取默认单别
   SELECT DISTINCT ooba002 INTO l_fabg.fabgdocno
     FROM ooba_t 
    WHERE oobaent = g_enterprise 
      AND ooba002  IN (SELECT oobl001 FROM oobl_t WHERE  ooblent = g_enterprise  AND oobl002 = 'afat509' ) 
      AND oobastus = 'Y' 
      AND ooba001  = l_glaa024
    ORDER BY ooba002
    
   CALL s_aooi200_fin_gen_docno(tm.faamld,'','',l_fabg.fabgdocno,l_fabg.fabgdocdt,'afat509')
   RETURNING l_success,l_fabg.fabgdocno
   IF l_success  = 0  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = l_fabg.fabgdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   INSERT INTO fabg_t (fabgent,fabgsite,fabg001,fabgld,fabgcomp,fabg002,fabg003,fabg004, 
                   fabgdocno,fabgdocdt,fabg005,fabg008,fabg009,fabg015,fabg016,
                   fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,
                   fabgcrtdt,fabgmodid,fabgmoddt,fabgcnfid,fabgcnfdt,
                   fabgpstid,fabgpstdt) 

    VALUES (g_enterprise,l_fabg.fabgsite,l_fabg.fabg001,l_fabg.fabgld,l_fabg.fabgcomp,l_fabg.fabg002,l_fabg.fabg003,l_fabg.fabg004,
            l_fabg.fabgdocno,l_fabg.fabgdocdt,l_fabg.fabg005,l_fabg.fabg008,l_fabg.fabg009,l_fabg.fabg015,l_fabg.fabg016, 
            l_fabg.fabgstus,l_fabg.fabgownid,l_fabg.fabgowndp,l_fabg.fabgcrtid,l_fabg.fabgcrtdp, 
            l_fabg.fabgcrtdt,l_fabg.fabgmodid,l_fabg.fabgmoddt,l_fabg.fabgcnfid,l_fabg.fabgcnfdt, 
            l_fabg.fabgpstid,l_fabg.fabgpstdt) 
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "l_fabg" 
       LET g_errparam.code   = SQLCA.sqlcode 
       LET g_errparam.popup  = TRUE 
       CALL cl_err()
       CALL s_transaction_end('N','0')
       RETURN
    END IF
   #新增单身段
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM faam_t 
    WHERE faament = g_enterprise 
      AND faamld = tm.faamld 
      AND faam004 = tm.faam004
      AND faam005 = tm.faam005
      AND faam024 IS NOT NULL
   
   SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = tm.faamld 
   LET g_sql = "SELECT  UNIQUE faam001,faam002,faam000,faah015,faam014,faah017,faah018,faam013,faam015,faah006,faam018,faam021, ",          
               "               faam020,faam023,faam028,faam029,faam030,faam031,faam032,faam033,faam034,faam035,faam036,",
               "               faam101,faam102,faam103,faam104,faam105,faam108,",
               "               faam151,faam152,faam153,faam154,faam155,faam158,faam009 ",
               "  FROM faam_t,faah_t",
               " WHERE faahent = faament AND faah003 = faam001 AND faah004 = faam002 ",
               "   AND faah001 = faam000 AND faament= '",g_enterprise,"'",
               "   AND faamld = '",tm.faamld,"' AND faah000 = faaj000 ",  #150908-00002#3 add faah000
               "   AND faam004 = '",tm.faam004,"'",
               "   AND faam005 = '",tm.faam005,"'",
               "   AND (faam007 = '1' OR faam007 = '3')" ,              
               "   AND faah032 = '",l_glaacomp,"'",
               "   AND faam000 = ? ",
               "   AND faam001 = ? ",
               "   AND faam002 = ? "
   IF l_n > 0 THEN
      LET g_sql = g_sql CLIPPED," AND faam024 is not null"
   ELSE
      LET g_sql = g_sql CLIPPED
   END IF
   PREPARE sel_faam FROM g_sql
   FOR i =1 TO g_faam_d.getLength()
       INITIALIZE l_fabh TO NULL 
       EXECUTE  sel_faam USING g_faam_d[i].faam000,g_faam_d[i].faam001,g_faam_d[i].faam002
                    INTO l_fabh.fabh001,l_fabh.fabh002,l_fabh.fabh000,l_fabh.fabh003,
                         l_fabh.fabh008,l_fabh.fabh005,l_fabh.fabh006,l_fabh.fabh010,
                         l_fabh.fabh011,l_faah006,l_fabh.fabh017,l_fabh.fabh023,l_fabh.fabh024,l_fabh.fabh025,
                         l_fabh.fabh027,l_fabh.fabh028,l_fabh.fabh029,l_fabh.fabh030,
                         l_fabh.fabh031,l_fabh.fabh032,l_fabh.fabh033,l_fabh.fabh034,l_fabh.fabh035,
                         l_fabh.fabh100,l_fabh.fabh101,l_fabh.fabh102,l_fabh.fabh104,l_fabh.fabh105,l_fabh.fabh108,
                         l_fabh.fabh150,l_fabh.fabh151,l_fabh.fabh152,l_fabh.fabh154,l_fabh.fabh155,l_fabh.fabh158,
                         l_fabh.fabh027
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'sel_faam:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN 
      END IF
      LET l_fabh.fabhseq = i
      LET l_fabh.fabhent = g_enterprise
      LET l_fabh.fabhld = tm.faamld
      LET l_fabh.fabhsite = tm.site
      LET l_fabh.fabhdocno = l_fabg.fabgdocno
      LET l_fabh.fabh009 = 0
      LET l_fabh.fabh004 = l_fabh.fabh008 - l_fabh.fabh011
      LET l_fabh.fabh007 = 0
      LET l_fabh.fabh012 = l_fabh.fabh011
      LET l_fabh.fabh013 = NULL
      LET l_fabh.fabh014 = NULL
      LET l_fabh.fabh016 = l_fabh.fabh015
      LET l_fabh.fabh018 = NULL
      LET l_fabh.fabh019 = 0
      LET l_str = cl_getmsg_parm("afa-00421", g_lang, tm.faam004 || "|" || tm.faam005)
      LET l_fabh.fabh036 = l_str.trim()
      IF l_fabh.fabh003='7' THEN
         SELECT faaj012,faan013 INTO l_faaj012,l_faaj013
           FROM faaj_t
          WHERE faajent = g_enterprise
            AND faajld = tm.faamld
            AND faaj001 = g_faam_d[i].faam001
            AND faaj002 = g_faam_d[i].faam002
            AND faaj037 = g_faam_d[i].faam000
         LET l_fabh.fabh013 = l_faaj012
         LET l_fabh.fabh015 = l_faaj013
      END IF
      IF cl_null(l_fabh.fabh017) THEN 
         LET l_fabh.fabh017 = 0
      END IF 
      SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = tm.faamld
      #资产：抓faaj007;部门：抓afai050
      LET l_para_data = NULL
      CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9009') RETURNING l_para_data 
      LET l_faaj006 = NULL
      LET l_faaj007 = NULL
      LET l_faah006 = NULL                  
      SELECT faaj006,faaj007,faaj025,faah006
        INTO l_faaj006,l_faaj007,l_faaj025,l_faah006
        FROM faah_t,faaj_t  
       WHERE faaj001 =faah003 AND faah000 = faaj000 #150908-00002#3 add faah000
         AND faaj002 =faah004
         AND faaj037 =faah001
         AND faajent =faahent
         AND faahent =g_enterprise 
         AND faajld=tm.faamld
         AND faaj001=l_fabh.fabh001
         AND faaj002=l_fabh.fabh002
         AND faaj037=l_fabh.fabh000
      
      IF l_faaj006 = '1' THEN #单一部门 
         IF l_para_data = '2' THEN 
            #资产
            LET l_fabh.fabh021 = l_faaj025
         ELSE
            #部门
            SELECT faae003 
              INTO l_fabh.fabh021
              FROM faae_t
             WHERE faaeent = g_enterprise AND faaeld = tm.faamld
               AND faae001 = l_faaj007 AND faae002 = l_faah006 
         END IF
      END IF     
        
      SELECT faajsite INTO l_fabh.fabh026
        FROM faaj_t
       WHERE faajent=g_enterprise
         AND faaj001 = l_fabh.fabh001
         AND faaj002 = l_fabh.fabh002
         AND faaj037 = l_fabh.fabh000
         AND faajld = tm.faamld          
      
      #INSERT INTO fabh_t VALUES(l_fabh.*) #mark by geza 20161123 #161111-00028#6 
      INSERT INTO fabh_t (fabhent,fabhld,fabhsite,fabhdocno,fabhseq,
                          fabh000,fabh001,fabh002,fabh003,fabh004,
                          fabh005,fabh006,fabh007,fabh008,fabh009,
                          fabh010,fabh011,fabh012,fabh013,fabh014,
                          fabh015,fabh016,fabh017,fabh018,fabh019,
                          fabh020,fabh021,fabh022,fabh023,fabh024,
                          fabh025,fabh026,fabh027,fabh028,fabh029,
                          fabh030,fabh031,fabh032,fabh033,fabh034,
                          fabh035,fabh036,fabh037,fabh038,fabh039,
                          fabh040,fabh041,fabh042,fabh043,fabh060,
                          fabh061,fabh062,fabh063,fabh064,fabh065,
                          fabh066,fabh067,fabh068,fabh069,fabh100,
                          fabh101,fabh102,fabh103,fabh104,fabh105,
                          fabh106,fabh107,fabh108,fabh109,fabh110,
                          fabh150,fabh151,fabh152,fabh153,fabh154,
                          fabh155,fabh156,fabh157,fabh158,fabh159,
                          fabh160,fabh070,fabh071,fabh072,fabh073,
                          fabh111,fabh161,fabh074,fabh075,fabh076) 
                   VALUES(l_fabh.fabhent,l_fabh.fabhld,l_fabh.fabhsite,l_fabh.fabhdocno,l_fabh.fabhseq,
                          l_fabh.fabh000,l_fabh.fabh001,l_fabh.fabh002,l_fabh.fabh003,l_fabh.fabh004,
                          l_fabh.fabh005,l_fabh.fabh006,l_fabh.fabh007,l_fabh.fabh008,l_fabh.fabh009,
                          l_fabh.fabh010,l_fabh.fabh011,l_fabh.fabh012,l_fabh.fabh013,l_fabh.fabh014,
                          l_fabh.fabh015,l_fabh.fabh016,l_fabh.fabh017,l_fabh.fabh018,l_fabh.fabh019,
                          l_fabh.fabh020,l_fabh.fabh021,l_fabh.fabh022,l_fabh.fabh023,l_fabh.fabh024,
                          l_fabh.fabh025,l_fabh.fabh026,l_fabh.fabh027,l_fabh.fabh028,l_fabh.fabh029,
                          l_fabh.fabh030,l_fabh.fabh031,l_fabh.fabh032,l_fabh.fabh033,l_fabh.fabh034,
                          l_fabh.fabh035,l_fabh.fabh036,l_fabh.fabh037,l_fabh.fabh038,l_fabh.fabh039,
                          l_fabh.fabh040,l_fabh.fabh041,l_fabh.fabh042,l_fabh.fabh043,l_fabh.fabh060,
                          l_fabh.fabh061,l_fabh.fabh062,l_fabh.fabh063,l_fabh.fabh064,l_fabh.fabh065,
                          l_fabh.fabh066,l_fabh.fabh067,l_fabh.fabh068,l_fabh.fabh069,l_fabh.fabh100,
                          l_fabh.fabh101,l_fabh.fabh102,l_fabh.fabh103,l_fabh.fabh104,l_fabh.fabh105,
                          l_fabh.fabh106,l_fabh.fabh107,l_fabh.fabh108,l_fabh.fabh109,l_fabh.fabh110,
                          l_fabh.fabh150,l_fabh.fabh151,l_fabh.fabh152,l_fabh.fabh153,l_fabh.fabh154,
                          l_fabh.fabh155,l_fabh.fabh156,l_fabh.fabh157,l_fabh.fabh158,l_fabh.fabh159,
                          l_fabh.fabh160,l_fabh.fabh070,l_fabh.fabh071,l_fabh.fabh072,l_fabh.fabh073,
                          l_fabh.fabh111,l_fabh.fabh161,l_fabh.fabh074,l_fabh.fabh075,l_fabh.fabh076) #mark by geza 20161123 #161111-00028#6 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabh_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END FOR 
   CALL s_transaction_end('Y','0')
   INITIALIZE g_errparam TO NULL 
   LET g_errparam.extend = "" 
   LET g_errparam.code   = 'adz-00217'
   LET g_errparam.popup  = TRUE 
   CALL cl_err()
   
   #150731-00006 1 add by yangtt
   IF NOT cl_null(l_fabg.fabgdocno) AND l_fabg.fabgstus = 'N' THEN
      #获取单别
      CALL s_aooi200_get_slip(l_fabg.fabgdocno) RETURNING l_success,l_slip
    
      #是否抛傳票
      SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = l_fabg.fabgld  
      CALL s_fin_get_doc_para(l_fabg.fabgld,l_fabg.fabgcomp,l_slip,'D-FIN-0030') RETURNING l_ooac004
    
      IF l_ooac004 = 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_slip
         LET g_errparam.code   = 'axr-00225'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN
      END IF
    
      IF l_glaa121 = 'Y' THEN
         CALL s_transaction_begin()
         CALL s_pre_voucher_ins('FA','F30',l_fabg.fabgld,l_fabg.fabgdocno,l_fabg.fabgdocdt,'0')
            RETURNING l_success
         IF l_success THEN
            CALL s_transaction_end('Y','0')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
      END IF
   END IF               
   #150731-00006 1 add by yangtt

END FUNCTION
################################################################################
# Descriptions...: 建立TMP TABLE供Q轉XG用
# Memo...........: #150908-00002#3
#
# Date & Author..: 151005 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq130_x01_tmp()
DROP TABLE afaq130_x01_tmp;
CREATE TEMP TABLE afaq130_x01_tmp(
   faam001         VARCHAR(20), 
   faam002         VARCHAR(20), 
   faam000         VARCHAR(10), 
   faah006         VARCHAR(10), 
   faah006_desc    VARCHAR(500), 
   faah007         VARCHAR(500), 
   faah007_desc    VARCHAR(500), 
   faam009         VARCHAR(10), 
   faam009_desc    VARCHAR(500), 
   faah028         VARCHAR(500), 
   faah028_desc    VARCHAR(500), 
   faah005         VARCHAR(500), 
   faah042         VARCHAR(500), 
   faah008         VARCHAR(500), 
   faah008_desc    VARCHAR(500), 
   faah018         VARCHAR(500), 
   faam014         DECIMAL(20,6), 
   faam003         VARCHAR(500),
   faaj019         DECIMAL(20,6), 
   faam007         VARCHAR(500), 
   faam010         VARCHAR(10), 
   faam010_desc    VARCHAR(500), 
   faam017         DECIMAL(20,6), 
   faam015         DECIMAL(20,6), 
   faam013         DECIMAL(20,6), 
   faah043         VARCHAR(500), 
   faam024         VARCHAR(20), 
   l_faaj008       VARCHAR(10), 
   l_faah012       VARCHAR(500), 
   faam016         DECIMAL(20,6), 
   l_faam014_015   DECIMAL(20,6), 
   l_faaj004       INTEGER,      #151105-00001#1 add
   faam022         VARCHAR(24), 
   l_faam022_desc  VARCHAR(500),
   faamsite        VARCHAR(500),
   l_faamsite      VARCHAR(500),   
   faamld          VARCHAR(500), 
   l_faamld        VARCHAR(500), 
   faamcomp        VARCHAR(500), 
   l_faamcomp      VARCHAR(500),
   faam011         VARCHAR(10), 
   faam004         SMALLINT, 
   faam005         SMALLINT,    
   faament         SMALLINT)
   
END FUNCTION
################################################################################
# Descriptions...: 透過RECORD把資料放入TEMP TABLE
# Memo...........: #150908-00002#3
#
# Date & Author..: 151003 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq130_ins_tmp()
DEFINE l_i like type_t.num10
DEFINE l_faah005_desc LIKE type_t.chr500    #取得faah005的說明文字
DEFINE l_faah042_desc LIKE type_t.chr500    #取得faah042的說明文字
DEFINE l_faam007_desc LIKE type_t.chr500    #取得faam007的說明文字
DEFINE l_faam003_desc LIKE type_t.chr500    #取得faam003的說明文字
DEFINE l_x01_tmp  RECORD
   faam001        LIKE faam_t.faam001, 
   faam002        LIKE faam_t.faam002, 
   faam000        LIKE faam_t.faam000, 
   faah006        LIKE faah_t.faah006, 
   faah006_desc   LIKE type_t.chr500, 
   faah007        LIKE type_t.chr500, 
   faah007_desc   LIKE type_t.chr500, 
   faam009        LIKE faam_t.faam009, 
   faam009_desc   LIKE type_t.chr500, 
   faah028        LIKE type_t.chr500, 
   faah028_desc   LIKE type_t.chr500, 
   faah005        LIKE type_t.chr500, 
   faah042        LIKE type_t.chr500, 
   faah008        LIKE type_t.chr500, 
   faah008_desc   LIKE type_t.chr500, 
   faah018        LIKE type_t.chr500, 
   faam014        LIKE faam_t.faam014, 
   faam003        LIKE type_t.chr500,
   faaj019        LIKE type_t.num20_6, 
   faam007        LIKE type_t.chr500,
   faam010        LIKE faam_t.faam010, 
   faam010_desc   LIKE type_t.chr500, 
   faam017        LIKE faam_t.faam017, 
   faam015        LIKE faam_t.faam015, 
   faam013        LIKE faam_t.faam013, 
   faah043        LIKE type_t.chr500, 
   faam024        LIKE type_t.chr20, 
   l_faaj008      LIKE type_t.chr10, 
   l_faah012      LIKE type_t.chr500, 
   faam016        LIKE faam_t.faam016, 
   l_faam014_015  LIKE type_t.num20_6, 
   l_faaj004      LIKE faaj_t.faaj004, #151105-00001#1 add
   faam022        LIKE faam_t.faam022, 
   l_faam022_desc LIKE type_t.chr500,
   faamsite       LIKE type_t.chr500,
   l_faamsite     LIKE type_t.chr500,   
   faamld         LIKE type_t.chr500, 
   l_faamld       LIKE type_t.chr500, 
   faamcomp       LIKE type_t.chr500, 
   l_faamcomp     LIKE type_t.chr500,     
   faam011        LIKE faam_t.faam011, 
   faam004        LIKE faam_t.faam004, 
   faam005        LIKE faam_t.faam005,
   faament        LIKE faam_t.faament
                  END RECORD
   DELETE FROM afaq130_x01_tmp
   FOR l_i = 1 TO g_faam_d.getLength()
      INITIALIZE l_x01_tmp.* TO NULL
      CALL s_desc_gzcbl004_desc('9903',g_faam_d[l_i].faah005) RETURNING l_faah005_desc
      CALL s_desc_gzcbl004_desc('9917',g_faam_d[l_i].faah042) RETURNING l_faah042_desc
      CALL s_desc_gzcbl004_desc('9912',g_faam_d[l_i].faam007) RETURNING l_faam007_desc
      CALL s_desc_gzcbl004_desc('9904',g_faam_d[l_i].faam003) RETURNING l_faam003_desc
      LET l_x01_tmp.faam001        = g_faam_d[l_i].faam001       
      LET l_x01_tmp.faam002        = g_faam_d[l_i].faam002       
      LET l_x01_tmp.faam000        = g_faam_d[l_i].faam000       
      LET l_x01_tmp.faah006        = g_faam_d[l_i].faah006       
      LET l_x01_tmp.faah006_desc   = g_faam_d[l_i].faah006_desc  
      LET l_x01_tmp.faah007        = g_faam_d[l_i].faah007       
      LET l_x01_tmp.faah007_desc   = g_faam_d[l_i].faah007_desc  
      LET l_x01_tmp.faam009        = g_faam_d[l_i].faam009       
      LET l_x01_tmp.faam009_desc   = g_faam_d[l_i].faam009_desc  
      LET l_x01_tmp.faah028        = g_faam_d[l_i].faah028       
      LET l_x01_tmp.faah028_desc   = g_faam_d[l_i].faah028_desc  
      LET l_x01_tmp.faah005        = g_faam_d[l_i].faah005,":",l_faah005_desc       
      LET l_x01_tmp.faah042        = g_faam_d[l_i].faah042,":",l_faah042_desc      
      LET l_x01_tmp.faah008        = g_faam_d[l_i].faah008       
      LET l_x01_tmp.faah008_desc   = g_faam_d[l_i].faah008_desc  
      LET l_x01_tmp.faah018        = g_faam_d[l_i].faah018       
      LET l_x01_tmp.faam014        = g_faam_d[l_i].faam014       
      LET l_x01_tmp.faam003        = g_faam_d[l_i].faam003,":",l_faam003_desc        
      LET l_x01_tmp.faaj019        = g_faam_d[l_i].faaj019       
      LET l_x01_tmp.faam007        = g_faam_d[l_i].faam007,":",l_faam007_desc        
      LET l_x01_tmp.faam010        = g_faam_d[l_i].faam010       
      LET l_x01_tmp.faam010_desc   = g_faam_d[l_i].faam010_desc  
      LET l_x01_tmp.faam017        = g_faam_d[l_i].faam017/100       
      LET l_x01_tmp.faam015        = g_faam_d[l_i].faam015       
      LET l_x01_tmp.faam013        = g_faam_d[l_i].faam013       
      LET l_x01_tmp.faah043        = g_faam_d[l_i].faah043       
      LET l_x01_tmp.faam024        = g_faam_d[l_i].faam024       
      LET l_x01_tmp.l_faaj008      = g_faam_d[l_i].l_faaj008     
      LET l_x01_tmp.l_faah012      = g_faam_d[l_i].l_faah012     
      LET l_x01_tmp.faam016        = g_faam_d[l_i].faam016       
      LET l_x01_tmp.l_faam014_015  = g_faam_d[l_i].l_faam014_015 
      LET l_x01_tmp.l_faaj004      = g_faam_d[l_i].l_faaj004  #151105-00001#1 add
      LET l_x01_tmp.faam022        = g_faam_d[l_i].faam022       
      LET l_x01_tmp.l_faam022_desc = g_faam_d[l_i].l_faam022_desc
      LET l_x01_tmp.faamsite       = tm.site
      LET l_x01_tmp.l_faamsite     = tm.site,":",tm.site_desc
      LET l_x01_tmp.faamld         = tm.faamld   
      LET l_x01_tmp.l_faamld       = tm.faamld,":",tm.faamld_desc    
      LET l_x01_tmp.faamcomp       = tm.faamcomp   
      LET l_x01_tmp.l_faamcomp     = tm.faamcomp,":",tm.faamcomp_desc
      LET l_x01_tmp.faam011        = tm.curr1
      LET l_x01_tmp.faam004        = tm.faam004   
      LET l_x01_tmp.faam005        = tm.faam005   
      LET l_x01_tmp.faament        = g_enterprise
      INSERT INTO afaq130_x01_tmp VALUES(l_x01_tmp.*)
   END FOR
END FUNCTION

 
{</section>}
 
