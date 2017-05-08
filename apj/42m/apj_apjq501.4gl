#該程式未解開Section, 採用最新樣板產出!
{<section id="apjq501.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-10-27 18:00:31), PR版次:0004(2016-10-28 10:03:36)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: apjq501
#+ Description: 工程專案成本查詢作業
#+ Creator....: 05423(2016-03-02 11:07:04)
#+ Modifier...: 02295 -SD/PR- 02295
 
{</section>}
 
{<section id="apjq501.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160905-00007#3   2016/09/05 By zhujing 调整系统中无ENT的SQL条件增加ent
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
       
       l_seq LIKE type_t.num10, 
   pjba001 LIKE type_t.chr100, 
   xccc902 LIKE xccc_t.xccc902, 
   xccd902 LIKE xccd_t.xccd902, 
   l_sum_1 LIKE type_t.num20_6, 
   l_xccc280_1 LIKE type_t.num20_6, 
   l_glar006_1 LIKE type_t.num20_6, 
   l_sum_2 LIKE type_t.num20_6, 
   l_xccc280_2 LIKE type_t.num20_6, 
   l_glar006_2 LIKE type_t.num20_6, 
   l_sum_3 LIKE type_t.num20_6, 
   l_sum_4 LIKE type_t.num20_6, 
   l_pjba016 LIKE type_t.num20_6, 
   l_diff_1 LIKE type_t.num20_6, 
   xcccld LIKE xccc_t.xcccld, 
   xccc001 LIKE xccc_t.xccc001, 
   xccc002 LIKE xccc_t.xccc002, 
   xccc003 LIKE xccc_t.xccc003, 
   xccc004 LIKE xccc_t.xccc004, 
   xccc005 LIKE xccc_t.xccc005, 
   xccc008 LIKE xccc_t.xccc008
       END RECORD
PRIVATE TYPE type_g_xccc2_d RECORD
       l_seq_1 LIKE type_t.num10, 
   xccc006 LIKE xccc_t.xccc006, 
   xccc006_desc LIKE type_t.chr500, 
   xccc006_desc_1 LIKE type_t.chr500, 
   xccc007 LIKE xccc_t.xccc007, 
   xccc901 LIKE xccc_t.xccc901, 
   xccc902 LIKE xccc_t.xccc902
       END RECORD
 
PRIVATE TYPE type_g_xccc3_d RECORD
       l_seq_2 LIKE type_t.num10, 
   xccd006 LIKE type_t.chr20, 
   xccd007 LIKE type_t.chr100, 
   xccd007_desc LIKE type_t.chr500, 
   xccd007_desc_1 LIKE type_t.chr500, 
   xccd008 LIKE type_t.chr300, 
   xccd901 LIKE type_t.num20_6, 
   xccd902 LIKE xccd_t.xccd902
       END RECORD
 
PRIVATE TYPE type_g_xccc4_d RECORD
       l_seq_3 LIKE type_t.num10, 
   xmdlorga LIKE type_t.chr100, 
   xmdlorga_desc LIKE type_t.chr500, 
   xmdl008 LIKE type_t.chr100, 
   xmdl008_desc LIKE type_t.chr500, 
   xmdl008_desc_1 LIKE type_t.chr500, 
   xmdl009 LIKE xmdl_t.xmdl009, 
   xmdl018 LIKE type_t.num20_6, 
   xccc280 LIKE xccc_t.xccc280, 
   l_pjdb018 LIKE type_t.num20_6, 
   l_diff_2 LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_xccc5_d RECORD
       l_seq_4 LIKE type_t.num10, 
   glar012 LIKE glar_t.glar012, 
   glar012_desc LIKE type_t.chr500, 
   glar001 LIKE type_t.chr30, 
   glacl004 LIKE type_t.chr500, 
   glar006 LIKE type_t.num20_6, 
   l_pjbg009 LIKE type_t.num20_6, 
   l_diff_3 LIKE type_t.num20_6
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_tm RECORD
   xccccomp       LIKE xccc_t.xccccomp,  #法人組織
   xccccomp_desc  LIKE type_t.chr80,
   xcccld         LIKE xccc_t.xcccld  ,  #帳別編號
   xcccld_desc    LIKE type_t.chr80,
   xccc003        LIKE xccc_t.xccc003 ,  #成本计算类型
   xccc003_desc   LIKE type_t.chr80 ,  #
   l_xccc004_b    LIKE xccc_t.xccc004,    #起始年度
   l_xccc005_b    LIKE xccc_t.xccc005,    #起始期别
   l_xccc004_e    LIKE xccc_t.xccc004,    #截止年度
   l_xccc005_e    LIKE xccc_t.xccc005     #截止期别
END RECORD
DEFINE tm            type_tm
DEFINE g_browser_tm  DYNAMIC ARRAY OF type_tm
DEFINE g_fetch       LIKE type_t.chr1

DEFINE g_page_cnt        LIKE type_t.num5   #總页數
DEFINE g_page_idx        LIKE type_t.num5   #当页笔数

DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_para_data           LIKE type_t.chr80     #项目成本归集原则
DEFINE g_glaa003     LIKE glaa_t.glaa003
                                                               
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
DEFINE g_rec_b               LIKE type_t.num10  
DEFINE g_wc_pjba             STRING     #161026-00054#1
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xccc_d            DYNAMIC ARRAY OF type_g_xccc_d
DEFINE g_xccc_d_t          type_g_xccc_d
DEFINE g_xccc2_d     DYNAMIC ARRAY OF type_g_xccc2_d
DEFINE g_xccc2_d_t   type_g_xccc2_d
 
DEFINE g_xccc3_d     DYNAMIC ARRAY OF type_g_xccc3_d
DEFINE g_xccc3_d_t   type_g_xccc3_d
 
DEFINE g_xccc4_d     DYNAMIC ARRAY OF type_g_xccc4_d
DEFINE g_xccc4_d_t   type_g_xccc4_d
 
DEFINE g_xccc5_d     DYNAMIC ARRAY OF type_g_xccc5_d
DEFINE g_xccc5_d_t   type_g_xccc5_d
 
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num10             #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apjq501.main" >}
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
   CALL cl_ap_init("apj","")
 
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
   DECLARE apjq501_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
 
   #end add-point
   PREPARE apjq501_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apjq501_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apjq501 WITH FORM cl_ap_formpath("apj",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apjq501_init()   
 
      #進入選單 Menu (="N")
      CALL apjq501_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apjq501
      
   END IF 
   
   CLOSE apjq501_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apjq501.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apjq501_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   #S-FIN-6020='2'时，库存结存、在制结存、结存小计三个栏位隐藏，项目库存成本页签、项目在制成本页签隐藏
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6020') RETURNING g_para_data   #项目成本归集原则          
   #161026-00054#1---mod---e
   #IF g_para_data = '2' THEN
   #   CALL cl_set_comp_visible('xccc902,xccd902,l_sum_1',FALSE)
   #   CALL cl_set_comp_visible('page_2,page_3',FALSE)      
   #ELSE
   #   CALL cl_set_comp_visible('xccc902,xccd902,l_sum_1',TRUE)
   #   CALL cl_set_comp_visible('page_2,page_3',TRUE)           
   #END IF
   IF g_para_data = '2' THEN
      CALL cl_set_comp_visible('b_xccc902,b_xccd902,l_sum_1',FALSE)
      CALL cl_set_comp_visible('page_1,page_2',FALSE)      
   ELSE
      CALL cl_set_comp_visible('b_xccc902,b_xccd902,l_sum_1',TRUE)
      CALL cl_set_comp_visible('page_1,page_2',TRUE)           
   END IF    
   #161026-00054#1---mod---e
   #end add-point
 
   CALL apjq501_default_search()
END FUNCTION
 
{</section>}
 
{<section id="apjq501.default_search" >}
PRIVATE FUNCTION apjq501_default_search()
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
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apjq501.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apjq501_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   DEFINE ls_js     STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL s_axc_set_site_default() RETURNING tm.xccccomp,tm.xcccld,tm.l_xccc004_b,tm.l_xccc005_b,tm.xccc003
   LET tm.l_xccc004_e = tm.l_xccc004_b
   LET tm.l_xccc005_e = tm.l_xccc005_b
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = tm.xccccomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.xccccomp_desc = '', g_rtn_fields[1] , ''

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = tm.xcccld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.xcccld_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = tm.xccc003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.xccc003_desc = '', g_rtn_fields[1] , ''
   
   CALL apjq501_query()
#   CALL apjq501_browser_fill()
#   CALL apjq501_fetch("")
   #end add-point
 
   
   CALL apjq501_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xccc_d.clear()
         CALL g_xccc2_d.clear()
 
         CALL g_xccc3_d.clear()
 
         CALL g_xccc4_d.clear()
 
         CALL g_xccc5_d.clear()
 
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL apjq501_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_xccc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apjq501_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL apjq501_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               CALL cl_set_act_visible("detail_first,detail_previous,'',detail_next,detail_last",TRUE)         
               DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
               DISPLAY g_browser_idx TO FORMONLY.p_start #當下筆數
               DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
               DISPLAY g_browser_cnt TO FORMONLY.p_end   #總筆數
               LET g_current_page = 1
               LET g_master_idx = l_ac
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_xccc2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               LET g_current_page = 2
               CALL apjq501_b_fill2()
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_xccc3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 3
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body3.before_row"
               LET g_current_page = 3
               CALL apjq501_b_fill2()
               #end add-point
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_xccc4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 4
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body4.before_row"
               LET g_current_page = 4
               CALL apjq501_b_fill2()
               #end add-point
 
            #自訂ACTION(detail_show,page_4)
            
 
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_xccc5_d TO s_detail5.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 5
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body5.before_row"
               LET g_current_page = 5
               CALL apjq501_b_fill2()
               #end add-point
 
            #自訂ACTION(detail_show,page_5)
            
 
            #add-point:page5自定義行為 name="ui_dialog.body5.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL apjq501_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("detail_first,detail_previous,'',detail_next,detail_last",TRUE) 
            DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
               DISPLAY g_browser_idx TO FORMONLY.p_start #當下筆數
               DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
               DISPLAY g_browser_cnt TO FORMONLY.p_end   #總筆數
            CONTINUE DIALOG
            #end add-point
            NEXT FIELD xccccomp
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apjq501_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjq501_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apjq501_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjq501_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apjq501_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjq501_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apjq501_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjq501_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apjq501_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjq501_idx_chk()
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL apjq501_b_fill()
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xccc_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_xccc2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_xccc3_d)
               LET g_export_id[3]   = "s_detail3"
 
               LET g_export_node[4] = base.typeInfo.create(g_xccc4_d)
               LET g_export_id[4]   = "s_detail4"
 
               LET g_export_node[5] = base.typeInfo.create(g_xccc5_d)
               LET g_export_id[5]   = "s_detail5"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL apjq501_b_fill()
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL apjq501_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL apjq501_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL apjq501_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL apjq501_b_fill()
 
         
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apjq501_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               CLEAR FORM
               CALL g_xccc_d.clear()
               CALL g_xccc2_d.clear()
               CALL g_xccc3_d.clear()
               CALL g_xccc4_d.clear()
               CALL g_xccc5_d.clear()
               CALL apjq501_query()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"
            
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="apjq501.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apjq501_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF g_detail_page_action = "detail_first" THEN
      LET g_action_choice = "fetch"
      CALL apjq501_fetch('F')
      LET g_current_row = g_current_idx
      LET g_curr_diag = ui.DIALOG.getCurrent()
      CALL apjq501_idx_chk()
      RETURN
   END IF
   IF g_detail_page_action = "detail_previous" THEN       
      LET g_action_choice = "fetch"
      CALL apjq501_fetch('P')
      LET g_current_row = g_current_idx
      LET g_curr_diag = ui.DIALOG.getCurrent()
      CALL apjq501_idx_chk()
      RETURN
   END IF
   IF g_detail_page_action = "detail_next" THEN         
      LET g_action_choice = "fetch"
      CALL apjq501_fetch('N')
      LET g_current_row = g_current_idx
      LET g_curr_diag = ui.DIALOG.getCurrent()
      CALL apjq501_idx_chk()
      RETURN
   END IF      
   IF g_detail_page_action = "detail_last" THEN    
      LET g_action_choice = "fetch"
      CALL apjq501_fetch('L')
      LET g_current_row = g_current_idx
      LET g_curr_diag = ui.DIALOG.getCurrent()
      CALL apjq501_idx_chk()
      RETURN
   END IF
   CALL apjq501_b_fill1()
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
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_xccc_d.clear()
   CALL g_xccc2_d.clear()
 
   CALL g_xccc3_d.clear()
 
   CALL g_xccc4_d.clear()
 
   CALL g_xccc5_d.clear()
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '','',xccc902,'','','','','','','','','','','','','','','','','', 
       '','',xccc006,'','',xccc007,xccc901,'','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY xccc_t.xcccld,xccc_t.xccc001,xccc_t.xccc002, 
       xccc_t.xccc003,xccc_t.xccc004,xccc_t.xccc005,xccc_t.xccc006,xccc_t.xccc007,xccc_t.xccc008) AS RANK FROM xccc_t", 
 
 
 
                     " LEFT JOIN xmdl_t ON xcccld = xmdldocno AND xccc001 = xmdlseqxccc002 = xccc003 = xccc004 = xccc005 = xccc006 = xccc007 = xccc008 =  LEFT JOIN glar_t ON xcccld = glarld AND xccc001 = glar001 AND xccc002 = glar002 AND xccc003 = glar003 AND xccc004 = glar004xccc005 = xccc006 = xccc007 = xccc008 =",
                     " WHERE xcccent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xccc_t"),
                     " ORDER BY xccc_t.xcccld,xccc_t.xccc001,xccc_t.xccc002,xccc_t.xccc003,xccc_t.xccc004,xccc_t.xccc005,xccc_t.xccc006,xccc_t.xccc007,xccc_t.xccc008"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
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
 
   LET g_sql = "SELECT '','',xccc902,'','','','','','','','','','','','','','','','','','','',xccc006, 
       '','',xccc007,xccc901,'','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apjq501_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apjq501_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xccc_d[l_ac].l_seq,g_xccc_d[l_ac].pjba001,g_xccc_d[l_ac].xccc902,g_xccc_d[l_ac].xccd902, 
       g_xccc_d[l_ac].l_sum_1,g_xccc_d[l_ac].l_xccc280_1,g_xccc_d[l_ac].l_glar006_1,g_xccc_d[l_ac].l_sum_2, 
       g_xccc_d[l_ac].l_xccc280_2,g_xccc_d[l_ac].l_glar006_2,g_xccc_d[l_ac].l_sum_3,g_xccc_d[l_ac].l_sum_4, 
       g_xccc_d[l_ac].l_pjba016,g_xccc_d[l_ac].l_diff_1,g_xccc_d[l_ac].xcccld,g_xccc_d[l_ac].xccc001, 
       g_xccc_d[l_ac].xccc002,g_xccc_d[l_ac].xccc003,g_xccc_d[l_ac].xccc004,g_xccc_d[l_ac].xccc005,g_xccc_d[l_ac].xccc008, 
       g_xccc2_d[l_ac].l_seq_1,g_xccc2_d[l_ac].xccc006,g_xccc2_d[l_ac].xccc006_desc,g_xccc2_d[l_ac].xccc006_desc_1, 
       g_xccc2_d[l_ac].xccc007,g_xccc2_d[l_ac].xccc901,g_xccc2_d[l_ac].xccc902,g_xccc3_d[l_ac].l_seq_2, 
       g_xccc3_d[l_ac].xccd006,g_xccc3_d[l_ac].xccd007,g_xccc3_d[l_ac].xccd007_desc,g_xccc3_d[l_ac].xccd007_desc_1, 
       g_xccc3_d[l_ac].xccd008,g_xccc3_d[l_ac].xccd901,g_xccc3_d[l_ac].xccd902,g_xccc4_d[l_ac].l_seq_3, 
       g_xccc4_d[l_ac].xmdlorga,g_xccc4_d[l_ac].xmdlorga_desc,g_xccc4_d[l_ac].xmdl008,g_xccc4_d[l_ac].xmdl008_desc, 
       g_xccc4_d[l_ac].xmdl008_desc_1,g_xccc4_d[l_ac].xmdl009,g_xccc4_d[l_ac].xmdl018,g_xccc4_d[l_ac].xccc280, 
       g_xccc4_d[l_ac].l_pjdb018,g_xccc4_d[l_ac].l_diff_2,g_xccc5_d[l_ac].l_seq_4,g_xccc5_d[l_ac].glar012, 
       g_xccc5_d[l_ac].glar012_desc,g_xccc5_d[l_ac].glar001,g_xccc5_d[l_ac].glacl004,g_xccc5_d[l_ac].glar006, 
       g_xccc5_d[l_ac].l_pjbg009,g_xccc5_d[l_ac].l_diff_3
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL apjq501_detail_show("'1'")
 
      CALL apjq501_xccc_t_mask()
 
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
 
 
 
 
 
   #應用 qs05 樣板自動產生(Version:4)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_xccc_d.deleteElement(g_xccc_d.getLength())
   CALL g_xccc2_d.deleteElement(g_xccc2_d.getLength())
 
   CALL g_xccc3_d.deleteElement(g_xccc3_d.getLength())
 
   CALL g_xccc4_d.deleteElement(g_xccc4_d.getLength())
 
   CALL g_xccc5_d.deleteElement(g_xccc5_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xccc_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE apjq501_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL apjq501_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL apjq501_detail_action_trans()
 
   LET l_ac = 1
   IF g_xccc_d.getLength() > 0 THEN
      CALL apjq501_b_fill2()
   END IF
 
      CALL apjq501_filter_show('xccc902','b_xccc902')
   CALL apjq501_filter_show('xccd902','b_xccd902')
   CALL apjq501_filter_show('xccc006','b_xccc006')
   CALL apjq501_filter_show('xccc007','b_xccc007')
   CALL apjq501_filter_show('xccc901','b_xccc901')
   CALL apjq501_filter_show('xmdl009','b_xmdl009')
   CALL apjq501_filter_show('glar012','b_glar012')
 
 
END FUNCTION
 
{</section>}
 
{<section id="apjq501.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apjq501_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   DEFINE l_xccc280     LIKE xccc_t.xccc280  #当期平均单价
#   DEFINE g_glaa003     LIKE glaa_t.glaa003
   DEFINE l_bdate       LIKE pjda_t.pjdadocdt
   DEFINE l_edate       LIKE pjda_t.pjdadocdt
   DEFINE l_date        LIKE pjda_t.pjdadocdt
   DEFINE l_yp_b        LIKE type_t.num10
   DEFINE l_yp_e        LIKE type_t.num10
   DEFINE l_xmdk_y      LIKE type_t.num10    #出货单对应年度
   DEFINE l_xmdk_p      LIKE type_t.num10    #出货单对应期别
   DEFINE l_xmdkdocno   LIKE xmdk_t.xmdkdocno   #出货单号
   DEFINE l_xmdkdocdt   LIKE xmdk_t.xmdkdocdt   #单据日期
   DEFINE l_xmdl008     LIKE xmdl_t.xmdl008     #料号
   DEFINE l_xmdl008_t   LIKE xmdl_t.xmdl008     #料号备份
   DEFINE l_xmdl009     LIKE xmdl_t.xmdl009     #产品特征
   DEFINE l_xmdl009_t   LIKE xmdl_t.xmdl009     #料号备份
   DEFINE l_xmdl017     LIKE xmdl_t.xmdl017     #出货单位
   DEFINE l_xmdl018     LIKE xmdl_t.xmdl018     #出货数量
   DEFINE l_xmdl037     LIKE xmdl_t.xmdl037     #销退量
   DEFINE l_unit        LIKE xmdl_t.xmdl017     #基础单位
   DEFINE l_value       LIKE xmdl_t.xmdl018     #暂存数量
   DEFINE l_save        LIKE xccc_t.xccc280     #暂存金额
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_datetype STRING
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   IF g_browser_tm.getLength() = 0 THEN
      RETURN
   END IF
   SELECT glaa003
     INTO g_glaa003
     FROM glaa_t
    WHERE glaaent = g_enterprise 
      AND glaald = tm.xcccld
   #根据年度期别算出起止单据日期
   CALL s_fin_date_get_period_range(g_glaa003,tm.l_xccc004_b,tm.l_xccc005_b)
      RETURNING l_bdate,l_date
   CALL s_fin_date_get_period_range(g_glaa003,tm.l_xccc004_e,tm.l_xccc005_e)
      RETURNING l_date,l_edate   
   LET l_yp_b = tm.l_xccc004_b*12 + tm.l_xccc005_b      
   LET l_yp_e = tm.l_xccc004_e*12 + tm.l_xccc005_e
   #抓取?境??
   IF FGL_GETENV("DBDATE") ='Y2MD/' THEN
      LET l_datetype = 'yy/mm/dd'
   ELSE
      LET l_datetype = 'yyyy/mm/dd'
   END IF
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   CALL g_xccc2_d.clear()
   CALL g_xccc3_d.clear()
   CALL g_xccc4_d.clear()
   CALL g_xccc5_d.clear()
   #单身根据第一页签显示明细  g_xccc_d[g_detail_idx].*
   #项目库存成本 g_xccc2_d
   LET l_ac = 1
   LET l_sql = " SELECT '',xccc006,imaal003,imaal004,xccc007,COALESCE(xccc901,0),COALESCE(xccc902,0) ",
               " FROM xccc_t LEFT OUTER JOIN imaal_t ON imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '",g_dlang,"' ",
               " WHERE xccc002 = '",g_xccc_d[g_detail_idx].pjba001,"' ",
               "   AND xccccomp = '",tm.xccccomp,"' ",
               "   AND xcccld = '",tm.xcccld,"' ",
               "   AND xccc003 = '",tm.xccc003,"' ",
               "   AND (xccc004*12 + xccc005 BETWEEN ",l_yp_b," AND ",l_yp_e,") ",
               "   AND xcccent = ",g_enterprise,
               " ORDER BY xccc006,xccc007 "
   PREPARE apjq501_detail2_pre FROM l_sql
   DECLARE apjq501_detail2_cur CURSOR FOR apjq501_detail2_pre
   FOREACH apjq501_detail2_cur INTO g_xccc2_d[l_ac].*
      LET g_xccc2_d[l_ac].l_seq_1 = l_ac
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_xccc2_d.deleteElement(g_xccc2_d.getLength())   
   #项目在制成本 g_xccc3_d
   LET l_ac = 1
   LET l_sql = " SELECT '',xccd006,xccd007,imaal003,imaal004,xccd008,COALESCE(xccd901,0),COALESCE(xccd902,0) ",
               " FROM xccd_t LEFT OUTER JOIN imaal_t ON imaal001 = xccd007 AND imaalent = xccdent AND imaal002 = '",g_dlang,"' ",
               " WHERE xccd002 = '",g_xccc_d[g_detail_idx].pjba001,"' ",
               "   AND xccdcomp = '",tm.xccccomp,"' ",
               "   AND xccdld = '",tm.xcccld,"' ",
               "   AND xccd003 = '",tm.xccc003,"' ",
               "   AND (xccd004*12 + xccd005 BETWEEN ",l_yp_b," AND ",l_yp_e,") ",
               "   AND xccdent = ",g_enterprise,
               " ORDER BY xccd006,xccd007,xccd008 "
   PREPARE apjq501_detail3_pre FROM l_sql
   DECLARE apjq501_detail3_cur CURSOR FOR apjq501_detail3_pre
   FOREACH apjq501_detail3_cur INTO g_xccc3_d[l_ac].*
      LET g_xccc3_d[l_ac].l_seq_2 = l_ac
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_xccc3_d.deleteElement(g_xccc3_d.getLength())
    #项目投入成本 g_xccc4_d
    #160715-00007#1 add-S
    #预算金额=依项目号+料号SUM(apjm210中材料预算页签本币未税金额pjbd018)
    #差异金额=预算金额-投入成本
    #160715-00007#1 add-E
   LET l_ac = 1
   #161026-00054#1---mod---s
   #LET l_sql = " SELECT UNIQUE xmdkdocno,xmdkdocdt,xmdl017,xmdl008,xmdl009,COALESCE(xmdl018,0),COALESCE(xmdl037,0) ",
   #            #160715-00007#1 add-S
   #            " ,(SELECT SUM(COALESCE(pjbd018,0)) FROM pjbd_t WHERE pjbd001 = '",g_xccc_d[g_detail_idx].pjba001,"' ",
   #            " AND pjbdent = ",g_enterprise," AND pjbd005 = xmdl008) l_pjbd018",
   #            "   FROM xmdk_t,xmdl_t ",
   #            #160715-00007#1 add-E
   #            "  WHERE xmdk002 = 'X' AND (xmdkdocdt < to_date('",l_edate,"','",l_datetype,"')) AND xmdkstus = 'S' AND xmdk000 = '1' ",  #抓取截止期别前的所有资料
   #            "    AND xmdkdocno = xmdldocno AND xmdkent = xmdlent AND xmdksite = xmdlsite ",
   #            "    AND xmdkent = ",g_enterprise," AND xmdksite = '",g_site,"' ",
   #            "    AND xmdl030 = '",g_xccc_d[g_detail_idx].pjba001,"' ",
   #            "  ORDER BY xmdkdocno,xmdkdocdt,xmdl008,xmdl009 " 
   #LET l_xmdl008_t = NULL                  
   #LET l_xmdl009_t = NULL
   #PREPARE apjq501_detail4_pre FROM l_sql
   #DECLARE apjq501_detail4_cur CURSOR FOR apjq501_detail4_pre
   #FOREACH apjq501_detail4_cur INTO l_xmdkdocno,l_xmdkdocdt,l_xmdl008,l_xmdl009,l_xmdl017,l_xmdl018,l_xmdl037
   #                                 ,g_xccc4_d[l_ac].l_pjdb018      #160715-00007#1 add
   #   #1.数量换算成基础单位
   #   IF cl_null(l_xmdl018) THEN LET l_xmdl018 = 0 END IF
   #   IF cl_null(l_xmdl037) THEN LET l_xmdl037 = 0 END IF
   #   LET l_value = l_xmdl018-l_xmdl037
   #   SELECT imaa006 INTO l_unit FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = l_xmdl008
   #   CALL s_aooi250_convert_qty(l_xmdl008,l_xmdl017,l_unit,l_value)
   #                  RETURNING l_success,l_value
   #   #2.算当前单据所属的年期
   #   CALL s_fin_date_get_period_value(g_glaa003,tm.xcccld,l_xmdkdocdt) RETURNING l_success,l_xmdk_y,l_xmdk_p
   #   #3.抓单价
   #   LET l_xccc280 = NULL
   #   SELECT xccc280 INTO l_xccc280 
   #     FROM xccc_t 
   #    WHERE xcccent = g_enterprise AND xccc002 = g_xccc_d[l_ac].pjba001
   #      AND xccc006 = l_xmdl008 AND xccc007 = l_xmdl009
   #      AND xccccomp = tm.xccccomp AND xcccld = tm.xcccld AND xccc003 = tm.xccc003
   #      AND xccc004 = l_xmdk_y AND xccc005 = l_xmdk_p
   #   IF cl_null(l_value) THEN LET l_value = 0 END IF
   #   IF cl_null(l_xccc280) THEN LET l_xccc280 = 0 END IF
   #   LET l_save = l_value*l_xccc280
   #   
   #   IF cl_null(l_xmdl008_t) THEN 
   #      LET l_xmdl008_t = l_xmdl008 
   #      LET l_xmdl009_t = l_xmdl009
   #   END IF
   #   IF NOT cl_null(l_xmdl008_t) AND l_xmdl008_t <> l_xmdl008 OR l_xmdl009_t <> l_xmdl009 THEN
   #      LET l_xmdl008_t = l_xmdl008 
   #      LET l_xmdl009_t = l_xmdl009
   #      LET g_xccc4_d[l_ac].l_seq_3 = l_ac
   #      LET g_xccc4_d[l_ac].xmdl008 = l_xmdl008
   #      LET g_xccc4_d[l_ac].xmdl009 = l_xmdl009
   #      CALL s_desc_get_item_desc(g_xccc4_d[l_ac].xmdl008) RETURNING g_xccc4_d[l_ac].xmdl008_desc,g_xccc4_d[l_ac].xmdl008_desc_1
   #      LET g_xccc4_d[l_ac].xmdl018 = g_xccc4_d[l_ac].xmdl018 + l_value
   #      LET g_xccc4_d[l_ac].xccc280 = g_xccc4_d[l_ac].xccc280 + l_save
   #      #160715-00007#1 add-S
   #      #差异金额=预算金额-投入成本
   #      LET g_xccc4_d[l_ac].l_diff_2 = g_xccc4_d[l_ac].l_pjdb018 - g_xccc4_d[l_ac].xccc280
   #      #160715-00007#1 add-E
   #      LET l_ac = l_ac + 1
   #   ELSE
   #      LET g_xccc4_d[l_ac].xmdl018 = g_xccc4_d[l_ac].xmdl018 + l_value
   #      LET g_xccc4_d[l_ac].xccc280 = g_xccc4_d[l_ac].xccc280 + l_save
   #   END IF
   #END FOREACH
   #IF NOT cl_null(l_xmdl008) THEN
   #   LET g_xccc4_d[l_ac].l_seq_3 = l_ac
   #   LET g_xccc4_d[l_ac].xmdl008 = l_xmdl008
   #   LET g_xccc4_d[l_ac].xmdl009 = l_xmdl009
   #   CALL s_desc_get_item_desc(g_xccc4_d[l_ac].xmdl008) RETURNING g_xccc4_d[l_ac].xmdl008_desc,g_xccc4_d[l_ac].xmdl008_desc_1
   #ELSE
   #   CALL g_xccc4_d.deleteElement(g_xccc4_d.getLength())
   #END IF
   LET l_sql = " SELECT UNIQUE '',xcck002,xcbfl003,xcck010,'','',xcck011,",
               "        SUM(-1*xcck009*xcck201),SUM(-1*xcck009*xcck202), ",
               " (SELECT SUM(COALESCE(pjbd018,0)) FROM pjbd_t WHERE pjbd001 = '",g_xccc_d[g_detail_idx].pjba001,"' ",
               " AND pjbdent = ",g_enterprise," AND pjbd005 = xcck010) l_pjbd018,0",               
               "        FROM xcck_t ", 
               "        LEFT JOIN xcbfl_t ON xcbflent=xcckent AND xcbflcomp=xcckcomp AND xcbfl001=xcck002 AND xcbfl002='",g_dlang,"'",
               "  WHERE xcckent = '",g_enterprise,"' AND xcckld = '",tm.xcccld,"'",
               "    AND xcckcomp = '",tm.xccccomp,"' ",
               "    AND (xcck004*12 + xcck005 BETWEEN ",l_yp_b," AND ",l_yp_e,") ",
               "    AND xcck003 = '",tm.xccc003,"' ",
               "    AND xcck030 = '",g_xccc_d[g_detail_idx].pjba001,"' ",
               "    AND xcck001 = '1' ",
               "    AND xcck055 IN('303X','305X') ",                                       
               " GROUP BY xcck002,xcbfl003,xcck010,xcck011 ",   
               " ORDER BY xcck002,xcbfl003,xcck010,xcck011 " 
   PREPARE apjq501_detail4_pre FROM l_sql
   DECLARE apjq501_detail4_cur CURSOR FOR apjq501_detail4_pre
   FOREACH apjq501_detail4_cur INTO g_xccc4_d[l_ac].*
      LET g_xccc4_d[l_ac].l_seq_3 = l_ac
      CALL s_desc_get_item_desc(g_xccc4_d[l_ac].xmdl008) RETURNING g_xccc4_d[l_ac].xmdl008_desc,g_xccc4_d[l_ac].xmdl008_desc_1     
      LET g_xccc4_d[l_ac].l_diff_2 = g_xccc4_d[l_ac].l_pjdb018 - g_xccc4_d[l_ac].xccc280
      LET l_ac = l_ac +1  
   END FOREACH      
   #161026-00054#1---mod---s
   #160715-00007#1 add-S-只有预算没有实际
   LET l_sql = " SELECT UNIQUE 0,'','',pjbd005,imaal003,imaal004,pjbd021,0,0 ",
               #160715-00007#1 add-S
               " ,SUM(COALESCE(pjbd018,0)),SUM(COALESCE(pjbd018,0)) ",
               "   FROM pjbd_t LEFT OUTER JOIN imaal_t ON imaal001 = pjbd005 AND imaal002 = '",g_dlang,"' AND imaalent = pjbdent ",
               #160715-00007#1 add-E
               "  WHERE pjbd001 = '",g_xccc_d[g_detail_idx].pjba001,"' ",
               "    AND pjbdent = ",g_enterprise,
               "    AND NOT EXISTS ",
               "        (SELECT 1 FROM xmdl_t,xmdk_t WHERE pjbd005 = xmdl008 AND pjbd021 = xmdl009 ",
               "           AND xmdk002 = 'X' AND (xmdkdocdt <to_date('",l_edate,"','",l_datetype,"')) AND xmdkstus = 'S' AND xmdk000 = '1' ",  #抓取截止期别前的所有资料
               "           AND xmdkdocno = xmdldocno AND xmdkent = xmdlent AND xmdksite = xmdlsite ",
               "           AND xmdkent = ",g_enterprise," AND xmdksite = '",g_site,"' ",
               "           AND xmdl030 = '",g_xccc_d[g_detail_idx].pjba001,"' )",
               "  GROUP BY pjbd005,imaal003,imaal004,pjbd021 "
   PREPARE apjq501_detail4_pre1 FROM l_sql
   DECLARE apjq501_detail4_cur1 CURSOR FOR apjq501_detail4_pre1
#   LET l_ac = l_ac+1
   FOREACH apjq501_detail4_cur1 INTO g_xccc4_d[l_ac].*
      LET g_xccc4_d[l_ac].l_seq_3 = l_ac
      LET l_ac = l_ac+1   
   END FOREACH
   #160715-00007#1 add-E
   #项目费用投入 g_xccc5_d glar005-glar006 glar001 = 项目号
   LET l_ac = 1
   #160715-00007#1 add-S
#   LET l_sql = " SELECT '',glar001,glacl004,COALESCE(glar005,0)-COALESCE(glar006,0) ",
#               " FROM glar_t LEFT OUTER JOIN glacl_t ON glacl001 = '",g_glaa003,"' AND glacl002 = glar001 AND glacl003 = '",g_dlang,"' ",
#               " WHERE glar022 = '",g_xccc_d[g_detail_idx].pjba001,"' ",
#               "   AND glarcomp = '",tm.xccccomp,"' ",
#               "   AND glarld = '",tm.xcccld,"' ",
#               "   AND (glar002*12 + glar003 BETWEEN ",l_yp_b," AND ",l_yp_e,") ",
#               "   AND glarent = ",g_enterprise,
#               " ORDER BY glar001 "
               
   LET l_sql = " SELECT '',glar012,ooefl003,glar001,glacl004,SUM(COALESCE(glar005,0)-COALESCE(glar006,0)),0,0 ",
               " FROM glar_t LEFT OUTER JOIN glacl_t ON glacl001 = '",g_glaa003,"' AND glacl002 = glar001 AND glacl003 = '",g_dlang,"' ",
               " WHERE glar022 = '",g_xccc_d[g_detail_idx].pjba001,"' ",
               "   AND glarcomp = '",tm.xccccomp,"' ",
               "   AND glarld = '",tm.xcccld,"' ",
               "   AND glar001 NOT IN ",
               #160905-00007#3 mod-S
#               "        (SELECT glab005 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glab002 = '8003' UNION ",
#               "        (SELECT glab006 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glab002 = '8003') UNION ",
#               "        (SELECT glab007 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glab002 = '8003') UNION ",
#               "        (SELECT glab008 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glab002 = '8003') UNION ",
#               "        (SELECT glab009 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glab002 = '8003')) ",
               "        (SELECT glab005 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glaaent = ",g_enterprise," AND glab002 = '8003' UNION ",
               "        (SELECT glab006 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glaaent = ",g_enterprise," AND glab002 = '8003') UNION ",
               "        (SELECT glab007 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glaaent = ",g_enterprise," AND glab002 = '8003') UNION ",
               "        (SELECT glab008 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glaaent = ",g_enterprise," AND glab002 = '8003') UNION ",
               "        (SELECT glab009 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glaaent = ",g_enterprise," AND glab002 = '8003')) ",
               #160905-00007#3 mod-E
               "   AND (glar002*12 + glar003 BETWEEN ",l_yp_b," AND ",l_yp_e,") ",
               "   AND glarent = ",g_enterprise,
               "   AND EXISTS(SELECT 1 FROM glac_t,glaa_t WHERE glaaent=glacent AND glaa004=glac001 AND glaald='",tm.xcccld,"' AND glac002=glar001 AND glac003 IN('2','3') AND glac002 LIKE '5%')",  #161026-00054#1
               " GROUP BY glar001,glacl004 ",
               " UNION ", 
               " (SELECT '','','',pjbg003,oocql004,",
#               " (SELECT SUM(COALESCE(glar005,0)-COALESCE(glar006,0)) FROM glar_t WHERE glarld = '",tm.xcccld,"' AND glarcomp = '",tm.xccccomp,"' ",  #160905-00007#3 marked
               " (SELECT SUM(COALESCE(glar005,0)-COALESCE(glar006,0)) FROM glar_t WHERE glarld = '",tm.xcccld,"' AND glarent = ",g_enterprise," AND glarcomp = '",tm.xccccomp,"' ",  #160905-00007#3 mod
               "  AND glar022 = '",g_xccc_d[g_detail_idx].pjba001,"' AND (glar002*12 + glar003 BETWEEN ",l_yp_b," AND ",l_yp_e,") ",
               "  AND glar001 IN ",
               #160905-00007#3 mod-S
#               "     (SELECT glab005 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glab002 = '8003' AND glab003 = pjbg003 UNION ",
#               "     (SELECT glab006 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glab002 = '8003' AND glab003 = pjbg003 ) UNION ",
#               "     (SELECT glab007 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glab002 = '8003' AND glab003 = pjbg003 ) UNION ",
#               "     (SELECT glab008 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glab002 = '8003' AND glab003 = pjbg003 ) UNION ",
#               "     (SELECT glab009 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glab002 = '8003' AND glab003 = pjbg003 )) ",
#               "     ) sum1,",
               "     (SELECT glab005 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glabent = ",g_enterprise," AND glab002 = '8003' AND glab003 = pjbg003 UNION ",
               "     (SELECT glab006 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glabent = ",g_enterprise," AND glab002 = '8003' AND glab003 = pjbg003 ) UNION ",
               "     (SELECT glab007 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glabent = ",g_enterprise," AND glab002 = '8003' AND glab003 = pjbg003 ) UNION ",
               "     (SELECT glab008 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glabent = ",g_enterprise," AND glab002 = '8003' AND glab003 = pjbg003 ) UNION ",
               "     (SELECT glab009 FROM glab_t WHERE glabld = '",tm.xcccld,"' AND glabent = ",g_enterprise," AND glab002 = '8003' AND glab003 = pjbg003 )) ",
               "     ) sum1,",
               #160905-00007#3 mod-E
               " SUM(pjbg009),0 ",
               " FROM pjbg_t LEFT OUTER JOIN oocql_t ON oocql001 = '8003' AND oocql002 = pjbg003 AND oocql003 = '",g_dlang,"' AND oocqlent = ",g_enterprise," ",
               " WHERE pjbg001 = '",g_xccc_d[g_detail_idx].pjba001,"' ",
               "   AND pjbgent = ",g_enterprise,
               " GROUP BY pjbg003,oocql004) ",
               " ORDER BY glar001 "  
   #160715-00007#1 add-E               
   PREPARE apjq501_detail5_pre FROM l_sql
   DECLARE apjq501_detail5_cur CURSOR FOR apjq501_detail5_pre
   FOREACH apjq501_detail5_cur INTO g_xccc5_d[l_ac].*
      LET g_xccc5_d[l_ac].l_seq_4 = l_ac
      #160715-00007#1 add-S
      IF cl_null(g_xccc5_d[l_ac].glar006) THEN
         LET g_xccc5_d[l_ac].glar006 = 0
      END IF
      LET g_xccc5_d[l_ac].l_diff_3 = g_xccc5_d[l_ac].l_pjbg009 - g_xccc5_d[l_ac].glar006
      #160715-00007#1 add-E
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_xccc5_d.deleteElement(g_xccc5_d.getLength())
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
 
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   CALL apjq501_idx_chk()
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="apjq501.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apjq501_detail_show(ps_page)
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
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc2_d[l_ac].xccc006
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xccc2_d[l_ac].xccc006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc2_d[l_ac].xccc006_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc3_d[l_ac].xccd007
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xccc3_d[l_ac].xccd007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc3_d[l_ac].xccd007_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'4'",1) > 0 THEN
      #帶出公用欄位reference值page4
      
 
      #add-point:show段單身reference name="detail_show.body4.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc4_d[l_ac].xmdl008
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xccc4_d[l_ac].xmdl008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc4_d[l_ac].xmdl008_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'5'",1) > 0 THEN
      #帶出公用欄位reference值page5
      
 
      #add-point:show段單身reference name="detail_show.body5.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc5_d[l_ac].glar012
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xccc5_d[l_ac].glar012_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc5_d[l_ac].glar012_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apjq501.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION apjq501_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xccc902,xccd902,xccc006,xccc007,xccc901,xmdl009,glar012
                          FROM s_detail1[1].b_xccc902,s_detail1[1].b_xccd902,s_detail2[1].b_xccc006, 
                              s_detail2[1].b_xccc007,s_detail2[1].b_xccc901,s_detail4[1].b_xmdl009,s_detail5[1].b_glar012 
 
 
         BEFORE CONSTRUCT
                     DISPLAY apjq501_filter_parser('xccc902') TO s_detail1[1].b_xccc902
            DISPLAY apjq501_filter_parser('xccd902') TO s_detail1[1].b_xccd902
            DISPLAY apjq501_filter_parser('xccc006') TO s_detail2[1].b_xccc006
            DISPLAY apjq501_filter_parser('xccc007') TO s_detail2[1].b_xccc007
            DISPLAY apjq501_filter_parser('xccc901') TO s_detail2[1].b_xccc901
            DISPLAY apjq501_filter_parser('xmdl009') TO s_detail4[1].b_xmdl009
            DISPLAY apjq501_filter_parser('glar012') TO s_detail5[1].b_glar012
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<l_seq>>----
         #----<<b_pjba001>>----
         #----<<b_xccc902>>----
         #Ctrlp:construct.c.filter.page1.b_xccc902
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc902
            #add-point:ON ACTION controlp INFIELD b_xccc902 name="construct.c.filter.page1.b_xccc902"
            
            #END add-point
 
 
         #----<<b_xccd902>>----
         #Ctrlp:construct.c.filter.page1.b_xccd902
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccd902
            #add-point:ON ACTION controlp INFIELD b_xccd902 name="construct.c.filter.page1.b_xccd902"
            
            #END add-point
 
 
         #----<<l_sum_1>>----
         #----<<l_xccc280_1>>----
         #----<<l_glar006_1>>----
         #----<<l_sum_2>>----
         #----<<l_xccc280_2>>----
         #----<<l_glar006_2>>----
         #----<<l_sum_3>>----
         #----<<l_sum_4>>----
         #----<<l_pjba016>>----
         #----<<l_diff_1>>----
         #----<<b_xcccld_1>>----
         #----<<b_xccc001_1>>----
         #----<<b_xccc002_1>>----
         #----<<b_xccc003_1>>----
         #----<<b_xccc004_1>>----
         #----<<b_xccc005_1>>----
         #----<<b_xccc008_1>>----
         #----<<l_seq_1>>----
         #----<<b_xccc006>>----
         #Ctrlp:construct.c.filter.page2.b_xccc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc006
            #add-point:ON ACTION controlp INFIELD b_xccc006 name="construct.c.filter.page2.b_xccc006"
            
            #END add-point
 
 
         #----<<b_xccc006_desc>>----
         #----<<b_xccc006_desc_1>>----
         #----<<b_xccc007>>----
         #Ctrlp:construct.c.filter.page2.b_xccc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc007
            #add-point:ON ACTION controlp INFIELD b_xccc007 name="construct.c.filter.page2.b_xccc007"
            
            #END add-point
 
 
         #----<<b_xccc901>>----
         #Ctrlp:construct.c.filter.page2.b_xccc901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccc901
            #add-point:ON ACTION controlp INFIELD b_xccc901 name="construct.c.filter.page2.b_xccc901"
            
            #END add-point
 
 
         #----<<b_xccc902_1>>----
         #----<<l_seq_2>>----
         #----<<b_xccd006>>----
         #----<<b_xccd007>>----
         #----<<b_xccd007_desc>>----
         #----<<b_xccd007_desc_1>>----
         #----<<b_xccd008>>----
         #----<<b_xccd901>>----
         #----<<b_xccd902_1>>----
         #----<<l_seq_3>>----
         #----<<b_xmdlorga>>----
         #----<<b_xmdlorga_desc>>----
         #----<<b_xmdl008>>----
         #----<<b_xmdl008_desc>>----
         #----<<b_xmdl008_desc_1>>----
         #----<<b_xmdl009>>----
         #Ctrlp:construct.c.filter.page4.b_xmdl009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl009
            #add-point:ON ACTION controlp INFIELD b_xmdl009 name="construct.c.filter.page4.b_xmdl009"
            
            #END add-point
 
 
         #----<<b_xmdl018>>----
         #----<<b_xccc280_3>>----
         #----<<l_pjdb018>>----
         #----<<l_diff_2>>----
         #----<<l_seq_4>>----
         #----<<b_glar012>>----
         #Ctrlp:construct.c.page5.b_glar012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar012
            #add-point:ON ACTION controlp INFIELD b_glar012 name="construct.c.filter.page5.b_glar012"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar012  #顯示到畫面上
            NEXT FIELD b_glar012                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar012_desc>>----
         #----<<b_glar001>>----
         #----<<b_glacl004>>----
         #----<<b_glar006>>----
         #----<<l_pjbg009>>----
         #----<<l_diff_3>>----
 
 
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
 
 
 
 
 
   
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL apjq501_filter_show('xccc902','b_xccc902')
   CALL apjq501_filter_show('xccd902','b_xccd902')
   CALL apjq501_filter_show('xccc006','b_xccc006')
   CALL apjq501_filter_show('xccc007','b_xccc007')
   CALL apjq501_filter_show('xccc901','b_xccc901')
   CALL apjq501_filter_show('xmdl009','b_xmdl009')
   CALL apjq501_filter_show('glar012','b_glar012')
 
 
   CALL apjq501_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="apjq501.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION apjq501_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
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
 
{<section id="apjq501.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION apjq501_filter_show(ps_field,ps_object)
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
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = apjq501_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="apjq501.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION apjq501_detail_action_trans()
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
 
{<section id="apjq501.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION apjq501_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
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
 
{<section id="apjq501.mask_functions" >}
 &include "erp/apj/apjq501_mask.4gl"
 
{</section>}
 
{<section id="apjq501.other_function" readonly="Y" >}

PRIVATE FUNCTION apjq501_query()
   DEFINE ls_wc         LIKE type_t.chr500
   DEFINE l_flag        LIKE type_t.num5        #放弃查询后不需再查找数据库里的资料
   DEFINE l_xccc003     LIKE xccc_t.xccc003     #成本计算类型
   #wc備份
   LET ls_wc = g_wc
   LET g_wc_filter_t = g_wc_filter
   LET g_master_idx = l_ac

   LET INT_FLAG = 0
   CLEAR FORM
   LET g_wc = ''
   INITIALIZE tm.* TO NULL
   CALL g_xccc_d.clear()
   CALL g_xccc2_d.clear()
   CALL g_xccc3_d.clear()
   CALL g_xccc4_d.clear()
   CALL g_xccc5_d.clear()
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   LET g_wc_filter = " 1=1"
   
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT tm.l_xccc004_b,tm.l_xccc005_b,tm.l_xccc004_e,tm.l_xccc005_e FROM l_xccc004_b,l_xccc005_b,l_xccc004_e,l_xccc005_e
         AFTER FIELD l_xccc004_b
            IF NOT cl_null(tm.l_xccc004_b) AND NOT cl_null(tm.l_xccc004_e) THEN
                IF tm.l_xccc004_b > tm.l_xccc004_e THEN  #截止不能小于起始
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'acr-00064'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD l_xccc004_b
                END IF
             END IF
         AFTER FIELD l_xccc005_b
            IF NOT cl_null(tm.l_xccc005_b) AND NOT cl_null(tm.l_xccc005_e) THEN
               IF tm.l_xccc004_b = tm.l_xccc004_e AND tm.l_xccc005_b > tm.l_xccc005_e THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD l_xccc005_b
               END IF
            END IF
         AFTER FIELD l_xccc004_e
            IF NOT cl_null(tm.l_xccc004_b) AND NOT cl_null(tm.l_xccc004_e) THEN
                IF tm.l_xccc004_b > tm.l_xccc004_e THEN  #截止不能小于起始
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'acr-00064'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD l_xccc004_e
                END IF
             END IF
         AFTER FIELD l_xccc005_e
            IF NOT cl_null(tm.l_xccc005_b) AND NOT cl_null(tm.l_xccc005_e) THEN
               IF tm.l_xccc004_b = tm.l_xccc004_e AND tm.l_xccc005_b > tm.l_xccc005_e THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD l_xccc005_e
               END IF
            END IF     
      END INPUT
      #161026-00054#1---add---s
      CONSTRUCT g_wc_pjba ON pjba001
           FROM b_pjba001
                      
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD b_pjba001 #法人组织
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001_4()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pjba001  #顯示到畫面上
            NEXT FIELD b_pjba001                     #返回原欄位         
         
         
      END CONSTRUCT      
      #161026-00054#1---add---e
      CONSTRUCT g_wc_table ON xccccomp,xcccld,xccc003
           FROM b_xccccomp,b_xcccld,b_xccc003
                      
         BEFORE CONSTRUCT
            CALL apjq501_default()  #预设
            
            DISPLAY tm.xccccomp,tm.xcccld,tm.xccc003,tm.l_xccc004_b,tm.l_xccc005_b,tm.l_xccc004_e,tm.l_xccc005_e
                 TO b_xccccomp,b_xcccld,b_xccc003,l_xccc004_b,l_xccc005_b,l_xccc004_e,l_xccc005_e
            DISPLAY tm.xccccomp_desc TO b_xccccomp_desc   #法人組織
            DISPLAY tm.xcccld_desc TO b_xcccld_desc     #帳別編號
            DISPLAY tm.xccc003_desc TO b_xccc003_desc     #成本计算类型
         AFTER FIELD b_xccccomp
            LET tm.xccccomp = GET_FLDBUF(b_xccccomp)
            
         AFTER FIELD b_xcccld
            LET tm.xcccld = GET_FLDBUF(b_xcccld)
            
         AFTER FIELD b_xccc003
            LET tm.xccc003 = GET_FLDBUF(b_xccc003)
            
         AFTER FIELD l_xccc004_b
            LET tm.l_xccc004_b = GET_FLDBUF(l_xccc004_b)
            
         AFTER FIELD l_xccc005_b
            LET tm.l_xccc005_b = GET_FLDBUF(l_xccc005_b)
            
         AFTER FIELD l_xccc004_e
            LET tm.l_xccc004_e = GET_FLDBUF(l_xccc004_e)
            
         AFTER FIELD l_xccc005_e
            LET tm.l_xccc005_e = GET_FLDBUF(l_xccc005_e)
            
         ON ACTION controlp INFIELD b_xccccomp #法人组织
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooefstus = 'Y'"
            CALL q_ooef001_2()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xccccomp  #顯示到畫面上
            NEXT FIELD b_xccccomp                     #返回原欄位

         ON ACTION controlp INFIELD b_xcccld   #账别编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()                #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcccld  #顯示到畫面上
            NEXT FIELD b_xcccld                     #返回原欄位
 
         ON ACTION controlp INFIELD b_xccc003  #成本计算类型
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xccc003  #顯示到畫面上
            NEXT FIELD b_xccc003                     #返回原欄位
 
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
  
   LET l_flag = 1   #放弃查询后不需再查找数据库里的资料
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      LET l_flag = 0   #放弃查询后不需再查找数据库里的资料
      #還原
#      LET g_wc = ls_wc                  #放弃查询后不需再查找数据库里的资料
#      LET g_wc_filter = g_wc_filter_t   #放弃查询后不需再查找数据库里的资料
   ELSE
      LET g_master_idx = 1
   END IF
   
   LET g_wc = g_wc_table 

   LET g_wc2 = " 1=1"

   LET g_error_show = 1
   #INITIALIZE tm.* TO NULL
   IF l_flag THEN    #放弃查询后不需再查找数据库里的资料
      CALL apjq501_browser_fill()
      CALL apjq501_fetch("")
      CALL apjq501_idx_chk()
#      CALL apjq501_b_fill()
   END IF            #放弃查询后不需再查找数据库里的资料
#   INITIALIZE tm.* TO NULL
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
PRIVATE FUNCTION apjq501_default()
DEFINE l_xccc003    LIKE xccc_t.xccc003

   #预设当前site的法人，主账套，年度期别，#成本计算类型   #150805-00001#3add加IF，截止年期赋值
   IF cl_null(tm.xccccomp) AND cl_null(tm.xcccld) AND cl_null(tm.xccc003) AND cl_null(tm.l_xccc004_b) AND cl_null(tm.l_xccc005_b) THEN
      CALL s_axc_set_site_default() RETURNING tm.xccccomp,tm.xcccld,tm.l_xccc004_b,tm.l_xccc005_b,tm.xccc003
      LET tm.l_xccc004_e = tm.l_xccc004_b
      LET tm.l_xccc005_e = tm.l_xccc005_b
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = tm.xccccomp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET tm.xccccomp_desc = '', g_rtn_fields[1] , ''
   
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = tm.xcccld
      CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET tm.xcccld_desc = '', g_rtn_fields[1] , ''
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = tm.xccc003
      CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET tm.xccc003_desc = '', g_rtn_fields[1] , ''
   END IF
   #fengmy150122---begin
   #S-FIN-6020='2'时，库存结存、在制结存、结存小计三个栏位隐藏，项目库存成本页签、项目在制成本页签隐藏
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6020') RETURNING g_para_data   #项目成本归集原则          
   #161026-00054#1---mod---s
   #IF g_para_data = '2' THEN
   #   CALL cl_set_comp_visible('xccc902,xccd902,l_sum_1',FALSE)
   #   CALL cl_set_comp_visible('page_2,page_3',FALSE)      
   #ELSE
   #   CALL cl_set_comp_visible('xccc902,xccd902,l_sum_1',TRUE)
   #   CALL cl_set_comp_visible('page_2,page_3',TRUE)           
   #END IF 
   IF g_para_data = '2' THEN
      CALL cl_set_comp_visible('b_xccc902,b_xccd902,l_sum_1',FALSE)
      CALL cl_set_comp_visible('page_1,page_2',FALSE)      
   ELSE
      CALL cl_set_comp_visible('b_xccc902,b_xccd902,l_sum_1',TRUE)
      CALL cl_set_comp_visible('page_1,page_2',TRUE)           
   END IF    
   #161026-00054#1---mod---e
END FUNCTION

################################################################################
#填充第一个单身
################################################################################
PRIVATE FUNCTION apjq501_b_fill1()
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準
   DEFINE l_wc STRING
   DEFINE l_xccc280     LIKE xccc_t.xccc280  #当期平均单价
#   DEFINE g_glaa003     LIKE glaa_t.glaa003
   DEFINE l_bdate       LIKE pjda_t.pjdadocdt
   DEFINE l_edate       LIKE pjda_t.pjdadocdt
   DEFINE l_date        LIKE pjda_t.pjdadocdt
   DEFINE l_yp_b        LIKE type_t.num10
   DEFINE l_yp_e        LIKE type_t.num10
   DEFINE l_xmdk_y      LIKE type_t.num10    #出货单对应年度
   DEFINE l_xmdk_p      LIKE type_t.num10    #出货单对应期别
   DEFINE l_xmdkdocno   LIKE xmdk_t.xmdkdocno   #出货单号
   DEFINE l_xmdkdocdt   LIKE xmdk_t.xmdkdocdt   #单据日期
   DEFINE l_xmdl008     LIKE xmdl_t.xmdl008     #料号
   DEFINE l_xmdl009     LIKE xmdl_t.xmdl009     #产品特征
   DEFINE l_xmdl017     LIKE xmdl_t.xmdl017     #出货单位
   DEFINE l_xmdl018     LIKE xmdl_t.xmdl018     #出货数量
   DEFINE l_xmdl037     LIKE xmdl_t.xmdl037     #销退量
   DEFINE l_unit        LIKE xmdl_t.xmdl017     #基础单位
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_save        LIKE xccc_t.xccc280
   #end add-point
   #add-point:b_fill段define-客製

   #end add-point
 
   #add-point:b_fill段sql_before
   IF g_browser_tm.getLength() = 0 THEN
      RETURN
   END IF
   SELECT glaa003
     INTO g_glaa003
     FROM glaa_t
    WHERE glaaent = g_enterprise 
      AND glaald = tm.xcccld
   #根据年度期别算出起止单据日期
   CALL s_fin_date_get_period_range(g_glaa003,tm.l_xccc004_b,tm.l_xccc005_b)
      RETURNING l_bdate,l_date
   CALL s_fin_date_get_period_range(g_glaa003,tm.l_xccc004_e,tm.l_xccc005_e)
      RETURNING l_date,l_edate   
   LET l_yp_b = tm.l_xccc004_b*12 + tm.l_xccc005_b      
   LET l_yp_e = tm.l_xccc004_e*12 + tm.l_xccc005_e
   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   #161026-00054#1---add---s
   IF cl_null(g_wc_pjba) THEN
      LET g_wc_pjba = " 1=1"
   END IF   
   #161026-00054#1---add---e
   CALL g_xccc_d.clear()
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:2)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql
   #LET g_sql = "SELECT UNIQUE pjba001,pjba016 FROM pjba_t WHERE pjbaent = ",g_enterprise," AND pjbastus = 'Y' AND pjba022 <> '2' " #160715-00007#1 mod
   LET g_sql = "SELECT UNIQUE pjba001,pjba016 FROM pjba_t WHERE pjbaent = ",g_enterprise," AND pjbastus = 'Y' AND pjba022 <> '2' AND ",g_wc_pjba  #161026-00054#1
   PREPARE apjq501_pjba_pre FROM g_sql
   DECLARE apjq501_pjba_cur CURSOR FOR apjq501_pjba_pre
   FOREACH apjq501_pjba_cur INTO g_xccc_d[l_ac].pjba001,g_xccc_d[l_ac].l_pjba016      #160715-00007#1 mod
      LET g_xccc_d[l_ac].l_seq = l_ac
      IF g_para_data = '2' THEN
         LET g_xccc_d[l_ac].xccc902 = 0
         LET g_xccc_d[l_ac].xccd902 = 0
      ELSE
         #庫存结存[xccc902]：依法人组织、账套、成本域（=项目号）、成本计算类型、SUM(xccc902) pjba001 = xccc002
         SELECT SUM(COALESCE(xccc902,0)) INTO g_xccc_d[l_ac].xccc902
           FROM xccc_t
          WHERE xccc002 = g_xccc_d[l_ac].pjba001
            AND xccccomp = tm.xccccomp
            AND xcccld = tm.xcccld
            AND xccc003 = tm.xccc003
            AND (xccc004*12 + xccc005 BETWEEN l_yp_b AND l_yp_e)
            AND xcccent = g_enterprise
         IF cl_null(g_xccc_d[l_ac].xccc902) THEN LET g_xccc_d[l_ac].xccc902 = 0 END IF
         #在制结存[xccd902]：依法人组织、账套、成本域（=项目号）、成本计算类型、SUM(xccd902)
         SELECT SUM(COALESCE(xccd902,0)) INTO g_xccc_d[l_ac].xccd902
           FROM xccd_t
          WHERE xccd002 = g_xccc_d[l_ac].pjba001
            AND xccdcomp = tm.xccccomp
            AND xccdld = tm.xcccld
            AND xccd003 = tm.xccc003
            AND (xccd004*12 + xccd005 BETWEEN l_yp_b AND l_yp_e)
            AND xccdent = g_enterprise
         IF cl_null(g_xccc_d[l_ac].xccd902) THEN LET g_xccc_d[l_ac].xccd902 = 0 END IF
      END IF
      #结存小计[l_sum_1]：库存结存+在制结存
      LET g_xccc_d[l_ac].l_sum_1 = g_xccc_d[l_ac].xccc902 + g_xccc_d[l_ac].xccd902
      #本期存货投入成本[l_xccc280_1]：取起始期别至截止期别范围内xmdk002='X'的出货单资料 SUM(该项目号出货单中每一料号的(出货数量-销退数量)*该料号当期平均单价(xccc280))
      #累计存货投入[l_xccc280_2]：取截止期别前xmdk002='X'的出货单资料 SUM(该项目号出货单中每一料号的(出货数量-销退数量)*该料号当期平均单价(xccc280))
      LET g_xccc_d[l_ac].l_xccc280_1 = 0
      LET g_xccc_d[l_ac].l_xccc280_2 = 0
      #161026-00054#1---add---s                  
      #LET g_sql = "SELECT UNIQUE xmdkdocno,xmdkdocdt,xmdl008,xmdl009,xmdl017,COALESCE(xmdl018,0),COALESCE(xmdl037,0) ",
      #            "FROM xmdk_t,xmdl_t ",
      #            "WHERE xmdk002 = 'X' AND (xmdkdocdt <",l_edate,") AND xmdkstus = 'S' ",
      #            " AND xmdk000 IN ('1','2','3','4','5','6') ",    #抓取截止期别前的所有资料
      #            "AND xmdkdocno = xmdldocno AND xmdkent = xmdlent AND xmdksite = xmdlsite ",
      #            "AND xmdkent = ",g_enterprise," AND xmdksite = '",g_site,"' ",
      #            "AND xmdl030 = '",g_xccc_d[l_ac].pjba001,"' ",
      #            "ORDER BY xmdkdocno,xmdkdocdt,xmdl008,xmdl009 "
      LET g_sql = " SELECT xcck013,SUM(-1*xcck009*xcck202) ",
                  "        FROM xcck_t ", 
                  "  WHERE xcckent = '",g_enterprise,"' AND xcckld = '",tm.xcccld,"'",
                  "    AND xcckcomp = '",tm.xccccomp,"' ",
                  "    AND (xcck004*12 + xcck005 BETWEEN ",l_yp_b," AND ",l_yp_e,") ",
                  "    AND xcck003 = '",tm.xccc003,"' ",
                  "    AND xcck030 = '",g_xccc_d[l_ac].pjba001,"' ",
                  "    AND xcck001 = '1' ",
                  "    AND xcck055 IN('303X','305X') ",                
                  " GROUP BY xcck013" 
      #161026-00054#1---add---e                  
      LET l_xmdkdocno = NULL                  
      LET l_xmdkdocdt = NULL
      LET l_xmdl008 = NULL
      LET l_xmdl009 = NULL
      LET l_xmdl017 = NULL
      LET l_xmdl018 = NULL
      LET l_xmdl037 = NULL
      PREPARE apjq501_xccc280_pre FROM g_sql
      DECLARE apjq501_xccc280_cur CURSOR FOR apjq501_xccc280_pre
      #161026-00054#1---mod---s                  
      #FOREACH apjq501_xccc280_cur INTO l_xmdkdocno,l_xmdkdocdt,l_xmdl008,l_xmdl009,l_xmdl017,l_xmdl018,l_xmdl037  
      #   #1.数量换算成基础单位
      #   IF cl_null(l_xmdl018) THEN LET l_xmdl018 = 0 END IF
      #   IF cl_null(l_xmdl037) THEN LET l_xmdl037 = 0 END IF
      #   SELECT imaa006 INTO l_unit FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = l_xmdl008
      #   CALL s_aooi250_convert_qty(l_xmdl008,l_xmdl017,l_unit,l_xmdl018)
      #                  RETURNING l_success,l_xmdl018
      #   CALL s_aooi250_convert_qty(l_xmdl008,l_xmdl017,l_unit,l_xmdl037)
      #                  RETURNING l_success,l_xmdl037
      #   #2.算当前单据所属的年期
      #   CALL s_fin_date_get_period_value(g_glaa003,tm.xcccld,l_xmdkdocdt) RETURNING l_success,l_xmdk_y,l_xmdk_p
      #   #3.抓单价
      #   LET l_xccc280 = NULL
      #   SELECT COALESCE(xccc280,0) INTO l_xccc280 
      #     FROM xccc_t 
      #    WHERE xcccent = g_enterprise AND xccc002 = g_xccc_d[l_ac].pjba001
      #      AND xccc006 = l_xmdl008 AND xccc007 = l_xmdl009
      #      AND xccccomp = tm.xccccomp AND xcccld = tm.xcccld AND xccc003 = tm.xccc003
      #      AND xccc004 = l_xmdk_y AND xccc005 = l_xmdk_p
      #   IF cl_null(l_xccc280) THEN LET l_xccc280 = 0 END IF
      #   LET l_save = (l_xmdl018 - l_xmdl037)*l_xccc280
      #   #4.若当前单据年期小于起始年期，则加入累计存货投入，否则仅加入本期存货投入
      #   IF l_xmdkdocdt < l_bdate THEN
      #      LET g_xccc_d[l_ac].l_xccc280_2 = g_xccc_d[l_ac].l_xccc280_2 + l_save
      #   ELSE
      #      LET g_xccc_d[l_ac].l_xccc280_1 = g_xccc_d[l_ac].l_xccc280_1 + l_save
      #      LET g_xccc_d[l_ac].l_xccc280_2 = g_xccc_d[l_ac].l_xccc280_2 + l_save
      #   END IF
      #END FOREACH  
      FOREACH apjq501_xccc280_cur INTO l_xmdkdocdt,l_save
         IF cl_null(l_save) THEN LET l_save = 0 END IF
         #4.若当前单据年期小于起始年期，则加入累计存货投入，否则仅加入本期存货投入
         IF l_xmdkdocdt < l_bdate THEN
            LET g_xccc_d[l_ac].l_xccc280_2 = g_xccc_d[l_ac].l_xccc280_2 + l_save
         ELSE
            LET g_xccc_d[l_ac].l_xccc280_1 = g_xccc_d[l_ac].l_xccc280_1 + l_save
            LET g_xccc_d[l_ac].l_xccc280_2 = g_xccc_d[l_ac].l_xccc280_2 + l_save
         END IF
      END FOREACH           
      #161026-00054#1---mod---s                  
      #本期费用投入[l_glar006_1]：取起始期别至截止期别内 项目核算项glaq027满足当前项目号的 SUM(当期费用类科目借方-贷方) ——费用类科目为6开头的科目
      SELECT SUM(COALESCE(glar005,0)-COALESCE(glar006,0)) INTO g_xccc_d[l_ac].l_glar006_1
        FROM glar_t
       WHERE glarent = g_enterprise 
         AND glarcomp = tm.xccccomp 
         AND glarld = tm.xcccld
         AND glar022 = g_xccc_d[l_ac].pjba001 
         AND glar001 LIKE '6%'
         AND (glar002*12+glar003 BETWEEN l_yp_b AND l_yp_e )
         AND EXISTS(SELECT 1 FROM glac_t,glaa_t WHERE glaaent=glacent AND glaa004=glac001 AND glaald= tm.xcccld AND glac002=glar001 AND glac003 IN('2','3') AND glac002 LIKE '5%') #161026-00054#1
      #累计费用投入[l_glar006_2]：取截止期别前 项目核算项glaq027满足当前项目号的 SUM(当期费用类科目借方-贷方) 
      SELECT SUM(COALESCE(glar005,0)-COALESCE(glar006,0)) INTO g_xccc_d[l_ac].l_glar006_2
        FROM glar_t
       WHERE glarent = g_enterprise 
         AND glarcomp = tm.xccccomp 
         AND glarld = tm.xcccld
         AND glar022 = g_xccc_d[l_ac].pjba001 
         AND glar001 LIKE '6%'
         AND (glar002*12+glar003 < l_yp_e )
         AND EXISTS(SELECT 1 FROM glac_t,glaa_t WHERE glaaent=glacent AND glaa004=glac001 AND glaald= tm.xcccld AND glac002=glar001 AND glac003 IN('2','3') AND glac002 LIKE '5%') #161026-00054#1
       
      #本期投入小计[l_sum_2]：本期存货投入+本期费用投入
      IF cl_null(g_xccc_d[l_ac].l_xccc280_1) THEN LET g_xccc_d[l_ac].l_xccc280_1 = 0 END IF
      IF cl_null(g_xccc_d[l_ac].l_xccc280_2) THEN LET g_xccc_d[l_ac].l_xccc280_2 = 0 END IF
      IF cl_null(g_xccc_d[l_ac].l_glar006_1) THEN LET g_xccc_d[l_ac].l_glar006_1 = 0 END IF
      IF cl_null(g_xccc_d[l_ac].l_glar006_2) THEN LET g_xccc_d[l_ac].l_glar006_2 = 0 END IF
      LET g_xccc_d[l_ac].l_sum_2 = g_xccc_d[l_ac].l_xccc280_1 + g_xccc_d[l_ac].l_glar006_1
      #累计投入小计[l_sum_3]=累计存货投入+累计费用投入
      LET g_xccc_d[l_ac].l_sum_3 = g_xccc_d[l_ac].l_xccc280_2 + g_xccc_d[l_ac].l_glar006_2
      #累计合计[l_sum_4]=结存小计+累计投入小计
      LET g_xccc_d[l_ac].l_sum_4 = g_xccc_d[l_ac].l_sum_1 + g_xccc_d[l_ac].l_sum_3
      #160715-00007#1 add-S
      #预算金额=依项目号抓apjm210单头项目预估材料成本、人工成本、加工费、制费一~制费五金额
      #差异金额=预算金额-累计投入小计
#      SELECT SUM(COALESCE(pjba016,0)) INTO g_xccc_d[l_ac].l_pjba016
#        FROM pjba_t 
#       WHERE pjba0001 = g_xccc_d[l_ac].pjba001
#         AND pjbaent = g_enterprise
      LET g_xccc_d[l_ac].l_diff_1 = g_xccc_d[l_ac].l_pjba016 - g_xccc_d[l_ac].l_sum_3
      #160715-00007#1 add-E
      LET l_ac = l_ac + 1
   END FOREACH 
   LET l_ac = l_ac - 1
   #end add-point
 
   CALL g_xccc_d.deleteElement(g_xccc_d.getLength())
 
   #add-point:陣列長度調整

   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_xccc_d.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
#   CALL apjq501_detail_index_setting()
 
   #重新計算單身筆數並呈現
#   CALL apjq501_detail_action_trans()
 
   CALL apjq501_b_fill2()
 
   
 
END FUNCTION

################################################################################
# Date & Author..: 2016-4-1 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION apjq501_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"

   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"

   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"

   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
         LET g_current_idx = g_browser_tm.getLength()              
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
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
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
         
         IF g_jump > 0 AND g_jump <= g_browser_tm.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE  
   END CASE 
 
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_current_idx
   DISPLAY g_browser_idx TO FORMONLY.h_index
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser_tm.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser_tm.getLength() THEN
      LET g_browser_idx = g_browser_tm.getLength()
      LET g_current_idx = g_browser_tm.getLength()
   END IF
   #更新单头资料
   LET tm.xccccomp      = g_browser_tm[g_current_idx].xccccomp
   LET tm.xccccomp_desc = g_browser_tm[g_current_idx].xccccomp_desc
   LET tm.xcccld        = g_browser_tm[g_current_idx].xcccld
   LET tm.xcccld_desc   = g_browser_tm[g_current_idx].xcccld_desc
   LET tm.xccc003       = g_browser_tm[g_current_idx].xccc003
   LET tm.xccc003_desc  = g_browser_tm[g_current_idx].xccc003_desc
   LET tm.l_xccc004_b   = g_browser_tm[g_current_idx].l_xccc004_b
   LET tm.l_xccc004_e   = g_browser_tm[g_current_idx].l_xccc004_e
   LET tm.l_xccc005_b   = g_browser_tm[g_current_idx].l_xccc005_b
   LET tm.l_xccc005_e   = g_browser_tm[g_current_idx].l_xccc005_e
   
   DISPLAY tm.xccccomp,tm.xcccld,tm.xccc003,tm.l_xccc004_b,tm.l_xccc005_b,tm.l_xccc004_e,tm.l_xccc005_e
        TO b_xccccomp,b_xcccld,b_xccc003,l_xccc004_b,l_xccc005_b,l_xccc004_e,l_xccc005_e
   DISPLAY tm.xccccomp_desc TO b_xccccomp_desc   #法人組織
   DISPLAY tm.xcccld_desc TO b_xcccld_desc     #帳別編號
   DISPLAY tm.xccc003_desc TO b_xccc003_desc     #成本计算类型
   CALL apjq501_b_fill1()
   
END FUNCTION

################################################################################
################################################################################
PRIVATE FUNCTION apjq501_browser_fill()
   
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_xccc004_b    LIKE xccc_t.xccc004    #起始年度
   DEFINE l_xccc005_b    LIKE xccc_t.xccc005    #起始期别
   DEFINE l_xccc004_e    LIKE xccc_t.xccc004    #截止年度
   DEFINE l_xccc005_e    LIKE xccc_t.xccc005     #截止期别
   DEFINE l_yp_b        LIKE type_t.num10
   DEFINE l_yp_e        LIKE type_t.num10
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   LET l_yp_b = tm.l_xccc004_b*12 + tm.l_xccc005_b      
   LET l_yp_e = tm.l_xccc004_e*12 + tm.l_xccc005_e
   LET l_xccc004_b = tm.l_xccc004_b
   LET l_xccc004_e = tm.l_xccc004_e
   LET l_xccc005_b = tm.l_xccc005_b
   LET l_xccc005_e = tm.l_xccc005_e
   #end add-point
    
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
   IF cl_null(g_wc) THEN
      LET g_wc = " xcccent = '",g_enterprise,"' "
   ELSE
      LET g_wc = g_wc," AND xcccent = '",g_enterprise,"' "
   END IF
   
   LET l_wc  = g_wc.trim()
   #end add-point
   
   #单头资料抓取sql
   LET l_sub_sql = " SELECT DISTINCT xccccomp,NULL,xcccld,NULL,xccc003,NULL ",
                   " FROM xccc_t ", 
                   "  ",
                   "  ",
                   " WHERE ",l_wc CLIPPED, " AND (xccc004*12+xccc005 BETWEEN ",l_yp_b," AND ",l_yp_e," )", cl_sql_add_filter("xccc_t")
  
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"

   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"

   #end add-point
   
   IF g_sql.getIndexOf("1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
   #清除畫面
   CLEAR FORM                
   INITIALIZE tm.* TO NULL
   CALL g_xccc_d.clear()
   CALL g_xccc2_d.clear()
   CALL g_xccc3_d.clear()
   CALL g_xccc4_d.clear()
   CALL g_xccc5_d.clear()
    
   #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
    
   #end add-point   
   CALL g_browser_tm.clear()     #清空单头阵列
   LET g_cnt = 1
 
   #依照t0.rmaadocno,t0.rmaadocdt,t0.rmaa002,t0.rmaa003,t0.rmaa001,t0.rmaa004,t0.rmaa005,t0.rmaa006,t0.rmaasite Browser欄位定義(取代原本bs_sql功能)
   LET g_sql = " SELECT DISTINCT xccccomp,ooefl003,xcccld,glaal002,xccc003,xcatl003 ",
               " FROM xccc_t LEFT OUTER JOIN ooefl_t ON ooefl001 = xccccomp AND ooeflent = xcccent AND ooefl002 = '",g_dlang,"' ",
               "             LEFT OUTER JOIN glaal_t ON glaalld = xcccld AND glaalent = xcccent AND glaal001 = '",g_dlang,"' ",
               "             LEFT OUTER JOIN xcatl_t ON xcatl001 = xccc003 AND xcatlent = xcccent AND xcatl002 = '",g_dlang,"' ",
               " WHERE ",l_wc CLIPPED, " AND (xccc004*12+xccc005 BETWEEN ",l_yp_b," AND ",l_yp_e," )" ,cl_sql_add_filter("xccc_t")
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"

   #end add-point
   LET g_sql = g_sql, " ORDER BY xccccomp,xcccld,xccc003 "
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"

   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"rmaa_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf("1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"

      #end add-point
      
      FOREACH browse_cur INTO g_browser_tm[g_cnt].xccccomp,g_browser_tm[g_cnt].xccccomp_desc,
                              g_browser_tm[g_cnt].xcccld,  g_browser_tm[g_cnt].xcccld_desc,
                              g_browser_tm[g_cnt].xccc003, g_browser_tm[g_cnt].xccc003_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         LET g_browser_tm[g_cnt].l_xccc004_b = l_xccc004_b
         LET g_browser_tm[g_cnt].l_xccc004_e = l_xccc004_e
         LET g_browser_tm[g_cnt].l_xccc005_b = l_xccc005_b
         LET g_browser_tm[g_cnt].l_xccc005_e = l_xccc005_e
         #end add-point
 
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_browse THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      FREE browse_pre
   END IF
  
#   IF cl_null(g_browser_tm[g_browser_tm.getLength()].xccccomp) THEN
      LET g_cnt = g_cnt-1
      CALL g_browser_tm.deleteElement(g_browser_tm.getLength())
#      LET g_cnt = g_browser_tm.getLength()-1
#   END IF
#   DISPLAY g_cnt 
   LET g_header_cnt  = g_browser_tm.getLength()
   LET g_browser_cnt = g_browser_tm.getLength()
   LET g_browser_idx = g_current_idx
   IF g_current_idx > g_browser_tm.getLength() THEN
      LET g_browser_idx = g_browser_tm.getLength()
      LET g_current_idx = g_browser_tm.getLength()
   END IF
   
   #筆數顯示
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
 
   LET g_rec_b = g_cnt
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0              
   
   #add-point:browser_fill段結束前 name="browser_fill.after"

   #end add-point   
END FUNCTION

PRIVATE FUNCTION apjq501_idx_chk()
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xccc_d.getLength() THEN
         LET g_detail_idx = g_xccc_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xccc_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xccc_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_xccc2_d.getLength() THEN
         LET g_detail_idx2 = g_xccc2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_xccc2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_xccc2_d.getLength() TO FORMONLY.cnt
   END IF
 
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_xccc3_d.getLength() THEN
         LET g_detail_idx2 = g_xccc3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_xccc3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_xccc3_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 4 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx2 > g_xccc4_d.getLength() THEN
         LET g_detail_idx2 = g_xccc4_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_xccc4_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_xccc4_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 5 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx2 > g_xccc5_d.getLength() THEN
         LET g_detail_idx2 = g_xccc5_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_xccc5_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_xccc5_d.getLength() TO FORMONLY.cnt
   END IF
END FUNCTION

 
{</section>}
 
