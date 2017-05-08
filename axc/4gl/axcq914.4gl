#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq914.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-03-22 11:23:03), PR版次:0002(2016-10-26 14:24:07)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000027
#+ Filename...: axcq914
#+ Description: 盤盈虧成本查詢作業(零售）
#+ Creator....: 07673(2016-01-07 17:07:21)
#+ Modifier...: 07673 -SD/PR- 02040
 
{</section>}
 
{<section id="axcq914.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151130-00003#14 By Dorislai  加入二次查詢
#160106-00004#1  By Dorislai  盤盈虧數量加上小計加總，及修正報表印不出來的狀況
#160802-00020#9   2016/09/26  By 02097    法人:視azzi800的据點權限/帳套: 視USER的帳套權限/QBE下法人/帳套不用互相勾稽
#161019-00017#10  2016/10/26  By 08734    调整组织开窗由q_ooef001_14变为q_ooef001_1
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
   xcck028 LIKE xcck_t.xcck028, 
   xcck028_desc LIKE type_t.chr500, 
   xcck006 LIKE xcck_t.xcck006, 
   xcck007 LIKE xcck_t.xcck007, 
   xcck008 LIKE xcck_t.xcck008, 
   xcck010 LIKE xcck_t.xcck010, 
   xcck010_desc LIKE type_t.chr500, 
   xcck010_desc_desc LIKE type_t.chr500, 
   xcck011 LIKE xcck_t.xcck011, 
   xcck015 LIKE xcck_t.xcck015, 
   xcck015_desc LIKE type_t.chr500, 
   xcck017 LIKE xcck_t.xcck017, 
   xcck002 LIKE xcck_t.xcck002, 
   xcck002_desc LIKE type_t.chr500, 
   xcck009 LIKE xcck_t.xcck009, 
   xcck044 LIKE xcck_t.xcck044, 
   xcck044_desc LIKE type_t.chr500, 
   xcck201 LIKE xcck_t.xcck201, 
   xcck282a LIKE xcck_t.xcck282a, 
   xcck282b LIKE xcck_t.xcck282b, 
   xcck282c LIKE xcck_t.xcck282c, 
   xcck282d LIKE xcck_t.xcck282d, 
   xcck282e LIKE xcck_t.xcck282e, 
   xcck282f LIKE xcck_t.xcck282f, 
   xcck282g LIKE xcck_t.xcck282g, 
   xcck282h LIKE xcck_t.xcck282h, 
   xcck282 LIKE xcck_t.xcck282, 
   xcck202a LIKE xcck_t.xcck202a, 
   xcck202b LIKE xcck_t.xcck202b, 
   xcck202c LIKE xcck_t.xcck202c, 
   xcck202d LIKE xcck_t.xcck202d, 
   xcck202e LIKE xcck_t.xcck202e, 
   xcck202f LIKE xcck_t.xcck202f, 
   xcck202g LIKE xcck_t.xcck202g, 
   xcck202h LIKE xcck_t.xcck202h, 
   xcck202 LIKE xcck_t.xcck202 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_tm RECORD
                     xcckcomp   LIKE xcck_t.xcckcomp,  #法人組織
                     xcckcomp_desc LIKE type_t.chr80,
                     xcckld     LIKE xcck_t.xcckld  ,  #帳別編號
                     xcckld_desc   LIKE type_t.chr80,
                     xcck004    LIKE xcck_t.xcck004 ,  #年度
                     xcck005    LIKE xcck_t.xcck005 ,  #期別
                     xcck001    LIKE xcck_t.xcck001 ,  #本位币顺序
                     xcck001_desc  LIKE type_t.chr80,  #本位币说明
                     xcck003    LIKE xcck_t.xcck003 ,  #成本計算類型
                     xcck003_desc  LIKE type_t.chr80,   
                     xcck004_1  LIKE xcck_t.xcck004,  #截止年度   #150805-00001#12add
                     xcck005_1  LIKE xcck_t.xcck005   #截止期別   #150805-00001#12add
                     END RECORD
DEFINE tm            type_tm
DEFINE g_fetch       LIKE type_t.chr1

DEFINE g_page_cnt        LIKE type_t.num5   #總页數
DEFINE g_page_idx        LIKE type_t.num5   #当页笔数
#DEFINE g_detail_idx         LIKE type_t.num5   #当行
#DEFINE g_detail_cnt         LIKE type_t.num5   #总行

DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_para_data           LIKE type_t.chr80     #采用成本域否  #fengmy150123
DEFINE g_para_data1          LIKE type_t.chr80     #采用特性否    #fengmy150123
#dujuan150324
 TYPE type_g_glfb_e RECORD
       v          STRING
       END RECORD
DEFINE g_param                     type_g_glfb_e  

#20150806--add--str--lujh
 TYPE type_g_xcck2_d RECORD
       xcck028 LIKE xcck_t.xcck028, 
   xcck028_2_desc LIKE type_t.chr500, 
   xcck202 LIKE xcck_t.xcck202
       END RECORD
       
DEFINE g_xcck2_d   DYNAMIC ARRAY OF type_g_xcck2_d
DEFINE g_xcck2_d_t type_g_xcck2_d
#20150806--add--end--lujh
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
DEFINE xccksite LIKE xcck_t.xccksite   #add BY chenhz 15/10/26
DEFINE l_sdate          LIKE xcck_t.xcck013
DEFINE l_edate          LIKE xcck_t.xcck013

#add by chenhz 15/12/04(s) 增加保留上次查询条件功能
TYPE type_g_tm RECORD   #添加一个数组，用于保存上一次查询的条件
    xcckcomp   STRING,
    xcckld     STRING,
    xcck001    STRING,
    xcck003    STRING,
    xccksite   STRING, 
    xcck002    STRING,
    xcck010    STRING,
    xcck028    STRING,
    xcck017    STRING,
    xcck006    STRING, 
    l_sdate   LIKE type_t.dat,
    l_edate   LIKE type_t.dat

END RECORD

DEFINE g_tm             type_g_tm
#end add-point
 
{</section>}
 
{<section id="axcq914.main" >}
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
   DECLARE axcq914_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq914_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq914_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq914 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq914_init()   
 
      #進入選單 Menu (="N")
      CALL axcq914_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq914
      
   END IF 
   
   CLOSE axcq914_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq914.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axcq914_init()
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
   CALL cl_set_combo_scc('b_xcck001','8914')
   #fengmy 150123----begin
   #根據參數顯示隱藏成本域 和 料件特性
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1  #采用特性否       
         
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('b_xcck002,b_xcck002_desc',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('b_xcck002,b_xcck002_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('b_xcck011',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('b_xcck011',FALSE)                
   END IF 
   #fengmy 150123----end 
   INITIALIZE g_tm.* TO NULL    #add by chenhz 15/12/04 对单头条件整个数组的值初始化  
   #end add-point
 
   CALL axcq914_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axcq914.default_search" >}
PRIVATE FUNCTION axcq914_default_search()
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
 
{<section id="axcq914.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axcq914_ui_dialog()
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
      CALL axcq914_b_fill()
   ELSE
      CALL axcq914_query()
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
 
         CALL axcq914_init()
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
               CALL axcq914_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL axcq914_detail_action_trans()
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
         #20150806--add--str--lujh
         DISPLAY ARRAY g_xcck2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_xcck2_d.getLength() TO FORMONLY.h_count
               CALL axcq914_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row
         
               #end add-point  
         
            #自訂ACTION(detail_show,page_2)
            
            #add-point:page2自定義行為
         
            #end add-point
         END DISPLAY
         #20150806--add--end--lujh
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axcq914_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_navigator_setting(g_page_idx, g_page_cnt)  #設定ToolBar上瀏覽上下筆資料的按鈕狀態
            NEXT FIELD xcck028_2          #20150806 add lujh
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #20150325 By dujuan    add
                  #創建臨時表
                  CALL axcq914_create_temp_table()
                  #為臨時表加數據
                  CALL axcq914_get_date()
                  LET g_param.v = "axcq914_tmp"
                  CALL axcq514_x01(" 1=1",g_param.v)   
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
                  CALL axcq914_create_temp_table()
                  #為臨時表加數據
                  CALL axcq914_get_date()
                  LET g_param.v = "axcq914_tmp"
                  CALL axcq514_x01(" 1=1",g_param.v)   
               #20150325 By dujuan    end  
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq914_query()
               #add-point:ON ACTION query name="menu.query"
               NEXT FIELD xcck028_2          #20150806 add lujh
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
            CALL axcq914_filter()
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
            CALL axcq914_b_fill()
 
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
            CALL axcq914_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axcq914_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axcq914_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axcq914_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION first
            LET g_fetch = 'F'
            CALL axcq914_fetch()

         ON ACTION previous
            LET g_fetch = 'P'
            CALL axcq914_fetch()

         ON ACTION jump
            LET g_fetch = '/'
            CALL axcq914_fetch()

         ON ACTION next
            LET g_fetch = 'N'
            CALL axcq914_fetch()

         ON ACTION last
            LET g_fetch = 'L'
            CALL axcq914_fetch()
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
 
{<section id="axcq914.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq914_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   CALL axcq914_query2()
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
      CONSTRUCT g_wc_table ON xccksite,xcck028,xcck006,xcck007,xcck008,xcck010,xcck011,xcck015,xcck017, 
          xcck002,xcck009,xcck044,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g, 
          xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202 
 
           FROM s_detail1[1].b_xccksite,s_detail1[1].b_xcck028,s_detail1[1].b_xcck006,s_detail1[1].b_xcck007, 
               s_detail1[1].b_xcck008,s_detail1[1].b_xcck010,s_detail1[1].b_xcck011,s_detail1[1].b_xcck015, 
               s_detail1[1].b_xcck017,s_detail1[1].b_xcck002,s_detail1[1].b_xcck009,s_detail1[1].b_xcck044, 
               s_detail1[1].b_xcck201,s_detail1[1].b_xcck282a,s_detail1[1].b_xcck282b,s_detail1[1].b_xcck282c, 
               s_detail1[1].b_xcck282d,s_detail1[1].b_xcck282e,s_detail1[1].b_xcck282f,s_detail1[1].b_xcck282g, 
               s_detail1[1].b_xcck282h,s_detail1[1].b_xcck282,s_detail1[1].b_xcck202a,s_detail1[1].b_xcck202b, 
               s_detail1[1].b_xcck202c,s_detail1[1].b_xcck202d,s_detail1[1].b_xcck202e,s_detail1[1].b_xcck202f, 
               s_detail1[1].b_xcck202g,s_detail1[1].b_xcck202h,s_detail1[1].b_xcck202
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_xccksite>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xccksite
            #add-point:BEFORE FIELD b_xccksite name="construct.b.page1.b_xccksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xccksite
            
            #add-point:AFTER FIELD b_xccksite name="construct.a.page1.b_xccksite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xccksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccksite
            #add-point:ON ACTION controlp INFIELD b_xccksite name="construct.c.page1.b_xccksite"
            
            #END add-point
 
 
         #----<<b_xccksite_desc>>----
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
         #----<<b_xcck010_desc_desc>>----
         #----<<b_xcck011>>----
         #Ctrlp:construct.c.page1.b_xcck011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck011
            #add-point:ON ACTION controlp INFIELD b_xcck011 name="construct.c.page1.b_xcck011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcck011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck011  #顯示到畫面上
            NEXT FIELD b_xcck011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck011
            #add-point:BEFORE FIELD b_xcck011 name="construct.b.page1.b_xcck011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck011
            
            #add-point:AFTER FIELD b_xcck011 name="construct.a.page1.b_xcck011"
            
            #END add-point
            
 
 
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
 
 
         #----<<b_xcck044>>----
         #Ctrlp:construct.c.page1.b_xcck044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck044
            #add-point:ON ACTION controlp INFIELD b_xcck044 name="construct.c.page1.b_xcck044"
            #此段落由子樣板a08產生
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
 
 
         #----<<b_xcck282a>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck282a
            #add-point:BEFORE FIELD b_xcck282a name="construct.b.page1.b_xcck282a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck282a
            
            #add-point:AFTER FIELD b_xcck282a name="construct.a.page1.b_xcck282a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck282a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282a
            #add-point:ON ACTION controlp INFIELD b_xcck282a name="construct.c.page1.b_xcck282a"
            
            #END add-point
 
 
         #----<<b_xcck282b>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck282b
            #add-point:BEFORE FIELD b_xcck282b name="construct.b.page1.b_xcck282b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck282b
            
            #add-point:AFTER FIELD b_xcck282b name="construct.a.page1.b_xcck282b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck282b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282b
            #add-point:ON ACTION controlp INFIELD b_xcck282b name="construct.c.page1.b_xcck282b"
            
            #END add-point
 
 
         #----<<b_xcck282c>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck282c
            #add-point:BEFORE FIELD b_xcck282c name="construct.b.page1.b_xcck282c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck282c
            
            #add-point:AFTER FIELD b_xcck282c name="construct.a.page1.b_xcck282c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck282c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282c
            #add-point:ON ACTION controlp INFIELD b_xcck282c name="construct.c.page1.b_xcck282c"
            
            #END add-point
 
 
         #----<<b_xcck282d>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck282d
            #add-point:BEFORE FIELD b_xcck282d name="construct.b.page1.b_xcck282d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck282d
            
            #add-point:AFTER FIELD b_xcck282d name="construct.a.page1.b_xcck282d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck282d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282d
            #add-point:ON ACTION controlp INFIELD b_xcck282d name="construct.c.page1.b_xcck282d"
            
            #END add-point
 
 
         #----<<b_xcck282e>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck282e
            #add-point:BEFORE FIELD b_xcck282e name="construct.b.page1.b_xcck282e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck282e
            
            #add-point:AFTER FIELD b_xcck282e name="construct.a.page1.b_xcck282e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck282e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282e
            #add-point:ON ACTION controlp INFIELD b_xcck282e name="construct.c.page1.b_xcck282e"
            
            #END add-point
 
 
         #----<<b_xcck282f>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck282f
            #add-point:BEFORE FIELD b_xcck282f name="construct.b.page1.b_xcck282f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck282f
            
            #add-point:AFTER FIELD b_xcck282f name="construct.a.page1.b_xcck282f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck282f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282f
            #add-point:ON ACTION controlp INFIELD b_xcck282f name="construct.c.page1.b_xcck282f"
            
            #END add-point
 
 
         #----<<b_xcck282g>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck282g
            #add-point:BEFORE FIELD b_xcck282g name="construct.b.page1.b_xcck282g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck282g
            
            #add-point:AFTER FIELD b_xcck282g name="construct.a.page1.b_xcck282g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck282g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282g
            #add-point:ON ACTION controlp INFIELD b_xcck282g name="construct.c.page1.b_xcck282g"
            
            #END add-point
 
 
         #----<<b_xcck282h>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck282h
            #add-point:BEFORE FIELD b_xcck282h name="construct.b.page1.b_xcck282h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck282h
            
            #add-point:AFTER FIELD b_xcck282h name="construct.a.page1.b_xcck282h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck282h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282h
            #add-point:ON ACTION controlp INFIELD b_xcck282h name="construct.c.page1.b_xcck282h"
            
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
 
 
         #----<<b_xcck202a>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck202a
            #add-point:BEFORE FIELD b_xcck202a name="construct.b.page1.b_xcck202a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck202a
            
            #add-point:AFTER FIELD b_xcck202a name="construct.a.page1.b_xcck202a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck202a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202a
            #add-point:ON ACTION controlp INFIELD b_xcck202a name="construct.c.page1.b_xcck202a"
            
            #END add-point
 
 
         #----<<b_xcck202b>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck202b
            #add-point:BEFORE FIELD b_xcck202b name="construct.b.page1.b_xcck202b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck202b
            
            #add-point:AFTER FIELD b_xcck202b name="construct.a.page1.b_xcck202b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck202b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202b
            #add-point:ON ACTION controlp INFIELD b_xcck202b name="construct.c.page1.b_xcck202b"
            
            #END add-point
 
 
         #----<<b_xcck202c>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck202c
            #add-point:BEFORE FIELD b_xcck202c name="construct.b.page1.b_xcck202c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck202c
            
            #add-point:AFTER FIELD b_xcck202c name="construct.a.page1.b_xcck202c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck202c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202c
            #add-point:ON ACTION controlp INFIELD b_xcck202c name="construct.c.page1.b_xcck202c"
            
            #END add-point
 
 
         #----<<b_xcck202d>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck202d
            #add-point:BEFORE FIELD b_xcck202d name="construct.b.page1.b_xcck202d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck202d
            
            #add-point:AFTER FIELD b_xcck202d name="construct.a.page1.b_xcck202d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck202d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202d
            #add-point:ON ACTION controlp INFIELD b_xcck202d name="construct.c.page1.b_xcck202d"
            
            #END add-point
 
 
         #----<<b_xcck202e>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck202e
            #add-point:BEFORE FIELD b_xcck202e name="construct.b.page1.b_xcck202e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck202e
            
            #add-point:AFTER FIELD b_xcck202e name="construct.a.page1.b_xcck202e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck202e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202e
            #add-point:ON ACTION controlp INFIELD b_xcck202e name="construct.c.page1.b_xcck202e"
            
            #END add-point
 
 
         #----<<b_xcck202f>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck202f
            #add-point:BEFORE FIELD b_xcck202f name="construct.b.page1.b_xcck202f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck202f
            
            #add-point:AFTER FIELD b_xcck202f name="construct.a.page1.b_xcck202f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck202f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202f
            #add-point:ON ACTION controlp INFIELD b_xcck202f name="construct.c.page1.b_xcck202f"
            
            #END add-point
 
 
         #----<<b_xcck202g>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck202g
            #add-point:BEFORE FIELD b_xcck202g name="construct.b.page1.b_xcck202g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck202g
            
            #add-point:AFTER FIELD b_xcck202g name="construct.a.page1.b_xcck202g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck202g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202g
            #add-point:ON ACTION controlp INFIELD b_xcck202g name="construct.c.page1.b_xcck202g"
            
            #END add-point
 
 
         #----<<b_xcck202h>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcck202h
            #add-point:BEFORE FIELD b_xcck202h name="construct.b.page1.b_xcck202h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcck202h
            
            #add-point:AFTER FIELD b_xcck202h name="construct.a.page1.b_xcck202h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcck202h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202h
            #add-point:ON ACTION controlp INFIELD b_xcck202h name="construct.c.page1.b_xcck202h"
            
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
   CALL axcq914_b_fill()
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
 
{<section id="axcq914.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq914_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE ls_sql2          STRING   #160802-00020#9
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL axcq914_create_temp_table()  
#  IF cl_null(g_wc_filter) THEN
#      LET g_wc_filter = " 1=1"
#   END IF
#   IF cl_null(g_wc) THEN
#      LET g_wc = " 1=1"
#   END IF
#   LET g_wc = g_wc," AND (xcck004*12+xcck005 BETWEEN ",tm.xcck004,"*12+",tm.xcck005," AND ",tm.xcck004_1,"*12+",tm.xcck005_1,")"    #150805-00001#12add 
#              
#   IF cl_null(g_wc2) THEN
#      LET g_wc2 = " 1=1"
#   END IF
#   
#   LET ls_wc = g_wc," AND ", g_wc2, " AND ", g_wc_filter," AND xcck055 = '311'" #盘盈亏
#
#
#   #显示资料
#   #抓出单头资料
#   LET g_sql = "SELECT UNIQUE xcckcomp,ooefl003,xcckld,glaal002, '",tm.xcck004,"' xcck004,'",tm.xcck005,"' xcck005,",
#               "              xcck001,' ' xcck001_desc,xcck003,xcatl003, '",tm.xcck004_1,"' xcck004_1,'",tm.xcck005_1,"' xcck005_1",   #150805-00001#12add
#               "  FROM xcck_t LEFT JOIN ooefl_t ON ooeflent='"||g_enterprise||"' AND ooefl001=xcckcomp AND ooefl002='"||g_dlang||"' ",
#               "              LEFT JOIN glaal_t ON glaalent='"||g_enterprise||"' AND glaalld=xcckld AND glaal001='"||g_dlang||"' ",
#              "               LEFT JOIN xcatl_t ON xcatlent='"||g_enterprise||"' AND xcatl001=xcck003 AND xcatl002='"||g_dlang||"' ",
#               " WHERE xcckent = ",g_enterprise,
#               "   AND ",ls_wc
#   LET g_sql = g_sql, cl_sql_add_filter("xcck_t"),  #額外的過濾條件
#              " ORDER BY xcckcomp,xcckld,xcck004,xcck005,xcck001,xcck003 "
#   PREPARE axcq914_prepare FROM g_sql      #預備一下
#   DECLARE axcq914_b_curs                  #宣告成可捲動的
#       SCROLL CURSOR WITH HOLD FOR axcq914_prepare
#
#   #抓出資料筆數
#   #151130-00003#14-mod-(S)  拿掉|xcck004||xcck005
#   #原本年度期別只有一欄，現在年度期別變區間，這部分需更改，例子：
#   #若單頭條件下，xcckcomp=DSCNJ,xcckld=03,xcck004||xcck005=2014/1-2015/12,xcck001=1,xcck002=RT01
#   #xcckcomp  xcckld   xcck004   xcck005   xcck001   xcck002
#   #--------------------------------------------------------------
#   # DSCNJ      03       2014      1         1         RT01
#   # DSCNJ      03       2014      12        1         RT01
#   #原本的會造成單頭有兩筆資料，改完後，資料會在同一筆單中
##   LET g_sql = "SELECT COUNT(DISTINCT xcckcomp||xcckld||xcck004||xcck005||xcck001||xcck003) ", 
#   LET g_sql = "SELECT COUNT(DISTINCT xcckcomp||xcckld||xcck001||xcck003) ",
#   #151130-00003#14-mod-(E)
#               "  FROM xcck_t",
#               " WHERE xcckent = ",g_enterprise,
#               "   AND ",ls_wc
#   LET g_sql = g_sql, cl_sql_add_filter("xcck_t")   #額外的過濾條件
#   PREPARE axcq914_precount FROM g_sql
#   DECLARE axcq914_count CURSOR FOR axcq914_precount
#
#   OPEN axcq914_b_curs         #抓出单头唯一性资料
#   IF SQLCA.sqlcode THEN                    #有問題
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.extend = "open axcq914_b_curs"
#      LET g_errparam.code   = SQLCA.sqlcode
#      LET g_errparam.popup  = FALSE
#      CALL cl_err()
#      INITIALIZE tm.* TO NULL
#   ELSE
#      #显示总页数
#      OPEN axcq914_count
#      FETCH axcq914_count INTO g_page_cnt
#      DISPLAY g_page_cnt TO FORMONLY.h_count  #总页数
#
#
#      LET g_fetch = 'F'
#      CALL axcq914_fetch()  #显示第一笔
#      
#      #未获取资料
#      IF g_page_cnt = 0 THEN
#         LET g_page_idx = ''  #当页
#         DISPLAY g_page_idx TO FORMONLY.h_index  #当页
#      END IF
#   END IF
#   
#   RETURN
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
 
   LET ls_sql_rank = "SELECT  UNIQUE xccksite,'',xcck028,'',xcck006,xcck007,xcck008,xcck010,'','',xcck011, 
       xcck015,'',xcck017,xcck002,'',xcck009,xcck044,'',xcck201,xcck282a,xcck282b,xcck282c,xcck282d, 
       xcck282e,xcck282f,xcck282g,xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f, 
       xcck202g,xcck202h,xcck202  ,DENSE_RANK() OVER( ORDER BY xcck_t.xcckld,xcck_t.xcck001,xcck_t.xcck002, 
       xcck_t.xcck003,xcck_t.xcck004,xcck_t.xcck005,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009) AS RANK FROM xcck_t", 
 
 
 
                     "",
                     " WHERE xcckent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xcck_t"),
                     " ORDER BY xcck_t.xcckld,xcck_t.xcck001,xcck_t.xcck002,xcck_t.xcck003,xcck_t.xcck004,xcck_t.xcck005,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
    LET ls_sql_rank = " SELECT  UNIQUE xcckent,xccksite,t1.ooefl003,xcck028,t2.rtaxl003,xcck006,xcck007,xcck008,xcck010,t9.imaal003,t9.imaal004,xcck011, 
                       xcck015,t10.inayl003,xcck017,xcck002,t3.xcbfl003,xcck009,xcck044,t11.oocal003,xcck201*xcck009,xcck282a,xcck282b,xcck282c,xcck282d, 
                       xcck282e,xcck282f,xcck282g,xcck282h,xcck282*xcck009,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f, 
                       xcck202g,xcck202h,xcck202*xcck009  ",
                     " FROM xcck_t", 
                     " LEFT JOIN ooefl_t t1 ON t1.ooefl001 = xccksite AND t1.ooeflent = xcckent AND t1.ooefl002 = '",g_dlang,"'",
                     " LEFT JOIN rtaxl_t t2 ON t2.rtaxl001 = xcck028  AND t2.rtaxlent = xcckent AND t2.rtaxl002 = '",g_dlang,"'",
                     " LEFT JOIN xcbfl_t t3 ON t3.xcbfl001 = xcck002  AND t3.xcbflent = xcckent AND t3.xcbfl002 = '",g_dlang,"'",
                     " LEFT JOIN imaal_t t9 ON t9.imaal001 = xcck010  AND t9.imaalent = xcckent AND t9.imaal002 = '",g_dlang,"'",
                     " LEFT JOIN inayl_t t10 ON t10.inayl001 = xcck015 AND t10.inaylent = xcckent AND t10.inayl002 = '",g_dlang,"'",
                     " LEFT JOIN oocal_t t11 ON t11.oocal001 = xcck044 AND t11.oocalent = xcckent AND t11.oocal002 = '",g_dlang,"'",
                     "",
                     " WHERE xcckent= ",g_enterprise," AND 1=1 AND ", ls_wc,
                     "   AND xcck013 BETWEEN to_date('",l_sdate,"','yy/mm/dd') AND to_date('",l_edate,"','yy/mm/dd')  " ,
                     "   AND xcck055 = '311'"  

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
                     " ORDER BY xccksite,xcck006,xcck007,xcck008,xcck010"
                     
  LET ls_sql_rank = " INSERT INTO axcq914_tmp ",ls_sql_rank    #将数据插入临时表中 #160802-00020#9 mark
  EXECUTE IMMEDIATE ls_sql_rank 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ERROR:" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF   
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
 
   LET g_sql = "SELECT xccksite,'',xcck028,'',xcck006,xcck007,xcck008,xcck010,'','',xcck011,xcck015, 
       '',xcck017,xcck002,'',xcck009,xcck044,'',xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e, 
       xcck282f,xcck282g,xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g, 
       xcck202h,xcck202",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT xccksite,ooefl003,xcck028,rtaxl003,xcck006,xcck007,xcck008,xcck010,imaal003,imaal004,xcck011,xcck015, 
                inayl003,xcck017,xcck002,xcbfl003,xcck009,xcck044,oocal003,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e, 
                xcck282f,xcck282g,xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g, 
                xcck202h,xcck202",
               "  FROM axcq914_tmp ", 
               " WHERE xcckent = ?"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq914_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axcq914_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xcck_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xccksite_desc,g_xcck_d[l_ac].xcck028, 
       g_xcck_d[l_ac].xcck028_desc,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008, 
       g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck010_desc,g_xcck_d[l_ac].xcck010_desc_desc,g_xcck_d[l_ac].xcck011, 
       g_xcck_d[l_ac].xcck015,g_xcck_d[l_ac].xcck015_desc,g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck002, 
       g_xcck_d[l_ac].xcck002_desc,g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck044_desc, 
       g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck282a,g_xcck_d[l_ac].xcck282b,g_xcck_d[l_ac].xcck282c, 
       g_xcck_d[l_ac].xcck282d,g_xcck_d[l_ac].xcck282e,g_xcck_d[l_ac].xcck282f,g_xcck_d[l_ac].xcck282g, 
       g_xcck_d[l_ac].xcck282h,g_xcck_d[l_ac].xcck282,g_xcck_d[l_ac].xcck202a,g_xcck_d[l_ac].xcck202b, 
       g_xcck_d[l_ac].xcck202c,g_xcck_d[l_ac].xcck202d,g_xcck_d[l_ac].xcck202e,g_xcck_d[l_ac].xcck202f, 
       g_xcck_d[l_ac].xcck202g,g_xcck_d[l_ac].xcck202h,g_xcck_d[l_ac].xcck202
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
 
      CALL axcq914_detail_show("'1'")      
 
      CALL axcq914_xcck_t_mask()
 
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
   FREE axcq914_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq914_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq914_detail_action_trans()
 
   IF g_xcck_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL axcq914_fetch()
   END IF
   
      CALL axcq914_filter_show('xccksite','b_xccksite')
   CALL axcq914_filter_show('xcck028','b_xcck028')
   CALL axcq914_filter_show('xcck006','b_xcck006')
   CALL axcq914_filter_show('xcck007','b_xcck007')
   CALL axcq914_filter_show('xcck008','b_xcck008')
   CALL axcq914_filter_show('xcck010','b_xcck010')
   CALL axcq914_filter_show('xcck011','b_xcck011')
   CALL axcq914_filter_show('xcck015','b_xcck015')
   CALL axcq914_filter_show('xcck017','b_xcck017')
   CALL axcq914_filter_show('xcck002','b_xcck002')
   CALL axcq914_filter_show('xcck009','b_xcck009')
   CALL axcq914_filter_show('xcck044','b_xcck044')
   CALL axcq914_filter_show('xcck201','b_xcck201')
   CALL axcq914_filter_show('xcck282a','b_xcck282a')
   CALL axcq914_filter_show('xcck282b','b_xcck282b')
   CALL axcq914_filter_show('xcck282c','b_xcck282c')
   CALL axcq914_filter_show('xcck282d','b_xcck282d')
   CALL axcq914_filter_show('xcck282e','b_xcck282e')
   CALL axcq914_filter_show('xcck282f','b_xcck282f')
   CALL axcq914_filter_show('xcck282g','b_xcck282g')
   CALL axcq914_filter_show('xcck282h','b_xcck282h')
   CALL axcq914_filter_show('xcck282','b_xcck282')
   CALL axcq914_filter_show('xcck202a','b_xcck202a')
   CALL axcq914_filter_show('xcck202b','b_xcck202b')
   CALL axcq914_filter_show('xcck202c','b_xcck202c')
   CALL axcq914_filter_show('xcck202d','b_xcck202d')
   CALL axcq914_filter_show('xcck202e','b_xcck202e')
   CALL axcq914_filter_show('xcck202f','b_xcck202f')
   CALL axcq914_filter_show('xcck202g','b_xcck202g')
   CALL axcq914_filter_show('xcck202h','b_xcck202h')
   CALL axcq914_filter_show('xcck202','b_xcck202')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   call axcq914_b2_fill()
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq914.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq914_fetch()
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
#   CASE g_fetch
#      WHEN 'F' FETCH FIRST    axcq914_b_curs INTO tm.*
#               LET g_page_idx = 1
#      WHEN 'L' FETCH LAST     axcq914_b_curs INTO tm.*
#               LET g_page_idx = g_page_cnt
#      WHEN 'P' FETCH PREVIOUS axcq914_b_curs INTO tm.*
#               IF g_page_idx > 1 THEN
#                  LET g_page_idx = g_page_idx - 1
#               END IF
#      WHEN 'N' FETCH NEXT     axcq914_b_curs INTO tm.*
#               IF g_page_idx < g_page_cnt THEN
#                  LET g_page_idx =  g_page_idx + 1
#               END IF
#      WHEN '/'
#          IF (NOT g_no_ask) THEN
#             CALL cl_set_act_visible("accept,cancel", TRUE)
#             CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
#             LET INT_FLAG = 0
#
#             PROMPT ls_msg CLIPPED,': ' FOR g_jump
#                #交談指令共用ACTION
#                &include "common_action.4gl"
#             END PROMPT
#
#             CALL cl_set_act_visible("accept,cancel", FALSE)
#             IF INT_FLAG THEN
#                LET INT_FLAG = 0
#                EXIT CASE
#             END IF
#
#          END IF
#          FETCH ABSOLUTE g_jump axcq914_b_curs INTO tm.*
#          LET g_no_ask = FALSE
#          IF g_jump > 0 AND g_jump <= g_page_cnt THEN
#             LET g_page_idx = g_jump
#          END IF
#
#   END CASE
#   DISPLAY g_page_idx TO FORMONLY.h_index  #当页
#
#   CALL axcq914_show()
#   
#   IF g_detail_cnt < g_detail_idx THEN
#      LET g_detail_idx = g_detail_cnt
#   END IF
#   DISPLAY g_detail_idx TO FORMONLY.idx  #显示当前第几行
#   
#   CALL cl_navigator_setting(g_page_idx, g_page_cnt)  #設定ToolBar上瀏覽上下筆資料的按鈕狀態
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   LET g_fetch = ''
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq914.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq914_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_xcck_d[l_ac].xccksite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xccksite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xccksite_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck010
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck010_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck010_desc
            LET ls_sql = "SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck010_desc_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck010_desc_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck015
            LET ls_sql = "SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck015_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck015_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck002
            LET ls_sql = "SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbfl001=? AND xcbfl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck044
            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck044_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck044_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq914.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axcq914_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   CALL axcq914_filter2()
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
      CONSTRUCT g_wc_filter ON xccksite,xcck028,xcck006,xcck007,xcck008,xcck010,xcck011,xcck015,xcck017, 
          xcck002,xcck009,xcck044,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g, 
          xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202 
 
                          FROM s_detail1[1].b_xccksite,s_detail1[1].b_xcck028,s_detail1[1].b_xcck006, 
                              s_detail1[1].b_xcck007,s_detail1[1].b_xcck008,s_detail1[1].b_xcck010,s_detail1[1].b_xcck011, 
                              s_detail1[1].b_xcck015,s_detail1[1].b_xcck017,s_detail1[1].b_xcck002,s_detail1[1].b_xcck009, 
                              s_detail1[1].b_xcck044,s_detail1[1].b_xcck201,s_detail1[1].b_xcck282a, 
                              s_detail1[1].b_xcck282b,s_detail1[1].b_xcck282c,s_detail1[1].b_xcck282d, 
                              s_detail1[1].b_xcck282e,s_detail1[1].b_xcck282f,s_detail1[1].b_xcck282g, 
                              s_detail1[1].b_xcck282h,s_detail1[1].b_xcck282,s_detail1[1].b_xcck202a, 
                              s_detail1[1].b_xcck202b,s_detail1[1].b_xcck202c,s_detail1[1].b_xcck202d, 
                              s_detail1[1].b_xcck202e,s_detail1[1].b_xcck202f,s_detail1[1].b_xcck202g, 
                              s_detail1[1].b_xcck202h,s_detail1[1].b_xcck202
 
         BEFORE CONSTRUCT
                     DISPLAY axcq914_filter_parser('xccksite') TO s_detail1[1].b_xccksite
            DISPLAY axcq914_filter_parser('xcck028') TO s_detail1[1].b_xcck028
            DISPLAY axcq914_filter_parser('xcck006') TO s_detail1[1].b_xcck006
            DISPLAY axcq914_filter_parser('xcck007') TO s_detail1[1].b_xcck007
            DISPLAY axcq914_filter_parser('xcck008') TO s_detail1[1].b_xcck008
            DISPLAY axcq914_filter_parser('xcck010') TO s_detail1[1].b_xcck010
            DISPLAY axcq914_filter_parser('xcck011') TO s_detail1[1].b_xcck011
            DISPLAY axcq914_filter_parser('xcck015') TO s_detail1[1].b_xcck015
            DISPLAY axcq914_filter_parser('xcck017') TO s_detail1[1].b_xcck017
            DISPLAY axcq914_filter_parser('xcck002') TO s_detail1[1].b_xcck002
            DISPLAY axcq914_filter_parser('xcck009') TO s_detail1[1].b_xcck009
            DISPLAY axcq914_filter_parser('xcck044') TO s_detail1[1].b_xcck044
            DISPLAY axcq914_filter_parser('xcck201') TO s_detail1[1].b_xcck201
            DISPLAY axcq914_filter_parser('xcck282a') TO s_detail1[1].b_xcck282a
            DISPLAY axcq914_filter_parser('xcck282b') TO s_detail1[1].b_xcck282b
            DISPLAY axcq914_filter_parser('xcck282c') TO s_detail1[1].b_xcck282c
            DISPLAY axcq914_filter_parser('xcck282d') TO s_detail1[1].b_xcck282d
            DISPLAY axcq914_filter_parser('xcck282e') TO s_detail1[1].b_xcck282e
            DISPLAY axcq914_filter_parser('xcck282f') TO s_detail1[1].b_xcck282f
            DISPLAY axcq914_filter_parser('xcck282g') TO s_detail1[1].b_xcck282g
            DISPLAY axcq914_filter_parser('xcck282h') TO s_detail1[1].b_xcck282h
            DISPLAY axcq914_filter_parser('xcck282') TO s_detail1[1].b_xcck282
            DISPLAY axcq914_filter_parser('xcck202a') TO s_detail1[1].b_xcck202a
            DISPLAY axcq914_filter_parser('xcck202b') TO s_detail1[1].b_xcck202b
            DISPLAY axcq914_filter_parser('xcck202c') TO s_detail1[1].b_xcck202c
            DISPLAY axcq914_filter_parser('xcck202d') TO s_detail1[1].b_xcck202d
            DISPLAY axcq914_filter_parser('xcck202e') TO s_detail1[1].b_xcck202e
            DISPLAY axcq914_filter_parser('xcck202f') TO s_detail1[1].b_xcck202f
            DISPLAY axcq914_filter_parser('xcck202g') TO s_detail1[1].b_xcck202g
            DISPLAY axcq914_filter_parser('xcck202h') TO s_detail1[1].b_xcck202h
            DISPLAY axcq914_filter_parser('xcck202') TO s_detail1[1].b_xcck202
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_xccksite>>----
         #Ctrlp:construct.c.filter.page1.b_xccksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccksite
            #add-point:ON ACTION controlp INFIELD b_xccksite name="construct.c.filter.page1.b_xccksite"
            
            #END add-point
 
 
         #----<<b_xccksite_desc>>----
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
 
 
         #----<<b_xcck010>>----
         #Ctrlp:construct.c.filter.page1.b_xcck010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck010
            #add-point:ON ACTION controlp INFIELD b_xcck010 name="construct.c.filter.page1.b_xcck010"
            
            #END add-point
 
 
         #----<<b_xcck010_desc>>----
         #----<<b_xcck010_desc_desc>>----
         #----<<b_xcck011>>----
         #Ctrlp:construct.c.page1.b_xcck011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck011
            #add-point:ON ACTION controlp INFIELD b_xcck011 name="construct.c.filter.page1.b_xcck011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xcck011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck011  #顯示到畫面上
            NEXT FIELD b_xcck011                     #返回原欄位
    


            #END add-point
 
 
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
 
 
         #----<<b_xcck002>>----
         #Ctrlp:construct.c.filter.page1.b_xcck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck002
            #add-point:ON ACTION controlp INFIELD b_xcck002 name="construct.c.filter.page1.b_xcck002"
            
            #END add-point
 
 
         #----<<b_xcck002_desc>>----
         #----<<b_xcck009>>----
         #Ctrlp:construct.c.filter.page1.b_xcck009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck009
            #add-point:ON ACTION controlp INFIELD b_xcck009 name="construct.c.filter.page1.b_xcck009"
            
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
 
 
         #----<<b_xcck282a>>----
         #Ctrlp:construct.c.filter.page1.b_xcck282a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282a
            #add-point:ON ACTION controlp INFIELD b_xcck282a name="construct.c.filter.page1.b_xcck282a"
            
            #END add-point
 
 
         #----<<b_xcck282b>>----
         #Ctrlp:construct.c.filter.page1.b_xcck282b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282b
            #add-point:ON ACTION controlp INFIELD b_xcck282b name="construct.c.filter.page1.b_xcck282b"
            
            #END add-point
 
 
         #----<<b_xcck282c>>----
         #Ctrlp:construct.c.filter.page1.b_xcck282c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282c
            #add-point:ON ACTION controlp INFIELD b_xcck282c name="construct.c.filter.page1.b_xcck282c"
            
            #END add-point
 
 
         #----<<b_xcck282d>>----
         #Ctrlp:construct.c.filter.page1.b_xcck282d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282d
            #add-point:ON ACTION controlp INFIELD b_xcck282d name="construct.c.filter.page1.b_xcck282d"
            
            #END add-point
 
 
         #----<<b_xcck282e>>----
         #Ctrlp:construct.c.filter.page1.b_xcck282e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282e
            #add-point:ON ACTION controlp INFIELD b_xcck282e name="construct.c.filter.page1.b_xcck282e"
            
            #END add-point
 
 
         #----<<b_xcck282f>>----
         #Ctrlp:construct.c.filter.page1.b_xcck282f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282f
            #add-point:ON ACTION controlp INFIELD b_xcck282f name="construct.c.filter.page1.b_xcck282f"
            
            #END add-point
 
 
         #----<<b_xcck282g>>----
         #Ctrlp:construct.c.filter.page1.b_xcck282g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282g
            #add-point:ON ACTION controlp INFIELD b_xcck282g name="construct.c.filter.page1.b_xcck282g"
            
            #END add-point
 
 
         #----<<b_xcck282h>>----
         #Ctrlp:construct.c.filter.page1.b_xcck282h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282h
            #add-point:ON ACTION controlp INFIELD b_xcck282h name="construct.c.filter.page1.b_xcck282h"
            
            #END add-point
 
 
         #----<<b_xcck282>>----
         #Ctrlp:construct.c.filter.page1.b_xcck282
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck282
            #add-point:ON ACTION controlp INFIELD b_xcck282 name="construct.c.filter.page1.b_xcck282"
            
            #END add-point
 
 
         #----<<b_xcck202a>>----
         #Ctrlp:construct.c.filter.page1.b_xcck202a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202a
            #add-point:ON ACTION controlp INFIELD b_xcck202a name="construct.c.filter.page1.b_xcck202a"
            
            #END add-point
 
 
         #----<<b_xcck202b>>----
         #Ctrlp:construct.c.filter.page1.b_xcck202b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202b
            #add-point:ON ACTION controlp INFIELD b_xcck202b name="construct.c.filter.page1.b_xcck202b"
            
            #END add-point
 
 
         #----<<b_xcck202c>>----
         #Ctrlp:construct.c.filter.page1.b_xcck202c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202c
            #add-point:ON ACTION controlp INFIELD b_xcck202c name="construct.c.filter.page1.b_xcck202c"
            
            #END add-point
 
 
         #----<<b_xcck202d>>----
         #Ctrlp:construct.c.filter.page1.b_xcck202d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202d
            #add-point:ON ACTION controlp INFIELD b_xcck202d name="construct.c.filter.page1.b_xcck202d"
            
            #END add-point
 
 
         #----<<b_xcck202e>>----
         #Ctrlp:construct.c.filter.page1.b_xcck202e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202e
            #add-point:ON ACTION controlp INFIELD b_xcck202e name="construct.c.filter.page1.b_xcck202e"
            
            #END add-point
 
 
         #----<<b_xcck202f>>----
         #Ctrlp:construct.c.filter.page1.b_xcck202f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202f
            #add-point:ON ACTION controlp INFIELD b_xcck202f name="construct.c.filter.page1.b_xcck202f"
            
            #END add-point
 
 
         #----<<b_xcck202g>>----
         #Ctrlp:construct.c.filter.page1.b_xcck202g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202g
            #add-point:ON ACTION controlp INFIELD b_xcck202g name="construct.c.filter.page1.b_xcck202g"
            
            #END add-point
 
 
         #----<<b_xcck202h>>----
         #Ctrlp:construct.c.filter.page1.b_xcck202h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck202h
            #add-point:ON ACTION controlp INFIELD b_xcck202h name="construct.c.filter.page1.b_xcck202h"
            
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
   
      CALL axcq914_filter_show('xccksite','b_xccksite')
   CALL axcq914_filter_show('xcck028','b_xcck028')
   CALL axcq914_filter_show('xcck006','b_xcck006')
   CALL axcq914_filter_show('xcck007','b_xcck007')
   CALL axcq914_filter_show('xcck008','b_xcck008')
   CALL axcq914_filter_show('xcck010','b_xcck010')
   CALL axcq914_filter_show('xcck011','b_xcck011')
   CALL axcq914_filter_show('xcck015','b_xcck015')
   CALL axcq914_filter_show('xcck017','b_xcck017')
   CALL axcq914_filter_show('xcck002','b_xcck002')
   CALL axcq914_filter_show('xcck009','b_xcck009')
   CALL axcq914_filter_show('xcck044','b_xcck044')
   CALL axcq914_filter_show('xcck201','b_xcck201')
   CALL axcq914_filter_show('xcck282a','b_xcck282a')
   CALL axcq914_filter_show('xcck282b','b_xcck282b')
   CALL axcq914_filter_show('xcck282c','b_xcck282c')
   CALL axcq914_filter_show('xcck282d','b_xcck282d')
   CALL axcq914_filter_show('xcck282e','b_xcck282e')
   CALL axcq914_filter_show('xcck282f','b_xcck282f')
   CALL axcq914_filter_show('xcck282g','b_xcck282g')
   CALL axcq914_filter_show('xcck282h','b_xcck282h')
   CALL axcq914_filter_show('xcck282','b_xcck282')
   CALL axcq914_filter_show('xcck202a','b_xcck202a')
   CALL axcq914_filter_show('xcck202b','b_xcck202b')
   CALL axcq914_filter_show('xcck202c','b_xcck202c')
   CALL axcq914_filter_show('xcck202d','b_xcck202d')
   CALL axcq914_filter_show('xcck202e','b_xcck202e')
   CALL axcq914_filter_show('xcck202f','b_xcck202f')
   CALL axcq914_filter_show('xcck202g','b_xcck202g')
   CALL axcq914_filter_show('xcck202h','b_xcck202h')
   CALL axcq914_filter_show('xcck202','b_xcck202')
 
    
   CALL axcq914_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq914.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axcq914_filter_parser(ps_field)
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
 
{<section id="axcq914.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axcq914_filter_show(ps_field,ps_object)
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
   LET ls_condition = axcq914_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq914.insert" >}
#+ insert
PRIVATE FUNCTION axcq914_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axcq914.modify" >}
#+ modify
PRIVATE FUNCTION axcq914_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq914.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axcq914_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq914.delete" >}
#+ delete
PRIVATE FUNCTION axcq914_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq914.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axcq914_detail_action_trans()
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
 
{<section id="axcq914.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axcq914_detail_index_setting()
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
 
{<section id="axcq914.mask_functions" >}
 &include "erp/axc/axcq914_mask.4gl"
 
{</section>}
 
{<section id="axcq914.other_function" readonly="Y" >}

#查询，pattern不支持功能需求，用此代替pattern
PRIVATE FUNCTION axcq914_query2()
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
   CALL g_xcck_d.clear()
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   LET g_wc_filter = " 1=1"
   
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1

   #CALL axcq914_default()  #查询前预设   #150805-00001#12mark
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
     

      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON xcckcomp,xcckld,xcck001,xcck003,
                              xccksite,xcck002,xcck010,xcck028,xcck017,xcck006  #add by chenhz 15/10/26 单头增加查询条件
                           
           FROM b_xcckcomp,b_xcckld,b_xcck001,b_xcck003,
                xccksite,xcck002,xcck010,xcck028,xcck017,xcck006  #add by chenhz 15/10/26 单头增加查询条件
           
                      
         BEFORE CONSTRUCT
            DISPLAY tm.xcckcomp,tm.xcckld,tm.xcck001,tm.xcck003
                 TO b_xcckcomp,b_xcckld,b_xcck001,b_xcck003
            DISPLAY tm.xcckcomp_desc TO b_xcckcomp_desc   #法人組織 
            DISPLAY tm.xcckld_desc TO b_xcckld_desc     #帳別編號
            DISPLAY tm.xcck003_desc  TO b_xcck003_desc    #成本計算類型
            #DISPLAY tm.xcck001_desc TO b_xcck001_desc
         #--单头开窗
         ON ACTION controlp INFIELD b_xcckcomp #法人组织
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
            CALL q_ooef001_2()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcckcomp  #顯示到畫面上
            NEXT FIELD b_xcckcomp                     #返回原欄位

         ON ACTION controlp INFIELD b_xcckld   #账别编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #160802-00020#9-s-add
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#9-e-add             
            CALL q_authorised_ld()                #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcckld  #顯示到畫面上
            NEXT FIELD b_xcckld                     #返回原欄位
 
         ON ACTION controlp INFIELD b_xcck003   #成本计算类型
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck003  #顯示到畫面上
            NEXT FIELD b_xcck003                     #返回原欄位

         #--单身开窗
         #add by chenhz 15/10/26(s) 单头增加开窗            
         ON ACTION controlp INFIELD xccksite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'xccksite',g_site,'c')   
            CALL q_ooef001_24() 
            DISPLAY g_qryparam.return1 TO xccksite  #顯示到畫面上
            NEXT FIELD xccksite                     #返回原欄位
            
         ON ACTION controlp INFIELD xcck006
            #盘点单号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xcck006 LIKE '%N808%' "
            CALL q_xcck006()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck006  #顯示到畫面上
            NEXT FIELD xcck006                     #返回原欄位

         ON ACTION controlp INFIELD xcck010
            #料号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck010  #顯示到畫面上
            NEXT FIELD xcck010                     #返回原欄位
            
         ON ACTION controlp INFIELD xcck002
            #成本域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck002  #顯示到畫面上
            NEXT FIELD xcck002                     #返回原欄位
            
         ON ACTION controlp INFIELD xcck028
            #品类
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " rtax004 ='",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"   #获取单前层级
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck028
 
         ON ACTION controlp INFIELD xcck017
            #批号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcck017()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck017  #顯示到畫面上
            NEXT FIELD xcck017                     #返回原欄位 
#add by chenhz 15/10/26(e)
         ON ACTION controlp INFIELD b_xccksite
            #组织
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
           # CALL q_ooef001_14()                           #呼叫開窗  #161019-00017#10  2016/10/26  By 08734  mark
            CALL q_ooef001_1()    #161019-00017#10  2016/10/26  By 08734  add
            DISPLAY g_qryparam.return1 TO b_xccksite  #顯示到畫面上
            NEXT FIELD b_xccksite                     #返回原欄位

         ON ACTION controlp INFIELD b_xcck006
            #盘点单号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " inpdstus = 'S'"
            CALL q_inpddocno_2()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck006  #顯示到畫面上
            NEXT FIELD b_xcck006                     #返回原欄位

         ON ACTION controlp INFIELD b_xcck010
            #料号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck010  #顯示到畫面上
            NEXT FIELD b_xcck010                     #返回原欄位

         ON ACTION controlp INFIELD b_xcck011
            #料件特性
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcck011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck011  #顯示到畫面上
            NEXT FIELD b_xcck011                     #返回原欄位
    
         ON ACTION controlp INFIELD b_xcck015
            #仓库编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_23()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck015  #顯示到畫面上
            NEXT FIELD b_xcck015                     #返回原欄位


         ON ACTION controlp INFIELD b_xcck002
            #成本域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck002  #顯示到畫面上
            NEXT FIELD b_xcck002                     #返回原欄位


         ON ACTION controlp INFIELD b_xcck044
            #单位
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck044  #顯示到畫面上
            NEXT FIELD b_xcck044                     #返回原欄位
 #add by chenhz 15/12/04(s)  将当前栏位值赋予g_tm的值，用以保存   

    AFTER FIELD xcckcomp
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcckcomp
       
    AFTER FIELD xcckld
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcckld
       
    AFTER FIELD xcck001
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck001
       
    AFTER FIELD xcck003
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck003
       
    AFTER FIELD xccksite
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xccksite

    AFTER FIELD xcck002
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck002
       
    AFTER FIELD xcck010
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck010
       
    AFTER FIELD xcck028
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck028
       
    AFTER FIELD xcck017
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck017

    AFTER FIELD xcck006
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck006
 #add by chenhz 15/12/04(e)     
      END CONSTRUCT
      
   INPUT l_sdate,l_edate
         FROM l_sdate,l_edate
      END INPUT
      
      BEFORE DIALOG     
#            LET g_xcck_d[1].xccksite = ""
#            DISPLAY ARRAY g_xcck_d TO s_detail1.*
#            BEFORE DISPLAY
#               EXIT DISPLAY
#            END DISPLAY   
#            LET xccksite = g_site             #add by chenhz 15/10/26
#            DISPLAY xccksite TO xccksite     
#            
       IF cl_null(g_tm.xccksite) THEN
          LET  g_tm.xccksite = g_site  
          DISPLAY g_tm.xccksite TO xccksite
       END IF
         
        DISPLAY g_tm.xcckcomp      TO  b_xcckcomp
        DISPLAY g_tm.xcckld        TO  b_xcckld
        DISPLAY g_tm.xcck001       TO  b_xcck001
        DISPLAY g_tm.xcck003       TO  b_xcck003
        DISPLAY g_tm.xccksite      TO  xccksite
        DISPLAY g_tm.xcck002       TO  xcck002
        DISPLAY g_tm.xcck010       TO  xcck010
        DISPLAY g_tm.xcck028       TO  xcck028
        DISPLAY g_tm.xcck017       TO  xcck017
        DISPLAY g_tm.xcck006       TO  xcck006
         
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
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
   
   LET g_wc = g_wc_table 
 
   
   LET g_wc2 = " 1=1"

        
   LET g_error_show = 1
   INITIALIZE tm.* TO NULL  
   CALL axcq914_b_fill()
#   INITIALIZE tm.* TO NULL #151130-00003#14-mark-會造成g_wc年度/期別沒值
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
PRIVATE FUNCTION axcq914_default()
   DEFINE l_glaa001   LIKE glaa_t.glaa001  #使用币别
   DEFINE l_glaa016   LIKE glaa_t.glaa016  #本位幣二
   DEFINE l_glaa020   LIKE glaa_t.glaa020  #本位幣三

   #预设当前site的法人，主账套，年度期别，成本计算类型   #150805-00001#12add加IF，截止年期赋值
    CALL s_axc_set_site_default() RETURNING tm.xcckcomp,tm.xcckld,tm.xcck004,tm.xcck005,tm.xcck003
   LET tm.xcck001 = '1'
   #fengmy 150123----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(tm.xcckcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,tm.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,tm.xcckcomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('b_xcck002,b_xcck002_desc',TRUE)                    
   ELSE                      
      CALL cl_set_comp_visible('b_xcck002,b_xcck002_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('b_xcck011',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('b_xcck011',FALSE)                
   END IF 
   #fengmy 150123----end   
   #说明栏位
   CALL s_desc_get_department_desc(tm.xcckcomp) RETURNING tm.xcckcomp_desc #法人組織
   CALL s_desc_get_ld_desc(tm.xcckld) RETURNING tm.xcckld_desc #帳別編號
   #成本計算類型
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = tm.xcck003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.xcck003_desc = '', g_rtn_fields[1] , ''

   #本位币说明
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = tm.xcckld
   CASE tm.xcck001
      WHEN '1'
           CALL s_desc_get_currency_desc(l_glaa001) RETURNING tm.xcck001_desc
      WHEN '2'
           CALL s_desc_get_currency_desc(l_glaa016) RETURNING tm.xcck001_desc
      WHEN '3'
           CALL s_desc_get_currency_desc(l_glaa020) RETURNING tm.xcck001_desc
   END CASE

END FUNCTION

PRIVATE FUNCTION axcq914_show()
   DEFINE l_glaa001   LIKE glaa_t.glaa001  #使用币别
   DEFINE l_glaa016   LIKE glaa_t.glaa016  #本位幣二
   DEFINE l_glaa020   LIKE glaa_t.glaa020  #本位幣三

   #显示单头
   DISPLAY tm.xcckcomp TO b_xcckcomp   #法人組織
   DISPLAY tm.xcckcomp_desc TO b_xcckcomp_desc   #法人組織
   DISPLAY tm.xcckld   TO b_xcckld     #帳別編號
   DISPLAY tm.xcckld_desc   TO b_xcckld_desc     #帳別編號
   DISPLAY tm.xcck004  TO b_xcck004    #年度
   DISPLAY tm.xcck005  TO b_xcck005    #期別
   DISPLAY tm.xcck001  TO b_xcck001    #本位币顺序
   DISPLAY tm.xcck003  TO b_xcck003    #成本計算類型
   DISPLAY tm.xcck003_desc  TO b_xcck003_desc    #成本計算類型
   
   #本位币说明
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = tm.xcckld
   CASE tm.xcck001
      WHEN '1'
           CALL s_desc_get_currency_desc(l_glaa001) RETURNING tm.xcck001_desc
      WHEN '2'
           CALL s_desc_get_currency_desc(l_glaa016) RETURNING tm.xcck001_desc
      WHEN '3'
           CALL s_desc_get_currency_desc(l_glaa020) RETURNING tm.xcck001_desc
   END CASE
   DISPLAY tm.xcck001_desc TO b_xcck001_desc
   #fengmy 150123----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(tm.xcckcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,tm.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,tm.xcckcomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('b_xcck002,b_xcck002_desc',TRUE)                    
   ELSE                      
      CALL cl_set_comp_visible('b_xcck002,b_xcck002_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('b_xcck011',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('b_xcck011',FALSE)                
   END IF 
   #fengmy 150123----end   
   #显示单身
#   CALL axcq914_b2_fill()
   
   #設定p_per內有特殊格式設定的欄位
   CALL cl_show_fld_cont() 
END FUNCTION

#筛选，pattern不支持功能需求，用此代替pattern
PRIVATE FUNCTION axcq914_filter2()
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
      CONSTRUCT g_wc_filter ON xcckcomp,xcckld,xcck004,xcck005,xcck001,xcck003,
                               xccksite,xcck006,xcck007,xcck008,xcck010,xcck011,xcck015,xcck017,xcck002, 
                               xcck009,xcck044,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h, 
                               xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202
           FROM b_xcckcomp,b_xcckld,b_xcck004,b_xcck005,b_xcck001,b_xcck003,
                s_detail1[1].b_xccksite,s_detail1[1].b_xcck006,s_detail1[1].b_xcck007,s_detail1[1].b_xcck008, 
                s_detail1[1].b_xcck010,s_detail1[1].b_xcck011,s_detail1[1].b_xcck015,s_detail1[1].b_xcck017, 
                s_detail1[1].b_xcck002,s_detail1[1].b_xcck009,s_detail1[1].b_xcck044,s_detail1[1].b_xcck201, 
                s_detail1[1].b_xcck282a,s_detail1[1].b_xcck282b,s_detail1[1].b_xcck282c,s_detail1[1].b_xcck282d, 
                s_detail1[1].b_xcck282e,s_detail1[1].b_xcck282f,s_detail1[1].b_xcck282g,s_detail1[1].b_xcck282h, 
                s_detail1[1].b_xcck282,s_detail1[1].b_xcck202a,s_detail1[1].b_xcck202b,s_detail1[1].b_xcck202c, 
                s_detail1[1].b_xcck202d,s_detail1[1].b_xcck202e,s_detail1[1].b_xcck202f,s_detail1[1].b_xcck202g, 
                s_detail1[1].b_xcck202h,s_detail1[1].b_xcck202
 
         BEFORE CONSTRUCT
#saki       CALL cl_qbe_init()
            DISPLAY axcq914_filter_parser('xcckcomp') TO s_detail1[1].b_xcckcomp
            DISPLAY axcq914_filter_parser('xcckld') TO s_detail1[1].b_xcckld
            DISPLAY axcq914_filter_parser('xcck004') TO s_detail1[1].b_xcck004
            DISPLAY axcq914_filter_parser('xcck005') TO s_detail1[1].b_xcck005
            DISPLAY axcq914_filter_parser('xcck001') TO s_detail1[1].b_xcck001
            DISPLAY axcq914_filter_parser('xcck003') TO s_detail1[1].b_xcck003
            DISPLAY axcq914_filter_parser('xccksite') TO s_detail1[1].b_xccksite
            DISPLAY axcq914_filter_parser('xcck006') TO s_detail1[1].b_xcck006
            DISPLAY axcq914_filter_parser('xcck007') TO s_detail1[1].b_xcck007
            DISPLAY axcq914_filter_parser('xcck008') TO s_detail1[1].b_xcck008
            DISPLAY axcq914_filter_parser('xcck010') TO s_detail1[1].b_xcck010
            DISPLAY axcq914_filter_parser('xcck011') TO s_detail1[1].b_xcck011
            DISPLAY axcq914_filter_parser('xcck015') TO s_detail1[1].b_xcck015
            DISPLAY axcq914_filter_parser('xcck017') TO s_detail1[1].b_xcck017
            DISPLAY axcq914_filter_parser('xcck002') TO s_detail1[1].b_xcck002
            DISPLAY axcq914_filter_parser('xcck009') TO s_detail1[1].b_xcck009
            DISPLAY axcq914_filter_parser('xcck044') TO s_detail1[1].b_xcck044
            DISPLAY axcq914_filter_parser('xcck201') TO s_detail1[1].b_xcck201
            DISPLAY axcq914_filter_parser('xcck282a') TO s_detail1[1].b_xcck282a
            DISPLAY axcq914_filter_parser('xcck282b') TO s_detail1[1].b_xcck282b
            DISPLAY axcq914_filter_parser('xcck282c') TO s_detail1[1].b_xcck282c
            DISPLAY axcq914_filter_parser('xcck282d') TO s_detail1[1].b_xcck282d
            DISPLAY axcq914_filter_parser('xcck282e') TO s_detail1[1].b_xcck282e
            DISPLAY axcq914_filter_parser('xcck282f') TO s_detail1[1].b_xcck282f
            DISPLAY axcq914_filter_parser('xcck282g') TO s_detail1[1].b_xcck282g
            DISPLAY axcq914_filter_parser('xcck282h') TO s_detail1[1].b_xcck282h
            DISPLAY axcq914_filter_parser('xcck282') TO s_detail1[1].b_xcck282
            DISPLAY axcq914_filter_parser('xcck202a') TO s_detail1[1].b_xcck202a
            DISPLAY axcq914_filter_parser('xcck202b') TO s_detail1[1].b_xcck202b
            DISPLAY axcq914_filter_parser('xcck202c') TO s_detail1[1].b_xcck202c
            DISPLAY axcq914_filter_parser('xcck202d') TO s_detail1[1].b_xcck202d
            DISPLAY axcq914_filter_parser('xcck202e') TO s_detail1[1].b_xcck202e
            DISPLAY axcq914_filter_parser('xcck202f') TO s_detail1[1].b_xcck202f
            DISPLAY axcq914_filter_parser('xcck202g') TO s_detail1[1].b_xcck202g
            DISPLAY axcq914_filter_parser('xcck202h') TO s_detail1[1].b_xcck202h
            DISPLAY axcq914_filter_parser('xcck202') TO s_detail1[1].b_xcck202
 
         #--单头开窗
         ON ACTION controlp INFIELD b_xcckcomp #法人组织
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
            CALL q_ooef001_2()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcckcomp  #顯示到畫面上
            NEXT FIELD b_xcckcomp                     #返回原欄位

         ON ACTION controlp INFIELD b_xcckld   #账别编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #160802-00020#9-s-add
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#9-e-add             
            CALL q_authorised_ld()                #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcckld  #顯示到畫面上
            NEXT FIELD b_xcckld                     #返回原欄位
 
         ON ACTION controlp INFIELD b_xcck003   #成本计算类型
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck003  #顯示到畫面上
            NEXT FIELD b_xcck003                     #返回原欄位

         #--单身开窗
         ON ACTION controlp INFIELD b_xccksite
            #组织
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
           # CALL q_ooef001_14()                           #呼叫開窗  #161019-00017#10  2016/10/26  By 08734  mark
            CALL q_ooef001_1()    #161019-00017#10  2016/10/26  By 08734  add
            DISPLAY g_qryparam.return1 TO b_xccksite  #顯示到畫面上
            NEXT FIELD b_xccksite                     #返回原欄位

         ON ACTION controlp INFIELD b_xcck006
            #盘点单号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " inpdstus = 'S'"
            CALL q_inpddocno_2()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck006  #顯示到畫面上
            NEXT FIELD b_xcck006                     #返回原欄位

         ON ACTION controlp INFIELD b_xcck010
            #料号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck010  #顯示到畫面上
            NEXT FIELD b_xcck010                     #返回原欄位

         ON ACTION controlp INFIELD b_xcck011
            #料件特性
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcck011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck011  #顯示到畫面上
            NEXT FIELD b_xcck011                     #返回原欄位
    
         ON ACTION controlp INFIELD b_xcck015
            #仓库编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_23()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck015  #顯示到畫面上
            NEXT FIELD b_xcck015                     #返回原欄位


         ON ACTION controlp INFIELD b_xcck002
            #成本域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck002  #顯示到畫面上
            NEXT FIELD b_xcck002                     #返回原欄位


         ON ACTION controlp INFIELD b_xcck044
            #单位
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck044  #顯示到畫面上
            NEXT FIELD b_xcck044                     #返回原欄位
 
      END CONSTRUCT
 
      BEFORE DIALOG
 
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
   
   CALL axcq914_filter_show('xcckcomp','b_xcckcomp')
   CALL axcq914_filter_show('xcckld','b_xcckld')
   CALL axcq914_filter_show('xcck004','b_xcck004')
   CALL axcq914_filter_show('xcck005','b_xcck005')
   CALL axcq914_filter_show('xcck001','b_xcck001')
   CALL axcq914_filter_show('xcck003','b_xcck003')
   CALL axcq914_filter_show('xccksite','b_xccksite')
   CALL axcq914_filter_show('xcck006','b_xcck006')
   CALL axcq914_filter_show('xcck007','b_xcck007')
   CALL axcq914_filter_show('xcck008','b_xcck008')
   CALL axcq914_filter_show('xcck010','b_xcck010')
   CALL axcq914_filter_show('xcck011','b_xcck011')
   CALL axcq914_filter_show('xcck015','b_xcck015')
   CALL axcq914_filter_show('xcck017','b_xcck017')
   CALL axcq914_filter_show('xcck002','b_xcck002')
   CALL axcq914_filter_show('xcck009','b_xcck009')
   CALL axcq914_filter_show('xcck044','b_xcck044')
   CALL axcq914_filter_show('xcck201','b_xcck201')
   CALL axcq914_filter_show('xcck282a','b_xcck282a')
   CALL axcq914_filter_show('xcck282b','b_xcck282b')
   CALL axcq914_filter_show('xcck282c','b_xcck282c')
   CALL axcq914_filter_show('xcck282d','b_xcck282d')
   CALL axcq914_filter_show('xcck282e','b_xcck282e')
   CALL axcq914_filter_show('xcck282f','b_xcck282f')
   CALL axcq914_filter_show('xcck282g','b_xcck282g')
   CALL axcq914_filter_show('xcck282h','b_xcck282h')
   CALL axcq914_filter_show('xcck282','b_xcck282')
   CALL axcq914_filter_show('xcck202a','b_xcck202a')
   CALL axcq914_filter_show('xcck202b','b_xcck202b')
   CALL axcq914_filter_show('xcck202c','b_xcck202c')
   CALL axcq914_filter_show('xcck202d','b_xcck202d')
   CALL axcq914_filter_show('xcck202e','b_xcck202e')
   CALL axcq914_filter_show('xcck202f','b_xcck202f')
   CALL axcq914_filter_show('xcck202g','b_xcck202g')
   CALL axcq914_filter_show('xcck202h','b_xcck202h')
   CALL axcq914_filter_show('xcck202','b_xcck202')
 
   INITIALIZE tm.* TO NULL 
   CALL axcq914_b_fill() 
   
END FUNCTION

#单身显示，pattern不支持功能需求，用此代替pattern
PRIVATE FUNCTION axcq914_b2_fill()
#   DEFINE ls_wc         STRING
#   TYPE type_sum        RECORD
#                        xcck201  LIKE xcck_t.xcck201,  #盤盈虧數量    #160106-00004#1-add
#                        xcck202a LIKE xcck_t.xcck202,  #成本金額-材料
#                        xcck202b LIKE xcck_t.xcck202,  #成本金額-人工
#                        xcck202c LIKE xcck_t.xcck202,  #成本金額-委外
#                        xcck202d LIKE xcck_t.xcck202,  #成本金額-製費一
#                        xcck202e LIKE xcck_t.xcck202,  #成本金額-製費二
#                        xcck202f LIKE xcck_t.xcck202,  #成本金額-製費三
#                        xcck202g LIKE xcck_t.xcck202,  #成本金額-製費四
#                        xcck202h LIKE xcck_t.xcck202,  #成本金額-製費五
#                        xcck202  LIKE xcck_t.xcck202   #成本金額 
#                        END RECORD
#   DEFINE l_sum         type_sum  #小计
#   DEFINE l_total       type_sum  #总计
#   
#   IF cl_null(g_wc_filter) THEN
#      LET g_wc_filter = " 1=1"
#   END IF
#   IF cl_null(g_wc) THEN
#      LET g_wc = " 1=1"
#   END IF
#   IF cl_null(g_wc2) THEN
#      LET g_wc2 = " 1=1"
#   END IF
#   
#   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter," AND xcck055 = '311'" #盘盈亏
# 
#   CALL g_xcck_d.clear()
# 
#   LET g_sql = "SELECT UNIQUE xccksite,ooefl003,xcck006,xcck007,xcck008,xcck010,imaal003,imaal004,xcck011, ",
#               "              xcck015,inayl003,xcck017,xcck002,xcbfl003,xcck009,xcck044,oocal003,xcck201, ",
#               "              xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,xcck282, ",
#               "              xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202,xcck004,xcck005 ",
#               "  FROM xcck_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xcck010 AND imaal002='"||g_dlang||"' ",
#               "              LEFT JOIN inayl_t ON inaylent='"||g_enterprise||"' AND inayl001=xcck015 AND inayl002='"||g_dlang||"' ",
#               "              LEFT JOIN ooefl_t ON ooeflent='"||g_enterprise||"' AND ooefl001=xccksite AND ooefl002='"||g_dlang||"' ",
#               "              LEFT JOIN xcbfl_t ON xcbflent='"||g_enterprise||"' AND xcbfl001=xcck002 AND xcbflcomp=xcckcomp AND xcbfl002='"||g_dlang||"' ",
#               "              LEFT JOIN oocal_t ON oocalent='"||g_enterprise||"' AND oocal001=xcck044 AND oocal002='"||g_dlang||"'",
#               " WHERE xcckent= ",g_enterprise,
#
#               "   AND xcckcomp='",tm.xcckcomp,"' ",
#               "   AND xcckld ='",tm.xcckld,"' ",
#               "   AND (xcck004*12+xcck005 between ",tm.xcck004,"*12+",tm.xcck005," AND ",tm.xcck004_1,"*12+",tm.xcck005_1,")",   #150805-00001#12add 
#               #"   AND xcck004= ",tm.xcck004,   #150805-00001#12mark
#               #"   AND xcck005= ",tm.xcck005,   #150805-00001#12mark
#               "   AND xcck001='",tm.xcck001,"' ",
#               "   AND xcck003='",tm.xcck003,"' ",
#
#               "   AND ",ls_wc   #单身需根据条件筛选资料
#   LET g_sql = g_sql, cl_sql_add_filter("xcck_t"),
#               " ORDER BY xcck004,xcck005,xccksite,xcck006,xcck007,xcck008,xcck010,xcck011,xcck015,xcck017,xcck002,xcck009,xcck044 "
#   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#   PREPARE axcq914_pb2 FROM g_sql
#   DECLARE b_fill_curs2 CURSOR FOR axcq914_pb2
#   LET g_cnt = l_ac
#   LET l_ac = 1   
#   ERROR "Searching!" 
#   
#   #依组织小计
#   LET l_sum.xcck201  = 0 #160106-00004#1-add
#   LET l_sum.xcck202a = 0
#   LET l_sum.xcck202b = 0
#   LET l_sum.xcck202c = 0
#   LET l_sum.xcck202d = 0
#   LET l_sum.xcck202e = 0
#   LET l_sum.xcck202f = 0
#   LET l_sum.xcck202g = 0
#   LET l_sum.xcck202h = 0
#   LET l_sum.xcck202  = 0
#   
#   #总计
#   LET l_total.xcck201 = 0 #160106-00004#1-add
#   LET l_total.xcck202a= 0
#   LET l_total.xcck202b= 0
#   LET l_total.xcck202c= 0
#   LET l_total.xcck202d= 0
#   LET l_total.xcck202e= 0
#   LET l_total.xcck202f= 0
#   LET l_total.xcck202g= 0
#   LET l_total.xcck202h= 0
#   LET l_total.xcck202 = 0
#   
#   FOREACH b_fill_curs2 INTO g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xccksite_desc,g_xcck_d[l_ac].xcck006, 
#       g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck010_desc, 
#       g_xcck_d[l_ac].xcck010_desc_desc,g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck015,g_xcck_d[l_ac].xcck015_desc, 
#       g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck002_desc,g_xcck_d[l_ac].xcck009, 
#       g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck044_desc,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck282a, 
#       g_xcck_d[l_ac].xcck282b,g_xcck_d[l_ac].xcck282c,g_xcck_d[l_ac].xcck282d,g_xcck_d[l_ac].xcck282e, 
#       g_xcck_d[l_ac].xcck282f,g_xcck_d[l_ac].xcck282g,g_xcck_d[l_ac].xcck282h,g_xcck_d[l_ac].xcck282, 
#       g_xcck_d[l_ac].xcck202a,g_xcck_d[l_ac].xcck202b,g_xcck_d[l_ac].xcck202c,g_xcck_d[l_ac].xcck202d, 
#       g_xcck_d[l_ac].xcck202e,g_xcck_d[l_ac].xcck202f,g_xcck_d[l_ac].xcck202g,g_xcck_d[l_ac].xcck202h, 
#       g_xcck_d[l_ac].xcck202
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
#         EXIT FOREACH
#      END IF
#      
#      #空值显示0
#      IF cl_null(g_xcck_d[l_ac].xcck201 ) THEN LET g_xcck_d[l_ac].xcck201  = 0 END IF
#      IF cl_null(g_xcck_d[l_ac].xcck282a) THEN LET g_xcck_d[l_ac].xcck282a = 0 END IF 
#      IF cl_null(g_xcck_d[l_ac].xcck282b) THEN LET g_xcck_d[l_ac].xcck282b = 0 END IF
#      IF cl_null(g_xcck_d[l_ac].xcck282c) THEN LET g_xcck_d[l_ac].xcck282c = 0 END IF
#      IF cl_null(g_xcck_d[l_ac].xcck282d) THEN LET g_xcck_d[l_ac].xcck282d = 0 END IF
#      IF cl_null(g_xcck_d[l_ac].xcck282e) THEN LET g_xcck_d[l_ac].xcck282e = 0 END IF 
#      IF cl_null(g_xcck_d[l_ac].xcck282f) THEN LET g_xcck_d[l_ac].xcck282f = 0 END IF
#      IF cl_null(g_xcck_d[l_ac].xcck282g) THEN LET g_xcck_d[l_ac].xcck282g = 0 END IF
#      IF cl_null(g_xcck_d[l_ac].xcck282h) THEN LET g_xcck_d[l_ac].xcck282h = 0 END IF
#      IF cl_null(g_xcck_d[l_ac].xcck282 ) THEN LET g_xcck_d[l_ac].xcck282  = 0 END IF
#      IF cl_null(g_xcck_d[l_ac].xcck202a) THEN LET g_xcck_d[l_ac].xcck202a = 0 END IF
#      IF cl_null(g_xcck_d[l_ac].xcck202b) THEN LET g_xcck_d[l_ac].xcck202b = 0 END IF
#      IF cl_null(g_xcck_d[l_ac].xcck202c) THEN LET g_xcck_d[l_ac].xcck202c = 0 END IF
#      IF cl_null(g_xcck_d[l_ac].xcck202d) THEN LET g_xcck_d[l_ac].xcck202d = 0 END IF 
#      IF cl_null(g_xcck_d[l_ac].xcck202e) THEN LET g_xcck_d[l_ac].xcck202e = 0 END IF
#      IF cl_null(g_xcck_d[l_ac].xcck202f) THEN LET g_xcck_d[l_ac].xcck202f = 0 END IF
#      IF cl_null(g_xcck_d[l_ac].xcck202g) THEN LET g_xcck_d[l_ac].xcck202g = 0 END IF
#      IF cl_null(g_xcck_d[l_ac].xcck202h) THEN LET g_xcck_d[l_ac].xcck202h = 0 END IF 
#      IF cl_null(g_xcck_d[l_ac].xcck202 ) THEN LET g_xcck_d[l_ac].xcck202  = 0 END IF
#      
#      
#      
#      #总计
#      LET l_total.xcck201 = l_total.xcck201  + g_xcck_d[l_ac].xcck201  #160106-00004#1-add
#      LET l_total.xcck202a= l_total.xcck202a + g_xcck_d[l_ac].xcck202a
#      LET l_total.xcck202b= l_total.xcck202b + g_xcck_d[l_ac].xcck202b
#      LET l_total.xcck202c= l_total.xcck202c + g_xcck_d[l_ac].xcck202c
#      LET l_total.xcck202d= l_total.xcck202d + g_xcck_d[l_ac].xcck202d
#      LET l_total.xcck202e= l_total.xcck202e + g_xcck_d[l_ac].xcck202e
#      LET l_total.xcck202f= l_total.xcck202f + g_xcck_d[l_ac].xcck202f
#      LET l_total.xcck202g= l_total.xcck202g + g_xcck_d[l_ac].xcck202g
#      LET l_total.xcck202h= l_total.xcck202h + g_xcck_d[l_ac].xcck202h
#      LET l_total.xcck202 = l_total.xcck202  + g_xcck_d[l_ac].xcck202 
#      
#      #依组织小计
#      LET l_sum.xcck201  = l_sum.xcck201  + g_xcck_d[l_ac].xcck201  #160106-00004#1-add
#      LET l_sum.xcck202a = l_sum.xcck202a + g_xcck_d[l_ac].xcck202a
#      LET l_sum.xcck202b = l_sum.xcck202b + g_xcck_d[l_ac].xcck202b
#      LET l_sum.xcck202c = l_sum.xcck202c + g_xcck_d[l_ac].xcck202c
#      LET l_sum.xcck202d = l_sum.xcck202d + g_xcck_d[l_ac].xcck202d
#      LET l_sum.xcck202e = l_sum.xcck202e + g_xcck_d[l_ac].xcck202e
#      LET l_sum.xcck202f = l_sum.xcck202f + g_xcck_d[l_ac].xcck202f
#      LET l_sum.xcck202g = l_sum.xcck202g + g_xcck_d[l_ac].xcck202g
#      LET l_sum.xcck202h = l_sum.xcck202h + g_xcck_d[l_ac].xcck202h
#      LET l_sum.xcck202  = l_sum.xcck202  + g_xcck_d[l_ac].xcck202 
#      IF l_ac > 1 THEN
#         IF g_xcck_d[l_ac].xccksite != g_xcck_d[l_ac-1].xccksite THEN
#            #把当前行下移，并在当前行显示小计
#            LET g_xcck_d[l_ac+1].* = g_xcck_d[l_ac].*
#            INITIALIZE  g_xcck_d[l_ac].* TO NULL
#            #LET g_xcck_d[l_ac].xccksite = cl_getmsg("axc-00205",g_lang)  #小计                         #151029-00010#2 20151029 s983961  mark(axcq小計整批顯示優化)
#            LET g_xcck_d[l_ac].xccksite_desc = g_xcck_d[l_ac-1].xccksite,cl_getmsg("axc-00205",g_lang)  #151029-00010#2 20151029 s983961  add(axcq小計整批顯示優化)  
#            LET g_xcck_d[l_ac].xcck201  = l_sum.xcck201  - g_xcck_d[l_ac+1].xcck201  #160106-00004#1-add
#            LET g_xcck_d[l_ac].xcck202a = l_sum.xcck202a - g_xcck_d[l_ac+1].xcck202a
#            LET g_xcck_d[l_ac].xcck202b = l_sum.xcck202b - g_xcck_d[l_ac+1].xcck202b
#            LET g_xcck_d[l_ac].xcck202c = l_sum.xcck202c - g_xcck_d[l_ac+1].xcck202c
#            LET g_xcck_d[l_ac].xcck202d = l_sum.xcck202d - g_xcck_d[l_ac+1].xcck202d
#            LET g_xcck_d[l_ac].xcck202e = l_sum.xcck202e - g_xcck_d[l_ac+1].xcck202e
#            LET g_xcck_d[l_ac].xcck202f = l_sum.xcck202f - g_xcck_d[l_ac+1].xcck202f
#            LET g_xcck_d[l_ac].xcck202g = l_sum.xcck202g - g_xcck_d[l_ac+1].xcck202g
#            LET g_xcck_d[l_ac].xcck202h = l_sum.xcck202h - g_xcck_d[l_ac+1].xcck202h
#            LET g_xcck_d[l_ac].xcck202  = l_sum.xcck202  - g_xcck_d[l_ac+1].xcck202 
#            LET l_ac = l_ac + 1
#            LET l_sum.xcck201  = g_xcck_d[l_ac].xcck201  #160106-00004#1-add
#            LET l_sum.xcck202a = g_xcck_d[l_ac].xcck202a
#            LET l_sum.xcck202b = g_xcck_d[l_ac].xcck202b
#            LET l_sum.xcck202c = g_xcck_d[l_ac].xcck202c
#            LET l_sum.xcck202d = g_xcck_d[l_ac].xcck202d
#            LET l_sum.xcck202e = g_xcck_d[l_ac].xcck202e
#            LET l_sum.xcck202f = g_xcck_d[l_ac].xcck202f
#            LET l_sum.xcck202g = g_xcck_d[l_ac].xcck202g
#            LET l_sum.xcck202h = g_xcck_d[l_ac].xcck202h
#            LET l_sum.xcck202  = g_xcck_d[l_ac].xcck202 
#         END IF
#      END IF
#
#      IF l_ac > g_max_rec THEN
#         IF g_error_show = 1 THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend =  "" 
#            LET g_errparam.code   =  9035 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
#         END IF
#         EXIT FOREACH
#      END IF
#      LET l_ac = l_ac + 1
#   END FOREACH
#   IF l_ac > 1 THEN  #单身有资料时
#      #最后一组小计
#      #LET g_xcck_d[l_ac].xccksite= cl_getmsg("axc-00205",g_lang)  #小计                          #151029-00010#2 20151029 s983961  mark(axcq小計整批顯示優化)
#      LET g_xcck_d[l_ac].xccksite_desc = g_xcck_d[l_ac-1].xccksite,cl_getmsg("axc-00205",g_lang)  #151029-00010#2 20151029 s983961  add(axcq小計整批顯示優化) 
#      LET g_xcck_d[l_ac].xcck201  = l_sum.xcck201  #160106-00004#1-add
#      LET g_xcck_d[l_ac].xcck202a = l_sum.xcck202a
#      LET g_xcck_d[l_ac].xcck202b = l_sum.xcck202b
#      LET g_xcck_d[l_ac].xcck202c = l_sum.xcck202c
#      LET g_xcck_d[l_ac].xcck202d = l_sum.xcck202d
#      LET g_xcck_d[l_ac].xcck202e = l_sum.xcck202e
#      LET g_xcck_d[l_ac].xcck202f = l_sum.xcck202f
#      LET g_xcck_d[l_ac].xcck202g = l_sum.xcck202g
#      LET g_xcck_d[l_ac].xcck202h = l_sum.xcck202h
#      LET g_xcck_d[l_ac].xcck202  = l_sum.xcck202 
#      LET l_ac = l_ac + 1
#      #合计
#      LET g_xcck_d[l_ac].xccksite= cl_getmsg("axc-00204",g_lang)  #合计:
#      LET g_xcck_d[l_ac].xcck201  = l_total.xcck201  #160106-00004#1-add
#      LET g_xcck_d[l_ac].xcck202a = l_total.xcck202a
#      LET g_xcck_d[l_ac].xcck202b = l_total.xcck202b
#      LET g_xcck_d[l_ac].xcck202c = l_total.xcck202c
#      LET g_xcck_d[l_ac].xcck202d = l_total.xcck202d
#      LET g_xcck_d[l_ac].xcck202e = l_total.xcck202e
#      LET g_xcck_d[l_ac].xcck202f = l_total.xcck202f
#      LET g_xcck_d[l_ac].xcck202g = l_total.xcck202g
#      LET g_xcck_d[l_ac].xcck202h = l_total.xcck202h
#      LET g_xcck_d[l_ac].xcck202  = l_total.xcck202 
#      LET l_ac = l_ac + 1
#   END IF
#
#   
#   LET g_error_show = 0
   #CALL g_xcck_d.deleteElement(g_xcck_d.getLength())   #最后没走foreach，没有空行了 

     #20150731--add--str--lujh   
   LET g_sql = "SELECT xcck028,rtaxl003,SUM(xcck202)",
               "  FROM axcq914_tmp ",
               " WHERE xcckent= ?" ,             
               " GROUP BY xcck028,rtaxl003 ",
               " ORDER BY xcck028 "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資
  

   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq914_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR axcq914_pb2
   
   OPEN b_fill_curs2 USING g_enterprise
 
    CALL g_xcck2_d.clear()
 
   #add-point:陣列清空

   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs2 INTO g_xcck2_d[l_ac].xcck028,g_xcck2_d[l_ac].xcck028_2_desc,g_xcck2_d[l_ac].xcck202
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
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
   LET g_error_show = 0
   
  
   CALL g_xcck2_d.deleteElement(g_xcck2_d.getLength())   

   FREE axcq914_pb2
 
 
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
# Date & Author..: 日期 By 作者:20150325 By dujuan
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq914_create_temp_table()
    DROP TABLE axcq914_tmp;
    CREATE TEMP TABLE axcq914_tmp(
      xcckent  LIKE xcck_t.xcckent,
      xccksite LIKE xcck_t.xccksite, 
      ooefl003 LIKE type_t.chr300, 
      xcck028  LIKE xcck_t.xcck028,
      rtaxl003 LIKE type_t.chr300, 
      xcck006  LIKE xcck_t.xcck006,
      xcck007  LIKE xcck_t.xcck007, 
      xcck008  LIKE xcck_t.xcck008, 
      xcck010  LIKE xcck_t.xcck010, 
      imaal003 LIKE type_t.chr300, 
      imaal004 LIKE type_t.chr300, 
      xcck011 LIKE xcck_t.xcck011, 
      xcck015 LIKE xcck_t.xcck015, 
      inayl003 LIKE type_t.chr300, 
      xcck017 LIKE xcck_t.xcck017, 
      xcck002 LIKE xcck_t.xcck002, 
      xcbfl003 LIKE type_t.chr300, 
      xcck009 LIKE xcck_t.xcck009, 
      xcck044 LIKE xcck_t.xcck044, 
      oocal003 LIKE type_t.chr300, 
      xcck201 LIKE xcck_t.xcck201, 
      xcck282a LIKE xcck_t.xcck282a, 
      xcck282b LIKE xcck_t.xcck282b, 
      xcck282c LIKE xcck_t.xcck282c, 
      xcck282d LIKE xcck_t.xcck282d, 
      xcck282e LIKE xcck_t.xcck282e, 
      xcck282f LIKE xcck_t.xcck282f, 
      xcck282g LIKE xcck_t.xcck282g, 
      xcck282h LIKE xcck_t.xcck282h, 
      xcck282 LIKE xcck_t.xcck282, 
      xcck202a LIKE xcck_t.xcck202a, 
      xcck202b LIKE xcck_t.xcck202b, 
      xcck202c LIKE xcck_t.xcck202c, 
      xcck202d LIKE xcck_t.xcck202d, 
      xcck202e LIKE xcck_t.xcck202e, 
      xcck202f LIKE xcck_t.xcck202f, 
      xcck202g LIKE xcck_t.xcck202g, 
      xcck202h LIKE xcck_t.xcck202h, 
      xcck202 LIKE xcck_t.xcck202
    );
END FUNCTION

################################################################################
# Descriptions...: 描述说明:临时表加数据
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者:20150325 By dujuan
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq914_get_date()
#    DEFINE sr RECORD 
#      xccksite LIKE xcck_t.xccksite, 
#      xccksite_desc LIKE type_t.chr300, 
#      xcck006 LIKE xcck_t.xcck006, 
#      xcck007 LIKE xcck_t.xcck007, 
#      xcck008 LIKE xcck_t.xcck008, 
#      xcck010 LIKE xcck_t.xcck010, 
#      xcck010_desc1 LIKE type_t.chr300, 
#      xcck010_desc2 LIKE type_t.chr300, 
#      xcck011 LIKE xcck_t.xcck011, 
#      xcck015 LIKE xcck_t.xcck015, 
#      xcck015_desc LIKE type_t.chr300, 
#      xcck017 LIKE xcck_t.xcck017, 
#      xcck002 LIKE xcck_t.xcck002, 
#      xcck002_desc LIKE type_t.chr300, 
#      xcck009 LIKE xcck_t.xcck009, 
#      xcck044 LIKE xcck_t.xcck044, 
#      xcck044_desc LIKE type_t.chr300, 
#      xcck201 LIKE xcck_t.xcck201, 
#      xcck282a LIKE xcck_t.xcck282a, 
#      xcck282b LIKE xcck_t.xcck282b, 
#      xcck282c LIKE xcck_t.xcck282c, 
#      xcck282d LIKE xcck_t.xcck282d, 
#      xcck282e LIKE xcck_t.xcck282e, 
#      xcck282f LIKE xcck_t.xcck282f, 
#      xcck282g LIKE xcck_t.xcck282g, 
#      xcck282h LIKE xcck_t.xcck282h, 
#      xcck282 LIKE xcck_t.xcck282, 
#      xcck202a LIKE xcck_t.xcck202a, 
#      xcck202b LIKE xcck_t.xcck202b, 
#      xcck202c LIKE xcck_t.xcck202c, 
#      xcck202d LIKE xcck_t.xcck202d, 
#      xcck202e LIKE xcck_t.xcck202e, 
#      xcck202f LIKE xcck_t.xcck202f, 
#      xcck202g LIKE xcck_t.xcck202g, 
#      xcck202h LIKE xcck_t.xcck202h, 
#      xcck202 LIKE xcck_t.xcck202, 
#      xcckcomp LIKE xcck_t.xcckcomp, 
#      xcckcomp_desc LIKE type_t.chr300, 
#      xcckld LIKE xcck_t.xcckld, 
#      xcckld_desc LIKE type_t.chr300, 
#      xcck001 LIKE xcck_t.xcck001, 
#      xcck003 LIKE xcck_t.xcck003, 
#      xcck004 LIKE xcck_t.xcck004, 
#      xcck005 LIKE xcck_t.xcck005, 
#      xcck001_desc LIKE type_t.chr300, 
#      xcck003_desc LIKE type_t.chr300, 
#      xcck004_desc LIKE type_t.chr300, 
#      xcck005_desc LIKE type_t.chr300, 
#      xcck_key LIKE type_t.chr1000
#    END RECORD
#    
#    DEFINE l_success  LIKE type_t.num5
#    DEFINE l_cnt      LIKE type_t.num5
#    DEFINE l_glaa001   LIKE glaa_t.glaa001  #使用币别
#    DEFINE l_glaa016   LIKE glaa_t.glaa016  #本位幣二
#    DEFINE l_glaa020   LIKE glaa_t.glaa020  #本位幣三
#    DEFINE ls_wc         STRING
#    
#    #刪除臨時表中資料
#    DELETE FROM axcq914_tmp
#    
#    LET l_success = TRUE
#    
#    FOR l_cnt = 1 TO g_page_cnt 
#    
#       FETCH ABSOLUTE l_cnt axcq914_b_curs INTO tm.*
#       LET sr.xcckld  = tm.xcckld
#       LET sr.xcck001 = tm.xcck001
#       LET sr.xcck004 = tm.xcck004
#       LET sr.xcck005 = tm.xcck005
#       LET sr.xcck003 = tm.xcck003
#       LET sr.xcckcomp = tm.xcckcomp
#       LET sr.xcckld_desc  = tm.xcckld_desc
#       LET sr.xcck003_desc = tm.xcck003_desc
#       LET sr.xcckcomp_desc = tm.xcckcomp_desc
#       LET sr.xcck004_desc = sr.xcck004
#       LET sr.xcck005_desc = sr.xcck005
#       #本位币说明
#       SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
#         FROM glaa_t
#        WHERE glaaent = g_enterprise
#          AND glaald  = tm.xcckld
#       CASE tm.xcck001
#         WHEN '1'
#                 CALL s_desc_get_currency_desc(l_glaa001) RETURNING tm.xcck001_desc
#         WHEN '2'
#                 CALL s_desc_get_currency_desc(l_glaa016) RETURNING tm.xcck001_desc
#         WHEN '3'
#                 CALL s_desc_get_currency_desc(l_glaa020) RETURNING tm.xcck001_desc
#       END CASE
#       LET sr.xcck001_desc = tm.xcck001_desc
#       LET sr.xcck_key = sr.xcckcomp,"-",sr.xcckld,"-",sr.xcck004_desc CLIPPED,"-" CLIPPED,sr.xcck005_desc CLIPPED,"-",sr.xcck001,"-",sr.xcck003 CLIPPED
#      
#       #临时表加数据的sql
#       IF cl_null(g_wc_filter) THEN
#         LET g_wc_filter = " 1=1"
#      END IF
#      IF cl_null(g_wc) THEN
#         LET g_wc = " 1=1"
#      END IF
#      IF cl_null(g_wc2) THEN
#         LET g_wc2 = " 1=1"
#      END IF
#   
#      LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter," AND xcck055 = '311'" #盘盈亏
#
#      LET g_sql = "SELECT UNIQUE xccksite,ooefl003,xcck006,xcck007,xcck008,xcck010,imaal003,imaal004,xcck011, ",
#               "              xcck015,inayl003,xcck017,xcck002,xcbfl003,xcck009,xcck044,oocal003,xcck201, ",
#               "              xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,xcck282, ",
#               "              xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202 ",
#               "  FROM xcck_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xcck010 AND imaal002='"||g_dlang||"' ",
#               "              LEFT JOIN inayl_t ON inaylent='"||g_enterprise||"' AND inayl001=xcck015 AND inayl002='"||g_dlang||"' ",
#               "              LEFT JOIN ooefl_t ON ooeflent='"||g_enterprise||"' AND ooefl001=xccksite AND ooefl002='"||g_dlang||"' ",
#               "              LEFT JOIN xcbfl_t ON xcbflent='"||g_enterprise||"' AND xcbfl001=xcck002 AND xcbflcomp=xcckcomp AND xcbfl002='"||g_dlang||"' ",
#               "              LEFT JOIN oocal_t ON oocalent='"||g_enterprise||"' AND oocal001=xcck044 AND oocal002='"||g_dlang||"'",
#               " WHERE xcckent= ",g_enterprise,
#               "   AND xcckcomp='",tm.xcckcomp,"' ",
#               "   AND xcckld ='",tm.xcckld,"' ",
##               "   AND xcck004= ",tm.xcck004, #160106-00004#1-mark
##               "   AND xcck005= ",tm.xcck005, #160106-00004#1-mark
#               "   AND xcck001='",tm.xcck001,"' ",
#               "   AND xcck003='",tm.xcck003,"' ",
#               "   AND ",ls_wc   #单身需根据条件筛选资料
#      LET g_sql = g_sql, cl_sql_add_filter("xcck_t"),
#               " ORDER BY xccksite,xcck006,xcck007,xcck008,xcck010,xcck011,xcck015,xcck017,xcck002,xcck009,xcck044 "
#      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#      
#       PREPARE axcq914_ins_tmp_pre FROM g_sql
#       DECLARE axcq914_ins_tmp_cs CURSOR FOR axcq914_ins_tmp_pre
#         
#       FOREACH axcq914_ins_tmp_cs INTO sr.xccksite,sr.xccksite_desc,sr.xcck006,sr.xcck007,sr.xcck008,sr.xcck010,sr.xcck010_desc1, 
#                                         sr.xcck010_desc2,sr.xcck011,sr.xcck015,sr.xcck015_desc,sr.xcck017,sr.xcck002,
#                                         sr.xcck002_desc,sr.xcck009,sr.xcck044,sr.xcck044_desc,sr.xcck201,sr.xcck282a, 
#                                         sr.xcck282b,sr.xcck282c,sr.xcck282d,sr.xcck282e,sr.xcck282f,sr.xcck282g,sr.xcck282h,
#                                         sr.xcck282,sr.xcck202a,sr.xcck202b,sr.xcck202c,sr.xcck202d,sr.xcck202e,sr.xcck202f,
#                                         sr.xcck202g,sr.xcck202h,sr.xcck202
#   
#             #空值显示0
#            IF cl_null(sr.xcck201 ) THEN LET sr.xcck201  = 0 END IF
#            IF cl_null(sr.xcck282a) THEN LET sr.xcck282a = 0 END IF 
#            IF cl_null(sr.xcck282b) THEN LET sr.xcck282b = 0 END IF
#            IF cl_null(sr.xcck282c) THEN LET sr.xcck282c = 0 END IF
#            IF cl_null(sr.xcck282d) THEN LET sr.xcck282d = 0 END IF
#            IF cl_null(sr.xcck282e) THEN LET sr.xcck282e = 0 END IF 
#            IF cl_null(sr.xcck282f) THEN LET sr.xcck282f = 0 END IF
#            IF cl_null(sr.xcck282g) THEN LET sr.xcck282g = 0 END IF
#            IF cl_null(sr.xcck282h) THEN LET sr.xcck282h = 0 END IF
#            IF cl_null(sr.xcck282 ) THEN LET sr.xcck282  = 0 END IF
#            IF cl_null(sr.xcck202a) THEN LET sr.xcck202a = 0 END IF
#            IF cl_null(sr.xcck202b) THEN LET sr.xcck202b = 0 END IF
#            IF cl_null(sr.xcck202c) THEN LET sr.xcck202c = 0 END IF
#            IF cl_null(sr.xcck202d) THEN LET sr.xcck202d = 0 END IF 
#            IF cl_null(sr.xcck202e) THEN LET sr.xcck202e = 0 END IF
#            IF cl_null(sr.xcck202f) THEN LET sr.xcck202f = 0 END IF
#            IF cl_null(sr.xcck202g) THEN LET sr.xcck202g = 0 END IF
#            IF cl_null(sr.xcck202h) THEN LET sr.xcck202h = 0 END IF 
#            IF cl_null(sr.xcck202 ) THEN LET sr.xcck202  = 0 END IF
#           
#            INSERT INTO axcq914_tmp ( xccksite,xccksite_desc,xcck006,xcck007,xcck008,xcck010,xcck010_desc1,xcck010_desc2,xcck011, 
#                                      xcck015,xcck015_desc,xcck017,xcck002,xcck002_desc,xcck009,xcck044,xcck044_desc,xcck201,xcck282a, 
#                                      xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,xcck282,xcck202a,xcck202b,xcck202c, 
#                                      xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202,xcckcomp,xcckcomp_desc,xcckld,xcckld_desc, 
#                                      xcck001,xcck003,xcck004,xcck005,xcck001_desc,xcck003_desc,xcck004_desc,xcck005_desc,xcck_key)
#                             VALUES ( sr.xccksite,sr.xccksite_desc,sr.xcck006,sr.xcck007,sr.xcck008,sr.xcck010,sr.xcck010_desc1, 
#                                         sr.xcck010_desc2,sr.xcck011,sr.xcck015,sr.xcck015_desc,sr.xcck017,sr.xcck002,
#                                         sr.xcck002_desc,sr.xcck009,sr.xcck044,sr.xcck044_desc,sr.xcck201,sr.xcck282a, 
#                                         sr.xcck282b,sr.xcck282c,sr.xcck282d,sr.xcck282e,sr.xcck282f,sr.xcck282g,sr.xcck282h,
#                                         sr.xcck282,sr.xcck202a,sr.xcck202b,sr.xcck202c,sr.xcck202d,sr.xcck202e,sr.xcck202f,
#                                         sr.xcck202g,sr.xcck202h,sr.xcck202,sr.xcckcomp,sr.xcckcomp_desc,sr.xcckld,sr.xcckld_desc, 
#                                         sr.xcck001,sr.xcck003,sr.xcck004,sr.xcck005,sr.xcck001_desc,sr.xcck003_desc,sr.xcck004_desc,
#                                         sr.xcck005_desc,sr.xcck_key)
#            
#            IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.extend = 'insert axcq_tmp'
#                  LET g_errparam.code = SQLCA.SQLCODE
#                  LET g_errparam.popup = FALSE
#                  CALL cl_err()
#                  LET l_success = FALSE
#             END IF
#          
#          
#         END FOREACH
#         
#         CALL cl_err_collect_show()
#         IF l_success = FALSE THEN
#           DELETE FROM axcq914_tmp
#         END IF
#   END FOR
#    
END FUNCTION

 
{</section>}
 
