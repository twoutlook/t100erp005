#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq840.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:10(2015-11-03 14:49:19), PR版次:0010(2016-11-03 16:36:47)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000125
#+ Filename...: aglq840
#+ Description: 跨帳套跨組織損益和資產負債查詢
#+ Creator....: 02481(2014-08-20 14:40:46)
#+ Modifier...: 02599 -SD/PR- 01531
 
{</section>}
 
{<section id="aglq840.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#150316-00010#17 2015/05/27 By 01727 增加XG报表
#150916          2015/09/24 By 03538 損益表類型公式抓本期數(A測)為準,加上單頭模板說明;依報表行序排列
#151001-00011#1  2015/10/12 By albireo XG報表增加百分比
#160302-00006#1  2016/03/02 By 07675   原本单身为可查询作业，增加二次筛选功能   
#160318-00025#36 2016/04/20 By 07959   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160727-00019#3  2016/08/01  By 08742  系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   aglq840_print_tmp -->aglq840_tmp01
#160811-00039#4  2016/08/29 By 02599   查询是自行输入账套时要检核账套权限
#160913-00017#3  2016/09/21 By 07900   AGL模组调整交易客商开窗
#161021-00015#1  2016/10/21 By 02599   当选择的报表模板为资产负债表，且结构为左右时，排序改成左右+行序
#161021-00037#2  2016/10/24 By 06821   組織類型與職能開窗調整
#161103-00040#1  2016/11/03 By 01531   资产负债类时，l_glfa011 = 0
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
GLOBALS "../../cfg/top_report.inc"   #150316-00010#17 Add
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_glfb_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   glfbseq LIKE glfb_t.glfbseq, 
   glfbseq1 LIKE glfb_t.glfbseq1, 
   glfb002 LIKE glfb_t.glfb002, 
   glfbl004 LIKE glfbl_t.glfbl004, 
   glfb003 LIKE glfb_t.glfb003, 
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
   amt100 LIKE type_t.num20_6, 
   per LIKE type_t.num20_6, 
   glfb008 LIKE glfb_t.glfb008 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

DEFINE tm                    RECORD
       glfa001               LIKE glfa_t.glfa001,
       glfa001_desc          LIKE type_t.chr80,   #150916
       glfa005               LIKE type_t.chr1000,       
       glfa010               LIKE glfa_t.glfa010,
       glfa011               LIKE glfa_t.glfa011,
       glfa012               LIKE glfa_t.glfa012,
       glfa009               LIKE glfa_t.glfa009,
       glfa008               LIKE glfa_t.glfa008,
       showstyle             LIKE type_t.chr1,
       fix_type              LIKE type_t.chr2,
       option                LIKE type_t.chr1,            #20150706 add lujh
       fix_acc               LIKE type_t.chr1000,
       #20150706--add--str--lujh
       ver                   LIKE ooed_t.ooed003,
       ooed006               LIKE ooed_t.ooed006,
       ooed007               LIKE ooed_t.ooed007,
       #20150706--add--end--lujh
       show_per              LIKE type_t.chr1,
       show_xrbl             LIKE type_t.chr1,
       show_ad               LIKE type_t.chr1,
       stus                  LIKE type_t.chr1,
       chg_curr              LIKE type_t.chr1,
       curr                  LIKE glaq_t.glaq005,
       rate                  LIKE glaq_t.glaq006 
       END RECORD
DEFINE g_glfa002             LIKE glfa_t.glfa002   #報表類型    

DEFINE g_glfbtext  DYNAMIC ARRAY OF RECORD
             sel      LIKE type_t.chr1, 
             glfbseq  LIKE glfb_t.glfbseq, 
             glfbseq1 LIKE glfb_t.glfbseq1, 
             glfb002  LIKE glfb_t.glfb002, 
             glfbl004 LIKE glfbl_t.glfbl004, 
             glfb003  LIKE glfb_t.glfb003, 
             glfb008  LIKE glfb_t.glfb008,
             detail   DYNAMIC ARRAY OF RECORD
                ld       LIKE glaa_t.glaald,
                ld_desc  LIKE glaal_t.glaal003,
                fix      LIKE type_t.chr80,
                fix_desc LIKE type_t.chr100,
                glad0171 LIKE type_t.chr100,
                lc_ld_desc      STRING
                END RECORD
       END RECORD
DEFINE g_str  STRING       
DEFINE g_field         LIKE type_t.chr100
DEFINE g_field_1       LIKE type_t.chr100
#20150706--add--str--lujh
DEFINE g_ooed001       LIKE ooed_t.ooed001
DEFINE g_ooed002       LIKE ooed_t.ooed002   
DEFINE g_ooed003       LIKE ooed_t.ooed003   
DEFINE g_ooed005       LIKE ooed_t.ooed005
#20150706--add--end--lujh
DEFINE g_glfa004       LIKE glfa_t.glfa004
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glfb_d
DEFINE g_master_t                   type_g_glfb_d
DEFINE g_glfb_d          DYNAMIC ARRAY OF type_g_glfb_d
DEFINE g_glfb_d_t        type_g_glfb_d
 
      
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
 
{<section id="aglq840.main" >}
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
   DECLARE aglq840_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq840_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq840_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq840 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq840_init()   
 
      #進入選單 Menu (="N")
      CALL aglq840_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq840
      
   END IF 
   
   CLOSE aglq840_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq840.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq840_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_str STRING,
          l_i   LIKE type_t.num5
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('glfa008','8705')
   CALL cl_set_combo_scc('showstyle','8037')
   CALL cl_set_combo_scc('fix_type','9934')
   CALL cl_set_combo_scc('option','9940')     #20150706 add lujh
   CALL cl_set_comp_entry('option',FALSE)     #20150706 add lujh
   CALL cl_set_comp_entry('ver',FALSE)        #20150706 add lujh    
   CALL cl_set_comp_visible('sel',FALSE)
   CALL cl_set_combo_scc('stus','9922')
   FOR l_i = 1 TO 99         #20150706 change 100 to 99 lujh          
       IF NOT cl_null(l_str) THEN LET l_str = l_str CLIPPED,"," END IF
       LET l_str = l_str,"amt",l_i USING '<<<<' CLIPPED
    END FOR
    CALL cl_set_comp_visible(l_str,FALSE)
    CALL aglq840_create_for_xg()   #150316-00010#17 Add
   #end add-point
 
   CALL aglq840_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aglq840.default_search" >}
PRIVATE FUNCTION aglq840_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glfbseq = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " glfbseq1 = '", g_argv[02], "' AND "
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
 
{<section id="aglq840.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq840_ui_dialog()
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
      CALL aglq840_b_fill()
   ELSE
      CALL aglq840_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glfb_d.clear()
 
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
 
         CALL aglq840_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glfb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq840_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq840_detail_action_trans()
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
            CALL aglq840_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aglq840_xg()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aglq840_xg()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglq840_query()
               #add-point:ON ACTION query name="menu.query"
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
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
            CALL aglq840_filter()
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
            CALL aglq840_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glfb_d)
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
            CALL aglq840_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq840_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq840_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq840_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glfb_d.getLength()
               LET g_glfb_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glfb_d.getLength()
               LET g_glfb_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glfb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glfb_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glfb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glfb_d[li_idx].sel = "N"
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
 
{<section id="aglq840.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq840_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_glfa004  LIKE glfa_t.glfa004
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_glfa002  LIKE glfa_t.glfa002
   DEFINE l_glav006  LIKE glav_t.glav006
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_pass     LIKE type_t.num5
   DEFINE l_flag     LIKE type_t.chr1   #是否多帳套
   DEFINE l_n        LIKE type_t.num5
   DEFINE l_tok  base.stringTokenizer
   DEFINE l_glfa005 LIKE glfa_t.glfa005
   DEFINE l_sql_str  STRING
   #20150706--add--str--lujh
   DEFINE l_sql      STRING  
   DEFINE l_str      STRING  
   DEFINE l_i        LIKE type_t.num5
   #20150706--add--end--lujh
   DEFINE l_glaa004  LIKE glaa_t.glaa004
   
   LET g_glfa002 = ''            #報表類型
   INITIALIZE tm.* TO NULL    
   
   LET tm.glfa010=YEAR(g_today)  #年度
   
   LET tm.glfa011=1              #起始期别
   LET tm.glfa012=MONTH(g_today) #截止期别
    
   LET tm.glfa008='1'            #金额 
   LET tm.glfa009=2              #小数位数
   LET tm.showstyle = '1'        #報表呈現方式為1：多帳別
   LET l_flag = '1'              #默認多帳套)
   
   #20150706--add--str--lujh
   LET tm.option = '1'           #选项   
   CALL cl_set_comp_entry('option',FALSE)     
   CALL cl_set_comp_entry('ver',FALSE)   
   CALL g_glfbtext.clear()
   FOR l_i = 1 TO 99               
      IF NOT cl_null(l_str) THEN LET l_str = l_str CLIPPED,"," END IF
      LET l_str = l_str,"amt",l_i USING '<<<<' CLIPPED
   END FOR
   CALL cl_set_comp_visible(l_str,FALSE)
   #20150706--add--end--lujh   
   
   DISPLAY tm.glfa010 TO glfa010  
   DISPLAY tm.glfa011 TO glfa011
   DISPLAY tm.glfa012 TO glfa012
   DISPLAY tm.glfa008 TO glfa008
   DISPLAY tm.glfa009 TO glfa009
   DISPLAY tm.showstyle TO showstyle
   DISPLAY tm.fix_type TO fix_type
   DISPLAY tm.fix_acc TO fix_acc
   #150827-00036#3--add--str--
   LET tm.show_xrbl='N'
   CALL cl_set_comp_visible("b_glfb008",FALSE)
   DISPLAY tm.show_xrbl TO show_xrbl
   #150827-00036#3--add--end
   #150827-00036#1--add--str--
   LET tm.show_ad='Y'
   LET tm.stus='1'
   LET tm.chg_curr='N'
   LET tm.curr=''
   LET tm.rate=''
   CALL cl_set_comp_entry('curr,rate',FALSE)
   DISPLAY BY NAME tm.show_ad,tm.stus,tm.chg_curr,tm.curr,tm.rate #150827-00036#1 add
   #150827-00036#1--add--end
   #150827-00036#12--add--str--
   #显示比率
   LET tm.show_per = 'Y'   
   DISPLAY BY NAME tm.show_per
   #150827-00036#12--add--end
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glfb_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON glfbseq,glfbseq1,glfb002,glfbl004,glfb003,glfb008
           FROM s_detail1[1].b_glfbseq,s_detail1[1].b_glfbseq1,s_detail1[1].b_glfb002,s_detail1[1].b_glfbl004, 
               s_detail1[1].b_glfb003,s_detail1[1].b_glfb008
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
 
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_glfbseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfbseq
            #add-point:BEFORE FIELD b_glfbseq name="construct.b.page1.b_glfbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfbseq
            
            #add-point:AFTER FIELD b_glfbseq name="construct.a.page1.b_glfbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbseq
            #add-point:ON ACTION controlp INFIELD b_glfbseq name="construct.c.page1.b_glfbseq"
            
            #END add-point
 
 
         #----<<b_glfbseq1>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfbseq1
            #add-point:BEFORE FIELD b_glfbseq1 name="construct.b.page1.b_glfbseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfbseq1
            
            #add-point:AFTER FIELD b_glfbseq1 name="construct.a.page1.b_glfbseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfbseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbseq1
            #add-point:ON ACTION controlp INFIELD b_glfbseq1 name="construct.c.page1.b_glfbseq1"
            
            #END add-point
 
 
         #----<<b_glfb002>>----
         #Ctrlp:construct.c.page1.b_glfb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb002
            #add-point:ON ACTION controlp INFIELD b_glfb002 name="construct.c.page1.b_glfb002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glfc001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glfb002  #顯示到畫面上
            NEXT FIELD b_glfb002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfb002
            #add-point:BEFORE FIELD b_glfb002 name="construct.b.page1.b_glfb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfb002
            
            #add-point:AFTER FIELD b_glfb002 name="construct.a.page1.b_glfb002"
            
            #END add-point
            
 
 
         #----<<b_glfbl004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfbl004
            #add-point:BEFORE FIELD b_glfbl004 name="construct.b.page1.b_glfbl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfbl004
            
            #add-point:AFTER FIELD b_glfbl004 name="construct.a.page1.b_glfbl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfbl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbl004
            #add-point:ON ACTION controlp INFIELD b_glfbl004 name="construct.c.page1.b_glfbl004"
            
            #END add-point
 
 
         #----<<b_glfb003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfb003
            #add-point:BEFORE FIELD b_glfb003 name="construct.b.page1.b_glfb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfb003
            
            #add-point:AFTER FIELD b_glfb003 name="construct.a.page1.b_glfb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb003
            #add-point:ON ACTION controlp INFIELD b_glfb003 name="construct.c.page1.b_glfb003"
            
            #END add-point
 
 
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
         #----<<per>>----
         #----<<b_glfb008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfb008
            #add-point:BEFORE FIELD b_glfb008 name="construct.b.page1.b_glfb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfb008
            
            #add-point:AFTER FIELD b_glfb008 name="construct.a.page1.b_glfb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb008
            #add-point:ON ACTION controlp INFIELD b_glfb008 name="construct.c.page1.b_glfb008"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
        
    INPUT tm.glfa001,tm.glfa005,tm.glfa010,tm.glfa011,tm.glfa012,
          tm.glfa008,tm.glfa009,tm.showstyle,tm.fix_type,tm.option,tm.fix_acc,    #20150706 add tm.option lujh 
          tm.ver,tm.ooed006,tm.ooed007,          #20150706 add lujh
          tm.show_per,                           #150827-00036#12 add
          tm.show_xrbl,                          #150827-00036#3 add
          tm.show_ad,tm.stus,tm.chg_curr,tm.curr,tm.rate  #150827-00036#1 add
           FROM  glfa001,glfa005,glfa010,glfa011,glfa012,glfa008,glfa009,showstyle,fix_type,option,fix_acc,  #20150706 add option lujh       
                 ver,ooed006,ooed007,            #20150706 add lujh
                 show_per,                       #150827-00036#12 add 
                 show_xrbl,                      #150827-00036#3 add
                 show_ad,stus,chg_curr,curr,rate #150827-00036#1 add
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
     
      AFTER FIELD glfa001
            IF cl_null(tm.glfa001) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'acr-00015'
               LET g_errparam.extend = tm.glfa001
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD glfa001
            END IF 
            
            IF NOT cl_null(tm.glfa001) THEN
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt FROM glfa_t
                WHERE glfaent=g_enterprise AND glfa001=tm.glfa001 AND glfa002 <> '3'
               IF l_cnt=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00249'
                  LET g_errparam.extend = tm.glfa001
                  LET g_errparam.popup = FALSE
                  LET tm.glfa001_desc = ''                  #150916
                  DISPLAY tm.glfa001_desc TO glfa001_desc   #150916                  
                  CALL cl_err()
                  NEXT FIELD glfa001
               END IF
               
               LET g_glfa002 = ''  #报表类型
               LET g_glfa004 = ''  #科目参照表
               SELECT glfa002,glfa004 INTO g_glfa002,g_glfa004 FROM glfa_t
                WHERE glfaent=g_enterprise AND glfa001=tm.glfa001
               IF g_glfa002 = '1' THEN   #資產負債類
                  LET tm.glfa011 = ''
                  CALL cl_set_comp_required('glfa011',FALSE)
                  CALL cl_set_comp_entry('glfa011',FALSE)
               END IF
               IF g_glfa002 = '2' THEN   #損益類
                  LET tm.glfa011 = 1
                  CALL cl_set_comp_entry('glfa011',TRUE)
                  CALL cl_set_comp_required('glfa011',TRUE)
               END IF 
               DISPLAY tm.glfa011 TO glfa011  
            
               CALL aglq840_glfa001_desc()   #150916               
            END IF  

            AFTER FIELD glfa005
              IF NOT cl_null(tm.glfa005) THEN
                 LET l_tok = base.StringTokenizer.createExt(tm.glfa005,'|','',TRUE)
                 IF l_tok.countTokens() > 0 THEN
                    WHILE l_tok.hasMoreTokens()
                       LET l_glfa005= l_tok.nextToken()
                       SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=l_glfa005
                       IF SQLCA.sqlcode=100 THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'agl-00055'
                          LET g_errparam.extend = l_glfa005
                          LET g_errparam.popup = FALSE
                          CALL cl_err()
                          NEXT FIELD glfa005
                       END IF
                       #160811-00039#4--add--str--
                       SELECT COUNT(*) INTO l_cnt FROM glaa_t WHERE glaaent=g_enterprise AND glaald=l_glfa005 AND glaastus='Y'
                       IF l_cnt=0 THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'agl-00051'
                          LET g_errparam.extend = l_glfa005
                          LET g_errparam.popup = FALSE
                          CALL cl_err()
                          NEXT FIELD glfa005
                       END IF
                       IF NOT s_ld_chk_authorization(g_user,l_glfa005) THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'agl-00165'
                          LET g_errparam.extend = l_glfa005
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                          NEXT FIELD glfa005
                       END IF
                       #160811-00039#4--add--end
                       IF NOT cl_null(g_glfa004) AND l_glaa004 <> g_glfa004 THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'agl-00242'
                          LET g_errparam.extend = l_glfa005
                          LET g_errparam.popup = FALSE
                          CALL cl_err()
                          NEXT FIELD glfa005
                       END IF
                    END WHILE
                 END IF
              END IF  
              LET g_str = tm.glfa005              
           
           
            AFTER FIELD glfa011
               IF tm.glfa011>tm.glfa012 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'agl-00227'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = FALSE
                   CALL cl_err()
               
                   NEXT FIELD glfa011
               END IF
               SELECT MAX(glav006) INTO l_glav006 FROM glav_t
               WHERE glavent=g_enterprise AND glav001=l_glfa004 AND glav002=tm.glfa010
               IF NOT cl_null(l_glav006) THEN
                  IF tm.glfa011>l_glav006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'sub-00427'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
               
                     NEXT FIELD glfa011
                  END IF
               END IF

            AFTER FIELD glfa012
               IF tm.glfa012<tm.glfa011 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'agl-00228'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = FALSE
                   CALL cl_err()
                   NEXT FIELD glfa012
               END IF
               SELECT MAX(glav006) INTO l_glav006 FROM glav_t
               WHERE glavent=g_enterprise AND glav001=l_glfa004 AND glav002=tm.glfa010
               IF NOT cl_null(l_glav006) THEN
                  IF tm.glfa012>l_glav006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'sub-00427'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
               
                     NEXT FIELD glfa012
                  END IF
               END IF 

            AFTER FIELD glfa009
               IF NOT cl_ap_chk_Range(tm.glfa009,"0","1","","","azz-00079",1) THEN
                  NEXT FIELD glfa009
               END IF
            
            ON CHANGE showstyle
               IF tm.showstyle = '2' THEN
                  LET l_flag = '2'    #單帐套
#                  #當呈現方式是單帳套時檢查 帳套是否有多選
#                  LET l_n = 0
#                  LET l_tok = base.StringTokenizer.createExt(g_str,'|','',TRUE)
#                  IF l_tok.countTokens() > 0 THEN
#                     WHILE l_tok.hasMoreTokens()
#                       LET l_glfa005= l_tok.nextToken()
#                       LET g_glfbtext[1].detail[g_glfbtext[1].detail.getLength()+1].amt=l_glfa005 CLIPPED
#                       LET l_n = l_n +1
#                     END WHILE
#                  END IF
#                  IF l_n > 1 THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'agl-00278'
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = FALSE
#                     CALL cl_err()
#                     NEXT FIELD glfa005
#                  END IF   
                  
               ELSE
                  LET l_flag = '1'    #多帐套        
               END IF  
               
            ON CHANGE fix_type
               #20150706--add--end--lujh
               IF tm.fix_type MATCHES '[123]' THEN 
                  CALL cl_set_comp_entry('option',TRUE)
               ELSE
                  CALL cl_set_comp_entry('option',FALSE)
                  CALL cl_set_comp_entry('ver',FALSE)
                  LET tm.option = '1'
                  LET tm.ver = ''
               END IF
               IF tm.fix_type MATCHES '[123]' AND tm.option MATCHES '[23]' THEN 
                  CALL cl_set_comp_required('fix_acc',TRUE)
               ELSE
                  CALL cl_set_comp_required('fix_acc',FALSE)
               END IF
               #20150706--add--end--lujh
            
            #20150706--add--end--lujh            
            ON CHANGE option   
               IF tm.fix_type MATCHES '[123]' AND tm.option MATCHES '[23]' THEN 
                  CALL cl_set_comp_required('fix_acc',TRUE)
                  CALL cl_set_comp_entry('ver',TRUE)
                  #2015/11/03--by--02599--add--str--
                  IF tm.fix_type = '1' THEN 
                     LET g_ooed001 = '8'
                  END IF
                  IF tm.fix_type MATCHES '[23]' THEN 
                     LET g_ooed001 = '1'
                  END IF
                  
                  IF NOT cl_null(tm.fix_acc) THEN
                     LET l_sql = "SELECT DISTINCT ooed005,ooed002,ooed003,ooed006,ooed007 ",
                                 "  FROM ooed_t", 
                                 " WHERE ooedent = '",g_enterprise,"'", 
                                 "   AND ooed001 = '",g_ooed001,"'", 
                                 "   AND ooed004 <> ooed005 ",
                                 "   AND ooed005 = '",tm.fix_acc,"'",
                                 "   AND ooed006 <= '",g_today,"'",
                                 "   AND (ooed007 IS NULL OR ooed007 >= '",g_today,"')"   
                     IF NOT cl_null(tm.ver) THEN 
                        LET l_sql = l_sql," AND ooed003 = '",tm.ver,"'"
                     END IF
                     
                     LET l_sql = l_sql," ORDER BY ooed002,ooed005"
                     PREPARE aglq840_ooed_pre1 FROM l_sql
                     EXECUTE aglq840_ooed_pre1 INTO g_ooed005,g_ooed002,g_ooed003,tm.ooed006,tm.ooed007
                       
                     LET tm.ver = g_ooed003  
                     DISPLAY tm.ver,tm.ooed006,tm.ooed007 TO ver,ooed006,ooed007
                  END IF
                  #2015/11/03--by--02599--add--end
               ELSE
                  CALL cl_set_comp_required('fix_acc',FALSE)
                  CALL cl_set_comp_entry('ver',FALSE)
               END IF
            
            AFTER FIELD fix_acc
               IF NOT cl_null(tm.fix_acc) AND tm.option MATCHES '[23]' THEN
                  IF tm.fix_type = '1' THEN 
                     LET g_ooed001 = '8'
                  END IF
                  IF tm.fix_type MATCHES '[23]' THEN 
                     LET g_ooed001 = '1'
                  END IF
                  
                  LET l_sql = "SELECT DISTINCT ooed005,ooed002,ooed003,ooed006,ooed007 ",
                              "  FROM ooed_t", 
                              " WHERE ooedent = '",g_enterprise,"'", 
                              "   AND ooed001 = '",g_ooed001,"'", 
                              "   AND ooed004 <> ooed005 ",
                              "   AND ooed005 = '",tm.fix_acc,"'",
                              "   AND ooed006 <= '",g_today,"'",
                              "   AND (ooed007 IS NULL OR ooed007 >= '",g_today,"')"   
                  IF NOT cl_null(tm.ver) THEN 
                     LET l_sql = l_sql," AND ooed003 = '",tm.ver,"'"
                  END IF
                  
                  LET l_sql = l_sql," ORDER BY ooed002,ooed005"
                  PREPARE aglq840_ooed_pre FROM l_sql
                  EXECUTE aglq840_ooed_pre INTO g_ooed005,g_ooed002,g_ooed003,tm.ooed006,tm.ooed007
                    
                  LET tm.ver = g_ooed003  
                  DISPLAY tm.ver,tm.ooed006,tm.ooed007 TO ver,ooed006,ooed007
               END IF
               
            AFTER FIELD ver
               IF NOT cl_null(tm.ver) THEN 
                  LET g_ooed003 = tm.ver
               END IF
            #20150706--add--end--lujh
        
         #150827-00036#12--add--str--
         ON CHANGE show_per
            IF tm.show_per = 'Y' THEN
               CALL cl_set_comp_visible('per',TRUE)
            ELSE
               CALL cl_set_comp_visible('per',FALSE)
            END IF
         #150827-00036#12--add--end
         
         #150827-00036#3--add--str--
         ON CHANGE show_xrbl
            IF tm.show_xrbl = 'Y' THEN
               CALL cl_set_comp_visible('b_glfb008',TRUE)
            ELSE
               CALL cl_set_comp_visible('b_glfb008',FALSE)
            END IF
         #150827-00036#3--add--end
            
         #150827-00036#1--add--str--
         AFTER FIELD show_ad
            IF tm.show_ad NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ad
            END IF
         
         AFTER FIELD stus
            IF tm.stus NOT MATCHES '[123]' THEN
               NEXT FIELD stus
            END IF
         
         ON CHANGE chg_curr
            IF tm.chg_curr = 'Y' THEN
               CALL cl_set_comp_entry('curr,rate',TRUE)
            ELSE
               CALL cl_set_comp_entry('curr,rate',FALSE)
               LET tm.curr=''
               LET tm.rate=''
               DISPLAY BY NAME tm.curr,tm.rate
            END IF
            
         AFTER FIELD curr
            IF NOT cl_null(tm.curr) THEN
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=tm.curr
               
               #160318-00025#36  2016/04/20  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
               #160318-00025#36  2016/04/20  by pengxin  add(E)
               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET tm.curr=''
                  NEXT FIELD CURRENT
               END IF
            END IF
            
         AFTER FIELD rate
            IF NOT cl_null(tm.rate) THEN
               CALL s_num_isnum(tm.rate) RETURNING l_success
               IF l_success=FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD rate
               END IF
            END IF
         #150827-00036#1--add--end
         
            ON ACTION controlp INFIELD glfa001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " glfa002<> '3' "
               CALL q_glfa001()                          #呼叫開窗
               LET tm.glfa001 = g_qryparam.return1
               DISPLAY tm.glfa001 TO glfa001  #顯示到畫面上
               CALL aglq840_glfa001_desc()   #150916
               NEXT FIELD glfa001  
            
            ON ACTION controlp INFIELD glfa005
               INITIALIZE g_qryparam.* TO NULL
#               IF l_flag = '1' THEN
                  LET g_qryparam.state = 'c'
#               ELSE
#                  LET g_qryparam.state = 'i'
#               END IF
               LET g_qryparam.reqry = FALSE
            
               #給予arg
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               IF NOT cl_null(tm.glfa001) THEN
                  SELECT glfa004 INTO l_glfa004 FROM glfa_t WHERE glfaent=g_enterprise AND glfa001=tm.glfa001
                  LET g_qryparam.where = " glaa004='",l_glfa004,"'"
               END IF
               CALL q_authorised_ld()                                #呼叫開窗
               LET g_str = g_qryparam.return1
               LET tm.glfa005 = g_qryparam.return1
               DISPLAY tm.glfa005 TO glfa005  
               
               NEXT FIELD glfa005
            ON ACTION controlp INFIELD fix_acc
               INITIALIZE g_qryparam.* TO NULL
               #20150706--add--str--lujh
               IF tm.fix_type MATCHES '[123]' AND tm.option MATCHES '[23]' THEN 
                  LET g_qryparam.state = 'i'
               ELSE
               #20150706--add--end--lujh
                  LET g_qryparam.state = 'c'
               END IF   #20150706 add lujh
               LET g_qryparam.reqry = FALSE
               CASE tm.fix_type
                  WHEN '1' #營運據點
                     IF tm.option = '1' THEN    #20150706 add lujh
                        LET g_qryparam.where = " ooef201 = 'Y' "   #161021-00037#2 add
                        CALL q_ooef001()     
                     #20150706--add--end--lujh
                     ELSE
                        LET g_ooed001 = '8'
                        LET g_qryparam.arg1 = '8'
                        LET g_qryparam.arg2 = g_today
                        CALL q_ooed005_1()
                     END IF
                     #20150706--add--end--lujh
                  WHEN '2' #部門
                     IF tm.option = '1' THEN    #20150706 add lujh
                        LET g_qryparam.where = "ooegstus='Y'"
                        CALL q_ooeg001_4()
                     #20150706--add--end--lujh
                     ELSE
                        LET g_ooed001 = '1'
                        LET g_qryparam.arg1 = '1'
                        LET g_qryparam.arg2 = g_today
                        CALL q_ooed005_1()
                     END IF
                     #20150706--add--end--lujh
                  WHEN '3' #利潤/成本中心
                     IF tm.option = '1' THEN    #20150706 add lujh
                        LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
                        CALL q_ooeg001_4() 
                     #20150706--add--end--lujh
                     ELSE
                        LET g_ooed001 = '1'
                        LET g_qryparam.arg1 = '1'
                        LET g_qryparam.arg2 = g_today
                        CALL q_ooed005_1()
                     END IF
                     #20150706--add--end--lujh
                  WHEN '4' #區域
                     LET g_qryparam.arg1 = '287'
                     CALL q_oocq002_287()  
                  WHEN '5' #交易客商
                      CALL q_pmaa001_25()      #160913-00017#3  add
                      #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
                  WHEN '6' #帳款客戶
                     CALL q_pmaa001_25()      #160913-00017#3  add
                      #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
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
               
               #20150706--add--str--lujh
               IF tm.fix_type MATCHES '[123]' THEN 
                  LET g_ooed005 = tm.fix_acc
                  LET g_ooed002 = g_qryparam.return2
                  LET g_ooed003 = g_qryparam.return3
                  LET tm.ooed006 = g_qryparam.return4
                  LET tm.ooed007 = g_qryparam.return5
                  LET tm.ver = g_ooed003
                  DISPLAY tm.ver,tm.ooed006,tm.ooed007 TO ver,ooed006,ooed007
               END IF
               #20150706--add--end--lujh
               
               NEXT FIELD fix_acc
           
         #150827-00036#1--add--str--
         ON ACTION controlp INFIELD curr
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = tm.curr  
            CALL q_ooai001()                          #呼叫開窗
            LET tm.curr = g_qryparam.return1
            DISPLAY tm.curr TO curr  #顯示到畫面上
            NEXT FIELD curr 
         #150827-00036#1--add--end
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
   CALL aglq840_b_fill()
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
 
{<section id="aglq840.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq840_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_flag          LIKE type_t.num5
   LET l_flag=TRUE
   IF l_flag=TRUE THEN
      LET g_field=''
      LET g_field_1=" ''"
      #設置核算項查詢條件
      #帳套+核算項
      IF NOT cl_null(tm.fix_type) THEN
         CASE tm.fix_type
            WHEN '1' #營運據點
               LET g_field="glar012"
            WHEN '2' #部門
               LET g_field="glar013"
            WHEN '3' #利潤/成本中心
               LET g_field="glar014"
            WHEN '4' #區域
               LET g_field="glar015"
            WHEN '5' #交易客商
               LET g_field="glar016"
            WHEN '6' #帳款客戶
               LET g_field="glar017"
            WHEN '7' #客群
               LET g_field="glar018"
            WHEN '8' #產品類別
               LET g_field="glar019"
            WHEN '9' #經營方式
               LET g_field="glar051"
            WHEN '10' #渠道
               LET g_field="glar052"
            WHEN '11' #品牌
               LET g_field="glar053" 
            WHEN '12' #人員
               LET g_field="glar020"
            WHEN '13' #專案
               LET g_field="glar022"
            WHEN '14' #WBS
               LET g_field="glar023"
            WHEN '15' #自由核算項一
               LET g_field="glar024"
               LET g_field_1="glad0171"
            WHEN '16' #自由核算項二
               LET g_field="glar025"
               LET g_field_1="glad0181"
            WHEN '17' #自由核算項三
               LET g_field="glar026"
               LET g_field_1="glad0191"
            WHEN '18' #自由核算項四
               LET g_field="glar027"
               LET g_field_1="glad0201"
            WHEN '19' #自由核算項五
               LET g_field="glar028"
               LET g_field_1="glad0211"
            WHEN '20' #自由核算項六
               LET g_field="glar029"
               LET g_field_1="glad0221"
            WHEN '21' #自由核算項七
               LET g_field="glar030"
               LET g_field_1="glad0231"
            WHEN '22' #自由核算項八
               LET g_field="glar031"
               LET g_field_1="glad0241"
            WHEN '23' #自由核算項九
               LET g_field="glar032"
               LET g_field_1="glad0251"
            WHEN '24' #自由核算項十
               LET g_field="glar033"
               LET g_field_1="glad0261"
         END CASE
      END IF
      CALL aglq840_settext(tm.glfa001) 
      CALL aglq840_fill_amt()
      RETURN
   END IF   
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',glfbseq,glfbseq1,glfb002,'',glfb003,'','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       glfb008  ,DENSE_RANK() OVER( ORDER BY glfb_t.glfbseq,glfb_t.glfbseq1) AS RANK FROM glfb_t",
 
 
                     "",
                     " WHERE glfbent=? AND glfb001=? AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glfb_t"),
                     " ORDER BY glfb_t.glfbseq,glfb_t.glfbseq1"
 
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
 
   LET g_sql = "SELECT '',glfbseq,glfbseq1,glfb002,'',glfb003,'','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','',glfb008",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq840_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq840_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glfb_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glfb_d[l_ac].sel,g_glfb_d[l_ac].glfbseq,g_glfb_d[l_ac].glfbseq1,g_glfb_d[l_ac].glfb002, 
       g_glfb_d[l_ac].glfbl004,g_glfb_d[l_ac].glfb003,g_glfb_d[l_ac].amt1,g_glfb_d[l_ac].amt2,g_glfb_d[l_ac].amt3, 
       g_glfb_d[l_ac].amt4,g_glfb_d[l_ac].amt5,g_glfb_d[l_ac].amt6,g_glfb_d[l_ac].amt7,g_glfb_d[l_ac].amt8, 
       g_glfb_d[l_ac].amt9,g_glfb_d[l_ac].amt10,g_glfb_d[l_ac].amt11,g_glfb_d[l_ac].amt12,g_glfb_d[l_ac].amt13, 
       g_glfb_d[l_ac].amt14,g_glfb_d[l_ac].amt15,g_glfb_d[l_ac].amt16,g_glfb_d[l_ac].amt17,g_glfb_d[l_ac].amt18, 
       g_glfb_d[l_ac].amt19,g_glfb_d[l_ac].amt20,g_glfb_d[l_ac].amt21,g_glfb_d[l_ac].amt22,g_glfb_d[l_ac].amt23, 
       g_glfb_d[l_ac].amt24,g_glfb_d[l_ac].amt25,g_glfb_d[l_ac].amt26,g_glfb_d[l_ac].amt27,g_glfb_d[l_ac].amt28, 
       g_glfb_d[l_ac].amt29,g_glfb_d[l_ac].amt30,g_glfb_d[l_ac].amt31,g_glfb_d[l_ac].amt32,g_glfb_d[l_ac].amt33, 
       g_glfb_d[l_ac].amt34,g_glfb_d[l_ac].amt35,g_glfb_d[l_ac].amt36,g_glfb_d[l_ac].amt37,g_glfb_d[l_ac].amt38, 
       g_glfb_d[l_ac].amt39,g_glfb_d[l_ac].amt40,g_glfb_d[l_ac].amt41,g_glfb_d[l_ac].amt42,g_glfb_d[l_ac].amt43, 
       g_glfb_d[l_ac].amt44,g_glfb_d[l_ac].amt45,g_glfb_d[l_ac].amt46,g_glfb_d[l_ac].amt47,g_glfb_d[l_ac].amt48, 
       g_glfb_d[l_ac].amt49,g_glfb_d[l_ac].amt50,g_glfb_d[l_ac].amt51,g_glfb_d[l_ac].amt52,g_glfb_d[l_ac].amt53, 
       g_glfb_d[l_ac].amt54,g_glfb_d[l_ac].amt55,g_glfb_d[l_ac].amt56,g_glfb_d[l_ac].amt57,g_glfb_d[l_ac].amt58, 
       g_glfb_d[l_ac].amt59,g_glfb_d[l_ac].amt60,g_glfb_d[l_ac].amt61,g_glfb_d[l_ac].amt62,g_glfb_d[l_ac].amt63, 
       g_glfb_d[l_ac].amt64,g_glfb_d[l_ac].amt65,g_glfb_d[l_ac].amt66,g_glfb_d[l_ac].amt67,g_glfb_d[l_ac].amt68, 
       g_glfb_d[l_ac].amt69,g_glfb_d[l_ac].amt70,g_glfb_d[l_ac].amt71,g_glfb_d[l_ac].amt72,g_glfb_d[l_ac].amt73, 
       g_glfb_d[l_ac].amt74,g_glfb_d[l_ac].amt75,g_glfb_d[l_ac].amt76,g_glfb_d[l_ac].amt77,g_glfb_d[l_ac].amt78, 
       g_glfb_d[l_ac].amt79,g_glfb_d[l_ac].amt80,g_glfb_d[l_ac].amt81,g_glfb_d[l_ac].amt82,g_glfb_d[l_ac].amt83, 
       g_glfb_d[l_ac].amt84,g_glfb_d[l_ac].amt85,g_glfb_d[l_ac].amt86,g_glfb_d[l_ac].amt87,g_glfb_d[l_ac].amt88, 
       g_glfb_d[l_ac].amt89,g_glfb_d[l_ac].amt90,g_glfb_d[l_ac].amt91,g_glfb_d[l_ac].amt92,g_glfb_d[l_ac].amt93, 
       g_glfb_d[l_ac].amt94,g_glfb_d[l_ac].amt95,g_glfb_d[l_ac].amt96,g_glfb_d[l_ac].amt97,g_glfb_d[l_ac].amt98, 
       g_glfb_d[l_ac].amt99,g_glfb_d[l_ac].amt100,g_glfb_d[l_ac].per,g_glfb_d[l_ac].glfb008
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_glfb_d[l_ac].statepic = cl_get_actipic(g_glfb_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aglq840_detail_show("'1'")      
 
      CALL aglq840_glfb_t_mask()
 
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
   
 
   
   CALL g_glfb_d.deleteElement(g_glfb_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_glfb_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq840_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq840_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq840_detail_action_trans()
 
   IF g_glfb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq840_fetch()
   END IF
   
      CALL aglq840_filter_show('glfbseq','b_glfbseq')
   CALL aglq840_filter_show('glfbseq1','b_glfbseq1')
   CALL aglq840_filter_show('glfb002','b_glfb002')
   CALL aglq840_filter_show('glfbl004','b_glfbl004')
   CALL aglq840_filter_show('glfb003','b_glfb003')
   CALL aglq840_filter_show('glfb008','b_glfb008')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq840.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq840_fetch()
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
 
{<section id="aglq840.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq840_detail_show(ps_page)
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
 
{<section id="aglq840.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq840_filter()
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
      CONSTRUCT g_wc_filter ON glfbseq,glfbseq1,glfb002,glfbl004,glfb003,glfb008
                          FROM s_detail1[1].b_glfbseq,s_detail1[1].b_glfbseq1,s_detail1[1].b_glfb002, 
                              s_detail1[1].b_glfbl004,s_detail1[1].b_glfb003,s_detail1[1].b_glfb008
 
         BEFORE CONSTRUCT
                     DISPLAY aglq840_filter_parser('glfbseq') TO s_detail1[1].b_glfbseq
            DISPLAY aglq840_filter_parser('glfbseq1') TO s_detail1[1].b_glfbseq1
            DISPLAY aglq840_filter_parser('glfb002') TO s_detail1[1].b_glfb002
            DISPLAY aglq840_filter_parser('glfbl004') TO s_detail1[1].b_glfbl004
            DISPLAY aglq840_filter_parser('glfb003') TO s_detail1[1].b_glfb003
            DISPLAY aglq840_filter_parser('glfb008') TO s_detail1[1].b_glfb008
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_glfbseq>>----
         #Ctrlp:construct.c.filter.page1.b_glfbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbseq
            #add-point:ON ACTION controlp INFIELD b_glfbseq name="construct.c.filter.page1.b_glfbseq"
            
            #END add-point
 
 
         #----<<b_glfbseq1>>----
         #Ctrlp:construct.c.filter.page1.b_glfbseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbseq1
            #add-point:ON ACTION controlp INFIELD b_glfbseq1 name="construct.c.filter.page1.b_glfbseq1"
            
            #END add-point
 
 
         #----<<b_glfb002>>----
         #Ctrlp:construct.c.page1.b_glfb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb002
            #add-point:ON ACTION controlp INFIELD b_glfb002 name="construct.c.filter.page1.b_glfb002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glfc001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glfb002  #顯示到畫面上
            NEXT FIELD b_glfb002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glfbl004>>----
         #Ctrlp:construct.c.filter.page1.b_glfbl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbl004
            #add-point:ON ACTION controlp INFIELD b_glfbl004 name="construct.c.filter.page1.b_glfbl004"
            
            #END add-point
 
 
         #----<<b_glfb003>>----
         #Ctrlp:construct.c.filter.page1.b_glfb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb003
            #add-point:ON ACTION controlp INFIELD b_glfb003 name="construct.c.filter.page1.b_glfb003"
            
            #END add-point
 
 
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
         #----<<per>>----
         #----<<b_glfb008>>----
         #Ctrlp:construct.c.filter.page1.b_glfb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb008
            #add-point:ON ACTION controlp INFIELD b_glfb008 name="construct.c.filter.page1.b_glfb008"
            
            #END add-point
 
 
   
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
 
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
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
   
      CALL aglq840_filter_show('glfbseq','b_glfbseq')
   CALL aglq840_filter_show('glfbseq1','b_glfbseq1')
   CALL aglq840_filter_show('glfb002','b_glfb002')
   CALL aglq840_filter_show('glfbl004','b_glfbl004')
   CALL aglq840_filter_show('glfb003','b_glfb003')
   CALL aglq840_filter_show('glfb008','b_glfb008')
 
    
   CALL aglq840_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq840.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq840_filter_parser(ps_field)
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
 
{<section id="aglq840.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq840_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq840_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq840.insert" >}
#+ insert
PRIVATE FUNCTION aglq840_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq840.modify" >}
#+ modify
PRIVATE FUNCTION aglq840_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq840.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq840_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq840.delete" >}
#+ delete
PRIVATE FUNCTION aglq840_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq840.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq840_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   #151009-00005  by taozf add-str 
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1  
   DISPLAY g_current_row_tot TO FORMONLY.idx  
   LET g_pagestart = 1
   LET g_detail_idx = 1
 
   #151009-00005 by taozf add-end 
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
 
{<section id="aglq840.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq840_detail_index_setting()
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
            IF g_glfb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_glfb_d.getLength() AND g_glfb_d.getLength() > 0
            LET g_detail_idx = g_glfb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_glfb_d.getLength() THEN
               LET g_detail_idx = g_glfb_d.getLength()
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
 
{<section id="aglq840.mask_functions" >}
 &include "erp/agl/aglq840_mask.4gl"
 
{</section>}
 
{<section id="aglq840.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 為XG報表建立臨時表
# Memo...........:
# Usage..........: CALL aglq840_create_for_xg()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By 01727
# Modify.........: 150316-00010#17 Add
################################################################################
PRIVATE FUNCTION aglq840_create_for_xg()
      DROP TABLE aglq840_tmp01;            #160727-00019#3  Mod  aglq840_print_tmp -->aglq840_tmp01
      CREATE TEMP TABLE aglq840_tmp01(     #160727-00019#3  Mod  aglq840_print_tmp -->aglq840_tmp01
            glfbseq        INTEGER, 
            glfbseq1       VARCHAR(1), 
            glfb002        VARCHAR(10), 
            glfbl004       VARCHAR(500), 
            glfb003        SMALLINT,
            amt1           DECIMAL(20,6), 
            amt2           DECIMAL(20,6), 
            amt3           DECIMAL(20,6), 
            amt4           DECIMAL(20,6), 
            amt5           DECIMAL(20,6), 
            amt6           DECIMAL(20,6), 
            amt7           DECIMAL(20,6), 
            amt8           DECIMAL(20,6), 
            amt9           DECIMAL(20,6), 
            amt10          DECIMAL(20,6), 
            amt11          DECIMAL(20,6), 
            amt12          DECIMAL(20,6), 
            amt13          DECIMAL(20,6), 
            amt14          DECIMAL(20,6), 
            amt15          DECIMAL(20,6), 
            amt16          DECIMAL(20,6), 
            amt17          DECIMAL(20,6), 
            amt18          DECIMAL(20,6), 
            amt19          DECIMAL(20,6), 
            amt20          DECIMAL(20,6), 
            amt21          DECIMAL(20,6), 
            amt22          DECIMAL(20,6), 
            amt23          DECIMAL(20,6), 
            amt24          DECIMAL(20,6), 
            amt25          DECIMAL(20,6), 
            amt26          DECIMAL(20,6), 
            amt27          DECIMAL(20,6), 
            amt28          DECIMAL(20,6), 
            amt29          DECIMAL(20,6), 
            amt30          DECIMAL(20,6), 
            amt31          DECIMAL(20,6), 
            amt32          DECIMAL(20,6), 
            amt33          DECIMAL(20,6), 
            amt34          DECIMAL(20,6), 
            amt35          DECIMAL(20,6), 
            amt36          DECIMAL(20,6), 
            amt37          DECIMAL(20,6), 
            amt38          DECIMAL(20,6), 
            amt39          DECIMAL(20,6), 
            amt40          DECIMAL(20,6), 
            amt41          DECIMAL(20,6), 
            amt42          DECIMAL(20,6), 
            amt43          DECIMAL(20,6), 
            amt44          DECIMAL(20,6), 
            amt45          DECIMAL(20,6), 
            amt46          DECIMAL(20,6), 
            amt47          DECIMAL(20,6), 
            amt48          DECIMAL(20,6), 
            amt49          DECIMAL(20,6), 
            amt50          DECIMAL(20,6),
            amt51          DECIMAL(20,6), 
            amt52          DECIMAL(20,6), 
            amt53          DECIMAL(20,6), 
            amt54          DECIMAL(20,6), 
            amt55          DECIMAL(20,6), 
            amt56          DECIMAL(20,6), 
            amt57          DECIMAL(20,6), 
            amt58          DECIMAL(20,6), 
            amt59          DECIMAL(20,6),
            amt60          DECIMAL(20,6),
            amt61          DECIMAL(20,6), 
            amt62          DECIMAL(20,6), 
            amt63          DECIMAL(20,6), 
            amt64          DECIMAL(20,6), 
            amt65          DECIMAL(20,6), 
            amt66          DECIMAL(20,6), 
            amt67          DECIMAL(20,6), 
            amt68          DECIMAL(20,6), 
            amt69          DECIMAL(20,6),
            amt70          DECIMAL(20,6),
            amt71          DECIMAL(20,6), 
            amt72          DECIMAL(20,6), 
            amt73          DECIMAL(20,6), 
            amt74          DECIMAL(20,6), 
            amt75          DECIMAL(20,6), 
            amt76          DECIMAL(20,6), 
            amt77          DECIMAL(20,6), 
            amt78          DECIMAL(20,6), 
            amt79          DECIMAL(20,6),
            amt80          DECIMAL(20,6),
            amt81          DECIMAL(20,6), 
            amt82          DECIMAL(20,6), 
            amt83          DECIMAL(20,6), 
            amt84          DECIMAL(20,6), 
            amt85          DECIMAL(20,6), 
            amt86          DECIMAL(20,6), 
            amt87          DECIMAL(20,6), 
            amt88          DECIMAL(20,6), 
            amt89          DECIMAL(20,6),
            amt90          DECIMAL(20,6),
            amt91          DECIMAL(20,6), 
            amt92          DECIMAL(20,6), 
            amt93          DECIMAL(20,6), 
            amt94          DECIMAL(20,6), 
            amt95          DECIMAL(20,6), 
            amt96          DECIMAL(20,6), 
            amt97          DECIMAL(20,6), 
            amt98          DECIMAL(20,6), 
            amt99          DECIMAL(20,6),
            amt100         DECIMAL(20,6),
            per            DECIMAL(20,6),
            glfb008        VARCHAR(24)
          )
END FUNCTION

################################################################################
# Descriptions...: 內容動態加載
# Memo...........:
# Usage..........: CALL aglq840_settext(p_glfa001)
#                  
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq840_settext(p_glfa001)
   DEFINE p_glfa001 LIKE glfa_t.glfa001
   DEFINE l_tok  base.stringTokenizer
   DEFINE l_glfa005 LIKE glfa_t.glfa005
   DEFINE l_glfbarray  DYNAMIC ARRAY OF RECORD
             sel           LIKE type_t.chr1, 
             glfbseq       LIKE glfb_t.glfbseq, 
             glfbseq1      LIKE glfb_t.glfbseq1, 
             glfb002       LIKE glfb_t.glfb002,
             glfbl004      LIKE glfbl_t.glfbl004,
             glfb003       LIKE glfb_t.glfb003,
             glfb008       LIKE glfb_t.glfb008             
                         END RECORD
   DEFINE l_glfbseq       LIKE glfb_t.glfbseq 
   DEFINE l_glfbseq1      LIKE glfb_t.glfbseq1                       
   DEFINE l_glfb002       LIKE glfb_t.glfb002
   DEFINE l_glfbl004      LIKE glfbl_t.glfbl004
   DEFINE l_glfb003       LIKE glfb_t.glfb003   
   DEFINE l_i             LIKE type_t.num5
   DEFINE lc_ld           LIKE type_t.chr50
   DEFINE lc_ld_desc      STRING
   DEFINE lc_fix_desc     STRING
   DEFINE l_index         LIKE type_t.num5
   DEFINE l_str           STRING
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_n,l_num       LIKE type_t.num5
   DEFINE l_glaacomp      LIKE glaa_t.glaacomp
   DEFINE l_sql STRING
   DEFINE l_ooef001       LIKE ooef_t.ooef001
   DEFINE l_format        STRING
   DEFINE l_str2          STRING
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_glarld_str    STRING  #单头录入的帳套查询条件
   DEFINE l_fix_acc       STRING  #单头录入的核算项查询条件
   DEFINE l_fix           LIKE type_t.chr80 #核算项编号
   DEFINE l_glfa011       LIKE glfa_t.glfa011
   DEFINE l_glad0171      LIKE type_t.chr100
   DEFINE l_flag          LIKE type_t.chr1   #20150706 add lujh
   
   CALL aglq840_cre_tmp()        #20150706 add lujh
   
   CALL g_glfbtext.clear()
   CALL g_glfb_d.clear()  
   LET l_ooef001 = ''
   LET l_n = 0
   LET l_flag = 'N'     #20150706 add lujh
#   IF tm.showstyle = '1'  THEN #多帳套加載 
#      LET l_tok = base.StringTokenizer.createExt(g_str,'|','',TRUE)
#      IF l_tok.countTokens() > 0 THEN
#         WHILE l_tok.hasMoreTokens()
#            LET l_glfa005= l_tok.nextToken()
#            LET g_glfbtext[1].detail[g_glfbtext[1].detail.getLength()+1].amt=l_glfa005 CLIPPED
#            LET l_n = l_n +1
#         END WHILE
#      END IF 
#   END IF
#
#   #當呈現方式單帳套+多據點
#   IF tm.showstyle = '2' THEN
#     LET l_glfa005 = g_str 
#     SELECT DISTINCT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaald = l_glfa005 AND glaaent = g_enterprise
#     LET l_sql = "SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef017 = '",l_glaacomp,"' "
#     IF g_glfa002 = '1' THEN  #資產負債類
#        LET g_sql=l_sql," AND ooef204 ='Y' ORDER BY ooef017 "  
#     END IF  
#     IF g_glfa002 = '2' THEN  #損益類
#        LET g_sql=l_sql, " ORDER BY ooef017"
#     END IF
#     PREPARE aglq840_ooef FROM g_sql
#     DECLARE aglq840_ooef001 CURSOR FOR aglq840_ooef 
#     FOREACH aglq840_ooef001 INTO l_ooef001
#       LET g_glfbtext[1].detail[g_glfbtext[1].detail.getLength()+1].amt=l_ooef001 CLIPPED
#       LET l_n = l_n +1 
#     END FOREACH 
#   END IF 
#
#
#
#   #當呈現方式多帳套+多據點
#   IF tm.showstyle = '3' THEN
#      LET l_tok = base.StringTokenizer.createExt(g_str,'|','',TRUE)
#      IF l_tok.countTokens() > 0 THEN
#         WHILE l_tok.hasMoreTokens()
#            LET l_glfa005= l_tok.nextToken()
#            SELECT DISTINCT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaald = l_glfa005 AND glaaent = g_enterprise
#            LET l_sql = "SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef017 = '",l_glaacomp,"' "
#            IF g_glfa002 = '1' THEN  #資產負債類
#               LET g_sql=l_sql," AND ooef204 ='Y' ORDER BY ooef017 "  
#            END IF  
#            IF g_glfa002 = '2' THEN  #損益類
#               LET g_sql=l_sql, " ORDER BY ooef017"
#            END IF
#            PREPARE aglq840_ooef1 FROM g_sql
#            DECLARE aglq840_ooef001_1 CURSOR FOR aglq840_ooef1 
#            FOREACH aglq840_ooef001_1 INTO l_ooef001
#               LET g_glfbtext[1].detail[g_glfbtext[1].detail.getLength()+1].amt=l_ooef001 CLIPPED
#               LET l_n = l_n +1 
#            END FOREACH 
#         END WHILE
#      END IF 
#   END IF

   IF g_glfa002 = '1' THEN  #資產負債類
      #LET l_glfa011 = tm.glfa012 #161103-00040#1 mark
      LET l_glfa011 = 0           #161103-00040#1 add
   ELSE
      LET l_glfa011 = tm.glfa011
   END IF
   
   #20150706--add--str--lujh
   #按组织树单层展开
   IF tm.option = '2' THEN 
      CALL aglq840_get_next_ooed004(g_ooed001,g_ooed002,g_ooed003,g_ooed005) RETURNING tm.fix_acc,l_flag
      #除了最上层根节点,这边抓的少了自己本层,这边也要加上
      LET tm.fix_acc = "'",g_ooed005,"'",",",tm.fix_acc
   END IF
   
   #按组织树多层展开
   IF tm.option = '3' THEN 
      CALL aglq840_get_ooed004(g_ooed001,g_ooed002,g_ooed003,g_ooed005) RETURNING tm.fix_acc,l_flag
      #除了最上层根节点,这边抓的少了自己本层,这边也要加上
      LET tm.fix_acc = "'",g_ooed005,"'",",",tm.fix_acc
   END IF 
   #20150706--add--end--lujh
 
   #設置核算項查詢條件
   #帳套+核算項
   IF NOT cl_null(tm.fix_type) THEN
      LET g_sql="SELECT DISTINCT ",g_field,",",g_field_1,      #抓取核算項編號
                "  FROM glar_t"
      IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
         tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
         LET g_sql=g_sql,"  LEFT OUTER JOIN glad_t ON gladent=glarent AND gladld=glarld AND glad001=glar001"
      END IF
      LET g_sql=g_sql," WHERE glarent=",g_enterprise,
                      "   AND glar002=",tm.glfa010,
                      "   AND glar003 BETWEEN ",l_glfa011," AND ",tm.glfa012
      
      #核算項條件
      IF NOT cl_null(tm.fix_acc) THEN
         LET l_fix_acc=tm.fix_acc
         LET l_num =l_fix_acc.getIndexOf('*',1)
         IF l_num>0 THEN
            LET l_fix_acc=cl_replace_str(tm.fix_acc,"*","%")
            LET g_sql=g_sql," AND ",g_field," LIKE '",l_fix_acc,"' "
         ELSE
            LET l_fix_acc=cl_replace_str(tm.fix_acc,"|","','")
            IF l_flag = 'N' THEN    #20150706 add lujh
               LET l_fix_acc="'",l_fix_acc,"'"   
            END IF                  #20150706 add lujh
            LET g_sql=g_sql," AND ",g_field," IN (",l_fix_acc,")"
         END IF
      ELSE
         IF tm.fix_type='1' OR tm.fix_type='2' OR tm.fix_type='3' OR tm.fix_type='4' OR tm.fix_type='5' OR
            tm.fix_type='6' OR tm.fix_type='7' OR tm.fix_type='8' OR tm.fix_type='9' OR tm.fix_type='10' OR
            tm.fix_type='11' OR tm.fix_type='12' OR tm.fix_type='13' OR tm.fix_type='14'  THEN
            LET g_sql=g_sql," AND ",g_field," <> ' ' "
         END IF
      END IF
      #帳套條件
      LET l_glarld_str=cl_replace_str(g_str,"|","','")
      LET l_glarld_str="'",l_glarld_str,"'"
      LET g_sql=g_sql," AND glarld IN (",l_glarld_str,")",
                      " ORDER BY ",g_field,",",g_field_1
         
      #20150706--add--str--lujh     
      IF tm.option MATCHES '[23]' THEN 
         LET g_sql = "SELECT ooed004,'' FROM aglq840_tmp ORDER BY ooed004 "
      END IF
      #20150706--add--end--lujh   
         
      PREPARE aglq840_fix_pr FROM g_sql
      DECLARE aglq840_fix_cs CURSOR FOR aglq840_fix_pr 
      FOREACH aglq840_fix_cs INTO l_fix,l_glad0171
         LET l_i = g_glfbtext[1].detail.getLength()+1
         LET g_glfbtext[1].detail[l_i].fix=l_fix CLIPPED
         LET g_glfbtext[1].detail[l_i].glad0171=l_glad0171 CLIPPED
         LET l_n = l_n +1 
      END FOREACH 
   ELSE
      #未設置核算項查詢條件
      #帳套
      LET l_tok = base.StringTokenizer.createExt(g_str,'|','',TRUE)
      IF l_tok.countTokens() > 0 THEN
         WHILE l_tok.hasMoreTokens()
            LET l_glfa005= l_tok.nextToken()
               LET g_glfbtext[1].detail[g_glfbtext[1].detail.getLength()+1].ld=l_glfa005
               LET l_n = l_n +1
         END WHILE
      END IF
   END IF
   
   #是否有符合的帳套或營運據點
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00277'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN 
   END IF

   LET g_sql="SELECT DISTINCT 'N',glfbseq,glfbseq1,glfb002,glfbl004,glfb003,glfb008",
             "  FROM glfb_t ",
             "  LEFT JOIN glfbl_t ON glfbent = glfblent AND glfb001 = glfbl001 AND glfbseq = glfblseq AND glfb002 = glfbl002 AND glfbl003 = '",g_lang,"' ", 
             "  LEFT OUTER JOIN glfa_t ON glfbent = glfaent AND glfb001 = glfa001  ",
             " WHERE glfbent=",g_enterprise," AND glfb001 ='",tm.glfa001,"'"
             
   IF g_glfa002 = '2'  THEN   #損益類
     #LET g_sql=g_sql," AND glfbseq1 IN ('B')  AND ",g_wc_table,   #150916 mark
      LET g_sql=g_sql," AND glfbseq1 IN ('A')  AND ",g_wc_table,   #150916  
                     " AND ",g_wc_filter,      #160302-00006#1  2016/03/02 ADD By 07675 
                     #" ORDER BY glfbseq"   #150924 mark
                      " ORDER BY glfb003"   #150924
   END IF
   
   IF g_glfa002 = '1'  THEN   #資產負債
      LET g_sql=g_sql," AND glfbseq1 IN ('B','D')  AND ",g_wc_table,
                      " AND ",g_wc_filter,   #160302-00006#1  2016/03/02 ADD By 07675
                     #" ORDER BY glfbseq"   #150924 mark
                      " ORDER BY glfbseq1,glfb003"   #150924 #161021-00015#1 add glfbseq1
   END IF
      
   PREPARE aglq840_glfb_pre FROM g_sql

   
   DECLARE aglq840_glfb_cs CURSOR FOR aglq840_glfb_pre

   CALL l_glfbarray.clear()
   LET l_cnt = 1
   FOREACH aglq840_glfb_cs INTO l_glfbarray[l_cnt].*
      LET l_cnt = l_cnt +1 
   END FOREACH
   LET l_cnt = l_cnt - 1
   #151009-00005  by taozf add-str 
   LET g_detail_idx = l_cnt  
   LET g_tot_cnt = 1       
   DISPLAY g_detail_idx TO FORMONLY.cnt  
   #151009-00005 by taozf add-end 
   CALL l_glfbarray.deleteElement(l_glfbarray.getLength())
   FOR l_i = 1 TO l_glfbarray.getLength()
      LET g_glfbtext[l_i].* = g_glfbtext[1].*
      LET g_glfbtext[l_i].sel = 'N'
      LET g_glfbtext[l_i].glfbseq = l_glfbarray[l_i].glfbseq
      LET g_glfbtext[l_i].glfbseq1 = l_glfbarray[l_i].glfbseq1
      LET g_glfbtext[l_i].glfb002 = l_glfbarray[l_i].glfb002
      LET g_glfbtext[l_i].glfbl004 = l_glfbarray[l_i].glfbl004
      LET g_glfbtext[l_i].glfb003 = l_glfbarray[l_i].glfb003
      LET g_glfbtext[l_i].glfb008 = l_glfbarray[l_i].glfb008
   END FOR
   
   
   LET l_str = NULL
   FOR l_i = 1 TO g_glfbtext[1].detail.getLength()
      IF NOT cl_null(l_str) THEN LET l_str = l_str CLIPPED,"," END IF
      LET l_index = l_i USING '<<<<'
      LET lc_ld = g_glfbtext[1].detail[l_i].ld CLIPPED
      IF NOT cl_null(lc_ld) THEN
         #抓取帐套说明
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = lc_ld
         CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET lc_ld_desc = '', g_rtn_fields[1] , ''
      ELSE 
         LET lc_ld_desc = ''
      END IF

      IF NOT cl_null(tm.fix_type) THEN  #帳套+核算项
         CASE tm.fix_type
            WHEN '1' #營運據點
               CALL s_desc_get_department_desc(g_glfbtext[1].detail[l_i].fix) RETURNING lc_fix_desc
            WHEN '2' #部門
               CALL s_desc_get_department_desc(g_glfbtext[1].detail[l_i].fix) RETURNING lc_fix_desc
            WHEN '3' #利潤成本中心
               CALL s_desc_get_department_desc(g_glfbtext[1].detail[l_i].fix) RETURNING lc_fix_desc
            WHEN '4' #區域
               CALL s_desc_get_acc_desc('287',g_glfbtext[1].detail[l_i].fix) RETURNING lc_fix_desc 
            WHEN '5' #交易客商
               CALL s_desc_get_trading_partner_abbr_desc(g_glfbtext[1].detail[l_i].fix) RETURNING lc_fix_desc
            WHEN '6' #帳款客戶
               CALL s_desc_get_trading_partner_abbr_desc(g_glfbtext[1].detail[l_i].fix) RETURNING lc_fix_desc
            WHEN '7' #客群
               CALL s_desc_get_acc_desc('281',g_glfbtext[1].detail[l_i].fix) RETURNING lc_fix_desc
            WHEN '8' #產品分類
               CALL s_desc_get_rtaxl003_desc(g_glfbtext[1].detail[l_i].fix) RETURNING lc_fix_desc
            WHEN '9' #经营方式
               CALL s_desc_gzcbl004_desc('6013',g_glfbtext[1].detail[l_i].fix) RETURNING lc_fix_desc
            WHEN '10' #渠道
               CALL s_desc_get_oojdl003_desc(g_glfbtext[1].detail[l_i].fix) RETURNING lc_fix_desc
            WHEN '11' #品牌
               CALL s_desc_get_acc_desc('2002',g_glfbtext[1].detail[l_i].fix) RETURNING lc_fix_desc
            WHEN '12' #人員
               CALL s_desc_get_person_desc(g_glfbtext[1].detail[l_i].fix) RETURNING lc_fix_desc
            WHEN '13' #专案
               CALL s_desc_get_project_desc(g_glfbtext[1].detail[l_i].fix) RETURNING lc_fix_desc
            WHEN '14' #WBS
               #CALL s_desc_get_wbs_desc('',g_glfbtext[1].detail[l_i].fix) RETURNING lc_fix_desc
               LET lc_fix_desc = g_glfbtext[1].detail[l_i].fix
         END CASE
         IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
            tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
            CALL s_voucher_free_account_desc(g_glfbtext[1].detail[l_i].glad0171,g_glfbtext[1].detail[l_i].fix) 
            RETURNING lc_fix_desc
         END IF
         IF cl_null(lc_fix_desc) THEN
            LET lc_ld_desc=g_glfbtext[1].detail[l_i].fix,lc_fix_desc
         ELSE
            LET lc_ld_desc="(",g_glfbtext[1].detail[l_i].fix,")",lc_fix_desc
         END IF
      END IF       
      LET l_str = l_str,"amt" CLIPPED,l_index USING '<<<<'
      CALL cl_set_comp_att_text("amt" || l_index,lc_ld_desc)
      LET g_glfbtext[1].detail[l_i].lc_ld_desc=lc_ld_desc    #记录每一列说明 #2015/10/13
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

   LET l_str = NULL                   
   FOR l_i = g_glfbtext[1].detail.getLength()+1 TO 99     #20150706 change 100 to 99 lujh
      IF NOT cl_null(l_str) THEN LET l_str = l_str CLIPPED,"," END IF
      LET l_str = l_str,"amt" CLIPPED,l_i USING '<<<<' 
   END FOR
   CALL cl_set_comp_visible(l_str,FALSE)  
    
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aglq840_fill_amt()
#                  
# Date & Author..: 日期 By 作者 02481
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq840_fill_amt()
   DEFINE l_k               LIKE type_t.num5
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_j               LIKE type_t.num5
   DEFINE l_amt             LIKE type_t.num20_6
   DEFINE l_amt100          LIKE type_t.num20_6   #20150706 add lujh
   DEFINE l_glfbseq         LIKE glfb_t.glfbseq
   DEFINE l_amt_fm          LIKE type_t.num20_6
   DEFINE l_glfbseq1        LIKE glfb_t.glfbseq1
   DEFINE l_sql             STRING
   
   CALL g_glfb_d.clear()
   
   #150827-00036#12--add--str--
   #显示比率
   IF tm.show_per = 'Y' THEN
      LET l_glfbseq = ''
      LET l_sql = "SELECT glfbseq,glfbseq1 FROM glfb_t",
                  " WHERE glfbent=",g_enterprise," AND glfb001='",tm.glfa001,"' AND glfb009='Y'"
      #2015/10/08--by--02599--add--str--            
      IF g_glfa002 = '2'  THEN   #損益類
         LET l_sql=l_sql," AND glfbseq1 IN ('A') "
      END IF
   
      IF g_glfa002 = '1'  THEN   #資產負債
         LET l_sql=l_sql," AND glfbseq1 IN ('B','D') "
      END IF
      #2015/10/08--by--02599--add--end
      
      DECLARE aglq840_sel_pr CURSOR FROM l_sql
      OPEN aglq840_sel_pr
      FETCH aglq840_sel_pr INTO l_glfbseq,l_glfbseq1
      CLOSE aglq840_sel_pr
      IF cl_null(l_glfbseq) THEN 
         LET l_amt_fm = 0
      END IF
   END IF
   #150827-00036#12--add--end
   
   CALL cl_err_collect_init()
   FOR l_k = 1 TO g_glfbtext.getLength() #遍歷單身數據
      LET l_i=g_glfb_d.getLength()+1
      LET g_glfb_d[l_i].sel = 'N'
      LET g_glfb_d[l_i].glfbseq = g_glfbtext[l_k].glfbseq CLIPPED  #得到行号
      LET g_glfb_d[l_i].glfbseq1 = g_glfbtext[l_k].glfbseq1 CLIPPED  #得到列号
      LET g_glfb_d[l_i].glfb002 = g_glfbtext[l_k].glfb002 CLIPPED  #得到項目
      LET g_glfb_d[l_i].glfbl004 = g_glfbtext[l_k].glfbl004 CLIPPED  #得到項目說明
      LET g_glfb_d[l_i].glfb003 = g_glfbtext[l_k].glfb003 CLIPPED  #得到序號
      LET g_glfb_d[l_i].glfb008 = g_glfbtext[l_k].glfb008 CLIPPED  #得到序號
      LET l_amt100 = 0          #20150706 add lujh
      FOR l_j = 1 TO g_glfbtext[1].detail.getLength()
         CALL aglq840_get_amt(l_j,l_k) RETURNING l_amt
         #150827-00036#1--add--str--
         #是否進行幣別轉換
         IF tm.chg_curr='Y'  THEN
            LET l_amt = l_amt * tm.rate
         END IF
         #150827-00036#1--add--end
         CASE l_j
            WHEN 1   LET g_glfb_d[l_i].amt1 = l_amt
            WHEN 2   LET g_glfb_d[l_i].amt2 = l_amt
            WHEN 3   LET g_glfb_d[l_i].amt3 = l_amt
            WHEN 4   LET g_glfb_d[l_i].amt4 = l_amt  
            WHEN 5   LET g_glfb_d[l_i].amt5 = l_amt
            WHEN 6   LET g_glfb_d[l_i].amt6 = l_amt
            WHEN 7   LET g_glfb_d[l_i].amt7 = l_amt
            WHEN 8   LET g_glfb_d[l_i].amt8 = l_amt
            WHEN 9   LET g_glfb_d[l_i].amt9 = l_amt
            WHEN 10  LET g_glfb_d[l_i].amt10 = l_amt  
            WHEN 11  LET g_glfb_d[l_i].amt11 = l_amt
            WHEN 12  LET g_glfb_d[l_i].amt12 = l_amt
            WHEN 13  LET g_glfb_d[l_i].amt13 = l_amt
            WHEN 14  LET g_glfb_d[l_i].amt14 = l_amt
            WHEN 15  LET g_glfb_d[l_i].amt15 = l_amt
            WHEN 16  LET g_glfb_d[l_i].amt16 = l_amt 
            WHEN 17  LET g_glfb_d[l_i].amt17 = l_amt
            WHEN 18  LET g_glfb_d[l_i].amt18 = l_amt           
            WHEN 19  LET g_glfb_d[l_i].amt19 = l_amt
            WHEN 20  LET g_glfb_d[l_i].amt20 = l_amt
            WHEN 21  LET g_glfb_d[l_i].amt21 = l_amt
            WHEN 22  LET g_glfb_d[l_i].amt22 = l_amt 
            WHEN 23  LET g_glfb_d[l_i].amt23 = l_amt
            WHEN 24  LET g_glfb_d[l_i].amt24 = l_amt
            WHEN 25  LET g_glfb_d[l_i].amt25 = l_amt
            WHEN 26  LET g_glfb_d[l_i].amt26 = l_amt
            WHEN 27  LET g_glfb_d[l_i].amt27 = l_amt
            WHEN 28  LET g_glfb_d[l_i].amt28 = l_amt
            WHEN 29  LET g_glfb_d[l_i].amt29 = l_amt 
            WHEN 30  LET g_glfb_d[l_i].amt30 = l_amt
            WHEN 31  LET g_glfb_d[l_i].amt31 = l_amt           
            WHEN 32  LET g_glfb_d[l_i].amt32 = l_amt
            WHEN 33  LET g_glfb_d[l_i].amt33 = l_amt
            WHEN 34  LET g_glfb_d[l_i].amt34 = l_amt
            WHEN 35  LET g_glfb_d[l_i].amt35 = l_amt
            WHEN 36  LET g_glfb_d[l_i].amt36 = l_amt
            WHEN 37  LET g_glfb_d[l_i].amt37 = l_amt
            WHEN 38  LET g_glfb_d[l_i].amt38 = l_amt
            WHEN 39  LET g_glfb_d[l_i].amt39 = l_amt
            WHEN 40  LET g_glfb_d[l_i].amt40 = l_amt
            WHEN 41  LET g_glfb_d[l_i].amt41 = l_amt
            WHEN 42  LET g_glfb_d[l_i].amt42 = l_amt 
            WHEN 43  LET g_glfb_d[l_i].amt43 = l_amt
            WHEN 44  LET g_glfb_d[l_i].amt44 = l_amt           
            WHEN 45  LET g_glfb_d[l_i].amt45 = l_amt
            WHEN 46  LET g_glfb_d[l_i].amt46 = l_amt
            WHEN 47  LET g_glfb_d[l_i].amt47 = l_amt
            WHEN 48  LET g_glfb_d[l_i].amt48 = l_amt 
            WHEN 49  LET g_glfb_d[l_i].amt49 = l_amt
            WHEN 50  LET g_glfb_d[l_i].amt50 = l_amt
            WHEN 51  LET g_glfb_d[l_i].amt51 = l_amt
            WHEN 52  LET g_glfb_d[l_i].amt52 = l_amt 
            WHEN 53  LET g_glfb_d[l_i].amt53 = l_amt
            WHEN 54  LET g_glfb_d[l_i].amt54 = l_amt           
            WHEN 55  LET g_glfb_d[l_i].amt55 = l_amt
            WHEN 56  LET g_glfb_d[l_i].amt56 = l_amt
            WHEN 57  LET g_glfb_d[l_i].amt57 = l_amt
            WHEN 58  LET g_glfb_d[l_i].amt58 = l_amt 
            WHEN 59  LET g_glfb_d[l_i].amt59 = l_amt
            WHEN 60  LET g_glfb_d[l_i].amt60 = l_amt 
            WHEN 61  LET g_glfb_d[l_i].amt61 = l_amt
            WHEN 62  LET g_glfb_d[l_i].amt62 = l_amt 
            WHEN 63  LET g_glfb_d[l_i].amt63 = l_amt
            WHEN 64  LET g_glfb_d[l_i].amt64 = l_amt           
            WHEN 65  LET g_glfb_d[l_i].amt65 = l_amt
            WHEN 66  LET g_glfb_d[l_i].amt66 = l_amt
            WHEN 67  LET g_glfb_d[l_i].amt67 = l_amt
            WHEN 68  LET g_glfb_d[l_i].amt68 = l_amt 
            WHEN 69  LET g_glfb_d[l_i].amt69 = l_amt
            WHEN 70  LET g_glfb_d[l_i].amt70 = l_amt 
            WHEN 71  LET g_glfb_d[l_i].amt71 = l_amt
            WHEN 72  LET g_glfb_d[l_i].amt72 = l_amt 
            WHEN 73  LET g_glfb_d[l_i].amt73 = l_amt
            WHEN 74  LET g_glfb_d[l_i].amt74 = l_amt           
            WHEN 75  LET g_glfb_d[l_i].amt75 = l_amt
            WHEN 76  LET g_glfb_d[l_i].amt76 = l_amt
            WHEN 77  LET g_glfb_d[l_i].amt77 = l_amt
            WHEN 78  LET g_glfb_d[l_i].amt78 = l_amt 
            WHEN 79  LET g_glfb_d[l_i].amt79 = l_amt
            WHEN 80  LET g_glfb_d[l_i].amt80 = l_amt 
            WHEN 81  LET g_glfb_d[l_i].amt81 = l_amt
            WHEN 82  LET g_glfb_d[l_i].amt82 = l_amt 
            WHEN 83  LET g_glfb_d[l_i].amt83 = l_amt
            WHEN 84  LET g_glfb_d[l_i].amt84 = l_amt           
            WHEN 85  LET g_glfb_d[l_i].amt85 = l_amt
            WHEN 86  LET g_glfb_d[l_i].amt86 = l_amt
            WHEN 87  LET g_glfb_d[l_i].amt87 = l_amt
            WHEN 88  LET g_glfb_d[l_i].amt88 = l_amt 
            WHEN 89  LET g_glfb_d[l_i].amt89 = l_amt
            WHEN 90  LET g_glfb_d[l_i].amt90 = l_amt 
            WHEN 91  LET g_glfb_d[l_i].amt91 = l_amt
            WHEN 92  LET g_glfb_d[l_i].amt92 = l_amt 
            WHEN 93  LET g_glfb_d[l_i].amt93 = l_amt
            WHEN 94  LET g_glfb_d[l_i].amt94 = l_amt           
            WHEN 95  LET g_glfb_d[l_i].amt95 = l_amt
            WHEN 96  LET g_glfb_d[l_i].amt96 = l_amt
            WHEN 97  LET g_glfb_d[l_i].amt97 = l_amt
            WHEN 98  LET g_glfb_d[l_i].amt98 = l_amt 
            WHEN 99  LET g_glfb_d[l_i].amt99 = l_amt
            #WHEN 100 LET g_glfb_d[l_i].amt100= l_amt    #20150706 mark lujh
         END CASE   
         
         LET g_glfb_d[l_i].amt100 = l_amt100 + l_amt    #20150706 add lujh
         LET l_amt100 = g_glfb_d[l_i].amt100            #20150706 add lujh
      END FOR
      #150827-00036#12--add--str--
      #当勾选显示比率，获取分母
      IF tm.show_per = 'Y' THEN
         IF l_glfbseq = g_glfb_d[l_i].glfbseq AND l_glfbseq1 = g_glfb_d[l_i].glfbseq1 THEN
            LET l_amt_fm = g_glfb_d[l_i].amt100
         END IF
      END IF
      #150827-00036#12--add--end
   END FOR     
   LET g_detail_cnt = g_glfb_d.getLength() 
   CALL cl_err_collect_show()
   
   #150827-00036#12--add--str--
   #当勾选显示比率，计算百分比率
   IF tm.show_per = 'Y' THEN
      IF cl_null(l_amt_fm) THEN LET l_amt_fm=0 END IF
      #遍历单身资料，计算百分比率
      FOR l_i = 1 TO g_detail_cnt
         IF NOT cl_null(g_glfb_d[l_i].amt100) THEN
            IF l_amt_fm = 0 THEN
               LET g_glfb_d[l_i].per = 0
            ELSE
               LET g_glfb_d[l_i].per = g_glfb_d[l_i].amt100 / l_amt_fm * 100
            END IF
         END IF
      END FOR
   END IF
   #150827-00036#12--add--end
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aglq840_get_amt(p_j,p_k)
#                  
# Date & Author..: 日期 By 作者 02481
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq840_get_amt(p_j,p_k)
   DEFINE p_j               LIKE type_t.num5
   DEFINE p_k               LIKE type_t.num5
   DEFINE p_glfbseq         LIKE glfb_t.glfbseq   
   DEFINE p_glfbseq1        LIKE glfb_t.glfbseq1
   DEFINE r_amt             LIKE type_t.num20_6
   DEFINE l_glfb004         LIKE glfb_t.glfb004
   DEFINE l_glfb005         LIKE glfb_t.glfb005
   DEFINE l_glfa007         LIKE glfa_t.glfa007
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_str             STRING    #帐别字符
   DEFINE l_comp            LIKE ooef_t.ooef001  #營運據點
   DEFINE l_tok  base.stringTokenizer
   DEFINE l_glfa005 LIKE glfa_t.glfa005
   DEFINE l_sql             STRING
   DEFINE l_ooed004_str     STRING              #20150706 add lujh
   DEFINE l_flag            LIKE type_t.chr1    #20150706 add lujh
   
   LET l_str = ''
   LET l_comp = ''
   SELECT glfb004,glfb005 INTO l_glfb004,l_glfb005 
       FROM glfb_t
      WHERE glfbent=g_enterprise AND glfb001=tm.glfa001
        AND glfbseq = g_glfbtext[p_k].glfbseq AND glfbseq1=g_glfbtext[p_k].glfbseq1 
#   IF tm.showstyle = '1'  THEN #多帳套加載   
#      LET l_str= g_glfbtext[p_k].detail[p_j].amt  #帳套
#      LET l_comp = ''
#   END IF 
#
#IF tm.showstyle = '2' THEN   #單帳套+多據點
#   LET l_str = g_str  #單頭帳套
#   LET l_comp = g_glfbtext[p_k].detail[p_j].amt  #單身頭多據點
#END IF
#
#IF  tm.showstyle = '3' THEN #多帳套+多據點
#    LET l_tok = base.StringTokenizer.createExt(g_str,'|','',TRUE)
#    IF l_tok.countTokens() > 0 THEN
#       WHILE l_tok.hasMoreTokens()
#             LET l_glfa005= l_tok.nextToken()
#             IF cl_null(l_str) THEN
#               # LET l_str = "'",l_glfa005
#                 LET l_str = l_glfa005
#             ELSE
#                LET l_str = l_str,"','",l_glfa005
#             END IF
#       END WHILE
#       IF NOT cl_null(l_str) THEN
#      #    LET l_str = l_str,"'"
#           LET l_str = l_str
#       END IF  
#    END IF       
##   LET l_str = cl_str_replace(g_str,'|','''')    #單頭帳套
#   LET l_comp = g_glfbtext[p_k].detail[p_j].amt  #單身頭多據點
#END IF

   LET l_str= g_glfbtext[p_k].detail[p_j].ld  #帳套
   #帳套+核算項
   IF cl_null(l_str) THEN
      LET l_str=cl_replace_str(g_str,"|","','")
   END IF
   IF NOT cl_null(g_glfbtext[p_k].detail[p_j].fix) THEN
      #20150706--add--str--lujh
      IF tm.option = '2' THEN 
         CALL aglq840_get_ooed004(g_ooed001,g_ooed002,g_ooed003,g_glfbtext[p_k].detail[p_j].fix)
         RETURNING l_ooed004_str,l_flag
         
         IF NOT cl_null(l_ooed004_str) THEN 
            #除了最上层根节点,这边抓的少了自己本层,这边也要加上
            LET l_ooed004_str = "'",g_glfbtext[p_k].detail[p_j].fix,"'",",",l_ooed004_str
            LET l_sql = g_field,"  IN (",l_ooed004_str,")" 
         ELSE
            LET l_sql = g_field,"  = '",g_glfbtext[p_k].detail[p_j].fix,"'"
         END IF
      ELSE
      #20150706--add--end--lujh
         LET l_sql = g_field,"  = '",g_glfbtext[p_k].detail[p_j].fix,"'"
      END IF  #20150706 add lujh
      IF tm.fix_type='15' OR tm.fix_type='16' OR tm.fix_type='17' OR tm.fix_type='18' OR tm.fix_type='19' OR
         tm.fix_type='20' OR tm.fix_type='21' OR tm.fix_type='22' OR tm.fix_type='23' OR tm.fix_type='24' THEN
         LET l_sql=l_sql," AND glar001 IN (SELECT DISTINCT glad001 FROM glad_t ",
                         "                  WHERE gladent=glarent AND gladld=glarld ",
                         "                    AND ",g_field_1," = '",g_glfbtext[p_k].detail[p_j].glad0171,"')"
      END IF
   END IF
#損益類 
IF g_glfa002 = '2' THEN
   IF NOT cl_null(l_glfb005) THEN
                           #帳別 #年度       #起始期別   #截止期別  #小數位數   #單位      #報表模板編號       
         CALL s_analy_form(l_str,tm.glfa010,tm.glfa011,tm.glfa012,tm.glfa009,tm.glfa008,tm.glfa001,
                           #取數公式來源  #計算公式  #核算项条件 #含審計調整傳票否 #傳票狀態
                           l_glfb004,    l_glfb005,l_sql,     tm.show_ad,     tm.stus) #150827-00036#1 add ‘show_ad,stus’
         RETURNING l_success,r_amt
   ELSE
      LET r_amt=' '
   END IF 
   RETURN r_amt
END IF 

#資產負債類  
IF g_glfa002 = '1' THEN
   IF NOT cl_null(l_glfb005) THEN
      IF g_glfbtext[p_k].glfbseq1 ='A' OR g_glfbtext[p_k].glfbseq1 ='C' THEN
         LET l_glfa007=0
      ELSE
         LET l_glfa007=tm.glfa012
      END IF
                        #帳別 #年度       #起始期別  #截止期別 #小數位數   #單位      #報表模板編號       
      CALL s_analy_form(l_str,tm.glfa010,l_glfa007,l_glfa007,tm.glfa009,tm.glfa008,tm.glfa001,
                        #取數公式來源  #計算公式  #核算项条件 #含審計調整傳票否 #傳票狀態
                        l_glfb004,    l_glfb005,l_sql,     tm.show_ad,     tm.stus) #150827-00036#1 add ‘show_ad,stus’
      RETURNING l_success,r_amt
   ELSE
      LET r_amt=' '
   END IF 
   RETURN r_amt
END IF

END FUNCTION

################################################################################
# Descriptions...: 列印XG報表
# Memo...........:
# Usage..........: CALL aglq840_xg()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By 07727
# Modify.........: 150316-00010#17 Add
################################################################################
PRIVATE FUNCTION aglq840_xg()
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_title        LIKE type_t.chr200
   DEFINE l_per          LIKE type_t.num26_10   #albireo 151012 add  151001-00011#1


   DELETE FROM aglq840_tmp01         #160727-00019#3  Mod  aglq840_print_tmp -->aglq840_tmp01

   FOR l_i = 1 TO g_glfb_d.getLength()
      LET l_per = g_glfb_d[l_i].per / 100   #albireo 151012 add  151001-00011#1

      INSERT INTO aglq840_tmp01(glfbseq, glfbseq1,glfb002,           #160727-00019#3  Mod  aglq840_print_tmp -->aglq840_tmp01
                                    glfbl004,glfb003,glfb008,
                                    amt1, amt2, amt3, amt4, amt5,
                                    amt6, amt7, amt8, amt9, amt10,
                                    amt11,amt12,amt13,amt14,amt15,
                                    amt16,amt17,amt18,amt19,amt20,
                                    amt21,amt22,amt23,amt24,amt25,
                                    amt26,amt27,amt28,amt29,amt30,
                                    amt31,amt32,amt33,amt34,amt35,
                                    amt36,amt37,amt38,amt39,amt40,
                                    amt41,amt42,amt43,amt44,amt45,
                                    amt46,amt47,amt48,amt49,amt50,
                                    amt51,amt52,amt53,amt54,amt55,
                                    amt56,amt57,amt58,amt59,amt60,
                                    amt61,amt62,amt63,amt64,amt65,
                                    amt66,amt67,amt68,amt69,amt70,
                                    amt71,amt72,amt73,amt74,amt75,
                                    amt76,amt77,amt78,amt79,amt80,
                                    amt81,amt82,amt83,amt84,amt85,
                                    amt86,amt87,amt88,amt89,amt90,
                                    amt91,amt92,amt93,amt94,amt95,
                                    amt96,amt97,amt98,amt99,amt100,
                                    per)    #151012 albireo add  151001-00011#1
         VALUES(l_i, g_glfb_d[l_i].glfbseq1,g_glfb_d[l_i].glfb002,
                g_glfb_d[l_i].glfbl004,g_glfb_d[l_i].glfb003,g_glfb_d[l_i].glfb008,
                g_glfb_d[l_i].amt1, g_glfb_d[l_i].amt2, g_glfb_d[l_i].amt3, g_glfb_d[l_i].amt4, g_glfb_d[l_i].amt5,
                g_glfb_d[l_i].amt6, g_glfb_d[l_i].amt7, g_glfb_d[l_i].amt8, g_glfb_d[l_i].amt9, g_glfb_d[l_i].amt10,
                g_glfb_d[l_i].amt11,g_glfb_d[l_i].amt12,g_glfb_d[l_i].amt13,g_glfb_d[l_i].amt14,g_glfb_d[l_i].amt15,
                g_glfb_d[l_i].amt16,g_glfb_d[l_i].amt17,g_glfb_d[l_i].amt18,g_glfb_d[l_i].amt19,g_glfb_d[l_i].amt20,
                g_glfb_d[l_i].amt21,g_glfb_d[l_i].amt22,g_glfb_d[l_i].amt23,g_glfb_d[l_i].amt24,g_glfb_d[l_i].amt25,
                g_glfb_d[l_i].amt26,g_glfb_d[l_i].amt27,g_glfb_d[l_i].amt28,g_glfb_d[l_i].amt29,g_glfb_d[l_i].amt30,
                g_glfb_d[l_i].amt31,g_glfb_d[l_i].amt32,g_glfb_d[l_i].amt33,g_glfb_d[l_i].amt34,g_glfb_d[l_i].amt35,
                g_glfb_d[l_i].amt36,g_glfb_d[l_i].amt37,g_glfb_d[l_i].amt38,g_glfb_d[l_i].amt39,g_glfb_d[l_i].amt40,
                g_glfb_d[l_i].amt41,g_glfb_d[l_i].amt42,g_glfb_d[l_i].amt43,g_glfb_d[l_i].amt44,g_glfb_d[l_i].amt45,
                g_glfb_d[l_i].amt46,g_glfb_d[l_i].amt47,g_glfb_d[l_i].amt48,g_glfb_d[l_i].amt49,g_glfb_d[l_i].amt50,
                g_glfb_d[l_i].amt51,g_glfb_d[l_i].amt52,g_glfb_d[l_i].amt53,g_glfb_d[l_i].amt54,g_glfb_d[l_i].amt55,
                g_glfb_d[l_i].amt56,g_glfb_d[l_i].amt57,g_glfb_d[l_i].amt58,g_glfb_d[l_i].amt59,g_glfb_d[l_i].amt60,
                g_glfb_d[l_i].amt61,g_glfb_d[l_i].amt62,g_glfb_d[l_i].amt63,g_glfb_d[l_i].amt64,g_glfb_d[l_i].amt65,
                g_glfb_d[l_i].amt66,g_glfb_d[l_i].amt67,g_glfb_d[l_i].amt68,g_glfb_d[l_i].amt69,g_glfb_d[l_i].amt70,
                g_glfb_d[l_i].amt71,g_glfb_d[l_i].amt72,g_glfb_d[l_i].amt73,g_glfb_d[l_i].amt74,g_glfb_d[l_i].amt75,
                g_glfb_d[l_i].amt76,g_glfb_d[l_i].amt77,g_glfb_d[l_i].amt78,g_glfb_d[l_i].amt79,g_glfb_d[l_i].amt80,
                g_glfb_d[l_i].amt81,g_glfb_d[l_i].amt82,g_glfb_d[l_i].amt83,g_glfb_d[l_i].amt84,g_glfb_d[l_i].amt85,
                g_glfb_d[l_i].amt86,g_glfb_d[l_i].amt87,g_glfb_d[l_i].amt88,g_glfb_d[l_i].amt89,g_glfb_d[l_i].amt90,
                g_glfb_d[l_i].amt91,g_glfb_d[l_i].amt92,g_glfb_d[l_i].amt93,g_glfb_d[l_i].amt94,g_glfb_d[l_i].amt95,
                g_glfb_d[l_i].amt96,g_glfb_d[l_i].amt97,g_glfb_d[l_i].amt98,g_glfb_d[l_i].amt99,g_glfb_d[l_i].amt100,
                l_per)   #albireo 151012 add 151001-00011#1
   END FOR

   FOR l_i = 1 TO g_glfbtext[1].detail.getLength()
#2015/10/13--by--02599--mod--str--
#     CALL s_axrt300_xrca_ref('xrcald',g_glfbtext[1].detail[l_i].ld,'','') RETURNING l_success,l_title
#     LET g_xg_fieldname[5 + l_i] = l_title
     LET g_xg_fieldname[5 + l_i] = g_glfbtext[1].detail[l_i].lc_ld_desc
#2015/10/13--by--02599--mod--end
   END FOR

   CALL aglq840_x01('1=1','aglq840_tmp01',l_i,tm.show_xrbl)        #160727-00019#3  Mod  aglq840_print_tmp -->aglq840_tmp01

END FUNCTION
# 根据组织类型、最上层组织、版本，查询下层所有组织
PRIVATE FUNCTION aglq840_get_ooed004(p_ooed001,p_ooed002,p_ooed003,p_ooed005)
   DEFINE p_ooed001           LIKE ooed_t.ooed001
   DEFINE p_ooed002           LIKE ooed_t.ooed002
   DEFINE p_ooed003           LIKE ooed_t.ooed003
   DEFINE p_ooed005           LIKE ooed_t.ooed005
   DEFINE l_sql               STRING
   DEFINE l_ooed004           LIKE ooed_t.ooed004
   DEFINE l_ooed004_str       STRING 
   
   DELETE FROM aglq840_tmp;
   
   LET l_ooed004_str = ''
   LET l_sql = "SELECT DISTINCT ooed004 ",
               "  FROM ooed_t ",
               "WHERE ooed001 = '",p_ooed001,"' ",
               "  AND ooed002 = '",p_ooed002,"' ",
               "  AND ooed003 = '",p_ooed003,"' ",
               "  AND ooed004 <> ooed005 ",
               "START WITH ooed005 = '",p_ooed005,"' ",  
               "       AND ooed001 = '",p_ooed001,"' ",
               "       AND ooed002 = '",p_ooed002,"' ",
               "       AND ooed003 = '",p_ooed003,"' ",
               "  AND ooed004 <> ooed005 ",
               "CONNECT BY ooed005 = PRIOR ooed004 ",  
               "       AND ooed001 = '",p_ooed001,"' ",
               "       AND ooed002 = '",p_ooed002,"' ",
               "       AND ooed003 = '",p_ooed003,"' ", 
               "  AND ooed004 <> ooed005 ",
               "  ORDER BY ooed004 "
   PREPARE aglq840_ooed004_pre FROM l_sql
   DECLARE aglq840_ooed004_cs CURSOR FOR aglq840_ooed004_pre
   FOREACH aglq840_ooed004_cs INTO l_ooed004
      IF cl_null(l_ooed004_str) THEN 
         LET l_ooed004_str = "'",l_ooed004,"'"
      ELSE
         LET l_ooed004_str = l_ooed004_str,",","'",l_ooed004,"'"
      END IF
      
      INSERT INTO aglq840_tmp VALUES(l_ooed004)
   END FOREACH 
   
   RETURN l_ooed004_str,'Y'
END FUNCTION
# 抓取节点下一层节点
PRIVATE FUNCTION aglq840_get_next_ooed004(p_ooed001,p_ooed002,p_ooed003,p_ooed005)
   DEFINE p_ooed001           LIKE ooed_t.ooed001
   DEFINE p_ooed002           LIKE ooed_t.ooed002
   DEFINE p_ooed003           LIKE ooed_t.ooed003
   DEFINE p_ooed005           LIKE ooed_t.ooed005
   DEFINE l_sql               STRING
   DEFINE l_ooed004           LIKE ooed_t.ooed004
   DEFINE l_ooed004_str       STRING 
   
   DELETE FROM aglq840_tmp;
   
   LET l_ooed004_str = ''
   LET l_sql = "SELECT DISTINCT ooed004 ",
               "  FROM ooed_t ",
               "WHERE ooed001 = '",p_ooed001,"' ",
               "  AND ooed002 = '",p_ooed002,"' ",
               "  AND ooed003 = '",p_ooed003,"' ",
               "  AND ooed005 = '",p_ooed005,"' ",
               "  AND ooed004 <> ooed005 ",           #151106-00012#1  add lujh
               "  ORDER BY ooed004 "
   PREPARE aglq840_ooed004_pre1 FROM l_sql
   DECLARE aglq840_ooed004_cs1 CURSOR FOR aglq840_ooed004_pre1
   FOREACH aglq840_ooed004_cs1 INTO l_ooed004
      IF cl_null(l_ooed004_str) THEN 
         LET l_ooed004_str = "'",l_ooed004,"'"
      ELSE
         LET l_ooed004_str = l_ooed004_str,",","'",l_ooed004,"'"
      END IF
      
      INSERT INTO aglq840_tmp VALUES(l_ooed004)
   END FOREACH 
   
   RETURN l_ooed004_str,'Y'
END FUNCTION
# 创建临时表
PRIVATE FUNCTION aglq840_cre_tmp()
   DROP TABLE aglq840_tmp;
   CREATE TEMP TABLE aglq840_tmp(
   ooed004           VARCHAR(10)
   );
END FUNCTION

PRIVATE FUNCTION aglq840_glfa001_desc()
   #150916--s
   SELECT glfal003 INTO tm.glfa001_desc FROM glfal_t
    WHERE glfalent = g_enterprise AND glfal001 = tm.glfa001 AND glfal002 = g_dlang
   DISPLAY tm.glfa001_desc TO glfa001_desc
   #150916--e
END FUNCTION

 
{</section>}
 
