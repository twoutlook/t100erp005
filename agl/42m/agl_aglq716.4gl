#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq716.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-06-03 13:50:15), PR版次:0005(2016-10-24 09:51:30)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000054
#+ Filename...: aglq716
#+ Description: 應收付對象交易明細查詢
#+ Creator....: 01727(2015-03-04 11:11:56)
#+ Modifier...: 01531 -SD/PR- 06821
 
{</section>}
 
{<section id="aglq716.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#44 2016/04/27  By 07959 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160505-00007#11 2016/06/02  By 01531 效能优化
#160811-00039#3  2016/08/12  By 02599 账务中心开窗要限定为账务中心组织编号,修正单身资料抓取录入账务中心下法人资料对应有权限的账套资料
#161021-00037#1  2016/10/24  By 06821 組織類型與職能開窗調整
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
PRIVATE TYPE type_g_glga_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   glgacomp LIKE glga_t.glgacomp, 
   glgacomp_desc LIKE type_t.chr500, 
   glgald LIKE glga_t.glgald, 
   glgald_desc LIKE type_t.chr500, 
   glga100 LIKE glga_t.glga100, 
   glgb021 LIKE glgb_t.glgb021, 
   glgb021_desc LIKE type_t.chr500, 
   style LIKE type_t.chr500, 
   glgadocdt LIKE glga_t.glgadocdt, 
   glga101 LIKE glga_t.glga101, 
   xrca001 LIKE type_t.chr500, 
   glgadocno LIKE glga_t.glgadocno, 
   glga007 LIKE glga_t.glga007, 
   glgb002 LIKE glgb_t.glgb002, 
   glgb002_desc LIKE type_t.chr500, 
   glgb005 LIKE glgb_t.glgb005, 
   l_glgb003 LIKE type_t.num20_6, 
   l_glgb0041 LIKE type_t.num20_6, 
   l_glgb00411 LIKE type_t.num20_6, 
   glgb003 LIKE glgb_t.glgb003, 
   glgb004 LIKE glgb_t.glgb004, 
   l_glgb004 LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_master_m RECORD
   xrcasite      LIKE xrca_t.xrcasite,
   xrcasite_desc LIKE ooefl_t.ooefl003,
   bdate         LIKE xrca_t.xrcadocdt,
   edate         LIKE xrca_t.xrcadocdt,
   types         LIKE type_t.chr1,
   check         LIKE type_t.chr1
       END RECORD
DEFINE g_master_m  type_g_master_m
DEFINE g_wc_xrcald   STRING
DEFINE g_wc_xrcacomp STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glga_d
DEFINE g_master_t                   type_g_glga_d
DEFINE g_glga_d          DYNAMIC ARRAY OF type_g_glga_d
DEFINE g_glga_d_t        type_g_glga_d
 
      
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
 
{<section id="aglq716.main" >}
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
   DECLARE aglq716_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq716_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq716_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq716 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq716_init()   
 
      #進入選單 Menu (="N")
      CALL aglq716_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq716
      
   END IF 
   
   CLOSE aglq716_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   #2015/03/18--02599--add--str--
   DROP TABLE aglq716_tmp;
   DROP TABLE aglq716_xg_tmp;
   #2015/03/18--02599--add--end
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq716.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq716_init()
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
   
      CALL cl_set_combo_scc('b_xrca001','8302') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_create_account_center_tmp()
   CALL aglq716_create_tmp()
   LET g_master_m.bdate = NULL
   LET g_master_m.edate = NULL

   CALL cl_set_combo_scc('b_glga100','8007') 
   CALL cl_set_combo_scc('b_glga101','8035') 
   #end add-point
 
   CALL aglq716_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aglq716.default_search" >}
PRIVATE FUNCTION aglq716_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glgald = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " glgadocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " glga100 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " glga101 = '", g_argv[04], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段開始後 name="default_search.after"
   IF NOT cl_null(g_argv[1]) THEN
      LET g_master_m.xrcasite = g_argv[1]
      LET g_master_m.xrcasite_desc = s_desc_get_department_desc(g_master_m.xrcasite)
      LET g_master_m.bdate = g_argv[2]
      LET g_master_m.edate = g_argv[3]
      LET g_master_m.check = g_argv[4]
      LET g_master_m.types = '3'
      LET g_wc = " glgacomp = '",g_argv[5],"' AND glgald  = '",g_argv[6],"' AND",
                 " glgb021 = '",g_argv[8],"' "
      IF NOT cl_null(g_argv[7]) THEN
         LET g_wc = g_wc," AND glga100  = '",g_argv[7],"'"
      END IF
      IF NOT cl_null(g_argv[9]) THEN
         LET g_wc = g_wc," AND glgb002  = '",g_argv[9],"'"
      END IF
      CALL s_fin_account_center_sons_query('3',g_site,g_today,'1')
      #取得帳務中心底下之組織範圍
      CALL s_fin_account_center_comp_str() RETURNING g_wc_xrcacomp    #150127-00007#1 add
      CALL s_fin_get_wc_str(g_wc_xrcacomp) RETURNING g_wc_xrcacomp
      #取得帳務中心底下的帳套範圍   
      CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
      CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald

      DISPLAY BY NAME g_master_m.xrcasite,g_master_m.xrcasite_desc,g_master_m.types,
                      g_master_m.bdate,g_master_m.edate,g_master_m.check
   END IF
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq716.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq716_ui_dialog()
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
      CALL aglq716_b_fill()
   ELSE
      CALL aglq716_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glga_d.clear()
 
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
 
         CALL aglq716_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glga_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq716_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq716_detail_action_trans()
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
            CALL aglq716_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aglq716_print()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aglq716_print()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglq716_query()
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
            CALL aglq716_filter()
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
            CALL aglq716_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glga_d)
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
            CALL aglq716_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq716_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq716_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq716_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glga_d.getLength()
               LET g_glga_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glga_d.getLength()
               LET g_glga_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glga_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glga_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glga_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glga_d[li_idx].sel = "N"
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
 
{<section id="aglq716.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq716_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glga_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON glgacomp,glgald,glga100,glgb021,glgadocdt,glga101,glgadocno,glga007,glgb002, 
          glgb005
           FROM s_detail1[1].b_glgacomp,s_detail1[1].b_glgald,s_detail1[1].b_glga100,s_detail1[1].b_glgb021, 
               s_detail1[1].b_glgadocdt,s_detail1[1].b_glga101,s_detail1[1].b_glgadocno,s_detail1[1].b_glga007, 
               s_detail1[1].b_glgb002,s_detail1[1].b_glgb005
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_glgacomp>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glgacomp
            #add-point:BEFORE FIELD b_glgacomp name="construct.b.page1.b_glgacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glgacomp
            
            #add-point:AFTER FIELD b_glgacomp name="construct.a.page1.b_glgacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glgacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glgacomp
            #add-point:ON ACTION controlp INFIELD b_glgacomp name="construct.c.page1.b_glgacomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_xrcacomp
            #CALL q_ooef001()   #161021-00037#1 mark
            CALL q_ooef001_46() #161021-00037#1 add            
            DISPLAY g_qryparam.return1 TO b_glgacomp   
            NEXT FIELD b_glgacomp
            #END add-point
 
 
         #----<<glgacomp_desc>>----
         #----<<b_glgald>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glgald
            #add-point:BEFORE FIELD b_glgald name="construct.b.page1.b_glgald"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glgald
            
            #add-point:AFTER FIELD b_glgald name="construct.a.page1.b_glgald"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glgald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glgald
            #add-point:ON ACTION controlp INFIELD b_glgald name="construct.c.page1.b_glgald"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glaald IN ",g_wc_xrcald
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO b_glgald
            NEXT FIELD b_glgald
            #END add-point
 
 
         #----<<glgald_desc>>----
         #----<<b_glga100>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glga100
            #add-point:BEFORE FIELD b_glga100 name="construct.b.page1.b_glga100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glga100
            
            #add-point:AFTER FIELD b_glga100 name="construct.a.page1.b_glga100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glga100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glga100
            #add-point:ON ACTION controlp INFIELD b_glga100 name="construct.c.page1.b_glga100"
            
            #END add-point
 
 
         #----<<b_glgb021>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glgb021
            #add-point:BEFORE FIELD b_glgb021 name="construct.b.page1.b_glgb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glgb021
            
            #add-point:AFTER FIELD b_glgb021 name="construct.a.page1.b_glgb021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glgb021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glgb021
            #add-point:ON ACTION controlp INFIELD b_glgb021 name="construct.c.page1.b_glgb021"
           INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " (pmaa002 ='1' OR pmaa002 ='3') " #供廠商OR交易對象
            CALL q_pmaa001_25()
            DISPLAY g_qryparam.return1 TO b_glgb021
            NEXT FIELD b_glgb021
            #END add-point
 
 
         #----<<glgb021_desc>>----
         #----<<b_style>>----
         #----<<b_glgadocdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glgadocdt
            #add-point:BEFORE FIELD b_glgadocdt name="construct.b.page1.b_glgadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glgadocdt
            
            #add-point:AFTER FIELD b_glgadocdt name="construct.a.page1.b_glgadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glgadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glgadocdt
            #add-point:ON ACTION controlp INFIELD b_glgadocdt name="construct.c.page1.b_glgadocdt"
            
            #END add-point
 
 
         #----<<b_glga101>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glga101
            #add-point:BEFORE FIELD b_glga101 name="construct.b.page1.b_glga101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glga101
            
            #add-point:AFTER FIELD b_glga101 name="construct.a.page1.b_glga101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glga101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glga101
            #add-point:ON ACTION controlp INFIELD b_glga101 name="construct.c.page1.b_glga101"
            
            #END add-point
 
 
         #----<<b_xrca001>>----
         #----<<b_glgadocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glgadocno
            #add-point:BEFORE FIELD b_glgadocno name="construct.b.page1.b_glgadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glgadocno
            
            #add-point:AFTER FIELD b_glgadocno name="construct.a.page1.b_glgadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glgadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glgadocno
            #add-point:ON ACTION controlp INFIELD b_glgadocno name="construct.c.page1.b_glgadocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glapdocno()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glgadocno  #顯示到畫面上
            NEXT FIELD b_glgadocno                     #返回原欄位

            #END add-point
 
 
         #----<<b_glga007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glga007
            #add-point:BEFORE FIELD b_glga007 name="construct.b.page1.b_glga007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glga007
            
            #add-point:AFTER FIELD b_glga007 name="construct.a.page1.b_glga007"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glga007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glga007
            #add-point:ON ACTION controlp INFIELD b_glga007 name="construct.c.page1.b_glga007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glapdocno()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glga007  #顯示到畫面上
            NEXT FIELD b_glga007                     #返回原欄位

            #END add-point
 
 
         #----<<b_glgb002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glgb002
            #add-point:BEFORE FIELD b_glgb002 name="construct.b.page1.b_glgb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glgb002
            
            #add-point:AFTER FIELD b_glgb002 name="construct.a.page1.b_glgb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glgb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glgb002
            #add-point:ON ACTION controlp INFIELD b_glgb002 name="construct.c.page1.b_glgb002"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' " #非統制科目
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO b_glgb002   #顯示到畫面上
            NEXT FIELD b_glgb002

            #END add-point
 
 
         #----<<glgb002_desc>>----
         #----<<b_glgb005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glgb005
            #add-point:BEFORE FIELD b_glgb005 name="construct.b.page1.b_glgb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glgb005
            
            #add-point:AFTER FIELD b_glgb005 name="construct.a.page1.b_glgb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glgb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glgb005
            #add-point:ON ACTION controlp INFIELD b_glgb005 name="construct.c.page1.b_glgb005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO INFIELD  #顯示到畫面上
            NEXT FIELD INFIELD                     #返回原欄位

            #END add-point
 
 
         #----<<l_glgb003>>----
         #----<<l_glgb0041>>----
         #----<<l_glgb00411>>----
         #----<<b_glgb003>>----
         #----<<b_glgb004>>----
         #----<<l_glgb004>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT g_master_m.xrcasite,g_master_m.bdate,g_master_m.edate,g_master_m.types,g_master_m.check    
         FROM xrcasite,bdate,edate,types,check ATTRIBUTE(WITHOUT DEFAULTS)

         AFTER FIELD xrcasite
           LET g_master_m.xrcasite_desc = ''
           IF NOT cl_null(g_master_m.xrcasite) THEN
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = g_master_m.xrcasite
              #161021-00037#1 --s mark
              ##160318-00025#44  2016/04/26  by pengxin  add(S)
              #LET g_errshow = TRUE #是否開窗 
              #LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
              ##160318-00025#44  2016/04/26  by pengxin  add(E)
              #IF NOT cl_chk_exist("v_ooef001") THEN
              #161021-00037#1 --e mark
              IF NOT cl_chk_exist("v_ooef001_212") THEN  #161021-00037#1 add
                 LET g_master_m.xrcasite = ''
                 LET g_master_m.xrcasite_desc = ''
                 DISPLAY BY NAME g_master_m.xrcasite_desc,g_master_m.xrcasite
                 NEXT FIELD CURRENT
              END IF
              #160811-00039#3--mark--str--
#              CALL s_fin_account_center_sons_query('3',g_master_m.xrcasite,g_today,'1')
#              #取得帳務中心底下之組織範圍
#              CALL s_fin_account_center_comp_str() RETURNING g_wc_xrcacomp    #150127-00007#1 add
#              CALL s_fin_get_wc_str(g_wc_xrcacomp) RETURNING g_wc_xrcacomp              
#              #取得帳務中心底下的帳套範圍   
#              CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
#              CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald
              #160811-00039#3--mark--end
              LET g_master_m.xrcasite_desc = s_desc_get_department_desc(g_master_m.xrcasite)
              DISPLAY BY NAME g_master_m.xrcasite_desc
           END IF

         AFTER FIELD bdate
            IF g_master_m.bdate != s_date_get_first_date(g_master_m.bdate) THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "aap-00335"
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_date_get_first_date(g_master_m.bdate) RETURNING g_master_m.bdate
            END IF
            LET g_master_m.edate = s_date_get_last_date(g_master_m.bdate   )
            DISPLAY BY NAME g_master_m.bdate,g_master_m.edate

         AFTER FIELD edate
            IF g_master_m.edate < g_master_m.bdate THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "aap-00336"
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_date_get_first_date(g_master_m.edate) RETURNING g_master_m.bdate
            END IF
            DISPLAY BY NAME g_master_m.bdate,g_master_m.edate

         ON CHANGE check
            IF g_master_m.check = 'Y' THEN
               CALL cl_set_comp_visible('b_glgb005,l_glgb003,l_glgb0041,l_glgb00411',TRUE)
            ELSE  # 不含＂幣別＂則隱藏單身的【幣別】【原幣期初、期末、本期增加、本期減少金額
               CALL cl_set_comp_visible('b_glgb005,l_glgb003,l_glgb0041,l_glgb00411',FALSE)
            END IF

         ON ACTION controlp  INFIELD  xrcasite               
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'i'
           LET g_qryparam.reqry = FALSE
           LET g_qryparam.default1 = g_master_m.xrcasite
           #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00039#3 add #161021-00037#1 mark
           #CALL q_ooef001()   #161021-00037#1 mark
           CALL q_ooef001_46() #161021-00037#1 add     
           LET g_master_m.xrcasite = g_qryparam.return1
           #160811-00039#3--mark--str--
#           CALL s_fin_account_center_sons_query('3',g_master_m.xrcasite,g_today,'1')
#           #取得帳務中心底下之組織範圍
#           CALL s_fin_account_center_comp_str() RETURNING g_wc_xrcacomp    #150127-00007#1 add
#           CALL s_fin_get_wc_str(g_wc_xrcacomp) RETURNING g_wc_xrcacomp              
#           #取得帳務中心底下的帳套範圍   
#           CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
#           CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald
           #160811-00039#3--mark--end
           LET g_master_m.xrcasite_desc = s_desc_get_department_desc(g_master_m.xrcasite)            
           CALL s_desc_get_department_desc(g_master_m.xrcasite) RETURNING g_master_m.xrcasite_desc
           DISPLAY BY NAME g_master_m.xrcasite,g_master_m.xrcasite_desc
           NEXT FIELD xrcasite

      END INPUT

      BEFORE DIALOG
         CALL aglq716_def()
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
   CALL aglq716_b_fill()
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
 
{<section id="aglq716.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq716_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_glaa004       LIKE glaa_t.glaa004
   DEFINE l_glgald        LIKE glga_t.glgald
   DEFINE l_glgacomp      LIKE glga_t.glgacomp
   DEFINE l_glgb021       LIKE glgb_t.glgb021
   DEFINE l_glgb005       LIKE glgb_t.glgb005
   DEFINE l_glgb002       LIKE glgb_t.glgb002
   DEFINE l_glgb0041      LIKE glgb_t.glgb004
   DEFINE l_glgb004       LIKE glgb_t.glgb004
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_gzcbl004      LIKE gzcbl_t.gzcbl004
   DEFINE l_scc           LIKE gzcb_t.gzcb001
   DEFINE l_gzcb005       LIKE gzcb_t.gzcb005
   DEFINE l_amt1          LIKE xrca_t.xrca108
   DEFINE l_amt2          LIKE xrca_t.xrca108
   DEFINE l_amt3          LIKE xrca_t.xrca108
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL aglq716_get_data()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',glgacomp,'',glgald,'',glga100,'','','',glgadocdt,glga101,'', 
       glgadocno,glga007,'','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY glga_t.glgald,glga_t.glgadocno, 
       glga_t.glga100,glga_t.glga101) AS RANK FROM glga_t",
 
 
                     "",
                     " WHERE glgaent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glga_t"),
                     " ORDER BY glga_t.glgald,glga_t.glgadocno,glga_t.glga100,glga_t.glga101"
 
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
 
   LET g_sql = "SELECT '',glgacomp,'',glgald,'',glga100,'','','',glgadocdt,glga101,'',glgadocno,glga007, 
       '','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   IF g_master_m.check = 'Y' THEN
      LET l_glgb005 = "glgb005"
   ELSE
      LET l_glgb005 = "''"
   END IF

#160505-00007#11 add--s---
   LET g_sql= " SELECT apca001 FROM apca_t WHERE apcaent = '",g_enterprise,"'",
              "    AND apcald = ?",
              "    AND apcadocno = ?"
   PREPARE aglq716_pb_1 FROM g_sql   

   LET g_sql= " SELECT apda001 FROM apda_t WHERE apdaent = '",g_enterprise,"'",
              "    AND apdald = ? ",
              "    AND apdadocno = ?"
   PREPARE aglq716_pb_2 FROM g_sql 

   LET g_sql= " SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = ?",
              " AND gzcbl002 = ? ",
              " AND gzcbl003 = '",g_lang,"'"
   PREPARE aglq716_pb_3 FROM g_sql 

   LET g_sql = " SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = (SELECT gzcb005 FROM gzcb_t WHERE gzcb001 = '8035' AND gzcb002 = ?) AND gzzal002 = '",g_lang,"'"  
   PREPARE aglq716_pb_4 FROM g_sql 
   
   LET g_sql = " SELECT xrca001 FROM xrca_t WHERE xrcaent = '",g_enterprise,"'",
               "    AND xrcald = ? ",
               "    AND xrcadocno = ?"
   PREPARE aglq716_pb_5 FROM g_sql  

   LET g_sql = " SELECT xrda001 FROM xrda_t WHERE xrdaent = '",g_enterprise,"'",
               "    AND xrdald = ?",
               "    AND xrdadocno = ?"
   PREPARE aglq716_pb_6 FROM g_sql  

   LET g_sql = "SELECT  ",
               "       CASE WHEN SUM(glgb003)   IS NULL THEN 0 ELSE SUM(glgb003)   END ,",
               "       CASE WHEN SUM(glgb004)   IS NULL THEN 0 ELSE SUM(glgb004)   END ,",
               "       CASE WHEN SUM(glgb0041)  IS NULL THEN 0 ELSE SUM(glgb0041)  END ",
               "  FROM aglq716_tmp                                                               ",
               " WHERE glgaent= '",g_enterprise,"'                                               ",
               "   AND ",ls_wc
   PREPARE aglq716_pb_7 FROM g_sql
   
   LET g_sql = " SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '9743' AND gzcbl002 = ? AND gzcbl003 = '",g_lang,"'"
   PREPARE aglq716_pb_8 FROM g_sql   
#160505-00007#11 add--e----               

#160505-00007#11 mod---s-------
#   LET g_sql = "SELECT ''  ,glgacomp ,''      ,glgald,''       ,glga100,glgb021,'',              ",
#               "       type,glgadocdt,glga101 ,''    ,glgadocno,glga007,glgb002,'',",l_glgb005,",",
#               "       SUM(glgb0030) ,SUM(glgb0040)  ,SUM(glgb00401)   ,                         ",
#               "       SUM(glgb003 ) ,SUM(glgb004 )  ,SUM(glgb0041 )                             ",
#               "  FROM aglq716_tmp                                                               ",
#               " WHERE glgaent= ?                                                                ",
#               "   AND ",ls_wc,
#               " GROUP BY glgacomp,glgald,glga100,glgb021,type,glgadocdt,                        ",
#               "          glga101 ,glgadocno,glga007,glgb002,",l_glgb005,
#               " ORDER BY glgacomp,glgald,glgb021,",l_glgb005,",glgb002,type                           "
   LET g_sql = "SELECT ''  ,glgacomp ,",
               "       (SELECT ooefl003 FROM ooefl_t WHERE ooeflent='",g_enterprise,"' AND ooefl001=glgacomp AND ooefl002='",g_dlang,"'),",
               "       glgald,",
               "       (SELECT glaal002 FROM glaal_t WHERE glaalent='",g_enterprise,"' AND glaalld=glgald AND glaal001='",g_dlang,"'),",
               "       glga100,glgb021,",
               "       (SELECT pmaal004 FROM pmaal_t WHERE pmaalent='",g_enterprise,"' AND pmaal001=glgb021 AND pmaal002='",g_dlang,"'),",
               "       type,glgadocdt,glga101 ,''    ,glgadocno,glga007,glgb002,",
               "       (SELECT glacl004 FROM glacl_t WHERE glaclent='",g_enterprise,"' AND glacl001=(SELECT glaa004 FROM glaa_t WHERE glaaent = '",g_enterprise,"' AND glaald = glgald) ",
               "           AND glacl002=glgb002 AND glacl003='",g_dlang,"'),",
                       l_glgb005,",",
               "       CASE WHEN SUM(glgb0030)  IS NULL THEN 0 ELSE SUM(glgb0030)  END  ,",
               "       CASE WHEN SUM(glgb0040)  IS NULL THEN 0 ELSE SUM(glgb0040)  END ,",
               "       CASE WHEN SUM(glgb00401) IS NULL THEN 0 ELSE SUM(glgb00401) END ,",
               "       CASE WHEN SUM(glgb003)   IS NULL THEN 0 ELSE SUM(glgb003)   END ,",
               "       CASE WHEN SUM(glgb004)   IS NULL THEN 0 ELSE SUM(glgb004)   END ,",
               "       CASE WHEN SUM(glgb0041)  IS NULL THEN 0 ELSE SUM(glgb0041)  END ",
               "  FROM aglq716_tmp                                                               ",
               " WHERE glgaent= ?                                                                ",
               "   AND ",ls_wc,
               " GROUP BY glgacomp,glgald,glga100,glgb021,type,glgadocdt,                        ",
               "          glga101 ,glgadocno,glga007,glgb002,",l_glgb005,
               " ORDER BY glgacomp,glgald,glgb021,",l_glgb005,",glgb002,type                           "
#160505-00007#11 mod---e-------               
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq716_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq716_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glga_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET l_glgald   = NULL
   LET l_glgb021  = NULL
   LET l_glgacomp = NULL
   LET l_glgb005  = NULL
   LET l_glgb002  = NULL
   LET l_glgb0041 = 0
   LET l_glgb004  = 0
   LET l_amt1     = 0
   LET l_amt2     = 0
   LET l_amt3     = 0
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glga_d[l_ac].sel,g_glga_d[l_ac].glgacomp,g_glga_d[l_ac].glgacomp_desc, 
       g_glga_d[l_ac].glgald,g_glga_d[l_ac].glgald_desc,g_glga_d[l_ac].glga100,g_glga_d[l_ac].glgb021, 
       g_glga_d[l_ac].glgb021_desc,g_glga_d[l_ac].style,g_glga_d[l_ac].glgadocdt,g_glga_d[l_ac].glga101, 
       g_glga_d[l_ac].xrca001,g_glga_d[l_ac].glgadocno,g_glga_d[l_ac].glga007,g_glga_d[l_ac].glgb002, 
       g_glga_d[l_ac].glgb002_desc,g_glga_d[l_ac].glgb005,g_glga_d[l_ac].l_glgb003,g_glga_d[l_ac].l_glgb0041, 
       g_glga_d[l_ac].l_glgb00411,g_glga_d[l_ac].glgb003,g_glga_d[l_ac].glgb004,g_glga_d[l_ac].l_glgb004 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_glga_d[l_ac].statepic = cl_get_actipic(g_glga_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
#160505-00007#11 mark --s-----
#      IF cl_null(g_glga_d[l_ac].l_glgb003  ) THEN LET g_glga_d[l_ac].l_glgb003   = 0 END IF
#      IF cl_null(g_glga_d[l_ac].l_glgb0041 ) THEN LET g_glga_d[l_ac].l_glgb0041  = 0 END IF
#      IF cl_null(g_glga_d[l_ac].l_glgb00411) THEN LET g_glga_d[l_ac].l_glgb00411 = 0 END IF
#
#      IF cl_null(g_glga_d[l_ac].l_glgb003  ) THEN LET g_glga_d[l_ac].l_glgb003   = 0 END IF
#      IF cl_null(g_glga_d[l_ac].l_glgb004  ) THEN LET g_glga_d[l_ac].l_glgb004   = 0 END IF
#      IF cl_null(g_glga_d[l_ac].l_glgb0041 ) THEN LET g_glga_d[l_ac].l_glgb0041  = 0 END IF


#      #小計
#      LET l_amt1 = l_amt1 + g_glga_d[l_ac].glgb003
#      LET l_amt2 = l_amt2 + g_glga_d[l_ac].glgb004
#      LET l_amt3 = l_amt3 + g_glga_d[l_ac].l_glgb004
#160505-00007#11 mark --e-----

      IF cl_null(l_glgald  ) THEN LET l_glgald  = g_glga_d[l_ac].glgald   END IF
      IF cl_null(l_glgb021 ) THEN LET l_glgb021 = g_glga_d[l_ac].glgb021  END IF
      IF cl_null(l_glgb005 ) THEN LET l_glgb005 = g_glga_d[l_ac].glgb005  END IF
      IF cl_null(l_glgb002 ) THEN LET l_glgb002 = g_glga_d[l_ac].glgb002  END IF
      IF cl_null(l_glgacomp) THEN LET l_glgacomp= g_glga_d[l_ac].glgacomp END IF

      #說明欄位填充
#160505-00007#11 mark --s-----     
#      SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glga_d[l_ac].glgald
#      CALL s_axrt300_xrca_ref('xrcasite',g_glga_d[l_ac].glgacomp,'','') RETURNING l_success,g_glga_d[l_ac].glgacomp_desc
#      CALL s_axrt300_xrca_ref('xrcald'  ,g_glga_d[l_ac].glgald  ,'','') RETURNING l_success,g_glga_d[l_ac].glgald_desc
#      CALL s_axrt300_xrca_ref('xrca004' ,g_glga_d[l_ac].glgb021 ,'','') RETURNING l_success,g_glga_d[l_ac].glgb021_desc
#      CALL s_axrt300_xrca_ref('xrca035' ,g_glga_d[l_ac].glgb002 ,l_glaa004,'') RETURNING l_success,g_glga_d[l_ac].glgb002_desc
#160505-00007#11 mark --e-----

#160505-00007#11 mod--s------------
#      #帳款單性质
#      CASE
#         WHEN g_glga_d[l_ac].glga101 = 'P10'
#            LET l_scc = '8540'
#            SELECT apca001 INTO g_glga_d[l_ac].xrca001 FROM apca_t WHERE apcaent = g_enterprise
#               AND apcald = g_glga_d[l_ac].glgald
#               AND apcadocno = g_glga_d[l_ac].glgadocno
#              
#            SELECT gzcbl004 INTO l_gzcbl004 FROM gzcbl_t WHERE gzcbl001 = l_scc
#               AND gzcbl002 = g_glga_d[l_ac].xrca001
#               AND gzcbl003 = g_lang  
#            LET g_glga_d[l_ac].xrca001 = g_glga_d[l_ac].xrca001,".",l_gzcbl004
#         WHEN g_glga_d[l_ac].glga101 = 'P20' OR g_glga_d[l_ac].glga101 = 'P30'
#            LET l_scc = '8507'
#            SELECT apda001 INTO g_glga_d[l_ac].xrca001 FROM apda_t WHERE apdaent = g_enterprise
#               AND apdald = g_glga_d[l_ac].glgald
#               AND apdadocno = g_glga_d[l_ac].glgadocno
#            SELECT gzcbl004 INTO l_gzcbl004 FROM gzcbl_t WHERE gzcbl001 = l_scc
#               AND gzcbl002 = g_glga_d[l_ac].xrca001
#               AND gzcbl003 = g_lang
#            LET g_glga_d[l_ac].xrca001 = g_glga_d[l_ac].xrca001,".",l_gzcbl004
#         WHEN g_glga_d[l_ac].glga101 = 'P40' OR g_glga_d[l_ac].glga101 = 'P50'
#            SELECT gzcb005 INTO l_gzcb005 FROM gzcb_t WHERE gzcb001 = '8035' AND gzcb002 = g_glga_d[l_ac].glga101
#            SELECT gzzal003 INTO g_glga_d[l_ac].xrca001 FROM gzzal_t WHERE gzzal001 = l_gzcb005 AND gzzal002 = g_lang
#         WHEN g_glga_d[l_ac].glga101 = 'P51' OR g_glga_d[l_ac].glga101 = 'P60'
#            SELECT gzcb005 INTO l_gzcb005 FROM gzcb_t WHERE gzcb001 = '8035' AND gzcb002 = g_glga_d[l_ac].glga101
#            SELECT gzzal003 INTO g_glga_d[l_ac].xrca001 FROM gzzal_t WHERE gzzal001 = l_gzcb005 AND gzzal002 = g_lang
#         WHEN g_glga_d[l_ac].glga101 = 'R10'
#            LET l_scc = '8302'
#            SELECT xrca001 INTO g_glga_d[l_ac].xrca001 FROM xrca_t WHERE xrcaent = g_enterprise
#               AND xrcald = g_glga_d[l_ac].glgald
#               AND xrcadocno = g_glga_d[l_ac].glgadocno
#            SELECT gzcbl004 INTO l_gzcbl004 FROM gzcbl_t WHERE gzcbl001 = l_scc
#               AND gzcbl002 = g_glga_d[l_ac].xrca001
#               AND gzcbl003 = g_lang
#            LET g_glga_d[l_ac].xrca001 = g_glga_d[l_ac].xrca001,".",l_gzcbl004
#         WHEN g_glga_d[l_ac].glga101 = 'R20'
#            LET l_scc = '8307'
#            SELECT xrda001 INTO g_glga_d[l_ac].xrca001 FROM xrda_t WHERE xrdaent = g_enterprise
#               AND xrdald = g_glga_d[l_ac].glgald
#               AND xrdadocno = g_glga_d[l_ac].glgadocno
#            SELECT gzcbl004 INTO l_gzcbl004 FROM gzcbl_t WHERE gzcbl001 = l_scc
#               AND gzcbl002 = g_glga_d[l_ac].xrca001
#               AND gzcbl003 = g_lang
#            LET g_glga_d[l_ac].xrca001 = g_glga_d[l_ac].xrca001,".",l_gzcbl004
#         WHEN g_glga_d[l_ac].glga101 = 'R40' OR g_glga_d[l_ac].glga101 = 'R50' OR g_glga_d[l_ac].glga101 = '650'
#            SELECT gzcb005 INTO l_gzcb005 FROM gzcb_t WHERE gzcb001 = '8035' AND gzcb002 = g_glga_d[l_ac].glga101
#            SELECT gzzal003 INTO g_glga_d[l_ac].xrca001 FROM gzzal_t WHERE gzzal001 = l_gzcb005 AND gzzal002 = g_lang
#      END CASE
      #帳款單性质
      CASE
         WHEN g_glga_d[l_ac].glga101 = 'P10'
            LET l_scc = '8540'
            EXECUTE aglq716_pb_1 USING g_glga_d[l_ac].glgald,g_glga_d[l_ac].glgadocno INTO g_glga_d[l_ac].xrca001 
            EXECUTE aglq716_pb_3 USING l_scc,g_glga_d[l_ac].xrca001 INTO l_gzcbl004               
            LET g_glga_d[l_ac].xrca001 = g_glga_d[l_ac].xrca001,".",l_gzcbl004
            
         WHEN g_glga_d[l_ac].glga101 = 'P20' OR g_glga_d[l_ac].glga101 = 'P30'
            LET l_scc = '8507'
            EXECUTE aglq716_pb_2 USING g_glga_d[l_ac].glgald,g_glga_d[l_ac].glgadocno INTO g_glga_d[l_ac].xrca001 
            EXECUTE aglq716_pb_3 USING l_scc,g_glga_d[l_ac].xrca001 INTO l_gzcbl004               
            LET g_glga_d[l_ac].xrca001 = g_glga_d[l_ac].xrca001,".",l_gzcbl004
            
         WHEN g_glga_d[l_ac].glga101 = 'P40' OR g_glga_d[l_ac].glga101 = 'P50'
            EXECUTE aglq716_pb_4 USING g_glga_d[l_ac].glga101 INTO g_glga_d[l_ac].xrca001
            
         WHEN g_glga_d[l_ac].glga101 = 'P51' OR g_glga_d[l_ac].glga101 = 'P60'
            EXECUTE aglq716_pb_4 USING g_glga_d[l_ac].glga101 INTO g_glga_d[l_ac].xrca001
            
         WHEN g_glga_d[l_ac].glga101 = 'R10'
            LET l_scc = '8302'
            EXECUTE aglq716_pb_5 USING g_glga_d[l_ac].glgald,g_glga_d[l_ac].glgadocno INTO g_glga_d[l_ac].xrca001 
            EXECUTE aglq716_pb_3 USING l_scc,g_glga_d[l_ac].xrca001 INTO l_gzcbl004 
            LET g_glga_d[l_ac].xrca001 = g_glga_d[l_ac].xrca001,".",l_gzcbl004
            
         WHEN g_glga_d[l_ac].glga101 = 'R20'
            LET l_scc = '8307'
            EXECUTE aglq716_pb_6 USING g_glga_d[l_ac].glgald,g_glga_d[l_ac].glgadocno INTO g_glga_d[l_ac].xrca001 
            EXECUTE aglq716_pb_3 USING l_scc,g_glga_d[l_ac].xrca001 INTO l_gzcbl004 
            LET g_glga_d[l_ac].xrca001 = g_glga_d[l_ac].xrca001,".",l_gzcbl004
            
         WHEN g_glga_d[l_ac].glga101 = 'R40' OR g_glga_d[l_ac].glga101 = 'R50' OR g_glga_d[l_ac].glga101 = '650'
            EXECUTE aglq716_pb_4 USING g_glga_d[l_ac].glga101 INTO g_glga_d[l_ac].xrca001
      END CASE
#160505-00007#11 mod--e------------ 

      #glgald,glgb021,glgb005,glgb002决定一次期初、期中、期末
      IF g_glga_d[l_ac].style <> '10' AND l_ac = 1 THEN
         LET g_glga_d[l_ac + 1].* = g_glga_d[l_ac].*
         LET g_glga_d[l_ac].glga100    = NULL
         LET g_glga_d[l_ac].style      = aglq716_get_desc('10')
         LET g_glga_d[l_ac].glgadocdt  = NULL
         LET g_glga_d[l_ac].glga101    = NULL
         LET g_glga_d[l_ac].xrca001    = NULL
         LET g_glga_d[l_ac].glgadocno  = NULL
         LET g_glga_d[l_ac].glga007    = NULL
         LET g_glga_d[l_ac].l_glgb003  = 0
         LET g_glga_d[l_ac].l_glgb0041 = 0
         LET g_glga_d[l_ac].l_glgb00411= 0
         LET g_glga_d[l_ac].glgb003    = 0
         LET g_glga_d[l_ac].glgb004    = 0
         LET g_glga_d[l_ac].l_glgb004  = 0
         LET l_ac = l_ac + 1
      END IF


      LET l_flag = 'N'
      IF g_master_m.check = 'Y' THEN
         IF g_glga_d[l_ac].glgb005 = l_glgb005 THEN
            LET l_flag = 'Y'
         END IF
      ELSE
         LET l_flag = 'Y'
      END IF
      IF g_glga_d[l_ac].glgald = l_glgald AND g_glga_d[l_ac].glgb021 = l_glgb021 AND g_glga_d[l_ac].glgacomp = l_glgacomp AND g_glga_d[l_ac].glgb002 = l_glgb002 AND l_flag = 'Y' THEN

         LET l_glgb0041 = l_glgb0041 + g_glga_d[l_ac].l_glgb00411
         LET g_glga_d[l_ac].l_glgb00411 = l_glgb0041

         LET l_glgb004  = l_glgb004  + g_glga_d[l_ac].l_glgb004
         LET g_glga_d[l_ac].l_glgb004 = l_glgb004
      ELSE
         LET g_glga_d[l_ac + 1].* = g_glga_d[l_ac].*
         LET g_glga_d[l_ac].glgald     = g_glga_d[l_ac - 1].glgald
         LET g_glga_d[l_ac].glgald_desc= g_glga_d[l_ac - 1].glgald_desc
         LET g_glga_d[l_ac].glgb021    = g_glga_d[l_ac - 1].glgb021
         LET g_glga_d[l_ac].glgb021_desc= g_glga_d[l_ac - 1].glgb021_desc
         LET g_glga_d[l_ac].glgacomp   = g_glga_d[l_ac - 1].glgacomp
         LET g_glga_d[l_ac].glgacomp_desc= g_glga_d[l_ac - 1].glgacomp_desc
         LET g_glga_d[l_ac].glgb005    = g_glga_d[l_ac - 1].glgb005
         LET g_glga_d[l_ac].glga100    = NULL
         LET g_glga_d[l_ac].style      = aglq716_get_desc('50')
         LET g_glga_d[l_ac].glgadocdt  = NULL
         LET g_glga_d[l_ac].glga101    = NULL
         LET g_glga_d[l_ac].xrca001    = NULL
         LET g_glga_d[l_ac].glgadocno  = NULL
         LET g_glga_d[l_ac].glga007    = NULL
         LET g_glga_d[l_ac].glgb002    = g_glga_d[l_ac - 1].glgb002
         LET g_glga_d[l_ac].glgb002_desc= g_glga_d[l_ac - 1].glgb002_desc
         LET g_glga_d[l_ac].l_glgb003  = 0
         LET g_glga_d[l_ac].l_glgb0041 = 0
         LET g_glga_d[l_ac].l_glgb00411= l_glgb0041
         LET g_glga_d[l_ac].glgb003    = 0
         LET g_glga_d[l_ac].glgb004    = 0
         LET g_glga_d[l_ac].l_glgb004   = l_glgb004
         LET l_ac = l_ac + 1
         LET l_glgb0041 = 0
         LET l_glgb004  = 0

         IF g_glga_d[l_ac].style <> '10' THEN
            LET g_glga_d[l_ac + 1].* = g_glga_d[l_ac].*
            LET g_glga_d[l_ac].glga100    = NULL
#160505-00007 mod s---           
            EXECUTE aglq716_pb_8 USING '10' INTO g_glga_d[l_ac].style
#            LET g_glga_d[l_ac].style      = aglq716_get_desc('10')
#160505-00007 mod e---  
            LET g_glga_d[l_ac].glgadocdt  = NULL
            LET g_glga_d[l_ac].glga101    = NULL
            LET g_glga_d[l_ac].xrca001    = NULL
            LET g_glga_d[l_ac].glgadocno  = NULL
            LET g_glga_d[l_ac].glga007    = NULL
            LET g_glga_d[l_ac].l_glgb003  = 0
            LET g_glga_d[l_ac].l_glgb0041 = 0
            LET g_glga_d[l_ac].l_glgb00411= 0
            LET g_glga_d[l_ac].glgb003    = 0
            LET g_glga_d[l_ac].glgb004    = 0
            LET g_glga_d[l_ac].l_glgb004   = 0
            LET l_ac = l_ac + 1
         END IF
         IF g_glga_d[l_ac].style <> '50' THEN
           LET l_glgb0041 = l_glgb0041 + g_glga_d[l_ac].l_glgb00411
           LET g_glga_d[l_ac].l_glgb00411 = l_glgb0041

           LET l_glgb004  = l_glgb004  + g_glga_d[l_ac].l_glgb004
           LET g_glga_d[l_ac].l_glgb004 = l_glgb004
         END IF

      END IF
#160505-00007#11 mod--s----
      EXECUTE aglq716_pb_8 USING g_glga_d[l_ac].style INTO g_glga_d[l_ac].style
#      CALL aglq716_get_desc(g_glga_d[l_ac].style) RETURNING g_glga_d[l_ac].style
#160505-00007#11 mod--e----
      LET l_glgald  = g_glga_d[l_ac].glgald
      LET l_glgb021 = g_glga_d[l_ac].glgb021
      LET l_glgacomp= g_glga_d[l_ac].glgacomp
      LET l_glgb005 = g_glga_d[l_ac].glgb005
      LET l_glgb002 = g_glga_d[l_ac].glgb002

      #end add-point
 
      CALL aglq716_detail_show("'1'")      
 
      CALL aglq716_glga_t_mask()
 
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
   
 
   
   CALL g_glga_d.deleteElement(g_glga_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   IF l_ac > 1 THEN
      LET g_glga_d[l_ac].* = g_glga_d[l_ac -1].*
      LET g_glga_d[l_ac].glga100    = NULL
#160505-00007 mod s---     
      EXECUTE aglq716_pb_8 USING '50' INTO g_glga_d[l_ac].style
#      LET g_glga_d[l_ac].style      = aglq716_get_desc('50')
#160505-00007 mod e---  
      LET g_glga_d[l_ac].glgadocdt  = NULL
      LET g_glga_d[l_ac].glga101    = NULL
      LET g_glga_d[l_ac].xrca001    = NULL
      LET g_glga_d[l_ac].glgadocno  = NULL
      LET g_glga_d[l_ac].glga007    = NULL
      LET g_glga_d[l_ac].l_glgb003  = 0
      LET g_glga_d[l_ac].l_glgb0041 = 0
      LET g_glga_d[l_ac].l_glgb00411= l_glgb0041
      LET g_glga_d[l_ac].glgb003    = 0
      LET g_glga_d[l_ac].glgb004    = 0
      LET g_glga_d[l_ac].l_glgb004  = l_glgb004

#160505-00007#11 mark s---
#画面档中处理小计
#      #小計
#      LET g_glga_d[l_ac + 1].* = g_glga_d[l_ac].*
#      INITIALIZE g_glga_d[l_ac +1].* TO NULL
#      LET g_glga_d[l_ac+ 1].glgadocno = "小计:"
#      LET g_glga_d[l_ac+ 1].glgb003   = l_amt1
#      LET g_glga_d[l_ac+ 1].glgb004   = l_amt2
#      LET g_glga_d[l_ac+ 1].l_glgb004 = l_amt3
      LET g_glga_d[l_ac + 1].* = g_glga_d[l_ac].*
      INITIALIZE g_glga_d[l_ac +1].* TO NULL
      LET g_glga_d[l_ac+ 1].glgadocno = cl_getmsg("azz-00928",g_lang) 
      EXECUTE aglq716_pb_7 INTO g_glga_d[l_ac+ 1].glgb003,g_glga_d[l_ac+ 1].glgb004,g_glga_d[l_ac+ 1].l_glgb004
#160505-00007#11 mark e---
   END IF
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_glga_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq716_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq716_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq716_detail_action_trans()
 
   IF g_glga_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq716_fetch()
   END IF
   
      CALL aglq716_filter_show('glgacomp','b_glgacomp')
   CALL aglq716_filter_show('glgald','b_glgald')
   CALL aglq716_filter_show('glga100','b_glga100')
   CALL aglq716_filter_show('glgb021','b_glgb021')
   CALL aglq716_filter_show('glgadocdt','b_glgadocdt')
   CALL aglq716_filter_show('glga101','b_glga101')
   CALL aglq716_filter_show('glgadocno','b_glgadocno')
   CALL aglq716_filter_show('glga007','b_glga007')
   CALL aglq716_filter_show('glgb002','b_glgb002')
   CALL aglq716_filter_show('glgb005','b_glgb005')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq716.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq716_fetch()
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
 
{<section id="aglq716.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq716_detail_show(ps_page)
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
 
{<section id="aglq716.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq716_filter()
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
      CONSTRUCT g_wc_filter ON glgacomp,glgald,glga100,glgb021,glgadocdt,glga101,glgadocno,glga007,glgb002, 
          glgb005
                          FROM s_detail1[1].b_glgacomp,s_detail1[1].b_glgald,s_detail1[1].b_glga100, 
                              s_detail1[1].b_glgb021,s_detail1[1].b_glgadocdt,s_detail1[1].b_glga101, 
                              s_detail1[1].b_glgadocno,s_detail1[1].b_glga007,s_detail1[1].b_glgb002, 
                              s_detail1[1].b_glgb005
 
         BEFORE CONSTRUCT
                     DISPLAY aglq716_filter_parser('glgacomp') TO s_detail1[1].b_glgacomp
            DISPLAY aglq716_filter_parser('glgald') TO s_detail1[1].b_glgald
            DISPLAY aglq716_filter_parser('glga100') TO s_detail1[1].b_glga100
            DISPLAY aglq716_filter_parser('glgb021') TO s_detail1[1].b_glgb021
            DISPLAY aglq716_filter_parser('glgadocdt') TO s_detail1[1].b_glgadocdt
            DISPLAY aglq716_filter_parser('glga101') TO s_detail1[1].b_glga101
            DISPLAY aglq716_filter_parser('glgadocno') TO s_detail1[1].b_glgadocno
            DISPLAY aglq716_filter_parser('glga007') TO s_detail1[1].b_glga007
            DISPLAY aglq716_filter_parser('glgb002') TO s_detail1[1].b_glgb002
            DISPLAY aglq716_filter_parser('glgb005') TO s_detail1[1].b_glgb005
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_glgacomp>>----
         #Ctrlp:construct.c.filter.page1.b_glgacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glgacomp
            #add-point:ON ACTION controlp INFIELD b_glgacomp name="construct.c.filter.page1.b_glgacomp"
            
            #END add-point
 
 
         #----<<glgacomp_desc>>----
         #----<<b_glgald>>----
         #Ctrlp:construct.c.filter.page1.b_glgald
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glgald
            #add-point:ON ACTION controlp INFIELD b_glgald name="construct.c.filter.page1.b_glgald"
            
            #END add-point
 
 
         #----<<glgald_desc>>----
         #----<<b_glga100>>----
         #Ctrlp:construct.c.filter.page1.b_glga100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glga100
            #add-point:ON ACTION controlp INFIELD b_glga100 name="construct.c.filter.page1.b_glga100"
            
            #END add-point
 
 
         #----<<b_glgb021>>----
         #Ctrlp:construct.c.filter.page1.b_glgb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glgb021
            #add-point:ON ACTION controlp INFIELD b_glgb021 name="construct.c.filter.page1.b_glgb021"
            
            #END add-point
 
 
         #----<<glgb021_desc>>----
         #----<<b_style>>----
         #----<<b_glgadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_glgadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glgadocdt
            #add-point:ON ACTION controlp INFIELD b_glgadocdt name="construct.c.filter.page1.b_glgadocdt"
            
            #END add-point
 
 
         #----<<b_glga101>>----
         #Ctrlp:construct.c.filter.page1.b_glga101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glga101
            #add-point:ON ACTION controlp INFIELD b_glga101 name="construct.c.filter.page1.b_glga101"
            
            #END add-point
 
 
         #----<<b_xrca001>>----
         #----<<b_glgadocno>>----
         #Ctrlp:construct.c.filter.page1.b_glgadocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glgadocno
            #add-point:ON ACTION controlp INFIELD b_glgadocno name="construct.c.filter.page1.b_glgadocno"
            
            #END add-point
 
 
         #----<<b_glga007>>----
         #Ctrlp:construct.c.filter.page1.b_glga007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glga007
            #add-point:ON ACTION controlp INFIELD b_glga007 name="construct.c.filter.page1.b_glga007"
            
            #END add-point
 
 
         #----<<b_glgb002>>----
         #Ctrlp:construct.c.filter.page1.b_glgb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glgb002
            #add-point:ON ACTION controlp INFIELD b_glgb002 name="construct.c.filter.page1.b_glgb002"
            
            #END add-point
 
 
         #----<<glgb002_desc>>----
         #----<<b_glgb005>>----
         #Ctrlp:construct.c.filter.page1.b_glgb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glgb005
            #add-point:ON ACTION controlp INFIELD b_glgb005 name="construct.c.filter.page1.b_glgb005"
            
            #END add-point
 
 
         #----<<l_glgb003>>----
         #----<<l_glgb0041>>----
         #----<<l_glgb00411>>----
         #----<<b_glgb003>>----
         #----<<b_glgb004>>----
         #----<<l_glgb004>>----
   
 
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
   
      CALL aglq716_filter_show('glgacomp','b_glgacomp')
   CALL aglq716_filter_show('glgald','b_glgald')
   CALL aglq716_filter_show('glga100','b_glga100')
   CALL aglq716_filter_show('glgb021','b_glgb021')
   CALL aglq716_filter_show('glgadocdt','b_glgadocdt')
   CALL aglq716_filter_show('glga101','b_glga101')
   CALL aglq716_filter_show('glgadocno','b_glgadocno')
   CALL aglq716_filter_show('glga007','b_glga007')
   CALL aglq716_filter_show('glgb002','b_glgb002')
   CALL aglq716_filter_show('glgb005','b_glgb005')
 
    
   CALL aglq716_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq716.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq716_filter_parser(ps_field)
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
 
{<section id="aglq716.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq716_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq716_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq716.insert" >}
#+ insert
PRIVATE FUNCTION aglq716_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq716.modify" >}
#+ modify
PRIVATE FUNCTION aglq716_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq716.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq716_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq716.delete" >}
#+ delete
PRIVATE FUNCTION aglq716_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq716.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq716_detail_action_trans()
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
 
{<section id="aglq716.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq716_detail_index_setting()
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
            IF g_glga_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_glga_d.getLength() AND g_glga_d.getLength() > 0
            LET g_detail_idx = g_glga_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_glga_d.getLength() THEN
               LET g_detail_idx = g_glga_d.getLength()
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
 
{<section id="aglq716.mask_functions" >}
 &include "erp/agl/aglq716_mask.4gl"
 
{</section>}
 
{<section id="aglq716.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 給予預設值
# Memo...........:
# Usage..........: CALL aglq716_def()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/04 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq716_def()

   IF cl_null(g_master_m.xrcasite) THEN
      LET g_master_m.xrcasite = g_site   
      LET g_master_m.xrcasite_desc = s_desc_get_department_desc(g_master_m.xrcasite)
   END IF
   IF cl_null(g_master_m.check) THEN
      LET g_master_m.check = 'Y'
      CALL cl_set_comp_visible('b_glgb005,b_glgb0030,b_glgb0040,b_glgb00401',TRUE)
   END IF
   IF cl_null(g_master_m.types) THEN
      LET g_master_m.types = '3'
   END IF
   IF cl_null(g_master_m.bdate) THEN
      LET g_master_m.bdate = s_date_get_first_date(g_today) 
      LET g_master_m.edate = s_date_get_last_date(g_today) 
   END IF
   #160811-00039#3--mark--str--
#   CALL s_fin_account_center_sons_query('3',g_site,g_today,'1')
#   #取得帳務中心底下之組織範圍
#   CALL s_fin_account_center_comp_str() RETURNING g_wc_xrcacomp    #150127-00007#1 add
#   CALL s_fin_get_wc_str(g_wc_xrcacomp) RETURNING g_wc_xrcacomp
#   #取得帳務中心底下的帳套範圍   
#   CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
#   CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald
   #160811-00039#3--mark--end
   DISPLAY BY NAME g_master_m.xrcasite,g_master_m.xrcasite_desc,g_master_m.types,
                   g_master_m.bdate,g_master_m.edate,g_master_m.check

END FUNCTION

################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL aglq716_create_tmp()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/04 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq716_create_tmp()

   DROP TABLE aglq716_tmp;
   CREATE TEMP TABLE aglq716_tmp(
      glgacomp        VARCHAR(10),       
      glgald          VARCHAR(5), 
      glga100         VARCHAR(4),
      glgb021         VARCHAR(10),
      type            VARCHAR(5),
      glgadocdt       DATE,
      glga101         VARCHAR(10),
      glgadocno       VARCHAR(20),
      glga007         VARCHAR(20),
      glgb002         VARCHAR(24),
      glgb005         VARCHAR(10),
      glgb0030        DECIMAL(20,6),
      glgb0040        DECIMAL(20,6),
      glgb00401       DECIMAL(20,6),
      glgb003         DECIMAL(20,6),
      glgb004         DECIMAL(20,6),
      glgb0041        DECIMAL(20,6),
      glgaent         SMALLINT
         )
   #2015/03/18--02599--add--str-- 
   #存入單身資料，用於報表打印   
   DROP TABLE aglq716_xg_tmp;
   CREATE TEMP TABLE aglq716_xg_tmp(
      seq            INTEGER,
      glgaent        SMALLINT,
      glgacomp       VARCHAR(10),
      glgacomp_desc  VARCHAR(500),
      glgald         VARCHAR(5),
      glgald_desc    VARCHAR(500),
      glga100        VARCHAR(200),
      glgb021        VARCHAR(10),
      glgb021_desc   VARCHAR(80),
      style          VARCHAR(200),
      glgadocdt      DATE,
      glga101        VARCHAR(200),
      xrca001        VARCHAR(200),
      glgadocno      VARCHAR(20),
      glga007        VARCHAR(20),
      glgb002        VARCHAR(24),
      glgb002_desc   VARCHAR(500),
      glgb005        VARCHAR(10),
      glgb0030       DECIMAL(20,6),
      glgb0040       DECIMAL(20,6),
      glgb00401      DECIMAL(20,6),
      glgb003        DECIMAL(20,6),
      glgb004        DECIMAL(20,6),
      glgb0041       DECIMAL(20,6)
   )
   #2015/03/18--02599--add--end
END FUNCTION

################################################################################
# Descriptions...: 將符合條件的資料存入臨時表
# Memo...........:
# Usage..........: CALL aglq716_get_data()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/04 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq716_get_data()
   DEFINE l_year          LIKE type_t.num5
   DEFINE l_month         LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE ls_wc           STRING
   DEFINE l_wc            STRING  #160811-00039#3 add
   DEFINE l_ld_str        STRING  #160811-00039#3 add

   LET l_year = YEAR(g_master_m.bdate)
   LET l_month= MONTH(g_master_m.bdate)

   DELETE FROM aglq716_tmp

#   CALL s_fin_account_center_sons_query('3',g_site,g_today,'1') #160811-00039#3 mark
   CALL s_fin_account_center_sons_query('3',g_master_m.xrcasite,g_today,'1') #160811-00039#3
   #取得帳務中心底下之組織範圍
   CALL s_fin_account_center_comp_str() RETURNING g_wc_xrcacomp    #150127-00007#1 add
   CALL s_fin_get_wc_str(g_wc_xrcacomp) RETURNING g_wc_xrcacomp
   #取得帳務中心底下的帳套範圍   
#   CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald #160811-00039#3 mark
#   CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald #160811-00039#3 mark
   #160811-00039#3--add--str--
   LET l_wc=g_wc_xrcacomp.substring(3,g_wc_xrcacomp.getLength()-2)
   #账套范围
   CALL s_axrt300_get_site(g_user,l_wc,'2')  RETURNING l_ld_str 
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","glatld")
   IF cl_null(l_ld_str) THEN   
      LET l_ld_str = " 1=1 "
   END IF
   #160811-00039#3--add--end
   
   CASE
      WHEN g_master_m.types = '1'   #未審核
         LET ls_wc = " glgastus ='N' "
      WHEN g_master_m.types = '2'   #已審核未拋轉
         LET ls_wc = " glgastus ='Y' and glga007 IS NULL"
      WHEN g_master_m.types = '3'   #已審核以拋轉
         LET ls_wc = " glgastus ='Y' and glga007 IS NOT NULL"
      WHEN g_master_m.types = '4'   #全部
         LET ls_wc = " 1=1"
   END CASE

   #STEP1:將期初餘額匯入臨時表
   LET g_sql = "   INSERT INTO aglq716_tmp                                                                  ",
               "   SELECT glatcomp,glatld,'',glat005,10,'','','','',glat007,glat100,                        ",
               "          0,0,SUM (CASE WHEN glac008 = 1 THEN glat103 - glat104 ELSE glat104 - glat103 END),",
               "          0,0,SUM (CASE WHEN glac008 = 1 THEN glat113 - glat114 ELSE glat114 - glat113 END),",
               "          glatent                                                                           ",
               "     FROM glat_t,glac_t,glaa_t                                                              ",
               "    WHERE     glatld = glaald                     AND glatent = glacent                     ",
               "          AND glat001 = '",l_year,"'              AND glat002 < '",l_month,"'               ",
               "          AND glatent = glaaent                   AND glatent = '",g_enterprise,"'          ",
               "          AND glac002 = glat007                   AND glaa004 = glac001                     ",
#               "          AND glatld IN ",g_wc_xrcald CLIPPED , #160811-00039#3 mark
               "          AND ",l_ld_str,  #160811-00039#3 add
               " GROUP BY glatcomp,glatld,glat005,glat007,glat100,glatent                                   "   
   PREPARE aglq716_tmp01 FROM g_sql
   EXECUTE aglq716_tmp01

   #STEP2:將本期異動匯入臨時表
   LET l_ld_str = cl_replace_str(l_ld_str,"glatld","glgald")  #160811-00039#3 add
   #本期異動
   LET g_sql = "   INSERT INTO aglq716_tmp                               ",
               "   SELECT glgbcomp,glgbld,glga100,glgb021,20,glgadocdt,glga101,glgadocno,glga007,glgb002,glgb005,                                                 ",   
               "          SUM(CASE WHEN glgb003 > 0 THEN glgb010 ELSE 0 END),  ",
               "          SUM(CASE WHEN glgb004 > 0 THEN glgb010 ELSE 0 END),  ",
               "          SUM(CASE WHEN glac008 = 1 THEN CASE WHEN glgb003 > 0 THEN glgb010 ELSE 0 END ELSE CASE WHEN glgb004 > 0 THEN glgb010 ELSE 0 END END) - ",
               "          SUM(CASE WHEN glac008 = 1 THEN CASE WHEN glgb004 > 0 THEN glgb010 ELSE 0 END ELSE CASE WHEN glgb003 > 0 THEN glgb010 ELSE 0 END END),  ",
               "          SUM(glgb003),                                                                              ",
               "          SUM(glgb004),                                                                              ",
               "          SUM(CASE WHEN glac008 = 1 THEN glgb003 ELSE glgb004 END) -                                                                             ",
               "          SUM(CASE WHEN glac008 = 1 THEN glgb004 ELSE glgb003 END),                                                                              ",
               "          glgbent                                                                                                                                ",
               "     FROM glgb_t,glga_t,glac_t,glaa_t                                                                                                            ",
               "    WHERE     glgadocdt BETWEEN '",g_master_m.bdate,"' AND '",g_master_m.edate,"' ",  
               "          AND glgald = glgbld                     AND glgadocno = glgbdocno                                                                      ",
               "          AND glga100 = glgb100                   AND glga101 = glgb101                                                                          ",
               "          AND glgaent = glgbent                   AND glgaent = '",g_enterprise,"'                                                               ",
               "          AND glgaent = glaaent                   AND glgaent = glacent                                                                          ",
               "          AND glgald = glaald                     AND glaa004 = glac001                                                                          ",
               "          AND ",ls_wc,
#               "          AND glac002 = glgb002                   AND glgald IN ",g_wc_xrcald CLIPPED , #160811-00039#3 mark
               "          AND glac002 = glgb002 ", #160811-00039#3 add
               "          AND ",l_ld_str,          #160811-00039#3 add
               " GROUP BY glgbcomp,glgbld,glga100,glgb021,2,glgadocdt,glga101,glgadocno,glga007,glgb002,glgb005,glgbent"         
   PREPARE aglq716_tmp02 FROM g_sql
   EXECUTE aglq716_tmp02 

END FUNCTION

################################################################################
# Descriptions...: 取得說明
# Memo...........:
# Usage..........: aglq716_get_desc(p_chr)
#                  RETURNING r_desc
# Input parameter: p_chr          類型編號
# Return code....: r_desc         類型說明
# Date & Author..: 2015/03/04 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq716_get_desc(p_chr)
   DEFINE p_chr         LIKE type_t.chr10

   DEFINE r_desc        LIKE type_t.chr100

   SELECT gzcbl004 INTO r_desc FROM gzcbl_t WHERE gzcbl001 = '9743' AND gzcbl002 = p_chr AND gzcbl003 = g_lang

   RETURN r_desc

END FUNCTION

################################################################################
# Descriptions...: 打印
# Memo...........:
# Usage..........: CALL aglq716_print()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq716_print()
   DEFINE l_i     LIKE type_t.num5
   
   IF g_glga_d.getLength() <= 0 THEN
      RETURN
   END IF
   
   #將單身資料插入臨時表
   DELETE FROM aglq716_xg_tmp;
   
   FOR l_i=1 TO g_glga_d.getLength()
      INSERT INTO aglq716_xg_tmp VALUES (
      l_i,g_enterprise,g_glga_d[l_i].glgacomp,g_glga_d[l_i].glgacomp_desc,g_glga_d[l_i].glgald,
      g_glga_d[l_i].glgald_desc,g_glga_d[l_i].glga100,g_glga_d[l_i].glgb021,g_glga_d[l_i].glgb021_desc,
      g_glga_d[l_i].style,g_glga_d[l_i].glgadocdt,g_glga_d[l_i].glga101,g_glga_d[l_i].xrca001,
      g_glga_d[l_i].glgadocno,g_glga_d[l_i].glga007,g_glga_d[l_i].glgb002,g_glga_d[l_i].glgb002_desc,
      g_glga_d[l_i].glgb005,g_glga_d[l_i].l_glgb003,g_glga_d[l_i].l_glgb0041,g_glga_d[l_i].l_glgb00411,
      g_glga_d[l_i].glgb003,g_glga_d[l_i].glgb004,g_glga_d[l_i].l_glgb004
      )
   END FOR
   IF g_master_m.check = 'Y' THEN
      #勾選顯示原幣
      CALL aglq716_x01('aglq716_xg_tmp',' 1=1')
   ELSE
      #未勾選顯示原幣，只打印本幣
      CALL aglq716_x02('aglq716_xg_tmp',' 1=1')
   END IF
END FUNCTION

 
{</section>}
 
