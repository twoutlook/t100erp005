#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq516.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:9(2014-09-09 10:27:57), PR版次:0009(2017-02-16 10:59:33)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000099
#+ Filename...: axcq516
#+ Description: 結存調整成本查詢作業
#+ Creator....: 00768(2014-09-05 18:01:17)
#+ Modifier...: 00768 -SD/PR- 08532
 
{</section>}
 
{<section id="axcq516.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160113-00011#2  By 02040     調整參數接收
#160520-00002#2  By 01531     效能优化
#160802-00020#4   2016/08/04  By dorislai    增加帳套權限管控
#160802-00020#10  2016/08/11  By dorislai    增加法人權限管控
#170216-00012#1   2017/02/16  By lvjuan      xcccopm ---> xccccomp
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
       
       xccc002 LIKE xccc_t.xccc002, 
   xccc002_desc LIKE type_t.chr500, 
   xccc006 LIKE xccc_t.xccc006, 
   xccc006_desc LIKE type_t.chr500, 
   xccc006_desc_desc LIKE type_t.chr500, 
   xccc007 LIKE xccc_t.xccc007, 
   xccc008 LIKE xccc_t.xccc008, 
   xccc903a LIKE xccc_t.xccc903a, 
   xccc903b LIKE xccc_t.xccc903b, 
   xccc903c LIKE xccc_t.xccc903c, 
   xccc903d LIKE xccc_t.xccc903d, 
   xccc903e LIKE xccc_t.xccc903e, 
   xccc903f LIKE xccc_t.xccc903f, 
   xccc903g LIKE xccc_t.xccc903g, 
   xccc903h LIKE xccc_t.xccc903h, 
   xccc903 LIKE xccc_t.xccc903 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_tm RECORD
                     xccccomp   LIKE xccc_t.xccccomp,  #法人組織
                     xccccomp_desc LIKE type_t.chr80,
                     xcccld     LIKE xccc_t.xcccld  ,  #帳別編號
                     xcccld_desc   LIKE type_t.chr80,
                     xccc004    LIKE xccc_t.xccc004 ,  #年度
                     xccc005    LIKE xccc_t.xccc005 ,  #期別
                     xccc001    LIKE xccc_t.xccc001 ,  #本位币顺序
                     xccc001_desc  LIKE type_t.chr80,  #本位币说明
                     xccc003    LIKE xccc_t.xccc003 ,  #成本計算類型
                     xccc003_desc  LIKE type_t.chr80   
                     END RECORD
DEFINE tm            type_tm
DEFINE g_fetch       LIKE type_t.chr1

DEFINE g_page_cnt        LIKE type_t.num5   #總页數
DEFINE g_page_idx        LIKE type_t.num5   #当页笔数
#DEFINE g_detail_idx         LIKE type_t.num5   #当行
#DEFINE g_detail_cnt         LIKE type_t.num5   #总行

DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_para_data        LIKE type_t.chr80     #采用成本域否   #fengmy 150109
DEFINE g_para_data1       LIKE type_t.chr80     #采用特性否     #fengmy 150109
#dujuan150324  str
 TYPE type_g_glfb_e RECORD
       v          STRING
       END RECORD
DEFINE g_param                     type_g_glfb_e  
#dujuan150324  end
DEFINE g_wc_cs_ld            STRING                #160802-00020#4-add
DEFINE g_wc_cs_comp          STRING                #160802-00020#10-add
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
 
{<section id="axcq516.main" >}
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
   #160802-00020#4-add-(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   #160802-00020#4-add-(E)
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  #160802-00020#10-add
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
   DECLARE axcq516_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq516_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq516_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq516 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq516_init()   
 
      #進入選單 Menu (="N")
      CALL axcq516_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq516
      
   END IF 
   
   CLOSE axcq516_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq516.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axcq516_init()
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
#160520-00002#2 mark--s---
#   axcq516_default()中已有预设，不需重复处理
#   #fengmy 150109----begin
#   #根據參數顯示隱藏成本域 和 料件特性
#   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否            
#   IF g_para_data = 'Y' THEN
#      CALL cl_set_comp_visible('b_xccc002,b_xccc002_desc',TRUE)                    
#   ELSE
#      CALL cl_set_comp_visible('b_xccc002,b_xccc002_desc',FALSE)                
#   END IF 
#   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否            
#   IF g_para_data1 = 'Y' THEN
#      CALL cl_set_comp_visible('b_xccc007',TRUE)                    
#   ELSE
#      CALL cl_set_comp_visible('b_xccc007',FALSE)                
#   END IF
#   #fengmy 150109----end  
#160520-00002#2 mark--e---
   #end add-point
 
   CALL axcq516_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axcq516.default_search" >}
PRIVATE FUNCTION axcq516_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
 
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   #160113-00011#2--add--(s)
   IF NOT cl_null(g_argv[10]) THEN
      LET g_wc = g_wc , " xccccomp = '", g_argv[10], "' AND "
   END IF
   #160113-00011#2--add--(e)
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
 
{<section id="axcq516.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axcq516_ui_dialog()
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
      CALL axcq516_b_fill()
   ELSE
      CALL axcq516_query()
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
 
         CALL axcq516_init()
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
               CALL axcq516_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL axcq516_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               DISPLAY g_master_idx TO FORMONLY.idx  #显示当前第几行
               #頁數不對重新刷新
               DISPLAY g_page_idx TO FORMONLY.h_index  #當前頁
               DISPLAY g_page_cnt TO FORMONLY.h_count  #總頁數
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
            CALL axcq516_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_navigator_setting(g_page_idx, g_page_cnt)  #設定ToolBar上瀏覽上下筆資料的按鈕狀態
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
                #20150325 By dujuan    add
                  #創建臨時表
                  CALL axcq516_create_temp_table()
                  #為臨時表加數據
                  CALL axcq516_get_date()
                  LET g_param.v = "axcq516_tmp"
                  CALL axcq516_x01(" 1=1",g_param.v)   
               #20150325 By dujuan    end  
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
                #20150325 By dujuan    add
                  #創建臨時表
                  CALL axcq516_create_temp_table()
                  #為臨時表加數據
                  CALL axcq516_get_date()
                  LET g_param.v = "axcq516_tmp"
                  CALL axcq516_x01(" 1=1",g_param.v)   
               #20150325 By dujuan    end  
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq516_query()
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
            CALL axcq516_filter()
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
            CALL axcq516_b_fill()
 
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
            CALL axcq516_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axcq516_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axcq516_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axcq516_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION first
            LET g_fetch = 'F'
            CALL axcq516_fetch()

         ON ACTION previous
            LET g_fetch = 'P'
            CALL axcq516_fetch()

         ON ACTION jump
            LET g_fetch = '/'
            CALL axcq516_fetch()

         ON ACTION next
            LET g_fetch = 'N'
            CALL axcq516_fetch()

         ON ACTION last
            LET g_fetch = 'L'
            CALL axcq516_fetch()
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
 
{<section id="axcq516.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq516_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   CALL axcq516_query2()
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
      CONSTRUCT g_wc_table ON xccc002,xccc006,xccc007,xccc008,xccc903a,xccc903b,xccc903c,xccc903d,xccc903e, 
          xccc903f,xccc903g,xccc903h,xccc903
           FROM s_detail1[1].b_xccc002,s_detail1[1].b_xccc006,s_detail1[1].b_xccc007,s_detail1[1].b_xccc008, 
               s_detail1[1].b_xccc903a,s_detail1[1].b_xccc903b,s_detail1[1].b_xccc903c,s_detail1[1].b_xccc903d, 
               s_detail1[1].b_xccc903e,s_detail1[1].b_xccc903f,s_detail1[1].b_xccc903g,s_detail1[1].b_xccc903h, 
               s_detail1[1].b_xccc903
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_xccc002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xccc002
            #add-point:BEFORE FIELD b_xccc002 name="construct.b.page1.b_xccc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xccc002
            
            #add-point:AFTER FIELD b_xccc002 name="construct.a.page1.b_xccc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xccc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc002
            #add-point:ON ACTION controlp INFIELD b_xccc002 name="construct.c.page1.b_xccc002"
            
            #END add-point
 
 
         #----<<b_xccc002_desc>>----
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
 
 
         #----<<b_xccc006_desc>>----
         #----<<b_xccc006_desc_desc>>----
         #----<<b_xccc007>>----
         #Ctrlp:construct.c.page1.b_xccc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc007
            #add-point:ON ACTION controlp INFIELD b_xccc007 name="construct.c.page1.b_xccc007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccc007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xccc007  #顯示到畫面上
            NEXT FIELD b_xccc007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xccc007
            #add-point:BEFORE FIELD b_xccc007 name="construct.b.page1.b_xccc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xccc007
            
            #add-point:AFTER FIELD b_xccc007 name="construct.a.page1.b_xccc007"
            
            #END add-point
            
 
 
         #----<<b_xccc008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xccc008
            #add-point:BEFORE FIELD b_xccc008 name="construct.b.page1.b_xccc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xccc008
            
            #add-point:AFTER FIELD b_xccc008 name="construct.a.page1.b_xccc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xccc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc008
            #add-point:ON ACTION controlp INFIELD b_xccc008 name="construct.c.page1.b_xccc008"
            
            #END add-point
 
 
         #----<<b_xccc903a>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xccc903a
            #add-point:BEFORE FIELD b_xccc903a name="construct.b.page1.b_xccc903a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xccc903a
            
            #add-point:AFTER FIELD b_xccc903a name="construct.a.page1.b_xccc903a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xccc903a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903a
            #add-point:ON ACTION controlp INFIELD b_xccc903a name="construct.c.page1.b_xccc903a"
            
            #END add-point
 
 
         #----<<b_xccc903b>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xccc903b
            #add-point:BEFORE FIELD b_xccc903b name="construct.b.page1.b_xccc903b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xccc903b
            
            #add-point:AFTER FIELD b_xccc903b name="construct.a.page1.b_xccc903b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xccc903b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903b
            #add-point:ON ACTION controlp INFIELD b_xccc903b name="construct.c.page1.b_xccc903b"
            
            #END add-point
 
 
         #----<<b_xccc903c>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xccc903c
            #add-point:BEFORE FIELD b_xccc903c name="construct.b.page1.b_xccc903c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xccc903c
            
            #add-point:AFTER FIELD b_xccc903c name="construct.a.page1.b_xccc903c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xccc903c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903c
            #add-point:ON ACTION controlp INFIELD b_xccc903c name="construct.c.page1.b_xccc903c"
            
            #END add-point
 
 
         #----<<b_xccc903d>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xccc903d
            #add-point:BEFORE FIELD b_xccc903d name="construct.b.page1.b_xccc903d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xccc903d
            
            #add-point:AFTER FIELD b_xccc903d name="construct.a.page1.b_xccc903d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xccc903d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903d
            #add-point:ON ACTION controlp INFIELD b_xccc903d name="construct.c.page1.b_xccc903d"
            
            #END add-point
 
 
         #----<<b_xccc903e>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xccc903e
            #add-point:BEFORE FIELD b_xccc903e name="construct.b.page1.b_xccc903e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xccc903e
            
            #add-point:AFTER FIELD b_xccc903e name="construct.a.page1.b_xccc903e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xccc903e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903e
            #add-point:ON ACTION controlp INFIELD b_xccc903e name="construct.c.page1.b_xccc903e"
            
            #END add-point
 
 
         #----<<b_xccc903f>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xccc903f
            #add-point:BEFORE FIELD b_xccc903f name="construct.b.page1.b_xccc903f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xccc903f
            
            #add-point:AFTER FIELD b_xccc903f name="construct.a.page1.b_xccc903f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xccc903f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903f
            #add-point:ON ACTION controlp INFIELD b_xccc903f name="construct.c.page1.b_xccc903f"
            
            #END add-point
 
 
         #----<<b_xccc903g>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xccc903g
            #add-point:BEFORE FIELD b_xccc903g name="construct.b.page1.b_xccc903g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xccc903g
            
            #add-point:AFTER FIELD b_xccc903g name="construct.a.page1.b_xccc903g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xccc903g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903g
            #add-point:ON ACTION controlp INFIELD b_xccc903g name="construct.c.page1.b_xccc903g"
            
            #END add-point
 
 
         #----<<b_xccc903h>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xccc903h
            #add-point:BEFORE FIELD b_xccc903h name="construct.b.page1.b_xccc903h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xccc903h
            
            #add-point:AFTER FIELD b_xccc903h name="construct.a.page1.b_xccc903h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xccc903h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903h
            #add-point:ON ACTION controlp INFIELD b_xccc903h name="construct.c.page1.b_xccc903h"
            
            #END add-point
 
 
         #----<<b_xccc903>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xccc903
            #add-point:BEFORE FIELD b_xccc903 name="construct.b.page1.b_xccc903"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xccc903
            
            #add-point:AFTER FIELD b_xccc903 name="construct.a.page1.b_xccc903"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xccc903
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903
            #add-point:ON ACTION controlp INFIELD b_xccc903 name="construct.c.page1.b_xccc903"
            
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
   CALL axcq516_b_fill()
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
 
{<section id="axcq516.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq516_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
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
   
   #显示资料
   #抓出单头资料
   LET g_sql = "SELECT UNIQUE xccccomp,ooefl003,xcccld,glaal002, ",
               "              xccc004,xccc005, ",
               "              xccc001,'',xccc003,xcatl003 ",
               "  FROM xccc_t LEFT JOIN ooefl_t ON ooeflent='"||g_enterprise||"' AND ooefl001=xccccomp AND ooefl002='"||g_dlang||"' ",
               "              LEFT JOIN glaal_t ON glaalent='"||g_enterprise||"' AND glaalld=xcccld AND glaal001='"||g_dlang||"' ",
              "               LEFT JOIN xcatl_t ON xcatlent='"||g_enterprise||"' AND xcatl001=xccc003 AND xcatl002='"||g_dlang||"' ",
               " WHERE xcccent = ",g_enterprise,
               "   AND ",ls_wc
   #160802-00020#4-add-(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND xcccld IN ",g_wc_cs_ld
    END IF
   #160802-00020#4-add-(E)   
   #160802-00020#10-add-(S)
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND xccccomp IN ",g_wc_cs_comp    #170216-00012#1  mod xcccomp ---> xccccomp
   END IF
   #160802-00020#10-add-(E)   
   LET g_sql = g_sql, cl_sql_add_filter("xccc_t"),  #額外的過濾條件
              " ORDER BY xccccomp,xcccld,xccc004,xccc005,xccc001,xccc003 "
   PREPARE axcq516_prepare FROM g_sql      #預備一下
   DECLARE axcq516_b_curs                  #宣告成可捲動的
       SCROLL CURSOR WITH HOLD FOR axcq516_prepare

   #抓出資料筆數
   LET g_sql = "SELECT COUNT(DISTINCT xccccomp||xcccld||xccc004||xccc005||xccc001||xccc003) ",
               "  FROM xccc_t",
               " WHERE xcccent = ",g_enterprise,
               "   AND ",ls_wc
   LET g_sql = g_sql, cl_sql_add_filter("xccc_t")   #額外的過濾條件
   #160802-00020#4-add-(S)
   #---增加帳號權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND xcccld IN ",g_wc_cs_ld
    END IF
   #160802-00020#4-add-(E) 
   #160802-00020#10-add-(S)
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND xccccomp IN ",g_wc_cs_comp   #170216-00012#1  mod xcccomp ---> xccccomp
   END IF
   #160802-00020#10-add-(E)
   PREPARE axcq516_precount FROM g_sql
   DECLARE axcq516_count CURSOR FOR axcq516_precount

   OPEN axcq516_b_curs         #抓出单头唯一性资料
   IF SQLCA.sqlcode THEN                    #有問題
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "open axcq516_b_curs"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      INITIALIZE tm.* TO NULL
   ELSE
      #显示总页数
      OPEN axcq516_count
      FETCH axcq516_count INTO g_page_cnt
      DISPLAY g_page_cnt TO FORMONLY.h_count  #总页数


      LET g_fetch = 'F'
      CALL axcq516_fetch()  #显示第一笔
      
      #未获取资料
      IF g_page_cnt = 0 THEN
         LET g_page_idx = ''  #当页
         DISPLAY g_page_idx TO FORMONLY.h_index  #当页
         #160113-00011#2-add----(s)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = "-100"
         LET g_errparam.popup  = FALSE
         CALL cl_err()
         #160113-00011#2-add----(e)         
      END IF
   END IF
   
   RETURN
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
 
   LET ls_sql_rank = "SELECT  UNIQUE xccc002,'',xccc006,'','',xccc007,xccc008,xccc903a,xccc903b,xccc903c, 
       xccc903d,xccc903e,xccc903f,xccc903g,xccc903h,xccc903  ,DENSE_RANK() OVER( ORDER BY xccc_t.xcccld, 
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
 
   LET g_sql = "SELECT xccc002,'',xccc006,'','',xccc007,xccc008,xccc903a,xccc903b,xccc903c,xccc903d, 
       xccc903e,xccc903f,xccc903g,xccc903h,xccc903",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq516_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axcq516_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xccc_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_xccc_d[l_ac].xccc002,g_xccc_d[l_ac].xccc002_desc,g_xccc_d[l_ac].xccc006, 
       g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_desc,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc008, 
       g_xccc_d[l_ac].xccc903a,g_xccc_d[l_ac].xccc903b,g_xccc_d[l_ac].xccc903c,g_xccc_d[l_ac].xccc903d, 
       g_xccc_d[l_ac].xccc903e,g_xccc_d[l_ac].xccc903f,g_xccc_d[l_ac].xccc903g,g_xccc_d[l_ac].xccc903h, 
       g_xccc_d[l_ac].xccc903
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
 
      CALL axcq516_detail_show("'1'")      
 
      CALL axcq516_xccc_t_mask()
 
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
   FREE axcq516_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq516_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq516_detail_action_trans()
 
   IF g_xccc_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL axcq516_fetch()
   END IF
   
      CALL axcq516_filter_show('xccc002','b_xccc002')
   CALL axcq516_filter_show('xccc006','b_xccc006')
   CALL axcq516_filter_show('xccc007','b_xccc007')
   CALL axcq516_filter_show('xccc008','b_xccc008')
   CALL axcq516_filter_show('xccc903a','b_xccc903a')
   CALL axcq516_filter_show('xccc903b','b_xccc903b')
   CALL axcq516_filter_show('xccc903c','b_xccc903c')
   CALL axcq516_filter_show('xccc903d','b_xccc903d')
   CALL axcq516_filter_show('xccc903e','b_xccc903e')
   CALL axcq516_filter_show('xccc903f','b_xccc903f')
   CALL axcq516_filter_show('xccc903g','b_xccc903g')
   CALL axcq516_filter_show('xccc903h','b_xccc903h')
   CALL axcq516_filter_show('xccc903','b_xccc903')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq516.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq516_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE ls_msg     STRING
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   #受pattern限制，使用g_fetch变量，非空为版型所有，不需要调用的
   IF cl_null(g_fetch) THEN
      RETURN
   END IF
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   CASE g_fetch
      WHEN 'F' FETCH FIRST    axcq516_b_curs INTO tm.*
               LET g_page_idx = 1
      WHEN 'L' FETCH LAST     axcq516_b_curs INTO tm.*
               LET g_page_idx = g_page_cnt
      WHEN 'P' FETCH PREVIOUS axcq516_b_curs INTO tm.*
               IF g_page_idx > 1 THEN
                  LET g_page_idx = g_page_idx - 1
               END IF
      WHEN 'N' FETCH NEXT     axcq516_b_curs INTO tm.*
               IF g_page_idx < g_page_cnt THEN
                  LET g_page_idx =  g_page_idx + 1
               END IF
      WHEN '/'
          IF (NOT g_no_ask) THEN
             CALL cl_set_act_visible("accept,cancel", TRUE)
             CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
             LET INT_FLAG = 0

             PROMPT ls_msg CLIPPED,': ' FOR g_jump
                #交談指令共用ACTION
                &include "common_action.4gl"
             END PROMPT

             CALL cl_set_act_visible("accept,cancel", FALSE)
             IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE
             END IF

          END IF
          FETCH ABSOLUTE g_jump axcq516_b_curs INTO tm.*
          LET g_no_ask = FALSE
          IF g_jump > 0 AND g_jump <= g_page_cnt THEN
             LET g_page_idx = g_jump
          END IF

   END CASE
   DISPLAY g_page_idx TO FORMONLY.h_index  #当页

   CALL axcq516_show()
   
   IF g_detail_cnt < g_detail_idx THEN
      LET g_detail_idx = g_detail_cnt
   END IF
   DISPLAY g_detail_idx TO FORMONLY.idx  #显示当前第几行
   
   CALL cl_navigator_setting(g_page_idx, g_page_cnt)  #設定ToolBar上瀏覽上下筆資料的按鈕狀態
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   LET g_fetch = ''
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq516.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq516_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_xccc_d[l_ac].xccc002
            LET ls_sql = "SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbfl001=? AND xcbfl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xccc_d[l_ac].xccc002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_d[l_ac].xccc002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_d[l_ac].xccc006
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xccc_d[l_ac].xccc006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_d[l_ac].xccc006_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_d[l_ac].xccc006_desc
            LET ls_sql = "SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xccc_d[l_ac].xccc006_desc_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_d[l_ac].xccc006_desc_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq516.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axcq516_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   CALL axcq516_filter2()
   RETURN
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
      CONSTRUCT g_wc_filter ON xccc002,xccc006,xccc007,xccc008,xccc903a,xccc903b,xccc903c,xccc903d,xccc903e, 
          xccc903f,xccc903g,xccc903h,xccc903
                          FROM s_detail1[1].b_xccc002,s_detail1[1].b_xccc006,s_detail1[1].b_xccc007, 
                              s_detail1[1].b_xccc008,s_detail1[1].b_xccc903a,s_detail1[1].b_xccc903b, 
                              s_detail1[1].b_xccc903c,s_detail1[1].b_xccc903d,s_detail1[1].b_xccc903e, 
                              s_detail1[1].b_xccc903f,s_detail1[1].b_xccc903g,s_detail1[1].b_xccc903h, 
                              s_detail1[1].b_xccc903
 
         BEFORE CONSTRUCT
                     DISPLAY axcq516_filter_parser('xccc002') TO s_detail1[1].b_xccc002
            DISPLAY axcq516_filter_parser('xccc006') TO s_detail1[1].b_xccc006
            DISPLAY axcq516_filter_parser('xccc007') TO s_detail1[1].b_xccc007
            DISPLAY axcq516_filter_parser('xccc008') TO s_detail1[1].b_xccc008
            DISPLAY axcq516_filter_parser('xccc903a') TO s_detail1[1].b_xccc903a
            DISPLAY axcq516_filter_parser('xccc903b') TO s_detail1[1].b_xccc903b
            DISPLAY axcq516_filter_parser('xccc903c') TO s_detail1[1].b_xccc903c
            DISPLAY axcq516_filter_parser('xccc903d') TO s_detail1[1].b_xccc903d
            DISPLAY axcq516_filter_parser('xccc903e') TO s_detail1[1].b_xccc903e
            DISPLAY axcq516_filter_parser('xccc903f') TO s_detail1[1].b_xccc903f
            DISPLAY axcq516_filter_parser('xccc903g') TO s_detail1[1].b_xccc903g
            DISPLAY axcq516_filter_parser('xccc903h') TO s_detail1[1].b_xccc903h
            DISPLAY axcq516_filter_parser('xccc903') TO s_detail1[1].b_xccc903
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_xccc002>>----
         #Ctrlp:construct.c.filter.page1.b_xccc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc002
            #add-point:ON ACTION controlp INFIELD b_xccc002 name="construct.c.filter.page1.b_xccc002"
            
            #END add-point
 
 
         #----<<b_xccc002_desc>>----
         #----<<b_xccc006>>----
         #Ctrlp:construct.c.filter.page1.b_xccc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc006
            #add-point:ON ACTION controlp INFIELD b_xccc006 name="construct.c.filter.page1.b_xccc006"
            
            #END add-point
 
 
         #----<<b_xccc006_desc>>----
         #----<<b_xccc006_desc_desc>>----
         #----<<b_xccc007>>----
         #Ctrlp:construct.c.page1.b_xccc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc007
            #add-point:ON ACTION controlp INFIELD b_xccc007 name="construct.c.filter.page1.b_xccc007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xccc007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xccc007  #顯示到畫面上
            NEXT FIELD b_xccc007                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xccc008>>----
         #Ctrlp:construct.c.filter.page1.b_xccc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc008
            #add-point:ON ACTION controlp INFIELD b_xccc008 name="construct.c.filter.page1.b_xccc008"
            
            #END add-point
 
 
         #----<<b_xccc903a>>----
         #Ctrlp:construct.c.filter.page1.b_xccc903a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903a
            #add-point:ON ACTION controlp INFIELD b_xccc903a name="construct.c.filter.page1.b_xccc903a"
            
            #END add-point
 
 
         #----<<b_xccc903b>>----
         #Ctrlp:construct.c.filter.page1.b_xccc903b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903b
            #add-point:ON ACTION controlp INFIELD b_xccc903b name="construct.c.filter.page1.b_xccc903b"
            
            #END add-point
 
 
         #----<<b_xccc903c>>----
         #Ctrlp:construct.c.filter.page1.b_xccc903c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903c
            #add-point:ON ACTION controlp INFIELD b_xccc903c name="construct.c.filter.page1.b_xccc903c"
            
            #END add-point
 
 
         #----<<b_xccc903d>>----
         #Ctrlp:construct.c.filter.page1.b_xccc903d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903d
            #add-point:ON ACTION controlp INFIELD b_xccc903d name="construct.c.filter.page1.b_xccc903d"
            
            #END add-point
 
 
         #----<<b_xccc903e>>----
         #Ctrlp:construct.c.filter.page1.b_xccc903e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903e
            #add-point:ON ACTION controlp INFIELD b_xccc903e name="construct.c.filter.page1.b_xccc903e"
            
            #END add-point
 
 
         #----<<b_xccc903f>>----
         #Ctrlp:construct.c.filter.page1.b_xccc903f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903f
            #add-point:ON ACTION controlp INFIELD b_xccc903f name="construct.c.filter.page1.b_xccc903f"
            
            #END add-point
 
 
         #----<<b_xccc903g>>----
         #Ctrlp:construct.c.filter.page1.b_xccc903g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903g
            #add-point:ON ACTION controlp INFIELD b_xccc903g name="construct.c.filter.page1.b_xccc903g"
            
            #END add-point
 
 
         #----<<b_xccc903h>>----
         #Ctrlp:construct.c.filter.page1.b_xccc903h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903h
            #add-point:ON ACTION controlp INFIELD b_xccc903h name="construct.c.filter.page1.b_xccc903h"
            
            #END add-point
 
 
         #----<<b_xccc903>>----
         #Ctrlp:construct.c.filter.page1.b_xccc903
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc903
            #add-point:ON ACTION controlp INFIELD b_xccc903 name="construct.c.filter.page1.b_xccc903"
            
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
   
      CALL axcq516_filter_show('xccc002','b_xccc002')
   CALL axcq516_filter_show('xccc006','b_xccc006')
   CALL axcq516_filter_show('xccc007','b_xccc007')
   CALL axcq516_filter_show('xccc008','b_xccc008')
   CALL axcq516_filter_show('xccc903a','b_xccc903a')
   CALL axcq516_filter_show('xccc903b','b_xccc903b')
   CALL axcq516_filter_show('xccc903c','b_xccc903c')
   CALL axcq516_filter_show('xccc903d','b_xccc903d')
   CALL axcq516_filter_show('xccc903e','b_xccc903e')
   CALL axcq516_filter_show('xccc903f','b_xccc903f')
   CALL axcq516_filter_show('xccc903g','b_xccc903g')
   CALL axcq516_filter_show('xccc903h','b_xccc903h')
   CALL axcq516_filter_show('xccc903','b_xccc903')
 
    
   CALL axcq516_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq516.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axcq516_filter_parser(ps_field)
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
 
{<section id="axcq516.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axcq516_filter_show(ps_field,ps_object)
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
   LET ls_condition = axcq516_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq516.insert" >}
#+ insert
PRIVATE FUNCTION axcq516_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axcq516.modify" >}
#+ modify
PRIVATE FUNCTION axcq516_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq516.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axcq516_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq516.delete" >}
#+ delete
PRIVATE FUNCTION axcq516_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq516.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axcq516_detail_action_trans()
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
 
{<section id="axcq516.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axcq516_detail_index_setting()
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
 
{<section id="axcq516.mask_functions" >}
 &include "erp/axc/axcq516_mask.4gl"
 
{</section>}
 
{<section id="axcq516.other_function" readonly="Y" >}

#查询，pattern不支持功能需求，用此代替pattern
PRIVATE FUNCTION axcq516_query2()
   DEFINE ls_wc       LIKE type_t.chr500
   DEFINE l_glaa001   LIKE glaa_t.glaa001  #使用币别
   DEFINE l_glaa016   LIKE glaa_t.glaa016  #本位幣二
   DEFINE l_glaa020   LIKE glaa_t.glaa020  #本位幣三
   
   #wc備份
   LET ls_wc = g_wc
   LET g_wc_filter_t = g_wc_filter
   LET g_master_idx = l_ac
 
   
   LET INT_FLAG = 0
   CLEAR FORM
   LET g_wc = ''
   INITIALIZE tm.* TO NULL
   CALL g_xccc_d.clear()
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   LET g_wc_filter = " 1=1"

   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1

   CALL axcq516_default()  #查询前预设
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON xccccomp,xcccld,xccc004,xccc005,xccc001,xccc003,
                              xccc002,xccc006,xccc007,xccc008,xccc903a,xccc903b,xccc903c,xccc903d,xccc903e, 
                              xccc903f,xccc903g,xccc903h,xccc903
           FROM b_xccccomp,b_xcccld,b_xccc004,b_xccc005,b_xccc001,b_xccc003,
                s_detail1[1].b_xccc002,s_detail1[1].b_xccc006,s_detail1[1].b_xccc007,s_detail1[1].b_xccc008, 
                s_detail1[1].b_xccc903a,s_detail1[1].b_xccc903b,s_detail1[1].b_xccc903c,s_detail1[1].b_xccc903d, 
                s_detail1[1].b_xccc903e,s_detail1[1].b_xccc903f,s_detail1[1].b_xccc903g,s_detail1[1].b_xccc903h, 
                s_detail1[1].b_xccc903
                      
         BEFORE CONSTRUCT
            DISPLAY tm.xccccomp,tm.xcccld,tm.xccc004,tm.xccc005,tm.xccc001,tm.xccc003
                 TO b_xccccomp,b_xcccld,b_xccc004,b_xccc005,b_xccc001,b_xccc003
            DISPLAY tm.xccccomp_desc TO b_xccccomp_desc   #法人組織 
            DISPLAY tm.xcccld_desc TO b_xcccld_desc     #帳別編號
            DISPLAY tm.xccc003_desc  TO b_xccc003_desc    #成本計算類型
            #DISPLAY tm.xccc001_desc TO b_xccc001_desc

         #--单头开窗
         ON ACTION controlp INFIELD b_xccccomp #法人组织
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#10-add-(S)
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #160802-00020#10-add-(E)
            CALL q_ooef001_2()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xccccomp  #顯示到畫面上
            NEXT FIELD b_xccccomp                     #返回原欄位

         ON ACTION controlp INFIELD b_xcccld   #账别编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #160802-00020#4-add-(S)
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#4-add-(E)
            CALL q_authorised_ld()                #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcccld  #顯示到畫面上
            NEXT FIELD b_xcccld                     #返回原欄位
 
         ON ACTION controlp INFIELD b_xccc003   #成本计算类型
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xccc003  #顯示到畫面上
            NEXT FIELD b_xccc003                     #返回原欄位

         #--单身开窗
         ON ACTION controlp INFIELD b_xccc002
            #成本域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xccc002  #顯示到畫面上
            NEXT FIELD b_xccc002                     #返回原欄位

         ON ACTION controlp INFIELD b_xccc006
            #料件编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xccc006  #顯示到畫面上
            NEXT FIELD b_xccc006                     #返回原欄位

         ON ACTION controlp INFIELD b_xccc007
            #料件特性
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccc007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xccc007  #顯示到畫面上
            NEXT FIELD b_xccc007                     #返回原欄位
       
      END CONSTRUCT

      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 

      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
 
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
 
   END DIALOG
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
      LET g_wc_filter = g_wc_filter_t
   ELSE
      LET g_master_idx = 1
   END IF
   
   LET g_wc = g_wc_table 
 

   LET g_wc2 = " 1=1"

        
   LET g_error_show = 1
   INITIALIZE tm.* TO NULL
   CALL axcq516_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
END FUNCTION

#查询前预设
PRIVATE FUNCTION axcq516_default()
   DEFINE l_glaa001   LIKE glaa_t.glaa001  #使用币别
   DEFINE l_glaa016   LIKE glaa_t.glaa016  #本位幣二
   DEFINE l_glaa020   LIKE glaa_t.glaa020  #本位幣三

   #预设当前site的法人，主账套，年度期别，成本计算类型
   CALL s_axc_set_site_default() RETURNING tm.xccccomp,tm.xcccld,tm.xccc004,tm.xccc005,tm.xccc003
   LET tm.xccc001 = '1'
   #fengmy 150109----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(tm.xccccomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF           
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('b_xccc002,b_xccc002_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('b_xccc002,b_xccc002_desc',FALSE)                
   END IF    
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('b_xccc007',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('b_xccc007',FALSE)                
   END IF
   #fengmy 150109----end     
   #说明栏位
   CALL s_desc_get_department_desc(tm.xccccomp) RETURNING tm.xccccomp_desc #法人組織
   CALL s_desc_get_ld_desc(tm.xcccld) RETURNING tm.xcccld_desc #帳別編號
   #成本計算類型
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = tm.xccc003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.xccc003_desc = '', g_rtn_fields[1] , ''

   #本位币说明
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = tm.xcccld
   CASE tm.xccc001
      WHEN '1'
           CALL s_desc_get_currency_desc(l_glaa001) RETURNING tm.xccc001_desc
      WHEN '2'
           CALL s_desc_get_currency_desc(l_glaa016) RETURNING tm.xccc001_desc
      WHEN '3'
           CALL s_desc_get_currency_desc(l_glaa020) RETURNING tm.xccc001_desc
   END CASE
END FUNCTION

PRIVATE FUNCTION axcq516_show()
   DEFINE l_glaa001   LIKE glaa_t.glaa001  #使用币别
   DEFINE l_glaa016   LIKE glaa_t.glaa016  #本位幣二
   DEFINE l_glaa020   LIKE glaa_t.glaa020  #本位幣三

   #显示单头
   DISPLAY tm.xccccomp TO b_xccccomp   #法人組織
   DISPLAY tm.xccccomp_desc TO b_xccccomp_desc   #法人組織
   DISPLAY tm.xcccld   TO b_xcccld     #帳別編號
   DISPLAY tm.xcccld_desc   TO b_xcccld_desc     #帳別編號
   DISPLAY tm.xccc004  TO b_xccc004    #年度
   DISPLAY tm.xccc005  TO b_xccc005    #期別
   DISPLAY tm.xccc001  TO b_xccc001    #本位币顺序
   DISPLAY tm.xccc003  TO b_xccc003    #成本計算類型
   DISPLAY tm.xccc003_desc  TO b_xccc003_desc    #成本計算類型
   
   #本位币说明
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = tm.xcccld
   CASE tm.xccc001
      WHEN '1'
           CALL s_desc_get_currency_desc(l_glaa001) RETURNING tm.xccc001_desc
      WHEN '2'
           CALL s_desc_get_currency_desc(l_glaa016) RETURNING tm.xccc001_desc
      WHEN '3'
           CALL s_desc_get_currency_desc(l_glaa020) RETURNING tm.xccc001_desc
   END CASE
   DISPLAY tm.xccc001_desc TO b_xccc001_desc
   #fengmy 150109----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(tm.xccccomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF   
      
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('b_xccc002,b_xccc002_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('b_xccc002,b_xccc002_desc',FALSE)                
   END IF    
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('b_xccc007',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('b_xccc007',FALSE)                
   END IF
   #fengmy 150109----end  
   #显示单身
   CALL axcq516_b_fill2()
   
   #設定p_per內有特殊格式設定的欄位
   CALL cl_show_fld_cont() 
END FUNCTION

#筛选，pattern不支持功能需求，用此代替pattern
PRIVATE FUNCTION axcq516_filter2()
   DEFINE l_glaa001   LIKE glaa_t.glaa001  #使用币别
   DEFINE l_glaa016   LIKE glaa_t.glaa016  #本位幣二
   DEFINE l_glaa020   LIKE glaa_t.glaa020  #本位幣三

   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   #備份
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   LET g_wc_filter       = ''
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xccccomp,xcccld,xccc004,xccc005,xccc001,xccc003,
                               xccc002,xccc006,xccc007,xccc008,xccc903a,xccc903b,xccc903c,xccc903d,xccc903e, 
                               xccc903f,xccc903g,xccc903h,xccc903
           FROM b_xccccomp,b_xcccld,b_xccc004,b_xccc005,b_xccc001,b_xccc003,
                s_detail1[1].b_xccc002,s_detail1[1].b_xccc006,s_detail1[1].b_xccc007,s_detail1[1].b_xccc008, 
                s_detail1[1].b_xccc903a,s_detail1[1].b_xccc903b,s_detail1[1].b_xccc903c,s_detail1[1].b_xccc903d, 
                s_detail1[1].b_xccc903e,s_detail1[1].b_xccc903f,s_detail1[1].b_xccc903g,s_detail1[1].b_xccc903h, 
                s_detail1[1].b_xccc903
 
         BEFORE CONSTRUCT
#saki       CALL cl_qbe_init()
            DISPLAY axcq516_filter_parser('xccccomp') TO s_detail1[1].b_xccccomp
            DISPLAY axcq516_filter_parser('xcccld') TO s_detail1[1].b_xcccld
            DISPLAY axcq516_filter_parser('xccc004') TO s_detail1[1].b_xccc004
            DISPLAY axcq516_filter_parser('xccc005') TO s_detail1[1].b_xccc005
            DISPLAY axcq516_filter_parser('xccc001') TO s_detail1[1].b_xccc001
            DISPLAY axcq516_filter_parser('xccc003') TO s_detail1[1].b_xccc003
            DISPLAY axcq516_filter_parser('xccc002') TO s_detail1[1].b_xccc002
            DISPLAY axcq516_filter_parser('xccc006') TO s_detail1[1].b_xccc006
            DISPLAY axcq516_filter_parser('xccc007') TO s_detail1[1].b_xccc007
            DISPLAY axcq516_filter_parser('xccc008') TO s_detail1[1].b_xccc008
            DISPLAY axcq516_filter_parser('xccc903a') TO s_detail1[1].b_xccc903a
            DISPLAY axcq516_filter_parser('xccc903b') TO s_detail1[1].b_xccc903b
            DISPLAY axcq516_filter_parser('xccc903c') TO s_detail1[1].b_xccc903c
            DISPLAY axcq516_filter_parser('xccc903d') TO s_detail1[1].b_xccc903d
            DISPLAY axcq516_filter_parser('xccc903e') TO s_detail1[1].b_xccc903e
            DISPLAY axcq516_filter_parser('xccc903f') TO s_detail1[1].b_xccc903f
            DISPLAY axcq516_filter_parser('xccc903g') TO s_detail1[1].b_xccc903g
            DISPLAY axcq516_filter_parser('xccc903h') TO s_detail1[1].b_xccc903h
            DISPLAY axcq516_filter_parser('xccc903') TO s_detail1[1].b_xccc903
 
         #--单头开窗
         ON ACTION controlp INFIELD b_xccccomp #法人组织
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#10-add-(S)
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #160802-00020#10-add-(E)
            CALL q_ooef001_2()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xccccomp  #顯示到畫面上
            NEXT FIELD b_xccccomp                     #返回原欄位

         ON ACTION controlp INFIELD b_xcccld   #账别编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #160802-00020#4-add-(S)
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#4-add-(E)
            CALL q_authorised_ld()                #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcccld  #顯示到畫面上
            NEXT FIELD b_xcccld                     #返回原欄位
 
         ON ACTION controlp INFIELD b_xccc003   #成本计算类型
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xccc003  #顯示到畫面上
            NEXT FIELD b_xccc003                     #返回原欄位

         #--单身开窗
         ON ACTION controlp INFIELD b_xccc002
            #成本域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xccc002  #顯示到畫面上
            NEXT FIELD b_xccc002                     #返回原欄位

         ON ACTION controlp INFIELD b_xccc006
            #料件编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xccc006  #顯示到畫面上
            NEXT FIELD b_xccc006                     #返回原欄位

         ON ACTION controlp INFIELD b_xccc007
            #料件特性
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccc007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xccc007  #顯示到畫面上
            NEXT FIELD b_xccc007                     #返回原欄位
       
 
      END CONSTRUCT
 
      #add-point:filter段add_cs

      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog

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
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
   
   CALL axcq516_filter_show('xccccomp','b_xccccomp')
   CALL axcq516_filter_show('xcccld','b_xcccld')
   CALL axcq516_filter_show('xccc004','b_xccc004')
   CALL axcq516_filter_show('xccc005','b_xccc005')
   CALL axcq516_filter_show('xccc001','b_xccc001')
   CALL axcq516_filter_show('xccc003','b_xccc003')
   CALL axcq516_filter_show('xccc002','b_xccc002')
   CALL axcq516_filter_show('xccc006','b_xccc006')
   CALL axcq516_filter_show('xccc007','b_xccc007')
   CALL axcq516_filter_show('xccc008','b_xccc008')
   CALL axcq516_filter_show('xccc903a','b_xccc903a')
   CALL axcq516_filter_show('xccc903b','b_xccc903b')
   CALL axcq516_filter_show('xccc903c','b_xccc903c')
   CALL axcq516_filter_show('xccc903d','b_xccc903d')
   CALL axcq516_filter_show('xccc903e','b_xccc903e')
   CALL axcq516_filter_show('xccc903f','b_xccc903f')
   CALL axcq516_filter_show('xccc903g','b_xccc903g')
   CALL axcq516_filter_show('xccc903h','b_xccc903h')
   CALL axcq516_filter_show('xccc903','b_xccc903')
 
   INITIALIZE tm.* TO NULL
   CALL axcq516_b_fill()
   
END FUNCTION

#单身显示，pattern不支持功能需求，用此代替pattern
PRIVATE FUNCTION axcq516_b_fill2()
   DEFINE ls_wc         STRING
#160520-00002#2   
#   TYPE type_sum        RECORD
#                        xccc903a LIKE xccc_t.xccc903,  #结存调整-材料
#                        xccc903b LIKE xccc_t.xccc903,  #结存调整-人工
#                        xccc903c LIKE xccc_t.xccc903,  #结存调整-委外
#                        xccc903d LIKE xccc_t.xccc903,  #结存调整-製費一
#                        xccc903e LIKE xccc_t.xccc903,  #结存调整-製費二
#                        xccc903f LIKE xccc_t.xccc903,  #结存调整-製費三
#                        xccc903g LIKE xccc_t.xccc903,  #结存调整-製費四
#                        xccc903h LIKE xccc_t.xccc903,  #结存调整-製費五
#                        xccc903  LIKE xccc_t.xccc903   #结存调整 
#                        END RECORD

#   DEFINE l_sum         type_sum  #小计
#   DEFINE l_total       type_sum  #总计
#160520-00002#2   
   
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
   
   CALL g_xccc_d.clear()
 
#160520-00002#2 add--s---
   LET g_sql = "SELECT        SUM(xccc903a),SUM(xccc903b),",
               "              SUM(xccc903c),SUM(xccc903d),",
               "              SUM(xccc903e),SUM(xccc903f),",
               "              SUM(xccc903g),SUM(xccc903h),",
               "              SUM(xccc903) ",
               "  FROM xccc_t ",
               " WHERE xcccent= ",g_enterprise,
               "   AND xccccomp='",tm.xccccomp,"' ",
               "   AND xcccld ='",tm.xcccld,"' ",
               "   AND xccc004= ",tm.xccc004,
               "   AND xccc005= ",tm.xccc005,
               "   AND xccc001='",tm.xccc001,"' ",
               "   AND xccc003='",tm.xccc003,"' ",
               "   AND ",ls_wc   #单身需根据条件筛选资料                
               
   PREPARE axcq516_sum_pr2 FROM g_sql        
   
   LET g_sql = g_sql CLIPPED, "   AND xccc002 = ?"
   PREPARE axcq516_sum_pr1 FROM g_sql  
#160520-00002#2 add---e--- 
 
#160520-00002#2 mod--s--- 
#   LET g_sql = "SELECT UNIQUE xccc002,xcbfl003,xccc006,imaal002,imaal003,xccc007,xccc008, ",
#               "              xccc903a,xccc903b,xccc903c,xccc903d,xccc903e,xccc903f,xccc903g,xccc903h,xccc903 ",
#               "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
#               "              LEFT JOIN xcbfl_t ON xcbflent='"||g_enterprise||"' AND xcbfl001=xccc002 AND xcbflcomp=xccccomp AND xcbfl002='"||g_dlang||"' ",
#               " WHERE xcccent= ",g_enterprise,
#               "   AND xccccomp='",tm.xccccomp,"' ",
#               "   AND xcccld ='",tm.xcccld,"' ",
#               "   AND xccc004= ",tm.xccc004,
#               "   AND xccc005= ",tm.xccc005,
#               "   AND xccc001='",tm.xccc001,"' ",
#               "   AND xccc003='",tm.xccc003,"' ",
#               "   AND ",ls_wc   #单身需根据条件筛选资料
#   LET g_sql = g_sql, cl_sql_add_filter("xccc_t"),
#               " ORDER BY xccc002,xccc006,xccc007,xccc008"
#   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   LET g_sql = "SELECT UNIQUE xccc002,xcbfl003,xccc006,imaal002,imaal003,xccc007,xccc008, ",
               "              CASE WHEN   xccc903a IS NULL THEN 0 ELSE xccc903a END ,",
               "              CASE WHEN   xccc903b IS NULL THEN 0 ELSE xccc903b END ,",
               "              CASE WHEN   xccc903c IS NULL THEN 0 ELSE xccc903c END ,",
               "              CASE WHEN   xccc903d IS NULL THEN 0 ELSE xccc903d END ,",
               "              CASE WHEN   xccc903e IS NULL THEN 0 ELSE xccc903e END ,",
               "              CASE WHEN   xccc903f IS NULL THEN 0 ELSE xccc903f END ,",
               "              CASE WHEN   xccc903g IS NULL THEN 0 ELSE xccc903g END ,",
               "              CASE WHEN   xccc903h IS NULL THEN 0 ELSE xccc903h END ,",
               "              CASE WHEN   xccc903  IS NULL THEN 0 ELSE xccc903  END  ",
               "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
               "              LEFT JOIN xcbfl_t ON xcbflent='"||g_enterprise||"' AND xcbfl001=xccc002 AND xcbflcomp=xccccomp AND xcbfl002='"||g_dlang||"' ",
               " WHERE xcccent= ",g_enterprise,
               "   AND xccccomp='",tm.xccccomp,"' ",
               "   AND xcccld ='",tm.xcccld,"' ",
               "   AND xccc004= ",tm.xccc004,
               "   AND xccc005= ",tm.xccc005,
               "   AND xccc001='",tm.xccc001,"' ",
               "   AND xccc003='",tm.xccc003,"' ",
               "   AND ",ls_wc   #单身需根据条件筛选资料
   LET g_sql = g_sql, cl_sql_add_filter("xccc_t"),
               " ORDER BY xccc002,xccc006,xccc007,xccc008"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  
#160520-00002#2 mod--e---    
   PREPARE axcq516_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR axcq516_pb2
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 

##160520-00002#2
#   #依组织小计
#   LET l_sum.xccc903a = 0
#   LET l_sum.xccc903b = 0
#   LET l_sum.xccc903c = 0
#   LET l_sum.xccc903d = 0
#   LET l_sum.xccc903e = 0
#   LET l_sum.xccc903f = 0
#   LET l_sum.xccc903g = 0
#   LET l_sum.xccc903h = 0
#   LET l_sum.xccc903  = 0
#   
#   #总计
#   LET l_total.xccc903a= 0
#   LET l_total.xccc903b= 0
#   LET l_total.xccc903c= 0
#   LET l_total.xccc903d= 0
#   LET l_total.xccc903e= 0
#   LET l_total.xccc903f= 0
#   LET l_total.xccc903g= 0
#   LET l_total.xccc903h= 0
#   LET l_total.xccc903 = 0
##160520-00002#2

   CALL cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否 #160520-00002#2
   
   FOREACH b_fill_curs2 INTO g_xccc_d[l_ac].xccc002,g_xccc_d[l_ac].xccc002_desc,g_xccc_d[l_ac].xccc006, 
       g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_desc,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc008, 
       g_xccc_d[l_ac].xccc903a,g_xccc_d[l_ac].xccc903b,g_xccc_d[l_ac].xccc903c,g_xccc_d[l_ac].xccc903d, 
       g_xccc_d[l_ac].xccc903e,g_xccc_d[l_ac].xccc903f,g_xccc_d[l_ac].xccc903g,g_xccc_d[l_ac].xccc903h, 
       g_xccc_d[l_ac].xccc903
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #160520-00002#2 mark--s---
      ##空值显示0
#       IF cl_null(g_xccc_d[l_ac].xccc903a) THEN LET g_xccc_d[l_ac].xccc903a = 0 END IF
#       IF cl_null(g_xccc_d[l_ac].xccc903b) THEN LET g_xccc_d[l_ac].xccc903b = 0 END IF
#       IF cl_null(g_xccc_d[l_ac].xccc903c) THEN LET g_xccc_d[l_ac].xccc903c = 0 END IF
#       IF cl_null(g_xccc_d[l_ac].xccc903d) THEN LET g_xccc_d[l_ac].xccc903d = 0 END IF 
#       IF cl_null(g_xccc_d[l_ac].xccc903e) THEN LET g_xccc_d[l_ac].xccc903e = 0 END IF
#       IF cl_null(g_xccc_d[l_ac].xccc903f) THEN LET g_xccc_d[l_ac].xccc903f = 0 END IF
#       IF cl_null(g_xccc_d[l_ac].xccc903g) THEN LET g_xccc_d[l_ac].xccc903g = 0 END IF
#       IF cl_null(g_xccc_d[l_ac].xccc903h) THEN LET g_xccc_d[l_ac].xccc903h = 0 END IF 
#       IF cl_null(g_xccc_d[l_ac].xccc903 ) THEN LET g_xccc_d[l_ac].xccc903  = 0 END IF
      #160520-00002#2 mark--e---
      
      #金额都为0的不显示
      IF g_xccc_d[l_ac].xccc903a = 0 AND
         g_xccc_d[l_ac].xccc903b = 0 AND
         g_xccc_d[l_ac].xccc903c = 0 AND
         g_xccc_d[l_ac].xccc903d = 0 AND 
         g_xccc_d[l_ac].xccc903e = 0 AND
         g_xccc_d[l_ac].xccc903f = 0 AND
         g_xccc_d[l_ac].xccc903g = 0 AND
         g_xccc_d[l_ac].xccc903h = 0 AND 
         g_xccc_d[l_ac].xccc903  = 0 THEN
         CONTINUE FOREACH
      END IF

##160520-00002#2
#      #总计
#      LET l_total.xccc903a= l_total.xccc903a + g_xccc_d[l_ac].xccc903a
#      LET l_total.xccc903b= l_total.xccc903b + g_xccc_d[l_ac].xccc903b
#      LET l_total.xccc903c= l_total.xccc903c + g_xccc_d[l_ac].xccc903c
#      LET l_total.xccc903d= l_total.xccc903d + g_xccc_d[l_ac].xccc903d
#      LET l_total.xccc903e= l_total.xccc903e + g_xccc_d[l_ac].xccc903e
#      LET l_total.xccc903f= l_total.xccc903f + g_xccc_d[l_ac].xccc903f
#      LET l_total.xccc903g= l_total.xccc903g + g_xccc_d[l_ac].xccc903g
#      LET l_total.xccc903h= l_total.xccc903h + g_xccc_d[l_ac].xccc903h
#      LET l_total.xccc903 = l_total.xccc903  + g_xccc_d[l_ac].xccc903 
#      
#      #依组织小计
#      LET l_sum.xccc903a = l_sum.xccc903a + g_xccc_d[l_ac].xccc903a
#      LET l_sum.xccc903b = l_sum.xccc903b + g_xccc_d[l_ac].xccc903b
#      LET l_sum.xccc903c = l_sum.xccc903c + g_xccc_d[l_ac].xccc903c
#      LET l_sum.xccc903d = l_sum.xccc903d + g_xccc_d[l_ac].xccc903d
#      LET l_sum.xccc903e = l_sum.xccc903e + g_xccc_d[l_ac].xccc903e
#      LET l_sum.xccc903f = l_sum.xccc903f + g_xccc_d[l_ac].xccc903f
#      LET l_sum.xccc903g = l_sum.xccc903g + g_xccc_d[l_ac].xccc903g
#      LET l_sum.xccc903h = l_sum.xccc903h + g_xccc_d[l_ac].xccc903h
#      LET l_sum.xccc903  = l_sum.xccc903  + g_xccc_d[l_ac].xccc903 
##160520-00002#2
      IF l_ac > 1 THEN
         IF g_xccc_d[l_ac].xccc002 != g_xccc_d[l_ac-1].xccc002 THEN
            #把当前行下移，并在当前行显示小计
            LET g_xccc_d[l_ac+1].* = g_xccc_d[l_ac].*
            INITIALIZE  g_xccc_d[l_ac].* TO NULL
            #fengmy 150109 modify--begin
#            LET g_xccc_d[l_ac].xccc002 = cl_getmsg("axc-00205",g_lang)
            #CALL cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否 #160520-00002#2
            IF g_para_data = 'Y' THEN
               LET g_xccc_d[l_ac].xccc002 = cl_getmsg("axc-00205",g_lang) 
            ELSE
               LET g_xccc_d[l_ac].xccc006 = cl_getmsg("axc-00205",g_lang)  
            END IF
            #fengmy 150109 modify--begin
##160520-00002#2           
#            LET g_xccc_d[l_ac].xccc903a = l_sum.xccc903a - g_xccc_d[l_ac+1].xccc903a
#            LET g_xccc_d[l_ac].xccc903b = l_sum.xccc903b - g_xccc_d[l_ac+1].xccc903b
#            LET g_xccc_d[l_ac].xccc903c = l_sum.xccc903c - g_xccc_d[l_ac+1].xccc903c
#            LET g_xccc_d[l_ac].xccc903d = l_sum.xccc903d - g_xccc_d[l_ac+1].xccc903d
#            LET g_xccc_d[l_ac].xccc903e = l_sum.xccc903e - g_xccc_d[l_ac+1].xccc903e
#            LET g_xccc_d[l_ac].xccc903f = l_sum.xccc903f - g_xccc_d[l_ac+1].xccc903f
#            LET g_xccc_d[l_ac].xccc903g = l_sum.xccc903g - g_xccc_d[l_ac+1].xccc903g
#            LET g_xccc_d[l_ac].xccc903h = l_sum.xccc903h - g_xccc_d[l_ac+1].xccc903h
#            LET g_xccc_d[l_ac].xccc903  = l_sum.xccc903  - g_xccc_d[l_ac+1].xccc903 
#            LET l_ac = l_ac + 1
#            LET l_sum.xccc903a = g_xccc_d[l_ac].xccc903a
#            LET l_sum.xccc903b = g_xccc_d[l_ac].xccc903b
#            LET l_sum.xccc903c = g_xccc_d[l_ac].xccc903c
#            LET l_sum.xccc903d = g_xccc_d[l_ac].xccc903d
#            LET l_sum.xccc903e = g_xccc_d[l_ac].xccc903e
#            LET l_sum.xccc903f = g_xccc_d[l_ac].xccc903f
#            LET l_sum.xccc903g = g_xccc_d[l_ac].xccc903g
#            LET l_sum.xccc903h = g_xccc_d[l_ac].xccc903h
#            LET l_sum.xccc903  = g_xccc_d[l_ac].xccc903
      
      EXECUTE axcq516_sum_pr1 USING g_xccc_d[l_ac-1].xccc002
                               INTO g_xccc_d[l_ac].xccc903a,g_xccc_d[l_ac].xccc903b,
                                    g_xccc_d[l_ac].xccc903c,g_xccc_d[l_ac].xccc903d,g_xccc_d[l_ac].xccc903e, 
                                    g_xccc_d[l_ac].xccc903f,g_xccc_d[l_ac].xccc903g,g_xccc_d[l_ac].xccc903h, 
                                    g_xccc_d[l_ac].xccc903
      IF cl_null(g_xccc_d[l_ac].xccc903a) THEN LET g_xccc_d[l_ac].xccc903a = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903b) THEN LET g_xccc_d[l_ac].xccc903b = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903c) THEN LET g_xccc_d[l_ac].xccc903c = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903d) THEN LET g_xccc_d[l_ac].xccc903d = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903e) THEN LET g_xccc_d[l_ac].xccc903e = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903f) THEN LET g_xccc_d[l_ac].xccc903f = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903g) THEN LET g_xccc_d[l_ac].xccc903g = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903h) THEN LET g_xccc_d[l_ac].xccc903h = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903)  THEN LET g_xccc_d[l_ac].xccc903  = 0 END IF     
      LET l_ac = l_ac + 1      
##160520-00002#2
         END IF
      END IF

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
   CALL g_xccc_d.deleteElement(g_xccc_d.getLength())
   LET l_ac = g_xccc_d.getLength()   #151029-00010#3 20151029 add by beckxie
   #IF l_ac > 1 THEN  #单身有资料时   #151029-00010#3 20151029 mark by beckxie
   IF l_ac >= 1 THEN  #单身有资料时   #151029-00010#3 20151029 add by beckxie
      LET l_ac = l_ac + 1   
##160520-00002#2
      EXECUTE axcq516_sum_pr1 USING g_xccc_d[l_ac-1].xccc002
                               INTO g_xccc_d[l_ac].xccc903a,g_xccc_d[l_ac].xccc903b,
                                    g_xccc_d[l_ac].xccc903c,g_xccc_d[l_ac].xccc903d,g_xccc_d[l_ac].xccc903e, 
                                    g_xccc_d[l_ac].xccc903f,g_xccc_d[l_ac].xccc903g,g_xccc_d[l_ac].xccc903h, 
                                    g_xccc_d[l_ac].xccc903
      IF cl_null(g_xccc_d[l_ac].xccc903a) THEN LET g_xccc_d[l_ac].xccc903a = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903b) THEN LET g_xccc_d[l_ac].xccc903b = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903c) THEN LET g_xccc_d[l_ac].xccc903c = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903d) THEN LET g_xccc_d[l_ac].xccc903d = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903e) THEN LET g_xccc_d[l_ac].xccc903e = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903f) THEN LET g_xccc_d[l_ac].xccc903f = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903g) THEN LET g_xccc_d[l_ac].xccc903g = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903h) THEN LET g_xccc_d[l_ac].xccc903h = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903)  THEN LET g_xccc_d[l_ac].xccc903  = 0 END IF
##160520-00002#2

      #最后一组小计
      #fengmy 150109 modify--begin
#      LET g_xccc_d[l_ac].xccc002 = cl_getmsg("axc-00205",g_lang)
      #CALL cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否 #160520-00002#2
      IF g_para_data = 'Y' THEN
         LET g_xccc_d[l_ac].xccc002 = cl_getmsg("axc-00205",g_lang)  
      ELSE
         LET g_xccc_d[l_ac].xccc006 = cl_getmsg("axc-00205",g_lang)  
      END IF
      #fengmy 150109 modify--begin
#160520-00002#2    
#      LET g_xccc_d[l_ac].xccc903a = l_sum.xccc903a
#      LET g_xccc_d[l_ac].xccc903b = l_sum.xccc903b
#      LET g_xccc_d[l_ac].xccc903c = l_sum.xccc903c
#      LET g_xccc_d[l_ac].xccc903d = l_sum.xccc903d
#      LET g_xccc_d[l_ac].xccc903e = l_sum.xccc903e
#      LET g_xccc_d[l_ac].xccc903f = l_sum.xccc903f
#      LET g_xccc_d[l_ac].xccc903g = l_sum.xccc903g
#      LET g_xccc_d[l_ac].xccc903h = l_sum.xccc903h
#      LET g_xccc_d[l_ac].xccc903  = l_sum.xccc903 
##160520-00002#2
      LET l_ac = l_ac + 1  
      #合计
      #fengmy 150109 modify--begin
#     LET g_xccc_d[l_ac].xccc002 = cl_getmsg("axc-00205",g_lang)
      #CALL cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否 #160520-00002#2
      IF g_para_data = 'Y' THEN
         LET g_xccc_d[l_ac].xccc002 = cl_getmsg("axc-00204",g_lang)                    
      ELSE                                               
         LET g_xccc_d[l_ac].xccc006 = cl_getmsg("axc-00204",g_lang)                
      END IF
      #fengmy 150109 modify--begin

##160520-00002#2     
#      LET g_xccc_d[l_ac].xccc903a = l_total.xccc903a
#      LET g_xccc_d[l_ac].xccc903b = l_total.xccc903b
#      LET g_xccc_d[l_ac].xccc903c = l_total.xccc903c
#      LET g_xccc_d[l_ac].xccc903d = l_total.xccc903d
#      LET g_xccc_d[l_ac].xccc903e = l_total.xccc903e
#      LET g_xccc_d[l_ac].xccc903f = l_total.xccc903f
#      LET g_xccc_d[l_ac].xccc903g = l_total.xccc903g
#      LET g_xccc_d[l_ac].xccc903h = l_total.xccc903h
#      LET g_xccc_d[l_ac].xccc903  = l_total.xccc903 
       EXECUTE axcq516_sum_pr2 INTO g_xccc_d[l_ac].xccc903a,g_xccc_d[l_ac].xccc903b,
                                    g_xccc_d[l_ac].xccc903c,g_xccc_d[l_ac].xccc903d,g_xccc_d[l_ac].xccc903e, 
                                    g_xccc_d[l_ac].xccc903f,g_xccc_d[l_ac].xccc903g,g_xccc_d[l_ac].xccc903h, 
                                    g_xccc_d[l_ac].xccc903
      IF cl_null(g_xccc_d[l_ac].xccc903a) THEN LET g_xccc_d[l_ac].xccc903a = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903b) THEN LET g_xccc_d[l_ac].xccc903b = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903c) THEN LET g_xccc_d[l_ac].xccc903c = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903d) THEN LET g_xccc_d[l_ac].xccc903d = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903e) THEN LET g_xccc_d[l_ac].xccc903e = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903f) THEN LET g_xccc_d[l_ac].xccc903f = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903g) THEN LET g_xccc_d[l_ac].xccc903g = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903h) THEN LET g_xccc_d[l_ac].xccc903h = 0 END IF
      IF cl_null(g_xccc_d[l_ac].xccc903)  THEN LET g_xccc_d[l_ac].xccc903  = 0 END IF                                    
##160520-00002#2
      LET l_ac = l_ac + 1
   END IF
   
   LET g_error_show = 0
   #CALL g_xccc_d.deleteElement(g_xccc_d.getLength())   # 最后没走foreach，没有空行了

   LET g_detail_cnt = g_xccc_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs2
   FREE axcq516_pb2
   
   LET l_ac = 1

   CALL axcq516_filter_show('xccccomp','b_xccccomp')
   CALL axcq516_filter_show('xcccld','b_xcccld')
   CALL axcq516_filter_show('xccc004','b_xccc004')
   CALL axcq516_filter_show('xccc005','b_xccc005')
   CALL axcq516_filter_show('xccc001','b_xccc001')
   CALL axcq516_filter_show('xccc003','b_xccc003')
   CALL axcq516_filter_show('xccc002','b_xccc002')
   CALL axcq516_filter_show('xccc006','b_xccc006')
   CALL axcq516_filter_show('xccc007','b_xccc007')
   CALL axcq516_filter_show('xccc008','b_xccc008')
   CALL axcq516_filter_show('xccc903a','b_xccc903a')
   CALL axcq516_filter_show('xccc903b','b_xccc903b')
   CALL axcq516_filter_show('xccc903c','b_xccc903c')
   CALL axcq516_filter_show('xccc903d','b_xccc903d')
   CALL axcq516_filter_show('xccc903e','b_xccc903e')
   CALL axcq516_filter_show('xccc903f','b_xccc903f')
   CALL axcq516_filter_show('xccc903g','b_xccc903g')
   CALL axcq516_filter_show('xccc903h','b_xccc903h')
   CALL axcq516_filter_show('xccc903','b_xccc903')
 
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明:创建临时表
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者:20150326 By dujuan
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq516_create_temp_table()
    DROP TABLE axcq516_tmp;
    CREATE TEMP TABLE axcq516_tmp(
      xccc002  VARCHAR(30), 
      xccc002_desc  VARCHAR(300), 
      xccc006  VARCHAR(40), 
      xccc006_desc  VARCHAR(300), 
      xccc006_desc_1  VARCHAR(300), 
      xccc007  VARCHAR(256), 
      xccc008  VARCHAR(30), 
      xccc903a  DECIMAL(20,6), 
      xccc903b  DECIMAL(20,6), 
      xccc903c  DECIMAL(20,6), 
      xccc903d  DECIMAL(20,6), 
      xccc903e  DECIMAL(20,6), 
      xccc903f  DECIMAL(20,6), 
      xccc903g  DECIMAL(20,6), 
      xccc903h  DECIMAL(20,6), 
      xccc903  DECIMAL(20,6), 
      xccccomp  VARCHAR(10), 
      xcccld  VARCHAR(5), 
      xccc001  VARCHAR(1), 
      xccc004  SMALLINT, 
      xccc003  VARCHAR(10), 
      xccc005  SMALLINT, 
      xccccomp_desc  VARCHAR(300), 
      xcccld_desc  VARCHAR(300), 
      xccc001_desc  VARCHAR(300), 
      xccc004_desc  VARCHAR(30), 
      xccc003_desc  VARCHAR(300), 
      xccc005_desc  VARCHAR(30), 
      xccc_key  VARCHAR(1000)
    );
END FUNCTION

################################################################################
# Descriptions...: 描述说明:临时表添加数据
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者:20150326 By dujuan
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq516_get_date()
   DEFINE sr RECORD 
      xccc002 LIKE xccc_t.xccc002, 
      xccc002_desc LIKE type_t.chr300, 
      xccc006 LIKE xccc_t.xccc006, 
      xccc006_desc LIKE type_t.chr300, 
      xccc006_desc_1 LIKE type_t.chr300, 
      xccc007 LIKE xccc_t.xccc007, 
      xccc008 LIKE xccc_t.xccc008, 
      xccc903a LIKE xccc_t.xccc903a, 
      xccc903b LIKE xccc_t.xccc903b, 
      xccc903c LIKE xccc_t.xccc903c, 
      xccc903d LIKE xccc_t.xccc903d, 
      xccc903e LIKE xccc_t.xccc903e, 
      xccc903f LIKE xccc_t.xccc903f, 
      xccc903g LIKE xccc_t.xccc903g, 
      xccc903h LIKE xccc_t.xccc903h, 
      xccc903 LIKE xccc_t.xccc903, 
      xccccomp LIKE xccc_t.xccccomp, 
      xcccld LIKE xccc_t.xcccld, 
      xccc001 LIKE xccc_t.xccc001, 
      xccc004 LIKE xccc_t.xccc004, 
      xccc003 LIKE xccc_t.xccc003, 
      xccc005 LIKE xccc_t.xccc005, 
      xccccomp_desc LIKE type_t.chr300, 
      xcccld_desc LIKE type_t.chr300, 
      xccc001_desc LIKE type_t.chr300, 
      xccc004_desc LIKE type_t.chr30, 
      xccc003_desc LIKE type_t.chr300, 
      xccc005_desc LIKE type_t.chr30, 
      xccc_key LIKE type_t.chr1000
    END RECORD
    
    DEFINE l_success  LIKE type_t.num5
    DEFINE l_cnt      LIKE type_t.num5
    DEFINE l_glaa001   LIKE glaa_t.glaa001  #使用币别
    DEFINE l_glaa016   LIKE glaa_t.glaa016  #本位幣二
    DEFINE l_glaa020   LIKE glaa_t.glaa020  #本位幣三
    DEFINE ls_wc         STRING
    
    #刪除臨時表中資料
    DELETE FROM axcq516_tmp
    
    LET l_success = TRUE
    
    FOR l_cnt = 1 TO g_page_cnt 
    
       FETCH ABSOLUTE l_cnt axcq516_b_curs INTO tm.*
       LET sr.xcccld  = tm.xcccld
       LET sr.xccc001 = tm.xccc001
       LET sr.xccc004 = tm.xccc004
       LET sr.xccc005 = tm.xccc005
       LET sr.xccc003 = tm.xccc003
       LET sr.xccccomp = tm.xccccomp
       LET sr.xcccld_desc  = tm.xcccld_desc
       LET sr.xccc003_desc = tm.xccc003_desc
       LET sr.xccccomp_desc = tm.xccccomp_desc
       LET sr.xccc004_desc = sr.xccc004
       LET sr.xccc005_desc = sr.xccc005
       #本位币说明
       SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
         FROM glaa_t
        WHERE glaaent = g_enterprise
          AND glaald  = tm.xcccld
       CASE tm.xccc001
         WHEN '1'
                 CALL s_desc_get_currency_desc(l_glaa001) RETURNING tm.xccc001_desc
         WHEN '2'
                 CALL s_desc_get_currency_desc(l_glaa016) RETURNING tm.xccc001_desc
         WHEN '3'
                 CALL s_desc_get_currency_desc(l_glaa020) RETURNING tm.xccc001_desc
       END CASE
       LET sr.xccc001_desc = tm.xccc001_desc
       LET sr.xccc_key = sr.xccccomp,"-",sr.xcccld,"-",sr.xccc004_desc CLIPPED,"-" CLIPPED,sr.xccc005_desc CLIPPED,"-",sr.xccc001,"-",sr.xccc003 CLIPPED
      
       #临时表加数据的sql
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

       LET g_sql = "SELECT UNIQUE xccc002,xcbfl003,xccc006,imaal002,imaal003,xccc007,xccc008, ",
               ##160520-00002#2 mod--s---
               #"              xccc903a,xccc903b,xccc903c,xccc903d,xccc903e,xccc903f,xccc903g,xccc903h,xccc903 ",
               "              CASE WHEN xccc903a = '' OR xccc903a IS NULL THEN 0 ELSE xccc903a END ,",
               "              CASE WHEN xccc903b = '' OR xccc903b IS NULL THEN 0 ELSE xccc903b END ,",
               "              CASE WHEN xccc903c = '' OR xccc903c IS NULL THEN 0 ELSE xccc903c END ,",
               "              CASE WHEN xccc903d = '' OR xccc903d IS NULL THEN 0 ELSE xccc903d END ,",
               "              CASE WHEN xccc903e = '' OR xccc903e IS NULL THEN 0 ELSE xccc903e END ,",
               "              CASE WHEN xccc903f = '' OR xccc903f IS NULL THEN 0 ELSE xccc903f END ,",
               "              CASE WHEN xccc903g = '' OR xccc903g IS NULL THEN 0 ELSE xccc903g END ,",
               "              CASE WHEN xccc903h = '' OR xccc903h IS NULL THEN 0 ELSE xccc903h END ,",
               "              CASE WHEN xccc903  = '' OR xccc903  IS NULL THEN 0 ELSE xccc903  END  ",               
               ##160520-00002#2 mod--e---
               "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
               "              LEFT JOIN xcbfl_t ON xcbflent='"||g_enterprise||"' AND xcbfl001=xccc002 AND xcbflcomp=xccccomp AND xcbfl002='"||g_dlang||"' ",
               " WHERE xcccent= ",g_enterprise,
               "   AND xccccomp='",tm.xccccomp,"' ",
               "   AND xcccld ='",tm.xcccld,"' ",
               "   AND xccc004= ",tm.xccc004,
               "   AND xccc005= ",tm.xccc005,
               "   AND xccc001='",tm.xccc001,"' ",
               "   AND xccc003='",tm.xccc003,"' ",
               "   AND ",ls_wc   #单身需根据条件筛选资料
       LET g_sql = g_sql, cl_sql_add_filter("xccc_t"),
               " ORDER BY xccc002,xccc006,xccc007,xccc008"
       LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
       PREPARE axcq516_ins_tmp_pre FROM g_sql
       DECLARE axcq516_ins_tmp_cs CURSOR FOR axcq516_ins_tmp_pre
         
       FOREACH axcq516_ins_tmp_cs INTO sr.xccc002,sr.xccc002_desc,sr.xccc006,sr.xccc006_desc,sr.xccc006_desc_1,
                                       sr.xccc007,sr.xccc008,sr.xccc903a,sr.xccc903b,sr.xccc903c,sr.xccc903d,
                                       sr.xccc903e,sr.xccc903f,sr.xccc903g,sr.xccc903h,sr.xccc903

#160520-00002#2
#             #空值显示0
#            IF cl_null(sr.xccc903a) THEN LET sr.xccc903a = 0 END IF
#            IF cl_null(sr.xccc903b) THEN LET sr.xccc903b = 0 END IF
#            IF cl_null(sr.xccc903c) THEN LET sr.xccc903c = 0 END IF
#            IF cl_null(sr.xccc903d) THEN LET sr.xccc903d = 0 END IF 
#            IF cl_null(sr.xccc903e) THEN LET sr.xccc903e = 0 END IF
#            IF cl_null(sr.xccc903f) THEN LET sr.xccc903f = 0 END IF
#            IF cl_null(sr.xccc903g) THEN LET sr.xccc903g = 0 END IF
#            IF cl_null(sr.xccc903h) THEN LET sr.xccc903h = 0 END IF 
#            IF cl_null(sr.xccc903 ) THEN LET sr.xccc903  = 0 END IF
#160520-00002#2
            
            #金额都为0的不显示
            IF sr.xccc903a = 0 AND
               sr.xccc903b = 0 AND
               sr.xccc903c = 0 AND
               sr.xccc903d = 0 AND 
               sr.xccc903e = 0 AND
               sr.xccc903f = 0 AND
               sr.xccc903g = 0 AND
               sr.xccc903h = 0 AND 
               sr.xccc903  = 0 THEN
               CONTINUE FOREACH
            END IF
           
            INSERT INTO axcq516_tmp ( xccc002,xccc002_desc,xccc006,xccc006_desc,xccc006_desc_1,xccc007,xccc008,xccc903a, 
                                      xccc903b,xccc903c,xccc903d,xccc903e,xccc903f,xccc903g,xccc903h,xccc903,xccccomp, 
                                      xcccld,xccc001,xccc004,xccc003,xccc005,xccccomp_desc,xcccld_desc,xccc001_desc,xccc004_desc, 
                                      xccc003_desc,xccc005_desc,xccc_key)
                             VALUES ( sr.xccc002,sr.xccc002_desc,sr.xccc006,sr.xccc006_desc,sr.xccc006_desc_1,sr.xccc007,sr.xccc008,
                                      sr.xccc903a,sr.xccc903b,sr.xccc903c,sr.xccc903d,sr.xccc903e,sr.xccc903f,sr.xccc903g,sr.xccc903h,
                                      sr.xccc903,sr.xccccomp,sr.xcccld,sr.xccc001,sr.xccc004,sr.xccc003,sr.xccc005,sr.xccccomp_desc,
                                      sr.xcccld_desc,sr.xccc001_desc,sr.xccc004_desc,sr.xccc003_desc,sr.xccc005_desc,sr.xccc_key)
          
            IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'insert axcq_tmp'
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET l_success = FALSE
             END IF
          
          
         END FOREACH
         
         CALL cl_err_collect_show()
         IF l_success = FALSE THEN
           DELETE FROM axcq516_tmp
         END IF
   END FOR
END FUNCTION

 
{</section>}
 
