#該程式未解開Section, 採用最新樣板產出!
{<section id="aapq421.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2015-03-25 16:09:50), PR版次:0008(2017-01-13 15:27:53)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000054
#+ Filename...: aapq421
#+ Description: 付款彙整查詢作業
#+ Creator....: 03080(2015-03-19 15:33:34)
#+ Modifier...: 03080 -SD/PR- 04152
 
{</section>}
 
{<section id="aapq421.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#150409-00012#2  2015/04/10             AR沖AP的數據。要再增加 取xrec_t,有作 應付單沖銷的部份。並且【其他調整沖銷】也要表達沖銷金額\表尾的本幣金額合計
#151231-00010#4  2016/01/11 By 02097    增加控制組
#161006-00005#42 2016/10/27 By 08732    組織類型與職能開窗調整
#161108-00017#2  2016/11/09 By Reanna   程式中INSERT INTO 有星號作整批調整
#161115-00042#5  2016/11/17 By 08729    開窗增加過濾據點
#161229-00047#33 2017/01/13 By Reanna   財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
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
PRIVATE TYPE type_g_apda_d RECORD
       #statepic       LIKE type_t.chr1,
       
       apdadocno LIKE apda_t.apdadocno, 
   apdacomp LIKE apda_t.apdacomp, 
   apdacomp_desc LIKE type_t.chr100, 
   apdald LIKE apda_t.apdald, 
   apda005 LIKE apda_t.apda005, 
   apda005_desc LIKE type_t.chr100, 
   l_apde100 LIKE type_t.chr10, 
   l_apce109 LIKE type_t.num20_6, 
   l_apce119 LIKE type_t.num20_6, 
   l_apde109b LIKE type_t.num20_6, 
   l_apde119b LIKE type_t.num20_6, 
   l_apde109c LIKE type_t.num20_6, 
   l_apde119c LIKE type_t.num20_6, 
   l_apde109d LIKE type_t.num20_6, 
   l_apde119d LIKE type_t.num20_6, 
   l_apde109e LIKE type_t.num20_6, 
   l_apde119e LIKE type_t.num20_6, 
   l_apde109f LIKE type_t.num20_6, 
   l_apde119f LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_construct_display    RECORD     #紀錄條件值 重新construct   apda>apca
                              apdacomp   STRING,
                              apdald     STRING,
                              apda005    STRING
                              END RECORD
DEFINE g_wc_apde              STRING     #紀錄apde  construct值
DEFINE g_wc_apca              STRING     #紀錄apda>apca重新construct值
DEFINE g_wc_apca_t            STRING   
DEFINE g_wc_filter2           STRING     #紀錄apda>apca重新construct值(二次查詢)
DEFINE g_wc_filter3           STRING     #紀錄apde  construct值(二次查詢)
DEFINE g_input                RECORD     #輸入年度期別的區間範圍
                              l_yy     LIKE type_t.num5,
                              l_mm     LIKE type_t.num5
                              END RECORD
DEFINE g_sql_ctrl          STRING               #151231-00010#4
DEFINE g_wc_cs_comp        STRING               #161006-00005#42   add
DEFINE g_comp              LIKE glaa_t.glaacomp #161115-00042#5 add
DEFINE g_comp_str          STRING               #161229-00047#33
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_apda_d
DEFINE g_master_t                   type_g_apda_d
DEFINE g_apda_d          DYNAMIC ARRAY OF type_g_apda_d
DEFINE g_apda_d_t        type_g_apda_d
 
      
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
 
{<section id="aapq421.main" >}
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
   #161229-00047#33 mark ------
   ##151231-00010#4--(S)
   #LET g_sql_ctrl = NULL
   ##CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161115-00042#5 mark
   ##161115-00042#5-add(s)
   #SELECT ooef017 INTO g_comp
   #  FROM ooef_t
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = g_site
   #   AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp) RETURNING g_sub_success,g_sql_ctrl
   ##161115-00042#5-add(e)
   ##151231-00010#4--(E)
   #161229-00047#33 mark end---
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
   DECLARE aapq421_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapq421_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapq421_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapq421 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapq421_init()   
 
      #進入選單 Menu (="N")
      CALL aapq421_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapq421
      
   END IF 
   
   CLOSE aapq421_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapq421.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapq421_init()
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
   CALL aapq421_create_tmp()
   CALL s_fin_set_comp_scc('l_yy','43')   #年度
   CALL s_fin_set_comp_scc('l_mm','111')  #期別
   
   #161006-00005#42   add---s
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   #161006-00005#42   add---e
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#33
   #end add-point
 
   CALL aapq421_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aapq421.default_search" >}
PRIVATE FUNCTION aapq421_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " apdald = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " apdadocno = '", g_argv[02], "' AND "
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
 
{<section id="aapq421.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aapq421_ui_dialog()
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
      CALL aapq421_b_fill()
   ELSE
      CALL aapq421_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_apda_d.clear()
 
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
 
         CALL aapq421_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_apda_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aapq421_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aapq421_detail_action_trans()
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
            CALL aapq421_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aapq421_x01(' 1=1','aapq421_x01_tmp')    #畫面的東西轉成XG報表   
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aapq421_x01(' 1=1','aapq421_x01_tmp')    #畫面的東西轉成XG報表   
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapq421_query()
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
            CALL aapq421_filter()
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
            CALL aapq421_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_apda_d)
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
            CALL aapq421_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aapq421_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aapq421_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aapq421_b_fill()
 
         
         
 
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
 
{<section id="aapq421.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapq421_query()
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
   CALL g_apda_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON apdadocno,apdacomp,apdald,apda005
           FROM s_detail1[1].b_apdadocno,s_detail1[1].b_apdacomp,s_detail1[1].b_apdald,s_detail1[1].b_apda005 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_apdadocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apdadocno
            #add-point:BEFORE FIELD b_apdadocno name="construct.b.page1.b_apdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apdadocno
            
            #add-point:AFTER FIELD b_apdadocno name="construct.a.page1.b_apdadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apdadocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apdadocno
            #add-point:ON ACTION controlp INFIELD b_apdadocno name="construct.c.page1.b_apdadocno"
            
            #END add-point
 
 
         #----<<b_apdacomp>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apdacomp
            #add-point:BEFORE FIELD b_apdacomp name="construct.b.page1.b_apdacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apdacomp
            
            #add-point:AFTER FIELD b_apdacomp name="construct.a.page1.b_apdacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apdacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apdacomp
            #add-point:ON ACTION controlp INFIELD b_apdacomp name="construct.c.page1.b_apdacomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooef003 = 'Y' ",
                                   " AND ooef001 IN ",g_wc_cs_comp   #161006-00005#42   add
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO b_apdacomp  #顯示到畫面上
            NEXT FIELD b_apdacomp
            #END add-point
 
 
         #----<<apdacomp_desc>>----
         #----<<b_apdald>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apdald
            #add-point:BEFORE FIELD b_apdald name="construct.b.page1.b_apdald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apdald
            
            #add-point:AFTER FIELD b_apdald name="construct.a.page1.b_apdald"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apdald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apdald
            #add-point:ON ACTION controlp INFIELD b_apdald name="construct.c.page1.b_apdald"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO b_apdald
            NEXT FIELD b_apdald
            #END add-point
 
 
         #----<<b_apda005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apda005
            #add-point:BEFORE FIELD b_apda005 name="construct.b.page1.b_apda005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apda005
            
            #add-point:AFTER FIELD b_apda005 name="construct.a.page1.b_apda005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apda005
            #add-point:ON ACTION controlp INFIELD b_apda005 name="construct.c.page1.b_apda005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161229-00047#33 add ------
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " apca005 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #161229-00047#33 add end---
            CALL q_apca005()
            DISPLAY g_qryparam.return1 TO b_apda005
            NEXT FIELD b_apda005
            #END add-point
 
 
         #----<<apda005_desc>>----
         #----<<l_apde100>>----
         #----<<l_apce109>>----
         #----<<l_apce119>>----
         #----<<l_apde109b>>----
         #----<<l_apde119b>>----
         #----<<l_apde109c>>----
         #----<<l_apde119c>>----
         #----<<l_apde109d>>----
         #----<<l_apde119d>>----
         #----<<l_apde109e>>----
         #----<<l_apde119e>>----
         #----<<l_apde109f>>----
         #----<<l_apde119f>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      #apde的construct
      CONSTRUCT g_wc_apde ON apde100
           FROM s_detail1[1].l_apde100
           
         ON ACTION controlp INFIELD l_apde100
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_apde100  #顯示到畫面上
            NEXT FIELD l_apde100     
      END CONSTRUCT
      
      #年度期別input
      INPUT BY NAME g_input.l_yy,g_input.l_mm
          ATTRIBUTE(WITHOUT DEFAULTS)
      END INPUT
      
      BEFORE DIALOG
         #161229-00047#33 add ------
         LET g_apda_d[1].apdadocno = ""
         DISPLAY ARRAY g_apda_d TO s_detail1.*
           BEFORE DISPLAY
              EXIT DISPLAY
         END DISPLAY
         #161229-00047#33 add end---
         #初入query段的預設值
         CALL aapq421_qbe_clear()
      
      AFTER DIALOG
         #apda>apca的重新construct 正確的抓取直接付款的資料
         LET g_construct_display.apdacomp  =GET_FLDBUF(b_apdacomp)   
         LET g_construct_display.apdald    =GET_FLDBUF(b_apdald)   
         LET g_construct_display.apda005   =GET_FLDBUF(b_apda005)
         IF INT_FLAG THEN
         ELSE
            CONSTRUCT g_wc_apca ON apcacomp,apcald,apca005
                 FROM s_detail1[1].b_apdacomp,s_detail1[1].b_apdald,s_detail1[1].b_apda005 
               BEFORE CONSTRUCT
                    DISPLAY g_construct_display.apdacomp,g_construct_display.apdald,g_construct_display.apda005
                         TO s_detail1[1].b_apdacomp,s_detail1[1].b_apdald,s_detail1[1].b_apda005
                  EXIT CONSTRUCT
            END CONSTRUCT
         END IF 
         LET g_wc_filter2 = ' 1=1'
         LET g_wc_filter3 = ' 1=1'
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
         CALL aapq421_qbe_clear()
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
   CALL aapq421_b_fill()
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
 
{<section id="aapq421.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapq421_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_wc_apca       STRING                             #直接付款段的條件
   DEFINE l_sql           STRING                             
   DEFINE l_apdald        LIKE apda_t.apdald                 #符合條件的全帳別
   DEFINE l_glaa          RECORD                             #抓帳套的會計期間參照表
                          glaa003 LIKE glaa_t.glaa003        
                          END RECORD                         
   DEFINE l_strdat        LIKE type_t.dat                    #抓會計期間起始日
   DEFINE l_enddat        LIKE type_t.dat                    #會計期間截止日
   DEFINE l_tmp           RECORD                             #計算及統計用的temp 
                          apdacomp   LIKE apda_t.apdacomp,   
                          apdald     LIKE apda_t.apdald,
                          apda005    LIKE apda_t.apda005,
                          apde100    LIKE apde_t.apde100,
                          apce109    LIKE apce_t.apce109,
                          apce119    LIKE apce_t.apce119,
                          apde109b   LIKE apde_t.apde109,
                          apde119b   LIKE apde_t.apde119,
                          apde109c   LIKE apde_t.apde109,
                          apde119c   LIKE apde_t.apde119,
                          apde109d   LIKE apde_t.apde109,
                          apde119d   LIKE apde_t.apde119,
                          apde109e   LIKE apde_t.apde109,
                          apde119e   LIKE apde_t.apde119,
                          apde109f   LIKE apde_t.apde109,
                          apde119f   LIKE apde_t.apde119
                          END RECORD
   DEFINE l_apde          RECORD                            #來源資料用record
                          apdacomp  LIKE apda_t.apdacomp,
                          apdald    LIKE apda_t.apdald,
                          apda005   LIKE apda_t.apda005,
                          apda001   LIKE apda_t.apda001,
                          apde002   LIKE apde_t.apde002,
                          apde006   LIKE apde_t.apde006,
                          apde015   LIKE apde_t.apde015,
                          apde100   LIKE apde_t.apde100,
                          apde109   LIKE apde_t.apde109,
                          apde119   LIKE apde_t.apde119                          
                          END RECORD
   DEFINE l_i             LIKE type_t.num10
   
   DEFINE l_x01_tmp       RECORD                            #XG報表用的temp
                          apdacomp LIKE apda_t.apdacomp, 
                          apdacomp_desc LIKE type_t.chr80, 
                          apdald        LIKE apda_t.apdald, 
                          apda005       LIKE apda_t.apda005, 
                          apda005_desc  LIKE type_t.chr80, 
                          apde100       LIKE type_t.chr10, 
                          apce109       LIKE type_t.num20_6, 
                          apce119       LIKE type_t.num20_6, 
                          apde109b      LIKE type_t.num20_6, 
                          apde119b      LIKE type_t.num20_6, 
                          apde109c      LIKE type_t.num20_6, 
                          apde119c      LIKE type_t.num20_6, 
                          apde109d      LIKE type_t.num20_6, 
                          apde119d      LIKE type_t.num20_6, 
                          apde109e      LIKE type_t.num20_6, 
                          apde119e      LIKE type_t.num20_6, 
                          apde109f      LIKE type_t.num20_6, 
                          apde119f      LIKE type_t.num20_6,
                          yy            LIKE type_t.num5,
                          mm            LIKE type_t.num5
                          END RECORD
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
 
   LET ls_sql_rank = "SELECT  UNIQUE apdadocno,apdacomp,'',apdald,apda005,'','','','','','','','','', 
       '','','','',''  ,DENSE_RANK() OVER( ORDER BY apda_t.apdald,apda_t.apdadocno) AS RANK FROM apda_t", 
 
 
 
                     "",
                     " WHERE apdaent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("apda_t"),
                     " ORDER BY apda_t.apdald,apda_t.apdadocno"
 
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
 
   LET g_sql = "SELECT apdadocno,apdacomp,'',apdald,apda005,'','','','','','','','','','','','','',''", 
 
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   IF cl_null(g_wc_filter2) THEN
      LET g_wc_filter2 = " 1=1"
   END IF
   IF cl_null(g_wc_apca) THEN
      LET g_wc_apca = " 1=1"
   END IF
   IF cl_null(g_wc_apde)THEN
      LET g_wc_apde = ' 1=1'
   END IF
   IF cl_null(g_wc_filter3)THEN
      LET g_wc_filter3 = " 1=1"
   END IF
   
   #l_wc_apca = g_wc_apca(重新CONSTRUCT apca_t條件),g_wc_apde(apde100 CONSTRUCT),
   #            g_wc_filter2(重新CONSTRUCT的apca_t二次查詢),g_wc_filter3(apde100 二次查詢)
   LET l_wc_apca = g_wc_apca CLIPPED," AND ",g_wc_apde, 
                   " AND ", g_wc_filter2 CLIPPED," AND ",g_wc_filter3 CLIPPED
   LET ls_wc = ls_wc CLIPPED," AND ",g_wc_apde CLIPPED," AND ",g_wc_filter3 CLIPPED
   
   
   #FOREACH 符合條件的帳別確認會計期別的區間
   LET l_sql = "SELECT DISTINCT apdald FROM apda_t,apde_t ",
               " WHERE apdaent = apdeent ",
               "   AND apdald  = apdeld ",
               "   AND apdadocno = apdedocno ",
               "   AND apdastus = 'Y' ",
               "   AND apdeent = ",g_enterprise," ",
               "   AND ",ls_wc CLIPPED,
               " UNION ",
               "SELECT DISTINCT apcald FROM apca_t,apde_t ",
               " WHERE apcaent = apdeent ",
               "   AND apcald  = apdeld ",
               "   AND apcadocno = apdedocno ",
               "   AND apcastus = 'Y' ",
               "   AND apdeent = ",g_enterprise," ",
               "   AND ",l_wc_apca CLIPPED
   PREPARE sel_apdaldp1 FROM l_sql
   DECLARE sel_apdaldc1 CURSOR FOR sel_apdaldp1
   
   #apda-apde     aapt420付款單身
   LET l_sql = "SELECT apdacomp,apdald,apda005,apda001,apde002,",
               "       apde006,apde015,apde100,apde109,apde119 ",
               "  FROM apda_t,apde_t ",
               " WHERE apdaent = apdeent ",
               "   AND apdald  = apdeld ",
               "   AND apdadocno = apdedocno ",
               "   AND apdaent = ",g_enterprise," ",
               "   AND apda001 = '45' ",
               "   AND apdastus = 'Y' ",
               "   AND apdald = ?     ", 
               "   AND apdadocdt BETWEEN ? AND ? ",
               "   AND ",ls_wc CLIPPED
   PREPARE sel_apdep1 FROM l_sql
   DECLARE sel_apdec1 CURSOR FOR sel_apdep1

   #apda-apce      aapt420帳款單身
   LET l_sql = "SELECT apdacomp,apdald,apda005,apda001,apce002,",
               "       apce006,apce015,apce100,apce109,apce119 ",
               "  FROM apda_t,apce_t ",
               " WHERE apdaent = apceent ",
               "   AND apdald  = apceld ",
               "   AND apdadocno = apcedocno ",
               "   AND apdaent = ",g_enterprise," ",
               "   AND apda001 = '45' ",
               "   AND apdastus = 'Y' ",
               "   AND apdald = ? AND apce002 LIKE '4%' ", #150409-00012
               "   AND apdadocdt BETWEEN ? AND ? ",
               "   AND ",ls_wc CLIPPED
   PREPARE sel_apcep1 FROM l_sql
   DECLARE sel_apcec1 CURSOR FOR sel_apcep1
   
   #xrda-xrce axct400帳款單身  #150409-00012
   LET l_sql = "SELECT xrdacomp,xrdald,xrda005,xrda001,xrce002,",
               "       xrce006,xrce015,xrce100,xrce109,xrce119 ",
               "  FROM xrda_t,xrce_t ",
               " WHERE xrdaent = xrceent ",
               "   AND xrdald  = xrceld ",
               "   AND xrdadocno = xrcedocno ",
               "   AND xrdaent = ",g_enterprise," ",
               "   AND xrda001 = '41' ",
               "   AND xrdastus = 'Y' ",
               "   AND xrdald = ? AND xrce002 LIKE '4%'  ",
               "   AND xrdadocdt BETWEEN ? AND ? ",
               "   AND ",ls_wc CLIPPED
   PREPARE sel_xrcep1 FROM l_sql
   DECLARE sel_xrcec1 CURSOR FOR sel_xrcep1
    #150409-00012
   
   
   #apca-apde       直接沖銷
   LET l_sql = "SELECT apcacomp,apcald,apca005,apca001,apde002,",
               "       apde006,apde015,apde100,apde109,apde119 ",
               "  FROM apca_t,apde_t ",
               " WHERE apcaent = apdeent ",
               "   AND apcald  = apdeld ",
               "   AND apcadocno = apdedocno ",
               "   AND apcaent = ",g_enterprise," ",
               "   AND apcastus = 'Y' ",
               "   AND apcald = ? ",
               "   AND apcadocdt BETWEEN ? AND ? ",
               "   AND ",l_wc_apca CLIPPED
   PREPARE sel_apdep2 FROM l_sql
   DECLARE sel_apdec2 CURSOR FOR sel_apdep2
   
   
   DELETE FROM aapq421_tmp
   FOREACH sel_apdaldc1 INTO l_apdald
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      #取會計期別頭尾日
      LET l_glaa.glaa003 = NULL
      SELECT glaa003 INTO l_glaa.glaa003 FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald  = l_apdald
      IF NOT cl_null(l_glaa.glaa003)THEN
         CALL s_fin_date_get_period_range(l_glaa.glaa003,g_input.l_yy,g_input.l_mm)
            RETURNING l_strdat,l_enddat
      END IF
      
      IF NOT cl_null(l_strdat) AND NOT cl_null(l_enddat)THEN
         #apda-apde
         FOREACH sel_apdec1 USING l_apdald,l_strdat,l_enddat
                            INTO l_apde.*
            IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
            
            #依借貸別判斷正負
            #付款單身C+D-
            IF l_apde.apde015 = 'C' THEN
            ELSE
               LET l_apde.apde109 = l_apde.apde109 * -1
               LET l_apde.apde119 = l_apde.apde119 * -1
            END IF
            
            INITIALIZE l_tmp.* TO NULL
            LET l_tmp.apdacomp = l_apde.apdacomp
            LET l_tmp.apdald   = l_apde.apdald
            LET l_tmp.apda005  = l_apde.apda005
            LET l_tmp.apde100  = l_apde.apde100
            CASE
               WHEN l_apde.apde002 = '10' AND l_apde.apde006 = '30'
                  #票據支付
                  LET l_tmp.apde109b = l_apde.apde109
                  LET l_tmp.apde119b = l_apde.apde119
               WHEN l_apde.apde002 = '10' AND l_apde.apde006 = '20'
                  #電匯款支付   
                  LET l_tmp.apde109c = l_apde.apde109
                  LET l_tmp.apde119c = l_apde.apde119
               WHEN l_apde.apde002 = '10' AND l_apde.apde006 = '10'
                  #現金支付
                  LET l_tmp.apde109d = l_apde.apde109
                  LET l_tmp.apde119d = l_apde.apde119
               WHEN l_apde.apde002 = '10'
                  #其他付款
                  LET l_tmp.apde109e = l_apde.apde109
                  LET l_tmp.apde119e = l_apde.apde119
               OTHERWISE
                  #其他沖銷
                  LET l_tmp.apde109f = l_apde.apde109
                  LET l_tmp.apde119f = l_apde.apde119
            END CASE
            LET l_tmp.apce109 = 0 
            LET l_tmp.apce119 = 0 
            IF cl_null(l_tmp.apde109b)THEN LET l_tmp.apde109b = 0 END IF
            IF cl_null(l_tmp.apde119b)THEN LET l_tmp.apde119b = 0 END IF
            IF cl_null(l_tmp.apde109c)THEN LET l_tmp.apde109c = 0 END IF
            IF cl_null(l_tmp.apde119c)THEN LET l_tmp.apde119c = 0 END IF
            IF cl_null(l_tmp.apde109d)THEN LET l_tmp.apde109d = 0 END IF
            IF cl_null(l_tmp.apde119d)THEN LET l_tmp.apde119d = 0 END IF
            IF cl_null(l_tmp.apde109e)THEN LET l_tmp.apde109e = 0 END IF
            IF cl_null(l_tmp.apde119e)THEN LET l_tmp.apde119e = 0 END IF
            IF cl_null(l_tmp.apde109f)THEN LET l_tmp.apde109f = 0 END IF
            IF cl_null(l_tmp.apde119f)THEN LET l_tmp.apde119f = 0 END IF
            #INSERT INTO aapq421_tmp VALUES(l_tmp.*,g_enterprise) #161108-00017#2 mark
            #161108-00017#2 add ------
            INSERT INTO aapq421_tmp (apdacomp,apdald,apda005,apde100,apce109,
                                     apce119,apde109b,apde119b,apde109c,apde119c,
                                     apde109d,apde119d,apde109e,apde119e,apde109f,
                                     apde119f,ent
                                    )
            VALUES (l_tmp.apdacomp,l_tmp.apdald,l_tmp.apda005,l_tmp.apde100,l_tmp.apce109,
                    l_tmp.apce119,l_tmp.apde109b,l_tmp.apde119b,l_tmp.apde109c,l_tmp.apde119c,
                    l_tmp.apde109d,l_tmp.apde119d,l_tmp.apde109e,l_tmp.apde119e,l_tmp.apde109f,
                    l_tmp.apde119f,g_enterprise
                   )
            #161108-00017#2 add end---
         END FOREACH
         #apda-apce
         FOREACH sel_apcec1 USING l_apdald,l_strdat,l_enddat
                            INTO l_apde.*
            IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
            
            #依借貸別判斷正負
            #帳款單身D+C-
            IF l_apde.apde015 = 'D' THEN
            ELSE
               LET l_apde.apde109 = l_apde.apde109 * -1
               LET l_apde.apde119 = l_apde.apde119 * -1
            END IF
            
            INITIALIZE l_tmp.* TO NULL
            LET l_tmp.apdacomp = l_apde.apdacomp
            LET l_tmp.apdald   = l_apde.apdald
            LET l_tmp.apda005  = l_apde.apda005
            LET l_tmp.apde100  = l_apde.apde100
            LET l_tmp.apce109 = l_apde.apde109 
            LET l_tmp.apce119 = l_apde.apde119
            IF cl_null(l_tmp.apde109b)THEN LET l_tmp.apde109b = 0 END IF
            IF cl_null(l_tmp.apde119b)THEN LET l_tmp.apde119b = 0 END IF
            IF cl_null(l_tmp.apde109c)THEN LET l_tmp.apde109c = 0 END IF
            IF cl_null(l_tmp.apde119c)THEN LET l_tmp.apde119c = 0 END IF
            IF cl_null(l_tmp.apde109d)THEN LET l_tmp.apde109d = 0 END IF
            IF cl_null(l_tmp.apde119d)THEN LET l_tmp.apde119d = 0 END IF
            IF cl_null(l_tmp.apde109e)THEN LET l_tmp.apde109e = 0 END IF
            IF cl_null(l_tmp.apde119e)THEN LET l_tmp.apde119e = 0 END IF
            IF cl_null(l_tmp.apde109f)THEN LET l_tmp.apde109f = 0 END IF
            IF cl_null(l_tmp.apde119f)THEN LET l_tmp.apde119f = 0 END IF
            #INSERT INTO aapq421_tmp VALUES(l_tmp.*,g_enterprise) #161108-00017#2 mark
            #161108-00017#2 add ------
            INSERT INTO aapq421_tmp (apdacomp,apdald,apda005,apde100,apce109,
                                     apce119,apde109b,apde119b,apde109c,apde119c,
                                     apde109d,apde119d,apde109e,apde119e,apde109f,
                                     apde119f,ent
                                    )
            VALUES (l_tmp.apdacomp,l_tmp.apdald,l_tmp.apda005,l_tmp.apde100,l_tmp.apce109,
                    l_tmp.apce119,l_tmp.apde109b,l_tmp.apde119b,l_tmp.apde109c,l_tmp.apde119c,
                    l_tmp.apde109d,l_tmp.apde119d,l_tmp.apde109e,l_tmp.apde119e,l_tmp.apde109f,
                    l_tmp.apde119f,g_enterprise
                   )
            #161108-00017#2 add end---
         END FOREACH        

         #xrda-xrce #
         FOREACH sel_xrcec1 USING l_apdald,l_strdat,l_enddat
                            INTO l_apde.*
            IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
            
            #依借貸別判斷正負
            #帳款單身D+C-
            IF l_apde.apde015 = 'D' THEN
            ELSE
               LET l_apde.apde109 = l_apde.apde109 * -1
               LET l_apde.apde119 = l_apde.apde119 * -1
            END IF
            
            INITIALIZE l_tmp.* TO NULL
            LET l_tmp.apdacomp  = l_apde.apdacomp
            LET l_tmp.apdald    = l_apde.apdald
            LET l_tmp.apda005   = l_apde.apda005
            LET l_tmp.apde100   = l_apde.apde100
            LET l_tmp.apde109f  = l_apde.apde109                 
            LET l_tmp.apde119f  = l_apde.apde119
            IF cl_null(l_tmp.apde109b)THEN LET l_tmp.apde109b = 0 END IF
            IF cl_null(l_tmp.apde119b)THEN LET l_tmp.apde119b = 0 END IF
            IF cl_null(l_tmp.apde109c)THEN LET l_tmp.apde109c = 0 END IF
            IF cl_null(l_tmp.apde119c)THEN LET l_tmp.apde119c = 0 END IF
            IF cl_null(l_tmp.apde109d)THEN LET l_tmp.apde109d = 0 END IF
            IF cl_null(l_tmp.apde119d)THEN LET l_tmp.apde119d = 0 END IF
            IF cl_null(l_tmp.apde109e)THEN LET l_tmp.apde109e = 0 END IF
            IF cl_null(l_tmp.apde119e)THEN LET l_tmp.apde119e = 0 END IF                       
            IF cl_null(l_tmp.apce109)THEN  LET l_tmp.apce109 = 0 END IF
            IF cl_null(l_tmp.apce119)THEN  LET l_tmp.apce119 = 0 END IF
            #INSERT INTO aapq421_tmp VALUES(l_tmp.*,g_enterprise) #161108-00017#2 mark
            #161108-00017#2 add ------
            INSERT INTO aapq421_tmp (apdacomp,apdald,apda005,apde100,apce109,
                                     apce119,apde109b,apde119b,apde109c,apde119c,
                                     apde109d,apde119d,apde109e,apde119e,apde109f,
                                     apde119f,ent
                                    )
            VALUES (l_tmp.apdacomp,l_tmp.apdald,l_tmp.apda005,l_tmp.apde100,l_tmp.apce109,
                    l_tmp.apce119,l_tmp.apde109b,l_tmp.apde119b,l_tmp.apde109c,l_tmp.apde119c,
                    l_tmp.apde109d,l_tmp.apde119d,l_tmp.apde109e,l_tmp.apde119e,l_tmp.apde109f,
                    l_tmp.apde119f,g_enterprise
                   )
            #161108-00017#2 add end---
         END FOREACH   
         
         #apca-apce
         FOREACH sel_apdec2 USING l_apdald,l_strdat,l_enddat
                            INTO l_apde.*
            IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
            
            #依借貸別判斷正負
            #依帳款性質決定是否*-1 0起頭的要反轉 要判斷8502決定是否反轉
            IF l_apde.apda001 MATCHES '0[1-9]' THEN
               IF l_apde.apde015 = 'D' THEN
               ELSE
                  LET l_apde.apde109 = l_apde.apde109 * -1
                  LET l_apde.apde119 = l_apde.apde119 * -1
               END IF            
            ELSE
               IF l_apde.apde015 = 'C' THEN
               ELSE
                  LET l_apde.apde109 = l_apde.apde109 * -1
                  LET l_apde.apde119 = l_apde.apde119 * -1
               END IF
            END IF

            INITIALIZE l_tmp.* TO NULL
            LET l_tmp.apdacomp = l_apde.apdacomp
            LET l_tmp.apdald   = l_apde.apdald
            LET l_tmp.apda005  = l_apde.apda005
            LET l_tmp.apde100  = l_apde.apde100
            CASE
               WHEN l_apde.apde002 = '10' AND l_apde.apde006 = '30'
                  #票據支付
                  LET l_tmp.apde109b = l_apde.apde109
                  LET l_tmp.apde119b = l_apde.apde119
               WHEN l_apde.apde002 = '10' AND l_apde.apde006 = '20'
                  #電匯款支付   
                  LET l_tmp.apde109c = l_apde.apde109
                  LET l_tmp.apde119c = l_apde.apde119
               WHEN l_apde.apde002 = '10' AND l_apde.apde006 = '10'
                  #現金支付
                  LET l_tmp.apde109d = l_apde.apde109
                  LET l_tmp.apde119d = l_apde.apde119
               WHEN l_apde.apde002 = '10'
                  #其他付款
                  LET l_tmp.apde109e = l_apde.apde109
                  LET l_tmp.apde119e = l_apde.apde119
               OTHERWISE
                  #其他沖銷
                  LET l_tmp.apde109f = l_apde.apde109
                  LET l_tmp.apde119f = l_apde.apde119
            END CASE
            LET l_tmp.apce109 = l_apde.apde109
            LET l_tmp.apce119 = l_apde.apde119
            IF cl_null(l_tmp.apde109b)THEN LET l_tmp.apde109b = 0 END IF
            IF cl_null(l_tmp.apde119b)THEN LET l_tmp.apde119b = 0 END IF
            IF cl_null(l_tmp.apde109c)THEN LET l_tmp.apde109c = 0 END IF
            IF cl_null(l_tmp.apde119c)THEN LET l_tmp.apde119c = 0 END IF
            IF cl_null(l_tmp.apde109d)THEN LET l_tmp.apde109d = 0 END IF
            IF cl_null(l_tmp.apde119d)THEN LET l_tmp.apde119d = 0 END IF
            IF cl_null(l_tmp.apde109e)THEN LET l_tmp.apde109e = 0 END IF
            IF cl_null(l_tmp.apde119e)THEN LET l_tmp.apde119e = 0 END IF
            IF cl_null(l_tmp.apde109f)THEN LET l_tmp.apde109f = 0 END IF
            IF cl_null(l_tmp.apde119f)THEN LET l_tmp.apde119f = 0 END IF
            #INSERT INTO aapq421_tmp VALUES(l_tmp.*,g_enterprise) #161108-00017#2 mark
            #161108-00017#2 add ------
            INSERT INTO aapq421_tmp (apdacomp,apdald,apda005,apde100,apce109,
                                     apce119,apde109b,apde119b,apde109c,apde119c,
                                     apde109d,apde119d,apde109e,apde119e,apde109f,
                                     apde119f,ent
                                    )
            VALUES (l_tmp.apdacomp,l_tmp.apdald,l_tmp.apda005,l_tmp.apde100,l_tmp.apce109,
                    l_tmp.apce119,l_tmp.apde109b,l_tmp.apde119b,l_tmp.apde109c,l_tmp.apde119c,
                    l_tmp.apde109d,l_tmp.apde119d,l_tmp.apde109e,l_tmp.apde119e,l_tmp.apde109f,
                    l_tmp.apde119f,g_enterprise
                   )
            #161108-00017#2 add end---
         END FOREACH
      END IF
   END FOREACH
   #151231-00010#4--(S)
   LET ls_wc = NULL
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET ls_wc = " AND apda005 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#4--(E)
   LET g_sql = "SELECT '',apdacomp,'',apdald,apda005,'',apde100,",
               "       SUM(apce109),SUM(apce119),SUM(apde109b),SUM(apde119b), ",
               "       SUM(apde109c),SUM(apde119c),SUM(apde109d),SUM(apde119d),",
               "       SUM(apde109e),SUM(apde119e),SUM(apde109f),SUM(apde119f) ",
               "  FROM aapq421_tmp ",
               " WHERE ent = ? ",ls_wc,   #151231-00010#4 add ls_wc
               " GROUP BY apdacomp,apdald,apda005,apde100 "
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapq421_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapq421_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_apda_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
    
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_apda_d[l_ac].apdadocno,g_apda_d[l_ac].apdacomp,g_apda_d[l_ac].apdacomp_desc, 
       g_apda_d[l_ac].apdald,g_apda_d[l_ac].apda005,g_apda_d[l_ac].apda005_desc,g_apda_d[l_ac].l_apde100, 
       g_apda_d[l_ac].l_apce109,g_apda_d[l_ac].l_apce119,g_apda_d[l_ac].l_apde109b,g_apda_d[l_ac].l_apde119b, 
       g_apda_d[l_ac].l_apde109c,g_apda_d[l_ac].l_apde119c,g_apda_d[l_ac].l_apde109d,g_apda_d[l_ac].l_apde119d, 
       g_apda_d[l_ac].l_apde109e,g_apda_d[l_ac].l_apde119e,g_apda_d[l_ac].l_apde109f,g_apda_d[l_ac].l_apde119f 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_apda_d[l_ac].statepic = cl_get_actipic(g_apda_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aapq421_detail_show("'1'")      
 
      CALL aapq421_apda_t_mask()
 
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
   
 
   
   CALL g_apda_d.deleteElement(g_apda_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   #依畫面資料INSERT XG_tmp 
   DELETE FROM aapq421_x01_tmp
   FOR l_i = 1 TO g_apda_d.getLength()
      INITIALIZE l_x01_tmp.* TO NULL
      LET l_x01_tmp.apdacomp      = g_apda_d[l_i].apdacomp
      LET l_x01_tmp.apdacomp_desc = g_apda_d[l_i].apdacomp_desc
      LET l_x01_tmp.apdald        = g_apda_d[l_i].apdald 
      LET l_x01_tmp.apda005       = g_apda_d[l_i].apda005 
      LET l_x01_tmp.apda005_desc  = g_apda_d[l_i].apda005_desc
      LET l_x01_tmp.apde100       = g_apda_d[l_i].l_apde100 
      LET l_x01_tmp.apce109       = g_apda_d[l_i].l_apce109 
      LET l_x01_tmp.apce119       = g_apda_d[l_i].l_apce119 
      LET l_x01_tmp.apde109b      = g_apda_d[l_i].l_apde109b
      LET l_x01_tmp.apde119b      = g_apda_d[l_i].l_apde119b
      LET l_x01_tmp.apde109c      = g_apda_d[l_i].l_apde109c 
      LET l_x01_tmp.apde119c      = g_apda_d[l_i].l_apde119c 
      LET l_x01_tmp.apde109d      = g_apda_d[l_i].l_apde109d
      LET l_x01_tmp.apde119d      = g_apda_d[l_i].l_apde119d 
      LET l_x01_tmp.apde109e      = g_apda_d[l_i].l_apde109e  
      LET l_x01_tmp.apde119e      = g_apda_d[l_i].l_apde119e 
      LET l_x01_tmp.apde109f      = g_apda_d[l_i].l_apde109f
      LET l_x01_tmp.apde119f      = g_apda_d[l_i].l_apde119f 
      LET l_x01_tmp.yy            = g_input.l_yy
      LET l_x01_tmp.mm            = g_input.l_mm
      #INSERT INTO aapq421_x01_tmp VALUES(l_x01_tmp.*) #161108-00017#2 mark
      #161108-00017#2 add ------
      INSERT INTO aapq421_x01_tmp (apdacomp,apdacomp_desc,apdald,apda005,apda005_desc,
                                   apde100,apce109,apce119,apde109b,apde119b,
                                   apde109c,apde119c,apde109d,apde119d,apde109e,
                                   apde119e,apde109f,apde119f,yy,mm
                                  )
      VALUES (l_x01_tmp.apdacomp,l_x01_tmp.apdacomp_desc,l_x01_tmp.apdald,l_x01_tmp.apda005,l_x01_tmp.apda005_desc,
              l_x01_tmp.apde100,l_x01_tmp.apce109,l_x01_tmp.apce119,l_x01_tmp.apde109b,l_x01_tmp.apde119b,
              l_x01_tmp.apde109c,l_x01_tmp.apde119c,l_x01_tmp.apde109d,l_x01_tmp.apde119d,l_x01_tmp.apde109e,
              l_x01_tmp.apde119e,l_x01_tmp.apde109f,l_x01_tmp.apde119f,l_x01_tmp.yy,l_x01_tmp.mm
             )
      #161108-00017#2 add end---
   END FOR
   #end add-point
 
   LET g_detail_cnt = g_apda_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aapq421_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aapq421_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aapq421_detail_action_trans()
 
   IF g_apda_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aapq421_fetch()
   END IF
   
      CALL aapq421_filter_show('apdadocno','b_apdadocno')
   CALL aapq421_filter_show('apdacomp','b_apdacomp')
   CALL aapq421_filter_show('apdald','b_apdald')
   CALL aapq421_filter_show('apda005','b_apda005')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq421.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapq421_fetch()
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
 
{<section id="aapq421.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapq421_detail_show(ps_page)
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
      LET g_apda_d[l_ac].apda005_desc = s_desc_get_trading_partner_abbr_desc(g_apda_d[l_ac].apda005)
      LET g_apda_d[l_ac].apdacomp_desc = s_desc_get_department_desc(g_apda_d[l_ac].apdacomp)
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq421.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapq421_filter()
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
      CONSTRUCT g_wc_filter ON apdadocno,apdacomp,apdald,apda005
                          FROM s_detail1[1].b_apdadocno,s_detail1[1].b_apdacomp,s_detail1[1].b_apdald, 
                              s_detail1[1].b_apda005
 
         BEFORE CONSTRUCT
                     DISPLAY aapq421_filter_parser('apdadocno') TO s_detail1[1].b_apdadocno
            DISPLAY aapq421_filter_parser('apdacomp') TO s_detail1[1].b_apdacomp
            DISPLAY aapq421_filter_parser('apdald') TO s_detail1[1].b_apdald
            DISPLAY aapq421_filter_parser('apda005') TO s_detail1[1].b_apda005
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_apdadocno>>----
         #Ctrlp:construct.c.filter.page1.b_apdadocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apdadocno
            #add-point:ON ACTION controlp INFIELD b_apdadocno name="construct.c.filter.page1.b_apdadocno"
            
            #END add-point
 
 
         #----<<b_apdacomp>>----
         #Ctrlp:construct.c.filter.page1.b_apdacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apdacomp
            #add-point:ON ACTION controlp INFIELD b_apdacomp name="construct.c.filter.page1.b_apdacomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooef003 = 'Y' ",
                                   " AND ooef001 IN ",g_wc_cs_comp #161006-00005#42 add
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO b_apdacomp  #顯示到畫面上
            NEXT FIELD b_apdacomp
            #END add-point
 
 
         #----<<apdacomp_desc>>----
         #----<<b_apdald>>----
         #Ctrlp:construct.c.filter.page1.b_apdald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apdald
            #add-point:ON ACTION controlp INFIELD b_apdald name="construct.c.filter.page1.b_apdald"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO b_apdald
            NEXT FIELD b_apdald
            #END add-point
 
 
         #----<<b_apda005>>----
         #Ctrlp:construct.c.filter.page1.b_apda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apda005
            #add-point:ON ACTION controlp INFIELD b_apda005 name="construct.c.filter.page1.b_apda005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#4--(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " apca005 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            CALL q_apca005()
            DISPLAY g_qryparam.return1 TO b_apda005
            NEXT FIELD b_apda005
            #END add-point
 
 
         #----<<apda005_desc>>----
         #----<<l_apde100>>----
         #----<<l_apce109>>----
         #----<<l_apce119>>----
         #----<<l_apde109b>>----
         #----<<l_apde119b>>----
         #----<<l_apde109c>>----
         #----<<l_apde119c>>----
         #----<<l_apde109d>>----
         #----<<l_apde119d>>----
         #----<<l_apde109e>>----
         #----<<l_apde119e>>----
         #----<<l_apde109f>>----
         #----<<l_apde119f>>----
   
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      CONSTRUCT g_wc_filter3 ON apde100
           FROM s_detail1[1].l_apde100
      END CONSTRUCT   
   
      AFTER DIALOG
         LET g_construct_display.apdacomp  =GET_FLDBUF(b_apdacomp)   
         LET g_construct_display.apdald    =GET_FLDBUF(b_apdald)   
         LET g_construct_display.apda005   =GET_FLDBUF(b_apda005)
         IF INT_FLAG THEN
         ELSE
            CONSTRUCT g_wc_filter2 ON apcacomp,apcald,apca005
                 FROM s_detail1[1].b_apdacomp,s_detail1[1].b_apdald,s_detail1[1].b_apda005 
               BEFORE CONSTRUCT
                    DISPLAY g_construct_display.apdacomp,g_construct_display.apdald,g_construct_display.apda005
                         TO s_detail1[1].b_apdacomp,s_detail1[1].b_apdald,s_detail1[1].b_apda005
                  EXIT CONSTRUCT
            END CONSTRUCT
            IF cl_null(g_wc_filter3)THEN LET g_wc_filter3 = ' 1=1' END IF
         END IF


      ON ACTION controlp 
         CASE
            WHEN INFIELD(b_apdacomp)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "ooef003 = 'Y' ",
                                      " AND ooef001 IN ",g_wc_cs_comp   #161006-00005#42   add
               CALL q_ooef001()
               DISPLAY g_qryparam.return1 TO b_apdacomp  #顯示到畫面上
               NEXT FIELD b_apdacomp

            WHEN INFIELD(b_apdald)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_grup
               CALL q_authorised_ld()
               DISPLAY g_qryparam.return1 TO b_apdald
               NEXT FIELD b_apdald
            WHEN INFIELD(b_apda005)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_apca005()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_apda005  #顯示到畫面上
               NEXT FIELD b_apda005
            WHEN INFIELD(l_apde100)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooai001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO l_apde100  #顯示到畫面上
               NEXT FIELD l_apde100   
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
   
      CALL aapq421_filter_show('apdadocno','b_apdadocno')
   CALL aapq421_filter_show('apdacomp','b_apdacomp')
   CALL aapq421_filter_show('apdald','b_apdald')
   CALL aapq421_filter_show('apda005','b_apda005')
 
    
   CALL aapq421_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq421.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapq421_filter_parser(ps_field)
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
 
{<section id="aapq421.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapq421_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapq421_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq421.insert" >}
#+ insert
PRIVATE FUNCTION aapq421_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapq421.modify" >}
#+ modify
PRIVATE FUNCTION aapq421_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq421.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aapq421_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq421.delete" >}
#+ delete
PRIVATE FUNCTION aapq421_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq421.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aapq421_detail_action_trans()
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
 
{<section id="aapq421.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aapq421_detail_index_setting()
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
            IF g_apda_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_apda_d.getLength() AND g_apda_d.getLength() > 0
            LET g_detail_idx = g_apda_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_apda_d.getLength() THEN
               LET g_detail_idx = g_apda_d.getLength()
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
 
{<section id="aapq421.mask_functions" >}
 &include "erp/aap/aapq421_mask.4gl"
 
{</section>}
 
{<section id="aapq421.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Date & Author..: 150319 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq421_create_tmp()
   #資料分類
   #1.aapt420   沖銷   付款單身apde資料   1對1   依分類給特定欄位值(tmp中apde109b~f,apde119b~f)
   #2.aapt420   沖銷   帳款單身apce資料   1對1   依apce002給正負值但都放在tmp apce109,apce119
   #3.aapt3*    直接付款      apde資料    1對1   依分類給特定欄位值(tmp中apde109b~f,apde119b~f)
   #                                     apce109,apce119給相同金額 為了讓帳款跟沖銷合計數看起來相等
   
   DROP TABLE aapq421_tmp;
   CREATE TEMP TABLE aapq421_tmp(
      apdacomp    VARCHAR(10),
      apdald      VARCHAR(5),
      apda005     VARCHAR(10),
      apde100     VARCHAR(10),
      apce109     DECIMAL(20,6),
      apce119     DECIMAL(20,6),
      apde109b    DECIMAL(20,6),
      apde119b    DECIMAL(20,6),
      apde109c    DECIMAL(20,6),
      apde119c    DECIMAL(20,6),
      apde109d    DECIMAL(20,6),
      apde119d    DECIMAL(20,6),
      apde109e    DECIMAL(20,6),
      apde119e    DECIMAL(20,6),
      apde109f    DECIMAL(20,6),
      apde119f    DECIMAL(20,6),
      ent         SMALLINT
   )
   
   DROP TABLE aapq421_x01_tmp;
   CREATE TEMP TABLE aapq421_x01_tmp(
      apdacomp  VARCHAR(10), 
      apdacomp_desc  VARCHAR(80), 
      apdald         VARCHAR(5), 
      apda005        VARCHAR(10), 
      apda005_desc   VARCHAR(80), 
      apde100        VARCHAR(10), 
      apce109        DECIMAL(20,6), 
      apce119        DECIMAL(20,6), 
      apde109b       DECIMAL(20,6), 
      apde119b       DECIMAL(20,6), 
      apde109c       DECIMAL(20,6), 
      apde119c       DECIMAL(20,6), 
      apde109d       DECIMAL(20,6), 
      apde119d       DECIMAL(20,6), 
      apde109e       DECIMAL(20,6), 
      apde119e       DECIMAL(20,6), 
      apde109f       DECIMAL(20,6), 
      apde119f       DECIMAL(20,6),
      yy             SMALLINT,
      mm             SMALLINT
   )
   
END FUNCTION

################################################################################
# Descriptions...: construct段預設值
# Memo...........:
# Date & Author..: 150319 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq421_qbe_clear()
   LET g_input.l_yy = YEAR(g_today)
   LET g_input.l_mm = MONTH(g_today)
   DISPLAY BY NAME g_input.l_yy,g_input.l_mm
END FUNCTION

 
{</section>}
 
