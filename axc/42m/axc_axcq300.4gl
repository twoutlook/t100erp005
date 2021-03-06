#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq300.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:28(2016-12-30 16:01:54), PR版次:0028(2017-02-20 14:40:37)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000117
#+ Filename...: axcq300
#+ Description: 成本計算前勾稽查詢
#+ Creator....: 01258(2014-09-11 00:00:00)
#+ Modifier...: 08992 -SD/PR- 02040
 
{</section>}
 
{<section id="axcq300.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151015-00002#1  2015/10/15  By Alberti   1.AP單的單身單身判斷 2.增加雜收單無設定單價的判斷
#160318-00025#8  2016/04/21  By 07675     將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160503-00030#3  2016/05/06  By Sarah     axcq300_b_fill2() SQL效能優化
#160530-00005#3  2016/05/30  By 03538     採購性質串 scc 2061 應用分類一, 若為Y 之性質才可顯示
#160628-00009#1  2016/06/28  By tsungyung 將金額取絕對值
#160907-00003#1  2016/09/09  By 02295     帳款檢核條件加上apca001 IN('01','02','13','17','22')
#160929-00039#1  2016/09/30  By charles4m 當 S-FIN-6013 未啟用時，不需要判斷產品特徵 (xcbb004 = inaj006)
#160802-00020#7  2016/10/06  By shiun     增加帳套權限管控、法人權限管控
#161205-00025#19 2016/12/22  By 02295     效能优化
#160913-00024#1  2016/12/30  By 08992     修改FUNCTION axcq300_b_fill2()段在單據編號(inaj001)前面多顯示作業編號(inaj035)與作業名稱(gzzal003)
#161223-00018#1  2016/01/09  By 08992     此段應為判斷成本結案日故將sfaa038(保稅核銷)改為sfaa048(成本結案日)
#170105-00011#10 2017/02/09  By 02295     效能优化 
#170207-00035#1  2017/02/13  By zhujing   同一料，即使有多產品特徵，成本階都是同一階。在axci120的產品特徵都為空的，故axcq300不用多串xcbb004的條件
#170220-00006#2  2017/02/20  By 02040     增加條件，抓取已確認之請款金額
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
PRIVATE TYPE type_g_xccc_d RECORD
       #statepic       LIKE type_t.chr1,
       
       xccc006 LIKE xccc_t.xccc006, 
   xccc007 LIKE xccc_t.xccc007, 
   xccc006_desc LIKE type_t.chr500, 
   xccc006_desc_1 LIKE type_t.chr500, 
   inaj035 LIKE inaj_t.inaj035, 
   inaj035_desc LIKE type_t.chr500, 
   docno LIKE type_t.chr20, 
   info LIKE type_t.chr500 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_tm         RECORD
                     xccccomp   LIKE xccc_t.xccccomp,  #法人組織
                     xccccomp_desc   LIKE type_t.chr500,
                     xcccld     LIKE xccc_t.xcccld  ,  #帳別編號
                     xcccld_desc     LIKE type_t.chr500,
                     xccc004    LIKE xccc_t.xccc004 ,  #年度
                     xccc005    LIKE xccc_t.xccc005 ,  #期別
                     xccc001    LIKE xccc_t.xccc001 ,  #本位币顺序
                     xccc001_desc    LIKE type_t.chr500,
                     xccc003    LIKE xccc_t.xccc003,    #成本計算類型
                     xccc003_desc    LIKE type_t.chr500                   
                     END RECORD
DEFINE tm            type_tm
DEFINE g_fetch       LIKE type_t.chr1

DEFINE g_page_cnt        LIKE type_t.num5   #總页數
DEFINE g_page_idx        LIKE type_t.num5   #当页笔数
#DEFINE g_detail_idx         LIKE type_t.num5   #当行
#DEFINE g_detail_cnt         LIKE type_t.num5   #总行

DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5

DEFINE g_glaa003    LIKE glaa_t.glaa003 #会计周期参照表号
DEFINE g_bdate      LIKE glav_t.glav004 #年度+期別對應的起始截止日期
DEFINE g_edate      LIKE glav_t.glav004

TYPE type_sr RECORD
      xccc006       LIKE xccc_t.xccc006, #料件编号
      xccc007       LIKE xccc_t.xccc007, #料件特性
      xccc006_desc  LIKE type_t.chr500,  #料件品名
      xccc006_desc1 LIKE type_t.chr500,  #料件规格
      docno         LIKE type_t.chr80,   #单据编号
      info          STRING               #错误说明 
      END RECORD
DEFINE sr           DYNAMIC ARRAY OF type_sr
DEFINE g_yy         LIKE xccc_t.xccc004  #年度 上一年度期别
DEFINE g_mm         LIKE xccc_t.xccc005  #期别 上一年度期别
DEFINE g_para_data1          LIKE type_t.chr80     #采用特性否    #fengmy150123

#2015/3/26 liuym -------str--- 
TYPE type_g_xccc_e RECORD
       v          STRING
       END RECORD
DEFINE g_param                     type_g_xccc_e  
#2015/3/26 liuym -------end---
#add--160802-00020#7 By shiun--(S)
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#add--160802-00020#7 By shiun--(E)
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_xccc_d
DEFINE g_master_t                   type_g_xccc_d
DEFINE g_xccc_d          DYNAMIC ARRAY OF type_g_xccc_d
DEFINE g_xccc_d_t        type_g_xccc_d
 
      
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
 
{<section id="axcq300.main" >}
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
   #add--160802-00020#7 By shiun--(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #add--160802-00020#7 By shiun--(E)
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
   DECLARE axcq300_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq300_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq300_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq300 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq300_init()   
 
      #進入選單 Menu (="N")
      CALL axcq300_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq300
      
   END IF 
   
   CLOSE axcq300_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq300.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axcq300_init()
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
   CALL cl_set_combo_scc('b_xccc001','8914')
   CALL cl_set_act_visible_toolbaritem("filter",FALSE)
   CALL cl_set_act_visible_toolbaritem("qbe_select,qbe_save,qbeclear",FALSE)
   #fengmy 150123----begin
   #根據參數顯示隱藏料件特性
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1  #采用特性否       
 
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('b_xccc007',TRUE)                    
   ELSE                     
      CALL cl_set_comp_visible('b_xccc007',FALSE)                
   END IF 
   #fengmy 150123----end   
   #end add-point
 
   CALL axcq300_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axcq300.default_search" >}
PRIVATE FUNCTION axcq300_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xcccld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xccc001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xccc002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xccc003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xccc004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xccc005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " xccc006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " xccc007 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " xccc008 = '", g_argv[09], "' AND "
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
 
{<section id="axcq300.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axcq300_ui_dialog()
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
   DEFINE l_sucess   LIKE type_t.num5   #2015/3/26 liuym
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
   LET g_wc = ''   #只有input条件
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL axcq300_b_fill()
   ELSE
      CALL axcq300_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xccc_d.clear()
 
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
 
         CALL axcq300_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xccc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axcq300_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL axcq300_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
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
            CALL axcq300_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
         #2015/3/26 liuym---str----
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN        
               IF g_xccc_d.getLength() > 0 THEN
                  LET g_param.v = "axcq300_temp" 
                  CALL axcq300_create_temp() RETURNING l_sucess
                  IF l_sucess THEN 
                     #CALL axcq300_ins_temp()     #161205-00025#19 mark
                     CALL axcq300_ins_temp_new()     #161205-00025#19 add
                     CALL axcq300_x01(' 1=1', g_param.v)
                  END IF
               END IF         
            END IF
         #2015/3/26 liuym---str---- 
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq300_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axcq300_filter()
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
            CALL axcq300_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xccc_d)
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
            CALL axcq300_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axcq300_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axcq300_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axcq300_b_fill()
 
         
         
 
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
 
{<section id="axcq300.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq300_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   CALL axcq300_query2()
   RETURN
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
 
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xccc_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON xccc006,inaj035
           FROM s_detail1[1].b_xccc006,s_detail1[1].b_inaj035
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_xccc006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xccc006
            #add-point:BEFORE FIELD b_xccc006 name="construct.b.page1.b_xccc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xccc006
            
            #add-point:AFTER FIELD b_xccc006 name="construct.a.page1.b_xccc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xccc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc006
            #add-point:ON ACTION controlp INFIELD b_xccc006 name="construct.c.page1.b_xccc006"
            
            #END add-point
 
 
         #----<<b_xccc007>>----
         #----<<b_xccc006_desc>>----
         #----<<b_xccc006_desc_1>>----
         #----<<b_inaj035>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_inaj035
            #add-point:BEFORE FIELD b_inaj035 name="construct.b.page1.b_inaj035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_inaj035
            
            #add-point:AFTER FIELD b_inaj035 name="construct.a.page1.b_inaj035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_inaj035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_inaj035
            #add-point:ON ACTION controlp INFIELD b_inaj035 name="construct.c.page1.b_inaj035"
            
            #END add-point
 
 
         #----<<b_inaj035_desc>>----
         #----<<b_docno>>----
         #----<<b_info>>----
   
       
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
   CALL axcq300_b_fill()
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
 
{<section id="axcq300.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq300_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   #fengmy 150123----begin
   #根據參數顯示隱藏料件特性
   IF cl_null(tm.xccccomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('b_xccc007',TRUE)                    
   ELSE                     
      CALL cl_set_comp_visible('b_xccc007',FALSE)                
   END IF 
   #fengmy 150123----end  
   CALL axcq300_b_fill2()
   RETURN
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
 
   LET ls_sql_rank = "SELECT  UNIQUE xccc006,xccc007,'','','','','',''  ,DENSE_RANK() OVER( ORDER BY xccc_t.xcccld, 
       xccc_t.xccc001,xccc_t.xccc002,xccc_t.xccc003,xccc_t.xccc004,xccc_t.xccc005,xccc_t.xccc006,xccc_t.xccc007, 
       xccc_t.xccc008) AS RANK FROM xccc_t",
 
 
                     "",
                     " WHERE xcccent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xccc_t"),
                     " ORDER BY xccc_t.xcccld,xccc_t.xccc001,xccc_t.xccc002,xccc_t.xccc003,xccc_t.xccc004,xccc_t.xccc005,xccc_t.xccc006,xccc_t.xccc007,xccc_t.xccc008"
 
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
 
   LET g_sql = "SELECT xccc006,xccc007,'','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq300_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axcq300_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xccc_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc006_desc, 
       g_xccc_d[l_ac].xccc006_desc_1,g_xccc_d[l_ac].inaj035,g_xccc_d[l_ac].inaj035_desc,g_xccc_d[l_ac].docno, 
       g_xccc_d[l_ac].info
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_xccc_d[l_ac].statepic = cl_get_actipic(g_xccc_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL axcq300_detail_show("'1'")      
 
      CALL axcq300_xccc_t_mask()
 
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
   
 
   
   CALL g_xccc_d.deleteElement(g_xccc_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_xccc_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axcq300_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq300_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq300_detail_action_trans()
 
   IF g_xccc_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL axcq300_fetch()
   END IF
   
      CALL axcq300_filter_show('xccc006','b_xccc006')
   CALL axcq300_filter_show('inaj035','b_inaj035')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq300.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq300_fetch()
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
 
{<section id="axcq300.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq300_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_xccc_d[l_ac].xccc006
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xccc_d[l_ac].xccc006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_d[l_ac].xccc006_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq300.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axcq300_filter()
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
      CONSTRUCT g_wc_filter ON xccc006,inaj035
                          FROM s_detail1[1].b_xccc006,s_detail1[1].b_inaj035
 
         BEFORE CONSTRUCT
                     DISPLAY axcq300_filter_parser('xccc006') TO s_detail1[1].b_xccc006
            DISPLAY axcq300_filter_parser('inaj035') TO s_detail1[1].b_inaj035
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_xccc006>>----
         #Ctrlp:construct.c.filter.page1.b_xccc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc006
            #add-point:ON ACTION controlp INFIELD b_xccc006 name="construct.c.filter.page1.b_xccc006"
            
            #END add-point
 
 
         #----<<b_xccc007>>----
         #----<<b_xccc006_desc>>----
         #----<<b_xccc006_desc_1>>----
         #----<<b_inaj035>>----
         #Ctrlp:construct.c.filter.page1.b_inaj035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_inaj035
            #add-point:ON ACTION controlp INFIELD b_inaj035 name="construct.c.filter.page1.b_inaj035"
            
            #END add-point
 
 
         #----<<b_inaj035_desc>>----
         #----<<b_docno>>----
         #----<<b_info>>----
   
 
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
   
      CALL axcq300_filter_show('xccc006','b_xccc006')
   CALL axcq300_filter_show('inaj035','b_inaj035')
 
    
   CALL axcq300_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq300.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axcq300_filter_parser(ps_field)
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
 
{<section id="axcq300.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axcq300_filter_show(ps_field,ps_object)
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
   LET ls_condition = axcq300_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq300.insert" >}
#+ insert
PRIVATE FUNCTION axcq300_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axcq300.modify" >}
#+ modify
PRIVATE FUNCTION axcq300_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq300.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axcq300_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq300.delete" >}
#+ delete
PRIVATE FUNCTION axcq300_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq300.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axcq300_detail_action_trans()
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
 
{<section id="axcq300.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axcq300_detail_index_setting()
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
            IF g_xccc_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xccc_d.getLength() AND g_xccc_d.getLength() > 0
            LET g_detail_idx = g_xccc_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xccc_d.getLength() THEN
               LET g_detail_idx = g_xccc_d.getLength()
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
 
{<section id="axcq300.mask_functions" >}
 &include "erp/axc/axcq300_mask.4gl"
 
{</section>}
 
{<section id="axcq300.other_function" readonly="Y" >}

#查询，pattern不支持功能需求，用此代替pattern
PRIVATE FUNCTION axcq300_query2()
   DEFINE ls_wc             LIKE type_t.chr500
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_glaa001         LIKE glaa_t.glaa001
   DEFINE l_glaa016         LIKE glaa_t.glaa016
   DEFINE l_glaa020         LIKE glaa_t.glaa020
   DEFINE l_flag            LIKE type_t.num5   #fengmy150227 放弃查询就不查数据库
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xccc_d.clear()
   LET g_wc_filter = " 1=1"
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac
 
   
   CALL axcq300_default()  #查询前预设
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      #单头input 条件，且栏位必输
      INPUT tm.xccccomp,tm.xcccld,tm.xccc004,tm.xccc005,tm.xccc001,tm.xccc003
         FROM b_xccccomp,b_xcccld,b_xccc004,b_xccc005,b_xccc001,b_xccc003
         ATTRIBUTE(WITHOUT DEFAULTS)
      
         BEFORE INPUT
         
         AFTER FIELD b_xccccomp
            CALL axcq300_chk_column('b_xccccomp') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            CALL s_desc_get_department_desc(tm.xccccomp) RETURNING tm.xccccomp_desc #法人組織
            DISPLAY tm.xccccomp_desc TO b_xccccomp_desc

         AFTER FIELD b_xcccld
            CALL axcq300_chk_column('b_xcccld') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            CALL s_desc_get_ld_desc(tm.xcccld) RETURNING tm.xcccld_desc #帳別編號
            DISPLAY tm.xcccld_desc TO b_xcccld_desc
            
         AFTER FIELD b_xccc001
            SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald  = tm.xcccld
            CASE tm.xccc001
               WHEN '1' 
                 INITIALIZE g_ref_fields TO NULL
                 LET g_ref_fields[1] = l_glaa001
                 CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
                 LET tm.xccc001_desc = '', g_rtn_fields[1] , ''                  
               WHEN '2'
                 INITIALIZE g_ref_fields TO NULL
                 LET g_ref_fields[1] = l_glaa016
                 CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
                 LET tm.xccc001_desc = '', g_rtn_fields[1] , ''
               WHEN '3'
                 INITIALIZE g_ref_fields TO NULL
                 LET g_ref_fields[1] = l_glaa020
                 CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
                 LET tm.xccc001_desc = '', g_rtn_fields[1] , ''
            END CASE
            DISPLAY tm.xccc001_desc TO b_xccc001_desc
   
         AFTER FIELD b_xccc003
            CALL axcq300_chk_column('b_xccc003') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            #成本計算類型说明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = tm.xccc003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET tm.xccc003_desc = '', g_rtn_fields[1] , ''
            DISPLAY tm.xccc003_desc TO b_xccc003_desc

         AFTER INPUT
            CALL axcq300_chk_column('b_xccccomp+b_xcccld') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD b_xccccomp
            END IF
            
      
         ON ACTION controlp INFIELD b_xccccomp #法人组织
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #add--160802-00020#7 By shiun--(S)
      	   #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #add--160802-00020#7 By shiun--(E)
            CALL q_ooef001_2()                      #呼叫開窗
            LET tm.xccccomp = g_qryparam.return1
            DISPLAY tm.xccccomp TO b_xccccomp  #顯示到畫面上
            CALL s_desc_get_department_desc(tm.xccccomp) RETURNING tm.xccccomp_desc #法人組織
            DISPLAY tm.xccccomp_desc TO b_xccccomp_desc
            NEXT FIELD b_xccccomp                     #返回原欄位

         ON ACTION controlp INFIELD b_xcccld   #账别编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #add--160802-00020#7 By shiun--(S)
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #add--160802-00020#7 By shiun--(E)
            CALL q_authorised_ld()                #呼叫開窗
            LET tm.xcccld = g_qryparam.return1
            DISPLAY tm.xcccld TO b_xcccld  #顯示到畫面上
            
            CALL s_desc_get_ld_desc(tm.xcccld) RETURNING tm.xcccld_desc #帳別編號
            DISPLAY tm.xcccld_desc TO b_xcccld_desc
            NEXT FIELD b_xcccld                     #返回原欄位
 
         ON ACTION controlp INFIELD b_xccc003   #成本计算类型
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                       #呼叫開窗
            LET tm.xccc003 = g_qryparam.return1
            DISPLAY tm.xccc003 TO b_xccc003  #顯示到畫面上
            
            #成本計算類型说明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = tm.xccc003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET tm.xccc003_desc = '', g_rtn_fields[1] , ''
            DISPLAY tm.xccc003_desc TO b_xccc003_desc
            NEXT FIELD b_xccc003                     #返回原欄位

      END INPUT
 
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前

      #end add-point 
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
 
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
  #   ON ACTION qbeclear   # 條件清除
  #      CLEAR FORM
  #
      #add-point:query段查詢方案相關ACTION設定後

      #end add-point 
 
   END DIALOG
 
   
   LET l_flag = 1   #fengmy150227
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      LET l_flag = 0   #fengmy150227
      #還原
      LET g_wc = ls_wc
   ELSE
      LET g_master_idx = 1
   END IF
   
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
        
   #add-point:cs段after_construct

   #end add-point
        
   LET g_error_show = 1
   IF l_flag THEN    #fengmy150227
      CALL axcq300_b_fill()
   END IF            #fengmy150227
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

#查询前预设
PRIVATE FUNCTION axcq300_default()
DEFINE  l_glaa001        LIKE glaa_t.glaa001

   #预设当前site的法人，主账套，年度期别，成本计算类型
   CALL s_axc_set_site_default() RETURNING tm.xccccomp,tm.xcccld,tm.xccc004,tm.xccc005,tm.xccc003  
   DISPLAY tm.xccccomp,tm.xcccld,tm.xccc004,tm.xccc005,tm.xccc003 TO b_xccccomp,b_xcccld,b_xccc004,b_xccc005,b_xccc003
   #fengmy 150123----begin
   #根據參數顯示隱藏料件特性
   IF cl_null(tm.xccccomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('b_xccc007',TRUE)                    
   ELSE                     
      CALL cl_set_comp_visible('b_xccc007',FALSE)                
   END IF 
   #fengmy 150123----end   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = tm.xccccomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.xccccomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY tm.xccccomp_desc TO b_xccccomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = tm.xcccld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.xcccld_desc = '', g_rtn_fields[1] , ''
   DISPLAY tm.xcccld_desc TO b_xcccld_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = tm.xccc003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.xccc003_desc = '', g_rtn_fields[1] , ''
   DISPLAY tm.xccc003_desc TO b_xccc003_desc
      
   LET tm.xccc001 = '1'
   DISPLAY tm.xccc001 TO b_xccc001
   
   SELECT glaa001 INTO l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = tm.xcccld

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.xccc001_desc = '', g_rtn_fields[1] , ''
   DISPLAY tm.xccc001_desc TO b_xccc001_desc
END FUNCTION

#检查栏位
PRIVATE FUNCTION axcq300_chk_column(p_column)
   DEFINE p_column      LIKE type_t.chr20
   DEFINE r_success     LIKE type_t.num5
   

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   CASE p_column
      WHEN 'b_xccccomp'  #法人
           IF NOT cl_null(tm.xccccomp) THEN
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = tm.xccccomp
              #add--160802-00020#7 By shiun--(S)
              #增加帳套權限控制
              IF NOT cl_null(g_wc_cs_comp) THEN
                 LET g_chkparam.where = " ooef001 IN ",g_wc_cs_comp
              END IF
              #add--160802-00020#7 By shiun--(E)
              IF NOT cl_chk_exist("v_ooef001_1") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'b_xcccld'    #帐套
           IF NOT cl_null(tm.xcccld) THEN
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = tm.xcccld
              #add--160802-00020#7 By shiun--(S)
              #增加帳套權限控制
              IF NOT cl_null(g_wc_cs_ld) THEN
                 LET g_chkparam.where = " glaald IN ",g_wc_cs_ld
              END IF
              #add--160802-00020#7 By shiun--(E)
              #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#8--add--end
              IF NOT cl_chk_exist("v_glaald") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'b_xccc003'   #成本计算类型
           IF NOT cl_null(tm.xccc003) THEN
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = tm.xccc003
              #160318-00025#8--add--str
              LET g_errshow = TRUE 
              LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
              #160318-00025#8--add--end
              IF NOT cl_chk_exist("v_xcat001") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'b_xccccomp+b_xcccld'  #法人+帐套
           IF NOT cl_null(tm.xccccomp) AND NOT cl_null(tm.xcccld) THEN
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = tm.xcccld
              LET g_chkparam.arg2 = tm.xccccomp
              #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#8--add--end
              IF NOT cl_chk_exist("v_glaald_5") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
   END CASE
   RETURN r_success
END FUNCTION

#
PRIVATE FUNCTION axcq300_b_fill2()
DEFINE l_glaa003         LIKE glaa_t.glaa003
DEFINE ls_msg            STRING
DEFINE l_success         LIKE type_t.num5
DEFINE l_sfaa048         LIKE sfaa_t.sfaa048
DEFINE l_n               LIKE type_t.num5
DEFINE l_apca001         LIKE apca_t.apca001
DEFINE l_apcadocno       LIKE apca_t.apcadocno
DEFINE l_apca_sum1       LIKE apca_t.apca103
DEFINE l_apca_sum2       LIKE apca_t.apca103
DEFINE l_apcb_sum1       LIKE apcb_t.apcb103
DEFINE l_apcb_sum2       LIKE apcb_t.apcb103
DEFINE l_apcb_sum3       LIKE apcb_t.apcb103
DEFINE l_apcb_sum4       LIKE apcb_t.apcb103
DEFINE l_apcb_sum5       LIKE apcb_t.apcb103
DEFINE l_apcb_sum6       LIKE apcb_t.apcb103
DEFINE l_apca025         LIKE apca_t.apca025
DEFINE l_sfaa012         LIKE sfaa_t.sfaa012
DEFINE l_sfec009         LIKE sfec_t.sfec009
DEFINE l_inbastus        LIKE inba_t.inbastus  #151015-00002#1 add
DEFINE l_xccw202         LIKE xccw_t.xccw202   #151015-00002#1 add
DEFINE l_inbb016         LIKE inbb_t.inbb016   #151015-00002#1 add
DEFINE l_str             STRING                #151201-00018 by whitney add
DEFINE l_oocql004        LIKE oocql_t.oocql004 #151201-00018 by whitney add
DEFINE l_pmds011_str1    STRING   #160530-00005#3  
DEFINE l_apca_inaj035    LIKE inaj_t.inaj035   #160913-00024#1 add
DEFINE l_apca_gzzal003   LIKE gzzal_t.gzzal003 #160913-00024#1 add

   #160530-00005#3--s   
   LET l_pmds011_str1 =  s_aap_get_acc_str('2061',"gzcb003 = 'Y' ")
   LET l_pmds011_str1 = s_fin_get_wc_str(l_pmds011_str1)   
   #160530-00005#3--e   
   #根据年度期别计算起始截止日期
   SELECT glaa003 INTO l_glaa003  #會計週期參照表號
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaa014 = 'Y'  #主帐套
      AND glaacomp = tm.xccccomp
   CALL s_fin_date_get_period_range(l_glaa003,tm.xccc004,tm.xccc005)
       RETURNING g_bdate,g_edate
   
   #单身初始化
   CALL g_xccc_d.clear()
   LET l_ac = 1
  
   #1.此期料件异动是否全部参于成本阶计算(axcp120)
   #170105-00011#10---mark---s            
   #LET g_sql = " SELECT inaj005,inaj006,",
   #           #160503-00030#3 mod str
   #           #"        '','',inaj001,''",
   #            "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal003,",
   #            "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal004,",
   #            #160913-00024#1-s
   #            "        '',",
   #            "        '',",
   #            #160913-00024#1-e
   #            "        inaj001,",
   #            "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00557' AND gzze002='",g_lang,"') info",
   #           #160503-00030#3 mod end 
   #            "   FROM inaj_t ",
   #            "  WHERE inaj022 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
   #            #"    AND inaj209 ='",tm.xccccomp,"'",  #mark zhangllc 150721
   #           #160503-00030#3 mod str
   #           #"    AND inaj008 NOT IN (SELECT inaa001 FROM inaa_t,inaj_t ",
   #           #"                         WHERE inaaent = inajent AND inaasite = inajsite AND inaa001 = inaj008 ",
   #           #"                           AND inaaent = ",g_enterprise," AND inaa010 = 'N'",
   #           #"                           AND inaasite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
   #           #"                                               AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"'))",
   #           #"    AND (inaj005 NOT IN (SELECT xcbb003 FROM xcbb_t ",
   #           #"                          WHERE xcbbent = ",g_enterprise," AND xcbbcomp = '",tm.xccccomp,"'",
   #           #"                            AND xcbb001 = ",tm.xccc004," AND xcbb002 = ",tm.xccc005,") OR ",
   #           #"         inaj006 NOT IN (SELECT xcbb004 FROM xcbb_t ",
   #           #"                          WHERE xcbbent = ",g_enterprise," AND xcbbcomp = '",tm.xccccomp,"'",
   #           #"                            AND xcbb001 = ",tm.xccc004," AND xcbb002 = ",tm.xccc005,"))",
   #            "    AND NOT EXISTS (SELECT 1 FROM inaa_t ",
   #            "                     WHERE inaaent = inajent AND inaasite = inajsite AND inaa001 = inaj008",
   #            "                       AND inaa010 = 'N'",
   #            "                       AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent = inaaent AND ooef001 = inaasite",
   #            "                                      AND ooefstus = 'Y' AND ooef017 = '",tm.xccccomp,"'))",
   #            "    AND (NOT EXISTS (SELECT 1 FROM xcbb_t WHERE xcbbent = inajent AND xcbb003 = inaj005",
   #            "                                            AND xcbbcomp = '",tm.xccccomp,"'",
   #            "                                            AND xcbb001 = ",tm.xccc004," AND xcbb002 = ",tm.xccc005,") " #160929-00039#1 reduce ,
   #           #160929-00039#1 ---mark (s)---
   #           #"         OR ",
   #           #"         NOT EXISTS (SELECT 1 FROM xcbb_t WHERE xcbbent = inajent AND xcbb004 = inaj006",
   #           #"                                            AND xcbbcomp = '",tm.xccccomp,"'",
   #           #"                                            AND xcbb001 = ",tm.xccc004," AND xcbb002 = ",tm.xccc005,") )", 
   #           #160929-00039#1 ---mark (e)---
   #           
   #           #160929-00039#1 ---add (s)---
   #            IF cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'Y' THEN
   #               LET g_sql = g_sql, "OR NOT EXISTS (SELECT 1 FROM xcbb_t WHERE xcbbent = inajent AND xcbb004 = inaj006",
   #                                  " AND xcbbcomp = '",tm.xccccomp,"'",
   #                                  " AND xcbb001 = ",tm.xccc004," AND xcbb002 = ",tm.xccc005,") "
   #            END IF 
   #            LET g_sql = g_sql , " ) " ,
   #           #160929-00039#1 ---add (e)---
   #           #160503-00030#3 mod end
   #            "    AND inajent = ",g_enterprise,     
   #           #"    AND inaj209 ='",tm.xccccomp,"'"   #mark zhangllc 150721
   #           #add zhangllc 150721
   #           #160503-00030#3 mod str
   #           #"    AND inajsite IN(SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
   #           #"                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"') "
   #            "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inajent AND ooef001=inajsite",        
   #            "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
   #           #160503-00030#3 mod end 
   #            #end
   #170105-00011#10---mark---e            
   #170105-00011#10---add---s
#   IF cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'Y' THEN   #170207-00035#1 marked 
      LET g_sql = " SELECT /*+ index(inaj_t inaj_n02)*/ inaj005,inaj006,",
                  "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal003,",
                  "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal004,",
                  "        inaj001,",
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00557' AND gzze002='",g_lang,"') info",
                  "   FROM inaj_t ",
                  "   LEFT JOIN inaa_t ON inaaent = inajent AND inaasite = inajsite AND inaa001 = inaj008 AND inaa010 <> 'N'",
                  "   LEFT JOIN xcbb_t ON xcbbent = inajent AND xcbb003 = inaj005 AND xcbbcomp = '",tm.xccccomp,"'",
                  "                   AND xcbb001 = ",tm.xccc004," AND xcbb002 = ",tm.xccc005,"",
                  "  WHERE inajent = ",g_enterprise,
                  "    AND inaj022 BETWEEN '",g_bdate,"' AND '",g_edate,"'",     
                  "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inajent AND ooef001=inajsite",        
                  "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",   
                  "    AND inaa001 IS NULL AND xcbb003 IS NULL"
   #170207-00035#1 marked-S
#   ELSE
#      LET g_sql = " SELECT /*+ index(inaj_t inaj_n02)*/ inaj005,inaj006,",
#                  "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal003,",
#                  "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal004,",
#                  "        inaj001,",
#                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00557' AND gzze002='",g_lang,"') info",
#                  "   FROM inaj_t ",
#                  "   LEFT JOIN inaa_t ON inaaent = inajent AND inaasite = inajsite AND inaa001 = inaj008 AND inaa010 <> 'N'",
#                  "   LEFT JOIN xcbb_t ON xcbbent = inajent AND xcbb003 = inaj005 AND xcbb004 = inaj006 AND xcbbcomp = '",tm.xccccomp,"'",
#                  "                   AND xcbb001 = ",tm.xccc004," AND xcbb002 = ",tm.xccc005,"",
#                  "  WHERE inajent = ",g_enterprise,
#                  "    AND inaj022 BETWEEN '",g_bdate,"' AND '",g_edate,"'",     
#                  "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inajent AND ooef001=inajsite",        
#                  "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",   
#                  "    AND inaa001 IS NULL AND xcbb003 IS NULL AND xcbb004 IS NULL "
#   END IF                  
   #170207-00035#1 marked-E
   #170105-00011#10---add---e                
   PREPARE axcq300_pr1 FROM g_sql
   DECLARE axcq300_cs1 CURSOR FOR axcq300_pr1
   FOREACH axcq300_cs1 INTO g_xccc_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:axcq300_cs1" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      #160913-00024#1-s
      IF NOT cl_null(g_xccc_d[l_ac].docno) THEN
         CALL axcq300_aooi200_get_slip(g_xccc_d[l_ac].docno) RETURNING g_xccc_d[l_ac].inaj035,g_xccc_d[l_ac].inaj035_desc 
      END IF
      #160913-00024#1-e      
#160503-00030#3 mark str
#      SELECT imaal003,imaal004 INTO g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_1 FROM imaal_t 
#       WHERE imaalent = g_enterprise AND imaal001 = g_xccc_d[l_ac].xccc006
#      CALL cl_getmsg('axc-00557',g_lang) RETURNING ls_msg  #此料號未參與成本階計算(axcp120)
#     LET g_xccc_d[l_ac].info = ls_msg  #错误信息
#160503-00030#3 mark end
      LET l_ac = l_ac + 1
   END FOREACH
               
   #2.入庫/退貨單与请款单未匹配
   LET g_sql = " SELECT pmdt006,pmdt007,",
              #160503-00030#3 mod str
              #"        '','',pmdtdocno,''",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=pmdtent AND imaal001=pmdt006 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=pmdtent AND imaal001=pmdt006 AND imaal002='"||g_dlang||"') imaal004,",
               #160913-00024#1-s
               "        (CASE (pmds000) WHEN '3' THEN 'apmt530' WHEN '4' THEN 'apmt532' WHEN '6' THEN 'apmt570' WHEN '7' THEN 'apmt580' ",
               "         WHEN '12' THEN 'apmt571' END), ",
               "        (SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = (CASE (pmds000) WHEN '3' THEN 'apmt530' WHEN '4' THEN 'apmt532' WHEN '6' THEN 'apmt570' WHEN '7' THEN 'apmt580' 
                        WHEN '12' THEN 'apmt571' END) AND gzzal002='"||g_dlang||"') gzzal003,",
               #160913-00024#1-e
               "        pmdtdocno,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00558' AND gzze002='",g_lang,"') info",
              #160503-00030#3 mod end                
               "   FROM pmdt_t,pmds_t ",
               "  WHERE pmdsent = pmdtent AND pmdsdocno = pmdtdocno ",
               #"    AND pmdsdocdt BETWEEN '",g_bdate,"' AND '",g_edate,"'", 
               "    AND pmds001 BETWEEN '",g_bdate,"' AND '",g_edate,"'",  #mod zhangllc 151109
               "    AND pmds000 IN ('3','4','6','7','12')  AND pmdt005 != '9'",   #排除样品
               "    AND pmds011 IN ",l_pmds011_str1 CLIPPED,                      #160530-00005#3
               "    AND ( pmdt056 + pmdt066 < pmdt024 OR",
               "         (pmdt056 IS NULL AND pmdt024 > 0 AND pmdt056 < pmdt024) OR", 
               "         (pmds000 = '7' AND pmds100 = '5' AND NOT EXISTS (SELECT 1 FROM apcb_t WHERE apcb008 = pmdtdocno AND apcb009 = pmdtseq)))", #无请款资料匹配纯折让的部分
               "    AND pmdsent = ",g_enterprise,
#               "    AND omdsstus <> 'X' ",     #wujie 150514   #2015/09/15 by stellar mark
               "    AND pmdsstus <> 'X' ",     #2015/09/15 by stellar add
              #160503-00030#3 mod str
              #"    AND pmdssite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
              #"                        AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"') "
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=pmdsent AND ooef001=pmdssite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
              #160503-00030#3 mod end 
   PREPARE axcq300_pr2 FROM g_sql
   DECLARE axcq300_cs2 CURSOR FOR axcq300_pr2
   FOREACH axcq300_cs2 INTO g_xccc_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:axcq300_cs2" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
#160503-00030#3 mark str
#      SELECT imaal003,imaal004 INTO g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_1 FROM imaal_t 
#       WHERE imaalent = g_enterprise AND imaal001 = g_xccc_d[l_ac].xccc006
#      CALL cl_getmsg('axc-00558',g_lang) RETURNING ls_msg  #入庫/退貨單与请款单未匹配
#      LET g_xccc_d[l_ac].info = ls_msg  #错误信息
#160503-00030#3 mark end
      LET l_ac = l_ac + 1
   END FOREACH
   
   #3.应付帐款数量或金额<0（入库单+仓退单）
   LET g_sql = " SELECT apcb004,'',",
              #160503-00030#3 mod str
              #"        '','',apcadocno,''",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=apcbent AND imaal001=apcb004 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=apcbent AND imaal001=apcb004 AND imaal002='"||g_dlang||"') imaal004,",
               #160913-00024#1-s
               "        'aapt300',",
               "        (SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = 'aapt300' AND gzzal002='"||g_dlang||"') gzzal003,",
               #160913-00024#1-e
               "        apcadocno,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00559' AND gzze002='",g_lang,"') info",
              #160503-00030#3 mod end
               "   FROM apca_t,apcb_t",
               "  WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
               "    AND apcadocdt BETWEEN '",g_bdate,"' AND '",g_edate ,"'",   
               "    AND (apca001 = '13' OR apca001 = '22') ",              
               "    AND ((apcb007 > 0 AND apcb101 < 0) OR ",      #判斷有數量而無金額
               "         (apcb007 > 0 AND apcb105 < 0) OR ",
               "         (apcb007 > 0 AND apcb111 < 0) OR ",
               "         (apcb007 > 0 AND apcb115 < 0) OR ",         
               "         (apcb007 < 0 AND apcb101 > 0) OR ",      #判斷無數量而有金額
               "         (apcb007 < 0 AND apcb105 > 0) OR ",
               "         (apcb007 < 0 AND apcb111 > 0) OR ",
               "         (apcb007 < 0 AND apcb115 > 0)) ",
               "    AND apcaent = ",g_enterprise," AND apcald = '",tm.xcccld,"'",
               "    AND apcacomp ='",tm.xccccomp,"'"
   PREPARE axcq300_pr3 FROM g_sql
   DECLARE axcq300_cs3 CURSOR FOR axcq300_pr3
   FOREACH axcq300_cs3 INTO g_xccc_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:axcq300_cs3" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
#160503-00030#3 mark str
#      SELECT imaal003,imaal004 INTO g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_1 FROM imaal_t 
#       WHERE imaalent = g_enterprise AND imaal001 = g_xccc_d[l_ac].xccc006
#      CALL cl_getmsg('axc-00559',g_lang) RETURNING ls_msg  #入庫倉退對應的应付帐款数量或金额<0
#      LET g_xccc_d[l_ac].info = ls_msg  #错误信息
#160503-00030#3 mark end
      LET l_ac = l_ac + 1
   END FOREACH            
                                           
   #4，檢查統計檔期未庫存小於零                                         
   LET g_sql = " SELECT inat001,inat002,",
              #160503-00030#3 mod str
              #"        '','','',''",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inatent AND imaal001=inat001 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inatent AND imaal001=inat001 AND imaal002='"||g_dlang||"') imaal004,",
               #160913-00024#1-s
               "        '',",
               "        '',",
               #160913-00024#1-e
               "        '',",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00560' AND gzze002='",g_lang,"') info",
              #160503-00030#3 mod end
               "   FROM inat_t ",
               "  WHERE inatent = ",g_enterprise," AND inat008 = ",tm.xccc004,
               "    AND inat009 = ",tm.xccc005," AND inat015 < 0 ",
              #160503-00030#3 mod str
              #"    AND inatsite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
              #"                        AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inatent AND ooef001=inatsite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
              #160503-00030#3 mod end
   PREPARE axcq300_pr4 FROM g_sql
   DECLARE axcq300_cs4 CURSOR FOR axcq300_pr4
   FOREACH axcq300_cs4 INTO g_xccc_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:axcq300_cs4" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
#160503-00030#3 mark str
#      SELECT imaal003,imaal004 INTO g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_1 FROM imaal_t 
#       WHERE imaalent = g_enterprise AND imaal001 = g_xccc_d[l_ac].xccc006
#      CALL cl_getmsg('axc-00560',g_lang) RETURNING ls_msg  #此料號統計檔期末庫存<0
#      LET g_xccc_d[l_ac].info = ls_msg  #错误信息
#160503-00030#3 mark end
      LET l_ac = l_ac + 1
   END FOREACH                                                
   
   #5.每日工時檔中, 有無輸入上期前就已結案的工單
#160503-00030#3 mod str
#   LET g_sql = " SELECT sfac001,sfac006,'','',xcbi002,'',sfaa048",
#               "   FROM xcbh_t,xcbi_t",
#               "   LEFT OUTER JOIN sfaa_t ON xcbient = sfaaent AND xcbi002 = sfaadocno AND sfaastus != 'X' AND sfaa048 IS NOT NULL",
#               "   LEFT OUTER JOIN sfac_t ON xcbient = sfacent AND xcbi002 = sfacdocno",
#               "  WHERE xcbhent = xcbient AND xcbhdocno = xcbidocno ",
#               "    AND xcbh001 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
#               "    AND (xcbi201 != 0 OR xcbi202 != 0 OR xcbi203 != 0 OR xcbi204 != 0) ",
#               "    AND xcbhent = xcbient AND xcbhdocno = xcbidocno",
#               "    AND xcbhent = ",g_enterprise," AND xcbhcomp = '",tm.xccccomp,"'"
   LET g_sql = " SELECT sfac001,sfac006,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfacent AND imaal001=sfac001 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfacent AND imaal001=sfac001 AND imaal002='"||g_dlang||"') imaal004,",
               #160913-00024#1-s
               "        'asft300',",
               "        (SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = 'asft300' AND gzzal002='"||g_dlang||"') gzzal003,",
               #160913-00024#1-e
               "        xcbi002,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00562' AND gzze002='",g_lang,"') info,",
               "        sfaa048",               
               "   FROM xcbh_t,xcbi_t",
               "   LEFT OUTER JOIN sfaa_t ON xcbient = sfaaent AND xcbi002 = sfaadocno AND sfaastus != 'X' AND sfaa048 IS NOT NULL",
               "   LEFT OUTER JOIN sfac_t ON xcbient = sfacent AND xcbi002 = sfacdocno",
               "  WHERE xcbhent = xcbient AND xcbhdocno = xcbidocno ",
               "    AND xcbh001 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND (xcbi201 != 0 OR xcbi202 != 0 OR xcbi203 != 0 OR xcbi204 != 0) ",
               "    AND xcbhent = ",g_enterprise," AND xcbhcomp = '",tm.xccccomp,"'",
               "    AND sfac001 IS NULL",
               " UNION",
               " SELECT sfac001,sfac006,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfacent AND imaal001=sfac001 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfacent AND imaal001=sfac001 AND imaal002='"||g_dlang||"') imaal004,",
               #160913-00024#1-s
               "        'asft300',",
               "        (SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = 'asft300' AND gzzal002='"||g_dlang||"') gzzal003,",
               #160913-00024#1-e
               "        xcbi002,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00561' AND gzze002='",g_lang,"') info,",
               "        sfaa048",               
               "   FROM xcbh_t,xcbi_t",
               "   LEFT OUTER JOIN sfaa_t ON xcbient = sfaaent AND xcbi002 = sfaadocno AND sfaastus != 'X' AND sfaa048 IS NOT NULL",
               "   LEFT OUTER JOIN sfac_t ON xcbient = sfacent AND xcbi002 = sfacdocno",
               "  WHERE xcbhent = xcbient AND xcbhdocno = xcbidocno ",
               "    AND xcbh001 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND (xcbi201 != 0 OR xcbi202 != 0 OR xcbi203 != 0 OR xcbi204 != 0) ",
               "    AND xcbhent = ",g_enterprise," AND xcbhcomp = '",tm.xccccomp,"'",
               "    AND sfac001 IS NOT NULL AND sfaa048 IS NOT NULL",
               "    AND ( to_char(sfaa048,'YYYY') < ",tm.xccc004," OR ",
               "         (to_char(sfaa048,'YYYY') = ",tm.xccc004," AND to_char(sfaa048,'MM') < ",tm.xccc005,") )"               
#160503-00030#3 mod end
   PREPARE axcq300_pr5 FROM g_sql
   DECLARE axcq300_cs5 CURSOR FOR axcq300_pr5
   FOREACH axcq300_cs5 INTO g_xccc_d[l_ac].*,l_sfaa048
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:axcq300_cs5" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
#160503-00030#3 mark str
#      IF cl_null(g_xccc_d[l_ac].xccc006) THEN
#         CALL cl_getmsg('axc-00562',g_lang) RETURNING ls_msg  #找不到此工單 
#         LET g_xccc_d[l_ac].info = ls_msg  #错误信息     
#      ELSE
#         SELECT imaal003,imaal004 INTO g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_1 FROM imaal_t 
#          WHERE imaalent = g_enterprise AND imaal001 = g_xccc_d[l_ac].xccc006
#         IF cl_null(l_sfaa048) THEN
#            CONTINUE FOREACH
#          # CALL cl_getmsg('axc-00563',g_lang) RETURNING ls_msg  #應結工單尚未結案
#          # LET g_xccc_d[l_ac].info = ls_msg  #错误信息 
#         ELSE            
#            IF YEAR(l_sfaa048) < tm.xccc004 OR (YEAR(l_sfaa048) = tm.xccc004 AND MONTH(l_sfaa048) < tm.xccc005) THEN
#               CALL cl_getmsg('axc-00561',g_lang) RETURNING ls_msg  #每日工時檔中, 有輸入上期前就已結案的工單 
#               LET g_xccc_d[l_ac].info = ls_msg  #错误信息   
#            ELSE
#               CALL g_xccc_d.deleteElement(l_ac)  
#               CONTINUE FOREACH               
#            END IF
#         END IF
#      END IF
#160503-00030#3 mark end
      LET l_ac = l_ac + 1
   END FOREACH 
   
#  #6,入庫材料是否有設標準工時  
#  LET g_sql = "SELECT UNIQUE sfac001,sfac006,'','','','' FROM sfaa_t,sfac_t,xcag_t",
#              " WHERE sfaaent = sfacent AND sfaadocno = sfacdocno ",
#              "   AND sfacent = xcagent AND sfacsite = xcagsite AND sfac001 = xcag004 ",
#              "   AND sfaadocdt BETWEEN '", g_bdate,"' AND '", g_edate,"'",
#              "   AND sfaa003 = '1' AND (xcag102 = 0 OR xcag102 is null) ",
#              "   AND sfaaent = ",g_enterprise," AND xcagcomp = '",tm.xccccomp,"'"
#  PREPARE axcq300_pr6 FROM g_sql
#  DECLARE axcq300_cs6 CURSOR FOR axcq300_pr6
#  FOREACH axcq300_cs6 INTO g_xccc_d[l_ac].*
#     IF SQLCA.sqlcode THEN
#        INITIALIZE g_errparam TO NULL 
#        LET g_errparam.extend = "FOREACH:axcq300_cs6" 
#        LET g_errparam.code   = SQLCA.sqlcode 
#        LET g_errparam.popup  = TRUE 
#        CALL cl_err()
#        EXIT FOREACH
#     END IF
#     SELECT imaal003,imaal004 INTO g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_1 FROM imaal_t 
#      WHERE imaalent = g_enterprise AND imaal001 = g_xccc_d[l_ac].xccc006
#     CALL cl_getmsg('axc-00564',g_lang) RETURNING ls_msg  #工單入庫材料未設標準工時
#     LET g_xccc_d[l_ac].info = ls_msg  #错误信息
#     
#     LET l_ac = l_ac + 1
#  END FOREACH 
   
   #7,應發數量=0 but 已發數量<>0
   LET g_sql = " SELECT sfba006,sfba021,",
              #160503-00030#3 mod str
              #"        '','',sfaadocno,''",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfbaent AND imaal001=sfba006 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfbaent AND imaal001=sfba006 AND imaal002='"||g_dlang||"') imaal004,",
               #160913-00024#1-s
               "        'asft300',",
               "        (SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = 'asft300' AND gzzal002='"||g_dlang||"') gzzal003,",
               #160913-00024#1-e
               "        sfaadocno,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00565' AND gzze002='",g_lang,"') info",
              #160503-00030#3 mod end
               "   FROM sfaa_t,sfba_t",
               "  WHERE sfaaent = sfbaent AND sfaadocno = sfbadocno ",
               "    AND sfaaent  =",g_enterprise,  #150823 by whitney add
               "    AND sfba013 = 0 AND (sfba016 <> 0 OR sfba025 <> 0)",
               #"    AND (sfaa038 >= '",g_bdate,"' OR sfaa038 IS NULL)",   #161223-00018#1 MARK
               "    AND (sfaa048 >= '",g_bdate,"' OR sfaa048 IS NULL)",    #161223-00018#1 MOD           
              #160503-00030#3 mod str
              #"    AND sfbasite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
              #"                        AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfbaent AND ooef001=sfbasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
              #160503-00030#3 mod end
   PREPARE axcq300_pr7 FROM g_sql
   DECLARE axcq300_cs7 CURSOR FOR axcq300_pr7
   FOREACH axcq300_cs7 INTO g_xccc_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:axcq300_cs7" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
#160503-00030#3 mark str
#      SELECT imaal003,imaal004 INTO g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_1 FROM imaal_t 
#       WHERE imaalent = g_enterprise AND imaal001 = g_xccc_d[l_ac].xccc006
#      CALL cl_getmsg('axc-00565',g_lang) RETURNING ls_msg  #工單應發數量為0，但是已發數量或者超領數量不為0
#      LET g_xccc_d[l_ac].info = ls_msg  #错误信息
#160503-00030#3 mark end
      LET l_ac = l_ac + 1
   END FOREACH 
   
   #8,檢查有inaj_t 但無工單編號
   #170105-00011#10---mark---s 
   #LET g_sql = " SELECT UNIQUE inaj005,inaj006,",
   #           #160503-00030#3 mod str
   #           #"        '','',inaj020,''",
   #            "        '',",
   #            "        '',",
   #            #160913-00024#1-s
   #            "        '',",
   #            "        '',",
   #            #160913-00024#1-e
   #            "        inaj020,",
   #            "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00566' AND gzze002='",g_lang,"') info",
   #           #160503-00030#3 mod end
   #            "   FROM inaj_t",
   #            "  WHERE inaj022 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
   #            "    AND inaj015 LIKE 'asft31%' AND inaj004 != 0 ",        #inaj015:发料，领料，超领等
   #            "    AND NOT EXISTS (SELECT 1 FROM sfaa_t WHERE sfaaent = inajent AND sfaadocno = inaj020) ",
   #            "    AND inajent = ",g_enterprise,
   #            #"    AND inaj209 ='",tm.xccccomp,"')"   #mark zhangllc 150721
   #            #add zhangllc 150721
   #           #160503-00030#3 mod str
   #           #"    AND inajsite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
   #           #"                        AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
   #            "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inajent AND ooef001=inajsite",
   #            "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
   #           #160503-00030#3 mod end
   #            #end
   #170105-00011#10---mark---e             
   #170105-00011#10---add---s
   LET g_sql = " SELECT /*+ index(inaj_t inaj_n02)*/ UNIQUE inaj005,inaj006,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal004,",
               "        inaj020,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00566' AND gzze002='",g_lang,"') info",
               "   FROM inaj_t",
               "   LEFT OUTER JOIN sfaa_t ON sfaaent = inajent AND sfaadocno = inaj020 ",
               "  WHERE inaj022 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND inaj015 LIKE 'asft31%' AND inaj004 != 0 ",        #inaj015:发料，领料，超领等
               "    AND inajent = ",g_enterprise,
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inajent AND ooef001=inajsite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
               "    AND sfaadocno IS NULL"               
   #170105-00011#10---add---e                
   PREPARE axcq300_pr8 FROM g_sql
   DECLARE axcq300_cs8 CURSOR FOR axcq300_pr8
   FOREACH axcq300_cs8 INTO g_xccc_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:axcq300_cs8" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      #160913-00024#1-s
      IF NOT cl_null(g_xccc_d[l_ac].docno) THEN
         CALL axcq300_aooi200_get_slip(g_xccc_d[l_ac].docno) RETURNING g_xccc_d[l_ac].inaj035,g_xccc_d[l_ac].inaj035_desc 
      END IF
      #160913-00024#1-e  
#160503-00030#3 mark str
#      SELECT imaal003,imaal004 INTO g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_1 FROM imaal_t 
#       WHERE imaalent = g_enterprise AND imaal001 = g_xccc_d[l_ac].xccc006
#      CALL cl_getmsg('axc-00566',g_lang) RETURNING ls_msg  #庫存異動明細檔inaj_t有資料，但無工單編號
#      LET g_xccc_d[l_ac].info = ls_msg  #错误信息
#160503-00030#3 mark end
      LET l_ac = l_ac + 1
   END FOREACH            

   #9.檢查有inaj_t,但無備料檔
#170105-00011#10---mark---s   
##160503-00030#3 mod str
##   LET g_sql = " SELECT UNIQUE inaj005,inaj006,",
##               "        '','',inaj020,'',SUM(inaj011*inaj004)",
##               "   FROM inaj_t ",
##               "  WHERE inaj022 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
##               "    AND inaj015 LIKE 'asft31%' AND inaj004 != 0 ",        #inaj015:发料，领料，超领等
##               "    AND inaj008 NOT IN (SELECT inaa001 FROM inaa_t,inaj_t ",
##               "                         WHERE inaaent = inajent AND inaasite = inajsite AND inaa001 = inaj008 ",
##               "                           AND inaaent = ",g_enterprise," AND inaa010 = 'N')",
##               "    AND inajent = ",g_enterprise,
##               #"    AND inaj209 ='",tm.xccccomp,"')",   #mark zhangllc 150721
##               #add zhangllc 150721
##               "    AND inajsite IN (SELECT ooef001 FROM ooef_t",
##               "                      WHERE ooefent = '",g_enterprise,"'",
##               "                        AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"') ",
##               #end
##               "  GROUP BY inaj005,inaj006,inaj020 "
#   LET g_sql = " SELECT UNIQUE inaj005,inaj006,",
#               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal003,",
#               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal004,",
#               #160913-00024#1-s
#               "        '',",
#               "        '',",
#               #160913-00024#1-e
#               "        inaj020,",
#               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00567' AND gzze002='",g_lang,"') info",
#               "   FROM inaj_t ",
#               "  WHERE inaj022 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
#               "    AND inaj015 LIKE 'asft31%' AND inaj004 != 0 ",        #inaj015:发料，领料，超领等
#               "    AND NOT EXISTS (SELECT 1 FROM inaa_t WHERE inaaent=inajent AND inaasite=inajsite",
#               "                                           AND inaa001=inaj008 AND inaa010='N')",               
#               "    AND inajent = ",g_enterprise,
#               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inajent AND ooef001=inajsite",
#               "                                       AND ooefstus='Y' AND ooef017='",tm.xccccomp,"')",               
#               "    AND NOT EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001=inaj005)",
#               " UNION",
#               " SELECT UNIQUE inaj005,inaj006,",
#               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal003,",
#               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal004,",
#               #160913-00024#1-s
#               "        '',",
#               "        '',",
#               #160913-00024#1-e
#               "        inaj020,",
#               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00568' AND gzze002='",g_lang,"') info",
#               "   FROM inaj_t ",
#               "  WHERE inaj022 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
#               "    AND inaj015 LIKE 'asft31%' AND inaj004 != 0 ",        #inaj015:发料，领料，超领等
#               "    AND NOT EXISTS (SELECT 1 FROM inaa_t WHERE inaaent=inajent AND inaasite=inajsite",
#               "                                           AND inaa001=inaj008 AND inaa010='N')",
#               "    AND inajent = ",g_enterprise,
#               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inajent AND ooef001=inajsite",
#               "                                       AND ooefstus='Y' AND ooef017='",tm.xccccomp,"')",
#               "    AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001=inaj005)",
#               "    AND NOT EXISTS (SELECT 1 FROM sfba_t WHERE sfbaent=inajent AND sfbadocno=inaj020)"
##160503-00030#3 mod end
#170105-00011#10---mark---e
   #170105-00011#10---add---s  
   LET g_sql = " SELECT /*+ index(inaj_t inaj_n02)*/ UNIQUE inaj005,inaj006,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal004,",
               "        inaj020,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00567' AND gzze002='",g_lang,"') info",
               "   FROM inaj_t ",
               "   LEFT JOIN inaa_t ON inaaent = inajent AND inaasite = inajsite AND inaa001 = inaj008 AND inaa010 <> 'N'",
               "   LEFT JOIN imaa_t ON imaaent=inajent AND imaa001=inaj005 ",
               "  WHERE inaj022 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND inaj015 LIKE 'asft31%' AND inaj004 != 0 ",        #inaj015:发料，领料，超领等              
               "    AND inajent = ",g_enterprise,
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inajent AND ooef001=inajsite",
               "                                       AND ooefstus='Y' AND ooef017='",tm.xccccomp,"')",               
               "    AND inaa001 IS NULL AND imaa001 IS NULL ",
               " UNION",
               " SELECT /*+ index(inaj_t inaj_n02)*/ UNIQUE inaj005,inaj006,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal004,",
               "        inaj020,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00568' AND gzze002='",g_lang,"') info",
               "   FROM inaj_t ",
               "   LEFT OUTER JOIN inaa_t ON inaaent = inajent AND inaasite = inajsite AND inaa001 = inaj008 AND inaa010 <> 'N'",
               "   LEFT OUTER JOIN imaa_t ON imaaent=inajent AND imaa001=inaj005 ",
               "   LEFT OUTER JOIN sfba_t ON sfbaent=inajent AND sfbadocno=inaj020",
               "  WHERE inaj022 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND inaj015 LIKE 'asft31%' AND inaj004 != 0 ",        #inaj015:发料，领料，超领等
               "    AND inajent = ",g_enterprise,
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inajent AND ooef001=inajsite",
               "                                       AND ooefstus='Y' AND ooef017='",tm.xccccomp,"')",
               "    AND inaa001 IS NULL AND imaa001 IS NULL AND sfbadocno IS NULL "  
   #170105-00011#10---add---e
   PREPARE axcq300_pr9 FROM g_sql
   DECLARE axcq300_cs9 CURSOR FOR axcq300_pr9
   FOREACH axcq300_cs9 INTO g_xccc_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:axcq300_cs9" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      #160913-00024#1-s
      IF NOT cl_null(g_xccc_d[l_ac].docno) THEN
         CALL axcq300_aooi200_get_slip(g_xccc_d[l_ac].docno) RETURNING g_xccc_d[l_ac].inaj035,g_xccc_d[l_ac].inaj035_desc 
      END IF
      #160913-00024#1-e  
#160503-00030#3 mark str
#      SELECT imaal003,imaal004 INTO g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_1 FROM imaal_t 
#          WHERE imaalent = g_enterprise AND imaal001 = g_xccc_d[l_ac].xccc006
#          
#      SELECT COUNT(*) INTO l_n FROM imaa_t 
#       WHERE imaaent = g_enterprise AND imaa001 = g_xccc_d[l_ac].xccc006
#      IF l_n = 0 THEN
#         CALL cl_getmsg('axc-00567',g_lang) RETURNING ls_msg  #有異動資料(inaj_t)但料號不存在料件主檔(imaa_t)
#         LET g_xccc_d[l_ac].info = ls_msg  #错误信息
#         LET l_ac = l_ac + 1
#      ELSE
#         SELECT COUNT(*) INTO l_n FROM sfba_t 
#          WHERE sfbaent = g_enterprise AND sfbadocno =  g_xccc_d[l_ac].docno
#         IF l_n = 0 THEN
#            CALL cl_getmsg('axc-00568',g_lang) RETURNING ls_msg  #工單備料檔無此料號存在
#            LET g_xccc_d[l_ac].info = ls_msg  #错误信息
#            LET l_ac = l_ac + 1
#         END IF
#      END IF
#160503-00030#3 mark end
      LET l_ac = l_ac + 1   #160503-00030#3 add
   END FOREACH 

#160503-00030#3 add str
   #把需要的訊息先抓出來
   CALL cl_getmsg('axc-00569',g_lang) RETURNING ls_msg  #請款單付款金額與單身不合
#160503-00030#3 add end
   #10,檢查請款的單頭與單身不合
  #LET g_sql = " SELECT apca001,apcadocno,(apca103-apca106),(apca113-apca116),apca025 FROM apca_t ",           #160628-00009#1 mark
  #160913-00024#1-s
  #LET g_sql = " SELECT apca001,apcadocno,ABS((apca103-apca106)),ABS((apca113-apca116)),apca025 FROM apca_t ", #160628-00009#1 add
  LET g_sql = " SELECT apca001,apcadocno,ABS((apca103-apca106)),ABS((apca113-apca116)),apca025,",
               "        (CASE (apca001) WHEN '01' THEN 'aapt320' WHEN '02' THEN 'aapt320' WHEN '13' THEN 'aapt300' WHEN '17' THEN 'aapt300' ",
               "         WHEN '22' THEN 'aapt340' END), ",
               "        (SELECT gzzal003 FROM gzzal_t WHERE gzzal001=(CASE (apca001) WHEN '01' THEN 'aapt320' WHEN '02' THEN 'aapt320' WHEN '13' THEN 'aapt300' WHEN '17' THEN 'aapt300' 
                       WHEN '22' THEN 'aapt340' END) AND gzzal002='"||g_dlang||"') gzzal003",
               "  FROM apca_t ",
  #160913-00024#1-e
               "  WHERE apcadocdt BETWEEN '",g_bdate,"' AND '",g_edate ,"'",
               "    AND EXISTS (SELECT 1 FROM apcb_t,imaa_t",
               "                 WHERE apcbent = apcaent AND apcbdocno = apcadocno",
               "                   AND apcbent = imaaent AND apcb004 = imaa001) ",
               "    AND apcaent = ",g_enterprise," AND apcacomp = '",tm.xccccomp,"' AND apcald = '",tm.xcccld,"'",
               "    AND apcastus = 'Y' ",                           #170220-00006#2    
               "    AND apca001 IN('01','02','13','17','22') "   #160907-00003#1
   PREPARE axcq300_pr10 FROM g_sql
   DECLARE axcq300_cs10 CURSOR FOR axcq300_pr10
   FOREACH axcq300_cs10 INTO l_apca001,l_apcadocno,l_apca_sum1,l_apca_sum2,l_apca025,l_apca_inaj035,l_apca_gzzal003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:axcq300_cs10" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF  
#wujie 150422 --begin
#抓单身合计金额改为新逻辑，用正负值apcb022乘以金额，然后合计即可
      #2015/09/15 by stellar modify ----- (S)
      #調整算式
#      SELECT SUM(apcb103-apcb106)*apcb022,SUM(apcb113-apcb116)*apcb022 INTO l_apcb_sum5,l_apcb_sum6 FROM apcb_t
     #SELECT SUM((apcb103-apcb106)*apcb022),SUM((apcb113-apcb116)*apcb022) INTO l_apcb_sum5,l_apcb_sum6 FROM apcb_t           #160628-00009#1 mark
      SELECT ABS(SUM((apcb103-apcb106)*apcb022)),ABS(SUM((apcb113-apcb116)*apcb022)) INTO l_apcb_sum5,l_apcb_sum6 FROM apcb_t #160628-00009#1 add
      #2015/09/15 by stellar modify ----- (E)
       WHERE apcbent = g_enterprise AND apcbdocno = l_apcadocno 
 
#      #来源为仓退      
#      SELECT SUM(apcb103-apcb106),SUM(apcb113-apcb116) INTO l_apcb_sum1,l_apcb_sum2 FROM apcb_t
#       WHERE apcbent = g_enterprise AND apcbdocno = l_apcadocno AND apcb001 = 'apmt580'
#      #来源不为仓退       
#      SELECT SUM(apcb103-apcb106),SUM(apcb113-apcb116) INTO l_apcb_sum3,l_apcb_sum4 FROM apcb_t
#       WHERE apcbent = g_enterprise AND apcbdocno = l_apcadocno AND (apcb001 != 'apmt580' OR apcb001 IS NULL)
#      IF cl_null(l_apcb_sum1) THEN LET l_apcb_sum1=0 END IF
#      IF cl_null(l_apcb_sum2) THEN LET l_apcb_sum2=0 END IF
#      IF cl_null(l_apcb_sum3) THEN LET l_apcb_sum3=0 END IF
#      IF cl_null(l_apcb_sum4) THEN LET l_apcb_sum4=0 END IF
#      LET l_apcb_sum5=l_apcb_sum1+l_apcb_sum3  
#      LET l_apcb_sum6=l_apcb_sum2+l_apcb_sum4
#wujie 150422 --end 
      
     #若差異處理是沖期初開帳的暫估時,應付單頭金額除了抓(apca103-apca106),(apca113-apca116)外需再扣掉api_file裡的api05
     #暂时还没有，后续加入
     #170220-00006#2-s-mark 
     ##151015-00002#1-Start-Add
     #IF (l_apca001 MATCHES '0[24]' OR l_apca001 MATCHES '2*') THEN 
     #   LET l_apcb_sum5 = l_apcb_sum5 * -1 
     #   LET l_apcb_sum6 = l_apcb_sum6 * -1
     #END IF 
     ##151015-00002#1-End-Add
     #170220-00006#2-e-mark 
      IF (l_apcb_sum5 != l_apca_sum1 OR l_apcb_sum6 != l_apca_sum2) AND l_apca025 != '4' THEN 
         LET g_xccc_d[l_ac].xccc006 = ' '
         LET g_xccc_d[l_ac].xccc007 = ' '
         LET g_xccc_d[l_ac].docno = l_apcadocno 
         #160913-00024#1-s         
         LET g_xccc_d[l_ac].inaj035 = l_apca_inaj035
         LET g_xccc_d[l_ac].inaj035_desc = l_apca_gzzal003
         #160913-00024#1-e         
        #CALL cl_getmsg('axc-00569',g_lang) RETURNING ls_msg  #請款單付款金額與單身不合  #160503-00030#3 mark
         LET g_xccc_d[l_ac].info = ls_msg  #错误信息
         LET l_ac = l_ac + 1
      END IF
   END FOREACH
   
   
   #11，產品分類編號為NULL
   LET g_sql = " SELECT imaa001,'',",
              #160503-00030#3 mod str
              #"        '','','',''",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=imaaent AND imaal001=imaa001 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=imaaent AND imaal001=imaa001 AND imaal002='"||g_dlang||"') imaal004,",
               #160913-00024#1-s
               "        '',",
               "        '',",
               #160913-00024#1-e
               "        '',",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00570' AND gzze002='",g_lang,"') info",
              #160503-00030#3 mod end
               "   FROM imaa_t",
               "  WHERE imaaent = ",g_enterprise," AND imaa009 IS NULL"
   PREPARE axcq300_pr11 FROM g_sql
   DECLARE axcq300_cs11 CURSOR FOR axcq300_pr11
   FOREACH axcq300_cs11 INTO g_xccc_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:axcq300_cs11" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
#160503-00030#3 mark str
#      SELECT imaal003,imaal004 INTO g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_1 FROM imaal_t 
#          WHERE imaalent = g_enterprise AND imaal001 = g_xccc_d[l_ac].xccc006     
#      CALL cl_getmsg('axc-00570',g_lang) RETURNING ls_msg  #此料號對應產品分類為空
#      LET g_xccc_d[l_ac].info = ls_msg  #错误信息
#160503-00030#3 mark end
      LET l_ac = l_ac + 1
   END FOREACH   

   #12,累计至当月的完工入库数量 = 工单数量,才做应结未结工单明细
   LET g_sql = " SELECT sfaa010,sfac006,",
              #160503-00030#3 mod str
              #"        '','',sfaadocno,'',sfaa012",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='"||g_dlang||"') imaal004,",
               #160913-00024#1-s
               "        'asft300',",
               "        (SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = 'asft300' AND gzzal002='"||g_dlang||"') gzzal003,",
               #160913-00024#1-e
               "        sfaadocno,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00563' AND gzze002='",g_lang,"') info,",
               "        sfaa012",
              #160503-00030#3 mod end
               "   FROM sfaa_t,sfac_t",         
               "  WHERE sfaaent = sfacent AND sfaadocno = sfacdocno AND sfaa010 = sfac001 ",
               "    AND sfaadocdt BETWEEN '", g_bdate,"' AND '", g_edate,"'",
               "    AND sfaa012 = sfaa050 + sfaa051 ", #完工数 = 生产数
              #160503-00030#3 add str
              #把FOREACH裡判斷生產數量sfaa012 是否等於 完工入庫數量SUM(sfec009 組進SQL中
               "    AND sfaa012 = (SELECT SUM(sfec009) FROM sfea_t,sfec_t",
               "                    WHERE sfeaent = sfecent AND sfeadocno = sfecdocno",
               "                      AND sfeaent = ",g_enterprise," AND sfeastus = 'S'",
               "                      AND sfec001 = sfaadocno AND sfec004 = '1' AND sfea001 <= '",g_edate,"')",
              #160503-00030#3 add end
               "    AND (sfaa065 = '0' OR sfaa065 IS NULL) ",  #未结案
               "    AND sfaaent = ",g_enterprise,
               "    AND sfaastus <> 'M' ",    #wujie 150514
               "    AND sfaastus <> 'X' ",    #151015-00002#1 add
              #160503-00030#3 mod str
              #"    AND sfaasite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
              #"                        AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfaaent AND ooef001=sfaasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
              #160503-00030#3 mod end               
   PREPARE axcq300_pr12 FROM g_sql
   DECLARE axcq300_cs12 CURSOR FOR axcq300_pr12
   FOREACH axcq300_cs12 INTO g_xccc_d[l_ac].*,l_sfaa012
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:axcq300_cs12" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
#160503-00030#3 mark str
#      SELECT SUM(sfec009) INTO l_sfec009 FROM sfea_t,sfec_t
#       WHERE sfeaent = sfecent AND sfeadocno = sfecdocno AND sfeaent = g_enterprise AND sfeastus = 'S'
#         AND sfec001 = g_xccc_d[l_ac].docno AND sfec004 = '1' AND sfea001 <= g_edate
#         AND sfeaent = g_enterprise 
#      IF cl_null(l_sfec009) THEN
#         LET l_sfec009 = 0
#      END IF
#      IF l_sfec009 <> l_sfaa012  THEN
#         CONTINUE FOREACH
#      END IF
#      
#      SELECT imaal003,imaal004 INTO g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_1 FROM imaal_t 
#          WHERE imaalent = g_enterprise AND imaal001 = g_xccc_d[l_ac].xccc006     
#      CALL cl_getmsg('axc-00563',g_lang) RETURNING ls_msg  #應結工單尚未結案
#      LET g_xccc_d[l_ac].info = ls_msg  #错误信息
#160503-00030#3 mark end
      LET l_ac = l_ac + 1
   END FOREACH   

   #13，當月完工入庫,檢核有無報工
   LET g_sql = " SELECT DISTINCT sfec005,sfec006,",
              #160503-00030#3 mod str
              #"        '','',sfec001,''",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfecent AND imaal001=sfec005 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfecent AND imaal001=sfec005 AND imaal002='"||g_dlang||"') imaal004,",
               #160913-00024#1-s
               "        'asft300',",
               "        (SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = 'asft300' AND gzzal002='"||g_dlang||"') gzzal003,",
               #160913-00024#1-e
               "        sfec001,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00571' AND gzze002='",g_lang,"') info",
              #160503-00030#3 mod end
               "   FROM sfec_t,sfea_t ",
               "  WHERE sfeaent = sfecent AND sfeadocno = sfecdocno ",
               "    AND sfea001 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND NOT EXISTS (SELECT 1 FROM xcbi_t WHERE xcbient = sfecent AND xcbi002 = sfec001 AND xcbicomp = '",tm.xccccomp,"') ",
               "    AND sfeaent = ",g_enterprise," AND sfeastus = 'S'",
              #160503-00030#3 mod str
              #"    AND sfeasite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
              #"                        AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfeaent AND ooef001=sfeasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
              #160503-00030#3 mod end
   PREPARE axcq300_pr13 FROM g_sql
   DECLARE axcq300_cs13 CURSOR FOR axcq300_pr13
   FOREACH axcq300_cs13 INTO g_xccc_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:axcq300_cs13" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
#160503-00030#3 mark str
#      SELECT imaal003,imaal004 INTO g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_1 FROM imaal_t 
#          WHERE imaalent = g_enterprise AND imaal001 = g_xccc_d[l_ac].xccc006     
#      CALL cl_getmsg('axc-00571',g_lang) RETURNING ls_msg  #工單已入庫,但未有報工資料
#      LET g_xccc_d[l_ac].info = ls_msg  #错误信息
#160503-00030#3 mark end
      LET l_ac = l_ac + 1
   END FOREACH   
   
   #by wuxja add 150515 ---begin---
   #14.检查在imaa中有的料号（已审核），但imac没有数据
   #170105-00011#10---mark---s 
   #LET g_sql = " SELECT imaa001,'',",
   #           #160503-00030#3 mod str
   #           #"        '','','',''",
   #            "        (SELECT imaal003 FROM imaal_t WHERE imaalent=imaaent AND imaal001=imaa001 AND imaal002='"||g_dlang||"') imaal003,",
   #            "        (SELECT imaal004 FROM imaal_t WHERE imaalent=imaaent AND imaal001=imaa001 AND imaal002='"||g_dlang||"') imaal004,",
   #            #160913-00024#1-s
   #            "        '',",
   #            "        '',",
   #            #160913-00024#1-e
   #            "        '',",
   #            "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00709' AND gzze002='",g_lang,"') info",
   #           #160503-00030#3 mod end
   #            "   FROM imaa_t",
   #            "  WHERE imaaent = ",g_enterprise," AND imaastus = 'Y'",
   #           #160503-00030#3 mod str
   #           #"    AND imaa001 NOT IN (SELECT imac001 FROM imac_t WHERE imacent = ",g_enterprise,")"
   #            "    AND NOT EXISTS (SELECT 1 FROM imac_t WHERE imacent=imaaent AND imac001=imaa001)"
   #           #160503-00030#3 mod end
   #170105-00011#10---mark---e 
   #170105-00011#10---add---s 
   LET g_sql = " SELECT imaa001,'',",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=imaaent AND imaal001=imaa001 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=imaaent AND imaal001=imaa001 AND imaal002='"||g_dlang||"') imaal004,",
               "        '',",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00709' AND gzze002='",g_lang,"') info",
               "   FROM imaa_t",
               "   LEFT OUTER JOIN imac_t ON imacent=imaaent AND imac001=imaa001",
               "  WHERE imaaent = ",g_enterprise," AND imaastus = 'Y'",
               "    AND imac001 IS NULL )"   
   #170105-00011#10---add---e               
   PREPARE axcq300_pr14 FROM g_sql
   DECLARE axcq300_cs14 CURSOR FOR axcq300_pr14
   FOREACH axcq300_cs14 INTO g_xccc_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:axcq300_cs14" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
#160503-00030#3 mark str
#      SELECT imaal003,imaal004 INTO g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_1 FROM imaal_t 
#          WHERE imaalent = g_enterprise AND imaal001 = g_xccc_d[l_ac].xccc006     
#      CALL cl_getmsg('axc-00709',g_lang) RETURNING ls_msg  #此料号存在于料件主档imaa中，但不存在于料件资讯档imac中
#      LET g_xccc_d[l_ac].info = ls_msg  #错误信息
#160503-00030#3 mark end
      LET l_ac = l_ac + 1
   END FOREACH
   #by wuxja add 150515 ---end---   
   
   #add zhangllc 150722 --begin--
   #15.检查有工单或备料，没inaj的，且没有xcbb的
   #170105-00011#10---mark---s                      
   #LET g_sql = " SELECT sfaa010,'',",
   #           #160503-00030#3 mod str
   #           #"        '','',sfaadocno,''",
   #            "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='"||g_dlang||"') imaal003,",
   #            "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='"||g_dlang||"') imaal004,",
   #            #160913-00024#1-s
   #            "        'asft300',",
   #            "        (SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = 'asft300' AND gzzal002='"||g_dlang||"') gzzal003,",
   #            #160913-00024#1-e
   #            "        sfaadocno,",
   #            "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00723' AND gzze002='",g_lang,"') info",
   #           #160503-00030#3 mod end
   #            "   FROM sfaa_t ",         
   #            "  WHERE sfaadocdt BETWEEN '", g_bdate,"' AND '", g_edate,"'",
   #            "    AND (sfaa065 = '0' OR sfaa065 IS NULL) ",  #未结案
   #            "    AND sfaastus NOT IN ('M','X','N') ",    #成本结案
   #            "    AND sfaaent = ",g_enterprise,               
   #           #160503-00030#3 mod str
   #           #"    AND sfaasite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
   #           #"                        AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
   #            "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfaaent AND ooef001=sfaasite",
   #            "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
   #           #160503-00030#3 mod end
   #            "    AND NOT EXISTS (SELECT 1 FROM inaj_t WHERE inajent = sfaaent AND inajsite = sfaasite",
   #            "                                           AND inaj005 = sfaa010 AND inaj020= sfaadocno) ",
   #            "    AND NOT EXISTS (SELECT 1 FROM xcbb_t WHERE xcbbent = sfaaent AND xcbb003 = sfaa010 ",
   #            "                                           AND xcbb001 = ",tm.xccc004," AND xcbb002 = ",tm.xccc005,
   #            "                                           AND xcbbcomp = '",tm.xccccomp,"') ",
   #            " UNION ",
   #            " SELECT sfba006,'',",
   #           #160503-00030#3 mod str
   #           #"        '','',sfaadocno,''",
   #            "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfbaent AND imaal001=sfba006 AND imaal002='"||g_dlang||"') imaal003,",
   #            "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfbaent AND imaal001=sfba006 AND imaal002='"||g_dlang||"') imaal004,",
   #            #160913-00024#1-s
   #            "        'asft300',",
   #            "        (SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = 'asft300' AND gzzal002='"||g_dlang||"') gzzal003,",
   #            #160913-00024#1-e
   #            "        sfaadocno,",
   #            "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00723' AND gzze002='",g_lang,"') info",
   #           #160503-00030#3 mod end
   #            "   FROM sfba_t,sfaa_t ",         
   #            "  WHERE sfaaent = sfbaent AND sfaadocno=sfbadocno ",
   #            "    AND sfaadocdt BETWEEN '", g_bdate,"' AND '", g_edate,"'",
   #            "    AND (sfaa065 = '0' OR sfaa065 IS NULL) ",  #未结案
   #            "    AND sfaastus NOT IN ('M','X','N') ",    #成本结案
   #            "    AND sfaaent = ",g_enterprise,
   #           #160503-00030#3 mod str
   #           #"    AND sfaasite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
   #           #"                        AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
   #            "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfaaent AND ooef001=sfaasite",
   #            "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
   #           #160503-00030#3 mod end
   #            "    AND NOT EXISTS (SELECT 1 FROM inaj_t WHERE inajent = sfbaent AND inajsite = sfbasite",
   #            "                                           AND inaj005 = sfba006 AND inaj020 = sfbadocno) ",
   #            "    AND NOT EXISTS (SELECT 1 FROM xcbb_t WHERE xcbbent = sfbaent AND xcbb003 = sfba006 ",
   #            "                                           AND xcbb001 = ",tm.xccc004," AND xcbb002 = ",tm.xccc005,
   #            "                                           AND xcbbcomp = '",tm.xccccomp,"') "
   #170105-00011#10---mark---e                      
   #170105-00011#10---add---s
   LET g_sql = " SELECT sfaa010,'',",
              #160503-00030#3 mod str
              #"        '','',sfaadocno,''",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='"||g_dlang||"') imaal004,",
               "        sfaadocno,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00723' AND gzze002='",g_lang,"') info",
               "   FROM sfaa_t ",
               "   LEFT OUTER JOIN inaj_t ON inajent = sfaaent AND inajsite = sfaasite",
               "                         AND inaj005 = sfaa010 AND inaj020= sfaadocno",
               "   LEFT OUTER JOIN xcbb_t ON xcbbent = sfaaent AND xcbb003 = sfaa010 ",
               "                         AND xcbb001 = ",tm.xccc004," AND xcbb002 = ",tm.xccc005,
               "                         AND xcbbcomp = '",tm.xccccomp,"'",               
               "  WHERE sfaadocdt BETWEEN '", g_bdate,"' AND '", g_edate,"'",
               "    AND (sfaa065 = '0' OR sfaa065 IS NULL) ",  #未结案
               "    AND sfaastus NOT IN ('M','X','N') ",    #成本结案
               "    AND sfaaent = ",g_enterprise,               
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfaaent AND ooef001=sfaasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
               "    AND inaj005 IS NULL AND inaj020 IS NULL ) ",
               "    AND xcbb003 IS NULL ",
               " UNION ",
               " SELECT sfba006,'',",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfbaent AND imaal001=sfba006 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfbaent AND imaal001=sfba006 AND imaal002='"||g_dlang||"') imaal004,",
               "        sfaadocno,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00723' AND gzze002='",g_lang,"') info",
               "   FROM sfaa_t,sfba_t ",
               "   LEFT OUTER JOIN inaj_t ON inajent = sfbaent AND inajsite = sfbasite",
               "                      AND inaj005 = sfba006 AND inaj020 = sfbadocno ",
               "   LEFT OUTER JOIN xcbb_t ON xcbbent = sfbaent AND xcbb003 = sfba006 ",
               "                         AND xcbb001 = ",tm.xccc004," AND xcbb002 = ",tm.xccc005,
               "                         AND xcbbcomp = '",tm.xccccomp,"'",               
               "  WHERE sfaaent = sfbaent AND sfaadocno=sfbadocno ",
               "    AND sfaadocdt BETWEEN '", g_bdate,"' AND '", g_edate,"'",
               "    AND (sfaa065 = '0' OR sfaa065 IS NULL) ",  #未结案
               "    AND sfaastus NOT IN ('M','X','N') ",    #成本结案
               "    AND sfaaent = ",g_enterprise,
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfaaent AND ooef001=sfaasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
               "    AND inaj005 IS NULL AND inaj020 IS NULL) ",
               "    AND xcbb003 IS NULL "
   #170105-00011#10---add---e                
   PREPARE axcq300_pr15 FROM g_sql
   DECLARE axcq300_cs15 CURSOR FOR axcq300_pr15
   FOREACH axcq300_cs15 INTO g_xccc_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:axcq300_cs15" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
#160503-00030#3 mark str
#      CALL s_desc_get_item_desc(g_xccc_d[l_ac].xccc006) RETURNING g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_1
#      CALL cl_getmsg('axc-00723',g_lang) RETURNING ls_msg  #有工單或備料，但無庫存異動明細檔inaj_t資料和料件據點成本資料按期設定檔xcbb_t資料
#      LET g_xccc_d[l_ac].info = ls_msg  #错误信息
#160503-00030#3 mark end
      LET l_ac = l_ac + 1
   END FOREACH
   #add zhangllc 150722 --end--
   
   #151015-00002#1-Start-Add
   #16.雜收單設定判斷
   #1.檢核狀態為未庫存扣帳單者, 則提示異常 ,”庫存異動單未作庫存扣帳”
   #2.與 axct312 (xccw_t)作比對, 不存在axct312或是xccw202.成本金額 是null或0者, 則提示異常  “雜收單未設定入庫單價”
#160503-00030#3 mod str
#   LET g_sql = " SELECT UNIQUE inbb001,'',",   #mod zhangllc 151110 add unique
#              #160503-00030#3 mod str
#              #"        '','',inbadocno,'',",
#               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal003,",
#               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal004,",
#               "        inbadocno,'",ls_msg_axc00557,"'",
#              #160503-00030#3 mod end
#               "        inbastus,xccw202,inbb016 ",
#               "   FROM inba_t,inbb_t ",
#               "   LEFT OUTER JOIN xccw_t ON xccw006 = inbbdocno and xccw010 = inbb001 AND inbbent = xccwent ",
#               "                         AND xccw001 = ",tm.xccc001," ",
#               "  WHERE inbaent = ",g_enterprise," ",
#               "    AND inbbent = inbaent AND inbadocno = inbbdocno ",
#              #160503-00030#3 mod str
#              #"    AND inbasite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
#              #"                        AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
#               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inbaent AND ooef001=inbasite",
#               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
#              #160503-00030#3 mod end
#               "    AND inbasite = inbbsite ",               
#               "    AND inba002 BETWEEN '", g_bdate,"' AND '", g_edate,"'",   #扣帳日期
#               "    AND inbastus != 'X' ",                                    #未作廢
#               "    AND inba001 = '2' "                                       #雜收單               
   LET g_sql = " SELECT UNIQUE inbb001,'',",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inbbent AND imaal001=inbb001 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inbbent AND imaal001=inbb001 AND imaal002='"||g_dlang||"') imaal004,",
               #160913-00024#1-s
               "        'aint302',",
               "        (SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = 'aint302' AND gzzal002='"||g_dlang||"') gzzal003,",
               #160913-00024#1-e
               "        inbadocno,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00737' AND gzze002='",g_lang,"') info,",
               "        inbastus,xccw202,inbb016 ",
               "   FROM inba_t,inbb_t ",
               "   LEFT OUTER JOIN xccw_t ON xccw006 = inbbdocno and xccw010 = inbb001 AND inbbent = xccwent ",
               "                         AND xccw001 = ",tm.xccc001," ",
               "  WHERE inbaent = ",g_enterprise," ",
               "    AND inbbent = inbaent AND inbadocno = inbbdocno ",
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inbaent AND ooef001=inbasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
               "    AND inbasite = inbbsite ",               
               "    AND inba002 BETWEEN '", g_bdate,"' AND '", g_edate,"'",   #扣帳日期
               "    AND inbastus != 'X' AND inbastus != 'S'",                 #未作廢 且 非已過帳
               "    AND inba001 = '2' ",                                      #雜收單
               " UNION",
               " SELECT UNIQUE inbb001,inbb016,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inbbent AND imaal001=inbb001 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inbbent AND imaal001=inbb001 AND imaal002='"||g_dlang||"') imaal004,",
               #160913-00024#1-s
               "        'aint302',",
               "        (SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = 'aint302' AND gzzal002='"||g_dlang||"') gzzal003,",
               #160913-00024#1-e
               "        inbadocno,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00738' AND gzze002='",g_lang,"') info,",
               "        inbastus,xccw202,inbb016 ",
               "   FROM inba_t,inbb_t ",
               "   LEFT OUTER JOIN xccw_t ON xccw006 = inbbdocno and xccw010 = inbb001 AND inbbent = xccwent ",
               "                         AND xccw001 = ",tm.xccc001," ",
               "  WHERE inbaent = ",g_enterprise," ",
               "    AND inbbent = inbaent AND inbadocno = inbbdocno ",
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inbaent AND ooef001=inbasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
               "    AND inbasite = inbbsite ",               
               "    AND inba002 BETWEEN '", g_bdate,"' AND '", g_edate,"'",   #扣帳日期
               "    AND inbastus = 'S'",                                      #已過帳
               "    AND inba001 = '2' ",                                      #雜收單
               "    AND (xccw202 IS NULL OR xccw202 = 0)"               
#160503-00030#3 mod end               
   PREPARE axcq300_pr16 FROM g_sql
   DECLARE axcq300_cs16 CURSOR FOR axcq300_pr16
   FOREACH axcq300_cs16 INTO g_xccc_d[l_ac].*,l_inbastus,l_xccw202,l_inbb016
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:axcq300_cs16" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF 
#160503-00030#3 mark str     
#      #mod zhangllc 151110 --begin
#      #SELECT imaal003,imaal004 INTO g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_1 FROM imaal_t 
#      # WHERE imaalent = g_enterprise AND imaal001 = g_xccc_d[l_ac].xccc006
#      CALL s_desc_get_item_desc(g_xccc_d[l_ac].xccc006) RETURNING g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_1
#      #mod zhangllc 151110 --end
#      
#      IF l_inbastus != 'S' THEN
#         CALL cl_getmsg('axc-00737',g_lang) RETURNING ls_msg  #庫存異動單未作庫存扣帳
#         LET g_xccc_d[l_ac].info = ls_msg  #错误信息 
#         LET l_ac = l_ac + 1
#         
#         CONTINUE FOREACH #因為過帳單據，一定不會有axct312的資料(設定單價)         
#      END IF
#160503-00030#3 mark end
      IF cl_null(l_xccw202) or l_xccw202 = 0 THEN 
#        LET g_xccc_d[l_ac].xccc007 = l_inbb016
         #151201-00018 by whitney add start
         LET l_oocql004 = ''
         SELECT oocql004 INTO l_oocql004
           FROM oocql_t,gzcb_t
          WHERE oocqlent = g_enterprise
            AND oocql001 = gzcb004
            AND oocql002 = l_inbb016
            AND oocql003 = g_dlang
            AND gzcb001 = '24'
            AND gzcb002 = 'aint302'
         LET l_str = l_inbb016,l_oocql004
#        CALL cl_getmsg('axc-00738',g_lang) RETURNING ls_msg  #雜收單未設定入庫單價  #160503-00030#3 mark
         CALL cl_replace_err_msg(g_xccc_d[l_ac].info,l_str) RETURNING g_xccc_d[l_ac].info
         #151201-00018 by whitney add end
#        LET g_xccc_d[l_ac].info = ls_msg  #错误信息  #160503-00030#3 mark
         LET l_ac = l_ac + 1
     #160503-00030#3 add str
      ELSE
         LET l_ac = l_ac + 1
     #160503-00030#3 add end         
      END IF   
           
   END FOREACH   
   #151015-00002#1-End-Add
   
   #add zhangllc 151029 --begin--
   #17.如果参数没有启用特性码计算成本，检查axci120中一个料号只能存在一笔资料，且特征栏位为空格(关键词唯一性，只要判断特性非空格就可以了)
   IF g_para_data1 = 'N' THEN
      LET g_sql = " SELECT xcbb003,xcbb004,",
                 #160503-00030#3 mod str
                 #"        '','','',''",
                  "        (SELECT imaal003 FROM imaal_t WHERE imaalent=xcbbent AND imaal001=xcbb003 AND imaal002='"||g_dlang||"') imaal003,",
                  "        (SELECT imaal004 FROM imaal_t WHERE imaalent=xcbbent AND imaal001=xcbb003 AND imaal002='"||g_dlang||"') imaal004,",
                  #160913-00024#1-s
                  "        'axci120',",
                  "        (SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = 'axci120' AND gzzal002='"||g_dlang||"') gzzal003,",
                  #160913-00024#1-e
                  "        '',",
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00740' AND gzze002='",g_lang,"') info",
                 #160503-00030#3 mod end
                  "   FROM xcbb_t ",
                  "  WHERE xcbbent = ",g_enterprise,
                  "    AND xcbbcomp='",tm.xccccomp,"' ",
                  "    AND xcbb001 = ",tm.xccc004,
                  "    AND xcbb002 = ",tm.xccc005,
                  "    AND xcbb004 IS NOT NULL AND xcbb004 !=' ' "
      PREPARE axcq300_pr17 FROM g_sql
      DECLARE axcq300_cs17 CURSOR FOR axcq300_pr17
      FOREACH axcq300_cs17 INTO g_xccc_d[l_ac].*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:axcq300_cs17" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
#160503-00030#3 mark str
#         CALL s_desc_get_item_desc(g_xccc_d[l_ac].xccc006) RETURNING g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_1
#         CALL cl_getmsg('axc-00740',g_lang) RETURNING ls_msg  #一个料号只能存在一笔资料，且特征栏位为空格
#         LET g_xccc_d[l_ac].info = ls_msg  #错误信息
#160503-00030#3 mark end
         LET l_ac = l_ac + 1
      END FOREACH
   END IF
   #add zhangllc 151029 --end--
   
   #add zhangllc 151109-02 -begin
   #17.检查发料单中工单不存在于工单维护作业中
#170105-00011#10---mark---s            
#  #160503-00030#3 mod str
#  #LET g_sql = " SELECT UNIQUE '','','','',sfdc001,''",
#   #LET g_sql = " SELECT UNIQUE '','','','',sfdc001,",   #160913-00024#1 MARK
#               #160913-00024#1-s
#   LET g_sql = " SELECT UNIQUE '','','','',",            
#               "        '',",
#               "        'asft300',",
#               "        (SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = 'asft300' AND gzzal002='"||g_dlang||"') gzzal003,",
#               #160913-00024#1-e
#               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00401' AND gzze002='",g_lang,"') info",
#  #160503-00030#3 mod end   
#               "   FROM sfdc_t,sfda_t ",
#               "  WHERE sfdcent = sfdaent AND sfdcdocno = sfdadocno ",
#               "    AND sfdaent = ",g_enterprise,
#               "    AND sfda001 BETWEEN '", g_bdate,"' AND '", g_edate,"'",
#               "    AND sfdastus = 'S' ",
#               "    AND NOT EXISTS (SELECT 1 FROM sfaa_t WHERE sfaaent = sfdcent and sfaadocno = sfdc001)",
#               "    AND sfdc001 IS NOT NULL ",
#               "    AND sfda002 NOT IN ('16','26') ",
#              #160503-00030#3 mod str
#              #"    AND sfdasite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
#              #"                        AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
#               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfdaent AND ooef001=sfdasite",
#               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
#              #160503-00030#3 mod end
#               " UNION ",
#              #160503-00030#3 mod str
#              #" SELECT UNIQUE '','','','',sfdb001,''",
#              #" SELECT UNIQUE '','','','',sfdb001,",  160913-00024#1 MARK
#               #160913-00024#1-s
#               " SELECT UNIQUE '','','','',",            
#               "        'asft300',",
#               "        (SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = 'asft300' AND gzzal002='"||g_dlang||"') gzzal003,",
#               "        sfdb001,",
#               #160913-00024#1-e
#               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00401' AND gzze002='",g_lang,"') info",
#               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00401' AND gzze002='",g_lang,"') info",
#              #160503-00030#3 mod end
#               "   FROM sfdb_t,sfda_t ",
#               "  WHERE sfdbent = sfdaent AND sfdbdocno = sfdadocno ",
#               "    AND sfdaent = ",g_enterprise,
#               "    AND sfda001 BETWEEN '", g_bdate,"' AND '", g_edate,"'",
#               "    AND sfdastus = 'S' ",
#               "    AND NOT EXISTS (SELECT 1 FROM sfaa_t WHERE sfaaent = sfdbent and sfaadocno = sfdb001)",
#               "    AND sfdb001 IS NOT NULL ",
#               "    AND sfda002 IN ('15','25') ",
#              #160503-00030#3 mod str
#              #"    AND sfdasite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
#              #"                        AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
#               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfdaent AND ooef001=sfdasite",
#               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
#              #160503-00030#3 mod end
#170105-00011#10---mark---e            
   #170105-00011#10---add---s
   LET g_sql = " SELECT UNIQUE '','','','',sfdc001,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00401' AND gzze002='",g_lang,"') info",  
               "   FROM sfda_t,sfdc_t ",
               "   LEFT OUTER JOIN sfaa_t ON sfaaent = sfdcent and sfaadocno = sfdc001 ",
               "  WHERE sfdcent = sfdaent AND sfdcdocno = sfdadocno ",
               "    AND sfdaent = ",g_enterprise,
               "    AND sfda001 BETWEEN '", g_bdate,"' AND '", g_edate,"'",
               "    AND sfdastus = 'S' ",
               "    AND sfaadocno IS NULL ",
               "    AND sfdc001 IS NOT NULL ",
               "    AND sfda002 NOT IN ('16','26') ",
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfdaent AND ooef001=sfdasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
               " UNION ",
               " SELECT UNIQUE '','','','',sfdb001,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00401' AND gzze002='",g_lang,"') info",
               "   FROM sfda_t,sfdb_t ",
               "   LEFT OUTER JOIN sfaa_t ON sfaaent = sfdbent and sfaadocno = sfdb001 ",
               "  WHERE sfdbent = sfdaent AND sfdbdocno = sfdadocno ",
               "    AND sfdaent = ",g_enterprise,
               "    AND sfda001 BETWEEN '", g_bdate,"' AND '", g_edate,"'",
               "    AND sfdastus = 'S' ",
               "    AND sfaadocno IS NULL",
               "    AND sfdb001 IS NOT NULL ",
               "    AND sfda002 IN ('15','25') ",
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfdaent AND ooef001=sfdasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"   
   #170105-00011#10---add---e               
   PREPARE axcq300_pr18 FROM g_sql
   DECLARE axcq300_cs18 CURSOR FOR axcq300_pr18
   FOREACH axcq300_cs18 INTO g_xccc_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:axcq300_cs18" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
#160503-00030#3 mark str
#      CALL cl_getmsg('axc-00401',g_lang) RETURNING ls_msg  #工單不存在工單維護作業中
#      LET g_xccc_d[l_ac].info = ls_msg  #错误信息
#160503-00030#3 mark end
      LET l_ac = l_ac + 1
   END FOREACH
   #add zhangllc 151109-02 -end
   
   CALL g_xccc_d.deleteElement(l_ac)
   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.cnt
END FUNCTION

################################################################################
# Descriptions...: 建立報表TempTable
# Memo...........:
# Usage..........: CALL axcq300_create_temp()
#                :      RETURNING r_sucess
# Input parameter: 無
# Return code....: r_success   建立狀態(TRUE:成功 FALSE:失敗)
# Date & Author..: 2015/3/26 By liuym
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq300_create_temp()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   
   DROP TABLE axcq300_temp
   
   CREATE TEMP TABLE axcq300_temp(
      xccccomp        VARCHAR(10), 
      xccccomp_desc   VARCHAR(100), 
      xcccld          VARCHAR(5), 
      xcccld_desc     VARCHAR(100), 
      xccc004         SMALLINT, 
      xccc005         SMALLINT, 
      xccc001         VARCHAR(1), 
      xccc001_desc    VARCHAR(100), 
      xccc003         VARCHAR(10), 
      xccc003_desc    VARCHAR(100), 
      xccc006         VARCHAR(40), 
      xccc007         VARCHAR(256), 
      imaal003        VARCHAR(255), 
      imaal004        VARCHAR(255), 
      lbl_docno       VARCHAR(30), 
      lbl_err         VARCHAR(1000)
      )
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axcq300_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 將查詢畫面上的資料寫入報表TempTable
# Memo...........:
# Usage..........: CALL axcq300_ins_temp
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/3/26 By liuym
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq300_ins_temp()
DEFINE l_cnt               LIKE type_t.num10
DEFINE l_xccc001_desc      LIKE type_t.chr100   #160503-00030#3 add

   LET l_cnt = g_xccc_d.getLength()

#160503-00030#3 add str
   IF NOT cl_null(tm.xccccomp_desc) THEN
      LET tm.xccccomp_desc = tm.xccccomp,'(',tm.xccccomp_desc,')' CLIPPED
   ELSE
      LET tm.xccccomp_desc = tm.xccccomp
   END IF
   IF NOT cl_null(tm.xcccld_desc) THEN
      LET tm.xcccld_desc = tm.xcccld,'(',tm.xcccld_desc,')' CLIPPED
   ELSE
      LET tm.xcccld_desc = tm.xcccld
   END IF
   IF NOT cl_null(tm.xccc003_desc) THEN
      LET tm.xccc003_desc = tm.xccc003,'(',tm.xccc003_desc,')' CLIPPED
   ELSE 
      LET tm.xccc003_desc = tm.xccc003
   END IF  
   IF NOT cl_null(tm.xccc001) THEN
      SELECT gzcbl004 INTO l_xccc001_desc FROM gzcbl_t
       WHERE gzcbl001='8914' AND gzcbl002=tm.xccc001 AND gzcbl003=g_dlang  
      IF NOT cl_null(tm.xccc001_desc) THEN
         LET tm.xccc001_desc=tm.xccc001,".",l_xccc001_desc,'(',tm.xccc001_desc,')' CLIPPED
      ELSE
         LET tm.xccc001_desc=tm.xccc001,".",l_xccc001_desc CLIPPED   
      END IF
   END IF   
#160503-00030#3 add end

   FOR l_cnt = 1 TO g_xccc_d.getLength()
      INSERT INTO axcq300_temp
                  (xccccomp,xccccomp_desc,xcccld,xcccld_desc,xccc004,
                   xccc005,xccc001,xccc001_desc,xccc003,xccc003_desc,                   
                   xccc006,xccc007,imaal003,imaal004,lbl_docno,lbl_err)
           VALUES (tm.xccccomp,tm.xccccomp_desc,tm.xcccld,tm.xcccld_desc,tm.xccc004,
                   tm.xccc005,tm.xccc001,tm.xccc001_desc,tm.xccc003,tm.xccc003_desc,
                   g_xccc_d[l_cnt].xccc006,g_xccc_d[l_cnt].xccc007,
                   g_xccc_d[l_cnt].xccc006_desc,g_xccc_d[l_cnt].xccc006_desc_1,
                   g_xccc_d[l_cnt].docno,g_xccc_d[l_cnt].info)   
   END FOR                  

END FUNCTION

################################################################################
# Descriptions...: 效能优化
# #161205-00025#19
################################################################################
PRIVATE FUNCTION axcq300_ins_temp_new()
DEFINE l_xccc001_desc    LIKE type_t.chr100
DEFINE l_pmds011_str1    STRING
DEFINE ls_msg            STRING

   IF NOT cl_null(tm.xccccomp_desc) THEN
      LET tm.xccccomp_desc = tm.xccccomp,'(',tm.xccccomp_desc,')' CLIPPED
   ELSE
      LET tm.xccccomp_desc = tm.xccccomp
   END IF
   IF NOT cl_null(tm.xcccld_desc) THEN
      LET tm.xcccld_desc = tm.xcccld,'(',tm.xcccld_desc,')' CLIPPED
   ELSE
      LET tm.xcccld_desc = tm.xcccld
   END IF
   IF NOT cl_null(tm.xccc003_desc) THEN
      LET tm.xccc003_desc = tm.xccc003,'(',tm.xccc003_desc,')' CLIPPED
   ELSE 
      LET tm.xccc003_desc = tm.xccc003
   END IF  
   IF NOT cl_null(tm.xccc001) THEN
      SELECT gzcbl004 INTO l_xccc001_desc FROM gzcbl_t
       WHERE gzcbl001='8914' AND gzcbl002=tm.xccc001 AND gzcbl003=g_dlang  
      IF NOT cl_null(tm.xccc001_desc) THEN
         LET tm.xccc001_desc=tm.xccc001,".",l_xccc001_desc,'(',tm.xccc001_desc,')' CLIPPED
      ELSE
         LET tm.xccc001_desc=tm.xccc001,".",l_xccc001_desc CLIPPED   
      END IF
   END IF
   
   LET l_pmds011_str1 =  s_aap_get_acc_str('2061',"gzcb003 = 'Y' ")
   LET l_pmds011_str1 = s_fin_get_wc_str(l_pmds011_str1) 
   
   #1.此期料件异动是否全部参于成本阶计算(axcp120)
   LET g_sql = " INSERT INTO axcq300_temp ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",
               "        inaj005,inaj006,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal004,",
               "        inaj001,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00557' AND gzze002='",g_lang,"') info",
               "   FROM inaj_t ",
               "  WHERE inaj022 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND NOT EXISTS (SELECT 1 FROM inaa_t ",
               "                     WHERE inaaent = inajent AND inaasite = inajsite AND inaa001 = inaj008",
               "                       AND inaa010 = 'N'",
               "                       AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent = inaaent AND ooef001 = inaasite",
               "                                      AND ooefstus = 'Y' AND ooef017 = '",tm.xccccomp,"'))",
               "    AND (NOT EXISTS (SELECT 1 FROM xcbb_t WHERE xcbbent = inajent AND xcbb003 = inaj005",
               "                                            AND xcbbcomp = '",tm.xccccomp,"'",
               "                                            AND xcbb001 = ",tm.xccc004," AND xcbb002 = ",tm.xccc005,") " #160929-00039#1 reduce ,
               #170207-00035#1 marked-S
#               IF cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'Y' THEN
#                  LET g_sql = g_sql, "OR NOT EXISTS (SELECT 1 FROM xcbb_t WHERE xcbbent = inajent AND xcbb004 = inaj006",
#                                     " AND xcbbcomp = '",tm.xccccomp,"'",
#                                     " AND xcbb001 = ",tm.xccc004," AND xcbb002 = ",tm.xccc005,") "
#               END IF 
               #170207-00035#1 marked-E
               LET g_sql = g_sql , " ) " ,
               "    AND inajent = ",g_enterprise,     
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inajent AND ooef001=inajsite",        
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
   PREPARE axcq300_pr1n FROM g_sql
   EXECUTE axcq300_pr1n
               
   #2.入庫/退貨單与请款单未匹配
   LET g_sql = " INSERT INTO axcq300_temp ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        pmdt006,pmdt007,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=pmdtent AND imaal001=pmdt006 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=pmdtent AND imaal001=pmdt006 AND imaal002='"||g_dlang||"') imaal004,",
               "        pmdtdocno,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00558' AND gzze002='",g_lang,"') info",             
               "   FROM pmdt_t,pmds_t ",
               "  WHERE pmdsent = pmdtent AND pmdsdocno = pmdtdocno ",
               "    AND pmds001 BETWEEN '",g_bdate,"' AND '",g_edate,"'", 
               "    AND pmds000 IN ('3','4','6','7','12')  AND pmdt005 != '9'",   #排除样品
               "    AND pmds011 IN ",l_pmds011_str1 CLIPPED,                    
               "    AND ( pmdt056 + pmdt066 < pmdt024 OR",
               "         (pmdt056 IS NULL AND pmdt024 > 0 AND pmdt056 < pmdt024) OR", 
               "         (pmds000 = '7' AND pmds100 = '5' AND NOT EXISTS (SELECT 1 FROM apcb_t WHERE apcb008 = pmdtdocno AND apcb009 = pmdtseq)))", #无请款资料匹配纯折让的部分
               "    AND pmdsent = ",g_enterprise,
               "    AND pmdsstus <> 'X' ",    
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=pmdsent AND ooef001=pmdssite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
   PREPARE axcq300_pr2n FROM g_sql
   EXECUTE axcq300_pr2n
   
   #3.应付帐款数量或金额<0（入库单+仓退单）
   LET g_sql = " INSERT INTO axcq300_temp ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        apcb004,'',",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=apcbent AND imaal001=apcb004 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=apcbent AND imaal001=apcb004 AND imaal002='"||g_dlang||"') imaal004,",
               "        apcadocno,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00559' AND gzze002='",g_lang,"') info",
               "   FROM apca_t,apcb_t",
               "  WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
               "    AND apcadocdt BETWEEN '",g_bdate,"' AND '",g_edate ,"'",   
               "    AND (apca001 = '13' OR apca001 = '22') ",              
               "    AND ((apcb007 > 0 AND apcb101 < 0) OR ",      #判斷有數量而無金額
               "         (apcb007 > 0 AND apcb105 < 0) OR ",
               "         (apcb007 > 0 AND apcb111 < 0) OR ",
               "         (apcb007 > 0 AND apcb115 < 0) OR ",         
               "         (apcb007 < 0 AND apcb101 > 0) OR ",      #判斷無數量而有金額
               "         (apcb007 < 0 AND apcb105 > 0) OR ",
               "         (apcb007 < 0 AND apcb111 > 0) OR ",
               "         (apcb007 < 0 AND apcb115 > 0)) ",
               "    AND apcaent = ",g_enterprise," AND apcald = '",tm.xcccld,"'",
               "    AND apcacomp ='",tm.xccccomp,"'"
   PREPARE axcq300_pr3n FROM g_sql
   EXECUTE axcq300_pr3n           
                                           
   #4，檢查統計檔期未庫存小於零                                         
   LET g_sql = " INSERT INTO axcq300_temp ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        inat001,inat002,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inatent AND imaal001=inat001 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inatent AND imaal001=inat001 AND imaal002='"||g_dlang||"') imaal004,",
               "        '',",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00560' AND gzze002='",g_lang,"') info",
               "   FROM inat_t ",
               "  WHERE inatent = ",g_enterprise," AND inat008 = ",tm.xccc004,
               "    AND inat009 = ",tm.xccc005," AND inat015 < 0 ",
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inatent AND ooef001=inatsite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
   PREPARE axcq300_pr4n FROM g_sql
   EXECUTE axcq300_pr4n                                                 
   
   #5.每日工時檔中, 有無輸入上期前就已結案的工單
   LET g_sql = " INSERT INTO axcq300_temp ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        sfac001,sfac006,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfacent AND imaal001=sfac001 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfacent AND imaal001=sfac001 AND imaal002='"||g_dlang||"') imaal004,",
               "        xcbi002,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00562' AND gzze002='",g_lang,"') info",
               "   FROM xcbh_t,xcbi_t",
               "   LEFT OUTER JOIN sfaa_t ON xcbient = sfaaent AND xcbi002 = sfaadocno AND sfaastus != 'X' AND sfaa048 IS NOT NULL",
               "   LEFT OUTER JOIN sfac_t ON xcbient = sfacent AND xcbi002 = sfacdocno",
               "  WHERE xcbhent = xcbient AND xcbhdocno = xcbidocno ",
               "    AND xcbh001 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND (xcbi201 != 0 OR xcbi202 != 0 OR xcbi203 != 0 OR xcbi204 != 0) ",
               "    AND xcbhent = ",g_enterprise," AND xcbhcomp = '",tm.xccccomp,"'",
               "    AND sfac001 IS NULL",
               " UNION",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        sfac001,sfac006,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfacent AND imaal001=sfac001 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfacent AND imaal001=sfac001 AND imaal002='"||g_dlang||"') imaal004,",
               "        xcbi002,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00561' AND gzze002='",g_lang,"') info",             
               "   FROM xcbh_t,xcbi_t",
               "   LEFT OUTER JOIN sfaa_t ON xcbient = sfaaent AND xcbi002 = sfaadocno AND sfaastus != 'X' AND sfaa048 IS NOT NULL",
               "   LEFT OUTER JOIN sfac_t ON xcbient = sfacent AND xcbi002 = sfacdocno",
               "  WHERE xcbhent = xcbient AND xcbhdocno = xcbidocno ",
               "    AND xcbh001 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND (xcbi201 != 0 OR xcbi202 != 0 OR xcbi203 != 0 OR xcbi204 != 0) ",
               "    AND xcbhent = ",g_enterprise," AND xcbhcomp = '",tm.xccccomp,"'",
               "    AND sfac001 IS NOT NULL AND sfaa048 IS NOT NULL",
               "    AND ( to_char(sfaa048,'YYYY') < ",tm.xccc004," OR ",
               "         (to_char(sfaa048,'YYYY') = ",tm.xccc004," AND to_char(sfaa048,'MM') < ",tm.xccc005,") )"               
   PREPARE axcq300_pr5n FROM g_sql
   EXECUTE axcq300_pr5n   
      
   #7,應發數量=0 but 已發數量<>0
   LET g_sql = " INSERT INTO axcq300_temp ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        sfba006,sfba021,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfbaent AND imaal001=sfba006 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfbaent AND imaal001=sfba006 AND imaal002='"||g_dlang||"') imaal004,",
               "        sfaadocno,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00565' AND gzze002='",g_lang,"') info",
               "   FROM sfaa_t,sfba_t",
               "  WHERE sfaaent = sfbaent AND sfaadocno = sfbadocno ",
               "    AND sfaaent  =",g_enterprise,  
               "    AND sfba013 = 0 AND (sfba016 <> 0 OR sfba025 <> 0)",
               #"    AND (sfaa038 >= '",g_bdate,"' OR sfaa038 IS NULL)",    #161223-00018#1 MARK
               "    AND (sfaa048 >= '",g_bdate,"' OR sfaa048 IS NULL)",   #161223-00018#1 MOD
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfbaent AND ooef001=sfbasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
   PREPARE axcq300_pr7n FROM g_sql
   EXECUTE axcq300_pr7n
   
   #8,檢查有inaj_t 但無工單編號
   LET g_sql = " INSERT INTO axcq300_temp ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        inaj005,inaj006,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal004,",
               "        inaj020,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00566' AND gzze002='",g_lang,"') info",
               "   FROM inaj_t",
               "  WHERE inaj022 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND inaj015 LIKE 'asft31%' AND inaj004 != 0 ",        #inaj015:发料，领料，超领等
               "    AND NOT EXISTS (SELECT 1 FROM sfaa_t WHERE sfaaent = inajent AND sfaadocno = inaj020) ",
               "    AND inajent = ",g_enterprise,
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inajent AND ooef001=inajsite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
   PREPARE axcq300_pr8n FROM g_sql
   EXECUTE axcq300_pr8n           

   #9.檢查有inaj_t,但無備料檔
   LET g_sql = " INSERT INTO axcq300_temp ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        inaj005,inaj006,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal004,",
               "        inaj020,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00567' AND gzze002='",g_lang,"') info",
               "   FROM inaj_t ",
               "  WHERE inaj022 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND inaj015 LIKE 'asft31%' AND inaj004 != 0 ",        #inaj015:发料，领料，超领等
               "    AND NOT EXISTS (SELECT 1 FROM inaa_t WHERE inaaent=inajent AND inaasite=inajsite",
               "                                           AND inaa001=inaj008 AND inaa010='N')",               
               "    AND inajent = ",g_enterprise,
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inajent AND ooef001=inajsite",
               "                                       AND ooefstus='Y' AND ooef017='",tm.xccccomp,"')",               
               "    AND NOT EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001=inaj005)",
               " UNION",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        inaj005,inaj006,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inajent AND imaal001=inaj005 AND imaal002='"||g_dlang||"') imaal004,",
               "        inaj020,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00568' AND gzze002='",g_lang,"') info",
               "   FROM inaj_t ",
               "  WHERE inaj022 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND inaj015 LIKE 'asft31%' AND inaj004 != 0 ",        #inaj015:发料，领料，超领等
               "    AND NOT EXISTS (SELECT 1 FROM inaa_t WHERE inaaent=inajent AND inaasite=inajsite",
               "                                           AND inaa001=inaj008 AND inaa010='N')",
               "    AND inajent = ",g_enterprise,
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inajent AND ooef001=inajsite",
               "                                       AND ooefstus='Y' AND ooef017='",tm.xccccomp,"')",
               "    AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001=inaj005)",
               "    AND NOT EXISTS (SELECT 1 FROM sfba_t WHERE sfbaent=inajent AND sfbadocno=inaj020)"
   PREPARE axcq300_pr9n FROM g_sql
   EXECUTE axcq300_pr9n


   #把需要的訊息先抓出來
   CALL cl_getmsg('axc-00569',g_lang) RETURNING ls_msg  #請款單付款金額與單身不合
   #10,檢查請款的單頭與單身不合
   LET g_sql = " INSERT INTO axcq300_temp ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",  
               "        '','','','',apcadocno,'",ls_msg,"'",
               "   FROM ( ",
               "         SELECT apca001,apcadocno,ABS((apca103-apca106)) a,ABS((apca113-apca116)) b,apca025, ",
               "                CASE WHEN (apca001='02' OR apca001='22') THEN ABS(SUM((apcb103-apcb106)*apcb022) OVER(PARTITION BY apcadocno))*-1 ELSE ABS(SUM((apcb103-apcb106)*apcb022) OVER(PARTITION BY apcadocno)) END a1,",
               "                CASE WHEN (apca001='02' OR apca001='22') THEN ABS(SUM((apcb113-apcb116)*apcb022) OVER(PARTITION BY apcadocno))*-1 ELSE ABS(SUM((apcb113-apcb116)*apcb022) OVER(PARTITION BY apcadocno)) END b1",
               "           FROM apca_t,apcb_t ", 
               "          WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
               "            AND apcadocdt BETWEEN '",g_bdate,"' AND '",g_edate ,"'",
               "            AND EXISTS (SELECT 1 FROM apcb_t,imaa_t",
               "                         WHERE apcbent = apcaent AND apcbdocno = apcadocno",
               "                           AND apcbent = imaaent AND apcb004 = imaa001) ",
               "            AND apcaent = ",g_enterprise," AND apcacomp = '",tm.xccccomp,"' AND apcald = '",tm.xcccld,"'",
               "            AND apca001 IN('01','02','13','17','22') ",               
               "        )",               
               "  WHERE (a1<>a OR b1<>b) AND apca025 <> '4' "  
   PREPARE axcq300_pr10n FROM g_sql
   EXECUTE axcq300_pr10n
   
   #11，產品分類編號為NULL
   LET g_sql = " INSERT INTO axcq300_temp ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        imaa001,'',",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=imaaent AND imaal001=imaa001 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=imaaent AND imaal001=imaa001 AND imaal002='"||g_dlang||"') imaal004,",
               "        '',",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00570' AND gzze002='",g_lang,"') info",
               "   FROM imaa_t",
               "  WHERE imaaent = ",g_enterprise," AND imaa009 IS NULL"
   PREPARE axcq300_pr11n FROM g_sql
   EXECUTE axcq300_pr11n   

   #12,累计至当月的完工入库数量 = 工单数量,才做应结未结工单明细
   LET g_sql = " INSERT INTO axcq300_temp ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        sfaa010,sfac006,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='"||g_dlang||"') imaal004,",
               "        sfaadocno,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00563' AND gzze002='",g_lang,"') info",
               "   FROM sfaa_t,sfac_t",         
               "  WHERE sfaaent = sfacent AND sfaadocno = sfacdocno AND sfaa010 = sfac001 ",
               "    AND sfaadocdt BETWEEN '", g_bdate,"' AND '", g_edate,"'",
               "    AND sfaa012 = sfaa050 + sfaa051 ", #完工数 = 生产数
              #把FOREACH裡判斷生產數量sfaa012 是否等於 完工入庫數量SUM(sfec009 組進SQL中
               "    AND sfaa012 = (SELECT SUM(sfec009) FROM sfea_t,sfec_t",
               "                    WHERE sfeaent = sfecent AND sfeadocno = sfecdocno",
               "                      AND sfeaent = ",g_enterprise," AND sfeastus = 'S'",
               "                      AND sfec001 = sfaadocno AND sfec004 = '1' AND sfea001 <= '",g_edate,"')",
               "    AND (sfaa065 = '0' OR sfaa065 IS NULL) ",  #未结案
               "    AND sfaaent = ",g_enterprise,
               "    AND sfaastus <> 'M' ",  
               "    AND sfaastus <> 'X' ",  
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfaaent AND ooef001=sfaasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"               
   PREPARE axcq300_pr12n FROM g_sql
   EXECUTE axcq300_pr12n

   #13，當月完工入庫,檢核有無報工
   LET g_sql = " INSERT INTO axcq300_temp ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        sfec005,sfec006,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfecent AND imaal001=sfec005 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfecent AND imaal001=sfec005 AND imaal002='"||g_dlang||"') imaal004,",
               "        sfec001,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00571' AND gzze002='",g_lang,"') info",
               "   FROM sfec_t,sfea_t ",
               "  WHERE sfeaent = sfecent AND sfeadocno = sfecdocno ",
               "    AND sfea001 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND NOT EXISTS (SELECT 1 FROM xcbi_t WHERE xcbient = sfecent AND xcbi002 = sfec001 AND xcbicomp = '",tm.xccccomp,"') ",
               "    AND sfeaent = ",g_enterprise," AND sfeastus = 'S'",
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfeaent AND ooef001=sfeasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
   PREPARE axcq300_pr13n FROM g_sql
   EXECUTE axcq300_pr13n  

   #14.检查在imaa中有的料号（已审核），但imac没有数据
   LET g_sql = " INSERT INTO axcq300_temp ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        imaa001,'',",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=imaaent AND imaal001=imaa001 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=imaaent AND imaal001=imaa001 AND imaal002='"||g_dlang||"') imaal004,",
               "        '',",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00709' AND gzze002='",g_lang,"') info",
               "   FROM imaa_t",
               "  WHERE imaaent = ",g_enterprise," AND imaastus = 'Y'",
               "    AND NOT EXISTS (SELECT 1 FROM imac_t WHERE imacent=imaaent AND imac001=imaa001)"
   PREPARE axcq300_pr14n FROM g_sql
   EXECUTE axcq300_pr14n

   #15.检查有工单或备料，没inaj的，且没有xcbb的
   LET g_sql = " INSERT INTO axcq300_temp ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        sfaa010,'',",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='"||g_dlang||"') imaal004,",
               "        sfaadocno,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00723' AND gzze002='",g_lang,"') info",
               "   FROM sfaa_t ",         
               "  WHERE sfaadocdt BETWEEN '", g_bdate,"' AND '", g_edate,"'",
               "    AND (sfaa065 = '0' OR sfaa065 IS NULL) ",  #未结案
               "    AND sfaastus NOT IN ('M','X','N') ",    #成本结案
               "    AND sfaaent = ",g_enterprise,               
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfaaent AND ooef001=sfaasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
               "    AND NOT EXISTS (SELECT 1 FROM inaj_t WHERE inajent = sfaaent AND inajsite = sfaasite",
               "                                           AND inaj005 = sfaa010 AND inaj020= sfaadocno) ",
               "    AND NOT EXISTS (SELECT 1 FROM xcbb_t WHERE xcbbent = sfaaent AND xcbb003 = sfaa010 ",
               "                                           AND xcbb001 = ",tm.xccc004," AND xcbb002 = ",tm.xccc005,
               "                                           AND xcbbcomp = '",tm.xccccomp,"') ",
               " UNION ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        sfba006,'',",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfbaent AND imaal001=sfba006 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfbaent AND imaal001=sfba006 AND imaal002='"||g_dlang||"') imaal004,",
               "        sfaadocno,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00723' AND gzze002='",g_lang,"') info",
               "   FROM sfba_t,sfaa_t ",         
               "  WHERE sfaaent = sfbaent AND sfaadocno=sfbadocno ",
               "    AND sfaadocdt BETWEEN '", g_bdate,"' AND '", g_edate,"'",
               "    AND (sfaa065 = '0' OR sfaa065 IS NULL) ",  #未结案
               "    AND sfaastus NOT IN ('M','X','N') ",    #成本结案
               "    AND sfaaent = ",g_enterprise,
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfaaent AND ooef001=sfaasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
               "    AND NOT EXISTS (SELECT 1 FROM inaj_t WHERE inajent = sfbaent AND inajsite = sfbasite",
               "                                           AND inaj005 = sfba006 AND inaj020 = sfbadocno) ",
               "    AND NOT EXISTS (SELECT 1 FROM xcbb_t WHERE xcbbent = sfbaent AND xcbb003 = sfba006 ",
               "                                           AND xcbb001 = ",tm.xccc004," AND xcbb002 = ",tm.xccc005,
               "                                           AND xcbbcomp = '",tm.xccccomp,"') "
   PREPARE axcq300_pr15n FROM g_sql
   EXECUTE axcq300_pr15n

   #16.雜收單設定判斷
   #1.檢核狀態為未庫存扣帳單者, 則提示異常 ,”庫存異動單未作庫存扣帳”
   #2.與 axct312 (xccw_t)作比對, 不存在axct312或是xccw202.成本金額 是null或0者, 則提示異常  “雜收單未設定入庫單價”         
   LET g_sql = " INSERT INTO axcq300_temp ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        inbb001,'',",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inbbent AND imaal001=inbb001 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inbbent AND imaal001=inbb001 AND imaal002='"||g_dlang||"') imaal004,",
               "        inbadocno,",
               "        CASE WHEN (xccw202 IS NULL OR xccw202 = 0) ",
               "             THEN inbb016||(SELECT oocql004 FROM oocql_t,gzcb_t ",
               "                             WHERE oocqlent = inbbent ",
               "                               AND oocql001 = gzcb004",
               "                               AND oocql002 = inbb016",
               "                               AND oocql003 = '",g_dlang,"'",
               "                               AND gzcb001 = '24'",
               "                               AND gzcb002 = 'aint302') ",
               "             ELSE (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00738' AND gzze002='",g_lang,"') END info ",
               "   FROM inba_t,inbb_t ",
               "   LEFT OUTER JOIN xccw_t ON xccw006 = inbbdocno and xccw010 = inbb001 AND inbbent = xccwent ",
               "                         AND xccw001 = ",tm.xccc001," ",
               "  WHERE inbaent = ",g_enterprise," ",
               "    AND inbbent = inbaent AND inbadocno = inbbdocno ",
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inbaent AND ooef001=inbasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
               "    AND inbasite = inbbsite ",               
               "    AND inba002 BETWEEN '", g_bdate,"' AND '", g_edate,"'",   #扣帳日期
               "    AND inbastus != 'X' AND inbastus != 'S'",                 #未作廢 且 非已過帳
               "    AND inba001 = '2' ",                                      #雜收單
               " UNION",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        inbb001,inbb016,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=inbbent AND imaal001=inbb001 AND imaal002='"||g_dlang||"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=inbbent AND imaal001=inbb001 AND imaal002='"||g_dlang||"') imaal004,",
               "        inbadocno,",
               "        CASE WHEN (xccw202 IS NULL OR xccw202 = 0) ",
               "             THEN inbb016||(SELECT oocql004 FROM oocql_t,gzcb_t ",
               "                             WHERE oocqlent = inbbent ",
               "                               AND oocql001 = gzcb004",
               "                               AND oocql002 = inbb016",
               "                               AND oocql003 = '",g_dlang,"'",
               "                               AND gzcb001 = '24'",
               "                               AND gzcb002 = 'aint302') ",
               "             ELSE (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00738' AND gzze002='",g_lang,"') END info ",
               "   FROM inba_t,inbb_t ",
               "   LEFT OUTER JOIN xccw_t ON xccw006 = inbbdocno and xccw010 = inbb001 AND inbbent = xccwent ",
               "                         AND xccw001 = ",tm.xccc001," ",
               "  WHERE inbaent = ",g_enterprise," ",
               "    AND inbbent = inbaent AND inbadocno = inbbdocno ",
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=inbaent AND ooef001=inbasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
               "    AND inbasite = inbbsite ",               
               "    AND inba002 BETWEEN '", g_bdate,"' AND '", g_edate,"'",   #扣帳日期
               "    AND inbastus = 'S'",                                      #已過帳
               "    AND inba001 = '2' ",                                      #雜收單
               "    AND (xccw202 IS NULL OR xccw202 = 0)"                             
   PREPARE axcq300_pr16n FROM g_sql
   EXECUTE axcq300_pr16n  

   #17.如果参数没有启用特性码计算成本，检查axci120中一个料号只能存在一笔资料，且特征栏位为空格(关键词唯一性，只要判断特性非空格就可以了)
   IF g_para_data1 = 'N' THEN
      LET g_sql = " INSERT INTO axcq300_temp ",
                  " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
                  "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
                  "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
                  "        xcbb003,xcbb004,",
                  "        (SELECT imaal003 FROM imaal_t WHERE imaalent=xcbbent AND imaal001=xcbb003 AND imaal002='"||g_dlang||"') imaal003,",
                  "        (SELECT imaal004 FROM imaal_t WHERE imaalent=xcbbent AND imaal001=xcbb003 AND imaal002='"||g_dlang||"') imaal004,",
                  "        '',",
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00740' AND gzze002='",g_lang,"') info",
                  "   FROM xcbb_t ",
                  "  WHERE xcbbent = ",g_enterprise,
                  "    AND xcbbcomp='",tm.xccccomp,"' ",
                  "    AND xcbb001 = ",tm.xccc004,
                  "    AND xcbb002 = ",tm.xccc005,
                  "    AND xcbb004 IS NOT NULL AND xcbb004 !=' ' "
      PREPARE axcq300_pr17n FROM g_sql
      EXECUTE axcq300_pr17n
   END IF

   #17.检查发料单中工单不存在于工单维护作业中
   LET g_sql = " INSERT INTO axcq300_temp ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        '','','','',sfdc001,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00401' AND gzze002='",g_lang,"') info",  
               "   FROM sfdc_t,sfda_t ",
               "  WHERE sfdcent = sfdaent AND sfdcdocno = sfdadocno ",
               "    AND sfdaent = ",g_enterprise,
               "    AND sfda001 BETWEEN '", g_bdate,"' AND '", g_edate,"'",
               "    AND sfdastus = 'S' ",
               "    AND NOT EXISTS (SELECT 1 FROM sfaa_t WHERE sfaaent = sfdcent and sfaadocno = sfdc001)",
               "    AND sfdc001 IS NOT NULL ",
               "    AND sfda002 NOT IN ('16','26') ",
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfdaent AND ooef001=sfdasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
               " UNION ",
               " SELECT DISTINCT '",tm.xccccomp,"','",tm.xccccomp_desc,"','",tm.xcccld,"','",tm.xcccld_desc,"',",
               "        '",tm.xccc004,"','",tm.xccc005,"','",tm.xccc001,"','",tm.xccc001_desc,"',",
               "        '",tm.xccc003,"','",tm.xccc003_desc,"',",   
               "        '','','','',sfdb001,",
               "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00401' AND gzze002='",g_lang,"') info",
               "   FROM sfdb_t,sfda_t ",
               "  WHERE sfdbent = sfdaent AND sfdbdocno = sfdadocno ",
               "    AND sfdaent = ",g_enterprise,
               "    AND sfda001 BETWEEN '", g_bdate,"' AND '", g_edate,"'",
               "    AND sfdastus = 'S' ",
               "    AND NOT EXISTS (SELECT 1 FROM sfaa_t WHERE sfaaent = sfdbent and sfaadocno = sfdb001)",
               "    AND sfdb001 IS NOT NULL ",
               "    AND sfda002 IN ('15','25') ",
               "    AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent=sfdaent AND ooef001=sfdasite",
               "                                       AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
   PREPARE axcq300_pr18n FROM g_sql
   EXECUTE axcq300_pr18n

END FUNCTION

################################################################################
# Descriptions...: 傳入單據編號取得作業代號及名稱#160913-00024#1
# Memo...........:
# Usage..........: CALL axcq300_aooi200_get_slip(g_xccc_d[l_ac].docno) 
#                  RETURNING g_xccc_d[l_ac].inaj035,g_xccc_d[l_ac].inaj035_desc
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2017/01/17 By 08992
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq300_aooi200_get_slip(p_docnodesc)
DEFINE l_ooba002 LIKE ooba_t.ooba002
DEFINE r_inaj035 LIKE inaj_t.inaj035
DEFINE r_gzzal003 LIKE gzzal_t.gzzal003
DEFINE p_docnodesc LIKE type_t.chr80
DEFINE  l_success  LIKE type_t.num5

   CALL s_aooi200_get_slip(p_docnodesc) RETURNING l_success,l_ooba002    
      
   SELECT oobx004 INTO r_inaj035 
     FROM oobx_t LEFT JOIN ooba_t ON oobaent = oobxent AND ooba002 = oobx001
    WHERE ooba002 = l_ooba002 
    
   SELECT gzzal003 INTO r_gzzal003 
     FROM gzzal_t 
    WHERE gzzal001 = r_inaj035 AND gzzal002 = g_dlang
   
   RETURN  r_inaj035,r_gzzal003   
END FUNCTION

 
{</section>}
 
