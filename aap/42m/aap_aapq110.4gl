#該程式未解開Section, 採用最新樣板產出!
{<section id="aapq110.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:10(2015-12-18 16:05:01), PR版次:0010(2017-01-06 16:48:01)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000084
#+ Filename...: aapq110
#+ Description: 供應商對帳單明細查詢
#+ Creator....: 04152(2015-01-21 12:58:05)
#+ Modifier...: 02097 -SD/PR- 06821
 
{</section>}
 
{<section id="aapq110.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151231-00010#4   2016/01/11  By 02097    增加控制組
#160518-00075#15  2016/08/03  By Hans     使用元件取得aooi200的限制人員/限制部門取用單別並加以限制範圍
#161018-00028#1   2016/10/18  By 06821    列印時改用其他變數接傳入條件，避免造成g_wc跳頁後無法以最新key查到資料 (BUG單:列印後按下一頁,單身頁簽內容會被清空，導致查不到資料)
#161006-00005#18  2016/10/24  By 08732    組織類型與職能開窗調整
#161115-00042#4   2016/11/16  By 08171    開窗範圍處理(控制組元件調整)
#161229-00047#22  2017/01/06  By 06821    財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
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
PRIVATE TYPE type_g_apbb_d RECORD
       #statepic       LIKE type_t.chr1,
       
       type1 LIKE type_t.chr500, 
   apbbcomp LIKE apbb_t.apbbcomp, 
   apbbcomp_desc LIKE type_t.chr500, 
   apbb002 LIKE type_t.chr500, 
   apbbdocdt LIKE apbb_t.apbbdocdt, 
   apbbdocno LIKE apbb_t.apbbdocno, 
   apbb010 LIKE apbb_t.apbb010, 
   apbb012 LIKE apbb_t.apbb012, 
   apbb054 LIKE apbb_t.apbb054, 
   apbb051 LIKE type_t.chr500, 
   apba004 LIKE type_t.chr500, 
   apba005 LIKE apba_t.apba005, 
   apbb014 LIKE apbb_t.apbb014, 
   apba105 LIKE apba_t.apba105, 
   apba115 LIKE apba_t.apba115, 
   apbbstus LIKE apbb_t.apbbstus 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input     RECORD
        apbb004         LIKE apbb_t.apbb004,
        apbb004_desc    LIKE type_t.chr80,
        docdt_s         LIKE apbb_t.apbbdocdt,
        docdt_e         LIKE apbb_t.apbbdocdt,
        apbbcomp        LIKE apbb_t.apbbcomp,
        apbb002         LIKE apbb_t.apbb002
                    END RECORD
DEFINE g_wc_apcacomp    STRING
DEFINE g_current_row    LIKE type_t.num5 
DEFINE g_current_idx    LIKE type_t.num10     
DEFINE g_jump           LIKE type_t.num10       
DEFINE g_browser_cnt    LIKE type_t.num10     
DEFINE g_header_cnt     LIKE type_t.num10     
DEFINE g_browser_idx    LIKE type_t.num10      
DEFINE g_no_ask         LIKE type_t.num5  
DEFINE g_rec_b          LIKE type_t.num5
DEFINE g_fetch_flag     LIKE type_t.chr1
DEFINE g_apbb_d1        DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
        apbbcomp        LIKE apbb_t.apbbcomp,
        apbb002         LIKE apbb_t.apbb002
                    END RECORD
DEFINE g_sql_ctrl          STRING      #151231-00010#4 
DEFINE g_user_dept_wc      STRING      #160518-00075#15
DEFINE g_user_dept_wc_q    STRING      #160518-00075#15
DEFINE g_wc_pint           STRING      #161018-00028#1   add 列印條件
DEFINE g_wc_cs_comp        STRING      #161006-00005#18   add azzi800權限_法人
DEFINE g_apbbcomp          LIKE apbb_t.apbbcomp #161115-00042#4 控制組抓法人
DEFINE g_comp_str          STRING      #161229-00047#22 add 
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_apbb_d
DEFINE g_master_t                   type_g_apbb_d
DEFINE g_apbb_d          DYNAMIC ARRAY OF type_g_apbb_d
DEFINE g_apbb_d_t        type_g_apbb_d
 
      
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
 
{<section id="aapq110.main" >}
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
   CALL cl_ap_init("aap","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_fin_create_account_center_tmp()     #展組織下階成員所需之暫存檔 
   #151231-00010#4--(S)
   LET g_sql_ctrl = NULL
  #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161115-00042#4 mark
   #161115-00042#4 --s add
   SELECT ooef017 INTO g_apbbcomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apbbcomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#22 mark
   #161115-00042#4 --e add
   #151231-00010#4--(E)
   #161006-00005#18   add---s
   CALL s_fin_azzi800_sons_query(g_today)                      
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp    
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp  
   #161006-00005#18   add---e   
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#22 add
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
   DECLARE aapq110_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapq110_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapq110_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapq110 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapq110_init()   
 
      #進入選單 Menu (="N")
      CALL aapq110_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapq110
      
   END IF 
   
   CLOSE aapq110_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapq110.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapq110_init()
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
      CALL cl_set_combo_scc_part('b_apbbstus','13','Y,N,A,D,R,W,X')
 
      CALL cl_set_combo_scc('b_apba004','8541') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   #160518-00075#18--s
   LET g_user_dept_wc = '' 
   CALL s_fin_get_user_dept_control('apbbcomp','','apbbent','apbbdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   #160518-00075#18--e 
   #end add-point
 
   CALL aapq110_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aapq110.default_search" >}
PRIVATE FUNCTION aapq110_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
 
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " apbbdocno = '", g_argv[01], "' AND "
   END IF
 
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段開始後 name="default_search.after"
   LET g_wc = ""
   
   IF NOT cl_null(g_argv[02]) THEN
      LET g_input.apbb004 = g_argv[02]
   END IF
   
   IF NOT cl_null(g_argv[03]) AND NOT cl_null(g_argv[04]) THEN
      LET g_input.docdt_s = g_argv[03]
      LET g_input.docdt_e = g_argv[04]
   END IF
   
   IF NOT cl_null(g_argv[05]) THEN
      LET g_input.apbbcomp = g_argv[05]
      LET g_wc = g_wc, " apbbcomp = '", g_argv[05], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[06]) THEN
      LET g_input.apbb002 = g_argv[06]
   END IF

   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq110.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aapq110_ui_dialog()
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
      CALL aapq110_b_fill()
   ELSE
      CALL aapq110_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_apbb_d.clear()
 
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
 
         CALL aapq110_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_apbb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aapq110_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aapq110_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               DISPLAY g_current_idx TO FORMONLY.h_index
               DISPLAY g_apbb_d1.getLength() TO FORMONLY.h_count
               DISPLAY g_detail_idx  TO FORMONLY.idx             #單身當下筆數
               DISPLAY g_apbb_d.getLength()  TO FORMONLY.cnt     #單身總筆數
               CALL cl_navigator_setting(g_current_idx,g_apbb_d1.getLength())
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
            CALL aapq110_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE)
            
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #列印aapr110_g01
               #161018-00028#1 --s mark
               #改用其他變數接傳入條件，避免造成g_wc跳頁後無法以最新key查到資料
               #LET g_wc = " apbb002 = '",g_input.apbb002,"' AND apbbcomp = '",g_input.apbbcomp,"' "    
               #CALL aapr110_g01(g_wc,g_input.apbb004,g_input.docdt_s,g_input.docdt_e)                  
               #161018-00028#1 --e mark
               #161018-00028#1 --s add
               LET g_wc_pint = " apbb002 = '",g_input.apbb002,"' AND apbbcomp = '",g_input.apbbcomp,"' " 
               CALL aapr110_g01(g_wc_pint,g_input.apbb004,g_input.docdt_s,g_input.docdt_e)          
               #161018-00028#1 --e add
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #列印aapr110_g01
               #161018-00028#1 --s mark
               #改用其他變數接傳入條件，避免造成g_wc跳頁後無法以最新key查到資料
               #LET g_wc = " apbb002 = '",g_input.apbb002,"' AND apbbcomp = '",g_input.apbbcomp,"' "    
               #CALL aapr110_g01(g_wc,g_input.apbb004,g_input.docdt_s,g_input.docdt_e)                  
               #161018-00028#1 --e mark
               #161018-00028#1 --s add
               LET g_wc_pint = " apbb002 = '",g_input.apbb002,"' AND apbbcomp = '",g_input.apbbcomp,"' " 
               CALL aapr110_g01(g_wc_pint,g_input.apbb004,g_input.docdt_s,g_input.docdt_e)          
               #161018-00028#1 --e add
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapq110_query()
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
            CALL aapq110_filter()
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
            CALL aapq110_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_apbb_d)
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
            CALL aapq110_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aapq110_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aapq110_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aapq110_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION previous
            LET g_action_choice="previous"
            CALL aapq110_fetch1('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
 
         ON ACTION first
            LET g_action_choice="first"
            CALL aapq110_fetch1('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG

         ON ACTION jump
            LET g_action_choice="jump"
            CALL aapq110_fetch1('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
            
         ON ACTION next
            LET g_action_choice="next"
            CALL aapq110_fetch1('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
            
         ON ACTION last
            LET g_action_choice="last"
            CALL aapq110_fetch1('L')
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
 
{<section id="aapq110.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapq110_query()
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
   CALL g_apbb_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON apbbcomp,apbbdocno,apbb010,apbb012,apbb054,apbb014,apbbstus
           FROM s_detail1[1].b_apbbcomp,s_detail1[1].b_apbbdocno,s_detail1[1].b_apbb010,s_detail1[1].b_apbb012, 
               s_detail1[1].b_apbb054,s_detail1[1].b_apbb014,s_detail1[1].b_apbbstus
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<apbbcrtdt>>----
         #AFTER FIELD apbbcrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<apbbmoddt>>----
         #AFTER FIELD apbbmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apbbcnfdt>>----
         #AFTER FIELD apbbcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apbbpstdt>>----
         #AFTER FIELD apbbpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
         
       #單身一般欄位開窗相關處理
                #----<<type1>>----
         #----<<b_apbbcomp>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apbbcomp
            #add-point:BEFORE FIELD b_apbbcomp name="construct.b.page1.b_apbbcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apbbcomp
            
            #add-point:AFTER FIELD b_apbbcomp name="construct.a.page1.b_apbbcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apbbcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apbbcomp
            #add-point:ON ACTION controlp INFIELD b_apbbcomp name="construct.c.page1.b_apbbcomp"
            #開窗c段--法人
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_apcacomp   #161006-00005#18   mark
            LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_cs_comp    #161006-00005#18   add
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO b_apbbcomp
            NEXT FIELD b_apbbcomp
            #END add-point
 
 
         #----<<b_apbbcomp_desc>>----
         #----<<b_apbb002>>----
         #----<<b_apbbdocdt>>----
         #----<<b_apbbdocno>>----
         #Ctrlp:construct.c.page1.b_apbbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apbbdocno
            #add-point:ON ACTION controlp INFIELD b_apbbdocno name="construct.c.page1.b_apbbdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段--異動單號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apbbcomp IN ",g_wc_apcacomp," AND apbbstus = 'Y' AND apbbdocdt BETWEEN '",g_input.docdt_s,"' AND '",g_input.docdt_e,"'"
            #151231-00010#4--(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND apbb002 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            #160518-00075#19--s
            IF NOT cl_null(g_user_dept_wc_q) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q
            END IF               
            #160518-00075#19--e
            CALL q_apbbdocno()
            DISPLAY g_qryparam.return1 TO b_apbbdocno
            NEXT FIELD b_apbbdocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apbbdocno
            #add-point:BEFORE FIELD b_apbbdocno name="construct.b.page1.b_apbbdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apbbdocno
            
            #add-point:AFTER FIELD b_apbbdocno name="construct.a.page1.b_apbbdocno"
            
            #END add-point
            
 
 
         #----<<b_apbb010>>----
         #Ctrlp:construct.c.page1.b_apbb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apbb010
            #add-point:ON ACTION controlp INFIELD b_apbb010 name="construct.c.page1.b_apbb010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isam010()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apbb010  #顯示到畫面上
            NEXT FIELD b_apbb010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apbb010
            #add-point:BEFORE FIELD b_apbb010 name="construct.b.page1.b_apbb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apbb010
            
            #add-point:AFTER FIELD b_apbb010 name="construct.a.page1.b_apbb010"
            
            #END add-point
            
 
 
         #----<<b_apbb012>>----
         #Ctrlp:construct.c.page1.b_apbb012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apbb012
            #add-point:ON ACTION controlp INFIELD b_apbb012 name="construct.c.page1.b_apbb012"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apbb012  #顯示到畫面上
            NEXT FIELD b_apbb012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apbb012
            #add-point:BEFORE FIELD b_apbb012 name="construct.b.page1.b_apbb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apbb012
            
            #add-point:AFTER FIELD b_apbb012 name="construct.a.page1.b_apbb012"
            
            #END add-point
            
 
 
         #----<<b_apbb054>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apbb054
            #add-point:BEFORE FIELD b_apbb054 name="construct.b.page1.b_apbb054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apbb054
            
            #add-point:AFTER FIELD b_apbb054 name="construct.a.page1.b_apbb054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apbb054
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apbb054
            #add-point:ON ACTION controlp INFIELD b_apbb054 name="construct.c.page1.b_apbb054"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmad002_2()                     
            DISPLAY g_qryparam.return1 TO b_apbb054  #顯示到畫面上

            NEXT FIELD b_apbb054                

            #END add-point
 
 
         #----<<b_apbb051>>----
         #----<<b_apba004>>----
         #----<<b_apba005>>----
         #----<<b_apbb014>>----
         #Ctrlp:construct.c.page1.b_apbb014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apbb014
            #add-point:ON ACTION controlp INFIELD b_apbb014 name="construct.c.page1.b_apbb014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段--幣別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()
            DISPLAY g_qryparam.return1 TO b_apbb014
            NEXT FIELD b_apbb014
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apbb014
            #add-point:BEFORE FIELD b_apbb014 name="construct.b.page1.b_apbb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apbb014
            
            #add-point:AFTER FIELD b_apbb014 name="construct.a.page1.b_apbb014"
            
            #END add-point
            
 
 
         #----<<b_apba105>>----
         #----<<b_apba115>>----
         #----<<b_apbbstus>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apbbstus
            #add-point:BEFORE FIELD b_apbbstus name="construct.b.page1.b_apbbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apbbstus
            
            #add-point:AFTER FIELD b_apbbstus name="construct.a.page1.b_apbbstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apbbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apbbstus
            #add-point:ON ACTION controlp INFIELD b_apbbstus name="construct.c.page1.b_apbbstus"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT g_input.apbb004,g_input.docdt_s,g_input.docdt_e
       FROM apbb004,docdt_s,docdt_e
            ATTRIBUTE(WITHOUT DEFAULTS)

         AFTER FIELD apbb004
            IF NOT cl_null(g_input.apbb004) THEN
               CALL s_fin_account_center_with_ld_chk(g_input.apbb004,'',g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               #抓取法人有哪些
               CALL s_fin_account_center_sons_query('3',g_input.apbb004,g_today,'')
               CALL s_fin_account_center_comp_str() RETURNING g_wc_apcacomp
               CALL s_fin_get_wc_str(g_wc_apcacomp) RETURNING g_wc_apcacomp
               #取得目前給的值
               CALL s_desc_get_department_desc(g_input.apbb004) RETURNING g_input.apbb004_desc
               DISPLAY BY NAME g_input.apbb004_desc
               SELECT ooef017 INTO g_apbbcomp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_input.apbb004 AND ooefstus = 'Y'    #161115-00042#4 add
               CALL s_fin_get_wc_str(g_apbbcomp) RETURNING g_comp_str #161229-00047#22 add 
               CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#22 add 
               #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apbbcomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#4 add  #161229-00047#22 mark
            END IF
         
         #帳務中心
         ON ACTION controlp INFIELD apbb004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.apbb004
            #CALL q_ooef001()     #161006-00005#18   mark
            CALL q_ooef001_46()   #161006-00005#18   add
            LET g_input.apbb004 = g_qryparam.return1
            DISPLAY g_input.apbb004 TO apbb004
            NEXT FIELD apbb004
         
         AFTER FIELD docdt_s
            IF NOT cl_null(g_input.docdt_s) AND NOT cl_null(g_input.docdt_e) THEN
               IF g_input.docdt_s > g_input.docdt_e THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "amm-00081"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.docdt_e = g_input.docdt_s
               END IF
            END IF
            
         AFTER FIELD docdt_e
            IF NOT cl_null(g_input.docdt_s) AND NOT cl_null(g_input.docdt_e) THEN
               IF g_input.docdt_s > g_input.docdt_e THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "amm-00081"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.docdt_s = s_date_get_first_date(g_input.docdt_e)
               END IF
            END IF
         
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
      BEFORE DIALOG
         CALL aapq110_qbe_clear()        
         LET g_wc_table = " apbbstus = 'Y'"
         DISPLAY 'Y' TO b_apbbstus         
      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後 name="query.qbeclear"
         
         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後 name="query.set_qbe_action_after"
         CALL aapq110_qbe_clear()
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
   CALL aapq110_browser_fill('')
   CALL aapq110_fetch1('F')
   #end add-point
        
   LET g_error_show = 1
   CALL aapq110_b_fill()
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
 
{<section id="aapq110.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapq110_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_main_sql      STRING
   DEFINE l_wc_date       STRING
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_apbb014       LIKE apbb_t.apbb014
   DEFINE l_apba105       LIKE apba_t.apba105
   DEFINE l_apba115       LIKE apba_t.apba115
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',apbbcomp,'','',apbbdocdt,apbbdocno,apbb010,apbb012,apbb054,'', 
       '','',apbb014,'','',apbbstus  ,DENSE_RANK() OVER( ORDER BY apbb_t.apbbdocno) AS RANK FROM apbb_t", 
 
 
 
                     "",
                     " WHERE apbbent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("apbb_t"),
                     " ORDER BY apbb_t.apbbdocno"
 
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
 
   LET g_sql = "SELECT '',apbbcomp,'','',apbbdocdt,apbbdocno,apbb010,apbb012,apbb054,'','','',apbb014, 
       '','',apbbstus",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #LET ls_wc = ls_wc," AND ",g_user_dept_wc     #160518-00075#15
   LET l_main_sql = " SELECT 'aapt110',apbbcomp,'',apbb002,apbbdocdt,apbbdocno,apbb010,apbb012,apbb054,",      #151207-00004#1 add apbb010,apbb012,apbb054
                    "        apbb051,apba004,apba005,apbb014,",
                    "        SUM(apba105*apba012) as apba105,SUM(apba115*apba012) as apba115,apbbstus ",          #151207-00004#1 add apbbstus
                    "   FROM apbb_t,apba_t", 
                    "  WHERE apbbent= ? AND apbaent = apbbent AND apbadocno = apbbdocno ",
                    "    AND apbbcomp = '",g_input.apbbcomp,"' AND apbb002 = '",g_input.apbb002,"'",
                   #"    AND apbbstus = 'Y' AND ",ls_wc,       #151207-00004#1 mark
                    "    AND ",g_user_dept_wc,                 #160518-00075#15
                    "    !@# ",   #用!@# 取代日期條件
                    "  GROUP BY apbbcomp,apbb002,apbbdocdt,apbbdocno,apbb051,apba004,apba005,apbb014 ",
                    "           ,apbb010,apbb012,apbb054,apbbstus",     #151207-00004#1
                    " UNION ",
                    " SELECT 'aapt415',apbbcomp,'',apbb002,apeadocdt,apeadocno,apbb010,apbb012,apbb054,",      #151207-00004#1 add apbb010,apbb012,apbb054
                    "        apea003,'','',apbb014,",
                    "        SUM(apeb109)*-1,SUM(apeb119)*-1,apbbstus ",      #151207-00004#1 add apbbstus
                    "   FROM apea_t,apeb_t,apbb_t",
                    "  WHERE apeaent = apebent AND apeadocno = apebdocno",
                    "    AND apebent = apbbent AND apeb003 = apbbdocno",
                    "    AND apeaent = ",g_enterprise,
                   #"    AND apeastus = 'Y'",      #151207-00004#1 mark
                    "    AND apbbcomp = '",g_input.apbbcomp,"'",
                    "    AND apbb002 = '",g_input.apbb002,"'",
                    #161115-00042#4 --s add
                    "   AND EXISTS (SELECT 1 FROM pmaa_t ",
                    "               WHERE pmaaent = ",g_enterprise,
                    "               AND ",g_sql_ctrl,
                    "               AND pmaaent = apbbent ",
                    "               AND pmaa001 = apbb002 ) ",
                    #161115-00042#4 --e add
                   #"    AND ",ls_wc,     #151207-00004#1 mark
                    "    AND ",g_user_dept_wc,  #160518-00075#15
                    "    !@# ",   #用!@# 取代日期條件
                    "  GROUP BY apbbcomp,apbb002,apeadocdt,apeadocno,apea003,apbb014",
                    "           ,apbb010,apbb012,apbb054,apbbstus"     #151207-00004#1
   LET l_wc_date = " AND apbbdocdt BETWEEN '",g_input.docdt_s,"' AND '",g_input.docdt_e,"'"
   CALL s_chr_replace(l_main_sql,'!@#',l_wc_date,1) RETURNING g_sql
   LET l_wc_date = " AND apeadocdt BETWEEN '",g_input.docdt_s,"' AND '",g_input.docdt_e,"'"
   CALL s_chr_replace(g_sql,'!@#',l_wc_date,1) RETURNING g_sql
   #LET g_sql = "SELECT * FROM (",g_sql,") ORDER BY apbbdocdt,apba004"        #151207-00004#1 mark
   #151231-00010#4--(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET ls_wc = ls_wc," AND apbb002 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#4--(E)
 
   LET g_sql = "SELECT * FROM (",g_sql,") WHERE ",ls_wc ," ORDER BY apbbdocdt,apba004"  #151207-00004#1
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapq110_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapq110_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_apbb_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
 
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_apbb_d[l_ac].type1,g_apbb_d[l_ac].apbbcomp,g_apbb_d[l_ac].apbbcomp_desc, 
       g_apbb_d[l_ac].apbb002,g_apbb_d[l_ac].apbbdocdt,g_apbb_d[l_ac].apbbdocno,g_apbb_d[l_ac].apbb010, 
       g_apbb_d[l_ac].apbb012,g_apbb_d[l_ac].apbb054,g_apbb_d[l_ac].apbb051,g_apbb_d[l_ac].apba004,g_apbb_d[l_ac].apba005, 
       g_apbb_d[l_ac].apbb014,g_apbb_d[l_ac].apba105,g_apbb_d[l_ac].apba115,g_apbb_d[l_ac].apbbstus
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_apbb_d[l_ac].statepic = cl_get_actipic(g_apbb_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CASE g_apbb_d[l_ac].type1
           WHEN 'aapt110'
                 LET g_apbb_d[l_ac].apba004 = g_apbb_d[l_ac].apba004,".",s_desc_gzcbl004_desc('8541',g_apbb_d[l_ac].apba004)
           WHEN 'aapt415'
                 LET g_apbb_d[l_ac].apba004 = "B.",s_desc_gzcbl004_desc('9743','B')
      END CASE
      LET g_apbb_d[l_ac].apbb002 = s_desc_show1(g_apbb_d[l_ac].apbb002,s_desc_get_trading_partner_abbr_desc(g_apbb_d[l_ac].apbb002))
      LET g_apbb_d[l_ac].apbb051 = s_desc_show1(g_apbb_d[l_ac].apbb051,s_desc_get_person_desc(g_apbb_d[l_ac].apbb051))
      LET g_apbb_d[l_ac].apbbcomp_desc= s_desc_show1(g_apbb_d[l_ac].apbbcomp,s_desc_get_department_desc(g_apbb_d[l_ac].apbbcomp))  #151207-00004#1
      #end add-point
 
      CALL aapq110_detail_show("'1'")      
 
      CALL aapq110_apbb_t_mask()
 
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
   
 
   
   CALL g_apbb_d.deleteElement(g_apbb_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   #計算期初金額
   IF g_apbb_d.getLength() > 0 THEN
      LET l_wc_date = " AND apbbdocdt < '",g_input.docdt_s,"'"
      CALL s_chr_replace(l_main_sql,'!@#',l_wc_date,1) RETURNING g_sql
      LET l_wc_date = " AND apeadocdt < '",g_input.docdt_s,"'"
      CALL s_chr_replace(g_sql,'!@#',l_wc_date,1) RETURNING g_sql
      
      LET g_sql = " SELECT apbb014,SUM(apba105),SUM(apba115) FROM (",g_sql,") ",
                  "  GROUP BY apbb014"
      PREPARE aapq110_pb1 FROM g_sql
      DECLARE b_fill_curs1 CURSOR FOR aapq110_pb1
      OPEN b_fill_curs1 USING g_enterprise
      LET l_n = 1
      FOREACH b_fill_curs1 INTO l_apbb014,l_apba105,l_apba115
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         #透過insertElement() 寫入期初餘額
         CALL g_apbb_d.insertElement(l_n)
         LET g_apbb_d[l_n].apbb014 = l_apbb014
         LET g_apbb_d[l_n].apba105 = l_apba105
         LET g_apbb_d[l_n].apba115 = l_apba115
         
         #每一筆需要顯示"期初金額"
         LET g_apbb_d[l_n].apba004 = "10.",s_desc_gzcbl004_desc('9743','10')
         
         LET l_n = l_n + 1
      END FOREACH
      #若l_n = 1 表示沒有期初金額，就顯示一筆期初金額=0
      IF l_n = 1 THEN
         CALL g_apbb_d.insertElement(1)
         LET g_apbb_d[1].apba004 = "10.",s_desc_gzcbl004_desc('9743','10')
         LET g_apbb_d[1].apbb014 = ''
         LET g_apbb_d[1].apba105 = 0
         LET g_apbb_d[1].apba115 = 0
      END IF
   END IF
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_apbb_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aapq110_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aapq110_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aapq110_detail_action_trans()
 
   IF g_apbb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aapq110_fetch()
   END IF
   
      CALL aapq110_filter_show('apbbcomp','b_apbbcomp')
   CALL aapq110_filter_show('apbbdocno','b_apbbdocno')
   CALL aapq110_filter_show('apbb010','b_apbb010')
   CALL aapq110_filter_show('apbb012','b_apbb012')
   CALL aapq110_filter_show('apbb054','b_apbb054')
   CALL aapq110_filter_show('apbb014','b_apbb014')
   CALL aapq110_filter_show('apbbstus','b_apbbstus')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   #b_fill()完之後重算筆數
   DISPLAY g_apbb_d1.getLength() TO FORMONLY.h_count
   DISPLAY g_apbb_d.getLength()  TO FORMONLY.cnt     #單身總筆數
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq110.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapq110_fetch()
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
 
{<section id="aapq110.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapq110_detail_show(ps_page)
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

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apbb_d[l_ac].apbbcomp
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_apbb_d[l_ac].apbbcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apbb_d[l_ac].apbbcomp_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq110.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapq110_filter()
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
      CONSTRUCT g_wc_filter ON apbbcomp,apbbdocno,apbb010,apbb012,apbb054,apbb014,apbbstus
                          FROM s_detail1[1].b_apbbcomp,s_detail1[1].b_apbbdocno,s_detail1[1].b_apbb010, 
                              s_detail1[1].b_apbb012,s_detail1[1].b_apbb054,s_detail1[1].b_apbb014,s_detail1[1].b_apbbstus 
 
 
         BEFORE CONSTRUCT
                     DISPLAY aapq110_filter_parser('apbbcomp') TO s_detail1[1].b_apbbcomp
            DISPLAY aapq110_filter_parser('apbbdocno') TO s_detail1[1].b_apbbdocno
            DISPLAY aapq110_filter_parser('apbb010') TO s_detail1[1].b_apbb010
            DISPLAY aapq110_filter_parser('apbb012') TO s_detail1[1].b_apbb012
            DISPLAY aapq110_filter_parser('apbb054') TO s_detail1[1].b_apbb054
            DISPLAY aapq110_filter_parser('apbb014') TO s_detail1[1].b_apbb014
            DISPLAY aapq110_filter_parser('apbbstus') TO s_detail1[1].b_apbbstus
 
 
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<apbbcrtdt>>----
         #AFTER FIELD apbbcrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<apbbmoddt>>----
         #AFTER FIELD apbbmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apbbcnfdt>>----
         #AFTER FIELD apbbcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apbbpstdt>>----
         #AFTER FIELD apbbpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
           
         #單身一般欄位開窗相關處理
                  #----<<type1>>----
         #----<<b_apbbcomp>>----
         #Ctrlp:construct.c.filter.page1.b_apbbcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apbbcomp
            #add-point:ON ACTION controlp INFIELD b_apbbcomp name="construct.c.filter.page1.b_apbbcomp"
            
            #END add-point
 
 
         #----<<b_apbbcomp_desc>>----
         #----<<b_apbb002>>----
         #----<<b_apbbdocdt>>----
         #----<<b_apbbdocno>>----
         #Ctrlp:construct.c.page1.b_apbbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apbbdocno
            #add-point:ON ACTION controlp INFIELD b_apbbdocno name="construct.c.filter.page1.b_apbbdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151231-00010#4--(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " apbb002 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E) 
            #160518-00075#19--s
            IF NOT cl_null(g_user_dept_wc_q) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q
            END IF               
            #160518-00075#19--e            
            CALL q_isamdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apbbdocno  #顯示到畫面上
            NEXT FIELD b_apbbdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_apbb010>>----
         #Ctrlp:construct.c.page1.b_apbb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apbb010
            #add-point:ON ACTION controlp INFIELD b_apbb010 name="construct.c.filter.page1.b_apbb010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isam010()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apbb010  #顯示到畫面上
            NEXT FIELD b_apbb010                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_apbb012>>----
         #Ctrlp:construct.c.page1.b_apbb012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apbb012
            #add-point:ON ACTION controlp INFIELD b_apbb012 name="construct.c.filter.page1.b_apbb012"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apbb012  #顯示到畫面上
            NEXT FIELD b_apbb012                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_apbb054>>----
         #Ctrlp:construct.c.filter.page1.b_apbb054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apbb054
            #add-point:ON ACTION controlp INFIELD b_apbb054 name="construct.c.filter.page1.b_apbb054"
            
            #END add-point
 
 
         #----<<b_apbb051>>----
         #----<<b_apba004>>----
         #----<<b_apba005>>----
         #----<<b_apbb014>>----
         #Ctrlp:construct.c.page1.b_apbb014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apbb014
            #add-point:ON ACTION controlp INFIELD b_apbb014 name="construct.c.filter.page1.b_apbb014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apbb014  #顯示到畫面上
            NEXT FIELD b_apbb014                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_apba105>>----
         #----<<b_apba115>>----
         #----<<b_apbbstus>>----
         #Ctrlp:construct.c.filter.page1.b_apbbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apbbstus
            #add-point:ON ACTION controlp INFIELD b_apbbstus name="construct.c.filter.page1.b_apbbstus"
            
            #END add-point
 
 
   
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      ON ACTION controlp
         CASE
            WHEN INFIELD (b_apbbcomp)
               #開窗c段--法人
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_apcacomp   #161006-00005#18   mark
               LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_cs_comp    #161006-00005#18   add
               CALL q_ooef001()
               DISPLAY g_qryparam.return1 TO b_apbbcomp
               NEXT FIELD b_apbbcomp
            WHEN INFIELD (b_apbb002)
               #開窗c段--供應商
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "('1','3')"
               #151231-00010#4--(S)
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = " apbb002 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
               END IF
               #151231-00010#4--(E)
               CALL q_pmaa001_1()
               DISPLAY g_qryparam.return1 TO b_apbb002
               NEXT FIELD b_apbb002
            WHEN INFIELD (b_apbbdocno)
               #開窗c段--異動單號
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " apbbcomp IN ",g_wc_apcacomp," AND apbbstus = 'Y' AND apbbdocdt BETWEEN '",g_input.docdt_s,"' AND '",g_input.docdt_e,"' AND apbb002 = '",g_input.apbb002,"'"
               #151231-00010#4--(S)
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND apbb002 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
               END IF
               #151231-00010#4--(E)              
               CALL q_apbbdocno()
               DISPLAY g_qryparam.return1 TO b_apbbdocno
               NEXT FIELD b_apbbdocno
            WHEN INFIELD (b_apbb051)
               #開窗c段--人員
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO b_apbb051
               NEXT FIELD b_apbb051
            WHEN INFIELD (b_apba004)
               #開窗c段--來源類型
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_apba004()
               DISPLAY g_qryparam.return1 TO b_apba004
               NEXT FIELD b_apba004
            WHEN INFIELD (b_apbb014)
               #開窗c段--幣別
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooaj002()
               DISPLAY g_qryparam.return1 TO b_apbb014
               NEXT FIELD b_apbb014
         END CASE
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
   
      CALL aapq110_filter_show('apbbcomp','b_apbbcomp')
   CALL aapq110_filter_show('apbbdocno','b_apbbdocno')
   CALL aapq110_filter_show('apbb010','b_apbb010')
   CALL aapq110_filter_show('apbb012','b_apbb012')
   CALL aapq110_filter_show('apbb054','b_apbb054')
   CALL aapq110_filter_show('apbb014','b_apbb014')
   CALL aapq110_filter_show('apbbstus','b_apbbstus')
 
    
   CALL aapq110_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq110.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapq110_filter_parser(ps_field)
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
 
{<section id="aapq110.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapq110_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapq110_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq110.insert" >}
#+ insert
PRIVATE FUNCTION aapq110_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapq110.modify" >}
#+ modify
PRIVATE FUNCTION aapq110_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq110.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aapq110_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq110.delete" >}
#+ delete
PRIVATE FUNCTION aapq110_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq110.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aapq110_detail_action_trans()
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
 
{<section id="aapq110.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aapq110_detail_index_setting()
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
            IF g_apbb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_apbb_d.getLength() AND g_apbb_d.getLength() > 0
            LET g_detail_idx = g_apbb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_apbb_d.getLength() THEN
               LET g_detail_idx = g_apbb_d.getLength()
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
 
{<section id="aapq110.mask_functions" >}
 &include "erp/aap/aapq110_mask.4gl"
 
{</section>}
 
{<section id="aapq110.other_function" readonly="Y" >}

PRIVATE FUNCTION aapq110_browser_fill(ps_page_action)
DEFINE ps_page_action      STRING
DEFINE l_sql               STRING
DEFINE l_sub_sql           STRING
DEFINE ls_wc               STRING
DEFINE l_sql_rank          STRING
   
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

   LET g_sql = " SELECT * FROM ( ",
               "    SELECT DISTINCT apbbcomp,apbb002 ",
               "      FROM apbb_t,apba_t", 
               "     WHERE apbbent= ? AND apbaent = apbbent AND apbadocno = apbbdocno AND apbbcomp IN ",g_wc_apcacomp,
               "       AND apbbstus = 'Y'",
               "       AND apbbdocdt BETWEEN '",g_input.docdt_s,"' AND '",g_input.docdt_e,"'",
               "       AND ",ls_wc,
               "    UNION ",
               "    SELECT DISTINCT apbbcomp,apbb002",
               "      FROM apea_t,apeb_t,apbb_t,apba_t",
               "     WHERE apeaent = apebent AND apeadocno = apebdocno",
               "       AND apebent = apbbent AND apeb003 = apbbdocno",
               "       AND apbbent = apbaent AND apbbdocno = apbadocno",
               "       AND apeaent = ",g_enterprise,
               "       AND apeastus = 'Y'",
               "       AND apbbcomp IN ",g_wc_apcacomp,
               "       AND apeadocdt BETWEEN '",g_input.docdt_s,"' AND '",g_input.docdt_e,"'",
               #161115-00042#4 --s add
               "   AND EXISTS (SELECT 1 FROM pmaa_t ",
               "               WHERE pmaaent = ",g_enterprise,
               "               AND ",g_sql_ctrl,
               "               AND pmaaent = apbbent ",
               "               AND pmaa001 = apbb002 ) ",
               #161115-00042#4 --e add
               "       AND ",ls_wc,
               "  ) ORDER BY apbbcomp,apbb002"
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   CALL g_apbb_d1.clear()
   LET l_ac = 1
   FOREACH browse_cur USING g_enterprise INTO g_apbb_d1[l_ac].apbbcomp,g_apbb_d1[l_ac].apbb002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   

   IF cl_null(g_apbb_d1[l_ac].apbbcomp) THEN
      CALL g_apbb_d1.deleteElement(l_ac)
   END IF
   
   LET g_browser_idx = 1
   LET g_header_cnt  = g_apbb_d1.getLength()
   LET g_browser_cnt = g_apbb_d1.getLength()

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
   
   CALL cl_navigator_setting(g_browser_idx,g_browser_cnt)
   
   LET g_rec_b = l_ac - 1
   LET g_detail_cnt = g_rec_b
   
   FREE browse_pre

END FUNCTION

PRIVATE FUNCTION aapq110_fetch1(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   
   IF g_header_cnt = 0 THEN
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
         
         IF g_jump > 0 AND g_jump <= g_apbb_d.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         
         LET g_no_ask = FALSE  
   END CASE 

   #代表沒有資料
   IF g_current_idx = 0 OR g_apbb_d1.getLength() = 0 THEN
      RETURN
   END IF
   
   IF g_current_idx > g_apbb_d1.getLength() THEN
      LET g_current_idx = g_apbb_d1.getLength()
   END IF
   LET g_input.apbbcomp = g_apbb_d1[g_current_idx].apbbcomp
   LET g_input.apbb002 =  g_apbb_d1[g_current_idx].apbb002
   
   DISPLAY g_current_idx TO FORMONLY.h_index
   DISPLAY g_input.apbbcomp TO apbbcomp
   DISPLAY g_input.apbb002 TO  apbb002
   CALL aapq110_b_fill()
END FUNCTION

PRIVATE FUNCTION aapq110_qbe_clear()
   LET g_input.apbb004 = ''
   LET g_input.docdt_s = s_date_get_first_date(g_today)
   LET g_input.docdt_e = g_today
   
   CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING g_sub_success,g_input.apbb004,g_errno
   #161115-00042#4 --s add
   SELECT ooef017 INTO g_apbbcomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_input.apbb004
      AND ooefstus = 'Y'
   CALL s_fin_get_wc_str(g_apbbcomp) RETURNING g_comp_str #161229-00047#22 add 
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#22 add 
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apbbcomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#22 mark
   #161115-00042#4 --e add
   IF NOT cl_null(g_input.apbb004) THEN
      CALL s_desc_get_department_desc(g_input.apbb004) RETURNING g_input.apbb004_desc
      CALL s_fin_account_center_sons_query('3',g_input.apbb004,g_today,'')
      CALL s_fin_account_center_comp_str() RETURNING g_wc_apcacomp
      CALL s_fin_get_wc_str(g_wc_apcacomp) RETURNING g_wc_apcacomp
      DISPLAY BY NAME g_input.apbb004_desc
   END IF
   
   LET l_ac = 1
   LET g_apbb_d[l_ac].apbbcomp = ''
   DISPLAY ARRAY g_apbb_d TO s_detail1.*
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
END FUNCTION

 
{</section>}
 
