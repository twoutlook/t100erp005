#該程式未解開Section, 採用最新樣板產出!
{<section id="aapq360.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:20(2017-01-18 11:20:56), PR版次:0020(2017-02-13 13:27:53)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000119
#+ Filename...: aapq360
#+ Description: 應付帳款清單查詢作業
#+ Creator....: 04152(2015-01-27 17:45:43)
#+ Modifier...: 06694 -SD/PR- 06821
 
{</section>}
 
{<section id="aapq360.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151013-00019#10 2015/11/11 By Reanna   單身加合計
#151124-00022#1  2015/11/25 By Hans     單身開放QBE(原幣應付,己付,未付,本幣應付,己付)
#151231-00010#4  2016/01/11 By 02097    增加控制組
#160425-00024#4  2016/04/27 By 02097    l_wc_ctrl为空应给" 1=1"
#160414-00018#36 2016/05/03 By Reanna   執行效能程式調整
#160518-00075#14 2016/07/24 By 03538    使用元件取得aooi200的限制人員/限制部門取用單別並加以限制範圍
#160518-00075#26 2016/08/01 By 03538    因應元件改變傳入參數為帳套欄位編號
#160812-00027#2  2016/08/16 By 06821    全面盤點應付程式帳套權限控管
#161012-00010#1  2016/10/13 By dorishsu CALL l_glaa.deleteElement(l_glaa.getLength())寫法會導致後續可用的帳套寫入temptalbe不完整
#161006-00005#19 2016/10/24 By 08732    組織類型與職能開窗調整
#161114-00017#1  2016/11/15 By Reanna   開窗權限調整
#161229-00047#29 2017/01/09 By 06821    財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#170111-00056#1  2017/01/12 By dorishsu 增加可依"帳款對象(apca004)"查詢
#170117-00012#1  2017/01/18 By 06694    增加列印(XG)功能
#170124-00003#1  2017/01/24 By 06694    底下总笔数与列印的总笔数調整為相符。
#170213-00013#1  2017/02/13 By 06821    當應付參數 s-fin-2002 為 3 時,帳款科目apca035改抓單身科目apcb029

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
PRIVATE TYPE type_g_apca_d RECORD
       #statepic       LIKE type_t.chr1,
       
       apcastus LIKE apca_t.apcastus, 
   apcasite LIKE apca_t.apcasite, 
   apcacomp LIKE type_t.chr500, 
   apcald LIKE apca_t.apcald, 
   apcadocno LIKE apca_t.apcadocno, 
   apcadocdt LIKE apca_t.apcadocdt, 
   apca001 LIKE apca_t.apca001, 
   apca004 LIKE apca_t.apca004, 
   apca004_desc LIKE type_t.chr500, 
   apca057 LIKE apca_t.apca057, 
   apca035 LIKE type_t.chr500, 
   apca038 LIKE apca_t.apca038, 
   apca014 LIKE type_t.chr500, 
   apca015 LIKE type_t.chr500, 
   apca058 LIKE type_t.chr500, 
   apca007 LIKE apca_t.apca007, 
   apca040 LIKE apca_t.apca040, 
   apcc100 LIKE apcc_t.apcc100, 
   apcc102 LIKE apcc_t.apcc102, 
   apccseq LIKE apcc_t.apccseq, 
   apcc001 LIKE apcc_t.apcc001, 
   apcc003 LIKE apcc_t.apcc003, 
   apcc004 LIKE apcc_t.apcc004, 
   apcc009 LIKE apcc_t.apcc009, 
   apcc108 LIKE apcc_t.apcc108, 
   apcc109 LIKE apcc_t.apcc109, 
   sum1 LIKE type_t.num20_6, 
   apcc113 LIKE apcc_t.apcc113, 
   apcc118 LIKE apcc_t.apcc118, 
   apcc119 LIKE apcc_t.apcc119, 
   sum2 LIKE type_t.num20_6, 
   apca053 LIKE apca_t.apca053 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_filter2        STRING
DEFINE g_sql_ctrl          STRING                #151231-00010#4
DEFINE g_user_dept_wc      STRING                #160518-00075#14
DEFINE g_wc_cs_ld          STRING                #160812-00027#2 add 查詢時帳套權限範圍
#161114-00017#1 add ------
DEFINE g_comp              LIKE glaa_t.glaacomp
DEFINE g_site_str          STRING
#161114-00017#1 add end---
DEFINE g_wc_cs_comp        STRING                #161229-00047#29 add
DEFINE g_sfin2002          LIKE type_t.chr100    #170213-00013#1  add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_apca_d
DEFINE g_master_t                   type_g_apca_d
DEFINE g_apca_d          DYNAMIC ARRAY OF type_g_apca_d
DEFINE g_apca_d_t        type_g_apca_d
 
      
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
 
{<section id="aapq360.main" >}
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
   #151231-00010#4--(S)
   LET g_sql_ctrl = NULL
   #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161114-00017#1 mark
   #151231-00010#4--(E)
   #161114-00017#1 add ------
   SELECT ooef017 INTO g_comp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#29 mark
   #161114-00017#1 add end---
   CALL cl_get_para(g_enterprise,g_comp,'S-FIN-2002') RETURNING g_sfin2002  #170213-00013#1 add   
   CALL aapq360_create_tmp()   #170117-00012#1 add
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
   DECLARE aapq360_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapq360_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapq360_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapq360 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapq360_init()   
 
      #進入選單 Menu (="N")
      CALL aapq360_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapq360
      
   END IF 
   
   CLOSE aapq360_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapq360.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapq360_init()
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
      CALL cl_set_combo_scc_part('b_apcastus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('b_apca001','8502') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_apca001','8502')       #帳款單性質
   CALL s_fin_create_account_center_tmp()
   
   #160812-00027#2 --s add
   #帳套權限相關預設範圍
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld     
   CALL s_fin_get_wc_str(g_wc_cs_ld) RETURNING g_wc_cs_ld  
   #160812-00027#2 --e add
   #161229-00047#29 --s add
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp      
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl 
   #161229-00047#29 --e add      
   #end add-point
 
   CALL aapq360_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aapq360.default_search" >}
PRIVATE FUNCTION aapq360_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " apcald = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " apcadocno = '", g_argv[02], "' AND "
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
 
{<section id="aapq360.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aapq360_ui_dialog()
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
   DEFINE l_prog   LIKE gzcb_t.gzcb005     #要開啟的程式名稱
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
      CALL aapq360_b_fill()
   ELSE
      CALL aapq360_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_apca_d.clear()
 
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
 
         CALL aapq360_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_apca_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aapq360_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aapq360_detail_action_trans()
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
            CALL aapq360_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aapq360_insert_tmp()                        #170117-00012#1 add
               CALL aapq360_x01(' 1=1','aapq360_x01_tmp')       #170117-00012#1 add
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aapq360_insert_tmp()                        #170117-00012#1 add
               CALL aapq360_x01(' 1=1','aapq360_x01_tmp')       #170117-00012#1 add
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapq360_query()
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
            CALL aapq360_filter()
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
            CALL aapq360_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_apca_d)
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
            CALL aapq360_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aapq360_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aapq360_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aapq360_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION modify_detail
            #超連結至原本程式
            IF NOT cl_null(g_apca_d[l_ac].apca001) THEN
               CALL s_fin_get_scc_value('8502',g_apca_d[l_ac].apca001,'3') RETURNING l_prog
               IF NOT cl_null(l_prog) THEN
                  LET la_param.prog = l_prog
               END IF
               IF NOT cl_null(l_prog) AND NOT cl_null(g_apca_d[l_ac].apcald) AND NOT cl_null(g_apca_d[l_ac].apcadocno) THEN
                  CASE
                     WHEN l_prog = "aapt300"
                        LET la_param.param[1] = ""
                        LET la_param.param[2] = g_apca_d[l_ac].apcald
                        LET la_param.param[3] = g_apca_d[l_ac].apcadocno
                     WHEN l_prog = "aapt301"
                        LET la_param.param[1] = "1"
                        LET la_param.param[2] = g_apca_d[l_ac].apcald
                        LET la_param.param[3] = g_apca_d[l_ac].apcadocno
                     WHEN l_prog = "aapt340"
                        LET la_param.param[1] = ""
                        LET la_param.param[2] = g_apca_d[l_ac].apcald
                        LET la_param.param[3] = g_apca_d[l_ac].apcadocno
                     WHEN l_prog = "aapt341"
                        LET la_param.param[1] = "1"
                        LET la_param.param[2] = g_apca_d[l_ac].apcald
                        LET la_param.param[3] = g_apca_d[l_ac].apcadocno
                     OTHERWISE
                        LET la_param.param[1] = g_apca_d[l_ac].apcald
                        LET la_param.param[2] = g_apca_d[l_ac].apcadocno
                  END CASE
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
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
 
{<section id="aapq360.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapq360_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_ld_str   STRING   #161114-00017#1
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
 
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_apca_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON apcastus,apcasite,apcald,apcadocno,apcadocdt,apca001,apca004,apca057,apca038, 
          apca007,apca040,apcc100,apcc003,apcc004,apcc009,apcc108,apcc109,apcc113,apcc118,apcc119,apca053 
 
           FROM s_detail1[1].b_apcastus,s_detail1[1].b_apcasite,s_detail1[1].b_apcald,s_detail1[1].b_apcadocno, 
               s_detail1[1].b_apcadocdt,s_detail1[1].b_apca001,s_detail1[1].b_apca004,s_detail1[1].b_apca057, 
               s_detail1[1].b_apca038,s_detail1[1].b_apca007,s_detail1[1].b_apca040,s_detail1[1].b_apcc100, 
               s_detail1[1].b_apcc003,s_detail1[1].b_apcc004,s_detail1[1].b_apcc009,s_detail1[1].b_apcc108, 
               s_detail1[1].b_apcc109,s_detail1[1].b_apcc113,s_detail1[1].b_apcc118,s_detail1[1].b_apcc119, 
               s_detail1[1].b_apca053
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
 
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<apcacrtdt>>----
         #AFTER FIELD apcacrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<apcamoddt>>----
         #AFTER FIELD apcamoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apcacnfdt>>----
         #AFTER FIELD apcacnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apcapstdt>>----
         #AFTER FIELD apcapstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
         
       #單身一般欄位開窗相關處理
                #----<<b_apcastus>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcastus
            #add-point:BEFORE FIELD b_apcastus name="construct.b.page1.b_apcastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcastus
            
            #add-point:AFTER FIELD b_apcastus name="construct.a.page1.b_apcastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcastus
            #add-point:ON ACTION controlp INFIELD b_apcastus name="construct.c.page1.b_apcastus"
            
            #END add-point
 
 
         #----<<b_apcasite>>----
         #Ctrlp:construct.c.page1.b_apcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcasite
            #add-point:ON ACTION controlp INFIELD b_apcasite name="construct.c.page1.b_apcasite"
            #開窗c段--帳務中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161006-00005#19   mark
            CALL q_ooef001_46()   #161006-00005#19   add 
            DISPLAY g_qryparam.return1 TO b_apcasite
            NEXT FIELD b_apcasite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcasite
            #add-point:BEFORE FIELD b_apcasite name="construct.b.page1.b_apcasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcasite
            
            #add-point:AFTER FIELD b_apcasite name="construct.a.page1.b_apcasite"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str #161114-00017#1
            #END add-point
            
 
 
         #----<<b_apcacomp>>----
         #----<<b_apcald>>----
         #Ctrlp:construct.c.page1.b_apcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcald
            #add-point:ON ACTION controlp INFIELD b_apcald name="construct.c.page1.b_apcald"
            #開窗c段--帳別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            LET g_qryparam.where = " glaald IN ",g_wc_cs_ld  #160812-00027#2 add
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO b_apcald
            NEXT FIELD b_apcald
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcald
            #add-point:BEFORE FIELD b_apcald name="construct.b.page1.b_apcald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcald
            
            #add-point:AFTER FIELD b_apcald name="construct.a.page1.b_apcald"
            
            #END add-point
            
 
 
         #----<<b_apcadocno>>----
         #Ctrlp:construct.c.page1.b_apcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcadocno
            #add-point:ON ACTION controlp INFIELD b_apcadocno name="construct.c.page1.b_apcadocno"
            #開窗c段--單據編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ' 1=1'   #160518-00075#14
            #151231-00010#4--(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
              #LET g_qryparam.where = " apca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"  #160518-00075#14 mark
               LET g_qryparam.where = g_qryparam.where," AND apca004 IN ",                                                  #160518-00075#14 
                                      "(SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"  #160518-00075#14 
            END IF
            #151231-00010#4--(E)
            #160518-00075#14--s
            IF NOT cl_null(g_user_dept_wc) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc  
            END IF
            #160518-00075#14--e
            #161114-00017#1 add ------
            #查詢依帳套權限管理
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","apcald")
            LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str
            #161114-00017#1 add end---
            CALL q_apcadocno()
            DISPLAY g_qryparam.return1 TO b_apcadocno
            NEXT FIELD b_apcadocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcadocno
            #add-point:BEFORE FIELD b_apcadocno name="construct.b.page1.b_apcadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcadocno
            
            #add-point:AFTER FIELD b_apcadocno name="construct.a.page1.b_apcadocno"
            
            #END add-point
            
 
 
         #----<<b_apcadocdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcadocdt
            #add-point:BEFORE FIELD b_apcadocdt name="construct.b.page1.b_apcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcadocdt
            
            #add-point:AFTER FIELD b_apcadocdt name="construct.a.page1.b_apcadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcadocdt
            #add-point:ON ACTION controlp INFIELD b_apcadocdt name="construct.c.page1.b_apcadocdt"
            
            #END add-point
 
 
         #----<<b_apca001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apca001
            #add-point:BEFORE FIELD b_apca001 name="construct.b.page1.b_apca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apca001
            
            #add-point:AFTER FIELD b_apca001 name="construct.a.page1.b_apca001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca001
            #add-point:ON ACTION controlp INFIELD b_apca001 name="construct.c.page1.b_apca001"
            
            #END add-point
 
 
         #----<<b_apca004>>----
         #Ctrlp:construct.c.page1.b_apca004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca004
            #add-point:ON ACTION controlp INFIELD b_apca004 name="construct.c.page1.b_apca004"
            #開窗c段--帳款對象編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"
            #151231-00010#4--(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " pmaa001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            CALL q_pmaa001_1()
            DISPLAY g_qryparam.return1 TO b_apca004
            NEXT FIELD b_apca004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apca004
            #add-point:BEFORE FIELD b_apca004 name="construct.b.page1.b_apca004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apca004
            
            #add-point:AFTER FIELD b_apca004 name="construct.a.page1.b_apca004"
            
            #END add-point
            
 
 
         #----<<b_apca004_desc>>----
         #----<<b_apca057>>----
         #Ctrlp:construct.c.page1.b_apca057
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca057
            #add-point:ON ACTION controlp INFIELD b_apca057 name="construct.c.page1.b_apca057"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apca057  #顯示到畫面上
            NEXT FIELD b_apca057                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apca057
            #add-point:BEFORE FIELD b_apca057 name="construct.b.page1.b_apca057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apca057
            
            #add-point:AFTER FIELD b_apca057 name="construct.a.page1.b_apca057"
            
            #END add-point
            
 
 
         #----<<b_apca035>>----
         #----<<b_apca038>>----
         #Ctrlp:construct.c.page1.b_apca038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca038
            #add-point:ON ACTION controlp INFIELD b_apca038 name="construct.c.page1.b_apca038"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#4--(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " apca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            CALL q_apca038()
            DISPLAY g_qryparam.return1 TO b_apca038
            NEXT FIELD b_apca038
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apca038
            #add-point:BEFORE FIELD b_apca038 name="construct.b.page1.b_apca038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apca038
            
            #add-point:AFTER FIELD b_apca038 name="construct.a.page1.b_apca038"
            
            #END add-point
            
 
 
         #----<<b_apca014>>----
         #----<<b_apca015>>----
         #----<<b_apca058>>----
         #----<<b_apca007>>----
         #Ctrlp:construct.c.page1.b_apca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca007
            #add-point:ON ACTION controlp INFIELD b_apca007 name="construct.c.page1.b_apca007"
            #開窗c段--帳款類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3111'
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO b_apca007
            NEXT FIELD b_apca007
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apca007
            #add-point:BEFORE FIELD b_apca007 name="construct.b.page1.b_apca007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apca007
            
            #add-point:AFTER FIELD b_apca007 name="construct.a.page1.b_apca007"
            
            #END add-point
            
 
 
         #----<<b_apca040>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apca040
            #add-point:BEFORE FIELD b_apca040 name="construct.b.page1.b_apca040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apca040
            
            #add-point:AFTER FIELD b_apca040 name="construct.a.page1.b_apca040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apca040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca040
            #add-point:ON ACTION controlp INFIELD b_apca040 name="construct.c.page1.b_apca040"
            
            #END add-point
 
 
         #----<<b_apcc100>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcc100
            #add-point:BEFORE FIELD b_apcc100 name="construct.b.page1.b_apcc100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcc100
            
            #add-point:AFTER FIELD b_apcc100 name="construct.a.page1.b_apcc100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcc100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc100
            #add-point:ON ACTION controlp INFIELD b_apcc100 name="construct.c.page1.b_apcc100"
            #開窗c段--幣別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO b_apcc100
            NEXT FIELD b_apcc100
            #END add-point
 
 
         #----<<b_apcc102>>----
         #----<<b_apccseq>>----
         #----<<b_apcc001>>----
         #----<<b_apcc003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcc003
            #add-point:BEFORE FIELD b_apcc003 name="construct.b.page1.b_apcc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcc003
            
            #add-point:AFTER FIELD b_apcc003 name="construct.a.page1.b_apcc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc003
            #add-point:ON ACTION controlp INFIELD b_apcc003 name="construct.c.page1.b_apcc003"
            
            #END add-point
 
 
         #----<<b_apcc004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcc004
            #add-point:BEFORE FIELD b_apcc004 name="construct.b.page1.b_apcc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcc004
            
            #add-point:AFTER FIELD b_apcc004 name="construct.a.page1.b_apcc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc004
            #add-point:ON ACTION controlp INFIELD b_apcc004 name="construct.c.page1.b_apcc004"
            
            #END add-point
 
 
         #----<<b_apcc009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcc009
            #add-point:BEFORE FIELD b_apcc009 name="construct.b.page1.b_apcc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcc009
            
            #add-point:AFTER FIELD b_apcc009 name="construct.a.page1.b_apcc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc009
            #add-point:ON ACTION controlp INFIELD b_apcc009 name="construct.c.page1.b_apcc009"
            
            #END add-point
 
 
         #----<<b_apcc108>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcc108
            #add-point:BEFORE FIELD b_apcc108 name="construct.b.page1.b_apcc108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcc108
            
            #add-point:AFTER FIELD b_apcc108 name="construct.a.page1.b_apcc108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcc108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc108
            #add-point:ON ACTION controlp INFIELD b_apcc108 name="construct.c.page1.b_apcc108"
            
            #END add-point
 
 
         #----<<b_apcc109>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcc109
            #add-point:BEFORE FIELD b_apcc109 name="construct.b.page1.b_apcc109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcc109
            
            #add-point:AFTER FIELD b_apcc109 name="construct.a.page1.b_apcc109"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcc109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc109
            #add-point:ON ACTION controlp INFIELD b_apcc109 name="construct.c.page1.b_apcc109"
            
            #END add-point
 
 
         #----<<b_sum1>>----
         #----<<b_apcc113>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcc113
            #add-point:BEFORE FIELD b_apcc113 name="construct.b.page1.b_apcc113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcc113
            
            #add-point:AFTER FIELD b_apcc113 name="construct.a.page1.b_apcc113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcc113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc113
            #add-point:ON ACTION controlp INFIELD b_apcc113 name="construct.c.page1.b_apcc113"
            
            #END add-point
 
 
         #----<<b_apcc118>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcc118
            #add-point:BEFORE FIELD b_apcc118 name="construct.b.page1.b_apcc118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcc118
            
            #add-point:AFTER FIELD b_apcc118 name="construct.a.page1.b_apcc118"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcc118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc118
            #add-point:ON ACTION controlp INFIELD b_apcc118 name="construct.c.page1.b_apcc118"
            
            #END add-point
 
 
         #----<<b_apcc119>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcc119
            #add-point:BEFORE FIELD b_apcc119 name="construct.b.page1.b_apcc119"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcc119
            
            #add-point:AFTER FIELD b_apcc119 name="construct.a.page1.b_apcc119"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcc119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc119
            #add-point:ON ACTION controlp INFIELD b_apcc119 name="construct.c.page1.b_apcc119"
            
            #END add-point
 
 
         #----<<b_sum2>>----
         #----<<b_apca053>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apca053
            #add-point:BEFORE FIELD b_apca053 name="construct.b.page1.b_apca053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apca053
            
            #add-point:AFTER FIELD b_apca053 name="construct.a.page1.b_apca053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apca053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca053
            #add-point:ON ACTION controlp INFIELD b_apca053 name="construct.c.page1.b_apca053"
            
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
      BEFORE DIALOG
         CALL aapq360_qbe_clear()
      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後 name="query.qbeclear"
         
         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後 name="query.set_qbe_action_after"
         CALL aapq360_qbe_clear()
      
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
   CALL aapq360_b_fill()
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
 
{<section id="aapq360.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapq360_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
DEFINE l_n                LIKE type_t.num5
DEFINE l_glaa             DYNAMIC ARRAY OF RECORD
                             glaald  LIKE glaa_t.glaald
                          END RECORD
DEFINE l_glaald           LIKE glaa_t.glaald
DEFINE l_wc_glaald        STRING
DEFINE l_wc_ctrl          STRING    #151231-00010#4
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL aapq360_filter2_show('apcc119','b_apcc119')
   CALL aapq360_filter2_show('rep_l_sum2','l_sum2')
   LET g_wc_filter2 = cl_replace_str(g_wc_filter2,'rep_l_sum2', 'apcc118 - apcc119')
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
 
   LET ls_sql_rank = "SELECT  UNIQUE apcastus,apcasite,'',apcald,apcadocno,apcadocdt,apca001,apca004, 
       '',apca057,'',apca038,'','','',apca007,apca040,'','','','','','','','','','','','','','',apca053  , 
       DENSE_RANK() OVER( ORDER BY apca_t.apcald,apca_t.apcadocno) AS RANK FROM apca_t",
 
 
                     "",
                     " WHERE apcaent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("apca_t"),
                     " ORDER BY apca_t.apcald,apca_t.apcadocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_wc = ls_wc," AND ",g_wc_filter2
                    ," AND ",g_user_dept_wc   #160518-00075#14
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
 
   LET g_sql = "SELECT apcastus,apcasite,'',apcald,apcadocno,apcadocdt,apca001,apca004,'',apca057,'', 
       apca038,'','','',apca007,apca040,'','','','','','','','','','','','','','',apca053",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #先撈出ALL有效的帳套
   #在過濾撈出該user權限符合可使用的帳套
   LET g_sql = "SELECT glaald FROM glaa_t",
               " WHERE glaaent = ",g_enterprise,
               "   AND glaastus = 'Y'"
   PREPARE sel_glaa_pb FROM g_sql
   DECLARE sel_glaa_cs CURSOR FOR sel_glaa_pb
   LET l_n = 1
   FOREACH sel_glaa_cs INTO l_glaald
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #判斷該user是否有該帳套權限
      CALL s_fin_ld_chk(l_glaald,g_user,'N') RETURNING  g_sub_success,g_errno
      
      IF NOT g_sub_success THEN
         CONTINUE FOREACH
      ELSE
         #寫入陣列記錄
         LET l_glaa[l_n].glaald = l_glaald
         LET l_n = l_n + 1
      END IF
   END FOREACH
   
   #CALL l_glaa.deleteElement(l_glaa.getLength())   #161012-00010#1 mark
   CALL l_glaa.deleteElement(l_n)                   #161012-00010#1 add

   #把可用的帳套寫入temptalbe
   LET l_n = 1
   FOR l_n = 1 TO l_glaa.getLength()
      INSERT INTO s_fin_tmp1(glaald) 
                      VALUES(l_glaa[l_n].glaald)   
   END FOR

   #組成where的條件字串
   CALL s_fin_account_center_ld_str() RETURNING l_wc_glaald
   CALL s_fin_get_wc_str(l_wc_glaald) RETURNING l_wc_glaald
#151124-00022#1 ---s---   
#   LET g_sql = "SELECT UNIQUE apcasite,apcacomp,apcald,apcadocno,apcastus, ",
#               "              apcadocdt,apca001,apca004,apca057,apca035,   ",
#               "              apca038,                                     ",
#               "              apca014,apca015,apca058,apca007,apca040,",
#               "              apcc100,apcc102,apccseq,apcc001,apcc003,",
#               "              apcc004,apcc009,apcc108,apcc109,0,",
#              #"              apcc113,apcc118,apcc119,0",         #151013-00019#10 mark
#               "              apcc113,apcc118,apcc119,0,apca053", #151013-00019#10
#               "  FROM apca_t",
#               "  LEFT JOIN apcc_t ON apcaent = apccent AND apcald = apccld AND apcadocno = apccdocno",
#               " WHERE apcaent= ?  ",
#               "   AND apcald IN ",l_wc_glaald,
#               "   AND ", ls_wc,cl_sql_add_filter("apca_t")

   #151231-00010#4--(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET l_wc_ctrl = " apca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#4--(E)
   IF cl_null(l_wc_ctrl) THEN LET l_wc_ctrl = " 1=1" END IF #160425-00024#4
   ##160414-00018#36 mark ------
   #LET g_sql = "SELECT  apcastus,apcasite,apcacomp,apcald,apcadocno, ",    #151013-00016#12 apcastus更換位置
   #            "        apcadocdt,apca001,apca004,apca057,apca035,   ",
   #            "        apca038,                                     ",
   #            "        apca014,apca015,apca058,apca007,apca040,     ",
   #            "        apcc100,apcc102,apccseq,apcc001,apcc003,     ",
   #            "        apcc004,apcc009,apcc108,apcc109,sum1,        ",  
   #            "        apcc113,apcc118,apcc119,sum2,apca053         ", 
   #            "   FROM                                              ",
   #            "    ( SELECT UNIQUE apcasite,apcacomp,apcald,apcadocno,apcastus,",
   #            "                    apcadocdt,apca001,apca004,apca057,apca035,  ",
   #            "                    apca038,                                    ",
   #            "                    apca014,apca015,apca058,apca007,apca040,    ",
   #            "                    apcc100,apcc102,apccseq,apcc001,apcc003,    ",
   #            "                    apcc004,apcc009,                            ",
   #            " (CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN apcc108 *-1 ELSE apcc108 END) apcc108,",
   #            " (CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN apcc109 *-1 ELSE apcc109 END) apcc109,",
   #            " (CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN (apcc108-apcc109) *-1 ELSE (apcc108-apcc109) END) sum1,    ",
   #            "                   apcc113,                                                                                                        ",
   #            " (CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN ((apcc118 * -1)+apcc113) ELSE (apcc118+apcc113) END) apcc118, ",
   #            " (CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN  apcc119 *-1 ELSE apcc119 END) apcc119,                    ",
   #            " (CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN (((apcc118-apcc119) * -1)+apcc113) ELSE (apcc118+apcc113-apcc119) END) sum2,",                          
   #            "                  apca053                                       ", 
   #            "               FROM apca_t                                      ",
   #            "               LEFT JOIN apcc_t ON apcaent = apccent AND apcald = apccld AND apcadocno = apccdocno ",
   #            "              WHERE apcaent= ?                                  ",
   #            "                AND apcald IN ",l_wc_glaald," AND ",l_wc_ctrl,  #151231-00010#4 add 控制組
   #            "                ) WHERE ", ls_wc,cl_sql_add_filter("apca_t")
   #            
   #160414-00018#36 mark end---
#151124-00022#1 ---e---
   #160414-00018#36 add ------
   LET g_sql = "SELECT  apcastus,apcasite,",
               #法人
               "        (CASE WHEN (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = apcaent AND ooefl001 = apcacomp AND ooefl002 = '",g_dlang,"') IS NULL THEN apcacomp ",
               "              ELSE (SELECT apcacomp||' '||'('||ooefl003||')' FROM ooefl_t WHERE ooeflent = apcaent AND ooefl001 = apcacomp AND ooefl002 = '",g_dlang,"') END ),",
               "        apcald,apcadocno, ",
               "        apcadocdt,apca001,",               
               #帳款對象
               #"        (CASE WHEN (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = apcaent AND pmaal001 = apca004 AND pmaal002 = '",g_dlang,"') IS NULL THEN apca004 ",            #170111-00056#1 mark
               #"              ELSE (SELECT apca004||' '||'('||pmaal004||')' FROM pmaal_t WHERE pmaalent = apcaent AND pmaal001 = apca004 AND pmaal002 = '",g_dlang,"') END ),",   #170111-00056#1 mark
               "        apca004,",                                                                                                                                                 #170111-00056#1 add
               "        (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = apcaent AND pmaal001 = apca004 AND pmaal002 = '",g_dlang,"'), ",                                            #170111-00056#1 add
               "        apca057,",
               #帳款科目
               "        (CASE WHEN (SELECT glacl004 FROM glacl_t,glaa_t WHERE glacl001=glaa004 AND glaaent=glaclent AND glaclent=apcaent AND glacl002=apca035 AND glacl003='",g_dlang,"' AND glaald=apcald) IS NULL THEN apca035 ",
               "              ELSE (SELECT apca035||' '||'('||glacl004||')' FROM glacl_t,glaa_t WHERE glacl001=glaa004 AND glaaent=glaclent AND glaclent=apcaent AND glacl002=apca035 AND glacl003='",g_dlang,"' AND glaald=apcald) END ),",
               "        apca038,",
               #人員
               "        (CASE WHEN (SELECT ooag011 FROM ooag_t WHERE ooagent = apcaent AND ooag001 = apca014) IS NULL THEN apca014",
               "              ELSE (SELECT apca014||' '||'('||ooag011||')' FROM ooag_t WHERE ooagent = apcaent AND ooag001 = apca014) END ),",
               #部門
               "        (CASE WHEN (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = apcaent AND ooefl001 = apca015 AND ooefl002 = '",g_dlang,"') IS NULL THEN apca015 ",
               "              ELSE (SELECT apca015||' '||'('||ooefl003||')' FROM ooefl_t WHERE ooeflent = apcaent AND ooefl001 = apca015 AND ooefl002 = '",g_dlang,"') END ),",
               #銷售類型
               "        (CASE WHEN (SELECT oocql004 FROM oocql_t WHERE oocqlent = apcaent AND oocql001='264' AND oocql002=apca058 AND oocql003 = '",g_dlang,"') IS NULL THEN apca058 ",
               "              ELSE (SELECT apca058||' '||'('||oocql004||')' FROM oocql_t WHERE oocqlent = apcaent AND oocql001='264' AND oocql002=apca058 AND oocql003 = '",g_dlang,"') END ),",
               "        apca007,apca040,",
               "        apcc100,apcc102,apccseq,apcc001,apcc003,",
               "        apcc004,apcc009,apcc108,apcc109,sum1,",  
               "        apcc113,apcc118,apcc119,sum2,apca053", 
               "   FROM",
               "        (SELECT UNIQUE apcasite,apcacomp,apcald,apcadocno,apcastus,",
               "                       apcadocdt,apca001,apca004,apca057,apca035,",
               "                       apca038,",
               "                       apca014,apca015,apca058,apca007,apca040,",
               "                       apcc100,apcc102,apccseq,apcc001,apcc003,",
               "                       apcc004,apcc009,",
               "                       (CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN apcc108 *-1 ELSE apcc108 END) apcc108,",
               "                       (CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN apcc109 *-1 ELSE apcc109 END) apcc109,",
               "                       (CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN (apcc108-apcc109) *-1 ELSE (apcc108-apcc109) END) sum1,    ",
               "                       apcc113,                                                                                                        ",
               "                       (CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN ((apcc118 * -1)+apcc113) ELSE (apcc118+apcc113) END) apcc118, ",
               "                       (CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN  apcc119 *-1 ELSE apcc119 END) apcc119,                    ",
               "                       (CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN (((apcc118-apcc119) * -1)+apcc113) ELSE (apcc118+apcc113-apcc119) END) sum2,",                          
               "                       apca053,apcaent", 
               "           FROM apca_t",
               "           LEFT JOIN apcc_t ON apcaent = apccent AND apcald = apccld AND apcadocno = apccdocno ",
               "          WHERE apcaent= ?                                  ",
               "            AND apcald IN ",l_wc_glaald," AND ",l_wc_ctrl,  #151231-00010#4 add 控制組
               "        )",
               "  WHERE ", ls_wc,cl_sql_add_filter("apca_t")
   #160414-00018#36 add end---
   LET g_sql = g_sql, cl_sql_add_filter("apca_t"),
               " ORDER BY apcasite,apcacomp,apcald,apcadocno"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapq360_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapq360_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_apca_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
 
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_apca_d[l_ac].apcastus,g_apca_d[l_ac].apcasite,g_apca_d[l_ac].apcacomp, 
       g_apca_d[l_ac].apcald,g_apca_d[l_ac].apcadocno,g_apca_d[l_ac].apcadocdt,g_apca_d[l_ac].apca001, 
       g_apca_d[l_ac].apca004,g_apca_d[l_ac].apca004_desc,g_apca_d[l_ac].apca057,g_apca_d[l_ac].apca035, 
       g_apca_d[l_ac].apca038,g_apca_d[l_ac].apca014,g_apca_d[l_ac].apca015,g_apca_d[l_ac].apca058,g_apca_d[l_ac].apca007, 
       g_apca_d[l_ac].apca040,g_apca_d[l_ac].apcc100,g_apca_d[l_ac].apcc102,g_apca_d[l_ac].apccseq,g_apca_d[l_ac].apcc001, 
       g_apca_d[l_ac].apcc003,g_apca_d[l_ac].apcc004,g_apca_d[l_ac].apcc009,g_apca_d[l_ac].apcc108,g_apca_d[l_ac].apcc109, 
       g_apca_d[l_ac].sum1,g_apca_d[l_ac].apcc113,g_apca_d[l_ac].apcc118,g_apca_d[l_ac].apcc119,g_apca_d[l_ac].sum2, 
       g_apca_d[l_ac].apca053
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_apca_d[l_ac].statepic = cl_get_actipic(g_apca_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      IF cl_null(g_apca_d[l_ac].apcc108) THEN LET g_apca_d[l_ac].apcc108 = 0 END IF
      IF cl_null(g_apca_d[l_ac].apcc109) THEN LET g_apca_d[l_ac].apcc109 = 0 END IF
      IF cl_null(g_apca_d[l_ac].apcc113) THEN LET g_apca_d[l_ac].apcc113 = 0 END IF
      IF cl_null(g_apca_d[l_ac].apcc118) THEN LET g_apca_d[l_ac].apcc118 = 0 END IF
      IF cl_null(g_apca_d[l_ac].apcc119) THEN LET g_apca_d[l_ac].apcc119 = 0 END IF
      IF cl_null(g_apca_d[l_ac].sum1) THEN LET g_apca_d[l_ac].sum1 = 0 END IF #151124-00022#1  
      IF cl_null(g_apca_d[l_ac].sum2) THEN LET g_apca_d[l_ac].sum2 = 0 END IF #151124-00022#1
      #151124-00022#1 ---s---  mark       
#      #原幣未付金額
#      LET g_apca_d[l_ac].l_sum1 = g_apca_d[l_ac].apcc108 - g_apca_d[l_ac].apcc109
#      #本幣應付金額
#      LET g_apca_d[l_ac].apcc118 = g_apca_d[l_ac].apcc113 + g_apca_d[l_ac].apcc118
#      #本幣未付金額
#      LET g_apca_d[l_ac].l_sum2 = g_apca_d[l_ac].apcc118 - g_apca_d[l_ac].apcc119
#      
#      #帳款單性質為2*or02or04用負數呈現
#      IF g_apca_d[l_ac].apca001[1,1] = 2 OR g_apca_d[l_ac].apca001 MATCHES '0[24]' THEN
#         LET g_apca_d[l_ac].apcc108 = g_apca_d[l_ac].apcc108 * -1
#         LET g_apca_d[l_ac].apcc109 = g_apca_d[l_ac].apcc109 * -1
#         LET g_apca_d[l_ac].l_sum1 = g_apca_d[l_ac].l_sum1 * -1
#         LET g_apca_d[l_ac].apcc118 = g_apca_d[l_ac].apcc118 * -1
#         LET g_apca_d[l_ac].apcc119 = g_apca_d[l_ac].apcc119 * -1
#         LET g_apca_d[l_ac].l_sum2 = g_apca_d[l_ac].l_sum2 * -1
#      END IF
      #151124-00022#1 ---e--- mark

      #170213-00013#1 --s add
      #當應付參數s-fin-2002為3時,帳款科目apca035改抓單身科目apcb029 
      IF g_sfin2002 = '3' THEN    
         LET g_apca_d[l_ac].apca035 = ''
         SELECT DISTINCT apcb029 INTO g_apca_d[l_ac].apca035
           FROM apcb_t
          WHERE apcbent = g_enterprise AND apcbld = g_apca_d[l_ac].apcald
            AND apcbdocno = g_apca_d[l_ac].apcadocno AND apcbseq = g_apca_d[l_ac].apccseq
         LET g_apca_d[l_ac].apca035 = s_desc_show1(g_apca_d[l_ac].apca035,s_desc_get_account_desc(g_apca_d[l_ac].apcald,g_apca_d[l_ac].apca035))
      END IF
      #170213-00013#1 --e add   
      #end add-point
 
      CALL aapq360_detail_show("'1'")      
 
      CALL aapq360_apca_t_mask()
 
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
   
 
   
   CALL g_apca_d.deleteElement(g_apca_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
 
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_apca_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aapq360_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aapq360_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aapq360_detail_action_trans()
 
   IF g_apca_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aapq360_fetch()
   END IF
   
      CALL aapq360_filter_show('apcastus','b_apcastus')
   CALL aapq360_filter_show('apcasite','b_apcasite')
   CALL aapq360_filter_show('apcald','b_apcald')
   CALL aapq360_filter_show('apcadocno','b_apcadocno')
   CALL aapq360_filter_show('apcadocdt','b_apcadocdt')
   CALL aapq360_filter_show('apca001','b_apca001')
   CALL aapq360_filter_show('apca004','b_apca004')
   CALL aapq360_filter_show('apca057','b_apca057')
   CALL aapq360_filter_show('apca038','b_apca038')
   CALL aapq360_filter_show('apca007','b_apca007')
   CALL aapq360_filter_show('apca040','b_apca040')
   CALL aapq360_filter_show('apcc100','b_apcc100')
   CALL aapq360_filter_show('apcc003','b_apcc003')
   CALL aapq360_filter_show('apcc004','b_apcc004')
   CALL aapq360_filter_show('apcc009','b_apcc009')
   CALL aapq360_filter_show('apcc108','b_apcc108')
   CALL aapq360_filter_show('apcc109','b_apcc109')
   CALL aapq360_filter_show('apcc113','b_apcc113')
   CALL aapq360_filter_show('apcc118','b_apcc118')
   CALL aapq360_filter_show('apcc119','b_apcc119')
   CALL aapq360_filter_show('apca053','b_apca053')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   IF cl_null(g_detail_idx) THEN
      LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.h_index
   END IF
   
   #170124-00003#1---(s)---
   LET g_tot_cnt = g_detail_cnt 
   DISPLAY g_tot_cnt TO FORMONLY.h_count
   #170124-00003#1---(e)---
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq360.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapq360_fetch()
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
 
{<section id="aapq360.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapq360_detail_show(ps_page)
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
      #160414-00018#36 mark ------
      ##法人
      #LET g_apca_d[l_ac].apcacomp = s_desc_show1(g_apca_d[l_ac].apcacomp,s_desc_get_department_desc(g_apca_d[l_ac].apcacomp))
      ##帳款對象
      #LET g_apca_d[l_ac].apca004 = s_desc_show1(g_apca_d[l_ac].apca004,s_desc_get_trading_partner_abbr_desc(g_apca_d[l_ac].apca004))
      ##帳款科目
      #LET g_apca_d[l_ac].apca035 = s_desc_show1(g_apca_d[l_ac].apca035,s_desc_get_account_desc(g_apca_d[l_ac].apcald,g_apca_d[l_ac].apca035))
      ##人員
      #LET g_apca_d[l_ac].apca014 = s_desc_show1(g_apca_d[l_ac].apca014,s_desc_get_person_desc(g_apca_d[l_ac].apca014))
      ##部門
      #LET g_apca_d[l_ac].apca015 = s_desc_show1(g_apca_d[l_ac].apca015,s_desc_get_department_desc(g_apca_d[l_ac].apca015))
      ##銷售類型
      #LET g_apca_d[l_ac].apca058 = s_desc_show1(g_apca_d[l_ac].apca058,s_desc_get_acc_desc('264',g_apca_d[l_ac].apca058))
      #160414-00018#36 mark end---
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq360.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapq360_filter()
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
      CONSTRUCT g_wc_filter ON apcastus,apcasite,apcald,apcadocno,apcadocdt,apca001,apca004,apca057, 
          apca038,apca007,apca040,apcc100,apcc003,apcc004,apcc009,apcc108,apcc109,apcc113,apcc118,apcc119, 
          apca053
                          FROM s_detail1[1].b_apcastus,s_detail1[1].b_apcasite,s_detail1[1].b_apcald, 
                              s_detail1[1].b_apcadocno,s_detail1[1].b_apcadocdt,s_detail1[1].b_apca001, 
                              s_detail1[1].b_apca004,s_detail1[1].b_apca057,s_detail1[1].b_apca038,s_detail1[1].b_apca007, 
                              s_detail1[1].b_apca040,s_detail1[1].b_apcc100,s_detail1[1].b_apcc003,s_detail1[1].b_apcc004, 
                              s_detail1[1].b_apcc009,s_detail1[1].b_apcc108,s_detail1[1].b_apcc109,s_detail1[1].b_apcc113, 
                              s_detail1[1].b_apcc118,s_detail1[1].b_apcc119,s_detail1[1].b_apca053
 
         BEFORE CONSTRUCT
                     DISPLAY aapq360_filter_parser('apcastus') TO s_detail1[1].b_apcastus
            DISPLAY aapq360_filter_parser('apcasite') TO s_detail1[1].b_apcasite
            DISPLAY aapq360_filter_parser('apcald') TO s_detail1[1].b_apcald
            DISPLAY aapq360_filter_parser('apcadocno') TO s_detail1[1].b_apcadocno
            DISPLAY aapq360_filter_parser('apcadocdt') TO s_detail1[1].b_apcadocdt
            DISPLAY aapq360_filter_parser('apca001') TO s_detail1[1].b_apca001
            DISPLAY aapq360_filter_parser('apca004') TO s_detail1[1].b_apca004
            DISPLAY aapq360_filter_parser('apca057') TO s_detail1[1].b_apca057
            DISPLAY aapq360_filter_parser('apca038') TO s_detail1[1].b_apca038
            DISPLAY aapq360_filter_parser('apca007') TO s_detail1[1].b_apca007
            DISPLAY aapq360_filter_parser('apca040') TO s_detail1[1].b_apca040
            DISPLAY aapq360_filter_parser('apcc100') TO s_detail1[1].b_apcc100
            DISPLAY aapq360_filter_parser('apcc003') TO s_detail1[1].b_apcc003
            DISPLAY aapq360_filter_parser('apcc004') TO s_detail1[1].b_apcc004
            DISPLAY aapq360_filter_parser('apcc009') TO s_detail1[1].b_apcc009
            DISPLAY aapq360_filter_parser('apcc108') TO s_detail1[1].b_apcc108
            DISPLAY aapq360_filter_parser('apcc109') TO s_detail1[1].b_apcc109
            DISPLAY aapq360_filter_parser('apcc113') TO s_detail1[1].b_apcc113
            DISPLAY aapq360_filter_parser('apcc118') TO s_detail1[1].b_apcc118
            DISPLAY aapq360_filter_parser('apcc119') TO s_detail1[1].b_apcc119
            DISPLAY aapq360_filter_parser('apca053') TO s_detail1[1].b_apca053
 
 
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<apcacrtdt>>----
         #AFTER FIELD apcacrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<apcamoddt>>----
         #AFTER FIELD apcamoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apcacnfdt>>----
         #AFTER FIELD apcacnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apcapstdt>>----
         #AFTER FIELD apcapstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
           
         #單身一般欄位開窗相關處理
                  #----<<b_apcastus>>----
         #Ctrlp:construct.c.filter.page1.b_apcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcastus
            #add-point:ON ACTION controlp INFIELD b_apcastus name="construct.c.filter.page1.b_apcastus"
            
            #END add-point
 
 
         #----<<b_apcasite>>----
         #Ctrlp:construct.c.page1.b_apcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcasite
            #add-point:ON ACTION controlp INFIELD b_apcasite name="construct.c.filter.page1.b_apcasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段--帳務中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161006-00005#19   mark
            CALL q_ooef001_46()   #161006-00005#19   add 
            DISPLAY g_qryparam.return1 TO b_apcasite
            NEXT FIELD b_apcasite
            #END add-point
 
 
         #----<<b_apcacomp>>----
         #----<<b_apcald>>----
         #Ctrlp:construct.c.page1.b_apcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcald
            #add-point:ON ACTION controlp INFIELD b_apcald name="construct.c.filter.page1.b_apcald"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段--帳別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            LET g_qryparam.where = " glaald IN ",g_wc_cs_ld  #160812-00027#2 add
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO b_apcald
            NEXT FIELD b_apcald
            #END add-point
 
 
         #----<<b_apcadocno>>----
         #Ctrlp:construct.c.page1.b_apcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcadocno
            #add-point:ON ACTION controlp INFIELD b_apcadocno name="construct.c.filter.page1.b_apcadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段--單據編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ' 1=1'   #160518-00075#14
            #151231-00010#4--(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
              #LET g_qryparam.where = " apca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"   #160518-00075#14 mark
               LET g_qryparam.where = g_qryparam.where," AND apca004 IN ",                                                   #160518-00075#14
                                      "(SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"   #160518-00075#14 
            END IF
            #151231-00010#4--(E)
            #160518-00075#14--s
            IF NOT cl_null(g_user_dept_wc) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc  
            END IF            
            #160518-00075#14--e            
            CALL q_apcadocno()
            DISPLAY g_qryparam.return1 TO b_apcadocno
            NEXT FIELD b_apcadocno
            #END add-point
 
 
         #----<<b_apcadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_apcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcadocdt
            #add-point:ON ACTION controlp INFIELD b_apcadocdt name="construct.c.filter.page1.b_apcadocdt"
            
            #END add-point
 
 
         #----<<b_apca001>>----
         #Ctrlp:construct.c.filter.page1.b_apca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca001
            #add-point:ON ACTION controlp INFIELD b_apca001 name="construct.c.filter.page1.b_apca001"
            
            #END add-point
 
 
         #----<<b_apca004>>----
         #Ctrlp:construct.c.page1.b_apca004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca004
            #add-point:ON ACTION controlp INFIELD b_apca004 name="construct.c.filter.page1.b_apca004"
            #開窗c段--帳款對象編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"
            #151231-00010#4--(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " pmaa001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            CALL q_pmaa001_1()
            DISPLAY g_qryparam.return1 TO b_apca004
            NEXT FIELD b_apca004
            #END add-point
 
 
         #----<<b_apca004_desc>>----
         #----<<b_apca057>>----
         #Ctrlp:construct.c.page1.b_apca057
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca057
            #add-point:ON ACTION controlp INFIELD b_apca057 name="construct.c.filter.page1.b_apca057"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apca057  #顯示到畫面上
            NEXT FIELD b_apca057                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_apca035>>----
         #----<<b_apca038>>----
         #Ctrlp:construct.c.page1.b_apca038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca038
            #add-point:ON ACTION controlp INFIELD b_apca038 name="construct.c.filter.page1.b_apca038"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#4--(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " apca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            CALL q_apca038()
            DISPLAY g_qryparam.return1 TO b_apca038
            NEXT FIELD b_apca038
            #END add-point
 
 
         #----<<b_apca014>>----
         #----<<b_apca015>>----
         #----<<b_apca058>>----
         #----<<b_apca007>>----
         #Ctrlp:construct.c.page1.b_apca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca007
            #add-point:ON ACTION controlp INFIELD b_apca007 name="construct.c.filter.page1.b_apca007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段--帳款類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3111'
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO b_apca007
            NEXT FIELD b_apca007
            #END add-point
 
 
         #----<<b_apca040>>----
         #Ctrlp:construct.c.filter.page1.b_apca040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca040
            #add-point:ON ACTION controlp INFIELD b_apca040 name="construct.c.filter.page1.b_apca040"
            
            #END add-point
 
 
         #----<<b_apcc100>>----
         #Ctrlp:construct.c.filter.page1.b_apcc100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc100
            #add-point:ON ACTION controlp INFIELD b_apcc100 name="construct.c.filter.page1.b_apcc100"
            #開窗c段--幣別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO b_apcc100
            NEXT FIELD b_apcc100
            #END add-point
 
 
         #----<<b_apcc102>>----
         #----<<b_apccseq>>----
         #----<<b_apcc001>>----
         #----<<b_apcc003>>----
         #Ctrlp:construct.c.filter.page1.b_apcc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc003
            #add-point:ON ACTION controlp INFIELD b_apcc003 name="construct.c.filter.page1.b_apcc003"
            
            #END add-point
 
 
         #----<<b_apcc004>>----
         #Ctrlp:construct.c.filter.page1.b_apcc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc004
            #add-point:ON ACTION controlp INFIELD b_apcc004 name="construct.c.filter.page1.b_apcc004"
            
            #END add-point
 
 
         #----<<b_apcc009>>----
         #Ctrlp:construct.c.filter.page1.b_apcc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc009
            #add-point:ON ACTION controlp INFIELD b_apcc009 name="construct.c.filter.page1.b_apcc009"
            
            #END add-point
 
 
         #----<<b_apcc108>>----
         #Ctrlp:construct.c.filter.page1.b_apcc108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc108
            #add-point:ON ACTION controlp INFIELD b_apcc108 name="construct.c.filter.page1.b_apcc108"
            
            #END add-point
 
 
         #----<<b_apcc109>>----
         #Ctrlp:construct.c.filter.page1.b_apcc109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc109
            #add-point:ON ACTION controlp INFIELD b_apcc109 name="construct.c.filter.page1.b_apcc109"
            
            #END add-point
 
 
         #----<<b_sum1>>----
         #----<<b_apcc113>>----
         #Ctrlp:construct.c.filter.page1.b_apcc113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc113
            #add-point:ON ACTION controlp INFIELD b_apcc113 name="construct.c.filter.page1.b_apcc113"
            
            #END add-point
 
 
         #----<<b_apcc118>>----
         #Ctrlp:construct.c.filter.page1.b_apcc118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc118
            #add-point:ON ACTION controlp INFIELD b_apcc118 name="construct.c.filter.page1.b_apcc118"
            
            #END add-point
 
 
         #----<<b_apcc119>>----
         #Ctrlp:construct.c.filter.page1.b_apcc119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc119
            #add-point:ON ACTION controlp INFIELD b_apcc119 name="construct.c.filter.page1.b_apcc119"
            
            #END add-point
 
 
         #----<<b_sum2>>----
         #----<<b_apca053>>----
         #Ctrlp:construct.c.filter.page1.b_apca053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca053
            #add-point:ON ACTION controlp INFIELD b_apca053 name="construct.c.filter.page1.b_apca053"
            
            #END add-point
 
 
   
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      CONSTRUCT g_wc_filter2 ON apcc119,rep_l_sum2 
           FROM s_detail1[1].b_apcc119,s_detail1[1].l_sum2
          BEFORE CONSTRUCT
             DISPLAY aapq360_filter2_parser('apcc119') TO s_detail1[1].b_apcc119
             DISPLAY aapq360_filter2_parser('rep_l_sum2') TO s_detail1[1].l_sum2
      END CONSTRUCT
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         LET g_wc_filter2 = " 1 = 1 "
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
   
      CALL aapq360_filter_show('apcastus','b_apcastus')
   CALL aapq360_filter_show('apcasite','b_apcasite')
   CALL aapq360_filter_show('apcald','b_apcald')
   CALL aapq360_filter_show('apcadocno','b_apcadocno')
   CALL aapq360_filter_show('apcadocdt','b_apcadocdt')
   CALL aapq360_filter_show('apca001','b_apca001')
   CALL aapq360_filter_show('apca004','b_apca004')
   CALL aapq360_filter_show('apca057','b_apca057')
   CALL aapq360_filter_show('apca038','b_apca038')
   CALL aapq360_filter_show('apca007','b_apca007')
   CALL aapq360_filter_show('apca040','b_apca040')
   CALL aapq360_filter_show('apcc100','b_apcc100')
   CALL aapq360_filter_show('apcc003','b_apcc003')
   CALL aapq360_filter_show('apcc004','b_apcc004')
   CALL aapq360_filter_show('apcc009','b_apcc009')
   CALL aapq360_filter_show('apcc108','b_apcc108')
   CALL aapq360_filter_show('apcc109','b_apcc109')
   CALL aapq360_filter_show('apcc113','b_apcc113')
   CALL aapq360_filter_show('apcc118','b_apcc118')
   CALL aapq360_filter_show('apcc119','b_apcc119')
   CALL aapq360_filter_show('apca053','b_apca053')
 
    
   CALL aapq360_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq360.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapq360_filter_parser(ps_field)
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
 
{<section id="aapq360.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapq360_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapq360_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq360.insert" >}
#+ insert
PRIVATE FUNCTION aapq360_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapq360.modify" >}
#+ modify
PRIVATE FUNCTION aapq360_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq360.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aapq360_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq360.delete" >}
#+ delete
PRIVATE FUNCTION aapq360_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq360.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aapq360_detail_action_trans()
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
 
{<section id="aapq360.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aapq360_detail_index_setting()
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
            IF g_apca_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_apca_d.getLength() AND g_apca_d.getLength() > 0
            LET g_detail_idx = g_apca_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_apca_d.getLength() THEN
               LET g_detail_idx = g_apca_d.getLength()
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
 
{<section id="aapq360.mask_functions" >}
 &include "erp/aap/aapq360_mask.4gl"
 
{</section>}
 
{<section id="aapq360.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 預設顯示
# Memo...........:
# Usage..........: CALL aapq360_qbe_clear()

# Date & Author..: 2015/01/28 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq360_qbe_clear()
DEFINE l_ld      LIKE glaa_t.glaald     #160518-00075#14
DEFINE l_comp    LIKE glaa_t.glaacomp   #160518-00075#14
   LET l_ac = 1
   LET g_apca_d[l_ac].apcasite = ''
   LET g_wc_filter2 = "1 = 1"
   DISPLAY ARRAY g_apca_d TO s_detail1.*
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
   #160518-00075#14--s
   #carol:本作業用g_site去對主帳套==>用以取得單據別參照表號
   CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,l_comp,l_ld
   LET g_user_dept_wc = ''
  #CALL s_fin_get_user_dept_control('',l_ld,'apcaent','apcadocno') RETURNING g_user_dept_wc       #160518-00075#26 mark
   CALL s_fin_get_user_dept_control('','apcald','apcaent','apcadocno') RETURNING g_user_dept_wc   #160518-00075#26 
   #160518-00075#14--e
END FUNCTION

PRIVATE FUNCTION aapq360_filter2_show(ps_field,ps_object)

   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aapq360_filter2_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
END FUNCTION

PRIVATE FUNCTION aapq360_filter2_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
    
   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter2.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter2.subString(li_tmp,li_tmp2)
   END IF
 
   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter2.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter2.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter2.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF
 
   RETURN ls_var
END FUNCTION
################################################################################
# Descriptions...: 建立臨時表
# Memo...........: #170117-00012#1
# Usage..........: CALL aapq360_create_tmp()
# Date & Author..: 170118 By 06694
################################################################################
PRIVATE FUNCTION aapq360_create_tmp()

   DROP TABLE aapq360_x01_tmp;
   CREATE TEMP TABLE aapq360_x01_tmp(
      apcastus          VARCHAR(100),
      l_apcastus_desc   VARCHAR(100),
      apcasite          VARCHAR(10),
      apcacomp          VARCHAR(500), 
      l_apcacomp_desc   VARCHAR(100), 
      apcald            VARCHAR(5), 
      apcadocno         VARCHAR(20),
      apcadocdt         DATE,
      apca001           VARCHAR(100),
      l_apca001_desc    VARCHAR(100),
      apca004           VARCHAR(10), 
      l_apca004_desc    VARCHAR(100),  
      apca057           VARCHAR(20),      
      apca035           VARCHAR(500),
      l_apca035_desc    VARCHAR(100), 
      apca038           VARCHAR(20),       
      apca014           VARCHAR(500), 
      l_apca014_desc    VARCHAR(100), 
      apca015           VARCHAR(500), 
      l_apca015_desc    VARCHAR(100),  
      apca058           VARCHAR(500),
      l_apca058_desc    VARCHAR(100),      
      apca007           VARCHAR(10), 
      apca040           VARCHAR(1), 
      apcc100           VARCHAR(10), 
      apcc102           DECIMAL(20,10), 
      apccseq           INTEGER, 
      apcc001           INTEGER, 
      apcc003           DATE, 
      apcc004           DATE, 
      apcc009           VARCHAR(20), 
      apcc108           DECIMAL(20,6), 
      apcc109           DECIMAL(20,6), 
      l_sum1            DECIMAL(20,6), 
      apcc113           DECIMAL(20,6), 
      apcc118           DECIMAL(20,6), 
      apcc119           DECIMAL(20,6), 
      l_sum2            DECIMAL(20,6), 
      apca053           VARCHAR(255)
   )
END FUNCTION

################################################################################
# Descriptions...: #依畫面資料INSERT XG_tmp
# Memo...........: #170117-00012#1 add
# Usage..........: aapq360_insert_tmp()
# Input parameter: l_x01_tmp   記錄單身資料的record
# Date & Author..: 2017/01/18 By 06694
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq360_insert_tmp()
   DEFINE l_i          LIKE type_t.num10
   DEFINE l_x01_tmp       RECORD 
      apcastus         LIKE type_t.chr100,
      l_apcastus_desc  LIKE type_t.chr100,
      apcasite         LIKE apca_t.apcasite,
      apcacomp         LIKE type_t.chr500,
      l_apcacomp_desc  LIKE type_t.chr100,
      apcald           LIKE apca_t.apcald, 
      apcadocno        LIKE apca_t.apcadocno,
      apcadocdt        LIKE apca_t.apcadocdt,
      apca001          LIKE type_t.chr100,
      l_apca001_desc   LIKE type_t.chr100,
      apca004          LIKE apca_t.apca004, 
      l_apca004_desc   LIKE type_t.chr100,  
      apca057          LIKE apca_t.apca057,      
      apca035          LIKE type_t.chr500,
      l_apca035_desc   LIKE type_t.chr100,
      apca038          LIKE apca_t.apca038,       
      apca014          LIKE type_t.chr500, 
      l_apca014_desc   LIKE type_t.chr100,
      apca015          LIKE type_t.chr500, 
      l_apca015_desc   LIKE type_t.chr100,
      apca058          LIKE type_t.chr500, 
      l_apca058_desc   LIKE type_t.chr100,
      apca007          LIKE apca_t.apca007, 
      apca040          LIKE apca_t.apca040, 
      apcc100          LIKE apcc_t.apcc100, 
      apcc102          LIKE apcc_t.apcc102, 
      apccseq          LIKE apcc_t.apccseq, 
      apcc001          LIKE apcc_t.apcc001, 
      apcc003          LIKE apcc_t.apcc003, 
      apcc004          LIKE apcc_t.apcc004, 
      apcc009          LIKE apcc_t.apcc009, 
      apcc108          LIKE apcc_t.apcc108, 
      apcc109          LIKE apcc_t.apcc109, 
      l_sum1           LIKE type_t.num20_6, 
      apcc113          LIKE apcc_t.apcc113, 
      apcc118          LIKE apcc_t.apcc118, 
      apcc119          LIKE apcc_t.apcc119, 
      l_sum2           LIKE type_t.num20_6, 
      apca053          LIKE apca_t.apca053     
   END RECORD
   
   DELETE FROM aapq360_x01_tmp
   FOR l_i = 1 TO g_apca_d.getLength()
      INITIALIZE l_x01_tmp.* TO NULL
      LET l_x01_tmp.apcastus          = g_apca_d[l_i].apcastus
      IF cl_null(g_apca_d[l_i].apcastus) THEN 
         LET l_x01_tmp.l_apcastus_desc  = ""
      ELSE
         LET l_x01_tmp.l_apcastus_desc  = l_x01_tmp.apcastus,":",s_desc_gzcbl004_desc('13',l_x01_tmp.apcastus)
      END IF     
      LET l_x01_tmp.apcasite          = g_apca_d[l_i].apcasite
      LET l_x01_tmp.apcacomp          = g_apca_d[l_i].apcacomp
      IF cl_null(g_apca_d[l_i].apcacomp) THEN 
         LET l_x01_tmp.l_apcacomp_desc= ""
      ELSE
         LET l_x01_tmp.l_apcacomp_desc= l_x01_tmp.apcacomp 
      END IF
      LET l_x01_tmp.apcald            = g_apca_d[l_i].apcald
      LET l_x01_tmp.apcadocno         = g_apca_d[l_i].apcadocno
      LET l_x01_tmp.apcadocdt         = g_apca_d[l_i].apcadocdt
      LET l_x01_tmp.apca001           = g_apca_d[l_i].apca001
      LET l_x01_tmp.l_apca001_desc    = l_x01_tmp.apca001,":",s_desc_gzcbl004_desc('8502',l_x01_tmp.apca001)
      LET l_x01_tmp.apca004           = g_apca_d[l_i].apca004
      LET l_x01_tmp.l_apca004_desc    = g_apca_d[l_i].apca004_desc
      LET l_x01_tmp.apca057           = g_apca_d[l_i].apca057
      LET l_x01_tmp.apca035           = g_apca_d[l_i].apca035
      IF cl_null(g_apca_d[l_i].apca035) THEN 
         LET l_x01_tmp.l_apca035_desc= ""
      ELSE
         LET l_x01_tmp.l_apca035_desc= l_x01_tmp.apca035
      END IF
      LET l_x01_tmp.apca038           = g_apca_d[l_i].apca038
      LET l_x01_tmp.apca014           = g_apca_d[l_i].apca014
      IF cl_null(g_apca_d[l_i].apca014) THEN 
         LET l_x01_tmp.l_apca014_desc= ""
      ELSE
         LET l_x01_tmp.l_apca014_desc= l_x01_tmp.apca014
      END IF      
      LET l_x01_tmp.apca015           = g_apca_d[l_i].apca015
      IF cl_null(g_apca_d[l_i].apca015) THEN 
         LET l_x01_tmp.l_apca015_desc= ""
      ELSE
         LET l_x01_tmp.l_apca015_desc= l_x01_tmp.apca015
      END IF
      LET l_x01_tmp.apca058           = g_apca_d[l_i].apca058
      LET l_x01_tmp.l_apca058_desc    = g_apca_d[l_i].apca058
      LET l_x01_tmp.apca007           = g_apca_d[l_i].apca007
      LET l_x01_tmp.apca040           = g_apca_d[l_i].apca040
      LET l_x01_tmp.apcc100           = g_apca_d[l_i].apcc100
      LET l_x01_tmp.apcc102           = g_apca_d[l_i].apcc102
      LET l_x01_tmp.apccseq           = g_apca_d[l_i].apccseq
      LET l_x01_tmp.apcc001           = g_apca_d[l_i].apcc001
      LET l_x01_tmp.apcc003           = g_apca_d[l_i].apcc003
      LET l_x01_tmp.apcc004           = g_apca_d[l_i].apcc004
      LET l_x01_tmp.apcc009           = g_apca_d[l_i].apcc009
      LET l_x01_tmp.apcc108           = g_apca_d[l_i].apcc108
      LET l_x01_tmp.apcc109           = g_apca_d[l_i].apcc109
      LET l_x01_tmp.l_sum1            = g_apca_d[l_i].sum1
      LET l_x01_tmp.apcc113           = g_apca_d[l_i].apcc113
      LET l_x01_tmp.apcc118           = g_apca_d[l_i].apcc118
      LET l_x01_tmp.apcc119           = g_apca_d[l_i].apcc119
      LET l_x01_tmp.l_sum2            = g_apca_d[l_i].sum2
      LET l_x01_tmp.apca053           = g_apca_d[l_i].apca053
      
      INSERT INTO aapq360_x01_tmp (apcastus,l_apcastus_desc,apcasite,apcacomp,l_apcacomp_desc,apcald,apcadocno,apcadocdt,
                                   apca001,l_apca001_desc,apca004,l_apca004_desc,apca057,apca035,l_apca035_desc,apca038,
                                   apca014,l_apca014_desc,apca015,l_apca015_desc,apca058,l_apca058_desc,apca007,apca040,
                                   apcc100,apcc102,apccseq,apcc001,apcc003,apcc004,apcc009,apcc108,apcc109,l_sum1,apcc113,
                                   apcc118,apcc119,l_sum2,apca053
                                   )
      VALUES (l_x01_tmp.apcastus,l_x01_tmp.l_apcastus_desc,l_x01_tmp.apcasite,l_x01_tmp.apcacomp,l_x01_tmp.l_apcacomp_desc,l_x01_tmp.apcald,
              l_x01_tmp.apcadocno,l_x01_tmp.apcadocdt,l_x01_tmp.apca001,l_x01_tmp.l_apca001_desc,l_x01_tmp.apca004,
              l_x01_tmp.l_apca004_desc,l_x01_tmp.apca057,l_x01_tmp.apca035,l_x01_tmp.l_apca035_desc,l_x01_tmp.apca038,l_x01_tmp.apca014,l_x01_tmp.l_apca014_desc,
              l_x01_tmp.apca015,l_x01_tmp.l_apca015_desc,l_x01_tmp.apca058,l_x01_tmp.l_apca058_desc,l_x01_tmp.apca007,l_x01_tmp.apca040,l_x01_tmp.apcc100,l_x01_tmp.apcc102,
              l_x01_tmp.apccseq,l_x01_tmp.apcc001,l_x01_tmp.apcc003,l_x01_tmp.apcc004,l_x01_tmp.apcc009,l_x01_tmp.apcc108,
              l_x01_tmp.apcc109,l_x01_tmp.l_sum1,l_x01_tmp.apcc113,l_x01_tmp.apcc118,l_x01_tmp.apcc119,l_x01_tmp.l_sum2,
              l_x01_tmp.apca053
             )
      
   END FOR
END FUNCTION

 
{</section>}
 
