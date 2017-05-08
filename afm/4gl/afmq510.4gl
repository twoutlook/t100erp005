#該程式未解開Section, 採用最新樣板產出!
{<section id="afmq510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2015-11-30 13:24:52), PR版次:0007(2016-11-09 09:37:27)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: afmq510
#+ Description: 投資單查詢
#+ Creator....: 03080(2015-05-24 15:26:00)
#+ Modifier...: 03080 -SD/PR- 08171
 
{</section>}
 
{<section id="afmq510.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#150820-00011#10   2015/09/10  By Reanna QBE增加投資購買日期、第一單身增加投資金額&摘要、第二單身合計拿掉、
#                                        "程式名稱"應該改為"異動類型"、列印按鈕鎖起來
#151028            151028      By albireo  排除作廢單
#151029-00012#9    151030      By Jessy   將帳務單的來源類型放入q類增加顯示
#151102-00009#1    151102      By Jessy   afmq510對象單身,投資單號欄位後面加上幣別,摘要後面依序加入日期fmmjdocdt/到期日fmmj021/面額fmmj017/年利率fmmj018/未平倉數量/未平倉餘額,第一單身加上合計金額功能
#151105-00001#4    151110      By Jessy   投資購買單號後方,增加交易市場帳戶編號
#151130            151130      By albireo 交易市場2次查詢無效;審核單查詢模式交易市場也要顯示;數量等問題修正
#160321-00016#27   160324      By Jessy   修正azzi920重複定義之錯誤訊息
#161006-00005#24   161021      By 06814   1.投資組織(fmmg002，fmmjsite)開窗改用q_ooef001_33()，ooef206條件拿掉 
#                                         2.法人(l_comp)需要azzi800控卡
#161104-00024#11   161109      By 08171   程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義(包含INSERT)
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
PRIVATE TYPE type_g_fmmg_d RECORD
       #statepic       LIKE type_t.chr1,
       
       fmmg002 LIKE fmmg_t.fmmg002, 
   fmmg002_desc LIKE type_t.chr500, 
   fmmgdocno LIKE fmmg_t.fmmgdocno, 
   l_fmmjdocno LIKE type_t.chr20, 
   fmmg004 LIKE type_t.chr10, 
   fmmj002_desc LIKE type_t.chr500, 
   l_fmmj006 LIKE type_t.chr10, 
   fmmj008 LIKE fmmj_t.fmmj008, 
   fmmj027 LIKE fmmj_t.fmmj027, 
   l_fmmjdocdt LIKE type_t.dat, 
   fmmj021 LIKE fmmj_t.fmmj021, 
   l_fmmj017 LIKE type_t.num20_6, 
   l_fmmj018 LIKE type_t.num15_3, 
   l_count LIKE type_t.num20_6, 
   l_amt LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input     RECORD
                   l_comp   LIKE glaa_t.glaacomp,
                   l_ld     LIKE glaa_t.glaald,
                   l_type   LIKE type_t.chr1,
                   l_ld_desc LIKE type_t.chr80,
                   l_comp_desc LIKE type_t.chr80
                   END RECORD
DEFINE g_memo_arr DYNAMIC ARRAY OF RECORD
       docdt     LIKE type_t.dat,
       docno     LIKE fmmj_t.fmmjdocno,
       prog      LIKE type_t.chr1,
       l_protype LIKE type_t.chr500,  #151029-00012#9 來源類型
       amount    LIKE type_t.num20_6,
       curr      LIKE type_t.chr20,
       account   LIKE type_t.num20_6,
       curr1     LIKE type_t.chr20,
       account1  LIKE type_t.num20_6,
       curr2     LIKE type_t.chr20,
       account2  LIKE type_t.num20_6,
       curr3     LIKE type_t.chr20,       
       account3  LIKE type_t.num20_6
                   END RECORD
DEFINE g_rec_b2    LIKE type_t.num10

DEFINE g_glaa    RECORD
                 glaa001   LIKE glaa_t.glaa001,
                 glaa015   LIKE glaa_t.glaa015,
                 glaa016   LIKE glaa_t.glaa016,
                 glaa019   LIKE glaa_t.glaa019,
                 glaa020   LIKE glaa_t.glaa020
                 END RECORD
DEFINE g_wc_cs_comp         STRING   #161006-00005#24 20161021 add by beckxie
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_fmmg_d
DEFINE g_master_t                   type_g_fmmg_d
DEFINE g_fmmg_d          DYNAMIC ARRAY OF type_g_fmmg_d
DEFINE g_fmmg_d_t        type_g_fmmg_d
 
      
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
 
{<section id="afmq510.main" >}
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
   CALL cl_ap_init("afm","")
 
   #add-point:作業初始化 name="main.init"
   #161006-00005#24 20161021 add by beckxie---S
   #展組織下階成員所需之暫存檔
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_azzi800_sons_query(g_today) 
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   #161006-00005#24 20161021 add by beckxie---E
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
   DECLARE afmq510_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afmq510_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmq510_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmq510 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmq510_init()   
 
      #進入選單 Menu (="N")
      CALL afmq510_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afmq510
      
   END IF 
   
   CLOSE afmq510_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afmq510.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afmq510_init()
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
   CALL cl_set_combo_scc_part('l_type','9984','a,b')
   CALL cl_set_combo_scc_part('prog','9984','1,2,3,4,5,6,7')
   CALL afmq510_prepare_declare()
   CALL afmq510_create_tmp()
   #end add-point
 
   CALL afmq510_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="afmq510.default_search" >}
PRIVATE FUNCTION afmq510_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " fmmgdocno = '", g_argv[01], "' AND "
   END IF
 
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段開始後 name="default_search.after"
   CALL afmq510_create_tmp()
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmq510.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION afmq510_ui_dialog()
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
      CALL afmq510_b_fill()
   ELSE
      CALL afmq510_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_fmmg_d.clear()
 
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
 
         CALL afmq510_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_fmmg_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL afmq510_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL afmq510_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               CALL afmq510_b_fill2(l_ac)
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_memo_arr TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2)

               BEFORE ROW


               BEFORE DISPLAY

         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL afmq510_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmq510_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afmq510_query()
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
            CALL afmq510_filter()
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
            CALL afmq510_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_fmmg_d)
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
            CALL afmq510_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL afmq510_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL afmq510_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL afmq510_b_fill()
 
         
         
 
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
 
{<section id="afmq510.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmq510_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_wc_main  STRING
   DEFINE l_count    LIKE type_t.num10
   DEFINE l_wc_fmmj  STRING
   DEFINE l_sql      STRING   #161006-00005#24 20161024 add by beckxie
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_fmmg_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON fmmg002,fmmgdocno,fmmj008,fmmj027,fmmj021
           FROM s_detail1[1].b_fmmg002,s_detail1[1].b_fmmgdocno,s_detail1[1].b_fmmj008,s_detail1[1].b_fmmj027, 
               s_detail1[1].b_fmmj021
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            #NEXT FIELD fmmjsite
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_fmmg002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_fmmg002
            #add-point:BEFORE FIELD b_fmmg002 name="construct.b.page1.b_fmmg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_fmmg002
            
            #add-point:AFTER FIELD b_fmmg002 name="construct.a.page1.b_fmmg002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_fmmg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmg002
            #add-point:ON ACTION controlp INFIELD b_fmmg002 name="construct.c.page1.b_fmmg002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooef017 = '",g_input.l_comp,"'"
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO b_fmmg002
            NEXT FIELD b_fmmg002
            #END add-point
 
 
         #----<<fmmg002_desc>>----
         #----<<b_fmmgdocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_fmmgdocno
            #add-point:BEFORE FIELD b_fmmgdocno name="construct.b.page1.b_fmmgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_fmmgdocno
            
            #add-point:AFTER FIELD b_fmmgdocno name="construct.a.page1.b_fmmgdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_fmmgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmgdocno
            #add-point:ON ACTION controlp INFIELD b_fmmgdocno name="construct.c.page1.b_fmmgdocno"
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
              LET g_qryparam.reqry = FALSE
              LET g_qryparam.where = "fmmg002 IN (SELECT ooef001 FROM ooef_t ",
                                     "              WHERE ooefent = ",g_enterprise," ",
                                     "                AND ooef017 = '",g_input.l_comp,"') "
              CALL q_fmmgdocno()
              DISPLAY g_qryparam.return1 TO b_fmmgdocno
              NEXT FIELD b_fmmgdocno
            #END add-point
 
 
         #----<<l_fmmjdocno>>----
         #----<<b_fmmg004>>----
         #----<<fmmj002_desc>>----
         #----<<l_fmmj006>>----
         #----<<b_fmmj008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_fmmj008
            #add-point:BEFORE FIELD b_fmmj008 name="construct.b.page1.b_fmmj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_fmmj008
            
            #add-point:AFTER FIELD b_fmmj008 name="construct.a.page1.b_fmmj008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_fmmj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmj008
            #add-point:ON ACTION controlp INFIELD b_fmmj008 name="construct.c.page1.b_fmmj008"
            
            #END add-point
 
 
         #----<<b_fmmj027>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_fmmj027
            #add-point:BEFORE FIELD b_fmmj027 name="construct.b.page1.b_fmmj027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_fmmj027
            
            #add-point:AFTER FIELD b_fmmj027 name="construct.a.page1.b_fmmj027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_fmmj027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmj027
            #add-point:ON ACTION controlp INFIELD b_fmmj027 name="construct.c.page1.b_fmmj027"
            
            #END add-point
 
 
         #----<<l_fmmjdocdt>>----
         #----<<b_fmmj021>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_fmmj021
            #add-point:BEFORE FIELD b_fmmj021 name="construct.b.page1.b_fmmj021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_fmmj021
            
            #add-point:AFTER FIELD b_fmmj021 name="construct.a.page1.b_fmmj021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_fmmj021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmj021
            #add-point:ON ACTION controlp INFIELD b_fmmj021 name="construct.c.page1.b_fmmj021"
            
            #END add-point
 
 
         #----<<l_fmmj017>>----
         #----<<l_fmmj018>>----
         #----<<l_count>>----
         #----<<l_amt>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      #150820-00011#10 add fmmjdocdt
      CONSTRUCT l_wc_main ON fmmjsite,fmmgdocno,fmmjdocno,fmmjdocno,fmmjdocdt
                        FROM fmmjsite,fmmgdocno,fmmjdocno,s_detail1[1].l_fmmjdocno,fmmjdocdt
           ON ACTION controlp INFIELD fmmjsite
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
              LET g_qryparam.reqry = FALSE
              #161006-00005#24 20161021 mark by beckxie---S
              #LET g_qryparam.where = "ooef017 = '",g_input.l_comp,"' AND ooef206 = 'Y'"
              #CALL q_ooef001()
              #161006-00005#24 20161021 mark by beckxie---E
              #161006-00005#24 20161021 add by beckxie---S
              LET g_qryparam.where = "ooef017 = '",g_input.l_comp,"' "
              CALL q_ooef001_33()
              #161006-00005#24 20161021 add by beckxie---E
              DISPLAY g_qryparam.return1 TO fmmjsite
              NEXT FIELD fmmjsite
           ON ACTION controlp INFIELD fmmgdocno
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
              LET g_qryparam.reqry = FALSE
              LET g_qryparam.where = "fmmg002 IN (SELECT ooef001 FROM ooef_t ",
                                     "              WHERE ooefent = ",g_enterprise," ",
                                     "                AND ooef017 = '",g_input.l_comp,"') "
              CALL q_fmmgdocno()
              DISPLAY g_qryparam.return1 TO fmmgdocno
              NEXT FIELD fmmgdocno
           ON ACTION controlp INFIELD fmmjdocno
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
              LET g_qryparam.reqry = FALSE
              LET g_qryparam.where = "fmmjsite IN (SELECT ooef001 FROM ooef_t ",
                                     "              WHERE ooefent = ",g_enterprise," ",
                                     "                AND ooef017 = '",g_input.l_comp,"') "
              CALL q_fmmjdocno()
              DISPLAY g_qryparam.return1 TO fmmjdocno
              NEXT FIELD fmmjdocno

           ON ACTION controlp INFIELD l_fmmjdocno
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
              LET g_qryparam.reqry = FALSE
              LET g_qryparam.where = "fmmjsite IN (SELECT ooef001 FROM ooef_t ",
                                     "              WHERE ooefent = ",g_enterprise," ",
                                     "                AND ooef017 = '",g_input.l_comp,"') "
              CALL q_fmmjdocno()
              DISPLAY g_qryparam.return1 TO l_fmmjdocno
              NEXT FIELD l_fmmjdocno
      END CONSTRUCT
      
      
      INPUT BY NAME g_input.l_comp,g_input.l_ld,g_input.l_type
          ATTRIBUTE(WITHOUT DEFAULTS)
            
          AFTER FIELD l_comp
             LET g_input.l_comp_desc = NULL
             DISPLAY BY NAME g_input.l_comp_desc
             IF NOT cl_null(g_input.l_comp)THEN
                CALL s_fin_account_center_chk(g_input.l_comp,'','','')
                   RETURNING g_sub_success,g_errno
                
                IF NOT g_sub_success THEN
                   INITIALIZE g_errparam.* TO NULL
                   LET g_errparam.code = g_errno
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD l_comp
                END IF
                
                CALL afmq510_comp_chk(g_input.l_comp)
                   RETURNING g_sub_success,g_errno
                
                IF NOT g_sub_success THEN
                   INITIALIZE g_errparam.* TO NULL
                   LET g_errparam.code = g_errno
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD l_comp
                END IF
                #161006-00005#24 20161024 add by beckxie---S
                #檢查是否存在於temp table之中
                LET l_sql = "SELECT COUNT(1) ",
                            "  FROM ooef_t ",
                            " WHERE ooefent = ",g_enterprise,
                            "   AND ooef001 = '",g_input.l_comp,"' ",
                            "   AND ooef001 IN ",g_wc_cs_comp
                PREPARE afmq510_comp_chk_pre FROM l_sql
                LET l_count = 0
                EXECUTE afmq510_comp_chk_pre INTO l_count
                IF l_count = 0 THEN
                   INITIALIZE g_errparam.* TO NULL
                   LET g_errparam.code = 'azz-00088'   #角色配置要先設定才能設定可拜訪據點
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD l_comp
                END IF
                #161006-00005#24 20161024 add by beckxie---E
             END IF     
            LET g_input.l_comp_desc = s_desc_get_department_desc(g_input.l_comp)  
            DISPLAY BY NAME g_input.l_comp_desc            
 


          AFTER FIELD l_ld
             LET g_input.l_ld_desc = NULL
             DISPLAY BY NAME g_input.l_ld_desc
             IF NOT cl_null(g_input.l_ld)THEN
                CALL s_fin_ld_chk(g_input.l_ld,g_user,'N') RETURNING g_sub_success,g_errno
                IF NOT g_sub_success THEN
                   INITIALIZE g_errparam.* TO NULL
                   LET g_errparam.code = g_errno
                   LET g_errparam.extend = ''
                   #160321-00016#27 --s add
                   LET g_errparam.replace[1] = 'agli010'
                   LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                   LET g_errparam.exeprog = 'agli010'
                   #160321-00016#27 --e add
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD l_ld
                END IF
             END IF
             LET g_input.l_ld_desc  = s_desc_get_ld_desc(g_input.l_ld)    
             DISPLAY BY NAME g_input.l_ld_desc
             INITIALIZE g_glaa.* TO NULL
             SELECT glaa001,glaa015,glaa016,glaa019,glaa020
               INTO g_glaa.*
               FROM glaa_t
              WHERE glaaent = g_enterprise
                AND glaald  = g_input.l_ld
                
             CALL cl_set_comp_visible('curr2,account2,curr3,account3',TRUE)
             IF g_glaa.glaa015 = 'Y' THEN
             ELSE
                CALL cl_set_comp_visible('curr2,account2',FALSE)
             END IF
             
             IF g_glaa.glaa019 = 'Y' THEN
             ELSE
                CALL cl_set_comp_visible('curr3,account3',FALSE)
             END IF  
             
          ON ACTION controlp INFIELD l_comp
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'i'
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.default1 = g_input.l_comp
             #LET g_qryparam.where = " ooef003 = 'Y'"                               #161006-00005#24 20161021 mark by beckxie
             LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_cs_comp   #161006-00005#24 20161021  add by beckxie
             CALL q_ooef001()
             LET g_input.l_comp =  g_qryparam.return1 
             DISPLAY BY NAME g_input.l_comp
             LET g_input.l_comp_desc = s_desc_get_department_desc(g_input.l_comp)  
             DISPLAY BY NAME g_input.l_comp_desc  
             NEXT FIELD l_comp
          ON ACTION controlp INFIELD l_ld
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'i'
             LET g_qryparam.default1 = g_input.l_ld
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.arg1 = g_user
             LET g_qryparam.arg2 = g_dept
             CALL q_authorised_ld()
             LET g_input.l_ld =  g_qryparam.return1 
             DISPLAY BY NAME g_input.l_ld
             LET g_input.l_ld_desc  = s_desc_get_ld_desc(g_input.l_ld)    
             DISPLAY BY NAME g_input.l_ld_desc
             NEXT FIELD l_ld  
             
          ON CHANGE l_type
             IF NOT cl_null(g_input.l_type)THEN
                CALL cl_set_comp_visible('l_fmmjdocno,fmmjdocno',TRUE)
                IF g_input.l_type = 'a' THEN
                   CALL cl_set_comp_visible('l_fmmjdocno,fmmjdocno',FALSE)
                   DISPLAY '' TO fmmjdocno                   
                END IF
             END IF
          
      END INPUT
      
      BEFORE DIALOG
         CALL afmq510_qbeclear()
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
         CALL  afmq510_qbeclear()
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
   IF INT_FLAG THEN
   ELSE
      LET g_wc2 = g_wc2 CLIPPED," AND ",l_wc_main CLIPPED," AND ",g_wc_table CLIPPED
      LET g_wc2 = g_wc2 CLIPPED," AND fmmg002 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," ",
                                                   " AND ooef017 = '",g_input.l_comp,"' ",
                                                   " AND ooefstus = 'Y' )"
   END IF   
   #end add-point
        
   LET g_error_show = 1
   CALL afmq510_b_fill()
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
 
{<section id="afmq510.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmq510_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   #151102-00009#1---s
   DEFINE l_fmmj005 LIKE fmmj_t.fmmj005
   DEFINE l_fmmj007 LIKE fmmj_t.fmmj007
   DEFINE l_fmmy003 LIKE fmmy_t.fmmy003
   #151102-00009#1---e
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
 
   LET ls_sql_rank = "SELECT  UNIQUE fmmg002,'',fmmgdocno,'','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY fmmg_t.fmmgdocno) AS RANK FROM fmmg_t", 
 
 
 
                     "",
                     " WHERE fmmgent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("fmmg_t"),
                     " ORDER BY fmmg_t.fmmgdocno"
 
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
 
   LET g_sql = "SELECT fmmg002,'',fmmgdocno,'','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   IF g_input.l_type = 'a' THEN 
     #LET g_sql = "SELECT fmmg002,'',fmmgdocno,'' ",       #150820-00011#10 mark
     #LET g_sql = "SELECT fmmg002,'',fmmgdocno,'','',''",  #150820-00011#10           #151102-00009#1 mark
     #LET g_sql = "SELECT fmmg002,'',fmmgdocno,'','','','','','','','','','','',''",  #151102-00009#1           
     LET g_sql = "SELECT fmmg002,'',fmmgdocno,'',fmmg004,'','','','','','','','','',''",  #albireo 151130
                  "  FROM fmmg_t ",
                  " WHERE fmmgent = ? ",
                  "   AND fmmgstus <> 'X' ",   #Albireo 151028
                  "   AND ",g_wc2 CLIPPED,
                  "   AND ",g_wc_filter CLIPPED   #151105-00001#11 151126 by sakura add
   ELSE
     #LET g_sql = "SELECT fmmg002,'',fmmgdocno,fmmjdocno ",                 #150820-00011#10 mark
     #LET g_sql = "SELECT fmmg002,'',fmmgdocno,fmmjdocno,fmmj008,fmmj027",  #150820-00011#10                                           #151102-00009#1 mark
      LET g_sql = "SELECT fmmg002,'',fmmgdocno,fmmjdocno,fmmj002,'',fmmj006,fmmj008,fmmj027,fmmjdocdt,fmmj021,fmmj017,fmmj018,'',''",  #151102-00009#1  #151105-00001#4 add fmmj002 
                  "  FROM fmmg_t,fmmj_t ",
                  " WHERE fmmgent = fmmjent ",
                  "   AND fmmgdocno = fmmj001 ",
                  "   AND fmmgent = ? ",
                  "   AND fmmjstus <> 'X' ",   #Albireo 151028
                  "   AND ",g_wc2 CLIPPED,
                  "   AND ",g_wc_filter CLIPPED   #151105-00001#11 151126 by sakura add
   END IF
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afmq510_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afmq510_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_fmmg_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_memo_arr.clear()
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_fmmg_d[l_ac].fmmg002,g_fmmg_d[l_ac].fmmg002_desc,g_fmmg_d[l_ac].fmmgdocno, 
       g_fmmg_d[l_ac].l_fmmjdocno,g_fmmg_d[l_ac].fmmg004,g_fmmg_d[l_ac].fmmj002_desc,g_fmmg_d[l_ac].l_fmmj006, 
       g_fmmg_d[l_ac].fmmj008,g_fmmg_d[l_ac].fmmj027,g_fmmg_d[l_ac].l_fmmjdocdt,g_fmmg_d[l_ac].fmmj021, 
       g_fmmg_d[l_ac].l_fmmj017,g_fmmg_d[l_ac].l_fmmj018,g_fmmg_d[l_ac].l_count,g_fmmg_d[l_ac].l_amt 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_fmmg_d[l_ac].statepic = cl_get_actipic(g_fmmg_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_fmmg_d[l_ac].fmmg002_desc = s_desc_get_department_desc(g_fmmg_d[l_ac].fmmg002)   
      
      #151102-00009#1---s
     #SELECT fmmj002,fmmj005,fmmj007,SUM(COALESCE(fmmy003,0)) INTO g_fmmg_d[l_ac].l_fmmj002,l_fmmj005,l_fmmj007,l_fmmy003 FROM fmmj_t      #151105-00001#4 add fmmj002
     # SELECT fmmj002,fmmj005,fmmj007,SUM(COALESCE(fmmy003,0)) INTO g_fmmg_d[l_ac].fmmj002,l_fmmj005,l_fmmj007,l_fmmy003 FROM fmmj_t      #151105-00001#4 add fmmj002
      SELECT fmmj002,fmmj005,fmmj007,SUM(COALESCE(fmmy003,0)) INTO g_fmmg_d[l_ac].fmmg004,l_fmmj005,l_fmmj007,l_fmmy003 FROM fmmj_t    #albireo 151130     
        LEFT OUTER JOIN fmmy_t ON  fmmjent = fmmyent AND fmmy001 = fmmjdocno AND fmmystus <> 'X'
       WHERE fmmjent = g_enterprise AND fmmjdocno = g_fmmg_d[l_ac].l_fmmjdocno
       GROUP BY fmmj005,fmmj007,fmmj002  #albireo 151130
       #GROUP BY fmmj005,fmmj007
       
      LET g_fmmg_d[l_ac].l_count = l_fmmj005 - l_fmmy003
      IF g_fmmg_d[l_ac].l_count < 0 THEN LET g_fmmg_d[l_ac].l_count = 0 END IF
      LET g_fmmg_d[l_ac].l_amt = g_fmmg_d[l_ac].l_count * l_fmmj007
      CALL s_curr_round_ld('1',g_input.l_ld,g_fmmg_d[l_ac].l_fmmj006,g_fmmg_d[l_ac].l_amt,2) RETURNING g_sub_success,g_errno,g_fmmg_d[l_ac].l_amt
      #151102-00009#1---e
     #LET g_fmmg_d[l_ac].fmmj002_desc = s_desc_fmme001_desc(g_fmmg_d[l_ac].l_fmmj002) #151105-00001#4
      #LET g_fmmg_d[l_ac].fmmj002_desc = s_desc_fmme001_desc(g_fmmg_d[l_ac].fmmj002) #151105-00001#4
      LET g_fmmg_d[l_ac].fmmj002_desc = s_desc_fmme001_desc(g_fmmg_d[l_ac].fmmg004) #albireo 151130
      #end add-point
 
      CALL afmq510_detail_show("'1'")      
 
      CALL afmq510_fmmg_t_mask()
 
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
   
 
   
   CALL g_fmmg_d.deleteElement(g_fmmg_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   LET g_tot_cnt = g_fmmg_d.getLength()
   CALL afmq510_b_fill2(1)
   #end add-point
 
   LET g_detail_cnt = g_fmmg_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE afmq510_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL afmq510_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL afmq510_detail_action_trans()
 
   IF g_fmmg_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL afmq510_fetch()
   END IF
   
      CALL afmq510_filter_show('fmmg002','b_fmmg002')
   CALL afmq510_filter_show('fmmgdocno','b_fmmgdocno')
   CALL afmq510_filter_show('fmmj008','b_fmmj008')
   CALL afmq510_filter_show('fmmj027','b_fmmj027')
   CALL afmq510_filter_show('fmmj021','b_fmmj021')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmq510.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmq510_fetch()
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
 
{<section id="afmq510.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afmq510_detail_show(ps_page)
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
 
{<section id="afmq510.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afmq510_filter()
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
      CONSTRUCT g_wc_filter ON fmmg002,fmmgdocno,fmmj008,fmmj027,fmmj021
                          FROM s_detail1[1].b_fmmg002,s_detail1[1].b_fmmgdocno,s_detail1[1].b_fmmj008, 
                              s_detail1[1].b_fmmj027,s_detail1[1].b_fmmj021
 
         BEFORE CONSTRUCT
                     DISPLAY afmq510_filter_parser('fmmg002') TO s_detail1[1].b_fmmg002
            DISPLAY afmq510_filter_parser('fmmgdocno') TO s_detail1[1].b_fmmgdocno
            DISPLAY afmq510_filter_parser('fmmj008') TO s_detail1[1].b_fmmj008
            DISPLAY afmq510_filter_parser('fmmj027') TO s_detail1[1].b_fmmj027
            DISPLAY afmq510_filter_parser('fmmj021') TO s_detail1[1].b_fmmj021
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_fmmg002>>----
         #Ctrlp:construct.c.filter.page1.b_fmmg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmg002
            #add-point:ON ACTION controlp INFIELD b_fmmg002 name="construct.c.filter.page1.b_fmmg002"
            #151105-00001#11 151126 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooef017 = '",g_input.l_comp,"'"
            #CALL q_ooef001()     #161006-00005#24 20161021 mark by beckxie
            CALL q_ooef001_33()   #161006-00005#24 20161021  add by beckxie
            DISPLAY g_qryparam.return1 TO b_fmmg002
            NEXT FIELD b_fmmg002
            #151105-00001#11 151126 by sakura add(E)
            #END add-point
 
 
         #----<<fmmg002_desc>>----
         #----<<b_fmmgdocno>>----
         #Ctrlp:construct.c.filter.page1.b_fmmgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmgdocno
            #add-point:ON ACTION controlp INFIELD b_fmmgdocno name="construct.c.filter.page1.b_fmmgdocno"
            #151105-00001#11 151126 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "fmmg002 IN (SELECT ooef001 FROM ooef_t ",
                                   "              WHERE ooefent = ",g_enterprise," ",
                                   "                AND ooef017 = '",g_input.l_comp,"') "
            CALL q_fmmgdocno()
            DISPLAY g_qryparam.return1 TO b_fmmgdocno
            NEXT FIELD b_fmmgdocno
            #151105-00001#11 151126 by sakura add(E)
            #END add-point
 
 
         #----<<l_fmmjdocno>>----
         #----<<b_fmmg004>>----
         #----<<fmmj002_desc>>----
         #----<<l_fmmj006>>----
         #----<<b_fmmj008>>----
         #Ctrlp:construct.c.filter.page1.b_fmmj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmj008
            #add-point:ON ACTION controlp INFIELD b_fmmj008 name="construct.c.filter.page1.b_fmmj008"
            
            #END add-point
 
 
         #----<<b_fmmj027>>----
         #Ctrlp:construct.c.filter.page1.b_fmmj027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmj027
            #add-point:ON ACTION controlp INFIELD b_fmmj027 name="construct.c.filter.page1.b_fmmj027"
            
            #END add-point
 
 
         #----<<l_fmmjdocdt>>----
         #----<<b_fmmj021>>----
         #Ctrlp:construct.c.filter.page1.b_fmmj021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmj021
            #add-point:ON ACTION controlp INFIELD b_fmmj021 name="construct.c.filter.page1.b_fmmj021"
            
            #END add-point
 
 
         #----<<l_fmmj017>>----
         #----<<l_fmmj018>>----
         #----<<l_count>>----
         #----<<l_amt>>----
   
 
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
   
      CALL afmq510_filter_show('fmmg002','b_fmmg002')
   CALL afmq510_filter_show('fmmgdocno','b_fmmgdocno')
   CALL afmq510_filter_show('fmmj008','b_fmmj008')
   CALL afmq510_filter_show('fmmj027','b_fmmj027')
   CALL afmq510_filter_show('fmmj021','b_fmmj021')
 
    
   CALL afmq510_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="afmq510.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afmq510_filter_parser(ps_field)
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
 
{<section id="afmq510.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afmq510_filter_show(ps_field,ps_object)
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
   LET ls_condition = afmq510_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afmq510.insert" >}
#+ insert
PRIVATE FUNCTION afmq510_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afmq510.modify" >}
#+ modify
PRIVATE FUNCTION afmq510_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afmq510.reproduce" >}
#+ reproduce
PRIVATE FUNCTION afmq510_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afmq510.delete" >}
#+ delete
PRIVATE FUNCTION afmq510_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afmq510.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION afmq510_detail_action_trans()
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
 
{<section id="afmq510.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION afmq510_detail_index_setting()
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
            IF g_fmmg_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_fmmg_d.getLength() AND g_fmmg_d.getLength() > 0
            LET g_detail_idx = g_fmmg_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_fmmg_d.getLength() THEN
               LET g_detail_idx = g_fmmg_d.getLength()
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
 
{<section id="afmq510.mask_functions" >}
 &include "erp/afm/afmq510_mask.4gl"
 
{</section>}
 
{<section id="afmq510.other_function" readonly="Y" >}

PRIVATE FUNCTION afmq510_prepare_declare()
   DEFINE l_sql    STRING
   #535
   LET l_sql = "SELECT fmmldocdt,fmmldocno,'1',fmmm004,fmmj005,fmmm007,", #151029-00012#9 add fmmm004
               "       fmmm008,'',fmmm010,'',fmmm014,'',fmmm016, ",
               "       fmmm004,fmmmseq ",               
               "  FROM fmml_t,fmmm_t,fmmj_t ",
               " WHERE fmmlent = fmmment ",
               "   AND fmmldocno = fmmm001 ",
               "   AND fmmjent = fmmment ",
               "   AND fmmjdocno = fmmm003 ",
               "   AND fmmjent = ",g_enterprise," ",
               "   AND fmmjdocno = ? ",
               "   AND fmmjstus = 'Y' ",
               "   AND fmmlstus <> 'X' ",
               "   AND fmml003 = ? ",
               " ORDER BY fmmldocdt,fmmldocno,fmmmseq"    #151029-00012#9
   PREPARE sel_fmmlp1 FROM l_sql
   DECLARE sel_fmmlc1 CURSOR FOR sel_fmmlp1

   #555
   LET l_sql = "SELECT fmmqdocdt,fmmqdocno,'3','',0,fmmr003,",
               "       fmmr004,'',fmmr006,'',fmmr008,'', ",
               "       fmmr010,'1',fmmrseq ",
               "  FROM fmmq_t,fmmr_t ",
               " WHERE fmmqent = fmmrent ",
               "   AND fmmqdocno = fmmrdocno ",
               "   AND fmmqent = ",g_enterprise," ",
               "   AND fmmqdocno = ? ",
               "   AND fmmqstus <> 'X' ",
               "   AND fmmq001 = ? "
               
   PREPARE sel_fmmqp1 FROM l_sql
   DECLARE sel_fmmqc1 CURSOR FOR sel_fmmqp1
   
   #570 
   LET l_sql = "SELECT fmnadocdt,fmnadocno,'4','',0,fmnb100,",
               "       0,'',fmnb115,'',fmnb125,'', ",
               "       fmnb135,fmna004,fmnbseq ",
               "  FROM fmnb_t,fmna_t ",
               " WHERE fmnbent = fmnaent  ",
               "   AND fmnbdocno = fmnadocno ",
               "   AND fmnbent = ",g_enterprise," ",
               "   AND fmnb002 = ? ",
               "   AND fmnb003 = ? ",
               "   AND fmnastus <> 'X' ",
               "   AND fmna001 = ? "
   PREPARE sel_fmnap1 FROM l_sql
   DECLARE sel_fmnac1 CURSOR FOR sel_fmnap1            
                
   #565
   LET l_sql = "SELECT fmmudocdt,fmmudocno,'6','',0,fmng003,",
               "       (fmng005+fmng006),'',(fmng009+fmng010),'',(fmng013+fmng014),'',",
               "       (fmng017+fmng018),'1',fmngseq ",
               " FROM fmmu_t,fmng_t ",
               "WHERE fmmuent = fmngent ",
               "  AND fmmudocno = fmngdocno ",
               "  AND fmngent = ",g_enterprise," ",
               "  AND fmng002 = ? ",
               "  AND fmmustus <> 'X' ",
               "  AND fmmu001 = ? "
   PREPARE sel_fmmup1 FROM l_sql
   DECLARE sel_fmmuc1 CURSOR FOR sel_fmmup1
   
   #585
   LET l_sql = "SELECT fmmwdocdt,fmmwdocno,'7',fmmx004,0,fmmx100,",   #151029-00012#9 add fmmx004
               "       fmmx101,'',fmmx112,'',fmmx122,'',",
               "       fmmx132,fmmx003,fmmxseq ",
               "  FROM fmmw_t,fmmx_t,fmmv_t ",
               " WHERE fmmvent = fmmxent ",
               "   AND fmmvdocno = fmmx002 ",
               "   AND fmmwent = fmmxent ",
               "   AND fmmwdocno = fmmxdocno ",
               "   AND fmmv001 = ? ",
               "   AND fmmwstus <> 'X' ",
               "   AND fmmw001 = ? ",
               " ORDER BY fmmwdocdt,fmmwdocno,fmmxseq"    #151029-00012#9
               
   PREPARE sel_fmmwp1 FROM l_sql
   DECLARE sel_fmmwc1 CURSOR FOR sel_fmmwp1   
   
   #595
   LET l_sql = "SELECT fmnedocdt,fmnedocno,'5',fmnf004,fmmy003,fmnf100,", #151029-00012#9 add fmnf004
               "       (fmnf101+fmnf102),'',(fmnf112+fmnf113),'',(fmnf121+fmnf123),'',",
               "       (fmnf131+fmnf132),fmnf003,fmnfseq ",
               "  FROM fmne_t,fmnf_t,fmmy_t ",
               " WHERE fmneent = fmnfent ",
               "   AND fmnedocno = fmnfdocno ",
               "   AND fmnfent = fmmyent ",
               "   AND fmnf002 = fmmydocno ",
               "   AND fmmy001 = ? ",
               "   AND fmmyent = ",g_enterprise," ",
               "   AND fmnestus <> 'X' ",
               "   AND fmne001 = ? ",
               " ORDER BY fmnedocdt,fmnedocno,fmnfseq"    #151029-00012#9
               
   PREPARE sel_fmnep1 FROM l_sql
   DECLARE sel_fmnec1 CURSOR FOR sel_fmnep1                  
END FUNCTION

################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL afmq510_create_tmp()
# Input parameter: 
# Return code....: 
# Date & Author..: 150525 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION afmq510_create_tmp()
   DROP TABLE afmq510_tmp;
   CREATE TEMP TABLE afmq510_tmp(
       docdt     LIKE type_t.dat,
       docno     LIKE fmmj_t.fmmjdocno,
       prog      LIKE type_t.chr1,
       l_protype LIKE type_t.chr500,  #151029-00012#9 來源類型
       amount    LIKE type_t.num20_6,
       curr      LIKE type_t.chr20,
       account   LIKE type_t.num20_6,
       curr1     LIKE type_t.chr20,
       account1  LIKE type_t.num20_6,
       curr2     LIKE type_t.chr20,
       account2  LIKE type_t.num20_6,
       curr3     LIKE type_t.chr20,       
       account3  LIKE type_t.num20_6
                           )
END FUNCTION

################################################################################
# Descriptions...: 傳入購買單 把底下來源單的帳務單全數抓出
# Memo...........:
# Usage..........: CALL afmq510_ins_tmp(p_fmmjdocno)
# Input parameter: 
# Return code....: 
# Date & Author..: 150525 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION afmq510_ins_tmp1(p_fmmjdocno)
   DEFINE p_fmmjdocno   LIKE fmmj_t.fmmjdocno
   DEFINE l_tmp   RECORD
       docdt     LIKE type_t.dat,
       docno     LIKE fmmj_t.fmmjdocno,
       prog      LIKE type_t.chr1,
       l_protype LIKE type_t.chr500,  #151029-00012#9 來源類型
       amount    LIKE type_t.num20_6,
       curr      LIKE type_t.chr20,
       account   LIKE type_t.num20_6,
       curr1     LIKE type_t.chr20,
       account1  LIKE type_t.num20_6,
       curr2     LIKE type_t.chr20,
       account2  LIKE type_t.num20_6,
       curr3     LIKE type_t.chr20,       
       account3  LIKE type_t.num20_6
                  END RECORD
   DEFINE l_state LIKE type_t.chr10
   DEFINE l_seq   LIKE type_t.num10
   
   #535
   #購買帳務單
   FOREACH sel_fmmlc1 USING p_fmmjdocno,g_input.l_ld
                      INTO l_tmp.*,l_state,l_seq
      #151029-00012#9---s
      IF NOT cl_null(l_tmp.l_protype) THEN
         LET l_tmp.l_protype = s_desc_show1(l_tmp.l_protype,s_desc_gzcbl004_desc('9983',l_tmp.l_protype))
      ELSE
         LET l_tmp.l_protype = NULL
      END IF
      #151029-00012#9---e                
                      
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH:sel_fmmlc1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #state = 2  為費用
      IF l_state = '4' THEN LET l_tmp.prog='2' END IF
      
     #INSERT INTO afmq510_tmp VALUES(l_tmp.*) #161104-00024#11 mark
      #161104-00024#11 --s add
      INSERT INTO afmq510_tmp(docdt,docno,prog,l_protype,amount,
                              curr,account,curr1,account1,curr2,
                              account2,curr3,account3)
      VALUES(l_tmp.docdt,l_tmp.docno,l_tmp.prog,l_tmp.l_protype,l_tmp.amount,
             l_tmp.curr,l_tmp.account,l_tmp.curr1,l_tmp.account1,l_tmp.curr2,
             l_tmp.account2,l_tmp.curr3,l_tmp.account3)
      #161104-00024#11 --e add
      #抓帳務單有無重評價
      FOREACH sel_fmnac1 USING l_tmp.docno,l_seq,g_input.l_ld
         INTO l_tmp.*
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'FOREACH:sel_fmnac1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH         
         END IF
         
        #INSERT INTO afmq510_tmp VALUES(l_tmp.*) #161104-00024#11 mark
         #161104-00024#11 --s add
         INSERT INTO afmq510_tmp(docdt,docno,prog,l_protype,amount,
                                 curr,account,curr1,account1,curr2,
                                 account2,curr3,account3)
         VALUES(l_tmp.docdt,l_tmp.docno,l_tmp.prog,l_tmp.l_protype,l_tmp.amount,
                l_tmp.curr,l_tmp.account,l_tmp.curr1,l_tmp.account1,l_tmp.curr2,
                l_tmp.account2,l_tmp.curr3,l_tmp.account3)
         #161104-00024#11 --e add
      END FOREACH
   END FOREACH
   
   #555
   #期末計量
   FOREACH sel_fmmqc1 USING p_fmmjdocno,g_input.l_ld
                      INTO l_tmp.*,l_state,l_seq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH:sel_fmmlc1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #state = 2  為費用
      IF l_state = '2' THEN LET l_tmp.prog='2' END IF
      
     #INSERT INTO afmq510_tmp VALUES(l_tmp.*) #161104-00024#11 mark
      #161104-00024#11 --s add
      INSERT INTO afmq510_tmp(docdt,docno,prog,l_protype,amount,
                              curr,account,curr1,account1,curr2,
                              account2,curr3,account3)
      VALUES(l_tmp.docdt,l_tmp.docno,l_tmp.prog,l_tmp.l_protype,l_tmp.amount,
             l_tmp.curr,l_tmp.account,l_tmp.curr1,l_tmp.account1,l_tmp.curr2,
             l_tmp.account2,l_tmp.curr3,l_tmp.account3)
      #161104-00024#11 --e add
      
      #抓帳務單有無重評價
      FOREACH sel_fmnac1 USING l_tmp.docno,l_seq,g_input.l_ld
         INTO l_tmp.*
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'FOREACH:sel_fmnac1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH         
         END IF
         
        #INSERT INTO afmq510_tmp VALUES(l_tmp.*) #161104-00024#11 mark
         #161104-00024#11 --s add
         INSERT INTO afmq510_tmp(docdt,docno,prog,l_protype,amount,
                                 curr,account,curr1,account1,curr2,
                                 account2,curr3,account3)
         VALUES(l_tmp.docdt,l_tmp.docno,l_tmp.prog,l_tmp.l_protype,l_tmp.amount,
                l_tmp.curr,l_tmp.account,l_tmp.curr1,l_tmp.account1,l_tmp.curr2,
                l_tmp.account2,l_tmp.curr3,l_tmp.account3)
         #161104-00024#11 --e add
      END FOREACH
   END FOREACH
   
   #565
   #計息
   FOREACH sel_fmmuc1 USING p_fmmjdocno,g_input.l_ld
                      INTO l_tmp.*,l_state,l_seq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH:sel_fmmuc1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
     #INSERT INTO afmq510_tmp VALUES(l_tmp.*) #161104-00024#11 mark
      #161104-00024#11 --s add
      INSERT INTO afmq510_tmp(docdt,docno,prog,l_protype,amount,
                              curr,account,curr1,account1,curr2,
                              account2,curr3,account3)
      VALUES(l_tmp.docdt,l_tmp.docno,l_tmp.prog,l_tmp.l_protype,l_tmp.amount,
             l_tmp.curr,l_tmp.account,l_tmp.curr1,l_tmp.account1,l_tmp.curr2,
             l_tmp.account2,l_tmp.curr3,l_tmp.account3)
      #161104-00024#11 --e add
      
      #抓帳務單有無重評價
      FOREACH sel_fmnac1 USING l_tmp.docno,l_seq,g_input.l_ld
         INTO l_tmp.*
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'FOREACH:sel_fmnac1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH         
         END IF
         
        #INSERT INTO afmq510_tmp VALUES(l_tmp.*) #161104-00024#11 mark
         #161104-00024#11 --s add
         INSERT INTO afmq510_tmp(docdt,docno,prog,l_protype,amount,
                                 curr,account,curr1,account1,curr2,
                                 account2,curr3,account3)
         VALUES(l_tmp.docdt,l_tmp.docno,l_tmp.prog,l_tmp.l_protype,l_tmp.amount,
                l_tmp.curr,l_tmp.account,l_tmp.curr1,l_tmp.account1,l_tmp.curr2,
                l_tmp.account2,l_tmp.curr3,l_tmp.account3)
         #161104-00024#11 --e add
      END FOREACH
   END FOREACH   
   
   #585
   #收息
   FOREACH sel_fmmwc1 USING p_fmmjdocno,g_input.l_ld
                      INTO l_tmp.*,l_state,l_seq
      #151029-00012#9---s
      IF NOT cl_null(l_tmp.l_protype) THEN
         LET l_tmp.l_protype = s_desc_show1(l_tmp.l_protype,s_desc_gzcbl004_desc('8806',l_tmp.l_protype))
      ELSE
         LET l_tmp.l_protype = NULL
      END IF
      #151029-00012#9---e
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH:sel_fmmlc1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      #state = 2  為費用
      IF l_state = '2' THEN LET l_tmp.prog='2' END IF
     #INSERT INTO afmq510_tmp VALUES(l_tmp.*) #161104-00024#11 mark
      #161104-00024#11 --s add
      INSERT INTO afmq510_tmp(docdt,docno,prog,l_protype,amount,
                              curr,account,curr1,account1,curr2,
                              account2,curr3,account3)
      VALUES(l_tmp.docdt,l_tmp.docno,l_tmp.prog,l_tmp.l_protype,l_tmp.amount,
             l_tmp.curr,l_tmp.account,l_tmp.curr1,l_tmp.account1,l_tmp.curr2,
             l_tmp.account2,l_tmp.curr3,l_tmp.account3)
      #161104-00024#11 --e add
      
      #抓帳務單有無重評價
      FOREACH sel_fmnac1 USING l_tmp.docno,l_seq,g_input.l_ld
         INTO l_tmp.*
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'FOREACH:sel_fmnac1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH         
         END IF
         
        #INSERT INTO afmq510_tmp VALUES(l_tmp.*) #161104-00024#11 mark
         #161104-00024#11 --s add
         INSERT INTO afmq510_tmp(docdt,docno,prog,l_protype,amount,
                                 curr,account,curr1,account1,curr2,
                                 account2,curr3,account3)
         VALUES(l_tmp.docdt,l_tmp.docno,l_tmp.prog,l_tmp.l_protype,l_tmp.amount,
                l_tmp.curr,l_tmp.account,l_tmp.curr1,l_tmp.account1,l_tmp.curr2,
                l_tmp.account2,l_tmp.curr3,l_tmp.account3)
         #161104-00024#11 --e add
      END FOREACH
   END FOREACH   
   
   #595
   #平倉
   FOREACH sel_fmnec1 USING p_fmmjdocno,g_input.l_ld
                      INTO l_tmp.*,l_state,l_seq
      #151029-00012#9---s
      IF NOT cl_null(l_tmp.l_protype) THEN
         LET l_tmp.l_protype = s_desc_show1(l_tmp.l_protype,s_desc_gzcbl004_desc('8867',l_tmp.l_protype))
      ELSE
         LET l_tmp.l_protype = NULL
      END IF
      #151029-00012#9---e
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH:sel_fmmlc1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      #state = 2  為費用
      IF l_state = '2' THEN LET l_tmp.prog='2' END IF
      
      LET l_tmp.amount  = l_tmp.amount * -1
      LET l_tmp.account = l_tmp.account * -1
      LET l_tmp.account1 = l_tmp.account1 * -1
      LET l_tmp.account2 = l_tmp.account2 * -1
      LET l_tmp.account3 = l_tmp.account3 * -1
      
     #INSERT INTO afmq510_tmp VALUES(l_tmp.*) #161104-00024#11 mark
      #161104-00024#11 --s add
      INSERT INTO afmq510_tmp(docdt,docno,prog,l_protype,amount,
                              curr,account,curr1,account1,curr2,
                              account2,curr3,account3)
      VALUES(l_tmp.docdt,l_tmp.docno,l_tmp.prog,l_tmp.l_protype,l_tmp.amount,
             l_tmp.curr,l_tmp.account,l_tmp.curr1,l_tmp.account1,l_tmp.curr2,
             l_tmp.account2,l_tmp.curr3,l_tmp.account3)
      #161104-00024#11 --e add
      
      #抓帳務單有無重評價
      FOREACH sel_fmnac1 USING l_tmp.docno,l_seq,g_input.l_ld
         INTO l_tmp.*
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'FOREACH:sel_fmnac1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH         
         END IF
         LET l_tmp.amount  = l_tmp.amount * -1
         LET l_tmp.account = l_tmp.account * -1
         LET l_tmp.account1 = l_tmp.account1 * -1
         LET l_tmp.account2 = l_tmp.account2 * -1
         LET l_tmp.account3 = l_tmp.account3 * -1
        #INSERT INTO afmq510_tmp VALUES(l_tmp.*) #161104-00024#11 mark
         #161104-00024#11 --s add
         INSERT INTO afmq510_tmp(docdt,docno,prog,l_protype,amount,
                                 curr,account,curr1,account1,curr2,
                                 account2,curr3,account3)
         VALUES(l_tmp.docdt,l_tmp.docno,l_tmp.prog,l_tmp.l_protype,l_tmp.amount,
                l_tmp.curr,l_tmp.account,l_tmp.curr1,l_tmp.account1,l_tmp.curr2,
                l_tmp.account2,l_tmp.curr3,l_tmp.account3)
         #161104-00024#11 --e add
      END FOREACH
   END FOREACH   
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
PRIVATE FUNCTION afmq510_b_fill2(p_ac)
   DEFINE p_ac   LIKE type_t.num10 
   DEFINE l_sql  STRING
   DEFINE l_idx  LIKE type_t.num10
   DEFINE l_fmmjdocno   LIKE fmmj_t.fmmjdocno
   
   
   DELETE FROM afmq510_tmp

   LET l_sql = "SELECT fmmjdocno FROM fmmj_t ",
               " WHERE fmmjent = ",g_enterprise," ",
               "   AND fmmjstus <> 'X' ",
               "   AND fmmj001 = ? "
   PREPARE sel_fmmjp1 FROM l_sql
   DECLARE sel_fmmjc1 CURSOR FOR sel_fmmjp1
   IF cl_null(p_ac) OR p_ac <= 0 THEN RETURN END IF
   CASE 
      WHEN g_input.l_type = 'a'  #審核單角度 
         FOREACH sel_fmmjc1 USING g_fmmg_d[p_ac].fmmgdocno
            INTO l_fmmjdocno
            IF SQLCA.SQLCODE THEN
               EXIT FOREACH
            END IF
            
            CALL afmq510_ins_tmp1(l_fmmjdocno)
         END FOREACH
      WHEN g_input.l_type = 'b'  #購買單角度
         CALL afmq510_ins_tmp1(g_fmmg_d[p_ac].l_fmmjdocno)
   END CASE
   
   LET l_sql = "SELECT * FROM afmq510_tmp ",
               " ORDER BY docdt "
   PREPARE sel_tmpp1 FROM l_sql
   DECLARE sel_tmpc1 CURSOR FOR sel_tmpp1 
   LET l_idx = 1
   CALL g_memo_arr.clear()
   FOREACH sel_tmpc1 INTO g_memo_arr[l_idx].*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      LET g_memo_arr[l_idx].curr1 = g_glaa.glaa001
      LET g_memo_arr[l_idx].curr2 = g_glaa.glaa016
      LET g_memo_arr[l_idx].curr3 = g_glaa.glaa020      
      LET l_idx = l_idx + 1
   END FOREACH
   
   LET g_rec_b2 = l_idx - 1
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
PRIVATE FUNCTION afmq510_qbeclear()
   DEFINE l_site   LIKE ooef_t.ooef001
   CLEAR FORM
   
   INITIALIZE g_input.* TO NULL
   CALL s_aap_get_default_apcasite('1','','') RETURNING g_sub_success,g_errno,l_site,g_input.l_ld,g_input.l_comp
   LET g_input.l_type = 'b'
   LET g_input.l_comp_desc = s_desc_get_department_desc(g_input.l_comp)    
   LET g_input.l_ld_desc  = s_desc_get_ld_desc(g_input.l_ld)             #帳套
   DISPLAY BY NAME g_input.l_type,g_input.l_ld,g_input.l_comp,g_input.l_comp_desc,g_input.l_ld_desc
   
   INITIALIZE g_glaa.* TO NULL
   SELECT glaa001,glaa015,glaa016,glaa019,glaa020
     INTO g_glaa.*
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_input.l_ld
      
   
   CALL cl_set_comp_visible('l_fmmjdocno,fmmjdocno',TRUE)
   CALL cl_set_comp_visible('curr2,account2,curr3,account3',TRUE)
   IF g_input.l_type = 'a' THEN
      CALL cl_set_comp_visible('l_fmmjdocno,fmmjdocno',FALSE)
      DISPLAY '' TO fmmjdocno                   
   END IF
   
   IF g_glaa.glaa015 = 'Y' THEN
   ELSE
      CALL cl_set_comp_visible('curr2,account2',FALSE)
   END IF
   
   IF g_glaa.glaa019 = 'Y' THEN
   ELSE
      CALL cl_set_comp_visible('curr3,account3',FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 法人勾檢核
# Memo...........:
# Date & Author..: 150622 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION afmq510_comp_chk(p_comp)
   DEFINE p_comp    LIKE ooef_t.ooef001
   DEFINE r_errno   LIKE gzze_t.gzze001
   DEFINE r_success LIKE type_t.num5
   DEFINE l_ooef003 LIKE ooef_t.ooef003
   
   LET r_errno = ''
   LET r_success = TRUE
   
   LET l_ooef003 = NULL
   SELECT ooef003 INTO l_ooef003 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_comp
      
   CASE
      WHEN l_ooef003 <> 'Y'
         LET r_errno = 'aap-00011'
         LET r_success = FALSE
   END CASE
   
   RETURN r_success,r_errno
END FUNCTION

 
{</section>}
 
