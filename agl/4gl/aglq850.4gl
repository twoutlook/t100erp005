#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq850.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2016-09-21 11:39:49), PR版次:0007(2016-10-27 17:37:18)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000085
#+ Filename...: aglq850
#+ Description: 科目跨法人查詢
#+ Creator....: 02599(2014-12-29 22:18:59)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="aglq850.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160302-00006#1  2016/03/02 By 07675 原本单身为不可查询作业，取消单身二次筛选功能
#160505-00007#19 2016/06/02 By 01531 效能优化
#160811-00039#4  2016/08/29 By 02599 查询是自行输入账套时要检核账套权限
#160912-00013#1  2016/09/12 By 02599 '余额型态'下拉框只显示'1.发生额'和'2.累计余额'
#160824-00004#3  2016/09/21 By 02599 增加传票选项：显示统制科目、科目层级、凭证状态、是否为内部管理科目、含月结凭证、含年结凭证，做法同aglq851
#160913-00017#4  2016/09/21 By 07900  AGL模组调整交易客商开窗
#160824-00004#4  2016/09/23 By 02599  排除XC类凭证时，继续增加条件：来源单据的成本凭证类型(xcea002)<>(7 OR 9)
#161021-00037#2  2016/10/24 By 06821  組織類型與職能開窗調整
#161027-00022#1  2016/10/27 By 02599  含月结凭证=N时，在排除XC凭证时，增加条件：来源成本单据的成本类型(xrea002)=9 and 科目对应的费用类别(glac010)=费用类型。
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
PRIVATE TYPE type_g_glaq_d RECORD
       
       sel LIKE type_t.chr1, 
   glaq002 LIKE glaq_t.glaq002, 
   glaq002_desc LIKE type_t.chr500, 
   amt1 LIKE type_t.num20_6, 
   amt2 LIKE type_t.num20_6, 
   amt3 LIKE type_t.num20_6, 
   amt4 LIKE type_t.num20_6, 
   amt5 LIKE type_t.num20_6, 
   amt6 LIKE type_t.num20_6, 
   amt7 LIKE type_t.num20_6, 
   amt8 LIKE type_t.num20_6, 
   amt9 LIKE type_t.num20_6, 
   amt10 LIKE type_t.num20_6, 
   amt11 LIKE type_t.num20_6, 
   amt12 LIKE type_t.num20_6, 
   amt13 LIKE type_t.num20_6, 
   amt14 LIKE type_t.num20_6, 
   amt15 LIKE type_t.num20_6, 
   amt16 LIKE type_t.num20_6, 
   amt17 LIKE type_t.num20_6, 
   amt18 LIKE type_t.num20_6, 
   amt19 LIKE type_t.num20_6, 
   amt20 LIKE type_t.num20_6, 
   amt21 LIKE type_t.num20_6, 
   amt22 LIKE type_t.num20_6, 
   amt23 LIKE type_t.num20_6, 
   amt24 LIKE type_t.num20_6, 
   amt25 LIKE type_t.num20_6, 
   amt26 LIKE type_t.num20_6, 
   amt27 LIKE type_t.num20_6, 
   amt28 LIKE type_t.num20_6, 
   amt29 LIKE type_t.num20_6, 
   amt30 LIKE type_t.num20_6, 
   amt31 LIKE type_t.num20_6, 
   amt32 LIKE type_t.num20_6, 
   amt33 LIKE type_t.num20_6, 
   amt34 LIKE type_t.num20_6, 
   amt35 LIKE type_t.num20_6, 
   amt36 LIKE type_t.num20_6, 
   amt37 LIKE type_t.num20_6, 
   amt38 LIKE type_t.num20_6, 
   amt39 LIKE type_t.num20_6, 
   amt40 LIKE type_t.num20_6, 
   amt41 LIKE type_t.num20_6, 
   amt42 LIKE type_t.num20_6, 
   amt43 LIKE type_t.num20_6, 
   amt44 LIKE type_t.num20_6, 
   amt45 LIKE type_t.num20_6, 
   amt46 LIKE type_t.num20_6, 
   amt47 LIKE type_t.num20_6, 
   amt48 LIKE type_t.num20_6, 
   amt49 LIKE type_t.num20_6, 
   amt50 LIKE type_t.num20_6, 
   amt51 LIKE type_t.num20_6, 
   amt52 LIKE type_t.num20_6, 
   amt53 LIKE type_t.num20_6, 
   amt54 LIKE type_t.num20_6, 
   amt55 LIKE type_t.num20_6, 
   amt56 LIKE type_t.num20_6, 
   amt57 LIKE type_t.num20_6, 
   amt58 LIKE type_t.num20_6, 
   amt59 LIKE type_t.num20_6, 
   amt60 LIKE type_t.num20_6, 
   amt61 LIKE type_t.num20_6, 
   amt62 LIKE type_t.num20_6, 
   amt63 LIKE type_t.num20_6, 
   amt64 LIKE type_t.num20_6, 
   amt65 LIKE type_t.num20_6, 
   amt66 LIKE type_t.num20_6, 
   amt67 LIKE type_t.num20_6, 
   amt68 LIKE type_t.num20_6, 
   amt69 LIKE type_t.num20_6, 
   amt70 LIKE type_t.num20_6, 
   amt71 LIKE type_t.num20_6, 
   amt72 LIKE type_t.num20_6, 
   amt73 LIKE type_t.num20_6, 
   amt74 LIKE type_t.num20_6, 
   amt75 LIKE type_t.num20_6, 
   amt76 LIKE type_t.num20_6, 
   amt77 LIKE type_t.num20_6, 
   amt78 LIKE type_t.num20_6, 
   amt79 LIKE type_t.num20_6, 
   amt80 LIKE type_t.num20_6, 
   amt81 LIKE type_t.num20_6, 
   amt82 LIKE type_t.num20_6, 
   amt83 LIKE type_t.num20_6, 
   amt84 LIKE type_t.num20_6, 
   amt85 LIKE type_t.num20_6, 
   amt86 LIKE type_t.num20_6, 
   amt87 LIKE type_t.num20_6, 
   amt88 LIKE type_t.num20_6, 
   amt89 LIKE type_t.num20_6, 
   amt90 LIKE type_t.num20_6, 
   amt91 LIKE type_t.num20_6, 
   amt92 LIKE type_t.num20_6, 
   amt93 LIKE type_t.num20_6, 
   amt94 LIKE type_t.num20_6, 
   amt95 LIKE type_t.num20_6, 
   amt96 LIKE type_t.num20_6, 
   amt97 LIKE type_t.num20_6, 
   amt98 LIKE type_t.num20_6, 
   amt99 LIKE type_t.num20_6, 
   amt100 LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE tm                RECORD
       glaqld            LIKE type_t.chr1000,
       glaq002           LIKE type_t.chr1000, 
       sdate             LIKE glap_t.glapdocdt,
       edate             LIKE glap_t.glapdocdt,
       kind              LIKE type_t.chr1,
       showstyle         LIKE type_t.chr1,
       fix_type          LIKE type_t.chr2,
       fix_acc           LIKE type_t.chr1000,
       glfa009           LIKE glfa_t.glfa009,
       glfa008           LIKE glfa_t.glfa008
       #160824-00004#3--add--str--
      ,show_acc        LIKE type_t.chr1, 
       glac005	        LIKE glac_t.glac005,
       stus            LIKE type_t.chr1,
       glac009	        LIKE glac_t.glac009,
       show_ce         LIKE type_t.chr1,
       show_ye         LIKE type_t.chr1
       #160824-00004#3--add--end
       END RECORD
DEFINE g_text            DYNAMIC ARRAY OF RECORD
       ld                LIKE glaa_t.glaald,
       fix               LIKE type_t.chr80,
       glad0171          LIKE type_t.chr100  
       END RECORD
DEFINE g_str             STRING
DEFINE g_str_glaq002     STRING
DEFINE g_glaa004         LIKE glaa_t.glaa004
DEFINE g_field           LIKE type_t.chr100
DEFINE g_field_1         LIKE type_t.chr100
DEFINE g_field_2         LIKE type_t.chr100
DEFINE g_field_3         LIKE type_t.chr100
DEFINE g_success         LIKE type_t.num10
#end add-point
 
#模組變數(Module Variables)
DEFINE g_glaq_d            DYNAMIC ARRAY OF type_g_glaq_d
DEFINE g_glaq_d_t          type_g_glaq_d
 
 
 
 
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
 
{<section id="aglq850.main" >}
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
   DECLARE aglq850_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq850_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq850_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq850 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq850_init()   
 
      #進入選單 Menu (="N")
      CALL aglq850_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq850
      
   END IF 
   
   CLOSE aglq850_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq850.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aglq850_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_str STRING
   DEFINE l_i   LIKE type_t.num5
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('glfa008','8705')
   CALL cl_set_combo_scc('showstyle','8037')
   CALL cl_set_combo_scc('fix_type','9934')
#   CALL cl_set_combo_scc('kind','9925') #160912-00013#1 mark
   CALL cl_set_combo_scc_part('kind','9925','1,2') #160912-00013#1 add
   CALL cl_set_comp_visible('sel',FALSE)
   FOR l_i = 1 TO 100
       IF NOT cl_null(l_str) THEN LET l_str = l_str CLIPPED,"," END IF
       LET l_str = l_str,"amt",l_i USING '<<<' CLIPPED
    END FOR
    CALL cl_set_comp_visible(l_str,FALSE)
    
    CALL cl_set_combo_scc('stus','9922') #160824-00004#3 add
    CALL aglq850_default_value()         #160824-00004#3 add
   #end add-point
 
   CALL aglq850_default_search()
END FUNCTION
 
{</section>}
 
{<section id="aglq850.default_search" >}
PRIVATE FUNCTION aglq850_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glaqld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " glaqdocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " glaqseq = '", g_argv[03], "' AND "
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
 
{<section id="aglq850.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq850_ui_dialog() 
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
   CALL aglq850_query()
   #end add-point
 
   
   CALL aglq850_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glaq_d.clear()
 
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
 
         CALL aglq850_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_glaq_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aglq850_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq850_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aglq850_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            CALL cl_set_act_visible("filter",FALSE)    #160302-00006#1 2016/03/02 ADD By 07675 
            CALL cl_set_act_visible("accept", FALSE)
            NEXT FIELD sel
            #end add-point
            NEXT FIELD glaqld
 
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
            
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL aglq850_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_glaq_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL aglq850_b_fill()
 
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
            CALL aglq850_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq850_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq850_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq850_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glaq_d.getLength()
               LET g_glaq_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glaq_d.getLength()
               LET g_glaq_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glaq_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glaq_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glaq_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glaq_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aglq850_filter()
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
               CALL aglq850_query()
               EXIT DIALOG
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
 
{<section id="aglq850.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq850_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
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
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_glaq_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '',glaq002,'','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY glaq_t.glaqld, 
       glaq_t.glaqdocno,glaq_t.glaqseq) AS RANK FROM glaq_t",
 
 
                     "",
                     " WHERE glaqent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glaq_t"),
                     " ORDER BY glaq_t.glaqld,glaq_t.glaqdocno,glaq_t.glaqseq"
 
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
 
   LET g_sql = "SELECT '',glaq002,'','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq850_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq850_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_glaq_d[l_ac].sel,g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq002_desc,g_glaq_d[l_ac].amt1, 
       g_glaq_d[l_ac].amt2,g_glaq_d[l_ac].amt3,g_glaq_d[l_ac].amt4,g_glaq_d[l_ac].amt5,g_glaq_d[l_ac].amt6, 
       g_glaq_d[l_ac].amt7,g_glaq_d[l_ac].amt8,g_glaq_d[l_ac].amt9,g_glaq_d[l_ac].amt10,g_glaq_d[l_ac].amt11, 
       g_glaq_d[l_ac].amt12,g_glaq_d[l_ac].amt13,g_glaq_d[l_ac].amt14,g_glaq_d[l_ac].amt15,g_glaq_d[l_ac].amt16, 
       g_glaq_d[l_ac].amt17,g_glaq_d[l_ac].amt18,g_glaq_d[l_ac].amt19,g_glaq_d[l_ac].amt20,g_glaq_d[l_ac].amt21, 
       g_glaq_d[l_ac].amt22,g_glaq_d[l_ac].amt23,g_glaq_d[l_ac].amt24,g_glaq_d[l_ac].amt25,g_glaq_d[l_ac].amt26, 
       g_glaq_d[l_ac].amt27,g_glaq_d[l_ac].amt28,g_glaq_d[l_ac].amt29,g_glaq_d[l_ac].amt30,g_glaq_d[l_ac].amt31, 
       g_glaq_d[l_ac].amt32,g_glaq_d[l_ac].amt33,g_glaq_d[l_ac].amt34,g_glaq_d[l_ac].amt35,g_glaq_d[l_ac].amt36, 
       g_glaq_d[l_ac].amt37,g_glaq_d[l_ac].amt38,g_glaq_d[l_ac].amt39,g_glaq_d[l_ac].amt40,g_glaq_d[l_ac].amt41, 
       g_glaq_d[l_ac].amt42,g_glaq_d[l_ac].amt43,g_glaq_d[l_ac].amt44,g_glaq_d[l_ac].amt45,g_glaq_d[l_ac].amt46, 
       g_glaq_d[l_ac].amt47,g_glaq_d[l_ac].amt48,g_glaq_d[l_ac].amt49,g_glaq_d[l_ac].amt50,g_glaq_d[l_ac].amt51, 
       g_glaq_d[l_ac].amt52,g_glaq_d[l_ac].amt53,g_glaq_d[l_ac].amt54,g_glaq_d[l_ac].amt55,g_glaq_d[l_ac].amt56, 
       g_glaq_d[l_ac].amt57,g_glaq_d[l_ac].amt58,g_glaq_d[l_ac].amt59,g_glaq_d[l_ac].amt60,g_glaq_d[l_ac].amt61, 
       g_glaq_d[l_ac].amt62,g_glaq_d[l_ac].amt63,g_glaq_d[l_ac].amt64,g_glaq_d[l_ac].amt65,g_glaq_d[l_ac].amt66, 
       g_glaq_d[l_ac].amt67,g_glaq_d[l_ac].amt68,g_glaq_d[l_ac].amt69,g_glaq_d[l_ac].amt70,g_glaq_d[l_ac].amt71, 
       g_glaq_d[l_ac].amt72,g_glaq_d[l_ac].amt73,g_glaq_d[l_ac].amt74,g_glaq_d[l_ac].amt75,g_glaq_d[l_ac].amt76, 
       g_glaq_d[l_ac].amt77,g_glaq_d[l_ac].amt78,g_glaq_d[l_ac].amt79,g_glaq_d[l_ac].amt80,g_glaq_d[l_ac].amt81, 
       g_glaq_d[l_ac].amt82,g_glaq_d[l_ac].amt83,g_glaq_d[l_ac].amt84,g_glaq_d[l_ac].amt85,g_glaq_d[l_ac].amt86, 
       g_glaq_d[l_ac].amt87,g_glaq_d[l_ac].amt88,g_glaq_d[l_ac].amt89,g_glaq_d[l_ac].amt90,g_glaq_d[l_ac].amt91, 
       g_glaq_d[l_ac].amt92,g_glaq_d[l_ac].amt93,g_glaq_d[l_ac].amt94,g_glaq_d[l_ac].amt95,g_glaq_d[l_ac].amt96, 
       g_glaq_d[l_ac].amt97,g_glaq_d[l_ac].amt98,g_glaq_d[l_ac].amt99,g_glaq_d[l_ac].amt100
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
 
      CALL aglq850_detail_show("'1'")
 
      CALL aglq850_glaq_t_mask()
 
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
 
   CALL g_glaq_d.deleteElement(g_glaq_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_glaq_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE aglq850_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq850_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq850_detail_action_trans()
 
   LET l_ac = 1
   IF g_glaq_d.getLength() > 0 THEN
      CALL aglq850_b_fill2()
   END IF
 
      CALL aglq850_filter_show('glaq002','b_glaq002')
 
 
END FUNCTION
 
{</section>}
 
{<section id="aglq850.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq850_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
 
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="aglq850.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq850_detail_show(ps_page)
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
 
{<section id="aglq850.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION aglq850_filter()
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
      CONSTRUCT g_wc_filter ON glaq002
                          FROM s_detail1[1].b_glaq002
 
         BEFORE CONSTRUCT
                     DISPLAY aglq850_filter_parser('glaq002') TO s_detail1[1].b_glaq002
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_glaq002>>----
         #Ctrlp:construct.c.page1.b_glaq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq002
            #add-point:ON ACTION controlp INFIELD b_glaq002 name="construct.c.filter.page1.b_glaq002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq002  #顯示到畫面上
            NEXT FIELD b_glaq002                     #返回原欄位
    


            #END add-point
 
 
         #----<<glaq002_desc>>----
         #----<<amt1>>----
         #----<<amt2>>----
         #----<<amt3>>----
         #----<<amt4>>----
         #----<<amt5>>----
         #----<<amt6>>----
         #----<<amt7>>----
         #----<<amt8>>----
         #----<<amt9>>----
         #----<<amt10>>----
         #----<<amt11>>----
         #----<<amt12>>----
         #----<<amt13>>----
         #----<<amt14>>----
         #----<<amt15>>----
         #----<<amt16>>----
         #----<<amt17>>----
         #----<<amt18>>----
         #----<<amt19>>----
         #----<<amt20>>----
         #----<<amt21>>----
         #----<<amt22>>----
         #----<<amt23>>----
         #----<<amt24>>----
         #----<<amt25>>----
         #----<<amt26>>----
         #----<<amt27>>----
         #----<<amt28>>----
         #----<<amt29>>----
         #----<<amt30>>----
         #----<<amt31>>----
         #----<<amt32>>----
         #----<<amt33>>----
         #----<<amt34>>----
         #----<<amt35>>----
         #----<<amt36>>----
         #----<<amt37>>----
         #----<<amt38>>----
         #----<<amt39>>----
         #----<<amt40>>----
         #----<<amt41>>----
         #----<<amt42>>----
         #----<<amt43>>----
         #----<<amt44>>----
         #----<<amt45>>----
         #----<<amt46>>----
         #----<<amt47>>----
         #----<<amt48>>----
         #----<<amt49>>----
         #----<<amt50>>----
         #----<<amt51>>----
         #----<<amt52>>----
         #----<<amt53>>----
         #----<<amt54>>----
         #----<<amt55>>----
         #----<<amt56>>----
         #----<<amt57>>----
         #----<<amt58>>----
         #----<<amt59>>----
         #----<<amt60>>----
         #----<<amt61>>----
         #----<<amt62>>----
         #----<<amt63>>----
         #----<<amt64>>----
         #----<<amt65>>----
         #----<<amt66>>----
         #----<<amt67>>----
         #----<<amt68>>----
         #----<<amt69>>----
         #----<<amt70>>----
         #----<<amt71>>----
         #----<<amt72>>----
         #----<<amt73>>----
         #----<<amt74>>----
         #----<<amt75>>----
         #----<<amt76>>----
         #----<<amt77>>----
         #----<<amt78>>----
         #----<<amt79>>----
         #----<<amt80>>----
         #----<<amt81>>----
         #----<<amt82>>----
         #----<<amt83>>----
         #----<<amt84>>----
         #----<<amt85>>----
         #----<<amt86>>----
         #----<<amt87>>----
         #----<<amt88>>----
         #----<<amt89>>----
         #----<<amt90>>----
         #----<<amt91>>----
         #----<<amt92>>----
         #----<<amt93>>----
         #----<<amt94>>----
         #----<<amt95>>----
         #----<<amt96>>----
         #----<<amt97>>----
         #----<<amt98>>----
         #----<<amt99>>----
         #----<<amt100>>----
 
 
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
 
      CALL aglq850_filter_show('glaq002','b_glaq002')
 
 
   CALL aglq850_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq850.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION aglq850_filter_parser(ps_field)
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
 
{<section id="aglq850.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq850_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq850_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="aglq850.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq850_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   LET g_current_row_tot = g_glaq_d.getLength() #160824-00004#3 add
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
 
{<section id="aglq850.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq850_detail_index_setting()
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
            IF g_glaq_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_glaq_d.getLength() AND g_glaq_d.getLength() > 0
            LET g_detail_idx = g_glaq_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_glaq_d.getLength() THEN
               LET g_detail_idx = g_glaq_d.getLength()
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
 
{<section id="aglq850.mask_functions" >}
 &include "erp/agl/aglq850_mask.4gl"
 
{</section>}
 
{<section id="aglq850.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 設置table每列及說明
# Memo...........:
# Usage..........: CALL aglq850_set_text()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/2/3 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq850_set_text()
   DEFINE l_tok  base.stringTokenizer
   DEFINE l_i             LIKE type_t.num5
   DEFINE lc_ld           LIKE type_t.chr50
   DEFINE lc_ld_desc      STRING
   DEFINE lc_fix_desc     STRING
   DEFINE l_index         LIKE type_t.num5
   DEFINE l_str           STRING
   DEFINE l_str1          LIKE type_t.chr20
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_n,l_num       LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE l_format        STRING
   DEFINE l_str2          STRING
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_ld            LIKE glaa_t.glaald 
   DEFINE l_glaqld_str    STRING  #单头录入的帳套查询条件
   DEFINE l_glaq002_str   STRING  #单头录入的科目查询条件
   DEFINE l_fix_acc       STRING  #单头录入的核算项查询条件
   DEFINE l_fix           LIKE type_t.chr80 #核算项编号
   DEFINE l_glfa011       LIKE glfa_t.glfa011
   DEFINE l_glad0171      LIKE type_t.chr100
   DEFINE l_sql1,l_sql2,l_sql3      STRING   #160824-00004#3 add
   
   CALL g_text.clear()
   CALL g_glaq_d.clear() 
   LET l_n = 0
   
   LET g_field=""
   LET g_field_1=" ''"
   LET g_field_2=''
   LET g_field_3=''
   #設置核算項查詢條件
   #帳套+核算項
   IF NOT cl_null(tm.fix_type) THEN
      CASE tm.fix_type
         WHEN '1' #營運據點
            LET g_field="glaq017"
            LET g_field_3="glar012"
         WHEN '2' #部門
            LET g_field="glaq018"
            LET g_field_2="glad007"
            LET g_field_3="glar013"
         WHEN '3' #利潤/成本中心
            LET g_field="glaq019"
            LET g_field_2="glad008"
            LET g_field_3="glar014"
         WHEN '4' #區域
            LET g_field="glaq020"
            LET g_field_2="glad009"
            LET g_field_3="glar015"
         WHEN '5' #交易客商
            LET g_field="glaq021"
            LET g_field_2="glad010"
            LET g_field_3="glar016"
         WHEN '6' #帳款客戶
            LET g_field="glaq022"
            LET g_field_2="glad027"
            LET g_field_3="glar017"
         WHEN '7' #客群
            LET g_field="glaq023"
            LET g_field_2="glad011"
            LET g_field_3="glar018"
         WHEN '8' #產品類別
            LET g_field="glaq024"
            LET g_field_2="glad012"
            LET g_field_3="glar019"
         WHEN '9' #經營方式
            LET g_field="glaq051"
            LET g_field_2="glad031"
            LET g_field_3="glar051"
         WHEN '10' #渠道
            LET g_field="glaq052"
            LET g_field_2="glad032"
            LET g_field_3="glar052"
         WHEN '11' #品牌
            LET g_field="glaq053" 
            LET g_field_2="glad033"
            LET g_field_3="glar053"
         WHEN '12' #人員
            LET g_field="glaq025"
            LET g_field_2="glad013"
            LET g_field_3="glar020"
         WHEN '13' #專案
            LET g_field="glaq027"
            LET g_field_2="glad015"
            LET g_field_3="glar022"
         WHEN '14' #WBS
            LET g_field="glaq028"
            LET g_field_2="glad016"
            LET g_field_3="glar023"
         WHEN '15' #自由核算項一
            LET g_field="glaq029"
            LET g_field_1="glad0171"
            LET g_field_2="glad017"
            LET g_field_3="glar024"
         WHEN '16' #自由核算項二
            LET g_field="glaq030"
            LET g_field_1="glad0181"
            LET g_field_2="glad018"
            LET g_field_3="glar025"
         WHEN '17' #自由核算項三
            LET g_field="glaq031"
            LET g_field_1="glad0191"
            LET g_field_2="glad019"
            LET g_field_3="glar026"
         WHEN '18' #自由核算項四
            LET g_field="glaq032"
            LET g_field_1="glad0201"
            LET g_field_2="glad020"
            LET g_field_3="glar027"
         WHEN '19' #自由核算項五
            LET g_field="glaq033"
            LET g_field_1="glad0211"
            LET g_field_2="glad021"
            LET g_field_3="glar028"
         WHEN '20' #自由核算項六
            LET g_field="glaq034"
            LET g_field_1="glad0221"
            LET g_field_2="glad022"
            LET g_field_3="glar029"
         WHEN '21' #自由核算項七
            LET g_field="glaq035"
            LET g_field_1="glad0231"
            LET g_field_2="glad023"
            LET g_field_3="glar030"
         WHEN '22' #自由核算項八
            LET g_field="glaq036"
            LET g_field_1="glad0241"
            LET g_field_2="glad024"
            LET g_field_3="glar031"
         WHEN '23' #自由核算項九
            LET g_field="glaq037"
            LET g_field_1="glad0251"
            LET g_field_2="glad025"
            LET g_field_3="glar032"
         WHEN '24' #自由核算項十
            LET g_field="glaq038"
            LET g_field_1="glad0261"
            LET g_field_2="glad026"
            LET g_field_3="glar033"
      END CASE
   END IF
   
   #160824-00004#3--add--str--
   #含內部管理科目否
   IF tm.glac009<>'Y' THEN
      LET l_sql1=l_sql1," AND glac009<>'Y' "
   END IF
   
   #顯示年結YE憑證否
   IF tm.show_ye<>'Y' THEN
      LET l_sql2=l_sql2," AND glap007<>'YE' "
   END IF
   
   #單據狀態l_sql3
   CASE
      WHEN tm.stus='1'
         LET l_sql3=l_sql3," AND glapstus='S' "
      WHEN tm.stus='2'
         LET l_sql3=l_sql3," AND glapstus IN ('S','Y') "
      WHEN tm.stus='3'
         LET l_sql3=l_sql3," AND glapstus IN ('S','Y','N') "
   END CASE
   #160824-00004#3--add--end
   
   #設置核算項查詢條件
   #帳套+核算項
   IF NOT cl_null(tm.fix_type) THEN
      LET g_sql="SELECT DISTINCT ",g_field,",",g_field_1,      #抓取核算項編號
                "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno "
               ,"   LEFT OUTER JOIN glac_t ON glacent=glaqent AND glac002=glaq002 AND glac001='",g_glaa004,"' " #160824-00004#3 add
      IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR  
         tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN 
         LET g_sql=g_sql,"  LEFT OUTER JOIN glad_t ON gladent=glaqent AND gladld=glaqld AND glad001=glaq002"
      END IF
      LET g_sql=g_sql," WHERE glaqent=",g_enterprise,
#                      "   AND glapstus='S'" #160824-00004#3 mark
                       l_sql1,l_sql2,l_sql3  #160824-00004#3 add
      
      #發生額
      IF tm.kind='1' THEN
         LET g_sql=g_sql," AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'"
      ELSE  #累計額
         LET g_sql=g_sql," AND glapdocdt <='",tm.edate,"' AND glap002>=",YEAR(tm.sdate)
      END IF
      
      #核算項條件
      IF NOT cl_null(tm.fix_acc) THEN
         LET l_fix_acc=tm.fix_acc
         LET l_num =l_fix_acc.getIndexOf('*',1)
         IF l_num>0 THEN
            LET l_fix_acc=cl_replace_str(tm.fix_acc,"*","%")
            LET g_sql=g_sql," AND ",g_field," LIKE '",l_fix_acc,"' "
         ELSE
            LET l_fix_acc=cl_replace_str(tm.fix_acc,"|","','")
            LET l_fix_acc="'",l_fix_acc,"'"
            LET g_sql=g_sql," AND ",g_field," IN ( ",l_fix_acc," ) "
         END IF
      ELSE
         IF tm.fix_type='1' OR tm.fix_type='2' OR tm.fix_type='3' OR tm.fix_type='4' OR tm.fix_type='5' OR
            tm.fix_type='6' OR tm.fix_type='7' OR tm.fix_type='8' OR tm.fix_type='9' OR tm.fix_type='10' OR
            tm.fix_type='11' OR tm.fix_type='12' OR tm.fix_type='13' OR tm.fix_type='14'  THEN
            LET g_sql=g_sql," AND ",g_field," <> ' ' "
         END IF
      END IF
      
      #科目条件
      LET g_sql=g_sql," AND ",g_str_glaq002
      #帳套條件
      LET l_glaqld_str=cl_replace_str(g_str,"|","','")
      LET l_glaqld_str="'",l_glaqld_str,"'"
      LET g_sql=g_sql," AND glaqld IN (",l_glaqld_str,") ",
                      " ORDER BY ",g_field,",",g_field_1
         
      PREPARE aglq850_fix_pr FROM g_sql
      DECLARE aglq850_fix_cs CURSOR FOR aglq850_fix_pr 
      FOREACH aglq850_fix_cs INTO l_fix,l_glad0171
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'FOREACH aglq850_fix_cs'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF
         LET l_i = g_text.getLength()+1
         LET g_text[l_i].fix=l_fix CLIPPED
         LET g_text[l_i].glad0171=l_glad0171 CLIPPED
         LET l_n = l_n +1 
      END FOREACH 
   ELSE
      #未設置核算項查詢條件
      #帳套
      LET l_tok = base.StringTokenizer.createExt(g_str,'|','',TRUE)
      IF l_tok.countTokens() > 0 THEN
         WHILE l_tok.hasMoreTokens()
            LET l_ld= l_tok.nextToken()
            LET l_i = g_text.getLength()+1
            LET g_text[l_i].ld=l_ld
            LET l_n = l_n +1
         END WHILE
      END IF
   END IF
   
   #是否有符合的帳套或營運據點
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00277'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE
      RETURN 
   END IF
  
   LET l_str = NULL
   FOR l_i = 1 TO g_text.getLength()
      IF NOT cl_null(l_str) THEN LET l_str = l_str CLIPPED,"," END IF
      LET l_index = l_i USING '<<<<'
      LET lc_ld = g_text[l_i].ld CLIPPED
      #按照帳套匯總金額
      IF NOT cl_null(lc_ld) THEN
         #抓取帐套说明
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = lc_ld
         CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET lc_ld_desc = '', g_rtn_fields[1] , ''
         #帳套編號+說明
         IF cl_null(lc_ld_desc) THEN
            LET lc_ld_desc=g_text[l_i].ld
         ELSE
            LET lc_ld_desc="(",g_text[l_i].ld,")",lc_ld_desc
         END IF
      ELSE 
         LET lc_ld_desc = ''
      END IF

      #按照核算項匯總金額
      IF NOT cl_null(tm.fix_type) THEN  #帳套+核算项
         CASE tm.fix_type
            WHEN '1' #營運據點
               CALL s_desc_get_department_desc(g_text[l_i].fix) RETURNING lc_fix_desc
            WHEN '2' #部門
               CALL s_desc_get_department_desc(g_text[l_i].fix) RETURNING lc_fix_desc
            WHEN '3' #利潤成本中心
               CALL s_desc_get_department_desc(g_text[l_i].fix) RETURNING lc_fix_desc
            WHEN '4' #區域
               CALL s_desc_get_acc_desc('287',g_text[l_i].fix) RETURNING lc_fix_desc 
            WHEN '5' #交易客商
               CALL s_desc_get_trading_partner_abbr_desc(g_text[l_i].fix) RETURNING lc_fix_desc
            WHEN '6' #帳款客戶
               CALL s_desc_get_trading_partner_abbr_desc(g_text[l_i].fix) RETURNING lc_fix_desc
            WHEN '7' #客群
               CALL s_desc_get_acc_desc('281',g_text[l_i].fix) RETURNING lc_fix_desc
            WHEN '8' #產品分類
               CALL s_desc_get_rtaxl003_desc(g_text[l_i].fix) RETURNING lc_fix_desc
            WHEN '9' #经营方式
               CALL s_desc_gzcbl004_desc('6013',g_text[l_i].fix) RETURNING lc_fix_desc
            WHEN '10' #渠道
               CALL s_desc_get_oojdl003_desc(g_text[l_i].fix) RETURNING lc_fix_desc
            WHEN '11' #品牌
               CALL s_desc_get_acc_desc('2002',g_text[l_i].fix) RETURNING lc_fix_desc
            WHEN '12' #人員
               CALL s_desc_get_person_desc(g_text[l_i].fix) RETURNING lc_fix_desc
            WHEN '13' #专案
               CALL s_desc_get_project_desc(g_text[l_i].fix) RETURNING lc_fix_desc
            WHEN '14' #WBS
               #CALL s_desc_get_wbs_desc('',g_text[l_i].fix) RETURNING lc_fix_desc
               LET lc_fix_desc = g_text[l_i].fix
         END CASE
         IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
            tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
            CALL s_voucher_free_account_desc(g_text[l_i].glad0171,g_text[l_i].fix) 
            RETURNING lc_fix_desc
         END IF
         #核算項編號+說明
         IF cl_null(lc_fix_desc) THEN
            LET lc_ld_desc=g_text[l_i].fix
         ELSE
            LET lc_ld_desc="(",g_text[l_i].fix,")",lc_fix_desc
         END IF
      END IF       
      LET l_str = l_str,"amt" CLIPPED,l_index USING '<<<<'
      CALL cl_set_comp_att_text("amt" || l_index,lc_ld_desc)
   END FOR
   
   
   CALL cl_set_comp_visible(l_str,TRUE)
   #設置單身金額欄位格式
   LET l_format = "---,---,---,--&"
   LET l_str2 = ""
   FOR l_j=1 TO tm.glfa009
       LET l_str2 = l_str2,"&"
   END FOR
   IF NOT cl_null(l_str2) THEN
      LET l_format = l_format,'.',l_str2
   END IF
   CALL cl_set_comp_format(l_str,l_format)
#160824-00004#3--mark--str--
#   LET l_str = NULL                   
#   FOR l_i = g_text.getLength()+1 TO 100
#      IF NOT cl_null(l_str) THEN LET l_str = l_str CLIPPED,"," END IF
#      LET l_str = l_str,"amt" CLIPPED,l_i USING '<<<<' 
#   END FOR
#   CALL cl_set_comp_visible(l_str,FALSE) 
#160824-00004#3--mark--end
END FUNCTION

################################################################################
# Descriptions...: 查詢操作
# Memo...........:
# Usage..........: CALL aglq850_query()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/2/26 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq850_query()
   DEFINE ls_wc           LIKE type_t.chr500
   DEFINE ls_return       STRING
   DEFINE ls_result       STRING 
   DEFINE l_glaqld        LIKE glaq_t.glaqld
   DEFINE l_glaq002       LIKE glaq_t.glaq002
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_tok           base.stringTokenizer
   DEFINE l_glaa004       LIKE glaa_t.glaa004
   DEFINE l_glaa004_o     LIKE glaa_t.glaa004
   DEFINE l_str           STRING
   DEFINE l_i             LIKE type_t.num5

#160824-00004#3--mark--str--
#   INITIALIZE tm.* TO NULL 
#   LET tm.sdate=g_today  #起始日期
#   LET tm.edate=g_today  #截止日期
#   LET tm.kind='1'       #餘額形態
#   LET tm.glfa008='1'            #金额 
#   LET tm.glfa009=2              #小数位数
#   LET tm.showstyle = '1'        #報表呈現方式為1：多帳別
#160824-00004#3--mark--end
   
   DISPLAY tm.sdate,tm.edate,tm.kind,tm.showstyle,tm.fix_type,tm.fix_acc,tm.glfa009,tm.glfa008 
        TO sdate,edate,kind,showstyle,fix_type,fix_acc,glfa009,glfa008
   #160824-00004#3--add--str--
   #傳票選項顯示
   DISPLAY tm.show_acc,tm.glac005,tm.stus,tm.glac009,tm.show_ce,tm.show_ye
        TO show_acc,glac005,stus,glac009,show_ce,show_ye
   #160824-00004#3--add--end
#   FOR l_i = 1 TO g_glaq_d.getLength() #160824-00004#3 mark
   FOR l_i = 1 TO g_text.getLength()    #160824-00004#3 add
       IF NOT cl_null(l_str) THEN LET l_str = l_str CLIPPED,"," END IF
       LET l_str = l_str,"amt",l_i USING '<<<' CLIPPED
    END FOR
    CALL cl_set_comp_visible(l_str,FALSE)
    
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glaq_d.clear()
   LET g_wc_filter = " 1=1"
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      CONSTRUCT g_str_glaq002 ON glaq002 FROM glaq002
                      
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD glaq002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_glaa004) THEN
               LET g_qryparam.where = "glac001 = '",g_glaa004,"'"
            END IF
            CALL aglt310_04()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq002
            NEXT FIELD glaq002                     #返回原欄位
               
      END CONSTRUCT
      
      INPUT tm.glaqld,tm.sdate,tm.edate,tm.kind,
            tm.showstyle,tm.fix_type,tm.fix_acc,tm.glfa009,tm.glfa008 
           ,tm.show_acc,tm.glac005,tm.stus,tm.glac009,tm.show_ce,tm.show_ye  #160824-00004#3 add
         FROM  glaqld,sdate,edate,kind,showstyle,fix_type,fix_acc,glfa009,glfa008
              ,show_acc,glac005,stus,glac009,show_ce,show_ye  #160824-00004#3 add
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT

         AFTER FIELD glaqld
            IF NOT cl_null(tm.glaqld) THEN
               LET l_tok = base.StringTokenizer.createExt(tm.glaqld,'|','',TRUE)
               LET l_glaa004_o=''
               IF l_tok.countTokens() > 0 THEN
                  WHILE l_tok.hasMoreTokens()
                     LET l_glaqld= l_tok.nextToken()
                     SELECT COUNT(*) INTO l_cnt FROM glaa_t WHERE glaaent=g_enterprise AND glaald=l_glaqld
                     IF l_cnt=0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'agl-00055'
                        LET g_errparam.extend = l_glaqld
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                        NEXT FIELD glaqld
                     END IF
                     #160811-00039#4--add--str--
                     SELECT COUNT(*) INTO l_cnt FROM glaa_t WHERE glaaent=g_enterprise AND glaald=l_glaqld AND glaastus='Y'
                     IF l_cnt=0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'agl-00051'
                        LET g_errparam.extend = l_glaqld
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                     
                        NEXT FIELD glaqld
                     END IF
                     IF NOT s_ld_chk_authorization(g_user,l_glaqld) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'agl-00165'
                        LET g_errparam.extend = l_glaqld
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     
                        NEXT FIELD glaqld
                     END IF
                     #160811-00039#4--add--end
                     SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=l_glaqld
                     IF cl_null(l_glaa004_o) THEN
                        LET l_glaa004_o = l_glaa004
                     ELSE
                        IF l_glaa004_o <> l_glaa004 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'agl-00310'
                           LET g_errparam.extend = l_glaqld
                           LET g_errparam.popup = FALSE
                           CALL cl_err()
                           NEXT FIELD glaqld
                        END IF
                     END IF
                  END WHILE
               END IF
            END IF  
            LET g_str = tm.glaqld              
            LET g_glaa004=l_glaa004_o

            AFTER FIELD sdate
               IF NOT cl_null(tm.sdate) THEN
                  IF NOT cl_null(tm.edate) THEN
                     IF tm.sdate>tm.edate THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'agl-00116'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
               
                        NEXT FIELD sdate
                     END IF
                  END IF
               END IF
         
            AFTER FIELD edate
               IF NOT cl_null(tm.edate) THEN
                  IF NOT cl_null(tm.sdate) THEN
                     IF tm.sdate>tm.edate THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'agl-00117'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
            
                        NEXT FIELD edate
                     END IF
                  END IF
               END IF

            AFTER FIELD glfa009
               IF NOT cl_ap_chk_Range(tm.glfa009,"0","1","","","azz-00079",1) THEN
                  NEXT FIELD glfa009
               END IF
            
            ON CHANGE showstyle
               
            ON CHANGE fix_type
            #160824-00004#3--add--str--
            AFTER FIELD show_acc
               IF tm.show_acc NOT MATCHES '[yYnN]' THEN
                  NEXT FIELD show_acc
               END IF
            
            AFTER FIELD glac005
               IF NOT cl_ap_chk_Range(tm.glac005,"1","1","99","1","azz-00087",1) THEN
                  NEXT FIELD glac005
               END IF
            
            AFTER FIELD stus
               IF tm.stus NOT MATCHES '[123]' THEN
                  NEXT FIELD stus
               END IF
               
            AFTER FIELD glac009
               IF tm.glac009 NOT MATCHES '[yYnN]' THEN
                  NEXT FIELD glac009
               END IF
               
            AFTER FIELD show_ce
               IF tm.show_ce NOT MATCHES '[yYnN]' THEN
                  NEXT FIELD show_ce
               END IF
            
            AFTER FIELD show_ye
               IF tm.show_ye NOT MATCHES '[yYnN]' THEN
                  NEXT FIELD show_ye
               END IF
            #160824-00004#3--add--end   
            ON ACTION controlp INFIELD glaqld
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
            
               #給予arg
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               CALL q_authorised_ld()                                #呼叫開窗
               LET g_str = g_qryparam.return1
               LET tm.glaqld = g_qryparam.return1
               DISPLAY tm.glaqld TO glaqld  
               NEXT FIELD glaqld
               
            ON ACTION controlp INFIELD fix_acc
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CASE tm.fix_type
                  WHEN '1' #營運據點
                     LET g_qryparam.where = " ooef201 = 'Y' "   #161021-00037#2 add
                     CALL q_ooef001()
                  WHEN '2' #部門
                     LET g_qryparam.where = "ooegstus='Y'"
                     CALL q_ooeg001_4()
                  WHEN '3' #利潤/成本中心
                     LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
                     CALL q_ooeg001_4() 
                  WHEN '4' #區域
                     LET g_qryparam.arg1 = '287'
                     CALL q_oocq002_287()  
                  WHEN '5' #交易客商
                     CALL q_pmaa001_25()      #160913-00017#4  add
                    #CALL q_pmaa001()        #160913-00017#4  mark    
                  WHEN '6' #帳款客戶
                     CALL q_pmaa001_25()      #160913-00017#4  add
                     #CALL q_pmaa001()        #160913-00017#4  mark    
                  WHEN '7' #客群
                     CALL q_oocq002_281() 
                  WHEN '8' #產品類別
                     CALL q_rtax001_1() 
                  WHEN '9' #經營方式
                     LET g_qryparam.arg1 = '6013'
                     CALL q_gzcb001()
                  WHEN '10' #渠道
                     CALL q_oojd001_2()
                  WHEN '11' #品牌
                     CALL q_oocq002_2002() 
                  WHEN '12' #人員
                     CALL q_ooag001_8()
                  WHEN '13' #專案
                     CALL q_pjba001()
                  WHEN '14' #WBS
                     LET g_qryparam.where = "pjbb012='1' "
                     CALL q_pjbb002()
                  WHEN '15' #自由核算項一
                     CALL q_glar024()
                  WHEN '16' #自由核算項二
                     CALL q_glar025()
                  WHEN '17' #自由核算項三
                     CALL q_glar026()
                  WHEN '18' #自由核算項四
                     CALL q_glar027()
                  WHEN '19' #自由核算項五
                     CALL q_glar028()
                  WHEN '20' #自由核算項六
                     CALL q_glar029()
                  WHEN '21' #自由核算項七
                     CALL q_glar030()
                  WHEN '22' #自由核算項八
                     CALL q_glar031()
                  WHEN '23' #自由核算項九
                     CALL q_glar032()
                  WHEN '24' #自由核算項十
                     CALL q_glar033()
               END CASE
               LET tm.fix_acc = g_qryparam.return1
               DISPLAY tm.fix_acc TO fix_acc  #顯示到畫面上
               NEXT FIELD fix_acc               
      END INPUT

      #end add-point 
 
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
 
   END DIALOG
 
   
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
   #科目条件
   IF cl_null(g_str_glaq002) THEN LET g_str_glaq002 = " 1=1" END IF

   LET g_error_show = 1
   
   #抓取符合條件的資料
   CALL cl_err_collect_init()
   LET g_success = TRUE
   CALL aglq850_set_text()
   IF g_text.getLength() > 0 THEN
      CALL aglq850_get_data()
   END IF
   IF g_success = FALSE THEN
      CALL cl_err_collect_show()
      CALL g_glaq_d.clear()
   ELSE
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
   END IF
   
   LET g_error_show = 0
   LET l_ac = g_master_idx
#   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "" 
#      LET g_errparam.code   = -100 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
# 
#   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   CALL cl_set_act_visible("accept,cancel", FALSE)
END FUNCTION

################################################################################
# Descriptions...: 查询符合条件的科目及金额
# Memo...........:
# Usage..........: CALL aglq850_get_data()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/3/2 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq850_get_data()
   DEFINE l_glaqld_str          STRING
   DEFINE l_glaq002_str         STRING
   DEFINE l_sql1,l_sql2,l_sql3  STRING
   DEFINE l_glac002             LIKE glac_t.glac002
   DEFINE l_glac003             LIKE glac_t.glac003
   DEFINE l_glac008             LIKE glac_t.glac008
   DEFINE l_field_value         LIKE type_t.chr100
   DEFINE l_amt1,l_amt2,l_amt3  LIKE type_t.num20_6
   DEFINE l_amt4,l_amt5,l_amt6  LIKE type_t.num20_6
   DEFINE l_i,l_j               LIKE type_t.num10
   DEFINE l_dw                  LIKE type_t.num10 #金额单位
   #160824-00004#3--add--str--
   DEFINE l_sql_1,l_sql_2,l_sql_3      STRING
   DEFINE l_sql_ce,l_sql_pr11          STRING
   DEFINE l_sql_pr1,l_sql_pr2          STRING
   DEFINE l_glaq002                    STRING
   DEFINE l_glac002_str                STRING
   #160824-00004#3--add--end
   DEFINE l_glav004             LIKE glav_t.glav004 #160824-00004#4 add
   
   
   #160824-00004#3--add--str--
   #顯示統制科目否
   IF tm.show_acc<>'Y' THEN
      LET l_sql_1=l_sql_1," AND glac003<>'1' "
   END IF
   #科目層級
   IF NOT cl_null(tm.glac005) THEN
      LET l_sql_1=l_sql_1," AND glac005<=",tm.glac005
   END IF
   #含內部管理科目否
   IF tm.glac009<>'Y' THEN
      LET l_sql_1=l_sql_1," AND glac009<>'Y' "
   END IF
   #顯示年結YE憑證否
   IF tm.show_ye<>'Y' THEN
      LET l_sql_2=l_sql_2," AND glap007<>'YE' "
   END IF
   #單據狀態
   CASE
      WHEN tm.stus='1'
         LET l_sql_3=l_sql_3," AND glapstus='S' "
      WHEN tm.stus='2'
         LET l_sql_3=l_sql_3," AND glapstus IN ('S','Y') "
      WHEN tm.stus='3'
         LET l_sql_3=l_sql_3," AND glapstus IN ('S','Y','N') "
   END CASE
   #160824-00004#3--add--end
   
   #抓出所有符合條件的會計科目
#160505-00007#19 mod s------
#   LET g_sql="SELECT DISTINCT glac002 FROM glac_t",
#             " WHERE glacent=",g_enterprise,
#             "   AND glac001='",g_glaa004,"' "
   LET g_sql="SELECT DISTINCT glac002,",
             "       (SELECT glacl004 FROM glacl_t WHERE glaclent = '",g_enterprise,"' AND glacl001 = '",g_glaa004,"' AND glacl002 = glac002 AND glacl003 = '",g_dlang,"') ",
             "       ,glac003,glac008 ", #160824-00004#3 add
             "  FROM glac_t",
             " WHERE glacent=",g_enterprise,
             "   AND glac001='",g_glaa004,"' "  
            ,l_sql_1 #160824-00004#3 add
#   PREPARE aglq850_pr01 FROM g_sql #160824-00004#3 mark       
#160505-00007#19 mod s------           
   #科目条件
   LET l_glaq002_str=cl_replace_str(g_str_glaq002,"glaq002","glac002")
   LET g_sql=g_sql," AND ",l_glaq002_str
   
   #帳套條件
   LET l_glaqld_str=cl_replace_str(g_str,"|","','")
   LET l_glaqld_str="'",l_glaqld_str,"'"
   #當勾選核算項類型時查詢啟用該核算項的科目
   IF NOT cl_null(tm.fix_type) AND tm.fix_type<> '1' THEN
      LET g_sql=g_sql," AND glac002 IN (SELECT DISTINCT glad001 FROM glad_t ",
                      "                  WHERE gladent =",g_enterprise," AND gladld IN (",l_glaqld_str,")",
                      "                    AND ",g_field_2," = 'Y' ",
                      "                   )"
   END IF
   LET g_sql=g_sql," ORDER BY glac002"
   PREPARE aglq850_glac002_pr FROM g_sql
   DECLARE aglq850_glac002_cs CURSOR FOR aglq850_glac002_pr

#160505-00007#19 add s------
#160824-00004#3--mark--str--
#  LET g_sql = " SELECT glac003,glac008 FROM glac_t ",
#              "  WHERE glacent= '",g_enterprise,"' AND glac001='",g_glaa004,"' AND glac002= ? "
#  PREPARE aglq850_glac003_pr FROM g_sql 
#160824-00004#3--mark--end
#160505-00007#19 add e------      

   IF NOT cl_null(tm.fix_type) THEN
      IF tm.kind = '1' THEN  #160824-00004#3 add
         #發生額(借-貸)且狀態為1：已過帳
         LET l_sql1="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                    "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                    " WHERE glaqent=",g_enterprise," AND glaqld IN (",l_glaqld_str,")",
                    "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
#                    "   AND glaq002 LIKE ? AND ",g_field,"=? ",  #160824-00004#3 mark
                    "   AND ",g_field,"=? ", #160824-00004#3 add
#                    "   AND glapstus='S'" #160824-00004#3 mark
                    l_sql_2,l_sql_3        #160824-00004#3 add
      
      ELSE  #160824-00004#3 add
         #累計額(借-貸)且狀態為1：已過帳
         LET l_sql2="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                   "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   " WHERE glaqent=",g_enterprise," AND glaqld IN (",l_glaqld_str,")",
                   "   AND glapdocdt <= '",tm.edate,"' AND glap002>= ",YEAR(tm.sdate),
#                   "   AND glaq002 LIKE ? AND ",g_field,"=? ", #160824-00004#3 mark
                   "   AND ",g_field,"=? ", #160824-00004#3 add
#                   "   AND glapstus='S'" #160824-00004#3 mark
                   l_sql_2,l_sql_3        #160824-00004#3 add
                   
         #年初數
         LET l_sql3="SELECT SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037) FROM glar_t",    
                   " WHERE glarent=",g_enterprise," AND glarld IN (",l_glaqld_str,")",
                   "   AND glar001=? AND ",g_field_3,"=? ",
                   "   AND glar002=",YEAR(tm.sdate)," AND glar003=0"
      END IF  #160824-00004#3 add
      
      #160824-00004#3--add--str--
      #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
      IF tm.show_ce <> 'Y' THEN
         IF tm.kind = '1' THEN
            #發生額(借-貸)且狀態為
            LET l_sql_ce="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                         "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                         " WHERE glaqent=",g_enterprise,
                         "   AND glaqld IN (",l_glaqld_str,")",
                         "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                         "   AND ",g_field,"=? ",l_sql_3
         ELSE
            #累計額(借-貸)且狀態為1：已過帳
            LET l_sql_ce="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                         "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                         " WHERE glaqent=",g_enterprise,
                         "   AND glaqld IN (",l_glaqld_str,")",
                         "   AND glapdocdt <= '",tm.edate,"' AND glap002>= ",YEAR(tm.sdate),
                         "   AND ",g_field,"=? ",l_sql_3
         END IF
      END IF
      #160824-00004#3--add--end
      
   ELSE
      IF tm.kind = '1' THEN #160824-00004#3 add
         #發生額(借-貸)且狀態為1：已過帳
         LET l_sql1="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                    "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                    " WHERE glaqent=",g_enterprise,
                    "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
#                    "   AND glaq002 LIKE ? AND glaqld = ? ", #160824-00004#3 mark
                    "   AND glaqld = ? ", #160824-00004#3 add
#                    "   AND glapstus='S'" #160824-00004#3 mark
                    l_sql_2,l_sql_3        #160824-00004#3 add
      
      ELSE #160824-00004#3 add
         #累計額(借-貸)且狀態為1：已過帳
         LET l_sql2="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                   "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   " WHERE glaqent=",g_enterprise,
                   "   AND glapdocdt <= '",tm.edate,"' AND glap002>= ",YEAR(tm.sdate),
#                   "   AND glaq002 LIKE ? AND glaqld = ? ", #160824-00004#3 mark
                   "   AND glaqld = ? ", #160824-00004#3 add
#                   "   AND glapstus='S'" #160824-00004#3 mark
                   l_sql_2,l_sql_3        #160824-00004#3 add
      
         #年初數
         LET l_sql3="SELECT SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037) FROM glar_t",    
                   " WHERE glarent=",g_enterprise,
                   "   AND glar001=? AND glarld = ? ",
                   "   AND glar002=",YEAR(tm.sdate)," AND glar003=0"
      END IF #160824-00004#3 add
      
      #160824-00004#3--add--str--
      #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
      IF tm.show_ce <> 'Y' THEN
         IF tm.kind = '1' THEN
            #發生額(借-貸)且狀態為1：已過帳
            LET l_sql_ce="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                         "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                         " WHERE glaqent=",g_enterprise,
                         "   AND glaqld = ? ",
                         "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                         l_sql_3
         ELSE   
            #累計額(借-貸)且狀態為1：已過帳
            LET l_sql_ce="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                         "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                         " WHERE glaqent=",g_enterprise,
                         "   AND glaqld = ? ",
                         "   AND glapdocdt <= '",tm.edate,"' AND glap002>= ",YEAR(tm.sdate),
                         l_sql_3
         END IF
         #160824-00004#3--add--end
      END IF
   END IF
#160824-00004#3--mark--str--
#   #發生額(借-貸)
#   PREPARE aglq850_sel_pr1 FROM l_sql1 
#   #整期間累計額(借-貸)
#   PREPARE aglq850_sel_pr2 FROM l_sql2
#160824-00004#3--mark--end
   IF tm.kind = '2' THEN #累計餘額  #160824-00004#3 add
      #年初數
      PREPARE aglq850_sel_pr3 FROM l_sql3
   END IF #160824-00004#3 add
   
#160505-00007#19 add s------
   LET l_dw=1
   CASE tm.glfa008
      WHEN '1' #元
         LET l_dw=1
      WHEN '2' #千
         LET l_dw=1000
      WHEN '3' #万
         LET l_dw=10000
   END CASE
#160505-00007#19 add e------

   #160824-00004#4--add--str--
   #抓取該年第一天
   SELECT MIN(glav004) INTO l_glav004 FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=YEAR(tm.sdate)
   #160824-00004#4--add--end
   
   CALL g_glaq_d.clear()
   LET l_i=1
   FOREACH aglq850_glac002_cs INTO l_glac002,g_glaq_d[l_i].glaq002_desc  #160505-00007#19 add g_glaq_d[l_i].glaq002_desc
                                  ,l_glac003,l_glac008  #160824-00004#3 add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'FOREACH aglq850_glac002_cs'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF
      LET g_glaq_d[l_i].sel='N'
      LET g_glaq_d[l_i].glaq002=l_glac002
      #會計科目名稱
#160505-00007#19 mod s----      
#      SELECT glacl004 INTO g_glaq_d[l_i].glaq002_desc FROM glacl_t
#       WHERE glaclent = g_enterprise
#         AND glacl001 = g_glaa004
#         AND glacl002 = l_glac002
#         AND glacl003 = g_dlang
#160505-00007#19 mod e----

      #餘額方向
#160505-00007#19 mod s----      
#      SELECT glac003,glac008 INTO l_glac003,l_glac008 FROM glac_t
#       WHERE glacent=g_enterprise AND glac001=g_glaa004 AND glac002=l_glac002
#      EXECUTE aglq850_glac003_pr USING l_glac002 INTO l_glac003,l_glac008 #160824-00004#3 mark
#160505-00007#19 mod e----      
      #當統制科目時匯總該統制科目下層所以明細科目
      #160824-00004#3--mod--str--
#      IF l_glac003 = '1' THEN
#         LET l_glac002=l_glac002,"%"
#      END IF
      #抓取科目对应的明细科目或者独立科目
      #当为统治科目时抓取下层明细科目
      LET l_glaq002=''
      IF l_glac003='1' THEN 
         CALL s_voucher_get_glac_str(g_glaa004,l_glac002) RETURNING l_glaq002
      END IF
      
      IF cl_null(l_glaq002) THEN
         LET l_glaq002 = "'",l_glac002,"'"
      END IF
      
      IF tm.show_ce <> 'Y' THEN
         LET l_glac002_str = " AND glac002 IN (",l_glaq002,")"
      END IF
      
      #当该统治科目没有下层明细科目时，抓取该科目本身资料      
      LET l_glaq002 = " AND glaq002 IN (",l_glaq002,")"
         
      IF tm.kind = '1' THEN
      #發生額(借-貸)
         LET l_sql_pr1=l_sql1,l_glaq002
         PREPARE aglq850_sel_pr1 FROM l_sql_pr1 
      ELSE
      #累計額(借-貸)
         LET l_sql_pr2=l_sql2,l_glaq002
         PREPARE aglq850_sel_pr2 FROM l_sql_pr2
      END IF
      
      #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
      IF tm.show_ce <> 'Y' THEN
         #160824-00004#4--mod--str--
         LET l_sql_pr11= l_sql_ce,l_glaq002, 
                         " AND (",
                         "      (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                         "                                     WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                         "                                       AND glac007='6' ",l_glac002_str,"))",
                         "       OR ",
                         "      (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                         "                                     WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                         "                                       AND glac010 <> 'N' ",   #排除非费用类科目
                         "                                       AND glac007='5' ",l_glac002_str,
                         "                                   )"
                         #"))",
                         #"     )"
      #按照核算项查询
      IF NOT cl_null(tm.fix_type) THEN
         IF tm.kind = '1' THEN
            #發生額(借-貸)且狀態為1：已過帳
            LET l_sql_pr11= l_sql_pr11,
#                            "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                            "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
                            "                                             WHERE xceaent=",g_enterprise," AND xceald IN (",l_glaqld_str,")",
#                            "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                            "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", #161027-00022#1 add
                            "                                               AND xcea001 BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                            "                                     )",
                            "       )",
                            "     )"
         ELSE                
            LET l_sql_pr11= l_sql_pr11, 
#                            "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                            "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
                            "                                             WHERE xceaent=",g_enterprise," AND xceald IN (",l_glaqld_str,")",
#                            "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                            "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", #161027-00022#1 add
                            "                                               AND xcea001>='",l_glav004,"' AND xcea001<='",tm.edate,"'",
                            "                                     )",
                            "       )",
                            "     )"
         END IF
      ELSE
      #按照账套查询
         IF tm.kind = '1' THEN
            #發生額(借-貸)且狀態為1：已過帳
            LET l_sql_pr11= l_sql_pr11,
#                            "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                            "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
                            "                                             WHERE xceaent=",g_enterprise," AND xceald = ?",
#                            "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                            "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", #161027-00022#1 add
                            "                                               AND xcea001 BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                            "                                     )",
                            "       )",
                            "     )"
         ELSE                
            LET l_sql_pr11= l_sql_pr11, 
#                            "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                            "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
                            "                                             WHERE xceaent=",g_enterprise," AND xceald = ?",
#                            "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                            "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", #161027-00022#1 add
                            "                                               AND xcea001>='",l_glav004,"' AND xcea001<='",tm.edate,"'",
                            "                                     )",
                            "       )",
                            "     )"
         END IF
      END IF
         #160824-00004#4--mod--end
         PREPARE aglq850_ce_pr FROM l_sql_pr11
      END IF      
      #160824-00004#3--mod--end
      
      FOR l_j = 1 TO g_text.getLength()
         #當選擇核算項資料時傳入核算項值，按核算項匯總科目金額
         #當未選擇核算項時傳入帳套值，按帳套匯總科目金額
         IF NOT cl_null(tm.fix_type) THEN
            LET l_field_value=g_text[l_j].fix
         ELSE
            LET l_field_value=g_text[l_j].ld
         END IF
         #發生額
         IF tm.kind='1' THEN
#            EXECUTE aglq850_sel_pr1 USING l_glac002,l_field_value #160824-00004#3 mark
            EXECUTE aglq850_sel_pr1 USING l_field_value            #160824-00004#3 add
                                     INTO l_amt1,l_amt2,l_amt3
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq850_sel_pr1'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_success = FALSE
            END IF
          
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF

         ELSE
         #累計額
            #年初數
            EXECUTE aglq850_sel_pr3 USING g_glaq_d[l_i].glaq002,l_field_value
                                     INTO l_amt1,l_amt2,l_amt3
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq850_sel_pr3'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_success = FALSE
            END IF
            #到截止日期金額匯總
#            EXECUTE aglq850_sel_pr2 USING l_glac002,l_field_value #160824-00004#3 mark
            EXECUTE aglq850_sel_pr2 USING l_field_value            #160824-00004#3 add
                                     INTO l_amt4,l_amt5,l_amt6
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq850_sel_pr2'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_success = FALSE
            END IF 
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
            IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
            LET l_amt1=l_amt1+l_amt4
            LET l_amt2=l_amt2+l_amt5
            LET l_amt3=l_amt3+l_amt6
         END IF
         
         #160824-00004#3--add--str--
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            LET l_amt4=0
            LET l_amt5=0
            LET l_amt6=0
            #按照核算项查询
            IF NOT cl_null(tm.fix_type) THEN #160824-00004#4 add
            EXECUTE aglq850_ce_pr USING l_field_value
                                   INTO l_amt4,l_amt5,l_amt6
            #160824-00004#4--add--str--
            ELSE
            #按照账套查询
               EXECUTE aglq850_ce_pr USING l_field_value,l_field_value
                                      INTO l_amt4,l_amt5,l_amt6
            END IF
            #160824-00004#4--add--end
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq850_ce_pr'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_success = FALSE
            END IF 
            
            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
            IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
            LET l_amt1=l_amt1 - l_amt4
            LET l_amt2=l_amt2 - l_amt5
            LET l_amt3=l_amt3 - l_amt6
         END IF
         #160824-00004#3--add--end
           
         #餘額方向，當glac008=1在借方時，餘額=借-貸；當glac008=2在貸方，餘額=貸-借
         IF l_glac008='2' THEN
            LET l_amt1=(-1)*l_amt1
            LET l_amt2=(-1)*l_amt2
            LET l_amt3=(-1)*l_amt3
         END IF
         
         #金额单位
#160505-00007#19 mark s----         
#         LET l_dw=1
#         CASE tm.glfa008
#            WHEN '1' #元
#               LET l_dw=1
#            WHEN '2' #千
#               LET l_dw=1000
#            WHEN '3' #万
#               LET l_dw=10000
#         END CASE
#160505-00007#19 mark e----

         LET l_amt1=l_amt1/l_dw
         LET l_amt2=l_amt2/l_dw
         LET l_amt3=l_amt3/l_dw
         CASE l_j
            WHEN 1   LET g_glaq_d[l_i].amt1 = l_amt1
            WHEN 2   LET g_glaq_d[l_i].amt2 = l_amt1
            WHEN 3   LET g_glaq_d[l_i].amt3 = l_amt1
            WHEN 4   LET g_glaq_d[l_i].amt4 = l_amt1  
            WHEN 5   LET g_glaq_d[l_i].amt5 = l_amt1
            WHEN 6   LET g_glaq_d[l_i].amt6 = l_amt1
            WHEN 7   LET g_glaq_d[l_i].amt7 = l_amt1
            WHEN 8   LET g_glaq_d[l_i].amt8 = l_amt1
            WHEN 9   LET g_glaq_d[l_i].amt9 = l_amt1
            WHEN 10  LET g_glaq_d[l_i].amt10 = l_amt1  
            WHEN 11  LET g_glaq_d[l_i].amt11 = l_amt1
            WHEN 12  LET g_glaq_d[l_i].amt12 = l_amt1
            WHEN 13  LET g_glaq_d[l_i].amt13 = l_amt1
            WHEN 14  LET g_glaq_d[l_i].amt14 = l_amt1
            WHEN 15  LET g_glaq_d[l_i].amt15 = l_amt1
            WHEN 16  LET g_glaq_d[l_i].amt16 = l_amt1 
            WHEN 17  LET g_glaq_d[l_i].amt17 = l_amt1
            WHEN 18  LET g_glaq_d[l_i].amt18 = l_amt1           
            WHEN 19  LET g_glaq_d[l_i].amt19 = l_amt1
            WHEN 20  LET g_glaq_d[l_i].amt20 = l_amt1
            WHEN 21  LET g_glaq_d[l_i].amt21 = l_amt1
            WHEN 22  LET g_glaq_d[l_i].amt22 = l_amt1 
            WHEN 23  LET g_glaq_d[l_i].amt23 = l_amt1
            WHEN 24  LET g_glaq_d[l_i].amt24 = l_amt1
            WHEN 25  LET g_glaq_d[l_i].amt25 = l_amt1
            WHEN 26  LET g_glaq_d[l_i].amt26 = l_amt1
            WHEN 27  LET g_glaq_d[l_i].amt27 = l_amt1
            WHEN 28  LET g_glaq_d[l_i].amt28 = l_amt1
            WHEN 29  LET g_glaq_d[l_i].amt29 = l_amt1 
            WHEN 30  LET g_glaq_d[l_i].amt30 = l_amt1
            WHEN 31  LET g_glaq_d[l_i].amt31 = l_amt1          
            WHEN 32  LET g_glaq_d[l_i].amt32 = l_amt1
            WHEN 33  LET g_glaq_d[l_i].amt33 = l_amt1
            WHEN 34  LET g_glaq_d[l_i].amt34 = l_amt1
            WHEN 35  LET g_glaq_d[l_i].amt35 = l_amt1
            WHEN 36  LET g_glaq_d[l_i].amt36 = l_amt1
            WHEN 37  LET g_glaq_d[l_i].amt37 = l_amt1
            WHEN 38  LET g_glaq_d[l_i].amt38 = l_amt1
            WHEN 39  LET g_glaq_d[l_i].amt39 = l_amt1
            WHEN 40  LET g_glaq_d[l_i].amt40 = l_amt1
            WHEN 41  LET g_glaq_d[l_i].amt41 = l_amt1
            WHEN 42  LET g_glaq_d[l_i].amt42 = l_amt1
            WHEN 43  LET g_glaq_d[l_i].amt43 = l_amt1
            WHEN 44  LET g_glaq_d[l_i].amt44 = l_amt1          
            WHEN 45  LET g_glaq_d[l_i].amt45 = l_amt1
            WHEN 46  LET g_glaq_d[l_i].amt46 = l_amt1
            WHEN 47  LET g_glaq_d[l_i].amt47 = l_amt1
            WHEN 48  LET g_glaq_d[l_i].amt48 = l_amt1
            WHEN 49  LET g_glaq_d[l_i].amt49 = l_amt1
            WHEN 50  LET g_glaq_d[l_i].amt50 = l_amt1
            WHEN 51  LET g_glaq_d[l_i].amt51 = l_amt1
            WHEN 52  LET g_glaq_d[l_i].amt52 = l_amt1
            WHEN 53  LET g_glaq_d[l_i].amt53 = l_amt1
            WHEN 54  LET g_glaq_d[l_i].amt54 = l_amt1          
            WHEN 55  LET g_glaq_d[l_i].amt55 = l_amt1
            WHEN 56  LET g_glaq_d[l_i].amt56 = l_amt1
            WHEN 57  LET g_glaq_d[l_i].amt57 = l_amt1
            WHEN 58  LET g_glaq_d[l_i].amt58 = l_amt1
            WHEN 59  LET g_glaq_d[l_i].amt59 = l_amt1
            WHEN 60  LET g_glaq_d[l_i].amt60 = l_amt1
            WHEN 61  LET g_glaq_d[l_i].amt61 = l_amt1
            WHEN 62  LET g_glaq_d[l_i].amt62 = l_amt1
            WHEN 63  LET g_glaq_d[l_i].amt63 = l_amt1
            WHEN 64  LET g_glaq_d[l_i].amt64 = l_amt1          
            WHEN 65  LET g_glaq_d[l_i].amt65 = l_amt1
            WHEN 66  LET g_glaq_d[l_i].amt66 = l_amt1
            WHEN 67  LET g_glaq_d[l_i].amt67 = l_amt1
            WHEN 68  LET g_glaq_d[l_i].amt68 = l_amt1
            WHEN 69  LET g_glaq_d[l_i].amt69 = l_amt1
            WHEN 70  LET g_glaq_d[l_i].amt70 = l_amt1
            WHEN 71  LET g_glaq_d[l_i].amt71 = l_amt1
            WHEN 72  LET g_glaq_d[l_i].amt72 = l_amt1
            WHEN 73  LET g_glaq_d[l_i].amt73 = l_amt1
            WHEN 74  LET g_glaq_d[l_i].amt74 = l_amt1          
            WHEN 75  LET g_glaq_d[l_i].amt75 = l_amt1
            WHEN 76  LET g_glaq_d[l_i].amt76 = l_amt1
            WHEN 77  LET g_glaq_d[l_i].amt77 = l_amt1
            WHEN 78  LET g_glaq_d[l_i].amt78 = l_amt1
            WHEN 79  LET g_glaq_d[l_i].amt79 = l_amt1
            WHEN 80  LET g_glaq_d[l_i].amt80 = l_amt1
            WHEN 81  LET g_glaq_d[l_i].amt81 = l_amt1
            WHEN 82  LET g_glaq_d[l_i].amt82 = l_amt1
            WHEN 83  LET g_glaq_d[l_i].amt83 = l_amt1
            WHEN 84  LET g_glaq_d[l_i].amt84 = l_amt1          
            WHEN 85  LET g_glaq_d[l_i].amt85 = l_amt1
            WHEN 86  LET g_glaq_d[l_i].amt86 = l_amt1
            WHEN 87  LET g_glaq_d[l_i].amt87 = l_amt1
            WHEN 88  LET g_glaq_d[l_i].amt88 = l_amt1
            WHEN 89  LET g_glaq_d[l_i].amt89 = l_amt1
            WHEN 90  LET g_glaq_d[l_i].amt90 = l_amt1 
            WHEN 91  LET g_glaq_d[l_i].amt91 = l_amt1
            WHEN 92  LET g_glaq_d[l_i].amt92 = l_amt1 
            WHEN 93  LET g_glaq_d[l_i].amt93 = l_amt1
            WHEN 94  LET g_glaq_d[l_i].amt94 = l_amt1           
            WHEN 95  LET g_glaq_d[l_i].amt95 = l_amt1
            WHEN 96  LET g_glaq_d[l_i].amt96 = l_amt1
            WHEN 97  LET g_glaq_d[l_i].amt97 = l_amt1
            WHEN 98  LET g_glaq_d[l_i].amt98 = l_amt1 
            WHEN 99  LET g_glaq_d[l_i].amt99 = l_amt1
            WHEN 100 LET g_glaq_d[l_i].amt100= l_amt1
         END CASE   
      END FOR
      LET l_i = l_i + 1
   END FOREACH
     
   LET g_detail_cnt = g_glaq_d.getLength() 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET g_detail_idx = 1
   DISPLAY g_detail_idx TO FORMONLY.h_index
END FUNCTION

################################################################################
# Descriptions...: 設置默認值
# Memo...........: #160824-00004#3 add
# Usage..........: CALL aglq850_default_value()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/09/21 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq850_default_value()
   
   INITIALIZE tm.* TO NULL 
   LET tm.sdate=g_today  #起始日期
   LET tm.edate=g_today  #截止日期
   LET tm.kind='1'       #餘額形態
   LET tm.glfa008='1'    #金额 
   LET tm.glfa009=2      #小数位数
   LET tm.showstyle = '1'#報表呈現方式為1：多帳別
   LET tm.show_acc='N'   #統制科目
   LET tm.glac005=99     #科目層級
   LET tm.stus='1'       #單據狀態
   LET tm.glac009='Y'    #含內部管理科目
   LET tm.show_ce='Y'    #含月結傳票
   LET tm.show_ye='Y'    #含年結傳票
END FUNCTION

 
{</section>}
 
