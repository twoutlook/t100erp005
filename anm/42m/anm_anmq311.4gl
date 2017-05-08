#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq311.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:10(2015-12-17 13:57:08), PR版次:0010(2017-01-04 13:46:59)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000061
#+ Filename...: anmq311
#+ Description: 資金預估狀況查詢
#+ Creator....: 05016(2015-09-15 14:04:17)
#+ Modifier...: 02159 -SD/PR- 01531
 
{</section>}
 
{<section id="anmq311.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151013-00016#2  2015/10/14 By RayHuang 1.加入XG(依明細或日計可能單身欄位不同，XG要配合)
#                                      2.二次篩選開放銀行帳號欄位
#151127-00002#5  2015/12/17 By sakura   增加一欄【備註】
#160122-00001#24 2016/01/27 By yangtt   添加交易帳戶編號用戶權限空管   
#160122-00001#24 2016/03/17 By 07900    添加交易帳戶編號用戶權限空管,增加部门权限 
#160318-00025#45 2016/04/19 by 07959    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160727-00019#4  2016/07/27 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以将系统中定义的临时表长度超过15码的全部改掉	
#160905-00007#8  2016/09/05 By 07900   调整系统中无ENT的SQL条件增加ent
#160816-00012#4  2016/09/02 By 07900    ANM增加资金中心，帐套，法人三个栏位权限
#161021-00038#1  2016/10/26 By 06821    組織類型與職能開窗調整
#161026-00010#2  2017/01/04 By 01531    改狀態條件抓取已复核狀態的资料
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
PRIVATE TYPE type_g_pmdt_d RECORD
       #statepic       LIKE type_t.chr1,
       
       apcadocdt LIKE apca_t.apcadocdt, 
   apca008 LIKE apca_t.apca008, 
   apcasite LIKE apca_t.apcasite, 
   apcasite_desc LIKE type_t.chr500, 
   apca010 LIKE apca_t.apca010, 
   l_nmas002 LIKE type_t.chr10, 
   nmaa001_desc LIKE type_t.chr100, 
   apca100 LIKE type_t.chr500, 
   amt1 LIKE type_t.num20_6, 
   amt2 LIKE type_t.num20_6, 
   amt3 LIKE type_t.num20_6, 
   amt4 LIKE type_t.num20_6, 
   amt5 LIKE type_t.num20_6, 
   amt6 LIKE type_t.num20_6, 
   sum1 LIKE type_t.num20_6, 
   pmdtdocno LIKE pmdt_t.pmdtdocno, 
   apca005 LIKE type_t.chr500, 
   apca005_desc LIKE type_t.chr500, 
   gzzz001 LIKE type_t.chr100, 
   gzzz001_desc LIKE type_t.chr500, 
   pmdtseq LIKE pmdt_t.pmdtseq, 
   apcc009 LIKE apcc_t.apcc009 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input RECORD
       l_comp      LIKE   type_t.chr100,
       l_comp_desc LIKE   type_t.chr100,
       l_enddate   LIKE   type_t.dat,
       l_type      LIKE   type_t.chr1,
       l_chk1      LIKE   type_t.chr1,
       l_chk2      LIKE   type_t.chr1,
       l_chk3      LIKE   type_t.chr1,
       l_chk4      LIKE   type_t.chr1,
       l_chk5      LIKE   type_t.chr1,
       l_chk6      LIKE   type_t.chr1
                 END RECORD
DEFINE g_sbas0019 LIKE type_t.chr1   
DEFINE g_wc_filter2      STRING    #151013-00016#2
DEFINE g_nmbx001         LIKE nmbx_t.nmbx001
DEFINE g_nmbx002         LIKE nmbx_t.nmbx002
DEFINE g_sql_bank        STRING    #160122-00001#24 By 07900 --add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_pmdt_d
DEFINE g_master_t                   type_g_pmdt_d
DEFINE g_pmdt_d          DYNAMIC ARRAY OF type_g_pmdt_d
DEFINE g_pmdt_d_t        type_g_pmdt_d
 
      
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
 
{<section id="anmq311.main" >}
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
   CALL cl_ap_init("anm","")
 
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
   DECLARE anmq311_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmq311_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmq311_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmq311 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmq311_init()   
 
      #進入選單 Menu (="N")
      CALL anmq311_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmq311
      
   END IF 
   
   CLOSE anmq311_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmq311.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION anmq311_init()
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
   CALL anmq311_create_tmp()
   #160122-00001#24--add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#24--add--end
   #end add-point
 
   CALL anmq311_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="anmq311.default_search" >}
PRIVATE FUNCTION anmq311_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " pmdtdocno = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " pmdtseq = '", g_argv[02], "' AND "
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
 
{<section id="anmq311.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION anmq311_ui_dialog()
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
    CALL anmq311_default() 
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
      CALL anmq311_b_fill()
   ELSE
      CALL anmq311_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_pmdt_d.clear()
 
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
 
         CALL anmq311_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_pmdt_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL anmq311_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL anmq311_detail_action_trans()
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
            CALL anmq311_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
           
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #151013-00016#2-----s
               CALL anmq311_ins_x01_tmp()
               CALL anmq311_x01(" 1 = 1","anmq311_x01_tmp")
               #151013-00016#2-----e
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #151013-00016#2-----s
               CALL anmq311_ins_x01_tmp()
               CALL anmq311_x01(" 1 = 1","anmq311_x01_tmp")
               #151013-00016#2-----e
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmq311_query()
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
            CALL anmq311_filter()
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
            CALL anmq311_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_pmdt_d)
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
            CALL anmq311_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL anmq311_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL anmq311_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL anmq311_b_fill()
 
         
         
 
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
 
{<section id="anmq311.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmq311_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_wc       STRING   
   DEFINE l_sql      STRING   #160816-00012#4 Add
   DEFINE l_count    LIKE type_t.num5
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_pmdt_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON apcadocdt,apca008,apcasite,apca010,pmdtdocno,pmdtseq,apcc009
           FROM s_detail1[1].b_apcadocdt,s_detail1[1].b_apca008,s_detail1[1].b_apcasite,s_detail1[1].b_apca010, 
               s_detail1[1].b_pmdtdocno,s_detail1[1].b_pmdtseq,s_detail1[1].b_apcc009
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            NEXT FIELD l_comp
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_apcadocdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcadocdt
            #add-point:BEFORE FIELD b_apcadocdt name="construct.b.page1.b_apcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcadocdt
            
            #add-point:AFTER FIELD b_apcadocdt name="construct.a.page1.b_apcadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcadocdt
            #add-point:ON ACTION controlp INFIELD b_apcadocdt name="construct.c.page1.b_apcadocdt"
            
            #END add-point
 
 
         #----<<b_apca008>>----
         #Ctrlp:construct.c.page1.b_apca008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca008
            #add-point:ON ACTION controlp INFIELD b_apca008 name="construct.c.page1.b_apca008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooib001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apca008  #顯示到畫面上
            NEXT FIELD b_apca008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apca008
            #add-point:BEFORE FIELD b_apca008 name="construct.b.page1.b_apca008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apca008
            
            #add-point:AFTER FIELD b_apca008 name="construct.a.page1.b_apca008"
            
            #END add-point
            
 
 
         #----<<b_apcasite>>----
         #Ctrlp:construct.c.page1.b_apcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcasite
            #add-point:ON ACTION controlp INFIELD b_apcasite name="construct.c.page1.b_apcasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apcasite  #顯示到畫面上
            NEXT FIELD b_apcasite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcasite
            #add-point:BEFORE FIELD b_apcasite name="construct.b.page1.b_apcasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcasite
            
            #add-point:AFTER FIELD b_apcasite name="construct.a.page1.b_apcasite"
            
            #END add-point
            
 
 
         #----<<apcasite_desc>>----
         #----<<b_apca010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apca010
            #add-point:BEFORE FIELD b_apca010 name="construct.b.page1.b_apca010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apca010
            
            #add-point:AFTER FIELD b_apca010 name="construct.a.page1.b_apca010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apca010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca010
            #add-point:ON ACTION controlp INFIELD b_apca010 name="construct.c.page1.b_apca010"
            
            #END add-point
 
 
         #----<<l_nmas002>>----
         #----<<b_nmaa001_desc>>----
         #----<<b_apca100>>----
         #----<<amt1>>----
         #----<<amt2>>----
         #----<<amt3>>----
         #----<<amt4>>----
         #----<<amt5>>----
         #----<<amt6>>----
         #----<<sum1>>----
         #----<<b_pmdtdocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdtdocno
            #add-point:BEFORE FIELD b_pmdtdocno name="construct.b.page1.b_pmdtdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdtdocno
            
            #add-point:AFTER FIELD b_pmdtdocno name="construct.a.page1.b_pmdtdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_pmdtdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdtdocno
            #add-point:ON ACTION controlp INFIELD b_pmdtdocno name="construct.c.page1.b_pmdtdocno"
            
            #END add-point
 
 
         #----<<b_apca005>>----
         #----<<apca005_desc>>----
         #----<<b_gzzz001>>----
         #----<<gzzz001_desc>>----
         #----<<b_pmdtseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdtseq
            #add-point:BEFORE FIELD b_pmdtseq name="construct.b.page1.b_pmdtseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdtseq
            
            #add-point:AFTER FIELD b_pmdtseq name="construct.a.page1.b_pmdtseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_pmdtseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdtseq
            #add-point:ON ACTION controlp INFIELD b_pmdtseq name="construct.c.page1.b_pmdtseq"
            
            #END add-point
 
 
         #----<<b_apcc009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcc009
            #add-point:BEFORE FIELD b_apcc009 name="construct.b.page1.b_apcc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcc009
            
            #add-point:AFTER FIELD b_apcc009 name="construct.a.page1.b_apcc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc009
            #add-point:ON ACTION controlp INFIELD b_apcc009 name="construct.c.page1.b_apcc009"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_input.l_comp,g_input.l_enddate,g_input.l_type,g_input.l_comp_desc,
                    g_input.l_chk1,g_input.l_chk2,g_input.l_chk3,
                    g_input.l_chk4,g_input.l_chk5,g_input.l_chk6
         ATTRIBUTE(WITHOUT DEFAULTS)
         
      AFTER FIELD l_comp
         LET g_input.l_comp_desc  = ''
         IF NOT cl_null(g_input.l_comp) THEN
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = g_input.l_comp
            IF NOT cl_chk_exist("v_ooef001_1") THEN
               LET g_input.l_comp = ''
               LET g_input.l_comp_desc = ''
               DISPLAY BY NAME g_input.l_comp_desc
               NEXT FIELD CURRENT
            END IF
            #160816-00012#4 Add  ---(S)---
            #检查用户是否有资金中心对应法人的权限
            CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
            LET l_count = 0
            LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                        "   AND ooef001 = '",g_input.l_comp,"'",
                        "   AND ooef003 = 'Y'",
                        "   AND ",l_wc CLIPPED
            PREPARE anmp410_count_prep2 FROM l_sql
            EXECUTE anmp410_count_prep2 INTO l_count
            IF cl_null(l_count) THEN LET l_count = 0 END IF
            IF l_count = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "ais-00228"
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_input.l_comp = ''
               LET g_input.l_comp_desc = ''
               DISPLAY BY NAME g_input.l_comp_desc              
               NEXT FIELD CURRENT
            END IF
            #160816-00012#4 Add  ---(E)---
         END IF
         CALL s_desc_get_department_desc(g_input.l_comp)RETURNING g_input.l_comp_desc
         DISPLAY BY NAME g_input.l_comp_desc,g_input.l_comp
         
      AFTER FIELD l_enddate
         IF NOT cl_null(g_input.l_enddate) THEN
            IF g_input.l_enddate < g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-02953'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.l_enddate = g_today
                  DISPLAY BY NAME g_input.l_enddate
                  NEXT FIELD CURRENT
             END IF           
          END IF
       
       ON CHANGE l_type
       CALL cl_set_comp_visible('b_apca005,apca005_desc,b_pmdtdocno,b_gzzz001,gzzz001_desc,b_apcc009',TRUE)   #151127-00002#5 add b_apcc009
       IF g_input.l_type = '1' THEN
          CALL cl_set_comp_visible('b_apca005,apca005_desc,b_pmdtdocno,b_gzzz001,gzzz001_desc,b_apcc009',FALSE)   #151127-00002#5 add b_apcc009
       END IF
       
       ON ACTION controlp INFIELD l_comp
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'i'
          LET g_qryparam.default1 = g_input.l_comp               
          LET g_qryparam.where = " ooef003 = 'Y' "
          #160816-00012#4 Add  ---(S)---
          CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
          LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED
          #160816-00012#4 Add  ---(E)---
          #CALL q_ooef001()        #161021-00038#1 mark                        
          CALL q_ooef001_2()       #161021-00038#1 add    
          LET g_input.l_comp = g_qryparam.return1
          CALL s_desc_get_department_desc(g_input.l_comp)RETURNING g_input.l_comp_desc
          DISPLAY BY NAME g_input.l_comp_desc,g_input.l_comp
          NEXT FIELD l_comp 
          
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
         CALL anmq311_default()
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
   CALL anmq311_b_fill()
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
 
{<section id="anmq311.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmq311_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_slip            LIKE type_t.chr100
   DEFINE ls_js             STRING
   DEFINE l_flag            LIKE type_t.num5
   DEFINE run_anmp830 RECORD
        wc     STRING,
        nmbxcomp   LIKE nmbx_t.nmbxcomp,
        nmbx001    LIKE nmbx_t.nmbx001,
        nmbx002    LIKE nmbx_t.nmbx002   
   END RECORD   
   
   DEFINE l_tran  STRING 
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD   
   DEFINE ls_js2         STRING              
   DEFINE l_apca009    LIKE apca_t.apca009
   DEFINE l_apca100_t  LIKE apca_t.apca100
   DEFINE l_apca010_t  LIKE apca_t.apca010
   DEFINE l_sum1_t     LIKE apca_t.apca108
   DEFINE l_odr        LIKE type_t.num5
   DEFINE l_tmp        type_g_pmdt_d
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_nmas002_t  LIKE nmas_t.nmas002
   DEFINE l_nmaa001    LIKE nmaa_t.nmaa001
   DEFINE l_str        LIKE type_t.chr100
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc_filter2) THEN
      LET g_wc_filter2 = " 1=1"
   ELSE
      CALL anmq311_filter2_show('nmas002','l_nmas002')
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '','','','','','','','','','','','','','','',pmdtdocno,'','','', 
       '',pmdtseq,''  ,DENSE_RANK() OVER( ORDER BY pmdt_t.pmdtdocno,pmdt_t.pmdtseq) AS RANK FROM pmdt_t", 
 
 
 
                     "",
                     " WHERE pmdtent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmdt_t"),
                     " ORDER BY pmdt_t.pmdtdocno,pmdt_t.pmdtseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_wc = ls_wc, " AND ",g_wc_filter2
   #160122-00001#24--add---str
   LET ls_wc = ls_wc CLIPPED," AND (nmas002 IN (",g_sql_bank,") OR TRIM(nmas002) IS NULL)"  #160122-00001#24 By 07900 --mod
   #160122-00001#24--add---end
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
 
   LET g_sql = "SELECT '','','','','','','','','','','','','','','',pmdtdocno,'','','','',pmdtseq,''", 
 
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   DELETE FROM anmq311_tmp
   LET g_nmbx001 = YEAR(g_input.l_enddate)
   LET g_nmbx002 = MONTH(g_input.l_enddate)
   #執行anmp830 ###
   INITIALIZE run_anmp830 TO NULL
   LET run_anmp830.wc = '1=1 '
   LET run_anmp830.nmbxcomp = g_input.l_comp
   LET run_anmp830.nmbx001 = g_nmbx001
   LET run_anmp830.nmbx002 = g_nmbx002   
   LET l_tran = util.JSON.stringify(run_anmp830)   
   INITIALIZE la_param.* TO NULL
   LET la_param.prog = 'anmp830'
   LET la_param.param[1] = l_tran
   LET la_param.background = 'Y'
   LET ls_js2 = util.JSON.stringify(la_param)
   CALL cl_cmdrun_wait(ls_js2)
   ########  
   LET l_cnt = 3
   IF g_input.l_chk1 = 'Y' THEN LET l_cnt = l_cnt + 1 END IF
   IF g_input.l_chk2 = 'Y' THEN LET l_cnt = l_cnt + 1 END IF
   IF g_input.l_chk3 = 'Y' THEN LET l_cnt = l_cnt + 1 END IF
   IF g_input.l_chk4 = 'Y' THEN LET l_cnt = l_cnt + 1 END IF
   IF g_input.l_chk5 = 'Y' THEN LET l_cnt = l_cnt + 1 END IF
   IF g_input.l_chk6 = 'Y' THEN LET l_cnt = l_cnt + 1 END IF
        
   CALL cl_progress_bar(l_cnt)
   
   CALL cl_err_collect_init()
   CALL anmq311_insert_tmp_ap()
   CALL anmq311_insert_tmp_nm()
   CALL anmq311_insert_tmp_ar() 
   CALL cl_err_collect_show()
   
  
   CALL cl_progress_ing("Data processing... ")
   DELETE FROM anmq311_tmp01     #160727-00019#4 Mod  anmq311_bfill_tmp--> anmq311_tmp01
   
   IF g_input.l_type = '0' THEN
      LET g_sql =" SELECT apcadocdt,apca008,apcasite,''  ,apca010,   ",
                 "        nmas002  ,''     ,apca100 ,amt1,           ",
                 "        amt2     ,amt3   ,amt4    ,amt5,amt6,sum1, ",
                 "        pmdtdocno,apca005,'','',''    ,l_type,     ",
                 "        apcc009                                    ",   #151127-00002#5
                 "   FROM anmq311_tmp                                ",
                 "  WHERE apcaent = ?                                ",
                 "   AND ", ls_wc                                                                                 
      LET g_sql = g_sql, " ORDER BY apca100,nmas002,l_type,apca010   "  
    ELSE
      LET g_sql =" SELECT '','','',''  ,apca010,                     ",
                 "        nmas002  ,'' ,apca100,                     ",
                 "        SUM(amt1),SUM(amt2),SUM(amt3),             ",
                 "        SUM(amt4),SUM(amt5),SUM(amt6),SUM(sum1),   ",
                 "        '', ''    ,'','','',l_type,                ",
                 "        ''                                         ",   #151127-00002#5
                 "   FROM anmq311_tmp                                ",
                 "  WHERE apcaent = ?                                ", 
                 "    AND ", ls_wc                                                                          
      LET g_sql = g_sql, " GROUP BY apca100,nmas002,l_type,apca010   ",
                         " ORDER BY apca100,nmas002,l_type,apca010   "
                      
   END IF          
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmq311_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmq311_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_pmdt_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET l_apca100_t =''
   LET l_odr = 1
   LET l_flag = 1
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_pmdt_d[l_ac].apcadocdt,g_pmdt_d[l_ac].apca008,g_pmdt_d[l_ac].apcasite, 
       g_pmdt_d[l_ac].apcasite_desc,g_pmdt_d[l_ac].apca010,g_pmdt_d[l_ac].l_nmas002,g_pmdt_d[l_ac].nmaa001_desc, 
       g_pmdt_d[l_ac].apca100,g_pmdt_d[l_ac].amt1,g_pmdt_d[l_ac].amt2,g_pmdt_d[l_ac].amt3,g_pmdt_d[l_ac].amt4, 
       g_pmdt_d[l_ac].amt5,g_pmdt_d[l_ac].amt6,g_pmdt_d[l_ac].sum1,g_pmdt_d[l_ac].pmdtdocno,g_pmdt_d[l_ac].apca005, 
       g_pmdt_d[l_ac].apca005_desc,g_pmdt_d[l_ac].gzzz001,g_pmdt_d[l_ac].gzzz001_desc,g_pmdt_d[l_ac].pmdtseq, 
       g_pmdt_d[l_ac].apcc009
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_pmdt_d[l_ac].statepic = cl_get_actipic(g_pmdt_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      IF cl_null(g_pmdt_d[l_ac].l_nmas002) AND l_flag = 1 THEN
         IF l_ac >= 1 THEN       #最後一筆帳戶      
            SELECT COUNT(1) INTO l_cnt  #160905-00007#8 mod SELECT COUNT(*) -> SELECT COUNT(1) 
              FROM anmq311_tmp01      #160727-00019#4 Mod  anmq311_bfill_tmp--> anmq311_tmp01
             WHERE nmas002 = l_nmas002_t
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            IF l_cnt > 0 THEN             
               LET g_pmdt_d[l_ac + 1].* = g_pmdt_d[l_ac].*            
               LET g_sql = " SELECT '','','','','',                        ",
                         "        '','',apca100,                           ",
                         "        SUM(amt1),SUM(amt2),SUM(amt3),           ", 
                         "        SUM(amt4),SUM(amt5),SUM(amt6),SUM(sum1), ",
                         "        '', ''     ,'','','','2',                ",
                         "        ''                                       ",   #151127-00002#5
                         "   FROM anmq311_tmp                              ",
                         "  WHERE nmas002 = '",l_nmas002_t,"'              ",
                         "    AND apca100 = '",l_apca100_t,"'              ",
                         "    AND ", ls_wc ," GROUP BY apca100             "
               PREPARE anmq311_b_fill_prep5 FROM g_sql
               EXECUTE anmq311_b_fill_prep5 INTO l_tmp.* 
               LET l_tmp.amt1 = l_tmp.amt1 * -1 #應付帳款負數
       　      LET l_tmp.amt2 = l_tmp.amt2 * -1 #預計提出負數
               LET l_tmp.amt3 = l_tmp.amt3 * -1 #融資負數   
               #依幣別小記字串             
               LET l_tmp.nmaa001_desc = cl_getmsg('lib-00156',g_dlang)
               LET l_str = cl_getmsg('anm-02956',g_dlang)            
               LET l_tmp.nmaa001_desc = l_str,l_tmp.nmaa001_desc
               LET l_tmp.apcasite_desc = 'curry_sum' #依幣別小記所在欄位flag  
               INSERT INTO  anmq311_tmp01 VALUES(l_tmp.*,l_odr)     #160727-00019#4 Mod  anmq311_bfill_tmp--> anmq311_tmp01
               LET l_odr = l_odr + 1  
            END IF               
            #在開始沒帳戶的時候 塞一筆空白
            
            LET g_pmdt_d[l_ac + 1].* = g_pmdt_d[l_ac].* 
            LET g_pmdt_d[l_ac].apcadocdt = ''
            LET g_pmdt_d[l_ac].apca008 = ''
            LET g_pmdt_d[l_ac].apcasite = ''
            LET g_pmdt_d[l_ac].apcasite_desc =''
            LET g_pmdt_d[l_ac].apca010 = ''
            LET g_pmdt_d[l_ac].l_nmas002 = ''
            LET g_pmdt_d[l_ac].nmaa001_desc = ''
            LET g_pmdt_d[l_ac].apca100 = l_apca100_t
            LET g_pmdt_d[l_ac].amt1 = 0 
            LET g_pmdt_d[l_ac].amt2 = 0
            LET g_pmdt_d[l_ac].amt3 = 0
            LET g_pmdt_d[l_ac].amt4 = 0
            LET g_pmdt_d[l_ac].amt5 = 0
            LET g_pmdt_d[l_ac].amt6 = 0
            LET g_pmdt_d[l_ac].sum1 = 0
            LET g_pmdt_d[l_ac].pmdtdocno = ''
            LET g_pmdt_d[l_ac].gzzz001 =''
            LET g_pmdt_d[l_ac].apca005 = ''
            LET g_pmdt_d[l_ac].apca005_desc =''
            LET g_pmdt_d[l_ac].pmdtseq = l_odr
            INSERT INTO anmq311_tmp01 VALUES(g_pmdt_d[l_ac].*,l_odr)   #160727-00019#4 Mod  anmq311_bfill_tmp--> anmq311_tmp01
            LET l_odr = l_odr + 1
            LET l_ac = l_ac + 1 
            LET l_flag = 2
         END IF
      END IF
      #帳戶小記
      IF l_nmas002_t <> g_pmdt_d[l_ac].l_nmas002 AND NOT cl_null(g_pmdt_d[l_ac].l_nmas002) THEN
         SELECT COUNT(1) INTO l_cnt #160905-00007#8 mod SELECT COUNT(*) -> SELECT COUNT(1) 
            FROM anmq311_tmp01      #160727-00019#4 Mod  anmq311_bfill_tmp--> anmq311_tmp01
           WHERE nmas002 = l_nmas002_t
          IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
          IF l_cnt > 0 THEN   
             INITIALIZE l_tmp TO NULL     
             LET g_sql = " SELECT '','','','','',                          ",
                         "        '','',apca100,                           ",
                         "        SUM(amt1),SUM(amt2),SUM(amt3),           ", 
                         "        SUM(amt4),SUM(amt5),SUM(amt6),SUM(sum1), ",
                         "        '', ''     ,'','','','2',                ",
                         "        ''                                       ",   #151127-00002#5
                         "   FROM anmq311_tmp                              ",
                         "  WHERE nmas002 = '",l_nmas002_t,"'              ",
                         "    AND apca100 = '",l_apca100_t,"'              ",
                         "    AND ", ls_wc ," GROUP BY apca100             "
             PREPARE anmq311_b_fill_prep3 FROM g_sql
             EXECUTE anmq311_b_fill_prep3 INTO l_tmp.* 
             LET l_tmp.amt1 = l_tmp.amt1 * -1 #應付帳款負數
       　    LET l_tmp.amt2 = l_tmp.amt2 * -1 #預計提出負數
             LET l_tmp.amt3 = l_tmp.amt3 * -1 #融資負數   
             #依帳戶小記字串             
             LET l_tmp.nmaa001_desc = cl_getmsg('lib-00156',g_dlang) 
             LET l_str = cl_getmsg('anm-02956',g_dlang)
             LET l_tmp.nmaa001_desc = l_str,l_tmp.nmaa001_desc
             LET l_tmp.apcasite_desc = 'curry_sum' #依幣別小記所在欄位flag  
             INSERT INTO  anmq311_tmp01 VALUES(l_tmp.*,l_odr)     #160727-00019#4 Mod  anmq311_bfill_tmp--> anmq311_tmp01
             LET l_odr = l_odr + 1      
         END IF             
      END IF
      IF l_apca100_t <> g_pmdt_d[l_ac].apca100 THEN 
          INITIALIZE l_tmp TO NULL     
          LET g_sql = " SELECT '','','','','',                          ",
                      "        '','','',                                ",
                      "        SUM(amt1),SUM(amt2),SUM(amt3),           ", 
                      "        SUM(amt4),SUM(amt5),SUM(amt6),SUM(sum1), ",
                      "        '', ''     ,'','','','2',                ",
                      "        ''                                       ",   #151127-00002#5
                      "   FROM anmq311_tmp                              ",
                      "  WHERE apca100 = '",l_apca100_t,"'              ",
                      "   AND ", ls_wc                     
          PREPARE anmq311_b_fill_prep2 FROM g_sql
          EXECUTE anmq311_b_fill_prep2 INTO l_tmp.* 
          LET l_tmp.amt1 = l_tmp.amt1 * -1 #應付帳款負數
       　 LET l_tmp.amt2 = l_tmp.amt2 * -1 #預計提出負數
          LET l_tmp.amt3 = l_tmp.amt3 * -1 #融資負數   
          LET l_tmp.apca100 = l_apca100_t   
          #依幣別小記字串             
          LET l_tmp.nmaa001_desc = cl_getmsg('lib-00156',g_dlang) 
          LET l_tmp.nmaa001_desc = l_apca100_t,l_tmp.nmaa001_desc
          LET l_tmp.apcasite_desc = 'curry_sum' #依幣別小記所在欄位flag  
          INSERT INTO  anmq311_tmp01 VALUES(l_tmp.*,l_odr)    #160727-00019#4 Mod  anmq311_bfill_tmp--> anmq311_tmp01
          LET l_odr = l_odr + 1  
          LET l_flag = 1          
      END IF  
      LET g_pmdt_d[l_ac].amt1 = g_pmdt_d[l_ac].amt1 * -1 #應付帳款負數
      LET g_pmdt_d[l_ac].amt2 = g_pmdt_d[l_ac].amt2 * -1 #預計提出負數
      LET g_pmdt_d[l_ac].amt3 = g_pmdt_d[l_ac].amt3 * -1 #融資負數
      LET g_pmdt_d[l_ac].pmdtseq = l_odr
      INSERT INTO anmq311_tmp01 VALUES(g_pmdt_d[l_ac].*,l_odr)    #160727-00019#4 Mod  anmq311_bfill_tmp--> anmq311_tmp01

      LET l_odr = l_odr + 1
      LET l_apca100_t = g_pmdt_d[l_ac].apca100
      LET l_nmas002_t = g_pmdt_d[l_ac].l_nmas002


      #end add-point
 
      CALL anmq311_detail_show("'1'")      
 
      CALL anmq311_pmdt_t_mask()
 
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
   
 
   
   CALL g_pmdt_d.deleteElement(g_pmdt_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   #最後一筆資料須在foreach外做小計
   IF l_ac > 1 THEN 
      INITIALIZE l_tmp TO NULL      
      LET g_sql =" SELECT '','','','','',                          ",
                 "        '','','',                                ",
                 "        SUM(amt1),SUM(amt2),SUM(amt3),           ", 
                 "        SUM(amt4),SUM(amt5),SUM(amt6),SUM(sum1), ",
                 "        '', ''     ,'','','','2',                ",
                 "        ''                                       ",   #151127-00002#5
                 "   FROM anmq311_tmp                              ",
                 "  WHERE apca100 = '",l_apca100_t,"'              ",
                 "   AND ", ls_wc        
      PREPARE anmq311_b_fill_prep4 FROM g_sql
      EXECUTE anmq311_b_fill_prep4 INTO l_tmp.* 
      LET l_tmp.amt1 = l_tmp.amt1 * -1 #應付帳款負數
      LET l_tmp.amt2 = l_tmp.amt2 * -1 #預計提出負數
      LET l_tmp.amt3 = l_tmp.amt3 * -1 #融資負數
      LET l_tmp.apcasite_desc = 'curry_sum' #依幣別小記所在欄位flag 
      LET l_tmp.nmaa001_desc = cl_getmsg('lib-00156',g_dlang) 
      LET l_tmp.nmaa001_desc = l_apca100_t,l_tmp.nmaa001_desc          
      LET l_tmp.apca100 = l_apca100_t 
      INSERT INTO  anmq311_tmp01 VALUES(l_tmp.*,l_odr)     #160727-00019#4 Mod  anmq311_bfill_tmp--> anmq311_tmp01
          
   END IF      
   
   CALL g_pmdt_d.clear()
   LET l_ac = 1
   LET g_sql = " SELECT * FROM anmq311_tmp01 ORDER BY odr "   #160727-00019#4 Mod  anmq311_bfill_tmp--> anmq311_tmp01
   LET l_apca100_t = ''
   LET l_nmas002_t = ''
   PREPARE anmq311_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR anmq311_pb2
   FOREACH b_fill_curs2 INTO g_pmdt_d[l_ac].* 
      #不屬於小計的   
      IF g_pmdt_d[l_ac].l_nmas002 = l_nmas002_t THEN
         IF l_ac > 1 THEN
            LET g_pmdt_d[l_ac].sum1 = g_pmdt_d[l_ac-1].sum1 + g_pmdt_d[l_ac].amt1 + g_pmdt_d[l_ac].amt2
                                    + g_pmdt_d[l_ac].amt3   + g_pmdt_d[l_ac].amt4 + g_pmdt_d[l_ac].amt5
                                    + g_pmdt_d[l_ac].amt6
         END IF
      ELSE
         #銀存檔nmbx會在每筆的第一行
         LET g_pmdt_d[l_ac].sum1 = g_pmdt_d[l_ac].amt6
      END IF                                    
               
      IF cl_null(g_pmdt_d[l_ac].l_nmas002) AND NOT cl_null(g_pmdt_d[l_ac].apca010) THEN
         IF l_ac > 1 THEN
            LET g_pmdt_d[l_ac].sum1 = g_pmdt_d[l_ac-1].sum1 + g_pmdt_d[l_ac].amt1 + g_pmdt_d[l_ac].amt2
                                    + g_pmdt_d[l_ac].amt3   + g_pmdt_d[l_ac].amt4 + g_pmdt_d[l_ac].amt5
                                    + g_pmdt_d[l_ac].amt6    
         END IF
      END IF
      #屬於小計的
      IF g_pmdt_d[l_ac].apcasite_desc = 'curry_sum' THEN
         LET g_pmdt_d[l_ac].sum1 =  g_pmdt_d[l_ac].amt1 + g_pmdt_d[l_ac].amt2
                                  + g_pmdt_d[l_ac].amt3  + g_pmdt_d[l_ac].amt4 + g_pmdt_d[l_ac].amt5
                                  + g_pmdt_d[l_ac].amt6           
      END IF
              
      IF NOT cl_null(g_pmdt_d[l_ac].pmdtdocno) THEN     
         CALL s_aooi200_get_slip(g_pmdt_d[l_ac].pmdtdocno) RETURNING g_sub_success,l_slip         
         SELECT oobx003 INTO g_pmdt_d[l_ac].gzzz001
           FROM oobx_t
          WHERE oobxent = g_enterprise
            AND oobx001 = l_slip
      END IF

      #帳戶說明
      IF NOT cl_null(g_pmdt_d[l_ac].l_nmas002) THEN
         CALL s_desc_get_nmas002_desc(g_pmdt_d[l_ac].l_nmas002) RETURNING g_pmdt_d[l_ac].nmaa001_desc
      END IF
      #對象
      CALL s_desc_get_trading_partner_abbr_desc(g_pmdt_d[l_ac].apca005)RETURNING g_pmdt_d[l_ac].apca005_desc
      #作業名稱
      CALL s_desc_get_prog_desc(g_pmdt_d[l_ac].gzzz001) RETURNING g_pmdt_d[l_ac].gzzz001_desc
      
      LET l_apca100_t = g_pmdt_d[l_ac].apca100   
      LET l_nmas002_t = g_pmdt_d[l_ac].l_nmas002
      
      LET l_ac = l_ac + 1
   END FOREACH
   
   
   
   CALL g_pmdt_d.deleteElement(g_pmdt_d.getLength())
   LET g_tot_cnt = g_pmdt_d.getLength()
   CALL cl_progress_ing("Data processing... ")
   #end add-point
 
   LET g_detail_cnt = g_pmdt_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE anmq311_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL anmq311_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL anmq311_detail_action_trans()
 
   IF g_pmdt_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL anmq311_fetch()
   END IF
   
      CALL anmq311_filter_show('apcadocdt','b_apcadocdt')
   CALL anmq311_filter_show('apca008','b_apca008')
   CALL anmq311_filter_show('apcasite','b_apcasite')
   CALL anmq311_filter_show('apca010','b_apca010')
   CALL anmq311_filter_show('pmdtdocno','b_pmdtdocno')
   CALL anmq311_filter_show('pmdtseq','b_pmdtseq')
   CALL anmq311_filter_show('apcc009','b_apcc009')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq311.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmq311_fetch()
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
 
{<section id="anmq311.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmq311_detail_show(ps_page)
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
 
{<section id="anmq311.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION anmq311_filter()
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
      CONSTRUCT g_wc_filter ON apcadocdt,apca008,apcasite,apca010,pmdtdocno,pmdtseq,apcc009
                          FROM s_detail1[1].b_apcadocdt,s_detail1[1].b_apca008,s_detail1[1].b_apcasite, 
                              s_detail1[1].b_apca010,s_detail1[1].b_pmdtdocno,s_detail1[1].b_pmdtseq, 
                              s_detail1[1].b_apcc009
 
         BEFORE CONSTRUCT
                     DISPLAY anmq311_filter_parser('apcadocdt') TO s_detail1[1].b_apcadocdt
            DISPLAY anmq311_filter_parser('apca008') TO s_detail1[1].b_apca008
            DISPLAY anmq311_filter_parser('apcasite') TO s_detail1[1].b_apcasite
            DISPLAY anmq311_filter_parser('apca010') TO s_detail1[1].b_apca010
            DISPLAY anmq311_filter_parser('pmdtdocno') TO s_detail1[1].b_pmdtdocno
            DISPLAY anmq311_filter_parser('pmdtseq') TO s_detail1[1].b_pmdtseq
            DISPLAY anmq311_filter_parser('apcc009') TO s_detail1[1].b_apcc009
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_apcadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_apcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcadocdt
            #add-point:ON ACTION controlp INFIELD b_apcadocdt name="construct.c.filter.page1.b_apcadocdt"
            
            #END add-point
 
 
         #----<<b_apca008>>----
         #Ctrlp:construct.c.page1.b_apca008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca008
            #add-point:ON ACTION controlp INFIELD b_apca008 name="construct.c.filter.page1.b_apca008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooib001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apca008  #顯示到畫面上
            NEXT FIELD b_apca008                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_apcasite>>----
         #Ctrlp:construct.c.page1.b_apcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcasite
            #add-point:ON ACTION controlp INFIELD b_apcasite name="construct.c.filter.page1.b_apcasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apcasite  #顯示到畫面上
            NEXT FIELD b_apcasite                     #返回原欄位
    


            #END add-point
 
 
         #----<<apcasite_desc>>----
         #----<<b_apca010>>----
         #Ctrlp:construct.c.filter.page1.b_apca010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca010
            #add-point:ON ACTION controlp INFIELD b_apca010 name="construct.c.filter.page1.b_apca010"
            
            #END add-point
 
 
         #----<<l_nmas002>>----
         #----<<b_nmaa001_desc>>----
         #----<<b_apca100>>----
         #----<<amt1>>----
         #----<<amt2>>----
         #----<<amt3>>----
         #----<<amt4>>----
         #----<<amt5>>----
         #----<<amt6>>----
         #----<<sum1>>----
         #----<<b_pmdtdocno>>----
         #Ctrlp:construct.c.filter.page1.b_pmdtdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdtdocno
            #add-point:ON ACTION controlp INFIELD b_pmdtdocno name="construct.c.filter.page1.b_pmdtdocno"
            
            #END add-point
 
 
         #----<<b_apca005>>----
         #----<<apca005_desc>>----
         #----<<b_gzzz001>>----
         #----<<gzzz001_desc>>----
         #----<<b_pmdtseq>>----
         #Ctrlp:construct.c.filter.page1.b_pmdtseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdtseq
            #add-point:ON ACTION controlp INFIELD b_pmdtseq name="construct.c.filter.page1.b_pmdtseq"
            
            #END add-point
 
 
         #----<<b_apcc009>>----
         #Ctrlp:construct.c.filter.page1.b_apcc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc009
            #add-point:ON ACTION controlp INFIELD b_apcc009 name="construct.c.filter.page1.b_apcc009"
            
            #END add-point
 
 
   
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      #151013-00016#2---start
      CONSTRUCT g_wc_filter2 ON nmas002 FROM s_detail1[1].l_nmas002
         BEFORE CONSTRUCT
            DISPLAY anmq311_filter_parser('nmas002') TO s_detail1[1].l_nmas002
            
         ON ACTION controlp INFIELD l_nmas002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmaa002 IN (SELECT ooef001 ",
                                   "               FROM ooef_t  ",
                                   "              WHERE ooefent = ",g_enterprise,
                                   "                AND ooef017 = '",g_input.l_comp,"' )"
            CALL q_nmas_01()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_nmas002  #顯示到畫面上
            NEXT FIELD l_nmas002                     #返回原欄位
      END CONSTRUCT
      #151013-00016#2---end
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
   
      CALL anmq311_filter_show('apcadocdt','b_apcadocdt')
   CALL anmq311_filter_show('apca008','b_apca008')
   CALL anmq311_filter_show('apcasite','b_apcasite')
   CALL anmq311_filter_show('apca010','b_apca010')
   CALL anmq311_filter_show('pmdtdocno','b_pmdtdocno')
   CALL anmq311_filter_show('pmdtseq','b_pmdtseq')
   CALL anmq311_filter_show('apcc009','b_apcc009')
 
    
   CALL anmq311_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq311.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION anmq311_filter_parser(ps_field)
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
 
{<section id="anmq311.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION anmq311_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmq311_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq311.insert" >}
#+ insert
PRIVATE FUNCTION anmq311_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmq311.modify" >}
#+ modify
PRIVATE FUNCTION anmq311_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq311.reproduce" >}
#+ reproduce
PRIVATE FUNCTION anmq311_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq311.delete" >}
#+ delete
PRIVATE FUNCTION anmq311_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq311.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION anmq311_detail_action_trans()
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
 
{<section id="anmq311.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION anmq311_detail_index_setting()
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
            IF g_pmdt_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_pmdt_d.getLength() AND g_pmdt_d.getLength() > 0
            LET g_detail_idx = g_pmdt_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_pmdt_d.getLength() THEN
               LET g_detail_idx = g_pmdt_d.getLength()
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
 
{<section id="anmq311.mask_functions" >}
 &include "erp/anm/anmq311_mask.4gl"
 
{</section>}
 
{<section id="anmq311.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 創建臨時表
# Memo...........:
# Usage..........: CALLanmq311_create_tmp()
# Date & Author..: 2015/09/15 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq311_create_tmp()

   DROP TABLE anmq311_tmp;
   
   CREATE TEMP TABLE anmq311_tmp (
      apcaent      SMALLINT,        #營運據點
      apcadocdt    DATE,      #日期
      apca008      VARCHAR(10),        #付款條件編號
      apcasite     VARCHAR(10),       #營運據點
      apca010      DATE,        #票據到期日
      nmas002      VARCHAR(10),        #銀行編號
      apca100      VARCHAR(10),        #幣別
      amt1         DECIMAL(20,6),        #應付帳款
      amt2         DECIMAL(20,6), 
      amt3         DECIMAL(20,6), 
      amt4         DECIMAL(20,6), 
      amt5         DECIMAL(20,6), 
      amt6         DECIMAL(20,6),      #0930
      sum1         DECIMAL(20,6), 
      pmdtdocno    VARCHAR(20),
      apca005      VARCHAR(10),        #交易對象
      l_type       SMALLINT,
      apcc009      VARCHAR(20)     #151127-00002#5
    )
   DROP TABLE anmq311_tmp01;            #160727-00019#4 Mod  anmq311_bfill_tmp--> anmq311_tmp01
   CREATE TEMP TABLE anmq311_tmp01(     #160727-00019#4 Mod  anmq311_bfill_tmp--> anmq311_tmp01
       apcadocdt       DATE,
       apca008         VARCHAR(10), 
       apcasite        VARCHAR(10), 
       apcasite_desc   VARCHAR(500), 
       apca010         DATE, 
       nmas002         VARCHAR(10), 
       nmaa001_desc    VARCHAR(80), 
       apca100         VARCHAR(100), 
       amt1            DECIMAL(20,6), 
       amt2            DECIMAL(20,6), 
       amt3            DECIMAL(20,6), 
       amt4            DECIMAL(20,6), 
       amt5            DECIMAL(20,6),
       amt6            DECIMAL(20,6),      #0930       
       sum1            DECIMAL(20,6), 
       pmdtdocno       VARCHAR(20),  
       apca005         VARCHAR(10), 
       apca005_desc    VARCHAR(500),
       gzzz001         VARCHAR(80), 
       gzzz001_desc    VARCHAR(500),       
       pmdtseq         INTEGER,
       apcc009         VARCHAR(20),        #151127-00002#5
       odr             SMALLINT
     )
     #151013-00016#2---start
     DROP TABLE anmq311_x01_tmp;
     CREATE TEMP TABLE anmq311_x01_tmp(
     seq           INTEGER,
     apca010       DATE, 
     nmas002       VARCHAR(500), 
     nmaa001_desc  VARCHAR(80), 
     apca100       VARCHAR(500), 
     amt1          DECIMAL(20,6), 
     amt2          DECIMAL(20,6), 
     amt3          DECIMAL(20,6),              
     amt4          DECIMAL(20,6), 
     amt5          DECIMAL(20,6), 
     amt6          DECIMAL(20,6), 
     sum1          DECIMAL(20,6), 
     pmdtdocno     VARCHAR(20), 
     apca005       VARCHAR(500), 
     apca005_desc  VARCHAR(500), 
     gzzz001       VARCHAR(80), 
     gzzz001_desc  VARCHAR(500), 
     pmdtseq       INTEGER,
     apcc009       VARCHAR(20),        #151127-00002#5
     l_comp_desc   VARCHAR(500),
     l_enddate     DATE,
     l_type        VARCHAR(500),        #0:明細 1:日記
     l_flag        VARCHAR(1))          #控制欄位隱顯
     #151013-00016#2---end
END FUNCTION

################################################################################
# Descriptions...: 插入臨時表
# Memo...........: 應付帳款出帳
# Usage..........: CALL anmq311_insert_tmp_ap()
# Date & Author..: 2015/09/15 By Hans
# Modify.........: 
################################################################################
PRIVATE FUNCTION anmq311_insert_tmp_ap()
DEFINE l_docdt       LIKE apca_t.apcadocdt
DEFINE l_docno       LIKE apca_t.apcadocno
DEFINE l_apca009     LIKE apca_t.apca009
DEFINE l_apca010     LIKE apca_t.apca010
DEFINE l_pmdt024     LIKE pmdt_t.pmdt024  #計價數量
DEFINE l_pmdt0242    LIKE pmdt_t.pmdt024  #計價數量 二
DEFINE l_pmdt0243    LIKE pmdt_t.pmdt024  #計價數量 三
DEFINE l_pmdt036     LIKE pmdt_t.pmdt036  #金額
DEFINE l_pmdt0362    LIKE pmdt_t.pmdt036  #金額二
DEFINE l_pmdt0363    LIKE pmdt_t.pmdt036  #金額二
DEFINE l_pmdl004     LIKE pmdl_t.pmdl004  #交易對象
DEFINE l_pmdl015     LIKE pmdl_t.pmdl015  #幣別
DEFINE l_pmdo015     LIKE pmdo_t.pmdo015  #已收貨量
DEFINE l_pmdo019     LIKE pmdo_t.pmdo019  #已入庫量
DEFINE l_pmdl009     LIKE pmdl_t.pmdl009  #付款條件
DEFINE l_pmdlsite    LIKE pmdl_t.pmdlsite #營運據點
DEFINE l_msg1        LIKE gzzd_t.gzzd005    
DEFINE l_msg2        LIKE gzzd_t.gzzd005 
DEFINE l_msg3        LIKE gzzd_t.gzzd005 
DEFINE l_pmdodocno   LIKE pmdo_t.pmdodocno
DEFINE l_pmdoseq     LIKE pmdo_t.pmdoseq
DEFINE l_pmdoseq1    LIKE pmdo_t.pmdoseq1
DEFINE l_pmdoseq2    LIKE pmdo_t.pmdoseq2

   #都已經起點的單價為主

   #SUM1  
   #未付款發票 apca_t
   CALL cl_get_para(g_enterprise,g_input.l_comp,'S-BAS-0019') RETURNING g_sbas0019         #是否走計價數量 
   IF g_input.l_chk1 = 'Y' THEN 
      #show_msg 未付款發票
      SELECT gzzd005 INTO l_msg1 FROM gzzd_t WHERE gzzd003 = 'lbl_chk1' AND gzzd002 = g_dlang AND gzzd001 = 'anmq311'
      CALL cl_progress_ing(l_msg1)
      LET g_sql = " INSERT INTO anmq311_tmp            ",
                  " SELECT apcaent,apcadocdt,apca008,apcasite,apcc004,'',apcc100,      ",
                  "        (CASE WHEN apca001 LIKE '2%' THEN (apcc108-apcc109) * -1 ELSE (apcc108-apcc109) END),    ",
                  "        0,0,0,0,0,0,                                       ",
                  "        apcadocno,apca005,'2',                             ",
                  "        apcc009                                            ",   #151127-00002#5
                  "   FROM apca_t,apcc_t                                      ",
                  "  WHERE apcaent = apccent AND apcaent = '",g_enterprise,"' ",
                  "    AND apcald = apccld AND apcadocno = apccdocno          ",
                  "    AND apcastus = 'Y' AND (apcc108-apcc109) > 0           ",
                  "    AND apcc004 <= '",g_input.l_enddate,"'                 ",
                  "    AND apcccomp = '",g_input.l_comp,"'                    "                 
      PREPARE anmq311_prep01 FROM g_sql
      EXECUTE anmq311_prep01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins_apca_t,ins_apcc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      #己作付款核銷，但是尚未拉到出納段的資料
      LET g_sql = " INSERT INTO anmq311_tmp            ",
                  " SELECT apdaent,apdadocdt,'',apdasite,apde032,apde008,apde100, ",
                  "        apde109,                                           ",
                  "        0,0,0,0,0,0,                                       ",
                  "        apdadocno,apda005,'2',                             ",
                  "        ''                                                 ",   #151127-00002#5
                  "   FROM apda_t,apde_t                                      ",
                  "  WHERE apdaent = apdeent AND apdaent = '",g_enterprise,"' ",                  
                  "    AND apdald = apdeld AND apdadocno = apdedocno          ",
                  "    AND apdastus = 'Y' AND apde006 IN ('10','20')          ",
                  "    AND apde009 = 'N'                                      ",
                  "    AND apde032 <= '",g_input.l_enddate,"'                 ",
                  "    AND apdacomp = '",g_input.l_comp,"'                    "                 
      PREPARE anmq311_prep012 FROM g_sql
      EXECUTE anmq311_prep012
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins_apda_t,ins_apde_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF            
   END IF
   
   IF g_input.l_chk3 = 'Y' THEN      
      #show_msg 未進貨採購
      SELECT gzzd005 INTO l_msg3 FROM gzzd_t WHERE gzzd003 = 'lbl_chk3' AND gzzd002 = g_dlang AND gzzd001 = 'anmq311'
      CALL cl_progress_ing(l_msg3)
      #未進貨採購   採購200 收貨100 驗退20(80) 入庫 70( 倉退 20 數量 = 200 -(100-20-20 ) = 140   應該付款未收貨數量
      LET g_sql = " SELECT pmdlsite,pmdl009,pmdo013,pmdldocno,pmdl015,         ",
                  "        pmdo031,pmdo022,pmdl004,pmdo015,pmdo019,              ",
                  "        pmdoseq,pmdoseq1,pmdoseq2                             ",
                  "   FROM pmdl_t,pmdo_t                                         ",
                  "  WHERE pmdlent = pmdoent AND pmdlent = '",g_enterprise,"'    ",
                  "    AND pmdldocno = pmdodocno                                 ",
                  "    AND pmdl005 ='1' AND pmdo021 <> '5'                       ", #交貨狀態 5:結案
                  "    AND (pmdo006 > pmdo015 OR pmdo006 > pmdo019 )             ", #尚有有未入庫數量 pmdo006=分批採購數量
                  "    AND pmdldocdt <= '",g_input.l_enddate,"'                  ",
                  "    AND pmdlstus <> 'C'                                       ",
                  "    AND pmdlsite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef017 = '",g_input.l_comp,"' ) "  #160905-00007#8  add ooefent = ",g_enterprise,"            
      PREPARE anmq311_prep02 FROM g_sql
      DECLARE anmq311_curs02 CURSOR FOR anmq311_prep02
      FOREACH anmq311_curs02 INTO l_pmdlsite,l_pmdl009,l_docdt  ,l_docno,l_pmdl015,
                                  l_pmdt024 ,l_pmdt036,l_pmdl004,l_pmdo015,l_pmdo019,
                                  l_pmdoseq,l_pmdoseq1,l_pmdoseq2
         #取收貨或者貨入庫數量                      
         IF l_pmdo015 >= l_pmdo019 THEN #取收貨量
            SELECT SUM (pmdt024) INTO l_pmdt0242
              FROM pmds_t,pmdt_t 
             WHERE pmdsent = pmdtent AND pmdtent = g_enterprise 
               AND pmdsdocno = pmdtdocno 
               AND pmdt001 = l_docno 
               AND pmdt002 = l_pmdoseq AND pmdt003 = l_pmdoseq1 AND pmdt004 = l_pmdoseq2
               AND pmds000 = '1' #收貨單
               AND pmdsdocdt <= g_input.l_enddate AND pmdsstus = 'Y'
         ELSE
            SELECT SUM (pmdt024) INTO l_pmdt0242
              FROM pmds_t,pmdt_t 
             WHERE pmdsent = pmdtent AND pmdtent = g_enterprise 
               AND pmdsdocno = pmdtdocno
               AND pmdt001 = l_docno 
               AND pmdt002 = l_pmdoseq AND pmdt003 = l_pmdoseq1 AND pmdt004 = l_pmdoseq2
               AND pmds000= '3' #入庫單
               AND pmdsdocdt <= g_input.l_enddate AND pmdsstus = 'S'
         END IF
         #取倉退/驗退數量
         SELECT SUM (pmdt024) INTO l_pmdt0243
           FROM pmds_t,pmdt_t 
          WHERE pmdsent = pmdtent AND pmdtent = g_enterprise 
            AND pmdsdocno = pmdtdocno 
            AND pmdt001 = l_docno 
            AND pmdt002 = l_pmdoseq AND pmdt003 = l_pmdoseq1 AND pmdt004 = l_pmdoseq2
            AND pmds000 IN ('5','7')  #倉退單
            AND pmdsdocdt <= g_input.l_enddate AND pmdsstus = 'S'
         
         IF cl_null(l_pmdt0242) THEN LET l_pmdt0242 = 0 END IF
         IF cl_null(l_pmdt0243) THEN LET l_pmdt0243 = 0 END IF  
     
         LET l_pmdt024 = l_pmdt024 - l_pmdt0242 + l_pmdt0243
         LET l_pmdt036 = l_pmdt024 * l_pmdt036
         #取票到期日     
         CALL s_fin_date_ap_payable(l_pmdlsite,l_pmdl004,l_pmdl009,l_docdt,l_docdt,l_docdt,l_docdt)
             RETURNING g_sub_success,l_apca009,l_apca010            
         INSERT INTO anmq311_tmp
         VALUES (g_enterprise,l_docdt,l_pmdl009,l_pmdlsite,l_apca010,'',l_pmdl015,l_pmdt036,
                 0,0,0,0,0,0,l_docno,l_pmdl004,'2','')   #151127-00002#5 add ''              
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins_pmdl_t,ins_pmdo_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF            
      END FOREACH
                   
     
   END IF
  
   #未請款進貨/已經收貨未入庫
   #已經收貨的計價數量(不管有無採購)包含收貨-入庫+驗退+倉退 
   IF g_input.l_chk2 = 'Y' THEN
      #show_msg 未請款進貨
      SELECT gzzd005 INTO l_msg2 FROM gzzd_t WHERE gzzd003 = 'lbl_chk2' AND gzzd002 = g_dlang AND gzzd001 = 'anmq311'
      CALL cl_progress_ing(l_msg2)                
                   
      LET g_sql = " SELECT pmdssite,pmds031,pmdsdocdt,pmdsdocno,pmds037,SUM(pmdt036a),pmds008 FROM(                                ",
                  " SELECT a.pmdssite,a.pmds031,a.pmdsdocdt,a.pmdsdocno,a.pmds037,                                                 ",
                  "       SUM((a.pmdt024-COALESCE(pmdt024b,0)+COALESCE(pmdt024c,0)) * a.pmdt036) pmdt036a ,a.pmds008               ",
                  "   FROM pmds_t a,pmdt_t a                                                                                       ", 
                  "   LEFT OUTER JOIN                                                                                              ",
                  "        ( SELECT SUM(CASE WHEN pmds000 IN ('5','7') THEN pmdt024 * -1 ELSE pmdt024 END ) pmdt024b,              ",
                  "              pmds006,pmdt028                                                                                   ",
                  "            FROM pmds_t,pmdt_t                                                                                  ",             
                  "           WHERE pmds000 IN ('5','6','7')  AND  pmdsdocdt <= '",g_input.l_enddate,"'                            ",
                  "             AND pmdsdocno = pmdtdocno  AND pmdsent = pmdtent AND pmdsent  = '",g_enterprise,"'                 ",
                  "             AND pmdsstus = 'S'                                                                                 ",
                  "           GROUP BY pmds006,pmdt028 ) b                                                                         ",
                  "             ON b.pmds006 = a.pmdtdocno AND b.pmdt028 = a.pmdtseq                                               ",
                  "   LEFT OUTER JOIN                                                                                              ",
                  "           ( SELECT SUM((CASE WHEN pmds000 IN ('5','7') THEN pmdt024 * -1 ELSE pmdt024 END)-pmdt056)  pmdt024c, ",
                  "                             pmds006,pmdt028                                                                    ",
                  "               FROM pmds_t,pmdt_t                                                                               ",
                  "              WHERE pmds000 IN ('5','6','7') AND pmdsdocdt <= '",g_input.l_enddate,"'                           ",
                  "                AND pmdsdocno = pmdtdocno  AND pmdsstus = 'S'                                                   ",
                  "              AND pmdsent =pmdtent AND pmdsent  = '",g_enterprise,"'                                            ",
                  "              GROUP BY pmds006,pmdt028 ) c                                                                      ",
                  "           ON c.pmds006 = a.pmdtdocno AND c.pmdt028 = a.pmdtseq                 ",                                  
                  "  WHERE a.pmdsent   = a.pmdtent   AND a.pmdsent  = '",g_enterprise,"'           ",
                  "    AND a.pmdsdocno = a.pmdtdocno AND a.pmdsdocdt <= '",g_input.l_enddate,"'    ", 
                  "    AND a.pmdsstus IN ('Y','S')                                                 ",
                  "    AND a.pmds000  IN ('1','2')                                                 ",
                  "    AND a.pmdssite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND  ooef017 = '",g_input.l_comp,"' ) ", #160905-00007#8 add ooefent = ",g_enterprise,"
                  " GROUP BY a.pmdssite,a.pmds031,a.pmdsdocdt,a.pmdsdocno,a.pmds037,a.pmds008               ",
                  " UNION                                                                                   ",
                  "SELECT d.pmdssite,d.pmds031,d.pmdsdocdt,d.pmdsdocno,d.pmds037,                           ",#apmt530/apmt532入庫                
                  "   SUM((d.pmdt024-COALESCE(d.pmdt056,0)-COALESCE(pmdt024e,0)) * d.pmdt036),d.pmds008     ",#(計價數量-驗退-立帳)*單價
                  "  FROM pmds_t d,pmdt_t d                                                                 ",
                  "  LEFT OUTER JOIN                                                                        ",
                  "      ( SELECT SUM(pmdt024) pmdt024e ,                                                   ", #驗退+已經立帳
                  "               pmds006,pmdt028                                                           ",
                  "         FROM pmds_t,pmdt_t                                                              ",                      
                  "        WHERE pmds000 IN ('5','7') AND pmdsdocno = pmdtdocno                             ",        
                  "           AND pmdsent = pmdtent AND pmdsent  = '",g_enterprise,"'                       ",
                  "           AND pmdsstus = 'S'    AND pmdsdocdt <= '",g_input.l_enddate,"'                ",
                  "    GROUP BY pmds006,pmdt028) e                                                          ",
                  "       ON  e.pmds006 = d.pmdtdocno AND e.pmdt028 = d.pmdtseq                             ",
                  "    WHERE d.pmds000 IN ('3','4') AND d.pmdsdocno = d.pmdtdocno AND d.pmdsstus = 'S'      ",
                  "      AND d.pmdsent  = '",g_enterprise,"'  AND d.pmdsdocdt <= '",g_input.l_enddate,"'    ",
                  "   GROUP BY d.pmdssite,d.pmds031,d.pmdsdocdt,d.pmdsdocno,d.pmds037,d.pmds008            )",
                  "   WHERE pmdssite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef017 = '",g_input.l_comp,"' )  ", #160905-00007#8 add ooefent = ",g_enterprise,"    
                  "   GROUP BY pmdssite,pmds031,pmdsdocdt,pmdsdocno,pmds037,pmds008                         "
                  
      PREPARE anmq311_prep03 FROM g_sql
      DECLARE anmq311_curs03 CURSOR FOR anmq311_prep03
      FOREACH anmq311_curs03 INTO l_pmdlsite,l_pmdl009,l_docdt,l_docno,l_pmdl015,
                                  l_pmdt036,l_pmdl004
                                  
         #取票到期日
         CALL s_fin_date_ap_payable(l_pmdlsite,l_pmdl004,l_pmdl009,l_docdt,l_docdt,l_docdt,l_docdt)
               RETURNING g_sub_success,l_apca009,l_apca010                
      　 INSERT INTO anmq311_tmp
         VALUES (g_enterprise,l_docdt,l_pmdl009,l_pmdlsite,l_apca010,'',l_pmdl015,l_pmdt036,
                 0,0,0,0,0,0,l_docno,l_pmdl004,'2','')   #151127-00002#5 add ''                       
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins_pmdl_t,ins_pmdo_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
      END FOREACH                                                                                                                   

   END IF
   #未進貨採購   採購200 收貨100 驗退20(80) 入庫 70( 倉退 20 數量 = 200 -(100-20-20 ) = 140   應該付款未收貨數量
#   LET g_sql = " INSERT INTO anmq311_tmp                                   ",
#               " SELECT pmdlent,pmdldocdt,'',pmdl015,                      ",
#               "        pmdo022*(pmdo031-((CASE WHEN pmdo015 >= pmdo019 THEN pmdo015 ELSE pmdo019 END )-pmdo017-pmdo040)  ), ",
#               "        0,0,0,0,0,                                         ",
#               "        pmdldocno,pmdl004                                  ",
#               "  FROM pmdl_t,pmdo_t                                       ",
#               " WHERE pmdlent = pmdoent AND pmdlent = '",g_enterprise,"'  ",
#               "   AND pmdldocno = pmdodocno                               ",
#               "   AND pmdl001 ='1' AND pmdo021 <> '5'                     ", #交貨狀態 5:結案
#               "   AND (pmdo006 > pmdo015 OR pmdo006 > pmdo019 )           ", #尚有有未入庫數量 pmdo006=分批採購數量
#               "   AND pmdldocdt <= '",g_input.l_enddate,"'                "  
#   PREPARE anmq311_prep01 FROM g_sql
#   EXECUTE anmq311_prep01
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = "ins_pmdl_t,ins_pmdo_t"
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#   END IF

END FUNCTION

################################################################################
# Descriptions...: 插入臨時表
# Memo...........: 預計提出/應收票據入帳
# Usage..........: CALL anmq311_insert_tmp_nm()
# Date & Author..: 2015/09/18 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq311_insert_tmp_nm()
DEFINE l_gzzd005   LIKE gzzd_t.gzzd005   
  #show_msg 銀存統計檔
   SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'lbl_bank' AND gzzd002 = g_dlang AND gzzd001 = 'anmq311'
   CALL cl_progress_ing(l_gzzd005)
   #銀存統計檔/可用資金餘額
   LET g_sql = " INSERT INTO anmq311_tmp    ",
               " SELECT nmbxent,'','','','',nmbx003,nmbx100,                           ",
               "        0,0,0,0,0,SUM(nmbx103-nmbx104),0,'','','1',                    ",
               "        ''                                                             ",   #151127-00002#5
               "  FROM nmbx_t                                                          ",
               " WHERE nmbxent = '",g_enterprise,"'                                    ",
               "   AND nmbx001 = '",g_nmbx001,"' AND nmbx002 <= '",g_nmbx002,"'        ",
               "   AND nmbxcomp = '",g_input.l_comp,"'                                 ",
               "   GROUP BY nmbxent,nmbx003,nmbx100                                    "
   PREPARE anmq311_prep09 FROM g_sql
   EXECUTE anmq311_prep09
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "nmbx_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF   
   
   #預計提出 2
   LET g_sql = " INSERT INTO anmq311_tmp            ",
               " SELECT nmckent,nmckdocdt,'',nmcksite,nmck011,nmck004,nmck100, ",
               "        0,nmck103,0,0,0,0,0,                                   ",
               "        nmckdocno,nmck005,'2',                                 ",
               "        nmck025                                                ",   #151127-00002#5
               "   FROM nmck_t                                                 ",
               "  WHERE nmck026 IN ('0','1','2','6','10','12')                 ",
               "    AND nmckstus = 'Y' AND nmck011 <='",g_input.l_enddate,"'   ",
               "    AND nmcksite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef017 = '",g_input.l_comp,"' ) "  #160905-00007#8 ADD  ooefent = ",g_enterprise,"       
   PREPARE anmq311_prep04 FROM g_sql
   EXECUTE anmq311_prep04
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins_nmck_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF            
  
   #應收票據入帳 3
   LET g_sql ="   INSERT INTO anmq311_tmp                                       ",
              "   SELECT nmbbent,nmbadocdt,'',nmbasite,nmbb031,trim(nmbb003),nmbb004, ",
              "          0,0,0,(nmbb006 - COALESCE(nmbb051,0)),0,0,0,           ",
              "          nmbadocno,nmbb026,'2',                                 ",
              "          ''                                                     ",   #151127-00002#5
              "     FROM nmba_t,nmbb_t                                          ",
              "    WHERE nmbaent = nmbbent AND nmbaent = '",g_enterprise,"'     ",
              #"     AND nmbadocno = nmbbdocno AND nmbastus IN ('Y','V')         ", #161026-00010#2 mark
              "     AND nmbadocno = nmbbdocno AND nmbastus IN ('V')              ", #161026-00010#2 add 
              "     AND nmbb042 IN ('1','2','4')                                ",
              "     AND nmbb031 <= '",g_input.l_enddate,"'                      ",
              "     AND nmbasite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef017 = '",g_input.l_comp,"' ) "   #160905-00007#8 ADD  ooefent = ",g_enterprise,"     
   PREPARE anmq311_prep05 FROM g_sql
   EXECUTE anmq311_prep05
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins_nmba_t,ins_nmbb_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF  
   
END FUNCTION

################################################################################
# Descriptions...: 插入臨時表
# Memo...........: 預計存入
# Usage..........: CALL anmq311_insert_tmp_ar()
# Date & Author..: 2015/09/18 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq311_insert_tmp_ar()
DEFINE l_xmdasite   LIKE xmda_t.xmdasite
DEFINE l_xmdadocdt  LIKE xmda_t.xmdadocdt
DEFINE l_xmda009    LIKE xmda_t.xmda009
DEFINE l_xmda004    LIKE xmda_t.xmda004
DEFINE l_xmda015    LIKE xmda_t.xmda015
DEFINE l_xmdadocno  LIKE xmda_t.xmdadocno 
DEFINE l_xmddseq    LIKE xmdd_t.xmddseq
DEFINE l_xmddseq1   LIKE xmdd_t.xmddseq1
DEFINE l_xmddseq2   LIKE xmdd_t.xmddseq2
DEFINE l_xmdd018    LIKE xmdd_t.xmdd018 #參考價格
DEFINE l_xmdd027    LIKE xmdd_t.xmdd027 #分批計價數量
DEFINE l_xmdl022    LIKE xmdl_t.xmdl022 #計價數量
DEFINE l_xmdk000    LIKE xmdk_t.xmdk000
DEFINE l_apca009    LIKE apca_t.apca009
DEFINE l_apca010    LIKE apca_t.apca010
DEFINE l_msg4     LIKE gzzd_t.gzzd005    
DEFINE l_msg5     LIKE gzzd_t.gzzd005 
DEFINE l_msg6     LIKE gzzd_t.gzzd005  

   #預計存入
   #未收款發票
   IF g_input.l_chk4 ='Y' THEN
     #show_msg 未收款發票
     SELECT gzzd005 INTO l_msg4 FROM gzzd_t WHERE gzzd003 = 'lbl_chk4' AND gzzd002 = g_dlang AND gzzd001 = 'anmq311'
     CALL cl_progress_ing(l_msg4)
      LET g_sql =" INSERT INTO anmq311_tmp                                       ",
                 " SELECT xrcaent,xrcadocdt,'',xrcasite,xrcc004,'',xrcc100,      ",
                 "        0,0,0,0,                                                    ",
                 "        (CASE WHEN xrca001 LIKE '2%' THEN (xrcc108-xrcc109) * -1 ELSE (xrcc108-xrcc109) END),    ",
                 "        0,0,                                               ",
                 "        xrcadocno,xrca005,'2',                             ",
                 "        xrcc009                                            ",   #151127-00002#5
                 "   FROM xrca_t,xrcc_t                                      ",
                 "  WHERE xrcaent = xrccent AND xrcaent = '",g_enterprise,"' ",
                 "    AND xrcald = xrccld AND xrcadocno = xrccdocno          ",
                 "    AND xrcastus = 'Y' AND (xrcc108-xrcc109) > 0           ",
                 "    AND xrcc004 <= '",g_input.l_enddate,"'                 ",
                 "    AND xrcccomp = '",g_input.l_comp,"'                    "                 
      PREPARE anmq311_prep06 FROM g_sql
      EXECUTE anmq311_prep06
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins_xrca_t,ins_xrcc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
   END IF
   
   #未開發票出貨單  出貨數量　－　已經立帳的數量
   IF g_input.l_chk5='Y' THEN 
      #show_msg 未開發票出貨單
      SELECT gzzd005 INTO l_msg5 FROM gzzd_t WHERE gzzd003 = 'lbl_chk5' AND gzzd002 = g_dlang AND gzzd001 = 'anmq311'
      CALL cl_progress_ing(l_msg5)
      LET g_sql = " SELECT xmdksite,xmdk001,xmdk010,xmdk016,                  ",
                  "    SUM(  CASE WHEN xmdk000 IN ('5','6') THEN (xmdl022-xmdl038) * xmdl024 * - 1 ELSE (xmdl022-xmdl038) * xmdl024 END), ",
                  "        xmdkdocno,xmdk008                                  ",
                  "   FROM xmdk_t,xmdl_t                                      ",
                  "  WHERE xmdkent = xmdlent AND xmdlent = '",g_enterprise,"' ",
                  "    AND xmdkdocno = xmdldocno AND xmdl022 - xmdl038 > 0    ",
                  "    AND xmdkdocdt <= '",g_input.l_enddate,"'               ",
                  "    AND xmdkstus = 'S'                                     ",
                  "    AND xmdksite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef017 = '",g_input.l_comp,"' ) ",#160905-00007#8 ADD  ooefent = ",g_enterprise," 
                  "  GROUP BY xmdksite,xmdk001,xmdk010,xmdk016,xmdkdocno,xmdk008  "

      PREPARE anmq311_prep07 FROM g_sql
      DECLARE anmq311_curs07 CURSOR FOR anmq311_prep07
      FOREACH anmq311_curs07 INTO l_xmdasite,l_xmdadocdt,l_xmda009,l_xmda015,
                                  l_xmdd018,l_xmdadocno,l_xmda004         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins_xmdk_t,ins_xmdl_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
        
         #取票到期日
         CALL s_fin_date_ap_payable(l_xmdasite,l_xmda004,l_xmda009,l_xmdadocdt,l_xmdadocdt,l_xmdadocdt,l_xmdadocdt)
                RETURNING g_sub_success,l_apca009,l_apca010  
         INSERT INTO anmq311_tmp
         VALUES (g_enterprise,l_xmdadocdt,l_xmda009,l_xmdasite,l_apca010,'',l_xmda015,
                    0,0,0,0,l_xmdd018,0,0,l_xmdadocno,l_xmda004,'2','')   #151127-00002#5 add ''

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins_xmdk_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
      END FOREACH         
   END IF
   
   #未出貨的訂單 /訂單數量 - 已經出貨的數量
   IF g_input.l_chk6 = 'Y' THEN
      #show_msg 未出貨的訂單
      SELECT gzzd005 INTO l_msg6 FROM gzzd_t WHERE gzzd003 = 'lbl_chk6' AND gzzd002 = g_dlang AND gzzd001 = 'anmq311'
      CALL cl_progress_ing(l_msg6)
      #IF g_sbas0019 = 'Y' THEN
         LET g_sql = "  SELECT xmdasite,xmdd011,xmda009,xmdd027,xmda015,              ",
                     "         xmdd018,xmdadocno,xmda004,xmddseq,xmddseq1,xmddseq2    ",
                     "    FROM xmda_t,xmdd_t                                          ",
                     "   WHERE xmdaent = xmddent AND xmdaent = '",g_enterprise,"'     ",
                     "     AND xmdastus ='Y' AND xmdadocdt <= '",g_input.l_enddate,"' ",
                     "     AND xmdd017  <> '5'   AND xmdd027 > xmdd014                ",
                     "     AND xmda005 = '1'     AND xmdadocno = xmdddocno            ",
                     "     AND xmdasite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef017 = '",g_input.l_comp,"' ) " #160905-00007#8 ADD  ooefent = ",g_enterprise,"  
         PREPARE anmq311_prep081 FROM g_sql
         DECLARE anmq311_curs081 CURSOR FOR anmq311_prep081
         FOREACH anmq311_curs081 INTO l_xmdasite,l_xmdadocdt,l_xmda009,l_xmdd027,l_xmda015,
                                      l_xmdd018,l_xmdadocno,l_xmda004,l_xmddseq,l_xmddseq1,l_xmddseq2
            #xmdl022 出貨的計價數量                          
            SELECT SUM(CASE WHEN xmdk000 ='6' THEN xmdl022 * -1 ELSE xmdl022 END) INTO l_xmdl022
              FROM xmdk_t,xmdl_t
             WHERE xmdkent = xmdlent AND xmdkent = g_enterprise
               AND xmdkdocno = xmdldocno
               AND xmdl003 = l_xmdadocno 
               AND xmdl004 = l_xmddseq AND xmdl005 = l_xmddseq1 AND xmdl006 = l_xmddseq2 
               AND xmdkstus='S'  
               AND xmdk000 IN ('1','6')  #出貨單 & 退貨單 
            IF cl_null(l_xmdl022) THEN LET l_xmdl022 = 0 END IF               
            LET l_xmdd027 = l_xmdd027 - l_xmdl022
            LET l_xmdd018 = l_xmdd018 * l_xmdd027
            
            #取票到期日
            CALL s_fin_date_ap_payable(l_xmdasite,l_xmda004,l_xmda009,l_xmdadocdt,l_xmdadocdt,l_xmdadocdt,l_xmdadocdt)
                RETURNING g_sub_success,l_apca009,l_apca010  
           
           #票據到期日大於截止日期 不顯示
            IF l_apca010 > g_input.l_enddate THEN
               CONTINUE FOREACH
            END IF
            
            INSERT INTO anmq311_tmp
            VALUES (g_enterprise,l_xmdadocdt,l_xmda009,l_xmdasite,l_apca010,'',l_xmda015,
                    0,0,0,0,l_xmdd018,0,0,l_xmdadocno,l_xmda004,'2','')   #151127-00002#5 add ''                       
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "xmda_t,xmdd_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF                 
         END FOREACH      
      #ELSE
#         LET g_sql = "  INSERT INTO anmq311_tmp                                       ",
#                     "  SELECT xmdasite,xmdadocdt,xmda009,xmdasite,'','',xmda015,     ",
#                     "         0,0,0,0,                                                ",
#                     "         (xmdd027 - xmdd014) * xmdd018,                         ",
#                     "         0,xmdadocno,xmda004                                    ",
#                     "    FROM xmda_t,xmdd_t                                          ",
#                     "   WHERE xmdaent = xmddent AND xmdaent = '",g_enterprise,"'     ",
#                     "     AND xmdastus ='Y' AND xmdadocdt <= '",g_input.l_enddate,"' ",
#                     "     AND xmdd017  <> '5'   AND xmdd027 > xmdd014                ",
#                     "     AND xmda005 = '1'  ",
#                     "     AND xmdasite IN (SELECT ooef001 FROM ooef_t WHERE ooef017 = '",g_input.l_comp,"' ) "  
#         PREPARE anmq311_prep082 FROM g_sql
#         EXECUTE anmq311_prep082
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = "ins_xmda_t,ins_xmdd_t"
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#         END IF      
     # END IF
   END IF
   
   
END FUNCTION

################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL anmq311_default()
# Date & Author..: 2015/09/15 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq311_default()
DEFINE l_ld  LIKE glaa_t.glaald
DEFINE l_wc       STRING   
DEFINE l_sql      STRING   #160816-00012#4 Add
DEFINE l_count    LIKE type_t.num5
   #預設g_site所屬法人
   CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,g_input.l_comp,l_ld
   #160816-00012#4 Add  ---(S)---
   #检查用户是否有资金中心对应法人的权限
   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
   LET l_count = 0
   LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
               "   AND ooef001 = '",g_input.l_comp,"'",
               "   AND ooef003 = 'Y'",
               "   AND ",l_wc CLIPPED
   PREPARE anmp410_count_prep FROM l_sql
   EXECUTE anmp410_count_prep INTO l_count
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      LET g_input.l_comp = ''     
   END IF
   #160816-00012#4 Add  ---(E)---
   CALL s_desc_get_department_desc(g_input.l_comp)RETURNING g_input.l_comp_desc
   LET g_input.l_enddate = g_today
   LET g_input.l_type    = '0'
   LET g_input.l_chk1    = 'N'
   LET g_input.l_chk2    = 'N'
   LET g_input.l_chk3    = 'N'
   LET g_input.l_chk4    = 'N'
   LET g_input.l_chk5    = 'N'
   LET g_input.l_chk6    = 'N'
   CALL cl_set_comp_visible('b_apca005,apca005_desc,b_pmdtdocno,b_gzzz001,gzzz001_desc,b_apcc009',TRUE)   #151127-00002#5 add b_apcc009
   IF g_input.l_type = '1' THEN
      CALL cl_set_comp_visible('b_apca005,apca005_desc,b_pmdtdocno,b_gzzz001,gzzz001_desc,b_apcc009',FALSE)   #151127-00002#5 add b_apcc009
   END IF
  
   DISPLAY BY NAME g_input.l_enddate ,g_input.l_type,
                   g_input.l_chk1    ,g_input.l_chk2,g_input.l_chk3,
                   g_input.l_chk4    ,g_input.l_chk5,g_input.l_chk6                   
   DISPLAY BY NAME g_input.l_comp_desc,g_input.l_comp


END FUNCTION

################################################################################
# Descriptions...: 供二次查詢用
# Memo...........: #151013-00016#2
# Usage..........: anmq311_filter2_parser(ps_field)
# Input parameter: ps_field       資料庫欄位名稱
# Date & Author..: 15/10/14 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq311_filter2_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING

   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter2.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter2.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter2.subString(li_tmp,li_tmp2)
   END IF
 
   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter2.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter2.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter2.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF
 
   RETURN ls_var
END FUNCTION

################################################################################
# Descriptions...: 供二次查詢用
# Memo...........: #151013-00016#2
# Usage..........: anmq311_filter2_show(ps_field,ps_object)
# Input parameter: ps_field       資料庫欄位名稱
#                : ps_object      欄位控件代號
# Date & Author..: 15/10/14 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq311_filter2_show(ps_field,ps_object)

   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   #add-point:filter_show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = anmq311_filter2_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
################################################################################
# Descriptions...: 透過RECORD把資料放入TEMP TABLE
# Memo...........: #151013-00016#2
#
# Date & Author..: 2015/10/14 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq311_ins_x01_tmp()
DEFINE l_i       LIKE type_t.num10
DEFINE l_gzzd005 LIKE gzzd_t.gzzd005
DEFINE l_x01_tmp RECORD
    seq          LIKE type_t.num10,
    apca010      LIKE apca_t.apca010, 
    nmas002      LIKE type_t.chr500, 
    nmaa001_desc LIKE type_t.chr80, 
    apca100      LIKE type_t.chr500, 
    amt1         LIKE type_t.num20_6, 
    amt2         LIKE type_t.num20_6, 
    amt3         LIKE type_t.num20_6,              
    amt4         LIKE type_t.num20_6, 
    amt5         LIKE type_t.num20_6, 
    amt6         LIKE type_t.num20_6, 
    sum1         LIKE type_t.num20_6, 
    pmdtdocno    LIKE pmdt_t.pmdtdocno, 
    apca005      LIKE type_t.chr500, 
    apca005_desc LIKE type_t.chr500, 
    gzzz001      LIKE type_t.chr80, 
    gzzz001_desc LIKE type_t.chr500, 
    pmdtseq      LIKE pmdt_t.pmdtseq,
    apcc009      LIKE apcc_t.apcc009,   #151127-00002#5
    l_comp_desc  LIKE type_t.chr500,
    l_enddate    LIKE type_t.dat,
    l_type       LIKE type_t.chr500,   
    l_flag       LIKE type_t.chr1
             END RECORD
   IF g_input.l_type = '0' THEN
      SELECT gzzd005 INTO l_gzzd005
        FROM gzzd_t
       WHERE gzzd001 = 'anmq311' AND gzzd002 = g_dlang
         AND gzzd003 = 'cbo_l_type.1'AND gzzd004 = 's'
   ELSE
      SELECT gzzd005 INTO l_gzzd005
        FROM gzzd_t
       WHERE gzzd001 = 'anmq311' AND gzzd002 = g_dlang
         AND gzzd003 = 'cbo_l_type.2'AND gzzd004 = 's'
   END IF
   
   DELETE FROM anmq311_x01_tmp
   FOR l_i = 1 TO g_pmdt_d.getLength()
      
      INITIALIZE l_x01_tmp.* TO NULL
      LET l_x01_tmp.seq          = l_i 
      LET l_x01_tmp.apca010      = g_pmdt_d[l_i].apca010     
      LET l_x01_tmp.nmas002      = g_pmdt_d[l_i].l_nmas002    
      LET l_x01_tmp.nmaa001_desc = g_pmdt_d[l_i].nmaa001_desc
      LET l_x01_tmp.apca100      = g_pmdt_d[l_i].apca100     
      LET l_x01_tmp.amt1         = g_pmdt_d[l_i].amt1        
      LET l_x01_tmp.amt2         = g_pmdt_d[l_i].amt2        
      LET l_x01_tmp.amt3         = g_pmdt_d[l_i].amt3        
      LET l_x01_tmp.amt4         = g_pmdt_d[l_i].amt4        
      LET l_x01_tmp.amt5         = g_pmdt_d[l_i].amt5        
      LET l_x01_tmp.amt6         = g_pmdt_d[l_i].amt6        
      LET l_x01_tmp.sum1         = g_pmdt_d[l_i].sum1        
      LET l_x01_tmp.pmdtdocno    = g_pmdt_d[l_i].pmdtdocno   
      LET l_x01_tmp.apca005      = g_pmdt_d[l_i].apca005     
      LET l_x01_tmp.apca005_desc = g_pmdt_d[l_i].apca005_desc
      LET l_x01_tmp.gzzz001      = g_pmdt_d[l_i].gzzz001     
      LET l_x01_tmp.gzzz001_desc = g_pmdt_d[l_i].gzzz001_desc
      LET l_x01_tmp.pmdtseq      = g_pmdt_d[l_i].pmdtseq     
      LET l_x01_tmp.apcc009      = g_pmdt_d[l_i].apcc009   #151127-00002#5
      LET l_x01_tmp.l_comp_desc  = g_input.l_comp,":",g_input.l_comp_desc 
      LET l_x01_tmp.l_enddate    = g_input.l_enddate   
      LET l_x01_tmp.l_type       = l_gzzd005      
      LET l_x01_tmp.l_flag       = g_input.l_type    
      
      INSERT INTO anmq311_x01_tmp VALUES(l_x01_tmp.*)
   END FOR


END FUNCTION

 
{</section>}
 
