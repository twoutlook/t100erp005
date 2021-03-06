#該程式未解開Section, 採用最新樣板產出!
{<section id="aisq350.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2015-01-30 11:34:51), PR版次:0007(2016-10-24 14:59:01)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000111
#+ Filename...: aisq350
#+ Description: 業務往來對帳單查詢
#+ Creator....: 04152(2015-01-08 15:49:25)
#+ Modifier...: 04152 -SD/PR- 04152
 
{</section>}
 
{<section id="aisq350.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#150206-00002#1  2015/02/09 By Reanna     增加撈取上期餘額的資訊
#151231-00010#3  2016/01/21 By albireo    增加控制組判斷
#160414-00018#26 2016/05/03 By Reanna     執行效能程式調整
#160920-00019#5  2016/09/20 By 08732      交易對象開窗調整為q_pmaa001_13
#161006-00005#27 2016/10/24 By Reanna     帳務中心(isafsite)開窗改用q_ooef001_46()
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
PRIVATE TYPE type_g_isaf_d RECORD
       #statepic       LIKE type_t.chr1,
       
       isafdocno LIKE isaf_t.isafdocno, 
   isafcomp LIKE isaf_t.isafcomp, 
   isafcomp_desc LIKE type_t.chr500, 
   isaf003 LIKE isaf_t.isaf003, 
   isaf003_desc LIKE type_t.chr500, 
   isaf100 LIKE isaf_t.isaf100, 
   l_isaf105_1 LIKE type_t.num20_6, 
   l_isaf105_2 LIKE type_t.num20_6, 
   l_isaf105_3 LIKE type_t.num20_6, 
   l_isaf105_4 LIKE type_t.num20_6, 
   l_isaf115_1 LIKE type_t.num20_6, 
   l_isaf115_2 LIKE type_t.num20_6, 
   l_isaf115_3 LIKE type_t.num20_6, 
   l_isaf115_4 LIKE type_t.num20_6 
       END RECORD
PRIVATE TYPE type_g_isaf2_d RECORD
       isafcomp LIKE isaf_t.isafcomp, 
   isafcomp_2_desc LIKE type_t.chr500, 
   l_isaf003_2 LIKE type_t.chr10, 
   l_isaf003_2_desc LIKE type_t.chr500, 
   l_isaf100_2 LIKE type_t.chr10, 
   l_isafdocno_2 LIKE type_t.chr20, 
   isafdocdt LIKE isaf_t.isafdocdt, 
   isaf057 LIKE isaf_t.isaf057, 
   l_isaf057_desc LIKE type_t.chr500, 
   isag001 LIKE isag_t.isag001, 
   isag002 LIKE isag_t.isag002, 
   l_isaf105_5 LIKE type_t.num20_6, 
   l_isaf115_5 LIKE type_t.num20_6, 
   l_isaf105_6 LIKE type_t.num20_6, 
   l_isaf115_6 LIKE type_t.num20_6, 
   l_prog LIKE type_t.chr500
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_head             STRING
DEFINE g_wc_isafcomp         STRING                        #帳務中心條件
DEFINE g_input     RECORD
        isafsite        LIKE isaf_t.isafsite,
        l_isafsite_desc LIKE type_t.chr80,
        l_isafdocdt1    LIKE isaf_t.isafdocdt,
        l_isafdocdt2    LIKE isaf_t.isafdocdt
                   END RECORD
DEFINE g_page1_ac            LIKE type_t.num5

#151231-00010#3-----s
DEFINE g_ctl_where          STRING    #交易對象控制組WHERE CON
#151231-00010#3-----e
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_isaf_d
DEFINE g_master_t                   type_g_isaf_d
DEFINE g_isaf_d          DYNAMIC ARRAY OF type_g_isaf_d
DEFINE g_isaf_d_t        type_g_isaf_d
DEFINE g_isaf2_d   DYNAMIC ARRAY OF type_g_isaf2_d
DEFINE g_isaf2_d_t type_g_isaf2_d
 
 
      
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
 
{<section id="aisq350.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_comp LIKE ooef_t.ooef001   #151231-00010#3
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ais","")
 
   #add-point:作業初始化 name="main.init"
   #151231-00010#3-----s
   LET l_comp = NULL
   SELECT ooef017 INTO l_comp FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   CALL s_control_get_customer_sql('2',l_comp,g_user,g_dept,'') RETURNING g_sub_success,g_ctl_where   
   #151231-00010#3-----e 
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
   DECLARE aisq350_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aisq350_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aisq350_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisq350 WITH FORM cl_ap_formpath("ais",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aisq350_init()   
 
      #進入選單 Menu (="N")
      CALL aisq350_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aisq350
      
   END IF 
   
   CLOSE aisq350_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aisq350.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aisq350_init()
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
   
      CALL cl_set_combo_scc('b_isag001','24') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_isag001','8341')
   #CALL cl_set_combo_scc('isag001','24')
   CALL s_fin_create_account_center_tmp()
   #end add-point
 
   CALL aisq350_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aisq350.default_search" >}
PRIVATE FUNCTION aisq350_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " isafcomp = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " isafdocno = '", g_argv[02], "' AND "
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
 
{<section id="aisq350.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aisq350_ui_dialog()
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
   DEFINE li_ac2          LIKE type_t.num5
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
      CALL aisq350_b_fill()
   ELSE
      CALL aisq350_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_isaf_d.clear()
         CALL g_isaf2_d.clear()
 
 
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
 
         CALL aisq350_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_isaf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aisq350_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aisq350_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               LET g_page1_ac = l_ac
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
         DISPLAY ARRAY g_isaf2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_isaf2_d.getLength() TO FORMONLY.h_count
               CALL aisq350_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body2.before_row"
 
               #end add-point  
 
            #自訂ACTION(detail_show,page_2)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page2_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_aist310
                  LET g_action_choice="prog_aist310"
                  IF cl_auth_chk_act("prog_aist310") THEN
                     
                     #add-point:ON ACTION prog_aist310 name="menu.detail_show.page2_sub.prog_aist310"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aist310'
               LET la_param.param[1] = g_isaf2_d[l_ac].l_isafdocno_2

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


                     #END add-point
                     
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page2.detail_qrystr"
               
               #END add-point
               
 
 
 
 
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aisq350_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #列印報表aisr350(tm.wc,帳務中心底下的所有法人,帳款日期起,帳款日期迄)
               CALL aisr350_g01("",g_wc_isafcomp,g_input.l_isafdocdt1,g_input.l_isafdocdt2)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #列印報表aisr350(tm.wc,帳務中心底下的所有法人,帳款日期起,帳款日期迄)
               CALL aisr350_g01("",g_wc_isafcomp,g_input.l_isafdocdt1,g_input.l_isafdocdt2)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aisq350_query()
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
            CALL aisq350_filter()
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
            CALL aisq350_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_isaf_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_isaf2_d)
               LET g_export_id[2]   = "s_detail2"
 
 
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
            CALL aisq350_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aisq350_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aisq350_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aisq350_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION modify_detail
            #對帳單/收款單超連結
            IF NOT cl_null(g_isaf2_d[l_ac].l_prog) THEN
               IF g_isaf2_d[l_ac].l_prog = "aist310" THEN 
                  LET la_param.prog = 'aist310'
               ELSE
                  LET la_param.prog = 'aist340'
               END IF
            END IF
            LET la_param.param[1] = g_isaf2_d[l_ac].isafcomp
            LET la_param.param[2] = g_isaf2_d[l_ac].l_isafdocno_2
            LET ls_js = util.JSON.stringify(la_param)
            CALL cl_cmdrun_wait(ls_js)
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
 
{<section id="aisq350.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aisq350_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_isafsite LIKE isaf_t.isafsite
   DEFINE l_comp     LIKE ooef_t.ooef001
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_isaf_d.clear()
   CALL g_isaf2_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON isafcomp,isaf003,isaf100
           FROM s_detail1[1].b_isafcomp,s_detail1[1].b_isaf003,s_detail1[1].b_isaf100
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_isafdocno>>----
         #----<<b_isafcomp>>----
         #Ctrlp:construct.c.page1.b_isafcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafcomp
            #add-point:ON ACTION controlp INFIELD b_isafcomp name="construct.c.page1.b_isafcomp"
            #開窗c段
            #法人
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooef003 = 'Y' AND ooef001 IN ",g_wc_isafcomp CLIPPED
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO b_isafcomp
            NEXT FIELD b_isafcomp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isafcomp
            #add-point:BEFORE FIELD b_isafcomp name="construct.b.page1.b_isafcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isafcomp
            
            #add-point:AFTER FIELD b_isafcomp name="construct.a.page1.b_isafcomp"
            
            #END add-point
            
 
 
         #----<<b_isafcomp_desc>>----
         #----<<b_isaf003>>----
         #Ctrlp:construct.c.page1.b_isaf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf003
            #add-point:ON ACTION controlp INFIELD b_isaf003 name="construct.c.page1.b_isaf003"
            #開窗c段
            #客戶編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#3-----s
            LET l_comp = NULL
            SELECT ooef017 INTO l_comp FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
                                                     
            LET g_qryparam.where = g_ctl_where,"AND EXISTS (SELECT 1 FROM pmab_t ",
                                                     "    WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                                     "      AND pmabsite = '",l_comp,"') "                                                    
            #151231-00010#3-----e        
            #CALL q_pmaa001()     #160920-00019#5--mark   
            CALL q_pmaa001_13()   #160920-00019#5--add
            DISPLAY g_qryparam.return1 TO b_isaf003
            NEXT FIELD b_isaf003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf003
            #add-point:BEFORE FIELD b_isaf003 name="construct.b.page1.b_isaf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf003
            
            #add-point:AFTER FIELD b_isaf003 name="construct.a.page1.b_isaf003"
            
            #END add-point
            
 
 
         #----<<b_isaf003_desc>>----
         #----<<b_isaf100>>----
         #Ctrlp:construct.c.page1.b_isaf100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf100
            #add-point:ON ACTION controlp INFIELD b_isaf100 name="construct.c.page1.b_isaf100"
            #開窗c段
            #幣別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()
            DISPLAY g_qryparam.return1 TO b_isaf100
            NEXT FIELD b_isaf100
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf100
            #add-point:BEFORE FIELD b_isaf100 name="construct.b.page1.b_isaf100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf100
            
            #add-point:AFTER FIELD b_isaf100 name="construct.a.page1.b_isaf100"
            
            #END add-point
            
 
 
         #----<<l_isaf105_1>>----
         #----<<l_isaf105_2>>----
         #----<<l_isaf105_3>>----
         #----<<l_isaf105_4>>----
         #----<<l_isaf115_1>>----
         #----<<l_isaf115_2>>----
         #----<<l_isaf115_3>>----
         #----<<l_isaf115_4>>----
         #----<<isafcomp_2_desc>>----
         #----<<l_isaf003_2>>----
         #----<<l_isaf003_2_desc>>----
         #----<<l_isaf100_2>>----
         #----<<l_isafdocno_2>>----
         #----<<b_isafdocdt>>----
         #----<<b_isaf057>>----
         #----<<l_isaf057_desc>>----
         #----<<b_isag001>>----
         #----<<b_isag002>>----
         #----<<l_isaf105_5>>----
         #----<<l_isaf115_5>>----
         #----<<l_isaf105_6>>----
         #----<<l_isaf115_6>>----
         #----<<l_prog>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT g_input.isafsite,g_input.l_isafdocdt1,g_input.l_isafdocdt2 FROM isafsite,l_isafdocdt1,l_isafdocdt2
            ATTRIBUTE(WITHOUT DEFAULTS)

         AFTER FIELD isafsite
            IF NOT cl_null(g_input.isafsite) THEN
               CALL s_fin_account_center_with_ld_chk(g_input.isafsite,'',g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               #重新抓取該帳務中心底下的法人有哪些
               IF NOT cl_null(g_input.isafsite) THEN
                  CALL s_fin_account_center_sons_query('3',g_input.isafsite,g_today,'')
                  CALL s_fin_account_center_comp_str() RETURNING g_wc_isafcomp
                  CALL s_fin_get_wc_str(g_wc_isafcomp) RETURNING g_wc_isafcomp
                  CALL s_desc_get_department_desc(g_input.isafsite) RETURNING g_input.l_isafsite_desc
                  DISPLAY BY NAME g_input.l_isafsite_desc
               END IF
            END IF

         AFTER INPUT
            IF NOT cl_null(g_input.l_isafdocdt1) AND NOT cl_null(g_input.l_isafdocdt2) THEN
               IF g_input.l_isafdocdt1 > g_input.l_isafdocdt2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "amm-00081"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
         
         #帳務中心
         ON ACTION controlp INFIELD isafsite
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.isafsite
            #CALL q_ooef001()      #161006-00005#26 mark
            CALL q_ooef001_46()    #161006-00005#26
            LET g_input.isafsite = g_qryparam.return1
            DISPLAY g_input.isafsite TO isafsite
            NEXT FIELD isafsite
      
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
         CALL aisq350_qbe_clear()


      BEFORE DIALOG
         CALL aisq350_qbe_clear()

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
   #151231-00010#3-----s
   LET l_comp = NULL
   SELECT ooef017 INTO l_comp FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site                                           
   LET g_wc = g_wc CLIPPED," AND EXISTS     (SELECT 1 FROM pmaa_t,pmab_t ",
                                            " WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                            "   AND pmaaent = ",g_enterprise," AND ",g_ctl_where,
                                            "   AND pmabsite = '",l_comp,"' ",
                                            "   AND pmaaent = isafent AND pmaa001 = isaf003)"
   #151231-00010#3-----e
   #end add-point
        
   LET g_error_show = 1
   CALL aisq350_b_fill()
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
 
{<section id="aisq350.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aisq350_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   #150206-00002#1 add ------
   DEFINE l_main_sql      STRING
   DEFINE l_wc_date       STRING
   DEFINE l_sql1          STRING
   DEFINE l_sql2          STRING
   #150206-00002#1 add end---
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
 
   LET ls_sql_rank = "SELECT  UNIQUE isafdocno,isafcomp,'',isaf003,'',isaf100,'','','','','','','','', 
       '','','','','','',isafdocdt,isaf057,'','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY isaf_t.isafcomp, 
       isaf_t.isafdocno) AS RANK FROM isaf_t",
 
 
                     " LEFT JOIN isag_t ON isafcomp = isagcomp AND isafdocno = isagdocno AND",
                     " WHERE isafent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("isaf_t"),
                     " ORDER BY isaf_t.isafcomp,isaf_t.isafdocno"
 
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
 
   LET g_sql = "SELECT isafdocno,isafcomp,'',isaf003,'',isaf100,'','','','','','','','','','','','', 
       '','',isafdocdt,isaf057,'','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150206-00002#1 mod ------
   LET l_main_sql = " SELECT isafsite,isafcomp,isaf003,isaf100",
                    "       ,0 AS A,SUM(isag105*isag015) AS B,0 AS C,0",
                    "       ,0 AS D,SUM(isag115*isag015) AS E,0 AS F,0",
                    "       ,isafent ",    #151231-00010#3
                    "   FROM isaf_t",
                    "   LEFT OUTER JOIN isag_t ON isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno",
                    "  WHERE isafent = ? ",
                    "    AND isafstus ='Y'",
                    "    AND isafcomp IN ",g_wc_isafcomp,
                    "    !@# ",   #用!@# 取代日期條件
                    "  GROUP BY isafsite,isafcomp,isaf003,isaf100,isafent",
                    " UNION ",
                    " SELECT isafsite,isbacomp,isba003,isaf100",
                    "       ,0,0,SUM(isbc103),0",
                    "       ,0,0,SUM(isbc104),0",
                    "       ,isbaent ",#151231-00010#3
                    "   FROM isba_t",
                    "   LEFT OUTER JOIN isbc_t ON isbaent = isbcent AND isbacomp = isbccomp AND isbadocno = isbcdocno",
                    "   LEFT OUTER JOIN isaf_t ON isbcent = isafent AND isbc004 = isafdocno",
                    "  WHERE isbaent = ",g_enterprise,
                    "    AND isbastus ='Y'",
                    "    AND isbacomp IN ",g_wc_isafcomp,
                    "    !@# ",   #用!@# 取代日期條件
                    "  GROUP BY isafsite,isbacomp,isba003,isaf100,isbaent ",
                    "  ORDER BY isafsite,isafcomp,isaf003,isaf100"
   
   #取QBE日期區間異動資料
   LET l_wc_date = " AND isafdocdt BETWEEN '",g_input.l_isafdocdt1,"' AND '",g_input.l_isafdocdt2,"'"
   CALL s_chr_replace(l_main_sql,'!@#',l_wc_date,1) RETURNING l_sql1
   LET l_wc_date = " AND isbadocdt BETWEEN '",g_input.l_isafdocdt1,"' AND '",g_input.l_isafdocdt2,"'"
   CALL s_chr_replace(l_sql1,'!@#',l_wc_date,1) RETURNING l_sql1
   
   #取尚未付款金額
   LET l_wc_date = " AND isafdocdt < '",g_input.l_isafdocdt1,"'"
   CALL s_chr_replace(l_main_sql,'!@#',l_wc_date,1) RETURNING l_sql2
   LET l_wc_date = " AND isbadocdt < '",g_input.l_isafdocdt1,"'"
   CALL s_chr_replace(l_sql2,'!@#',l_wc_date,1) RETURNING l_sql2
   CALL s_chr_replace(l_sql2,'?',g_enterprise,1) RETURNING l_sql2
   
   #160414-00018#26 mark ------
   ##最後在把"QBE日期區間異動資料"+"尚未付款金額(期初餘額)"GROUP BY
   #LET g_sql = "SELECT '',isafcomp,'',isaf003,''",
   #            "      ,isaf100,SUM(A),SUM(B),SUM(C),0",
   #            "      ,SUM(D),SUM(E),SUM(F),0,''",
   #            "      ,'','','','',''",
   #            "      ,'','','','',''",
   #            "   FROM ( ",
   #            "          SELECT isafsite,isafcomp,isaf003,isaf100",
   #            "                ,0 AS A,SUM(B) AS B,SUM(C) AS C,0",
   #            "                ,0 AS D,SUM(E) AS E,SUM(F) AS F,0",
   #            "                ,isafent ",   #151231-00010#3
   #            "            FROM (",l_sql1,") ",
   #            "            GROUP BY isafsite,isafcomp,isaf003,isaf100,isafent",
   #            "          UNION ",
   #            "          SELECT isafsite,isafcomp,isaf003,isaf100",
   #            "                ,SUM(B)-SUM(C),0,0,0",
   #            "                ,SUM(E)-SUM(F),0,0,0",
   #            "                ,isafent ", #151231-00010#3
   #            "            FROM (",l_sql2,") ",
   #            "            GROUP BY isafsite,isafcomp,isaf003,isaf100,isafent",
   #            "          ORDER BY isafsite,isafcomp,isaf003,isaf100",
   #            "        )",
   #            "   WHERE 1=1 AND "
   #160414-00018#26 mark end---
   #160414-00018#26 add ------
   #最後在把"QBE日期區間異動資料"+"尚未付款金額(期初餘額)"GROUP BY
   LET g_sql = "SELECT '',isafcomp,",
               #法人名稱
               "       (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = isafent AND ooefl001 = isafcomp AND ooefl002 = '",g_dlang,"'),",
               "       isaf003,",
               #客戶名稱
               "       (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = isafent AND pmaal001 = isaf003 AND pmaal002 = '",g_dlang,"'),",
               "       isaf100,SUM(A),SUM(B),SUM(C),0,",
               "       SUM(D),SUM(E),SUM(F),0,'',",
               "       '','','','','',",
               "       '','','','','',",
               "       isafent",
               "   FROM ( ",
               "          SELECT isafsite,isafcomp,isaf003,isaf100,",
               "                 0 AS A,SUM(B) AS B,SUM(C) AS C,0,",
               "                 0 AS D,SUM(E) AS E,SUM(F) AS F,0,",
               "                 isafent ",   #151231-00010#3
               "            FROM (",l_sql1,") ",
               "            GROUP BY isafsite,isafcomp,isaf003,isaf100,isafent",
               "          UNION ",
               "          SELECT isafsite,isafcomp,isaf003,isaf100,",
               "                 SUM(B)-SUM(C),0,0,0,",
               "                 SUM(E)-SUM(F),0,0,0,",
               "                 isafent ", #151231-00010#3
               "            FROM (",l_sql2,") ",
               "            GROUP BY isafsite,isafcomp,isaf003,isaf100,isafent",
               "          ORDER BY isafsite,isafcomp,isaf003,isaf100",
               "        )",
               "   WHERE 1=1 AND "
   #160414-00018#26 add end---
   LET g_sql = g_sql, ls_wc,cl_sql_add_filter("isaf_t"),
               "   GROUP BY isafent,isafsite,isafcomp,isaf003,isaf100",
               "   ORDER BY isafent,isafsite,isafcomp,isaf003,isaf100"
   #150206-00002#1 mod end---
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aisq350_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aisq350_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_isaf_d.clear()
   CALL g_isaf2_d.clear()   
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_isaf_d[l_ac].isafdocno,g_isaf_d[l_ac].isafcomp,g_isaf_d[l_ac].isafcomp_desc, 
       g_isaf_d[l_ac].isaf003,g_isaf_d[l_ac].isaf003_desc,g_isaf_d[l_ac].isaf100,g_isaf_d[l_ac].l_isaf105_1, 
       g_isaf_d[l_ac].l_isaf105_2,g_isaf_d[l_ac].l_isaf105_3,g_isaf_d[l_ac].l_isaf105_4,g_isaf_d[l_ac].l_isaf115_1, 
       g_isaf_d[l_ac].l_isaf115_2,g_isaf_d[l_ac].l_isaf115_3,g_isaf_d[l_ac].l_isaf115_4,g_isaf2_d[l_ac].isafcomp, 
       g_isaf2_d[l_ac].isafcomp_2_desc,g_isaf2_d[l_ac].l_isaf003_2,g_isaf2_d[l_ac].l_isaf003_2_desc, 
       g_isaf2_d[l_ac].l_isaf100_2,g_isaf2_d[l_ac].l_isafdocno_2,g_isaf2_d[l_ac].isafdocdt,g_isaf2_d[l_ac].isaf057, 
       g_isaf2_d[l_ac].l_isaf057_desc,g_isaf2_d[l_ac].isag001,g_isaf2_d[l_ac].isag002,g_isaf2_d[l_ac].l_isaf105_5, 
       g_isaf2_d[l_ac].l_isaf115_5,g_isaf2_d[l_ac].l_isaf105_6,g_isaf2_d[l_ac].l_isaf115_6,g_isaf2_d[l_ac].l_prog 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_isaf_d[l_ac].statepic = cl_get_actipic(g_isaf_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #160414-00018#26 mark ------
      ##法人名稱
      #CALL s_desc_get_department_desc(g_isaf_d[l_ac].isafcomp) RETURNING g_isaf_d[l_ac].isafcomp_desc
      ##客戶名稱
      #CALL s_desc_get_trading_partner_abbr_desc(g_isaf_d[l_ac].isaf003) RETURNING g_isaf_d[l_ac].isaf003_desc
      #160414-00018#26 mark end---
      
      IF cl_null(g_isaf_d[l_ac].l_isaf105_1) THEN LET g_isaf_d[l_ac].l_isaf105_1 = 0 END IF
      IF cl_null(g_isaf_d[l_ac].l_isaf115_1) THEN LET g_isaf_d[l_ac].l_isaf115_1 = 0 END IF
      IF cl_null(g_isaf_d[l_ac].l_isaf105_2) THEN LET g_isaf_d[l_ac].l_isaf105_2 = 0 END IF
      IF cl_null(g_isaf_d[l_ac].l_isaf115_2) THEN LET g_isaf_d[l_ac].l_isaf115_2 = 0 END IF
      IF cl_null(g_isaf_d[l_ac].l_isaf105_3) THEN LET g_isaf_d[l_ac].l_isaf105_3 = 0 END IF
      IF cl_null(g_isaf_d[l_ac].l_isaf115_3) THEN LET g_isaf_d[l_ac].l_isaf115_3 = 0 END IF
      
      #應收原幣餘額：上期原幣餘額+本期應收原幣-本期已收原幣
      LET g_isaf_d[l_ac].l_isaf105_4 = g_isaf_d[l_ac].l_isaf105_1+g_isaf_d[l_ac].l_isaf105_2-g_isaf_d[l_ac].l_isaf105_3
      IF cl_null(g_isaf_d[l_ac].l_isaf105_4) THEN LET g_isaf_d[l_ac].l_isaf105_4 = 0 END IF
      #應收本幣餘額：上期本幣餘額+本期應收本幣-本期已收本幣
      LET g_isaf_d[l_ac].l_isaf115_4 = g_isaf_d[l_ac].l_isaf115_1+g_isaf_d[l_ac].l_isaf115_2-g_isaf_d[l_ac].l_isaf115_3
      IF cl_null(g_isaf_d[l_ac].l_isaf115_3) THEN LET g_isaf_d[l_ac].l_isaf115_3 = 0 END IF
      #end add-point
 
      CALL aisq350_detail_show("'1'")      
 
      CALL aisq350_isaf_t_mask()
 
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
   
 
   
   CALL g_isaf_d.deleteElement(g_isaf_d.getLength())   
   CALL g_isaf2_d.deleteElement(g_isaf2_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_isaf_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aisq350_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aisq350_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aisq350_detail_action_trans()
 
   IF g_isaf_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aisq350_fetch()
   END IF
   
      CALL aisq350_filter_show('isafcomp','b_isafcomp')
   CALL aisq350_filter_show('isaf003','b_isaf003')
   CALL aisq350_filter_show('isaf100','b_isaf100')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq350.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aisq350_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_sql           STRING
   DEFINE li_ac2          LIKE type_t.num5
   DEFINE l_last_isaf105  LIKE isaf_t.isaf105
   DEFINE l_last_isaf115  LIKE isaf_t.isaf115
   DEFINE l_last_isbc103  LIKE isbc_t.isbc103
   DEFINE l_last_isbc104  LIKE isbc_t.isbc104
   DEFINE l_sum1          LIKE isaf_t.isaf105
   DEFINE l_sum2          LIKE isaf_t.isaf105
   DEFINE l_sum3          LIKE isaf_t.isaf115
   DEFINE l_sum4          LIKE isaf_t.isaf115
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
 
   #add-point:陣列清空 name="fetch.array_clear"
 
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   IF cl_null(g_page1_ac) OR g_page1_ac = 0 THEN LET g_page1_ac = 1 END IF
   CALL g_isaf2_d.clear()
   
   LET l_sum1 = 0
   LET l_sum2 = 0
   LET l_sum3 = 0
   LET l_sum4 = 0

   #撈取該客戶上期餘額
   SELECT SUM(isag105*isag015),SUM(isag115*isag015)
     INTO l_last_isaf105,l_last_isaf115
     FROM isaf_t
     LEFT OUTER JOIN isag_t ON isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno
    WHERE isafent = g_enterprise
      AND isafcomp = g_isaf_d[g_page1_ac].isafcomp
      AND isaf003 = g_isaf_d[g_page1_ac].isaf003
      AND isaf100 = g_isaf_d[g_page1_ac].isaf100
      AND isafdocdt < g_input.l_isafdocdt1
      AND isafstus = 'Y'
   IF cl_null(l_last_isaf105) THEN LET l_last_isaf105 = 0 END IF
   IF cl_null(l_last_isaf115) THEN LET l_last_isaf115 = 0 END IF
   SELECT SUM(isbc103),SUM(isbc104)
     INTO l_last_isbc103,l_last_isbc104
     FROM isbc_t
     INNER JOIN isba_t ON isbcent = isbaent AND isbccomp = isbacomp AND isbcdocno = isbadocno
     LEFT OUTER JOIN isaf_t ON isbcent = isafent AND isbc004 = isafdocno
    WHERE isbcent = g_enterprise
      AND isbccomp = g_isaf_d[g_page1_ac].isafcomp
      AND isaf003 = g_isaf_d[g_page1_ac].isaf003
      AND isaf100 = g_isaf_d[g_page1_ac].isaf100
      AND isbastus = 'Y'
      AND isbadocdt < g_input.l_isafdocdt1
   IF cl_null(l_last_isbc103) THEN LET l_last_isbc103 = 0 END IF
   IF cl_null(l_last_isbc104) THEN LET l_last_isbc104 = 0 END IF
   #上期原幣餘額 = 上期應收原幣 - 上期已收原幣
   LET g_isaf2_d[1].l_isaf105_5 = l_last_isaf105 - l_last_isbc103
   IF cl_null(g_isaf2_d[1].l_isaf105_5) THEN LET g_isaf2_d[1].l_isaf105_5 = 0 END IF
   #上期本幣餘額 = 上期應收本幣 - 上期已收本幣
   LET g_isaf2_d[1].l_isaf115_5 = l_last_isaf115 - l_last_isbc104
   IF cl_null(g_isaf2_d[1].l_isaf115_5) THEN LET g_isaf2_d[1].l_isaf115_5 = 0 END IF
   LET l_sum1 = l_sum1 + g_isaf2_d[1].l_isaf105_5
   LET l_sum2 = l_sum2 + g_isaf2_d[1].l_isaf115_5
   
   CALL s_desc_gzcbl004_desc('9743','10') RETURNING g_isaf2_d[1].l_isaf057_desc
   
   
   #撈取"本期明細資料"
   LET g_sql = "SELECT UNIQUE isafcomp,'',isaf003,'',isaf100",
               "             ,isafdocno,isafdocdt,isaf057,''",
               "             ,isag001,isag002,'','',''",
               "             ,'','aist310'",
               "  FROM isaf_t",
               "  LEFT OUTER JOIN isag_t ON isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno",
               " WHERE isafent=",g_enterprise,
               "   AND isafcomp='",g_isaf_d[g_page1_ac].isafcomp,"'",
               "   AND isaf003='",g_isaf_d[g_page1_ac].isaf003,"'",
               "   AND isaf100='",g_isaf_d[g_page1_ac].isaf100,"'",
               "   AND isafdocdt BETWEEN '",g_input.l_isafdocdt1,"' AND '",g_input.l_isafdocdt2,"'",
               "   AND isafstus = 'Y'",
               " GROUP BY isafcomp,isaf003,isafdocno,isafdocdt,isaf057,isaf100,isag001,isag002",
               " UNION ",
               "SELECT UNIQUE isbacomp,'',isba003,'',isaf100",
               "             ,isbadocno,isbadocdt,isba001,''",
               "             ,'','','','',''",
               "             ,'','aist340'",
               "  FROM isba_t",
               "  LEFT OUTER JOIN isbc_t ON isbaent = isbcent AND isbacomp = isbccomp AND isbadocno = isbcdocno",
               "  LEFT OUTER JOIN isaf_t ON isbcent = isafent AND isbc004 = isafdocno",
               " WHERE isbaent=",g_enterprise,
               "   AND isbacomp='",g_isaf_d[g_page1_ac].isafcomp,"'",
               "   AND isba003='",g_isaf_d[g_page1_ac].isaf003,"'",
               "   AND isaf100='",g_isaf_d[g_page1_ac].isaf100,"'",
               "   AND isbadocdt BETWEEN '",g_input.l_isafdocdt1,"' AND '",g_input.l_isafdocdt2,"'",
               "   AND isbastus = 'Y'",
               " GROUP BY isbacomp,isba003,isbadocno,isbadocdt,isba001,isaf100",
               " ORDER BY isafdocdt"
   PREPARE aisq350_pb2 FROM g_sql
   DECLARE aisq350_cs2 CURSOR FOR aisq350_pb2

   LET l_ac = 2
   FOREACH aisq350_cs2 INTO 
       g_isaf2_d[l_ac].isafcomp,g_isaf2_d[l_ac].isafcomp_2_desc,g_isaf2_d[l_ac].l_isaf003_2,g_isaf2_d[l_ac].l_isaf003_2_desc,g_isaf2_d[l_ac].l_isaf100_2
      ,g_isaf2_d[l_ac].l_isafdocno_2,g_isaf2_d[l_ac].isafdocdt,g_isaf2_d[l_ac].isaf057,g_isaf2_d[l_ac].l_isaf057_desc
      ,g_isaf2_d[l_ac].isag001,g_isaf2_d[l_ac].isag002,g_isaf2_d[l_ac].l_isaf105_5,g_isaf2_d[l_ac].l_isaf115_5,g_isaf2_d[l_ac].l_isaf105_6
      ,g_isaf2_d[l_ac].l_isaf115_6,g_isaf2_d[l_ac].l_prog
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:aisq350_cs2"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #法人名稱
      CALL s_desc_get_department_desc(g_isaf2_d[l_ac].isafcomp) RETURNING g_isaf2_d[l_ac].isafcomp_2_desc
      #客戶名稱
      CALL s_desc_get_trading_partner_abbr_desc(g_isaf2_d[l_ac].l_isaf003_2) RETURNING g_isaf2_d[l_ac].l_isaf003_2_desc
      #人員名稱
      CALL s_desc_get_person_desc(g_isaf2_d[l_ac].isaf057) RETURNING g_isaf2_d[l_ac].l_isaf057_desc
      
      #對帳單 原幣含稅金額、本幣含稅金額
      #因為來源單號可能會空 所以假裝給值就不用分兩段SQL
      IF cl_null(g_isaf2_d[l_ac].isag002) THEN
         LET g_isaf2_d[l_ac].isag002 = '!@#'
      END IF
      LET l_sql = " SELECT SUM(isag105*isag015),SUM(isag115*isag015)",
                  "   FROM (SELECT isag105,isag015,isag115,CASE WHEN isag002 IS NULL THEN '!@#' ELSE isag002 END AS isag002",
                  "           FROM isaf_t",
                  "           LEFT OUTER JOIN isag_t ON isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno",
                  "          WHERE isafent   =",g_enterprise,
                  "            AND isafcomp  ='",g_isaf2_d[l_ac].isafcomp,"'",
                  "            AND isafdocno ='",g_isaf2_d[l_ac].l_isafdocno_2,"'",
                  "            AND isag001   ='",g_isaf2_d[l_ac].isag001,"'",
                  "         )",
                  "  WHERE isag002 = '",g_isaf2_d[l_ac].isag002,"'"
      PREPARE sel_isag_pre FROM l_sql
      DECLARE sel_isag_cur CURSOR FOR sel_isag_pre
      FOREACH sel_isag_cur INTO g_isaf2_d[l_ac].l_isaf105_5,g_isaf2_d[l_ac].l_isaf115_5
      END FOREACH
      IF g_isaf2_d[l_ac].isag002 = '!@#' THEN #最後要還原空白回來
         LET g_isaf2_d[l_ac].isag002 = ''
      END IF
      IF cl_null(g_isaf2_d[l_ac].l_isaf105_5) THEN LET g_isaf2_d[l_ac].l_isaf105_5 = 0 END IF
      IF cl_null(g_isaf2_d[l_ac].l_isaf115_5) THEN LET g_isaf2_d[l_ac].l_isaf115_5 = 0 END IF
      
      #收款單 已收原幣、本幣金額
      SELECT SUM(isbc103),SUM(isbc104)
        INTO g_isaf2_d[l_ac].l_isaf105_6,g_isaf2_d[l_ac].l_isaf115_6
        FROM isbc_t
       WHERE isbcent = g_enterprise
         AND isbccomp = g_isaf2_d[l_ac].isafcomp
         AND isbcdocno = g_isaf2_d[l_ac].l_isafdocno_2
      IF cl_null(g_isaf2_d[l_ac].l_isaf105_6) THEN LET g_isaf2_d[l_ac].l_isaf105_6 = 0 END IF
      IF cl_null(g_isaf2_d[l_ac].l_isaf115_6) THEN LET g_isaf2_d[l_ac].l_isaf115_6 = 0 END IF
      
      #統計金額(最後要顯示餘額用)
      LET l_sum1 = l_sum1 + g_isaf2_d[l_ac].l_isaf105_5
      LET l_sum2 = l_sum2 + g_isaf2_d[l_ac].l_isaf115_5
      LET l_sum3 = l_sum3 + g_isaf2_d[l_ac].l_isaf105_6
      LET l_sum4 = l_sum4 + g_isaf2_d[l_ac].l_isaf115_6

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
   
   #本期餘額
   LET g_isaf2_d[l_ac].l_isaf105_5 = l_sum1 - l_sum3
   LET g_isaf2_d[l_ac].l_isaf115_5 = l_sum2 - l_sum4
   CALL s_desc_gzcbl004_desc('9743','50') RETURNING g_isaf2_d[l_ac].l_isaf057_desc
   
   LET li_ac2 = g_isaf2_d.getLength()
   DISPLAY li_ac2 TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aisq350.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aisq350_detail_show(ps_page)
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
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
 
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq350.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aisq350_filter()
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
      CONSTRUCT g_wc_filter ON isafcomp,isaf003,isaf100
                          FROM s_detail1[1].b_isafcomp,s_detail1[1].b_isaf003,s_detail1[1].b_isaf100
 
         BEFORE CONSTRUCT
                     DISPLAY aisq350_filter_parser('isafcomp') TO s_detail1[1].b_isafcomp
            DISPLAY aisq350_filter_parser('isaf003') TO s_detail1[1].b_isaf003
            DISPLAY aisq350_filter_parser('isaf100') TO s_detail1[1].b_isaf100
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_isafdocno>>----
         #----<<b_isafcomp>>----
         #Ctrlp:construct.c.page1.b_isafcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafcomp
            #add-point:ON ACTION controlp INFIELD b_isafcomp name="construct.c.filter.page1.b_isafcomp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isafcomp  #顯示到畫面上
            NEXT FIELD b_isafcomp                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_isafcomp_desc>>----
         #----<<b_isaf003>>----
         #Ctrlp:construct.c.page1.b_isaf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf003
            #add-point:ON ACTION controlp INFIELD b_isaf003 name="construct.c.filter.page1.b_isaf003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_pmaa001()     #160920-00019#5--mark   
            CALL q_pmaa001_13()   #160920-00019#5--add  
            DISPLAY g_qryparam.return1 TO b_isaf003  #顯示到畫面上
            NEXT FIELD b_isaf003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_isaf003_desc>>----
         #----<<b_isaf100>>----
         #Ctrlp:construct.c.page1.b_isaf100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf100
            #add-point:ON ACTION controlp INFIELD b_isaf100 name="construct.c.filter.page1.b_isaf100"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isaf100  #顯示到畫面上
            NEXT FIELD b_isaf100                     #返回原欄位
    


            #END add-point
 
 
         #----<<l_isaf105_1>>----
         #----<<l_isaf105_2>>----
         #----<<l_isaf105_3>>----
         #----<<l_isaf105_4>>----
         #----<<l_isaf115_1>>----
         #----<<l_isaf115_2>>----
         #----<<l_isaf115_3>>----
         #----<<l_isaf115_4>>----
         #----<<isafcomp_2_desc>>----
         #----<<l_isaf003_2>>----
         #----<<l_isaf003_2_desc>>----
         #----<<l_isaf100_2>>----
         #----<<l_isafdocno_2>>----
         #----<<b_isafdocdt>>----
         #----<<b_isaf057>>----
         #----<<l_isaf057_desc>>----
         #----<<b_isag001>>----
         #----<<b_isag002>>----
         #----<<l_isaf105_5>>----
         #----<<l_isaf115_5>>----
         #----<<l_isaf105_6>>----
         #----<<l_isaf115_6>>----
         #----<<l_prog>>----
   
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      ON ACTION controlp
         CASE
            WHEN INFIELD (b_isafcomp)
               #開窗c段
               #法人
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "ooef003 = 'Y' AND ooef001 IN ",g_wc_isafcomp CLIPPED
               CALL q_ooef001()
               DISPLAY g_qryparam.return1 TO b_isafcomp
               NEXT FIELD b_isafcomp
            WHEN INFIELD (b_isaf003)
               #開窗c段
               #客戶編號
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #CALL q_pmaa001()     #160920-00019#5--mark   
               CALL q_pmaa001_13()   #160920-00019#5--add
               DISPLAY g_qryparam.return1 TO b_isaf003
               NEXT FIELD b_isaf003
            WHEN INFIELD (b_isaf100)
               #開窗c段
               #幣別
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_aooi001_1()
               DISPLAY g_qryparam.return1 TO b_isaf100
               NEXT FIELD b_isaf100
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
   
      CALL aisq350_filter_show('isafcomp','b_isafcomp')
   CALL aisq350_filter_show('isaf003','b_isaf003')
   CALL aisq350_filter_show('isaf100','b_isaf100')
 
    
   CALL aisq350_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq350.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aisq350_filter_parser(ps_field)
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
 
{<section id="aisq350.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aisq350_filter_show(ps_field,ps_object)
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
   LET ls_condition = aisq350_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq350.insert" >}
#+ insert
PRIVATE FUNCTION aisq350_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aisq350.modify" >}
#+ modify
PRIVATE FUNCTION aisq350_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq350.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aisq350_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq350.delete" >}
#+ delete
PRIVATE FUNCTION aisq350_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq350.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aisq350_detail_action_trans()
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
 
{<section id="aisq350.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aisq350_detail_index_setting()
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
            IF g_isaf_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_isaf_d.getLength() AND g_isaf_d.getLength() > 0
            LET g_detail_idx = g_isaf_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_isaf_d.getLength() THEN
               LET g_detail_idx = g_isaf_d.getLength()
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
 
{<section id="aisq350.mask_functions" >}
 &include "erp/ais/aisq350_mask.4gl"
 
{</section>}
 
{<section id="aisq350.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 給預設
# Memo...........:
# Usage..........: CALL aisq350_qbe_clear()

# Date & Author..: 2015/01/23 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq350_qbe_clear()
   DEFINE l_comp   LIKE ooef_t.ooef001    #151231-00010#3
   CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING g_sub_success,g_input.isafsite,g_errno
   IF NOT cl_null(g_input.isafsite) THEN
      CALL s_desc_get_department_desc(g_input.isafsite) RETURNING g_input.l_isafsite_desc
      #抓取法人有哪些
      CALL s_fin_account_center_sons_query('3',g_input.isafsite,g_today,'')
      CALL s_fin_account_center_comp_str() RETURNING g_wc_isafcomp
      CALL s_fin_get_wc_str(g_wc_isafcomp) RETURNING g_wc_isafcomp
   END IF
   
   CALL s_date_get_first_date(g_today) RETURNING g_input.l_isafdocdt1
   CALL s_date_get_last_date(g_today) RETURNING g_input.l_isafdocdt2
   DISPLAY BY NAME g_input.l_isafsite_desc,g_input.l_isafdocdt1,g_input.l_isafdocdt2
   
 
   
   LET l_ac = 1
   LET g_isaf_d[l_ac].isafcomp = ''
   DISPLAY ARRAY g_isaf_d TO s_detail1.*
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
   
END FUNCTION

 
{</section>}
 
