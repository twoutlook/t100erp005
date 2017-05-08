#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq912.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-03-18 18:08:12), PR版次:0002(2016-10-21 15:48:01)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000027
#+ Filename...: axcq912
#+ Description: 銷售成本查詢作業
#+ Creator....: 07675(2016-01-13 14:36:44)
#+ Modifier...: 07675 -SD/PR- 02040
 
{</section>}
 
{<section id="axcq912.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160802-00020#9   2016/09/26  By 02097    法人:視azzi800的据點權限/帳套: 視USER的帳套權限/QBE下法人/帳套不用互相勾稽
#161019-00017#9   2016/10/19  By zhujing  据点组织开窗资料整批调整
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
PRIVATE TYPE type_g_xcck_d RECORD
       #statepic       LIKE type_t.chr1,
       
       xccksite LIKE xcck_t.xccksite, 
   xccksite_desc LIKE type_t.chr500, 
   xcck002 LIKE xcck_t.xcck002, 
   xcck002_desc LIKE type_t.chr500, 
   xcck006 LIKE xcck_t.xcck006, 
   xcck007 LIKE xcck_t.xcck007, 
   xcck008 LIKE xcck_t.xcck008, 
   xcck009 LIKE xcck_t.xcck009, 
   xcck010 LIKE xcck_t.xcck010, 
   xcck010_desc LIKE type_t.chr500, 
   xcck010_desc_1 LIKE type_t.chr500, 
   xcck013 LIKE xcck_t.xcck013, 
   l_rtiadocdt LIKE type_t.dat, 
   xcck028 LIKE xcck_t.xcck028, 
   xcck028_desc LIKE type_t.chr500, 
   imag011 LIKE imag_t.imag011, 
   imag011_desc LIKE type_t.chr500, 
   xmdk004 LIKE xmdk_t.xmdk004, 
   xmdk004_desc LIKE type_t.chr500, 
   xcck015 LIKE xcck_t.xcck015, 
   xcck015_desc LIKE type_t.chr500, 
   xcck017 LIKE xcck_t.xcck017, 
   xcck044 LIKE xcck_t.xcck044, 
   xcck044_desc LIKE type_t.chr500, 
   xcck201 LIKE xcck_t.xcck201, 
   xcck282 LIKE xcck_t.xcck282, 
   xcck202 LIKE xcck_t.xcck202 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#160802-00020#9-s-add
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#160802-00020#9-e-add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_xcck_d
DEFINE g_master_t                   type_g_xcck_d
DEFINE g_xcck_d          DYNAMIC ARRAY OF type_g_xcck_d
DEFINE g_xcck_d_t        type_g_xcck_d
 
      
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
   #自定義模組變數-客製(Module Variable)
TYPE type_g_xcck2_d RECORD
       xcck028 LIKE xcck_t.xcck028, 
       rtaxl003 LIKE type_t.chr500, 
       xcck202 LIKE xcck_t.xcck202
       END RECORD

 TYPE type_g_xcck3_d RECORD
       xcck013 LIKE xcck_t.xcck013, 
       xcck006   LIKE xcck_t.xcck006, 
       xcck202       LIKE xcck_t.xcck202
       END RECORD


DEFINE g_sql2           STRING
DEFINE g_sql3           STRING
DEFINE g_acc            LIKE gzcb_t.gzcb007
DEFINE l_sdate          LIKE xcck_t.xcck013
DEFINE l_edate          LIKE xcck_t.xcck013
DEFINE xcck001          LIKE xcck_t.xcck001
DEFINE xcck003          LIKE xcck_t.xcck003
DEFINE xcckld           LIKE xcck_t.xcckld
DEFINE xcckcomp         LIKE xcck_t.xcckcomp
DEFINE xccksite         LIKE xcck_t.xccksite

DEFINE g_detail_cnt3         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_cnt2                LIKE type_t.num10   
DEFINE g_cnt3                LIKE type_t.num10


DEFINE g_xcck2_d   DYNAMIC ARRAY OF type_g_xcck2_d
DEFINE g_xcck2_d_t type_g_xcck2_d 
DEFINE g_xcck3_d   DYNAMIC ARRAY OF type_g_xcck3_d
DEFINE g_xcck3_d_t type_g_xcck3_d

#add by chenhz 15/12/04(s) 增加保留上次查询条件功能   
 TYPE type_g_tm RECORD   #添加一个数组，用于保存上一次查询的条件

    xcckcomp     STRING,
    xcckld       STRING,
    xccksite     STRING,
    xcck006      STRING,
    xcck002      STRING,
    xcck010      STRING,
    xcck001      STRING,
    xcck003      STRING,
    xcck028      STRING,
    xcck012      STRING, #add by 160101
    l_sdate      LIKE  type_t.dat,
    l_edate      LIKE  type_t.dat 

END RECORD

DEFINE g_tm             type_g_tm 
#end add-point
 
{</section>}
 
{<section id="axcq912.main" >}
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
   #160802-00020#9-s-add
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #160802-00020#9-e-add
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
   DECLARE axcq912_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq912_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq912_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq912 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq912_init()   
 
      #進入選單 Menu (="N")
      CALL axcq912_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq912
      
   END IF 
   
   CLOSE axcq912_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq912.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axcq912_init()
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
   CALL cl_set_combo_scc('xcck001','8914')
   INITIALIZE g_tm.* TO NULL    #add by chenhz 15/12/04 对单头条件整个数组的值初始化   
   #end add-point
 
   CALL axcq912_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axcq912.default_search" >}
PRIVATE FUNCTION axcq912_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xcckld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xcck001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xcck002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xcck003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xcck004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xcck005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " xcck006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " xcck007 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " xcck008 = '", g_argv[09], "' AND "
   END IF
   IF NOT cl_null(g_argv[10]) THEN
      LET g_wc = g_wc, " xcck009 = '", g_argv[10], "' AND "
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
 
{<section id="axcq912.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axcq912_ui_dialog()
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
      CALL axcq912_b_fill()
   ELSE
      CALL axcq912_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xcck_d.clear()
 
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
 
         CALL axcq912_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xcck_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axcq912_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL axcq912_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
          DISPLAY g_detail_cnt TO h_count
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
   DISPLAY ARRAY g_xcck2_d TO s_detail2.* ATTRIBUTES(COUNT=g_detail_cnt2)
            BEFORE DISPLAY
                             
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY l_ac TO FORMONLY.h_index
               DISPLAY g_xcck2_d.getLength() TO FORMONLY.h_count
               DISPLAY ' ' TO FORMONLY.p_start
               DISPLAY ' ' TO FORMONLY.p_end   
         END DISPLAY 

         DISPLAY ARRAY g_xcck3_d TO s_detail3.* ATTRIBUTES(COUNT=g_detail_cnt3)
            BEFORE DISPLAY
                             
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               DISPLAY l_ac TO FORMONLY.h_index
               DISPLAY g_xcck3_d.getLength() TO FORMONLY.h_count
               DISPLAY ' ' TO FORMONLY.p_start
               DISPLAY ' ' TO FORMONLY.p_end   
         END DISPLAY 
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axcq912_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axcq912_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
         # CALL cxcq912_g01(g_wc,l_sdate,l_edate)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
         # CALL cxcq912_g01(g_wc,l_sdate,l_edate)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq912_query()
               #add-point:ON ACTION query name="menu.query"
               CALL axcq912_query2()
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
            CALL axcq912_filter()
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
            CALL axcq912_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xcck_d)
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
            CALL axcq912_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axcq912_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axcq912_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axcq912_b_fill()
 
         
         
 
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
 
{<section id="axcq912.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq912_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
    RETURN
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xcck_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON xccksite,xcck002,xcck006,xcck007,xcck008,xcck009,xcck010,xcck013,xcck028, 
          imag011,xmdk004,xcck015,xcck017,xcck044,xcck201,xcck282,xcck202
           FROM s_detail1[1].b_xccksite,s_detail1[1].b_xcck002,s_detail1[1].b_xcck006,s_detail1[1].b_xcck007, 
               s_detail1[1].b_xcck008,s_detail1[1].b_xcck009,s_detail1[1].b_xcck010,s_detail1[1].b_xcck013, 
               s_detail1[1].b_xcck028,s_detail1[1].b_imag011,s_detail1[1].b_xmdk004,s_detail1[1].b_xcck015, 
               s_detail1[1].b_xcck017,s_detail1[1].b_xcck044,s_detail1[1].b_xcck201,s_detail1[1].b_xcck282, 
               s_detail1[1].b_xcck202
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_xccksite>>----
         #Ctrlp:construct.c.page1.b_xccksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccksite
            #add-point:ON ACTION controlp INFIELD b_xccksite name="construct.c.page1.b_xccksite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗   #161019-00017#9 marked
            CALL q_ooef001_24()                         #呼叫開窗   #161019-00017#9 add
            DISPLAY g_qryparam.return1 TO b_xccksite  #顯示到畫面上
            NEXT FIELD b_xccksite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xccksite
            #add-point:BEFORE FIELD b_xccksite name="construct.b.page1.b_xccksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xccksite
            
            #add-point:AFTER FIELD b_xccksite name="construct.a.page1.b_xccksite"
            
            #END add-point
            
 
 
         #----<<b_xccksite_desc>>----
         #----<<b_xcck002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck002
            #add-point:BEFORE FIELD b_xcck002 name="construct.b.page1.b_xcck002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck002
            
            #add-point:AFTER FIELD b_xcck002 name="construct.a.page1.b_xcck002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck002
            #add-point:ON ACTION controlp INFIELD b_xcck002 name="construct.c.page1.b_xcck002"
            
            #END add-point
 
 
         #----<<b_xcck002_desc>>----
         #----<<b_xcck006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck006
            #add-point:BEFORE FIELD b_xcck006 name="construct.b.page1.b_xcck006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck006
            
            #add-point:AFTER FIELD b_xcck006 name="construct.a.page1.b_xcck006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck006
            #add-point:ON ACTION controlp INFIELD b_xcck006 name="construct.c.page1.b_xcck006"
            
            #END add-point
 
 
         #----<<b_xcck007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck007
            #add-point:BEFORE FIELD b_xcck007 name="construct.b.page1.b_xcck007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck007
            
            #add-point:AFTER FIELD b_xcck007 name="construct.a.page1.b_xcck007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck007
            #add-point:ON ACTION controlp INFIELD b_xcck007 name="construct.c.page1.b_xcck007"
            
            #END add-point
 
 
         #----<<b_xcck008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck008
            #add-point:BEFORE FIELD b_xcck008 name="construct.b.page1.b_xcck008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck008
            
            #add-point:AFTER FIELD b_xcck008 name="construct.a.page1.b_xcck008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck008
            #add-point:ON ACTION controlp INFIELD b_xcck008 name="construct.c.page1.b_xcck008"
            
            #END add-point
 
 
         #----<<b_xcck009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck009
            #add-point:BEFORE FIELD b_xcck009 name="construct.b.page1.b_xcck009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck009
            
            #add-point:AFTER FIELD b_xcck009 name="construct.a.page1.b_xcck009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck009
            #add-point:ON ACTION controlp INFIELD b_xcck009 name="construct.c.page1.b_xcck009"
            
            #END add-point
 
 
         #----<<b_xcck010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck010
            #add-point:BEFORE FIELD b_xcck010 name="construct.b.page1.b_xcck010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck010
            
            #add-point:AFTER FIELD b_xcck010 name="construct.a.page1.b_xcck010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck010
            #add-point:ON ACTION controlp INFIELD b_xcck010 name="construct.c.page1.b_xcck010"
            
            #END add-point
 
 
         #----<<b_xcck010_desc>>----
         #----<<b_xcck010_desc_1>>----
         #----<<b_xcck013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck013
            #add-point:BEFORE FIELD b_xcck013 name="construct.b.page1.b_xcck013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck013
            
            #add-point:AFTER FIELD b_xcck013 name="construct.a.page1.b_xcck013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck013
            #add-point:ON ACTION controlp INFIELD b_xcck013 name="construct.c.page1.b_xcck013"
            
            #END add-point
 
 
         #----<<l_rtiadocdt>>----
         #----<<b_xcck028>>----
         #Ctrlp:construct.c.page1.b_xcck028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck028
            #add-point:ON ACTION controlp INFIELD b_xcck028 name="construct.c.page1.b_xcck028"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck028  #顯示到畫面上
            NEXT FIELD b_xcck028                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck028
            #add-point:BEFORE FIELD b_xcck028 name="construct.b.page1.b_xcck028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck028
            
            #add-point:AFTER FIELD b_xcck028 name="construct.a.page1.b_xcck028"
            
            #END add-point
            
 
 
         #----<<b_xcck028_desc>>----
         #----<<b_imag011>>----
         #Ctrlp:construct.c.page1.b_imag011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imag011
            #add-point:ON ACTION controlp INFIELD b_imag011 name="construct.c.page1.b_imag011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imag011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imag011  #顯示到畫面上
            NEXT FIELD b_imag011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imag011
            #add-point:BEFORE FIELD b_imag011 name="construct.b.page1.b_imag011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imag011
            
            #add-point:AFTER FIELD b_imag011 name="construct.a.page1.b_imag011"
            
            #END add-point
            
 
 
         #----<<b_imag011_desc>>----
         #----<<b_xmdk004>>----
         #Ctrlp:construct.c.page1.b_xmdk004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk004
            #add-point:ON ACTION controlp INFIELD b_xmdk004 name="construct.c.page1.b_xmdk004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk004  #顯示到畫面上
            NEXT FIELD b_xmdk004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xmdk004
            #add-point:BEFORE FIELD b_xmdk004 name="construct.b.page1.b_xmdk004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xmdk004
            
            #add-point:AFTER FIELD b_xmdk004 name="construct.a.page1.b_xmdk004"
            
            #END add-point
            
 
 
         #----<<b_xmdk004_desc>>----
         #----<<b_xcck015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck015
            #add-point:BEFORE FIELD b_xcck015 name="construct.b.page1.b_xcck015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck015
            
            #add-point:AFTER FIELD b_xcck015 name="construct.a.page1.b_xcck015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck015
            #add-point:ON ACTION controlp INFIELD b_xcck015 name="construct.c.page1.b_xcck015"
            
            #END add-point
 
 
         #----<<b_xcck015_desc>>----
         #----<<b_xcck017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck017
            #add-point:BEFORE FIELD b_xcck017 name="construct.b.page1.b_xcck017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck017
            
            #add-point:AFTER FIELD b_xcck017 name="construct.a.page1.b_xcck017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck017
            #add-point:ON ACTION controlp INFIELD b_xcck017 name="construct.c.page1.b_xcck017"
            
            #END add-point
 
 
         #----<<b_xcck044>>----
         #Ctrlp:construct.c.page1.b_xcck044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck044
            #add-point:ON ACTION controlp INFIELD b_xcck044 name="construct.c.page1.b_xcck044"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck044  #顯示到畫面上
            NEXT FIELD b_xcck044                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck044
            #add-point:BEFORE FIELD b_xcck044 name="construct.b.page1.b_xcck044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck044
            
            #add-point:AFTER FIELD b_xcck044 name="construct.a.page1.b_xcck044"
            
            #END add-point
            
 
 
         #----<<b_xcck044_desc>>----
         #----<<b_xcck201>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck201
            #add-point:BEFORE FIELD b_xcck201 name="construct.b.page1.b_xcck201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck201
            
            #add-point:AFTER FIELD b_xcck201 name="construct.a.page1.b_xcck201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck201
            #add-point:ON ACTION controlp INFIELD b_xcck201 name="construct.c.page1.b_xcck201"
            
            #END add-point
 
 
         #----<<b_xcck282>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck282
            #add-point:BEFORE FIELD b_xcck282 name="construct.b.page1.b_xcck282"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck282
            
            #add-point:AFTER FIELD b_xcck282 name="construct.a.page1.b_xcck282"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck282
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282
            #add-point:ON ACTION controlp INFIELD b_xcck282 name="construct.c.page1.b_xcck282"
            
            #END add-point
 
 
         #----<<b_xcck202>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck202
            #add-point:BEFORE FIELD b_xcck202 name="construct.b.page1.b_xcck202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck202
            
            #add-point:AFTER FIELD b_xcck202 name="construct.a.page1.b_xcck202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202
            #add-point:ON ACTION controlp INFIELD b_xcck202 name="construct.c.page1.b_xcck202"
            
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
   CALL axcq912_b_fill()
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
 
{<section id="axcq912.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq912_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
    CALL axcq912_create_temp_table()   #创建临时表
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
 
   LET ls_sql_rank = "SELECT  UNIQUE xccksite,'',xcck002,'',xcck006,xcck007,xcck008,xcck009,xcck010, 
       '','',xcck013,'',xcck028,'','','','','',xcck015,'',xcck017,xcck044,'',xcck201,xcck282,xcck202  , 
       DENSE_RANK() OVER( ORDER BY xcck_t.xcckld,xcck_t.xcck001,xcck_t.xcck002,xcck_t.xcck003,xcck_t.xcck004, 
       xcck_t.xcck005,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009) AS RANK FROM xcck_t", 
 
 
 
                     "",
                     " WHERE xcckent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xcck_t"),
                     " ORDER BY xcck_t.xcckld,xcck_t.xcck001,xcck_t.xcck002,xcck_t.xcck003,xcck_t.xcck004,xcck_t.xcck005,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   LET ls_sql_rank = "SELECT  UNIQUE xcckent,xccksite,t1.ooefl003,xcck002,t2.ooefl003,xcck006,xcck007,xcck008,xcck009,xcck010,
                      t3.imaal003,t3.imaal004,xcck013,t4.rtiadocdt,xcck028,t5.rtaxl003,t6.imag011,t7.oocql004,t8.xmdk004,t9.ooefl003,
                      xcck015,t10.inayl003,xcck017,xcck044,t11.oocal003,xcck201*xcck009,xcck282,xcck202*xcck009 ",
                      " FROM xcck_t",
                    " LEFT JOIN ooefl_t t1 ON t1.ooefl001 = xccksite AND t1.ooeflent = xcckent AND t1.ooefl002 = '",g_dlang,"'",
                    " LEFT JOIN ooefl_t t2 ON t2.ooefl001 = xcck002  AND t2.ooeflent = xcckent AND t2.ooefl002 = '",g_dlang,"'",
                    " LEFT JOIN imaal_t t3 ON t3.imaal001 = xcck010  AND t3.imaalent = xcckent AND t3.imaal002 = '",g_dlang,"'",
                    " LEFT JOIN rtia_t  t4 ON t4.rtiadocno = xcck006 AND t4.rtiaent = xcckent ",
                    " LEFT JOIN rtaxl_t t5 ON t5.rtaxl001 = xcck028  AND t5.rtaxlent = xcckent AND t5.rtaxl002 = '",g_dlang,"'",
                    " LEFT JOIN imag_t  t6 ON t6.imagsite = xcckcomp AND t6.imag001 =  xcck010 AND t6.imagent = xcckent ",
                    " LEFT JOIN oocql_t t7 ON t7.oocql001 = '206'    AND t7.oocql002 = imag011 AND t7.oocqlent = imagent AND t7.oocql003 = '",g_dlang,"'", 
                    " LEFT JOIN xmdk_t  t8  ON t8.xmdkdocno = xcck006 AND t8.xmdkent = xcckent ",
                    " LEFT JOIN ooefl_t t9 ON t9.ooefl001 = t8.xmdk004 AND t9.ooeflent = t8.xmdkent AND t9.ooefl002 = '",g_dlang,"'",
                    " LEFT JOIN inayl_t t10 ON t10.inayl001 = xcck015  AND t10.inaylent = xcckent AND t10.inayl002 = '",g_dlang,"'",
                    " LEFT JOIN oocal_t t11 ON t11.oocal001 = xcck044  AND t11.oocalent = xcckent AND t11.oocal002 = '",g_dlang,"'",
                     
                     "",
                     " WHERE xcckent= ",g_enterprise," AND 1=1 ",
                     "   AND xcck013 BETWEEN to_date('",l_sdate,"','yy/mm/dd') AND to_date('",l_edate,"','yy/mm/dd')  ", 
                     "   AND  xcck055 IN ('303','305','307','215') ",          
                     "   AND ", ls_wc

   #160802-00020#9-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET ls_sql_rank = ls_sql_rank , " AND xcckld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET ls_sql_rank = ls_sql_rank," AND xcckcomp IN ",g_wc_cs_comp
   END IF  
   #160802-00020#9-e-add

   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xcck_t"),
                     " ORDER BY xccksite,xcck002,xcck013,xcck006,xcck007,xcck008,xcck009 "
                     
                     
   LET ls_sql_rank = " INSERT INTO axcq912_tmp ",ls_sql_rank
   
   EXECUTE IMMEDIATE ls_sql_rank  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ERROR:" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()

   END IF 
                     
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
 
   LET g_sql = "SELECT xccksite,'',xcck002,'',xcck006,xcck007,xcck008,xcck009,xcck010,'','',xcck013, 
       '',xcck028,'','','','','',xcck015,'',xcck017,xcck044,'',xcck201,xcck282,xcck202",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
        LET g_sql = "SELECT xccksite,ooefl0031,xcck002,ooefl0032,xcck006,xcck007,xcck008,xcck009,xcck010,
                      imaal003,imaal004,xcck013,rtiadocdt,xcck028,rtaxl003,imag011,oocql004,xmdk004,ooefl0033,
                      xcck015,inayl003,xcck017,xcck044,oocal003,xcck201,xcck282,xcck202 ",
               " FROM axcq912_tmp",
               " WHERE xcckent = ? "
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq912_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axcq912_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xcck_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xccksite_desc,g_xcck_d[l_ac].xcck002, 
       g_xcck_d[l_ac].xcck002_desc,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008, 
       g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck010_desc,g_xcck_d[l_ac].xcck010_desc_1, 
       g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].l_rtiadocdt,g_xcck_d[l_ac].xcck028,g_xcck_d[l_ac].xcck028_desc, 
       g_xcck_d[l_ac].imag011,g_xcck_d[l_ac].imag011_desc,g_xcck_d[l_ac].xmdk004,g_xcck_d[l_ac].xmdk004_desc, 
       g_xcck_d[l_ac].xcck015,g_xcck_d[l_ac].xcck015_desc,g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck044, 
       g_xcck_d[l_ac].xcck044_desc,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck282,g_xcck_d[l_ac].xcck202 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_xcck_d[l_ac].statepic = cl_get_actipic(g_xcck_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL axcq912_detail_show("'1'")      
 
      CALL axcq912_xcck_t_mask()
 
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
   
 
   
   CALL g_xcck_d.deleteElement(g_xcck_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_xcck_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axcq912_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq912_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq912_detail_action_trans()
 
   IF g_xcck_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL axcq912_fetch()
   END IF
   
      CALL axcq912_filter_show('xccksite','b_xccksite')
   CALL axcq912_filter_show('xcck002','b_xcck002')
   CALL axcq912_filter_show('xcck006','b_xcck006')
   CALL axcq912_filter_show('xcck007','b_xcck007')
   CALL axcq912_filter_show('xcck008','b_xcck008')
   CALL axcq912_filter_show('xcck009','b_xcck009')
   CALL axcq912_filter_show('xcck010','b_xcck010')
   CALL axcq912_filter_show('xcck013','b_xcck013')
   CALL axcq912_filter_show('xcck028','b_xcck028')
   CALL axcq912_filter_show('imag011','b_imag011')
   CALL axcq912_filter_show('xmdk004','b_xmdk004')
   CALL axcq912_filter_show('xcck015','b_xcck015')
   CALL axcq912_filter_show('xcck017','b_xcck017')
   CALL axcq912_filter_show('xcck044','b_xcck044')
   CALL axcq912_filter_show('xcck201','b_xcck201')
   CALL axcq912_filter_show('xcck282','b_xcck282')
   CALL axcq912_filter_show('xcck202','b_xcck202')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
     CALL axcq912_b2_fill()
   CALL axcq912_b3_fill()
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq912.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq912_fetch()
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
 
{<section id="axcq912.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq912_detail_show(ps_page)
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
 
{<section id="axcq912.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axcq912_filter()
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
      CONSTRUCT g_wc_filter ON xccksite,xcck002,xcck006,xcck007,xcck008,xcck009,xcck010,xcck013,xcck028, 
          imag011,xmdk004,xcck015,xcck017,xcck044,xcck201,xcck282,xcck202
                          FROM s_detail1[1].b_xccksite,s_detail1[1].b_xcck002,s_detail1[1].b_xcck006, 
                              s_detail1[1].b_xcck007,s_detail1[1].b_xcck008,s_detail1[1].b_xcck009,s_detail1[1].b_xcck010, 
                              s_detail1[1].b_xcck013,s_detail1[1].b_xcck028,s_detail1[1].b_imag011,s_detail1[1].b_xmdk004, 
                              s_detail1[1].b_xcck015,s_detail1[1].b_xcck017,s_detail1[1].b_xcck044,s_detail1[1].b_xcck201, 
                              s_detail1[1].b_xcck282,s_detail1[1].b_xcck202
 
         BEFORE CONSTRUCT
                     DISPLAY axcq912_filter_parser('xccksite') TO s_detail1[1].b_xccksite
            DISPLAY axcq912_filter_parser('xcck002') TO s_detail1[1].b_xcck002
            DISPLAY axcq912_filter_parser('xcck006') TO s_detail1[1].b_xcck006
            DISPLAY axcq912_filter_parser('xcck007') TO s_detail1[1].b_xcck007
            DISPLAY axcq912_filter_parser('xcck008') TO s_detail1[1].b_xcck008
            DISPLAY axcq912_filter_parser('xcck009') TO s_detail1[1].b_xcck009
            DISPLAY axcq912_filter_parser('xcck010') TO s_detail1[1].b_xcck010
            DISPLAY axcq912_filter_parser('xcck013') TO s_detail1[1].b_xcck013
            DISPLAY axcq912_filter_parser('xcck028') TO s_detail1[1].b_xcck028
            DISPLAY axcq912_filter_parser('imag011') TO s_detail1[1].b_imag011
            DISPLAY axcq912_filter_parser('xmdk004') TO s_detail1[1].b_xmdk004
            DISPLAY axcq912_filter_parser('xcck015') TO s_detail1[1].b_xcck015
            DISPLAY axcq912_filter_parser('xcck017') TO s_detail1[1].b_xcck017
            DISPLAY axcq912_filter_parser('xcck044') TO s_detail1[1].b_xcck044
            DISPLAY axcq912_filter_parser('xcck201') TO s_detail1[1].b_xcck201
            DISPLAY axcq912_filter_parser('xcck282') TO s_detail1[1].b_xcck282
            DISPLAY axcq912_filter_parser('xcck202') TO s_detail1[1].b_xcck202
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_xccksite>>----
         #Ctrlp:construct.c.page1.b_xccksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccksite
            #add-point:ON ACTION controlp INFIELD b_xccksite name="construct.c.filter.page1.b_xccksite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                             #呼叫開窗   #161019-00017#9 marked
            CALL q_ooef001_24()                           #呼叫開窗   #161019-00017#9 add
            DISPLAY g_qryparam.return1 TO b_xccksite  #顯示到畫面上
            NEXT FIELD b_xccksite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xccksite_desc>>----
         #----<<b_xcck002>>----
         #Ctrlp:construct.c.filter.page1.b_xcck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck002
            #add-point:ON ACTION controlp INFIELD b_xcck002 name="construct.c.filter.page1.b_xcck002"
            
            #END add-point
 
 
         #----<<b_xcck002_desc>>----
         #----<<b_xcck006>>----
         #Ctrlp:construct.c.filter.page1.b_xcck006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck006
            #add-point:ON ACTION controlp INFIELD b_xcck006 name="construct.c.filter.page1.b_xcck006"
            
            #END add-point
 
 
         #----<<b_xcck007>>----
         #Ctrlp:construct.c.filter.page1.b_xcck007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck007
            #add-point:ON ACTION controlp INFIELD b_xcck007 name="construct.c.filter.page1.b_xcck007"
            
            #END add-point
 
 
         #----<<b_xcck008>>----
         #Ctrlp:construct.c.filter.page1.b_xcck008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck008
            #add-point:ON ACTION controlp INFIELD b_xcck008 name="construct.c.filter.page1.b_xcck008"
            
            #END add-point
 
 
         #----<<b_xcck009>>----
         #Ctrlp:construct.c.filter.page1.b_xcck009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck009
            #add-point:ON ACTION controlp INFIELD b_xcck009 name="construct.c.filter.page1.b_xcck009"
            
            #END add-point
 
 
         #----<<b_xcck010>>----
         #Ctrlp:construct.c.filter.page1.b_xcck010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck010
            #add-point:ON ACTION controlp INFIELD b_xcck010 name="construct.c.filter.page1.b_xcck010"
            
            #END add-point
 
 
         #----<<b_xcck010_desc>>----
         #----<<b_xcck010_desc_1>>----
         #----<<b_xcck013>>----
         #Ctrlp:construct.c.filter.page1.b_xcck013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck013
            #add-point:ON ACTION controlp INFIELD b_xcck013 name="construct.c.filter.page1.b_xcck013"
            
            #END add-point
 
 
         #----<<l_rtiadocdt>>----
         #----<<b_xcck028>>----
         #Ctrlp:construct.c.page1.b_xcck028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck028
            #add-point:ON ACTION controlp INFIELD b_xcck028 name="construct.c.filter.page1.b_xcck028"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck028  #顯示到畫面上
            NEXT FIELD b_xcck028                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xcck028_desc>>----
         #----<<b_imag011>>----
         #Ctrlp:construct.c.page1.b_imag011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imag011
            #add-point:ON ACTION controlp INFIELD b_imag011 name="construct.c.filter.page1.b_imag011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imag011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imag011  #顯示到畫面上
            NEXT FIELD b_imag011                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imag011_desc>>----
         #----<<b_xmdk004>>----
         #Ctrlp:construct.c.page1.b_xmdk004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk004
            #add-point:ON ACTION controlp INFIELD b_xmdk004 name="construct.c.filter.page1.b_xmdk004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk004  #顯示到畫面上
            NEXT FIELD b_xmdk004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdk004_desc>>----
         #----<<b_xcck015>>----
         #Ctrlp:construct.c.filter.page1.b_xcck015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck015
            #add-point:ON ACTION controlp INFIELD b_xcck015 name="construct.c.filter.page1.b_xcck015"
            
            #END add-point
 
 
         #----<<b_xcck015_desc>>----
         #----<<b_xcck017>>----
         #Ctrlp:construct.c.filter.page1.b_xcck017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck017
            #add-point:ON ACTION controlp INFIELD b_xcck017 name="construct.c.filter.page1.b_xcck017"
            
            #END add-point
 
 
         #----<<b_xcck044>>----
         #Ctrlp:construct.c.page1.b_xcck044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck044
            #add-point:ON ACTION controlp INFIELD b_xcck044 name="construct.c.filter.page1.b_xcck044"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck044  #顯示到畫面上
            NEXT FIELD b_xcck044                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xcck044_desc>>----
         #----<<b_xcck201>>----
         #Ctrlp:construct.c.filter.page1.b_xcck201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck201
            #add-point:ON ACTION controlp INFIELD b_xcck201 name="construct.c.filter.page1.b_xcck201"
            
            #END add-point
 
 
         #----<<b_xcck282>>----
         #Ctrlp:construct.c.filter.page1.b_xcck282
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282
            #add-point:ON ACTION controlp INFIELD b_xcck282 name="construct.c.filter.page1.b_xcck282"
            
            #END add-point
 
 
         #----<<b_xcck202>>----
         #Ctrlp:construct.c.filter.page1.b_xcck202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202
            #add-point:ON ACTION controlp INFIELD b_xcck202 name="construct.c.filter.page1.b_xcck202"
            
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
   
      CALL axcq912_filter_show('xccksite','b_xccksite')
   CALL axcq912_filter_show('xcck002','b_xcck002')
   CALL axcq912_filter_show('xcck006','b_xcck006')
   CALL axcq912_filter_show('xcck007','b_xcck007')
   CALL axcq912_filter_show('xcck008','b_xcck008')
   CALL axcq912_filter_show('xcck009','b_xcck009')
   CALL axcq912_filter_show('xcck010','b_xcck010')
   CALL axcq912_filter_show('xcck013','b_xcck013')
   CALL axcq912_filter_show('xcck028','b_xcck028')
   CALL axcq912_filter_show('imag011','b_imag011')
   CALL axcq912_filter_show('xmdk004','b_xmdk004')
   CALL axcq912_filter_show('xcck015','b_xcck015')
   CALL axcq912_filter_show('xcck017','b_xcck017')
   CALL axcq912_filter_show('xcck044','b_xcck044')
   CALL axcq912_filter_show('xcck201','b_xcck201')
   CALL axcq912_filter_show('xcck282','b_xcck282')
   CALL axcq912_filter_show('xcck202','b_xcck202')
 
    
   CALL axcq912_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq912.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axcq912_filter_parser(ps_field)
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
 
{<section id="axcq912.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axcq912_filter_show(ps_field,ps_object)
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
   LET ls_condition = axcq912_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq912.insert" >}
#+ insert
PRIVATE FUNCTION axcq912_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axcq912.modify" >}
#+ modify
PRIVATE FUNCTION axcq912_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq912.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axcq912_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq912.delete" >}
#+ delete
PRIVATE FUNCTION axcq912_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq912.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axcq912_detail_action_trans()
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
 
{<section id="axcq912.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axcq912_detail_index_setting()
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
            IF g_xcck_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xcck_d.getLength() AND g_xcck_d.getLength() > 0
            LET g_detail_idx = g_xcck_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xcck_d.getLength() THEN
               LET g_detail_idx = g_xcck_d.getLength()
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
 
{<section id="axcq912.mask_functions" >}
 &include "erp/axc/axcq912_mask.4gl"
 
{</section>}
 
{<section id="axcq912.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axcq912_query2()
 DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準

   #end add-point 
   #add-point:query段define-客製

   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xcck_d.clear()
   
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
      CONSTRUCT g_wc_table ON xcckcomp,xcckld,xccksite,xcck006,xcck002,xcck010,xcck001,xcck003,xcck028,xcck012 #add by zhr 160101 xcck012
           FROM xcckcomp,xcckld,xccksite,xcck006,xcck002,xcck010,xcck001,xcck003,xcck028,xcck012  #add by zhr 160101 xcck012

                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       

         ON ACTION controlp INFIELD xccksite
            #add-point:ON ACTION controlp INFIELD b_xccksite
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                             #呼叫開窗   #161019-00017#9 marked
            CALL q_ooef001_24()                           #呼叫開窗   #161019-00017#9 add
            DISPLAY g_qryparam.return1 TO xccksite  #顯示到畫面上
            NEXT FIELD xccksite                     #返回原欄位
 
         ON ACTION controlp INFIELD xcckcomp
            #add-point:ON ACTION controlp INFIELD xcckcomp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#9-s
            IF cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef003 = 'Y'"
            ELSE
               LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_cs_comp
            END IF
            #160802-00020#9-e
#            CALL q_ooef001()                            #呼叫開窗   #161019-00017#9 marked
            CALL q_ooef001_2()                           #呼叫開窗   #161019-00017#9 add
            DISPLAY g_qryparam.return1 TO xcckcomp  #顯示到畫面上
            NEXT FIELD xcckcomp                     #返回原欄位
            
            
         ON ACTION controlp INFIELD xcckld
            #add-point:ON ACTION controlp INFIELD xcckld
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#9-s-add
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept             
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#9-e-add             
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcckld  #顯示到畫面上
            NEXT FIELD xcckld                     #返回原欄位

         ON ACTION controlp INFIELD xcck002
             #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccc002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck002  #顯示到畫面上
            NEXT FIELD xcck002                     #返回原欄位
            #END add-point
 
         ON ACTION controlp INFIELD xcck010
            #add-point:ON ACTION controlp INFIELD xcckld
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck010  #顯示到畫面上
            NEXT FIELD xcck010                     #返回原欄位
            
            
         ON ACTION controlp INFIELD xcck003
            #add-point:ON ACTION controlp INFIELD xcck003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck003  #顯示到畫面上
            NEXT FIELD xcck003                     #返回原欄位

 
         ON ACTION controlp INFIELD xcck028
            #add-point:ON ACTION controlp INFIELD b_xcck028
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	         LET g_qryparam.reqry = FALSE
	         LET g_qryparam.where = " rtax004 ='",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"   #获取单前层级
            CALL q_rtax001()                         
            DISPLAY g_qryparam.return1 TO xcck028
            
         ON ACTION controlp INFIELD xcck006
            #add-point:ON ACTION controlp INFIELD xcckld
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcck006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck006  #顯示到畫面上
            NEXT FIELD xcck006                     #返回原欄位
        #add by zhr 160101 -----str-------    
         ON ACTION controlp INFIELD xcck012  
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcck012()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck012  #顯示到畫面上
            NEXT FIELD xcck012                     #返回原欄位
        #add by zhr 160101 ------end -----

   #add by chenhz 15/12/04(s)  将当前栏位值赋予g_tm的值，用以保存   

    AFTER FIELD xcckcomp
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcckcomp
       
    AFTER FIELD xcckld
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcckld
       
    AFTER FIELD xccksite
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xccksite
       
    AFTER FIELD xcck006
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck006
       
    AFTER FIELD xcck002
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck002
       
    AFTER FIELD xcck010
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck010
       
    AFTER FIELD xcck001
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck001
       
    AFTER FIELD xcck003
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck003

    AFTER FIELD xcck028
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck028
    #add by zhr 160101 -----str-----
    AFTER FIELD xcck012
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck012
    #add by zhr 160101 -----end-----

 #add by chenhz 15/12/04(e)  
       
      END CONSTRUCT
      
      INPUT l_sdate,l_edate
         FROM l_sdate,l_edate
      END INPUT

     BEFORE DIALOG

         IF cl_null(g_tm.xccksite) THEN
            LET  g_tm.xccksite = g_site  
            DISPLAY g_tm.xccksite TO xccksite
         END IF
  #不需要默认值       
#         IF cl_null(g_tm.xcck003) THEN
#            LET  g_tm.xcck003 = 'COST01'
#            DISPLAY g_tm.xcck003 TO xcck003
#         END IF

         IF cl_null(g_tm.xcck001) THEN
            LET  g_tm.xcck001 = '1'
            DISPLAY g_tm.xcck001 TO xcck001
         END IF
             

         DISPLAY g_tm.xcckcomp TO  xcckcomp
         DISPLAY g_tm.xcckld   TO  xcckld
         DISPLAY g_tm.xccksite TO  xccksite
         DISPLAY g_tm.xcck006  TO  xcck006
         DISPLAY g_tm.xcck002  TO  xcck002
         DISPLAY g_tm.xcck010  TO  xcck010
         DISPLAY g_tm.xcck001  TO  xcck001
         DISPLAY g_tm.xcck003  TO  xcck003
         DISPLAY g_tm.xcck028  TO  xcck028
         DISPLAY g_tm.xcck012  TO  xcck012   #add by zhr 160101

         IF g_tm.l_sdate IS NULL THEN
            LET l_sdate =g_today
            DISPLAY l_sdate TO l_sdate       
         ELSE
            LET l_sdate = g_tm.l_sdate    
            DISPLAY l_sdate TO l_sdate
         END IF
        
         IF g_tm.l_edate IS NULL THEN
            LET l_edate =g_today
            DISPLAY l_edate TO l_edate       
         ELSE
            LET l_edate = g_tm.l_edate    
            DISPLAY l_edate TO l_edate
         END IF
        
         
         AFTER DIALOG
         
         LET g_tm.l_sdate = l_sdate
         LET g_tm.l_edate = l_edate 
            
      
 
  
      #add-point:query段more_construct

      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept

         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前

      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後

         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後

      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
      LET g_wc2 = ls_wc2
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct

   #end add-point
        
   LET g_error_show = 1
   CALL axcq912_b_fill()
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
PRIVATE FUNCTION axcq912_b2_fill()


     LET g_sql2 = "SELECT xcck028,rtaxl003,SUM(xcck202)",
                  "  FROM axcq912_tmp  ",
                  " WHERE xcckent = ? ",
                  " GROUP BY xcck028,rtaxl003 ",
                  " ORDER BY xcck028 "

   #end add-point
 
   LET g_sql2 = cl_sql_add_mask(g_sql2)              #遮蔽特定資料
   PREPARE axcq912_pb2 FROM g_sql2
   DECLARE b_fill_curs2 CURSOR FOR axcq912_pb2
   
   OPEN b_fill_curs2 USING g_enterprise
 
   CALL g_xcck2_d.clear()
 
   #add-point:陣列清空

   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs2 INTO g_xcck2_d[l_ac].xcck028,g_xcck2_d[l_ac].rtaxl003,g_xcck2_d[l_ac].xcck202
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_xcck_d[l_ac].statepic = cl_get_actipic(g_xcck_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充

      #end add-point
 
      CALL axcq912_detail_show("'1'")      
 
      CALL axcq912_xcck_t_mask()
 
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
   
  
   CALL g_xcck2_d.deleteElement(g_xcck2_d.getLength())   

   FREE axcq912_pb2
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
PRIVATE FUNCTION axcq912_b3_fill()

 LET g_sql3 =  "SELECT xcck013,xcck006,SUM(xcck202)",
               "  FROM axcq912_tmp ",
               " WHERE xcckent= ? " ,
               " GROUP BY xcck013,xcck006",                
               " ORDER BY xcck013,xcck006"

   #end add-point
 
   LET g_sql3 = cl_sql_add_mask(g_sql3)              #遮蔽特定資料
   PREPARE axcq912_pb3 FROM g_sql3
   DECLARE b_fill_curs3 CURSOR FOR axcq912_pb3
   
   OPEN b_fill_curs3 USING g_enterprise
 
   CALL g_xcck3_d.clear()
 
   #add-point:陣列清空

   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs3 INTO g_xcck3_d[l_ac].xcck013,g_xcck3_d[l_ac].xcck006,g_xcck3_d[l_ac].xcck202
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_xcck_d[l_ac].statepic = cl_get_actipic(g_xcck_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充

      #end add-point
 
      CALL axcq912_detail_show("'1'")      
 
      CALL axcq912_xcck_t_mask()
 
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
   
 
   
   CALL g_xcck3_d.deleteElement(g_xcck3_d.getLength())   

   FREE axcq912_pb3

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
PRIVATE FUNCTION axcq912_create_temp_table()
 DROP TABLE axcq912_tmp;
   CREATE TEMP TABLE axcq912_tmp(
    xcckent  LIKE xcck_t.xcckent,
    xccksite LIKE xcck_t.xccksite,
    ooefl0031 LIKE type_t.chr500,
    xcck002  LIKE xcck_t.xcck002,
    ooefl0032 LIKE type_t.chr500,
    xcck006  LIKE xcck_t.xcck006,
    xcck007  LIKE xcck_t.xcck007,
    xcck008  LIKE xcck_t.xcck008,
    xcck009  LIKE xcck_t.xcck009,
    xcck010  LIKE xcck_t.xcck010,
    imaal003 LIKE type_t.chr500,
    imaal004 LIKE type_t.chr500,
    xcck013  LIKE xcck_t.xcck013,
    rtiadocdt LIKE rtia_t.rtiadocdt,
    xcck028  LIKE xcck_t.xcck028,
    rtaxl003 LIKE type_t.chr500,
    imag011  LIKE imag_t.imag011,
    oocql004 LIKE type_t.chr500, 
    xmdk004  LIKE xmdk_t.xmdk004,
    ooefl0033 LIKE type_t.chr500,
    xcck015  LIKE xcck_t.xcck015,
    inayl003 LIKE type_t.chr500,
    xcck017  LIKE xcck_t.xcck017,
    xcck044  LIKE xcck_t.xcck044,
    oocal003 LIKE type_t.chr500,
    xcck201  LIKE xcck_t.xcck201,
    xcck282  LIKE xcck_t.xcck282,
    xcck202  LIKE xcck_t.xcck202
                      )
END FUNCTION

 
{</section>}
 
