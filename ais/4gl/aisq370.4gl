#該程式未解開Section, 採用最新樣板產出!
{<section id="aisq370.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2017-01-25 12:07:13), PR版次:0003(2017-01-25 12:16:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000004
#+ Filename...: aisq370
#+ Description: 應付發票清單查詢作業
#+ Creator....: 08732(2016-09-07 10:54:02)
#+ Modifier...: 08729 -SD/PR- 08729
 
{</section>}
 
{<section id="aisq370.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#161021-00002#1  2016/11/01  By 08732   補上發票類型以及稅別說明欄位
#170104-00053#1  2017/01/09  By 08729   加上isam036欄位，並將待抵單呈現成負數，將isam001改為開窗
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
PRIVATE TYPE type_g_isam_d RECORD
       #statepic       LIKE type_t.chr1,
       
       isamcomp LIKE isam_t.isamcomp, 
   isamcomp_desc LIKE type_t.chr500, 
   isamdocno LIKE isam_t.isamdocno, 
   isamseq LIKE isam_t.isamseq, 
   isam001 LIKE isam_t.isam001, 
   isam002 LIKE isam_t.isam002, 
   isam002_desc LIKE type_t.chr500, 
   isam011 LIKE isam_t.isam011, 
   isam009 LIKE isam_t.isam009, 
   isam010 LIKE isam_t.isam010, 
   isam008 LIKE isam_t.isam008, 
   isam008_desc LIKE type_t.chr500, 
   l_isam036 LIKE type_t.chr10, 
   isam036_desc LIKE type_t.chr500, 
   isam012 LIKE isam_t.isam012, 
   isam012_desc LIKE type_t.chr500, 
   isam0121 LIKE isam_t.isam0121, 
   isam013 LIKE isam_t.isam013, 
   isam014 LIKE isam_t.isam014, 
   isam015 LIKE isam_t.isam015, 
   isam023 LIKE isam_t.isam023, 
   isam024 LIKE isam_t.isam024, 
   isam025 LIKE isam_t.isam025, 
   isam026 LIKE isam_t.isam026, 
   isam027 LIKE isam_t.isam027, 
   isam028 LIKE isam_t.isam028, 
   isamownid LIKE isam_t.isamownid, 
   isamownid_desc LIKE type_t.chr500, 
   isamowndp LIKE isam_t.isamowndp, 
   isamowndp_desc LIKE type_t.chr6, 
   isamcrtid LIKE isam_t.isamcrtid, 
   isamcrtid_desc LIKE type_t.chr500, 
   isamcrtdp LIKE isam_t.isamcrtdp, 
   isamcrtdp_desc LIKE type_t.chr6, 
   isamcrtdt DATETIME YEAR TO SECOND, 
   isammodid LIKE isam_t.isammodid, 
   isammodid_desc LIKE type_t.chr500, 
   isammoddt DATETIME YEAR TO SECOND, 
   isamcnfid LIKE isam_t.isamcnfid, 
   isamcnfid_desc LIKE type_t.chr500, 
   isamcnfdt DATETIME YEAR TO SECOND 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
PRIVATE TYPE type_g_isam_m RECORD
       l_isamcomp        LIKE  isam_t.isamcomp, 
       l_isamcomp_desc   LIKE  type_t.chr500
       END RECORD

DEFINE g_isam_m          type_g_isam_m
DEFINE g_isam_m_o        type_g_isam_m 
DEFINE g_wc_cs_comp      STRING
DEFINE g_ctl_where       STRING    #交易對象控制組WHERE
DEFINE g_xg_visible      STRING     #XG欄位隱藏條件
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_isam_d
DEFINE g_master_t                   type_g_isam_d
DEFINE g_isam_d          DYNAMIC ARRAY OF type_g_isam_d
DEFINE g_isam_d_t        type_g_isam_d
 
      
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
 
{<section id="aisq370.main" >}
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
   CALL cl_ap_init("ais","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_fin_create_account_center_tmp()
   CALL s_control_get_supplier_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_ctl_where
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
   DECLARE aisq370_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aisq370_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aisq370_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisq370 WITH FORM cl_ap_formpath("ais",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aisq370_init()   
 
      #進入選單 Menu (="N")
      CALL aisq370_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aisq370
      
   END IF 
   
   CLOSE aisq370_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aisq370.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aisq370_init()
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
   CALL aisq370_qbe_clear()
   #CALL cl_set_combo_scc_part('b_isam001','24','aapt110,aapt300,aapt330,aapt331,aapt351,aapt352') #170104-00053#1 mark
   CALL cl_set_combo_scc('l_isam036','9716') #異動狀態 #170104-00053#1 add
   #end add-point
 
   CALL aisq370_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aisq370.default_search" >}
PRIVATE FUNCTION aisq370_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " isamdocno = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " isamseq = '", g_argv[02], "' AND "
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
 
{<section id="aisq370.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aisq370_ui_dialog()
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
   DEFINE l_glaald   LIKE glaa_t.glaald
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
   CALL aisq370_create_tmp()
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL aisq370_b_fill()
   ELSE
      CALL aisq370_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_isam_d.clear()
 
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
 
         CALL aisq370_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_isam_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aisq370_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aisq370_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_aisq370
            LET g_action_choice="prog_aisq370"
            IF cl_auth_chk_act("prog_aisq370") THEN
               
               #add-point:ON ACTION prog_aisq370 name="menu.detail_show.page1.prog_aisq370"
               IF NOT cl_null(g_detail_idx) OR g_detail_idx <> 0  THEN
                  IF cl_null(g_isam_d[g_detail_idx].isamdocno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code   = 'sub-00280'
                     LET g_errparam.extend = s_fin_get_colname(g_prog,'isamdocno')
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  END IF
                  
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = g_isam_d[g_detail_idx].isam001
                  CASE 
                     WHEN la_param.prog MATCHES 'aapt110' 
                        LET la_param.param[1] = g_isam_d[g_detail_idx].isamdocno
                        
                     WHEN la_param.prog MATCHES 'aapt3[04]0'
                        LET la_param.param[3] = g_isam_d[g_detail_idx].isamdocno
                        
                     WHEN la_param.prog MATCHES 'aapt3[123]0' 
                        LET la_param.param[2] = g_isam_d[g_detail_idx].isamdocno 
                     
                     WHEN la_param.prog MATCHES 'aapt3[35]1' 
                        LET la_param.param[2] = g_isam_d[g_detail_idx].isamdocno 
                        
                     WHEN la_param.prog MATCHES 'aapt3[04]1' 
                        LET la_param.param[2] = g_isam_d[g_detail_idx].isamdocno
                        
                     WHEN la_param.prog MATCHES 'aapt352' 
                        LET la_param.param[2] = g_isam_d[g_detail_idx].isamdocno 
                  
                  END CASE
                  
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aisq370_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
 
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aisq370_ins_x01_tmp()
               CALL aisq370_x01('1=1','aisq370_x01_tmp',g_xg_visible)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aisq370_ins_x01_tmp()
               CALL aisq370_x01('1=1','aisq370_x01_tmp',g_xg_visible)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aisq370_query()
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
            CALL aisq370_filter()
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
            CALL aisq370_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_isam_d)
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
            CALL aisq370_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aisq370_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aisq370_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aisq370_b_fill()
 
         
         
 
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
 
{<section id="aisq370.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aisq370_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_count    LIKE type_t.num5 
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_isam_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON isamcomp,isamdocno,isamseq,isam001,isam002,isam011,isam009,isam010,isam008, 
          isam012,isam0121,isam013,isam014,isam015,isam023,isam024,isam025,isam026,isam027,isam028,isamownid, 
          isamowndp,isamcrtid,isamcrtdp,isamcrtdt,isammodid,isammoddt,isamcnfid,isamcnfdt
           FROM s_detail1[1].b_isamcomp,s_detail1[1].b_isamdocno,s_detail1[1].b_isamseq,s_detail1[1].b_isam001, 
               s_detail1[1].b_isam002,s_detail1[1].b_isam011,s_detail1[1].b_isam009,s_detail1[1].b_isam010, 
               s_detail1[1].b_isam008,s_detail1[1].b_isam012,s_detail1[1].b_isam0121,s_detail1[1].b_isam013, 
               s_detail1[1].b_isam014,s_detail1[1].b_isam015,s_detail1[1].b_isam023,s_detail1[1].b_isam024, 
               s_detail1[1].b_isam025,s_detail1[1].b_isam026,s_detail1[1].b_isam027,s_detail1[1].b_isam028, 
               s_detail1[1].b_isamownid,s_detail1[1].b_isamowndp,s_detail1[1].b_isamcrtid,s_detail1[1].b_isamcrtdp, 
               s_detail1[1].b_isamcrtdt,s_detail1[1].b_isammodid,s_detail1[1].b_isammoddt,s_detail1[1].b_isamcnfid, 
               s_detail1[1].b_isamcnfdt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            CALL cl_qbe_init()
            LET g_isam_d[1].isamcomp = ''
            DISPLAY ARRAY g_isam_d TO s_detail1.*
               BEFORE DISPLAY
                  EXIT DISPLAY
            END DISPLAY
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<isamcrtdt>>----
         AFTER FIELD isamcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<isammoddt>>----
         AFTER FIELD isammoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<isamcnfdt>>----
         AFTER FIELD isamcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<isampstdt>>----
         #AFTER FIELD isampstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
         
       #單身一般欄位開窗相關處理
                #----<<b_isamcomp>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isamcomp
            #add-point:BEFORE FIELD b_isamcomp name="construct.b.page1.b_isamcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isamcomp
            
            #add-point:AFTER FIELD b_isamcomp name="construct.a.page1.b_isamcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isamcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamcomp
            #add-point:ON ACTION controlp INFIELD b_isamcomp name="construct.c.page1.b_isamcomp"
            
            #END add-point
 
 
         #----<<b_isamcomp_desc>>----
         #----<<b_isamdocno>>----
         #Ctrlp:construct.c.page1.b_isamdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamdocno
            #add-point:ON ACTION controlp INFIELD b_isamdocno name="construct.c.page1.b_isamdocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "apbbcomp = '",g_isam_m.l_isamcomp,"' "
            CALL q_isamdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isamdocno  #顯示到畫面上
            NEXT FIELD b_isamdocno                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isamdocno
            #add-point:BEFORE FIELD b_isamdocno name="construct.b.page1.b_isamdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isamdocno
            
            #add-point:AFTER FIELD b_isamdocno name="construct.a.page1.b_isamdocno"
            
            #END add-point
            
 
 
         #----<<b_isamseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isamseq
            #add-point:BEFORE FIELD b_isamseq name="construct.b.page1.b_isamseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isamseq
            
            #add-point:AFTER FIELD b_isamseq name="construct.a.page1.b_isamseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isamseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamseq
            #add-point:ON ACTION controlp INFIELD b_isamseq name="construct.c.page1.b_isamseq"
            
            #END add-point
 
 
         #----<<b_isam001>>----
         #Ctrlp:construct.c.page1.b_isam001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam001
            #add-point:ON ACTION controlp INFIELD b_isam001 name="construct.c.page1.b_isam001"
            #170104-00053#1-(s)
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isam001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isam001  #顯示到畫面上
            NEXT FIELD b_isam001                     #返回原欄位
            #170104-00053#1-add(e)



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam001
            #add-point:BEFORE FIELD b_isam001 name="construct.b.page1.b_isam001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam001
            
            #add-point:AFTER FIELD b_isam001 name="construct.a.page1.b_isam001"
            
            #END add-point
            
 
 
         #----<<b_isam002>>----
         #Ctrlp:construct.c.page1.b_isam002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam002
            #add-point:ON ACTION controlp INFIELD b_isam002 name="construct.c.page1.b_isam002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = g_ctl_where
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isam002  #顯示到畫面上
            NEXT FIELD b_isam002                     #返回原欄位
            

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam002
            #add-point:BEFORE FIELD b_isam002 name="construct.b.page1.b_isam002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam002
            
            #add-point:AFTER FIELD b_isam002 name="construct.a.page1.b_isam002"
            
            #END add-point
            
 
 
         #----<<b_isam002_desc>>----
         #----<<b_isam011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam011
            #add-point:BEFORE FIELD b_isam011 name="construct.b.page1.b_isam011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam011
            
            #add-point:AFTER FIELD b_isam011 name="construct.a.page1.b_isam011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isam011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam011
            #add-point:ON ACTION controlp INFIELD b_isam011 name="construct.c.page1.b_isam011"
            
            #END add-point
 
 
         #----<<b_isam009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam009
            #add-point:BEFORE FIELD b_isam009 name="construct.b.page1.b_isam009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam009
            
            #add-point:AFTER FIELD b_isam009 name="construct.a.page1.b_isam009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isam009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam009
            #add-point:ON ACTION controlp INFIELD b_isam009 name="construct.c.page1.b_isam009"
            
            #END add-point
 
 
         #----<<b_isam010>>----
         #Ctrlp:construct.c.page1.b_isam010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam010
            #add-point:ON ACTION controlp INFIELD b_isam010 name="construct.c.page1.b_isam010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isam010()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isam010  #顯示到畫面上
            NEXT FIELD b_isam010                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam010
            #add-point:BEFORE FIELD b_isam010 name="construct.b.page1.b_isam010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam010
            
            #add-point:AFTER FIELD b_isam010 name="construct.a.page1.b_isam010"
            
            #END add-point
            
 
 
         #----<<b_isam008>>----
         #Ctrlp:construct.c.page1.b_isam008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam008
            #add-point:ON ACTION controlp INFIELD b_isam008 name="construct.c.page1.b_isam008"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isac001 IN (SELECT ooef019 FROM ooef_t ",
                                   " WHERE ooefent = isacent AND ooef001 = '",g_isam_m.l_isamcomp,
                                                   "')"
            CALL q_isac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isam008  #顯示到畫面上
            NEXT FIELD b_isam008                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam008
            #add-point:BEFORE FIELD b_isam008 name="construct.b.page1.b_isam008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam008
            
            #add-point:AFTER FIELD b_isam008 name="construct.a.page1.b_isam008"
            
            #END add-point
            
 
 
         #----<<b_isam008_desc>>----
         #----<<l_isam036>>----
         #----<<b_isam036_desc>>----
         #----<<b_isam012>>----
         #Ctrlp:construct.c.page1.b_isam012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam012
            #add-point:ON ACTION controlp INFIELD b_isam012 name="construct.c.page1.b_isam012"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oodb001 IN (SELECT ooef019 FROM ooef_t ",
                                   " WHERE ooefent = oodbent AND ooef001 = '",g_isam_m.l_isamcomp,
                                                   "')"
            CALL q_oodb002_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isam012  #顯示到畫面上
            NEXT FIELD b_isam012                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam012
            #add-point:BEFORE FIELD b_isam012 name="construct.b.page1.b_isam012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam012
            
            #add-point:AFTER FIELD b_isam012 name="construct.a.page1.b_isam012"
            
            #END add-point
            
 
 
         #----<<b_isam012_desc>>----
         #----<<b_isam0121>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam0121
            #add-point:BEFORE FIELD b_isam0121 name="construct.b.page1.b_isam0121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam0121
            
            #add-point:AFTER FIELD b_isam0121 name="construct.a.page1.b_isam0121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isam0121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam0121
            #add-point:ON ACTION controlp INFIELD b_isam0121 name="construct.c.page1.b_isam0121"
            
            #END add-point
 
 
         #----<<b_isam013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam013
            #add-point:BEFORE FIELD b_isam013 name="construct.b.page1.b_isam013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam013
            
            #add-point:AFTER FIELD b_isam013 name="construct.a.page1.b_isam013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isam013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam013
            #add-point:ON ACTION controlp INFIELD b_isam013 name="construct.c.page1.b_isam013"
            
            #END add-point
 
 
         #----<<b_isam014>>----
         #Ctrlp:construct.c.page1.b_isam014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam014
            #add-point:ON ACTION controlp INFIELD b_isam014 name="construct.c.page1.b_isam014"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isam014  #顯示到畫面上
            NEXT FIELD b_isam014                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam014
            #add-point:BEFORE FIELD b_isam014 name="construct.b.page1.b_isam014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam014
            
            #add-point:AFTER FIELD b_isam014 name="construct.a.page1.b_isam014"
            
            #END add-point
            
 
 
         #----<<b_isam015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam015
            #add-point:BEFORE FIELD b_isam015 name="construct.b.page1.b_isam015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam015
            
            #add-point:AFTER FIELD b_isam015 name="construct.a.page1.b_isam015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isam015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam015
            #add-point:ON ACTION controlp INFIELD b_isam015 name="construct.c.page1.b_isam015"
            
            #END add-point
 
 
         #----<<b_isam023>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam023
            #add-point:BEFORE FIELD b_isam023 name="construct.b.page1.b_isam023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam023
            
            #add-point:AFTER FIELD b_isam023 name="construct.a.page1.b_isam023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isam023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam023
            #add-point:ON ACTION controlp INFIELD b_isam023 name="construct.c.page1.b_isam023"
            
            #END add-point
 
 
         #----<<b_isam024>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam024
            #add-point:BEFORE FIELD b_isam024 name="construct.b.page1.b_isam024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam024
            
            #add-point:AFTER FIELD b_isam024 name="construct.a.page1.b_isam024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isam024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam024
            #add-point:ON ACTION controlp INFIELD b_isam024 name="construct.c.page1.b_isam024"
            
            #END add-point
 
 
         #----<<b_isam025>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam025
            #add-point:BEFORE FIELD b_isam025 name="construct.b.page1.b_isam025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam025
            
            #add-point:AFTER FIELD b_isam025 name="construct.a.page1.b_isam025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isam025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam025
            #add-point:ON ACTION controlp INFIELD b_isam025 name="construct.c.page1.b_isam025"
            
            #END add-point
 
 
         #----<<b_isam026>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam026
            #add-point:BEFORE FIELD b_isam026 name="construct.b.page1.b_isam026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam026
            
            #add-point:AFTER FIELD b_isam026 name="construct.a.page1.b_isam026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isam026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam026
            #add-point:ON ACTION controlp INFIELD b_isam026 name="construct.c.page1.b_isam026"
            
            #END add-point
 
 
         #----<<b_isam027>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam027
            #add-point:BEFORE FIELD b_isam027 name="construct.b.page1.b_isam027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam027
            
            #add-point:AFTER FIELD b_isam027 name="construct.a.page1.b_isam027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isam027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam027
            #add-point:ON ACTION controlp INFIELD b_isam027 name="construct.c.page1.b_isam027"
            
            #END add-point
 
 
         #----<<b_isam028>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam028
            #add-point:BEFORE FIELD b_isam028 name="construct.b.page1.b_isam028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam028
            
            #add-point:AFTER FIELD b_isam028 name="construct.a.page1.b_isam028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isam028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam028
            #add-point:ON ACTION controlp INFIELD b_isam028 name="construct.c.page1.b_isam028"
            
            #END add-point
 
 
         #----<<b_isamownid>>----
         #Ctrlp:construct.c.page1.b_isamownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamownid
            #add-point:ON ACTION controlp INFIELD b_isamownid name="construct.c.page1.b_isamownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isamownid  #顯示到畫面上
            NEXT FIELD b_isamownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isamownid
            #add-point:BEFORE FIELD b_isamownid name="construct.b.page1.b_isamownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isamownid
            
            #add-point:AFTER FIELD b_isamownid name="construct.a.page1.b_isamownid"
            
            #END add-point
            
 
 
         #----<<b_isamownid_desc>>----
         #----<<b_isamowndp>>----
         #Ctrlp:construct.c.page1.b_isamowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamowndp
            #add-point:ON ACTION controlp INFIELD b_isamowndp name="construct.c.page1.b_isamowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isamowndp  #顯示到畫面上
            NEXT FIELD b_isamowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isamowndp
            #add-point:BEFORE FIELD b_isamowndp name="construct.b.page1.b_isamowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isamowndp
            
            #add-point:AFTER FIELD b_isamowndp name="construct.a.page1.b_isamowndp"
            
            #END add-point
            
 
 
         #----<<b_isamowndp_desc>>----
         #----<<b_isamcrtid>>----
         #Ctrlp:construct.c.page1.b_isamcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamcrtid
            #add-point:ON ACTION controlp INFIELD b_isamcrtid name="construct.c.page1.b_isamcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isamcrtid  #顯示到畫面上
            NEXT FIELD b_isamcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isamcrtid
            #add-point:BEFORE FIELD b_isamcrtid name="construct.b.page1.b_isamcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isamcrtid
            
            #add-point:AFTER FIELD b_isamcrtid name="construct.a.page1.b_isamcrtid"
            
            #END add-point
            
 
 
         #----<<b_isamcrtid_desc>>----
         #----<<b_isamcrtdp>>----
         #Ctrlp:construct.c.page1.b_isamcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamcrtdp
            #add-point:ON ACTION controlp INFIELD b_isamcrtdp name="construct.c.page1.b_isamcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isamcrtdp  #顯示到畫面上
            NEXT FIELD b_isamcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isamcrtdp
            #add-point:BEFORE FIELD b_isamcrtdp name="construct.b.page1.b_isamcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isamcrtdp
            
            #add-point:AFTER FIELD b_isamcrtdp name="construct.a.page1.b_isamcrtdp"
            
            #END add-point
            
 
 
         #----<<b_isamcrtdp_desc>>----
         #----<<b_isamcrtdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isamcrtdt
            #add-point:BEFORE FIELD b_isamcrtdt name="construct.b.page1.b_isamcrtdt"
            
            #END add-point
 
 
         #----<<b_isammodid>>----
         #Ctrlp:construct.c.page1.b_isammodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isammodid
            #add-point:ON ACTION controlp INFIELD b_isammodid name="construct.c.page1.b_isammodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isammodid  #顯示到畫面上
            NEXT FIELD b_isammodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isammodid
            #add-point:BEFORE FIELD b_isammodid name="construct.b.page1.b_isammodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isammodid
            
            #add-point:AFTER FIELD b_isammodid name="construct.a.page1.b_isammodid"
            
            #END add-point
            
 
 
         #----<<b_isammodid_desc>>----
         #----<<b_isammoddt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isammoddt
            #add-point:BEFORE FIELD b_isammoddt name="construct.b.page1.b_isammoddt"
            
            #END add-point
 
 
         #----<<b_isamcnfid>>----
         #Ctrlp:construct.c.page1.b_isamcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamcnfid
            #add-point:ON ACTION controlp INFIELD b_isamcnfid name="construct.c.page1.b_isamcnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isamcnfid  #顯示到畫面上
            NEXT FIELD b_isamcnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isamcnfid
            #add-point:BEFORE FIELD b_isamcnfid name="construct.b.page1.b_isamcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isamcnfid
            
            #add-point:AFTER FIELD b_isamcnfid name="construct.a.page1.b_isamcnfid"
            
            #END add-point
            
 
 
         #----<<b_isamcnfid_desc>>----
         #----<<b_isamcnfdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isamcnfdt
            #add-point:BEFORE FIELD b_isamcnfdt name="construct.b.page1.b_isamcnfdt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_isam_m.l_isamcomp ATTRIBUTE (WITHOUT DEFAULTS)
      
         ON ACTION controlp INFIELD l_isamcomp
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y'" ,
                                   " AND ooef001 IN ",g_wc_cs_comp
            LET g_qryparam.default1 = g_isam_m.l_isamcomp
            CALL q_ooef001()
            LET g_isam_m.l_isamcomp = g_qryparam.return1
            DISPLAY g_isam_m.l_isamcomp TO l_isamcomp
            CALL s_desc_get_department_desc(g_isam_m.l_isamcomp) RETURNING g_isam_m.l_isamcomp_desc
            DISPLAY BY NAME g_isam_m.l_isamcomp_desc
            NEXT FIELD l_isamcomp
      
      
         AFTER FIELD l_isamcomp
           LET g_isam_m.l_isamcomp_desc = ''
           DISPLAY BY NAME g_isam_m.l_isamcomp_desc
           IF NOT cl_null(g_isam_m.l_isamcomp) THEN
               IF g_isam_m.l_isamcomp != g_isam_m_o.l_isamcomp OR cl_null(g_isam_m_o.l_isamcomp) THEN

                  CALL aisq370_isamcomp_chk(g_isam_m.l_isamcomp) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN                  
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isam_m.l_isamcomp = g_isam_m_o.l_isamcomp
                     LET g_isam_m.l_isamcomp_desc = g_isam_m_o.l_isamcomp_desc
                     DISPLAY BY NAME g_isam_m.l_isamcomp_desc
                     NEXT FIELD CURRENT
                  END IF
                 
                  LET l_count = NULL
                  SELECT count(1) INTO l_count 
                    FROM s_fin_tmp1
                   WHERE comp = g_isam_m.l_isamcomp
                     AND comp IN (SELECT ooef001 FROM s_fin_tmp1)
                     
                  IF cl_null(l_count) THEN LET l_count = 0 END IF
                     
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ais-00342'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isam_m.l_isamcomp = g_isam_m_o.l_isamcomp
                     LET g_isam_m.l_isamcomp_desc = g_isam_m_o.l_isamcomp_desc
                     DISPLAY BY NAME g_isam_m.l_isamcomp_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_isam_m.l_isamcomp) RETURNING g_isam_m.l_isamcomp_desc
            DISPLAY BY NAME g_isam_m.l_isamcomp_desc
            LET g_isam_m_o.* = g_isam_m.*
            
            CALL aisq370_set_visible()
            CALL aisq370_set_no_visible()
      
      END INPUT
      
      BEFORE DIALOG
      
         CALL aisq370_qbe_clear()

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
         CALL aisq370_qbe_clear()
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
   CALL aisq370_b_fill()
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
 
{<section id="aisq370.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aisq370_b_fill()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE isamcomp,'',isamdocno,isamseq,isam001,isam002,'',isam011,isam009, 
       isam010,isam008,'','','',isam012,'',isam0121,isam013,isam014,isam015,isam023,isam024,isam025, 
       isam026,isam027,isam028,isamownid,'',isamowndp,'',isamcrtid,'',isamcrtdp,'',isamcrtdt,isammodid, 
       '',isammoddt,isamcnfid,'',isamcnfdt  ,DENSE_RANK() OVER( ORDER BY isam_t.isamdocno,isam_t.isamseq) AS RANK FROM isam_t", 
 
 
 
                     "",
                     " WHERE isament= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("isam_t"),
                     " ORDER BY isam_t.isamdocno,isam_t.isamseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_wc = ls_wc CLIPPED," AND isamcomp = '",g_isam_m.l_isamcomp,"' "
   
   #161021-00002#1  mark---s
   #LET ls_sql_rank = "SELECT  UNIQUE isamcomp,'',isamdocno,isamseq,isam001,isam002,",
   #                  "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent = isament AND pmaal001 = isam002 AND pmaal002 = '"||g_dlang||"') isam002_desc,",
   #                  "isam011,isam009,", 
   #                  "isam010,isam008,isam012,",
   #                  "isam0121,isam013,isam014,isam015,isam023,isam024,isam025,isam026, ",
   #                  "isam027,isam028,isamownid,'',isamowndp,'',isamcrtid,'',isamcrtdp,'',isamcrtdt,isammodid,'',isammoddt, ",
   #                  "isamcnfid,'',isamcnfdt  ,DENSE_RANK() OVER( ORDER BY isam_t.isamdocno,isam_t.isamseq) AS RANK FROM isam_t", 
   #
   #
   #
   #                  "",
   #                  " WHERE isament= ? AND 1=1 AND ", ls_wc 
   #161021-00002#1  mark---e
   #161021-00002#1  add---s
   LET ls_sql_rank = "SELECT  UNIQUE isamcomp,'',isamdocno,isamseq,isam001,isam002,",
                     "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent = isament AND pmaal001 = isam002 AND pmaal002 = '"||g_dlang||"') isam002_desc,",
                     "isam011,isam009,", 
                     "isam010,isam008,",
                     "(SELECT isacl004 FROM isacl_t WHERE isaclent = isament AND isacl001 IN (SELECT ooef019 FROM ooef_t WHERE ooefent = isament AND ooef001 = isamcomp) AND isacl002 = isam008 AND isacl003 = '"||g_dlang||"') isam008_desc,",
                     #170104-00053#1-add(s)
                     "isam036, ",
                     "(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '9716' AND gzcbl002 = isam036 AND gzcbl003 = '"||g_dlang||"') isam036_desc,",
                     #170104-00053#1-add(e)
                     "isam012,",
                     "(SELECT oodbl004 FROM oodbl_t WHERE oodblent = isament AND oodbl001 IN (SELECT ooef019 FROM ooef_t WHERE ooefent = isament AND ooef001 = isamcomp) AND oodbl002 = isam012 AND oodbl003 = '"||g_dlang||"') isam012_desc,",
                     #170104-00053#1-mark(s)
                     #"isam0121,isam013,isam014,isam015,isam023,isam024,isam025,isam026, ",                                    
                     #"isam027,isam028,isamownid,'',isamowndp,'',isamcrtid,'',isamcrtdp,'',isamcrtdt,isammodid,'',isammoddt, ",   
                     #170104-00053#1-mark(e)
                     #170104-00053#1-add(s)
                     "isam0121,isam013,isam014,isam015, ",
                     "(CASE WHEN apbb050 = 2 and isam023 > 0 THEN isam023 * -1 ELSE isam023 end) isam023,",
                     "(CASE WHEN apbb050 = 2 and isam023 > 0 THEN isam024 * -1 ELSE isam024 end) isam024,",
                     "(CASE WHEN apbb050 = 2 and isam023 > 0 THEN isam025 * -1 ELSE isam025 end) isam025,",
                     "(CASE WHEN apbb050 = 2 and isam023 > 0 THEN isam026 * -1 ELSE isam026 end) isam026,",
                     "(CASE WHEN apbb050 = 2 and isam023 > 0 THEN isam027 * -1 ELSE isam027 end) isam027,",
                     "(CASE WHEN apbb050 = 2 and isam023 > 0 THEN isam028 * -1 ELSE isam028 end) isam028,",
                     #170104-00053#1-add(e)
                     "isamownid,'',isamowndp,'',isamcrtid,'',isamcrtdp,'',isamcrtdt,isammodid,'',isammoddt, ",
                     "isamcnfid,'',isamcnfdt  ,DENSE_RANK() OVER( ORDER BY isam_t.isamdocno,isam_t.isamseq) AS RANK FROM isam_t", 
                     " LEFT JOIN apbb_t ON apbbent = isament AND apbbdocno = isamdocno",    #170104-00053#1-add
 
 
                     "",
                     " WHERE isament= ? AND 1=1 AND ", ls_wc
   #161021-00002#1  add---e
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("isam_t"),
                     " ORDER BY isam_t.isamdocno,isam_t.isamseq"
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
 
   LET g_sql = "SELECT isamcomp,'',isamdocno,isamseq,isam001,isam002,'',isam011,isam009,isam010,isam008, 
       '','','',isam012,'',isam0121,isam013,isam014,isam015,isam023,isam024,isam025,isam026,isam027, 
       isam028,isamownid,'',isamowndp,'',isamcrtid,'',isamcrtdp,'',isamcrtdt,isammodid,'',isammoddt, 
       isamcnfid,'',isamcnfdt",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #161021-00002#1  mark---s 
   #LET g_sql = "SELECT isamcomp,'',isamdocno,isamseq,isam001,isam002,isam002_desc,isam011,isam009,isam010,isam008, 
   #    '',isam012,'',isam0121,isam013,isam014,isam015,isam023,isam024,isam025,isam026,isam027,isam028, 
   #    isamownid,'',isamowndp,'',isamcrtid,'',isamcrtdp,'',isamcrtdt,isammodid,'',isammoddt,isamcnfid, 
   #    '',isamcnfdt",
   #            " FROM (",ls_sql_rank,")",
   #           " WHERE RANK >= ",g_pagestart,
   #             " AND RANK < ",g_pagestart + g_num_in_page
   #161021-00002#1  mark---e
   
   #161021-00002#1  add---s 
   #170104-00053#1  mark(s)   
   #LET g_sql = "SELECT isamcomp,'',isamdocno,isamseq,isam001,isam002,isam002_desc,isam011,isam009,isam010,isam008, 
   #    isam008_desc,isam012,isam012_desc,isam0121,isam013,isam014,isam015,isam023,isam024,isam025,isam026,isam027,isam028, 
   #    isamownid,'',isamowndp,'',isamcrtid,'',isamcrtdp,'',isamcrtdt,isammodid,'',isammoddt,isamcnfid, 
   #    '',isamcnfdt",
   #170104-00053#1 mark(e)    
   #170104-00053#1-add(s)
   LET g_sql = "SELECT isamcomp,'',isamdocno,isamseq,isam001,isam002,isam002_desc,isam011,isam009,isam010,isam008, 
       isam008_desc,isam036,isam036_desc,isam012,isam012_desc,isam0121,isam013,isam014,isam015,isam023,isam024,isam025,isam026,isam027,isam028, 
       isamownid,'',isamowndp,'',isamcrtid,'',isamcrtdp,'',isamcrtdt,isammodid,'',isammoddt,isamcnfid, 
       '',isamcnfdt", 
   #170104-00053#1-add(e)       
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #161021-00002#1  add---e
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aisq370_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aisq370_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_isam_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_isam_d[l_ac].isamcomp,g_isam_d[l_ac].isamcomp_desc,g_isam_d[l_ac].isamdocno, 
       g_isam_d[l_ac].isamseq,g_isam_d[l_ac].isam001,g_isam_d[l_ac].isam002,g_isam_d[l_ac].isam002_desc, 
       g_isam_d[l_ac].isam011,g_isam_d[l_ac].isam009,g_isam_d[l_ac].isam010,g_isam_d[l_ac].isam008,g_isam_d[l_ac].isam008_desc, 
       g_isam_d[l_ac].l_isam036,g_isam_d[l_ac].isam036_desc,g_isam_d[l_ac].isam012,g_isam_d[l_ac].isam012_desc, 
       g_isam_d[l_ac].isam0121,g_isam_d[l_ac].isam013,g_isam_d[l_ac].isam014,g_isam_d[l_ac].isam015, 
       g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025,g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027, 
       g_isam_d[l_ac].isam028,g_isam_d[l_ac].isamownid,g_isam_d[l_ac].isamownid_desc,g_isam_d[l_ac].isamowndp, 
       g_isam_d[l_ac].isamowndp_desc,g_isam_d[l_ac].isamcrtid,g_isam_d[l_ac].isamcrtid_desc,g_isam_d[l_ac].isamcrtdp, 
       g_isam_d[l_ac].isamcrtdp_desc,g_isam_d[l_ac].isamcrtdt,g_isam_d[l_ac].isammodid,g_isam_d[l_ac].isammodid_desc, 
       g_isam_d[l_ac].isammoddt,g_isam_d[l_ac].isamcnfid,g_isam_d[l_ac].isamcnfid_desc,g_isam_d[l_ac].isamcnfdt 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_isam_d[l_ac].statepic = cl_get_actipic(g_isam_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aisq370_detail_show("'1'")      
 
      CALL aisq370_isam_t_mask()
 
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
   
 
   
   CALL g_isam_d.deleteElement(g_isam_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_isam_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aisq370_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aisq370_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aisq370_detail_action_trans()
 
   IF g_isam_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aisq370_fetch()
   END IF
   
      CALL aisq370_filter_show('isamcomp','b_isamcomp')
   CALL aisq370_filter_show('isamdocno','b_isamdocno')
   CALL aisq370_filter_show('isamseq','b_isamseq')
   CALL aisq370_filter_show('isam001','b_isam001')
   CALL aisq370_filter_show('isam002','b_isam002')
   CALL aisq370_filter_show('isam011','b_isam011')
   CALL aisq370_filter_show('isam009','b_isam009')
   CALL aisq370_filter_show('isam010','b_isam010')
   CALL aisq370_filter_show('isam008','b_isam008')
   CALL aisq370_filter_show('isam012','b_isam012')
   CALL aisq370_filter_show('isam0121','b_isam0121')
   CALL aisq370_filter_show('isam013','b_isam013')
   CALL aisq370_filter_show('isam014','b_isam014')
   CALL aisq370_filter_show('isam015','b_isam015')
   CALL aisq370_filter_show('isam023','b_isam023')
   CALL aisq370_filter_show('isam024','b_isam024')
   CALL aisq370_filter_show('isam025','b_isam025')
   CALL aisq370_filter_show('isam026','b_isam026')
   CALL aisq370_filter_show('isam027','b_isam027')
   CALL aisq370_filter_show('isam028','b_isam028')
   CALL aisq370_filter_show('isamownid','b_isamownid')
   CALL aisq370_filter_show('isamowndp','b_isamowndp')
   CALL aisq370_filter_show('isamcrtid','b_isamcrtid')
   CALL aisq370_filter_show('isamcrtdp','b_isamcrtdp')
   CALL aisq370_filter_show('isamcrtdt','b_isamcrtdt')
   CALL aisq370_filter_show('isammodid','b_isammodid')
   CALL aisq370_filter_show('isammoddt','b_isammoddt')
   CALL aisq370_filter_show('isamcnfid','b_isamcnfid')
   CALL aisq370_filter_show('isamcnfdt','b_isamcnfdt')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq370.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aisq370_fetch()
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
 
{<section id="aisq370.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aisq370_detail_show(ps_page)
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
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body.reference"
 
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq370.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aisq370_filter()
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
      CONSTRUCT g_wc_filter ON isamcomp,isamdocno,isamseq,isam001,isam002,isam011,isam009,isam010,isam008, 
          isam012,isam0121,isam013,isam014,isam015,isam023,isam024,isam025,isam026,isam027,isam028,isamownid, 
          isamowndp,isamcrtid,isamcrtdp,isamcrtdt,isammodid,isammoddt,isamcnfid,isamcnfdt
                          FROM s_detail1[1].b_isamcomp,s_detail1[1].b_isamdocno,s_detail1[1].b_isamseq, 
                              s_detail1[1].b_isam001,s_detail1[1].b_isam002,s_detail1[1].b_isam011,s_detail1[1].b_isam009, 
                              s_detail1[1].b_isam010,s_detail1[1].b_isam008,s_detail1[1].b_isam012,s_detail1[1].b_isam0121, 
                              s_detail1[1].b_isam013,s_detail1[1].b_isam014,s_detail1[1].b_isam015,s_detail1[1].b_isam023, 
                              s_detail1[1].b_isam024,s_detail1[1].b_isam025,s_detail1[1].b_isam026,s_detail1[1].b_isam027, 
                              s_detail1[1].b_isam028,s_detail1[1].b_isamownid,s_detail1[1].b_isamowndp, 
                              s_detail1[1].b_isamcrtid,s_detail1[1].b_isamcrtdp,s_detail1[1].b_isamcrtdt, 
                              s_detail1[1].b_isammodid,s_detail1[1].b_isammoddt,s_detail1[1].b_isamcnfid, 
                              s_detail1[1].b_isamcnfdt
 
         BEFORE CONSTRUCT
                     DISPLAY aisq370_filter_parser('isamcomp') TO s_detail1[1].b_isamcomp
            DISPLAY aisq370_filter_parser('isamdocno') TO s_detail1[1].b_isamdocno
            DISPLAY aisq370_filter_parser('isamseq') TO s_detail1[1].b_isamseq
            DISPLAY aisq370_filter_parser('isam001') TO s_detail1[1].b_isam001
            DISPLAY aisq370_filter_parser('isam002') TO s_detail1[1].b_isam002
            DISPLAY aisq370_filter_parser('isam011') TO s_detail1[1].b_isam011
            DISPLAY aisq370_filter_parser('isam009') TO s_detail1[1].b_isam009
            DISPLAY aisq370_filter_parser('isam010') TO s_detail1[1].b_isam010
            DISPLAY aisq370_filter_parser('isam008') TO s_detail1[1].b_isam008
            DISPLAY aisq370_filter_parser('isam012') TO s_detail1[1].b_isam012
            DISPLAY aisq370_filter_parser('isam0121') TO s_detail1[1].b_isam0121
            DISPLAY aisq370_filter_parser('isam013') TO s_detail1[1].b_isam013
            DISPLAY aisq370_filter_parser('isam014') TO s_detail1[1].b_isam014
            DISPLAY aisq370_filter_parser('isam015') TO s_detail1[1].b_isam015
            DISPLAY aisq370_filter_parser('isam023') TO s_detail1[1].b_isam023
            DISPLAY aisq370_filter_parser('isam024') TO s_detail1[1].b_isam024
            DISPLAY aisq370_filter_parser('isam025') TO s_detail1[1].b_isam025
            DISPLAY aisq370_filter_parser('isam026') TO s_detail1[1].b_isam026
            DISPLAY aisq370_filter_parser('isam027') TO s_detail1[1].b_isam027
            DISPLAY aisq370_filter_parser('isam028') TO s_detail1[1].b_isam028
            DISPLAY aisq370_filter_parser('isamownid') TO s_detail1[1].b_isamownid
            DISPLAY aisq370_filter_parser('isamowndp') TO s_detail1[1].b_isamowndp
            DISPLAY aisq370_filter_parser('isamcrtid') TO s_detail1[1].b_isamcrtid
            DISPLAY aisq370_filter_parser('isamcrtdp') TO s_detail1[1].b_isamcrtdp
            DISPLAY aisq370_filter_parser('isamcrtdt') TO s_detail1[1].b_isamcrtdt
            DISPLAY aisq370_filter_parser('isammodid') TO s_detail1[1].b_isammodid
            DISPLAY aisq370_filter_parser('isammoddt') TO s_detail1[1].b_isammoddt
            DISPLAY aisq370_filter_parser('isamcnfid') TO s_detail1[1].b_isamcnfid
            DISPLAY aisq370_filter_parser('isamcnfdt') TO s_detail1[1].b_isamcnfdt
 
 
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<isamcrtdt>>----
         AFTER FIELD isamcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<isammoddt>>----
         AFTER FIELD isammoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<isamcnfdt>>----
         AFTER FIELD isamcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<isampstdt>>----
         #AFTER FIELD isampstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
           
         #單身一般欄位開窗相關處理
                  #----<<b_isamcomp>>----
         #Ctrlp:construct.c.filter.page1.b_isamcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamcomp
            #add-point:ON ACTION controlp INFIELD b_isamcomp name="construct.c.filter.page1.b_isamcomp"
            
            #END add-point
 
 
         #----<<b_isamcomp_desc>>----
         #----<<b_isamdocno>>----
         #Ctrlp:construct.c.page1.b_isamdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamdocno
            #add-point:ON ACTION controlp INFIELD b_isamdocno name="construct.c.filter.page1.b_isamdocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "apbbcomp = '",g_isam_m.l_isamcomp,"' "
            CALL q_isamdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isamdocno  #顯示到畫面上
            NEXT FIELD b_isamdocno                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isamseq>>----
         #Ctrlp:construct.c.filter.page1.b_isamseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamseq
            #add-point:ON ACTION controlp INFIELD b_isamseq name="construct.c.filter.page1.b_isamseq"
            
            #END add-point
 
 
         #----<<b_isam001>>----
         #Ctrlp:construct.c.page1.b_isam001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam001
            #add-point:ON ACTION controlp INFIELD b_isam001 name="construct.c.filter.page1.b_isam001"
            #170104-00053#1-add(s)
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isam001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isam001  #顯示到畫面上
            NEXT FIELD b_isam001                     #返回原欄位
            #170104-00053#1-add(e)



            #END add-point
 
 
         #----<<b_isam002>>----
         #Ctrlp:construct.c.page1.b_isam002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam002
            #add-point:ON ACTION controlp INFIELD b_isam002 name="construct.c.filter.page1.b_isam002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = g_ctl_where
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isam002  #顯示到畫面上
            NEXT FIELD b_isam002                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isam002_desc>>----
         #----<<b_isam011>>----
         #Ctrlp:construct.c.filter.page1.b_isam011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam011
            #add-point:ON ACTION controlp INFIELD b_isam011 name="construct.c.filter.page1.b_isam011"
            
            #END add-point
 
 
         #----<<b_isam009>>----
         #Ctrlp:construct.c.filter.page1.b_isam009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam009
            #add-point:ON ACTION controlp INFIELD b_isam009 name="construct.c.filter.page1.b_isam009"
            
            #END add-point
 
 
         #----<<b_isam010>>----
         #Ctrlp:construct.c.page1.b_isam010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam010
            #add-point:ON ACTION controlp INFIELD b_isam010 name="construct.c.filter.page1.b_isam010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isam010()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isam010  #顯示到畫面上
            NEXT FIELD b_isam010                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isam008>>----
         #Ctrlp:construct.c.page1.b_isam008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam008
            #add-point:ON ACTION controlp INFIELD b_isam008 name="construct.c.filter.page1.b_isam008"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isac001 IN (SELECT ooef019 FROM ooef_t ",
                                   " WHERE ooefent = isacent AND ooef001 = '",g_isam_m.l_isamcomp,
                                                   "')"
            CALL q_isac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isam008  #顯示到畫面上
            NEXT FIELD b_isam008                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isam008_desc>>----
         #----<<l_isam036>>----
         #----<<b_isam036_desc>>----
         #----<<b_isam012>>----
         #Ctrlp:construct.c.page1.b_isam012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam012
            #add-point:ON ACTION controlp INFIELD b_isam012 name="construct.c.filter.page1.b_isam012"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oodb001 IN (SELECT ooef019 FROM ooef_t ",
                                   " WHERE ooefent = oodbent AND ooef001 = '",g_isam_m.l_isamcomp,
                                                   "')"
            CALL q_oodb002_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isam012  #顯示到畫面上
            NEXT FIELD b_isam012                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isam012_desc>>----
         #----<<b_isam0121>>----
         #Ctrlp:construct.c.filter.page1.b_isam0121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam0121
            #add-point:ON ACTION controlp INFIELD b_isam0121 name="construct.c.filter.page1.b_isam0121"
            
            #END add-point
 
 
         #----<<b_isam013>>----
         #Ctrlp:construct.c.filter.page1.b_isam013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam013
            #add-point:ON ACTION controlp INFIELD b_isam013 name="construct.c.filter.page1.b_isam013"
            
            #END add-point
 
 
         #----<<b_isam014>>----
         #Ctrlp:construct.c.page1.b_isam014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam014
            #add-point:ON ACTION controlp INFIELD b_isam014 name="construct.c.filter.page1.b_isam014"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isam014  #顯示到畫面上
            NEXT FIELD b_isam014                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isam015>>----
         #Ctrlp:construct.c.filter.page1.b_isam015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam015
            #add-point:ON ACTION controlp INFIELD b_isam015 name="construct.c.filter.page1.b_isam015"
            
            #END add-point
 
 
         #----<<b_isam023>>----
         #Ctrlp:construct.c.filter.page1.b_isam023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam023
            #add-point:ON ACTION controlp INFIELD b_isam023 name="construct.c.filter.page1.b_isam023"
            
            #END add-point
 
 
         #----<<b_isam024>>----
         #Ctrlp:construct.c.filter.page1.b_isam024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam024
            #add-point:ON ACTION controlp INFIELD b_isam024 name="construct.c.filter.page1.b_isam024"
            
            #END add-point
 
 
         #----<<b_isam025>>----
         #Ctrlp:construct.c.filter.page1.b_isam025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam025
            #add-point:ON ACTION controlp INFIELD b_isam025 name="construct.c.filter.page1.b_isam025"
            
            #END add-point
 
 
         #----<<b_isam026>>----
         #Ctrlp:construct.c.filter.page1.b_isam026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam026
            #add-point:ON ACTION controlp INFIELD b_isam026 name="construct.c.filter.page1.b_isam026"
            
            #END add-point
 
 
         #----<<b_isam027>>----
         #Ctrlp:construct.c.filter.page1.b_isam027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam027
            #add-point:ON ACTION controlp INFIELD b_isam027 name="construct.c.filter.page1.b_isam027"
            
            #END add-point
 
 
         #----<<b_isam028>>----
         #Ctrlp:construct.c.filter.page1.b_isam028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam028
            #add-point:ON ACTION controlp INFIELD b_isam028 name="construct.c.filter.page1.b_isam028"
            
            #END add-point
 
 
         #----<<b_isamownid>>----
         #Ctrlp:construct.c.page1.b_isamownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamownid
            #add-point:ON ACTION controlp INFIELD b_isamownid name="construct.c.filter.page1.b_isamownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isamownid  #顯示到畫面上
            NEXT FIELD b_isamownid                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isamownid_desc>>----
         #----<<b_isamowndp>>----
         #Ctrlp:construct.c.page1.b_isamowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamowndp
            #add-point:ON ACTION controlp INFIELD b_isamowndp name="construct.c.filter.page1.b_isamowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isamowndp  #顯示到畫面上
            NEXT FIELD b_isamowndp                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isamowndp_desc>>----
         #----<<b_isamcrtid>>----
         #Ctrlp:construct.c.page1.b_isamcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamcrtid
            #add-point:ON ACTION controlp INFIELD b_isamcrtid name="construct.c.filter.page1.b_isamcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isamcrtid  #顯示到畫面上
            NEXT FIELD b_isamcrtid                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isamcrtid_desc>>----
         #----<<b_isamcrtdp>>----
         #Ctrlp:construct.c.page1.b_isamcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamcrtdp
            #add-point:ON ACTION controlp INFIELD b_isamcrtdp name="construct.c.filter.page1.b_isamcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isamcrtdp  #顯示到畫面上
            NEXT FIELD b_isamcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isamcrtdp_desc>>----
         #----<<b_isamcrtdt>>----
         #----<<b_isammodid>>----
         #Ctrlp:construct.c.page1.b_isammodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isammodid
            #add-point:ON ACTION controlp INFIELD b_isammodid name="construct.c.filter.page1.b_isammodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isammodid  #顯示到畫面上
            NEXT FIELD b_isammodid                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isammodid_desc>>----
         #----<<b_isammoddt>>----
         #----<<b_isamcnfid>>----
         #Ctrlp:construct.c.page1.b_isamcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamcnfid
            #add-point:ON ACTION controlp INFIELD b_isamcnfid name="construct.c.filter.page1.b_isamcnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isamcnfid  #顯示到畫面上
            NEXT FIELD b_isamcnfid                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isamcnfid_desc>>----
         #----<<b_isamcnfdt>>----
   
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         
         
         LET l_ac = 1
         LET g_isam_d[l_ac].isamdocno = ''
         DISPLAY ARRAY g_isam_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY         
         END DISPLAY
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
   
      CALL aisq370_filter_show('isamcomp','b_isamcomp')
   CALL aisq370_filter_show('isamdocno','b_isamdocno')
   CALL aisq370_filter_show('isamseq','b_isamseq')
   CALL aisq370_filter_show('isam001','b_isam001')
   CALL aisq370_filter_show('isam002','b_isam002')
   CALL aisq370_filter_show('isam011','b_isam011')
   CALL aisq370_filter_show('isam009','b_isam009')
   CALL aisq370_filter_show('isam010','b_isam010')
   CALL aisq370_filter_show('isam008','b_isam008')
   CALL aisq370_filter_show('isam012','b_isam012')
   CALL aisq370_filter_show('isam0121','b_isam0121')
   CALL aisq370_filter_show('isam013','b_isam013')
   CALL aisq370_filter_show('isam014','b_isam014')
   CALL aisq370_filter_show('isam015','b_isam015')
   CALL aisq370_filter_show('isam023','b_isam023')
   CALL aisq370_filter_show('isam024','b_isam024')
   CALL aisq370_filter_show('isam025','b_isam025')
   CALL aisq370_filter_show('isam026','b_isam026')
   CALL aisq370_filter_show('isam027','b_isam027')
   CALL aisq370_filter_show('isam028','b_isam028')
   CALL aisq370_filter_show('isamownid','b_isamownid')
   CALL aisq370_filter_show('isamowndp','b_isamowndp')
   CALL aisq370_filter_show('isamcrtid','b_isamcrtid')
   CALL aisq370_filter_show('isamcrtdp','b_isamcrtdp')
   CALL aisq370_filter_show('isamcrtdt','b_isamcrtdt')
   CALL aisq370_filter_show('isammodid','b_isammodid')
   CALL aisq370_filter_show('isammoddt','b_isammoddt')
   CALL aisq370_filter_show('isamcnfid','b_isamcnfid')
   CALL aisq370_filter_show('isamcnfdt','b_isamcnfdt')
 
    
   CALL aisq370_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq370.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aisq370_filter_parser(ps_field)
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
 
{<section id="aisq370.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aisq370_filter_show(ps_field,ps_object)
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
   LET ls_condition = aisq370_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq370.insert" >}
#+ insert
PRIVATE FUNCTION aisq370_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aisq370.modify" >}
#+ modify
PRIVATE FUNCTION aisq370_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq370.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aisq370_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq370.delete" >}
#+ delete
PRIVATE FUNCTION aisq370_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq370.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aisq370_detail_action_trans()
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
 
{<section id="aisq370.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aisq370_detail_index_setting()
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
            IF g_isam_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_isam_d.getLength() AND g_isam_d.getLength() > 0
            LET g_detail_idx = g_isam_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_isam_d.getLength() THEN
               LET g_detail_idx = g_isam_d.getLength()
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
 
{<section id="aisq370.mask_functions" >}
 &include "erp/ais/aisq370_mask.4gl"
 
{</section>}
 
{<section id="aisq370.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 資料清空還原預設值
# Memo...........:
# Usage..........: CALL aisq370_qbe_clear()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/09/08 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq370_qbe_clear()
DEFINE l_success       LIKE type_t.num5
   
   CALL s_fin_azzi800_sons_query(g_today) 
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   
   CALL s_aooi100_get_comp(g_site) RETURNING l_success,g_isam_m.l_isamcomp
   LET g_isam_m.l_isamcomp_desc = s_desc_get_department_desc(g_isam_m.l_isamcomp) 
   LET g_isam_m_o.* = g_isam_m.*
   DISPLAY BY NAME g_isam_m.l_isamcomp,g_isam_m.l_isamcomp_desc
   
   CALL aisq370_set_visible()
   CALL aisq370_set_no_visible()
   
   LET l_ac = 1
   LET g_isam_d[l_ac].isamdocno = ''
   DISPLAY ARRAY g_isam_d TO s_detail1.*
      BEFORE DISPLAY
         EXIT DISPLAY         
   END DISPLAY

END FUNCTION

################################################################################
# Descriptions...: 建立臨時表
# Memo...........: #160518-00024#6
# Usage..........: CALL aisq370_create_tmp()
# Date & Author..: 2016/09/10 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq370_create_tmp()

   #建立臨時表     
   DROP TABLE aisq370_x01_tmp;
   CREATE TEMP TABLE aisq370_x01_tmp(
      isament           LIKE  isam_t.isament,
      isamcomp          LIKE  isam_t.isamcomp,
      l_isamcomp_desc   LIKE  type_t.chr100,
      isamdocno         LIKE  isam_t.isamdocno,
      isamseq           LIKE  isam_t.isamseq,
      isam001           LIKE  isam_t.isam001,
      isam002           LIKE  isam_t.isam002,
      l_isam002_desc    LIKE  type_t.chr100,
      isam011           LIKE  isam_t.isam011,
      isam009           LIKE  isam_t.isam009,
      isam010           LIKE  isam_t.isam010,
      isam008           LIKE  isam_t.isam008,
      l_isam008_desc    LIKE  type_t.chr100,
      l_isam036           LIKE  isam_t.isam036,    #170104-00053#1 add
      l_isam036_desc    LIKE  type_t.chr100,     #170104-00053#1 add
      isam012           LIKE  isam_t.isam012,
      l_isam012_desc    LIKE  type_t.chr100,
      isam0121          LIKE  isam_t.isam0121,
      isam013           LIKE  isam_t.isam013,
      isam014           LIKE  isam_t.isam014,
      isam015           LIKE  isam_t.isam015,
      isam023           LIKE  isam_t.isam023,
      isam024           LIKE  isam_t.isam024,
      isam025           LIKE  isam_t.isam025,
      isam026           LIKE  isam_t.isam026,
      isam027           LIKE  isam_t.isam027,
      isam028           LIKE  isam_t.isam028,
      isamownid         LIKE  isam_t.isamownid,
      l_isamownid_desc  LIKE  type_t.chr100,
      isamowndp         LIKE  isam_t.isamowndp,
      l_isamowndp_desc  LIKE  type_t.chr100,
      isamcrtid         LIKE  isam_t.isamcrtid,
      l_isamcrtid_desc  LIKE  type_t.chr100,
      isamcrtdp         LIKE  isam_t.isamcrtdp,
      l_isamcrtdp_desc  LIKE  type_t.chr100,
      isamcrtdt         LIKE  isam_t.isamcrtdt,
      isammodid         LIKE  isam_t.isammodid,
      l_isammodid_desc  LIKE  type_t.chr100,
      isammoddt         LIKE  isam_t.isammoddt,
      isamcnfid         LIKE  isam_t.isamcnfid,
      l_isamcnfid_desc  LIKE  type_t.chr100,
      isamcnfdt         LIKE  isam_t.isamcnfdt
      )
END FUNCTION

################################################################################
# Descriptions...: 報表列印
# Memo...........: #160518-00024#6
# Usage..........: CALL aisq370_ins_x01_tmp()
# Date & Author..: 2016/09/10 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq370_ins_x01_tmp()
DEFINE l_i                 LIKE type_t.num5
DEFINE l_isamcomp_desc     LIKE type_t.chr100

   #單頭
   LET l_isamcomp_desc = g_isam_m.l_isamcomp,':',g_isam_m.l_isamcomp_desc 
   
   DELETE FROM aisq370_x01_tmp   #161021-00002#1   add
   
   #單身
   LET l_i = 1
   FOR l_i = 1 TO g_isam_d.getLength()
      #170104-00053#1 add(s)
      IF cl_null(g_isam_d[l_i].l_isam036) THEN
         LET g_isam_d[l_i].isam036_desc =''
      ELSE
         LET g_isam_d[l_i].isam036_desc = g_isam_d[l_i].l_isam036,":",s_desc_gzcbl004_desc('9716',g_isam_d[l_i].l_isam036)
      END IF
      #170104-00053#1 add(e)
      INSERT INTO aisq370_x01_tmp
         VALUES(g_enterprise,                   g_isam_d[l_i].isamcomp,         l_isamcomp_desc,
                g_isam_d[l_i].isamdocno,        g_isam_d[l_i].isamseq,          g_isam_d[l_i].isam001,
                g_isam_d[l_i].isam002,          g_isam_d[l_i].isam002_desc,     g_isam_d[l_i].isam011,
                g_isam_d[l_i].isam009,          g_isam_d[l_i].isam010,          g_isam_d[l_i].isam008,
                #g_isam_d[l_i].isam008_desc,     g_isam_d[l_i].isam012,          g_isam_d[l_i].isam012_desc, #170104-00053#1 mark
                g_isam_d[l_i].isam008_desc,     g_isam_d[l_i].l_isam036,          g_isam_d[l_i].isam036_desc,  #170104-00053#1 add
                g_isam_d[l_i].isam012,          g_isam_d[l_i].isam012_desc,     #170104-00053#1 add
                g_isam_d[l_i].isam0121,         g_isam_d[l_i].isam013,          g_isam_d[l_i].isam014,
                g_isam_d[l_i].isam015,          g_isam_d[l_i].isam023,          g_isam_d[l_i].isam024,
                g_isam_d[l_i].isam025,          g_isam_d[l_i].isam026,          g_isam_d[l_i].isam027,
                g_isam_d[l_i].isam028,          g_isam_d[l_i].isamownid,        g_isam_d[l_i].isamownid_desc,
                g_isam_d[l_i].isamowndp,        g_isam_d[l_i].isamowndp_desc,   g_isam_d[l_i].isamcrtid,
                g_isam_d[l_i].isamcrtid_desc,   g_isam_d[l_i].isamcrtdp,        g_isam_d[l_i].isamcrtdp_desc,
                g_isam_d[l_i].isamcrtdt,        g_isam_d[l_i].isammodid,        g_isam_d[l_i].isammodid_desc,
                g_isam_d[l_i].isammoddt,        g_isam_d[l_i].isamcnfid,        g_isam_d[l_i].isamcnfid_desc,
                g_isam_d[l_i].isamcnfdt
                )
   END FOR
   CALL aisq370_xg_visible()
END FUNCTION

################################################################################
# Descriptions...: 傳進XG報表隱藏欄位設置
# Memo...........: #160518-00024#6
# Usage..........: CALL aisq370_xg_visible()
# Date & Author..: 2016/09/10 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq370_xg_visible()
   
   DEFINE l_isam009  LIKE isam_t.isam009
   
   LET g_xg_visible = NULL
   LET l_isam009 = ''
   
   SELECT DISTINCT isai002 INTO l_isam009
     FROM isai_t
     LEFT JOIN isam_t ON isament = isaient
     LEFT JOIN ooef_t ON ooefent = isaient AND ooef019 = isai001
         WHERE ooefent = g_enterprise
           AND ooef001 = isamcomp
           AND isamcomp = g_isam_m.l_isamcomp
           
   IF l_isam009 != 1 THEN
      LET g_xg_visible = "isam009"
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 法人欄位檢核
# Memo...........: 檢核存在有效;檢核是否為法人組織;user有無權限使用此組織
# Usage..........: CALL aisq370_isamcomp_chk(p_isamcomp)
#                  RETURNING g_sub_success,g_errno
# Input parameter: p_isamcomp     法人
# Return code....: r_success
#                : r_errno
# Date & Author..: 2016/09/10 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq370_isamcomp_chk(p_isamcomp)
   
   DEFINE p_isamcomp   LIKE isam_t.isamcomp
   DEFINE r_success    LIKE type_t.num5
   DEFINE r_errno      LIKE gzze_t.gzze001
   DEFINE l_ooef       RECORD
                       ooef003   LIKE ooef_t.ooef003,
                       ooefstus  LIKE ooef_t.ooefstus
                       END RECORD
   DEFINE l_count      LIKE type_t.num10
   DEFINE l_sql        STRING

   LET r_success = TRUE
   LET r_errno   = ''

   INITIALIZE l_ooef.* TO NULL
   SELECT ooef003,ooefstus
     INTO l_ooef.*
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_isamcomp
      
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_success = FALSE
         LET r_errno   = 'wss-00231'
      WHEN l_ooef.ooefstus <> 'Y'
         LET r_success = FALSE
         LET r_errno   = 'wss-00231'
      WHEN l_ooef.ooef003  <> 'Y'
         LET r_success = FALSE
         LET r_errno   = 'aap-00011'
   END CASE
   
   IF NOT r_success THEN 
      RETURN r_success,r_errno 
   END IF
   
   LET l_count = NULL
   LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = ",g_enterprise," ",
               "   AND ooef001 = '",p_isamcomp,"' ",
               "   AND ooef001 IN ",g_wc_cs_comp CLIPPED
               
   PREPARE sel_ooefp11 FROM l_sql
   EXECUTE sel_ooefp11 INTO l_count
   
   IF cl_null(l_count)THEN LET l_count = 0 END IF

   IF l_count = 0 THEN
      LET r_success = FALSE
      LET r_errno   = 'ais-00228'
   END IF

   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 開啟發票代碼、字軌欄位顯隱
# Memo...........:
# Usage..........: CALL aisq370_set_visible()
# Input parameter: 無
# Date & Author..: 2016/09/13 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq370_set_visible()
   
   CALL cl_set_comp_visible('b_isam009',TRUE)
   
END FUNCTION

################################################################################
# Descriptions...: 關閉發票代碼、字軌欄位顯隱
# Memo...........:
# Usage..........: CALL aisq370_set_no_visible()
# Input parameter: 無
# Date & Author..: 2016/09/13 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq370_set_no_visible()
DEFINE l_isai002  LIKE isai_t.isai002

   SELECT isai002 INTO l_isai002
     FROM isai_t,ooef_t 
    WHERE ooefent = isaient AND ooef019 = isai001
      AND ooefent = g_enterprise
      AND ooef001 = g_isam_m.l_isamcomp
           
   IF l_isai002 = 1 THEN
      CALL cl_set_comp_visible("b_isam009", FALSE)
   END IF
   
END FUNCTION

 
{</section>}
 
