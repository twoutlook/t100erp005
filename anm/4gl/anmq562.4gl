#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq562.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-01-26 14:57:14), PR版次:0006(2016-10-26 16:21:05)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000052
#+ Filename...: anmq562
#+ Description: 待結算卡追蹤查詢
#+ Creator....: 02599(2015-04-27 15:49:55)
#+ Modifier...: 01727 -SD/PR- 04152
 
{</section>}
 
{<section id="anmq562.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151201-00002#19  2016/01/26 By 01727     天河產品回收
#160122-00001#4   2016/02/22 By 07673     添加交易账户编号用户权限控管
#160318-00025#26  2016/04/28 BY 07900     校验代码重复错误讯息的修改
#160816-00012#4   2016/09/02 By 07900     ANM增加资金中心，帐套，法人三个栏位权限
#161021-00050#8   2016/10/26 By Reanna    资金中心开窗需调整为q_ooef001_33;法人开窗调整为q_ooef001_2,要注意原本where条件中的权限设置要保留
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
PRIVATE TYPE type_g_nmea_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   nmea018 LIKE nmea_t.nmea018, 
   nmeasite LIKE nmea_t.nmeasite, 
   nmeasite_desc LIKE type_t.chr500, 
   nmea017 LIKE nmea_t.nmea017, 
   nmbadocdt LIKE nmba_t.nmbadocdt, 
   nmea001 LIKE nmea_t.nmea001, 
   nmea009 LIKE nmea_t.nmea009, 
   nmea013 LIKE nmea_t.nmea013, 
   nmea008 LIKE nmea_t.nmea008, 
   nmeadocno LIKE nmea_t.nmeadocno, 
   nmeaseq LIKE nmea_t.nmeaseq, 
   nmeacomp LIKE nmea_t.nmeacomp 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input        RECORD 
       nmeasite_1     LIKE nmea_t.nmeasite,
       nmeasite_1_desc  LIKE ooefl_t.ooefl003,
       nmeacomp       LIKE nmea_t.nmeacomp,
       nmeacomp_desc  LIKE ooefl_t.ooefl003,
       stus           LIKE type_t.chr1,
       nmea013        LIKE nmea_t.nmea013,
       nmea019        LIKE nmea_t.nmea019
       END RECORD

 TYPE type_g_nmec_d RECORD
  #151201-00002#19 Mod  ---(S)---
   nmec022       LIKE nmec_t.nmec022,
   nmecsite      LIKE nmec_t.nmecsite,
   nmecsite_desc LIKE type_t.chr500,
   nmec001       LIKE nmec_t.nmec001,
   nmec014       LIKE nmec_t.nmec014,
   nmec007       LIKE nmec_t.nmec007,
   nmec009       LIKE nmec_t.nmec009,
   nmec027       LIKE nmec_t.nmec027,
   nmeccomp      LIKE nmec_t.nmeccomp,
   nmecdocno     LIKE nmec_t.nmecdocno,
   nmecseq       LIKE nmec_t.nmecseq
  #151201-00002#19 Mod  ---(E)---
       END RECORD
DEFINE g_nmec_d              DYNAMIC ARRAY OF type_g_nmec_d
DEFINE g_current_page2       LIKE type_t.num5              #目前所在頁數
DEFINE l_ac2                 LIKE type_t.num10
DEFINE g_sql_bank            STRING                         #160122-00001#4   
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_nmea_d
DEFINE g_master_t                   type_g_nmea_d
DEFINE g_nmea_d          DYNAMIC ARRAY OF type_g_nmea_d
DEFINE g_nmea_d_t        type_g_nmea_d
 
      
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
 
{<section id="anmq562.main" >}
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
   CALL cl_ap_init("anm","")
 
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
   DECLARE anmq562_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmq562_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmq562_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmq562 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmq562_init()   
 
      #進入選單 Menu (="N")
      CALL anmq562_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmq562
      
   END IF 
   
   CLOSE anmq562_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmq562.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION anmq562_init()
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
   CALL cl_set_combo_scc('b_nmea003','8310')
   CALL s_fin_create_account_center_tmp()
   CALL cl_set_comp_visible("apt,exi", FALSE)
   #160122-00001#4 --add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#4 --add--end
   #end add-point
 
   CALL anmq562_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="anmq562.default_search" >}
PRIVATE FUNCTION anmq562_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " nmeacomp = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " nmeadocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " nmeaseq = '", g_argv[03], "' AND "
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
 
{<section id="anmq562.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION anmq562_ui_dialog()
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
      CALL anmq562_b_fill()
   ELSE
      CALL anmq562_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_nmea_d.clear()
 
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
 
         CALL anmq562_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_nmea_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL anmq562_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL anmq562_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_nmec_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2) 
      
            BEFORE DISPLAY 
               LET g_current_page2 = 1
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac2 = g_detail_idx2

         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL anmq562_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION act2
            LET g_action_choice="act2"
            IF cl_auth_chk_act("act2") THEN
               
               #add-point:ON ACTION act2 name="menu.act2"
               CALL cl_set_comp_visible("apt,exi", TRUE)
               CALL anmq562_act2()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION exi
            LET g_action_choice="exi"
            IF cl_auth_chk_act("exi") THEN
               
               #add-point:ON ACTION exi name="menu.exi"
               CALL anmq562_b_fill()
               CALL cl_set_comp_visible("apt,exi", FALSE)
               #END add-point
               
               
            END IF
 
 
 
 
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
               CALL anmq562_query()
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
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION apt
            LET g_action_choice="apt"
            IF cl_auth_chk_act("apt") THEN
               
               #add-point:ON ACTION apt name="menu.apt"
               CALL anmq562_apt()
               CALL cl_set_comp_visible("apt,exi", FALSE)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION act1
            LET g_action_choice="act1"
            IF cl_auth_chk_act("act1") THEN
               
               #add-point:ON ACTION act1 name="menu.act1"
               CALL cl_set_comp_visible("apt,exi", TRUE)
               CALL anmq562_act1()
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL anmq562_filter()
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
            CALL anmq562_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_nmea_d)
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
            CALL anmq562_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL anmq562_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL anmq562_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL anmq562_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_nmea_d.getLength()
               LET g_nmea_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_nmea_d.getLength()
               LET g_nmea_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_nmea_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmea_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_nmea_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmea_d[li_idx].sel = "N"
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
 
{<section id="anmq562.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmq562_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_nmeasite LIKE nmea_t.nmeasite
   DEFINE l_nmeacomp LIKE nmea_t.nmeacomp
   DEFINE l_nmea003_str  STRING
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_wc       STRING   
   DEFINE l_sql      STRING   #160816-00012#4 Add
   DEFINE l_count    LIKE type_t.num5
   DEFINE g_glaald     LIKE glaa_t.glaald
  
   
   #取得預設的資金中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
   CALL s_fin_get_account_center('',g_user,'6',g_today) RETURNING g_sub_success,g_input.nmeasite_1,g_errno
   #法人
   SELECT ooef017 INTO g_input.nmeacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_input.nmeasite_1
   CALL s_desc_get_department_desc(g_input.nmeasite_1) RETURNING g_input.nmeasite_1_desc
   CALL s_desc_get_department_desc(g_input.nmeacomp) RETURNING g_input.nmeacomp_desc
   #160816-00012#4 Add  ---(S)---
   #检查用户是否有资金中心对应法人的权限
   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
   LET l_count = 0
   LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
               "   AND ooef001 = '",g_input.nmeacomp,"'",
               "   AND ooef003 = 'Y'",
               "   AND ",l_wc CLIPPED
   PREPARE anmp410_count_prep FROM l_sql
   EXECUTE anmp410_count_prep INTO l_count
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      LET g_input.nmeacomp = ''
      LET g_input.nmeacomp_desc = ''    
   END IF
   #160816-00012#4 Add  ---(E)---
   LET l_nmea003_str = ''
   LET g_input.stus = '1'
   LET g_input.nmea019 = g_today
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_nmea_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON nmeadocno,nmeaseq,nmeacomp
           FROM s_detail1[1].b_nmeadocno,s_detail1[1].b_nmeaseq,s_detail1[1].b_nmeacomp
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_nmea018>>----
         #----<<b_nmeasite>>----
         #----<<b_nmeasite_desc>>----
         #----<<b_nmea017>>----
         #----<<b_nmbadocdt>>----
         #----<<b_nmea001>>----
         #----<<b_nmea009>>----
         #----<<b_nmea013>>----
         #----<<b_nmea008>>----
         #----<<b_nmeadocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmeadocno
            #add-point:BEFORE FIELD b_nmeadocno name="construct.b.page1.b_nmeadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmeadocno
            
            #add-point:AFTER FIELD b_nmeadocno name="construct.a.page1.b_nmeadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmeadocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmeadocno
            #add-point:ON ACTION controlp INFIELD b_nmeadocno name="construct.c.page1.b_nmeadocno"
            
            #END add-point
 
 
         #----<<b_nmeaseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmeaseq
            #add-point:BEFORE FIELD b_nmeaseq name="construct.b.page1.b_nmeaseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmeaseq
            
            #add-point:AFTER FIELD b_nmeaseq name="construct.a.page1.b_nmeaseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmeaseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmeaseq
            #add-point:ON ACTION controlp INFIELD b_nmeaseq name="construct.c.page1.b_nmeaseq"
            
            #END add-point
 
 
         #----<<b_nmeacomp>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmeacomp
            #add-point:BEFORE FIELD b_nmeacomp name="construct.b.page1.b_nmeacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmeacomp
            
            #add-point:AFTER FIELD b_nmeacomp name="construct.a.page1.b_nmeacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmeacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmeacomp
            #add-point:ON ACTION controlp INFIELD b_nmeacomp name="construct.c.page1.b_nmeacomp"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_input.nmeasite_1,g_input.nmeacomp,g_input.stus,g_input.nmea013,g_input.nmea019
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            DISPLAY BY NAME g_input.nmeasite_1,g_input.nmeasite_1_desc,
                            g_input.nmeacomp,g_input.nmeacomp_desc,g_input.stus
         
         BEFORE FIELD nmeasite_1
            LET l_nmeasite = g_input.nmeasite_1
         
         AFTER FIELD nmeasite_1
            IF NOT cl_null(g_input.nmeasite_1) THEN
               LET g_errno=''
               CALL s_fin_account_center_chk(g_input.nmeasite_1,'','6',g_today) RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_input.nmeasite_1
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_input.nmeasite_1=l_nmeasite
                  CALL s_desc_get_department_desc(g_input.nmeasite_1) RETURNING g_input.nmeasite_1_desc
                  DISPLAY BY NAME g_input.nmeasite_1_desc
                  NEXT FIELD CURRENT
               END IF
               #160816-00012#4 Add  ---(S)---
               #法人
               SELECT ooef017 INTO g_input.nmeacomp
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_input.nmeasite_1  
               #检查用户是否有资金中心对应法人的权限
               CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
               LET l_count = 0
               LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                           "   AND ooef001 = '",g_input.nmeacomp,"'",
                           "   AND ooef003 = 'Y'",
                           "   AND ",l_wc CLIPPED
               PREPARE anmp410_count_prep2 FROM l_sql
               EXECUTE anmp410_count_prep2 INTO l_count
               IF cl_null(l_count) THEN LET l_count = 0 END IF
               IF l_count = 0 THEN
                  LET g_input.nmeacomp = ''           
                  DISPLAY BY NAME g_input.nmeacomp
               END IF
               #160816-00012#4 Add  ---(E)---
            END IF
            CALL s_desc_get_department_desc(g_input.nmeasite_1) RETURNING g_input.nmeasite_1_desc
            DISPLAY BY NAME g_input.nmeasite_1_desc
            
         BEFORE FIELD nmeacomp
            LET l_nmeacomp = g_input.nmeacomp         
            
         AFTER FIELD nmeacomp
            IF NOT cl_null(g_input.nmeacomp) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_input.nmeacomp

               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME
               ELSE
                  #檢查失敗時後續處理
                  LET g_input.nmeacomp=l_nmeacomp
                  CALL s_desc_get_department_desc(g_input.nmeacomp) RETURNING g_input.nmeacomp_desc
                  DISPLAY BY NAME g_input.nmeacomp_desc
                  NEXT FIELD CURRENT
               END IF
               #160816-00012#4 Add  ---(S)---
               #检查用户是否有资金中心对应法人的权限
               #取得帳務組織下所屬成員
               CALL s_fin_account_center_sons_query('6',g_input.nmeasite_1,g_today,'')
               #取得帳務組織下所屬成員之法人   
               CALL s_fin_account_center_comp_str() RETURNING l_wc
               #將取回的字串轉換為SQL條件
               CALL s_fin_get_wc_str(l_wc) RETURNING l_wc
               
               IF NOT cl_null(g_input.nmeasite_1) THEN
                  LET l_count = 0
                  SELECT COUNT(1) INTO l_count
                    FROM ooef_t
                   WHERE ooefent = g_enterprise AND ooef017 = g_input.nmeacomp
                     AND ooef001 = g_input.nmeasite_1
                  IF s_chr_get_index_of(l_wc,g_input.nmeacomp,1) = 0 AND l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-02928'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.nmeacomp = l_nmeacomp 
                     NEXT FIELD CURRENT
                  END IF
               END IF              
               LET l_count = 0
               LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                           "   AND ooef001 = '",g_input.nmeacomp,"'",
                           "   AND ooef003 = 'Y'",
                           "   AND ooef001 IN ",l_wc CLIPPED
               PREPARE anmp410_count_prep1 FROM l_sql
               EXECUTE anmp410_count_prep1 INTO l_count
               IF cl_null(l_count) THEN LET l_count = 0 END IF
               IF l_count = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "ais-00228"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.nmeacomp = l_nmeacomp 
                  NEXT FIELD CURRENT
               END IF
               #160816-00012#4 Add  ---(E)---
            END IF
            CALL s_desc_get_department_desc(g_input.nmeacomp) RETURNING g_input.nmeacomp_desc
            DISPLAY BY NAME g_input.nmeacomp_desc

         AFTER FIELD nmea013
            IF NOT cl_null(g_input.nmea013) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_input.nmea013
               LET g_chkparam.arg2 = g_input.nmeacomp
               #160318-00025#26  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi120",g_lang,"2"),"|:EXEPROGanmi120"
               #160318-00025#26  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmas002_1") THEN
                  #檢查成功時後續處理
                  #160122-00001#4--add---str
                  IF NOT s_anmi120_nmll002_chk(g_input.nmea013,g_user) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_input.nmea013
                     LET g_errparam.code   = 'anm-00574' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  #160122-00001#4--add---end
               ELSE
                  #檢查失敗時後續處理
                  LET g_input.nmea013 = ''
                  NEXT FIELD CURRENT
               END IF

            END IF

         ON ACTION controlp INFIELD nmeasite_1
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.nmeasite_1
            LET g_qryparam.where = " ooef206 = 'Y'"
            #CALL q_ooef001()    #161021-00050#8 mark
            CALL q_ooef001_33()  #161021-00050#8
            LET g_input.nmeasite_1 = g_qryparam.return1
            DISPLAY g_input.nmeasite_1 TO nmeasite_1
            NEXT FIELD nmeasite_1
            
         ON ACTION controlp INFIELD nmeacomp 
            CALL s_fin_account_center_sons_query('6',g_input.nmeasite_1,g_today,'')
            CALL s_fin_account_center_comp_str() RETURNING l_wc
            CALL s_fin_get_wc_str(l_wc) RETURNING l_wc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.nmeacomp
            LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",l_wc CLIPPED
            #CALL q_ooef001()  #161021-00050#8 mark
            CALL q_ooef001_2() #161021-00050#8
            LET g_input.nmeacomp = g_qryparam.return1
            DISPLAY g_input.nmeacomp TO nmeacomp
            NEXT FIELD nmeacomp

         ON ACTION controlp INFIELD nmea013
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.nmea013
            LET g_qryparam.arg1 = g_input.nmeacomp
            #160122-00001#4 -add -str
            LET g_qryparam.where =" nmas002 IN (",g_sql_bank,")"
            #160122-00001#4 -add -end
            CALL q_nmas002() 
            LET g_input.nmea013  = g_qryparam.return1
            DISPLAY g_input.nmea013 TO nmea013
            NEXT FIELD nmea013
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
   CALL anmq562_b_fill()
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
 
{<section id="anmq562.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmq562_b_fill()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',nmea018,nmeasite,'',nmea017,'',nmea001,nmea009,nmea013,nmea008, 
       nmeadocno,nmeaseq,nmeacomp  ,DENSE_RANK() OVER( ORDER BY nmea_t.nmeacomp,nmea_t.nmeadocno,nmea_t.nmeaseq) AS RANK FROM nmea_t", 
 
 
 
                     "",
                     " WHERE nmeaent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("nmea_t"),
                     " ORDER BY nmea_t.nmeacomp,nmea_t.nmeadocno,nmea_t.nmeaseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_wc = " nmeasite = '",g_input.nmeasite_1,"' AND nmeacomp='",g_input.nmeacomp,"' AND (nmea013 = '",g_input.nmea013,"' OR nmea013 IS NULL)"

   CASE
      WHEN g_input.stus = '1'
         LET ls_wc = ls_wc," AND nmea018 = 'N'"
      WHEN g_input.stus = '2'
         LET ls_wc = ls_wc," AND nmea018 = 'Y'"
   END CASE

   LET ls_sql_rank = "SELECT UNIQUE '',nmea018,nmeasite,'',nmea017,'',nmea001,nmea009,nmea013, ",
                     "       nmea008,nmeadocno,nmeaseq,nmeacomp",
                     "  FROM nmea_t,nmba_t",
                     " WHERE nmeaent= ? AND 1=1 AND ", ls_wc CLIPPED,
                     "   AND nmbaent = nmeaent",
                     "   AND nmbadocno = nmeadocno",
                     "   AND nmbacomp = nmeacomp",
                     "   AND nmbastus = 'Y'",
                     " ORDER BY nmea_t.nmeacomp,nmea_t.nmeadocno,nmea_t.nmeaseq"

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
 
   LET g_sql = "SELECT '',nmea018,nmeasite,'',nmea017,'',nmea001,nmea009,nmea013,nmea008,nmeadocno,nmeaseq, 
       nmeacomp",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = ls_sql_rank
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmq562_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmq562_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_nmea_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_nmea_d[l_ac].sel,g_nmea_d[l_ac].nmea018,g_nmea_d[l_ac].nmeasite,g_nmea_d[l_ac].nmeasite_desc, 
       g_nmea_d[l_ac].nmea017,g_nmea_d[l_ac].nmbadocdt,g_nmea_d[l_ac].nmea001,g_nmea_d[l_ac].nmea009, 
       g_nmea_d[l_ac].nmea013,g_nmea_d[l_ac].nmea008,g_nmea_d[l_ac].nmeadocno,g_nmea_d[l_ac].nmeaseq, 
       g_nmea_d[l_ac].nmeacomp
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_nmea_d[l_ac].statepic = cl_get_actipic(g_nmea_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #門店名稱
      CALL s_desc_get_department_desc(g_nmea_d[l_ac].nmeasite) RETURNING g_nmea_d[l_ac].nmeasite_desc
      #收银日期
      SELECT nmbadocdt INTO g_nmea_d[l_ac].nmbadocdt FROM nmba_t WHERE nmbaent = g_enterprise
         AND nmbadocno = g_nmea_d[l_ac].nmeadocno
         AND nmbacomp  = g_input.nmeacomp

      #end add-point
 
      CALL anmq562_detail_show("'1'")      
 
      CALL anmq562_nmea_t_mask()
 
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
   
 
   
   CALL g_nmea_d.deleteElement(g_nmea_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
 
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_nmea_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE anmq562_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL anmq562_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL anmq562_detail_action_trans()
 
   IF g_nmea_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL anmq562_fetch()
   END IF
   
      CALL anmq562_filter_show('nmeadocno','b_nmeadocno')
   CALL anmq562_filter_show('nmeaseq','b_nmeaseq')
   CALL anmq562_filter_show('nmeacomp','b_nmeacomp')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   CALL anmq562_b_fill2()
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq562.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmq562_fetch()
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
 
{<section id="anmq562.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmq562_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_nmea_d[l_ac].nmeasite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_nmea_d[l_ac].nmeasite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmea_d[l_ac].nmeasite_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq562.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION anmq562_filter()
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
      CONSTRUCT g_wc_filter ON nmeadocno,nmeaseq,nmeacomp
                          FROM s_detail1[1].b_nmeadocno,s_detail1[1].b_nmeaseq,s_detail1[1].b_nmeacomp 
 
 
         BEFORE CONSTRUCT
                     DISPLAY anmq562_filter_parser('nmeadocno') TO s_detail1[1].b_nmeadocno
            DISPLAY anmq562_filter_parser('nmeaseq') TO s_detail1[1].b_nmeaseq
            DISPLAY anmq562_filter_parser('nmeacomp') TO s_detail1[1].b_nmeacomp
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_nmea018>>----
         #----<<b_nmeasite>>----
         #----<<b_nmeasite_desc>>----
         #----<<b_nmea017>>----
         #----<<b_nmbadocdt>>----
         #----<<b_nmea001>>----
         #----<<b_nmea009>>----
         #----<<b_nmea013>>----
         #----<<b_nmea008>>----
         #----<<b_nmeadocno>>----
         #Ctrlp:construct.c.filter.page1.b_nmeadocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmeadocno
            #add-point:ON ACTION controlp INFIELD b_nmeadocno name="construct.c.filter.page1.b_nmeadocno"
            
            #END add-point
 
 
         #----<<b_nmeaseq>>----
         #Ctrlp:construct.c.filter.page1.b_nmeaseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmeaseq
            #add-point:ON ACTION controlp INFIELD b_nmeaseq name="construct.c.filter.page1.b_nmeaseq"
            
            #END add-point
 
 
         #----<<b_nmeacomp>>----
         #Ctrlp:construct.c.filter.page1.b_nmeacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmeacomp
            #add-point:ON ACTION controlp INFIELD b_nmeacomp name="construct.c.filter.page1.b_nmeacomp"
            
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
   
      CALL anmq562_filter_show('nmeadocno','b_nmeadocno')
   CALL anmq562_filter_show('nmeaseq','b_nmeaseq')
   CALL anmq562_filter_show('nmeacomp','b_nmeacomp')
 
    
   CALL anmq562_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq562.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION anmq562_filter_parser(ps_field)
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
 
{<section id="anmq562.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION anmq562_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmq562_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq562.insert" >}
#+ insert
PRIVATE FUNCTION anmq562_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmq562.modify" >}
#+ modify
PRIVATE FUNCTION anmq562_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq562.reproduce" >}
#+ reproduce
PRIVATE FUNCTION anmq562_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq562.delete" >}
#+ delete
PRIVATE FUNCTION anmq562_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq562.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION anmq562_detail_action_trans()
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
 
{<section id="anmq562.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION anmq562_detail_index_setting()
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
            IF g_nmea_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_nmea_d.getLength() AND g_nmea_d.getLength() > 0
            LET g_detail_idx = g_nmea_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_nmea_d.getLength() THEN
               LET g_detail_idx = g_nmea_d.getLength()
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
 
{<section id="anmq562.mask_functions" >}
 &include "erp/anm/anmq562_mask.4gl"
 
{</section>}
 
{<section id="anmq562.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查詢銀行帳
# Memo...........:
# Usage..........: CALL anmq562_b_fill2()
#                  RETURNING ---
# Date & Author..: 2015/06/30 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq562_b_fill2()
   DEFINE ls_wc      STRING

   LET ls_wc = " nmecsite = '",g_input.nmeasite_1,"' AND nmeccomp='",g_input.nmeacomp,"' AND (nmec024 = '",g_input.nmea013,"' OR nmec018 IS NULL)"

   CASE
      WHEN g_input.stus = '1'
         LET ls_wc = ls_wc," AND nmec022 = 'N'"
      WHEN g_input.stus = '2'
         LET ls_wc = ls_wc," AND nmec022 = 'Y'"
   END CASE

   CALL g_nmec_d.clear()

   LET g_cnt = l_ac2
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac2 = 1   

   LET g_sql = "SELECT nmec022,nmecsite,'',nmec001,nmec014,nmec007,nmec009,nmec027,nmeccomp,nmecdocno,nmecseq",
               "  FROM nmec_t,nmba_t",
               " WHERE nmecent = '",g_enterprise,"'",
               "   AND nmbaent = nmecent",
               "   AND nmbadocno = nmecdocno",
               "   AND nmbacomp = nmeccomp",
               "   AND nmbastus = 'Y'",
               "   AND ",ls_wc

   PREPARE anmq562_prep FROM g_sql
   DECLARE b_fill2_curs CURSOR FOR anmq562_prep

   FOREACH b_fill2_curs INTO g_nmec_d[l_ac2].*
      #門店名稱
      CALL s_desc_get_department_desc(g_nmec_d[l_ac2].nmecsite) RETURNING g_nmec_d[l_ac2].nmecsite_desc

      LET l_ac2 = l_ac2 + 1
   END FOREACH

   CALL g_nmec_d.deleteElement(g_nmec_d.getLength())   

   LET g_detail_cnt2 = g_nmec_d.getLength()
   LET l_ac2 = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill2_curs
   FREE anmq562_prep
 
END FUNCTION

################################################################################
# Descriptions...: 自动对账
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq562_act1()
   DEFINE l_m         LIKE type_t.num5
   DEFINE l_n         LIKE type_t.num5

   #STEP1.根據流水號對帳
   FOR l_m = 1 TO g_nmea_d.getLength()
      IF g_nmea_d[l_m].nmea018 = 'Y' THEN CONTINUE FOR END IF
      FOR l_n = 1 TO g_nmec_d.getLength()
         IF g_nmec_d[l_n].nmec022 = 'Y' THEN CONTINUE FOR END IF
         IF g_nmea_d[l_m].nmea017 = g_nmec_d[l_n].nmec001 THEN
            LET g_nmea_d[l_m].nmea018 = 'Y'
            LET g_nmec_d[l_m].nmec022 = 'Y'
         END IF
      END FOR
   END FOR

   #STEP1.根據金額號對帳
   FOR l_m = 1 TO g_nmea_d.getLength()
      IF g_nmea_d[l_m].nmea018 = 'Y' THEN CONTINUE FOR END IF
      FOR l_n = 1 TO g_nmec_d.getLength()
         IF g_nmec_d[l_n].nmec022 = 'Y' THEN CONTINUE FOR END IF
         IF g_nmea_d[l_m].nmea009 = g_nmec_d[l_n].nmec027 THEN
            LET g_nmea_d[l_m].nmea018 = 'Y'
            LET g_nmec_d[l_m].nmec022 = 'Y'
         END IF
      END FOR
   END FOR

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq562_act2()
   DEFINE l_nmea018         LIKE nmea_t.nmea018
   DEFINE l_nmec022         LIKE nmec_t.nmec022

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT ARRAY g_nmea_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)

      BEFORE ROW
         LET l_ac = ARR_CURR()
         LET g_current_page = 1

      BEFORE FIELD b_nmea018
         LET l_nmea018 = g_nmea_d[l_ac].nmea018

      AFTER FIELD b_nmea018
         IF NOT cl_null(g_nmea_d[l_ac].nmea018) THEN
            IF l_nmea018 = 'Y' AND g_nmea_d[l_ac].nmea018 = 'N' THEN
               LET g_nmea_d[l_ac].nmea018 = l_nmea018
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00363'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
         END IF

      END INPUT

      INPUT ARRAY g_nmec_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_detail_cnt2,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)

      BEFORE ROW
         LET l_ac2 = ARR_CURR()
         LET g_current_page = 2

      BEFORE FIELD b_nmec022
         LET l_nmec022 = g_nmec_d[l_ac2].nmec022

      AFTER FIELD b_nmec022
         IF NOT cl_null(g_nmec_d[l_ac2].nmec022) THEN
            IF l_nmec022 = 'Y' AND g_nmec_d[l_ac2].nmec022 = 'N' THEN
               LET g_nmec_d[l_ac2].nmec022 = l_nmec022
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00363'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
         END IF

      END INPUT

      ON ACTION accept 
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
   END DIALOG
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq562_apt()
   DEFINE l_m         LIKE type_t.num5
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5

   #錯誤訊息匯總初始化
   CALL cl_err_collect_init()
   CALL s_transaction_begin()
   LET l_success = TRUE

   FOR l_m = 1 TO g_nmea_d.getLength()
      IF g_nmea_d[l_m].nmea018 = 'N' THEN
         UPDATE nmea_t SET nmea018 = 'N',
                           nmea019 = g_input.nmea019
          WHERE nmeaent   = g_enterprise
            AND nmeadocno = g_nmea_d[l_m].nmeadocno
            AND nmeacomp  = g_nmea_d[l_m].nmeacomp
            AND nmeaseq   = g_nmea_d[l_m].nmeaseq
      ELSE
         UPDATE nmea_t SET nmea018 = 'Y',
                           nmea019 = g_input.nmea019
          WHERE nmeaent   = g_enterprise
            AND nmeadocno = g_nmea_d[l_m].nmeadocno
            AND nmeacomp  = g_nmea_d[l_m].nmeacomp
            AND nmeaseq   = g_nmea_d[l_m].nmeaseq
      END IF

   END FOR

   FOR l_n = 1 TO g_nmec_d.getLength()
      IF g_nmec_d[l_n].nmec022 = 'N' THEN
         UPDATE nmec_t SET nmec022 = 'N',
                           nmec026 = g_input.nmea019
          WHERE nmecent   = g_enterprise
            AND nmecdocno = g_nmec_d[l_n].nmecdocno
            AND nmeccomp  = g_nmec_d[l_n].nmeccomp
            AND nmecseq   = g_nmec_d[l_n].nmecseq
      ELSE
         UPDATE nmec_t SET nmec022 = 'Y',
                           nmec026 = g_input.nmea019
          WHERE nmecent   = g_enterprise
            AND nmecdocno = g_nmec_d[l_n].nmecdocno
            AND nmeccomp  = g_nmec_d[l_n].nmeccomp
            AND nmecseq   = g_nmec_d[l_n].nmecseq
      END IF

   END FOR

   IF l_success THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
      CALL cl_err_collect_show()
   END IF

END FUNCTION

 
{</section>}
 
