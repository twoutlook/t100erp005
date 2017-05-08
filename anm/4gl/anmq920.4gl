#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq920.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2014-08-13 17:00:14), PR版次:0006(2016-09-08 18:16:12)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000074
#+ Filename...: anmq920
#+ Description: 帳戶各期資金狀況查詢
#+ Creator....: 02291(2014-08-12 16:13:06)
#+ Modifier...: 02291 -SD/PR- 07900
 
{</section>}
 
{<section id="anmq920.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#150715-00014#2 150724 By Jessy  anmq* bug修復(增加法人開窗條件與欄位檢核/隱藏選取項目會跑出來/單身資料無法下條件)
#150730-00008#1 150803 by yangtt 拿掉【內部】相關字眼，程序里不設定為內部銀行(ooab002= '0')
#160122-00001#29 2016/02/03 By 02599    增加交易账户用户权限控管
#160122-00001#29 2016/03/17 By 07673    添加交易帳戶編號用戶權限空管,增加部门权限
#160322-00006#1  2016/03/25 By 02599    单头法人默认赋值当前据点对应法人,'账户编号'改成交易账户开窗改成q_nmas_01,'简称'改完账户编号+账户说明
#160318-00025#45 2016/04/19 by 07959    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160726-00010#1  2016/07/27 By 01531    若原币期初余额&本币期初余额抓不到金额，则应该显示为0 ，目前是显示为空。
#160816-00012#4  2016/09/08 By 07900    ANM增加资金中心，帐套，法人三个栏位权限
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
PRIVATE TYPE type_g_nmbx_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   nmbx003 LIKE nmbx_t.nmbx003, 
   nmbx003_desc LIKE type_t.chr500, 
   nmbx100 LIKE nmbx_t.nmbx100, 
   ocbb LIKE type_t.num20_6, 
   ccbb LIKE type_t.num20_6, 
   nmbx103 LIKE nmbx_t.nmbx103, 
   nmbx113 LIKE nmbx_t.nmbx113, 
   nmbx104 LIKE nmbx_t.nmbx104, 
   nmbx114 LIKE nmbx_t.nmbx114, 
   ocbt LIKE type_t.num20_6, 
   ccbt LIKE type_t.num20_6 
       END RECORD
PRIVATE TYPE type_g_nmbx2_d RECORD
       nmbx003 LIKE nmbx_t.nmbx003, 
   nmbx100 LIKE nmbx_t.nmbx100, 
   ocbb2 LIKE type_t.num20_6, 
   ccbb2 LIKE type_t.num20_6, 
   nmbx103 LIKE nmbx_t.nmbx103, 
   nmbx123 LIKE nmbx_t.nmbx123, 
   nmbx104 LIKE nmbx_t.nmbx104, 
   nmbx124 LIKE nmbx_t.nmbx124, 
   ocbt2 LIKE type_t.num20_6, 
   ccbt2 LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_nmbx3_d RECORD
       nmbx003 LIKE nmbx_t.nmbx003, 
   nmbx100 LIKE nmbx_t.nmbx100, 
   ocbb3 LIKE type_t.num20_6, 
   ccbb3 LIKE type_t.num20_6, 
   nmbx103 LIKE nmbx_t.nmbx103, 
   nmbx133 LIKE nmbx_t.nmbx133, 
   nmbx104 LIKE nmbx_t.nmbx104, 
   nmbx134 LIKE nmbx_t.nmbx134, 
   ocbt3 LIKE type_t.num20_6, 
   ccbt3 LIKE type_t.num20_6
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_table1           STRING
DEFINE  g_a              LIKE type_t.chr1
DEFINE tm                    RECORD
       nmbxcomp   LIKE nmbx_t.nmbxcomp,
       nmbxcomp_desc   LIKE type_t.chr80,
       nmbx001    LIKE nmbx_t.nmbx001,
       nmbx002    LIKE nmbx_t.nmbx002
      END RECORD 
DEFINE g_current_row    LIKE type_t.num5 
DEFINE g_current_idx    LIKE type_t.num10     
DEFINE g_jump           LIKE type_t.num10        
DEFINE g_no_ask         LIKE type_t.num5  
DEFINE g_rec_b          LIKE type_t.num5
DEFINE g_wc_nmbxcomp STRING      #150715-00014#2
DEFINE g_sql_bank       STRING                #160122-00001#29 by 07673
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_nmbx_d
DEFINE g_master_t                   type_g_nmbx_d
DEFINE g_nmbx_d          DYNAMIC ARRAY OF type_g_nmbx_d
DEFINE g_nmbx_d_t        type_g_nmbx_d
DEFINE g_nmbx2_d   DYNAMIC ARRAY OF type_g_nmbx2_d
DEFINE g_nmbx2_d_t type_g_nmbx2_d
 
DEFINE g_nmbx3_d   DYNAMIC ARRAY OF type_g_nmbx3_d
DEFINE g_nmbx3_d_t type_g_nmbx3_d
 
 
      
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
 
{<section id="anmq920.main" >}
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
   DECLARE anmq920_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmq920_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmq920_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmq920 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmq920_init()   
 
      #進入選單 Menu (="N")
      CALL anmq920_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmq920
      
   END IF 
   
   CLOSE anmq920_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE anmq920_xg_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmq920.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION anmq920_init()
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
   CALL anmq920_create_tmp()
   #150715-00014#2----s
   CALL s_fin_create_account_center_tmp()  #展組織下階成員所需之暫存檔
   CALL s_fin_azzi800_sons_query(g_today)  #取使用者權限下據點之的法人
   CALL s_fin_account_center_comp_str() RETURNING g_wc_nmbxcomp  #將取回的字串轉換為SQL條件
   CALL s_fin_get_wc_str(g_wc_nmbxcomp) RETURNING g_wc_nmbxcomp 
   #150715-00014#2----e
   #160122-00001#29 by 07673 --add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#29 by 07673 --add--end
   #end add-point
 
   CALL anmq920_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="anmq920.default_search" >}
PRIVATE FUNCTION anmq920_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
 
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " nmbxcomp = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " nmbx001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " nmbx002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " nmbx003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " nmbxorga = '", g_argv[05], "' AND "
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
 
{<section id="anmq920.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION anmq920_ui_dialog()
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
   CALL cl_set_comp_visible('sel',FALSE)  #150715-00014#2 隱藏選取標籤
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL anmq920_b_fill()
   ELSE
      CALL anmq920_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_nmbx_d.clear()
         CALL g_nmbx2_d.clear()
 
         CALL g_nmbx3_d.clear()
 
 
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
 
         CALL anmq920_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_nmbx_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL anmq920_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL anmq920_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
 
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
         DISPLAY ARRAY g_nmbx2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_nmbx2_d.getLength() TO FORMONLY.h_count
               CALL anmq920_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body2.before_row"
 
               #end add-point  
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_nmbx3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_nmbx3_d.getLength() TO FORMONLY.h_count
               CALL anmq920_fetch()
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
            CALL anmq920_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            CALL cl_set_act_visible('insert', FALSE)   #150715-00014#2 隱藏新增Action
            CALL cl_set_comp_visible('sel',FALSE)      #150715-00014#2 隱藏選取標籤
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL anmq920_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL anmq920_print()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL anmq920_print()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmq920_query()
               #add-point:ON ACTION query name="menu.query"
               CALL cl_set_comp_visible('sel',FALSE)      #150715-00014#2 隱藏選取標籤
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
            CALL anmq920_filter()
            #add-point:ON ACTION filter name="menu.filter"
            CALL cl_set_comp_visible('sel',FALSE)      #150715-00014#2 隱藏選取標籤
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
            CALL anmq920_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_nmbx_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_nmbx2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_nmbx3_d)
               LET g_export_id[3]   = "s_detail3"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            CALL cl_set_comp_visible('sel',FALSE)  #150715-00014#2 隱藏選取標籤
            #END add-point
            CALL cl_user_overview()
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL anmq920_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL anmq920_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL anmq920_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL anmq920_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_nmbx_d.getLength()
               LET g_nmbx_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_nmbx_d.getLength()
               LET g_nmbx_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_nmbx_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmbx_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_nmbx_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmbx_d[li_idx].sel = "N"
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
 
{<section id="anmq920.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmq920_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_sql      STRING   #160816-00012#4 Add
   DEFINE l_wc       STRING   #160816-00012#4 Add
   DEFINE l_count    LIKE type_t.num5  #160816-00012#4 Add
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_nmbx_d.clear()
   CALL g_nmbx2_d.clear()
 
   CALL g_nmbx3_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON nmbx003,nmbx100,nmbx103,nmbx113,nmbx104,nmbx114,nmbx123,nmbx124,nmbx133, 
          nmbx134
           FROM s_detail1[1].b_nmbx003,s_detail1[1].b_nmbx100,s_detail1[1].b_nmbx103,s_detail1[1].b_nmbx113, 
               s_detail1[1].b_nmbx104,s_detail1[1].b_nmbx114,s_detail2[1].b_nmbx123,s_detail2[1].b_nmbx124, 
               s_detail3[1].b_nmbx133,s_detail3[1].b_nmbx134
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_nmbx003>>----
         #Ctrlp:construct.c.page1.b_nmbx003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx003
            #add-point:ON ACTION controlp INFIELD b_nmbx003 name="construct.c.page1.b_nmbx003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
           #LET g_qryparam.where = " nmab002 = '0'"   #150730-00008 #1 02291 mark
            #160322-00006#1--mod--str--
#            #160122-00001#29--add--str--
#            LET g_qryparam.where =" nmab001 IN (SELECT DISTINCT nmaa004 FROM nmaa_t,nmas_t",
#                                  " WHERE nmaaent=nmasent AND nmaa001=nmas001",
#                                  " AND nmas002 IN (",g_sql_bank,") )"
#            #160122-00001#29--add--end
#            CALL q_nmab001()                           #呼叫開窗
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,") "
            CALL q_nmas_01()
            #160322-00006#1--mod--end
            DISPLAY g_qryparam.return1 TO b_nmbx003  #顯示到畫面上
            NEXT FIELD b_nmbx003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbx003
            #add-point:BEFORE FIELD b_nmbx003 name="construct.b.page1.b_nmbx003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbx003
            
            #add-point:AFTER FIELD b_nmbx003 name="construct.a.page1.b_nmbx003"
            
            #END add-point
            
 
 
         #----<<b_nmbx003_desc>>----
         #----<<b_nmbx100>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbx100
            #add-point:BEFORE FIELD b_nmbx100 name="construct.b.page1.b_nmbx100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbx100
            
            #add-point:AFTER FIELD b_nmbx100 name="construct.a.page1.b_nmbx100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbx100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx100
            #add-point:ON ACTION controlp INFIELD b_nmbx100 name="construct.c.page1.b_nmbx100"
            #150715-00014#2-----s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbx100    #顯示到畫面上
            NEXT FIELD b_nmbx100                       #返回原欄位
            #150715-00014#2-----e
            #END add-point
 
 
         #----<<ocbb>>----
         #----<<ccbb>>----
         #----<<b_nmbx103>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbx103
            #add-point:BEFORE FIELD b_nmbx103 name="construct.b.page1.b_nmbx103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbx103
            
            #add-point:AFTER FIELD b_nmbx103 name="construct.a.page1.b_nmbx103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbx103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx103
            #add-point:ON ACTION controlp INFIELD b_nmbx103 name="construct.c.page1.b_nmbx103"
            
            #END add-point
 
 
         #----<<b_nmbx113>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbx113
            #add-point:BEFORE FIELD b_nmbx113 name="construct.b.page1.b_nmbx113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbx113
            
            #add-point:AFTER FIELD b_nmbx113 name="construct.a.page1.b_nmbx113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbx113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx113
            #add-point:ON ACTION controlp INFIELD b_nmbx113 name="construct.c.page1.b_nmbx113"
            
            #END add-point
 
 
         #----<<b_nmbx104>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbx104
            #add-point:BEFORE FIELD b_nmbx104 name="construct.b.page1.b_nmbx104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbx104
            
            #add-point:AFTER FIELD b_nmbx104 name="construct.a.page1.b_nmbx104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbx104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx104
            #add-point:ON ACTION controlp INFIELD b_nmbx104 name="construct.c.page1.b_nmbx104"
            
            #END add-point
 
 
         #----<<b_nmbx114>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbx114
            #add-point:BEFORE FIELD b_nmbx114 name="construct.b.page1.b_nmbx114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbx114
            
            #add-point:AFTER FIELD b_nmbx114 name="construct.a.page1.b_nmbx114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbx114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx114
            #add-point:ON ACTION controlp INFIELD b_nmbx114 name="construct.c.page1.b_nmbx114"
            
            #END add-point
 
 
         #----<<ocbt>>----
         #----<<ccbt>>----
         #----<<ocbb2>>----
         #----<<ccbb2>>----
         #----<<b_nmbx123>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbx123
            #add-point:BEFORE FIELD b_nmbx123 name="construct.b.page2.b_nmbx123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbx123
            
            #add-point:AFTER FIELD b_nmbx123 name="construct.a.page2.b_nmbx123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_nmbx123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx123
            #add-point:ON ACTION controlp INFIELD b_nmbx123 name="construct.c.page2.b_nmbx123"
            
            #END add-point
 
 
         #----<<b_nmbx124>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbx124
            #add-point:BEFORE FIELD b_nmbx124 name="construct.b.page2.b_nmbx124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbx124
            
            #add-point:AFTER FIELD b_nmbx124 name="construct.a.page2.b_nmbx124"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_nmbx124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx124
            #add-point:ON ACTION controlp INFIELD b_nmbx124 name="construct.c.page2.b_nmbx124"
            
            #END add-point
 
 
         #----<<ocbt2>>----
         #----<<ccbt2>>----
         #----<<ocbb3>>----
         #----<<ccbb3>>----
         #----<<b_nmbx133>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbx133
            #add-point:BEFORE FIELD b_nmbx133 name="construct.b.page3.b_nmbx133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbx133
            
            #add-point:AFTER FIELD b_nmbx133 name="construct.a.page3.b_nmbx133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_nmbx133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx133
            #add-point:ON ACTION controlp INFIELD b_nmbx133 name="construct.c.page3.b_nmbx133"
            
            #END add-point
 
 
         #----<<b_nmbx134>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbx134
            #add-point:BEFORE FIELD b_nmbx134 name="construct.b.page3.b_nmbx134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbx134
            
            #add-point:AFTER FIELD b_nmbx134 name="construct.a.page3.b_nmbx134"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_nmbx134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx134
            #add-point:ON ACTION controlp INFIELD b_nmbx134 name="construct.c.page3.b_nmbx134"
            
            #END add-point
 
 
         #----<<ocbt3>>----
         #----<<ccbt3>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT tm.nmbxcomp,tm.nmbx001,tm.nmbx002 FROM b_nmbxcomp,b_nmbx001,b_nmbx002
         BEFORE INPUT
            #160322-00006#1--add--str--
            IF cl_null(tm.nmbxcomp) THEN
               SELECT ooef017 INTO tm.nmbxcomp FROM ooef_t 
               WHERE ooefent=g_enterprise AND ooef001=g_site
               #160816-00012#4 Add  ---(S)---
               #检查用户是否有资金中心对应法人的权限
               CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
               LET l_count = 0
               LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                           "   AND ooef001 = '",tm.nmbxcomp,"'",
                           "   AND ooef003 = 'Y'",
                           "   AND ",l_wc CLIPPED
               PREPARE anmp410_count_prep FROM l_sql
               EXECUTE anmp410_count_prep INTO l_count
               IF cl_null(l_count) THEN LET l_count = 0 END IF
               IF l_count = 0 THEN
                  LET tm.nmbxcomp = ''                          
               END IF
               #160816-00012#4 Add  ---(E)---
               DISPLAY tm.nmbxcomp TO b_nmbxcomp
            END IF
            #160322-00006#1--add--end
            LET tm.nmbx001 = YEAR(g_today)
            LET tm.nmbx002 = MONTH(g_today)
            DISPLAY tm.nmbx001 TO b_nmbx001
            DISPLAY tm.nmbx002 TO b_nmbx002
         
         BEFORE FIELD b_nmbxcomp 
            
         AFTER FIELD b_nmbxcomp 
            CALL anmq920_nmbxcomp_desc()
            IF NOT cl_null(tm.nmbxcomp) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = tm.nmbxcomp
               IF NOT cl_chk_exist("v_ooef001_1") THEN
                  LET tm.nmbxcomp = ''
                  LET tm.nmbxcomp_desc = ' '
                  CALL anmq920_nmbxcomp_desc()
                  NEXT FIELD CURRENT
               END IF
               
               #160816-00012#4 --mark--
               #150715-00014#2-----s
               #比對輸入的法人是否在權限下
#               IF s_chr_get_index_of(g_wc_nmbxcomp,tm.nmbxcomp,'1') = 0 THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'ais-00228'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#                  LET tm.nmbxcomp = ''
#                  LET tm.nmbxcomp_desc = ''
#                  CALL anmq920_nmbxcomp_desc()
#                  DISPLAY tm.nmbxcomp TO b_nmbxcomp
#                  NEXT FIELD CURRENT
#               END IF
               #150715-00014#2-----e
               #160816-00012#4 --mark--
               #160816-00012#4 Add  ---(S)---
               #检查用户是否有资金中心对应法人的权限
               CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
               LET l_count = 0
               LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                           "   AND ooef017 = '",tm.nmbxcomp,"'",
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
                  LET tm.nmbxcomp = ''
                  CALL anmq920_nmbxcomp_desc()
                  DISPLAY tm.nmbxcomp TO b_nmbxcomp                  
                  NEXT FIELD CURRENT
               END IF
               #160816-00012#4 Add  ---(E)---
                              
            END IF
            CALL anmq920_nmbxcomp_desc()
            
         ON ACTION controlp INFIELD b_nmbxcomp
            #add-point:ON ACTION controlp INFIELD nmbxcomp
            #此段落由子樣板a07產生
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y' "
            #160816-00012#4 Add  ---(S)---
            CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
            LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED
            #160816-00012#4 Add  ---(E)---
            LET g_qryparam.default1 = tm.nmbxcomp             #給予default值
            
            CALL q_ooef017_01()           #150715-00014#2   呼叫開窗
            LET tm.nmbxcomp = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL anmq920_nmbxcomp_desc()
            DISPLAY tm.nmbxcomp TO b_nmbxcomp              #顯示到畫面上
            NEXT FIELD b_nmbxcomp                          #返回原欄位
     
      END INPUT
      
      #150715-00014#2-----s
      #加上合計功能後無法查詢，需重新DISPLAY所有頁籤
      BEFORE DIALOG
         CALL cl_qbe_init() 
         LET g_nmbx_d[1].nmbx003 = ""
         DISPLAY ARRAY g_nmbx_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
      #150715-00014#2-----e
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
         #150715-00014#2-----s
         LET tm.nmbx001 = YEAR(g_today)
         LET tm.nmbx002 = MONTH(g_today)
         LET tm.nmbxcomp = ''
         DISPLAY tm.nmbx001 TO b_nmbx001
         DISPLAY tm.nmbx002 TO b_nmbx002
         DISPLAY tm.nmbxcomp TO b_nmbxcomp
         #加上合計功能後無法查詢，需重新DISPLAY所有頁籤
         LET g_nmbx_d[1].nmbx003 = ""
         DISPLAY ARRAY g_nmbx_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         #150715-00014#2-----e
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
   CALL anmq920_b_fill()
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
 
{<section id="anmq920.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmq920_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_nmbx103       LIKE nmbx_t.nmbx103
   DEFINE l_nmbx104       LIKE nmbx_t.nmbx104
   DEFINE l_nmbx113       LIKE nmbx_t.nmbx113
   DEFINE l_nmbx114       LIKE nmbx_t.nmbx114
   DEFINE l_nmbx123       LIKE nmbx_t.nmbx123
   DEFINE l_nmbx124       LIKE nmbx_t.nmbx124
   DEFINE l_nmbx133       LIKE nmbx_t.nmbx133
   DEFINE l_nmbx134       LIKE nmbx_t.nmbx134
   DEFINE l_tot1          LIKE nmbx_t.nmbx103
   DEFINE l_tot2          LIKE nmbx_t.nmbx103
   DEFINE l_tot3          LIKE nmbx_t.nmbx103
   DEFINE l_tot4          LIKE nmbx_t.nmbx103
   DEFINE l_desc          STRING  #160322-00006#1 add
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',nmbx003,'',nmbx100,'','',nmbx103,nmbx113,nmbx104,nmbx114,'', 
       '','','','','','',nmbx123,'',nmbx124,'','','','','','','',nmbx133,'',nmbx134,'',''  ,DENSE_RANK() OVER( ORDER BY nmbx_t.nmbxcomp, 
       nmbx_t.nmbx001,nmbx_t.nmbx002,nmbx_t.nmbx003,nmbx_t.nmbxorga) AS RANK FROM nmbx_t",
 
 
                     "",
                     " WHERE nmbxent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("nmbx_t"),
                     " ORDER BY nmbx_t.nmbxcomp,nmbx_t.nmbx001,nmbx_t.nmbx002,nmbx_t.nmbx003,nmbx_t.nmbxorga"
 
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
 
   LET g_sql = "SELECT '',nmbx003,'',nmbx100,'','',nmbx103,nmbx113,nmbx104,nmbx114,'','','','','','', 
       '',nmbx123,'',nmbx124,'','','','','','','',nmbx133,'',nmbx134,'',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  UNIQUE '',nmbx003,'',nmbx100,'','',nmbx103,nmbx113,nmbx104,nmbx114,'','', 
       nmbx003,nmbx100,'','',nmbx103,nmbx123,nmbx104,nmbx124,'','',nmbx003,nmbx100,'','',nmbx103,nmbx133,nmbx104,nmbx134,'','' ",
               "  FROM nmbx_t,nmab_t,nmaa_t,nmas_t",
 
 
               "",
               " WHERE nmasent = nmbxent AND nmas002 = nmbx003 ",
               "   AND nmaaent = nmasent AND nmaa001 = nmas001 ",
               "   AND nmabent = nmaaent AND nmab001 = nmaa004 ",
               "   AND nmbxent= ? AND 1=1 AND ", ls_wc,cl_sql_add_filter("nmbx_t"),
               "   AND nmbxcomp = '",tm.nmbxcomp,"' AND nmbx001 = ",tm.nmbx001,
              #"   AND nmbx002 <>0 AND nmbx002 = ",tm.nmbx002," AND nmab002 = '0' "  #150730-00008 #1 02291 mark
               "   AND nmbx002 <>0 AND nmbx002 = ",tm.nmbx002,  #150730-00008 #1 02291 add
               #160122-00001#29 by 07673--modify--str--
               " AND nmas002 IN (",g_sql_bank,")"
               #160122-00001#29 by 07673--modify--end
   
   LET g_sql = g_sql, cl_sql_add_filter("nmbx_t"),
                      " ORDER BY nmbx_t.nmbx003"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmq920_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmq920_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_nmbx_d.clear()
   CALL g_nmbx2_d.clear()   
 
   CALL g_nmbx3_d.clear()   
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_nmbx_d[l_ac].sel,g_nmbx_d[l_ac].nmbx003,g_nmbx_d[l_ac].nmbx003_desc,g_nmbx_d[l_ac].nmbx100, 
       g_nmbx_d[l_ac].ocbb,g_nmbx_d[l_ac].ccbb,g_nmbx_d[l_ac].nmbx103,g_nmbx_d[l_ac].nmbx113,g_nmbx_d[l_ac].nmbx104, 
       g_nmbx_d[l_ac].nmbx114,g_nmbx_d[l_ac].ocbt,g_nmbx_d[l_ac].ccbt,g_nmbx2_d[l_ac].nmbx003,g_nmbx2_d[l_ac].nmbx100, 
       g_nmbx2_d[l_ac].ocbb2,g_nmbx2_d[l_ac].ccbb2,g_nmbx2_d[l_ac].nmbx103,g_nmbx2_d[l_ac].nmbx123,g_nmbx2_d[l_ac].nmbx104, 
       g_nmbx2_d[l_ac].nmbx124,g_nmbx2_d[l_ac].ocbt2,g_nmbx2_d[l_ac].ccbt2,g_nmbx3_d[l_ac].nmbx003,g_nmbx3_d[l_ac].nmbx100, 
       g_nmbx3_d[l_ac].ocbb3,g_nmbx3_d[l_ac].ccbb3,g_nmbx3_d[l_ac].nmbx103,g_nmbx3_d[l_ac].nmbx133,g_nmbx3_d[l_ac].nmbx104, 
       g_nmbx3_d[l_ac].nmbx134,g_nmbx3_d[l_ac].ocbt3,g_nmbx3_d[l_ac].ccbt3
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_nmbx_d[l_ac].statepic = cl_get_actipic(g_nmbx_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #160322-00006#1--add--str--
      #抓取交易账户对应的账户编号+账户说明
      SELECT DISTINCT nmas001 INTO g_nmbx_d[l_ac].nmbx003_desc
        FROM nmas_t
       WHERE nmasent=g_enterprise AND nmas002=g_nmbx_d[l_ac].nmbx003
      CALL s_desc_fmmf004_desc(g_nmbx_d[l_ac].nmbx003_desc) RETURNING l_desc
      LET g_nmbx_d[l_ac].nmbx003_desc = g_nmbx_d[l_ac].nmbx003_desc," ",l_desc
      #160322-00006#1--add--end
      
      IF tm.nmbx002 = 1 THEN
         #若期别为第一期，取该年度0期呈现，
         #1月期初余额=0期 nmbx103-nmbx104
         #获取0期提入、提出金额
         SELECT nmbx103,nmbx104,nmbx113,nmbx114,nmbx123,nmbx124,nmbx133,nmbx134
           INTO l_nmbx103,l_nmbx104,l_nmbx113,l_nmbx114,l_nmbx123,l_nmbx124,l_nmbx133,l_nmbx134
           FROM nmbx_t
          WHERE nmbxent = g_enterprise AND nmbxcomp = tm.nmbxcomp
            AND nmbx001 = tm.nmbx001 AND nmbx002 = 0
            AND nmbx003 = g_nmbx_d[l_ac].nmbx003
        
         LET g_nmbx_d[l_ac].ocbb = l_nmbx103 - l_nmbx104     #0期 原币期初余额
         LET g_nmbx_d[l_ac].ccbb = l_nmbx113 - l_nmbx114     #0期 本币期初余额
         LET g_nmbx2_d[l_ac].ocbb2 = l_nmbx103 - l_nmbx104   #0期 原币期初余额
         LET g_nmbx2_d[l_ac].ccbb2 = l_nmbx123 - l_nmbx124   #0期 本位币二期初余额
         LET g_nmbx3_d[l_ac].ocbb3 = l_nmbx103 - l_nmbx104   #0期 原币期初余额
         LET g_nmbx3_d[l_ac].ccbb3 = l_nmbx133 - l_nmbx134   #0期 本位币三期初余额
         #160726-00010#2 add s---
         IF cl_null(g_nmbx_d[l_ac].ocbb)   THEN LET g_nmbx_d[l_ac].ocbb   = 0 END IF
         IF cl_null(g_nmbx2_d[l_ac].ocbb2) THEN LET g_nmbx2_d[l_ac].ocbb2 = 0 END IF
         IF cl_null(g_nmbx3_d[l_ac].ocbb3) THEN LET g_nmbx3_d[l_ac].ocbb3 = 0 END IF
         IF cl_null(g_nmbx_d[l_ac].ccbb)   THEN LET g_nmbx_d[l_ac].ccbb   = 0 END IF
         IF cl_null(g_nmbx2_d[l_ac].ccbb2) THEN LET g_nmbx2_d[l_ac].ccbb2 = 0 END IF
         IF cl_null(g_nmbx3_d[l_ac].ccbb3) THEN LET g_nmbx3_d[l_ac].ccbb3 = 0 END IF         
         #160726-00010#2 add e---         
      ELSE
         #非第1期，其他各期余额=上期结存+原币存入-原币提出
         #上期结存
         SELECT SUM(nmbx103)-SUM(nmbx104),SUM(nmbx113)-SUM(nmbx114),
                SUM(nmbx123)-SUM(nmbx124),SUM(nmbx133)-SUM(nmbx134)
           INTO l_tot1,l_tot2,l_tot3,l_tot4
           FROM nmbx_t
          WHERE nmbxent = g_enterprise AND nmbxcomp = tm.nmbxcomp
            AND nmbx001 = tm.nmbx001 AND nmbx002 < tm.nmbx002
            AND nmbx003 = g_nmbx_d[l_ac].nmbx003
         
         LET g_nmbx_d[l_ac].ocbb = l_tot1      #原币期初余额
         LET g_nmbx_d[l_ac].ccbb = l_tot2      #本币期初余额
         LET g_nmbx2_d[l_ac].ocbb2 = l_tot1    #原币期初余额
         LET g_nmbx2_d[l_ac].ccbb2 = l_tot3    #本位币二期初余额
         LET g_nmbx3_d[l_ac].ocbb3 = l_tot1    #原币期初余额
         LET g_nmbx3_d[l_ac].ccbb3 = l_tot4    #本位币三期初余额
         
         #160726-00010#2 add s---
         IF cl_null(g_nmbx_d[l_ac].ocbb)   THEN LET g_nmbx_d[l_ac].ocbb   = 0 END IF
         IF cl_null(g_nmbx2_d[l_ac].ocbb2) THEN LET g_nmbx2_d[l_ac].ocbb2 = 0 END IF
         IF cl_null(g_nmbx3_d[l_ac].ocbb3) THEN LET g_nmbx3_d[l_ac].ocbb3 = 0 END IF
         IF cl_null(g_nmbx_d[l_ac].ccbb)   THEN LET g_nmbx_d[l_ac].ccbb   = 0 END IF
         IF cl_null(g_nmbx2_d[l_ac].ccbb2) THEN LET g_nmbx2_d[l_ac].ccbb2 = 0 END IF
         IF cl_null(g_nmbx3_d[l_ac].ccbb3) THEN LET g_nmbx3_d[l_ac].ccbb3 = 0 END IF         
         #160726-00010#2 add e---
      END IF
      #结存
      SELECT SUM(nmbx103)-SUM(nmbx104),SUM(nmbx113)-SUM(nmbx114),
             SUM(nmbx123)-SUM(nmbx124),SUM(nmbx133)-SUM(nmbx134)
        INTO g_nmbx_d[l_ac].ocbt,g_nmbx_d[l_ac].ccbt,g_nmbx2_d[l_ac].ccbt2,g_nmbx3_d[l_ac].ccbt3
        FROM nmbx_t
       WHERE nmbxent = g_enterprise AND nmbxcomp = tm.nmbxcomp
         AND nmbx001 = tm.nmbx001 AND nmbx002 <= tm.nmbx002
         AND nmbx003 = g_nmbx_d[l_ac].nmbx003
      LET g_nmbx2_d[l_ac].ocbt2 = g_nmbx_d[l_ac].ocbt
      LET g_nmbx3_d[l_ac].ocbt3 = g_nmbx_d[l_ac].ocbt       
      #end add-point
 
      CALL anmq920_detail_show("'1'")      
 
      CALL anmq920_nmbx_t_mask()
 
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
   
 
   
   CALL g_nmbx_d.deleteElement(g_nmbx_d.getLength())   
   CALL g_nmbx2_d.deleteElement(g_nmbx2_d.getLength())
 
   CALL g_nmbx3_d.deleteElement(g_nmbx3_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_nmbx_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE anmq920_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL anmq920_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL anmq920_detail_action_trans()
 
   IF g_nmbx_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL anmq920_fetch()
   END IF
   
      CALL anmq920_filter_show('nmbx003','b_nmbx003')
   CALL anmq920_filter_show('nmbx100','b_nmbx100')
   CALL anmq920_filter_show('nmbx103','b_nmbx103')
   CALL anmq920_filter_show('nmbx113','b_nmbx113')
   CALL anmq920_filter_show('nmbx104','b_nmbx104')
   CALL anmq920_filter_show('nmbx114','b_nmbx114')
   CALL anmq920_filter_show('nmbx123','b_nmbx123')
   CALL anmq920_filter_show('nmbx124','b_nmbx124')
   CALL anmq920_filter_show('nmbx133','b_nmbx133')
   CALL anmq920_filter_show('nmbx134','b_nmbx134')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq920.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmq920_fetch()
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
 
{<section id="anmq920.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmq920_detail_show(ps_page)
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
#160322-00006#1--mark--str--
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_nmbx_d[l_ac].nmbx003
#            LET ls_sql = "SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_nmbx_d[l_ac].nmbx003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_nmbx_d[l_ac].nmbx003_desc
#160322-00006#1--mark--end
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
 
{<section id="anmq920.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION anmq920_filter()
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
      CONSTRUCT g_wc_filter ON nmbx003,nmbx100,nmbx103,nmbx113,nmbx104,nmbx114,nmbx123,nmbx124,nmbx133, 
          nmbx134
                          FROM s_detail1[1].b_nmbx003,s_detail1[1].b_nmbx100,s_detail1[1].b_nmbx103, 
                              s_detail1[1].b_nmbx113,s_detail1[1].b_nmbx104,s_detail1[1].b_nmbx114,s_detail2[1].b_nmbx123, 
                              s_detail2[1].b_nmbx124,s_detail3[1].b_nmbx133,s_detail3[1].b_nmbx134
 
         BEFORE CONSTRUCT
                     DISPLAY anmq920_filter_parser('nmbx003') TO s_detail1[1].b_nmbx003
            DISPLAY anmq920_filter_parser('nmbx100') TO s_detail1[1].b_nmbx100
            DISPLAY anmq920_filter_parser('nmbx103') TO s_detail1[1].b_nmbx103
            DISPLAY anmq920_filter_parser('nmbx113') TO s_detail1[1].b_nmbx113
            DISPLAY anmq920_filter_parser('nmbx104') TO s_detail1[1].b_nmbx104
            DISPLAY anmq920_filter_parser('nmbx114') TO s_detail1[1].b_nmbx114
            DISPLAY anmq920_filter_parser('nmbx123') TO s_detail2[1].b_nmbx123
            DISPLAY anmq920_filter_parser('nmbx124') TO s_detail2[1].b_nmbx124
            DISPLAY anmq920_filter_parser('nmbx133') TO s_detail3[1].b_nmbx133
            DISPLAY anmq920_filter_parser('nmbx134') TO s_detail3[1].b_nmbx134
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_nmbx003>>----
         #Ctrlp:construct.c.page1.b_nmbx003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx003
            #add-point:ON ACTION controlp INFIELD b_nmbx003 name="construct.c.filter.page1.b_nmbx003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
           #LET g_qryparam.where = " nmab002 = '0'"    #150715-00014#2  #150730-00008 #1 02291 mark
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbx003    #顯示到畫面上
            NEXT FIELD b_nmbx003                       #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbx003_desc>>----
         #----<<b_nmbx100>>----
         #Ctrlp:construct.c.filter.page1.b_nmbx100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx100
            #add-point:ON ACTION controlp INFIELD b_nmbx100 name="construct.c.filter.page1.b_nmbx100"
            #150715-00014#2-----s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbx100    #顯示到畫面上
            NEXT FIELD b_nmbx100                       #返回原欄位
            #150715-00014#2-----e
            #END add-point
 
 
         #----<<ocbb>>----
         #----<<ccbb>>----
         #----<<b_nmbx103>>----
         #Ctrlp:construct.c.filter.page1.b_nmbx103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx103
            #add-point:ON ACTION controlp INFIELD b_nmbx103 name="construct.c.filter.page1.b_nmbx103"
            
            #END add-point
 
 
         #----<<b_nmbx113>>----
         #Ctrlp:construct.c.filter.page1.b_nmbx113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx113
            #add-point:ON ACTION controlp INFIELD b_nmbx113 name="construct.c.filter.page1.b_nmbx113"
            
            #END add-point
 
 
         #----<<b_nmbx104>>----
         #Ctrlp:construct.c.filter.page1.b_nmbx104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx104
            #add-point:ON ACTION controlp INFIELD b_nmbx104 name="construct.c.filter.page1.b_nmbx104"
            
            #END add-point
 
 
         #----<<b_nmbx114>>----
         #Ctrlp:construct.c.filter.page1.b_nmbx114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx114
            #add-point:ON ACTION controlp INFIELD b_nmbx114 name="construct.c.filter.page1.b_nmbx114"
            
            #END add-point
 
 
         #----<<ocbt>>----
         #----<<ccbt>>----
         #----<<ocbb2>>----
         #----<<ccbb2>>----
         #----<<b_nmbx123>>----
         #Ctrlp:construct.c.filter.page2.b_nmbx123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx123
            #add-point:ON ACTION controlp INFIELD b_nmbx123 name="construct.c.filter.page2.b_nmbx123"
            
            #END add-point
 
 
         #----<<b_nmbx124>>----
         #Ctrlp:construct.c.filter.page2.b_nmbx124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx124
            #add-point:ON ACTION controlp INFIELD b_nmbx124 name="construct.c.filter.page2.b_nmbx124"
            
            #END add-point
 
 
         #----<<ocbt2>>----
         #----<<ccbt2>>----
         #----<<ocbb3>>----
         #----<<ccbb3>>----
         #----<<b_nmbx133>>----
         #Ctrlp:construct.c.filter.page3.b_nmbx133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx133
            #add-point:ON ACTION controlp INFIELD b_nmbx133 name="construct.c.filter.page3.b_nmbx133"
            
            #END add-point
 
 
         #----<<b_nmbx134>>----
         #Ctrlp:construct.c.filter.page3.b_nmbx134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbx134
            #add-point:ON ACTION controlp INFIELD b_nmbx134 name="construct.c.filter.page3.b_nmbx134"
            
            #END add-point
 
 
         #----<<ocbt3>>----
         #----<<ccbt3>>----
   
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         CALL cl_set_comp_visible('sel',FALSE)  #150715-00014#2 隱藏選取標籤
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
   
      CALL anmq920_filter_show('nmbx003','b_nmbx003')
   CALL anmq920_filter_show('nmbx100','b_nmbx100')
   CALL anmq920_filter_show('nmbx103','b_nmbx103')
   CALL anmq920_filter_show('nmbx113','b_nmbx113')
   CALL anmq920_filter_show('nmbx104','b_nmbx104')
   CALL anmq920_filter_show('nmbx114','b_nmbx114')
   CALL anmq920_filter_show('nmbx123','b_nmbx123')
   CALL anmq920_filter_show('nmbx124','b_nmbx124')
   CALL anmq920_filter_show('nmbx133','b_nmbx133')
   CALL anmq920_filter_show('nmbx134','b_nmbx134')
 
    
   CALL anmq920_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq920.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION anmq920_filter_parser(ps_field)
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
 
{<section id="anmq920.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION anmq920_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmq920_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq920.insert" >}
#+ insert
PRIVATE FUNCTION anmq920_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmq920.modify" >}
#+ modify
PRIVATE FUNCTION anmq920_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq920.reproduce" >}
#+ reproduce
PRIVATE FUNCTION anmq920_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq920.delete" >}
#+ delete
PRIVATE FUNCTION anmq920_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq920.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION anmq920_detail_action_trans()
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
 
{<section id="anmq920.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION anmq920_detail_index_setting()
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
            IF g_nmbx_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_nmbx_d.getLength() AND g_nmbx_d.getLength() > 0
            LET g_detail_idx = g_nmbx_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_nmbx_d.getLength() THEN
               LET g_detail_idx = g_nmbx_d.getLength()
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
 
{<section id="anmq920.mask_functions" >}
 &include "erp/anm/anmq920_mask.4gl"
 
{</section>}
 
{<section id="anmq920.other_function" readonly="Y" >}

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
PRIVATE FUNCTION anmq920_nmbxcomp_desc()
   SELECT ooefl003 INTO tm.nmbxcomp_desc FROM ooefl_t
    WHERE ooeflent = g_enterprise AND ooefl001 = tm.nmbxcomp
      AND ooefl002 = g_dlang
   DISPLAY tm.nmbxcomp_desc TO b_nmbxcomp_desc
END FUNCTION

################################################################################
# Descriptions...: 建立临时表
# Memo...........:
# Usage..........: CALL anmq920_create_tmp()
#                  RETURNING 
# Date & Author..: 2015/03/24 By 03273
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq920_create_tmp()
   DROP TABLE anmq920_xg_tmp;
   CREATE TEMP TABLE anmq920_xg_tmp(
   seq          LIKE type_t.num10,
   nmbx003      LIKE nmbx_t.nmbx003, 
   nmbx003_desc LIKE type_t.chr500, 
   nmbx100      LIKE nmbx_t.nmbx100, 
   ocbb         LIKE type_t.num20_6, 
   ccbb         LIKE type_t.num20_6, 
   nmbx103      LIKE nmbx_t.nmbx103, 
   nmbx113      LIKE nmbx_t.nmbx113, 
   nmbx104      LIKE nmbx_t.nmbx104, 
   nmbx114      LIKE nmbx_t.nmbx114, 
   ocbt         LIKE type_t.num20_6, 
   ccbt         LIKE type_t.num20_6)
END FUNCTION

################################################################################
# Descriptions...: 打印
# Memo...........:
# Usage..........: CALL anmq920_print()
#                  RETURNING
# Date & Author..: 2015/03/24 By 03273
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq920_print()
   DEFINE l_i         LIKE type_t.num10
   
   IF g_nmbx_d.getLength() <= 0 THEN
      RETURN
   END IF

   #將所需資料插入臨時表
   DELETE FROM anmq920_xg_tmp;
   
   FOR l_i=1 TO g_nmbx_d.getLength()
       INSERT INTO anmq920_xg_tmp VALUES ( 
       l_i,g_nmbx_d[l_i].nmbx003,g_nmbx_d[l_i].nmbx003_desc,g_nmbx_d[l_i].nmbx100, 
       g_nmbx_d[l_i].ocbb,g_nmbx_d[l_i].ccbb,g_nmbx_d[l_i].nmbx103,g_nmbx_d[l_i].nmbx113,g_nmbx_d[l_i].nmbx104, 
       g_nmbx_d[l_i].nmbx114,g_nmbx_d[l_i].ocbt,g_nmbx_d[l_i].ccbt)        
   END FOR 
   
   CALL anmq920_x01('anmq920_xg_tmp',' 1=1')
   
END FUNCTION

 
{</section>}
 
