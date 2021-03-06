#該程式未解開Section, 採用最新樣板產出!
{<section id="aapq370.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-02-17 10:26:13), PR版次:0005(2017-01-09 17:13:08)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000048
#+ Filename...: aapq370
#+ Description: 進貨金額排行榜
#+ Creator....: 05016(2015-11-25 17:04:51)
#+ Modifier...: 05016 -SD/PR- 06821
 
{</section>}
 
{<section id="aapq370.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151231-00010#4   2016/01/11  By 02097    增加控制組/若單頭沒有帳套條件的開窗,都限制取目前所在據點對應的法人串 pmabsite/若input 條件有帳套就以帳套對應法人串 pmabsite 
#160215-00013#2   2016/02/17  By HansQBE 增加二欄採購性質 pmds011 料件類別 imaa004 故要增加串 imaa_t 
#161006-00005#19  2016/10/24  By 08732    組織類型與職能開窗調整
#161115-00042#4   2016/11/16  By 08171    開窗範圍處理
#161229-00047#30  2017/01/09  By 06821    財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
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
PRIVATE TYPE type_g_apcb_d RECORD
       #statepic       LIKE type_t.chr1,
       
       apcbseq LIKE apcb_t.apcbseq, 
   apca004 LIKE type_t.chr500, 
   apca004_desc LIKE type_t.chr500, 
   apcb113 LIKE apcb_t.apcb113, 
   apcb1132 LIKE type_t.num20_6, 
   amt LIKE type_t.num20_6, 
   per LIKE type_t.num20_6, 
   apcbdocno LIKE apcb_t.apcbdocno, 
   apcbld LIKE apcb_t.apcbld 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input RECORD
    apcasite      LIKE apca_t.apcasite,
    apcasite_desc LIKE type_t.chr100,
    strdate       LIKE apca_t.apcadocdt,
    enddate       LIKE apca_t.apcadocdt,
    pmaa047       LIKE pmaa_t.pmaa047,
    pmds048       LIKE type_t.chr1,
    type          LIKE type_t.chr1,
    rank          LIKE type_t.num5,
    mon           LIKE apca_t.apca113,
    apca001       LIKE apca_t.apca001,
    pmds000       LIKE pmds_t.pmds000,
    wc            STRING
END RECORD
DEFINE g_wc_apcasite STRING
DEFINE g_apca001_str STRING
DEFINE g_pmds000_str STRING
DEFINE g_ld   LIKE apca_t.apcald
DEFINE g_comp LIKE apca_t.apcacomp
DEFINE g_sql_ctrl          STRING      #151231-00010#4
DEFINE g_wc_pmds011        STRING      #160215-00013#2
DEFINE g_apcacomp LIKE apca_t.apcacomp #161115-00042#4 控制組抓g_site的法人
DEFINE g_wc_cs_comp        STRING      #161229-00047#30 add
DEFINE g_comp_str          STRING      #161229-00047#30 add 
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_apcb_d
DEFINE g_master_t                   type_g_apcb_d
DEFINE g_apcb_d          DYNAMIC ARRAY OF type_g_apcb_d
DEFINE g_apcb_d_t        type_g_apcb_d
 
      
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
 
{<section id="aapq370.main" >}
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
  #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161115-00042#4 mark
   #161115-00042#4 --s add
   SELECT ooef017 INTO g_apcacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apcacomp) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#30 mark
   #161115-00042#4 --e add
   #151231-00010#4--(E)
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
   DECLARE aapq370_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapq370_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapq370_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapq370 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapq370_init()   
 
      #進入選單 Menu (="N")
      CALL aapq370_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapq370
      
   END IF 
   
   CLOSE aapq370_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapq370.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapq370_init()
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
   LET g_apca001_str = s_aap_get_acc_str('8502',"gzcb005 IN ('aapt320','aapt300','aapt340') ")
   CALL cl_set_combo_scc_part('apca001','8502',g_apca001_str)
   LET g_apca001_str = s_fin_get_wc_str(g_apca001_str)
   
   LET g_pmds000_str = s_aap_get_acc_str('2060',"gzcb003 = 'Y'")
   CALL cl_set_combo_scc_part('pmds000','2060',g_pmds000_str)
   LET g_pmds000_str = s_fin_get_wc_str(g_pmds000_str)
   
   #160215-00013#2---s---   
   CALL cl_set_combo_scc('imaa004','1001')   
   CALL cl_set_combo_scc('imaa004_1','1001') 
   CALL cl_set_combo_scc('pmds011','2061')   
   CALL cl_set_combo_scc('pmds011_1','2061') 
   #160215-00013#2---e---  
   
   
   CALL s_fin_create_account_center_tmp()                   #展組織下階成員所需之暫存檔 
   CALL aapq370_create_tmp()
   CALL aapq370_set_default()
   #161229-00047#30 --s add
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp      
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl 
   #161229-00047#30 --e add     
   #end add-point
 
   CALL aapq370_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aapq370.default_search" >}
PRIVATE FUNCTION aapq370_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " apcbld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " apcbdocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " apcbseq = '", g_argv[03], "' AND "
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
 
{<section id="aapq370.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aapq370_ui_dialog()
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
      CALL aapq370_b_fill()
   ELSE
      CALL aapq370_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_apcb_d.clear()
 
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
 
         CALL aapq370_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_apcb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aapq370_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aapq370_detail_action_trans()
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
            CALL aapq370_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aapq370_print()
               CALL aapq370_x01('1=1','aapq370_x01_tmp')
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aapq370_print()
               CALL aapq370_x01('1=1','aapq370_x01_tmp')
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapq370_query()
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
            CALL aapq370_filter()
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
            CALL aapq370_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_apcb_d)
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
            CALL aapq370_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aapq370_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aapq370_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aapq370_b_fill()
 
         
         
 
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
 
{<section id="aapq370.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapq370_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_str      STRING
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_apcb_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON apcbseq,apcb113,apcbdocno,apcbld
           FROM s_detail1[1].b_apcbseq,s_detail1[1].b_apcb113,s_detail1[1].b_apcbdocno,s_detail1[1].b_apcbld 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            NEXT FIELD apcasite
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_apcbseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcbseq
            #add-point:BEFORE FIELD b_apcbseq name="construct.b.page1.b_apcbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcbseq
            
            #add-point:AFTER FIELD b_apcbseq name="construct.a.page1.b_apcbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcbseq
            #add-point:ON ACTION controlp INFIELD b_apcbseq name="construct.c.page1.b_apcbseq"
            
            #END add-point
 
 
         #----<<b_apca004>>----
         #----<<apca004_desc>>----
         #----<<b_apcb113>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcb113
            #add-point:BEFORE FIELD b_apcb113 name="construct.b.page1.b_apcb113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcb113
            
            #add-point:AFTER FIELD b_apcb113 name="construct.a.page1.b_apcb113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcb113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcb113
            #add-point:ON ACTION controlp INFIELD b_apcb113 name="construct.c.page1.b_apcb113"
            
            #END add-point
 
 
         #----<<apcb1132>>----
         #----<<amt>>----
         #----<<per>>----
         #----<<b_apcbdocno>>----
         #Ctrlp:construct.c.page1.b_apcbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcbdocno
            #add-point:ON ACTION controlp INFIELD b_apcbdocno name="construct.c.page1.b_apcbdocno"
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
            CALL q_apcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apcbdocno  #顯示到畫面上
            NEXT FIELD b_apcbdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcbdocno
            #add-point:BEFORE FIELD b_apcbdocno name="construct.b.page1.b_apcbdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcbdocno
            
            #add-point:AFTER FIELD b_apcbdocno name="construct.a.page1.b_apcbdocno"
            
            #END add-point
            
 
 
         #----<<b_apcbld>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcbld
            #add-point:BEFORE FIELD b_apcbld name="construct.b.page1.b_apcbld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcbld
            
            #add-point:AFTER FIELD b_apcbld name="construct.a.page1.b_apcbld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcbld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcbld
            #add-point:ON ACTION controlp INFIELD b_apcbld name="construct.c.page1.b_apcbld"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_input.apcasite,g_input.strdate,g_input.enddate,g_input.pmaa047,
                    g_input.pmds048 ,g_input.type   ,g_input.rank  ,g_input.mon,
                    g_input.apcasite_desc                    
                    ATTRIBUTE(WITHOUT DEFAULTS)
          
          AFTER FIELD apcasite
             IF NOT cl_null(g_input.apcasite) THEN
                CALL s_fin_account_center_with_ld_chk(g_input.apcasite,'',g_user,'3','N','',g_today) 
                   RETURNING g_sub_success,g_errno
                IF NOT g_sub_success THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = g_errno
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_input.apcasite = ''
                   LET g_input.apcasite_desc = ''
                   DISPLAY BY NAME g_input.apcasite_desc,g_input.apcasite
                   NEXT FIELD CURRENT
                END IF
                CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'1')
                #取得帳務中心底下之組織範圍
                CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
                CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
                #取得所屬法人加帳別
                CALL s_fin_orga_get_comp_ld(g_input.apcasite) RETURNING g_sub_success,g_errno,g_comp,g_ld   
                #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#4 add  #161229-00047#30 mark
                CALL s_fin_get_wc_str(g_comp) RETURNING g_comp_str  #161229-00047#30 add 
                CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#30 add                
             END IF
             CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc
             DISPLAY BY NAME g_input.apcasite,g_input.apcasite_desc
         
          ON ACTION controlp INFIELD apcasite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.apcasite
            #CALL q_ooef001()     #161006-00005#19   mark
            CALL q_ooef001_46()   #161006-00005#19   add 
            LET g_input.apcasite = g_qryparam.return1
            CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc
            DISPLAY BY NAME g_input.apcasite,g_input.apcasite_desc
            NEXT FIELD apcasite
          
         AFTER FIELD strdate
            IF NOT cl_null(g_input.strdate)THEN
               IF g_input.strdate > g_input.enddate THEN
                  LET g_input.enddate = g_input.strdate
               END IF
            END IF
            
         AFTER FIELD enddate
            IF NOT cl_null(g_input.enddate)THEN
               IF g_input.enddate < g_input.strdate THEN
                  LET g_input.strdate = g_input.enddate
               END IF
            END IF
         
         ON CHANGE type
            CALL cl_set_comp_visible('group_2,group_3',TRUE)
            IF g_input.type = '0' THEN
               CALL cl_set_comp_visible('group_3',FALSE)
            ELSE
               CALL cl_set_comp_visible('group_2',FALSE)
            END IF


      END INPUT
      CONSTRUCT BY NAME g_wc_pmds011 ON pmds011
      END CONSTRUCT
      CONSTRUCT BY NAME g_input.wc ON apca005,apca007,apcadocno,pmdsdocno,pmds008,apca001,pmds000
                                      ,imaa004,pmds011_1,imaa004_1      #160215-00013#2
      
         ON ACTION controlp INFIELD apca007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3211'
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO apca007  #顯示到畫面上
            NEXT FIELD apca007
              
         ON ACTION controlp INFIELD apcadocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET l_str = " apcasite = '",g_input.apcasite,"' AND apcacomp = '",g_comp,"' AND apcald = '",g_ld,"' ",
                        " AND apcadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"'                 ",
                        " AND apcastus ='Y'                                                                     ",
                        " AND EXISTS ( SELECT 1 FROM pmds_t WHERE pmdsent = '",g_enterprise,"'                  ",
                        "                        AND pmdsdocno IN ( SELECT apcb002 FROM apcb_t                  ",
                        "                                            WHERE apcadocno = apcbdocno AND apcald = apcbld ",
                        "                                              AND apcb023 = 'N'                        ",
                        "                                              AND apcbent = '",g_enterprise,"' )       ",
                        "                        AND pmdsstus ='S'                                              "                                                                      
            IF g_input.pmds048 MATCHES '[12]' THEN　#內外購
               LET l_str = l_str CLIPPED, " AND pmds048 = '",g_input.pmds048,"'                    "
            END IF       
            LET l_str = l_str CLIPPED, ") "     
            IF g_input.pmaa047 MATCHES '[12]' THEN  #企業關係人       
               LET l_str  =l_str CLIPPED,  "   AND EXISTS ( SELECT 1 FROM pmaa_t WHERE pmaaent = '",g_enterprise,"'   ",
                                           "                   AND pmaa001 = apca005                                  ",
                                           "   AND CASE WHEN pmaa047 = 'Y' THEN 1 ELSE 2 END = '",g_input.pmaa047,"') "            
            END IF                     
            IF NOT cl_null(g_input.apca001) THEN #採購性質
               LET l_str = l_str CLIPPED ," AND apca001 = '",g_input.apca001,"'  " 
            ELSE
               LET l_str = l_str CLIPPED ," AND apca001 IN ", g_apca001_str  
            END IF       
            LET g_qryparam.where = l_str
            #151231-00010#4--(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND apca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)  
            CALL q_apcadocno()
            DISPLAY g_qryparam.return1 TO apcadocno
            NEXT FIELD apcadocno
            
         ON ACTION controlp INFIELD apca005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE          
            #151231-00010#4--(S)
            LET g_qryparam.where = " pmac002 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                   " AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"'))"
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND pmac002 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)  
            CALL q_pmac002_1()
            DISPLAY g_qryparam.return1 TO apca005  #顯示到畫面上
            NEXT FIELD apca005
            
         ON ACTION controlp INFIELD pmdsdocno 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_pmds000_str          #單據類型
            LET l_str = " pmdsstus = 'S'  AND pmds001 BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"' ", 
                        " AND pmdssite IN ",g_wc_apcasite
            IF g_input.pmaa047 MATCHES '[12]' THEN
               LET l_str  =l_str CLIPPED,  "   AND EXISTS ( SELECT 1 FROM pmaa_t WHERE pmaaent = '",g_enterprise,"'   ",
                                            "                   AND pmaa001 = pmds008                                  ",
                                            "   AND CASE WHEN pmaa047 = 'Y' THEN 1 ELSE 2 END = '",g_input.pmaa047,"') "            
            END IF            
            IF NOT cl_null(g_input.pmds000) THEN
               LET l_str = l_str CLIPPED," pmds000 = '",g_input.pmds000,"' "
            END IF
            IF g_input.pmds048 MATCHES '[12]' THEN　#內外購
               LET l_str = l_str CLIPPED, "AND pmds048 = '",g_input.pmds048,"'  "
            END IF
            
            LET g_qryparam.where = l_str   
            #151231-00010#4--(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND pmds008 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)              
            CALL q_pmdsdocno_7()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdsdocno  #顯示到畫面上
            NEXT FIELD pmdsdocno                     #返回原欄位
            
         ON ACTION controlp INFIELD pmds008 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#4--(S)
            LET g_qryparam.where = " pmac002 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                   " AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"'))"
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND pmac002 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)  
            CALL q_pmac002_1()               #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmds008  #顯示到畫面上
            NEXT FIELD pmds008                     #返回原欄位
            
      END CONSTRUCT
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
         CALL aapq370_set_default()
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
   CALL aapq370_b_fill()
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
 
{<section id="aapq370.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapq370_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sum     LIKE type_t.num20_6
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   IF g_input.type = '0' THEN
      CALL aapq370_ins_apcb()
   ELSE
      CALL aapq370_ins_pmds()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE apcbseq,'','',apcb113,'','','',apcbdocno,apcbld  ,DENSE_RANK() OVER( ORDER BY apcb_t.apcbld, 
       apcb_t.apcbdocno,apcb_t.apcbseq) AS RANK FROM apcb_t",
 
 
                     "",
                     " WHERE apcbent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("apcb_t"),
                     " ORDER BY apcb_t.apcbld,apcb_t.apcbdocno,apcb_t.apcbseq"
 
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
 
   LET g_sql = "SELECT apcbseq,'','',apcb113,'','','',apcbdocno,apcbld",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT apcbseq,apca004,'',apcb113,apcb1132,amt,'','',''  ",
                " FROM aapq370_tmp                                       ",
                "WHERE apcbseq <= '",g_input.rank,"'                     ",
                "  AND amt >= '",g_input.mon,"' AND apcbent = ?          ",
                #161115-00042#4 --s add
                "   AND EXISTS (SELECT 1 FROM pmaa_t ",
                "               WHERE pmaaent = ",g_enterprise,
                "               AND ",g_sql_ctrl,
                "               AND pmaaent = apcbent ",
                "               AND pmaa001 = apca004 ) ",
                #161115-00042#4 --e add
                "  ORDER BY apcbseq                                      "
   
   SELECT SUM(amt) INTO l_sum 
     FROM aapq370_tmp 
    WHERE apcbseq <= g_input.rank
      AND amt >= g_input.mon
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapq370_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapq370_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_apcb_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_apcb_d[l_ac].apcbseq,g_apcb_d[l_ac].apca004,g_apcb_d[l_ac].apca004_desc, 
       g_apcb_d[l_ac].apcb113,g_apcb_d[l_ac].apcb1132,g_apcb_d[l_ac].amt,g_apcb_d[l_ac].per,g_apcb_d[l_ac].apcbdocno, 
       g_apcb_d[l_ac].apcbld
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_apcb_d[l_ac].statepic = cl_get_actipic(g_apcb_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_apcb_d[l_ac].per = g_apcb_d[l_ac].amt/l_sum * 100
      LET g_apcb_d[l_ac].apca004_desc = s_desc_get_trading_partner_abbr_desc(g_apcb_d[l_ac].apca004)
      #end add-point
 
      CALL aapq370_detail_show("'1'")      
 
      CALL aapq370_apcb_t_mask()
 
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
   
 
   
   CALL g_apcb_d.deleteElement(g_apcb_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   LET g_tot_cnt = g_apcb_d.getLength()
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_apcb_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aapq370_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aapq370_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aapq370_detail_action_trans()
 
   IF g_apcb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aapq370_fetch()
   END IF
   
      CALL aapq370_filter_show('apcbseq','b_apcbseq')
   CALL aapq370_filter_show('apcb113','b_apcb113')
   CALL aapq370_filter_show('apcbdocno','b_apcbdocno')
   CALL aapq370_filter_show('apcbld','b_apcbld')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq370.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapq370_fetch()
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
 
{<section id="aapq370.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapq370_detail_show(ps_page)
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
 
{<section id="aapq370.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapq370_filter()
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
      CONSTRUCT g_wc_filter ON apcbseq,apcb113,apcbdocno,apcbld
                          FROM s_detail1[1].b_apcbseq,s_detail1[1].b_apcb113,s_detail1[1].b_apcbdocno, 
                              s_detail1[1].b_apcbld
 
         BEFORE CONSTRUCT
                     DISPLAY aapq370_filter_parser('apcbseq') TO s_detail1[1].b_apcbseq
            DISPLAY aapq370_filter_parser('apcb113') TO s_detail1[1].b_apcb113
            DISPLAY aapq370_filter_parser('apcbdocno') TO s_detail1[1].b_apcbdocno
            DISPLAY aapq370_filter_parser('apcbld') TO s_detail1[1].b_apcbld
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_apcbseq>>----
         #Ctrlp:construct.c.filter.page1.b_apcbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcbseq
            #add-point:ON ACTION controlp INFIELD b_apcbseq name="construct.c.filter.page1.b_apcbseq"
            
            #END add-point
 
 
         #----<<b_apca004>>----
         #----<<apca004_desc>>----
         #----<<b_apcb113>>----
         #Ctrlp:construct.c.filter.page1.b_apcb113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcb113
            #add-point:ON ACTION controlp INFIELD b_apcb113 name="construct.c.filter.page1.b_apcb113"
            
            #END add-point
 
 
         #----<<apcb1132>>----
         #----<<amt>>----
         #----<<per>>----
         #----<<b_apcbdocno>>----
         #Ctrlp:construct.c.page1.b_apcbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcbdocno
            #add-point:ON ACTION controlp INFIELD b_apcbdocno name="construct.c.filter.page1.b_apcbdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151231-00010#4--(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND apca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)     
            CALL q_apcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apcbdocno  #顯示到畫面上
            NEXT FIELD b_apcbdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_apcbld>>----
         #Ctrlp:construct.c.filter.page1.b_apcbld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcbld
            #add-point:ON ACTION controlp INFIELD b_apcbld name="construct.c.filter.page1.b_apcbld"
            
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
   
      CALL aapq370_filter_show('apcbseq','b_apcbseq')
   CALL aapq370_filter_show('apcb113','b_apcb113')
   CALL aapq370_filter_show('apcbdocno','b_apcbdocno')
   CALL aapq370_filter_show('apcbld','b_apcbld')
 
    
   CALL aapq370_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq370.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapq370_filter_parser(ps_field)
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
 
{<section id="aapq370.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapq370_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapq370_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq370.insert" >}
#+ insert
PRIVATE FUNCTION aapq370_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapq370.modify" >}
#+ modify
PRIVATE FUNCTION aapq370_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq370.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aapq370_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq370.delete" >}
#+ delete
PRIVATE FUNCTION aapq370_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq370.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aapq370_detail_action_trans()
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
 
{<section id="aapq370.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aapq370_detail_index_setting()
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
            IF g_apcb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_apcb_d.getLength() AND g_apcb_d.getLength() > 0
            LET g_detail_idx = g_apcb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_apcb_d.getLength() THEN
               LET g_detail_idx = g_apcb_d.getLength()
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
 
{<section id="aapq370.mask_functions" >}
 &include "erp/aap/aapq370_mask.4gl"
 
{</section>}
 
{<section id="aapq370.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 創建臨時表
# Memo...........:
# Usage..........: CALL aapq370_create_tmp()
# Date & Author..: 2015/11/25 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq370_create_tmp()

   DROP TABLE aapq370_tmp;
           CREATE TEMP TABLE aapq370_tmp(
      apcbseq      LIKE apcb_t.apcbseq, 
      apca004      LIKE type_t.chr500, 
      apcb113      LIKE apcb_t.apcb113, 
      apcb1132     LIKE type_t.num20_6, 
      amt          LIKE type_t.num20_6,
      apcbent      LIKE apcb_t.apcbent
   )
   
   DROP TABLE aapq370_x01_tmp;
      CREATE TEMP TABLE aapq370_x01_tmp(
           apcasite_desc LIKE type_t.chr100,
           apcadate_desc LIKE type_t.chr100,
           pmaa047_desc  LIKE type_t.chr100,
           pmds048_desc  LIKE type_t.chr100, 
           type_desc     LIKE type_t.chr100,
           rank          LIKE type_t.num5,
           mon           LIKE apca_t.apca113,            
           apcbseq       LIKE apcb_t.apcbseq, 
           apca004       LIKE apca_t.apca004, 
           apca004_desc  LIKE type_t.chr500, 
           apcb113       LIKE apcb_t.apcb113, 
           apcb1132      LIKE type_t.num20_6, 
           amt           LIKE type_t.num20_6, 
           per           LIKE type_t.num20_6
   )
       
END FUNCTION

################################################################################
# Descriptions...: 插入臨時表(AP)
# Memo...........:
# Usage..........: CALL aapq370_ins_apcb()
# Date & Author..: 2015/11/30 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq370_ins_apcb()

   DELETE FROM aapq370_tmp
   IF cl_null(g_input.wc) THEN LET g_input.wc = '1=1' END IF     
   IF cl_null(g_wc_pmds011) THEN LET g_wc_pmds011 = '1=1' END IF                             #160215-00013#2
   LET g_sql = " SELECT apca005,SUM(CASE apcb022 WHEN  1 THEN apcb113 ELSE 0 END)    a1,  ",
               "                SUM(CASE apcb022 WHEN -1 THEN apcb113*-1 ELSE 0 END) a2   ",
               "   FROM apcb_t,apca_t,imaa_t WHERE apcadocno = apcbdocno                  ", #160215-00013#2 Add imaa_t
               "    AND apcaent = imaaent AND apcb004 = imaa001                           ", #160215-00013#2               
               "    AND apcaent = apcbent AND apcaent = '",g_enterprise,"'                ", 
               "    AND apcadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"' ",
               "    AND EXISTS ( SELECT 1 FROM pmds_t WHERE pmdsent = '",g_enterprise,"'  ",
               "                              AND pmdsdocno = apcb002 AND pmdsstus ='S'   "
   LET g_sql = g_sql CLIPPED, " AND ",g_wc_pmds011                                           #160215-00013#2
   IF g_input.pmds048 MATCHES '[12]' THEN　#內外購
     LET g_sql = g_sql CLIPPED, " AND pmds048 = '",g_input.pmds048,"'                     "
   END IF         
   LET g_sql = g_sql CLIPPED, ")"
   IF g_input.pmaa047 MATCHES '[12]' THEN #企業關係人
      LET g_sql = g_sql CLIPPED,
               "   AND EXISTS ( SELECT 1 FROM pmaa_t WHERE pmaaent = '",g_enterprise,"' ",
               "                         AND pmaa001 = apca005                          ",
               "   AND CASE WHEN pmaa047 = 'Y' THEN 1 ELSE 2 END  = '",g_input.pmaa047,"')   "
   END IF                  
   LET g_sql = g_sql CLIPPED ," AND apca001 IN ", g_apca001_str  
   #IF NOT cl_null(g_input.apca001) THEN #採購性質
   #   LET g_sql = g_sql CLIPPED ," AND apca001 = '",g_input.apca001,"'                  " 
   #ELSE
   #   LET g_sql = g_sql CLIPPED ," AND apca001 IN ", g_apca001_str  
   #END IF
   LET g_sql = g_sql CLIPPED, " AND apcb023 ='N' AND apcasite ='",g_input.apcasite,"' AND apcastus = 'Y' ",
                              " AND ",g_input.wc
                              
   #151231-00010#4--(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_sql = g_sql," AND apca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#4--(E)                             
  LET g_sql =  " INSERT INTO aapq370_tmp                                                        ",
               " SELECT DENSE_RANK() OVER( ORDER BY (a1+a2)desc) AS RANK ,apca005,a1,a2,(a1+a2),",
               "        '",g_enterprise,"'                                                      ",
               "   FROM ( ", g_sql , " GROUP BY apca005   )                                     "                       
 
   PREPARE aapq370_ins_apcb_prep01 FROM g_sql 
   EXECUTE aapq370_ins_apcb_prep01
   
   

END FUNCTION

################################################################################
# Descriptions...: 插入臨時表(APM)
# Memo...........:
# Usage..........: CALL aapq370_ins_pmds()
# Date & Author..: 2015/11/25 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq370_ins_pmds()
   
   DELETE FROM aapq370_tmp
   IF cl_null(g_input.wc) THEN LET g_input.wc = '1=1' END IF
   LET g_input.wc = cl_replace_str(g_input.wc,'pmds011_1','pmds011') #160215-00013#2
   LET g_input.wc = cl_replace_str(g_input.wc,'imaa004_1','imaa004') #160215-00013#2
   LET g_sql = " SELECT pmds008,  ",
               #"        CASE WHEN gzcb004 = '1'  THEN (pmds043*pmds038) * gzcb004 ELSE 0 END amt1 ,",
               #"        CASE WHEN gzcb004 = '-1' THEN (pmds043*pmds038) * gzcb004 ELSE 0 END amt2  ",
               "        CASE WHEN gzcb004 = '1'  THEN (pmdt038*pmds038) * gzcb004 ELSE 0 END amt1 ,",#160215-00013#2 原本取單頭因要串到料件性質
               "        CASE WHEN gzcb004 = '-1' THEN (pmdt038*pmds038) * gzcb004 ELSE 0 END amt2  ",#160215-00013#2 所以改取單身金額
               "   FROM imaa_t,pmdt_t,pmds_t LEFT JOIN gzcb_t ON  gzcb003 ='Y' AND gzcb001 = '2060' AND gzcb002 = pmds000 ",  #160215-00013#2 ADD pmdt_t,imaa_t
               "  WHERE pmdsent = pmdtent AND pmdsent = imaaent AND pmdsent = '",g_enterprise,"'   ",                         #160215-00013#2
               "    AND pmdsdocno = pmdtdocno AND pmdt006 = imaa001 "                                                         #160215-00013#2 
   IF g_input.pmaa047 MATCHES '[12]' THEN #企業關係人
      LET g_sql = g_sql CLIPPED,
               "   AND EXISTS ( SELECT 1 FROM pmaa_t WHERE pmaaent = '",g_enterprise,"'    ",
               "                         AND pmaa001 = pmds008                             ",
               "   AND CASE WHEN pmaa047 = 'Y' THEN 1 ELSE 2 END = '",g_input.pmaa047,"')  "
   END IF   
   IF g_input.pmds048 MATCHES '[12]' THEN　#內外購
      LET g_sql = g_sql CLIPPED, "AND pmds048 = '",g_input.pmds048,"'                   "
   END IF
   LET g_sql = g_sql CLIPPED ," AND pmds000 IN ", g_pmds000_str 
   LET g_sql = g_sql CLIPPED, " AND ",g_input.wc, 
                              " AND pmds001 BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"' ", 
                              " AND pmds008 IS NOT NULL AND pmdsstus ='S'                           ", 
                              " AND pmdssite IN ",g_wc_apcasite 
   #151231-00010#4--(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_sql = g_sql," AND pmds008 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#4--(E)    
   LET g_sql = "  INSERT INTO aapq370_tmp ",   
               "  SELECT DENSE_RANK() OVER( ORDER BY  SUM(amt1+amt2) DESC) AS RANK,    ",
               "         pmds008,sum(amt1),sum(amt2),SUM(amt1+amt2),'",g_enterprise,"' ",  
               "    FROM ( ", g_sql, ") GROUP by pmds008 " 
                                                         
   PREPARE aapq370_ins_pmds_prep01 FROM g_sql
   EXECUTE aapq370_ins_pmds_prep01
   

END FUNCTION

################################################################################
# Descriptions...: 預設
# Memo...........:
# Usage..........: CALL aapq370_set_default()
# Date & Author..: 2015/11/26 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq370_set_default()


   LET g_input.apcasite = g_site
   #161115-00042#4 --s add
   SELECT ooef017 INTO g_apcacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_input.apcasite
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#30 mark
   CALL s_fin_get_wc_str(g_apcacomp) RETURNING g_comp_str  #161229-00047#30 add 
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#30 add    
   #161115-00042#4 --e add
   CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'1')
   #取得帳務中心底下之組織範圍
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
   CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite                
   CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc
   LET g_input.strdate = g_today
   LET g_input.enddate = g_today
   LET g_input.pmaa047 ='0' #企業關係人
   LET g_input.pmds048 = '0'    #全部
   LET g_input.type = '0'
   LET g_input.rank = '50'
   LET g_input.mon = '0'
   CALL cl_set_comp_visible('group_2,group_3',TRUE)
   CALL cl_set_comp_visible('group_3',FALSE)
   DISPLAY BY NAME g_input.apcasite_desc,g_input.apcasite,g_input.strdate,g_input.enddate,g_input.pmaa047,
                   g_input.pmds048     ,g_input.type   ,g_input.rank  ,g_input.mon 
                    
   
END FUNCTION

################################################################################
# Descriptions...: 報表輸出
# Memo...........:
# Usage..........: CALL aapq370_print()
# Date & Author..:　2015/11/30 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq370_print()
DEFINE l_i  LIKE type_t.num5
DEFINE l_apcasite_desc LIKE type_t.chr100
DEFINE l_apcadate_desc   LIKE type_t.chr100
DEFINE l_pmaa047_desc  LIKE type_t.chr100
DEFINE l_pmds048_desc  LIKE type_t.chr100
DEFINE l_type_desc     LIKE type_t.chr100

   
   DELETE FROM aapq370_x01_tmp
   CASE g_input.pmaa047 
      WHEN '0'
         SELECT gzzd005 INTO l_pmaa047_desc FROM gzzd_t WHERE gzzd003 = 'cbo_pmaa047.0' AND gzzd002 = g_dlang AND gzzd001 = 'aapq370'
      WHEN '1'
         SELECT gzzd005 INTO l_pmaa047_desc FROM gzzd_t WHERE gzzd003 = 'cbo_pmaa047.1' AND gzzd002 = g_dlang AND gzzd001 = 'aapq370'
      WHEN '2'
         SELECT gzzd005 INTO l_pmaa047_desc FROM gzzd_t WHERE gzzd003 = 'cbo_pmaa047.2' AND gzzd002 = g_dlang AND gzzd001 = 'aapq370'
   END CASE
   
   CASE g_input.pmds048 
      WHEN '1'
         SELECT gzzd005 INTO l_pmds048_desc FROM gzzd_t WHERE gzzd003 = 'cbo_pmds048.1' AND gzzd002 = g_dlang AND gzzd001 = 'aapq370'
      WHEN '2'
         SELECT gzzd005 INTO l_pmds048_desc FROM gzzd_t WHERE gzzd003 = 'cbo_pmds048.2' AND gzzd002 = g_dlang AND gzzd001 = 'aapq370'
      WHEN '3'
         SELECT gzzd005 INTO l_pmds048_desc FROM gzzd_t WHERE gzzd003 = 'cbo_pmds048.3' AND gzzd002 = g_dlang AND gzzd001 = 'aapq370'
   END CASE    

   CASE g_input.type 
      WHEN '0'
         SELECT gzzd005 INTO l_type_desc FROM gzzd_t WHERE gzzd003 = 'cbo_type.0' AND gzzd002 = g_dlang AND gzzd001 = 'aapq370'
      WHEN '1'
         SELECT gzzd005 INTO l_type_desc FROM gzzd_t WHERE gzzd003 = 'cbo_type.1' AND gzzd002 = g_dlang AND gzzd001 = 'aapq370'
   END CASE      

   LET l_apcasite_desc = g_input.apcasite,':',g_input.apcasite_desc
   LET l_apcadate_desc = g_input.strdate,'~',g_input.enddate
   
   
   FOR l_i = 1 to g_apcb_d.getLength()
      INSERT INTO aapq370_x01_tmp
      VALUES(l_apcasite_desc,l_apcadate_desc,l_pmaa047_desc,l_pmds048_desc,l_type_desc,g_input.rank,g_input.mon,
             g_apcb_d[l_i].apcbseq,g_apcb_d[l_i].apca004,g_apcb_d[l_i].apca004_desc,
             g_apcb_d[l_i].apcb113, g_apcb_d[l_i].apcb1132, g_apcb_d[l_i].amt,g_apcb_d[l_i].per)
   END FOR
   

END FUNCTION

 
{</section>}
 
