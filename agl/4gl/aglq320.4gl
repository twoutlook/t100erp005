#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq320.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-12-31 16:59:36), PR版次:0003(2016-08-01 15:17:28)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000034
#+ Filename...: aglq320
#+ Description: 多欄式明細帳查詢
#+ Creator....: 05016(2015-12-21 16:56:35)
#+ Modifier...: 05016 -SD/PR- 08742
 
{</section>}
 
{<section id="aglq320.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160321-00016#30   2016/03/25  By Jessy         修正azzi920重複定義之錯誤訊息
#160727-00019#3    2016/08/01   By 08742     系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                             Mod   aglq320_print_tmp -->aglq320_tmp01
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
GLOBALS "../../cfg/top_report.inc"
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_glap_d RECORD
       #statepic       LIKE type_t.chr1,
       
       glap002 LIKE glap_t.glap002, 
   glap004 LIKE glap_t.glap004, 
   glapdocdt LIKE glap_t.glapdocdt, 
   glapdocno LIKE glap_t.glapdocno, 
   l_glaq001 LIKE type_t.chr500, 
   l_glaq005 LIKE type_t.chr10, 
   l_glaq010 LIKE type_t.num20_6, 
   l_glaq006 LIKE type_t.num26_10, 
   l_glaq003_0 LIKE type_t.num20_6, 
   l_glaq003_1 LIKE type_t.num20_6, 
   l_glaq003_2 LIKE type_t.num20_6, 
   l_glaq003_3 LIKE type_t.num20_6, 
   l_glaq003_4 LIKE type_t.num20_6, 
   l_glaq003_5 LIKE type_t.num20_6, 
   l_glaq003_6 LIKE type_t.num20_6, 
   l_glaq003_7 LIKE type_t.num20_6, 
   l_glaq003_8 LIKE type_t.num20_6, 
   l_glaq003_9 LIKE type_t.num20_6, 
   l_glaq003_10 LIKE type_t.num20_6, 
   l_glaq003_11 LIKE type_t.num20_6, 
   l_glaq003_12 LIKE type_t.num20_6, 
   l_glaq003_13 LIKE type_t.num20_6, 
   l_glaq003_14 LIKE type_t.num20_6, 
   l_glaq003_15 LIKE type_t.num20_6, 
   l_glaq003_16 LIKE type_t.num20_6, 
   l_glaq003_17 LIKE type_t.num20_6, 
   l_glaq003_18 LIKE type_t.num20_6, 
   l_glaq003_19 LIKE type_t.num20_6, 
   l_glaq003_20 LIKE type_t.num20_6, 
   l_glaq003_21 LIKE type_t.num20_6, 
   l_glaq003_22 LIKE type_t.num20_6, 
   l_glaq003_23 LIKE type_t.num20_6, 
   l_glaq003_24 LIKE type_t.num20_6, 
   l_glaq003_25 LIKE type_t.num20_6, 
   l_glaq003_26 LIKE type_t.num20_6, 
   l_glaq003_27 LIKE type_t.num20_6, 
   l_glaq003_28 LIKE type_t.num20_6, 
   l_glaq003_29 LIKE type_t.num20_6, 
   l_glaq003_30 LIKE type_t.num20_6, 
   l_glaq004_0 LIKE type_t.num20_6, 
   l_glaq004_1 LIKE type_t.num20_6, 
   l_glaq004_2 LIKE type_t.num20_6, 
   l_glaq004_3 LIKE type_t.num20_6, 
   l_glaq004_4 LIKE type_t.num20_6, 
   l_glaq004_5 LIKE type_t.num20_6, 
   l_glaq004_6 LIKE type_t.num20_6, 
   l_glaq004_7 LIKE type_t.num20_6, 
   l_glaq004_8 LIKE type_t.num20_6, 
   l_glaq004_9 LIKE type_t.num20_6, 
   l_glaq004_10 LIKE type_t.num20_6, 
   l_glaq004_11 LIKE type_t.num20_6, 
   l_glaq004_12 LIKE type_t.num20_6, 
   l_glaq004_13 LIKE type_t.num20_6, 
   l_glaq004_14 LIKE type_t.num20_6, 
   l_glaq004_15 LIKE type_t.num20_6, 
   l_glaq004_16 LIKE type_t.num20_6, 
   l_glaq004_17 LIKE type_t.num20_6, 
   l_glaq004_18 LIKE type_t.num20_6, 
   l_glaq004_19 LIKE type_t.num20_6, 
   l_glaq004_20 LIKE type_t.num20_6, 
   l_glaq004_21 LIKE type_t.num20_6, 
   l_glaq004_22 LIKE type_t.num20_6, 
   l_glaq004_23 LIKE type_t.num20_6, 
   l_glaq004_24 LIKE type_t.num20_6, 
   l_glaq004_25 LIKE type_t.num20_6, 
   l_glaq004_26 LIKE type_t.num20_6, 
   l_glaq004_27 LIKE type_t.num20_6, 
   l_glaq004_28 LIKE type_t.num20_6, 
   l_glaq004_29 LIKE type_t.num20_6, 
   l_glaq004_30 LIKE type_t.num20_6, 
   l_dc LIKE type_t.chr100, 
   l_amt LIKE type_t.num20_6, 
   glapld LIKE glap_t.glapld, 
   glapld_desc LIKE type_t.chr500 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input RECORD
   glapld         LIKE glap_t.glapld,
   glapld_desc    LIKE type_t.chr500,
   glapcomp       LIKE glap_t.glapcomp,
   glapcomp_desc  LIKE type_t.chr500,
   glaa001        LIKE glaa_t.glaa001,
   glaa016        LIKE glaa_t.glaa016,
   glaa020        LIKE glaa_t.glaa020,
   sdate          LIKE apca_t.apcadocdt,
   edate          LIKE apca_t.apcadocdt,
   multicurr      LIKE type_t.chr1,
   syear          LIKE xrea_t.xrea001,
   eyear          LIKE xrea_t.xrea001,
   speriod        LIKE xrea_t.xrea002,
   eperiod        LIKE xrea_t.xrea002,
   currchk        LIKE type_t.chr1,
   stus           LIKE type_t.chr1,
   show_ad        LIKE type_t.chr1,
   show_ce        LIKE type_t.chr1,
   show_ye        LIKE type_t.chr1,
   glaq002        LIKE glaq_t.glaq002,
   glaq002_desc   LIKE type_t.chr100
         END RECORD
         
DEFINE g_glaa RECORD
    glaacomp  LIKE glaa_t.glaacomp,
    glaa001   LIKE glaa_t.glaa001,
    glaa003   LIKE glaa_t.glaa003,
    glaa004   LIKE glaa_t.glaa004,
    glaa015   LIKE glaa_t.glaa015, #啟用本位幣二
    glaa016   LIKE glaa_t.glaa016, #本位幣二
    glaa019   LIKE glaa_t.glaa019, #啟用本位幣三
    glaa020   LIKE glaa_t.glaa020  #本位幣三
          END RECORD                           

#資料瀏覽之欄位 
DEFINE g_wc3 STRING
DEFINE g_glac       DYNAMIC ARRAY OF RECORD    
        glac002         LIKE glac_t.glac002 #科目編號
      END RECORD

DEFINE g_current_row   LIKE type_t.num5
DEFINE g_current_idx   LIKE type_t.num10
DEFINE g_jump          LIKE type_t.num10
DEFINE g_no_ask        LIKE type_t.num5
DEFINE g_rec_b         LIKE type_t.num5 
        
DEFINE g_glaq DYNAMIC ARRAY OF RECORD
        glaq002     LIKE glaq_t.glaq002
        END RECORD
        
DEFINE g_tree       DYNAMIC ARRAY OF RECORD
         pid           LIKE type_t.chr500,    #父節點id
         id            LIKE type_t.chr500,    #本身節點id
         glac002       LIKE glac_t.glac002,   #父節點的科目
         glaq002       LIKE glaq_t.glaq002    #自己的科目
         END RECORD       
         
DEFINE g_glac002    LIKE glac_t.glac002         
DEFINE g_tree_idx   LIKE type_t.num10
DEFINE g_tree_pid   LIKE type_t.chr500
DEFINE g_preyear    LIKE glap_t.glap002
DEFINE g_premon     LIKE glap_t.glap004
DEFINE g_sql2,g_sql3,g_sql4         STRING

DEFINE g_glap_d2          DYNAMIC ARRAY OF type_g_glap_d
DEFINE g_glap_d3          DYNAMIC ARRAY OF type_g_glap_d
DEFINE g_j                LIKE type_t.num5
DEFINE g_k                LIKE type_t.num5
DEFINE g_glac002_t LIKE glac_t.glac002
DEFINE g_flag             LIKE type_t.chr1 #判斷是否為起始周期第一天
DEFINE g_pdate_s1         LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glap_d
DEFINE g_master_t                   type_g_glap_d
DEFINE g_glap_d          DYNAMIC ARRAY OF type_g_glap_d
DEFINE g_glap_d_t        type_g_glap_d
 
      
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
 
{<section id="aglq320.main" >}
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
   CALL cl_ap_init("agl","")
 
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
   DECLARE aglq320_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq320_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq320_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq320 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq320_init()   
 
      #進入選單 Menu (="N")
      CALL aglq320_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq320
      
   END IF 
   
   CLOSE aglq320_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq320.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq320_init()
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
   CALL cl_set_combo_scc('stus','9922')
   CALL aglq320_set_default()
   CALL aglq320_create_tmp()
   
   #end add-point
 
   CALL aglq320_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aglq320.default_search" >}
PRIVATE FUNCTION aglq320_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glapld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " glapdocno = '", g_argv[02], "' AND "
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
 
{<section id="aglq320.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq320_ui_dialog()
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
   DEFINE l_type    LIKE type_t.chr1
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
      CALL aglq320_b_fill()
   ELSE
      CALL aglq320_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glap_d.clear()
 
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
 
         CALL aglq320_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glap_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq320_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq320_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
              
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_glap_d2 TO s_detail2.* ATTRIBUTES(COUNT=g_tree_idx)
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               LET g_master_idx = l_ac
         END DISPLAY

         DISPLAY ARRAY g_glap_d3 TO s_detail3.* ATTRIBUTES(COUNT=g_tree_idx)
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               LET g_master_idx = l_ac
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aglq320_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("filter",FALSE)
            CALL cl_set_act_visible("first,previous,jump,next,last",TRUE)
            IF g_header_cnt=1 THEN
               CALL cl_set_act_visible("first,previous,jump,next,last",FALSE)
            ELSE
               IF g_current_idx=1 THEN
                  CALL cl_set_act_visible("first,previous", FALSE)
                  CALL cl_set_act_visible("jump,next,last", TRUE)
               ELSE
                  IF g_current_idx<>g_header_cnt THEN
                     CALL cl_set_act_visible("first,previous,jump,next,last",TRUE)
                  ELSE
                     CALL cl_set_act_visible("first,previous,jump",TRUE)
                     CALL cl_set_act_visible("next,last", FALSE)
                  END IF
               END IF
            END IF
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aglq320_01(g_input.multicurr)RETURNING g_sub_success,l_type
               IF g_sub_success THEN
                 CALL aglq320_print_ins(l_type)
                 CALL aglq320_x01('1=1','aglq320_tmp01',g_j,g_k,g_input.currchk)   #160727-00019#3  Mod  aglq320_print_tmp -->aglq320_tmp01    
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aglq320_01(g_input.multicurr)RETURNING g_sub_success,l_type
               IF g_sub_success THEN
                 CALL aglq320_print_ins(l_type)
                 CALL aglq320_x01('1=1','aglq320_tmp01',g_j,g_k,g_input.currchk)   #160727-00019#3  Mod  aglq320_print_tmp -->aglq320_tmp01    
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglq320_query()
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
            CALL aglq320_filter()
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
            CALL aglq320_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glap_d)
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
            CALL aglq320_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq320_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq320_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq320_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION previous
            LET g_action_choice="previous"
            CALL aglq320_fetch1('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
            
         ON ACTION first
            LET g_action_choice="first"
            CALL aglq320_fetch1('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
         
         ON ACTION jump
            LET g_action_choice="jump"
            CALL aglq320_fetch1('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
            
         ON ACTION next
            LET g_action_choice="next"
            CALL aglq320_fetch1('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
            
         ON ACTION last
            LET g_action_choice="last"
            CALL aglq320_fetch1('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
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
 
{<section id="aglq320.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq320_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   DEFINE l_success        LIKE type_t.chr1
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   LET g_input.glaq002 = ''
   LET g_input.glaq002_desc = ''
   DISPLAY BY NAME g_input.glaq002,g_input.glaq002_desc 
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glap_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON glapdocno,glapld
           FROM s_detail1[1].b_glapdocno,s_detail1[1].b_glapld
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            NEXT FIELD glapld
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_glap002>>----
         #----<<b_glap004>>----
         #----<<b_glapdocdt>>----
         #----<<b_glapdocno>>----
         #Ctrlp:construct.c.page1.b_glapdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glapdocno
            #add-point:ON ACTION controlp INFIELD b_glapdocno name="construct.c.page1.b_glapdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glapdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glapdocno  #顯示到畫面上
            NEXT FIELD b_glapdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glapdocno
            #add-point:BEFORE FIELD b_glapdocno name="construct.b.page1.b_glapdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glapdocno
            
            #add-point:AFTER FIELD b_glapdocno name="construct.a.page1.b_glapdocno"
            
            #END add-point
            
 
 
         #----<<l_glaq001>>----
         #----<<l_glaq005>>----
         #----<<l_glaq010>>----
         #----<<l_glaq006>>----
         #----<<l_glaq003_0>>----
         #----<<l_glaq003_1>>----
         #----<<l_glaq003_2>>----
         #----<<l_glaq003_3>>----
         #----<<l_glaq003_4>>----
         #----<<l_glaq003_5>>----
         #----<<l_glaq003_6>>----
         #----<<l_glaq003_7>>----
         #----<<l_glaq003_8>>----
         #----<<l_glaq003_9>>----
         #----<<l_glaq003_10>>----
         #----<<l_glaq003_11>>----
         #----<<l_glaq003_12>>----
         #----<<l_glaq003_13>>----
         #----<<l_glaq003_14>>----
         #----<<l_glaq003_15>>----
         #----<<l_glaq003_16>>----
         #----<<l_glaq003_17>>----
         #----<<l_glaq003_18>>----
         #----<<l_glaq003_19>>----
         #----<<l_glaq003_20>>----
         #----<<l_glaq003_21>>----
         #----<<l_glaq003_22>>----
         #----<<l_glaq003_23>>----
         #----<<l_glaq003_24>>----
         #----<<l_glaq003_25>>----
         #----<<l_glaq003_26>>----
         #----<<l_glaq003_27>>----
         #----<<l_glaq003_28>>----
         #----<<l_glaq003_29>>----
         #----<<l_glaq003_30>>----
         #----<<l_glaq004_0>>----
         #----<<l_glaq004_1>>----
         #----<<l_glaq004_2>>----
         #----<<l_glaq004_3>>----
         #----<<l_glaq004_4>>----
         #----<<l_glaq004_5>>----
         #----<<l_glaq004_6>>----
         #----<<l_glaq004_7>>----
         #----<<l_glaq004_8>>----
         #----<<l_glaq004_9>>----
         #----<<l_glaq004_10>>----
         #----<<l_glaq004_11>>----
         #----<<l_glaq004_12>>----
         #----<<l_glaq004_13>>----
         #----<<l_glaq004_14>>----
         #----<<l_glaq004_15>>----
         #----<<l_glaq004_16>>----
         #----<<l_glaq004_17>>----
         #----<<l_glaq004_18>>----
         #----<<l_glaq004_19>>----
         #----<<l_glaq004_20>>----
         #----<<l_glaq004_21>>----
         #----<<l_glaq004_22>>----
         #----<<l_glaq004_23>>----
         #----<<l_glaq004_24>>----
         #----<<l_glaq004_25>>----
         #----<<l_glaq004_26>>----
         #----<<l_glaq004_27>>----
         #----<<l_glaq004_28>>----
         #----<<l_glaq004_29>>----
         #----<<l_glaq004_30>>----
         #----<<l_dc>>----
         #----<<l_amt>>----
         #----<<b_glapld>>----
         #Ctrlp:construct.c.page1.b_glapld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glapld
            #add-point:ON ACTION controlp INFIELD b_glapld name="construct.c.page1.b_glapld"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaald()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glapld  #顯示到畫面上
            NEXT FIELD b_glapld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glapld
            #add-point:BEFORE FIELD b_glapld name="construct.b.page1.b_glapld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glapld
            
            #add-point:AFTER FIELD b_glapld name="construct.a.page1.b_glapld"
            
            #END add-point
            
 
 
         #----<<b_glapld_desc>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      CONSTRUCT BY NAME g_wc3 ON glac002
            BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD glac002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac001 = '",g_glaa.glaa004,"' AND glac003  = '1' "  #glac003(統制)
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO glac002
            NEXT FIELD glac002         
         END CONSTRUCT 
      
      INPUT BY NAME g_input.glapld,g_input.glapcomp,g_input.glaa001,g_input.glaa016,g_input.glaa020, 
                    g_input.sdate,g_input.edate,g_input.multicurr,g_input.syear,g_input.eyear,    
                    g_input.speriod,g_input.eperiod,g_input.currchk,g_input.stus,g_input.show_ad,    
                    g_input.show_ce,g_input.show_ye,g_input.glapcomp_desc,g_input.glapld_desc,
                    g_input.glaq002,g_input.glaq002_desc
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         
         AFTER FIELD glapld
            IF NOT cl_null(g_input.glapld) THEN
               CALL s_fin_ld_chk(g_input.glapld,g_user,'N') RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_input.glapld
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'agli010'
                  LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                  LET g_errparam.exeprog = 'agli010'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.glapld = ''
                  LET g_input.glapld_desc =''
                  CALL aglq320_glapld_ref(g_input.glapld)
                  NEXT FIELD glapld                                                                                        
               END IF          
               CALL aglq320_glapld_ref(g_input.glapld)                        
            END IF
            LET g_input.glapld_desc =  s_desc_get_ld_desc(g_input.glapld)
            DISPLAY BY NAME g_input.glapld_desc     
         
         AFTER FIELD sdate
            IF NOT cl_null(g_input.sdate) THEN
               CALL s_get_accdate(g_glaa.glaa003,g_input.sdate,'','')
                    RETURNING l_success,g_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                              l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e 
               IF l_success = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()             
                  NEXT FIELD sdate
               END IF
               IF NOT cl_null(g_input.edate) THEN
                  IF g_input.sdate>g_input.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00116'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()            
                     NEXT FIELD sdate
                  END IF
               END IF
               LET g_input.syear=l_glav002
               LET g_input.speriod=l_glav006
               DISPLAY BY NAME g_input.syear,g_input.speriod 
            END IF
         
         AFTER FIELD edate         
            IF NOT cl_null(g_input.edate) THEN
               CALL s_get_accdate(g_glaa.glaa003,g_input.edate,'','')
                   RETURNING l_success,g_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                            l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               IF l_success = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()             
                  NEXT FIELD edate
               END IF
               IF NOT cl_null(g_input.edate) THEN
                  IF g_input.sdate>g_input.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00116'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()            
                     NEXT FIELD edate
                  END IF
               END IF
               LET g_input.eyear=l_glav002
               LET g_input.eperiod=l_glav006
               DISPLAY BY NAME g_input.syear,g_input.speriod 
            END IF
            
            ON CHANGE currchk
               CALL aglq320_curry_show()
            ON CHANGE multicurr                        
               CALL cl_set_comp_visible('bpage_1,bpage_2,bpage_3',TRUE)
               CASE g_input.multicurr
                  WHEN 0 
                     CALL cl_set_comp_visible('bpage_2,bpage_3',FALSE)
                  WHEN 1
                     CALL cl_set_comp_visible('bpage_3',FALSE)
                  WHEN 2 
                     CALL cl_set_comp_visible('bpage_2',FALSE)
               END CASE     
                 
            ON ACTION controlp INFIELD glapld
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.glapld
               LET g_qryparam.arg1 = g_user                                 #人員權限
               LET g_qryparam.arg2 = g_dept                                 #部門權限
               CALL q_authorised_ld()
               LET g_input.glapld = g_qryparam.return1
               CALL s_desc_get_ld_desc(g_input.glapld) RETURNING g_input.glapld_desc
               DISPLAY BY NAME g_input.glapld_desc,g_input.glapld
               NEXT FIELD glapld   
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
         CALL aglq320_set_default()
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
   
   CALL aglq320_set_page()
   CALL aglq320_fetch1('F')
   LET g_error_show = 1
#   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.extend = ""
#      LET g_errparam.code   = -100
#      LET g_errparam.popup  = TRUE
#      CALL cl_err()
#      RETURN
#   END IF
   RETURN
   #end add-point
        
   LET g_error_show = 1
   CALL aglq320_b_fill()
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
 
{<section id="aglq320.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq320_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_i        LIKE type_t.num5
   DEFINE l_cnt      LIKe type_t.num5
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL aglq320_grow_tree()    
   CALL aglq320_set_title()
   CALL aglq320_temp_set() #整理temp_table
   CALL aglq320_b_fill1()
   CASE g_input.multicurr
      WHEN 1
         CALL aglq320_b_fill2()
      WHEN 2 
         CALL aglq320_b_fill3()
      WHEN 3
         CALL aglq320_b_fill2()
         CALL aglq320_b_fill3()
   END CASE    
   
   SELECT COUNT(*) INTO l_cnt FROM aglq320_tmp
    WHERE l_flag = '2'
   IF l_cnt=0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
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
 
   LET ls_sql_rank = "SELECT  UNIQUE glap002,glap004,glapdocdt,glapdocno,'','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','',glapld,''  , 
       DENSE_RANK() OVER( ORDER BY glap_t.glapld,glap_t.glapdocno) AS RANK FROM glap_t",
 
 
                     "",
                     " WHERE glapent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glap_t"),
                     " ORDER BY glap_t.glapld,glap_t.glapdocno"
 
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
 
   LET g_sql = "SELECT glap002,glap004,glapdocdt,glapdocno,'','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','',glapld,''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq320_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq320_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glap_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glap_d[l_ac].glap002,g_glap_d[l_ac].glap004,g_glap_d[l_ac].glapdocdt,g_glap_d[l_ac].glapdocno, 
       g_glap_d[l_ac].l_glaq001,g_glap_d[l_ac].l_glaq005,g_glap_d[l_ac].l_glaq010,g_glap_d[l_ac].l_glaq006, 
       g_glap_d[l_ac].l_glaq003_0,g_glap_d[l_ac].l_glaq003_1,g_glap_d[l_ac].l_glaq003_2,g_glap_d[l_ac].l_glaq003_3, 
       g_glap_d[l_ac].l_glaq003_4,g_glap_d[l_ac].l_glaq003_5,g_glap_d[l_ac].l_glaq003_6,g_glap_d[l_ac].l_glaq003_7, 
       g_glap_d[l_ac].l_glaq003_8,g_glap_d[l_ac].l_glaq003_9,g_glap_d[l_ac].l_glaq003_10,g_glap_d[l_ac].l_glaq003_11, 
       g_glap_d[l_ac].l_glaq003_12,g_glap_d[l_ac].l_glaq003_13,g_glap_d[l_ac].l_glaq003_14,g_glap_d[l_ac].l_glaq003_15, 
       g_glap_d[l_ac].l_glaq003_16,g_glap_d[l_ac].l_glaq003_17,g_glap_d[l_ac].l_glaq003_18,g_glap_d[l_ac].l_glaq003_19, 
       g_glap_d[l_ac].l_glaq003_20,g_glap_d[l_ac].l_glaq003_21,g_glap_d[l_ac].l_glaq003_22,g_glap_d[l_ac].l_glaq003_23, 
       g_glap_d[l_ac].l_glaq003_24,g_glap_d[l_ac].l_glaq003_25,g_glap_d[l_ac].l_glaq003_26,g_glap_d[l_ac].l_glaq003_27, 
       g_glap_d[l_ac].l_glaq003_28,g_glap_d[l_ac].l_glaq003_29,g_glap_d[l_ac].l_glaq003_30,g_glap_d[l_ac].l_glaq004_0, 
       g_glap_d[l_ac].l_glaq004_1,g_glap_d[l_ac].l_glaq004_2,g_glap_d[l_ac].l_glaq004_3,g_glap_d[l_ac].l_glaq004_4, 
       g_glap_d[l_ac].l_glaq004_5,g_glap_d[l_ac].l_glaq004_6,g_glap_d[l_ac].l_glaq004_7,g_glap_d[l_ac].l_glaq004_8, 
       g_glap_d[l_ac].l_glaq004_9,g_glap_d[l_ac].l_glaq004_10,g_glap_d[l_ac].l_glaq004_11,g_glap_d[l_ac].l_glaq004_12, 
       g_glap_d[l_ac].l_glaq004_13,g_glap_d[l_ac].l_glaq004_14,g_glap_d[l_ac].l_glaq004_15,g_glap_d[l_ac].l_glaq004_16, 
       g_glap_d[l_ac].l_glaq004_17,g_glap_d[l_ac].l_glaq004_18,g_glap_d[l_ac].l_glaq004_19,g_glap_d[l_ac].l_glaq004_20, 
       g_glap_d[l_ac].l_glaq004_21,g_glap_d[l_ac].l_glaq004_22,g_glap_d[l_ac].l_glaq004_23,g_glap_d[l_ac].l_glaq004_24, 
       g_glap_d[l_ac].l_glaq004_25,g_glap_d[l_ac].l_glaq004_26,g_glap_d[l_ac].l_glaq004_27,g_glap_d[l_ac].l_glaq004_28, 
       g_glap_d[l_ac].l_glaq004_29,g_glap_d[l_ac].l_glaq004_30,g_glap_d[l_ac].l_dc,g_glap_d[l_ac].l_amt, 
       g_glap_d[l_ac].glapld,g_glap_d[l_ac].glapld_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_glap_d[l_ac].statepic = cl_get_actipic(g_glap_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aglq320_detail_show("'1'")      
 
      CALL aglq320_glap_t_mask()
 
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
   
 
   
   CALL g_glap_d.deleteElement(g_glap_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_glap_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq320_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq320_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq320_detail_action_trans()
 
   IF g_glap_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq320_fetch()
   END IF
   
      CALL aglq320_filter_show('glapdocno','b_glapdocno')
   CALL aglq320_filter_show('glapld','b_glapld')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq320.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq320_fetch()
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
 
{<section id="aglq320.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq320_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_glap_d[l_ac].glapld
            LET ls_sql = "SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_glap_d[l_ac].glapld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glap_d[l_ac].glapld_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq320.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq320_filter()
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
      CONSTRUCT g_wc_filter ON glapdocno,glapld
                          FROM s_detail1[1].b_glapdocno,s_detail1[1].b_glapld
 
         BEFORE CONSTRUCT
                     DISPLAY aglq320_filter_parser('glapdocno') TO s_detail1[1].b_glapdocno
            DISPLAY aglq320_filter_parser('glapld') TO s_detail1[1].b_glapld
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_glap002>>----
         #----<<b_glap004>>----
         #----<<b_glapdocdt>>----
         #----<<b_glapdocno>>----
         #Ctrlp:construct.c.page1.b_glapdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glapdocno
            #add-point:ON ACTION controlp INFIELD b_glapdocno name="construct.c.filter.page1.b_glapdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glapdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glapdocno  #顯示到畫面上
            NEXT FIELD b_glapdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<l_glaq001>>----
         #----<<l_glaq005>>----
         #----<<l_glaq010>>----
         #----<<l_glaq006>>----
         #----<<l_glaq003_0>>----
         #----<<l_glaq003_1>>----
         #----<<l_glaq003_2>>----
         #----<<l_glaq003_3>>----
         #----<<l_glaq003_4>>----
         #----<<l_glaq003_5>>----
         #----<<l_glaq003_6>>----
         #----<<l_glaq003_7>>----
         #----<<l_glaq003_8>>----
         #----<<l_glaq003_9>>----
         #----<<l_glaq003_10>>----
         #----<<l_glaq003_11>>----
         #----<<l_glaq003_12>>----
         #----<<l_glaq003_13>>----
         #----<<l_glaq003_14>>----
         #----<<l_glaq003_15>>----
         #----<<l_glaq003_16>>----
         #----<<l_glaq003_17>>----
         #----<<l_glaq003_18>>----
         #----<<l_glaq003_19>>----
         #----<<l_glaq003_20>>----
         #----<<l_glaq003_21>>----
         #----<<l_glaq003_22>>----
         #----<<l_glaq003_23>>----
         #----<<l_glaq003_24>>----
         #----<<l_glaq003_25>>----
         #----<<l_glaq003_26>>----
         #----<<l_glaq003_27>>----
         #----<<l_glaq003_28>>----
         #----<<l_glaq003_29>>----
         #----<<l_glaq003_30>>----
         #----<<l_glaq004_0>>----
         #----<<l_glaq004_1>>----
         #----<<l_glaq004_2>>----
         #----<<l_glaq004_3>>----
         #----<<l_glaq004_4>>----
         #----<<l_glaq004_5>>----
         #----<<l_glaq004_6>>----
         #----<<l_glaq004_7>>----
         #----<<l_glaq004_8>>----
         #----<<l_glaq004_9>>----
         #----<<l_glaq004_10>>----
         #----<<l_glaq004_11>>----
         #----<<l_glaq004_12>>----
         #----<<l_glaq004_13>>----
         #----<<l_glaq004_14>>----
         #----<<l_glaq004_15>>----
         #----<<l_glaq004_16>>----
         #----<<l_glaq004_17>>----
         #----<<l_glaq004_18>>----
         #----<<l_glaq004_19>>----
         #----<<l_glaq004_20>>----
         #----<<l_glaq004_21>>----
         #----<<l_glaq004_22>>----
         #----<<l_glaq004_23>>----
         #----<<l_glaq004_24>>----
         #----<<l_glaq004_25>>----
         #----<<l_glaq004_26>>----
         #----<<l_glaq004_27>>----
         #----<<l_glaq004_28>>----
         #----<<l_glaq004_29>>----
         #----<<l_glaq004_30>>----
         #----<<l_dc>>----
         #----<<l_amt>>----
         #----<<b_glapld>>----
         #Ctrlp:construct.c.page1.b_glapld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glapld
            #add-point:ON ACTION controlp INFIELD b_glapld name="construct.c.filter.page1.b_glapld"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaald()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glapld  #顯示到畫面上
            NEXT FIELD b_glapld                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glapld_desc>>----
   
 
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
   
      CALL aglq320_filter_show('glapdocno','b_glapdocno')
   CALL aglq320_filter_show('glapld','b_glapld')
 
    
   CALL aglq320_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq320.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq320_filter_parser(ps_field)
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
 
{<section id="aglq320.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq320_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq320_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq320.insert" >}
#+ insert
PRIVATE FUNCTION aglq320_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq320.modify" >}
#+ modify
PRIVATE FUNCTION aglq320_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq320.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq320_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq320.delete" >}
#+ delete
PRIVATE FUNCTION aglq320_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq320.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq320_detail_action_trans()
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
 
{<section id="aglq320.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq320_detail_index_setting()
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
            IF g_glap_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_glap_d.getLength() AND g_glap_d.getLength() > 0
            LET g_detail_idx = g_glap_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_glap_d.getLength() THEN
               LET g_detail_idx = g_glap_d.getLength()
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
 
{<section id="aglq320.mask_functions" >}
 &include "erp/agl/aglq320_mask.4gl"
 
{</section>}
 
{<section id="aglq320.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 預設
# Memo...........:
# Usage..........: CALL aglq320_set_default()
# Date & Author..: 2015/12/22 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq320_set_default()
DEFINE l_site LIKE apca_t.apcasite
DEFINE l_glav005        LIKE glav_t.glav005
DEFINE l_sdate_s        LIKE glav_t.glav004 #當季起始日
DEFINE l_sdate_e        LIKE glav_t.glav004 #當季截止日
DEFINE l_glav007        LIKE glav_t.glav007 #歸屬週別
DEFINE l_wdate_s        LIKE glav_t.glav004 #當週起始日
DEFINE l_wdate_e        LIKE glav_t.glav004 #當週截止日
DEFINE l_success        LIKE type_t.chr1

   #帳務組織/帳套/法人預設
   CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,l_site,
                                                      g_input.glapld,g_input.glapcomp
   #獲取帳套相關資訊                                                      
   CALL aglq320_glapld_ref(g_input.glapld)                                                                                                          
   #帳別說明/法人說明
   CALL s_desc_get_ld_desc(g_input.glapld)RETURNING g_input.glapld_desc
   CALL s_desc_get_department_desc(g_input.glapcomp) RETURNING g_input.glapcomp_desc
   LET g_input.currchk ='N' 
   CALL aglq320_curry_show() 
   LET g_input.stus='1'      #單據狀態
   LET g_input.show_ad ='Y'  #含年結傳票
   LET g_input.show_ce ='Y'  #含審計調整傳票
   LET g_input.show_ye ='Y'  #含年結傳票
   LET g_input.multicurr='0'
   CALL cl_set_comp_visible('bpage_2,bpage_3',FALSE)
   LET g_input.glaq002 = ''
   LET g_input.glaq002_desc = ''   
   
   #取得會計週期資料             
   CALL s_get_accdate(g_glaa.glaa003,g_today,'','')
      RETURNING l_success,g_errno,g_input.syear,l_glav005,l_sdate_s,l_sdate_e,
                g_input.speriod,g_input.sdate,g_input.edate,l_glav007,l_wdate_s,l_wdate_e
   LET g_input.eyear=g_input.syear
   LET g_input.eperiod=g_input.speriod
   IF l_success  = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF 
   
   DISPLAY BY NAME g_input.glapld,g_input.glapcomp,g_input.glapld_desc,g_input.glapcomp_desc,
                   g_input.currchk,g_input.stus,g_input.show_ad,g_input.show_ce,g_input.show_ye,
                   g_input.syear,g_input.speriod,g_input.sdate,g_input.edate,
                   g_input.glaq002,g_input.glaq002_desc
END FUNCTION

################################################################################
# Descriptions...: 獲取帳套相關資訊
# Memo...........:
# Usage..........: CALL aglq320_glapld_ref(p_ld)
# Date & Author..: 2015/12/22 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq320_glapld_ref(p_ld)
DEFINE p_ld LIKE apca_t.apcald

   CALL s_ld_sel_glaa(p_ld,'glaacomp|glaa001|glaa003|glaa004|glaa015|glaa016|glaa019|glaa020')
        RETURNING g_sub_success,g_glaa.*
         
   #本位幣二
   IF g_glaa.glaa015='Y' THEN
      CALL cl_set_comp_visible("glaa016",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa016",FALSE)
   END IF
   #本位幣三
   IF g_glaa.glaa019='Y' THEN
      CALL cl_set_comp_visible("glaa020",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa020",FALSE)
   END IF 
   #多本位幣
   CALL cl_set_comp_entry("multicurr",TRUE)
  
   CASE
      WHEN g_glaa.glaa015<>'Y' AND g_glaa.glaa019<>'Y' 
         CALL cl_set_comp_entry("multicurr",FALSE)
         CALL cl_set_combo_scc_part('multicurr','9921','0')
      WHEN g_glaa.glaa015='Y' AND g_glaa.glaa019<>'Y' 
         CALL cl_set_combo_scc_part('multicurr','9921','0,1')
      WHEN g_glaa.glaa015<>'Y' AND g_glaa.glaa019='Y' 
         CALL cl_set_combo_scc_part('multicurr','9921','0,2')
      WHEN g_glaa.glaa015='Y' AND g_glaa.glaa019='Y' 
         CALL cl_set_combo_scc_part('multicurr','9921','0,1,2,3')
   END CASE
   LET g_input.glaa001 = g_glaa.glaa001
   LET g_input.glaa016 = g_glaa.glaa016
   LET g_input.glaa020 = g_glaa.glaa020
   LET g_input.glapcomp = g_glaa.glaacomp
   CALL s_desc_get_department_desc(g_input.glapcomp) RETURNING g_input.glapcomp_desc
   DISPLAY BY NAME g_input.glaa001,g_input.glaa016,g_input.glaa020,g_input.glapcomp,
                   g_input.glapcomp_desc
END FUNCTION

################################################################################
# Descriptions...: 根據選項顯示/隱藏欄位
# Memo...........:
# Usage..........: CALL aglq320_curry_show()
# Date & Author..: 2015/12/22 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq320_curry_show()

   CALL cl_set_comp_visible('l_glaq005,l_glaq010,l_glaq006',TRUE)
   CALL cl_set_comp_visible('l_glaq005_2,l_glaq010_2,l_glaq006_2',TRUE)
   CALL cl_set_comp_visible('l_glaq005_3,l_glaq010_3,l_glaq006_3',TRUE)
   IF g_input.currchk ='N'  THEN
      CALL cl_set_comp_visible('l_glaq005,l_glaq010,l_glaq006',FALSE)
      CALL cl_set_comp_visible('l_glaq005_2,l_glaq010_2,l_glaq006_2',FALSE)
      CALL cl_set_comp_visible('l_glaq005_3,l_glaq010_3,l_glaq006_3',FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aglq320_set_page()
# Date & Author..: 2015/12/22 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq320_set_page()
DEFINE l_idx    LIKE type_t.num5
DEFINE l_sql    STRING
DEFINE i        LIKE type_t.num5

  IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
   
   CALL g_glac.clear()
   #統制跳頁

   LET l_sql="   SELECT DISTINCT glac002 ",
             "     FROM glac_t           ",
             "    WHERE 1=1  AND glac003 = '1'        ",
             "     AND glacent = '",g_enterprise,"'   ",
             "     AND glac001 = '",g_glaa.glaa004,"' ",
             "     AND ", g_wc3 ,
             " ORDER BY glac002  " 

   PREPARE aglq320_pr FROM l_sql
   DECLARE aglq320_cr CURSOR FOR aglq320_pr      
   LET l_idx=1  
   FOREACH aglq320_cr INTO g_glac[l_idx].glac002
      IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = 'FOREACH aglq320_cr'
           LET g_errparam.popup = FALSE
           CALL cl_err()
           EXIT FOREACH
      END IF
      IF l_idx > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
         EXIT FOREACH
      END IF
      IF cl_null(g_glac[l_idx].glac002) THEN
         CALL g_glac.deleteElement(l_idx)
      ELSE
         LET l_idx=l_idx+1
      END IF        
    
   END FOREACH 
   
   LET l_idx = l_idx - 1
   CALL g_glac.deleteElement(g_glac.getLength())
   LET g_header_cnt = g_glac.getLength()
   LET g_rec_b = l_idx   
   #DISPLAY g_header_cnt TO FORMONLY.h_count     



END FUNCTION

################################################################################
# Descriptions...: 跳頁
# Memo...........:
# Usage..........: CALL aglq320_fetch1(p_flag)
# Date & Author..: 2015/12/22 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq320_fetch1(p_flag)
DEFINE p_flag   LIKE type_t.chr1
DEFINE ls_msg     STRING

   IF g_header_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF

   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'L' LET g_current_idx = g_header_cnt
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
            CALL cl_getmsg('fetch',g_dlang) RETURNING ls_msg
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

         IF g_jump > 0 AND g_jump <= g_glac.getLength() THEN
             LET g_current_idx = g_jump
         END IF

         LET g_no_ask = FALSE
   END CASE
   #代表沒有資料
   IF g_current_idx = 0 OR g_glac.getLength() = 0 THEN
      RETURN
   END IF

   #超出範圍
   IF g_current_idx > g_glac.getLength() THEN
      LET g_current_idx = g_glac.getLength()
   END IF         
   CALL cl_set_act_visible("first,previous,jump,next,last",TRUE)   
    IF g_header_cnt=1 THEN
               CALL cl_set_act_visible("first,previous,jump,next,last",FALSE)
            ELSE
               IF g_current_idx=1 THEN
                  CALL cl_set_act_visible("first,previous", FALSE)
                  CALL cl_set_act_visible("jump,next,last", TRUE)
               ELSE
                  IF g_current_idx<>g_header_cnt THEN
                     CALL cl_set_act_visible("first,previous,jump,next,last",TRUE)
                  ELSE
                     CALL cl_set_act_visible("first,previous,jump",TRUE)
                     CALL cl_set_act_visible("next,last", FALSE)
                  END IF
               END IF
            END IF
   
  
   
  #                               
   LET g_input.glaq002 = g_glac[g_current_idx].glac002
   LET g_input.glaq002_desc = s_desc_get_account_desc(g_input.glapld,g_input.glaq002) 
   DISPLAY BY NAME g_input.glaq002,g_input.glaq002_desc 
   CALL aglq320_b_fill()

   
END FUNCTION

################################################################################
# Descriptions...: 取得明細科目節點
# Memo...........:
# Usage..........: CALL aglq320_grow_tree(p_glac002)
# Date & Author..: 2015/12/22 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq320_grow_tree_node(p_glac002)
DEFINE l_node    DYNAMIC ARRAY OF RECORD
                    glac002  LIKE glac_t.glac002                  
                    END RECORD
DEFINE l_idx      LIKE type_t.num10
DEFINE l_id       LIKE type_t.chr100
DEFINE l_sql      STRING
DEFINE l_i        LIKE type_t.num5
DEFINE p_glac002  LIKE glac_t.glac002

   CALL l_node.clear()
   #需要計算的科目
   LET l_sql = " SELECT glac002 FROM glac_t            ",
               "  WHERE glacent = '",g_enterprise,"'   ",
               "    AND glac004 = '",p_glac002,"'      ",
               "    AND glac001 = '",g_glaa.glaa004,"' ",
               " ORDER BY glac002                      "
               
   PREPARE sel_aglq320_nodep1 FROM l_sql
   DECLARE sel_aglq320_nodec1 CURSOR FOR sel_aglq320_nodep1               
   LET l_idx = 1   
   FOREACH sel_aglq320_nodec1 INTO l_node[l_idx].glac002
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF

      LET l_idx = l_idx + 1
   END FOREACH
   CALL l_node.deleteElement(l_node.getLength()) 
   #如果l_idx = 1 代表沒往下的節點
   #          > 1 代表有往下的節點
   #把上層節點給到g_tree去
   FOR l_i = 1 TO g_tree.getLength()
      IF g_tree[l_i].glaq002 = p_glac002 THEN RETURN END IF
   END FOR
   LET g_tree[g_tree_idx].pid = g_tree_pid CLIPPED
   LET g_tree[g_tree_idx].id  = g_tree_pid CLIPPED,'.',g_tree_idx USING '<<<<<<<<<<<<<<<<'
   LET g_tree[g_tree_idx].glaq002 = p_glac002 
   
   IF l_idx = 1 THEN
      #最底層明細科目insert_tmp
      CALL aglq320_inset_tmp(p_glac002)
   ELSE
      LET g_tree[g_tree_idx].glac002 = p_glac002 #父節點的科目
   END IF
   
   LET l_id = g_tree[g_tree_idx].id    #自己是誰要記錄
   LET g_tree_idx = g_tree_idx + 1  
   CALL l_node.deleteElement(l_idx)
   #FOR 跑遞迴 再往下找節點
   FOR l_idx = 1 TO l_node.getLength()
      LET g_tree_pid = l_id CLIPPED 
      CALL aglq320_grow_tree_node(l_node[l_idx].glac002)
   END FOR
   

END FUNCTION

################################################################################
# Descriptions...: title 設置
# Memo...........:
# Usage..........: CALL aglq320_set_title()
# Modify.........: 2015/12/22 By Hans
################################################################################
PRIVATE FUNCTION aglq320_set_title()
DEFINE l_i LIKE type_t.num5
DEFINE l_j LIKE type_t.num5
DEFINE l_k LIKE type_t.num5
DEFINE l_n LIKE type_t.num5
DEFINE l_title DYNAMIC ARRAY OF RECORD
          title1     LIKE type_t.chr500,
          title2     LIKE type_t.chr500,
          title1_2   LIKE type_t.chr500,
          title2_2   LIKE type_t.chr500,
          title1_3   LIKE type_t.chr500,
          title2_3   LIKE type_t.chr500            
          END RECORD
          
DEFINE l_sql   STRING
DEFINE l_glac008 LIKE glac_t.glac008
DEFINE l_field    STRING

   CALL l_title.clear()
  
   #儲存table name
   FOR l_i = 1 TO 30
      LET l_title[l_i].title1 = 'l_glaq003_'||l_i
      LET l_title[l_i].title2 = 'l_glaq004_'||l_i
      LET l_title[l_i].title1_2 = 'l_glaq003_'||l_i||'_2'
      LET l_title[l_i].title2_2 = 'l_glaq004_'||l_i||'_2'
      LET l_title[l_i].title1_3 = 'l_glaq003_'||l_i||'_3'
      LET l_title[l_i].title2_3 = 'l_glaq004_'||l_i||'_3'
      
      CALL cl_set_comp_visible(l_title[l_i].title1,FALSE)
      CALL cl_set_comp_visible(l_title[l_i].title2,FALSE)
      CALL cl_set_comp_visible(l_title[l_i].title1_2,FALSE)
      CALL cl_set_comp_visible(l_title[l_i].title2_2,FALSE)
      CALL cl_set_comp_visible(l_title[l_i].title1_3,FALSE)
      CALL cl_set_comp_visible(l_title[l_i].title2_3,FALSE)
   END FOR
   CALL cl_set_comp_visible('l_glaq003_0,l_glaq004_0,l_glaq003_0_2,l_glaq004_2,l_glaq003_0_3,l_glaq004_0_3',FALSE)
   
   LET l_sql = " SELECT glac002,glac008 ",
               "  FROM glac_t           ",
               " WHERE glacent = '",g_enterprise,"'     ",
              "    AND glac001 = '",g_glaa.glaa004,"'   ",
               "   AND glac004 = '",g_input.glaq002,"'  ",
               " ORDER BY glac002                       "
   LET l_i = 1 LET g_j = 1 LET g_k = 1 LET l_n = 1
   PREPARE aglq320_set_pr01 FROM l_sql
   DECLARE aglq320_set_cs01 CURSOR FOR aglq320_set_pr01
   FOREACH aglq320_set_cs01 INTO g_glaq[l_i].glaq002,l_glac008
      IF g_input.glaq002 = g_glaq[l_i].glaq002 THEN CONTINUE FOREACH END IF
      IF l_glac008  = 1 THEN     #借方科目        
         CALL cl_set_comp_visible(l_title[g_j].title1,TRUE)         #開啟欄位
         CALL cl_set_comp_visible(l_title[g_j].title1_2,TRUE)       #開啟欄位
         CALL cl_set_comp_visible(l_title[g_j].title1_3,TRUE)       #開啟欄位
         CALL cl_set_comp_att_text(l_title[g_j].title1,s_desc_get_account_desc(g_input.glapld,g_glaq[l_i].glaq002))　  #置換title
         CALL cl_set_comp_att_text(l_title[g_j].title1_2,s_desc_get_account_desc(g_input.glapld,g_glaq[l_i].glaq002))　#置換title
         CALL cl_set_comp_att_text(l_title[g_j].title1_3,s_desc_get_account_desc(g_input.glapld,g_glaq[l_i].glaq002))　#置換title                 
         LET g_j = g_j+1       
         LET g_xg_fieldname[l_i+18] = s_desc_get_account_desc(g_input.glapld,g_glaq[l_i].glaq002)  
          CALL cl_set_comp_visible('l_glaq003_0,l_glaq003_0_2,l_glaq003_0_3',TRUE)         
      ELSE
         CALL cl_set_comp_visible(l_title[g_k].title2,TRUE)                       #開啟欄位
         CALL cl_set_comp_visible(l_title[g_k].title2_2,TRUE)                      
         CALL cl_set_comp_visible(l_title[g_k].title2_3,TRUE)  
         CALL cl_set_comp_att_text(l_title[g_k].title2,s_desc_get_account_desc(g_input.glapld,g_glaq[l_i].glaq002)) #置換title
         CALL cl_set_comp_att_text(l_title[g_k].title2_2,s_desc_get_account_desc(g_input.glapld,g_glaq[l_i].glaq002)) #置換title
         CALL cl_set_comp_att_text(l_title[g_k].title2_3,s_desc_get_account_desc(g_input.glapld,g_glaq[l_i].glaq002)) #置換title
         LET g_k = g_k+1
         LET g_xg_fieldname[l_i+48] = s_desc_get_account_desc(g_input.glapld,g_glaq[l_i].glaq002)
         CALL cl_set_comp_visible('l_glaq003_0,l_glaq004_0,l_glaq004_2,l_glaq004_0_3',TRUE)
      END IF
      #借方期初      
      LET l_i = l_i+1
   END FOREACH
   CALL g_glaq.deleteElement(l_i)
END FUNCTION

################################################################################
# Descriptions...:　創建臨時表
# Memo...........:
# Usage..........: CALL aglq320_create_tmp()
# Date & Author..: 2015/12/23 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq320_create_tmp()

   DROP TABLE aglq320_tmp;
      CREATE TEMP TABLE aglq320_tmp(
      glap002    LIKE glap_t.glap002,
      glap004    LIKE glap_t.glap004,
      glapdocdt  LIKE glap_t.glapdocdt,
      glapdocno  LIKE glap_t.glapdocno,
      glaq001    LIKE glaq_t.glaq001,
      glaq005    LIKE glaq_t.glaq005,
      glaq010    LIKE glaq_t.glaq010,
      glaq006    LIKE glaq_t.glaq006,
      glaq003    LIKE glaq_t.glaq003, #借方金額
      glaq004    LIKE glaq_t.glaq004,
      glaq040    LIKE glaq_t.glaq040, #借方金額(本位幣二)
      glaq041    LIKE glaq_t.glaq041,
      glaq043    LIKE glaq_t.glaq042, #借方金額(本位幣三)
      glaq044    LIKE glaq_t.glaq044, 
      glaq002    LIKE glaq_t.glaq002,
      l_flag     LIKE type_t.chr1        
           )
           
   DROP TABLE aglq320_tmp01               #160727-00019#3  Mod  aglq320_print_tmp -->aglq320_tmp01 
      CREATE TEMP TABLE aglq320_tmp01(    #160727-00019#3  Mod  aglq320_print_tmp -->aglq320_tmp01 
         glapld_desc    LIKE type_t.chr500, 
         glapcomp_desc  LIKE type_t.chr500,  
         glaa_desc      LIKE type_t.chr500,
         sdate_desc     LIKE type_t.chr500,
         edate_desc     LIKE type_t.chr500,
         stus_desc      LIKE type_t.chr500,  
         show_ad_desc   LIKE type_t.chr500,          
         show_ce_desc   LIKE type_t.chr500,         
         show_ye_desc   LIKE type_t.chr500,                           
         glap002      LIKE glap_t.glap002, 
         glap004      LIKE glap_t.glap004, 
         glapdocdt    LIKE glap_t.glapdocdt, 
         glapdocno    LIKE glap_t.glapdocno, 
         l_glaq001    LIKE type_t.chr500, 
         l_glaq005    LIKE type_t.chr10, 
         l_glaq010    LIKE type_t.num20_6, 
         l_glaq006    LIKE type_t.num26_10, 
         l_glaq003_0  LIKE type_t.num20_6, 
         l_glaq003_1  LIKE type_t.num20_6, 
         l_glaq003_2  LIKE type_t.num20_6, 
         l_glaq003_3  LIKE type_t.num20_6, 
         l_glaq003_4  LIKE type_t.num20_6, 
         l_glaq003_5  LIKE type_t.num20_6, 
         l_glaq003_6  LIKE type_t.num20_6, 
         l_glaq003_7  LIKE type_t.num20_6, 
         l_glaq003_8  LIKE type_t.num20_6, 
         l_glaq003_9  LIKE type_t.num20_6, 
         l_glaq003_10 LIKE type_t.num20_6, 
         l_glaq003_11 LIKE type_t.num20_6, 
         l_glaq003_12 LIKE type_t.num20_6, 
         l_glaq003_13 LIKE type_t.num20_6, 
         l_glaq003_14 LIKE type_t.num20_6, 
         l_glaq003_15 LIKE type_t.num20_6, 
         l_glaq003_16 LIKE type_t.num20_6, 
         l_glaq003_17 LIKE type_t.num20_6, 
         l_glaq003_18 LIKE type_t.num20_6, 
         l_glaq003_19 LIKE type_t.num20_6, 
         l_glaq003_20 LIKE type_t.num20_6, 
         l_glaq003_21 LIKE type_t.num20_6, 
         l_glaq003_22 LIKE type_t.num20_6, 
         l_glaq003_23 LIKE type_t.num20_6, 
         l_glaq003_24 LIKE type_t.num20_6, 
         l_glaq003_25 LIKE type_t.num20_6, 
         l_glaq003_26 LIKE type_t.num20_6, 
         l_glaq003_27 LIKE type_t.num20_6, 
         l_glaq003_28 LIKE type_t.num20_6, 
         l_glaq003_29 LIKE type_t.num20_6, 
         l_glaq003_30 LIKE type_t.num20_6, 
         l_glaq004_0  LIKE type_t.num20_6, 
         l_glaq004_1  LIKE type_t.num20_6, 
         l_glaq004_2  LIKE type_t.num20_6, 
         l_glaq004_3  LIKE type_t.num20_6, 
         l_glaq004_4  LIKE type_t.num20_6, 
         l_glaq004_5  LIKE type_t.num20_6, 
         l_glaq004_6  LIKE type_t.num20_6, 
         l_glaq004_7  LIKE type_t.num20_6, 
         l_glaq004_8  LIKE type_t.num20_6, 
         l_glaq004_9  LIKE type_t.num20_6, 
         l_glaq004_10 LIKE type_t.num20_6, 
         l_glaq004_11 LIKE type_t.num20_6, 
         l_glaq004_12 LIKE type_t.num20_6, 
         l_glaq004_13 LIKE type_t.num20_6, 
         l_glaq004_14 LIKE type_t.num20_6, 
         l_glaq004_15 LIKE type_t.num20_6, 
         l_glaq004_16 LIKE type_t.num20_6, 
         l_glaq004_17 LIKE type_t.num20_6, 
         l_glaq004_18 LIKE type_t.num20_6, 
         l_glaq004_19 LIKE type_t.num20_6, 
         l_glaq004_20 LIKE type_t.num20_6, 
         l_glaq004_21 LIKE type_t.num20_6, 
         l_glaq004_22 LIKE type_t.num20_6, 
         l_glaq004_23 LIKE type_t.num20_6, 
         l_glaq004_24 LIKE type_t.num20_6, 
         l_glaq004_25 LIKE type_t.num20_6, 
         l_glaq004_26 LIKE type_t.num20_6, 
         l_glaq004_27 LIKE type_t.num20_6, 
         l_glaq004_28 LIKE type_t.num20_6, 
         l_glaq004_29 LIKE type_t.num20_6, 
         l_glaq004_30 LIKE type_t.num20_6, 
         l_dc LIKE type_t.chr100, 
         l_amt LIKE type_t.num20_6
                             )
           
END FUNCTION

################################################################################
# Descriptions...:  插入臨時表
# Memo...........:
# Usage..........: CALL aglq320_inset_tmp(p_glac002)
# Date & Author..: 2015/12/23 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq320_inset_tmp(p_glaq002)
DEFINE p_glaq002  LIKE glaq_t.glaq002
DEFINE l_sql STRING
   IF g_input.sdate <> g_pdate_s1 THEN #表示破期抓取抓0期glar余额+本年1期第一天~起始日期前一天的发生额（glaq） 
      #期初：抓取CE、YE、AD憑證金額
      LET l_sql= " INSERT INTO aglq320_tmp                                                   ",  
                 " SELECT '','','','','','',                                                 ",
                 "        SUM(glaq010),'',SUM(glaq003),SUM(glaq004),SUM(glaq040),            ",
                 "        SUM(glaq041),SUM(glaq043),SUM(glaq044),                            ",
                 "        '",g_glac002,"','3'                                                ",
                 "     FROM glap_t,glaq_t                                                    ", 
                 "    WHERE glapent = glaqent AND glaqent=",g_enterprise,"                   ",
                 "      AND glapdocno = glaqdocno                                            ",
                 "      AND glapld = glaqld AND glaqld='",g_input.glapld,"'                  ",
                 "      AND glaq002 = '",p_glaq002,"' AND glap002= '",g_input.syear,"'       ",
                 "      AND glapdocdt < '",g_input.sdate,"'  AND glapstus IN ('S','Y','N')   "
      LET l_sql = l_sql CLIPPED,g_sql3                                 
      PREPARE aglq320_ins_tmppr03 FROM l_sql                                         
      EXECUTE aglq320_ins_tmppr03
   END IF
   #明細傳票資料
   LET l_sql = " INSERT INTO aglq320_tmp                                              ",
               " SELECT glap002,glap004,glapdocdt,glapdocno,glaq001,                  ",
               "        glaq005,glaq010,glaq006,glaq003,glaq004,                      ",
               "        glaq040,glaq041,glaq043,glaq044,                              ",
               "        '",g_glac002,"','2'                                           ",
               "   FROM glap_t,glaq_t                                                 ",
               "  WHERE glapdocno = glaqdocno AND glapent = glaqent                   ",
               "    AND glapdocdt BETWEEN '",g_input.sdate,"' AND '",g_input.edate,"' ",  
               "    AND glapent = '",g_enterprise,"'                                  ",          
               "    AND glaq002 = '",p_glaq002,"'  AND glaqld='",g_input.glapld,"'    "         
    LET l_sql = l_sql CLIPPED,g_sql2,g_sql4    
   PREPARE aglq320_ins_tmppr04 FROM l_sql
   EXECUTE aglq320_ins_tmppr04     

   
END FUNCTION

################################################################################
# Descriptions...: 取得條件
# Memo...........:
# Usage..........: CALL aglq320_str()
# Date & Author..: 2015/12/23 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq320_str()
DEFINE l_pdate_s1       LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
DEFINE l_pdate_e1       LIKE glav_t.glav004
DEFINE l_pdate_s2       LIKE glav_t.glav004 #截止年度+期別對應的起始截止日期
DEFINE l_pdate_e2       LIKE glav_t.glav004
DEFINE l_period         LIKE glap_t.glap004
DEFINE l_glav002        LIKE glav_t.glav002
DEFINE l_glav005        LIKE glav_t.glav005
DEFINE l_sdate_s        LIKE glav_t.glav004
DEFINE l_sdate_e        LIKE glav_t.glav004
DEFINE l_glav006        LIKE glav_t.glav006
DEFINE l_glav007        LIKE glav_t.glav007
DEFINE l_wdate_s        LIKE glav_t.glav004
DEFINE l_wdate_e        LIKE glav_t.glav004
DEFINE l_glav004        LIKE glav_t.glav004
DEFINE l_glav004_m      LIKE glav_t.glav004
DEFINE l_glav004_e      LIKE glav_t.glav004

   LET g_sql2 = '' LET g_sql3 ='' LET g_sql4 = ''
   #顯示月結CE憑證否
   IF g_input.show_ce<>'Y' THEN
      LET g_sql2=g_sql2," AND glap007<>'CE' "
      LET g_sql3="'CE'"
   END IF
   #顯示年結YE憑證否
   IF g_input.show_ye<>'Y' THEN
      LET g_sql2=g_sql2," AND glap007<>'YE' "
      IF NOT cl_null(g_sql3) THEN
         LET g_sql3=g_sql3,",'YE'"
      ELSE
         LET g_sql3="'YE'" 
      END IF
   END IF
   #顯示AD審計調整傳票否
   IF g_input.show_ad<>'Y' THEN
      LET g_sql2=g_sql2," AND glap007<>'AD' "
      IF NOT cl_null(g_sql3) THEN
         LET g_sql3=g_sql3,",'AD'"
      ELSE
         LET g_sql3="'AD'" 
      END IF
   END IF
   IF NOT cl_null(g_sql3) THEN
      LET g_sql3=" AND glap007 IN (",g_sql3,")"
   END IF
   #單據狀態
   CASE
      WHEN g_input.stus='1'
         LET g_sql4=g_sql4," AND glapstus='S' "
      WHEN g_input.stus='2'
         LET g_sql4=g_sql4," AND glapstus IN ('S','Y') "
      WHEN g_input.stus='3'
         LET g_sql4=g_sql4," AND glapstus IN ('S','Y','N') "
   END CASE
   
   
   #取得會計週期資料
   CALL s_get_accdate(g_glaa.glaa003,'',g_input.syear,g_input.speriod) 
   RETURNING g_sub_success,g_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,g_pdate_s1,l_pdate_e1,l_glav007,l_wdate_s,l_wdate_e
   
   #取得上期年月
   CALL s_fin_date_get_last_period(g_glaa.glaa003,g_input.glapld,g_input.syear,g_input.speriod)
      RETURNING g_sub_success,g_preyear,g_premon
   
   #起始年度第一天
   SELECT MIN(glav004) INTO l_glav004 FROM glav_t 
   WHERE glavent=g_enterprise AND glav001=g_glaa.glaa003 AND glav002=g_input.syear
   #抓取上一期最後一天
   LET l_period = g_input.speriod-1 #上期
   SELECT MAX(glav004) INTO l_glav004_m FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa.glaa003 AND glav002=g_input.syear AND glav006=l_period
   #获取期初截止日期
   IF g_input.sdate=l_pdate_s1 THEN
      LET l_glav004_e = l_glav004_m
   ELSE
      LET l_glav004_e = g_input.sdate-1
   END IF   
      
END FUNCTION

################################################################################
# Descriptions...: 取得根結點
# Memo...........:
# Usage..........: CALL aglq320_grow_tree()
# Date & Author..: 2015/12/23 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq320_grow_tree()
DEFINE l_root DYNAMIC ARRAY OF RECORD
                 glac002  LIKE glac_t.glac002
                 END RECORD
DEFINE l_idx     LIKE type_t.num5    #array index
DEFINE l_sql STRING

   CALL g_tree.clear()
   CALL l_root.clear()
   CALL aglq320_str()
   LET g_glac002_t =''
   DELETE FROM aglq320_tmp
   
   LET l_sql = " SELECT DISTINCT glac002 FROM glac_t    ",
               "  WHERE glacent = '",g_enterprise,"'    ",
               "    AND glac004 = '",g_input.glaq002,"' ",
               "    AND glac001 = '",g_glaa.glaa004,"'  "
   LET l_idx = 1
   LET g_tree_idx = 1
   PREPARE aglq320_tree_pr02 FROM l_sql
   DECLARE aglq320_tree_cs02 CURSOR FOR aglq320_tree_pr02
   FOREACH aglq320_tree_cs02 INTO l_root[l_idx].glac002   
      IF g_input.glaq002 = l_root[l_idx].glac002 THEN CONTINUE FOREACH END IF     
      LET g_tree_pid = '0'    #代表是起始節點
      LET g_glac002 = l_root[l_idx].glac002         
      CALL aglq320_grow_tree_node(l_root[l_idx].glac002)
      LET l_idx = l_idx+1
   END FOREACH
   CALL l_root.deleteElement(l_idx)
   
   DELETE FROM aglq320_tmp
   WHERE glaq003 IS NULL AND glaq004 IS NULL
END FUNCTION

################################################################################
# Descriptions...: 整理temp_table
# Memo...........:
# Usage..........: CALL aglq320_temp_set()
# Date & Author..: 2015/12/24 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq320_temp_set()
DEFINE l_glaq010 LIKE glaq_t.glaq010
DEFINE l_glaq003 LIKE glaq_t.glaq003
DEFINE l_glaq004 LIKE glaq_t.glaq004
DEFINE l_glaq040 LIKE glaq_t.glaq040
DEFINE l_glaq041 LIKE glaq_t.glaq042
DEFINE l_glaq043 LIKE glaq_t.glaq043
DEFINE l_glaq044 LIKE glaq_t.glaq044
DEFINE l_glaq002 LIKE glaq_t.glaq002
DEFINE l_glaq001 LIKE type_t.chr100  
DEFINE l_glac008 LIKE glac_t.glac008
DEFINE l_i  LIKE type_t.num5
DEFINE l_sql STRING

   #期初金額整理  
   LET l_glaq001=s_desc_gzcbl004_desc('9927','1')
   IF g_input.sdate <> g_pdate_s1 THEN #破期
      FOR l_i = 1 TO g_glaq.getLength()
         LET l_sql = " INSERT INTO aglq320_tmp                                                 ",
                     " SELECT  '','','','','",l_glaq001,"','',                                 ",
                     "         SUM(glar010-glar011),'',SUM(glar005),SUM(glar006),              ",
                     "         SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037),            ",
                     "         glar001,'3'                                                     ",
                     "   FROM glar_t                                                           ",
                     "  WHERE glar002 = '",g_input.syear,"' AND glarld = '",g_input.glapld,"'  ",
                     "    AND glar003 = 0  AND glar001 = '",g_glaq[l_i].glaq002,"'             ",
                     "    GROUP BY glar001                                                     "
         PREPARE aglq320_pb7 FROM l_sql            
         EXECUTE aglq320_pb7         
      END FOR  
  ELSE
     FOR l_i = 1 TO g_glaq.getLength()
        LET l_sql = " INSERT INTO aglq320_tmp                                                 ",
                    " SELECT  '','','','','",l_glaq001,"','',                                 ",
                    "         SUM(glar010-glar011),'',SUM(glar005),SUM(glar006),              ",
                    "         SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037),            ",
                    "         glar001,'3'                                                     ",
                    "   FROM glar_t                                                           ",
                    "  WHERE glar002 = '",g_input.syear,"' AND glarld = '",g_input.glapld,"'  ",
                    "    AND glar003 = '",g_preyear,"' AND glar001 = '",g_glaq[l_i].glaq002,"' ",
                    "    GROUP BY glar001                                                     "
        PREPARE aglq320_pb8 FROM l_sql            
        EXECUTE aglq320_pb8         
     END FOR  
  END IF  
     
  
  LET l_sql = " SELECT SUM(glaq010),SUM(glaq003),SUM(glaq004),SUM(glaq040), ",
              "        SUM(glaq041),SUM(glaq043),SUM(glaq044),glaq002       ",        
              "  FROM aglq320_tmp   ",
              " WHERE l_flag = '3'  ",
              " GROUP BY glaq002    "
   PREPARE aglq320_pb3 FROM l_sql            
   DECLARE aglq320_cs3 CURSOR FOR aglq320_pb3
   FOREACH aglq320_cs3 INTO  l_glaq010,l_glaq003,l_glaq004,l_glaq040,
                             l_glaq041,l_glaq043,l_glaq044,l_glaq002  
      INSERT INTO aglq320_tmp
      VALUES('','','','',l_glaq001,'',l_glaq010,'',l_glaq003,l_glaq004,l_glaq040,
              l_glaq041,l_glaq043,l_glaq044,l_glaq002,'1')
   END FOREACH
   DELETE FROM aglq320_tmp
    WHERE l_flag = '3'
   
   
                         
END FUNCTION

################################################################################
# Descriptions...: 數字重置
# Memo...........:
# Usage..........: CALLaglq320_reset(p_ac)
# Date & Author..: 2015/12/24 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq320_reset(p_ac,p_flag)
DEFINE p_ac    LIKE type_t.num5
DEFINE p_flag  LIKE type_t.chr1
   
   CASE p_flag
      WHEN 1
         IF cl_null(g_glap_d[p_ac].l_glaq003_1 ) THEN LET g_glap_d[p_ac].l_glaq003_1  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_2 ) THEN LET g_glap_d[p_ac].l_glaq003_2  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_3 ) THEN LET g_glap_d[p_ac].l_glaq003_3  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_4 ) THEN LET g_glap_d[p_ac].l_glaq003_4  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_5 ) THEN LET g_glap_d[p_ac].l_glaq003_5  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_6 ) THEN LET g_glap_d[p_ac].l_glaq003_6  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_7 ) THEN LET g_glap_d[p_ac].l_glaq003_7  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_8 ) THEN LET g_glap_d[p_ac].l_glaq003_8  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_9 ) THEN LET g_glap_d[p_ac].l_glaq003_9  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_10) THEN LET g_glap_d[p_ac].l_glaq003_10 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_11) THEN LET g_glap_d[p_ac].l_glaq003_11 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_12) THEN LET g_glap_d[p_ac].l_glaq003_12 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_13) THEN LET g_glap_d[p_ac].l_glaq003_13 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_14) THEN LET g_glap_d[p_ac].l_glaq003_14 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_15) THEN LET g_glap_d[p_ac].l_glaq003_15 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_16) THEN LET g_glap_d[p_ac].l_glaq003_16 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_17) THEN LET g_glap_d[p_ac].l_glaq003_17 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_18) THEN LET g_glap_d[p_ac].l_glaq003_18 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_19) THEN LET g_glap_d[p_ac].l_glaq003_19 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_20) THEN LET g_glap_d[p_ac].l_glaq003_20 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_21) THEN LET g_glap_d[p_ac].l_glaq003_21 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_22) THEN LET g_glap_d[p_ac].l_glaq003_22 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_23) THEN LET g_glap_d[p_ac].l_glaq003_23 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_24) THEN LET g_glap_d[p_ac].l_glaq003_24 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_25) THEN LET g_glap_d[p_ac].l_glaq003_25 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_26) THEN LET g_glap_d[p_ac].l_glaq003_26 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_27) THEN LET g_glap_d[p_ac].l_glaq003_27 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_28) THEN LET g_glap_d[p_ac].l_glaq003_28 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_29) THEN LET g_glap_d[p_ac].l_glaq003_29 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq003_30) THEN LET g_glap_d[p_ac].l_glaq003_30 = 0 END IF
       
         IF cl_null(g_glap_d[p_ac].l_glaq004_1 ) THEN LET g_glap_d[p_ac].l_glaq004_1  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_2 ) THEN LET g_glap_d[p_ac].l_glaq004_2  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_3 ) THEN LET g_glap_d[p_ac].l_glaq004_3  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_4 ) THEN LET g_glap_d[p_ac].l_glaq004_4  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_5 ) THEN LET g_glap_d[p_ac].l_glaq004_5  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_6 ) THEN LET g_glap_d[p_ac].l_glaq004_6  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_7 ) THEN LET g_glap_d[p_ac].l_glaq004_7  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_8 ) THEN LET g_glap_d[p_ac].l_glaq004_8  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_9 ) THEN LET g_glap_d[p_ac].l_glaq004_9  = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_10) THEN LET g_glap_d[p_ac].l_glaq004_10 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_11) THEN LET g_glap_d[p_ac].l_glaq004_11 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_12) THEN LET g_glap_d[p_ac].l_glaq004_12 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_13) THEN LET g_glap_d[p_ac].l_glaq004_13 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_14) THEN LET g_glap_d[p_ac].l_glaq004_14 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_15) THEN LET g_glap_d[p_ac].l_glaq004_15 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_16) THEN LET g_glap_d[p_ac].l_glaq004_16 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_17) THEN LET g_glap_d[p_ac].l_glaq004_17 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_18) THEN LET g_glap_d[p_ac].l_glaq004_18 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_19) THEN LET g_glap_d[p_ac].l_glaq004_19 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_20) THEN LET g_glap_d[p_ac].l_glaq004_20 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_21) THEN LET g_glap_d[p_ac].l_glaq004_21 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_22) THEN LET g_glap_d[p_ac].l_glaq004_22 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_23) THEN LET g_glap_d[p_ac].l_glaq004_23 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_24) THEN LET g_glap_d[p_ac].l_glaq004_24 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_25) THEN LET g_glap_d[p_ac].l_glaq004_25 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_26) THEN LET g_glap_d[p_ac].l_glaq004_26 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_27) THEN LET g_glap_d[p_ac].l_glaq004_27 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_28) THEN LET g_glap_d[p_ac].l_glaq004_28 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_29) THEN LET g_glap_d[p_ac].l_glaq004_29 = 0 END IF
         IF cl_null(g_glap_d[p_ac].l_glaq004_30) THEN LET g_glap_d[p_ac].l_glaq004_30 = 0 END IF

         IF cl_null(g_glap_d2[p_ac].l_glaq003_1 ) THEN LET g_glap_d2[p_ac].l_glaq003_1  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_2 ) THEN LET g_glap_d2[p_ac].l_glaq003_2  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_3 ) THEN LET g_glap_d2[p_ac].l_glaq003_3  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_4 ) THEN LET g_glap_d2[p_ac].l_glaq003_4  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_5 ) THEN LET g_glap_d2[p_ac].l_glaq003_5  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_6 ) THEN LET g_glap_d2[p_ac].l_glaq003_6  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_7 ) THEN LET g_glap_d2[p_ac].l_glaq003_7  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_8 ) THEN LET g_glap_d2[p_ac].l_glaq003_8  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_9 ) THEN LET g_glap_d2[p_ac].l_glaq003_9  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_10) THEN LET g_glap_d2[p_ac].l_glaq003_10 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_11) THEN LET g_glap_d2[p_ac].l_glaq003_11 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_12) THEN LET g_glap_d2[p_ac].l_glaq003_12 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_13) THEN LET g_glap_d2[p_ac].l_glaq003_13 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_14) THEN LET g_glap_d2[p_ac].l_glaq003_14 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_15) THEN LET g_glap_d2[p_ac].l_glaq003_15 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_16) THEN LET g_glap_d2[p_ac].l_glaq003_16 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_17) THEN LET g_glap_d2[p_ac].l_glaq003_17 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_18) THEN LET g_glap_d2[p_ac].l_glaq003_18 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_19) THEN LET g_glap_d2[p_ac].l_glaq003_19 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_20) THEN LET g_glap_d2[p_ac].l_glaq003_20 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_21) THEN LET g_glap_d2[p_ac].l_glaq003_21 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_22) THEN LET g_glap_d2[p_ac].l_glaq003_22 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_23) THEN LET g_glap_d2[p_ac].l_glaq003_23 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_24) THEN LET g_glap_d2[p_ac].l_glaq003_24 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_25) THEN LET g_glap_d2[p_ac].l_glaq003_25 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_26) THEN LET g_glap_d2[p_ac].l_glaq003_26 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_27) THEN LET g_glap_d2[p_ac].l_glaq003_27 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_28) THEN LET g_glap_d2[p_ac].l_glaq003_28 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_29) THEN LET g_glap_d2[p_ac].l_glaq003_29 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq003_30) THEN LET g_glap_d2[p_ac].l_glaq003_30 = 0 END IF
       
         IF cl_null(g_glap_d2[p_ac].l_glaq004_1 ) THEN LET g_glap_d2[p_ac].l_glaq004_1  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_2 ) THEN LET g_glap_d2[p_ac].l_glaq004_2  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_3 ) THEN LET g_glap_d2[p_ac].l_glaq004_3  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_4 ) THEN LET g_glap_d2[p_ac].l_glaq004_4  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_5 ) THEN LET g_glap_d2[p_ac].l_glaq004_5  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_6 ) THEN LET g_glap_d2[p_ac].l_glaq004_6  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_7 ) THEN LET g_glap_d2[p_ac].l_glaq004_7  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_8 ) THEN LET g_glap_d2[p_ac].l_glaq004_8  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_9 ) THEN LET g_glap_d2[p_ac].l_glaq004_9  = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_10) THEN LET g_glap_d2[p_ac].l_glaq004_10 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_11) THEN LET g_glap_d2[p_ac].l_glaq004_11 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_12) THEN LET g_glap_d2[p_ac].l_glaq004_12 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_13) THEN LET g_glap_d2[p_ac].l_glaq004_13 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_14) THEN LET g_glap_d2[p_ac].l_glaq004_14 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_15) THEN LET g_glap_d2[p_ac].l_glaq004_15 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_16) THEN LET g_glap_d2[p_ac].l_glaq004_16 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_17) THEN LET g_glap_d2[p_ac].l_glaq004_17 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_18) THEN LET g_glap_d2[p_ac].l_glaq004_18 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_19) THEN LET g_glap_d2[p_ac].l_glaq004_19 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_20) THEN LET g_glap_d2[p_ac].l_glaq004_20 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_21) THEN LET g_glap_d2[p_ac].l_glaq004_21 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_22) THEN LET g_glap_d2[p_ac].l_glaq004_22 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_23) THEN LET g_glap_d2[p_ac].l_glaq004_23 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_24) THEN LET g_glap_d2[p_ac].l_glaq004_24 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_25) THEN LET g_glap_d2[p_ac].l_glaq004_25 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_26) THEN LET g_glap_d2[p_ac].l_glaq004_26 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_27) THEN LET g_glap_d2[p_ac].l_glaq004_27 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_28) THEN LET g_glap_d2[p_ac].l_glaq004_28 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_29) THEN LET g_glap_d2[p_ac].l_glaq004_29 = 0 END IF
         IF cl_null(g_glap_d2[p_ac].l_glaq004_30) THEN LET g_glap_d2[p_ac].l_glaq004_30 = 0 END IF

         IF cl_null(g_glap_d3[p_ac].l_glaq003_1 ) THEN LET g_glap_d3[p_ac].l_glaq003_1  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_2 ) THEN LET g_glap_d3[p_ac].l_glaq003_2  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_3 ) THEN LET g_glap_d3[p_ac].l_glaq003_3  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_4 ) THEN LET g_glap_d3[p_ac].l_glaq003_4  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_5 ) THEN LET g_glap_d3[p_ac].l_glaq003_5  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_6 ) THEN LET g_glap_d3[p_ac].l_glaq003_6  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_7 ) THEN LET g_glap_d3[p_ac].l_glaq003_7  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_8 ) THEN LET g_glap_d3[p_ac].l_glaq003_8  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_9 ) THEN LET g_glap_d3[p_ac].l_glaq003_9  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_10) THEN LET g_glap_d3[p_ac].l_glaq003_10 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_11) THEN LET g_glap_d3[p_ac].l_glaq003_11 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_12) THEN LET g_glap_d3[p_ac].l_glaq003_12 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_13) THEN LET g_glap_d3[p_ac].l_glaq003_13 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_14) THEN LET g_glap_d3[p_ac].l_glaq003_14 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_15) THEN LET g_glap_d3[p_ac].l_glaq003_15 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_16) THEN LET g_glap_d3[p_ac].l_glaq003_16 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_17) THEN LET g_glap_d3[p_ac].l_glaq003_17 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_18) THEN LET g_glap_d3[p_ac].l_glaq003_18 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_19) THEN LET g_glap_d3[p_ac].l_glaq003_19 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_20) THEN LET g_glap_d3[p_ac].l_glaq003_20 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_21) THEN LET g_glap_d3[p_ac].l_glaq003_21 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_22) THEN LET g_glap_d3[p_ac].l_glaq003_22 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_23) THEN LET g_glap_d3[p_ac].l_glaq003_23 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_24) THEN LET g_glap_d3[p_ac].l_glaq003_24 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_25) THEN LET g_glap_d3[p_ac].l_glaq003_25 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_26) THEN LET g_glap_d3[p_ac].l_glaq003_26 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_27) THEN LET g_glap_d3[p_ac].l_glaq003_27 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_28) THEN LET g_glap_d3[p_ac].l_glaq003_28 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_29) THEN LET g_glap_d3[p_ac].l_glaq003_29 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq003_30) THEN LET g_glap_d3[p_ac].l_glaq003_30 = 0 END IF
                                                                    
         IF cl_null(g_glap_d3[p_ac].l_glaq004_1 ) THEN LET g_glap_d3[p_ac].l_glaq004_1  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_2 ) THEN LET g_glap_d3[p_ac].l_glaq004_2  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_3 ) THEN LET g_glap_d3[p_ac].l_glaq004_3  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_4 ) THEN LET g_glap_d3[p_ac].l_glaq004_4  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_5 ) THEN LET g_glap_d3[p_ac].l_glaq004_5  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_6 ) THEN LET g_glap_d3[p_ac].l_glaq004_6  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_7 ) THEN LET g_glap_d3[p_ac].l_glaq004_7  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_8 ) THEN LET g_glap_d3[p_ac].l_glaq004_8  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_9 ) THEN LET g_glap_d3[p_ac].l_glaq004_9  = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_10) THEN LET g_glap_d3[p_ac].l_glaq004_10 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_11) THEN LET g_glap_d3[p_ac].l_glaq004_11 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_12) THEN LET g_glap_d3[p_ac].l_glaq004_12 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_13) THEN LET g_glap_d3[p_ac].l_glaq004_13 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_14) THEN LET g_glap_d3[p_ac].l_glaq004_14 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_15) THEN LET g_glap_d3[p_ac].l_glaq004_15 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_16) THEN LET g_glap_d3[p_ac].l_glaq004_16 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_17) THEN LET g_glap_d3[p_ac].l_glaq004_17 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_18) THEN LET g_glap_d3[p_ac].l_glaq004_18 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_19) THEN LET g_glap_d3[p_ac].l_glaq004_19 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_20) THEN LET g_glap_d3[p_ac].l_glaq004_20 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_21) THEN LET g_glap_d3[p_ac].l_glaq004_21 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_22) THEN LET g_glap_d3[p_ac].l_glaq004_22 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_23) THEN LET g_glap_d3[p_ac].l_glaq004_23 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_24) THEN LET g_glap_d3[p_ac].l_glaq004_24 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_25) THEN LET g_glap_d3[p_ac].l_glaq004_25 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_26) THEN LET g_glap_d3[p_ac].l_glaq004_26 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_27) THEN LET g_glap_d3[p_ac].l_glaq004_27 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_28) THEN LET g_glap_d3[p_ac].l_glaq004_28 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_29) THEN LET g_glap_d3[p_ac].l_glaq004_29 = 0 END IF
         IF cl_null(g_glap_d3[p_ac].l_glaq004_30) THEN LET g_glap_d3[p_ac].l_glaq004_30 = 0 END IF
      WHEN 2     
         LET g_glap_d[p_ac].l_glaq003_0 = g_glap_d[p_ac].l_glaq003_1  + g_glap_d[p_ac].l_glaq003_2  + g_glap_d[p_ac].l_glaq003_3 
                                        + g_glap_d[p_ac].l_glaq003_4  + g_glap_d[p_ac].l_glaq003_5  + g_glap_d[p_ac].l_glaq003_6 
                                        + g_glap_d[p_ac].l_glaq003_7  + g_glap_d[p_ac].l_glaq003_8  + g_glap_d[p_ac].l_glaq003_9 
                                        + g_glap_d[p_ac].l_glaq003_10 + g_glap_d[p_ac].l_glaq003_11 + g_glap_d[p_ac].l_glaq003_12
                                        + g_glap_d[p_ac].l_glaq003_13 + g_glap_d[p_ac].l_glaq003_14 + g_glap_d[p_ac].l_glaq003_15
                                        + g_glap_d[p_ac].l_glaq003_16 + g_glap_d[p_ac].l_glaq003_17 + g_glap_d[p_ac].l_glaq003_18
                                        + g_glap_d[p_ac].l_glaq003_19 + g_glap_d[p_ac].l_glaq003_20 + g_glap_d[p_ac].l_glaq003_21
                                        + g_glap_d[p_ac].l_glaq003_22 + g_glap_d[p_ac].l_glaq003_23 + g_glap_d[p_ac].l_glaq003_24
                                        + g_glap_d[p_ac].l_glaq003_25 + g_glap_d[p_ac].l_glaq003_26 + g_glap_d[p_ac].l_glaq003_27
                                        + g_glap_d[p_ac].l_glaq003_28 + g_glap_d[p_ac].l_glaq003_29 + g_glap_d[p_ac].l_glaq003_30
         
         LET g_glap_d[p_ac].l_glaq004_0 = g_glap_d[p_ac].l_glaq004_1  + g_glap_d[p_ac].l_glaq004_2  + g_glap_d[p_ac].l_glaq004_3 
                                        + g_glap_d[p_ac].l_glaq004_4  + g_glap_d[p_ac].l_glaq004_5  + g_glap_d[p_ac].l_glaq004_6 
                                        + g_glap_d[p_ac].l_glaq004_7  + g_glap_d[p_ac].l_glaq004_8  + g_glap_d[p_ac].l_glaq004_9 
                                        + g_glap_d[p_ac].l_glaq004_10 + g_glap_d[p_ac].l_glaq004_11 + g_glap_d[p_ac].l_glaq004_12
                                        + g_glap_d[p_ac].l_glaq004_13 + g_glap_d[p_ac].l_glaq004_14 + g_glap_d[p_ac].l_glaq004_15
                                        + g_glap_d[p_ac].l_glaq004_16 + g_glap_d[p_ac].l_glaq004_17 + g_glap_d[p_ac].l_glaq004_18
                                        + g_glap_d[p_ac].l_glaq004_19 + g_glap_d[p_ac].l_glaq004_20 + g_glap_d[p_ac].l_glaq004_21
                                        + g_glap_d[p_ac].l_glaq004_22 + g_glap_d[p_ac].l_glaq004_23 + g_glap_d[p_ac].l_glaq004_24
                                        + g_glap_d[p_ac].l_glaq004_25 + g_glap_d[p_ac].l_glaq004_26 + g_glap_d[p_ac].l_glaq004_27
                                        + g_glap_d[p_ac].l_glaq004_28 + g_glap_d[p_ac].l_glaq004_29 + g_glap_d[p_ac].l_glaq004_30
                                       
        LET g_glap_d2[p_ac].l_glaq003_0 = g_glap_d2[p_ac].l_glaq003_1  + g_glap_d2[p_ac].l_glaq003_2  + g_glap_d2[p_ac].l_glaq003_3 
                                        + g_glap_d2[p_ac].l_glaq003_4  + g_glap_d2[p_ac].l_glaq003_5  + g_glap_d2[p_ac].l_glaq003_6 
                                        + g_glap_d2[p_ac].l_glaq003_7  + g_glap_d2[p_ac].l_glaq003_8  + g_glap_d2[p_ac].l_glaq003_9 
                                        + g_glap_d2[p_ac].l_glaq003_10 + g_glap_d2[p_ac].l_glaq003_11 + g_glap_d2[p_ac].l_glaq003_12
                                        + g_glap_d2[p_ac].l_glaq003_13 + g_glap_d2[p_ac].l_glaq003_14 + g_glap_d2[p_ac].l_glaq003_15
                                        + g_glap_d2[p_ac].l_glaq003_16 + g_glap_d2[p_ac].l_glaq003_17 + g_glap_d2[p_ac].l_glaq003_18
                                        + g_glap_d2[p_ac].l_glaq003_19 + g_glap_d2[p_ac].l_glaq003_20 + g_glap_d2[p_ac].l_glaq003_21
                                        + g_glap_d2[p_ac].l_glaq003_22 + g_glap_d2[p_ac].l_glaq003_23 + g_glap_d2[p_ac].l_glaq003_24
                                        + g_glap_d2[p_ac].l_glaq003_25 + g_glap_d2[p_ac].l_glaq003_26 + g_glap_d2[p_ac].l_glaq003_27
                                        + g_glap_d2[p_ac].l_glaq003_28 + g_glap_d2[p_ac].l_glaq003_29 + g_glap_d2[p_ac].l_glaq003_30
         
        LET g_glap_d2[p_ac].l_glaq004_0 = g_glap_d2[p_ac].l_glaq004_1  + g_glap_d2[p_ac].l_glaq004_2  + g_glap_d2[p_ac].l_glaq004_3 
                                        + g_glap_d2[p_ac].l_glaq004_4  + g_glap_d2[p_ac].l_glaq004_5  + g_glap_d2[p_ac].l_glaq004_6 
                                        + g_glap_d2[p_ac].l_glaq004_7  + g_glap_d2[p_ac].l_glaq004_8  + g_glap_d2[p_ac].l_glaq004_9 
                                        + g_glap_d2[p_ac].l_glaq004_10 + g_glap_d2[p_ac].l_glaq004_11 + g_glap_d2[p_ac].l_glaq004_12
                                        + g_glap_d2[p_ac].l_glaq004_13 + g_glap_d2[p_ac].l_glaq004_14 + g_glap_d2[p_ac].l_glaq004_15
                                        + g_glap_d2[p_ac].l_glaq004_16 + g_glap_d2[p_ac].l_glaq004_17 + g_glap_d2[p_ac].l_glaq004_18
                                        + g_glap_d2[p_ac].l_glaq004_19 + g_glap_d2[p_ac].l_glaq004_20 + g_glap_d2[p_ac].l_glaq004_21
                                        + g_glap_d2[p_ac].l_glaq004_22 + g_glap_d2[p_ac].l_glaq004_23 + g_glap_d2[p_ac].l_glaq004_24
                                        + g_glap_d2[p_ac].l_glaq004_25 + g_glap_d2[p_ac].l_glaq004_26 + g_glap_d2[p_ac].l_glaq004_27
                                        + g_glap_d2[p_ac].l_glaq004_28 + g_glap_d2[p_ac].l_glaq004_29 + g_glap_d2[p_ac].l_glaq004_30
                                        
         LET g_glap_d3[p_ac].l_glaq003_0 = g_glap_d3[p_ac].l_glaq003_1  + g_glap_d3[p_ac].l_glaq003_2  + g_glap_d3[p_ac].l_glaq003_3 
                                         + g_glap_d3[p_ac].l_glaq003_4  + g_glap_d3[p_ac].l_glaq003_5  + g_glap_d3[p_ac].l_glaq003_6 
                                         + g_glap_d3[p_ac].l_glaq003_7  + g_glap_d3[p_ac].l_glaq003_8  + g_glap_d3[p_ac].l_glaq003_9 
                                         + g_glap_d3[p_ac].l_glaq003_10 + g_glap_d3[p_ac].l_glaq003_11 + g_glap_d3[p_ac].l_glaq003_12
                                         + g_glap_d3[p_ac].l_glaq003_13 + g_glap_d3[p_ac].l_glaq003_14 + g_glap_d3[p_ac].l_glaq003_15
                                         + g_glap_d3[p_ac].l_glaq003_16 + g_glap_d3[p_ac].l_glaq003_17 + g_glap_d3[p_ac].l_glaq003_18
                                         + g_glap_d3[p_ac].l_glaq003_19 + g_glap_d3[p_ac].l_glaq003_20 + g_glap_d3[p_ac].l_glaq003_21
                                         + g_glap_d3[p_ac].l_glaq003_22 + g_glap_d3[p_ac].l_glaq003_23 + g_glap_d3[p_ac].l_glaq003_24
                                         + g_glap_d3[p_ac].l_glaq003_25 + g_glap_d3[p_ac].l_glaq003_26 + g_glap_d3[p_ac].l_glaq003_27
                                         + g_glap_d3[p_ac].l_glaq003_28 + g_glap_d3[p_ac].l_glaq003_29 + g_glap_d3[p_ac].l_glaq003_30
         
         LET g_glap_d3[p_ac].l_glaq004_0 = g_glap_d3[p_ac].l_glaq004_1  + g_glap_d3[p_ac].l_glaq004_2  + g_glap_d3[p_ac].l_glaq004_3 
                                         + g_glap_d3[p_ac].l_glaq004_4  + g_glap_d3[p_ac].l_glaq004_5  + g_glap_d3[p_ac].l_glaq004_6 
                                         + g_glap_d3[p_ac].l_glaq004_7  + g_glap_d3[p_ac].l_glaq004_8  + g_glap_d3[p_ac].l_glaq004_9 
                                         + g_glap_d3[p_ac].l_glaq004_10 + g_glap_d3[p_ac].l_glaq004_11 + g_glap_d3[p_ac].l_glaq004_12
                                         + g_glap_d3[p_ac].l_glaq004_13 + g_glap_d3[p_ac].l_glaq004_14 + g_glap_d3[p_ac].l_glaq004_15
                                         + g_glap_d3[p_ac].l_glaq004_16 + g_glap_d3[p_ac].l_glaq004_17 + g_glap_d3[p_ac].l_glaq004_18
                                         + g_glap_d3[p_ac].l_glaq004_19 + g_glap_d3[p_ac].l_glaq004_20 + g_glap_d3[p_ac].l_glaq004_21
                                         + g_glap_d3[p_ac].l_glaq004_22 + g_glap_d3[p_ac].l_glaq004_23 + g_glap_d3[p_ac].l_glaq004_24
                                         + g_glap_d3[p_ac].l_glaq004_25 + g_glap_d3[p_ac].l_glaq004_26 + g_glap_d3[p_ac].l_glaq004_27
                                         + g_glap_d3[p_ac].l_glaq004_28 + g_glap_d3[p_ac].l_glaq004_29 + g_glap_d3[p_ac].l_glaq004_30                                                        
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 填充本位幣一
# Memo...........:
# Usage..........: CALL aglq320_b_fill1()
# Date & Author..: 2015/12/29 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq320_b_fill1()
DEFINE l_sql STRING
DEFINE l_i          LIKE type_t.num5
DEFINE l_j          LIKE type_t.num5
DEFINE l_glac002    LIKE glac_t.glac002
DEFINE l_glaq003    LIKE glaq_t.glaq003
DEFINE l_glaq0031   LIKE glaq_t.glaq003
DEFINE l_glaq004    LIKE glaq_t.glaq004
DEFINE l_glaq0041   LIKE glaq_t.glaq004 
DEFINE l_glac DYNAMIC ARRAY OF RECORD
          idx       LIKE type_t.num5,   
          glac002   LIKE glac_t.glac002
   END RECORD
DEFINE l_glap DYNAMIC ARRAY OF RECORD
          idx       LIKE type_t.num5,
        glap004     LIKE glap_t.glap004          
    END RECORD        
DEFINE l_glac008    LIKE glac_t.glac008
DEFINE l_idx        LIKE type_t.num5
DEFINE l_mon        LIKE glaq_t.glaq003
DEFINE l_glaq002_t  LIKE glaq_t.glaq002
DEFINE l_glap002_t  LIKE glap_t.glap002 #年度
DEFINE l_glap002_o  LIKE glap_t.glap002
DEFINE l_glap004_t  LIKE glap_t.glap004 
DEFINE l_y          LIKE type_t.num5
DEFINE l_m          LIKE type_t.num5

   CALL g_glap_d.clear()
   CALL l_glac.clear()
   LET l_sql = " SELECT glac002,glac008                 ",
               "  FROM glac_t                           ",
               " WHERE glacent = '",g_enterprise,"'     ",
               "   AND glac001 = '",g_glaa.glaa004,"'   ",
               "   AND glac004 = '",g_input.glaq002,"'  ",           
               " ORDER BY glac002                       "
   LET l_i = 1 LET l_j = 31
   PREPARE aglq320_set_pr02 FROM l_sql
   DECLARE aglq320_set_cs02 CURSOR FOR aglq320_set_pr02
   FOREACH aglq320_set_cs02 INTO l_glac002,l_glac008
      IF g_input.glaq002 = l_glac002 THEN CONTINUE FOREACH END IF
      IF l_glac008 = '1'  THEN     #開啟借方科目        
         LET l_glac[l_i].glac002 = l_glac002
         LET l_glac[l_i].idx = l_i
         LET l_i = l_i +1 
      ELSE #開啟貸方科目
         LET l_glac[l_j].glac002 = l_glac002
         LET l_glac[l_j].idx = l_j
         LET l_j = l_j +1 
      END IF
   END FOREACH   
                            
   LET g_sql = "  SELECT glap002,glap004,glapdocdt,glapdocno,glaq001,    ",
               "         glaq005,glaq010,glaq006,glaq003,glaq004,glaq002 ",
               "    FROM aglq320_tmp                                     ",
               "   WHERE l_flag IN ('2')                                 ",
               "   ORDER BY l_flag,glapdocdt                             "    
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1     
   LET l_i =  1
   LET l_glaq002_t =''
   LET l_glap002_t = ''
   LET l_glap002_o = ''
   LET l_glap004_t =''
   PREPARE aglq320_bfill_pb1 FROM g_sql
   DECLARE aglq320_bfill_cs1 CURSOR FOR aglq320_bfill_pb1              
   FOREACH aglq320_bfill_cs1 INTO 
      g_glap_d[l_ac].glap002,g_glap_d[l_ac].glap004,g_glap_d[l_ac].glapdocdt,g_glap_d[l_ac].glapdocno, 
      g_glap_d[l_ac].l_glaq001,g_glap_d[l_ac].l_glaq005,g_glap_d[l_ac].l_glaq010,g_glap_d[l_ac].l_glaq006,
      l_glaq003,l_glaq004,l_glac002
      #取得科目科餘方向
      SELECT glac008 INTO l_glac008 FROM glac_t
       WHERE glacent = g_enterprise
         AND glac001 = g_glaa.glaa004   
         AND glac002 = l_glac002                  
      
      IF l_ac = 1 THEN #期初     
         LET g_glap_d[l_ac + 1].* = g_glap_d[l_ac].*
         LET g_glap_d[l_ac].glap002 = ''
         LET g_glap_d[l_ac].glap004 = ''
         LET g_glap_d[l_ac].glapdocdt = ''
         LET g_glap_d[l_ac].glapdocno = '' 
         LET g_glap_d[l_ac].l_glaq001 = s_desc_gzcbl004_desc('9927','1')
         LET g_glap_d[l_ac].l_glaq005 = ''
         LET g_glap_d[l_ac].l_glaq010 = ''
         LET g_glap_d[l_ac].l_glaq006 = ''

         PREPARE aglq320_pb4 FROM " SELECT DISTINCT glaq002 FROM aglq320_tmp " 
         DECLARE aglq320_cs4 CURSOR FOR aglq320_pb4
         FOREACH aglq320_cs4 INTO l_glaq002_t         
            FOR l_idx = 1 TO 30 #找出第幾格
               IF l_glaq002_t = l_glac[l_idx].glac002 THEN  
                  SELECT glaq003,glaq004                   
                    INTO l_glaq0031,l_glaq0041 FROM aglq320_tmp
                   WHERE glaq002 = l_glaq002_t AND l_flag = 1 
                  IF cl_null(l_glaq0031) THEN LET l_glaq0031 = 0 END IF
                  IF cl_null(l_glaq0041) THEN LET l_glaq0041 = 0 END IF
                  #借-貸 期初
                  LET l_mon =  l_glaq0031 - l_glaq0041
                  IF l_glac008 = 1 THEN 
                     CASE l_idx
                        WHEN 1    
                           LET g_glap_d[l_ac].l_glaq003_1  = l_mon
                        WHEN 2
                           LET g_glap_d[l_ac].l_glaq003_2  = l_mon
                        WHEN 3
                           LET g_glap_d[l_ac].l_glaq003_3  = l_mon
                        WHEN 4   
                           LET g_glap_d[l_ac].l_glaq003_4  = l_mon
                        WHEN 5   
                           LET g_glap_d[l_ac].l_glaq003_5  = l_mon
                        WHEN 6
                           LET g_glap_d[l_ac].l_glaq003_6  = l_mon
                        WHEN 7
                           LET g_glap_d[l_ac].l_glaq003_7  = l_mon
                        WHEN 8
                           LET g_glap_d[l_ac].l_glaq003_8  = l_mon
                        WHEN 9
                           LET g_glap_d[l_ac].l_glaq003_9  = l_mon
                        WHEN 10
                           LET g_glap_d[l_ac].l_glaq003_10 = l_mon
                        WHEN 11
                           LET g_glap_d[l_ac].l_glaq003_11 = l_mon
                        WHEN 12
                           LET g_glap_d[l_ac].l_glaq003_12 = l_mon
                        WHEN 13
                           LET g_glap_d[l_ac].l_glaq003_13 = l_mon
                        WHEN 14
                           LET g_glap_d[l_ac].l_glaq003_14 = l_mon
                        WHEN 15
                           LET g_glap_d[l_ac].l_glaq003_15 = l_mon
                        WHEN 16
                           LET g_glap_d[l_ac].l_glaq003_16 = l_mon
                        WHEN 17
                           LET g_glap_d[l_ac].l_glaq003_17 = l_mon
                        WHEN 18
                           LET g_glap_d[l_ac].l_glaq003_18 = l_mon
                        WHEN 19
                           LET g_glap_d[l_ac].l_glaq003_19 = l_mon
                        WHEN 20
                           LET g_glap_d[l_ac].l_glaq003_20 = l_mon
                        WHEN 21
                           LET g_glap_d[l_ac].l_glaq003_21 = l_mon
                        WHEN 22
                           LET g_glap_d[l_ac].l_glaq003_22 = l_mon
                        WHEN 23
                           LET g_glap_d[l_ac].l_glaq003_23 = l_mon
                        WHEN 24
                           LET g_glap_d[l_ac].l_glaq003_24 = l_mon
                        WHEN 25
                           LET g_glap_d[l_ac].l_glaq003_25 = l_mon
                        WHEN 26
                           LET g_glap_d[l_ac].l_glaq003_26 = l_mon
                        WHEN 27
                           LET g_glap_d[l_ac].l_glaq003_27 = l_mon
                        WHEN 28
                           LET g_glap_d[l_ac].l_glaq003_28 = l_mon
                        WHEN 29
                           LET g_glap_d[l_ac].l_glaq003_29 = l_mon
                        WHEN 30
                           LET g_glap_d[l_ac].l_glaq003_30 = l_mon               
                     END CASE
                  ELSE
                     CASE l_idx
                        WHEN 31    
                           LET g_glap_d[l_ac].l_glaq004_1  = l_mon
                        WHEN 32
                           LET g_glap_d[l_ac].l_glaq004_2  = l_mon
                        WHEN 33
                           LET g_glap_d[l_ac].l_glaq004_3  = l_mon
                        WHEN 34   
                           LET g_glap_d[l_ac].l_glaq004_4  = l_mon
                        WHEN 35   
                           LET g_glap_d[l_ac].l_glaq004_5  = l_mon
                        WHEN 36
                           LET g_glap_d[l_ac].l_glaq004_6  = l_mon
                        WHEN 37
                           LET g_glap_d[l_ac].l_glaq004_7  = l_mon
                        WHEN 38
                           LET g_glap_d[l_ac].l_glaq004_8  = l_mon
                        WHEN 39
                           LET g_glap_d[l_ac].l_glaq004_9  = l_mon
                        WHEN 40
                           LET g_glap_d[l_ac].l_glaq004_10 = l_mon
                        WHEN 41
                           LET g_glap_d[l_ac].l_glaq004_11 = l_mon
                        WHEN 42
                           LET g_glap_d[l_ac].l_glaq004_12 = l_mon
                        WHEN 43
                           LET g_glap_d[l_ac].l_glaq004_13 = l_mon
                        WHEN 44
                           LET g_glap_d[l_ac].l_glaq004_14 = l_mon
                        WHEN 45
                           LET g_glap_d[l_ac].l_glaq004_15 = l_mon
                        WHEN 46
                           LET g_glap_d[l_ac].l_glaq004_16 = l_mon
                        WHEN 47
                           LET g_glap_d[l_ac].l_glaq004_17 = l_mon
                        WHEN 48
                           LET g_glap_d[l_ac].l_glaq004_18 = l_mon
                        WHEN 49
                           LET g_glap_d[l_ac].l_glaq004_19 = l_mon
                        WHEN 50
                           LET g_glap_d[l_ac].l_glaq004_20 = l_mon
                        WHEN 51
                           LET g_glap_d[l_ac].l_glaq004_21 = l_mon
                        WHEN 52
                           LET g_glap_d[l_ac].l_glaq004_22 = l_mon
                        WHEN 53
                           LET g_glap_d[l_ac].l_glaq004_23 = l_mon
                        WHEN 54
                           LET g_glap_d[l_ac].l_glaq004_24 = l_mon
                        WHEN 55
                           LET g_glap_d[l_ac].l_glaq004_25 = l_mon
                        WHEN 56
                           LET g_glap_d[l_ac].l_glaq004_26 = l_mon
                        WHEN 57
                           LET g_glap_d[l_ac].l_glaq004_27 = l_mon
                        WHEN 58
                           LET g_glap_d[l_ac].l_glaq004_28 = l_mon
                        WHEN 59
                           LET g_glap_d[l_ac].l_glaq004_29 = l_mon
                        WHEN 60
                           LET g_glap_d[l_ac].l_glaq004_30 = l_mon 
                     END CASE
                  END IF                
               END IF             
            END FOR  
         END FOREACH    
         CALL aglq320_reset(l_ac,'1')
         CALL aglq320_reset(l_ac,'2')  
         LET g_glap_d[l_ac].l_amt =  g_glap_d[l_ac].l_glaq003_0 -  g_glap_d[l_ac].l_glaq004_0    
         IF cl_null(g_glap_d[l_ac].l_amt) THEN LET g_glap_d[l_ac].l_amt = 0 END IF
         CASE 
           WHEN g_glap_d[l_ac].l_amt > 0  
              CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #借  
           WHEN g_glap_d[l_ac].l_amt < 0 
              CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #貸
           WHEN g_glap_d[l_ac].l_amt = 0
              CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #平
         END CASE                       
         #紀錄本年累計       
         LET l_y = 1  
         LET l_m = 1         
         LET l_ac = l_ac + 1 
      END IF 
      
      #借方科目      
      IF l_glac008 = 1 THEN
         IF l_glaq003 <> 0 THEN
             FOR l_idx = 1 TO 30
                IF l_glac002 = l_glac[l_idx].glac002 THEN                                   
                   EXIT FOR          
                END IF             
             END FOR
             LET l_mon = l_glaq003
          END IF
          IF l_glaq004 <> 0 THEN
             FOR l_idx = 1 TO 30
                IF l_glac002 = l_glac[l_idx].glac002 THEN                                
                   EXIT FOR          
                END IF             
             END FOR
             LET l_mon = l_glaq004 * -1
          END IF
      ELSE
         IF l_glaq003 <> 0 THEN
            FOR l_idx = 31 TO 60
               IF l_glac002 = l_glac[l_idx].glac002 THEN                 
                  EXIT FOR          
               END IF             
            END FOR
             LET l_mon = l_glaq003 * - 1
         END IF
         IF l_glaq004 <> 0 THEN
             FOR l_idx = 31 TO 60
                IF l_glac002 = l_glac[l_idx].glac002 THEN              
                   
                   EXIT FOR          
                END IF             
             END FOR
             LET l_mon = l_glaq004 
          END IF
      END IF     
      IF l_glac008 = 1 THEN 
         CASE l_idx
            WHEN 1    
               LET g_glap_d[l_ac].l_glaq003_1  = l_mon
            WHEN 2
               LET g_glap_d[l_ac].l_glaq003_2  = l_mon
            WHEN 3
               LET g_glap_d[l_ac].l_glaq003_3  = l_mon
            WHEN 4   
               LET g_glap_d[l_ac].l_glaq003_4  = l_mon
            WHEN 5   
               LET g_glap_d[l_ac].l_glaq003_5  = l_mon
            WHEN 6
               LET g_glap_d[l_ac].l_glaq003_6  = l_mon
            WHEN 7
               LET g_glap_d[l_ac].l_glaq003_7  = l_mon
            WHEN 8
               LET g_glap_d[l_ac].l_glaq003_8  = l_mon
            WHEN 9
               LET g_glap_d[l_ac].l_glaq003_9  = l_mon
            WHEN 10
               LET g_glap_d[l_ac].l_glaq003_10 = l_mon
            WHEN 11
               LET g_glap_d[l_ac].l_glaq003_11 = l_mon
            WHEN 12
               LET g_glap_d[l_ac].l_glaq003_12 = l_mon
            WHEN 13
               LET g_glap_d[l_ac].l_glaq003_13 = l_mon
            WHEN 14
               LET g_glap_d[l_ac].l_glaq003_14 = l_mon
            WHEN 15
               LET g_glap_d[l_ac].l_glaq003_15 = l_mon
            WHEN 16
               LET g_glap_d[l_ac].l_glaq003_16 = l_mon
            WHEN 17
               LET g_glap_d[l_ac].l_glaq003_17 = l_mon
            WHEN 18
               LET g_glap_d[l_ac].l_glaq003_18 = l_mon
            WHEN 19
               LET g_glap_d[l_ac].l_glaq003_19 = l_mon
            WHEN 20
               LET g_glap_d[l_ac].l_glaq003_20 = l_mon
            WHEN 21
               LET g_glap_d[l_ac].l_glaq003_21 = l_mon
            WHEN 22
               LET g_glap_d[l_ac].l_glaq003_22 = l_mon
            WHEN 23
               LET g_glap_d[l_ac].l_glaq003_23 = l_mon
            WHEN 24
               LET g_glap_d[l_ac].l_glaq003_24 = l_mon
            WHEN 25
               LET g_glap_d[l_ac].l_glaq003_25 = l_mon
            WHEN 26
               LET g_glap_d[l_ac].l_glaq003_26 = l_mon
            WHEN 27
               LET g_glap_d[l_ac].l_glaq003_27 = l_mon
            WHEN 28
               LET g_glap_d[l_ac].l_glaq003_28 = l_mon
            WHEN 29
               LET g_glap_d[l_ac].l_glaq003_29 = l_mon
            WHEN 30
               LET g_glap_d[l_ac].l_glaq003_30 = l_mon               
         END CASE
      ELSE
         CASE l_idx
            WHEN 31    
               LET g_glap_d[l_ac].l_glaq004_1  = l_mon
            WHEN 32
               LET g_glap_d[l_ac].l_glaq004_2  = l_mon
            WHEN 33
               LET g_glap_d[l_ac].l_glaq004_3  = l_mon
            WHEN 34   
               LET g_glap_d[l_ac].l_glaq004_4  = l_mon
            WHEN 35   
               LET g_glap_d[l_ac].l_glaq004_5  = l_mon
            WHEN 36
               LET g_glap_d[l_ac].l_glaq004_6  = l_mon
            WHEN 37
               LET g_glap_d[l_ac].l_glaq004_7  = l_mon
            WHEN 38
               LET g_glap_d[l_ac].l_glaq004_8  = l_mon
            WHEN 39
               LET g_glap_d[l_ac].l_glaq004_9  = l_mon
            WHEN 40
               LET g_glap_d[l_ac].l_glaq004_10 = l_mon
            WHEN 41
               LET g_glap_d[l_ac].l_glaq004_11 = l_mon
            WHEN 42
               LET g_glap_d[l_ac].l_glaq004_12 = l_mon
            WHEN 43
               LET g_glap_d[l_ac].l_glaq004_13 = l_mon
            WHEN 44
               LET g_glap_d[l_ac].l_glaq004_14 = l_mon
            WHEN 45
               LET g_glap_d[l_ac].l_glaq004_15 = l_mon
            WHEN 46
               LET g_glap_d[l_ac].l_glaq004_16 = l_mon
            WHEN 47
               LET g_glap_d[l_ac].l_glaq004_17 = l_mon
            WHEN 48
               LET g_glap_d[l_ac].l_glaq004_18 = l_mon
            WHEN 49
               LET g_glap_d[l_ac].l_glaq004_19 = l_mon
            WHEN 50
               LET g_glap_d[l_ac].l_glaq004_20 = l_mon
            WHEN 51
               LET g_glap_d[l_ac].l_glaq004_21 = l_mon
            WHEN 52
               LET g_glap_d[l_ac].l_glaq004_22 = l_mon
            WHEN 53
               LET g_glap_d[l_ac].l_glaq004_23 = l_mon
            WHEN 54
               LET g_glap_d[l_ac].l_glaq004_24 = l_mon
            WHEN 55
               LET g_glap_d[l_ac].l_glaq004_25 = l_mon
            WHEN 56
               LET g_glap_d[l_ac].l_glaq004_26 = l_mon
            WHEN 57
               LET g_glap_d[l_ac].l_glaq004_27 = l_mon
            WHEN 58
               LET g_glap_d[l_ac].l_glaq004_28 = l_mon
            WHEN 59
               LET g_glap_d[l_ac].l_glaq004_29 = l_mon
            WHEN 60
               LET g_glap_d[l_ac].l_glaq004_30 = l_mon               
         END CASE
      END IF
      CALL aglq320_reset(l_ac,'1')
      CALL aglq320_reset(l_ac,'2') 
      LET g_glap_d[l_ac].l_amt = g_glap_d[l_ac].l_glaq003_0 -  g_glap_d[l_ac].l_glaq004_0 + g_glap_d[l_ac-1].l_amt  
      IF cl_null(g_glap_d[l_ac].l_amt) THEN LET g_glap_d[l_ac].l_amt = 0 END IF
　　  CASE 
         WHEN g_glap_d[l_ac].l_amt > 0  
            CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #借  
         WHEN g_glap_d[l_ac].l_amt < 0 
            CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #貸
         WHEN g_glap_d[l_ac].l_amt = 0
            CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #平
      END CASE      
      #本期合計
      IF l_glap004_t <> g_glap_d[l_ac].glap004 AND l_ac > 1 THEN
         LET l_glap002_t = g_glap_d[l_ac-1].glap002 #紀錄本期年度
         LET g_glap_d[l_ac + 2].* = g_glap_d[l_ac].*
         INITIALIZE g_glap_d[l_ac].* TO NULL
         LET g_glap_d[l_ac].glap002 = ''   
         LET g_glap_d[l_ac].glap004 = ''           
         LET g_glap_d[l_ac].glapdocdt = ''
         LET g_glap_d[l_ac].glapdocno = '' 
         LET g_glap_d[l_ac].l_glaq001 = s_desc_gzcbl004_desc('9927','2')
         LET g_glap_d[l_ac].l_glaq005 = ''
         LET g_glap_d[l_ac].l_glaq010 = ''
         LET g_glap_d[l_ac].l_glaq006 = ''     
         CALL aglq320_reset(l_ac,'1')
         FOR l_idx = 1 TO l_glap.getLength()   
            IF l_glap004_t = l_glap[l_idx].glap004 THEN          
               LET g_glap_d[l_ac].l_glaq003_1  = g_glap_d[l_ac].l_glaq003_1  + g_glap_d[l_idx].l_glaq003_1 
               LET g_glap_d[l_ac].l_glaq003_2  = g_glap_d[l_ac].l_glaq003_2  + g_glap_d[l_idx].l_glaq003_2 
               LET g_glap_d[l_ac].l_glaq003_3  = g_glap_d[l_ac].l_glaq003_3  + g_glap_d[l_idx].l_glaq003_3 
               LET g_glap_d[l_ac].l_glaq003_4  = g_glap_d[l_ac].l_glaq003_4  + g_glap_d[l_idx].l_glaq003_4 
               LET g_glap_d[l_ac].l_glaq003_5  = g_glap_d[l_ac].l_glaq003_5  + g_glap_d[l_idx].l_glaq003_5 
               LET g_glap_d[l_ac].l_glaq003_6  = g_glap_d[l_ac].l_glaq003_6  + g_glap_d[l_idx].l_glaq003_6 
               LET g_glap_d[l_ac].l_glaq003_7  = g_glap_d[l_ac].l_glaq003_7  + g_glap_d[l_idx].l_glaq003_7 
               LET g_glap_d[l_ac].l_glaq003_8  = g_glap_d[l_ac].l_glaq003_8  + g_glap_d[l_idx].l_glaq003_8 
               LET g_glap_d[l_ac].l_glaq003_9  = g_glap_d[l_ac].l_glaq003_9  + g_glap_d[l_idx].l_glaq003_9 
               LET g_glap_d[l_ac].l_glaq003_10 = g_glap_d[l_ac].l_glaq003_10 + g_glap_d[l_idx].l_glaq003_10
               LET g_glap_d[l_ac].l_glaq003_11 = g_glap_d[l_ac].l_glaq003_11 + g_glap_d[l_idx].l_glaq003_11
               LET g_glap_d[l_ac].l_glaq003_12 = g_glap_d[l_ac].l_glaq003_12 + g_glap_d[l_idx].l_glaq003_12
               LET g_glap_d[l_ac].l_glaq003_13 = g_glap_d[l_ac].l_glaq003_13 + g_glap_d[l_idx].l_glaq003_13
               LET g_glap_d[l_ac].l_glaq003_14 = g_glap_d[l_ac].l_glaq003_14 + g_glap_d[l_idx].l_glaq003_14
               LET g_glap_d[l_ac].l_glaq003_15 = g_glap_d[l_ac].l_glaq003_15 + g_glap_d[l_idx].l_glaq003_15
               LET g_glap_d[l_ac].l_glaq003_16 = g_glap_d[l_ac].l_glaq003_16 + g_glap_d[l_idx].l_glaq003_16
               LET g_glap_d[l_ac].l_glaq003_17 = g_glap_d[l_ac].l_glaq003_17 + g_glap_d[l_idx].l_glaq003_17
               LET g_glap_d[l_ac].l_glaq003_18 = g_glap_d[l_ac].l_glaq003_18 + g_glap_d[l_idx].l_glaq003_18
               LET g_glap_d[l_ac].l_glaq003_19 = g_glap_d[l_ac].l_glaq003_19 + g_glap_d[l_idx].l_glaq003_19
               LET g_glap_d[l_ac].l_glaq003_20 = g_glap_d[l_ac].l_glaq003_20 + g_glap_d[l_idx].l_glaq003_20
               LET g_glap_d[l_ac].l_glaq003_21 = g_glap_d[l_ac].l_glaq003_21 + g_glap_d[l_idx].l_glaq003_21
               LET g_glap_d[l_ac].l_glaq003_22 = g_glap_d[l_ac].l_glaq003_22 + g_glap_d[l_idx].l_glaq003_22
               LET g_glap_d[l_ac].l_glaq003_23 = g_glap_d[l_ac].l_glaq003_23 + g_glap_d[l_idx].l_glaq003_23
               LET g_glap_d[l_ac].l_glaq003_24 = g_glap_d[l_ac].l_glaq003_24 + g_glap_d[l_idx].l_glaq003_24
               LET g_glap_d[l_ac].l_glaq003_25 = g_glap_d[l_ac].l_glaq003_25 + g_glap_d[l_idx].l_glaq003_25
               LET g_glap_d[l_ac].l_glaq003_26 = g_glap_d[l_ac].l_glaq003_26 + g_glap_d[l_idx].l_glaq003_26
               LET g_glap_d[l_ac].l_glaq003_27 = g_glap_d[l_ac].l_glaq003_27 + g_glap_d[l_idx].l_glaq003_27
               LET g_glap_d[l_ac].l_glaq003_28 = g_glap_d[l_ac].l_glaq003_28 + g_glap_d[l_idx].l_glaq003_28
               LET g_glap_d[l_ac].l_glaq003_29 = g_glap_d[l_ac].l_glaq003_29 + g_glap_d[l_idx].l_glaq003_29
               LET g_glap_d[l_ac].l_glaq003_30 = g_glap_d[l_ac].l_glaq003_30 + g_glap_d[l_idx].l_glaq003_30
                                                               
               LET g_glap_d[l_ac].l_glaq004_1  = g_glap_d[l_ac].l_glaq004_1  + g_glap_d[l_idx].l_glaq004_1 
               LET g_glap_d[l_ac].l_glaq004_2  = g_glap_d[l_ac].l_glaq004_2  + g_glap_d[l_idx].l_glaq004_2 
               LET g_glap_d[l_ac].l_glaq004_3  = g_glap_d[l_ac].l_glaq004_3  + g_glap_d[l_idx].l_glaq004_3 
               LET g_glap_d[l_ac].l_glaq004_4  = g_glap_d[l_ac].l_glaq004_4  + g_glap_d[l_idx].l_glaq004_4 
               LET g_glap_d[l_ac].l_glaq004_5  = g_glap_d[l_ac].l_glaq004_5  + g_glap_d[l_idx].l_glaq004_5 
               LET g_glap_d[l_ac].l_glaq004_6  = g_glap_d[l_ac].l_glaq004_6  + g_glap_d[l_idx].l_glaq004_6 
               LET g_glap_d[l_ac].l_glaq004_7  = g_glap_d[l_ac].l_glaq004_7  + g_glap_d[l_idx].l_glaq004_7 
               LET g_glap_d[l_ac].l_glaq004_8  = g_glap_d[l_ac].l_glaq004_8  + g_glap_d[l_idx].l_glaq004_8 
               LET g_glap_d[l_ac].l_glaq004_9  = g_glap_d[l_ac].l_glaq004_9  + g_glap_d[l_idx].l_glaq004_9 
               LET g_glap_d[l_ac].l_glaq004_10 = g_glap_d[l_ac].l_glaq004_10 + g_glap_d[l_idx].l_glaq004_10
               LET g_glap_d[l_ac].l_glaq004_11 = g_glap_d[l_ac].l_glaq004_11 + g_glap_d[l_idx].l_glaq004_11
               LET g_glap_d[l_ac].l_glaq004_12 = g_glap_d[l_ac].l_glaq004_12 + g_glap_d[l_idx].l_glaq004_12
               LET g_glap_d[l_ac].l_glaq004_13 = g_glap_d[l_ac].l_glaq004_13 + g_glap_d[l_idx].l_glaq004_13
               LET g_glap_d[l_ac].l_glaq004_14 = g_glap_d[l_ac].l_glaq004_14 + g_glap_d[l_idx].l_glaq004_14
               LET g_glap_d[l_ac].l_glaq004_15 = g_glap_d[l_ac].l_glaq004_15 + g_glap_d[l_idx].l_glaq004_15
               LET g_glap_d[l_ac].l_glaq004_16 = g_glap_d[l_ac].l_glaq004_16 + g_glap_d[l_idx].l_glaq004_16
               LET g_glap_d[l_ac].l_glaq004_17 = g_glap_d[l_ac].l_glaq004_17 + g_glap_d[l_idx].l_glaq004_17
               LET g_glap_d[l_ac].l_glaq004_18 = g_glap_d[l_ac].l_glaq004_18 + g_glap_d[l_idx].l_glaq004_18
               LET g_glap_d[l_ac].l_glaq004_19 = g_glap_d[l_ac].l_glaq004_19 + g_glap_d[l_idx].l_glaq004_19
               LET g_glap_d[l_ac].l_glaq004_20 = g_glap_d[l_ac].l_glaq004_20 + g_glap_d[l_idx].l_glaq004_20
               LET g_glap_d[l_ac].l_glaq004_21 = g_glap_d[l_ac].l_glaq004_21 + g_glap_d[l_idx].l_glaq004_21
               LET g_glap_d[l_ac].l_glaq004_22 = g_glap_d[l_ac].l_glaq004_22 + g_glap_d[l_idx].l_glaq004_22
               LET g_glap_d[l_ac].l_glaq004_23 = g_glap_d[l_ac].l_glaq004_23 + g_glap_d[l_idx].l_glaq004_23
               LET g_glap_d[l_ac].l_glaq004_24 = g_glap_d[l_ac].l_glaq004_24 + g_glap_d[l_idx].l_glaq004_24
               LET g_glap_d[l_ac].l_glaq004_25 = g_glap_d[l_ac].l_glaq004_25 + g_glap_d[l_idx].l_glaq004_25
               LET g_glap_d[l_ac].l_glaq004_26 = g_glap_d[l_ac].l_glaq004_26 + g_glap_d[l_idx].l_glaq004_26
               LET g_glap_d[l_ac].l_glaq004_27 = g_glap_d[l_ac].l_glaq004_27 + g_glap_d[l_idx].l_glaq004_27
               LET g_glap_d[l_ac].l_glaq004_28 = g_glap_d[l_ac].l_glaq004_28 + g_glap_d[l_idx].l_glaq004_28
               LET g_glap_d[l_ac].l_glaq004_29 = g_glap_d[l_ac].l_glaq004_29 + g_glap_d[l_idx].l_glaq004_29
               LET g_glap_d[l_ac].l_glaq004_30 = g_glap_d[l_ac].l_glaq004_30 + g_glap_d[l_idx].l_glaq004_30                                        
            END IF
         END FOR 
         CALL aglq320_reset(l_ac,'2') 
         LET g_glap_d[l_ac].l_amt = g_glap_d[l_ac-1].l_amt           
         IF cl_null(g_glap_d[l_ac].l_amt) THEN LET g_glap_d[l_ac].l_amt = 0 END IF
         CASE 
            WHEN g_glap_d[l_ac].l_amt > 0  
               CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #借  
            WHEN g_glap_d[l_ac].l_amt < 0 
               CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #貸
            WHEN g_glap_d[l_ac].l_amt = 0
               CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #平
         END CASE         
         LET l_ac = l_ac +1    
         #本年累計            
         LET g_glap_d[l_ac].glap002 = ''           
         LET g_glap_d[l_ac].glap004 = ''
         LET g_glap_d[l_ac].glapdocdt = ''
         LET g_glap_d[l_ac].glapdocno = '' 
         LET g_glap_d[l_ac].l_glaq001 = s_desc_gzcbl004_desc('9927','3')
         LET g_glap_d[l_ac].l_glaq005 = ''
         LET g_glap_d[l_ac].l_glaq010 = ''
         LET g_glap_d[l_ac].l_glaq006 = ''
         CALL aglq320_reset(l_ac,'1')
         # 本期累計+上次本年累計
         IF l_glap002_t <> g_glap_d[l_m].glap002 THEN
            LET g_glap_d[l_ac].l_glaq003_1  = g_glap_d[l_ac-1].l_glaq003_1  
            LET g_glap_d[l_ac].l_glaq003_2  = g_glap_d[l_ac-1].l_glaq003_2  
            LET g_glap_d[l_ac].l_glaq003_3  = g_glap_d[l_ac-1].l_glaq003_3  
            LET g_glap_d[l_ac].l_glaq003_4  = g_glap_d[l_ac-1].l_glaq003_4  
            LET g_glap_d[l_ac].l_glaq003_5  = g_glap_d[l_ac-1].l_glaq003_5  
            LET g_glap_d[l_ac].l_glaq003_6  = g_glap_d[l_ac-1].l_glaq003_6  
            LET g_glap_d[l_ac].l_glaq003_7  = g_glap_d[l_ac-1].l_glaq003_7  
            LET g_glap_d[l_ac].l_glaq003_8  = g_glap_d[l_ac-1].l_glaq003_8  
            LET g_glap_d[l_ac].l_glaq003_9  = g_glap_d[l_ac-1].l_glaq003_9  
            LET g_glap_d[l_ac].l_glaq003_10 = g_glap_d[l_ac-1].l_glaq003_10 
            LET g_glap_d[l_ac].l_glaq003_11 = g_glap_d[l_ac-1].l_glaq003_11 
            LET g_glap_d[l_ac].l_glaq003_12 = g_glap_d[l_ac-1].l_glaq003_12 
            LET g_glap_d[l_ac].l_glaq003_13 = g_glap_d[l_ac-1].l_glaq003_13 
            LET g_glap_d[l_ac].l_glaq003_14 = g_glap_d[l_ac-1].l_glaq003_14 
            LET g_glap_d[l_ac].l_glaq003_15 = g_glap_d[l_ac-1].l_glaq003_15 
            LET g_glap_d[l_ac].l_glaq003_16 = g_glap_d[l_ac-1].l_glaq003_16 
            LET g_glap_d[l_ac].l_glaq003_17 = g_glap_d[l_ac-1].l_glaq003_17 
            LET g_glap_d[l_ac].l_glaq003_18 = g_glap_d[l_ac-1].l_glaq003_18 
            LET g_glap_d[l_ac].l_glaq003_19 = g_glap_d[l_ac-1].l_glaq003_19 
            LET g_glap_d[l_ac].l_glaq003_20 = g_glap_d[l_ac-1].l_glaq003_20 
            LET g_glap_d[l_ac].l_glaq003_21 = g_glap_d[l_ac-1].l_glaq003_21 
            LET g_glap_d[l_ac].l_glaq003_22 = g_glap_d[l_ac-1].l_glaq003_22 
            LET g_glap_d[l_ac].l_glaq003_23 = g_glap_d[l_ac-1].l_glaq003_23 
            LET g_glap_d[l_ac].l_glaq003_24 = g_glap_d[l_ac-1].l_glaq003_24 
            LET g_glap_d[l_ac].l_glaq003_25 = g_glap_d[l_ac-1].l_glaq003_25 
            LET g_glap_d[l_ac].l_glaq003_26 = g_glap_d[l_ac-1].l_glaq003_26 
            LET g_glap_d[l_ac].l_glaq003_27 = g_glap_d[l_ac-1].l_glaq003_27 
            LET g_glap_d[l_ac].l_glaq003_28 = g_glap_d[l_ac-1].l_glaq003_28 
            LET g_glap_d[l_ac].l_glaq003_29 = g_glap_d[l_ac-1].l_glaq003_29 
            LET g_glap_d[l_ac].l_glaq003_30 = g_glap_d[l_ac-1].l_glaq003_30
            
            LET g_glap_d[l_ac].l_glaq004_1  = g_glap_d[l_ac-1].l_glaq004_1  
            LET g_glap_d[l_ac].l_glaq004_2  = g_glap_d[l_ac-1].l_glaq004_2  
            LET g_glap_d[l_ac].l_glaq004_3  = g_glap_d[l_ac-1].l_glaq004_3  
            LET g_glap_d[l_ac].l_glaq004_4  = g_glap_d[l_ac-1].l_glaq004_4  
            LET g_glap_d[l_ac].l_glaq004_5  = g_glap_d[l_ac-1].l_glaq004_5  
            LET g_glap_d[l_ac].l_glaq004_6  = g_glap_d[l_ac-1].l_glaq004_6  
            LET g_glap_d[l_ac].l_glaq004_7  = g_glap_d[l_ac-1].l_glaq004_7  
            LET g_glap_d[l_ac].l_glaq004_8  = g_glap_d[l_ac-1].l_glaq004_8  
            LET g_glap_d[l_ac].l_glaq004_9  = g_glap_d[l_ac-1].l_glaq004_9  
            LET g_glap_d[l_ac].l_glaq004_10 = g_glap_d[l_ac-1].l_glaq004_10 
            LET g_glap_d[l_ac].l_glaq004_11 = g_glap_d[l_ac-1].l_glaq004_11 
            LET g_glap_d[l_ac].l_glaq004_12 = g_glap_d[l_ac-1].l_glaq004_12 
            LET g_glap_d[l_ac].l_glaq004_13 = g_glap_d[l_ac-1].l_glaq004_13 
            LET g_glap_d[l_ac].l_glaq004_14 = g_glap_d[l_ac-1].l_glaq004_14 
            LET g_glap_d[l_ac].l_glaq004_15 = g_glap_d[l_ac-1].l_glaq004_15 
            LET g_glap_d[l_ac].l_glaq004_16 = g_glap_d[l_ac-1].l_glaq004_16 
            LET g_glap_d[l_ac].l_glaq004_17 = g_glap_d[l_ac-1].l_glaq004_17 
            LET g_glap_d[l_ac].l_glaq004_18 = g_glap_d[l_ac-1].l_glaq004_18 
            LET g_glap_d[l_ac].l_glaq004_19 = g_glap_d[l_ac-1].l_glaq004_19 
            LET g_glap_d[l_ac].l_glaq004_20 = g_glap_d[l_ac-1].l_glaq004_20 
            LET g_glap_d[l_ac].l_glaq004_21 = g_glap_d[l_ac-1].l_glaq004_21 
            LET g_glap_d[l_ac].l_glaq004_22 = g_glap_d[l_ac-1].l_glaq004_22 
            LET g_glap_d[l_ac].l_glaq004_23 = g_glap_d[l_ac-1].l_glaq004_23 
            LET g_glap_d[l_ac].l_glaq004_24 = g_glap_d[l_ac-1].l_glaq004_24 
            LET g_glap_d[l_ac].l_glaq004_25 = g_glap_d[l_ac-1].l_glaq004_25 
            LET g_glap_d[l_ac].l_glaq004_26 = g_glap_d[l_ac-1].l_glaq004_26 
            LET g_glap_d[l_ac].l_glaq004_27 = g_glap_d[l_ac-1].l_glaq004_27 
            LET g_glap_d[l_ac].l_glaq004_28 = g_glap_d[l_ac-1].l_glaq004_28 
            LET g_glap_d[l_ac].l_glaq004_29 = g_glap_d[l_ac-1].l_glaq004_29 
            LET g_glap_d[l_ac].l_glaq004_30 = g_glap_d[l_ac-1].l_glaq004_30        
         ELSE         
            LET g_glap_d[l_ac].l_glaq003_1  = g_glap_d[l_ac-1].l_glaq003_1  + g_glap_d[l_y].l_glaq003_1 
            LET g_glap_d[l_ac].l_glaq003_2  = g_glap_d[l_ac-1].l_glaq003_2  + g_glap_d[l_y].l_glaq003_2 
            LET g_glap_d[l_ac].l_glaq003_3  = g_glap_d[l_ac-1].l_glaq003_3  + g_glap_d[l_y].l_glaq003_3 
            LET g_glap_d[l_ac].l_glaq003_4  = g_glap_d[l_ac-1].l_glaq003_4  + g_glap_d[l_y].l_glaq003_4 
            LET g_glap_d[l_ac].l_glaq003_5  = g_glap_d[l_ac-1].l_glaq003_5  + g_glap_d[l_y].l_glaq003_5 
            LET g_glap_d[l_ac].l_glaq003_6  = g_glap_d[l_ac-1].l_glaq003_6  + g_glap_d[l_y].l_glaq003_6 
            LET g_glap_d[l_ac].l_glaq003_7  = g_glap_d[l_ac-1].l_glaq003_7  + g_glap_d[l_y].l_glaq003_7 
            LET g_glap_d[l_ac].l_glaq003_8  = g_glap_d[l_ac-1].l_glaq003_8  + g_glap_d[l_y].l_glaq003_8 
            LET g_glap_d[l_ac].l_glaq003_9  = g_glap_d[l_ac-1].l_glaq003_9  + g_glap_d[l_y].l_glaq003_9 
            LET g_glap_d[l_ac].l_glaq003_10 = g_glap_d[l_ac-1].l_glaq003_10 + g_glap_d[l_y].l_glaq003_10
            LET g_glap_d[l_ac].l_glaq003_11 = g_glap_d[l_ac-1].l_glaq003_11 + g_glap_d[l_y].l_glaq003_11
            LET g_glap_d[l_ac].l_glaq003_12 = g_glap_d[l_ac-1].l_glaq003_12 + g_glap_d[l_y].l_glaq003_12
            LET g_glap_d[l_ac].l_glaq003_13 = g_glap_d[l_ac-1].l_glaq003_13 + g_glap_d[l_y].l_glaq003_13
            LET g_glap_d[l_ac].l_glaq003_14 = g_glap_d[l_ac-1].l_glaq003_14 + g_glap_d[l_y].l_glaq003_14
            LET g_glap_d[l_ac].l_glaq003_15 = g_glap_d[l_ac-1].l_glaq003_15 + g_glap_d[l_y].l_glaq003_15
            LET g_glap_d[l_ac].l_glaq003_16 = g_glap_d[l_ac-1].l_glaq003_16 + g_glap_d[l_y].l_glaq003_16
            LET g_glap_d[l_ac].l_glaq003_17 = g_glap_d[l_ac-1].l_glaq003_17 + g_glap_d[l_y].l_glaq003_17
            LET g_glap_d[l_ac].l_glaq003_18 = g_glap_d[l_ac-1].l_glaq003_18 + g_glap_d[l_y].l_glaq003_18
            LET g_glap_d[l_ac].l_glaq003_19 = g_glap_d[l_ac-1].l_glaq003_19 + g_glap_d[l_y].l_glaq003_19
            LET g_glap_d[l_ac].l_glaq003_20 = g_glap_d[l_ac-1].l_glaq003_20 + g_glap_d[l_y].l_glaq003_20
            LET g_glap_d[l_ac].l_glaq003_21 = g_glap_d[l_ac-1].l_glaq003_21 + g_glap_d[l_y].l_glaq003_21
            LET g_glap_d[l_ac].l_glaq003_22 = g_glap_d[l_ac-1].l_glaq003_22 + g_glap_d[l_y].l_glaq003_22
            LET g_glap_d[l_ac].l_glaq003_23 = g_glap_d[l_ac-1].l_glaq003_23 + g_glap_d[l_y].l_glaq003_23
            LET g_glap_d[l_ac].l_glaq003_24 = g_glap_d[l_ac-1].l_glaq003_24 + g_glap_d[l_y].l_glaq003_24
            LET g_glap_d[l_ac].l_glaq003_25 = g_glap_d[l_ac-1].l_glaq003_25 + g_glap_d[l_y].l_glaq003_25
            LET g_glap_d[l_ac].l_glaq003_26 = g_glap_d[l_ac-1].l_glaq003_26 + g_glap_d[l_y].l_glaq003_26
            LET g_glap_d[l_ac].l_glaq003_27 = g_glap_d[l_ac-1].l_glaq003_27 + g_glap_d[l_y].l_glaq003_27
            LET g_glap_d[l_ac].l_glaq003_28 = g_glap_d[l_ac-1].l_glaq003_28 + g_glap_d[l_y].l_glaq003_28
            LET g_glap_d[l_ac].l_glaq003_29 = g_glap_d[l_ac-1].l_glaq003_29 + g_glap_d[l_y].l_glaq003_29
            LET g_glap_d[l_ac].l_glaq003_30 = g_glap_d[l_ac-1].l_glaq003_30 + g_glap_d[l_y].l_glaq003_30
         
            LET g_glap_d[l_ac].l_glaq004_1  = g_glap_d[l_ac-1].l_glaq004_1  + g_glap_d[l_y].l_glaq004_1 
            LET g_glap_d[l_ac].l_glaq004_2  = g_glap_d[l_ac-1].l_glaq004_2  + g_glap_d[l_y].l_glaq004_2 
            LET g_glap_d[l_ac].l_glaq004_3  = g_glap_d[l_ac-1].l_glaq004_3  + g_glap_d[l_y].l_glaq004_3 
            LET g_glap_d[l_ac].l_glaq004_4  = g_glap_d[l_ac-1].l_glaq004_4  + g_glap_d[l_y].l_glaq004_4 
            LET g_glap_d[l_ac].l_glaq004_5  = g_glap_d[l_ac-1].l_glaq004_5  + g_glap_d[l_y].l_glaq004_5 
            LET g_glap_d[l_ac].l_glaq004_6  = g_glap_d[l_ac-1].l_glaq004_6  + g_glap_d[l_y].l_glaq004_6 
            LET g_glap_d[l_ac].l_glaq004_7  = g_glap_d[l_ac-1].l_glaq004_7  + g_glap_d[l_y].l_glaq004_7 
            LET g_glap_d[l_ac].l_glaq004_8  = g_glap_d[l_ac-1].l_glaq004_8  + g_glap_d[l_y].l_glaq004_8 
            LET g_glap_d[l_ac].l_glaq004_9  = g_glap_d[l_ac-1].l_glaq004_9  + g_glap_d[l_y].l_glaq004_9 
            LET g_glap_d[l_ac].l_glaq004_10 = g_glap_d[l_ac-1].l_glaq004_10 + g_glap_d[l_y].l_glaq004_10
            LET g_glap_d[l_ac].l_glaq004_11 = g_glap_d[l_ac-1].l_glaq004_11 + g_glap_d[l_y].l_glaq004_11
            LET g_glap_d[l_ac].l_glaq004_12 = g_glap_d[l_ac-1].l_glaq004_12 + g_glap_d[l_y].l_glaq004_12
            LET g_glap_d[l_ac].l_glaq004_13 = g_glap_d[l_ac-1].l_glaq004_13 + g_glap_d[l_y].l_glaq004_13
            LET g_glap_d[l_ac].l_glaq004_14 = g_glap_d[l_ac-1].l_glaq004_14 + g_glap_d[l_y].l_glaq004_14
            LET g_glap_d[l_ac].l_glaq004_15 = g_glap_d[l_ac-1].l_glaq004_15 + g_glap_d[l_y].l_glaq004_15
            LET g_glap_d[l_ac].l_glaq004_16 = g_glap_d[l_ac-1].l_glaq004_16 + g_glap_d[l_y].l_glaq004_16
            LET g_glap_d[l_ac].l_glaq004_17 = g_glap_d[l_ac-1].l_glaq004_17 + g_glap_d[l_y].l_glaq004_17
            LET g_glap_d[l_ac].l_glaq004_18 = g_glap_d[l_ac-1].l_glaq004_18 + g_glap_d[l_y].l_glaq004_18
            LET g_glap_d[l_ac].l_glaq004_19 = g_glap_d[l_ac-1].l_glaq004_19 + g_glap_d[l_y].l_glaq004_19
            LET g_glap_d[l_ac].l_glaq004_20 = g_glap_d[l_ac-1].l_glaq004_20 + g_glap_d[l_y].l_glaq004_20
            LET g_glap_d[l_ac].l_glaq004_21 = g_glap_d[l_ac-1].l_glaq004_21 + g_glap_d[l_y].l_glaq004_21
            LET g_glap_d[l_ac].l_glaq004_22 = g_glap_d[l_ac-1].l_glaq004_22 + g_glap_d[l_y].l_glaq004_22
            LET g_glap_d[l_ac].l_glaq004_23 = g_glap_d[l_ac-1].l_glaq004_23 + g_glap_d[l_y].l_glaq004_23
            LET g_glap_d[l_ac].l_glaq004_24 = g_glap_d[l_ac-1].l_glaq004_24 + g_glap_d[l_y].l_glaq004_24
            LET g_glap_d[l_ac].l_glaq004_25 = g_glap_d[l_ac-1].l_glaq004_25 + g_glap_d[l_y].l_glaq004_25
            LET g_glap_d[l_ac].l_glaq004_26 = g_glap_d[l_ac-1].l_glaq004_26 + g_glap_d[l_y].l_glaq004_26
            LET g_glap_d[l_ac].l_glaq004_27 = g_glap_d[l_ac-1].l_glaq004_27 + g_glap_d[l_y].l_glaq004_27
            LET g_glap_d[l_ac].l_glaq004_28 = g_glap_d[l_ac-1].l_glaq004_28 + g_glap_d[l_y].l_glaq004_28
            LET g_glap_d[l_ac].l_glaq004_29 = g_glap_d[l_ac-1].l_glaq004_29 + g_glap_d[l_y].l_glaq004_29
            LET g_glap_d[l_ac].l_glaq004_30 = g_glap_d[l_ac-1].l_glaq004_30 + g_glap_d[l_y].l_glaq004_30
         END IF
         #紀錄本年累計所在的位置
         LET l_y = l_ac                 
         CALL aglq320_reset(l_ac,'2')  
         #本年累計餘額
         LET g_glap_d[l_ac].l_amt = g_glap_d[l_ac-1].l_amt
         IF cl_null(g_glap_d[l_ac].l_amt) THEN LET g_glap_d[l_ac].l_amt = 0 END IF
         CASE 
            WHEN g_glap_d[l_ac].l_amt > 0  
               CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #借  
            WHEN g_glap_d[l_ac].l_amt < 0 
               CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #貸
            WHEN g_glap_d[l_ac].l_amt = 0
               CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #平
         END CASE   
         LET l_ac = l_ac +1  
         LET l_m = l_ac-3
      END IF
      
      LET l_glap004_t = g_glap_d[l_ac].glap004      
      LET l_glap[l_ac].idx     = l_ac
      LET l_glap[l_ac].glap004 = g_glap_d[l_ac].glap004 
      
      LET l_ac = l_ac +1
      
   END FOREACH
   
   CALL g_glap_d.deleteElement(g_glap_d.getLength())
  
   IF l_ac > 1 THEN #本期合計     
      LET l_glap002_t = g_glap_d[l_ac-1].glap002 #紀錄本期年度
      INITIALIZE g_glap_d[l_ac].* TO NULL
      LET g_glap_d[l_ac].l_glaq001 = s_desc_gzcbl004_desc('9927','2')
      CALL aglq320_reset(l_ac,'1')  
      FOR l_idx = 1 TO l_glap.getLength() 
         IF l_glap004_t = l_glap[l_idx].glap004  THEN                   
            LET g_glap_d[l_ac].l_glaq003_1  = g_glap_d[l_ac].l_glaq003_1  + g_glap_d[l_idx].l_glaq003_1 
            LET g_glap_d[l_ac].l_glaq003_2  = g_glap_d[l_ac].l_glaq003_2  + g_glap_d[l_idx].l_glaq003_2 
            LET g_glap_d[l_ac].l_glaq003_3  = g_glap_d[l_ac].l_glaq003_3  + g_glap_d[l_idx].l_glaq003_3 
            LET g_glap_d[l_ac].l_glaq003_4  = g_glap_d[l_ac].l_glaq003_4  + g_glap_d[l_idx].l_glaq003_4 
            LET g_glap_d[l_ac].l_glaq003_5  = g_glap_d[l_ac].l_glaq003_5  + g_glap_d[l_idx].l_glaq003_5 
            LET g_glap_d[l_ac].l_glaq003_6  = g_glap_d[l_ac].l_glaq003_6  + g_glap_d[l_idx].l_glaq003_6 
            LET g_glap_d[l_ac].l_glaq003_7  = g_glap_d[l_ac].l_glaq003_7  + g_glap_d[l_idx].l_glaq003_7 
            LET g_glap_d[l_ac].l_glaq003_8  = g_glap_d[l_ac].l_glaq003_8  + g_glap_d[l_idx].l_glaq003_8 
            LET g_glap_d[l_ac].l_glaq003_9  = g_glap_d[l_ac].l_glaq003_9  + g_glap_d[l_idx].l_glaq003_9 
            LET g_glap_d[l_ac].l_glaq003_10 = g_glap_d[l_ac].l_glaq003_10 + g_glap_d[l_idx].l_glaq003_15
            LET g_glap_d[l_ac].l_glaq003_11 = g_glap_d[l_ac].l_glaq003_11 + g_glap_d[l_idx].l_glaq003_11
            LET g_glap_d[l_ac].l_glaq003_12 = g_glap_d[l_ac].l_glaq003_12 + g_glap_d[l_idx].l_glaq003_12
            LET g_glap_d[l_ac].l_glaq003_13 = g_glap_d[l_ac].l_glaq003_13 + g_glap_d[l_idx].l_glaq003_13
            LET g_glap_d[l_ac].l_glaq003_14 = g_glap_d[l_ac].l_glaq003_14 + g_glap_d[l_idx].l_glaq003_14
            LET g_glap_d[l_ac].l_glaq003_15 = g_glap_d[l_ac].l_glaq003_15 + g_glap_d[l_idx].l_glaq003_15
            LET g_glap_d[l_ac].l_glaq003_16 = g_glap_d[l_ac].l_glaq003_16 + g_glap_d[l_idx].l_glaq003_16
            LET g_glap_d[l_ac].l_glaq003_17 = g_glap_d[l_ac].l_glaq003_17 + g_glap_d[l_idx].l_glaq003_17
            LET g_glap_d[l_ac].l_glaq003_18 = g_glap_d[l_ac].l_glaq003_18 + g_glap_d[l_idx].l_glaq003_18
            LET g_glap_d[l_ac].l_glaq003_19 = g_glap_d[l_ac].l_glaq003_19 + g_glap_d[l_idx].l_glaq003_19
            LET g_glap_d[l_ac].l_glaq003_20 = g_glap_d[l_ac].l_glaq003_20 + g_glap_d[l_idx].l_glaq003_20
            LET g_glap_d[l_ac].l_glaq003_21 = g_glap_d[l_ac].l_glaq003_21 + g_glap_d[l_idx].l_glaq003_21
            LET g_glap_d[l_ac].l_glaq003_22 = g_glap_d[l_ac].l_glaq003_22 + g_glap_d[l_idx].l_glaq003_22
            LET g_glap_d[l_ac].l_glaq003_23 = g_glap_d[l_ac].l_glaq003_23 + g_glap_d[l_idx].l_glaq003_23
            LET g_glap_d[l_ac].l_glaq003_24 = g_glap_d[l_ac].l_glaq003_24 + g_glap_d[l_idx].l_glaq003_24
            LET g_glap_d[l_ac].l_glaq003_25 = g_glap_d[l_ac].l_glaq003_25 + g_glap_d[l_idx].l_glaq003_25
            LET g_glap_d[l_ac].l_glaq003_26 = g_glap_d[l_ac].l_glaq003_26 + g_glap_d[l_idx].l_glaq003_26
            LET g_glap_d[l_ac].l_glaq003_27 = g_glap_d[l_ac].l_glaq003_27 + g_glap_d[l_idx].l_glaq003_27
            LET g_glap_d[l_ac].l_glaq003_28 = g_glap_d[l_ac].l_glaq003_28 + g_glap_d[l_idx].l_glaq003_28
            LET g_glap_d[l_ac].l_glaq003_29 = g_glap_d[l_ac].l_glaq003_29 + g_glap_d[l_idx].l_glaq003_29
            LET g_glap_d[l_ac].l_glaq003_30 = g_glap_d[l_ac].l_glaq003_30 + g_glap_d[l_idx].l_glaq003_30
            
            LET g_glap_d[l_ac].l_glaq004_1  = g_glap_d[l_ac].l_glaq004_1  + g_glap_d[l_idx].l_glaq004_1 
            LET g_glap_d[l_ac].l_glaq004_2  = g_glap_d[l_ac].l_glaq004_2  + g_glap_d[l_idx].l_glaq004_2 
            LET g_glap_d[l_ac].l_glaq004_3  = g_glap_d[l_ac].l_glaq004_3  + g_glap_d[l_idx].l_glaq004_3 
            LET g_glap_d[l_ac].l_glaq004_4  = g_glap_d[l_ac].l_glaq004_4  + g_glap_d[l_idx].l_glaq004_4 
            LET g_glap_d[l_ac].l_glaq004_5  = g_glap_d[l_ac].l_glaq004_5  + g_glap_d[l_idx].l_glaq004_5 
            LET g_glap_d[l_ac].l_glaq004_6  = g_glap_d[l_ac].l_glaq004_6  + g_glap_d[l_idx].l_glaq004_6 
            LET g_glap_d[l_ac].l_glaq004_7  = g_glap_d[l_ac].l_glaq004_7  + g_glap_d[l_idx].l_glaq004_7 
            LET g_glap_d[l_ac].l_glaq004_8  = g_glap_d[l_ac].l_glaq004_8  + g_glap_d[l_idx].l_glaq004_8 
            LET g_glap_d[l_ac].l_glaq004_9  = g_glap_d[l_ac].l_glaq004_9  + g_glap_d[l_idx].l_glaq004_9 
            LET g_glap_d[l_ac].l_glaq004_10 = g_glap_d[l_ac].l_glaq004_10 + g_glap_d[l_idx].l_glaq004_15
            LET g_glap_d[l_ac].l_glaq004_11 = g_glap_d[l_ac].l_glaq004_11 + g_glap_d[l_idx].l_glaq004_11
            LET g_glap_d[l_ac].l_glaq004_12 = g_glap_d[l_ac].l_glaq004_12 + g_glap_d[l_idx].l_glaq004_12
            LET g_glap_d[l_ac].l_glaq004_13 = g_glap_d[l_ac].l_glaq004_13 + g_glap_d[l_idx].l_glaq004_13
            LET g_glap_d[l_ac].l_glaq004_14 = g_glap_d[l_ac].l_glaq004_14 + g_glap_d[l_idx].l_glaq004_14
            LET g_glap_d[l_ac].l_glaq004_15 = g_glap_d[l_ac].l_glaq004_15 + g_glap_d[l_idx].l_glaq004_15
            LET g_glap_d[l_ac].l_glaq004_16 = g_glap_d[l_ac].l_glaq004_16 + g_glap_d[l_idx].l_glaq004_16
            LET g_glap_d[l_ac].l_glaq004_17 = g_glap_d[l_ac].l_glaq004_17 + g_glap_d[l_idx].l_glaq004_17
            LET g_glap_d[l_ac].l_glaq004_18 = g_glap_d[l_ac].l_glaq004_18 + g_glap_d[l_idx].l_glaq004_18
            LET g_glap_d[l_ac].l_glaq004_19 = g_glap_d[l_ac].l_glaq004_19 + g_glap_d[l_idx].l_glaq004_19
            LET g_glap_d[l_ac].l_glaq004_20 = g_glap_d[l_ac].l_glaq004_20 + g_glap_d[l_idx].l_glaq004_20
            LET g_glap_d[l_ac].l_glaq004_21 = g_glap_d[l_ac].l_glaq004_21 + g_glap_d[l_idx].l_glaq004_21
            LET g_glap_d[l_ac].l_glaq004_22 = g_glap_d[l_ac].l_glaq004_22 + g_glap_d[l_idx].l_glaq004_22
            LET g_glap_d[l_ac].l_glaq004_23 = g_glap_d[l_ac].l_glaq004_23 + g_glap_d[l_idx].l_glaq004_23
            LET g_glap_d[l_ac].l_glaq004_24 = g_glap_d[l_ac].l_glaq004_24 + g_glap_d[l_idx].l_glaq004_24
            LET g_glap_d[l_ac].l_glaq004_25 = g_glap_d[l_ac].l_glaq004_25 + g_glap_d[l_idx].l_glaq004_25
            LET g_glap_d[l_ac].l_glaq004_26 = g_glap_d[l_ac].l_glaq004_26 + g_glap_d[l_idx].l_glaq004_26
            LET g_glap_d[l_ac].l_glaq004_27 = g_glap_d[l_ac].l_glaq004_27 + g_glap_d[l_idx].l_glaq004_27
            LET g_glap_d[l_ac].l_glaq004_28 = g_glap_d[l_ac].l_glaq004_28 + g_glap_d[l_idx].l_glaq004_28
            LET g_glap_d[l_ac].l_glaq004_29 = g_glap_d[l_ac].l_glaq004_29 + g_glap_d[l_idx].l_glaq004_29
            LET g_glap_d[l_ac].l_glaq004_30 = g_glap_d[l_ac].l_glaq004_30 + g_glap_d[l_idx].l_glaq004_30
            
         END IF            
      END FOR
      
      CALL aglq320_reset(l_ac,'2')    
      LET g_glap_d[l_ac].l_amt = g_glap_d[l_ac-1].l_amt  
      IF cl_null(g_glap_d[l_ac].l_amt) THEN LET g_glap_d[l_ac].l_amt = 0 END IF
      CASE 
         WHEN g_glap_d[l_ac].l_amt > 0  
            CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #借  
         WHEN g_glap_d[l_ac].l_amt < 0 
            CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #貸
         WHEN g_glap_d[l_ac].l_amt = 0
            CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #平
      END CASE      
      #本年合計
      LET l_ac = l_ac +1
      LET g_glap_d[l_ac].glap002 = ''
      LET g_glap_d[l_ac].glap004 = ''
      LET g_glap_d[l_ac].glapdocdt = ''
      LET g_glap_d[l_ac].glapdocno = '' 
      LET g_glap_d[l_ac].l_glaq001 = s_desc_gzcbl004_desc('9927','3')
      LET g_glap_d[l_ac].l_glaq005 = ''
      LET g_glap_d[l_ac].l_glaq010 = ''
      LET g_glap_d[l_ac].l_glaq006 = ''
      CALL aglq320_reset(l_ac,'1')
      IF l_glap002_t <> g_glap_d[l_m].glap002 THEN
         LET g_glap_d[l_ac].l_glaq003_1  = g_glap_d[l_ac-1].l_glaq003_1  
         LET g_glap_d[l_ac].l_glaq003_2  = g_glap_d[l_ac-1].l_glaq003_2  
         LET g_glap_d[l_ac].l_glaq003_3  = g_glap_d[l_ac-1].l_glaq003_3  
         LET g_glap_d[l_ac].l_glaq003_4  = g_glap_d[l_ac-1].l_glaq003_4  
         LET g_glap_d[l_ac].l_glaq003_5  = g_glap_d[l_ac-1].l_glaq003_5  
         LET g_glap_d[l_ac].l_glaq003_6  = g_glap_d[l_ac-1].l_glaq003_6  
         LET g_glap_d[l_ac].l_glaq003_7  = g_glap_d[l_ac-1].l_glaq003_7  
         LET g_glap_d[l_ac].l_glaq003_8  = g_glap_d[l_ac-1].l_glaq003_8  
         LET g_glap_d[l_ac].l_glaq003_9  = g_glap_d[l_ac-1].l_glaq003_9  
         LET g_glap_d[l_ac].l_glaq003_10 = g_glap_d[l_ac-1].l_glaq003_10 
         LET g_glap_d[l_ac].l_glaq003_11 = g_glap_d[l_ac-1].l_glaq003_11 
         LET g_glap_d[l_ac].l_glaq003_12 = g_glap_d[l_ac-1].l_glaq003_12 
         LET g_glap_d[l_ac].l_glaq003_13 = g_glap_d[l_ac-1].l_glaq003_13 
         LET g_glap_d[l_ac].l_glaq003_14 = g_glap_d[l_ac-1].l_glaq003_14 
         LET g_glap_d[l_ac].l_glaq003_15 = g_glap_d[l_ac-1].l_glaq003_15 
         LET g_glap_d[l_ac].l_glaq003_16 = g_glap_d[l_ac-1].l_glaq003_16 
         LET g_glap_d[l_ac].l_glaq003_17 = g_glap_d[l_ac-1].l_glaq003_17 
         LET g_glap_d[l_ac].l_glaq003_18 = g_glap_d[l_ac-1].l_glaq003_18 
         LET g_glap_d[l_ac].l_glaq003_19 = g_glap_d[l_ac-1].l_glaq003_19 
         LET g_glap_d[l_ac].l_glaq003_20 = g_glap_d[l_ac-1].l_glaq003_20 
         LET g_glap_d[l_ac].l_glaq003_21 = g_glap_d[l_ac-1].l_glaq003_21 
         LET g_glap_d[l_ac].l_glaq003_22 = g_glap_d[l_ac-1].l_glaq003_22 
         LET g_glap_d[l_ac].l_glaq003_23 = g_glap_d[l_ac-1].l_glaq003_23 
         LET g_glap_d[l_ac].l_glaq003_24 = g_glap_d[l_ac-1].l_glaq003_24 
         LET g_glap_d[l_ac].l_glaq003_25 = g_glap_d[l_ac-1].l_glaq003_25 
         LET g_glap_d[l_ac].l_glaq003_26 = g_glap_d[l_ac-1].l_glaq003_26 
         LET g_glap_d[l_ac].l_glaq003_27 = g_glap_d[l_ac-1].l_glaq003_27 
         LET g_glap_d[l_ac].l_glaq003_28 = g_glap_d[l_ac-1].l_glaq003_28 
         LET g_glap_d[l_ac].l_glaq003_29 = g_glap_d[l_ac-1].l_glaq003_29 
         LET g_glap_d[l_ac].l_glaq003_30 = g_glap_d[l_ac-1].l_glaq003_30
         
         LET g_glap_d[l_ac].l_glaq004_1  = g_glap_d[l_ac-1].l_glaq004_1  
         LET g_glap_d[l_ac].l_glaq004_2  = g_glap_d[l_ac-1].l_glaq004_2  
         LET g_glap_d[l_ac].l_glaq004_3  = g_glap_d[l_ac-1].l_glaq004_3  
         LET g_glap_d[l_ac].l_glaq004_4  = g_glap_d[l_ac-1].l_glaq004_4  
         LET g_glap_d[l_ac].l_glaq004_5  = g_glap_d[l_ac-1].l_glaq004_5  
         LET g_glap_d[l_ac].l_glaq004_6  = g_glap_d[l_ac-1].l_glaq004_6  
         LET g_glap_d[l_ac].l_glaq004_7  = g_glap_d[l_ac-1].l_glaq004_7  
         LET g_glap_d[l_ac].l_glaq004_8  = g_glap_d[l_ac-1].l_glaq004_8  
         LET g_glap_d[l_ac].l_glaq004_9  = g_glap_d[l_ac-1].l_glaq004_9  
         LET g_glap_d[l_ac].l_glaq004_10 = g_glap_d[l_ac-1].l_glaq004_10 
         LET g_glap_d[l_ac].l_glaq004_11 = g_glap_d[l_ac-1].l_glaq004_11 
         LET g_glap_d[l_ac].l_glaq004_12 = g_glap_d[l_ac-1].l_glaq004_12 
         LET g_glap_d[l_ac].l_glaq004_13 = g_glap_d[l_ac-1].l_glaq004_13 
         LET g_glap_d[l_ac].l_glaq004_14 = g_glap_d[l_ac-1].l_glaq004_14 
         LET g_glap_d[l_ac].l_glaq004_15 = g_glap_d[l_ac-1].l_glaq004_15 
         LET g_glap_d[l_ac].l_glaq004_16 = g_glap_d[l_ac-1].l_glaq004_16 
         LET g_glap_d[l_ac].l_glaq004_17 = g_glap_d[l_ac-1].l_glaq004_17 
         LET g_glap_d[l_ac].l_glaq004_18 = g_glap_d[l_ac-1].l_glaq004_18 
         LET g_glap_d[l_ac].l_glaq004_19 = g_glap_d[l_ac-1].l_glaq004_19 
         LET g_glap_d[l_ac].l_glaq004_20 = g_glap_d[l_ac-1].l_glaq004_20 
         LET g_glap_d[l_ac].l_glaq004_21 = g_glap_d[l_ac-1].l_glaq004_21 
         LET g_glap_d[l_ac].l_glaq004_22 = g_glap_d[l_ac-1].l_glaq004_22 
         LET g_glap_d[l_ac].l_glaq004_23 = g_glap_d[l_ac-1].l_glaq004_23 
         LET g_glap_d[l_ac].l_glaq004_24 = g_glap_d[l_ac-1].l_glaq004_24 
         LET g_glap_d[l_ac].l_glaq004_25 = g_glap_d[l_ac-1].l_glaq004_25 
         LET g_glap_d[l_ac].l_glaq004_26 = g_glap_d[l_ac-1].l_glaq004_26 
         LET g_glap_d[l_ac].l_glaq004_27 = g_glap_d[l_ac-1].l_glaq004_27 
         LET g_glap_d[l_ac].l_glaq004_28 = g_glap_d[l_ac-1].l_glaq004_28 
         LET g_glap_d[l_ac].l_glaq004_29 = g_glap_d[l_ac-1].l_glaq004_29 
         LET g_glap_d[l_ac].l_glaq004_30 = g_glap_d[l_ac-1].l_glaq004_30        
      ELSE         
         LET g_glap_d[l_ac].l_glaq003_1  = g_glap_d[l_ac-1].l_glaq003_1  +  g_glap_d[l_y].l_glaq003_1 
         LET g_glap_d[l_ac].l_glaq003_2  = g_glap_d[l_ac-1].l_glaq003_2  +  g_glap_d[l_y].l_glaq003_2 
         LET g_glap_d[l_ac].l_glaq003_3  = g_glap_d[l_ac-1].l_glaq003_3  +  g_glap_d[l_y].l_glaq003_3 
         LET g_glap_d[l_ac].l_glaq003_4  = g_glap_d[l_ac-1].l_glaq003_4  +  g_glap_d[l_y].l_glaq003_4 
         LET g_glap_d[l_ac].l_glaq003_5  = g_glap_d[l_ac-1].l_glaq003_5  +  g_glap_d[l_y].l_glaq003_5 
         LET g_glap_d[l_ac].l_glaq003_6  = g_glap_d[l_ac-1].l_glaq003_6  +  g_glap_d[l_y].l_glaq003_6 
         LET g_glap_d[l_ac].l_glaq003_7  = g_glap_d[l_ac-1].l_glaq003_7  +  g_glap_d[l_y].l_glaq003_7 
         LET g_glap_d[l_ac].l_glaq003_8  = g_glap_d[l_ac-1].l_glaq003_8  +  g_glap_d[l_y].l_glaq003_8 
         LET g_glap_d[l_ac].l_glaq003_9  = g_glap_d[l_ac-1].l_glaq003_9  +  g_glap_d[l_y].l_glaq003_9 
         LET g_glap_d[l_ac].l_glaq003_10 = g_glap_d[l_ac-1].l_glaq003_10 +  g_glap_d[l_y].l_glaq003_10
         LET g_glap_d[l_ac].l_glaq003_11 = g_glap_d[l_ac-1].l_glaq003_11 +  g_glap_d[l_y].l_glaq003_11
         LET g_glap_d[l_ac].l_glaq003_12 = g_glap_d[l_ac-1].l_glaq003_12 +  g_glap_d[l_y].l_glaq003_12
         LET g_glap_d[l_ac].l_glaq003_13 = g_glap_d[l_ac-1].l_glaq003_13 +  g_glap_d[l_y].l_glaq003_13
         LET g_glap_d[l_ac].l_glaq003_14 = g_glap_d[l_ac-1].l_glaq003_14 +  g_glap_d[l_y].l_glaq003_14
         LET g_glap_d[l_ac].l_glaq003_15 = g_glap_d[l_ac-1].l_glaq003_15 +  g_glap_d[l_y].l_glaq003_15
         LET g_glap_d[l_ac].l_glaq003_16 = g_glap_d[l_ac-1].l_glaq003_16 +  g_glap_d[l_y].l_glaq003_16
         LET g_glap_d[l_ac].l_glaq003_17 = g_glap_d[l_ac-1].l_glaq003_17 +  g_glap_d[l_y].l_glaq003_17
         LET g_glap_d[l_ac].l_glaq003_18 = g_glap_d[l_ac-1].l_glaq003_18 +  g_glap_d[l_y].l_glaq003_18
         LET g_glap_d[l_ac].l_glaq003_19 = g_glap_d[l_ac-1].l_glaq003_19 +  g_glap_d[l_y].l_glaq003_19
         LET g_glap_d[l_ac].l_glaq003_20 = g_glap_d[l_ac-1].l_glaq003_20 +  g_glap_d[l_y].l_glaq003_20
         LET g_glap_d[l_ac].l_glaq003_21 = g_glap_d[l_ac-1].l_glaq003_21 +  g_glap_d[l_y].l_glaq003_21
         LET g_glap_d[l_ac].l_glaq003_22 = g_glap_d[l_ac-1].l_glaq003_22 +  g_glap_d[l_y].l_glaq003_22
         LET g_glap_d[l_ac].l_glaq003_23 = g_glap_d[l_ac-1].l_glaq003_23 +  g_glap_d[l_y].l_glaq003_23
         LET g_glap_d[l_ac].l_glaq003_24 = g_glap_d[l_ac-1].l_glaq003_24 +  g_glap_d[l_y].l_glaq003_24
         LET g_glap_d[l_ac].l_glaq003_25 = g_glap_d[l_ac-1].l_glaq003_25 +  g_glap_d[l_y].l_glaq003_25
         LET g_glap_d[l_ac].l_glaq003_26 = g_glap_d[l_ac-1].l_glaq003_26 +  g_glap_d[l_y].l_glaq003_26
         LET g_glap_d[l_ac].l_glaq003_27 = g_glap_d[l_ac-1].l_glaq003_27 +  g_glap_d[l_y].l_glaq003_27
         LET g_glap_d[l_ac].l_glaq003_28 = g_glap_d[l_ac-1].l_glaq003_28 +  g_glap_d[l_y].l_glaq003_28
         LET g_glap_d[l_ac].l_glaq003_29 = g_glap_d[l_ac-1].l_glaq003_29 +  g_glap_d[l_y].l_glaq003_29
         LET g_glap_d[l_ac].l_glaq003_30 = g_glap_d[l_ac-1].l_glaq003_30 +  g_glap_d[l_y].l_glaq003_30    
         
         LET g_glap_d[l_ac].l_glaq004_1  = g_glap_d[l_ac-1].l_glaq004_1  + g_glap_d[l_y].l_glaq004_1 
         LET g_glap_d[l_ac].l_glaq004_2  = g_glap_d[l_ac-1].l_glaq004_2  + g_glap_d[l_y].l_glaq004_2 
         LET g_glap_d[l_ac].l_glaq004_3  = g_glap_d[l_ac-1].l_glaq004_3  + g_glap_d[l_y].l_glaq004_3 
         LET g_glap_d[l_ac].l_glaq004_4  = g_glap_d[l_ac-1].l_glaq004_4  + g_glap_d[l_y].l_glaq004_4 
         LET g_glap_d[l_ac].l_glaq004_5  = g_glap_d[l_ac-1].l_glaq004_5  + g_glap_d[l_y].l_glaq004_5 
         LET g_glap_d[l_ac].l_glaq004_6  = g_glap_d[l_ac-1].l_glaq004_6  + g_glap_d[l_y].l_glaq004_6 
         LET g_glap_d[l_ac].l_glaq004_7  = g_glap_d[l_ac-1].l_glaq004_7  + g_glap_d[l_y].l_glaq004_7 
         LET g_glap_d[l_ac].l_glaq004_8  = g_glap_d[l_ac-1].l_glaq004_8  + g_glap_d[l_y].l_glaq004_8 
         LET g_glap_d[l_ac].l_glaq004_9  = g_glap_d[l_ac-1].l_glaq004_9  + g_glap_d[l_y].l_glaq004_9 
         LET g_glap_d[l_ac].l_glaq004_10 = g_glap_d[l_ac-1].l_glaq004_10 + g_glap_d[l_y].l_glaq004_10
         LET g_glap_d[l_ac].l_glaq004_11 = g_glap_d[l_ac-1].l_glaq004_11 + g_glap_d[l_y].l_glaq004_11
         LET g_glap_d[l_ac].l_glaq004_12 = g_glap_d[l_ac-1].l_glaq004_12 + g_glap_d[l_y].l_glaq004_12
         LET g_glap_d[l_ac].l_glaq004_13 = g_glap_d[l_ac-1].l_glaq004_13 + g_glap_d[l_y].l_glaq004_13
         LET g_glap_d[l_ac].l_glaq004_14 = g_glap_d[l_ac-1].l_glaq004_14 + g_glap_d[l_y].l_glaq004_14
         LET g_glap_d[l_ac].l_glaq004_15 = g_glap_d[l_ac-1].l_glaq004_15 + g_glap_d[l_y].l_glaq004_15
         LET g_glap_d[l_ac].l_glaq004_16 = g_glap_d[l_ac-1].l_glaq004_16 + g_glap_d[l_y].l_glaq004_16
         LET g_glap_d[l_ac].l_glaq004_17 = g_glap_d[l_ac-1].l_glaq004_17 + g_glap_d[l_y].l_glaq004_17
         LET g_glap_d[l_ac].l_glaq004_18 = g_glap_d[l_ac-1].l_glaq004_18 + g_glap_d[l_y].l_glaq004_18
         LET g_glap_d[l_ac].l_glaq004_19 = g_glap_d[l_ac-1].l_glaq004_19 + g_glap_d[l_y].l_glaq004_19
         LET g_glap_d[l_ac].l_glaq004_20 = g_glap_d[l_ac-1].l_glaq004_20 + g_glap_d[l_y].l_glaq004_20
         LET g_glap_d[l_ac].l_glaq004_21 = g_glap_d[l_ac-1].l_glaq004_21 + g_glap_d[l_y].l_glaq004_21
         LET g_glap_d[l_ac].l_glaq004_22 = g_glap_d[l_ac-1].l_glaq004_22 + g_glap_d[l_y].l_glaq004_22
         LET g_glap_d[l_ac].l_glaq004_23 = g_glap_d[l_ac-1].l_glaq004_23 + g_glap_d[l_y].l_glaq004_23
         LET g_glap_d[l_ac].l_glaq004_24 = g_glap_d[l_ac-1].l_glaq004_24 + g_glap_d[l_y].l_glaq004_24
         LET g_glap_d[l_ac].l_glaq004_25 = g_glap_d[l_ac-1].l_glaq004_25 + g_glap_d[l_y].l_glaq004_25
         LET g_glap_d[l_ac].l_glaq004_26 = g_glap_d[l_ac-1].l_glaq004_26 + g_glap_d[l_y].l_glaq004_26
         LET g_glap_d[l_ac].l_glaq004_27 = g_glap_d[l_ac-1].l_glaq004_27 + g_glap_d[l_y].l_glaq004_27
         LET g_glap_d[l_ac].l_glaq004_28 = g_glap_d[l_ac-1].l_glaq004_28 + g_glap_d[l_y].l_glaq004_28
         LET g_glap_d[l_ac].l_glaq004_29 = g_glap_d[l_ac-1].l_glaq004_29 + g_glap_d[l_y].l_glaq004_29
         LET g_glap_d[l_ac].l_glaq004_30 = g_glap_d[l_ac-1].l_glaq004_30 + g_glap_d[l_y].l_glaq004_30
      END IF
      CALL aglq320_reset(l_ac,'2')
      LET g_glap_d[l_ac].l_amt = g_glap_d[l_ac-1].l_amt
      IF cl_null(g_glap_d[l_ac].l_amt) THEN LET g_glap_d[l_ac].l_amt = 0 END IF
      CASE 
         WHEN g_glap_d[l_ac].l_amt > 0  
            CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #借  
         WHEN g_glap_d[l_ac].l_amt < 0 
            CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #貸
         WHEN g_glap_d[l_ac].l_amt = 0
            CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d[l_ac].l_dc  #平
      END CASE      
   END IF 
   
   
   
   LET g_detail_cnt = g_glap_d.getLength()
   LET g_tot_cnt = g_glap_d.getLength()
   DISPLAY g_tot_cnt TO FORMONLY.h_count 
   DISPLAY g_current_idx TO FORMONLY.h_index     
   LET l_ac = g_cnt
   LET g_cnt = 0   


END FUNCTION

################################################################################
# Descriptions...: 填充本位幣二
# Memo...........:
# Usage..........: CALL aglq320_b_fill2()
# Date & Author..: 2015/12/28 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq320_b_fill2()
DEFINE l_sql STRING
DEFINE l_i          LIKE type_t.num5
DEFINE l_j          LIKE type_t.num5
DEFINE l_glac002    LIKE glac_t.glac002
DEFINE l_glaq003    LIKE glaq_t.glaq003
DEFINE l_glaq0031   LIKE glaq_t.glaq003
DEFINE l_glaq004    LIKE glaq_t.glaq004
DEFINE l_glaq0041   LIKE glaq_t.glaq004 
DEFINE l_glac DYNAMIC ARRAY OF RECORD
          idx       LIKE type_t.num5,   
          glac002   LIKE glac_t.glac002
   END RECORD
DEFINE l_glap DYNAMIC ARRAY OF RECORD
          idx       LIKE type_t.num5,
        glap004     LIKE glap_t.glap004          
    END RECORD        

DEFINE l_glac008    LIKE glac_t.glac008
DEFINE l_idx        LIKE type_t.num5
DEFINE l_mon        LIKE glaq_t.glaq003
DEFINE l_glaq002_t  LIKE glaq_t.glaq002
DEFINE l_glap002_t  LIKE glap_t.glap002 #年度
DEFINE l_glap002_o  LIKE glap_t.glap002
DEFINE l_glap004_t  LIKE glap_t.glap004 
DEFINE l_y          LIKE type_t.num5
DEFINE l_m          LIKE type_t.num5

   CALL g_glap_d2.clear()
   CALL l_glac.clear()
   LET l_sql = " SELECT glac002,glac008                 ",
               "  FROM glac_t                           ",
               " WHERE glacent = '",g_enterprise,"'     ",
               "   AND glac001 = '",g_glaa.glaa004,"'   ",
               "   AND glac004 = '",g_input.glaq002,"'  ",           
               " ORDER BY glac002                       "
   LET l_i = 1 LET l_j = 31
   PREPARE aglq320_set_pr03 FROM l_sql
   DECLARE aglq320_set_cs03 CURSOR FOR aglq320_set_pr03
   FOREACH aglq320_set_cs03 INTO l_glac002,l_glac008
      IF g_input.glaq002 = l_glac002 THEN CONTINUE FOREACH END IF
      IF l_glac008 = '1'  THEN     #開啟借方科目        
         LET l_glac[l_i].glac002 = l_glac002
         LET l_glac[l_i].idx = l_i
         LET l_i = l_i +1 
      ELSE #開啟貸方科目
         LET l_glac[l_j].glac002 = l_glac002
         LET l_glac[l_j].idx = l_j
         LET l_j = l_j +1 
      END IF
   END FOREACH   
                            
   LET g_sql = "  SELECT glap002,glap004,glapdocdt,glapdocno,glaq001,    ",
               "         glaq005,glaq010,glaq006,glaq040,glaq041,glaq002 ",
               "    FROM aglq320_tmp                                     ",
               "   WHERE l_flag IN ('2')                                 ",
               "   ORDER BY l_flag,glapdocdt                             "    
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1     
   LET l_i =  1
   LET l_glaq002_t =''
   LET l_glap002_t = ''
   LET l_glap002_o = ''
   LET l_glap004_t =''
   PREPARE aglq320_bfill_pb2 FROM g_sql
   DECLARE aglq320_bfill_cs2 CURSOR FOR aglq320_bfill_pb2              
   FOREACH aglq320_bfill_cs2 INTO 
      g_glap_d2[l_ac].glap002,g_glap_d2[l_ac].glap004,g_glap_d2[l_ac].glapdocdt,g_glap_d2[l_ac].glapdocno, 
      g_glap_d2[l_ac].l_glaq001,g_glap_d2[l_ac].l_glaq005,g_glap_d2[l_ac].l_glaq010,g_glap_d2[l_ac].l_glaq006,
      l_glaq003,l_glaq004,l_glac002
      IF cl_null(l_glaq003) THEN LET l_glaq003 = 0 END IF
      IF cl_null(l_glaq004) THEN LET l_glaq004 = 0 END IF
      #取得科目科餘方向
      SELECT glac008 INTO l_glac008 FROM glac_t
       WHERE glacent = g_enterprise
         AND glac001 = g_glaa.glaa004   
         AND glac002 = l_glac002                  
      
      IF l_ac = 1 THEN #期初     
         LET g_glap_d2[l_ac + 1].* = g_glap_d2[l_ac].*
         LET g_glap_d2[l_ac].glap002 = ''
         LET g_glap_d2[l_ac].glap004 = ''
         LET g_glap_d2[l_ac].glapdocdt = ''
         LET g_glap_d2[l_ac].glapdocno = '' 
         LET g_glap_d2[l_ac].l_glaq001 = s_desc_gzcbl004_desc('9927','1')
         LET g_glap_d2[l_ac].l_glaq005 = ''
         LET g_glap_d2[l_ac].l_glaq010 = ''
         LET g_glap_d2[l_ac].l_glaq006 = ''

         PREPARE aglq320_pb5 FROM " SELECT DISTINCT glaq002 FROM aglq320_tmp " 
         DECLARE aglq320_cs5 CURSOR FOR aglq320_pb5
         FOREACH aglq320_cs5 INTO l_glaq002_t         
            FOR l_idx = 1 TO 30
               IF l_glaq002_t = l_glac[l_idx].glac002 THEN  
                  SELECT glaq040,glaq041                   
                    INTO l_glaq0031,l_glaq0041 FROM aglq320_tmp
                   WHERE glaq002 = l_glaq002_t AND l_flag = 1 
                  IF cl_null(l_glaq0031) THEN LET l_glaq0031 = 0 END IF
                  IF cl_null(l_glaq0041) THEN LET l_glaq0041 = 0 END IF
                  #借-貸 期初
                  LET l_mon =  l_glaq0031 - l_glaq0041
                    IF l_glac008 = 1 THEN 
                     CASE l_idx
                        WHEN 1    
                           LET g_glap_d2[l_ac].l_glaq003_1  = l_mon
                        WHEN 2
                           LET g_glap_d2[l_ac].l_glaq003_2  = l_mon
                        WHEN 3
                           LET g_glap_d2[l_ac].l_glaq003_3  = l_mon
                        WHEN 4   
                           LET g_glap_d2[l_ac].l_glaq003_4  = l_mon
                        WHEN 5   
                           LET g_glap_d2[l_ac].l_glaq003_5  = l_mon
                        WHEN 6
                           LET g_glap_d2[l_ac].l_glaq003_6  = l_mon
                        WHEN 7
                           LET g_glap_d2[l_ac].l_glaq003_7  = l_mon
                        WHEN 8
                           LET g_glap_d2[l_ac].l_glaq003_8  = l_mon
                        WHEN 9
                           LET g_glap_d2[l_ac].l_glaq003_9  = l_mon
                        WHEN 10
                           LET g_glap_d2[l_ac].l_glaq003_10 = l_mon
                        WHEN 11
                           LET g_glap_d2[l_ac].l_glaq003_11 = l_mon
                        WHEN 12
                           LET g_glap_d2[l_ac].l_glaq003_12 = l_mon
                        WHEN 13
                           LET g_glap_d2[l_ac].l_glaq003_13 = l_mon
                        WHEN 14
                           LET g_glap_d2[l_ac].l_glaq003_14 = l_mon
                        WHEN 15
                           LET g_glap_d2[l_ac].l_glaq003_15 = l_mon
                        WHEN 16
                           LET g_glap_d2[l_ac].l_glaq003_16 = l_mon
                        WHEN 17
                           LET g_glap_d2[l_ac].l_glaq003_17 = l_mon
                        WHEN 18
                           LET g_glap_d2[l_ac].l_glaq003_18 = l_mon
                        WHEN 19
                           LET g_glap_d2[l_ac].l_glaq003_19 = l_mon
                        WHEN 20
                           LET g_glap_d2[l_ac].l_glaq003_20 = l_mon
                        WHEN 21
                           LET g_glap_d2[l_ac].l_glaq003_21 = l_mon
                        WHEN 22
                           LET g_glap_d2[l_ac].l_glaq003_22 = l_mon
                        WHEN 23
                           LET g_glap_d2[l_ac].l_glaq003_23 = l_mon
                        WHEN 24
                           LET g_glap_d2[l_ac].l_glaq003_24 = l_mon
                        WHEN 25
                           LET g_glap_d2[l_ac].l_glaq003_25 = l_mon
                        WHEN 26
                           LET g_glap_d2[l_ac].l_glaq003_26 = l_mon
                        WHEN 27
                           LET g_glap_d2[l_ac].l_glaq003_27 = l_mon
                        WHEN 28
                           LET g_glap_d2[l_ac].l_glaq003_28 = l_mon
                        WHEN 29
                           LET g_glap_d2[l_ac].l_glaq003_29 = l_mon
                        WHEN 30
                           LET g_glap_d2[l_ac].l_glaq003_30 = l_mon               
                     END CASE
                  ELSE
                     CASE l_idx
                        WHEN 31    
                           LET g_glap_d2[l_ac].l_glaq004_1  = l_mon
                        WHEN 32
                           LET g_glap_d2[l_ac].l_glaq004_2  = l_mon
                        WHEN 33
                           LET g_glap_d2[l_ac].l_glaq004_3  = l_mon
                        WHEN 34   
                           LET g_glap_d2[l_ac].l_glaq004_4  = l_mon
                        WHEN 35   
                           LET g_glap_d2[l_ac].l_glaq004_5  = l_mon
                        WHEN 36
                           LET g_glap_d2[l_ac].l_glaq004_6  = l_mon
                        WHEN 37
                           LET g_glap_d2[l_ac].l_glaq004_7  = l_mon
                        WHEN 38
                           LET g_glap_d2[l_ac].l_glaq004_8  = l_mon
                        WHEN 39
                           LET g_glap_d2[l_ac].l_glaq004_9  = l_mon
                        WHEN 40
                           LET g_glap_d2[l_ac].l_glaq004_10 = l_mon
                        WHEN 41
                           LET g_glap_d2[l_ac].l_glaq004_11 = l_mon
                        WHEN 42
                           LET g_glap_d2[l_ac].l_glaq004_12 = l_mon
                        WHEN 43
                           LET g_glap_d2[l_ac].l_glaq004_13 = l_mon
                        WHEN 44
                           LET g_glap_d2[l_ac].l_glaq004_14 = l_mon
                        WHEN 45
                           LET g_glap_d2[l_ac].l_glaq004_15 = l_mon
                        WHEN 46
                           LET g_glap_d2[l_ac].l_glaq004_16 = l_mon
                        WHEN 47
                           LET g_glap_d2[l_ac].l_glaq004_17 = l_mon
                        WHEN 48
                           LET g_glap_d2[l_ac].l_glaq004_18 = l_mon
                        WHEN 49
                           LET g_glap_d2[l_ac].l_glaq004_19 = l_mon
                        WHEN 50
                           LET g_glap_d2[l_ac].l_glaq004_20 = l_mon
                        WHEN 51
                           LET g_glap_d2[l_ac].l_glaq004_21 = l_mon
                        WHEN 52
                           LET g_glap_d2[l_ac].l_glaq004_22 = l_mon
                        WHEN 53
                           LET g_glap_d2[l_ac].l_glaq004_23 = l_mon
                        WHEN 54
                           LET g_glap_d2[l_ac].l_glaq004_24 = l_mon
                        WHEN 55
                           LET g_glap_d2[l_ac].l_glaq004_25 = l_mon
                        WHEN 56
                           LET g_glap_d2[l_ac].l_glaq004_26 = l_mon
                        WHEN 57
                           LET g_glap_d2[l_ac].l_glaq004_27 = l_mon
                        WHEN 58
                           LET g_glap_d2[l_ac].l_glaq004_28 = l_mon
                        WHEN 59
                           LET g_glap_d2[l_ac].l_glaq004_29 = l_mon
                        WHEN 60
                           LET g_glap_d2[l_ac].l_glaq004_30 = l_mon 
                     END CASE
                  END IF  
               END IF             
            END FOR  
         END FOREACH    
         CALL aglq320_reset(l_ac,'1')
         CALL aglq320_reset(l_ac,'2')  
         LET g_glap_d2[l_ac].l_amt =  g_glap_d2[l_ac].l_glaq003_0 -  g_glap_d2[l_ac].l_glaq004_0    
         IF cl_null(g_glap_d2[l_ac].l_amt) THEN LET g_glap_d2[l_ac].l_amt = 0 END IF
         CASE 
            WHEN g_glap_d2[l_ac].l_amt > 0  
               CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #借  
            WHEN g_glap_d[l_ac].l_amt < 0 
               CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #貸
            WHEN g_glap_d[l_ac].l_amt = 0
               CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #平
         END CASE             
         #紀錄本年累計       
         LET l_y = 1  
         LET l_m = 1         
         LET l_ac = l_ac + 1 
      END IF 
      
      #借方科目      
      IF l_glac008 = 1 THEN
         IF l_glaq003 <> 0 THEN
             FOR l_idx = 1 TO 30
                IF l_glac002 = l_glac[l_idx].glac002 THEN                                   
                   EXIT FOR          
                END IF             
             END FOR
             LET l_mon = l_glaq003
          END IF
          IF l_glaq004 <> 0 THEN
             FOR l_idx = 1 TO 30
                IF l_glac002 = l_glac[l_idx].glac002 THEN                                
                   EXIT FOR          
                END IF             
             END FOR
             LET l_mon = l_glaq004 * -1
          END IF
      ELSE
         IF l_glaq003 <> 0 THEN
            FOR l_idx = 31 TO 60
               IF l_glac002 = l_glac[l_idx].glac002 THEN                 
                  EXIT FOR          
               END IF             
            END FOR
             LET l_mon = l_glaq003 * - 1
         END IF
         IF l_glaq004 <> 0 THEN
             FOR l_idx = 31 TO 60
                IF l_glac002 = l_glac[l_idx].glac002 THEN              
                   
                   EXIT FOR          
                END IF             
             END FOR
             LET l_mon = l_glaq004 
          END IF
      END IF     
      IF l_glac008 = 1 THEN 
         CASE l_idx
            WHEN 1    
               LET g_glap_d2[l_ac].l_glaq003_1  = l_mon
            WHEN 2
               LET g_glap_d2[l_ac].l_glaq003_2  = l_mon
            WHEN 3
               LET g_glap_d2[l_ac].l_glaq003_3  = l_mon
            WHEN 4   
               LET g_glap_d2[l_ac].l_glaq003_4  = l_mon
            WHEN 5   
               LET g_glap_d2[l_ac].l_glaq003_5  = l_mon
            WHEN 6
               LET g_glap_d2[l_ac].l_glaq003_6  = l_mon
            WHEN 7
               LET g_glap_d2[l_ac].l_glaq003_7  = l_mon
            WHEN 8
               LET g_glap_d2[l_ac].l_glaq003_8  = l_mon
            WHEN 9
               LET g_glap_d2[l_ac].l_glaq003_9  = l_mon
            WHEN 10
               LET g_glap_d2[l_ac].l_glaq003_10 = l_mon
            WHEN 11
               LET g_glap_d2[l_ac].l_glaq003_11 = l_mon
            WHEN 12
               LET g_glap_d2[l_ac].l_glaq003_12 = l_mon
            WHEN 13
               LET g_glap_d2[l_ac].l_glaq003_13 = l_mon
            WHEN 14
               LET g_glap_d2[l_ac].l_glaq003_14 = l_mon
            WHEN 15
               LET g_glap_d2[l_ac].l_glaq003_15 = l_mon
            WHEN 16
               LET g_glap_d2[l_ac].l_glaq003_16 = l_mon
            WHEN 17
               LET g_glap_d2[l_ac].l_glaq003_17 = l_mon
            WHEN 18
               LET g_glap_d2[l_ac].l_glaq003_18 = l_mon
            WHEN 19
               LET g_glap_d2[l_ac].l_glaq003_19 = l_mon
            WHEN 20
               LET g_glap_d2[l_ac].l_glaq003_20 = l_mon
            WHEN 21
               LET g_glap_d2[l_ac].l_glaq003_21 = l_mon
            WHEN 22
               LET g_glap_d2[l_ac].l_glaq003_22 = l_mon
            WHEN 23
               LET g_glap_d2[l_ac].l_glaq003_23 = l_mon
            WHEN 24
               LET g_glap_d2[l_ac].l_glaq003_24 = l_mon
            WHEN 25
               LET g_glap_d2[l_ac].l_glaq003_24 = l_mon
            WHEN 26
               LET g_glap_d2[l_ac].l_glaq003_24 = l_mon
            WHEN 27
               LET g_glap_d2[l_ac].l_glaq003_24 = l_mon
            WHEN 28
               LET g_glap_d2[l_ac].l_glaq003_24 = l_mon
            WHEN 29
               LET g_glap_d2[l_ac].l_glaq003_24 = l_mon
            WHEN 30
               LET g_glap_d2[l_ac].l_glaq003_24 = l_mon               
         END CASE
      ELSE
         CASE l_idx
            WHEN 31    
               LET g_glap_d2[l_ac].l_glaq004_1  = l_mon
            WHEN 32
               LET g_glap_d2[l_ac].l_glaq004_2  = l_mon
            WHEN 33
               LET g_glap_d2[l_ac].l_glaq004_3  = l_mon
            WHEN 34   
               LET g_glap_d2[l_ac].l_glaq004_4  = l_mon
            WHEN 35   
               LET g_glap_d2[l_ac].l_glaq004_5  = l_mon
            WHEN 36
               LET g_glap_d2[l_ac].l_glaq004_6  = l_mon
            WHEN 37
               LET g_glap_d2[l_ac].l_glaq004_7  = l_mon
            WHEN 38
               LET g_glap_d2[l_ac].l_glaq004_8  = l_mon
            WHEN 39
               LET g_glap_d2[l_ac].l_glaq004_9  = l_mon
            WHEN 40
               LET g_glap_d2[l_ac].l_glaq004_10 = l_mon
            WHEN 41
               LET g_glap_d2[l_ac].l_glaq004_11 = l_mon
            WHEN 42
               LET g_glap_d2[l_ac].l_glaq004_12 = l_mon
            WHEN 43
               LET g_glap_d2[l_ac].l_glaq004_13 = l_mon
            WHEN 44
               LET g_glap_d2[l_ac].l_glaq004_14 = l_mon
            WHEN 45
               LET g_glap_d2[l_ac].l_glaq004_15 = l_mon
            WHEN 46
               LET g_glap_d2[l_ac].l_glaq004_16 = l_mon
            WHEN 47
               LET g_glap_d2[l_ac].l_glaq004_17 = l_mon
            WHEN 48
               LET g_glap_d2[l_ac].l_glaq004_18 = l_mon
            WHEN 49
               LET g_glap_d2[l_ac].l_glaq004_19 = l_mon
            WHEN 50
               LET g_glap_d2[l_ac].l_glaq004_20 = l_mon
            WHEN 51
               LET g_glap_d2[l_ac].l_glaq004_21 = l_mon
            WHEN 52
               LET g_glap_d2[l_ac].l_glaq004_22 = l_mon
            WHEN 53
               LET g_glap_d2[l_ac].l_glaq004_23 = l_mon
            WHEN 54
               LET g_glap_d2[l_ac].l_glaq004_24 = l_mon
            WHEN 55
               LET g_glap_d2[l_ac].l_glaq004_25 = l_mon
            WHEN 56
               LET g_glap_d2[l_ac].l_glaq004_26 = l_mon
            WHEN 57
               LET g_glap_d2[l_ac].l_glaq004_27 = l_mon
            WHEN 58
               LET g_glap_d2[l_ac].l_glaq004_28 = l_mon
            WHEN 59
               LET g_glap_d2[l_ac].l_glaq004_29 = l_mon
            WHEN 60
               LET g_glap_d2[l_ac].l_glaq004_30 = l_mon               
         END CASE
      END IF
      CALL aglq320_reset(l_ac,'1')
      CALL aglq320_reset(l_ac,'2') 
      LET g_glap_d2[l_ac].l_amt = g_glap_d2[l_ac].l_glaq003_0 -  g_glap_d2[l_ac].l_glaq004_0 + g_glap_d2[l_ac-1].l_amt  
      IF cl_null(g_glap_d2[l_ac].l_amt) THEN LET g_glap_d2[l_ac].l_amt = 0 END IF
　　　 CASE 
         WHEN g_glap_d2[l_ac].l_amt > 0  
            CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #借  
         WHEN g_glap_d[l_ac].l_amt < 0 
            CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #貸
         WHEN g_glap_d[l_ac].l_amt = 0
            CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #平
      END CASE                  
      #本期合計
      IF l_glap004_t <> g_glap_d2[l_ac].glap004 AND l_ac > 1 THEN
         LET l_glap002_t = g_glap_d2[l_ac-1].glap002 #紀錄本期年度
         LET g_glap_d2[l_ac + 2].* = g_glap_d2[l_ac].*
         INITIALIZE g_glap_d2[l_ac].* TO NULL
         LET g_glap_d2[l_ac].l_glaq001 = s_desc_gzcbl004_desc('9927','2')    
         CALL aglq320_reset(l_ac,'1')
         FOR l_idx = 1 TO l_glap.getLength() 
            IF l_glap004_t = l_glap[l_idx].glap004  THEN                   
               LET g_glap_d2[l_ac].l_glaq003_1  = g_glap_d2[l_ac].l_glaq003_1  + g_glap_d2[l_idx].l_glaq003_1 
               LET g_glap_d2[l_ac].l_glaq003_2  = g_glap_d2[l_ac].l_glaq003_2  + g_glap_d2[l_idx].l_glaq003_2 
               LET g_glap_d2[l_ac].l_glaq003_3  = g_glap_d2[l_ac].l_glaq003_3  + g_glap_d2[l_idx].l_glaq003_3 
               LET g_glap_d2[l_ac].l_glaq003_4  = g_glap_d2[l_ac].l_glaq003_4  + g_glap_d2[l_idx].l_glaq003_4 
               LET g_glap_d2[l_ac].l_glaq003_5  = g_glap_d2[l_ac].l_glaq003_5  + g_glap_d2[l_idx].l_glaq003_5 
               LET g_glap_d2[l_ac].l_glaq003_6  = g_glap_d2[l_ac].l_glaq003_6  + g_glap_d2[l_idx].l_glaq003_6 
               LET g_glap_d2[l_ac].l_glaq003_7  = g_glap_d2[l_ac].l_glaq003_7  + g_glap_d2[l_idx].l_glaq003_7 
               LET g_glap_d2[l_ac].l_glaq003_8  = g_glap_d2[l_ac].l_glaq003_8  + g_glap_d2[l_idx].l_glaq003_8 
               LET g_glap_d2[l_ac].l_glaq003_9  = g_glap_d2[l_ac].l_glaq003_9  + g_glap_d2[l_idx].l_glaq003_9 
               LET g_glap_d2[l_ac].l_glaq003_10 = g_glap_d2[l_ac].l_glaq003_10 + g_glap_d2[l_idx].l_glaq003_10
               LET g_glap_d2[l_ac].l_glaq003_11 = g_glap_d2[l_ac].l_glaq003_11 + g_glap_d2[l_idx].l_glaq003_11
               LET g_glap_d2[l_ac].l_glaq003_12 = g_glap_d2[l_ac].l_glaq003_12 + g_glap_d2[l_idx].l_glaq003_12
               LET g_glap_d2[l_ac].l_glaq003_13 = g_glap_d2[l_ac].l_glaq003_13 + g_glap_d2[l_idx].l_glaq003_13
               LET g_glap_d2[l_ac].l_glaq003_14 = g_glap_d2[l_ac].l_glaq003_14 + g_glap_d2[l_idx].l_glaq003_14
               LET g_glap_d2[l_ac].l_glaq003_15 = g_glap_d2[l_ac].l_glaq003_15 + g_glap_d2[l_idx].l_glaq003_15
               LET g_glap_d2[l_ac].l_glaq003_16 = g_glap_d2[l_ac].l_glaq003_16 + g_glap_d2[l_idx].l_glaq003_16
               LET g_glap_d2[l_ac].l_glaq003_17 = g_glap_d2[l_ac].l_glaq003_17 + g_glap_d2[l_idx].l_glaq003_17
               LET g_glap_d2[l_ac].l_glaq003_18 = g_glap_d2[l_ac].l_glaq003_18 + g_glap_d2[l_idx].l_glaq003_18
               LET g_glap_d2[l_ac].l_glaq003_19 = g_glap_d2[l_ac].l_glaq003_19 + g_glap_d2[l_idx].l_glaq003_19
               LET g_glap_d2[l_ac].l_glaq003_20 = g_glap_d2[l_ac].l_glaq003_20 + g_glap_d2[l_idx].l_glaq003_20
               LET g_glap_d2[l_ac].l_glaq003_21 = g_glap_d2[l_ac].l_glaq003_21 + g_glap_d2[l_idx].l_glaq003_21
               LET g_glap_d2[l_ac].l_glaq003_22 = g_glap_d2[l_ac].l_glaq003_22 + g_glap_d2[l_idx].l_glaq003_22
               LET g_glap_d2[l_ac].l_glaq003_23 = g_glap_d2[l_ac].l_glaq003_23 + g_glap_d2[l_idx].l_glaq003_23
               LET g_glap_d2[l_ac].l_glaq003_24 = g_glap_d2[l_ac].l_glaq003_24 + g_glap_d2[l_idx].l_glaq003_24
               LET g_glap_d2[l_ac].l_glaq003_25 = g_glap_d2[l_ac].l_glaq003_25 + g_glap_d2[l_idx].l_glaq003_25
               LET g_glap_d2[l_ac].l_glaq003_26 = g_glap_d2[l_ac].l_glaq003_26 + g_glap_d2[l_idx].l_glaq003_26
               LET g_glap_d2[l_ac].l_glaq003_27 = g_glap_d2[l_ac].l_glaq003_27 + g_glap_d2[l_idx].l_glaq003_27
               LET g_glap_d2[l_ac].l_glaq003_28 = g_glap_d2[l_ac].l_glaq003_28 + g_glap_d2[l_idx].l_glaq003_28
               LET g_glap_d2[l_ac].l_glaq003_29 = g_glap_d2[l_ac].l_glaq003_29 + g_glap_d2[l_idx].l_glaq003_29
               LET g_glap_d2[l_ac].l_glaq003_30 = g_glap_d2[l_ac].l_glaq003_30 + g_glap_d2[l_idx].l_glaq003_30
               
               LET g_glap_d2[l_ac].l_glaq004_1  = g_glap_d2[l_ac].l_glaq004_1  + g_glap_d2[l_idx].l_glaq004_1 
               LET g_glap_d2[l_ac].l_glaq004_2  = g_glap_d2[l_ac].l_glaq004_2  + g_glap_d2[l_idx].l_glaq004_2 
               LET g_glap_d2[l_ac].l_glaq004_3  = g_glap_d2[l_ac].l_glaq004_3  + g_glap_d2[l_idx].l_glaq004_3 
               LET g_glap_d2[l_ac].l_glaq004_4  = g_glap_d2[l_ac].l_glaq004_4  + g_glap_d2[l_idx].l_glaq004_4 
               LET g_glap_d2[l_ac].l_glaq004_5  = g_glap_d2[l_ac].l_glaq004_5  + g_glap_d2[l_idx].l_glaq004_5 
               LET g_glap_d2[l_ac].l_glaq004_6  = g_glap_d2[l_ac].l_glaq004_6  + g_glap_d2[l_idx].l_glaq004_6 
               LET g_glap_d2[l_ac].l_glaq004_7  = g_glap_d2[l_ac].l_glaq004_7  + g_glap_d2[l_idx].l_glaq004_7 
               LET g_glap_d2[l_ac].l_glaq004_8  = g_glap_d2[l_ac].l_glaq004_8  + g_glap_d2[l_idx].l_glaq004_8 
               LET g_glap_d2[l_ac].l_glaq004_9  = g_glap_d2[l_ac].l_glaq004_9  + g_glap_d2[l_idx].l_glaq004_9 
               LET g_glap_d2[l_ac].l_glaq004_10 = g_glap_d2[l_ac].l_glaq004_10 + g_glap_d2[l_idx].l_glaq004_10
               LET g_glap_d2[l_ac].l_glaq004_11 = g_glap_d2[l_ac].l_glaq004_11 + g_glap_d2[l_idx].l_glaq004_11
               LET g_glap_d2[l_ac].l_glaq004_12 = g_glap_d2[l_ac].l_glaq004_12 + g_glap_d2[l_idx].l_glaq004_12
               LET g_glap_d2[l_ac].l_glaq004_13 = g_glap_d2[l_ac].l_glaq004_13 + g_glap_d2[l_idx].l_glaq004_13
               LET g_glap_d2[l_ac].l_glaq004_14 = g_glap_d2[l_ac].l_glaq004_14 + g_glap_d2[l_idx].l_glaq004_14
               LET g_glap_d2[l_ac].l_glaq004_15 = g_glap_d2[l_ac].l_glaq004_15 + g_glap_d2[l_idx].l_glaq004_15
               LET g_glap_d2[l_ac].l_glaq004_16 = g_glap_d2[l_ac].l_glaq004_16 + g_glap_d2[l_idx].l_glaq004_16
               LET g_glap_d2[l_ac].l_glaq004_17 = g_glap_d2[l_ac].l_glaq004_17 + g_glap_d2[l_idx].l_glaq004_17
               LET g_glap_d2[l_ac].l_glaq004_18 = g_glap_d2[l_ac].l_glaq004_18 + g_glap_d2[l_idx].l_glaq004_18
               LET g_glap_d2[l_ac].l_glaq004_19 = g_glap_d2[l_ac].l_glaq004_19 + g_glap_d2[l_idx].l_glaq004_19
               LET g_glap_d2[l_ac].l_glaq004_20 = g_glap_d2[l_ac].l_glaq004_20 + g_glap_d2[l_idx].l_glaq004_20
               LET g_glap_d2[l_ac].l_glaq004_21 = g_glap_d2[l_ac].l_glaq004_21 + g_glap_d2[l_idx].l_glaq004_21
               LET g_glap_d2[l_ac].l_glaq004_22 = g_glap_d2[l_ac].l_glaq004_22 + g_glap_d2[l_idx].l_glaq004_22
               LET g_glap_d2[l_ac].l_glaq004_23 = g_glap_d2[l_ac].l_glaq004_23 + g_glap_d2[l_idx].l_glaq004_23
               LET g_glap_d2[l_ac].l_glaq004_24 = g_glap_d2[l_ac].l_glaq004_24 + g_glap_d2[l_idx].l_glaq004_24
               LET g_glap_d2[l_ac].l_glaq004_25 = g_glap_d2[l_ac].l_glaq004_25 + g_glap_d2[l_idx].l_glaq004_25
               LET g_glap_d2[l_ac].l_glaq004_26 = g_glap_d2[l_ac].l_glaq004_26 + g_glap_d2[l_idx].l_glaq004_26
               LET g_glap_d2[l_ac].l_glaq004_27 = g_glap_d2[l_ac].l_glaq004_27 + g_glap_d2[l_idx].l_glaq004_27
               LET g_glap_d2[l_ac].l_glaq004_28 = g_glap_d2[l_ac].l_glaq004_28 + g_glap_d2[l_idx].l_glaq004_28
               LET g_glap_d2[l_ac].l_glaq004_29 = g_glap_d2[l_ac].l_glaq004_29 + g_glap_d2[l_idx].l_glaq004_29
               LET g_glap_d2[l_ac].l_glaq004_30 = g_glap_d2[l_ac].l_glaq004_30 + g_glap_d2[l_idx].l_glaq004_30               
            END IF            
         END FOR             
         CALL aglq320_reset(l_ac,'2')             
         LET g_glap_d2[l_ac].l_amt = g_glap_d2[l_ac-1].l_amt  
         IF cl_null(g_glap_d2[l_ac].l_amt) THEN LET g_glap_d2[l_ac].l_amt = 0 END IF
         CASE 
            WHEN g_glap_d2[l_ac].l_amt > 0  
               CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #借  
            WHEN g_glap_d[l_ac].l_amt < 0 
               CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #貸
            WHEN g_glap_d[l_ac].l_amt = 0
               CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #平
         END CASE         
         LET l_ac = l_ac +1    
         #本年累計            
         LET g_glap_d2[l_ac].glap002 = ''           
         LET g_glap_d2[l_ac].glap004 = ''
         LET g_glap_d2[l_ac].glapdocdt = ''
         LET g_glap_d2[l_ac].glapdocno = '' 
         LET g_glap_d2[l_ac].l_glaq001 = s_desc_gzcbl004_desc('9927','3')
         LET g_glap_d2[l_ac].l_glaq005 = ''
         LET g_glap_d2[l_ac].l_glaq010 = ''
         LET g_glap_d2[l_ac].l_glaq006 = ''
         CALL aglq320_reset(l_ac,'1')
         # 本期累計+上次本年累計
         IF l_glap002_t <> g_glap_d2[l_m].glap002 THEN
            LET g_glap_d2[l_ac].l_glaq003_1  = g_glap_d2[l_ac-1].l_glaq003_1  
            LET g_glap_d2[l_ac].l_glaq003_2  = g_glap_d2[l_ac-1].l_glaq003_2  
            LET g_glap_d2[l_ac].l_glaq003_3  = g_glap_d2[l_ac-1].l_glaq003_3  
            LET g_glap_d2[l_ac].l_glaq003_4  = g_glap_d2[l_ac-1].l_glaq003_4  
            LET g_glap_d2[l_ac].l_glaq003_5  = g_glap_d2[l_ac-1].l_glaq003_5  
            LET g_glap_d2[l_ac].l_glaq003_6  = g_glap_d2[l_ac-1].l_glaq003_6  
            LET g_glap_d2[l_ac].l_glaq003_7  = g_glap_d2[l_ac-1].l_glaq003_7  
            LET g_glap_d2[l_ac].l_glaq003_8  = g_glap_d2[l_ac-1].l_glaq003_8  
            LET g_glap_d2[l_ac].l_glaq003_9  = g_glap_d2[l_ac-1].l_glaq003_9  
            LET g_glap_d2[l_ac].l_glaq003_10 = g_glap_d2[l_ac-1].l_glaq003_10 
            LET g_glap_d2[l_ac].l_glaq003_11 = g_glap_d2[l_ac-1].l_glaq003_11 
            LET g_glap_d2[l_ac].l_glaq003_12 = g_glap_d2[l_ac-1].l_glaq003_12 
            LET g_glap_d2[l_ac].l_glaq003_13 = g_glap_d2[l_ac-1].l_glaq003_13 
            LET g_glap_d2[l_ac].l_glaq003_14 = g_glap_d2[l_ac-1].l_glaq003_14 
            LET g_glap_d2[l_ac].l_glaq003_15 = g_glap_d2[l_ac-1].l_glaq003_15 
            LET g_glap_d2[l_ac].l_glaq003_16 = g_glap_d2[l_ac-1].l_glaq003_16 
            LET g_glap_d2[l_ac].l_glaq003_17 = g_glap_d2[l_ac-1].l_glaq003_17 
            LET g_glap_d2[l_ac].l_glaq003_18 = g_glap_d2[l_ac-1].l_glaq003_18 
            LET g_glap_d2[l_ac].l_glaq003_19 = g_glap_d2[l_ac-1].l_glaq003_19 
            LET g_glap_d2[l_ac].l_glaq003_20 = g_glap_d2[l_ac-1].l_glaq003_20 
            LET g_glap_d2[l_ac].l_glaq003_21 = g_glap_d2[l_ac-1].l_glaq003_21 
            LET g_glap_d2[l_ac].l_glaq003_22 = g_glap_d2[l_ac-1].l_glaq003_22 
            LET g_glap_d2[l_ac].l_glaq003_23 = g_glap_d2[l_ac-1].l_glaq003_23 
            LET g_glap_d2[l_ac].l_glaq003_24 = g_glap_d2[l_ac-1].l_glaq003_24 
            LET g_glap_d2[l_ac].l_glaq003_25 = g_glap_d2[l_ac-1].l_glaq003_25 
            LET g_glap_d2[l_ac].l_glaq003_26 = g_glap_d2[l_ac-1].l_glaq003_26 
            LET g_glap_d2[l_ac].l_glaq003_27 = g_glap_d2[l_ac-1].l_glaq003_27 
            LET g_glap_d2[l_ac].l_glaq003_28 = g_glap_d2[l_ac-1].l_glaq003_28 
            LET g_glap_d2[l_ac].l_glaq003_29 = g_glap_d2[l_ac-1].l_glaq003_29 
            LET g_glap_d2[l_ac].l_glaq003_30 = g_glap_d2[l_ac-1].l_glaq003_30
            
            LET g_glap_d2[l_ac].l_glaq004_1  = g_glap_d2[l_ac-1].l_glaq004_1  
            LET g_glap_d2[l_ac].l_glaq004_2  = g_glap_d2[l_ac-1].l_glaq004_2  
            LET g_glap_d2[l_ac].l_glaq004_3  = g_glap_d2[l_ac-1].l_glaq004_3  
            LET g_glap_d2[l_ac].l_glaq004_4  = g_glap_d2[l_ac-1].l_glaq004_4  
            LET g_glap_d2[l_ac].l_glaq004_5  = g_glap_d2[l_ac-1].l_glaq004_5  
            LET g_glap_d2[l_ac].l_glaq004_6  = g_glap_d2[l_ac-1].l_glaq004_6  
            LET g_glap_d2[l_ac].l_glaq004_7  = g_glap_d2[l_ac-1].l_glaq004_7  
            LET g_glap_d2[l_ac].l_glaq004_8  = g_glap_d2[l_ac-1].l_glaq004_8  
            LET g_glap_d2[l_ac].l_glaq004_9  = g_glap_d2[l_ac-1].l_glaq004_9  
            LET g_glap_d2[l_ac].l_glaq004_10 = g_glap_d2[l_ac-1].l_glaq004_10 
            LET g_glap_d2[l_ac].l_glaq004_11 = g_glap_d2[l_ac-1].l_glaq004_11 
            LET g_glap_d2[l_ac].l_glaq004_12 = g_glap_d2[l_ac-1].l_glaq004_12 
            LET g_glap_d2[l_ac].l_glaq004_13 = g_glap_d2[l_ac-1].l_glaq004_13 
            LET g_glap_d2[l_ac].l_glaq004_14 = g_glap_d2[l_ac-1].l_glaq004_14 
            LET g_glap_d2[l_ac].l_glaq004_15 = g_glap_d2[l_ac-1].l_glaq004_15 
            LET g_glap_d2[l_ac].l_glaq004_16 = g_glap_d2[l_ac-1].l_glaq004_16 
            LET g_glap_d2[l_ac].l_glaq004_17 = g_glap_d2[l_ac-1].l_glaq004_17 
            LET g_glap_d2[l_ac].l_glaq004_18 = g_glap_d2[l_ac-1].l_glaq004_18 
            LET g_glap_d2[l_ac].l_glaq004_19 = g_glap_d2[l_ac-1].l_glaq004_19 
            LET g_glap_d2[l_ac].l_glaq004_20 = g_glap_d2[l_ac-1].l_glaq004_20 
            LET g_glap_d2[l_ac].l_glaq004_21 = g_glap_d2[l_ac-1].l_glaq004_21 
            LET g_glap_d2[l_ac].l_glaq004_22 = g_glap_d2[l_ac-1].l_glaq004_22 
            LET g_glap_d2[l_ac].l_glaq004_23 = g_glap_d2[l_ac-1].l_glaq004_23 
            LET g_glap_d2[l_ac].l_glaq004_24 = g_glap_d2[l_ac-1].l_glaq004_24 
            LET g_glap_d2[l_ac].l_glaq004_25 = g_glap_d2[l_ac-1].l_glaq004_25 
            LET g_glap_d2[l_ac].l_glaq004_26 = g_glap_d2[l_ac-1].l_glaq004_26 
            LET g_glap_d2[l_ac].l_glaq004_27 = g_glap_d2[l_ac-1].l_glaq004_27 
            LET g_glap_d2[l_ac].l_glaq004_28 = g_glap_d2[l_ac-1].l_glaq004_28 
            LET g_glap_d2[l_ac].l_glaq004_29 = g_glap_d2[l_ac-1].l_glaq004_29 
            LET g_glap_d2[l_ac].l_glaq004_30 = g_glap_d2[l_ac-1].l_glaq004_30        
         ELSE         
            LET g_glap_d2[l_ac].l_glaq003_1  = g_glap_d2[l_ac-1].l_glaq003_1  + g_glap_d2[l_y].l_glaq003_1 
            LET g_glap_d2[l_ac].l_glaq003_2  = g_glap_d2[l_ac-1].l_glaq003_2  + g_glap_d2[l_y].l_glaq003_2 
            LET g_glap_d2[l_ac].l_glaq003_3  = g_glap_d2[l_ac-1].l_glaq003_3  + g_glap_d2[l_y].l_glaq003_3 
            LET g_glap_d2[l_ac].l_glaq003_4  = g_glap_d2[l_ac-1].l_glaq003_4  + g_glap_d2[l_y].l_glaq003_4 
            LET g_glap_d2[l_ac].l_glaq003_5  = g_glap_d2[l_ac-1].l_glaq003_5  + g_glap_d2[l_y].l_glaq003_5 
            LET g_glap_d2[l_ac].l_glaq003_6  = g_glap_d2[l_ac-1].l_glaq003_6  + g_glap_d2[l_y].l_glaq003_6 
            LET g_glap_d2[l_ac].l_glaq003_7  = g_glap_d2[l_ac-1].l_glaq003_7  + g_glap_d2[l_y].l_glaq003_7 
            LET g_glap_d2[l_ac].l_glaq003_8  = g_glap_d2[l_ac-1].l_glaq003_8  + g_glap_d2[l_y].l_glaq003_8 
            LET g_glap_d2[l_ac].l_glaq003_9  = g_glap_d2[l_ac-1].l_glaq003_9  + g_glap_d2[l_y].l_glaq003_9 
            LET g_glap_d2[l_ac].l_glaq003_10 = g_glap_d2[l_ac-1].l_glaq003_10 + g_glap_d2[l_y].l_glaq003_10
            LET g_glap_d2[l_ac].l_glaq003_11 = g_glap_d2[l_ac-1].l_glaq003_11 + g_glap_d2[l_y].l_glaq003_11
            LET g_glap_d2[l_ac].l_glaq003_12 = g_glap_d2[l_ac-1].l_glaq003_12 + g_glap_d2[l_y].l_glaq003_12
            LET g_glap_d2[l_ac].l_glaq003_13 = g_glap_d2[l_ac-1].l_glaq003_13 + g_glap_d2[l_y].l_glaq003_13
            LET g_glap_d2[l_ac].l_glaq003_14 = g_glap_d2[l_ac-1].l_glaq003_14 + g_glap_d2[l_y].l_glaq003_14
            LET g_glap_d2[l_ac].l_glaq003_15 = g_glap_d2[l_ac-1].l_glaq003_15 + g_glap_d2[l_y].l_glaq003_15
            LET g_glap_d2[l_ac].l_glaq003_16 = g_glap_d2[l_ac-1].l_glaq003_16 + g_glap_d2[l_y].l_glaq003_16
            LET g_glap_d2[l_ac].l_glaq003_17 = g_glap_d2[l_ac-1].l_glaq003_17 + g_glap_d2[l_y].l_glaq003_17
            LET g_glap_d2[l_ac].l_glaq003_18 = g_glap_d2[l_ac-1].l_glaq003_18 + g_glap_d2[l_y].l_glaq003_18
            LET g_glap_d2[l_ac].l_glaq003_19 = g_glap_d2[l_ac-1].l_glaq003_19 + g_glap_d2[l_y].l_glaq003_19
            LET g_glap_d2[l_ac].l_glaq003_20 = g_glap_d2[l_ac-1].l_glaq003_20 + g_glap_d2[l_y].l_glaq003_20
            LET g_glap_d2[l_ac].l_glaq003_21 = g_glap_d2[l_ac-1].l_glaq003_21 + g_glap_d2[l_y].l_glaq003_21
            LET g_glap_d2[l_ac].l_glaq003_22 = g_glap_d2[l_ac-1].l_glaq003_22 + g_glap_d2[l_y].l_glaq003_22
            LET g_glap_d2[l_ac].l_glaq003_23 = g_glap_d2[l_ac-1].l_glaq003_23 + g_glap_d2[l_y].l_glaq003_23
            LET g_glap_d2[l_ac].l_glaq003_24 = g_glap_d2[l_ac-1].l_glaq003_24 + g_glap_d2[l_y].l_glaq003_24
            LET g_glap_d2[l_ac].l_glaq003_25 = g_glap_d2[l_ac-1].l_glaq003_25 + g_glap_d2[l_y].l_glaq003_25
            LET g_glap_d2[l_ac].l_glaq003_26 = g_glap_d2[l_ac-1].l_glaq003_26 + g_glap_d2[l_y].l_glaq003_26
            LET g_glap_d2[l_ac].l_glaq003_27 = g_glap_d2[l_ac-1].l_glaq003_27 + g_glap_d2[l_y].l_glaq003_27
            LET g_glap_d2[l_ac].l_glaq003_28 = g_glap_d2[l_ac-1].l_glaq003_28 + g_glap_d2[l_y].l_glaq003_28
            LET g_glap_d2[l_ac].l_glaq003_29 = g_glap_d2[l_ac-1].l_glaq003_29 + g_glap_d2[l_y].l_glaq003_29
            LET g_glap_d2[l_ac].l_glaq003_30 = g_glap_d2[l_ac-1].l_glaq003_30 + g_glap_d2[l_y].l_glaq003_30
         
            LET g_glap_d2[l_ac].l_glaq004_1  = g_glap_d2[l_ac-1].l_glaq004_1  + g_glap_d2[l_y].l_glaq004_1 
            LET g_glap_d2[l_ac].l_glaq004_2  = g_glap_d2[l_ac-1].l_glaq004_2  + g_glap_d2[l_y].l_glaq004_2 
            LET g_glap_d2[l_ac].l_glaq004_3  = g_glap_d2[l_ac-1].l_glaq004_3  + g_glap_d2[l_y].l_glaq004_3 
            LET g_glap_d2[l_ac].l_glaq004_4  = g_glap_d2[l_ac-1].l_glaq004_4  + g_glap_d2[l_y].l_glaq004_4 
            LET g_glap_d2[l_ac].l_glaq004_5  = g_glap_d2[l_ac-1].l_glaq004_5  + g_glap_d2[l_y].l_glaq004_5 
            LET g_glap_d2[l_ac].l_glaq004_6  = g_glap_d2[l_ac-1].l_glaq004_6  + g_glap_d2[l_y].l_glaq004_6 
            LET g_glap_d2[l_ac].l_glaq004_7  = g_glap_d2[l_ac-1].l_glaq004_7  + g_glap_d2[l_y].l_glaq004_7 
            LET g_glap_d2[l_ac].l_glaq004_8  = g_glap_d2[l_ac-1].l_glaq004_8  + g_glap_d2[l_y].l_glaq004_8 
            LET g_glap_d2[l_ac].l_glaq004_9  = g_glap_d2[l_ac-1].l_glaq004_9  + g_glap_d2[l_y].l_glaq004_9 
            LET g_glap_d2[l_ac].l_glaq004_10 = g_glap_d2[l_ac-1].l_glaq004_10 + g_glap_d2[l_y].l_glaq004_10
            LET g_glap_d2[l_ac].l_glaq004_11 = g_glap_d2[l_ac-1].l_glaq004_11 + g_glap_d2[l_y].l_glaq004_11
            LET g_glap_d2[l_ac].l_glaq004_12 = g_glap_d2[l_ac-1].l_glaq004_12 + g_glap_d2[l_y].l_glaq004_12
            LET g_glap_d2[l_ac].l_glaq004_13 = g_glap_d2[l_ac-1].l_glaq004_13 + g_glap_d2[l_y].l_glaq004_13
            LET g_glap_d2[l_ac].l_glaq004_14 = g_glap_d2[l_ac-1].l_glaq004_14 + g_glap_d2[l_y].l_glaq004_14
            LET g_glap_d2[l_ac].l_glaq004_15 = g_glap_d2[l_ac-1].l_glaq004_15 + g_glap_d2[l_y].l_glaq004_15
            LET g_glap_d2[l_ac].l_glaq004_16 = g_glap_d2[l_ac-1].l_glaq004_16 + g_glap_d2[l_y].l_glaq004_16
            LET g_glap_d2[l_ac].l_glaq004_17 = g_glap_d2[l_ac-1].l_glaq004_17 + g_glap_d2[l_y].l_glaq004_17
            LET g_glap_d2[l_ac].l_glaq004_18 = g_glap_d2[l_ac-1].l_glaq004_18 + g_glap_d2[l_y].l_glaq004_18
            LET g_glap_d2[l_ac].l_glaq004_19 = g_glap_d2[l_ac-1].l_glaq004_19 + g_glap_d2[l_y].l_glaq004_19
            LET g_glap_d2[l_ac].l_glaq004_20 = g_glap_d2[l_ac-1].l_glaq004_20 + g_glap_d2[l_y].l_glaq004_20
            LET g_glap_d2[l_ac].l_glaq004_21 = g_glap_d2[l_ac-1].l_glaq004_21 + g_glap_d2[l_y].l_glaq004_21
            LET g_glap_d2[l_ac].l_glaq004_22 = g_glap_d2[l_ac-1].l_glaq004_22 + g_glap_d2[l_y].l_glaq004_22
            LET g_glap_d2[l_ac].l_glaq004_23 = g_glap_d2[l_ac-1].l_glaq004_23 + g_glap_d2[l_y].l_glaq004_23
            LET g_glap_d2[l_ac].l_glaq004_24 = g_glap_d2[l_ac-1].l_glaq004_24 + g_glap_d2[l_y].l_glaq004_24
            LET g_glap_d2[l_ac].l_glaq004_25 = g_glap_d2[l_ac-1].l_glaq004_25 + g_glap_d2[l_y].l_glaq004_25
            LET g_glap_d2[l_ac].l_glaq004_26 = g_glap_d2[l_ac-1].l_glaq004_26 + g_glap_d2[l_y].l_glaq004_26
            LET g_glap_d2[l_ac].l_glaq004_27 = g_glap_d2[l_ac-1].l_glaq004_27 + g_glap_d2[l_y].l_glaq004_27
            LET g_glap_d2[l_ac].l_glaq004_28 = g_glap_d2[l_ac-1].l_glaq004_28 + g_glap_d2[l_y].l_glaq004_28
            LET g_glap_d2[l_ac].l_glaq004_29 = g_glap_d2[l_ac-1].l_glaq004_29 + g_glap_d2[l_y].l_glaq004_29
            LET g_glap_d2[l_ac].l_glaq004_30 = g_glap_d2[l_ac-1].l_glaq004_30 + g_glap_d2[l_y].l_glaq004_30
         END IF
         #紀錄本年累計所在的位置
         LET l_y = l_ac                 
         CALL aglq320_reset(l_ac,'2')  
         #本年累計餘額
         LET g_glap_d2[l_ac].l_amt = g_glap_d2[l_ac-1].l_amt
          IF cl_null(g_glap_d2[l_ac].l_amt) THEN LET g_glap_d2[l_ac].l_amt = 0 END IF
         CASE 
            WHEN g_glap_d2[l_ac].l_amt > 0  
               CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #借  
            WHEN g_glap_d[l_ac].l_amt < 0 
               CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #貸
            WHEN g_glap_d[l_ac].l_amt = 0
               CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #平
         END CASE                                             
         LET l_ac = l_ac +1  
         LET l_m = l_ac-3
      END IF
      
      LET l_glap004_t = g_glap_d2[l_ac].glap004      
      LET l_glap[l_ac].idx     = l_ac
      LET l_glap[l_ac].glap004 = g_glap_d2[l_ac].glap004 
      
      LET l_ac = l_ac +1
      
   END FOREACH
   
   CALL g_glap_d2.deleteElement(g_glap_d2.getLength())
   IF l_ac > 1 THEN #本期合計     
      LET l_glap002_t = g_glap_d2[l_ac-1].glap002 #紀錄本期年度
      INITIALIZE g_glap_d2[l_ac].* TO NULL
      LET g_glap_d2[l_ac].l_glaq001 = s_desc_gzcbl004_desc('9927','2')
      CALL aglq320_reset(l_ac,'1')  
      FOR l_idx = 1 TO l_glap.getLength()  
         IF l_glap004_t = l_glap[l_idx].glap004  THEN                   
            LET g_glap_d2[l_ac].l_glaq003_1  = g_glap_d2[l_ac].l_glaq003_1  + g_glap_d2[l_idx].l_glaq003_1 
            LET g_glap_d2[l_ac].l_glaq003_2  = g_glap_d2[l_ac].l_glaq003_2  + g_glap_d2[l_idx].l_glaq003_2 
            LET g_glap_d2[l_ac].l_glaq003_3  = g_glap_d2[l_ac].l_glaq003_3  + g_glap_d2[l_idx].l_glaq003_3 
            LET g_glap_d2[l_ac].l_glaq003_4  = g_glap_d2[l_ac].l_glaq003_4  + g_glap_d2[l_idx].l_glaq003_4 
            LET g_glap_d2[l_ac].l_glaq003_5  = g_glap_d2[l_ac].l_glaq003_5  + g_glap_d2[l_idx].l_glaq003_5 
            LET g_glap_d2[l_ac].l_glaq003_6  = g_glap_d2[l_ac].l_glaq003_6  + g_glap_d2[l_idx].l_glaq003_6 
            LET g_glap_d2[l_ac].l_glaq003_7  = g_glap_d2[l_ac].l_glaq003_7  + g_glap_d2[l_idx].l_glaq003_7 
            LET g_glap_d2[l_ac].l_glaq003_8  = g_glap_d2[l_ac].l_glaq003_8  + g_glap_d2[l_idx].l_glaq003_8 
            LET g_glap_d2[l_ac].l_glaq003_9  = g_glap_d2[l_ac].l_glaq003_9  + g_glap_d2[l_idx].l_glaq003_9 
            LET g_glap_d2[l_ac].l_glaq003_10 = g_glap_d2[l_ac].l_glaq003_10 + g_glap_d2[l_idx].l_glaq003_15
            LET g_glap_d2[l_ac].l_glaq003_11 = g_glap_d2[l_ac].l_glaq003_11 + g_glap_d2[l_idx].l_glaq003_11
            LET g_glap_d2[l_ac].l_glaq003_12 = g_glap_d2[l_ac].l_glaq003_12 + g_glap_d2[l_idx].l_glaq003_12
            LET g_glap_d2[l_ac].l_glaq003_13 = g_glap_d2[l_ac].l_glaq003_13 + g_glap_d2[l_idx].l_glaq003_13
            LET g_glap_d2[l_ac].l_glaq003_14 = g_glap_d2[l_ac].l_glaq003_14 + g_glap_d2[l_idx].l_glaq003_14
            LET g_glap_d2[l_ac].l_glaq003_15 = g_glap_d2[l_ac].l_glaq003_15 + g_glap_d2[l_idx].l_glaq003_15
            LET g_glap_d2[l_ac].l_glaq003_16 = g_glap_d2[l_ac].l_glaq003_16 + g_glap_d2[l_idx].l_glaq003_15
            LET g_glap_d2[l_ac].l_glaq003_17 = g_glap_d2[l_ac].l_glaq003_17 + g_glap_d2[l_idx].l_glaq003_15
            LET g_glap_d2[l_ac].l_glaq003_18 = g_glap_d2[l_ac].l_glaq003_18 + g_glap_d2[l_idx].l_glaq003_15
            LET g_glap_d2[l_ac].l_glaq003_19 = g_glap_d2[l_ac].l_glaq003_19 + g_glap_d2[l_idx].l_glaq003_15
            LET g_glap_d2[l_ac].l_glaq003_20 = g_glap_d2[l_ac].l_glaq003_20 + g_glap_d2[l_idx].l_glaq003_15
            LET g_glap_d2[l_ac].l_glaq003_21 = g_glap_d2[l_ac].l_glaq003_21 + g_glap_d2[l_idx].l_glaq003_15
            LET g_glap_d2[l_ac].l_glaq003_22 = g_glap_d2[l_ac].l_glaq003_22 + g_glap_d2[l_idx].l_glaq003_15
         END IF            
      END FOR
      CALL aglq320_reset(l_ac,'2')    
      LET g_glap_d2[l_ac].l_amt = g_glap_d2[l_ac-1].l_amt
      IF cl_null(g_glap_d2[l_ac].l_amt) THEN LET g_glap_d2[l_ac].l_amt = 0 END IF
      CASE 
         WHEN g_glap_d2[l_ac].l_amt > 0  
            CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #借  
         WHEN g_glap_d[l_ac].l_amt < 0 
            CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #貸
         WHEN g_glap_d[l_ac].l_amt = 0
            CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #平
      END CASE       
      #本年合計
      LET l_ac = l_ac +1
      LET g_glap_d2[l_ac].glap002 = ''
      LET g_glap_d2[l_ac].glap004 = ''
      LET g_glap_d2[l_ac].glapdocdt = ''
      LET g_glap_d2[l_ac].glapdocno = '' 
      LET g_glap_d2[l_ac].l_glaq001 = s_desc_gzcbl004_desc('9927','3')
      LET g_glap_d2[l_ac].l_glaq005 = ''
      LET g_glap_d2[l_ac].l_glaq010 = ''
      LET g_glap_d2[l_ac].l_glaq006 = ''
      CALL aglq320_reset(l_ac,'1')
      IF l_glap002_t <> g_glap_d2[l_m].glap002 THEN
         LET g_glap_d2[l_ac].l_glaq003_1  = g_glap_d2[l_ac-1].l_glaq003_1  
         LET g_glap_d2[l_ac].l_glaq003_2  = g_glap_d2[l_ac-1].l_glaq003_2  
         LET g_glap_d2[l_ac].l_glaq003_3  = g_glap_d2[l_ac-1].l_glaq003_3  
         LET g_glap_d2[l_ac].l_glaq003_4  = g_glap_d2[l_ac-1].l_glaq003_4  
         LET g_glap_d2[l_ac].l_glaq003_5  = g_glap_d2[l_ac-1].l_glaq003_5  
         LET g_glap_d2[l_ac].l_glaq003_6  = g_glap_d2[l_ac-1].l_glaq003_6  
         LET g_glap_d2[l_ac].l_glaq003_7  = g_glap_d2[l_ac-1].l_glaq003_7  
         LET g_glap_d2[l_ac].l_glaq003_8  = g_glap_d2[l_ac-1].l_glaq003_8  
         LET g_glap_d2[l_ac].l_glaq003_9  = g_glap_d2[l_ac-1].l_glaq003_9  
         LET g_glap_d2[l_ac].l_glaq003_10 = g_glap_d2[l_ac-1].l_glaq003_10 
         LET g_glap_d2[l_ac].l_glaq003_11 = g_glap_d2[l_ac-1].l_glaq003_11 
         LET g_glap_d2[l_ac].l_glaq003_12 = g_glap_d2[l_ac-1].l_glaq003_12 
         LET g_glap_d2[l_ac].l_glaq003_13 = g_glap_d2[l_ac-1].l_glaq003_13 
         LET g_glap_d2[l_ac].l_glaq003_14 = g_glap_d2[l_ac-1].l_glaq003_14 
         LET g_glap_d2[l_ac].l_glaq003_15 = g_glap_d2[l_ac-1].l_glaq003_15 
         LET g_glap_d2[l_ac].l_glaq003_16 = g_glap_d2[l_ac-1].l_glaq003_16 
         LET g_glap_d2[l_ac].l_glaq003_17 = g_glap_d2[l_ac-1].l_glaq003_17 
         LET g_glap_d2[l_ac].l_glaq003_18 = g_glap_d2[l_ac-1].l_glaq003_18 
         LET g_glap_d2[l_ac].l_glaq003_19 = g_glap_d2[l_ac-1].l_glaq003_19 
         LET g_glap_d2[l_ac].l_glaq003_20 = g_glap_d2[l_ac-1].l_glaq003_20 
         LET g_glap_d2[l_ac].l_glaq003_21 = g_glap_d2[l_ac-1].l_glaq003_21 
         LET g_glap_d2[l_ac].l_glaq003_22 = g_glap_d2[l_ac-1].l_glaq003_22 
         LET g_glap_d2[l_ac].l_glaq003_23 = g_glap_d2[l_ac-1].l_glaq003_23 
         LET g_glap_d2[l_ac].l_glaq003_24 = g_glap_d2[l_ac-1].l_glaq003_24 
         LET g_glap_d2[l_ac].l_glaq003_25 = g_glap_d2[l_ac-1].l_glaq003_25 
         LET g_glap_d2[l_ac].l_glaq003_26 = g_glap_d2[l_ac-1].l_glaq003_26 
         LET g_glap_d2[l_ac].l_glaq003_27 = g_glap_d2[l_ac-1].l_glaq003_27 
         LET g_glap_d2[l_ac].l_glaq003_28 = g_glap_d2[l_ac-1].l_glaq003_28 
         LET g_glap_d2[l_ac].l_glaq003_29 = g_glap_d2[l_ac-1].l_glaq003_29 
         LET g_glap_d2[l_ac].l_glaq003_30 = g_glap_d2[l_ac-1].l_glaq003_30
         
         LET g_glap_d2[l_ac].l_glaq004_1  = g_glap_d2[l_ac-1].l_glaq004_1  
         LET g_glap_d2[l_ac].l_glaq004_2  = g_glap_d2[l_ac-1].l_glaq004_2  
         LET g_glap_d2[l_ac].l_glaq004_3  = g_glap_d2[l_ac-1].l_glaq004_3  
         LET g_glap_d2[l_ac].l_glaq004_4  = g_glap_d2[l_ac-1].l_glaq004_4  
         LET g_glap_d2[l_ac].l_glaq004_5  = g_glap_d2[l_ac-1].l_glaq004_5  
         LET g_glap_d2[l_ac].l_glaq004_6  = g_glap_d2[l_ac-1].l_glaq004_6  
         LET g_glap_d2[l_ac].l_glaq004_7  = g_glap_d2[l_ac-1].l_glaq004_7  
         LET g_glap_d2[l_ac].l_glaq004_8  = g_glap_d2[l_ac-1].l_glaq004_8  
         LET g_glap_d2[l_ac].l_glaq004_9  = g_glap_d2[l_ac-1].l_glaq004_9  
         LET g_glap_d2[l_ac].l_glaq004_10 = g_glap_d2[l_ac-1].l_glaq004_10 
         LET g_glap_d2[l_ac].l_glaq004_11 = g_glap_d2[l_ac-1].l_glaq004_11 
         LET g_glap_d2[l_ac].l_glaq004_12 = g_glap_d2[l_ac-1].l_glaq004_12 
         LET g_glap_d2[l_ac].l_glaq004_13 = g_glap_d2[l_ac-1].l_glaq004_13 
         LET g_glap_d2[l_ac].l_glaq004_14 = g_glap_d2[l_ac-1].l_glaq004_14 
         LET g_glap_d2[l_ac].l_glaq004_15 = g_glap_d2[l_ac-1].l_glaq004_15 
         LET g_glap_d2[l_ac].l_glaq004_16 = g_glap_d2[l_ac-1].l_glaq004_16 
         LET g_glap_d2[l_ac].l_glaq004_17 = g_glap_d2[l_ac-1].l_glaq004_17 
         LET g_glap_d2[l_ac].l_glaq004_18 = g_glap_d2[l_ac-1].l_glaq004_18 
         LET g_glap_d2[l_ac].l_glaq004_19 = g_glap_d2[l_ac-1].l_glaq004_19 
         LET g_glap_d2[l_ac].l_glaq004_20 = g_glap_d2[l_ac-1].l_glaq004_20 
         LET g_glap_d2[l_ac].l_glaq004_21 = g_glap_d2[l_ac-1].l_glaq004_21 
         LET g_glap_d2[l_ac].l_glaq004_22 = g_glap_d2[l_ac-1].l_glaq004_22 
         LET g_glap_d2[l_ac].l_glaq004_23 = g_glap_d2[l_ac-1].l_glaq004_23 
         LET g_glap_d2[l_ac].l_glaq004_24 = g_glap_d2[l_ac-1].l_glaq004_24 
         LET g_glap_d2[l_ac].l_glaq004_25 = g_glap_d2[l_ac-1].l_glaq004_25 
         LET g_glap_d2[l_ac].l_glaq004_26 = g_glap_d2[l_ac-1].l_glaq004_26 
         LET g_glap_d2[l_ac].l_glaq004_27 = g_glap_d2[l_ac-1].l_glaq004_27 
         LET g_glap_d2[l_ac].l_glaq004_28 = g_glap_d2[l_ac-1].l_glaq004_28 
         LET g_glap_d2[l_ac].l_glaq004_29 = g_glap_d2[l_ac-1].l_glaq004_29 
         LET g_glap_d2[l_ac].l_glaq004_30 = g_glap_d2[l_ac-1].l_glaq004_30        
      ELSE         
         LET g_glap_d2[l_ac].l_glaq003_1  = g_glap_d2[l_ac-1].l_glaq003_1  +  g_glap_d2[l_y].l_glaq003_1 
         LET g_glap_d2[l_ac].l_glaq003_2  = g_glap_d2[l_ac-1].l_glaq003_2  +  g_glap_d2[l_y].l_glaq003_2 
         LET g_glap_d2[l_ac].l_glaq003_3  = g_glap_d2[l_ac-1].l_glaq003_3  +  g_glap_d2[l_y].l_glaq003_3 
         LET g_glap_d2[l_ac].l_glaq003_4  = g_glap_d2[l_ac-1].l_glaq003_4  +  g_glap_d2[l_y].l_glaq003_4 
         LET g_glap_d2[l_ac].l_glaq003_5  = g_glap_d2[l_ac-1].l_glaq003_5  +  g_glap_d2[l_y].l_glaq003_5 
         LET g_glap_d2[l_ac].l_glaq003_6  = g_glap_d2[l_ac-1].l_glaq003_6  +  g_glap_d2[l_y].l_glaq003_6 
         LET g_glap_d2[l_ac].l_glaq003_7  = g_glap_d2[l_ac-1].l_glaq003_7  +  g_glap_d2[l_y].l_glaq003_7 
         LET g_glap_d2[l_ac].l_glaq003_8  = g_glap_d2[l_ac-1].l_glaq003_8  +  g_glap_d2[l_y].l_glaq003_8 
         LET g_glap_d2[l_ac].l_glaq003_9  = g_glap_d2[l_ac-1].l_glaq003_9  +  g_glap_d2[l_y].l_glaq003_9 
         LET g_glap_d2[l_ac].l_glaq003_10 = g_glap_d2[l_ac-1].l_glaq003_10 +  g_glap_d2[l_y].l_glaq003_10
         LET g_glap_d2[l_ac].l_glaq003_11 = g_glap_d2[l_ac-1].l_glaq003_11 +  g_glap_d2[l_y].l_glaq003_11
         LET g_glap_d2[l_ac].l_glaq003_12 = g_glap_d2[l_ac-1].l_glaq003_12 +  g_glap_d2[l_y].l_glaq003_12
         LET g_glap_d2[l_ac].l_glaq003_13 = g_glap_d2[l_ac-1].l_glaq003_13 +  g_glap_d2[l_y].l_glaq003_13
         LET g_glap_d2[l_ac].l_glaq003_14 = g_glap_d2[l_ac-1].l_glaq003_14 +  g_glap_d2[l_y].l_glaq003_14
         LET g_glap_d2[l_ac].l_glaq003_15 = g_glap_d2[l_ac-1].l_glaq003_15 +  g_glap_d2[l_y].l_glaq003_15
         LET g_glap_d2[l_ac].l_glaq003_16 = g_glap_d2[l_ac-1].l_glaq003_16 +  g_glap_d2[l_y].l_glaq003_16
         LET g_glap_d2[l_ac].l_glaq003_17 = g_glap_d2[l_ac-1].l_glaq003_17 +  g_glap_d2[l_y].l_glaq003_17
         LET g_glap_d2[l_ac].l_glaq003_18 = g_glap_d2[l_ac-1].l_glaq003_18 +  g_glap_d2[l_y].l_glaq003_18
         LET g_glap_d2[l_ac].l_glaq003_19 = g_glap_d2[l_ac-1].l_glaq003_19 +  g_glap_d2[l_y].l_glaq003_19
         LET g_glap_d2[l_ac].l_glaq003_20 = g_glap_d2[l_ac-1].l_glaq003_20 +  g_glap_d2[l_y].l_glaq003_20
         LET g_glap_d2[l_ac].l_glaq003_21 = g_glap_d2[l_ac-1].l_glaq003_21 +  g_glap_d2[l_y].l_glaq003_21
         LET g_glap_d2[l_ac].l_glaq003_22 = g_glap_d2[l_ac-1].l_glaq003_22 +  g_glap_d2[l_y].l_glaq003_22
         LET g_glap_d2[l_ac].l_glaq003_23 = g_glap_d2[l_ac-1].l_glaq003_23 +  g_glap_d2[l_y].l_glaq003_23
         LET g_glap_d2[l_ac].l_glaq003_24 = g_glap_d2[l_ac-1].l_glaq003_24 +  g_glap_d2[l_y].l_glaq003_24
         LET g_glap_d2[l_ac].l_glaq003_25 = g_glap_d2[l_ac-1].l_glaq003_25 +  g_glap_d2[l_y].l_glaq003_25
         LET g_glap_d2[l_ac].l_glaq003_26 = g_glap_d2[l_ac-1].l_glaq003_26 +  g_glap_d2[l_y].l_glaq003_26
         LET g_glap_d2[l_ac].l_glaq003_27 = g_glap_d2[l_ac-1].l_glaq003_27 +  g_glap_d2[l_y].l_glaq003_27
         LET g_glap_d2[l_ac].l_glaq003_28 = g_glap_d2[l_ac-1].l_glaq003_28 +  g_glap_d2[l_y].l_glaq003_28
         LET g_glap_d2[l_ac].l_glaq003_29 = g_glap_d2[l_ac-1].l_glaq003_29 +  g_glap_d2[l_y].l_glaq003_29
         LET g_glap_d2[l_ac].l_glaq003_30 = g_glap_d2[l_ac-1].l_glaq003_30 +  g_glap_d2[l_y].l_glaq003_30    
         
         LET g_glap_d2[l_ac].l_glaq004_1  = g_glap_d2[l_ac-1].l_glaq004_1  + g_glap_d2[l_y].l_glaq004_1 
         LET g_glap_d2[l_ac].l_glaq004_2  = g_glap_d2[l_ac-1].l_glaq004_2  + g_glap_d2[l_y].l_glaq004_2 
         LET g_glap_d2[l_ac].l_glaq004_3  = g_glap_d2[l_ac-1].l_glaq004_3  + g_glap_d2[l_y].l_glaq004_3 
         LET g_glap_d2[l_ac].l_glaq004_4  = g_glap_d2[l_ac-1].l_glaq004_4  + g_glap_d2[l_y].l_glaq004_4 
         LET g_glap_d2[l_ac].l_glaq004_5  = g_glap_d2[l_ac-1].l_glaq004_5  + g_glap_d2[l_y].l_glaq004_5 
         LET g_glap_d2[l_ac].l_glaq004_6  = g_glap_d2[l_ac-1].l_glaq004_6  + g_glap_d2[l_y].l_glaq004_6 
         LET g_glap_d2[l_ac].l_glaq004_7  = g_glap_d2[l_ac-1].l_glaq004_7  + g_glap_d2[l_y].l_glaq004_7 
         LET g_glap_d2[l_ac].l_glaq004_8  = g_glap_d2[l_ac-1].l_glaq004_8  + g_glap_d2[l_y].l_glaq004_8 
         LET g_glap_d2[l_ac].l_glaq004_9  = g_glap_d2[l_ac-1].l_glaq004_9  + g_glap_d2[l_y].l_glaq004_9 
         LET g_glap_d2[l_ac].l_glaq004_10 = g_glap_d2[l_ac-1].l_glaq004_10 + g_glap_d2[l_y].l_glaq004_10
         LET g_glap_d2[l_ac].l_glaq004_11 = g_glap_d2[l_ac-1].l_glaq004_11 + g_glap_d2[l_y].l_glaq004_11
         LET g_glap_d2[l_ac].l_glaq004_12 = g_glap_d2[l_ac-1].l_glaq004_12 + g_glap_d2[l_y].l_glaq004_12
         LET g_glap_d2[l_ac].l_glaq004_13 = g_glap_d2[l_ac-1].l_glaq004_13 + g_glap_d2[l_y].l_glaq004_13
         LET g_glap_d2[l_ac].l_glaq004_14 = g_glap_d2[l_ac-1].l_glaq004_14 + g_glap_d2[l_y].l_glaq004_14
         LET g_glap_d2[l_ac].l_glaq004_15 = g_glap_d2[l_ac-1].l_glaq004_15 + g_glap_d2[l_y].l_glaq004_15
         LET g_glap_d2[l_ac].l_glaq004_16 = g_glap_d2[l_ac-1].l_glaq004_16 + g_glap_d2[l_y].l_glaq004_16
         LET g_glap_d2[l_ac].l_glaq004_17 = g_glap_d2[l_ac-1].l_glaq004_17 + g_glap_d2[l_y].l_glaq004_17
         LET g_glap_d2[l_ac].l_glaq004_18 = g_glap_d2[l_ac-1].l_glaq004_18 + g_glap_d2[l_y].l_glaq004_18
         LET g_glap_d2[l_ac].l_glaq004_19 = g_glap_d2[l_ac-1].l_glaq004_19 + g_glap_d2[l_y].l_glaq004_19
         LET g_glap_d2[l_ac].l_glaq004_20 = g_glap_d2[l_ac-1].l_glaq004_20 + g_glap_d2[l_y].l_glaq004_20
         LET g_glap_d2[l_ac].l_glaq004_21 = g_glap_d2[l_ac-1].l_glaq004_21 + g_glap_d2[l_y].l_glaq004_21
         LET g_glap_d2[l_ac].l_glaq004_22 = g_glap_d2[l_ac-1].l_glaq004_22 + g_glap_d2[l_y].l_glaq004_22
         LET g_glap_d2[l_ac].l_glaq004_23 = g_glap_d2[l_ac-1].l_glaq004_23 + g_glap_d2[l_y].l_glaq004_23
         LET g_glap_d2[l_ac].l_glaq004_24 = g_glap_d2[l_ac-1].l_glaq004_24 + g_glap_d2[l_y].l_glaq004_24
         LET g_glap_d2[l_ac].l_glaq004_25 = g_glap_d2[l_ac-1].l_glaq004_25 + g_glap_d2[l_y].l_glaq004_25
         LET g_glap_d2[l_ac].l_glaq004_26 = g_glap_d2[l_ac-1].l_glaq004_26 + g_glap_d2[l_y].l_glaq004_26
         LET g_glap_d2[l_ac].l_glaq004_27 = g_glap_d2[l_ac-1].l_glaq004_27 + g_glap_d2[l_y].l_glaq004_27
         LET g_glap_d2[l_ac].l_glaq004_28 = g_glap_d2[l_ac-1].l_glaq004_28 + g_glap_d2[l_y].l_glaq004_28
         LET g_glap_d2[l_ac].l_glaq004_29 = g_glap_d2[l_ac-1].l_glaq004_29 + g_glap_d2[l_y].l_glaq004_29
         LET g_glap_d2[l_ac].l_glaq004_30 = g_glap_d2[l_ac-1].l_glaq004_30 + g_glap_d2[l_y].l_glaq004_30
      END IF
      CALL aglq320_reset(l_ac,'2')
      LET g_glap_d2[l_ac].l_amt = g_glap_d2[l_ac-1].l_amt  
      IF cl_null(g_glap_d2[l_ac].l_amt) THEN LET g_glap_d2[l_ac].l_amt = 0 END IF
      CASE 
         WHEN g_glap_d2[l_ac].l_amt > 0  
            CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #借  
         WHEN g_glap_d[l_ac].l_amt < 0 
            CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #貸
         WHEN g_glap_d[l_ac].l_amt = 0
            CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d2[l_ac].l_dc  #平
      END CASE        
   END IF 
   
END FUNCTION

################################################################################
# Descriptions...: 填充本位幣三
# Memo...........:
# Usage..........: CALL aglq320_b_fill3()
# Date & Author..: 2015/12/28 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq320_b_fill3()
DEFINE l_sql STRING
DEFINE l_i          LIKE type_t.num5
DEFINE l_j          LIKE type_t.num5
DEFINE l_glac002    LIKE glac_t.glac002
DEFINE l_glaq003    LIKE glaq_t.glaq003
DEFINE l_glaq0031   LIKE glaq_t.glaq003
DEFINE l_glaq004    LIKE glaq_t.glaq004
DEFINE l_glaq0041   LIKE glaq_t.glaq004 
DEFINE l_glac DYNAMIC ARRAY OF RECORD
          idx       LIKE type_t.num5,   
          glac002   LIKE glac_t.glac002
   END RECORD
DEFINE l_glap DYNAMIC ARRAY OF RECORD
          idx       LIKE type_t.num5,
        glap004     LIKE glap_t.glap004          
    END RECORD        
DEFINE l_glac008    LIKE glac_t.glac008
DEFINE l_idx        LIKE type_t.num5
DEFINE l_mon        LIKE glaq_t.glaq003
DEFINE l_glaq002_t  LIKE glaq_t.glaq002
DEFINE l_glap002_t  LIKE glap_t.glap002 #年度
DEFINE l_glap002_o  LIKE glap_t.glap002
DEFINE l_glap004_t  LIKE glap_t.glap004 
DEFINE l_y          LIKE type_t.num5
DEFINE l_m          LIKE type_t.num5

   CALL g_glap_d3.clear()
   CALL l_glac.clear()
   LET l_sql = " SELECT glac002,glac008                 ",
               "  FROM glac_t                           ",
               " WHERE glacent = '",g_enterprise,"'     ",
               "   AND glac001 = '",g_glaa.glaa004,"'   ",
               "   AND glac004 = '",g_input.glaq002,"'  ",           
               " ORDER BY glac002                       "
   LET l_i = 1 LET l_j = 31
   PREPARE aglq320_set_pr04 FROM l_sql
   DECLARE aglq320_set_cs04 CURSOR FOR aglq320_set_pr04
   FOREACH aglq320_set_cs04 INTO l_glac002,l_glac008
      IF g_input.glaq002 = l_glac002 THEN CONTINUE FOREACH END IF
      IF l_glac008 = '1'  THEN     #開啟借方科目        
         LET l_glac[l_i].glac002 = l_glac002
         LET l_glac[l_i].idx = l_i
         LET l_i = l_i +1 
      ELSE #開啟貸方科目
         LET l_glac[l_j].glac002 = l_glac002
         LET l_glac[l_j].idx = l_j
         LET l_j = l_j +1 
      END IF
   END FOREACH   
                            
   LET g_sql = "  SELECT glap002,glap004,glapdocdt,glapdocno,glaq001,    ",
               "         glaq005,glaq010,glaq006,glaq043,glaq044,glaq002 ",
               "    FROM aglq320_tmp                                     ",
               "   WHERE l_flag IN ('2')                                 ",
               "   ORDER BY l_flag,glapdocdt                             "    
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1     
   LET l_i =  1
   LET l_glaq002_t =''
   LET l_glap002_t = ''
   LET l_glap002_o = ''
   LET l_glap004_t =''
   PREPARE aglq320_bfill_pb3 FROM g_sql
   DECLARE aglq320_bfill_cs3 CURSOR FOR aglq320_bfill_pb3              
   FOREACH aglq320_bfill_cs3 INTO 
      g_glap_d3[l_ac].glap002,g_glap_d3[l_ac].glap004,g_glap_d3[l_ac].glapdocdt,g_glap_d3[l_ac].glapdocno, 
      g_glap_d3[l_ac].l_glaq001,g_glap_d3[l_ac].l_glaq005,g_glap_d3[l_ac].l_glaq010,g_glap_d3[l_ac].l_glaq006,
      l_glaq003,l_glaq004,l_glac002
      IF cl_null(l_glaq003) THEN LET l_glaq003 = 0 END IF
      IF cl_null(l_glaq004) THEN LET l_glaq004 = 0 END IF
      #取得科目科餘方向
      SELECT glac008 INTO l_glac008 FROM glac_t
       WHERE glacent = g_enterprise
         AND glac001 = g_glaa.glaa004   
         AND glac002 = l_glac002                  
      
      IF l_ac = 1 THEN #期初     
         LET g_glap_d3[l_ac + 1].* = g_glap_d3[l_ac].*
         LET g_glap_d3[l_ac].glap002 = ''
         LET g_glap_d3[l_ac].glap004 = ''
         LET g_glap_d3[l_ac].glapdocdt = ''
         LET g_glap_d3[l_ac].glapdocno = '' 
         LET g_glap_d3[l_ac].l_glaq001 = s_desc_gzcbl004_desc('9927','1')
         LET g_glap_d3[l_ac].l_glaq005 = ''
         LET g_glap_d3[l_ac].l_glaq010 = ''
         LET g_glap_d3[l_ac].l_glaq006 = ''

         PREPARE aglq320_pb6 FROM " SELECT DISTINCT glaq002 FROM aglq320_tmp " 
         DECLARE aglq320_cs6 CURSOR FOR aglq320_pb6
         FOREACH aglq320_cs6 INTO l_glaq002_t         
            FOR l_idx = 1 TO 30
               IF l_glaq002_t = l_glac[l_idx].glac002 THEN  
                  SELECT glaq043,glaq044                   
                    INTO l_glaq0031,l_glaq0041 FROM aglq320_tmp
                   WHERE glaq002 = l_glaq002_t AND l_flag = 1 
                  IF cl_null(l_glaq0031) THEN LET l_glaq0031 = 0 END IF
                  IF cl_null(l_glaq0041) THEN LET l_glaq0041 = 0 END IF
                  #借-貸 期初
                  LET l_mon =  l_glaq0031 - l_glaq0041
                     IF l_glac008 = 1 THEN 
                     CASE l_idx
                        WHEN 1    
                           LET g_glap_d3[l_ac].l_glaq003_1  = l_mon
                        WHEN 2
                           LET g_glap_d3[l_ac].l_glaq003_2  = l_mon
                        WHEN 3
                           LET g_glap_d3[l_ac].l_glaq003_3  = l_mon
                        WHEN 4   
                           LET g_glap_d3[l_ac].l_glaq003_4  = l_mon
                        WHEN 5   
                           LET g_glap_d3[l_ac].l_glaq003_5  = l_mon
                        WHEN 6
                           LET g_glap_d3[l_ac].l_glaq003_6  = l_mon
                        WHEN 7
                           LET g_glap_d3[l_ac].l_glaq003_7  = l_mon
                        WHEN 8
                           LET g_glap_d3[l_ac].l_glaq003_8  = l_mon
                        WHEN 9
                           LET g_glap_d3[l_ac].l_glaq003_9  = l_mon
                        WHEN 10
                           LET g_glap_d3[l_ac].l_glaq003_10 = l_mon
                        WHEN 11
                           LET g_glap_d3[l_ac].l_glaq003_11 = l_mon
                        WHEN 12
                           LET g_glap_d3[l_ac].l_glaq003_12 = l_mon
                        WHEN 13
                           LET g_glap_d3[l_ac].l_glaq003_13 = l_mon
                        WHEN 14
                           LET g_glap_d3[l_ac].l_glaq003_14 = l_mon
                        WHEN 15
                           LET g_glap_d3[l_ac].l_glaq003_15 = l_mon
                        WHEN 16
                           LET g_glap_d3[l_ac].l_glaq003_16 = l_mon
                        WHEN 17
                           LET g_glap_d3[l_ac].l_glaq003_17 = l_mon
                        WHEN 18
                           LET g_glap_d3[l_ac].l_glaq003_18 = l_mon
                        WHEN 19
                           LET g_glap_d3[l_ac].l_glaq003_19 = l_mon
                        WHEN 20
                           LET g_glap_d3[l_ac].l_glaq003_20 = l_mon
                        WHEN 21
                           LET g_glap_d3[l_ac].l_glaq003_21 = l_mon
                        WHEN 22
                           LET g_glap_d3[l_ac].l_glaq003_22 = l_mon
                        WHEN 23
                           LET g_glap_d3[l_ac].l_glaq003_23 = l_mon
                        WHEN 24
                           LET g_glap_d3[l_ac].l_glaq003_24 = l_mon
                        WHEN 25
                           LET g_glap_d3[l_ac].l_glaq003_25 = l_mon
                        WHEN 26
                           LET g_glap_d3[l_ac].l_glaq003_26 = l_mon
                        WHEN 27
                           LET g_glap_d3[l_ac].l_glaq003_27 = l_mon
                        WHEN 28
                           LET g_glap_d3[l_ac].l_glaq003_28 = l_mon
                        WHEN 29
                           LET g_glap_d3[l_ac].l_glaq003_29 = l_mon
                        WHEN 30
                           LET g_glap_d3[l_ac].l_glaq003_30 = l_mon               
                     END CASE
                  ELSE
                     CASE l_idx
                        WHEN 31    
                           LET g_glap_d3[l_ac].l_glaq004_1  = l_mon
                        WHEN 32
                           LET g_glap_d3[l_ac].l_glaq004_2  = l_mon
                        WHEN 33
                           LET g_glap_d3[l_ac].l_glaq004_3  = l_mon
                        WHEN 34   
                           LET g_glap_d3[l_ac].l_glaq004_4  = l_mon
                        WHEN 35   
                           LET g_glap_d3[l_ac].l_glaq004_5  = l_mon
                        WHEN 36
                           LET g_glap_d3[l_ac].l_glaq004_6  = l_mon
                        WHEN 37
                           LET g_glap_d3[l_ac].l_glaq004_7  = l_mon
                        WHEN 38
                           LET g_glap_d3[l_ac].l_glaq004_8  = l_mon
                        WHEN 39
                           LET g_glap_d3[l_ac].l_glaq004_9  = l_mon
                        WHEN 40
                           LET g_glap_d3[l_ac].l_glaq004_10 = l_mon
                        WHEN 41
                           LET g_glap_d3[l_ac].l_glaq004_11 = l_mon
                        WHEN 42
                           LET g_glap_d3[l_ac].l_glaq004_12 = l_mon
                        WHEN 43
                           LET g_glap_d3[l_ac].l_glaq004_13 = l_mon
                        WHEN 44
                           LET g_glap_d3[l_ac].l_glaq004_14 = l_mon
                        WHEN 45
                           LET g_glap_d3[l_ac].l_glaq004_15 = l_mon
                        WHEN 46
                           LET g_glap_d3[l_ac].l_glaq004_16 = l_mon
                        WHEN 47
                           LET g_glap_d3[l_ac].l_glaq004_17 = l_mon
                        WHEN 48
                           LET g_glap_d3[l_ac].l_glaq004_18 = l_mon
                        WHEN 49
                           LET g_glap_d3[l_ac].l_glaq004_19 = l_mon
                        WHEN 50
                           LET g_glap_d3[l_ac].l_glaq004_20 = l_mon
                        WHEN 51
                           LET g_glap_d3[l_ac].l_glaq004_21 = l_mon
                        WHEN 52
                           LET g_glap_d3[l_ac].l_glaq004_22 = l_mon
                        WHEN 53
                           LET g_glap_d3[l_ac].l_glaq004_23 = l_mon
                        WHEN 54
                           LET g_glap_d3[l_ac].l_glaq004_24 = l_mon
                        WHEN 55
                           LET g_glap_d3[l_ac].l_glaq004_25 = l_mon
                        WHEN 56
                           LET g_glap_d3[l_ac].l_glaq004_26 = l_mon
                        WHEN 57
                           LET g_glap_d3[l_ac].l_glaq004_27 = l_mon
                        WHEN 58
                           LET g_glap_d3[l_ac].l_glaq004_28 = l_mon
                        WHEN 59
                           LET g_glap_d3[l_ac].l_glaq004_29 = l_mon
                        WHEN 60
                           LET g_glap_d3[l_ac].l_glaq004_30 = l_mon 
                     END CASE
                  END IF                 
               END IF             
            END FOR  
         END FOREACH    
         CALL aglq320_reset(l_ac,'1')
         CALL aglq320_reset(l_ac,'2')  
         LET g_glap_d3[l_ac].l_amt =  g_glap_d3[l_ac].l_glaq003_0 -  g_glap_d3[l_ac].l_glaq004_0    
         IF cl_null(g_glap_d3[l_ac].l_amt) THEN LET g_glap_d3[l_ac].l_amt = 0 END IF
         CASE 
            WHEN g_glap_d3[l_ac].l_amt > 0  
               CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #借  
            WHEN g_glap_d[l_ac].l_amt < 0 
               CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #貸
            WHEN g_glap_d[l_ac].l_amt = 0
               CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #平
         END CASE         
         #紀錄本年累計       
         LET l_y = 1  
         LET l_m = 1         
         LET l_ac = l_ac + 1 
      END IF 
      
      #借方科目      
      IF l_glac008 = 1 THEN
         IF l_glaq003 <> 0 THEN
             FOR l_idx = 1 TO 30
                IF l_glac002 = l_glac[l_idx].glac002 THEN                                   
                   EXIT FOR          
                END IF             
             END FOR
             LET l_mon = l_glaq003
          END IF
          IF l_glaq004 <> 0 THEN
             FOR l_idx = 1 TO 30
                IF l_glac002 = l_glac[l_idx].glac002 THEN                                
                   EXIT FOR          
                END IF             
             END FOR
             LET l_mon = l_glaq004 * -1
          END IF
      ELSE
         IF l_glaq003 <> 0 THEN
            FOR l_idx = 31 TO 60
               IF l_glac002 = l_glac[l_idx].glac002 THEN                 
                  EXIT FOR          
               END IF             
            END FOR
             LET l_mon = l_glaq003 * - 1
         END IF
         IF l_glaq004 <> 0 THEN
             FOR l_idx = 31 TO 60
                IF l_glac002 = l_glac[l_idx].glac002 THEN              
                   
                   EXIT FOR          
                END IF             
             END FOR
             LET l_mon = l_glaq004 
          END IF
      END IF     
      IF l_glac008 = 1 THEN 
         CASE l_idx
            WHEN 1    
               LET g_glap_d3[l_ac].l_glaq003_1  = l_mon
            WHEN 2
               LET g_glap_d3[l_ac].l_glaq003_2  = l_mon
            WHEN 3
               LET g_glap_d3[l_ac].l_glaq003_3  = l_mon
            WHEN 4   
               LET g_glap_d3[l_ac].l_glaq003_4  = l_mon
            WHEN 5   
               LET g_glap_d3[l_ac].l_glaq003_5  = l_mon
            WHEN 6
               LET g_glap_d3[l_ac].l_glaq003_6  = l_mon
            WHEN 7
               LET g_glap_d3[l_ac].l_glaq003_7  = l_mon
            WHEN 8
               LET g_glap_d3[l_ac].l_glaq003_8  = l_mon
            WHEN 9
               LET g_glap_d3[l_ac].l_glaq003_9  = l_mon
            WHEN 10
               LET g_glap_d3[l_ac].l_glaq003_10 = l_mon
            WHEN 11
               LET g_glap_d3[l_ac].l_glaq003_11 = l_mon
            WHEN 12
               LET g_glap_d3[l_ac].l_glaq003_12 = l_mon
            WHEN 13
               LET g_glap_d3[l_ac].l_glaq003_13 = l_mon
            WHEN 14
               LET g_glap_d3[l_ac].l_glaq003_14 = l_mon
            WHEN 15
               LET g_glap_d3[l_ac].l_glaq003_15 = l_mon
            WHEN 16
               LET g_glap_d3[l_ac].l_glaq003_16 = l_mon
            WHEN 17
               LET g_glap_d3[l_ac].l_glaq003_17 = l_mon
            WHEN 18
               LET g_glap_d3[l_ac].l_glaq003_18 = l_mon
            WHEN 19
               LET g_glap_d3[l_ac].l_glaq003_19 = l_mon
            WHEN 20
               LET g_glap_d3[l_ac].l_glaq003_20 = l_mon
            WHEN 21
               LET g_glap_d3[l_ac].l_glaq003_21 = l_mon
            WHEN 22
               LET g_glap_d3[l_ac].l_glaq003_22 = l_mon
            WHEN 23
               LET g_glap_d3[l_ac].l_glaq003_23 = l_mon
            WHEN 24
               LET g_glap_d3[l_ac].l_glaq003_24 = l_mon
            WHEN 25
               LET g_glap_d3[l_ac].l_glaq003_24 = l_mon
            WHEN 26
               LET g_glap_d3[l_ac].l_glaq003_24 = l_mon
            WHEN 27
               LET g_glap_d3[l_ac].l_glaq003_24 = l_mon
            WHEN 28
               LET g_glap_d3[l_ac].l_glaq003_24 = l_mon
            WHEN 29
               LET g_glap_d3[l_ac].l_glaq003_24 = l_mon
            WHEN 30
               LET g_glap_d3[l_ac].l_glaq003_24 = l_mon               
         END CASE
      ELSE
         CASE l_idx
            WHEN 31    
               LET g_glap_d3[l_ac].l_glaq004_1  = l_mon
            WHEN 32
               LET g_glap_d3[l_ac].l_glaq004_2  = l_mon
            WHEN 33
               LET g_glap_d3[l_ac].l_glaq004_3  = l_mon
            WHEN 34   
               LET g_glap_d3[l_ac].l_glaq004_4  = l_mon
            WHEN 35   
               LET g_glap_d3[l_ac].l_glaq004_5  = l_mon
            WHEN 36
               LET g_glap_d3[l_ac].l_glaq004_6  = l_mon
            WHEN 37
               LET g_glap_d3[l_ac].l_glaq004_7  = l_mon
            WHEN 38
               LET g_glap_d3[l_ac].l_glaq004_8  = l_mon
            WHEN 39
               LET g_glap_d3[l_ac].l_glaq004_9  = l_mon
            WHEN 40
               LET g_glap_d3[l_ac].l_glaq004_10 = l_mon
            WHEN 41
               LET g_glap_d3[l_ac].l_glaq004_11 = l_mon
            WHEN 42
               LET g_glap_d3[l_ac].l_glaq004_12 = l_mon
            WHEN 43
               LET g_glap_d3[l_ac].l_glaq004_13 = l_mon
            WHEN 44
               LET g_glap_d3[l_ac].l_glaq004_14 = l_mon
            WHEN 45
               LET g_glap_d3[l_ac].l_glaq004_15 = l_mon
            WHEN 46
               LET g_glap_d3[l_ac].l_glaq004_16 = l_mon
            WHEN 47
               LET g_glap_d3[l_ac].l_glaq004_17 = l_mon
            WHEN 48
               LET g_glap_d3[l_ac].l_glaq004_18 = l_mon
            WHEN 49
               LET g_glap_d3[l_ac].l_glaq004_19 = l_mon
            WHEN 50
               LET g_glap_d3[l_ac].l_glaq004_20 = l_mon
            WHEN 51
               LET g_glap_d3[l_ac].l_glaq004_21 = l_mon
            WHEN 52
               LET g_glap_d3[l_ac].l_glaq004_22 = l_mon
            WHEN 53
               LET g_glap_d3[l_ac].l_glaq004_23 = l_mon
            WHEN 54
               LET g_glap_d3[l_ac].l_glaq004_24 = l_mon
            WHEN 55
               LET g_glap_d3[l_ac].l_glaq004_25 = l_mon
            WHEN 56
               LET g_glap_d3[l_ac].l_glaq004_26 = l_mon
            WHEN 57
               LET g_glap_d3[l_ac].l_glaq004_27 = l_mon
            WHEN 58
               LET g_glap_d3[l_ac].l_glaq004_28 = l_mon
            WHEN 59
               LET g_glap_d3[l_ac].l_glaq004_29 = l_mon
            WHEN 60
               LET g_glap_d3[l_ac].l_glaq004_30 = l_mon               
         END CASE
      END IF
      CALL aglq320_reset(l_ac,'1')
      CALL aglq320_reset(l_ac,'2') 
      LET g_glap_d3[l_ac].l_amt = g_glap_d3[l_ac].l_glaq003_0 -  g_glap_d3[l_ac].l_glaq004_0 + g_glap_d3[l_ac-1].l_amt  
      IF cl_null(g_glap_d3[l_ac].l_amt) THEN LET g_glap_d3[l_ac].l_amt = 0 END IF
　　　 CASE 
         WHEN g_glap_d3[l_ac].l_amt > 0  
            CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #借  
         WHEN g_glap_d[l_ac].l_amt < 0 
            CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #貸
         WHEN g_glap_d[l_ac].l_amt = 0
            CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #平
      END CASE             
      #本期合計
      IF l_glap004_t <> g_glap_d3[l_ac].glap004 AND l_ac > 1 THEN
         LET l_glap002_t = g_glap_d3[l_ac-1].glap002 #紀錄本期年度
         LET g_glap_d3[l_ac + 2].* = g_glap_d3[l_ac].*
         INITIALIZE g_glap_d3[l_ac].* TO NULL
         LET g_glap_d3[l_ac].l_glaq001 = s_desc_gzcbl004_desc('9927','2')   
         CALL aglq320_reset(l_ac,'1')
         FOR l_idx = 1 TO l_glap.getLength()
            IF l_glap004_t = l_glap[l_idx].glap004 THEN                   
               LET g_glap_d3[l_ac].l_glaq003_1  = g_glap_d3[l_ac].l_glaq003_1  + g_glap_d3[l_idx].l_glaq003_1 
               LET g_glap_d3[l_ac].l_glaq003_2  = g_glap_d3[l_ac].l_glaq003_2  + g_glap_d3[l_idx].l_glaq003_2 
               LET g_glap_d3[l_ac].l_glaq003_3  = g_glap_d3[l_ac].l_glaq003_3  + g_glap_d3[l_idx].l_glaq003_3 
               LET g_glap_d3[l_ac].l_glaq003_4  = g_glap_d3[l_ac].l_glaq003_4  + g_glap_d3[l_idx].l_glaq003_4 
               LET g_glap_d3[l_ac].l_glaq003_5  = g_glap_d3[l_ac].l_glaq003_5  + g_glap_d3[l_idx].l_glaq003_5 
               LET g_glap_d3[l_ac].l_glaq003_6  = g_glap_d3[l_ac].l_glaq003_6  + g_glap_d3[l_idx].l_glaq003_6 
               LET g_glap_d3[l_ac].l_glaq003_7  = g_glap_d3[l_ac].l_glaq003_7  + g_glap_d3[l_idx].l_glaq003_7 
               LET g_glap_d3[l_ac].l_glaq003_8  = g_glap_d3[l_ac].l_glaq003_8  + g_glap_d3[l_idx].l_glaq003_8 
               LET g_glap_d3[l_ac].l_glaq003_9  = g_glap_d3[l_ac].l_glaq003_9  + g_glap_d3[l_idx].l_glaq003_9 
               LET g_glap_d3[l_ac].l_glaq003_10 = g_glap_d3[l_ac].l_glaq003_10 + g_glap_d3[l_idx].l_glaq003_10
               LET g_glap_d3[l_ac].l_glaq003_11 = g_glap_d3[l_ac].l_glaq003_11 + g_glap_d3[l_idx].l_glaq003_11
               LET g_glap_d3[l_ac].l_glaq003_12 = g_glap_d3[l_ac].l_glaq003_12 + g_glap_d3[l_idx].l_glaq003_12
               LET g_glap_d3[l_ac].l_glaq003_13 = g_glap_d3[l_ac].l_glaq003_13 + g_glap_d3[l_idx].l_glaq003_13
               LET g_glap_d3[l_ac].l_glaq003_14 = g_glap_d3[l_ac].l_glaq003_14 + g_glap_d3[l_idx].l_glaq003_14
               LET g_glap_d3[l_ac].l_glaq003_15 = g_glap_d3[l_ac].l_glaq003_15 + g_glap_d3[l_idx].l_glaq003_15
               LET g_glap_d3[l_ac].l_glaq003_16 = g_glap_d3[l_ac].l_glaq003_16 + g_glap_d3[l_idx].l_glaq003_16
               LET g_glap_d3[l_ac].l_glaq003_17 = g_glap_d3[l_ac].l_glaq003_17 + g_glap_d3[l_idx].l_glaq003_17
               LET g_glap_d3[l_ac].l_glaq003_18 = g_glap_d3[l_ac].l_glaq003_18 + g_glap_d3[l_idx].l_glaq003_18
               LET g_glap_d3[l_ac].l_glaq003_19 = g_glap_d3[l_ac].l_glaq003_19 + g_glap_d3[l_idx].l_glaq003_19
               LET g_glap_d3[l_ac].l_glaq003_20 = g_glap_d3[l_ac].l_glaq003_20 + g_glap_d3[l_idx].l_glaq003_20
               LET g_glap_d3[l_ac].l_glaq003_21 = g_glap_d3[l_ac].l_glaq003_21 + g_glap_d3[l_idx].l_glaq003_21
               LET g_glap_d3[l_ac].l_glaq003_22 = g_glap_d3[l_ac].l_glaq003_22 + g_glap_d3[l_idx].l_glaq003_22
               LET g_glap_d3[l_ac].l_glaq003_23 = g_glap_d3[l_ac].l_glaq003_23 + g_glap_d3[l_idx].l_glaq003_23
               LET g_glap_d3[l_ac].l_glaq003_24 = g_glap_d3[l_ac].l_glaq003_24 + g_glap_d3[l_idx].l_glaq003_24
               LET g_glap_d3[l_ac].l_glaq003_25 = g_glap_d3[l_ac].l_glaq003_25 + g_glap_d3[l_idx].l_glaq003_25
               LET g_glap_d3[l_ac].l_glaq003_26 = g_glap_d3[l_ac].l_glaq003_26 + g_glap_d3[l_idx].l_glaq003_26
               LET g_glap_d3[l_ac].l_glaq003_27 = g_glap_d3[l_ac].l_glaq003_27 + g_glap_d3[l_idx].l_glaq003_27
               LET g_glap_d3[l_ac].l_glaq003_28 = g_glap_d3[l_ac].l_glaq003_28 + g_glap_d3[l_idx].l_glaq003_28
               LET g_glap_d3[l_ac].l_glaq003_29 = g_glap_d3[l_ac].l_glaq003_29 + g_glap_d3[l_idx].l_glaq003_29
               LET g_glap_d3[l_ac].l_glaq003_30 = g_glap_d3[l_ac].l_glaq003_30 + g_glap_d3[l_idx].l_glaq003_30
               
               LET g_glap_d3[l_ac].l_glaq004_1  = g_glap_d3[l_ac].l_glaq004_1  + g_glap_d3[l_idx].l_glaq004_1 
               LET g_glap_d3[l_ac].l_glaq004_2  = g_glap_d3[l_ac].l_glaq004_2  + g_glap_d3[l_idx].l_glaq004_2 
               LET g_glap_d3[l_ac].l_glaq004_3  = g_glap_d3[l_ac].l_glaq004_3  + g_glap_d3[l_idx].l_glaq004_3 
               LET g_glap_d3[l_ac].l_glaq004_4  = g_glap_d3[l_ac].l_glaq004_4  + g_glap_d3[l_idx].l_glaq004_4 
               LET g_glap_d3[l_ac].l_glaq004_5  = g_glap_d3[l_ac].l_glaq004_5  + g_glap_d3[l_idx].l_glaq004_5 
               LET g_glap_d3[l_ac].l_glaq004_6  = g_glap_d3[l_ac].l_glaq004_6  + g_glap_d3[l_idx].l_glaq004_6 
               LET g_glap_d3[l_ac].l_glaq004_7  = g_glap_d3[l_ac].l_glaq004_7  + g_glap_d3[l_idx].l_glaq004_7 
               LET g_glap_d3[l_ac].l_glaq004_8  = g_glap_d3[l_ac].l_glaq004_8  + g_glap_d3[l_idx].l_glaq004_8 
               LET g_glap_d3[l_ac].l_glaq004_9  = g_glap_d3[l_ac].l_glaq004_9  + g_glap_d3[l_idx].l_glaq004_9 
               LET g_glap_d3[l_ac].l_glaq004_10 = g_glap_d3[l_ac].l_glaq004_10 + g_glap_d3[l_idx].l_glaq004_10
               LET g_glap_d3[l_ac].l_glaq004_11 = g_glap_d3[l_ac].l_glaq004_11 + g_glap_d3[l_idx].l_glaq004_11
               LET g_glap_d3[l_ac].l_glaq004_12 = g_glap_d3[l_ac].l_glaq004_12 + g_glap_d3[l_idx].l_glaq004_12
               LET g_glap_d3[l_ac].l_glaq004_13 = g_glap_d3[l_ac].l_glaq004_13 + g_glap_d3[l_idx].l_glaq004_13
               LET g_glap_d3[l_ac].l_glaq004_14 = g_glap_d3[l_ac].l_glaq004_14 + g_glap_d3[l_idx].l_glaq004_14
               LET g_glap_d3[l_ac].l_glaq004_15 = g_glap_d3[l_ac].l_glaq004_15 + g_glap_d3[l_idx].l_glaq004_15
               LET g_glap_d3[l_ac].l_glaq004_16 = g_glap_d3[l_ac].l_glaq004_16 + g_glap_d3[l_idx].l_glaq004_16
               LET g_glap_d3[l_ac].l_glaq004_17 = g_glap_d3[l_ac].l_glaq004_17 + g_glap_d3[l_idx].l_glaq004_17
               LET g_glap_d3[l_ac].l_glaq004_18 = g_glap_d3[l_ac].l_glaq004_18 + g_glap_d3[l_idx].l_glaq004_18
               LET g_glap_d3[l_ac].l_glaq004_19 = g_glap_d3[l_ac].l_glaq004_19 + g_glap_d3[l_idx].l_glaq004_19
               LET g_glap_d3[l_ac].l_glaq004_20 = g_glap_d3[l_ac].l_glaq004_20 + g_glap_d3[l_idx].l_glaq004_20
               LET g_glap_d3[l_ac].l_glaq004_21 = g_glap_d3[l_ac].l_glaq004_21 + g_glap_d3[l_idx].l_glaq004_21
               LET g_glap_d3[l_ac].l_glaq004_22 = g_glap_d3[l_ac].l_glaq004_22 + g_glap_d3[l_idx].l_glaq004_22
               LET g_glap_d3[l_ac].l_glaq004_23 = g_glap_d3[l_ac].l_glaq004_23 + g_glap_d3[l_idx].l_glaq004_23
               LET g_glap_d3[l_ac].l_glaq004_24 = g_glap_d3[l_ac].l_glaq004_24 + g_glap_d3[l_idx].l_glaq004_24
               LET g_glap_d3[l_ac].l_glaq004_25 = g_glap_d3[l_ac].l_glaq004_25 + g_glap_d3[l_idx].l_glaq004_25
               LET g_glap_d3[l_ac].l_glaq004_26 = g_glap_d3[l_ac].l_glaq004_26 + g_glap_d3[l_idx].l_glaq004_26
               LET g_glap_d3[l_ac].l_glaq004_27 = g_glap_d3[l_ac].l_glaq004_27 + g_glap_d3[l_idx].l_glaq004_27
               LET g_glap_d3[l_ac].l_glaq004_28 = g_glap_d3[l_ac].l_glaq004_28 + g_glap_d3[l_idx].l_glaq004_28
               LET g_glap_d3[l_ac].l_glaq004_29 = g_glap_d3[l_ac].l_glaq004_29 + g_glap_d3[l_idx].l_glaq004_29
               LET g_glap_d3[l_ac].l_glaq004_30 = g_glap_d3[l_ac].l_glaq004_30 + g_glap_d3[l_idx].l_glaq004_30               
            END IF            
         END FOR             
         CALL aglq320_reset(l_ac,'2')    
         LET g_glap_d3[l_ac].l_amt = g_glap_d3[l_ac-1].l_amt  
         IF cl_null(g_glap_d3[l_ac].l_amt) THEN LET g_glap_d3[l_ac].l_amt = 0 END IF
         CASE 
            WHEN g_glap_d3[l_ac].l_amt > 0  
               CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #借  
            WHEN g_glap_d[l_ac].l_amt < 0 
               CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #貸
            WHEN g_glap_d[l_ac].l_amt = 0
               CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #平
         END CASE      
                 
         LET l_ac = l_ac +1    
         #本年累計            
         LET g_glap_d3[l_ac].glap002 = ''           
         LET g_glap_d3[l_ac].glap004 = ''
         LET g_glap_d3[l_ac].glapdocdt = ''
         LET g_glap_d3[l_ac].glapdocno = '' 
         LET g_glap_d3[l_ac].l_glaq001 = s_desc_gzcbl004_desc('9927','3')
         LET g_glap_d3[l_ac].l_glaq005 = ''
         LET g_glap_d3[l_ac].l_glaq010 = ''
         LET g_glap_d3[l_ac].l_glaq006 = ''
         CALL aglq320_reset(l_ac,'1')
         # 本期累計+上次本年累計
         IF l_glap002_t <> g_glap_d3[l_m].glap002 THEN
            LET g_glap_d3[l_ac].l_glaq003_1  = g_glap_d3[l_ac-1].l_glaq003_1  
            LET g_glap_d3[l_ac].l_glaq003_2  = g_glap_d3[l_ac-1].l_glaq003_2  
            LET g_glap_d3[l_ac].l_glaq003_3  = g_glap_d3[l_ac-1].l_glaq003_3  
            LET g_glap_d3[l_ac].l_glaq003_4  = g_glap_d3[l_ac-1].l_glaq003_4  
            LET g_glap_d3[l_ac].l_glaq003_5  = g_glap_d3[l_ac-1].l_glaq003_5  
            LET g_glap_d3[l_ac].l_glaq003_6  = g_glap_d3[l_ac-1].l_glaq003_6  
            LET g_glap_d3[l_ac].l_glaq003_7  = g_glap_d3[l_ac-1].l_glaq003_7  
            LET g_glap_d3[l_ac].l_glaq003_8  = g_glap_d3[l_ac-1].l_glaq003_8  
            LET g_glap_d3[l_ac].l_glaq003_9  = g_glap_d3[l_ac-1].l_glaq003_9  
            LET g_glap_d3[l_ac].l_glaq003_10 = g_glap_d3[l_ac-1].l_glaq003_10 
            LET g_glap_d3[l_ac].l_glaq003_11 = g_glap_d3[l_ac-1].l_glaq003_11 
            LET g_glap_d3[l_ac].l_glaq003_12 = g_glap_d3[l_ac-1].l_glaq003_12 
            LET g_glap_d3[l_ac].l_glaq003_13 = g_glap_d3[l_ac-1].l_glaq003_13 
            LET g_glap_d3[l_ac].l_glaq003_14 = g_glap_d3[l_ac-1].l_glaq003_14 
            LET g_glap_d3[l_ac].l_glaq003_15 = g_glap_d3[l_ac-1].l_glaq003_15 
            LET g_glap_d3[l_ac].l_glaq003_16 = g_glap_d3[l_ac-1].l_glaq003_16 
            LET g_glap_d3[l_ac].l_glaq003_17 = g_glap_d3[l_ac-1].l_glaq003_17 
            LET g_glap_d3[l_ac].l_glaq003_18 = g_glap_d3[l_ac-1].l_glaq003_18 
            LET g_glap_d3[l_ac].l_glaq003_19 = g_glap_d3[l_ac-1].l_glaq003_19 
            LET g_glap_d3[l_ac].l_glaq003_20 = g_glap_d3[l_ac-1].l_glaq003_20 
            LET g_glap_d3[l_ac].l_glaq003_21 = g_glap_d3[l_ac-1].l_glaq003_21 
            LET g_glap_d3[l_ac].l_glaq003_22 = g_glap_d3[l_ac-1].l_glaq003_22 
            LET g_glap_d3[l_ac].l_glaq003_23 = g_glap_d3[l_ac-1].l_glaq003_23 
            LET g_glap_d3[l_ac].l_glaq003_24 = g_glap_d3[l_ac-1].l_glaq003_24 
            LET g_glap_d3[l_ac].l_glaq003_25 = g_glap_d3[l_ac-1].l_glaq003_25 
            LET g_glap_d3[l_ac].l_glaq003_26 = g_glap_d3[l_ac-1].l_glaq003_26 
            LET g_glap_d3[l_ac].l_glaq003_27 = g_glap_d3[l_ac-1].l_glaq003_27 
            LET g_glap_d3[l_ac].l_glaq003_28 = g_glap_d3[l_ac-1].l_glaq003_28 
            LET g_glap_d3[l_ac].l_glaq003_29 = g_glap_d3[l_ac-1].l_glaq003_29 
            LET g_glap_d3[l_ac].l_glaq003_30 = g_glap_d3[l_ac-1].l_glaq003_30
            
            LET g_glap_d3[l_ac].l_glaq004_1  = g_glap_d3[l_ac-1].l_glaq004_1  
            LET g_glap_d3[l_ac].l_glaq004_2  = g_glap_d3[l_ac-1].l_glaq004_2  
            LET g_glap_d3[l_ac].l_glaq004_3  = g_glap_d3[l_ac-1].l_glaq004_3  
            LET g_glap_d3[l_ac].l_glaq004_4  = g_glap_d3[l_ac-1].l_glaq004_4  
            LET g_glap_d3[l_ac].l_glaq004_5  = g_glap_d3[l_ac-1].l_glaq004_5  
            LET g_glap_d3[l_ac].l_glaq004_6  = g_glap_d3[l_ac-1].l_glaq004_6  
            LET g_glap_d3[l_ac].l_glaq004_7  = g_glap_d3[l_ac-1].l_glaq004_7  
            LET g_glap_d3[l_ac].l_glaq004_8  = g_glap_d3[l_ac-1].l_glaq004_8  
            LET g_glap_d3[l_ac].l_glaq004_9  = g_glap_d3[l_ac-1].l_glaq004_9  
            LET g_glap_d3[l_ac].l_glaq004_10 = g_glap_d3[l_ac-1].l_glaq004_10 
            LET g_glap_d3[l_ac].l_glaq004_11 = g_glap_d3[l_ac-1].l_glaq004_11 
            LET g_glap_d3[l_ac].l_glaq004_12 = g_glap_d3[l_ac-1].l_glaq004_12 
            LET g_glap_d3[l_ac].l_glaq004_13 = g_glap_d3[l_ac-1].l_glaq004_13 
            LET g_glap_d3[l_ac].l_glaq004_14 = g_glap_d3[l_ac-1].l_glaq004_14 
            LET g_glap_d3[l_ac].l_glaq004_15 = g_glap_d3[l_ac-1].l_glaq004_15 
            LET g_glap_d3[l_ac].l_glaq004_16 = g_glap_d3[l_ac-1].l_glaq004_16 
            LET g_glap_d3[l_ac].l_glaq004_17 = g_glap_d3[l_ac-1].l_glaq004_17 
            LET g_glap_d3[l_ac].l_glaq004_18 = g_glap_d3[l_ac-1].l_glaq004_18 
            LET g_glap_d3[l_ac].l_glaq004_19 = g_glap_d3[l_ac-1].l_glaq004_19 
            LET g_glap_d3[l_ac].l_glaq004_20 = g_glap_d3[l_ac-1].l_glaq004_20 
            LET g_glap_d3[l_ac].l_glaq004_21 = g_glap_d3[l_ac-1].l_glaq004_21 
            LET g_glap_d3[l_ac].l_glaq004_22 = g_glap_d3[l_ac-1].l_glaq004_22 
            LET g_glap_d3[l_ac].l_glaq004_23 = g_glap_d3[l_ac-1].l_glaq004_23 
            LET g_glap_d3[l_ac].l_glaq004_24 = g_glap_d3[l_ac-1].l_glaq004_24 
            LET g_glap_d3[l_ac].l_glaq004_25 = g_glap_d3[l_ac-1].l_glaq004_25 
            LET g_glap_d3[l_ac].l_glaq004_26 = g_glap_d3[l_ac-1].l_glaq004_26 
            LET g_glap_d3[l_ac].l_glaq004_27 = g_glap_d3[l_ac-1].l_glaq004_27 
            LET g_glap_d3[l_ac].l_glaq004_28 = g_glap_d3[l_ac-1].l_glaq004_28 
            LET g_glap_d3[l_ac].l_glaq004_29 = g_glap_d3[l_ac-1].l_glaq004_29 
            LET g_glap_d3[l_ac].l_glaq004_30 = g_glap_d3[l_ac-1].l_glaq004_30        
         ELSE         
            LET g_glap_d3[l_ac].l_glaq003_1  = g_glap_d3[l_ac-1].l_glaq003_1  + g_glap_d3[l_y].l_glaq003_1 
            LET g_glap_d3[l_ac].l_glaq003_2  = g_glap_d3[l_ac-1].l_glaq003_2  + g_glap_d3[l_y].l_glaq003_2 
            LET g_glap_d3[l_ac].l_glaq003_3  = g_glap_d3[l_ac-1].l_glaq003_3  + g_glap_d3[l_y].l_glaq003_3 
            LET g_glap_d3[l_ac].l_glaq003_4  = g_glap_d3[l_ac-1].l_glaq003_4  + g_glap_d3[l_y].l_glaq003_4 
            LET g_glap_d3[l_ac].l_glaq003_5  = g_glap_d3[l_ac-1].l_glaq003_5  + g_glap_d3[l_y].l_glaq003_5 
            LET g_glap_d3[l_ac].l_glaq003_6  = g_glap_d3[l_ac-1].l_glaq003_6  + g_glap_d3[l_y].l_glaq003_6 
            LET g_glap_d3[l_ac].l_glaq003_7  = g_glap_d3[l_ac-1].l_glaq003_7  + g_glap_d3[l_y].l_glaq003_7 
            LET g_glap_d3[l_ac].l_glaq003_8  = g_glap_d3[l_ac-1].l_glaq003_8  + g_glap_d3[l_y].l_glaq003_8 
            LET g_glap_d3[l_ac].l_glaq003_9  = g_glap_d3[l_ac-1].l_glaq003_9  + g_glap_d3[l_y].l_glaq003_9 
            LET g_glap_d3[l_ac].l_glaq003_10 = g_glap_d3[l_ac-1].l_glaq003_10 + g_glap_d3[l_y].l_glaq003_10
            LET g_glap_d3[l_ac].l_glaq003_11 = g_glap_d3[l_ac-1].l_glaq003_11 + g_glap_d3[l_y].l_glaq003_11
            LET g_glap_d3[l_ac].l_glaq003_12 = g_glap_d3[l_ac-1].l_glaq003_12 + g_glap_d3[l_y].l_glaq003_12
            LET g_glap_d3[l_ac].l_glaq003_13 = g_glap_d3[l_ac-1].l_glaq003_13 + g_glap_d3[l_y].l_glaq003_13
            LET g_glap_d3[l_ac].l_glaq003_14 = g_glap_d3[l_ac-1].l_glaq003_14 + g_glap_d3[l_y].l_glaq003_14
            LET g_glap_d3[l_ac].l_glaq003_15 = g_glap_d3[l_ac-1].l_glaq003_15 + g_glap_d3[l_y].l_glaq003_15
            LET g_glap_d3[l_ac].l_glaq003_16 = g_glap_d3[l_ac-1].l_glaq003_16 + g_glap_d3[l_y].l_glaq003_16
            LET g_glap_d3[l_ac].l_glaq003_17 = g_glap_d3[l_ac-1].l_glaq003_17 + g_glap_d3[l_y].l_glaq003_17
            LET g_glap_d3[l_ac].l_glaq003_18 = g_glap_d3[l_ac-1].l_glaq003_18 + g_glap_d3[l_y].l_glaq003_18
            LET g_glap_d3[l_ac].l_glaq003_19 = g_glap_d3[l_ac-1].l_glaq003_19 + g_glap_d3[l_y].l_glaq003_19
            LET g_glap_d3[l_ac].l_glaq003_20 = g_glap_d3[l_ac-1].l_glaq003_20 + g_glap_d3[l_y].l_glaq003_20
            LET g_glap_d3[l_ac].l_glaq003_21 = g_glap_d3[l_ac-1].l_glaq003_21 + g_glap_d3[l_y].l_glaq003_21
            LET g_glap_d3[l_ac].l_glaq003_22 = g_glap_d3[l_ac-1].l_glaq003_22 + g_glap_d3[l_y].l_glaq003_22
            LET g_glap_d3[l_ac].l_glaq003_23 = g_glap_d3[l_ac-1].l_glaq003_23 + g_glap_d3[l_y].l_glaq003_23
            LET g_glap_d3[l_ac].l_glaq003_24 = g_glap_d3[l_ac-1].l_glaq003_24 + g_glap_d3[l_y].l_glaq003_24
            LET g_glap_d3[l_ac].l_glaq003_25 = g_glap_d3[l_ac-1].l_glaq003_25 + g_glap_d3[l_y].l_glaq003_25
            LET g_glap_d3[l_ac].l_glaq003_26 = g_glap_d3[l_ac-1].l_glaq003_26 + g_glap_d3[l_y].l_glaq003_26
            LET g_glap_d3[l_ac].l_glaq003_27 = g_glap_d3[l_ac-1].l_glaq003_27 + g_glap_d3[l_y].l_glaq003_27
            LET g_glap_d3[l_ac].l_glaq003_28 = g_glap_d3[l_ac-1].l_glaq003_28 + g_glap_d3[l_y].l_glaq003_28
            LET g_glap_d3[l_ac].l_glaq003_29 = g_glap_d3[l_ac-1].l_glaq003_29 + g_glap_d3[l_y].l_glaq003_29
            LET g_glap_d3[l_ac].l_glaq003_30 = g_glap_d3[l_ac-1].l_glaq003_30 + g_glap_d3[l_y].l_glaq003_30
         
            LET g_glap_d3[l_ac].l_glaq004_1  = g_glap_d3[l_ac-1].l_glaq004_1  + g_glap_d3[l_y].l_glaq004_1 
            LET g_glap_d3[l_ac].l_glaq004_2  = g_glap_d3[l_ac-1].l_glaq004_2  + g_glap_d3[l_y].l_glaq004_2 
            LET g_glap_d3[l_ac].l_glaq004_3  = g_glap_d3[l_ac-1].l_glaq004_3  + g_glap_d3[l_y].l_glaq004_3 
            LET g_glap_d3[l_ac].l_glaq004_4  = g_glap_d3[l_ac-1].l_glaq004_4  + g_glap_d3[l_y].l_glaq004_4 
            LET g_glap_d3[l_ac].l_glaq004_5  = g_glap_d3[l_ac-1].l_glaq004_5  + g_glap_d3[l_y].l_glaq004_5 
            LET g_glap_d3[l_ac].l_glaq004_6  = g_glap_d3[l_ac-1].l_glaq004_6  + g_glap_d3[l_y].l_glaq004_6 
            LET g_glap_d3[l_ac].l_glaq004_7  = g_glap_d3[l_ac-1].l_glaq004_7  + g_glap_d3[l_y].l_glaq004_7 
            LET g_glap_d3[l_ac].l_glaq004_8  = g_glap_d3[l_ac-1].l_glaq004_8  + g_glap_d3[l_y].l_glaq004_8 
            LET g_glap_d3[l_ac].l_glaq004_9  = g_glap_d3[l_ac-1].l_glaq004_9  + g_glap_d3[l_y].l_glaq004_9 
            LET g_glap_d3[l_ac].l_glaq004_10 = g_glap_d3[l_ac-1].l_glaq004_10 + g_glap_d3[l_y].l_glaq004_10
            LET g_glap_d3[l_ac].l_glaq004_11 = g_glap_d3[l_ac-1].l_glaq004_11 + g_glap_d3[l_y].l_glaq004_11
            LET g_glap_d3[l_ac].l_glaq004_12 = g_glap_d3[l_ac-1].l_glaq004_12 + g_glap_d3[l_y].l_glaq004_12
            LET g_glap_d3[l_ac].l_glaq004_13 = g_glap_d3[l_ac-1].l_glaq004_13 + g_glap_d3[l_y].l_glaq004_13
            LET g_glap_d3[l_ac].l_glaq004_14 = g_glap_d3[l_ac-1].l_glaq004_14 + g_glap_d3[l_y].l_glaq004_14
            LET g_glap_d3[l_ac].l_glaq004_15 = g_glap_d3[l_ac-1].l_glaq004_15 + g_glap_d3[l_y].l_glaq004_15
            LET g_glap_d3[l_ac].l_glaq004_16 = g_glap_d3[l_ac-1].l_glaq004_16 + g_glap_d3[l_y].l_glaq004_16
            LET g_glap_d3[l_ac].l_glaq004_17 = g_glap_d3[l_ac-1].l_glaq004_17 + g_glap_d3[l_y].l_glaq004_17
            LET g_glap_d3[l_ac].l_glaq004_18 = g_glap_d3[l_ac-1].l_glaq004_18 + g_glap_d3[l_y].l_glaq004_18
            LET g_glap_d3[l_ac].l_glaq004_19 = g_glap_d3[l_ac-1].l_glaq004_19 + g_glap_d3[l_y].l_glaq004_19
            LET g_glap_d3[l_ac].l_glaq004_20 = g_glap_d3[l_ac-1].l_glaq004_20 + g_glap_d3[l_y].l_glaq004_20
            LET g_glap_d3[l_ac].l_glaq004_21 = g_glap_d3[l_ac-1].l_glaq004_21 + g_glap_d3[l_y].l_glaq004_21
            LET g_glap_d3[l_ac].l_glaq004_22 = g_glap_d3[l_ac-1].l_glaq004_22 + g_glap_d3[l_y].l_glaq004_22
            LET g_glap_d3[l_ac].l_glaq004_23 = g_glap_d3[l_ac-1].l_glaq004_23 + g_glap_d3[l_y].l_glaq004_23
            LET g_glap_d3[l_ac].l_glaq004_24 = g_glap_d3[l_ac-1].l_glaq004_24 + g_glap_d3[l_y].l_glaq004_24
            LET g_glap_d3[l_ac].l_glaq004_25 = g_glap_d3[l_ac-1].l_glaq004_25 + g_glap_d3[l_y].l_glaq004_25
            LET g_glap_d3[l_ac].l_glaq004_26 = g_glap_d3[l_ac-1].l_glaq004_26 + g_glap_d3[l_y].l_glaq004_26
            LET g_glap_d3[l_ac].l_glaq004_27 = g_glap_d3[l_ac-1].l_glaq004_27 + g_glap_d3[l_y].l_glaq004_27
            LET g_glap_d3[l_ac].l_glaq004_28 = g_glap_d3[l_ac-1].l_glaq004_28 + g_glap_d3[l_y].l_glaq004_28
            LET g_glap_d3[l_ac].l_glaq004_29 = g_glap_d3[l_ac-1].l_glaq004_29 + g_glap_d3[l_y].l_glaq004_29
            LET g_glap_d3[l_ac].l_glaq004_30 = g_glap_d3[l_ac-1].l_glaq004_30 + g_glap_d3[l_y].l_glaq004_30
         END IF 
         #紀錄本年累計所在的位置
         LET l_y = l_ac                 
         CALL aglq320_reset(l_ac,'2')  
         #本年累計餘額
         LET g_glap_d3[l_ac].l_amt = g_glap_d3[l_ac-1].l_amt
         IF cl_null(g_glap_d3[l_ac].l_amt) THEN LET g_glap_d3[l_ac].l_amt = 0 END IF
         CASE 
            WHEN g_glap_d3[l_ac].l_amt > 0  
               CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #借  
            WHEN g_glap_d[l_ac].l_amt < 0 
               CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #貸
            WHEN g_glap_d[l_ac].l_amt = 0
               CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #平
         END CASE                                            
         LET l_ac = l_ac +1  
         LET l_m = l_ac-3
      END IF
      
      LET l_glap004_t = g_glap_d3[l_ac].glap004      
      LET l_glap[l_ac].idx     = l_ac
      LET l_glap[l_ac].glap004 = g_glap_d3[l_ac].glap004 
      
      LET l_ac = l_ac +1
      
   END FOREACH
   
   CALL g_glap_d3.deleteElement(g_glap_d3.getLength())
   IF l_ac > 1 THEN #本期合計     
      LET l_glap002_t = g_glap_d3[l_ac-1].glap002 #紀錄本期年度
      INITIALIZE g_glap_d3[l_ac].* TO NULL 
      LET g_glap_d3[l_ac].l_glaq001 = s_desc_gzcbl004_desc('9927','2')
      CALL aglq320_reset(l_ac,'1')  
      FOR l_idx = 1 TO l_glap.getLength() 
         IF l_glap004_t =  l_glap[l_idx].glap004 THEN                   
            LET g_glap_d3[l_ac].l_glaq003_1  = g_glap_d3[l_ac].l_glaq003_1  + g_glap_d3[l_idx].l_glaq003_1 
            LET g_glap_d3[l_ac].l_glaq003_2  = g_glap_d3[l_ac].l_glaq003_2  + g_glap_d3[l_idx].l_glaq003_2 
            LET g_glap_d3[l_ac].l_glaq003_3  = g_glap_d3[l_ac].l_glaq003_3  + g_glap_d3[l_idx].l_glaq003_3 
            LET g_glap_d3[l_ac].l_glaq003_4  = g_glap_d3[l_ac].l_glaq003_4  + g_glap_d3[l_idx].l_glaq003_4 
            LET g_glap_d3[l_ac].l_glaq003_5  = g_glap_d3[l_ac].l_glaq003_5  + g_glap_d3[l_idx].l_glaq003_5 
            LET g_glap_d3[l_ac].l_glaq003_6  = g_glap_d3[l_ac].l_glaq003_6  + g_glap_d3[l_idx].l_glaq003_6 
            LET g_glap_d3[l_ac].l_glaq003_7  = g_glap_d3[l_ac].l_glaq003_7  + g_glap_d3[l_idx].l_glaq003_7 
            LET g_glap_d3[l_ac].l_glaq003_8  = g_glap_d3[l_ac].l_glaq003_8  + g_glap_d3[l_idx].l_glaq003_8 
            LET g_glap_d3[l_ac].l_glaq003_9  = g_glap_d3[l_ac].l_glaq003_9  + g_glap_d3[l_idx].l_glaq003_9 
            LET g_glap_d3[l_ac].l_glaq003_10 = g_glap_d3[l_ac].l_glaq003_10 + g_glap_d3[l_idx].l_glaq003_15
            LET g_glap_d3[l_ac].l_glaq003_11 = g_glap_d3[l_ac].l_glaq003_11 + g_glap_d3[l_idx].l_glaq003_11
            LET g_glap_d3[l_ac].l_glaq003_12 = g_glap_d3[l_ac].l_glaq003_12 + g_glap_d3[l_idx].l_glaq003_12
            LET g_glap_d3[l_ac].l_glaq003_13 = g_glap_d3[l_ac].l_glaq003_13 + g_glap_d3[l_idx].l_glaq003_13
            LET g_glap_d3[l_ac].l_glaq003_14 = g_glap_d3[l_ac].l_glaq003_14 + g_glap_d3[l_idx].l_glaq003_14
            LET g_glap_d3[l_ac].l_glaq003_15 = g_glap_d3[l_ac].l_glaq003_15 + g_glap_d3[l_idx].l_glaq003_15
            LET g_glap_d3[l_ac].l_glaq003_16 = g_glap_d3[l_ac].l_glaq003_16 + g_glap_d3[l_idx].l_glaq003_16
            LET g_glap_d3[l_ac].l_glaq003_17 = g_glap_d3[l_ac].l_glaq003_17 + g_glap_d3[l_idx].l_glaq003_17
            LET g_glap_d3[l_ac].l_glaq003_18 = g_glap_d3[l_ac].l_glaq003_18 + g_glap_d3[l_idx].l_glaq003_18
            LET g_glap_d3[l_ac].l_glaq003_19 = g_glap_d3[l_ac].l_glaq003_19 + g_glap_d3[l_idx].l_glaq003_19
            LET g_glap_d3[l_ac].l_glaq003_20 = g_glap_d3[l_ac].l_glaq003_20 + g_glap_d3[l_idx].l_glaq003_20
            LET g_glap_d3[l_ac].l_glaq003_21 = g_glap_d3[l_ac].l_glaq003_21 + g_glap_d3[l_idx].l_glaq003_21
            LET g_glap_d3[l_ac].l_glaq003_22 = g_glap_d3[l_ac].l_glaq003_22 + g_glap_d3[l_idx].l_glaq003_22
            LET g_glap_d3[l_ac].l_glaq003_23 = g_glap_d3[l_ac].l_glaq003_23 + g_glap_d3[l_idx].l_glaq003_23
            LET g_glap_d3[l_ac].l_glaq003_24 = g_glap_d3[l_ac].l_glaq003_24 + g_glap_d3[l_idx].l_glaq003_24
            LET g_glap_d3[l_ac].l_glaq003_25 = g_glap_d3[l_ac].l_glaq003_25 + g_glap_d3[l_idx].l_glaq003_25
            LET g_glap_d3[l_ac].l_glaq003_26 = g_glap_d3[l_ac].l_glaq003_26 + g_glap_d3[l_idx].l_glaq003_26
            LET g_glap_d3[l_ac].l_glaq003_27 = g_glap_d3[l_ac].l_glaq003_27 + g_glap_d3[l_idx].l_glaq003_27
            LET g_glap_d3[l_ac].l_glaq003_28 = g_glap_d3[l_ac].l_glaq003_28 + g_glap_d3[l_idx].l_glaq003_28
            LET g_glap_d3[l_ac].l_glaq003_29 = g_glap_d3[l_ac].l_glaq003_29 + g_glap_d3[l_idx].l_glaq003_29
            LET g_glap_d3[l_ac].l_glaq003_30 = g_glap_d3[l_ac].l_glaq003_30 + g_glap_d3[l_idx].l_glaq003_30  

            LET g_glap_d3[l_ac].l_glaq004_1  = g_glap_d3[l_ac].l_glaq004_1  + g_glap_d3[l_idx].l_glaq004_1 
            LET g_glap_d3[l_ac].l_glaq004_2  = g_glap_d3[l_ac].l_glaq004_2  + g_glap_d3[l_idx].l_glaq004_2 
            LET g_glap_d3[l_ac].l_glaq004_3  = g_glap_d3[l_ac].l_glaq004_3  + g_glap_d3[l_idx].l_glaq004_3 
            LET g_glap_d3[l_ac].l_glaq004_4  = g_glap_d3[l_ac].l_glaq004_4  + g_glap_d3[l_idx].l_glaq004_4 
            LET g_glap_d3[l_ac].l_glaq004_5  = g_glap_d3[l_ac].l_glaq004_5  + g_glap_d3[l_idx].l_glaq004_5 
            LET g_glap_d3[l_ac].l_glaq004_6  = g_glap_d3[l_ac].l_glaq004_6  + g_glap_d3[l_idx].l_glaq004_6 
            LET g_glap_d3[l_ac].l_glaq004_7  = g_glap_d3[l_ac].l_glaq004_7  + g_glap_d3[l_idx].l_glaq004_7 
            LET g_glap_d3[l_ac].l_glaq004_8  = g_glap_d3[l_ac].l_glaq004_8  + g_glap_d3[l_idx].l_glaq004_8 
            LET g_glap_d3[l_ac].l_glaq004_9  = g_glap_d3[l_ac].l_glaq004_9  + g_glap_d3[l_idx].l_glaq004_9 
            LET g_glap_d3[l_ac].l_glaq004_10 = g_glap_d3[l_ac].l_glaq004_10 + g_glap_d3[l_idx].l_glaq004_10
            LET g_glap_d3[l_ac].l_glaq004_11 = g_glap_d3[l_ac].l_glaq004_11 + g_glap_d3[l_idx].l_glaq004_11
            LET g_glap_d3[l_ac].l_glaq004_12 = g_glap_d3[l_ac].l_glaq004_12 + g_glap_d3[l_idx].l_glaq004_12
            LET g_glap_d3[l_ac].l_glaq004_13 = g_glap_d3[l_ac].l_glaq004_13 + g_glap_d3[l_idx].l_glaq004_13
            LET g_glap_d3[l_ac].l_glaq004_14 = g_glap_d3[l_ac].l_glaq004_14 + g_glap_d3[l_idx].l_glaq004_14
            LET g_glap_d3[l_ac].l_glaq004_15 = g_glap_d3[l_ac].l_glaq004_15 + g_glap_d3[l_idx].l_glaq004_15
            LET g_glap_d3[l_ac].l_glaq004_16 = g_glap_d3[l_ac].l_glaq004_16 + g_glap_d3[l_idx].l_glaq004_16
            LET g_glap_d3[l_ac].l_glaq004_17 = g_glap_d3[l_ac].l_glaq004_17 + g_glap_d3[l_idx].l_glaq004_17
            LET g_glap_d3[l_ac].l_glaq004_18 = g_glap_d3[l_ac].l_glaq004_18 + g_glap_d3[l_idx].l_glaq004_18
            LET g_glap_d3[l_ac].l_glaq004_19 = g_glap_d3[l_ac].l_glaq004_19 + g_glap_d3[l_idx].l_glaq004_19
            LET g_glap_d3[l_ac].l_glaq004_20 = g_glap_d3[l_ac].l_glaq004_20 + g_glap_d3[l_idx].l_glaq004_20
            LET g_glap_d3[l_ac].l_glaq004_21 = g_glap_d3[l_ac].l_glaq004_21 + g_glap_d3[l_idx].l_glaq004_21
            LET g_glap_d3[l_ac].l_glaq004_22 = g_glap_d3[l_ac].l_glaq004_22 + g_glap_d3[l_idx].l_glaq004_22
            LET g_glap_d3[l_ac].l_glaq004_23 = g_glap_d3[l_ac].l_glaq004_23 + g_glap_d3[l_idx].l_glaq004_23
            LET g_glap_d3[l_ac].l_glaq004_24 = g_glap_d3[l_ac].l_glaq004_24 + g_glap_d3[l_idx].l_glaq004_24
            LET g_glap_d3[l_ac].l_glaq004_25 = g_glap_d3[l_ac].l_glaq004_25 + g_glap_d3[l_idx].l_glaq004_25
            LET g_glap_d3[l_ac].l_glaq004_26 = g_glap_d3[l_ac].l_glaq004_26 + g_glap_d3[l_idx].l_glaq004_26
            LET g_glap_d3[l_ac].l_glaq004_27 = g_glap_d3[l_ac].l_glaq004_27 + g_glap_d3[l_idx].l_glaq004_27
            LET g_glap_d3[l_ac].l_glaq004_28 = g_glap_d3[l_ac].l_glaq004_28 + g_glap_d3[l_idx].l_glaq004_28
            LET g_glap_d3[l_ac].l_glaq004_29 = g_glap_d3[l_ac].l_glaq004_29 + g_glap_d3[l_idx].l_glaq004_29
            LET g_glap_d3[l_ac].l_glaq004_30 = g_glap_d3[l_ac].l_glaq004_30 + g_glap_d3[l_idx].l_glaq004_30  
         END IF            
      END FOR
     
      CALL aglq320_reset(l_ac,'2')    
      LET g_glap_d3[l_ac].l_amt = g_glap_d3[l_ac].l_amt      
      IF cl_null(g_glap_d3[l_ac].l_amt) THEN LET g_glap_d3[l_ac].l_amt = 0 END IF
      CASE 
         WHEN g_glap_d3[l_ac].l_amt > 0  
            CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #借  
         WHEN g_glap_d[l_ac].l_amt < 0 
            CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #貸
         WHEN g_glap_d[l_ac].l_amt = 0
            CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #平
      END CASE        
      #本年合計
      LET l_ac = l_ac +1
      LET g_glap_d3[l_ac].glap002 = ''
      LET g_glap_d3[l_ac].glap004 = ''
      LET g_glap_d3[l_ac].glapdocdt = ''
      LET g_glap_d3[l_ac].glapdocno = '' 
      LET g_glap_d3[l_ac].l_glaq001 = s_desc_gzcbl004_desc('9927','3')
      LET g_glap_d3[l_ac].l_glaq005 = ''
      LET g_glap_d3[l_ac].l_glaq010 = ''
      LET g_glap_d3[l_ac].l_glaq006 = ''
      CALL aglq320_reset(l_ac,'1')
       IF l_glap002_t <> g_glap_d3[l_m].glap002 THEN
            LET g_glap_d3[l_ac].l_glaq003_1  = g_glap_d3[l_ac-1].l_glaq003_1  
            LET g_glap_d3[l_ac].l_glaq003_2  = g_glap_d3[l_ac-1].l_glaq003_2  
            LET g_glap_d3[l_ac].l_glaq003_3  = g_glap_d3[l_ac-1].l_glaq003_3  
            LET g_glap_d3[l_ac].l_glaq003_4  = g_glap_d3[l_ac-1].l_glaq003_4  
            LET g_glap_d3[l_ac].l_glaq003_5  = g_glap_d3[l_ac-1].l_glaq003_5  
            LET g_glap_d3[l_ac].l_glaq003_6  = g_glap_d3[l_ac-1].l_glaq003_6  
            LET g_glap_d3[l_ac].l_glaq003_7  = g_glap_d3[l_ac-1].l_glaq003_7  
            LET g_glap_d3[l_ac].l_glaq003_8  = g_glap_d3[l_ac-1].l_glaq003_8  
            LET g_glap_d3[l_ac].l_glaq003_9  = g_glap_d3[l_ac-1].l_glaq003_9  
            LET g_glap_d3[l_ac].l_glaq003_10 = g_glap_d3[l_ac-1].l_glaq003_10 
            LET g_glap_d3[l_ac].l_glaq003_11 = g_glap_d3[l_ac-1].l_glaq003_11 
            LET g_glap_d3[l_ac].l_glaq003_12 = g_glap_d3[l_ac-1].l_glaq003_12 
            LET g_glap_d3[l_ac].l_glaq003_13 = g_glap_d3[l_ac-1].l_glaq003_13 
            LET g_glap_d3[l_ac].l_glaq003_14 = g_glap_d3[l_ac-1].l_glaq003_14 
            LET g_glap_d3[l_ac].l_glaq003_15 = g_glap_d3[l_ac-1].l_glaq003_15 
            LET g_glap_d3[l_ac].l_glaq003_16 = g_glap_d3[l_ac-1].l_glaq003_16 
            LET g_glap_d3[l_ac].l_glaq003_17 = g_glap_d3[l_ac-1].l_glaq003_17 
            LET g_glap_d3[l_ac].l_glaq003_18 = g_glap_d3[l_ac-1].l_glaq003_18 
            LET g_glap_d3[l_ac].l_glaq003_19 = g_glap_d3[l_ac-1].l_glaq003_19 
            LET g_glap_d3[l_ac].l_glaq003_20 = g_glap_d3[l_ac-1].l_glaq003_20 
            LET g_glap_d3[l_ac].l_glaq003_21 = g_glap_d3[l_ac-1].l_glaq003_21 
            LET g_glap_d3[l_ac].l_glaq003_22 = g_glap_d3[l_ac-1].l_glaq003_22 
            LET g_glap_d3[l_ac].l_glaq003_23 = g_glap_d3[l_ac-1].l_glaq003_23 
            LET g_glap_d3[l_ac].l_glaq003_24 = g_glap_d3[l_ac-1].l_glaq003_24 
            LET g_glap_d3[l_ac].l_glaq003_25 = g_glap_d3[l_ac-1].l_glaq003_25 
            LET g_glap_d3[l_ac].l_glaq003_26 = g_glap_d3[l_ac-1].l_glaq003_26 
            LET g_glap_d3[l_ac].l_glaq003_27 = g_glap_d3[l_ac-1].l_glaq003_27 
            LET g_glap_d3[l_ac].l_glaq003_28 = g_glap_d3[l_ac-1].l_glaq003_28 
            LET g_glap_d3[l_ac].l_glaq003_29 = g_glap_d3[l_ac-1].l_glaq003_29 
            LET g_glap_d3[l_ac].l_glaq003_30 = g_glap_d3[l_ac-1].l_glaq003_30
            
            LET g_glap_d3[l_ac].l_glaq004_1  = g_glap_d3[l_ac-1].l_glaq004_1  
            LET g_glap_d3[l_ac].l_glaq004_2  = g_glap_d3[l_ac-1].l_glaq004_2  
            LET g_glap_d3[l_ac].l_glaq004_3  = g_glap_d3[l_ac-1].l_glaq004_3  
            LET g_glap_d3[l_ac].l_glaq004_4  = g_glap_d3[l_ac-1].l_glaq004_4  
            LET g_glap_d3[l_ac].l_glaq004_5  = g_glap_d3[l_ac-1].l_glaq004_5  
            LET g_glap_d3[l_ac].l_glaq004_6  = g_glap_d3[l_ac-1].l_glaq004_6  
            LET g_glap_d3[l_ac].l_glaq004_7  = g_glap_d3[l_ac-1].l_glaq004_7  
            LET g_glap_d3[l_ac].l_glaq004_8  = g_glap_d3[l_ac-1].l_glaq004_8  
            LET g_glap_d3[l_ac].l_glaq004_9  = g_glap_d3[l_ac-1].l_glaq004_9  
            LET g_glap_d3[l_ac].l_glaq004_10 = g_glap_d3[l_ac-1].l_glaq004_10 
            LET g_glap_d3[l_ac].l_glaq004_11 = g_glap_d3[l_ac-1].l_glaq004_11 
            LET g_glap_d3[l_ac].l_glaq004_12 = g_glap_d3[l_ac-1].l_glaq004_12 
            LET g_glap_d3[l_ac].l_glaq004_13 = g_glap_d3[l_ac-1].l_glaq004_13 
            LET g_glap_d3[l_ac].l_glaq004_14 = g_glap_d3[l_ac-1].l_glaq004_14 
            LET g_glap_d3[l_ac].l_glaq004_15 = g_glap_d3[l_ac-1].l_glaq004_15 
            LET g_glap_d3[l_ac].l_glaq004_16 = g_glap_d3[l_ac-1].l_glaq004_16 
            LET g_glap_d3[l_ac].l_glaq004_17 = g_glap_d3[l_ac-1].l_glaq004_17 
            LET g_glap_d3[l_ac].l_glaq004_18 = g_glap_d3[l_ac-1].l_glaq004_18 
            LET g_glap_d3[l_ac].l_glaq004_19 = g_glap_d3[l_ac-1].l_glaq004_19 
            LET g_glap_d3[l_ac].l_glaq004_20 = g_glap_d3[l_ac-1].l_glaq004_20 
            LET g_glap_d3[l_ac].l_glaq004_21 = g_glap_d3[l_ac-1].l_glaq004_21 
            LET g_glap_d3[l_ac].l_glaq004_22 = g_glap_d3[l_ac-1].l_glaq004_22 
            LET g_glap_d3[l_ac].l_glaq004_23 = g_glap_d3[l_ac-1].l_glaq004_23 
            LET g_glap_d3[l_ac].l_glaq004_24 = g_glap_d3[l_ac-1].l_glaq004_24 
            LET g_glap_d3[l_ac].l_glaq004_25 = g_glap_d3[l_ac-1].l_glaq004_25 
            LET g_glap_d3[l_ac].l_glaq004_26 = g_glap_d3[l_ac-1].l_glaq004_26 
            LET g_glap_d3[l_ac].l_glaq004_27 = g_glap_d3[l_ac-1].l_glaq004_27 
            LET g_glap_d3[l_ac].l_glaq004_28 = g_glap_d3[l_ac-1].l_glaq004_28 
            LET g_glap_d3[l_ac].l_glaq004_29 = g_glap_d3[l_ac-1].l_glaq004_29 
            LET g_glap_d3[l_ac].l_glaq004_30 = g_glap_d3[l_ac-1].l_glaq004_30        
         ELSE         
            LET g_glap_d3[l_ac].l_glaq003_1  = g_glap_d3[l_ac-1].l_glaq003_1  +  g_glap_d3[l_y].l_glaq003_1 
            LET g_glap_d3[l_ac].l_glaq003_2  = g_glap_d3[l_ac-1].l_glaq003_2  +  g_glap_d3[l_y].l_glaq003_2 
            LET g_glap_d3[l_ac].l_glaq003_3  = g_glap_d3[l_ac-1].l_glaq003_3  +  g_glap_d3[l_y].l_glaq003_3 
            LET g_glap_d3[l_ac].l_glaq003_4  = g_glap_d3[l_ac-1].l_glaq003_4  +  g_glap_d3[l_y].l_glaq003_4 
            LET g_glap_d3[l_ac].l_glaq003_5  = g_glap_d3[l_ac-1].l_glaq003_5  +  g_glap_d3[l_y].l_glaq003_5 
            LET g_glap_d3[l_ac].l_glaq003_6  = g_glap_d3[l_ac-1].l_glaq003_6  +  g_glap_d3[l_y].l_glaq003_6 
            LET g_glap_d3[l_ac].l_glaq003_7  = g_glap_d3[l_ac-1].l_glaq003_7  +  g_glap_d3[l_y].l_glaq003_7 
            LET g_glap_d3[l_ac].l_glaq003_8  = g_glap_d3[l_ac-1].l_glaq003_8  +  g_glap_d3[l_y].l_glaq003_8 
            LET g_glap_d3[l_ac].l_glaq003_9  = g_glap_d3[l_ac-1].l_glaq003_9  +  g_glap_d3[l_y].l_glaq003_9 
            LET g_glap_d3[l_ac].l_glaq003_10 = g_glap_d3[l_ac-1].l_glaq003_10 +  g_glap_d3[l_y].l_glaq003_10
            LET g_glap_d3[l_ac].l_glaq003_11 = g_glap_d3[l_ac-1].l_glaq003_11 +  g_glap_d3[l_y].l_glaq003_11
            LET g_glap_d3[l_ac].l_glaq003_12 = g_glap_d3[l_ac-1].l_glaq003_12 +  g_glap_d3[l_y].l_glaq003_12
            LET g_glap_d3[l_ac].l_glaq003_13 = g_glap_d3[l_ac-1].l_glaq003_13 +  g_glap_d3[l_y].l_glaq003_13
            LET g_glap_d3[l_ac].l_glaq003_14 = g_glap_d3[l_ac-1].l_glaq003_14 +  g_glap_d3[l_y].l_glaq003_14
            LET g_glap_d3[l_ac].l_glaq003_15 = g_glap_d3[l_ac-1].l_glaq003_15 +  g_glap_d3[l_y].l_glaq003_15
            LET g_glap_d3[l_ac].l_glaq003_16 = g_glap_d3[l_ac-1].l_glaq003_16 +  g_glap_d3[l_y].l_glaq003_16
            LET g_glap_d3[l_ac].l_glaq003_17 = g_glap_d3[l_ac-1].l_glaq003_17 +  g_glap_d3[l_y].l_glaq003_17
            LET g_glap_d3[l_ac].l_glaq003_18 = g_glap_d3[l_ac-1].l_glaq003_18 +  g_glap_d3[l_y].l_glaq003_18
            LET g_glap_d3[l_ac].l_glaq003_19 = g_glap_d3[l_ac-1].l_glaq003_19 +  g_glap_d3[l_y].l_glaq003_19
            LET g_glap_d3[l_ac].l_glaq003_20 = g_glap_d3[l_ac-1].l_glaq003_20 +  g_glap_d3[l_y].l_glaq003_20
            LET g_glap_d3[l_ac].l_glaq003_21 = g_glap_d3[l_ac-1].l_glaq003_21 +  g_glap_d3[l_y].l_glaq003_21
            LET g_glap_d3[l_ac].l_glaq003_22 = g_glap_d3[l_ac-1].l_glaq003_22 +  g_glap_d3[l_y].l_glaq003_22
            LET g_glap_d3[l_ac].l_glaq003_23 = g_glap_d3[l_ac-1].l_glaq003_23 +  g_glap_d3[l_y].l_glaq003_23
            LET g_glap_d3[l_ac].l_glaq003_24 = g_glap_d3[l_ac-1].l_glaq003_24 +  g_glap_d3[l_y].l_glaq003_24
            LET g_glap_d3[l_ac].l_glaq003_25 = g_glap_d3[l_ac-1].l_glaq003_25 +  g_glap_d3[l_y].l_glaq003_25
            LET g_glap_d3[l_ac].l_glaq003_26 = g_glap_d3[l_ac-1].l_glaq003_26 +  g_glap_d3[l_y].l_glaq003_26
            LET g_glap_d3[l_ac].l_glaq003_27 = g_glap_d3[l_ac-1].l_glaq003_27 +  g_glap_d3[l_y].l_glaq003_27
            LET g_glap_d3[l_ac].l_glaq003_28 = g_glap_d3[l_ac-1].l_glaq003_28 +  g_glap_d3[l_y].l_glaq003_28
            LET g_glap_d3[l_ac].l_glaq003_29 = g_glap_d3[l_ac-1].l_glaq003_29 +  g_glap_d3[l_y].l_glaq003_29
            LET g_glap_d3[l_ac].l_glaq003_30 = g_glap_d3[l_ac-1].l_glaq003_30 +  g_glap_d3[l_y].l_glaq003_30    
            
            LET g_glap_d3[l_ac].l_glaq004_1  = g_glap_d3[l_ac-1].l_glaq004_1  + g_glap_d3[l_y].l_glaq004_1 
            LET g_glap_d3[l_ac].l_glaq004_2  = g_glap_d3[l_ac-1].l_glaq004_2  + g_glap_d3[l_y].l_glaq004_2 
            LET g_glap_d3[l_ac].l_glaq004_3  = g_glap_d3[l_ac-1].l_glaq004_3  + g_glap_d3[l_y].l_glaq004_3 
            LET g_glap_d3[l_ac].l_glaq004_4  = g_glap_d3[l_ac-1].l_glaq004_4  + g_glap_d3[l_y].l_glaq004_4 
            LET g_glap_d3[l_ac].l_glaq004_5  = g_glap_d3[l_ac-1].l_glaq004_5  + g_glap_d3[l_y].l_glaq004_5 
            LET g_glap_d3[l_ac].l_glaq004_6  = g_glap_d3[l_ac-1].l_glaq004_6  + g_glap_d3[l_y].l_glaq004_6 
            LET g_glap_d3[l_ac].l_glaq004_7  = g_glap_d3[l_ac-1].l_glaq004_7  + g_glap_d3[l_y].l_glaq004_7 
            LET g_glap_d3[l_ac].l_glaq004_8  = g_glap_d3[l_ac-1].l_glaq004_8  + g_glap_d3[l_y].l_glaq004_8 
            LET g_glap_d3[l_ac].l_glaq004_9  = g_glap_d3[l_ac-1].l_glaq004_9  + g_glap_d3[l_y].l_glaq004_9 
            LET g_glap_d3[l_ac].l_glaq004_10 = g_glap_d3[l_ac-1].l_glaq004_10 + g_glap_d3[l_y].l_glaq004_10
            LET g_glap_d3[l_ac].l_glaq004_11 = g_glap_d3[l_ac-1].l_glaq004_11 + g_glap_d3[l_y].l_glaq004_11
            LET g_glap_d3[l_ac].l_glaq004_12 = g_glap_d3[l_ac-1].l_glaq004_12 + g_glap_d3[l_y].l_glaq004_12
            LET g_glap_d3[l_ac].l_glaq004_13 = g_glap_d3[l_ac-1].l_glaq004_13 + g_glap_d3[l_y].l_glaq004_13
            LET g_glap_d3[l_ac].l_glaq004_14 = g_glap_d3[l_ac-1].l_glaq004_14 + g_glap_d3[l_y].l_glaq004_14
            LET g_glap_d3[l_ac].l_glaq004_15 = g_glap_d3[l_ac-1].l_glaq004_15 + g_glap_d3[l_y].l_glaq004_15
            LET g_glap_d3[l_ac].l_glaq004_16 = g_glap_d3[l_ac-1].l_glaq004_16 + g_glap_d3[l_y].l_glaq004_16
            LET g_glap_d3[l_ac].l_glaq004_17 = g_glap_d3[l_ac-1].l_glaq004_17 + g_glap_d3[l_y].l_glaq004_17
            LET g_glap_d3[l_ac].l_glaq004_18 = g_glap_d3[l_ac-1].l_glaq004_18 + g_glap_d3[l_y].l_glaq004_18
            LET g_glap_d3[l_ac].l_glaq004_19 = g_glap_d3[l_ac-1].l_glaq004_19 + g_glap_d3[l_y].l_glaq004_19
            LET g_glap_d3[l_ac].l_glaq004_20 = g_glap_d3[l_ac-1].l_glaq004_20 + g_glap_d3[l_y].l_glaq004_20
            LET g_glap_d3[l_ac].l_glaq004_21 = g_glap_d3[l_ac-1].l_glaq004_21 + g_glap_d3[l_y].l_glaq004_21
            LET g_glap_d3[l_ac].l_glaq004_22 = g_glap_d3[l_ac-1].l_glaq004_22 + g_glap_d3[l_y].l_glaq004_22
            LET g_glap_d3[l_ac].l_glaq004_23 = g_glap_d3[l_ac-1].l_glaq004_23 + g_glap_d3[l_y].l_glaq004_23
            LET g_glap_d3[l_ac].l_glaq004_24 = g_glap_d3[l_ac-1].l_glaq004_24 + g_glap_d3[l_y].l_glaq004_24
            LET g_glap_d3[l_ac].l_glaq004_25 = g_glap_d3[l_ac-1].l_glaq004_25 + g_glap_d3[l_y].l_glaq004_25
            LET g_glap_d3[l_ac].l_glaq004_26 = g_glap_d3[l_ac-1].l_glaq004_26 + g_glap_d3[l_y].l_glaq004_26
            LET g_glap_d3[l_ac].l_glaq004_27 = g_glap_d3[l_ac-1].l_glaq004_27 + g_glap_d3[l_y].l_glaq004_27
            LET g_glap_d3[l_ac].l_glaq004_28 = g_glap_d3[l_ac-1].l_glaq004_28 + g_glap_d3[l_y].l_glaq004_28
            LET g_glap_d3[l_ac].l_glaq004_29 = g_glap_d3[l_ac-1].l_glaq004_29 + g_glap_d3[l_y].l_glaq004_29
            LET g_glap_d3[l_ac].l_glaq004_30 = g_glap_d3[l_ac-1].l_glaq004_30 + g_glap_d3[l_y].l_glaq004_30
         END IF
      CALL aglq320_reset(l_ac,'2')
      LET g_glap_d3[l_ac].l_amt = g_glap_d3[l_ac-1].l_amt  
      IF cl_null(g_glap_d3[l_ac].l_amt) THEN LET g_glap_d3[l_ac].l_amt = 0 END IF
      CASE 
         WHEN g_glap_d3[l_ac].l_amt > 0  
            CALL cl_getmsg('axr-00302',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #借  
         WHEN g_glap_d[l_ac].l_amt < 0 
            CALL cl_getmsg('axr-00303',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #貸
         WHEN g_glap_d[l_ac].l_amt = 0
            CALL cl_getmsg('axc-00725',g_dlang) RETURNING  g_glap_d3[l_ac].l_dc  #平
      END CASE          
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 報表資料
# Memo...........:
# Usage..........: CALL aglq320_print_ins(p_type)
# Date & Author..: 2015/12/28 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq320_print_ins(p_type)
DEFINE l_i      LIKE type_t.num5
DEFINE p_type   LIKE type_t.chr1
DEFINE l_glapld_desc     LIKE type_t.chr500
DEFINE l_glapcomp_desc   LIKE type_t.chr500
DEFINE l_glaa_desc       LIKE type_t.chr500
DEFINE l_sdate_desc    LIKE type_t.chr500
DEFINE l_edate_desc    LIKE type_t.chr500
DEFINE l_stus_desc       LIKE type_t.chr500
DEFINE l_show_ad_desc    LIKE type_t.chr500
DEFINE l_show_ce_desc    LIKE type_t.chr500
DEFINE l_show_ye_desc    LIKE type_t.chr500
   
   
   LET l_glapld_desc   = g_input.glapld,':',g_input.glapld_desc
   LET l_glapcomp_desc = g_input.glapcomp,':',g_input.glapcomp_desc
   LET l_glaa_desc  = g_input.glaa001      
   CASE
      WHEN g_glaa.glaa015<>'Y' AND g_glaa.glaa019<>'Y'
         LET l_glaa_desc  = g_input.glaa001       
      WHEN g_glaa.glaa015='Y' AND g_glaa.glaa019<>'Y' 
         LET l_glaa_desc  = g_input.glaa001,',',g_glaa.glaa016 
      WHEN g_glaa.glaa015<>'Y' AND g_glaa.glaa019='Y' 
         LET l_glaa_desc  = g_input.glaa001,',',g_glaa.glaa020 
      WHEN g_glaa.glaa015='Y' AND g_glaa.glaa019='Y' 
         LET l_glaa_desc  = g_input.glaa001,',',g_glaa.glaa016,',',g_glaa.glaa020 
   END CASE
   LET l_sdate_desc = g_input.sdate,' ',g_input.syear,' ',g_input.speriod  
   LET l_edate_desc = g_input.edate,' ',g_input.eyear,' ',g_input.eperiod  
   LET l_stus_desc = s_desc_gzcbl004_desc('9922',g_input.stus)
   LET l_show_ad_desc = g_input.show_ad 
   LET l_show_ce_desc = g_input.show_ce
   LET l_show_ye_desc = g_input.show_ye

     
     
   DELETE FROM aglq320_tmp01                      #160727-00019#3  Mod  aglq320_print_tmp -->aglq320_tmp01
   CASE p_type
      WHEN 1
         FOR l_i = 1 TO g_glap_d.getLength()
            INSERT INTO aglq320_tmp01 (           #160727-00019#3  Mod  aglq320_print_tmp -->aglq320_tmp01
              glapld_desc,glapcomp_desc,glaa_desc,sdate_desc,edate_desc,
              stus_desc,show_ad_desc,show_ce_desc,show_ye_desc, 
              glap002,glap004,glapdocdt,glapdocno, 
              l_glaq001,l_glaq005,l_glaq010,l_glaq006, 
              l_glaq003_0,l_glaq003_1,l_glaq003_2,l_glaq003_3, 
              l_glaq003_4,l_glaq003_5,l_glaq003_6,l_glaq003_7, 
              l_glaq003_8,l_glaq003_9,l_glaq003_10,l_glaq003_11, 
              l_glaq003_12,l_glaq003_13,l_glaq003_14,l_glaq003_15, 
              l_glaq003_16,l_glaq003_17,l_glaq003_18,l_glaq003_19, 
              l_glaq003_20,l_glaq003_21,l_glaq003_22,l_glaq003_23, 
              l_glaq003_24,l_glaq003_25,l_glaq003_26,l_glaq003_27, 
              l_glaq003_28,l_glaq003_29,l_glaq003_30,
              l_glaq004_0,l_glaq004_1,l_glaq004_2,l_glaq004_3,l_glaq004_4,l_glaq004_5,
              l_glaq004_6,l_glaq004_7,l_glaq004_8,l_glaq004_9,l_glaq004_10,l_glaq004_11,l_glaq004_12, 
              l_glaq004_13,l_glaq004_14,l_glaq004_15,l_glaq004_16, 
              l_glaq004_17,l_glaq004_18,l_glaq004_19,l_glaq004_20, 
              l_glaq004_21,l_glaq004_22,l_glaq004_23,l_glaq004_24, 
              l_glaq004_25,l_glaq004_26,l_glaq004_27,l_glaq004_28, 
              l_glaq004_29,l_glaq004_30,l_dc,l_amt )                                                    
            VALUES(                
             l_glapld_desc,l_glapcomp_desc,l_glaa_desc,l_sdate_desc,l_edate_desc,
             l_stus_desc,l_show_ad_desc,l_show_ce_desc,l_show_ye_desc,             
             g_glap_d[l_i].glap002,g_glap_d[l_i].glap004,g_glap_d[l_i].glapdocdt,g_glap_d[l_i].glapdocno, 
             g_glap_d[l_i].l_glaq001,g_glap_d[l_i].l_glaq005,g_glap_d[l_i].l_glaq010,g_glap_d[l_i].l_glaq006, 
             g_glap_d[l_i].l_glaq003_0,g_glap_d[l_i].l_glaq003_1,g_glap_d[l_i].l_glaq003_2,g_glap_d[l_i].l_glaq003_3, 
             g_glap_d[l_i].l_glaq003_4,g_glap_d[l_i].l_glaq003_5,g_glap_d[l_i].l_glaq003_6,g_glap_d[l_i].l_glaq003_7, 
             g_glap_d[l_i].l_glaq003_8,g_glap_d[l_i].l_glaq003_9,g_glap_d[l_i].l_glaq003_10,g_glap_d[l_i].l_glaq003_11, 
             g_glap_d[l_i].l_glaq003_12,g_glap_d[l_i].l_glaq003_13,g_glap_d[l_i].l_glaq003_14,g_glap_d[l_i].l_glaq003_15, 
             g_glap_d[l_i].l_glaq003_16,g_glap_d[l_i].l_glaq003_17,g_glap_d[l_i].l_glaq003_18,g_glap_d[l_i].l_glaq003_19, 
             g_glap_d[l_i].l_glaq003_20,g_glap_d[l_i].l_glaq003_21,g_glap_d[l_i].l_glaq003_22,g_glap_d[l_i].l_glaq003_23, 
             g_glap_d[l_i].l_glaq003_24,g_glap_d[l_i].l_glaq003_25,g_glap_d[l_i].l_glaq003_26,g_glap_d[l_i].l_glaq003_27, 
             g_glap_d[l_i].l_glaq003_28,g_glap_d[l_i].l_glaq003_29,g_glap_d[l_i].l_glaq003_30,g_glap_d[l_i].l_glaq004_0, 
             g_glap_d[l_i].l_glaq004_1,g_glap_d[l_i].l_glaq004_2,g_glap_d[l_i].l_glaq004_3,g_glap_d[l_i].l_glaq004_4, 
             g_glap_d[l_i].l_glaq004_5,g_glap_d[l_i].l_glaq004_6,g_glap_d[l_i].l_glaq004_7,g_glap_d[l_i].l_glaq004_8, 
             g_glap_d[l_i].l_glaq004_9,g_glap_d[l_i].l_glaq004_10,g_glap_d[l_i].l_glaq004_11,g_glap_d[l_i].l_glaq004_12, 
             g_glap_d[l_i].l_glaq004_13,g_glap_d[l_i].l_glaq004_14,g_glap_d[l_i].l_glaq004_15,g_glap_d[l_i].l_glaq004_16, 
             g_glap_d[l_i].l_glaq004_17,g_glap_d[l_i].l_glaq004_18,g_glap_d[l_i].l_glaq004_19,g_glap_d[l_i].l_glaq004_20, 
             g_glap_d[l_i].l_glaq004_21,g_glap_d[l_i].l_glaq004_22,g_glap_d[l_i].l_glaq004_23,g_glap_d[l_i].l_glaq004_24, 
             g_glap_d[l_i].l_glaq004_25,g_glap_d[l_i].l_glaq004_26,g_glap_d[l_i].l_glaq004_27,g_glap_d[l_i].l_glaq004_28, 
             g_glap_d[l_i].l_glaq004_29,g_glap_d[l_i].l_glaq004_30,g_glap_d[l_ac].l_dc,g_glap_d[l_ac].l_amt)
         END FOR
      WHEN 2
         FOR l_i = 1 TO g_glap_d2.getLength()
            INSERT INTO aglq320_tmp01                   #160727-00019#3  Mod  aglq320_print_tmp -->aglq320_tmp01
            VALUES(l_glapld_desc,l_glapcomp_desc,l_glaa_desc,l_sdate_desc,l_edate_desc,
             l_stus_desc,l_show_ad_desc,l_show_ce_desc,l_show_ye_desc,             
             g_glap_d2[l_i].glap002,g_glap_d2[l_i].glap004,g_glap_d2[l_i].glapdocdt,g_glap_d2[l_i].glapdocno, 
             g_glap_d2[l_i].l_glaq001,g_glap_d2[l_i].l_glaq005,g_glap_d2[l_i].l_glaq010,g_glap_d2[l_i].l_glaq006, 
             g_glap_d2[l_i].l_glaq003_0,g_glap_d2[l_i].l_glaq003_1,g_glap_d2[l_i].l_glaq003_2,g_glap_d2[l_i].l_glaq003_3, 
             g_glap_d2[l_i].l_glaq003_4,g_glap_d2[l_i].l_glaq003_5,g_glap_d2[l_i].l_glaq003_6,g_glap_d2[l_i].l_glaq003_7, 
             g_glap_d2[l_i].l_glaq003_8,g_glap_d2[l_i].l_glaq003_9,g_glap_d2[l_i].l_glaq003_10,g_glap_d2[l_i].l_glaq003_11, 
             g_glap_d2[l_i].l_glaq003_12,g_glap_d2[l_i].l_glaq003_13,g_glap_d2[l_i].l_glaq003_14,g_glap_d2[l_i].l_glaq003_15, 
             g_glap_d2[l_i].l_glaq003_16,g_glap_d2[l_i].l_glaq003_17,g_glap_d2[l_i].l_glaq003_18,g_glap_d2[l_i].l_glaq003_19, 
             g_glap_d2[l_i].l_glaq003_20,g_glap_d2[l_i].l_glaq003_21,g_glap_d2[l_i].l_glaq003_22,g_glap_d2[l_i].l_glaq003_23, 
             g_glap_d2[l_i].l_glaq003_24,g_glap_d2[l_i].l_glaq003_25,g_glap_d2[l_i].l_glaq003_26,g_glap_d2[l_i].l_glaq003_27, 
             g_glap_d2[l_i].l_glaq003_28,g_glap_d2[l_i].l_glaq003_29,g_glap_d2[l_i].l_glaq003_30,g_glap_d2[l_i].l_glaq004_0, 
             g_glap_d2[l_i].l_glaq004_1,g_glap_d2[l_i].l_glaq004_2,g_glap_d2[l_i].l_glaq004_3,g_glap_d2[l_i].l_glaq004_4, 
             g_glap_d2[l_i].l_glaq004_5,g_glap_d2[l_i].l_glaq004_6,g_glap_d2[l_i].l_glaq004_7,g_glap_d2[l_i].l_glaq004_8, 
             g_glap_d2[l_i].l_glaq004_9,g_glap_d2[l_i].l_glaq004_10,g_glap_d2[l_i].l_glaq004_11,g_glap_d2[l_i].l_glaq004_12, 
             g_glap_d2[l_i].l_glaq004_13,g_glap_d2[l_i].l_glaq004_14,g_glap_d2[l_i].l_glaq004_15,g_glap_d2[l_i].l_glaq004_16, 
             g_glap_d2[l_i].l_glaq004_17,g_glap_d2[l_i].l_glaq004_18,g_glap_d2[l_i].l_glaq004_19,g_glap_d2[l_i].l_glaq004_20, 
             g_glap_d2[l_i].l_glaq004_21,g_glap_d2[l_i].l_glaq004_22,g_glap_d2[l_i].l_glaq004_23,g_glap_d2[l_i].l_glaq004_24, 
             g_glap_d2[l_i].l_glaq004_25,g_glap_d2[l_i].l_glaq004_26,g_glap_d2[l_i].l_glaq004_27,g_glap_d2[l_i].l_glaq004_28, 
             g_glap_d2[l_i].l_glaq004_29,g_glap_d2[l_i].l_glaq004_30,g_glap_d2[l_ac].l_dc,g_glap_d2[l_ac].l_amt)
         END FOR
       WHEN 3
          FOR l_i = 1 TO g_glap_d3.getLength()
             INSERT INTO aglq320_tmp01        #160727-00019#3  Mod  aglq320_print_tmp -->aglq320_tmp01
             VALUES(l_glapld_desc,l_glapcomp_desc,l_glaa_desc,l_sdate_desc,l_edate_desc,
             l_stus_desc,l_show_ad_desc,l_show_ce_desc,l_show_ye_desc,              
             g_glap_d3[l_i].glap002,g_glap_d3[l_i].glap004,g_glap_d3[l_i].glapdocdt,g_glap_d3[l_i].glapdocno, 
              g_glap_d3[l_i].l_glaq001,g_glap_d3[l_i].l_glaq005,g_glap_d3[l_i].l_glaq010,g_glap_d3[l_i].l_glaq006, 
              g_glap_d3[l_i].l_glaq003_0,g_glap_d3[l_i].l_glaq003_1,g_glap_d3[l_i].l_glaq003_2,g_glap_d3[l_i].l_glaq003_3, 
              g_glap_d3[l_i].l_glaq003_4,g_glap_d3[l_i].l_glaq003_5,g_glap_d3[l_i].l_glaq003_6,g_glap_d3[l_i].l_glaq003_7, 
              g_glap_d3[l_i].l_glaq003_8,g_glap_d3[l_i].l_glaq003_9,g_glap_d3[l_i].l_glaq003_10,g_glap_d3[l_i].l_glaq003_11, 
              g_glap_d3[l_i].l_glaq003_12,g_glap_d3[l_i].l_glaq003_13,g_glap_d3[l_i].l_glaq003_14,g_glap_d3[l_i].l_glaq003_15, 
              g_glap_d3[l_i].l_glaq003_16,g_glap_d3[l_i].l_glaq003_17,g_glap_d3[l_i].l_glaq003_18,g_glap_d3[l_i].l_glaq003_19, 
              g_glap_d3[l_i].l_glaq003_20,g_glap_d3[l_i].l_glaq003_21,g_glap_d3[l_i].l_glaq003_22,g_glap_d3[l_i].l_glaq003_23, 
              g_glap_d3[l_i].l_glaq003_24,g_glap_d3[l_i].l_glaq003_25,g_glap_d3[l_i].l_glaq003_26,g_glap_d3[l_i].l_glaq003_27, 
              g_glap_d3[l_i].l_glaq003_28,g_glap_d3[l_i].l_glaq003_29,g_glap_d3[l_i].l_glaq003_30,g_glap_d3[l_i].l_glaq004_0, 
              g_glap_d3[l_i].l_glaq004_1,g_glap_d3[l_i].l_glaq004_2,g_glap_d3[l_i].l_glaq004_3,g_glap_d3[l_i].l_glaq004_4, 
              g_glap_d3[l_i].l_glaq004_5,g_glap_d3[l_i].l_glaq004_6,g_glap_d3[l_i].l_glaq004_7,g_glap_d3[l_i].l_glaq004_8, 
              g_glap_d3[l_i].l_glaq004_9,g_glap_d3[l_i].l_glaq004_10,g_glap_d3[l_i].l_glaq004_11,g_glap_d3[l_i].l_glaq004_12, 
              g_glap_d3[l_i].l_glaq004_13,g_glap_d3[l_i].l_glaq004_14,g_glap_d3[l_i].l_glaq004_15,g_glap_d3[l_i].l_glaq004_16, 
              g_glap_d3[l_i].l_glaq004_17,g_glap_d3[l_i].l_glaq004_18,g_glap_d3[l_i].l_glaq004_19,g_glap_d3[l_i].l_glaq004_20, 
              g_glap_d3[l_i].l_glaq004_21,g_glap_d3[l_i].l_glaq004_22,g_glap_d3[l_i].l_glaq004_23,g_glap_d3[l_i].l_glaq004_24, 
              g_glap_d3[l_i].l_glaq004_25,g_glap_d3[l_i].l_glaq004_26,g_glap_d3[l_i].l_glaq004_27,g_glap_d3[l_i].l_glaq004_28, 
              g_glap_d3[l_i].l_glaq004_29,g_glap_d3[l_i].l_glaq004_30,g_glap_d3[l_ac].l_dc,g_glap_d3[l_ac].l_amt)
          END FOR
   END CASE


END FUNCTION

 
{</section>}
 
