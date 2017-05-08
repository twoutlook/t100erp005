#該程式未解開Section, 採用最新樣板產出!
{<section id="aisq100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-09-07 14:45:44), PR版次:0004(2016-10-26 13:52:06)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000011
#+ Filename...: aisq100
#+ Description: 客戶對帳查詢作業
#+ Creator....: 08171(2016-08-30 14:11:56)
#+ Modifier...: 08171 -SD/PR- 08171
 
{</section>}
 
{<section id="aisq100.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#161006-00005#26  2016/10/21 By Reanna      1.業務組織(isaf004)開窗改用q_ooeg001_4 2.帳務中心(isafsite)開窗改用q_ooef001_46()，where條件拿掉
#161017-00005#1   2016/10/26 By 08171       業務組織開窗根據aooi125法人底下的部門
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
PRIVATE TYPE type_g_isaf_d RECORD
       #statepic       LIKE type_t.chr1,
       
       isaf001 LIKE isaf_t.isaf001, 
   isafdocno LIKE isaf_t.isafdocno, 
   isafdocdt LIKE isaf_t.isafdocdt, 
   isaf005 LIKE isaf_t.isaf005, 
   isaf005_desc LIKE type_t.chr500, 
   isaf004 LIKE isaf_t.isaf004, 
   isaf004_desc LIKE type_t.chr500, 
   isaf057 LIKE isaf_t.isaf057, 
   isaf057_desc LIKE type_t.chr500, 
   isaf100 LIKE isaf_t.isaf100, 
   isaf101 LIKE isaf_t.isaf101, 
   isaf103 LIKE isaf_t.isaf103, 
   isaf104 LIKE isaf_t.isaf104, 
   isaf105 LIKE isaf_t.isaf105, 
   isaf113 LIKE isaf_t.isaf113, 
   isaf114 LIKE isaf_t.isaf114, 
   isaf115 LIKE isaf_t.isaf115, 
   isat001 LIKE isat_t.isat001, 
   isat001_desc LIKE type_t.chr500, 
   isat003 LIKE isat_t.isat003, 
   isat004 LIKE isat_t.isat004, 
   isat014 LIKE type_t.chr500, 
   isat025 LIKE type_t.chr500, 
   isatseq LIKE isat_t.isatseq, 
   isat007 LIKE isat_t.isat007 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

TYPE type_g_input RECORD
        isafsite        LIKE isaf_t.isafsite,
        isafsite_desc   LIKE type_t.chr80,
        isafcomp        LIKE isaf_t.isafcomp,
        isafcomp_desc   LIKE type_t.chr80,
        isaf002         LIKE isaf_t.isaf002,
        isaf002_desc    LIKE type_t.chr80,
        l_isafdocdt_s   LIKE isaf_t.isafdocdt,
        l_isafdocdt_e   LIKE isaf_t.isafdocdt
                    END RECORD
DEFINE g_input    type_g_input
DEFINE g_input_o  type_g_input
DEFINE g_wc_isafcomp    STRING
DEFINE g_ctl_where      STRING    #交易對象控制組WHERE CON
DEFINE g_xg_visible          STRING     #XG欄位隱藏條件
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_isaf_d
DEFINE g_master_t                   type_g_isaf_d
DEFINE g_isaf_d          DYNAMIC ARRAY OF type_g_isaf_d
DEFINE g_isaf_d_t        type_g_isaf_d
 
      
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
 
{<section id="aisq100.main" >}
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
   CALL cl_ap_init("ais","")
 
   #add-point:作業初始化 name="main.init"
   LET g_ctl_where = NULL
   CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_ctl_where
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
   DECLARE aisq100_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aisq100_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aisq100_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisq100 WITH FORM cl_ap_formpath("ais",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aisq100_init()   
 
      #進入選單 Menu (="N")
      CALL aisq100_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aisq100
      
   END IF 
   
   CLOSE aisq100_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aisq100.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aisq100_init()
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
   
      CALL cl_set_combo_scc('b_isaf001','9715') 
 
   
   #add-point:畫面資料初始化 name="init.init"

   CALL aisq100_qbe_clear()
   #end add-point
 
   CALL aisq100_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aisq100.default_search" >}
PRIVATE FUNCTION aisq100_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " isafcomp = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " isafdocno = '", g_argv[02], "' AND "
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
 
{<section id="aisq100.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aisq100_ui_dialog()
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
    CALL aisq100_create_tmp()
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL aisq100_b_fill()
   ELSE
      CALL aisq100_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_isaf_d.clear()
 
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
 
         CALL aisq100_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_isaf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aisq100_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aisq100_detail_action_trans()
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
            CALL aisq100_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aisq100_ins_x01_tmp()
               CALL aisq100_x01(' 1=1','aisq100_x01_tmp',g_xg_visible)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aisq100_ins_x01_tmp()
               CALL aisq100_x01(' 1=1','aisq100_x01_tmp',g_xg_visible)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aisq100_query()
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
            CALL aisq100_filter()
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
            CALL aisq100_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_isaf_d)
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
            CALL aisq100_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aisq100_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aisq100_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aisq100_b_fill()
 
         
         
 
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
 
{<section id="aisq100.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aisq100_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE hid_isaf003     LIKE type_t.num5
   DEFINE g_glaald        LIKE glaa_t.glaald
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_isaf_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON isaf001,isafdocno,isafdocdt,isaf005,isaf004,isaf057,isaf100,isaf101,isaf103, 
          isaf104,isaf105,isaf113,isaf114,isaf115
           FROM s_detail1[1].b_isaf001,s_detail1[1].b_isafdocno,s_detail1[1].b_isafdocdt,s_detail1[1].b_isaf005, 
               s_detail1[1].b_isaf004,s_detail1[1].b_isaf057,s_detail1[1].b_isaf100,s_detail1[1].b_isaf101, 
               s_detail1[1].b_isaf103,s_detail1[1].b_isaf104,s_detail1[1].b_isaf105,s_detail1[1].b_isaf113, 
               s_detail1[1].b_isaf114,s_detail1[1].b_isaf115
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_isaf001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf001
            #add-point:BEFORE FIELD b_isaf001 name="construct.b.page1.b_isaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf001
            
            #add-point:AFTER FIELD b_isaf001 name="construct.a.page1.b_isaf001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf001
            #add-point:ON ACTION controlp INFIELD b_isaf001 name="construct.c.page1.b_isaf001"
            
            #END add-point
 
 
         #----<<b_isafdocno>>----
         #Ctrlp:construct.c.page1.b_isafdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafdocno
            #add-point:ON ACTION controlp INFIELD b_isafdocno name="construct.c.page1.b_isafdocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isafsite = '",g_input.isafsite,"'",
                                   " AND isafcomp = '",g_input.isafcomp,"'",
                                   " AND isaf002 = '",g_input.isaf002,"' ",
                                   " AND isafdocdt BETWEEN '",g_input.l_isafdocdt_s,"' AND '",g_input.l_isafdocdt_e,"' "
            CALL q_isafdocno()
            DISPLAY g_qryparam.return1 TO b_isafdocno
            NEXT FIELD b_isafdocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isafdocno
            #add-point:BEFORE FIELD b_isafdocno name="construct.b.page1.b_isafdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isafdocno
            
            #add-point:AFTER FIELD b_isafdocno name="construct.a.page1.b_isafdocno"
            
            #END add-point
            
 
 
         #----<<b_isafdocdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isafdocdt
            #add-point:BEFORE FIELD b_isafdocdt name="construct.b.page1.b_isafdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isafdocdt
            
            #add-point:AFTER FIELD b_isafdocdt name="construct.a.page1.b_isafdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isafdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafdocdt
            #add-point:ON ACTION controlp INFIELD b_isafdocdt name="construct.c.page1.b_isafdocdt"
            
            #END add-point
 
 
         #----<<b_isaf005>>----
         #Ctrlp:construct.c.page1.b_isaf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf005
            #add-point:ON ACTION controlp INFIELD b_isaf005 name="construct.c.page1.b_isaf005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO b_isaf005
            NEXT FIELD b_isaf005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf005
            #add-point:BEFORE FIELD b_isaf005 name="construct.b.page1.b_isaf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf005
            
            #add-point:AFTER FIELD b_isaf005 name="construct.a.page1.b_isaf005"
            
            #END add-point
            
 
 
         #----<<b_isaf005_desc>>----
         #----<<b_isaf004>>----
         #Ctrlp:construct.c.page1.b_isaf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf004
            #add-point:ON ACTION controlp INFIELD b_isaf004 name="construct.c.page1.b_isaf004"
            #業務組織
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooegstus = 'Y' AND ooeg009 = '",g_input.isafcomp,"'" #161017-00005#1 add
            #CALL q_ooef001()  #161006-00005#26 mark
            CALL q_ooeg001_4() #161006-00005#26
            DISPLAY g_qryparam.return1 TO b_isaf004
            NEXT FIELD b_isaf004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf004
            #add-point:BEFORE FIELD b_isaf004 name="construct.b.page1.b_isaf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf004
            
            #add-point:AFTER FIELD b_isaf004 name="construct.a.page1.b_isaf004"
            
            #END add-point
            
 
 
         #----<<b_isaf004_desc>>----
         #----<<b_isaf057>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf057
            #add-point:BEFORE FIELD b_isaf057 name="construct.b.page1.b_isaf057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf057
            
            #add-point:AFTER FIELD b_isaf057 name="construct.a.page1.b_isaf057"
         
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf057
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf057
            #add-point:ON ACTION controlp INFIELD b_isaf057 name="construct.c.page1.b_isaf057"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO b_isaf057
            NEXT FIELD b_isaf057
            #END add-point
 
 
         #----<<b_isaf057_desc>>----
         #----<<b_isaf100>>----
         #Ctrlp:construct.c.page1.b_isaf100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf100
            #add-point:ON ACTION controlp INFIELD b_isaf100 name="construct.c.page1.b_isaf100"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()
            DISPLAY g_qryparam.return1 TO b_isaf100 
            NEXT FIELD b_isaf100
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf100
            #add-point:BEFORE FIELD b_isaf100 name="construct.b.page1.b_isaf100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf100
            
            #add-point:AFTER FIELD b_isaf100 name="construct.a.page1.b_isaf100"
            
            #END add-point
            
 
 
         #----<<b_isaf101>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf101
            #add-point:BEFORE FIELD b_isaf101 name="construct.b.page1.b_isaf101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf101
            
            #add-point:AFTER FIELD b_isaf101 name="construct.a.page1.b_isaf101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf101
            #add-point:ON ACTION controlp INFIELD b_isaf101 name="construct.c.page1.b_isaf101"
            
            #END add-point
 
 
         #----<<b_isaf103>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf103
            #add-point:BEFORE FIELD b_isaf103 name="construct.b.page1.b_isaf103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf103
            
            #add-point:AFTER FIELD b_isaf103 name="construct.a.page1.b_isaf103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf103
            #add-point:ON ACTION controlp INFIELD b_isaf103 name="construct.c.page1.b_isaf103"
            
            #END add-point
 
 
         #----<<b_isaf104>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf104
            #add-point:BEFORE FIELD b_isaf104 name="construct.b.page1.b_isaf104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf104
            
            #add-point:AFTER FIELD b_isaf104 name="construct.a.page1.b_isaf104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf104
            #add-point:ON ACTION controlp INFIELD b_isaf104 name="construct.c.page1.b_isaf104"
            
            #END add-point
 
 
         #----<<b_isaf105>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf105
            #add-point:BEFORE FIELD b_isaf105 name="construct.b.page1.b_isaf105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf105
            
            #add-point:AFTER FIELD b_isaf105 name="construct.a.page1.b_isaf105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf105
            #add-point:ON ACTION controlp INFIELD b_isaf105 name="construct.c.page1.b_isaf105"
            
            #END add-point
 
 
         #----<<b_isaf113>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf113
            #add-point:BEFORE FIELD b_isaf113 name="construct.b.page1.b_isaf113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf113
            
            #add-point:AFTER FIELD b_isaf113 name="construct.a.page1.b_isaf113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf113
            #add-point:ON ACTION controlp INFIELD b_isaf113 name="construct.c.page1.b_isaf113"
            
            #END add-point
 
 
         #----<<b_isaf114>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf114
            #add-point:BEFORE FIELD b_isaf114 name="construct.b.page1.b_isaf114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf114
            
            #add-point:AFTER FIELD b_isaf114 name="construct.a.page1.b_isaf114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf114
            #add-point:ON ACTION controlp INFIELD b_isaf114 name="construct.c.page1.b_isaf114"
            
            #END add-point
 
 
         #----<<b_isaf115>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf115
            #add-point:BEFORE FIELD b_isaf115 name="construct.b.page1.b_isaf115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf115
            
            #add-point:AFTER FIELD b_isaf115 name="construct.a.page1.b_isaf115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf115
            #add-point:ON ACTION controlp INFIELD b_isaf115 name="construct.c.page1.b_isaf115"
            
            #END add-point
 
 
         #----<<b_isat001>>----
         #----<<b_isat001_desc>>----
         #----<<b_isat003>>----
         #----<<b_isat004>>----
         #----<<b_isat014>>----
         #----<<b_isat025>>----
         #----<<b_isatseq>>----
         #----<<b_isat007>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT g_input.isafsite,g_input.isafcomp,g_input.isaf002,g_input.l_isafdocdt_s,g_input.l_isafdocdt_e
       FROM isafsite,isafcomp,isaf002,l_isafdocdt_s,l_isafdocdt_e
            ATTRIBUTE(WITHOUT DEFAULTS)
         #帳務中心   
         AFTER FIELD isafsite
            LET g_input.isafsite_desc = ''
            DISPLAY BY NAME g_input.isafsite_desc
            IF NOT cl_null(g_input.isafsite) THEN
               IF g_input.isafsite != g_input_o.isafsite OR cl_null(g_input_o.isafsite) THEN         
                  CALL s_fin_account_center_sons_query('3',g_input.isafsite,g_today,'1')
                  CALL s_fin_account_center_chk(g_input.isafsite,'','3',g_input.l_isafdocdt_s)
                  RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.isafsite = g_input_o.isafsite
                     LET g_input.isafcomp = g_input_o.isafcomp
                     CALL s_desc_get_department_desc(g_input.isafsite) RETURNING g_input.isafsite_desc
                     DISPLAY BY NAME g_input.isafsite_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL s_fin_orga_get_comp_ld(g_input.isafsite) RETURNING g_sub_success,g_errno,g_input.isafcomp,g_glaald
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_input.isafsite = g_input_o.isafsite
                        LET g_input.isafcomp = g_input_o.isafcomp
                        #帳務中心說明
                        CALL s_desc_get_department_desc(g_input.isafsite) RETURNING g_input.isafsite_desc
                        DISPLAY BY NAME g_input.isafsite_desc
                        NEXT FIELD CURRENT
                     END IF
                              
                  IF NOT cl_null(g_input.isafcomp)THEN
                     CALL s_fin_account_center_with_ld_chk(g_input.isafsite,g_glaald,g_user,'3','Y','',g_today) 
                        RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        #LET g_errparam.code = 'aap-00127'
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_input.isafsite = g_input_o.isafsite
                        #帳務中心說明
                        CALL s_desc_get_department_desc(g_input.isafsite) RETURNING g_input.isafsite_desc
                        DISPLAY BY NAME g_input.isafsite_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #抓取法人有哪些
                  CALL s_fin_account_center_sons_query('3',g_input.isafsite,g_today,'')
                  CALL s_fin_account_center_comp_str() RETURNING g_wc_isafcomp
                  CALL s_fin_get_wc_str(g_wc_isafcomp) RETURNING g_wc_isafcomp
                  #帳務中心說明
                  CALL s_desc_get_department_desc(g_input.isafsite) RETURNING g_input.isafsite_desc
                  DISPLAY BY NAME g_input.isafsite_desc
               END IF
            END IF
            #帳務中心說明
            CALL s_desc_get_department_desc(g_input.isafsite) RETURNING g_input.isafsite_desc
            DISPLAY BY NAME g_input.isafsite_desc
            LET g_input_o.* = g_input.*
         
         #帳務中心
         ON ACTION controlp INFIELD isafsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.isafsite
            #LET g_qryparam.where = "ooef003 = 'Y'" #161006-00005#26 mark
            #CALL q_ooef001()                       #161006-00005#26 mark
            CALL q_ooef001_46()                     #161006-00005#26
            LET g_input.isafsite = g_qryparam.return1
            DISPLAY g_input.isafsite TO isafsite
            #帳務中心說明
            CALL s_desc_get_department_desc(g_input.isafsite) RETURNING g_input.isafsite_desc
            DISPLAY BY NAME g_input.isafsite_desc
            NEXT FIELD isafsite
         
         #法人
         AFTER FIELD isafcomp
            LET g_input.isafcomp_desc = ''
            DISPLAY BY NAME g_input.isafcomp_desc
            IF NOT cl_null(g_input.isafcomp) THEN
               IF g_input.isafcomp != g_input_o.isafcomp OR cl_null(g_input_o.isafcomp) THEN                       
                  #檢查是否為法人
                  CALL s_fin_comp_chk(g_input.isafcomp) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi100'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.isafcomp = g_input_o.isafcomp
                     NEXT FIELD CURRENT
                  END IF                             
                  #取得帳務組織下所屬成員
                  CALL s_fin_account_center_sons_query('3',g_input.isafsite,g_today,'1')
                  #取得帳務組織底下所屬的法人範圍
                  CALL s_fin_account_center_comp_str() RETURNING g_wc_isafcomp
                  #將取回的字串轉換為SQL條件
                  CALL s_fin_get_wc_str(g_wc_isafcomp) RETURNING g_wc_isafcomp       
                  #帳務中心與帳別檢查 (針對權限的檢核)                 
                  IF NOT cl_null(g_input.isafsite)THEN
                     CALL s_fin_account_center_with_ld_chk(g_input.isafsite,g_glaald,g_user,'3','Y','',g_today) 
                        RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aap-00127'#法人不為帳務組織底下的法人,或無此組織權限!!!
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_input.isafcomp = g_input_o.isafcomp
                        NEXT FIELD CURRENT
                     END IF   
                  END IF
                  #比對輸入的法人是否在帳務組織下(帳務中心勾稽的檢核)
                  IF s_chr_get_index_of(g_wc_isafcomp,g_input.isafcomp,'1') = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ais-00312' #來源組織不屬於單頭法人組織,請檢查！
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.isafcomp = g_input_o.isafcomp
                     #法人說明
                     CALL s_desc_get_department_desc(g_input.isafcomp) RETURNING g_input.isafcomp_desc   
                     DISPLAY BY NAME g_input.isafcomp_desc
                     NEXT FIELD CURRENT
                  END IF 
                  #法人說明                  
                  CALL s_desc_get_department_desc(g_input.isafcomp) RETURNING g_input.isafcomp_desc   
                  DISPLAY BY NAME g_input.isafcomp_desc
               END IF
            END IF
            #法人說明                  
            CALL s_desc_get_department_desc(g_input.isafcomp) RETURNING g_input.isafcomp_desc   
            DISPLAY BY NAME g_input.isafcomp_desc
            LET g_input_o.* = g_input.*
            
         #法人
         ON ACTION controlp INFIELD isafcomp
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.isafcomp
            
            CALL s_fin_account_center_sons_query('3',g_input.isafsite,g_today,'')
            CALL s_fin_account_center_comp_str() RETURNING g_wc_isafcomp
            CALL s_fin_get_wc_str(g_wc_isafcomp) RETURNING g_wc_isafcomp
            LET g_qryparam.where    = "ooef003 = 'Y' AND ooef001 IN ",g_wc_isafcomp CLIPPED," "                                   
            CALL q_ooef001()
            LET g_input.isafcomp = g_qryparam.return1
            DISPLAY g_input.isafcomp TO isafcomp
            #法人說明                  
            CALL s_desc_get_department_desc(g_input.isafcomp) RETURNING g_input.isafcomp_desc   
            DISPLAY BY NAME g_input.isafcomp_desc
            NEXT FIELD isafcomp
     
         #發票客戶
         AFTER FIELD isaf002
            LET g_input.isaf002_desc = ''
            DISPLAY BY NAME g_input.isaf002_desc
            IF NOT cl_null(g_input.isaf002) THEN
               IF g_input.isaf002 != g_input_o.isaf002 OR cl_null(g_input_o.isaf002) THEN
                 #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL      
                  LET g_errshow = TRUE #是否開窗 
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_input.isaf002
                  LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"#要執行的建議程式待補 
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_pmaa001_2") THEN           
                     LET g_input.isaf002 = g_input_o.isaf002
                     #發票客戶說明
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_input.isaf002
                     CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                     LET g_input.isaf002_desc = '', g_rtn_fields[1] , ''
                     DISPLAY BY NAME g_input.isaf002_desc
                     NEXT FIELD CURRENT
                  END IF
                  #檢核客戶在控制組與單據別控制內是否可使用(整合)
                  CALL s_control_check_customer(g_input.isaf002,'2',g_input.isafsite,g_user,g_dept,'')
                  RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     #檢查失敗時後續處理
                     LET g_input.isaf002 = g_input_o.isaf002
                     #發票客戶說明
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_input.isaf002
                     CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                     LET g_input.isaf002_desc = '', g_rtn_fields[1] , ''
                     DISPLAY BY NAME g_input.isaf002_desc
                     NEXT FIELD CURRENT
                  END IF
                  #發票客戶說明
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_input.isaf002
                  CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_input.isaf002_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_input.isaf002_desc
               END IF
            END IF
            #發票客戶說明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_input.isaf002
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_input.isaf002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_input.isaf002_desc
            LET g_input_o.* = g_input.*
         #發票客戶
         ON ACTION controlp INFIELD isaf002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pmaa002 IN ('2','3')"
            IF NOT cl_null(g_ctl_where) AND NOT g_ctl_where = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",g_ctl_where
            END IF          
            CALL q_pmaa001_13()
            LET g_input.isaf002 = g_qryparam.return1
            DISPLAY g_input.isaf002 TO isaf002
            #發票客戶說明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_input.isaf002
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_input.isaf002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_input.isaf002_desc
            NEXT FIELD isaf002
         
         AFTER FIELD l_isafdocdt_s
            IF NOT cl_null(g_input.l_isafdocdt_s) AND NOT cl_null(g_input.l_isafdocdt_e) THEN
               IF g_input.l_isafdocdt_s > g_input.l_isafdocdt_e THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "amm-00081"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.l_isafdocdt_e = g_input.l_isafdocdt_s
               END IF
            END IF
            
         AFTER FIELD l_isafdocdt_e
            IF NOT cl_null(g_input.l_isafdocdt_s) AND NOT cl_null(g_input.l_isafdocdt_e) THEN
               IF g_input.l_isafdocdt_s > g_input.l_isafdocdt_e THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "amm-00081"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.l_isafdocdt_s = s_date_get_first_date(g_input.l_isafdocdt_e)
               END IF
            END IF
         
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
      BEFORE DIALOG
      CALL aisq100_qbe_clear()        
      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後 name="query.qbeclear"
         
         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後 name="query.set_qbe_action_after"
      CALL aisq100_qbe_clear()
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
   SELECT isai002 INTO hid_isaf003
     FROM ooef_t
     LEFT JOIN isai_t ON isaient = ooefent AND isai001 = ooef019
     WHERE ooefent = g_enterprise
     AND ooef001 = g_input.isafsite
     AND ooef017 = g_input.isafcomp
     
   CALL cl_set_comp_visible("b_isat003", TRUE)
   IF hid_isaf003 != 2 THEN
      CALL cl_set_comp_visible("b_isat003", FALSE)
   END IF

   #end add-point
        
   LET g_error_show = 1
   CALL aisq100_b_fill()
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
 
{<section id="aisq100.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aisq100_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE hid_isaf003     LIKE type_t.num5
   DEFINE l_main_sql      STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   SELECT isai002 INTO hid_isaf003
     FROM ooef_t
     LEFT JOIN isai_t ON isaient = ooefent AND isai001 = ooef019
     WHERE ooefent = g_enterprise
     AND ooef001 = g_input.isafsite
     AND ooef017 = g_input.isafcomp
     
   CALL cl_set_comp_visible("b_isat003", TRUE)
   IF hid_isaf003 != 2 THEN
      CALL cl_set_comp_visible("b_isat003", FALSE)
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
 
   LET ls_sql_rank = "SELECT  UNIQUE isaf001,isafdocno,isafdocdt,isaf005,'',isaf004,'',isaf057,'',isaf100, 
       isaf101,isaf103,isaf104,isaf105,isaf113,isaf114,isaf115,'','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY isaf_t.isafcomp, 
       isaf_t.isafdocno) AS RANK FROM isaf_t",
 
 
                     "",
                     " WHERE isafent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("isaf_t"),
                     " ORDER BY isaf_t.isafcomp,isaf_t.isafdocno"
 
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
 
   LET g_sql = "SELECT isaf001,isafdocno,isafdocdt,isaf005,'',isaf004,'',isaf057,'',isaf100,isaf101, 
       isaf103,isaf104,isaf105,isaf113,isaf114,isaf115,'','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
  
   LET l_main_sql = "SELECT isaf001,isafdocno,isafdocdt,",
                           "isaf005,(SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=isaf005),", #帳務人員+說明
                           "isaf004,(SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=isaf004 AND ooefl002='"||g_dlang||"'),", #業務組織+說明
                           "isaf057,(SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=isaf057),", #業務人員+說明
                           "isaf100,isaf101, isaf103,isaf104,isaf105,isaf113,isaf114,isaf115,",
                           "isat001,(SELECT isacl004 FROM isacl_t WHERE isaclent = '"||g_enterprise||"' AND isacl001 = ooef019 AND isacl002 = isat001 AND isacl003 = '"||g_dlang||"'),", #發票類型+說明
                           "isat003,isat004,",
                           "(SELECT gzcbl002|| ':' ||gzcbl004 AS isat014 FROM gzcbl_t WHERE gzcbl001 = '9716'AND gzcbl002 = isat014 AND gzcbl003 = '"||g_dlang||"'),", #發票異動狀態  代碼+說明
                           "(SELECT gzcbl002|| ':' ||gzcbl004 AS isat025 FROM gzcbl_t WHERE gzcbl001 = '9716'AND gzcbl002 = isat025 AND gzcbl003 = '"||g_dlang||"'),", #發票最終狀態  代碼+說明
                           "isatseq,isat007 ",
                      "FROM isaf_t ",
                      "LEFT JOIN isat_t ON isafent = isatent AND isafcomp = isatcomp AND isafdocno = isatdocno ",
                      "LEFT JOIN ooef_t ON ooefent = isafent  AND  ooef001 = isafsite ",
                     "WHERE isafent = ? AND isafsite = '"||g_input.isafsite||"' AND isafcomp = '"||g_input.isafcomp||"' AND isaf002 = '"||g_input.isaf002||"' ",
                       "AND isafdocdt BETWEEN '"||g_input.l_isafdocdt_s||"' AND '"||g_input.l_isafdocdt_e||"' ",
                       "ORDER BY isaf001,isafdocno "

   LET g_sql = "SELECT * FROM (",l_main_sql,") WHERE ",ls_wc ,""
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aisq100_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aisq100_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_isaf_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_isaf_d[l_ac].isaf001,g_isaf_d[l_ac].isafdocno,g_isaf_d[l_ac].isafdocdt, 
       g_isaf_d[l_ac].isaf005,g_isaf_d[l_ac].isaf005_desc,g_isaf_d[l_ac].isaf004,g_isaf_d[l_ac].isaf004_desc, 
       g_isaf_d[l_ac].isaf057,g_isaf_d[l_ac].isaf057_desc,g_isaf_d[l_ac].isaf100,g_isaf_d[l_ac].isaf101, 
       g_isaf_d[l_ac].isaf103,g_isaf_d[l_ac].isaf104,g_isaf_d[l_ac].isaf105,g_isaf_d[l_ac].isaf113,g_isaf_d[l_ac].isaf114, 
       g_isaf_d[l_ac].isaf115,g_isaf_d[l_ac].isat001,g_isaf_d[l_ac].isat001_desc,g_isaf_d[l_ac].isat003, 
       g_isaf_d[l_ac].isat004,g_isaf_d[l_ac].isat014,g_isaf_d[l_ac].isat025,g_isaf_d[l_ac].isatseq,g_isaf_d[l_ac].isat007 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_isaf_d[l_ac].statepic = cl_get_actipic(g_isaf_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aisq100_detail_show("'1'")      
 
      CALL aisq100_isaf_t_mask()
 
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
   
 
   
   CALL g_isaf_d.deleteElement(g_isaf_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_isaf_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aisq100_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aisq100_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aisq100_detail_action_trans()
 
   IF g_isaf_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aisq100_fetch()
   END IF
   
      CALL aisq100_filter_show('isaf001','b_isaf001')
   CALL aisq100_filter_show('isafdocno','b_isafdocno')
   CALL aisq100_filter_show('isafdocdt','b_isafdocdt')
   CALL aisq100_filter_show('isaf005','b_isaf005')
   CALL aisq100_filter_show('isaf004','b_isaf004')
   CALL aisq100_filter_show('isaf057','b_isaf057')
   CALL aisq100_filter_show('isaf100','b_isaf100')
   CALL aisq100_filter_show('isaf101','b_isaf101')
   CALL aisq100_filter_show('isaf103','b_isaf103')
   CALL aisq100_filter_show('isaf104','b_isaf104')
   CALL aisq100_filter_show('isaf105','b_isaf105')
   CALL aisq100_filter_show('isaf113','b_isaf113')
   CALL aisq100_filter_show('isaf114','b_isaf114')
   CALL aisq100_filter_show('isaf115','b_isaf115')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   #b_fill()完之後重算筆數
   DISPLAY g_isaf_d.getLength() TO FORMONLY.h_count     #單身總筆數
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq100.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aisq100_fetch()
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
 
{<section id="aisq100.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aisq100_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_isaf_d[l_ac].isaf005
            LET ls_sql = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? "
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_isaf_d[l_ac].isaf005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_isaf_d[l_ac].isaf005_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_isaf_d[l_ac].isaf004
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_isaf_d[l_ac].isaf004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_isaf_d[l_ac].isaf004_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_isaf_d[l_ac].isaf057
            LET ls_sql = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? "
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_isaf_d[l_ac].isaf057_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_isaf_d[l_ac].isaf057_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq100.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aisq100_filter()
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
      CONSTRUCT g_wc_filter ON isaf001,isafdocno,isafdocdt,isaf005,isaf004,isaf057,isaf100,isaf101,isaf103, 
          isaf104,isaf105,isaf113,isaf114,isaf115
                          FROM s_detail1[1].b_isaf001,s_detail1[1].b_isafdocno,s_detail1[1].b_isafdocdt, 
                              s_detail1[1].b_isaf005,s_detail1[1].b_isaf004,s_detail1[1].b_isaf057,s_detail1[1].b_isaf100, 
                              s_detail1[1].b_isaf101,s_detail1[1].b_isaf103,s_detail1[1].b_isaf104,s_detail1[1].b_isaf105, 
                              s_detail1[1].b_isaf113,s_detail1[1].b_isaf114,s_detail1[1].b_isaf115
 
         BEFORE CONSTRUCT
                     DISPLAY aisq100_filter_parser('isaf001') TO s_detail1[1].b_isaf001
            DISPLAY aisq100_filter_parser('isafdocno') TO s_detail1[1].b_isafdocno
            DISPLAY aisq100_filter_parser('isafdocdt') TO s_detail1[1].b_isafdocdt
            DISPLAY aisq100_filter_parser('isaf005') TO s_detail1[1].b_isaf005
            DISPLAY aisq100_filter_parser('isaf004') TO s_detail1[1].b_isaf004
            DISPLAY aisq100_filter_parser('isaf057') TO s_detail1[1].b_isaf057
            DISPLAY aisq100_filter_parser('isaf100') TO s_detail1[1].b_isaf100
            DISPLAY aisq100_filter_parser('isaf101') TO s_detail1[1].b_isaf101
            DISPLAY aisq100_filter_parser('isaf103') TO s_detail1[1].b_isaf103
            DISPLAY aisq100_filter_parser('isaf104') TO s_detail1[1].b_isaf104
            DISPLAY aisq100_filter_parser('isaf105') TO s_detail1[1].b_isaf105
            DISPLAY aisq100_filter_parser('isaf113') TO s_detail1[1].b_isaf113
            DISPLAY aisq100_filter_parser('isaf114') TO s_detail1[1].b_isaf114
            DISPLAY aisq100_filter_parser('isaf115') TO s_detail1[1].b_isaf115
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_isaf001>>----
         #Ctrlp:construct.c.filter.page1.b_isaf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf001
            #add-point:ON ACTION controlp INFIELD b_isaf001 name="construct.c.filter.page1.b_isaf001"
            
            #END add-point
 
 
         #----<<b_isafdocno>>----
         #Ctrlp:construct.c.page1.b_isafdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafdocno
            #add-point:ON ACTION controlp INFIELD b_isafdocno name="construct.c.filter.page1.b_isafdocno"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isafsite = '",g_input.isafsite,"'",
                                   " AND isafcomp = '",g_input.isafcomp,"'",
                                   " AND isaf002 = '",g_input.isaf002,"' ",
                                   " AND isafdocdt BETWEEN '",g_input.l_isafdocdt_s,"' AND '",g_input.l_isafdocdt_e,"'"
            CALL q_isafdocno()
            DISPLAY g_qryparam.return1 TO b_isafdocno
            NEXT FIELD b_isafdocno
            #END add-point
 
 
         #----<<b_isafdocdt>>----
         #Ctrlp:construct.c.filter.page1.b_isafdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafdocdt
            #add-point:ON ACTION controlp INFIELD b_isafdocdt name="construct.c.filter.page1.b_isafdocdt"
            
            #END add-point
 
 
         #----<<b_isaf005>>----
         #Ctrlp:construct.c.page1.b_isaf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf005
            #add-point:ON ACTION controlp INFIELD b_isaf005 name="construct.c.filter.page1.b_isaf005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO b_isaf005
            NEXT FIELD b_isaf005
            #END add-point
 
 
         #----<<b_isaf005_desc>>----
         #----<<b_isaf004>>----
         #Ctrlp:construct.c.page1.b_isaf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf004
            #add-point:ON ACTION controlp INFIELD b_isaf004 name="construct.c.filter.page1.b_isaf004"
            #業務組織
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()  #161006-00005#26 mark
            LET g_qryparam.where = " ooegstus = 'Y' AND ooeg009 = '",g_input.isafcomp,"'" #161017-00005#1 add
            CALL q_ooeg001_4() #161006-00005#26
            DISPLAY g_qryparam.return1 TO b_isaf004
            NEXT FIELD b_isaf004
            #END add-point
 
 
         #----<<b_isaf004_desc>>----
         #----<<b_isaf057>>----
         #Ctrlp:construct.c.filter.page1.b_isaf057
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf057
            #add-point:ON ACTION controlp INFIELD b_isaf057 name="construct.c.filter.page1.b_isaf057"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isaf057  #顯示到畫面上
            NEXT FIELD b_isaf057                     #返回原欄位
            #END add-point
 
 
         #----<<b_isaf057_desc>>----
         #----<<b_isaf100>>----
         #Ctrlp:construct.c.page1.b_isaf100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf100
            #add-point:ON ACTION controlp INFIELD b_isaf100 name="construct.c.filter.page1.b_isaf100"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()
            DISPLAY g_qryparam.return1 TO b_isaf100
            NEXT FIELD b_isaf100
            #END add-point
 
 
         #----<<b_isaf101>>----
         #Ctrlp:construct.c.filter.page1.b_isaf101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf101
            #add-point:ON ACTION controlp INFIELD b_isaf101 name="construct.c.filter.page1.b_isaf101"
            
            #END add-point
 
 
         #----<<b_isaf103>>----
         #Ctrlp:construct.c.filter.page1.b_isaf103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf103
            #add-point:ON ACTION controlp INFIELD b_isaf103 name="construct.c.filter.page1.b_isaf103"
            
            #END add-point
 
 
         #----<<b_isaf104>>----
         #Ctrlp:construct.c.filter.page1.b_isaf104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf104
            #add-point:ON ACTION controlp INFIELD b_isaf104 name="construct.c.filter.page1.b_isaf104"
            
            #END add-point
 
 
         #----<<b_isaf105>>----
         #Ctrlp:construct.c.filter.page1.b_isaf105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf105
            #add-point:ON ACTION controlp INFIELD b_isaf105 name="construct.c.filter.page1.b_isaf105"
            
            #END add-point
 
 
         #----<<b_isaf113>>----
         #Ctrlp:construct.c.filter.page1.b_isaf113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf113
            #add-point:ON ACTION controlp INFIELD b_isaf113 name="construct.c.filter.page1.b_isaf113"
            
            #END add-point
 
 
         #----<<b_isaf114>>----
         #Ctrlp:construct.c.filter.page1.b_isaf114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf114
            #add-point:ON ACTION controlp INFIELD b_isaf114 name="construct.c.filter.page1.b_isaf114"
            
            #END add-point
 
 
         #----<<b_isaf115>>----
         #Ctrlp:construct.c.filter.page1.b_isaf115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf115
            #add-point:ON ACTION controlp INFIELD b_isaf115 name="construct.c.filter.page1.b_isaf115"
            
            #END add-point
 
 
         #----<<b_isat001>>----
         #----<<b_isat001_desc>>----
         #----<<b_isat003>>----
         #----<<b_isat004>>----
         #----<<b_isat014>>----
         #----<<b_isat025>>----
         #----<<b_isatseq>>----
         #----<<b_isat007>>----
   
 
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
   
      CALL aisq100_filter_show('isaf001','b_isaf001')
   CALL aisq100_filter_show('isafdocno','b_isafdocno')
   CALL aisq100_filter_show('isafdocdt','b_isafdocdt')
   CALL aisq100_filter_show('isaf005','b_isaf005')
   CALL aisq100_filter_show('isaf004','b_isaf004')
   CALL aisq100_filter_show('isaf057','b_isaf057')
   CALL aisq100_filter_show('isaf100','b_isaf100')
   CALL aisq100_filter_show('isaf101','b_isaf101')
   CALL aisq100_filter_show('isaf103','b_isaf103')
   CALL aisq100_filter_show('isaf104','b_isaf104')
   CALL aisq100_filter_show('isaf105','b_isaf105')
   CALL aisq100_filter_show('isaf113','b_isaf113')
   CALL aisq100_filter_show('isaf114','b_isaf114')
   CALL aisq100_filter_show('isaf115','b_isaf115')
 
    
   CALL aisq100_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq100.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aisq100_filter_parser(ps_field)
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
 
{<section id="aisq100.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aisq100_filter_show(ps_field,ps_object)
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
   LET ls_condition = aisq100_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq100.insert" >}
#+ insert
PRIVATE FUNCTION aisq100_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aisq100.modify" >}
#+ modify
PRIVATE FUNCTION aisq100_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq100.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aisq100_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq100.delete" >}
#+ delete
PRIVATE FUNCTION aisq100_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq100.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aisq100_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   LET g_tot_cnt = g_isaf_d.getLength()
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
 
{<section id="aisq100.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aisq100_detail_index_setting()
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
            IF g_isaf_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_isaf_d.getLength() AND g_isaf_d.getLength() > 0
            LET g_detail_idx = g_isaf_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_isaf_d.getLength() THEN
               LET g_detail_idx = g_isaf_d.getLength()
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
 
{<section id="aisq100.mask_functions" >}
 &include "erp/ais/aisq100_mask.4gl"
 
{</section>}
 
{<section id="aisq100.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 資料初始化
# Memo...........:
# Usage..........: CALL aisq100__qbe_clear()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 160830 By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq100_qbe_clear()
   CALL s_fin_create_account_center_tmp()
   LET g_input.isafsite      = ''
   LET g_input.isafsite_desc = ''
   LET g_input.isafcomp      = ''
   LET g_input.isafcomp_desc = ''
   LET g_input.isaf002       = ''
   LET g_input.isaf002_desc  = ''
   LET g_input.l_isafdocdt_s = g_today
   LET g_input.l_isafdocdt_e = g_today
   LET g_input_o.isafsite      = ''
   LET g_input_o.isafcomp      = ''
   LET g_input_o.isaf002       = ''
   CALL cl_set_comp_visible("b_isat003", TRUE)

END FUNCTION

################################################################################
# Descriptions...: 建立臨時表
# Memo...........: 
# Usage..........: CALL aisq100_create_tmp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 20160901 By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq100_create_tmp()

   DROP TABLE aisq100_x01_tmp;
   CREATE TEMP TABLE aisq100_x01_tmp(  
      isafent            SMALLINT,   
      l_isafsite_desc    VARCHAR(100),
      l_isafcomp_desc    VARCHAR(100),
      l_isaf002_desc     VARCHAR(100),
      l_isafdocdt        VARCHAR(100),
      l_isaf001          VARCHAR(100), 
      isafdocno          VARCHAR(20), 
      isafdocdt          DATE, 
      isaf005            VARCHAR(20), 
      l_isaf005_desc     VARCHAR(100), 
      isaf004            VARCHAR(10), 
      l_isaf004_desc     VARCHAR(100), 
      isaf057            VARCHAR(20), 
      l_isaf057_desc     VARCHAR(100), 
      isaf100            VARCHAR(10), 
      isaf101            DECIMAL(20,10), 
      isaf103            DECIMAL(20,6), 
      isaf104            DECIMAL(20,6),      
      isaf105            DECIMAL(20,6), 
      isaf113            DECIMAL(20,6), 
      isaf114            DECIMAL(20,6), 
      isaf115            DECIMAL(20,6), 
      isat001            VARCHAR(2), 
      l_isat001_desc     VARCHAR(100), 
      isat003            VARCHAR(20), 
      isat004            VARCHAR(20), 
      l_isat014          VARCHAR(100),  
      l_isat025          VARCHAR(100), 
      isatseq            INTEGER, 
      isat007            DATE
      )
END FUNCTION

################################################################################
# Descriptions...: 報表列印
# Memo...........:
# Usage..........: CALL aisq100_ins_x01_tmp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 20160901 By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq100_ins_x01_tmp()
DEFINE l_i                 LIKE type_t.num5
DEFINE l_isafsite_desc     LIKE type_t.chr100
DEFINE l_isafcomp_desc     LIKE type_t.chr100
DEFINE l_isaf002_desc      LIKE type_t.chr100
DEFINE l_isafdocdt         LIKE type_t.chr100
DEFINE l_isaf001           LIKE type_t.chr100
DEFINE l_isaf005_desc      LIKE type_t.chr100
DEFINE l_isaf004_desc      LIKE type_t.chr100
DEFINE l_isaf057_desc      LIKE type_t.chr100
DEFINE l_isat001_desc      LIKE type_t.chr100



   LET l_isafsite_desc = g_input.isafsite,':',g_input.isafsite_desc 
   LET l_isafcomp_desc = g_input.isafcomp,':',g_input.isafcomp_desc
   LET l_isaf002_desc  = g_input.isaf002,':',g_input.isaf002_desc 
   LET l_isafdocdt     = g_input.l_isafdocdt_s,'~',g_input.l_isafdocdt_e

   DELETE FROM aisq100_x01_tmp

   LET l_i = 1
   FOR l_i = 1 TO g_isaf_d.getLength()  
      IF NOT cl_null(g_isaf_d[l_i].isaf001) THEN
         LET l_isaf001 = g_isaf_d[l_i].isaf001,':',s_desc_gzcbl004_desc('9715',g_isaf_d[l_i].isaf001)
      ELSE
         LET l_isaf001 = ''
      END IF
    
    
      INSERT INTO aisq100_x01_tmp
      VALUES(g_enterprise,
             l_isafsite_desc,
             l_isafcomp_desc,
             l_isaf002_desc,
             l_isafdocdt,
             l_isaf001,
             g_isaf_d[l_i].isafdocno,
             g_isaf_d[l_i].isafdocdt, 
             g_isaf_d[l_i].isaf005,
             g_isaf_d[l_i].isaf005_desc,
             g_isaf_d[l_i].isaf004,
             g_isaf_d[l_i].isaf004_desc, 
             g_isaf_d[l_i].isaf057,
             g_isaf_d[l_i].isaf057_desc,
             g_isaf_d[l_i].isaf100, 
             g_isaf_d[l_i].isaf101, 
             g_isaf_d[l_i].isaf103,
             g_isaf_d[l_i].isaf104,             
             g_isaf_d[l_i].isaf105,
             g_isaf_d[l_i].isaf113,
             g_isaf_d[l_i].isaf114, 
             g_isaf_d[l_i].isaf115,
             g_isaf_d[l_i].isat001,
             g_isaf_d[l_i].isat001_desc,
             g_isaf_d[l_i].isat003, 
             g_isaf_d[l_i].isat004,
             g_isaf_d[l_i].isat014,  
             g_isaf_d[l_i].isat025,
             g_isaf_d[l_i].isatseq,
             g_isaf_d[l_i].isat007
             )
   END FOR
   CALL aisq100_xg_visible()
END FUNCTION

################################################################################
# Descriptions...: XG欄位顯隱
# Memo...........:
# Usage..........: CALL aisq100_xg_visible()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 20160902 By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq100_xg_visible()
DEFINE l_isat003  LIKE isat_t.isat003
   LET g_xg_visible = NULL
   LET l_isat003 = ''
   
   SELECT isai002 INTO l_isat003
     FROM ooef_t
     LEFT JOIN isai_t ON isaient = ooefent AND isai001 = ooef019
     WHERE ooefent = g_enterprise
     AND ooef001 = g_input.isafsite
     AND ooef017 = g_input.isafcomp
     

   IF l_isat003 != 2 THEN      
      LET g_xg_visible = "isat003"
   END IF
END FUNCTION

 
{</section>}
 
