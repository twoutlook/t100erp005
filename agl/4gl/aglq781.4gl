#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq781.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2017-01-11 16:01:36), PR版次:0001(2017-01-17 17:29:09)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aglq781
#+ Description: 細項立衝歷史餘額查詢作業
#+ Creator....: 02599(2017-01-09 17:22:24)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="aglq781.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"

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
PRIVATE TYPE type_g_glax_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   glax002 LIKE glax_t.glax002, 
   glax002_desc LIKE type_t.chr500, 
   glaxdocdt LIKE glax_t.glaxdocdt, 
   glaxdocno LIKE glax_t.glaxdocno, 
   glaxseq LIKE glax_t.glaxseq, 
   glax005 LIKE glax_t.glax005, 
   glax006 LIKE glax_t.glax006, 
   glax022 LIKE glax_t.glax022, 
   glax022_desc LIKE type_t.chr500, 
   hsx LIKE type_t.chr500, 
   glax008 LIKE glax_t.glax008, 
   glax010 LIKE glax_t.glax010, 
   glax003 LIKE glax_t.glax003, 
   glax052 LIKE type_t.num20_6, 
   glax056 LIKE type_t.num20_6, 
   glax008c LIKE type_t.num20_6, 
   glax010c LIKE type_t.num20_6, 
   glax003c LIKE type_t.num20_6, 
   glax052c LIKE type_t.num20_6, 
   glax056c LIKE type_t.num20_6, 
   glax001 LIKE glax_t.glax001 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input         RECORD
       glaald          LIKE glaa_t.glaald,
       glaald_desc     LIKE glaal_t.glaal002,
       glaacomp        LIKE glaa_t.glaacomp,
       glaacomp_desc   LIKE ooefl_t.ooefl003,
       glaa001         LIKE glaa_t.glaa001,
       glaa016         LIKE glaa_t.glaa016,
       glaa020         LIKE glaa_t.glaa020,
       curr_o          LIKE type_t.chr1,  #顯示外幣
       show_num        LIKE type_t.chr1,  #顯示數量
       ctype           LIKE type_t.chr1,  #多本位幣
       edate           LIKE glax_t.glaxdocdt #立冲截止日期
       END RECORD
DEFINE g_glax049       LIKE glax_t.glax049
#多語言SQL
DEFINE g_get_sql       RECORD
       glax017         STRING,  #营运据点
       glax018         STRING,  #部门
       glax019         STRING,  #责任中心
       glax020         STRING,  #区域
       glax021         STRING,  #收付款客商
       glax022         STRING,  #账款客商
       glax023         STRING,  #客群
       glax024         STRING,  #产品类别
       glax025         STRING,  #人员
       glax027         STRING,  #专案编号
       glax028         STRING,  #WBS
       glax061         STRING,  #经营方式
       glax062         STRING,  #渠道
       glax063         STRING   #品牌  
                       END RECORD 
DEFINE g_bookno        LIKE glaa_t.glaald
DEFINE g_glaa004       LIKE glaa_t.glaa004
DEFINE g_glaa015       LIKE glaa_t.glaa015
DEFINE g_glaa019       LIKE glaa_t.glaa019
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glax_d
DEFINE g_master_t                   type_g_glax_d
DEFINE g_glax_d          DYNAMIC ARRAY OF type_g_glax_d
DEFINE g_glax_d_t        type_g_glax_d
 
      
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
 
{<section id="aglq781.main" >}
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
   DECLARE aglq781_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq781_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq781_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq781 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq781_init()   
 
      #進入選單 Menu (="N")
      CALL aglq781_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq781
      
   END IF 
   
   CLOSE aglq781_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE aglq781_tmp01
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq781.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq781_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_pass            LIKE type_t.num5
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('glax061','6013')
   #获取账别
   IF cl_null(g_input.glaald) THEN
      CALL s_ld_bookno()  RETURNING l_success,g_input.glaald
      IF l_success = FALSE THEN
         RETURN 
      END IF 
      CALL s_ld_chk_authorization(g_user,g_input.glaald) RETURNING l_pass
      IF l_pass = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00164'
         LET g_errparam.extend = g_input.glaald
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
   END IF
   CALL aglq781_glaald_desc(g_input.glaald)
   
   #营运据点
   CALL s_fin_get_department_sql('ta3','glaxent','glax017') RETURNING g_get_sql.glax017
   #部門
   CALL s_fin_get_department_sql('ta4','glaxent','glax018') RETURNING g_get_sql.glax018
   #利润成本中心
   CALL s_fin_get_department_sql('ta5','glaxent','glax019') RETURNING g_get_sql.glax019
   #区域
   CALL s_fin_get_acc_sql('ta6','glaxent','287','glax020') RETURNING g_get_sql.glax020
   #收付款客商
   CALL s_fin_get_trading_partner_abbr_sql('ta7','glaxent','glax021') RETURNING g_get_sql.glax021
   #账款客商
   CALL s_fin_get_trading_partner_abbr_sql('ta8','glaxent','glax022') RETURNING g_get_sql.glax022
   #客群
   CALL s_fin_get_acc_sql('ta9','glaxent','281','glax023') RETURNING g_get_sql.glax023
   #产品类别
   CALL s_fin_get_rtaxl003_sql('ta10','glaxent','glax024') RETURNING g_get_sql.glax024
   #人员
   CALL s_fin_get_person_sql('ta11','glaxent','glax025') RETURNING g_get_sql.glax025
   #专案
   CALL s_fin_get_project_sql('ta12','glaxent','glax027') RETURNING g_get_sql.glax027
   #WBS
   CALL s_fin_get_wbs_sql('ta13','glaxent','glax027','glax028') RETURNING g_get_sql.glax028
   #经营方式
   LET g_get_sql.glax061 = "(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='6013' AND gzcbl002=glax061 AND gzcbl003='"||g_dlang||"')"
   #渠道
   CALL s_fin_get_oojdl003_sql('ta14','glaxent','glax062') RETURNING g_get_sql.glax062
   #品牌
   CALL s_fin_get_acc_sql('ta15','glaxent','2002','glax063') RETURNING g_get_sql.glax063
   
   CALL aglq781_create_print_tmp() #列印报表临时表
   #end add-point
 
   CALL aglq781_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aglq781.default_search" >}
PRIVATE FUNCTION aglq781_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glaxld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " glaxdocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " glaxseq = '", g_argv[03], "' AND "
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
 
{<section id="aglq781.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq781_ui_dialog()
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
   CALL cl_set_act_visible("filter", FALSE)
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL aglq781_b_fill()
   ELSE
      CALL aglq781_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glax_d.clear()
 
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
 
         CALL aglq781_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glax_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq781_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq781_detail_action_trans()
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
            CALL aglq781_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            CALL cl_set_act_visible("filter", FALSE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aglq781_output()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aglq781_output()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglq781_query()
               #add-point:ON ACTION query name="menu.query"
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION exchange_ld
            LET g_action_choice="exchange_ld"
            IF cl_auth_chk_act("exchange_ld") THEN
               
               #add-point:ON ACTION exchange_ld name="menu.exchange_ld"
               CALL aglt310_01(g_input.glaald) RETURNING g_bookno
               IF g_input.glaald <> g_bookno THEN
                  CLEAR FORM
                  CALL g_glax_d.clear()
               END IF
               LET g_input.glaald = g_bookno
               #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
               CALL aglq781_glaald_desc(g_input.glaald)
               DISPLAY g_input.glaald,g_input.glaald_desc,g_input.glaacomp,g_input.glaacomp_desc,g_input.glaa001,
                       g_input.glaa016,g_input.glaa020,g_input.curr_o,g_input.show_num,g_input.ctype,g_input.edate
                    TO glaald,glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020,
                       curr_o,show_num,ctype,edate
                IF cl_null(g_wc) THEN
                   LET g_wc = '1=1'
                END IF 
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aglq781_filter()
            #add-point:ON ACTION filter name="menu.filter"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
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
            CALL aglq781_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glax_d)
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
            CALL aglq781_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq781_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq781_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq781_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glax_d.getLength()
               LET g_glax_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glax_d.getLength()
               LET g_glax_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glax_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glax_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glax_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glax_d[li_idx].sel = "N"
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
 
{<section id="aglq781.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq781_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   LET g_glax049 = 0
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glax_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON glax022
           FROM s_detail1[1].b_glax022
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_glax002>>----
         #----<<glax002_desc>>----
         #----<<b_glaxdocdt>>----
         #----<<b_glaxdocno>>----
         #----<<b_glaxseq>>----
         #----<<b_glax005>>----
         #----<<b_glax006>>----
         #----<<b_glax022>>----
         #Ctrlp:construct.c.page1.b_glax022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glax022
            #add-point:ON ACTION controlp INFIELD b_glax022 name="construct.c.page1.b_glax022"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glax022  #顯示到畫面上
            NEXT FIELD b_glax022                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glax022
            #add-point:BEFORE FIELD b_glax022 name="construct.b.page1.b_glax022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glax022
            
            #add-point:AFTER FIELD b_glax022 name="construct.a.page1.b_glax022"
            
            #END add-point
            
 
 
         #----<<glax022_desc>>----
         #----<<hsx>>----
         #----<<b_glax008>>----
         #----<<b_glax010>>----
         #----<<b_glax003>>----
         #----<<glax052>>----
         #----<<glax056>>----
         #----<<glax008c>>----
         #----<<glax010c>>----
         #----<<glax003c>>----
         #----<<glax052c>>----
         #----<<glax056c>>----
         #----<<b_glax001>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_input.curr_o,g_input.show_num,g_input.ctype,g_input.edate
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
         
         ON CHANGE curr_o 
            IF g_input.curr_o MATCHES '[yYnN]' THEN
               IF g_input.curr_o='Y' THEN
                  CALL cl_set_comp_visible('b_glax010,glax010c',TRUE)
               ELSE
                  CALL cl_set_comp_visible('b_glax010,glax010c',FALSE)
               END IF                  
            ELSE
               NEXT FIELD curr_o
            END IF
         
         ON CHANGE show_num 
            IF g_input.show_num MATCHES '[yYnN]' THEN
               IF g_input.show_num='Y' THEN
                  CALL cl_set_comp_visible('b_glax008,glax008c',TRUE)
               ELSE
                  CALL cl_set_comp_visible('b_glax008,glax008c',TRUE)
               END IF                  
            ELSE
               NEXT FIELD show_num
            END IF
            
         ON CHANGE ctype
            IF g_input.ctype MATCHES '[0123]' THEN
               CALL aglq781_set_curr_show()
            ELSE
               NEXT FIELD ctype
            END IF
            
         AFTER FIELD edate
            IF NOT cl_null(g_input.edate) THEN
               IF NOT cl_null(g_glax049) THEN
                  IF YEAR(g_input.edate) < g_glax049 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = 'agl-00539'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD edate
                  END IF
               END IF
            END IF
      END INPUT
      
      #科目+核算项查询条件
      CONSTRUCT BY NAME g_wc2 ON glax049,glax002,glaxdocno,glaxseq,glaxdocdt,glax017,glax018,glax019,
                                glax020,glax021,glax022,glax023,glax024,glax025,glax027,glax028,
                                glax061,glax062,glax063

         BEFORE CONSTRUCT
            
         AFTER FIELD glax049
             CALL FGL_DIALOG_GETBUFFER() RETURNING g_glax049
             
         ON ACTION controlp INFIELD glax002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_input.glaald,"'",
                                   "                    AND glad003='Y' AND gladstus='Y' )"
            CALL aglt310_04()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax002  #顯示到畫面上
            NEXT FIELD glax002                     #返回原欄位
            
         ON ACTION controlp INFIELD glaxdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glaxld = '",g_input.glaald,"'"
            CALL q_glaxdocno()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaxdocno  #顯示到畫面上
            NEXT FIELD glaxdocno                     #返回原欄位

         ON ACTION controlp INFIELD glax017
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef201 = 'Y' "   
            CALL q_ooef001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax017  #顯示到畫面上
            NEXT FIELD glax017                     #返回原欄位

         ON ACTION controlp INFIELD glax018
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y'"
            CALL q_ooeg001_4()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax018  #顯示到畫面上
            NEXT FIELD glax018                     #返回原欄位


         ON ACTION controlp INFIELD glax019
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax019  #顯示到畫面上
            NEXT FIELD glax019                     #返回原欄位

         ON ACTION controlp INFIELD glax020
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax020  #顯示到畫面上
            NEXT FIELD glax020                     #返回原欄位

         ON ACTION controlp INFIELD glax021
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()     
            DISPLAY g_qryparam.return1 TO glax021  #顯示到畫面上
            NEXT FIELD glax021                     #返回原欄位

         ON ACTION controlp INFIELD glax022
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()       
            DISPLAY g_qryparam.return1 TO glax022  #顯示到畫面上
            NEXT FIELD glax022                     #返回原欄位

         ON ACTION controlp INFIELD glax023
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax023  #顯示到畫面上
            NEXT FIELD glax023                     #返回原欄位

         ON ACTION controlp INFIELD glax024
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax024  #顯示到畫面上
            NEXT FIELD glax024                     #返回原欄位

         ON ACTION controlp INFIELD glax025
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax025  #顯示到畫面上
            NEXT FIELD glax025       
         
         #专案
          ON ACTION controlp INFIELD glax027
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax027     #顯示到畫面上
            NEXT FIELD glax027
            
          #WBS
          ON ACTION controlp INFIELD glax028
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = "pjbb012='1' "
            CALL q_pjbb002()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax028     #顯示到畫面上
            NEXT FIELD glax028
         
         #渠道
         ON ACTION controlp INFIELD glax062
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oojdstus='Y' "
            CALL q_oojd001_2()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax062  #顯示到畫面上
            NEXT FIELD glax062                     #返回原欄位
            
         #品牌
         ON ACTION controlp INFIELD glax063
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax063  #顯示到畫面上
            NEXT FIELD glax063                     #返回原欄位
      END CONSTRUCT

      BEFORE DIALOG
        #預設
        DISPLAY g_input.glaald,g_input.glaald_desc,g_input.glaacomp,g_input.glaacomp_desc,g_input.glaa001,
                g_input.glaa016,g_input.glaa020,g_input.curr_o,g_input.show_num,g_input.ctype,g_input.edate
             TO glaald,glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020,
                curr_o,show_num,ctype,edate
         IF cl_null(g_glax049) OR g_glax049=0 THEN
            LET g_glax049 = YEAR(g_today)
         END IF
         DISPLAY g_glax049 TO glax049
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
   CALL aglq781_b_fill()
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
 
{<section id="aglq781.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq781_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sdate         LIKE type_t.dat
   DEFINE l_sql_glax002_desc STRING
   DEFINE l_glax017       LIKE glax_t.glax017
   DEFINE l_glax017_desc  LIKE type_t.chr500
   DEFINE l_glax018       LIKE glax_t.glax018
   DEFINE l_glax018_desc  LIKE type_t.chr500
   DEFINE l_glax019       LIKE glax_t.glax019
   DEFINE l_glax019_desc  LIKE type_t.chr500
   DEFINE l_glax020       LIKE glax_t.glax020
   DEFINE l_glax020_desc  LIKE type_t.chr500
   DEFINE l_glax021       LIKE glax_t.glax021
   DEFINE l_glax021_desc  LIKE type_t.chr500
   DEFINE l_glax023       LIKE glax_t.glax023
   DEFINE l_glax023_desc  LIKE type_t.chr500
   DEFINE l_glax024       LIKE glax_t.glax024
   DEFINE l_glax024_desc  LIKE type_t.chr500
   DEFINE l_glax025       LIKE glax_t.glax025
   DEFINE l_glax025_desc  LIKE type_t.chr500
   DEFINE l_glax027       LIKE glax_t.glax027
   DEFINE l_glax027_desc  LIKE type_t.chr500
   DEFINE l_glax028       LIKE glax_t.glax028
   DEFINE l_glax028_desc  LIKE type_t.chr500
   DEFINE l_glax061       LIKE glax_t.glax061
   DEFINE l_glax061_desc  LIKE type_t.chr500
   DEFINE l_glax062       LIKE glax_t.glax062
   DEFINE l_glax062_desc  LIKE type_t.chr500
   DEFINE l_glax063       LIKE glax_t.glax063
   DEFINE l_glax063_desc  LIKE type_t.chr500
   DEFINE l_hsx           STRING
   DEFINE l_hsx_desc      STRING
   DEFINE l_glay008       LIKE glay_t.glay008
   DEFINE l_glay010       LIKE glay_t.glay010
   DEFINE l_glay003       LIKE glay_t.glay003
   DEFINE l_glay052       LIKE glay_t.glay052
   DEFINE l_glay054       LIKE glay_t.glay054
   DEFINE l_wc            STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET l_wc=''
   IF NOT cl_null(g_glax049) AND g_glax049 <> 0 THEN
      LET l_sdate=MDY(1,1,g_glax049)
      LET l_wc=" glaxdocdt >='",l_sdate,"' "
   END IF
   IF cl_null(l_wc) THEN
      LET l_wc = " glaxdocdt <='",g_input.edate,"' "
   ELSE
      LET l_wc = l_wc," AND glaxdocdt <='",g_input.edate,"' "
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = l_wc
   ELSE
      LET g_wc2 = g_wc2," AND ",l_wc
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',glax002,'',glaxdocdt,glaxdocno,glaxseq,glax005,glax006,glax022, 
       '','',glax008,glax010,glax003,'','','','','','','',glax001  ,DENSE_RANK() OVER( ORDER BY glax_t.glaxld, 
       glax_t.glaxdocno,glax_t.glaxseq) AS RANK FROM glax_t",
 
 
                     "",
                     " WHERE glaxent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glax_t"),
                     " ORDER BY glax_t.glaxld,glax_t.glaxdocno,glax_t.glaxseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_sql_rank = "SELECT UNIQUE glaxent,glax002,glaxdocdt,glaxdocno,glaxseq,glax005,glax006,glax022,", 
                     "       glax017,glax018,glax019,glax020,glax021,glax023,glax024,",
                     "       glax061,glax062,glax063,glax025,glax027,glax028,",
                     "       glax008,glax010,glax003,glax052,glax056,",
                     "       glax008-glax044 glax008c,glax010-glax046 glax010c,glax003-glax042 glax003c,",
                     "       glax052-glax054 glax052c,glax056-glax058 glax056c,glax001,",
                     "       DENSE_RANK() OVER( ORDER BY glax_t.glaxld,glax_t.glaxdocno,glax_t.glaxseq) AS RANK ",
                     "  FROM glax_t",
                     " WHERE glaxent= ? AND 1=1 AND ", ls_wc,
                     "   AND glaxld='",g_input.glaald,"'",
                     "   AND glaxstus='Y' "
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glax_t"),
                     " ORDER BY glax002,glaxdocdt,glaxdocno,glaxseq"
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
 
   LET g_sql = "SELECT '',glax002,'',glaxdocdt,glaxdocno,glaxseq,glax005,glax006,glax022,'','',glax008, 
       glax010,glax003,'','','','','','','',glax001",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #科目说明
   LET l_sql_glax002_desc = "(SELECT glacl004 FROM glacl_t WHERE glaclent=",g_enterprise," AND glacl001='",g_glaa004,"' AND glacl002=glax002 AND glacl003='"||g_dlang||"')"
   
   LET g_sql = "SELECT UNIQUE 'N',glax002,",l_sql_glax002_desc,",glaxdocdt,glaxdocno,glaxseq,glax005,glax006,", 
               "       glax022,",g_get_sql.glax022,",glax017,",g_get_sql.glax017,",glax018,",g_get_sql.glax018,",",
               "       glax019,",g_get_sql.glax019,",glax020,",g_get_sql.glax020,",glax021,",g_get_sql.glax021,",",
               "       glax023,",g_get_sql.glax023,",glax024,",g_get_sql.glax024,",glax061,",g_get_sql.glax061,",",
               "       glax062,",g_get_sql.glax062,",glax063,",g_get_sql.glax063,",glax025,",g_get_sql.glax025,",",
               "       glax027,",g_get_sql.glax027,",glax028,",g_get_sql.glax028,",",
               "       glax008,glax010,glax003,glax052,glax056,",
               "       glax008c,glax010c,glax003c,",
               "       glax052c,glax056c,glax001 ",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq781_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq781_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glax_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   #重新单身填充
   IF 1=2 THEN
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glax_d[l_ac].sel,g_glax_d[l_ac].glax002,g_glax_d[l_ac].glax002_desc,g_glax_d[l_ac].glaxdocdt, 
       g_glax_d[l_ac].glaxdocno,g_glax_d[l_ac].glaxseq,g_glax_d[l_ac].glax005,g_glax_d[l_ac].glax006, 
       g_glax_d[l_ac].glax022,g_glax_d[l_ac].glax022_desc,g_glax_d[l_ac].hsx,g_glax_d[l_ac].glax008, 
       g_glax_d[l_ac].glax010,g_glax_d[l_ac].glax003,g_glax_d[l_ac].glax052,g_glax_d[l_ac].glax056,g_glax_d[l_ac].glax008c, 
       g_glax_d[l_ac].glax010c,g_glax_d[l_ac].glax003c,g_glax_d[l_ac].glax052c,g_glax_d[l_ac].glax056c, 
       g_glax_d[l_ac].glax001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_glax_d[l_ac].statepic = cl_get_actipic(g_glax_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aglq781_detail_show("'1'")      
 
      CALL aglq781_glax_t_mask()
 
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
   
 
   
   CALL g_glax_d.deleteElement(g_glax_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   END IF
   
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glax_d[l_ac].sel,g_glax_d[l_ac].glax002,g_glax_d[l_ac].glax002_desc,g_glax_d[l_ac].glaxdocdt, 
       g_glax_d[l_ac].glaxdocno,g_glax_d[l_ac].glaxseq,g_glax_d[l_ac].glax005,g_glax_d[l_ac].glax006, 
       g_glax_d[l_ac].glax022,g_glax_d[l_ac].glax022_desc,
       l_glax017,l_glax017_desc,l_glax018,l_glax018_desc,l_glax019,l_glax019_desc,l_glax020,l_glax020_desc,
       l_glax021,l_glax021_desc,l_glax023,l_glax023_desc,l_glax024,l_glax024_desc,l_glax061,l_glax061_desc,
       l_glax062,l_glax062_desc,l_glax063,l_glax063_desc,l_glax025,l_glax025_desc,l_glax027,l_glax027_desc,
       l_glax028,l_glax028_desc,
       g_glax_d[l_ac].glax008,g_glax_d[l_ac].glax010,g_glax_d[l_ac].glax003,g_glax_d[l_ac].glax052,g_glax_d[l_ac].glax056, 
       g_glax_d[l_ac].glax008c,g_glax_d[l_ac].glax010c,g_glax_d[l_ac].glax003c,g_glax_d[l_ac].glax052c,g_glax_d[l_ac].glax056c, 
       g_glax_d[l_ac].glax001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      #账款客户
      LET g_glax_d[l_ac].glax022_desc=g_glax_d[l_ac].glax022," ",g_glax_d[l_ac].glax022_desc
      
      LET l_hsx=''
      LET l_hsx_desc=''
      #营运据点
      IF NOT cl_null(l_glax017) THEN
         LET l_hsx=l_glax017
         LET l_hsx_desc=l_glax017_desc
      END IF
      #部门
      IF NOT cl_null(l_glax018) THEN
         IF NOT cl_null(l_hsx) THEN
            LET l_hsx=l_hsx,"-",l_glax018
            LET l_hsx_desc=l_hsx_desc,"-",l_glax018_desc
         ELSE
            LET l_hsx=l_glax018
            LET l_hsx_desc=l_glax018_desc
         END IF
      END IF
      #利润/成本中心
      IF NOT cl_null(l_glax019) THEN
         IF NOT cl_null(l_hsx) THEN
            LET l_hsx=l_hsx,"-",l_glax019
            LET l_hsx_desc=l_hsx_desc,"-",l_glax019_desc
         ELSE
            LET l_hsx=l_glax019
            LET l_hsx_desc=l_glax019_desc
         END IF
      END IF
      #区域
      IF NOT cl_null(l_glax020) THEN
         IF NOT cl_null(l_hsx) THEN
            LET l_hsx=l_hsx,"-",l_glax020
            LET l_hsx_desc=l_hsx_desc,"-",l_glax020_desc
         ELSE
            LET l_hsx=l_glax020
            LET l_hsx_desc=l_glax020_desc
         END IF
      END IF
      #收付款客商
      IF NOT cl_null(l_glax021) THEN
         IF NOT cl_null(l_hsx) THEN
            LET l_hsx=l_hsx,"-",l_glax021
            LET l_hsx_desc=l_hsx_desc,"-",l_glax021_desc
         ELSE
            LET l_hsx=l_glax021
            LET l_hsx_desc=l_glax021_desc
         END IF
      END IF
      #客群
      IF NOT cl_null(l_glax023) THEN
         IF NOT cl_null(l_hsx) THEN
            LET l_hsx=l_hsx,"-",l_glax023
            LET l_hsx_desc=l_hsx_desc,"-",l_glax023_desc
         ELSE
            LET l_hsx=l_glax023
            LET l_hsx_desc=l_glax023_desc
         END IF
      END IF
      #产品类别
      IF NOT cl_null(l_glax024) THEN
         IF NOT cl_null(l_hsx) THEN
            LET l_hsx=l_hsx,"-",l_glax024
            LET l_hsx_desc=l_hsx_desc,"-",l_glax024_desc
         ELSE
            LET l_hsx=l_glax024
            LET l_hsx_desc=l_glax024_desc
         END IF
      END IF
      #经营方式
      IF NOT cl_null(l_glax061) THEN
         IF NOT cl_null(l_hsx) THEN
            LET l_hsx=l_hsx,"-",l_glax061
            LET l_hsx_desc=l_hsx_desc,"-",l_glax061_desc
         ELSE
            LET l_hsx=l_glax061
            LET l_hsx_desc=l_glax061_desc
         END IF
      END IF
      #渠道
      IF NOT cl_null(l_glax062) THEN
         IF NOT cl_null(l_hsx) THEN
            LET l_hsx=l_hsx,"-",l_glax062
            LET l_hsx_desc=l_hsx_desc,"-",l_glax062_desc
         ELSE
            LET l_hsx=l_glax062
            LET l_hsx_desc=l_glax062_desc
         END IF
      END IF
      #品牌
      IF NOT cl_null(l_glax063) THEN
         IF NOT cl_null(l_hsx) THEN
            LET l_hsx=l_hsx,"-",l_glax063
            LET l_hsx_desc=l_hsx_desc,"-",l_glax063_desc
         ELSE
            LET l_hsx=l_glax063
            LET l_hsx_desc=l_glax063_desc
         END IF
      END IF
      #人员
      IF NOT cl_null(l_glax025) THEN
         IF NOT cl_null(l_hsx) THEN
            LET l_hsx=l_hsx,"-",l_glax025
            LET l_hsx_desc=l_hsx_desc,"-",l_glax025_desc
         ELSE
            LET l_hsx=l_glax025
            LET l_hsx_desc=l_glax025_desc
         END IF
      END IF
      #专案
      IF NOT cl_null(l_glax027) THEN
         IF NOT cl_null(l_hsx) THEN
            LET l_hsx=l_hsx,"-",l_glax027
            LET l_hsx_desc=l_hsx_desc,"-",l_glax027_desc
         ELSE
            LET l_hsx=l_glax027
            LET l_hsx_desc=l_glax027_desc
         END IF
      END IF
      #WBS
      IF NOT cl_null(l_glax028) THEN
         IF NOT cl_null(l_hsx) THEN
            LET l_hsx=l_hsx,"-",l_glax028
            LET l_hsx_desc=l_hsx_desc,"-",l_glax028_desc
         ELSE
            LET l_hsx=l_glax028
            LET l_hsx_desc=l_glax028_desc
         END IF
      END IF
      #立冲条件
      LET g_glax_d[l_ac].hsx=l_hsx,"\n",l_hsx_desc
      
      #将大于截止日期的冲账资料加回
      LET l_glay008 = 0
      LET l_glay010 = 0
      LET l_glay003 = 0
      LET l_glay052 = 0
      LET l_glay054 = 0
      SELECT SUM(glay008),SUM(glay010),SUM(glay003),SUM(glay052),SUM(glay054)
        INTO l_glay008,l_glay010,l_glay003,l_glay052,l_glay054
        FROM glay_t
       WHERE glayent=g_enterprise AND glayld=g_input.glaald
         AND glaystus='Y'
         AND glaydocdt>g_input.edate
         AND glay002=g_glax_d[l_ac].glax002
         AND glay041=g_glax_d[l_ac].glaxdocno
         AND glay042=g_glax_d[l_ac].glaxseq
      IF cl_null(l_glay008) THEN LET l_glay008 = 0 END IF
      IF cl_null(l_glay010) THEN LET l_glay010 = 0 END IF
      IF cl_null(l_glay003) THEN LET l_glay003 = 0 END IF
      IF cl_null(l_glay052) THEN LET l_glay052 = 0 END IF
      IF cl_null(l_glay054) THEN LET l_glay054 = 0 END IF
      LET g_glax_d[l_ac].glax008c = g_glax_d[l_ac].glax008c + l_glay008
      LET g_glax_d[l_ac].glax010c = g_glax_d[l_ac].glax010c + l_glay010
      LET g_glax_d[l_ac].glax003c = g_glax_d[l_ac].glax003c + l_glay003
      LET g_glax_d[l_ac].glax052c = g_glax_d[l_ac].glax052c + l_glay052
      LET g_glax_d[l_ac].glax056c = g_glax_d[l_ac].glax056c + l_glay054
      
      CALL aglq781_glax_t_mask()
 
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
   
 
   
   CALL g_glax_d.deleteElement(g_glax_d.getLength())   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_glax_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq781_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq781_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq781_detail_action_trans()
 
   IF g_glax_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq781_fetch()
   END IF
   
      CALL aglq781_filter_show('glax022','b_glax022')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq781.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq781_fetch()
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
 
{<section id="aglq781.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq781_detail_show(ps_page)
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
 
{<section id="aglq781.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq781_filter()
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
      CONSTRUCT g_wc_filter ON glax022
                          FROM s_detail1[1].b_glax022
 
         BEFORE CONSTRUCT
                     DISPLAY aglq781_filter_parser('glax022') TO s_detail1[1].b_glax022
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_glax002>>----
         #----<<glax002_desc>>----
         #----<<b_glaxdocdt>>----
         #----<<b_glaxdocno>>----
         #----<<b_glaxseq>>----
         #----<<b_glax005>>----
         #----<<b_glax006>>----
         #----<<b_glax022>>----
         #Ctrlp:construct.c.page1.b_glax022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glax022
            #add-point:ON ACTION controlp INFIELD b_glax022 name="construct.c.filter.page1.b_glax022"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glax022  #顯示到畫面上
            NEXT FIELD b_glax022                     #返回原欄位
    



            #END add-point
 
 
         #----<<glax022_desc>>----
         #----<<hsx>>----
         #----<<b_glax008>>----
         #----<<b_glax010>>----
         #----<<b_glax003>>----
         #----<<glax052>>----
         #----<<glax056>>----
         #----<<glax008c>>----
         #----<<glax010c>>----
         #----<<glax003c>>----
         #----<<glax052c>>----
         #----<<glax056c>>----
         #----<<b_glax001>>----
   
 
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
   
      CALL aglq781_filter_show('glax022','b_glax022')
 
    
   CALL aglq781_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq781.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq781_filter_parser(ps_field)
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
 
{<section id="aglq781.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq781_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq781_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq781.insert" >}
#+ insert
PRIVATE FUNCTION aglq781_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq781.modify" >}
#+ modify
PRIVATE FUNCTION aglq781_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq781.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq781_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq781.delete" >}
#+ delete
PRIVATE FUNCTION aglq781_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq781.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq781_detail_action_trans()
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
 
{<section id="aglq781.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq781_detail_index_setting()
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
            IF g_glax_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_glax_d.getLength() AND g_glax_d.getLength() > 0
            LET g_detail_idx = g_glax_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_glax_d.getLength() THEN
               LET g_detail_idx = g_glax_d.getLength()
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
 
{<section id="aglq781.mask_functions" >}
 &include "erp/agl/aglq781_mask.4gl"
 
{</section>}
 
{<section id="aglq781.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 獲取帳套相關資料
# Memo...........:
# Usage..........: CALL aglq781_glaald_desc(p_glaald)
# Input parameter: p_glaald   帳套
# Date & Author..: 2017/01/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq781_glaald_desc(p_glaald)
DEFINE  p_glaald    LIKE glaa_t.glaald
   
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glaald 
    CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_input.glaald_desc=g_rtn_fields[1]
    #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
   SELECT glaacomp,glaa001,glaa004,glaa015,glaa016,glaa019,glaa020
     INTO g_input.glaacomp,g_input.glaa001,g_glaa004,
          g_glaa015,g_input.glaa016,g_glaa019,g_input.glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glaald 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_input.glaacomp_desc= g_rtn_fields[1]
   
   #本位幣二
   IF g_glaa015='Y' THEN
      CALL cl_set_comp_visible("glaa016",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa016",FALSE)
   END IF
   #本位幣三
   IF g_glaa019='Y' THEN
      CALL cl_set_comp_visible("glaa020",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa020",FALSE)
   END IF   
   #多本位幣
   CALL cl_set_comp_entry("ctype",TRUE)
   CASE
      WHEN g_glaa015<>'Y' AND g_glaa019<>'Y' 
         CALL cl_set_comp_entry("ctype",FALSE)
         CALL cl_set_combo_scc_part('ctype','9921','0')
      WHEN g_glaa015='Y' AND g_glaa019<>'Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1')
      WHEN g_glaa015<>'Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,2')
      WHEN g_glaa015='Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1,2,3')
   END CASE
   LET g_input.ctype='0'
   CALL aglq781_set_curr_show() #顯示本位幣二、本位幣三
   LET g_input.curr_o='N'
   CALL cl_set_comp_visible('b_glax010,glax010c',FALSE)
   LET g_input.show_num='N'
   CALL cl_set_comp_visible('b_glax008,glax008c',FALSE)
   LET g_input.edate=g_today #立冲截止日期
END FUNCTION

################################################################################
# Descriptions...: 設置本位幣二、別你幣三顯示否
# Memo...........:
# Usage..........: CALL aglq781_set_curr_show()
# Date & Author..: 2017/01/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq781_set_curr_show()
   #顯示本位幣二
   IF g_input.ctype='1' THEN
      CALL cl_set_comp_visible("glax052,glax052c",TRUE)
   ELSE
      CALL cl_set_comp_visible("glax052,glax052c",FALSE)
   END IF
   #顯示本位幣三
   IF g_input.ctype='2' THEN
      CALL cl_set_comp_visible("glax056,glax056c",TRUE)
   ELSE
      CALL cl_set_comp_visible("glax056,glax056c",FALSE)
   END IF
   #全部
   IF g_input.ctype='3' THEN
      CALL cl_set_comp_visible("glax052,glax052c,glax056,glax056c",TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 建立打印临时表
# Memo...........:
# Usage..........: CALL aglq781_create_print_tmp()
# Input parameter: 
# Return code....: 
# Date & Author..: 2017/01/11 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq781_create_print_tmp()
   DROP TABLE aglq781_tmp01
   CREATE TEMP TABLE aglq781_tmp01(
   glaxent LIKE glax_t.glaxent,
   glaxld LIKE glax_t.glaxld,
   glax002 LIKE glax_t.glax002, 
   glax002_desc LIKE type_t.chr500, 
   glaxdocdt LIKE glax_t.glaxdocdt, 
   glaxdocno LIKE glax_t.glaxdocno, 
   glaxseq LIKE glax_t.glaxseq, 
   glax005 LIKE glax_t.glax005, 
   glax006 LIKE glax_t.glax006, 
   glax022 LIKE glax_t.glax022, 
   glax022_desc LIKE type_t.chr500, 
   hsx LIKE type_t.chr500, 
   glax008 LIKE glax_t.glax008, 
   glax010 LIKE glax_t.glax010, 
   glax003 LIKE glax_t.glax003, 
   glax052 LIKE type_t.num20_6, 
   glax056 LIKE type_t.num20_6, 
   glax008c LIKE type_t.num20_6, 
   glax010c LIKE type_t.num20_6, 
   glax003c LIKE type_t.num20_6, 
   glax052c LIKE type_t.num20_6, 
   glax056c LIKE type_t.num20_6, 
   glax001 LIKE glax_t.glax001 
   )
END FUNCTION

################################################################################
# Descriptions...: 打印
# Memo...........: 
# Usage..........: CALL aglq781_output()
# Input parameter: 
# Return code....:
# Date & Author..: 2017/01/11 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq781_output()
DEFINE l_i,l_count      LIKE type_t.num5
DEFINE l_xg_visible     STRING
   
   DELETE FROM aglq781_tmp01          
   LET l_count = g_glax_d.getLength()
   
   FOR l_i = 1 TO l_count
      INSERT INTO aglq781_tmp01
      VALUES(g_enterprise,g_input.glaald,g_glax_d[l_i].glax002,g_glax_d[l_i].glax002_desc,g_glax_d[l_i].glaxdocdt, 
             g_glax_d[l_i].glaxdocno,g_glax_d[l_i].glaxseq,g_glax_d[l_i].glax005,g_glax_d[l_i].glax006, 
             g_glax_d[l_i].glax022,g_glax_d[l_i].glax022_desc,g_glax_d[l_i].hsx,g_glax_d[l_i].glax008, 
             g_glax_d[l_i].glax010,g_glax_d[l_i].glax003,g_glax_d[l_i].glax052,g_glax_d[l_i].glax056,
             g_glax_d[l_ac].glax008c,g_glax_d[l_i].glax010c,g_glax_d[l_i].glax003c,g_glax_d[l_i].glax052c, 
             g_glax_d[l_i].glax056c,g_glax_d[l_i].glax001)
   END FOR
   #影藏栏位
   LET l_xg_visible = ''
   IF g_input.curr_o='N' THEN
      LET l_xg_visible="glax010|l_glax010c"
   END IF
   IF g_input.show_num='N' THEN
      LET l_xg_visible=l_xg_visible,"|glax008|l_glax008c"
   END IF
   CASE g_input.ctype
      WHEN '0'
         LET l_xg_visible=l_xg_visible,"|glax052|l_glax052c|glax056|l_glax056c"
      WHEN '1'
         LET l_xg_visible=l_xg_visible,"|glax056|l_glax056c"
      WHEN '2'
         LET l_xg_visible=l_xg_visible,"|glax052|l_glax052c"
   END CASE
   CALL aglq781_x01(' 1=1','aglq781_tmp01',l_xg_visible)
END FUNCTION

 
{</section>}
 
