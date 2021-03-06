#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq920.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2014-09-13 11:27:33), PR版次:0004(2016-11-28 16:55:36)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000073
#+ Filename...: axrq920
#+ Description: 應收暫估月結查詢
#+ Creator....: 02599(2014-07-08 14:16:19)
#+ Modifier...: 02599 -SD/PR- 08729
 
{</section>}
 
{<section id="axrq920.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#52 2016/03/29 By 07959    將重複內容的錯誤訊息置換為公用錯誤訊息
#160731-00372#1  2016/08/16 By 07900    客户开窗不要开供应商
#160811-00009#2  2016/08/17 By 01531    账务中心/法人/账套权限控管
#161123-00048#5  2016/11/28 By 08729    開窗增加過濾據點 
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
PRIVATE TYPE type_g_xreb_d RECORD
       #statepic       LIKE type_t.chr1,
       
       xreb004 LIKE xreb_t.xreb004, 
   xreb005 LIKE xreb_t.xreb005, 
   xreb006 LIKE xreb_t.xreb006, 
   xreb007 LIKE xreb_t.xreb007, 
   xreb020 LIKE xreb_t.xreb020, 
   xreb022 LIKE xreb_t.xreb022, 
   xreb008 LIKE xreb_t.xreb008, 
   xreb100 LIKE xreb_t.xreb100, 
   xreb103 LIKE xreb_t.xreb103, 
   xreb113 LIKE xreb_t.xreb113, 
   xreb101 LIKE xreb_t.xreb101, 
   xreb114 LIKE xreb_t.xreb114 
       END RECORD
PRIVATE TYPE type_g_xreb3_d RECORD
       xreb004 LIKE xreb_t.xreb004, 
   xreb005 LIKE xreb_t.xreb005, 
   xreb006 LIKE xreb_t.xreb006, 
   xreb007 LIKE xreb_t.xreb007, 
   xreb020 LIKE xreb_t.xreb020, 
   xreb022 LIKE xreb_t.xreb022, 
   xreb008 LIKE xreb_t.xreb008, 
   xreb100 LIKE xreb_t.xreb100, 
   xreb123 LIKE xreb_t.xreb123, 
   xreb121 LIKE xreb_t.xreb121, 
   xreb124 LIKE xreb_t.xreb124, 
   xreb133 LIKE xreb_t.xreb133, 
   xreb131 LIKE xreb_t.xreb131, 
   xreb134 LIKE xreb_t.xreb134
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_xrec_d RECORD
       sel            LIKE type_t.chr1,
       xrec005 LIKE type_t.chr500, 
   xrec006 LIKE xrec_t.xrec006, 
   xrec006_desc LIKE type_t.chr500, 
   xrec011_1 LIKE xrec_t.xrec011, 
   xrec007 LIKE xrec_t.xrec007, 
   xrec009 LIKE xrec_t.xrec009, 
   xrec008 LIKE xrec_t.xrec008, 
   xrec010 LIKE xrec_t.xrec010, 
   xrec011 LIKE xrec_t.xrec011 
       END RECORD
DEFINE g_xrec_d          DYNAMIC ARRAY OF type_g_xrec_d

DEFINE tm                RECORD
   xreb001               LIKE xreb_t.xreb001,
   xreb002               LIKE xreb_t.xreb002,
   xrebld                LIKE xreb_t.xrebld,
   xrebld_desc           LIKE glaal_t.glaal002,
   xrebcomp              LIKE xreb_t.xrebcomp,
   xrebcomp_desc         LIKE ooefl_t.ooefl003,
   xref007               LIKE xref_t.xref007,
   xref008               LIKE xref_t.xref008
      END RECORD  
DEFINE g_xrec_p          DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
       xrec005           LIKE xrec_t.xrec005,
       xrec006           LIKE xrec_t.xrec006
      END RECORD 
DEFINE g_xrec005         LIKE xrec_t.xrec005
DEFINE g_xrec006         LIKE xrec_t.xrec006
DEFINE g_current_row   LIKE type_t.num5
DEFINE g_current_idx   LIKE type_t.num10     
DEFINE g_jump          LIKE type_t.num10        
DEFINE g_no_ask        LIKE type_t.num5  
DEFINE g_rec_b         LIKE type_t.num5
DEFINE g_sql_ctrl      STRING           #161123-00048#5-add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_xreb_d
DEFINE g_master_t                   type_g_xreb_d
DEFINE g_xreb_d          DYNAMIC ARRAY OF type_g_xreb_d
DEFINE g_xreb_d_t        type_g_xreb_d
DEFINE g_xreb3_d   DYNAMIC ARRAY OF type_g_xreb3_d
DEFINE g_xreb3_d_t type_g_xreb3_d
 
 
      
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
 
{<section id="axrq920.main" >}
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
   CALL cl_ap_init("axr","")
 
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
   DECLARE axrq920_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrq920_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq920_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrq920 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrq920_init()   
 
      #進入選單 Menu (="N")
      CALL axrq920_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrq920
      
   END IF 
   
   CLOSE axrq920_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrq920.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrq920_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_sql         STRING
   DEFINE l_str         STRING 
   DEFINE l_gzcb002     LIKE gzcb_t.gzcb002
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_set_comp_scc('xreb001','43')
#   CALL cl_set_combo_scc('xreb002','39')
   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8302' AND gzcb005 ='axrt320' "
   PREPARE axrq920_xrcb004_prep FROM l_sql
   DECLARE axrq920_xrcb004_curs CURSOR FOR axrq920_xrcb004_prep
   LET l_str = NULL
   LET l_gzcb002 = NULL
   FOREACH axrq920_xrcb004_curs INTO l_gzcb002
      IF cl_null(l_str) THEN 
         LET l_str = l_gzcb002 
         CONTINUE FOREACH 
      END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH
   CALL cl_set_combo_scc_part('b_xreb004','8302',l_str)
   CALL cl_set_combo_scc_part('xreb004_1','8302',l_str)
   #161123-00048#5-add(s)
   SELECT ooef017 INTO tm.xrebcomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',tm.xrebcomp) RETURNING g_sub_success,g_sql_ctrl
   #161123-00048#5-add(e)
   #end add-point
 
   CALL axrq920_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axrq920.default_search" >}
PRIVATE FUNCTION axrq920_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xrebld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xreb001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xreb002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xreb003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xreb005 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xreb006 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " xreb007 = '", g_argv[07], "' AND "
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
 
{<section id="axrq920.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axrq920_ui_dialog()
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
      CALL axrq920_b_fill()
   ELSE
      CALL axrq920_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xreb_d.clear()
         CALL g_xreb3_d.clear()
 
 
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
 
         CALL axrq920_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xreb_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrq920_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL axrq920_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               DISPLAY g_header_cnt TO FORMONLY.h_count
               DISPLAY g_current_idx TO FORMONLY.h_index
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_xreb_d.getLength() TO FORMONLY.cnt
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
         DISPLAY ARRAY g_xreb3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_xreb3_d.getLength() TO FORMONLY.h_count
               CALL axrq920_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body3.before_row"
               DISPLAY g_header_cnt TO FORMONLY.h_count
               DISPLAY g_current_idx TO FORMONLY.h_index
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_xreb3_d.getLength() TO FORMONLY.cnt
               #end add-point  
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
          DISPLAY ARRAY g_xrec_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               DISPLAY g_header_cnt TO FORMONLY.h_count
               DISPLAY g_current_idx TO FORMONLY.h_index
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_xrec_d.getLength() TO FORMONLY.cnt
               CALL axrq920_fetch()
               LET g_master_idx = l_ac
               
            
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail2", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axrq920_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            #上下筆按鈕顯示否設置
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
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            #end add-point
 
         
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
               CALL axrq920_query()
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
            CALL axrq920_filter()
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
            CALL axrq920_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xreb_d)
               LET g_export_id[1]   = "s_detail2"
               LET g_export_node[2] = base.typeInfo.create(g_xreb3_d)
               LET g_export_id[2]   = "s_detail3"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[3] = base.typeInfo.create(g_xrec_d)
               LET g_export_id[3]   = "s_detail1"
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
            CALL axrq920_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrq920_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrq920_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrq920_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION first
            LET g_action_choice="first"
            IF cl_auth_chk_act("first") THEN 
               CALL axrq920_fetch1('F')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               EXIT DIALOG
            END IF
         ON ACTION previous
            LET g_action_choice="previous"
            IF cl_auth_chk_act("previous") THEN 
               CALL axrq920_fetch1('P')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               EXIT DIALOG
            END IF
         ON ACTION jump
            LET g_action_choice="jump"
            IF cl_auth_chk_act("jump") THEN 
               CALL axrq920_fetch1('/')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               EXIT DIALOG
            END IF
         ON ACTION next
            LET g_action_choice="next"
            IF cl_auth_chk_act("next") THEN 
               CALL axrq920_fetch1('N')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               EXIT DIALOG
            END IF
         ON ACTION last
            LET g_action_choice="last"
            IF cl_auth_chk_act("last") THEN 
               CALL axrq920_fetch1('L')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               EXIT DIALOG
            END IF
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
 
{<section id="axrq920.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrq920_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   CALL axrq920_query1()
   RETURN
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xreb_d.clear()
   CALL g_xreb3_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON xreb004,xreb005,xreb006,xreb007,xreb020,xreb022,xreb008,xreb100,xreb103, 
          xreb113,xreb101,xreb114,xreb123,xreb121,xreb124,xreb133,xreb131,xreb134
           FROM s_detail2[1].b_xreb004,s_detail2[1].b_xreb005,s_detail2[1].b_xreb006,s_detail2[1].b_xreb007, 
               s_detail2[1].b_xreb020,s_detail2[1].b_xreb022,s_detail2[1].b_xreb008,s_detail2[1].b_xreb100, 
               s_detail2[1].b_xreb103,s_detail2[1].b_xreb113,s_detail2[1].b_xreb101,s_detail2[1].b_xreb114, 
               s_detail3[1].b_xreb123,s_detail3[1].b_xreb121,s_detail3[1].b_xreb124,s_detail3[1].b_xreb133, 
               s_detail3[1].b_xreb131,s_detail3[1].b_xreb134
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_xreb004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb004
            #add-point:BEFORE FIELD b_xreb004 name="construct.b.page2.b_xreb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb004
            
            #add-point:AFTER FIELD b_xreb004 name="construct.a.page2.b_xreb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_xreb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb004
            #add-point:ON ACTION controlp INFIELD b_xreb004 name="construct.c.page2.b_xreb004"
            
            #END add-point
 
 
         #----<<b_xreb005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb005
            #add-point:BEFORE FIELD b_xreb005 name="construct.b.page2.b_xreb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb005
            
            #add-point:AFTER FIELD b_xreb005 name="construct.a.page2.b_xreb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_xreb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb005
            #add-point:ON ACTION controlp INFIELD b_xreb005 name="construct.c.page2.b_xreb005"
            
            #END add-point
 
 
         #----<<b_xreb006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb006
            #add-point:BEFORE FIELD b_xreb006 name="construct.b.page2.b_xreb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb006
            
            #add-point:AFTER FIELD b_xreb006 name="construct.a.page2.b_xreb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_xreb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb006
            #add-point:ON ACTION controlp INFIELD b_xreb006 name="construct.c.page2.b_xreb006"
            
            #END add-point
 
 
         #----<<b_xreb007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb007
            #add-point:BEFORE FIELD b_xreb007 name="construct.b.page2.b_xreb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb007
            
            #add-point:AFTER FIELD b_xreb007 name="construct.a.page2.b_xreb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_xreb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb007
            #add-point:ON ACTION controlp INFIELD b_xreb007 name="construct.c.page2.b_xreb007"
            
            #END add-point
 
 
         #----<<b_xreb020>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb020
            #add-point:BEFORE FIELD b_xreb020 name="construct.b.page2.b_xreb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb020
            
            #add-point:AFTER FIELD b_xreb020 name="construct.a.page2.b_xreb020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_xreb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb020
            #add-point:ON ACTION controlp INFIELD b_xreb020 name="construct.c.page2.b_xreb020"
            
            #END add-point
 
 
         #----<<b_xreb022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb022
            #add-point:BEFORE FIELD b_xreb022 name="construct.b.page2.b_xreb022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb022
            
            #add-point:AFTER FIELD b_xreb022 name="construct.a.page2.b_xreb022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_xreb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb022
            #add-point:ON ACTION controlp INFIELD b_xreb022 name="construct.c.page2.b_xreb022"
            
            #END add-point
 
 
         #----<<b_xreb008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb008
            #add-point:BEFORE FIELD b_xreb008 name="construct.b.page2.b_xreb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb008
            
            #add-point:AFTER FIELD b_xreb008 name="construct.a.page2.b_xreb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_xreb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb008
            #add-point:ON ACTION controlp INFIELD b_xreb008 name="construct.c.page2.b_xreb008"
            
            #END add-point
 
 
         #----<<b_xreb100>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb100
            #add-point:BEFORE FIELD b_xreb100 name="construct.b.page2.b_xreb100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb100
            
            #add-point:AFTER FIELD b_xreb100 name="construct.a.page2.b_xreb100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_xreb100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb100
            #add-point:ON ACTION controlp INFIELD b_xreb100 name="construct.c.page2.b_xreb100"
            
            #END add-point
 
 
         #----<<b_xreb103>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb103
            #add-point:BEFORE FIELD b_xreb103 name="construct.b.page2.b_xreb103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb103
            
            #add-point:AFTER FIELD b_xreb103 name="construct.a.page2.b_xreb103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_xreb103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb103
            #add-point:ON ACTION controlp INFIELD b_xreb103 name="construct.c.page2.b_xreb103"
            
            #END add-point
 
 
         #----<<b_xreb113>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb113
            #add-point:BEFORE FIELD b_xreb113 name="construct.b.page2.b_xreb113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb113
            
            #add-point:AFTER FIELD b_xreb113 name="construct.a.page2.b_xreb113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_xreb113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb113
            #add-point:ON ACTION controlp INFIELD b_xreb113 name="construct.c.page2.b_xreb113"
            
            #END add-point
 
 
         #----<<b_xreb101>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb101
            #add-point:BEFORE FIELD b_xreb101 name="construct.b.page2.b_xreb101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb101
            
            #add-point:AFTER FIELD b_xreb101 name="construct.a.page2.b_xreb101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_xreb101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb101
            #add-point:ON ACTION controlp INFIELD b_xreb101 name="construct.c.page2.b_xreb101"
            
            #END add-point
 
 
         #----<<b_xreb114>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb114
            #add-point:BEFORE FIELD b_xreb114 name="construct.b.page2.b_xreb114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb114
            
            #add-point:AFTER FIELD b_xreb114 name="construct.a.page2.b_xreb114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_xreb114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb114
            #add-point:ON ACTION controlp INFIELD b_xreb114 name="construct.c.page2.b_xreb114"
            
            #END add-point
 
 
         #----<<xreb004_1>>----
         #----<<xreb005_1>>----
         #----<<xreb006_1>>----
         #----<<xreb007_1>>----
         #----<<xreb020_1>>----
         #----<<xreb022_1>>----
         #----<<xreb008_1>>----
         #----<<xreb100_1>>----
         #----<<b_xreb123>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb123
            #add-point:BEFORE FIELD b_xreb123 name="construct.b.page3.b_xreb123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb123
            
            #add-point:AFTER FIELD b_xreb123 name="construct.a.page3.b_xreb123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_xreb123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb123
            #add-point:ON ACTION controlp INFIELD b_xreb123 name="construct.c.page3.b_xreb123"
            
            #END add-point
 
 
         #----<<b_xreb121>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb121
            #add-point:BEFORE FIELD b_xreb121 name="construct.b.page3.b_xreb121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb121
            
            #add-point:AFTER FIELD b_xreb121 name="construct.a.page3.b_xreb121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_xreb121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb121
            #add-point:ON ACTION controlp INFIELD b_xreb121 name="construct.c.page3.b_xreb121"
            
            #END add-point
 
 
         #----<<b_xreb124>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb124
            #add-point:BEFORE FIELD b_xreb124 name="construct.b.page3.b_xreb124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb124
            
            #add-point:AFTER FIELD b_xreb124 name="construct.a.page3.b_xreb124"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_xreb124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb124
            #add-point:ON ACTION controlp INFIELD b_xreb124 name="construct.c.page3.b_xreb124"
            
            #END add-point
 
 
         #----<<b_xreb133>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb133
            #add-point:BEFORE FIELD b_xreb133 name="construct.b.page3.b_xreb133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb133
            
            #add-point:AFTER FIELD b_xreb133 name="construct.a.page3.b_xreb133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_xreb133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb133
            #add-point:ON ACTION controlp INFIELD b_xreb133 name="construct.c.page3.b_xreb133"
            
            #END add-point
 
 
         #----<<b_xreb131>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb131
            #add-point:BEFORE FIELD b_xreb131 name="construct.b.page3.b_xreb131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb131
            
            #add-point:AFTER FIELD b_xreb131 name="construct.a.page3.b_xreb131"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_xreb131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb131
            #add-point:ON ACTION controlp INFIELD b_xreb131 name="construct.c.page3.b_xreb131"
            
            #END add-point
 
 
         #----<<b_xreb134>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreb134
            #add-point:BEFORE FIELD b_xreb134 name="construct.b.page3.b_xreb134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreb134
            
            #add-point:AFTER FIELD b_xreb134 name="construct.a.page3.b_xreb134"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_xreb134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb134
            #add-point:ON ACTION controlp INFIELD b_xreb134 name="construct.c.page3.b_xreb134"
            
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
   CALL axrq920_b_fill()
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
 
{<section id="axrq920.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrq920_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
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
 
   LET ls_sql_rank = "SELECT  UNIQUE xreb004,xreb005,xreb006,xreb007,xreb020,xreb022,xreb008,xreb100, 
       xreb103,xreb113,xreb101,xreb114,'','','','','','','','',xreb123,xreb121,xreb124,xreb133,xreb131, 
       xreb134  ,DENSE_RANK() OVER( ORDER BY xreb_t.xrebld,xreb_t.xreb001,xreb_t.xreb002,xreb_t.xreb003, 
       xreb_t.xreb005,xreb_t.xreb006,xreb_t.xreb007) AS RANK FROM xreb_t",
 
 
                     "",
                     " WHERE xrebent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xreb_t"),
                     " ORDER BY xreb_t.xrebld,xreb_t.xreb001,xreb_t.xreb002,xreb_t.xreb003,xreb_t.xreb005,xreb_t.xreb006,xreb_t.xreb007"
 
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
 
   LET g_sql = "SELECT xreb004,xreb005,xreb006,xreb007,xreb020,xreb022,xreb008,xreb100,xreb103,xreb113, 
       xreb101,xreb114,'','','','','','','','',xreb123,xreb121,xreb124,xreb133,xreb131,xreb134",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrq920_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrq920_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xreb_d.clear()
   CALL g_xreb3_d.clear()   
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_xreb_d[l_ac].xreb004,g_xreb_d[l_ac].xreb005,g_xreb_d[l_ac].xreb006,g_xreb_d[l_ac].xreb007, 
       g_xreb_d[l_ac].xreb020,g_xreb_d[l_ac].xreb022,g_xreb_d[l_ac].xreb008,g_xreb_d[l_ac].xreb100,g_xreb_d[l_ac].xreb103, 
       g_xreb_d[l_ac].xreb113,g_xreb_d[l_ac].xreb101,g_xreb_d[l_ac].xreb114,g_xreb3_d[l_ac].xreb004, 
       g_xreb3_d[l_ac].xreb005,g_xreb3_d[l_ac].xreb006,g_xreb3_d[l_ac].xreb007,g_xreb3_d[l_ac].xreb020, 
       g_xreb3_d[l_ac].xreb022,g_xreb3_d[l_ac].xreb008,g_xreb3_d[l_ac].xreb100,g_xreb3_d[l_ac].xreb123, 
       g_xreb3_d[l_ac].xreb121,g_xreb3_d[l_ac].xreb124,g_xreb3_d[l_ac].xreb133,g_xreb3_d[l_ac].xreb131, 
       g_xreb3_d[l_ac].xreb134
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_xreb_d[l_ac].statepic = cl_get_actipic(g_xreb_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL axrq920_detail_show("'1'")      
 
      CALL axrq920_xreb_t_mask()
 
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
   
 
   
   CALL g_xreb_d.deleteElement(g_xreb_d.getLength())   
   CALL g_xreb3_d.deleteElement(g_xreb3_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_xreb_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axrq920_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrq920_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrq920_detail_action_trans()
 
   IF g_xreb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL axrq920_fetch()
   END IF
   
      CALL axrq920_filter_show('xreb004','b_xreb004')
   CALL axrq920_filter_show('xreb005','b_xreb005')
   CALL axrq920_filter_show('xreb006','b_xreb006')
   CALL axrq920_filter_show('xreb007','b_xreb007')
   CALL axrq920_filter_show('xreb020','b_xreb020')
   CALL axrq920_filter_show('xreb022','b_xreb022')
   CALL axrq920_filter_show('xreb008','b_xreb008')
   CALL axrq920_filter_show('xreb100','b_xreb100')
   CALL axrq920_filter_show('xreb103','b_xreb103')
   CALL axrq920_filter_show('xreb113','b_xreb113')
   CALL axrq920_filter_show('xreb101','b_xreb101')
   CALL axrq920_filter_show('xreb114','b_xreb114')
   CALL axrq920_filter_show('xreb123','b_xreb123')
   CALL axrq920_filter_show('xreb121','b_xreb121')
   CALL axrq920_filter_show('xreb124','b_xreb124')
   CALL axrq920_filter_show('xreb133','b_xreb133')
   CALL axrq920_filter_show('xreb131','b_xreb131')
   CALL axrq920_filter_show('xreb134','b_xreb134')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq920.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrq920_fetch()
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
 
{<section id="axrq920.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrq920_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_xrec_d[l_ac].xrec006
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrec_d[l_ac].xrec006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrec_d[l_ac].xrec006_desc

      #end add-point
   END IF
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq920.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrq920_filter()
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
      CONSTRUCT g_wc_filter ON xreb004,xreb005,xreb006,xreb007,xreb020,xreb022,xreb008,xreb100,xreb103, 
          xreb113,xreb101,xreb114,xreb123,xreb121,xreb124,xreb133,xreb131,xreb134
                          FROM s_detail2[1].b_xreb004,s_detail2[1].b_xreb005,s_detail2[1].b_xreb006, 
                              s_detail2[1].b_xreb007,s_detail2[1].b_xreb020,s_detail2[1].b_xreb022,s_detail2[1].b_xreb008, 
                              s_detail2[1].b_xreb100,s_detail2[1].b_xreb103,s_detail2[1].b_xreb113,s_detail2[1].b_xreb101, 
                              s_detail2[1].b_xreb114,s_detail3[1].b_xreb123,s_detail3[1].b_xreb121,s_detail3[1].b_xreb124, 
                              s_detail3[1].b_xreb133,s_detail3[1].b_xreb131,s_detail3[1].b_xreb134
 
         BEFORE CONSTRUCT
                     DISPLAY axrq920_filter_parser('xreb004') TO s_detail2[1].b_xreb004
            DISPLAY axrq920_filter_parser('xreb005') TO s_detail2[1].b_xreb005
            DISPLAY axrq920_filter_parser('xreb006') TO s_detail2[1].b_xreb006
            DISPLAY axrq920_filter_parser('xreb007') TO s_detail2[1].b_xreb007
            DISPLAY axrq920_filter_parser('xreb020') TO s_detail2[1].b_xreb020
            DISPLAY axrq920_filter_parser('xreb022') TO s_detail2[1].b_xreb022
            DISPLAY axrq920_filter_parser('xreb008') TO s_detail2[1].b_xreb008
            DISPLAY axrq920_filter_parser('xreb100') TO s_detail2[1].b_xreb100
            DISPLAY axrq920_filter_parser('xreb103') TO s_detail2[1].b_xreb103
            DISPLAY axrq920_filter_parser('xreb113') TO s_detail2[1].b_xreb113
            DISPLAY axrq920_filter_parser('xreb101') TO s_detail2[1].b_xreb101
            DISPLAY axrq920_filter_parser('xreb114') TO s_detail2[1].b_xreb114
            DISPLAY axrq920_filter_parser('xreb123') TO s_detail3[1].b_xreb123
            DISPLAY axrq920_filter_parser('xreb121') TO s_detail3[1].b_xreb121
            DISPLAY axrq920_filter_parser('xreb124') TO s_detail3[1].b_xreb124
            DISPLAY axrq920_filter_parser('xreb133') TO s_detail3[1].b_xreb133
            DISPLAY axrq920_filter_parser('xreb131') TO s_detail3[1].b_xreb131
            DISPLAY axrq920_filter_parser('xreb134') TO s_detail3[1].b_xreb134
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_xreb004>>----
         #Ctrlp:construct.c.filter.page2.b_xreb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb004
            #add-point:ON ACTION controlp INFIELD b_xreb004 name="construct.c.filter.page2.b_xreb004"
            
            #END add-point
 
 
         #----<<b_xreb005>>----
         #Ctrlp:construct.c.filter.page2.b_xreb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb005
            #add-point:ON ACTION controlp INFIELD b_xreb005 name="construct.c.filter.page2.b_xreb005"
            
            #END add-point
 
 
         #----<<b_xreb006>>----
         #Ctrlp:construct.c.filter.page2.b_xreb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb006
            #add-point:ON ACTION controlp INFIELD b_xreb006 name="construct.c.filter.page2.b_xreb006"
            
            #END add-point
 
 
         #----<<b_xreb007>>----
         #Ctrlp:construct.c.filter.page2.b_xreb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb007
            #add-point:ON ACTION controlp INFIELD b_xreb007 name="construct.c.filter.page2.b_xreb007"
            
            #END add-point
 
 
         #----<<b_xreb020>>----
         #Ctrlp:construct.c.filter.page2.b_xreb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb020
            #add-point:ON ACTION controlp INFIELD b_xreb020 name="construct.c.filter.page2.b_xreb020"
            
            #END add-point
 
 
         #----<<b_xreb022>>----
         #Ctrlp:construct.c.filter.page2.b_xreb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb022
            #add-point:ON ACTION controlp INFIELD b_xreb022 name="construct.c.filter.page2.b_xreb022"
            
            #END add-point
 
 
         #----<<b_xreb008>>----
         #Ctrlp:construct.c.filter.page2.b_xreb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb008
            #add-point:ON ACTION controlp INFIELD b_xreb008 name="construct.c.filter.page2.b_xreb008"
            
            #END add-point
 
 
         #----<<b_xreb100>>----
         #Ctrlp:construct.c.filter.page2.b_xreb100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb100
            #add-point:ON ACTION controlp INFIELD b_xreb100 name="construct.c.filter.page2.b_xreb100"
            
            #END add-point
 
 
         #----<<b_xreb103>>----
         #Ctrlp:construct.c.filter.page2.b_xreb103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb103
            #add-point:ON ACTION controlp INFIELD b_xreb103 name="construct.c.filter.page2.b_xreb103"
            
            #END add-point
 
 
         #----<<b_xreb113>>----
         #Ctrlp:construct.c.filter.page2.b_xreb113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb113
            #add-point:ON ACTION controlp INFIELD b_xreb113 name="construct.c.filter.page2.b_xreb113"
            
            #END add-point
 
 
         #----<<b_xreb101>>----
         #Ctrlp:construct.c.filter.page2.b_xreb101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb101
            #add-point:ON ACTION controlp INFIELD b_xreb101 name="construct.c.filter.page2.b_xreb101"
            
            #END add-point
 
 
         #----<<b_xreb114>>----
         #Ctrlp:construct.c.filter.page2.b_xreb114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb114
            #add-point:ON ACTION controlp INFIELD b_xreb114 name="construct.c.filter.page2.b_xreb114"
            
            #END add-point
 
 
         #----<<xreb004_1>>----
         #----<<xreb005_1>>----
         #----<<xreb006_1>>----
         #----<<xreb007_1>>----
         #----<<xreb020_1>>----
         #----<<xreb022_1>>----
         #----<<xreb008_1>>----
         #----<<xreb100_1>>----
         #----<<b_xreb123>>----
         #Ctrlp:construct.c.filter.page3.b_xreb123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb123
            #add-point:ON ACTION controlp INFIELD b_xreb123 name="construct.c.filter.page3.b_xreb123"
            
            #END add-point
 
 
         #----<<b_xreb121>>----
         #Ctrlp:construct.c.filter.page3.b_xreb121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb121
            #add-point:ON ACTION controlp INFIELD b_xreb121 name="construct.c.filter.page3.b_xreb121"
            
            #END add-point
 
 
         #----<<b_xreb124>>----
         #Ctrlp:construct.c.filter.page3.b_xreb124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb124
            #add-point:ON ACTION controlp INFIELD b_xreb124 name="construct.c.filter.page3.b_xreb124"
            
            #END add-point
 
 
         #----<<b_xreb133>>----
         #Ctrlp:construct.c.filter.page3.b_xreb133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb133
            #add-point:ON ACTION controlp INFIELD b_xreb133 name="construct.c.filter.page3.b_xreb133"
            
            #END add-point
 
 
         #----<<b_xreb131>>----
         #Ctrlp:construct.c.filter.page3.b_xreb131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb131
            #add-point:ON ACTION controlp INFIELD b_xreb131 name="construct.c.filter.page3.b_xreb131"
            
            #END add-point
 
 
         #----<<b_xreb134>>----
         #Ctrlp:construct.c.filter.page3.b_xreb134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb134
            #add-point:ON ACTION controlp INFIELD b_xreb134 name="construct.c.filter.page3.b_xreb134"
            
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
   
      CALL axrq920_filter_show('xreb004','b_xreb004')
   CALL axrq920_filter_show('xreb005','b_xreb005')
   CALL axrq920_filter_show('xreb006','b_xreb006')
   CALL axrq920_filter_show('xreb007','b_xreb007')
   CALL axrq920_filter_show('xreb020','b_xreb020')
   CALL axrq920_filter_show('xreb022','b_xreb022')
   CALL axrq920_filter_show('xreb008','b_xreb008')
   CALL axrq920_filter_show('xreb100','b_xreb100')
   CALL axrq920_filter_show('xreb103','b_xreb103')
   CALL axrq920_filter_show('xreb113','b_xreb113')
   CALL axrq920_filter_show('xreb101','b_xreb101')
   CALL axrq920_filter_show('xreb114','b_xreb114')
   CALL axrq920_filter_show('xreb123','b_xreb123')
   CALL axrq920_filter_show('xreb121','b_xreb121')
   CALL axrq920_filter_show('xreb124','b_xreb124')
   CALL axrq920_filter_show('xreb133','b_xreb133')
   CALL axrq920_filter_show('xreb131','b_xreb131')
   CALL axrq920_filter_show('xreb134','b_xreb134')
 
    
   CALL axrq920_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq920.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrq920_filter_parser(ps_field)
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
 
{<section id="axrq920.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrq920_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrq920_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq920.insert" >}
#+ insert
PRIVATE FUNCTION axrq920_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrq920.modify" >}
#+ modify
PRIVATE FUNCTION axrq920_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq920.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axrq920_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq920.delete" >}
#+ delete
PRIVATE FUNCTION axrq920_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq920.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrq920_detail_action_trans()
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
 
{<section id="axrq920.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrq920_detail_index_setting()
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
            IF g_xreb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xreb_d.getLength() AND g_xreb_d.getLength() > 0
            LET g_detail_idx = g_xreb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xreb_d.getLength() THEN
               LET g_detail_idx = g_xreb_d.getLength()
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
 
{<section id="axrq920.mask_functions" >}
 &include "erp/axr/axrq920_mask.4gl"
 
{</section>}
 
{<section id="axrq920.other_function" readonly="Y" >}

#+ 資料查詢
PRIVATE FUNCTION axrq920_query1()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   DEFINE l_pass     LIKE type_t.num5
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_ld_str   STRING  #160811-00009#2  
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xrec_d.clear()
   CALL g_xreb_d.clear()
   CALL g_xreb3_d.clear()
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
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON xrec005,xrec006 FROM xrec005,xrec006
         BEFORE CONSTRUCT
         ON ACTION controlp INFIELD xrec005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where =" (pmaa002 ='2' OR pmaa002='3')"  #160731-00372#1 2016/08/16 By 07900 add
            #161123-00048#5-add(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_sql_ctrl
            END IF
            #161123-00048#5-add(E)
            CALL q_pmaa001_5()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrec005  #顯示到畫面上
            NEXT FIELD xrec005                     #返回原欄位   
         ON ACTION controlp INFIELD xrec006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_imaa001()                      #呼叫開窗 #161123-00048#5 mark
            LET g_qryparam.arg1 = tm.xrebcomp               #161123-00048#5-add   
            CALL q_imaf001_21()                             #161123-00048#5-add
            DISPLAY g_qryparam.return1 TO xrec006  #顯示到畫面上
            NEXT FIELD xrec006                     #返回原欄位  
         
      END CONSTRUCT
      
      INPUT BY NAME tm.xreb001,tm.xreb002,tm.xrebld
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            CALL axrq920_default()
            
         AFTER FIELD xreb001
            IF NOT cl_null(tm.xreb001) AND NOT cl_null(tm.xreb002) AND NOT cl_null(tm.xrebld) THEN
               CALL axrq920_get_xref()
            END IF
         AFTER FIELD xreb002
            IF NOT cl_null(tm.xreb001) AND NOT cl_null(tm.xreb002) AND NOT cl_null(tm.xrebld) THEN
               CALL axrq920_get_xref()
            END IF
         AFTER FIELD xrebld
            IF NOT cl_null(tm.xrebld) THEN
               CALL axrq920_xrebld_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = tm.xrebld
                  #160318-00005#52 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'agli010'
                        LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                        LET g_errparam.exeprog = 'agli010'
                  END CASE
                  #160318-00005#52 --e add
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET tm.xrebld = ''
                  DISPLAY '','','' TO xrebld_desc,xrebcomp,xrebcomp_desc
                  NEXT FIELD xrebld
               END IF
               #检查使用者是否有权限使用当前账别
               CALL s_ld_chk_authorization(g_user,tm.xrebld) RETURNING l_pass
               IF l_pass = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00022'
                  LET g_errparam.extend = tm.xrebld
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET tm.xrebld = ''
                  DISPLAY '','','' TO xrebld_desc,xrebcomp,xrebcomp_desc
                  NEXT FIELD xrebld
               END IF
               IF NOT cl_null(tm.xreb001) AND NOT cl_null(tm.xreb002)  THEN
                  CALL axrq920_get_xref()
               END IF
            END IF 
            CALL axrq920_xrebld_desc()
            DISPLAY tm.xrebld,tm.xrebld_desc,tm.xrebcomp,tm.xrebcomp_desc
                 TO xrebld,xrebld_desc,xrebcomp,xrebcomp_desc
            
         ON ACTION controlp INFIELD xrebld
            CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str #160811-00009#2
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = tm.xrebld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
             LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y')"    #160811-00009#2 add 
            CALL q_authorised_ld()                                #呼叫開窗

            LET tm.xrebld = g_qryparam.return1              
            CALL axrq920_xrebld_desc()
            DISPLAY tm.xrebld,tm.xrebld_desc,tm.xrebcomp,tm.xrebcomp_desc
                 TO xrebld,xrebld_desc,xrebcomp,xrebcomp_desc
            
            NEXT FIELD xrebld                          #返回原欄位
            
      END INPUT
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
         
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         INITIALIZE tm.* TO NULL
         CALL axrq920_default()
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
   END DIALOG
 
   
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
   ELSE
      LET g_master_idx = 1
   END IF
   
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
        
   LET g_error_show = 1
   CALL axrq920_set_page()
   CALL axrq920_fetch1('F')
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
END FUNCTION

################################################################################
# Descriptions...: 抓取帳套說明及法人資料
# Memo...........:
# Usage..........: CALL axrq920_xrebld_desc()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq920_xrebld_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = tm.xrebld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.xrebld_desc=g_rtn_fields[1]
   SELECT glaacomp INTO tm.xrebcomp FROM glaa_t
   WHERE glaaent=g_enterprise AND glaald=tm.xrebld
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = tm.xrebcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.xrebcomp_desc= g_rtn_fields[1]
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',tm.xrebcomp) RETURNING g_sub_success,g_sql_ctrl #161123-00048#5-add
END FUNCTION

################################################################################
# Descriptions...: 檢查錄入的帳套是否正確
# Memo...........:
# Usage..........: CALL axrq920_xrebld_chk()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq920_xrebld_chk()
   DEFINE l_glaastus  LIKE glaa_t.glaastus
   DEFINE l_glaa008   LIKE glaa_t.glaa008 #160811-00009#2
   DEFINE l_glaa014   LIKE glaa_t.glaa014 #160811-00009#2
   
   LET g_errno = ''
   #SELECT glaastus INTO l_glaastus FROM glaa_t #160811-00009#2
   SELECT glaastus,glaa008,glaa014 INTO l_glaastus,l_glaa008,l_glaa014 FROM glaa_t #160811-00009#2
    WHERE glaaent = g_enterprise
      AND glaald = tm.xrebld
   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'agl-00016'
#      WHEN l_glaastus = 'N'      LET g_errno = 'agl-00051'    #160318-00005#52  mark
      WHEN l_glaastus = 'N'      LET g_errno = 'sub-01302'     #160318-00005#52  add
      WHEN l_glaa008 = 'N' AND l_glaa014 = 'N' LET g_errno = 'axr-00021'  #160811-00009#2  add
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 单身一查询
# Memo...........:
# Usage..........: CALL axrq920_b_fill1()
################################################################################
PRIVATE FUNCTION axrq920_b_fill1()
   DEFINE ls_wc           LIKE type_t.chr500
   DEFINE l_xrec005       LIKE xrec_t.xrec005
   DEFINE l_xrec011       LIKE xrec_t.xrec011
   DEFINE l_pmaal004      LIKE pmaal_t.pmaal004
   DEFINE l_year          LIKE xrec_t.xrec001
   DEFINE l_month         LIKE xrec_t.xrec002
   DEFINE l_xreb021       LIKE xreb_t.xreb021
   
   LET g_sql = "SELECT  UNIQUE xrec005,xrec006,imaal003,SUM(xrec007),SUM(xrec009),SUM(xrec008),-1*SUM(xrec010),SUM(xrec011) FROM xrec_t", 
               " LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xrec006 AND imaal002='"||g_dlang||"' ",
               " WHERE xrecent=",g_enterprise," AND xrecld='",tm.xrebld,"' AND xrec001=",tm.xreb001,
               "   AND xrec002=",tm.xreb002," AND xrec003='AR' AND xrec004='1' AND xrec005='",g_xrec005,"'",
               "   AND xrec006='",g_xrec006,"' ",
               " GROUP BY xrec005,xrec006,imaal003 ",
               " ORDER BY xrec005,xrec006,imaal003 "
               
   PREPARE axrq920_pb1 FROM g_sql
   DECLARE b_fill1_curs1 CURSOR FOR axrq920_pb1

   LET l_ac=1
   FOREACH b_fill1_curs1 INTO l_xrec005,g_xrec_d[l_ac].xrec006,g_xrec_d[l_ac].xrec006_desc, 
                              g_xrec_d[l_ac].xrec007,g_xrec_d[l_ac].xrec009,g_xrec_d[l_ac].xrec008, 
                              g_xrec_d[l_ac].xrec010,g_xrec_d[l_ac].xrec011
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF  
      LET g_xrec_d[l_ac].sel = "N"
      
      #交易說明
      LET l_pmaal004=''
      SELECT pmaal004 INTO l_pmaal004 FROM pmaal_t 
      WHERE pmaalent=g_enterprise AND pmaal001=l_xrec005 AND pmaal002=g_lang
      LET g_xrec_d[l_ac].xrec005=l_xrec005,l_pmaal004
      #上期未沖暫估累計金額
      IF tm.xreb002=1 THEN
         LET l_year=tm.xreb001-1
         LET l_month=12
      ELSE
         LET l_year=tm.xreb001
         LET l_month=tm.xreb002-1
      END IF
      SELECT SUM(xrec011) INTO g_xrec_d[l_ac].xrec011_1 FROM xrec_t
       WHERE xrecent=g_enterprise AND xrecld=tm.xrebld
         AND xrec001=l_year AND xrec002=l_month AND xrec003='AR'
         AND xrec005=l_xrec005 AND xrec006=g_xrec_d[l_ac].xrec006
         
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
   END FOREACH
   LET g_error_show = 0
   LET l_ac = l_ac - 1
   CALL g_xrec_d.deleteElement(g_xrec_d.getLength())
   LET g_detail_cnt = l_ac 
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   #單身二、單身三資料
   LET g_sql = "SELECT UNIQUE xreb004,xreb005,xreb006,xreb007,xreb020,xreb022,xreb008,xreb100,xreb103,", 
               "       xreb113,xreb101,xreb114,xreb123,",
               "       xreb121,xreb124,xreb133,xreb131,xreb134 ",
               "  FROM xreb_t,xrcb_t",
               " WHERE xrebent=xrcbent AND xrebld=xrcbld AND xreb005=xrcbdocno AND xreb006=xrcbseq ",
               "   AND xrebent=",g_enterprise," AND xrebcomp='",tm.xrebcomp,"' AND xrebld='",tm.xrebld,"'",
               "   AND xreb001=",tm.xreb001," AND xreb002=",tm.xreb002," AND xreb003='AR' ",
               "   AND xrcb005='",g_xrec006,"' AND xreb009='",g_xrec005,"'",
               " ORDER BY xreb004,xreb005,xreb006,xreb007 "
   PREPARE axrq920_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR axrq920_pb2
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xreb_d.clear()
   CALL g_xreb3_d.clear()   
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs2 INTO g_xreb_d[l_ac].xreb004,g_xreb_d[l_ac].xreb005,g_xreb_d[l_ac].xreb006,g_xreb_d[l_ac].xreb007, 
       g_xreb_d[l_ac].xreb020,g_xreb_d[l_ac].xreb022,g_xreb_d[l_ac].xreb008,g_xreb_d[l_ac].xreb100,g_xreb_d[l_ac].xreb103, 
       g_xreb_d[l_ac].xreb113,g_xreb_d[l_ac].xreb101,g_xreb_d[l_ac].xreb114, 
       g_xreb3_d[l_ac].xreb123,g_xreb3_d[l_ac].xreb121,g_xreb3_d[l_ac].xreb124, 
       g_xreb3_d[l_ac].xreb133,g_xreb3_d[l_ac].xreb131,g_xreb3_d[l_ac].xreb134 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET g_xreb3_d[l_ac].xreb004 = g_xreb_d[l_ac].xreb004
      LET g_xreb3_d[l_ac].xreb005 = g_xreb_d[l_ac].xreb005
      LET g_xreb3_d[l_ac].xreb006 = g_xreb_d[l_ac].xreb006
      LET g_xreb3_d[l_ac].xreb007 = g_xreb_d[l_ac].xreb007
      LET g_xreb3_d[l_ac].xreb020 = g_xreb_d[l_ac].xreb020
      LET g_xreb3_d[l_ac].xreb022 = g_xreb_d[l_ac].xreb022
      LET g_xreb3_d[l_ac].xreb008 = g_xreb_d[l_ac].xreb008
      LET g_xreb3_d[l_ac].xreb100 = g_xreb_d[l_ac].xreb100
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   CALL g_xreb_d.deleteElement(g_xreb_d.getLength())   
   CALL g_xreb3_d.deleteElement(g_xreb3_d.getLength()) 
   
   SELECT xreb021 INTO l_xreb021 FROM xreb_t
    WHERE xrebent=g_enterprise AND xrebld=tm.xrebld AND xreb001=tm.xreb001
      AND xreb002=tm.xreb002 AND xreb003='AR' AND xreb005=g_xreb_d[1].xreb005
      AND xreb006=g_xreb_d[1].xreb006 AND xreb007=g_xreb_d[1].xreb007
   IF l_xreb021='N' THEN
      CALL cl_set_comp_visible("b_xreb101,b_xreb114,b_xreb121,b_xreb124,b_xreb131,b_xreb134",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_xreb101,b_xreb114,b_xreb121,b_xreb124,b_xreb131,b_xreb134",TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 抓取暫估月結傳票資料
# Memo...........:
# Usage..........: CALL axrq920_get_xref()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq920_get_xref()
   
   LET tm.xref007=''
   LET tm.xref008=''
   SELECT xref007,xref008 INTO tm.xref007,tm.xref008 FROM xref_t
   WHERE xrefent=g_enterprise AND xrefcomp=tm.xrebcomp AND xrefld=tm.xrebld
   AND xref001=tm.xreb001 AND xref002=tm.xreb002 AND xref003='AR' 
   
   DISPLAY tm.xref007,tm.xref008 TO xref007,xref008
END FUNCTION

################################################################################
# Descriptions...: 查詢該期別條件下所有交易對象+科目資料
# Memo...........:
# Usage..........: CALL axrq920_set_page()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq920_set_page()
   DEFINE l_sql    STRING
   DEFINE l_idx    LIKE type_t.num5
   
   CALL g_xrec_p.clear()
   LET l_sql="SELECT DISTINCT xrec005,xrec006 FROM xrec_t",
             " WHERE xrecent=",g_enterprise," AND xrec001=",tm.xreb001," AND xrec002=",tm.xreb002,
             "   AND xrecld='",tm.xrebld,"' AND xrec003='AR' AND xrec004='1' AND ",g_wc,
             " ORDER BY xrec005,xrec006 "
   PREPARE axrq920_sel_p_pr FROM l_sql
   DECLARE axrq920_sel_p_cr CURSOR FOR axrq920_sel_p_pr
   LET l_idx=1
   FOREACH axrq920_sel_p_cr INTO g_xrec_p[l_idx].xrec005,g_xrec_p[l_idx].xrec006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH axrq920_sel_p_cr'
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET l_idx=l_idx+1
      IF l_idx > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   LET l_idx=l_idx-1
   CALL g_xrec_p.deleteElement(g_xrec_p.getLength())
   LET g_header_cnt = l_idx
   LET g_rec_b = l_idx
   DISPLAY g_header_cnt TO FORMONLY.h_count
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axrq920_fetch1(p_flag)
# Input parameter: p_flag   传入参数变量说明1執行操作
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq920_fetch1(p_flag)
   DEFINE p_flag   LIKE type_t.chr1
   DEFINE ls_msg     STRING
   
   IF g_header_cnt = 0 THEN
      LET g_xrec005=NULL
      LET g_xrec006=NULL
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
         
         IF g_jump > 0 AND g_jump <= g_xrec_p.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         
         LET g_no_ask = FALSE  
   END CASE 
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_xrec_p.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_xrec_p.getLength() THEN
      LET g_current_idx = g_xrec_p.getLength()
   END IF
   
   DISPLAY g_current_idx TO FORMONLY.h_index
   LET g_xrec005 = g_xrec_p[g_current_idx].xrec005
   LET g_xrec006 = g_xrec_p[g_current_idx].xrec006
   CALL axrq920_b_fill1() 
END FUNCTION

################################################################################
# Descriptions...: 顯示單頭資料
# Memo...........:
# Usage..........: CALL axrq920_show()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq920_show()
   
   DISPLAY tm.xreb001,tm.xreb002,tm.xrebld,tm.xrebld_desc,tm.xrebcomp,tm.xrebcomp_desc,
           tm.xref007,tm.xref008,g_xrec005,g_xrec006
        TO xreb001,xreb002,xrebld,xrebld_desc,xrebcomp,xrebcomp_desc,xref007,xref008,xrec005,xrec006
END FUNCTION
# 赋默认值
PRIVATE FUNCTION axrq920_default()
   DEFINE l_pass     LIKE type_t.num5
   DEFINE l_success  LIKE type_t.num5
   
   LET tm.xreb001=YEAR(g_today)
   LET tm.xreb002=MONTH(g_today)
   CALL s_ld_bookno()  RETURNING l_success,tm.xrebld
   IF l_success = FALSE THEN
      LET tm.xrebld=""
   END IF 
   CALL s_ld_chk_authorization(g_user,tm.xrebld) RETURNING l_pass
   IF l_pass = FALSE THEN
      LET tm.xrebld=""
   END IF
   CALL axrq920_xrebld_desc()
   DISPLAY tm.xrebld_desc,tm.xrebcomp,tm.xrebcomp_desc TO xrebld_desc,xrebcomp,xrebcomp_desc
END FUNCTION

 
{</section>}
 
