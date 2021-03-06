#該程式未解開Section, 採用最新樣板產出!
{<section id="aapq120.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:14(2016-11-09 11:03:10), PR版次:0014(2017-01-06 16:56:18)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000078
#+ Filename...: aapq120
#+ Description: 供應商發票付款查詢作業
#+ Creator....: 05016(2014-12-30 09:41:45)
#+ Modifier...: 08171 -SD/PR- 06821
 
{</section>}
 
{<section id="aapq120.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#150127-00007#1               By Reanna   掃把清空&給預設值
#150302-00006#1               By Hans     1.單身法人/交易對象拉到單頭;2.第一个单身加"已付款金额 "/"未付金額";3.第二單身增加發票號碼
#151231-00010#4   2016/01/11  By 02097    增加控制組/若單頭沒有帳套條件的開窗,都限制取目前所在據點對應的法人串 pmabsite/若input 條件有帳套就以帳套對應法人串 pmabsite 
#160321-00016#20  2016/03/23  By Jessy    修正azzi920重複定義之錯誤訊息
#160318-00025#43  2016/04/26  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 aapq910_bfill_tmp ——> aapq910_tmp01
#160518-00075#18  2016/08/03  By Hans     使用元件取得aooi200的限制人員/限制部門取用單別並加以限制範圍
#161014-00053#2   2016/10/19  By 08171    增加法人權限
#161006-00005#19  2016/10/24  By 08732    組織類型與職能開窗調整
#160831-00052#1   2016/11/08  By 08171    增加【立帳日期】串聯,並提供QBE查詢處理。
#161115-00042#4   2016/11/16  By 08171    開窗範圍處理
#161229-00047#23  2017/01/06  By 06821    財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
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
       
       isamseq LIKE isam_t.isamseq, 
   isamcomp LIKE isam_t.isamcomp, 
   isam002 LIKE isam_t.isam002, 
   isam002_desc LIKE type_t.chr500, 
   isamdocno LIKE isam_t.isamdocno, 
   isam011 LIKE isam_t.isam011, 
   isam009 LIKE isam_t.isam009, 
   isam010 LIKE isam_t.isam010, 
   apcadocdt LIKE apca_t.apcadocdt, 
   isam014 LIKE isam_t.isam014, 
   isam023 LIKE isam_t.isam023, 
   isam024 LIKE isam_t.isam024, 
   isam025 LIKE isam_t.isam025, 
   isam036 LIKE isam_t.isam036, 
   isam050 LIKE isam_t.isam050, 
   l_amt1 LIKE type_t.num20_6, 
   l_amt2 LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_isam2_d RECORD
         apde001      LIKE apde_t.apde001, 
         apde001_desc LIKE type_t.chr500, 
         apeb011      LIKE apeb_t.apeb011,
         apeb008      LIKE apeb_t.apeb008,
         apdedocno    LIKE apde_t.apdedocno,
         apde002      LIKE apde_t.apde002, 
         apde002_desc LIKE type_t.chr500, 
         apde006      LIKE type_t.chr100, 
         apde100      LIKE apde_t.apde100,
         apde101      LIKE apde_t.apde101,         
         apde109      LIKE apde_t.apde109,    
         apde119      LIKE apde_t.apde119, 
         apde003      LIKE apde_t.apde003, 
         apde024      LIKE type_t.chr500, 
         apde032      LIKE apde_t.apde032, 
         apde014      LIKE apde_t.apde014
       END RECORD
DEFINE g_isam2_d          DYNAMIC ARRAY OF type_g_isam2_d  
DEFINE g_input RECORD 
       apcasite        LIKE apca_t.apcasite,
       apcasite_desc   LIKE type_t.chr80,
       isamcomp        LIKE isam_t.isamcomp,
       isamcomp_desc   LIKE type_t.chr80,
       isam002         LIKE isam_t.isam002,
       isam002_desc    LIKE type_t.chr80
     END RECORD
DEFINE g_wc_apcacomp   STRING
DEFINE g_glaald        LIKE glaa_t.glaald  
DEFINE g_wc3           STRING
DEFINE g_sql_ctrl          STRING      #151231-00010#4
DEFINE g_user_dept_wc      STRING      #160518-00075#18
DEFINE g_user_dept_wc_q    STRING      #160518-00075#18
DEFINE g_wc_cs_comp        STRING    #azzi800的權限可看的資料範圍 #161014-00053#2 add
DEFINE g_comp              LIKE glaa_t.glaacomp   #161115-00042#4 add
DEFINE g_comp_str          STRING      #161229-00047#23 add 
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
 
{<section id="aapq120.main" >}
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
   #151231-00010#4--(E)
   #161115-00042#4 --s add
   SELECT ooef017 INTO g_comp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#23 mark
   #161115-00042#4 --e add
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
   DECLARE aapq120_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapq120_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapq120_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapq120 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapq120_init()   
 
      #進入選單 Menu (="N")
      CALL aapq120_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapq120
      
   END IF 
   
   CLOSE aapq120_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapq120.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapq120_init()
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
   
      CALL cl_set_combo_scc('b_isam036','9716') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL aapq120_creat_tmp()
   CALL cl_set_combo_scc('b_isam036','9716')
   #建立撈取帳務中心所屬範圍需使用的暫存檔  
   CALL s_fin_create_account_center_tmp()
   #160518-00075#18--s
   LET g_user_dept_wc = '' 
   CALL s_fin_get_user_dept_control('isamcomp','','isament','isamdocno') RETURNING g_user_dept_wc
   #開窗使用
   CALL s_fin_get_user_dept_control('apbbcomp','','apbbent','apbbdocno') RETURNING g_user_dept_wc_q 
   #160518-00075#18--e
   #161014-00053#2 --s add
   #法人
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   #161014-00053#2 --e add   
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#23 add
   #end add-point
 
   CALL aapq120_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aapq120.default_search" >}
PRIVATE FUNCTION aapq120_default_search()
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
 
{<section id="aapq120.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aapq120_ui_dialog()
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
   #CALL cl_set_act_visible("insert,output", FALSE)
  
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL aapq120_b_fill()
   ELSE
      CALL aapq120_query()
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
 
         CALL aapq120_init()
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
               CALL aapq120_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aapq120_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               CALL aapq120_b_fill2()
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_isam2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               LET g_current_page = 2
               
            BEFORE ROW
               CALL aapq120_b_fill2()   
                            
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aapq120_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible('selall,selnone,unsel,sel',FALSE)  
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapq120_query()
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
            CALL aapq120_filter()
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
            CALL aapq120_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_isam_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_isam2_d)
               LET g_export_id[2]   = "s_detail2"
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
            CALL aapq120_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aapq120_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aapq120_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aapq120_b_fill()
 
         
         
 
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
 
{<section id="aapq120.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapq120_query()
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
      CONSTRUCT g_wc_table ON isamseq,isamcomp,isam002,isamdocno,isam011,isam009,isam010,apcadocdt,isam014, 
          isam023,isam024,isam025,isam036,isam050
           FROM s_detail1[1].b_isamseq,s_detail1[1].b_isamcomp,s_detail1[1].b_isam002,s_detail1[1].b_isamdocno, 
               s_detail1[1].b_isam011,s_detail1[1].b_isam009,s_detail1[1].b_isam010,s_detail1[1].b_apcadocdt, 
               s_detail1[1].b_isam014,s_detail1[1].b_isam023,s_detail1[1].b_isam024,s_detail1[1].b_isam025, 
               s_detail1[1].b_isam036,s_detail1[1].b_isam050
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            #160518-00075#18---s---
            LET g_isam_d[1].isamcomp = ""
            DISPLAY ARRAY g_isam_d TO s_detail1.* 
              BEFORE DISPLAY
                 EXIT DISPLAY
            END DISPLAY
            #160518-00075#18---e---
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
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
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamcomp
            #add-point:ON ACTION controlp INFIELD b_isamcomp name="construct.c.page1.b_isamcomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN " ,g_wc_apcacomp #161014-00053#2 mark
            #161014-00053#2 --s add
            LET g_qryparam.where = " ooef003 = 'Y' "             
            IF NOT cl_null(g_wc_cs_comp)THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ooef001 IN ",g_wc_cs_comp                   #160824-00049#1 add
            END IF            
            #161014-00053#2 --e add
            #CALL q_ooef001_2()   #161006-00005#19   mark
            CALL q_ooef001()      #161006-00005#19   add          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isamcomp  #顯示到畫面上
            NEXT FIELD b_isamcomp                     #返回原欄位
            #END add-point
 
 
         #----<<b_isam002>>----
         #Ctrlp:construct.c.page1.b_isam002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam002
            #add-point:ON ACTION controlp INFIELD b_isam002 name="construct.c.page1.b_isam002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " (pmaa002 ='1' OR pmaa002 ='3') " #供廠商OR交易對象
            #151231-00010#4--(S)
            LET g_qryparam.where = g_qryparam.where, " AND pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef017 = '",g_input.isamcomp,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where =  g_qryparam.where, " AND pmaa001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            CALL q_pmaa001_25()
            DISPLAY g_qryparam.return1 TO b_isam002
            NEXT FIELD b_isam002
    
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
         #----<<b_isamdocno>>----
         #Ctrlp:construct.c.page1.b_isamdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamdocno
            #add-point:ON ACTION controlp INFIELD b_isamdocno name="construct.c.page1.b_isamdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apbbstus = 'Y' AND apbbcomp IN " ,g_wc_apcacomp
            #160518-00075#19--s
            IF NOT cl_null(g_user_dept_wc_q) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q
            END IF               
            #160518-00075#19--e
            CALL q_apbbdocno_5()
            DISPLAY g_qryparam.return1 TO b_isamdocno
            NEXT FIELD b_isamdocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isamdocno
            #add-point:BEFORE FIELD b_isamdocno name="construct.b.page1.b_isamdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isamdocno
            
            #add-point:AFTER FIELD b_isamdocno name="construct.a.page1.b_isamdocno"
            
            #END add-point
            
 
 
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
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isamcomp IN " ,g_wc_apcacomp
            CALL q_isam010_8()
            DISPLAY g_qryparam.return1 TO b_isam010
            NEXT FIELD b_isam010
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam010
            #add-point:BEFORE FIELD b_isam010 name="construct.b.page1.b_isam010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam010
            
            #add-point:AFTER FIELD b_isam010 name="construct.a.page1.b_isam010"
            
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
 
 
         #----<<b_isam014>>----
         #Ctrlp:construct.c.page1.b_isam014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam014
            #add-point:ON ACTION controlp INFIELD b_isam014 name="construct.c.page1.b_isam014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()
            DISPLAY g_qryparam.return1 TO b_isam014
            NEXT FIELD b_isam014
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam014
            #add-point:BEFORE FIELD b_isam014 name="construct.b.page1.b_isam014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam014
            
            #add-point:AFTER FIELD b_isam014 name="construct.a.page1.b_isam014"
            
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
 
 
         #----<<b_isam036>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam036
            #add-point:BEFORE FIELD b_isam036 name="construct.b.page1.b_isam036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam036
            
            #add-point:AFTER FIELD b_isam036 name="construct.a.page1.b_isam036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isam036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam036
            #add-point:ON ACTION controlp INFIELD b_isam036 name="construct.c.page1.b_isam036"
          
            #END add-point
 
 
         #----<<b_isam050>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isam050
            #add-point:BEFORE FIELD b_isam050 name="construct.b.page1.b_isam050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isam050
            
            #add-point:AFTER FIELD b_isam050 name="construct.a.page1.b_isam050"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isam050
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam050
            #add-point:ON ACTION controlp INFIELD b_isam050 name="construct.c.page1.b_isam050"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "  isamdocno = apcadocno AND apcadocno = isam050 AND isam010 IS NOT NULL",
                                   "  AND apcacomp IN " ,g_wc_apcacomp 
            CALL q_isam050()
            DISPLAY g_qryparam.return1 TO b_isam050
            NEXT FIELD b_isam050
            #END add-point
 
 
         #----<<l_amt1>>----
         #----<<l_amt2>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT g_input.apcasite,g_input.apcasite_desc,g_input.isamcomp,g_input.isamcomp_desc
      
       FROM b_apcasite,apcasite_desc,isamcomp,isamcomp_desc
             ATTRIBUTE(WITHOUT DEFAULTS)
      
         AFTER FIELD b_apcasite
            #帳務中心
            LET g_input.apcasite_desc = ''
            IF NOT cl_null(g_input.apcasite) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_input.apcasite
               #160318-00025#43  2016/04/26  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#43  2016/04/26  by pengxin  add(E)
               IF NOT cl_chk_exist("v_ooef001") THEN
                  LET g_input.apcasite = ''
                  LET g_input.apcasite_desc = '' 
                  LET g_input.isamcomp = ''
                  LET g_input.isamcomp_desc = ''                       
                  DISPLAY BY NAME g_input.apcasite_desc,g_input.apcasite,g_input.isamcomp,g_input.isamcomp_desc                  
                  NEXT FIELD b_apcasite
               END IF
               #161006-00005#19   add---s
               CALL s_fin_account_center_chk(g_input.apcasite,'','3','') RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.apcasite = ''
                  LET g_input.apcasite_desc = '' 
                  LET g_input.isamcomp = ''
                  LET g_input.isamcomp_desc = ''                       
                  DISPLAY BY NAME g_input.apcasite_desc,g_input.apcasite,g_input.isamcomp,g_input.isamcomp_desc                  
                  NEXT FIELD b_apcasite
               END IF
               #161006-00005#19   add---e
               CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'1')
               #取得帳務中心底下之組織範圍
               CALL s_fin_account_center_comp_str() RETURNING g_wc_apcacomp
               CALL s_fin_get_wc_str(g_wc_apcacomp) RETURNING g_wc_apcacomp
               LET g_input.apcasite_desc = s_desc_get_department_desc(g_input.apcasite)
               CALL s_fin_orga_get_comp_ld(g_input.apcasite) RETURNING g_sub_success,g_errno,g_input.isamcomp,g_glaald
               CALL s_fin_get_wc_str(g_input.isamcomp) RETURNING g_comp_str #161229-00047#23 add 
               CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl        #161229-00047#23 add 
               #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.isamcomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#4 add   #161229-00047#23 mark
               CALL s_desc_get_department_desc(g_input.isamcomp) RETURNING g_input.isamcomp_desc
               DISPLAY BY NAME g_input.apcasite_desc,g_input.isamcomp_desc,g_input.isamcomp,g_input.isamcomp_desc 
            END IF      
            #161014-00053#2--s add            
            CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'1') 
            CALL s_fin_account_center_comp_str() RETURNING g_wc_apcacomp
            CALL s_fin_get_wc_str(g_wc_apcacomp) RETURNING g_wc_apcacomp
            #161014-00053#2--e add
            
         #150302-00006#2   ---s---         
         AFTER FIELD isamcomp            
            IF NOT cl_null(g_input.isamcomp) THEN
               #161014-00053#2 --s add
               CALL aapq120_isamcomp_chk(g_input.isamcomp) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.isamcomp = ''
                  LET g_input.isamcomp_desc = ''
                  DISPLAY BY NAME g_input.isamcomp_desc,g_input.isamcomp
                  NEXT FIELD CURRENT
               END IF
               #161014-00053#2 --e add
               CALL s_fin_comp_chk(g_input.isamcomp) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160321-00016#20 --s add
                  #(s_fin_comp_chk)agl-00098 -> sub-01302
                  LET g_errparam.replace[1] = 'aooi100'
                  LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi100'
                  #160321-00016#20 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.isamcomp = ''
                  LET g_input.isamcomp_desc = ''
                  DISPLAY BY NAME g_input.isamcomp_desc
                  NEXT FIELD CURRENT
               END IF
               #161006-00005#19   add---s
               CALL s_fin_site_belong_to_comp_chk(g_input.apcasite,g_input.isamcomp) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.isamcomp = ''
                  LET g_input.isamcomp_desc = ''
                  DISPLAY BY NAME g_input.isamcomp_desc,g_input.isamcomp
                  NEXT FIELD CURRENT
               END IF
               #161006-00005#19   add---e

               SELECT glaald INTO g_glaald
                 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaacomp = g_input.isamcomp
                  AND glaa014 = 'Y'                  
                  IF NOT cl_null(g_input.apcasite)THEN
                  CALL s_fin_account_center_with_ld_chk(g_input.apcasite,'',g_user,'3','Y','',g_today)
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00127'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.isamcomp = ''
                     LET g_input.isamcomp_desc = ''
                     DISPLAY BY NAME g_input.isamcomp_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_fin_get_wc_str(g_input.isamcomp) RETURNING g_comp_str #161229-00047#23 add 
               CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl        #161229-00047#23 add 
               #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.isamcomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#4 add   #161229-00047#23 mark
            END IF
            CALL s_desc_get_department_desc(g_input.isamcomp) RETURNING g_input.isamcomp_desc
            DISPLAY BY NAME g_input.isamcomp_desc
         
            
         #150302-00006#2   ---e---    
         
         ON ACTION controlp INFIELD b_apcasite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.apcasite
            #CALL q_ooef001()     #161006-00005#19   mark
            CALL q_ooef001_46()   #161006-00005#19   add       
            LET g_input.apcasite = g_qryparam.return1
            CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc
            DISPLAY BY NAME g_input.apcasite,g_input.apcasite_desc
            NEXT FIELD b_apcasite
            
         #150302-00006#2   ---s---  
         ON ACTION controlp INFIELD isamcomp
            #161014-00053#2--s add            
            CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'1') 
            CALL s_fin_account_center_comp_str() RETURNING g_wc_apcacomp
            CALL s_fin_get_wc_str(g_wc_apcacomp) RETURNING g_wc_apcacomp
            #161014-00053#2--e add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.isamcomp
            LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN " ,g_wc_apcacomp
            #CALL q_ooef001_2()   #161006-00005#19   mark
            CALL q_ooef001()      #161006-00005#19   add          #呼叫開窗  
            LET g_input.isamcomp = g_qryparam.return1
            CALL s_desc_get_department_desc(g_input.isamcomp) RETURNING g_input.isamcomp_desc
            DISPLAY BY NAME g_input.isamcomp #顯示到畫面上
            NEXT FIELD isamcomp                     #返回原欄位
      
         
      END INPUT
      
      
     CONSTRUCT BY NAME g_wc3 ON isam002
         ON ACTION controlp INFIELD isam002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " (pmaa002 ='1' OR pmaa002 ='3') " #供廠商OR交易對象
            #151231-00010#4--(S)
            LET g_qryparam.where = g_qryparam.where, " AND pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef017 = '",g_input.isamcomp,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where =  g_qryparam.where, " AND pmaa001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            CALL q_pmaa001_25()
            DISPLAY g_qryparam.return1 TO isam002
            NEXT FIELD isam002
            
         
      END CONSTRUCT
        #150302-00006#2   ---e---  
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
      #150127-00007#1
      BEFORE DIALOG
         CALL aapq120_qbe_clear()
      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後 name="query.qbeclear"
         
         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後 name="query.set_qbe_action_after"
         CALL aapq120_qbe_clear()    #150127-00007#1
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
   CALL aapq120_b_fill()
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
 
{<section id="aapq120.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapq120_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_isamdocno   LIKE isam_t.isamdocno
   DEFINE l_isam010     LIKE isam_t.isam010
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL aapq120_insert_tmp()
   DELETE FROM aapq910_tmp01  #临时表长度超过15码的减少到15码以下 aapq910_bfill_tmp ——> aapq910_tmp01
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
 
   LET ls_sql_rank = "SELECT  UNIQUE isamseq,isamcomp,isam002,'',isamdocno,isam011,isam009,isam010,'', 
       isam014,isam023,isam024,isam025,isam036,isam050,'',''  ,DENSE_RANK() OVER( ORDER BY isam_t.isamdocno, 
       isam_t.isamseq) AS RANK FROM isam_t",
 
 
                     "",
                     " WHERE isament= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("isam_t"),
                     " ORDER BY isam_t.isamdocno,isam_t.isamseq"
 
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
 
   LET g_sql = "SELECT isamseq,isamcomp,isam002,'',isamdocno,isam011,isam009,isam010,'',isam014,isam023, 
       isam024,isam025,isam036,isam050,'',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150302-00006#1   ---s---
   IF NOT cl_null(g_input.isamcomp) THEN
      LET ls_wc = ls_wc," AND isamcomp = '",g_input.isamcomp,"'"
   END IF
   IF NOT cl_null(g_wc3) THEN
      LET ls_wc = ls_wc," AND ",g_wc3
   END IF 
   #150302-00006#1   ---e---
   LET ls_wc = ls_wc," AND ",g_user_dept_wc     #160518-00075#17
   #151231-00010#4--(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET ls_wc =  ls_wc, " AND isam002 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#4--(E)  
  #LET g_sql = " SELECT '',isamcomp,isam002,'',isamdocno,isam011,isam009,isam010,isam014, ",           #160831-00052#1 mark
   LET g_sql = " SELECT '',isamcomp,isam002,'',isamdocno,isam011,isam009,isam010,apcadocdt,isam014, ", #160831-00052#1 add
               "          isam023,isam024,isam025,isam036,isam050,0,0                  ",
               "   FROM aapq120_tmp " ,
               " WHERE isament = ? AND 1=1 AND isamcomp IN ",g_wc_apcacomp," AND ",ls_wc,cl_sql_add_filter("isam_t"), 
               #161115-00042#4 --s add
               "   AND EXISTS (SELECT 1 FROM pmaa_t ",
               "               WHERE pmaaent = ",g_enterprise,
               "               AND ",g_sql_ctrl,
               "               AND pmaaent = isament ",
               "               AND pmaa001 = isam002 ) ",
               #161115-00042#4 --e add
               " ORDER BY isam002,isamdocno,isam010 "
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapq120_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapq120_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_isam_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET l_isamdocno = ''
   LET l_isam010 = ''
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_isam_d[l_ac].isamseq,g_isam_d[l_ac].isamcomp,g_isam_d[l_ac].isam002,g_isam_d[l_ac].isam002_desc, 
       g_isam_d[l_ac].isamdocno,g_isam_d[l_ac].isam011,g_isam_d[l_ac].isam009,g_isam_d[l_ac].isam010, 
       g_isam_d[l_ac].apcadocdt,g_isam_d[l_ac].isam014,g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024, 
       g_isam_d[l_ac].isam025,g_isam_d[l_ac].isam036,g_isam_d[l_ac].isam050,g_isam_d[l_ac].l_amt1,g_isam_d[l_ac].l_amt2 
 
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
      IF cl_null(g_isam_d[l_ac].isam050)THEN 
         SELECT apcadocno
         INTO g_isam_d[l_ac].isam050
           FROM apca_t,apcb_t
          WHERE apcadocno = apcbdocno
            AND apcald = apcbld
            AND apcaent  = apcbent
            AND apcb049 = g_isam_d[l_ac].isamdocno      
      END IF
      IF l_isamdocno = g_isam_d[l_ac].isamdocno AND l_isam010 = g_isam_d[l_ac].isam010 THEN
         CONTINUE FOREACH
      END IF
      CALL s_desc_get_trading_partner_abbr_desc(g_isam_d[l_ac].isam002) RETURNING g_isam_d[l_ac].isam002_desc       
      LET l_isamdocno = g_isam_d[l_ac].isamdocno
      LET l_isam010 = g_isam_d[l_ac].isam010

      #150302-00006#1   ---s---
      SELECT SUM(apeb109) INTO g_isam_d[l_ac].l_amt1
        FROM apeb_t
       WHERE apebent = g_enterprise
         AND apeb003 = g_isam_d[l_ac].isamdocno
         AND apeb008 = g_isam_d[l_ac].isam010
      
      IF cl_null(g_isam_d[l_ac].l_amt1) THEN
         LET g_isam_d[l_ac].l_amt1 = 0
      END IF

     LET g_isam_d[l_ac].l_amt2 = g_isam_d[l_ac].isam025 - g_isam_d[l_ac].l_amt1
     #150302-00006#1   ---e---
      #end add-point
 
      CALL aapq120_detail_show("'1'")      
 
      CALL aapq120_isam_t_mask()
 
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
   CALL aapq120_b_fill2()
   #end add-point
 
   LET g_detail_cnt = g_isam_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aapq120_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aapq120_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aapq120_detail_action_trans()
 
   IF g_isam_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aapq120_fetch()
   END IF
   
      CALL aapq120_filter_show('isamseq','b_isamseq')
   CALL aapq120_filter_show('isamcomp','b_isamcomp')
   CALL aapq120_filter_show('isam002','b_isam002')
   CALL aapq120_filter_show('isamdocno','b_isamdocno')
   CALL aapq120_filter_show('isam011','b_isam011')
   CALL aapq120_filter_show('isam009','b_isam009')
   CALL aapq120_filter_show('isam010','b_isam010')
   CALL aapq120_filter_show('apcadocdt','b_apcadocdt')
   CALL aapq120_filter_show('isam014','b_isam014')
   CALL aapq120_filter_show('isam023','b_isam023')
   CALL aapq120_filter_show('isam024','b_isam024')
   CALL aapq120_filter_show('isam025','b_isam025')
   CALL aapq120_filter_show('isam036','b_isam036')
   CALL aapq120_filter_show('isam050','b_isam050')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq120.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapq120_fetch()
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
 
{<section id="aapq120.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapq120_detail_show(ps_page)
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
 
{<section id="aapq120.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapq120_filter()
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
      CONSTRUCT g_wc_filter ON isamseq,isamcomp,isam002,isamdocno,isam011,isam009,isam010,apcadocdt, 
          isam014,isam023,isam024,isam025,isam036,isam050
                          FROM s_detail1[1].b_isamseq,s_detail1[1].b_isamcomp,s_detail1[1].b_isam002, 
                              s_detail1[1].b_isamdocno,s_detail1[1].b_isam011,s_detail1[1].b_isam009, 
                              s_detail1[1].b_isam010,s_detail1[1].b_apcadocdt,s_detail1[1].b_isam014, 
                              s_detail1[1].b_isam023,s_detail1[1].b_isam024,s_detail1[1].b_isam025,s_detail1[1].b_isam036, 
                              s_detail1[1].b_isam050
 
         BEFORE CONSTRUCT
                     DISPLAY aapq120_filter_parser('isamseq') TO s_detail1[1].b_isamseq
            DISPLAY aapq120_filter_parser('isamcomp') TO s_detail1[1].b_isamcomp
            DISPLAY aapq120_filter_parser('isam002') TO s_detail1[1].b_isam002
            DISPLAY aapq120_filter_parser('isamdocno') TO s_detail1[1].b_isamdocno
            DISPLAY aapq120_filter_parser('isam011') TO s_detail1[1].b_isam011
            DISPLAY aapq120_filter_parser('isam009') TO s_detail1[1].b_isam009
            DISPLAY aapq120_filter_parser('isam010') TO s_detail1[1].b_isam010
            DISPLAY aapq120_filter_parser('apcadocdt') TO s_detail1[1].b_apcadocdt
            DISPLAY aapq120_filter_parser('isam014') TO s_detail1[1].b_isam014
            DISPLAY aapq120_filter_parser('isam023') TO s_detail1[1].b_isam023
            DISPLAY aapq120_filter_parser('isam024') TO s_detail1[1].b_isam024
            DISPLAY aapq120_filter_parser('isam025') TO s_detail1[1].b_isam025
            DISPLAY aapq120_filter_parser('isam036') TO s_detail1[1].b_isam036
            DISPLAY aapq120_filter_parser('isam050') TO s_detail1[1].b_isam050
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_isamseq>>----
         #Ctrlp:construct.c.filter.page1.b_isamseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamseq
            #add-point:ON ACTION controlp INFIELD b_isamseq name="construct.c.filter.page1.b_isamseq"
            
            #END add-point
 
 
         #----<<b_isamcomp>>----
         #Ctrlp:construct.c.filter.page1.b_isamcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamcomp
            #add-point:ON ACTION controlp INFIELD b_isamcomp name="construct.c.filter.page1.b_isamcomp"
            
            #END add-point
 
 
         #----<<b_isam002>>----
         #Ctrlp:construct.c.page1.b_isam002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam002
            #add-point:ON ACTION controlp INFIELD b_isam002 name="construct.c.filter.page1.b_isam002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151231-00010#4--(S)
            LET g_qryparam.where = " pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef017 = '",g_input.isamcomp,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where =  g_qryparam.where, " AND pmaa001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isam002  #顯示到畫面上
            NEXT FIELD b_isam002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_isam002_desc>>----
         #----<<b_isamdocno>>----
         #Ctrlp:construct.c.page1.b_isamdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isamdocno
            #add-point:ON ACTION controlp INFIELD b_isamdocno name="construct.c.filter.page1.b_isamdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151231-00010#4--(S)
            LET g_qryparam.where = " isamcomp = '",g_input.isamcomp,"' "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where =  g_qryparam.where, " AND apbb002 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            #160518-00075#19--s
            IF NOT cl_null(g_user_dept_wc_q) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q
            END IF               
            #160518-00075#19--e
            CALL q_isamdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isamdocno  #顯示到畫面上
            NEXT FIELD b_isamdocno                     #返回原欄位
    


            #END add-point
 
 
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
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isam010()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isam010  #顯示到畫面上
            NEXT FIELD b_isam010                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_apcadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_apcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcadocdt
            #add-point:ON ACTION controlp INFIELD b_apcadocdt name="construct.c.filter.page1.b_apcadocdt"
            
            #END add-point
 
 
         #----<<b_isam014>>----
         #Ctrlp:construct.c.page1.b_isam014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam014
            #add-point:ON ACTION controlp INFIELD b_isam014 name="construct.c.filter.page1.b_isam014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isam014  #顯示到畫面上
            NEXT FIELD b_isam014                     #返回原欄位
    


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
 
 
         #----<<b_isam036>>----
         #Ctrlp:construct.c.filter.page1.b_isam036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam036
            #add-point:ON ACTION controlp INFIELD b_isam036 name="construct.c.filter.page1.b_isam036"
            
            #END add-point
 
 
         #----<<b_isam050>>----
         #Ctrlp:construct.c.filter.page1.b_isam050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isam050
            #add-point:ON ACTION controlp INFIELD b_isam050 name="construct.c.filter.page1.b_isam050"
            
            #END add-point
 
 
         #----<<l_amt1>>----
         #----<<l_amt2>>----
   
 
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
   
      CALL aapq120_filter_show('isamseq','b_isamseq')
   CALL aapq120_filter_show('isamcomp','b_isamcomp')
   CALL aapq120_filter_show('isam002','b_isam002')
   CALL aapq120_filter_show('isamdocno','b_isamdocno')
   CALL aapq120_filter_show('isam011','b_isam011')
   CALL aapq120_filter_show('isam009','b_isam009')
   CALL aapq120_filter_show('isam010','b_isam010')
   CALL aapq120_filter_show('apcadocdt','b_apcadocdt')
   CALL aapq120_filter_show('isam014','b_isam014')
   CALL aapq120_filter_show('isam023','b_isam023')
   CALL aapq120_filter_show('isam024','b_isam024')
   CALL aapq120_filter_show('isam025','b_isam025')
   CALL aapq120_filter_show('isam036','b_isam036')
   CALL aapq120_filter_show('isam050','b_isam050')
 
    
   CALL aapq120_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq120.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapq120_filter_parser(ps_field)
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
 
{<section id="aapq120.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapq120_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapq120_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq120.insert" >}
#+ insert
PRIVATE FUNCTION aapq120_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapq120.modify" >}
#+ modify
PRIVATE FUNCTION aapq120_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq120.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aapq120_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq120.delete" >}
#+ delete
PRIVATE FUNCTION aapq120_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq120.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aapq120_detail_action_trans()
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
 
{<section id="aapq120.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aapq120_detail_index_setting()
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
 
{<section id="aapq120.mask_functions" >}
 &include "erp/aap/aapq120_mask.4gl"
 
{</section>}
 
{<section id="aapq120.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 獲取臨時表
# Memo...........:
# Usage..........: CALL aapq120_creat_tmp()
# Date & Author..: 2014/12/30 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION aapq120_creat_tmp()
DROP TABLE aapq120_tmp;
      CREATE TEMP TABLE aapq120_tmp(
         isamcomp    LIKE isam_t.isamcomp,
         isam002     LIKE isam_t.isam002, 
         isamdocno   LIKE isam_t.isamdocno, 
         isam011     LIKE isam_t.isam011, 
         isam009     LIKE isam_t.isam009, 
         isam010     LIKE isam_t.isam010, 
         apcadocdt   LIKE apca_t.apcadocdt, #160831-00052#1 add
         isam014     LIKE isam_t.isam014, 
         isam023     LIKE isam_t.isam023, 
         isam024     LIKE isam_t.isam024, 
         isam025     LIKE isam_t.isam025, 
         isam036     LIKE isam_t.isam036, 
         isam050     LIKE isam_t.isam050,
         isament     LIKE isam_t.isament
              )
END FUNCTION

################################################################################
# Descriptions...: 填充資料
# Memo...........:
# Usage..........: CALL aapq120_insert_tmp()
# Date & Author..: 2014/12/30 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION aapq120_insert_tmp()
DEFINE l_isam DYNAMIC ARRAY OF RECORD
    isamcomp    LIKE isam_t.isamcomp,   
    isam002     LIKE isam_t.isam002, 
    isamdocno   LIKE isam_t.isamdocno,
    isam011     LIKE isam_t.isam011, 
    isam009     LIKE isam_t.isam009, 
    isam010     LIKE isam_t.isam010, 
    apcadocdt   LIKE apca_t.apcadocdt, #160831-00052#1 add
    isam014     LIKE isam_t.isam014, 
    isam023     LIKE isam_t.isam023, 
    isam024     LIKE isam_t.isam024, 
    isam025     LIKE isam_t.isam025, 
    isam036     LIKE isam_t.isam036, 
    isam050     LIKE isam_t.isam050,
    isament     LIKE isam_t.isament
    END RECORD
DEFINE l_i          LIKE type_t.num5
DEFINE l_apbbdocno LIKE apbb_t.apbbdocno 
DEFINE l_count     LIKE type_t.num5

   DELETE FROM aapq120_tmp   #(aapt110)廠商發票對帳單有發票者, 且為有效對帳單
   LET g_sql = " INSERT INTO aapq120_tmp                            ",
               " SELECT isamcomp,isam002,isamdocno,isam011,isam009, ",
              #"        isam010 ,isam014,isam023  ,isam024,isam025, ",            #160831-00052#1 mark
               "        isam010 ,apcadocdt,isam014,isam023  ,isam024,isam025, ",  #160831-00052#1 add
               "        isam036 ,isam050,isament                    ",
              #"   FROM isam_t,apbb_t                               ",            #160831-00052#1 mark
               "   FROM apbb_t,isam_t                               ",            #160831-00052#1 add
               "   LEFT JOIN apca_t ON apcaent = isament AND apcadocno = isam050  ", #160831-00052#1 add
               "  WHERE isamdocno = apbbdocno                       ",
               "    AND isament   = apbbent AND isament = '",g_enterprise,"' ",
               "    AND isamdocno != COALESCE(isam050,' ')          ",
               "    AND apbbstus = 'Y' AND isam010 IS NOT NULL      " 
   PREPARE isam_ins_tmp FROM g_sql
   EXECUTE isam_ins_tmp 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins_isam_tmp"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF   
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM aapq120_tmp
   #從帳款單
   LET g_sql = " INSERT INTO aapq120_tmp                            ",
               " SELECT isamcomp,isam002,isamdocno,isam011,isam009, ",
              #"        isam010 ,isam014,isam023  ,isam024,isam025, ",            #160831-00052#1 mark
               "        isam010 ,apcadocdt,isam014,isam023  ,isam024,isam025, ",  #160831-00052#1 add
               "        isam036 ,isam050,isament                    ",
              #"   FROM isam_t,apbb_t                               ",            #160831-00052#1 mark
               "   FROM apbb_t,isam_t                               ",            #160831-00052#1 add
               "   LEFT JOIN apca_t ON apcaent = isament AND apcadocno = isam050  ", #160831-00052#1 add
               "  WHERE isamdocno = apcadocno                       ",
               "    AND isam050   = apcadocno                         ",
               "    AND isament   = apcaent AND isament = '",g_enterprise,"' ",           
               "    AND apcastus  = 'Y' AND isam010 IS NOT NULL     " 
   PREPARE isam_ins_tmp2 FROM g_sql
   EXECUTE isam_ins_tmp2 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins_isam_tmp"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF  
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM aapq120_tmp
   #無發票號碼apca001   
   LET l_i = 1  
   CALL l_isam.clear()
   LET g_sql = " SELECT apbbcomp,apbb002,apbbdocno,apbbdocdt,apbb009,       ",
               "          apbb010,apbb014,apbb023,apbb024,apbb025,          ",
               "           '','',apcaent                                    ",  
               "   FROM apbb_t,apba_t,apca_t,apcb_t                         ",
               "  WHERE apbbdocno = apbadocno                               ",
               "    AND apbbdocno = apcb049                                 ", 
               "    AND apcadocno = apcbdocno                               ",
               "    AND apcald = apcbld                                     ",
               "    AND apca001 IN ('17','13')                              ",
               "    AND (apbb010 IS NULL OR apbb010 = ' ' )                 ",
               "    AND apbbstus='Y' AND apcastus <> 'X'                    ",
               "    AND apbbent = apcbent AND apbbent = apcaent             ",
               "    AND apbbent = apcaent AND apbbent = '",g_enterprise ,"' ",
               "  UNION                                                     ",
               " SELECT apbbcomp,apbb002,apbbdocno,apbbdocdt,apbb009,       ",
               "          apbb010,apbb014,apbb023,apbb024,apbb025,          ",
               "           '','',apcaent                                    ",  
               "   FROM apbb_t,apba_t,apca_t,apcb_t                         ",
               "  WHERE apbbdocno = apbadocno                               ",
               "    AND apcb049 IN (select apbbdocno from apbb_t where  (apbb010 IS NULL OR apbb010 = ' ' ) )",
               "    AND apcadocno = apcbdocno        ",
               "    AND apcald = apcbld                                     ",
               "    AND apca001 IN ('17','13')                              ",
               "    AND (apbb010 IS NULL OR apbb010 = ' ' )                 ",
               "    AND apbbstus='Y' AND apcastus <> 'X'                    ",
               "    AND apbbent = apcbent AND apbbent = apcaent             ",
               "    AND apbbent = apcaent AND apbbent = '",g_enterprise ,"' "
   
   PREPARE isam_ins_tmp3 FROM g_sql
   DECLARE isam_ins_curs3 CURSOR FOR isam_ins_tmp3
   FOREACH isam_ins_curs3 INTO 
      l_isam[l_i].isamcomp,l_isam[l_i].isam002,l_isam[l_i].isamdocno,l_isam[l_i].isam011, l_isam[l_i].isam009,
      l_isam[l_i].isam010 ,l_isam[l_i].isam014,l_isam[l_i].isam023  ,l_isam[l_i].isam024, l_isam[l_i].isam025,                       
      l_isam[l_i].isam036 ,l_isam[l_i].isam050,l_isam[l_i].isament
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF      
            
      SELECT apcadocno INTO l_isam[l_i].isam050
        FROM apca_t,apcb_t
       WHERE apcadocno = apcbdocno
         AND apcald = apcbld
         AND apcaent  = apcbent
         AND apcb049 = l_isam[l_i].isamdocno
             
     INSERT INTO aapq120_tmp   
      VALUES (l_isam[l_i].isamcomp,l_isam[l_i].isam002,l_isam[l_i].isamdocno,l_isam[l_i].isam011, l_isam[l_i].isam009,
             #l_isam[l_i].isam010 ,l_isam[l_i].isam014,l_isam[l_i].isam023  ,l_isam[l_i].isam024, l_isam[l_i].isam025,                        #160831-00052#1 mark
              l_isam[l_i].isam010 ,l_isam[l_i].apcadocdt ,l_isam[l_i].isam014,l_isam[l_i].isam023  ,l_isam[l_i].isam024, l_isam[l_i].isam025, #160831-00052#1 add
              l_isam[l_i].isam036 ,l_isam[l_i].isam050,l_isam[l_i].isament)
      
      LET l_i = l_i + 1
   END FOREACH
  
   
END FUNCTION

################################################################################
# Descriptions...: 第二單身填充
# Memo...........:
# Usage..........: CALL aapq120_b_fill2()
# Date & Author..: 2014/12/30 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION aapq120_b_fill2()
   DEFINE li_ac           LIKE type_t.num5
   DEFINE l_sql           STRING
     
   #沖銷明細
   IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
      LET g_detail_idx = 1
   END IF
   
   LET li_ac = 1
   CALL g_isam2_d.clear()          
              
#   LET l_sql = " SELECT apde001,'',apdedocno ,                     ",
#               "        apde002,'',apde006,apde100 ,               ",
#               "        apde109,apde119,apde003,apde024,           ",
#               "        apde032,apde014                            ",
#               "   FROM apde_t,apca_t                              ",
#               "  WHERE apdedocno = '",g_isam_d[g_detail_idx].isam050,"' ",
#               "   AND apdeent = apcaent AND apdedocno = apcadocno ",
#               "   AND apdeent = '",g_enterprise,"'                ",
#               "   AND apde002 = '10'                              ",
#               "   AND apcastus = 'Y'                              ",
#               " UNION                                             ",
#               " SELECT apde001,'',apdedocno ,                     ",
#               "        apde002,'',apde006,apde100 ,               ",
#               "        apde109,apde119,apde003,apde024,           ",
#               "        apde032,apde014                            ",
#               "   FROM apde_t,apda_t                              ",
#               "  WHERE apdedocno IN (SELECT apcedocno FROM apce_t ",
#               "                       WHERE apceent = '",g_enterprise,"' ",
#               "                         AND apce003 = '",g_isam_d[g_detail_idx].isam050,"' ) ",
#               "   AND apdeent = apdaent AND apdedocno = apdadocno   ",
#               "   AND apdeent = '",g_enterprise,"'                  ",
#               "   AND apde002 = '10'                                ",
#               "   AND apdastus = 'Y'                                ",
#               "   UNION                                             ",
#               " SELECT xrde001,'',xrdedocno ,                     ",
#               "        xrde002,'',xrde006,xrde100 ,               ",
#               "        xrde109,xrde119,xrde003,xrde008,           ",
#               "        to_date('','YYYY/MM/DD'),xrde014           ",
#               "   FROM xrde_t,xrda_t                              ",
#               "  WHERE xrdedocno IN (SELECT xrcedocno FROM xrce_t ",
#               "                       WHERE xrceent = '",g_enterprise,"' ",
#               "                         AND xrce003 = '",g_isam_d[g_detail_idx].isam050,"' ) ",
#               "   AND xrdeent = xrdaent AND xrdedocno = xrdadocno   ",
#               "   AND xrdeent = '",g_enterprise,"'                  ",
#               "   AND xrde002 = '10'                                ",
#               "   AND xrdastus = 'Y'                                ",
#               "   UNION ",
#               "   SELECT 'aapt415','',apebdocno,                    ",
#               "          '90',     '','',apeb100,                   ",
#               "          apeb109,apeb119,apeb003,'',                ",
#               "          to_date('','YYYY/MM/DD'), ''               ",
#               "     FROM apeb_t                                               ",
#               "    WHERE apebent   = ",g_enterprise,"                         ",
#               "      AND apeb003   =  '",g_isam_d[g_detail_idx].isamdocno,"'  "



   
   #20150301--add--str--               
   LET l_sql = "   SELECT 'aapt415','',apeb011,apeb008,apebdocno,    ",
               "          '90',     '','',apeb100,                   ",
               "          apeb101,apeb109,apeb119,apeb003,'',        ",
               "          to_date('','YYYY/MM/DD'), ''               ",
               "     FROM apeb_t,apea_t                              ",
               "    WHERE apebent   = ",g_enterprise,"               ",
               "      AND apeb003   = '",g_isam_d[g_detail_idx].isamdocno,"'",
               "      AND apeb008   = '",g_isam_d[g_detail_idx].isam010,"'",
               "      AND apeaent   = apebent                        ",
               "      AND apeadocno = apebdocno                      ",
               "      AND apeastus = 'Y'                             "
   #20150301--add--end--
                            
   PREPARE aapq120_pb2 FROM l_sql
   DECLARE b_fill2_curs2 CURSOR FOR aapq120_pb2

   FOREACH b_fill2_curs2 INTO 
      g_isam2_d[li_ac].apde001,g_isam2_d[li_ac].apde001_desc,
      g_isam2_d[li_ac].apeb011,g_isam2_d[li_ac].apeb008,
      g_isam2_d[li_ac].apdedocno,g_isam2_d[li_ac].apde002,g_isam2_d[li_ac].apde002_desc,
      g_isam2_d[li_ac].apde006,g_isam2_d[li_ac].apde100,g_isam2_d[li_ac].apde101,
      g_isam2_d[li_ac].apde109,
      g_isam2_d[li_ac].apde119,g_isam2_d[li_ac].apde003,g_isam2_d[li_ac].apde024,
      g_isam2_d[li_ac].apde032,g_isam2_d[li_ac].apde014
              
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:b_fill2_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF   
            
      #作業別
      CALL s_desc_gzcbl004_desc(8529,g_isam2_d[li_ac].apde001)RETURNING g_isam2_d[li_ac].apde001_desc
      #類型
      CALL s_desc_gzcbl004_desc(8506,g_isam2_d[li_ac].apde002)RETURNING g_isam2_d[li_ac].apde002_desc
      IF cl_null(g_isam2_d[li_ac].apde002_desc) THEN
         LET g_isam2_d[li_ac].apde002_desc = g_isam2_d[li_ac].apde002
      ELSE
         LET g_isam2_d[li_ac].apde002_desc = g_isam2_d[li_ac].apde002,'.',g_isam2_d[li_ac].apde002_desc
      END IF
      #付款方式
      IF NOT cl_null(s_desc_gzcbl004_desc(8310,g_isam2_d[li_ac].apde006))THEN
         LET g_isam2_d[li_ac].apde006 = g_isam2_d[li_ac].apde006,".",s_desc_gzcbl004_desc(8310,g_isam2_d[li_ac].apde006)
      END IF
                 
      LET li_ac = li_ac + 1
      IF li_ac > g_max_rec THEN
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
   CALL g_isam2_d.deleteElement(g_isam2_d.getLength())
   
  # DISPLAY li_ac TO FORMONLY.cnt
  #LET g_detail_idx2 = 1
  # DISPLAY g_detail_idx2 TO FORMONLY.idx
   


END FUNCTION

################################################################################
# Descriptions...: 掃把清空&給預設值 #150127-00007#1
# Memo...........:
# Usage..........: CALL aapq120_qbe_clear()

# Date & Author..: 2015/02/02 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq120_qbe_clear()
   DEFINE l_success     LIKE type_t.num5   #20150301  add
   #帳務組織/帳套/法人預設
   CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,g_input.apcasite,
                                                      g_glaald,g_input.isamcomp
   CALL s_fin_orga_get_comp_ld(g_input.apcasite) RETURNING g_sub_success,g_errno,g_input.isamcomp,g_glaald     
   CALL s_fin_get_wc_str(g_input.isamcomp) RETURNING g_comp_str 
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl        #161229-00047#23 add  
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.isamcomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#4 add      #161229-00047#23 mark
   LET g_input.apcasite_desc = s_desc_get_department_desc(g_input.apcasite)
   CALL s_desc_get_department_desc(g_input.isamcomp) RETURNING g_input.isamcomp_desc
   CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'1')
   #取得帳務中心底下之組織範圍
   #抓取法人有哪些
   CALL s_fin_account_center_comp_str() RETURNING g_wc_apcacomp
   CALL s_fin_get_wc_str(g_wc_apcacomp) RETURNING g_wc_apcacomp 
   DISPLAY BY NAME g_input.apcasite,g_input.apcasite_desc,g_input.isamcomp_desc
   
END FUNCTION

################################################################################
# Descriptions...: 法人權限檢核
# Memo...........: #161014-00053#2
# Usage..........: CALL aapq120_isamcomp_chk(p_comp)
#                  RETURNING 無
# Input parameter: p_comp 法人
# Return code....: 無
# Date & Author..: 161020 By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq120_isamcomp_chk(p_comp)
   DEFINE p_comp   LIKE apga_t.apgacomp
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
      AND ooef001 = p_comp
      
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
   IF NOT r_success THEN RETURN r_success,r_errno END IF

   LET l_count = NULL
   LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = ",g_enterprise," ",
               "   AND ooef001 = '",p_comp,"' ",
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

 
{</section>}
 
