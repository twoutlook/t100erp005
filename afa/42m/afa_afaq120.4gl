#該程式未解開Section, 採用最新樣板產出!
{<section id="afaq120.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:13(2016-01-08 14:44:27), PR版次:0013(2016-12-14 14:04:29)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000122
#+ Filename...: afaq120
#+ Description: 資產異動明細帳查詢作業
#+ Creator....: 02003(2015-01-14 11:27:46)
#+ Modifier...: 03080 -SD/PR- 01531
 
{</section>}
 
{<section id="afaq120.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#150813apo      2015/08/13 by 03538     修正匯出excel異常
#150908-00002#2 2015/10/02 by RayHuang  新增欄位&XG列印
#151028         151028     By albireo   1.出售未顯示傳票及客戶2.重產前未清空臨時表
#160104-00020#1 160107     By albireo   QBE增加單身異動單號;增加資產名稱 
#160419-00030#1 160421     by 07673     二次篩選沒有功能
#160125-00005#7 2016/08/09 By 01531     查詢時加上帳套人員權限條件過濾
#161031-00005#1 2016/10/31 By 02114     afat421资产部门转移在afaq120中查不到数据
#161111-00049#5 2016/11/16 By 01531     固资栏位过滤
#161214-00022#1 2016/12/14 By 01531     afaq120单身有资料，但未显示
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
PRIVATE TYPE type_g_faah_d RECORD
       #statepic       LIKE type_t.chr1,
       
       faah000 LIKE faah_t.faah000, 
   ooef001 LIKE ooef_t.ooef001, 
   faah003 LIKE faah_t.faah003, 
   faah004 LIKE faah_t.faah004, 
   faah001 LIKE faah_t.faah001, 
   faah012 LIKE faah_t.faah012, 
   fabgld LIKE fabg_t.fabgld, 
   fabgdocdt LIKE fabg_t.fabgdocdt, 
   fabg005 LIKE fabg_t.fabg005, 
   fabhdocno LIKE fabh_t.fabhdocno, 
   fabhseq LIKE fabh_t.fabhseq, 
   fabh007 LIKE fabh_t.fabh007, 
   fabh010 LIKE fabh_t.fabh010, 
   fabh018 LIKE fabh_t.fabh018, 
   demo LIKE type_t.chr500, 
   l_fabh027 LIKE type_t.chr10, 
   l_fabh033 LIKE type_t.chr20, 
   l_fabh005 LIKE type_t.chr10, 
   l_faam013 LIKE type_t.num20_6, 
   l_faam013_2 LIKE type_t.num20_6, 
   l_fabh011 LIKE type_t.num20_6, 
   l_fabh004 LIKE type_t.num20_6, 
   l_fabg008 LIKE type_t.chr20, 
   l_fabh030 LIKE type_t.chr10 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_master2   RECORD 
          fabgsite       LIKE fabg_t.fabgsite,
          fabgsite_desc  LIKE type_t.chr80,
          bdate          LIKE fabg_t.fabgdocdt,
          edate          LIKE fabg_t.fabgdocdt,
          fabgstus       LIKE fabg_t.fabgstus,
          glaa014        LIKE glaa_t.glaa014
                   END RECORD 
DEFINE g_master2_t   RECORD 
          fabgsite       LIKE fabg_t.fabgsite,
          fabgsite_desc  LIKE type_t.chr80,
          bdate          LIKE fabg_t.fabgdocdt,
          edate          LIKE fabg_t.fabgdocdt,
          fabgstus       LIKE fabg_t.fabgstus,
          glaa014        LIKE glaa_t.glaa014
                   END RECORD      
 TYPE type_g_faah2_d RECORD
       faai000    LIKE faai_t.faai000,
       faai001    LIKE faai_t.faai001,
       faai002    LIKE faai_t.faai002,
       faai003    LIKE faai_t.faai003,
       fabhdocno  LIKE fabh_t.fabhdocno,
       fabhseq    LIKE fabh_t.fabhseq,
       faaiseq    LIKE faai_t.faaiseq,
       faai004    LIKE faai_t.faai004,
       faai005    LIKE faai_t.faai005,
       faai006    LIKE faai_t.faai006,
       faai007    LIKE faai_t.faai007,
       faai008    LIKE faai_t.faai008,
       faai015    LIKE faai_t.faai015,
       faai016    LIKE faai_t.faai016,
       faai017    LIKE faai_t.faai017,
       faai018    LIKE faai_t.faai018
       END RECORD
DEFINE g_faah2_d          DYNAMIC ARRAY OF type_g_faah2_d
DEFINE g_faah2_d_t        type_g_faah2_d
DEFINE g_sql2     STRING 
DEFINE g_sql3     STRING 
DEFINE g_sql4     STRING 
DEFINE g_sql5     STRING 
DEFINE g_sql6     STRING 
DEFINE g_sql7     STRING 
DEFINE g_sql8     STRING 
DEFINE g_sql9     STRING 
DEFINE g_sql10    STRING 
DEFINE g_sql11    STRING 
DEFINE g_sql12    STRING 
DEFINE g_sql13    STRING 
DEFINE g_sql14    STRING 
DEFINE g_sql15    STRING 
DEFINE g_sql16    STRING 
DEFINE g_sql17    STRING 
DEFINE g_sql18    STRING 
DEFINE g_sql19    STRING 
DEFINE g_sql27    STRING 
DEFINE g_wc_tmp   STRING   #150908-00002#2 
DEFINE g_wc_cs_orga   STRING      #160125-00005#7
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_faah_d
DEFINE g_master_t                   type_g_faah_d
DEFINE g_faah_d          DYNAMIC ARRAY OF type_g_faah_d
DEFINE g_faah_d_t        type_g_faah_d
 
      
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
 
{<section id="afaq120.main" >}
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
   CALL cl_ap_init("afa","")
 
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
   DECLARE afaq120_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afaq120_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afaq120_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afaq120 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afaq120_init()   
 
      #進入選單 Menu (="N")
      CALL afaq120_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afaq120
      
   END IF 
   
   CLOSE afaq120_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afaq120.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afaq120_init()
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
   
      CALL cl_set_combo_scc('b_fabg005','9910') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('fabgstus','9922')
   CALL cl_set_combo_scc('b_fabg005','9965') 
   CALL cl_set_combo_scc('b_fabh018','9965') 
   CALL afaq120_create_tmp()
   #营运据点范围
   CALL s_axrt300_get_site(g_user,'','1') RETURNING g_wc_cs_orga #160125-00005#7    
   #end add-point
 
   CALL afaq120_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="afaq120.default_search" >}
PRIVATE FUNCTION afaq120_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " faah000 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " faah001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " faah003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " faah004 = '", g_argv[04], "' AND "
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
 
{<section id="afaq120.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION afaq120_ui_dialog()
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
#   LET g_wc = " 1=1"
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL afaq120_b_fill()
   ELSE
      CALL afaq120_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_faah_d.clear()
 
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
 
         CALL afaq120_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_faah_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL afaq120_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL afaq120_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_faah2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2) 
      
            BEFORE DISPLAY 
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               CALL afaq120_b2_fill()
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_faah2_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
            
               
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL afaq120_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #150908-00002#2---s
               CALL afaq120_ins_xg_tmp()
               CALL afaq120_x01("1 = 1","afaq120_xg_tmp")  
               #150908-00002#2---e
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #150908-00002#2---s
               CALL afaq120_ins_xg_tmp()
               CALL afaq120_x01("1 = 1","afaq120_xg_tmp")  
               #150908-00002#2---e
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afaq120_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION afaq120_01
            LET g_action_choice="afaq120_01"
            IF cl_auth_chk_act("afaq120_01") THEN
               
               #add-point:ON ACTION afaq120_01 name="menu.afaq120_01"
               IF g_current_page =1 THEN 
                  IF l_ac > 0 THEN 
                     INITIALIZE la_param.* TO NULL
                     CASE g_faah_d[l_ac].fabg005
                        #资本化afat400
                        WHEN '1'
                           LET la_param.prog = 'afat400'
                           LET la_param.param[1] = g_faah_d[l_ac].fabhdocno
                           
                        #折旧afat509
                        WHEN '2'
                           LET la_param.prog = 'afat509'
                           LET la_param.param[1] = g_faah_d[l_ac].fabgld
                           LET la_param.param[2] = g_faah_d[l_ac].fabhdocno
                        #外送afat440
                        WHEN '3'
                           LET la_param.prog = 'afat440'
                           LET la_param.param[1] = g_faah_d[l_ac].fabhdocno
                        #出售afat504
                        WHEN '5'
                           LET la_param.prog = 'afat504'
                           LET la_param.param[1] = g_faah_d[l_ac].fabgld
                           LET la_param.param[2] = g_faah_d[l_ac].fabhdocno
                        #销帐afat506
                        WHEN '6'
                           LET la_param.prog = 'afat506'
                           LET la_param.param[1] = g_faah_d[l_ac].fabgld
                           LET la_param.param[2] = g_faah_d[l_ac].fabhdocno
                        #折毕再提afat501
                        WHEN '7'
                           LET la_param.prog = 'afat501'
                           LET la_param.param[1] = g_faah_d[l_ac].fabgld
                           LET la_param.param[2] = g_faah_d[l_ac].fabhdocno
                        #停用afat430
                        WHEN '8'
                           LET la_param.prog = 'afat430'
                           LET la_param.param[1] = g_faah_d[l_ac].fabhdocno
                        #重估afat503
                        WHEN '9'
                           LET la_param.prog = 'afat503'
                           LET la_param.param[1] = g_faah_d[l_ac].fabgld
                           LET la_param.param[2] = g_faah_d[l_ac].fabhdocno
                        #合并afat470
                        WHEN '13'
                           LET la_param.prog = 'afat470'
                           LET la_param.param[1] = g_faah_d[l_ac].fabhdocno
                        #分割afat480
                        WHEN '14'
                           LET la_param.prog = 'afat480'
                           LET la_param.param[1] = g_faah_d[l_ac].fabhdocno
                        #减值准备afat502
                        WHEN '15'
                           LET la_param.prog = 'afat502'
                           LET la_param.param[1] = g_faah_d[l_ac].fabgld
                           LET la_param.param[2] = g_faah_d[l_ac].fabhdocno
                        #收回afat450
                        WHEN '16'
                           LET la_param.prog = 'afat450'
                           LET la_param.param[1] = g_faah_d[l_ac].fabhdocno
                        #改良afat508
                        WHEN '18'
                           LET la_param.prog = 'afat508'
                           LET la_param.param[1] = g_faah_d[l_ac].fabgld
                           LET la_param.param[2] = g_faah_d[l_ac].fabhdocno
                        #报废afat507
                        WHEN '19'
                           LET la_param.prog = 'afat507'
                           LET la_param.param[1] = g_faah_d[l_ac].fabgld
                           LET la_param.param[2] = g_faah_d[l_ac].fabhdocno
                     END CASE
                     IF NOT cl_null(g_faah_d[l_ac].fabg005) THEN 
                        LET ls_js = util.JSON.stringify(la_param)
                        CALL cl_cmdrun_wait(ls_js)
                     END IF 
                  END IF
               END IF
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
            CALL afaq120_filter()
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
            CALL afaq120_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_faah_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               #150813apo--s
               LET g_export_node[2] = base.typeInfo.create(g_faah2_d)
               LET g_export_id[2]   = "s_detail2"               
               #150813apo--e
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
            CALL afaq120_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL afaq120_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL afaq120_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL afaq120_b_fill()
 
         
         
 
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
 
{<section id="afaq120.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afaq120_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   CALL afaq120_query_1()
   RETURN 
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_faah_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON faah000,ooef001,faah003,faah004,faah001,faah012,fabgdocdt,fabg005,fabhdocno 
 
           FROM s_detail1[1].b_faah000,s_detail1[1].b_ooef001,s_detail1[1].b_faah003,s_detail1[1].b_faah004, 
               s_detail1[1].b_faah001,s_detail1[1].b_faah012,s_detail1[1].b_fabgdocdt,s_detail1[1].b_fabg005, 
               s_detail1[1].b_fabhdocno
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_faah000>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah000
            #add-point:BEFORE FIELD b_faah000 name="construct.b.page1.b_faah000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah000
            
            #add-point:AFTER FIELD b_faah000 name="construct.a.page1.b_faah000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faah000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah000
            #add-point:ON ACTION controlp INFIELD b_faah000 name="construct.c.page1.b_faah000"
            
            #END add-point
 
 
         #----<<b_ooef001>>----
         #Ctrlp:construct.c.page1.b_ooef001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_ooef001
            #add-point:ON ACTION controlp INFIELD b_ooef001 name="construct.c.page1.b_ooef001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_ooef001  #顯示到畫面上
            NEXT FIELD b_ooef001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_ooef001
            #add-point:BEFORE FIELD b_ooef001 name="construct.b.page1.b_ooef001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_ooef001
            
            #add-point:AFTER FIELD b_ooef001 name="construct.a.page1.b_ooef001"
            
            #END add-point
            
 
 
         #----<<b_faah003>>----
         #Ctrlp:construct.c.page1.b_faah003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah003
            #add-point:ON ACTION controlp INFIELD b_faah003 name="construct.c.page1.b_faah003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faah003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah003  #顯示到畫面上
            NEXT FIELD b_faah003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah003
            #add-point:BEFORE FIELD b_faah003 name="construct.b.page1.b_faah003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah003
            
            #add-point:AFTER FIELD b_faah003 name="construct.a.page1.b_faah003"
            
            #END add-point
            
 
 
         #----<<b_faah004>>----
         #Ctrlp:construct.c.page1.b_faah004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah004
            #add-point:ON ACTION controlp INFIELD b_faah004 name="construct.c.page1.b_faah004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faah004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah004  #顯示到畫面上
            NEXT FIELD b_faah004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah004
            #add-point:BEFORE FIELD b_faah004 name="construct.b.page1.b_faah004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah004
            
            #add-point:AFTER FIELD b_faah004 name="construct.a.page1.b_faah004"
            
            #END add-point
            
 
 
         #----<<b_faah001>>----
         #Ctrlp:construct.c.page1.b_faah001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah001
            #add-point:ON ACTION controlp INFIELD b_faah001 name="construct.c.page1.b_faah001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faah001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah001  #顯示到畫面上
            NEXT FIELD b_faah001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah001
            #add-point:BEFORE FIELD b_faah001 name="construct.b.page1.b_faah001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah001
            
            #add-point:AFTER FIELD b_faah001 name="construct.a.page1.b_faah001"
            
            #END add-point
            
 
 
         #----<<b_faah012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah012
            #add-point:BEFORE FIELD b_faah012 name="construct.b.page1.b_faah012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah012
            
            #add-point:AFTER FIELD b_faah012 name="construct.a.page1.b_faah012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faah012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah012
            #add-point:ON ACTION controlp INFIELD b_faah012 name="construct.c.page1.b_faah012"
            
            #END add-point
 
 
         #----<<b_fabgld>>----
         #----<<b_fabgdocdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_fabgdocdt
            #add-point:BEFORE FIELD b_fabgdocdt name="construct.b.page1.b_fabgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_fabgdocdt
            
            #add-point:AFTER FIELD b_fabgdocdt name="construct.a.page1.b_fabgdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_fabgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fabgdocdt
            #add-point:ON ACTION controlp INFIELD b_fabgdocdt name="construct.c.page1.b_fabgdocdt"
            
            #END add-point
 
 
         #----<<b_fabg005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_fabg005
            #add-point:BEFORE FIELD b_fabg005 name="construct.b.page1.b_fabg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_fabg005
            
            #add-point:AFTER FIELD b_fabg005 name="construct.a.page1.b_fabg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_fabg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fabg005
            #add-point:ON ACTION controlp INFIELD b_fabg005 name="construct.c.page1.b_fabg005"
            
            #END add-point
 
 
         #----<<b_fabhdocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_fabhdocno
            #add-point:BEFORE FIELD b_fabhdocno name="construct.b.page1.b_fabhdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_fabhdocno
            
            #add-point:AFTER FIELD b_fabhdocno name="construct.a.page1.b_fabhdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_fabhdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fabhdocno
            #add-point:ON ACTION controlp INFIELD b_fabhdocno name="construct.c.page1.b_fabhdocno"
            
            #END add-point
 
 
         #----<<b_fabhseq>>----
         #----<<b_fabh007>>----
         #----<<b_fabh010>>----
         #----<<b_fabh018>>----
         #----<<b_demo>>----
         #----<<l_fabh027>>----
         #----<<l_fabh033>>----
         #----<<l_fabh005>>----
         #----<<l_faam013>>----
         #----<<l_faam013_2>>----
         #----<<l_fabh011>>----
         #----<<l_fabh004>>----
         #----<<l_fabg008>>----
         #----<<l_fabh030>>----
   
       
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
   CALL afaq120_b_fill()
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
 
{<section id="afaq120.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afaq120_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   CALL afaq120_b_fill_1()
   RETURN 
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
 
   LET ls_sql_rank = "SELECT  UNIQUE faah000,'',faah003,faah004,faah001,faah012,'','','','','','','', 
       '','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY faah_t.faah000,faah_t.faah001, 
       faah_t.faah003,faah_t.faah004) AS RANK FROM faah_t",
 
 
                     "",
                     " WHERE faahent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("faah_t"),
                     " ORDER BY faah_t.faah000,faah_t.faah001,faah_t.faah003,faah_t.faah004"
 
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
 
   LET g_sql = "SELECT faah000,'',faah003,faah004,faah001,faah012,'','','','','','','','','','','','', 
       '','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afaq120_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afaq120_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_faah_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_faah_d[l_ac].faah000,g_faah_d[l_ac].ooef001,g_faah_d[l_ac].faah003,g_faah_d[l_ac].faah004, 
       g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah012,g_faah_d[l_ac].fabgld,g_faah_d[l_ac].fabgdocdt, 
       g_faah_d[l_ac].fabg005,g_faah_d[l_ac].fabhdocno,g_faah_d[l_ac].fabhseq,g_faah_d[l_ac].fabh007, 
       g_faah_d[l_ac].fabh010,g_faah_d[l_ac].fabh018,g_faah_d[l_ac].demo,g_faah_d[l_ac].l_fabh027,g_faah_d[l_ac].l_fabh033, 
       g_faah_d[l_ac].l_fabh005,g_faah_d[l_ac].l_faam013,g_faah_d[l_ac].l_faam013_2,g_faah_d[l_ac].l_fabh011, 
       g_faah_d[l_ac].l_fabh004,g_faah_d[l_ac].l_fabg008,g_faah_d[l_ac].l_fabh030
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_faah_d[l_ac].statepic = cl_get_actipic(g_faah_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL afaq120_detail_show("'1'")      
 
      CALL afaq120_faah_t_mask()
 
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
   
 
   
   CALL g_faah_d.deleteElement(g_faah_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_faah_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE afaq120_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL afaq120_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL afaq120_detail_action_trans()
 
   IF g_faah_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL afaq120_fetch()
   END IF
   
      CALL afaq120_filter_show('faah000','b_faah000')
   CALL afaq120_filter_show('ooef001','b_ooef001')
   CALL afaq120_filter_show('faah003','b_faah003')
   CALL afaq120_filter_show('faah004','b_faah004')
   CALL afaq120_filter_show('faah001','b_faah001')
   CALL afaq120_filter_show('faah012','b_faah012')
   CALL afaq120_filter_show('fabgdocdt','b_fabgdocdt')
   CALL afaq120_filter_show('fabg005','b_fabg005')
   CALL afaq120_filter_show('fabhdocno','b_fabhdocno')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afaq120.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afaq120_fetch()
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
 
{<section id="afaq120.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afaq120_detail_show(ps_page)
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
 
{<section id="afaq120.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afaq120_filter()
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
      CONSTRUCT g_wc_filter ON faah000,ooef001,faah003,faah004,faah001,faah012,fabgdocdt,fabg005,fabhdocno 
 
                          FROM s_detail1[1].b_faah000,s_detail1[1].b_ooef001,s_detail1[1].b_faah003, 
                              s_detail1[1].b_faah004,s_detail1[1].b_faah001,s_detail1[1].b_faah012,s_detail1[1].b_fabgdocdt, 
                              s_detail1[1].b_fabg005,s_detail1[1].b_fabhdocno
 
         BEFORE CONSTRUCT
                     DISPLAY afaq120_filter_parser('faah000') TO s_detail1[1].b_faah000
            DISPLAY afaq120_filter_parser('ooef001') TO s_detail1[1].b_ooef001
            DISPLAY afaq120_filter_parser('faah003') TO s_detail1[1].b_faah003
            DISPLAY afaq120_filter_parser('faah004') TO s_detail1[1].b_faah004
            DISPLAY afaq120_filter_parser('faah001') TO s_detail1[1].b_faah001
            DISPLAY afaq120_filter_parser('faah012') TO s_detail1[1].b_faah012
            DISPLAY afaq120_filter_parser('fabgdocdt') TO s_detail1[1].b_fabgdocdt
            DISPLAY afaq120_filter_parser('fabg005') TO s_detail1[1].b_fabg005
            DISPLAY afaq120_filter_parser('fabhdocno') TO s_detail1[1].b_fabhdocno
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_faah000>>----
         #Ctrlp:construct.c.filter.page1.b_faah000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah000
            #add-point:ON ACTION controlp INFIELD b_faah000 name="construct.c.filter.page1.b_faah000"
            
            #END add-point
 
 
         #----<<b_ooef001>>----
         #Ctrlp:construct.c.page1.b_ooef001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_ooef001
            #add-point:ON ACTION controlp INFIELD b_ooef001 name="construct.c.filter.page1.b_ooef001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_ooef001  #顯示到畫面上
            NEXT FIELD b_ooef001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_faah003>>----
         #Ctrlp:construct.c.page1.b_faah003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah003
            #add-point:ON ACTION controlp INFIELD b_faah003 name="construct.c.filter.page1.b_faah003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faah003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah003  #顯示到畫面上
            NEXT FIELD b_faah003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_faah004>>----
         #Ctrlp:construct.c.page1.b_faah004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah004
            #add-point:ON ACTION controlp INFIELD b_faah004 name="construct.c.filter.page1.b_faah004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faah004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah004  #顯示到畫面上
            NEXT FIELD b_faah004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_faah001>>----
         #Ctrlp:construct.c.page1.b_faah001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah001
            #add-point:ON ACTION controlp INFIELD b_faah001 name="construct.c.filter.page1.b_faah001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faah001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah001  #顯示到畫面上
            NEXT FIELD b_faah001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_faah012>>----
         #Ctrlp:construct.c.filter.page1.b_faah012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah012
            #add-point:ON ACTION controlp INFIELD b_faah012 name="construct.c.filter.page1.b_faah012"
            
            #END add-point
 
 
         #----<<b_fabgld>>----
         #----<<b_fabgdocdt>>----
         #Ctrlp:construct.c.filter.page1.b_fabgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fabgdocdt
            #add-point:ON ACTION controlp INFIELD b_fabgdocdt name="construct.c.filter.page1.b_fabgdocdt"
            
            #END add-point
 
 
         #----<<b_fabg005>>----
         #Ctrlp:construct.c.filter.page1.b_fabg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fabg005
            #add-point:ON ACTION controlp INFIELD b_fabg005 name="construct.c.filter.page1.b_fabg005"
            
            #END add-point
 
 
         #----<<b_fabhdocno>>----
         #Ctrlp:construct.c.filter.page1.b_fabhdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fabhdocno
            #add-point:ON ACTION controlp INFIELD b_fabhdocno name="construct.c.filter.page1.b_fabhdocno"
          #albireo #160104-00020#1-----s
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c' 
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.where = "fabgdocdt BETWEEN '",g_master2.bdate,"' AND '",g_master2.edate,"' "
             CALL q_fabgdocno_1()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO b_fabhdocno  #顯示到畫面上
             NEXT FIELD b_fabhdocno
          #albireo #160104-00020#1-----e
            #END add-point
 
 
         #----<<b_fabhseq>>----
         #----<<b_fabh007>>----
         #----<<b_fabh010>>----
         #----<<b_fabh018>>----
         #----<<b_demo>>----
         #----<<l_fabh027>>----
         #----<<l_fabh033>>----
         #----<<l_fabh005>>----
         #----<<l_faam013>>----
         #----<<l_faam013_2>>----
         #----<<l_fabh011>>----
         #----<<l_fabh004>>----
         #----<<l_fabg008>>----
         #----<<l_fabh030>>----
   
 
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
   
      CALL afaq120_filter_show('faah000','b_faah000')
   CALL afaq120_filter_show('ooef001','b_ooef001')
   CALL afaq120_filter_show('faah003','b_faah003')
   CALL afaq120_filter_show('faah004','b_faah004')
   CALL afaq120_filter_show('faah001','b_faah001')
   CALL afaq120_filter_show('faah012','b_faah012')
   CALL afaq120_filter_show('fabgdocdt','b_fabgdocdt')
   CALL afaq120_filter_show('fabg005','b_fabg005')
   CALL afaq120_filter_show('fabhdocno','b_fabhdocno')
 
    
   CALL afaq120_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="afaq120.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afaq120_filter_parser(ps_field)
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
 
{<section id="afaq120.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afaq120_filter_show(ps_field,ps_object)
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
   LET ls_condition = afaq120_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afaq120.insert" >}
#+ insert
PRIVATE FUNCTION afaq120_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afaq120.modify" >}
#+ modify
PRIVATE FUNCTION afaq120_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afaq120.reproduce" >}
#+ reproduce
PRIVATE FUNCTION afaq120_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afaq120.delete" >}
#+ delete
PRIVATE FUNCTION afaq120_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afaq120.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION afaq120_detail_action_trans()
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
 
{<section id="afaq120.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION afaq120_detail_index_setting()
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
            IF g_faah_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_faah_d.getLength() AND g_faah_d.getLength() > 0
            LET g_detail_idx = g_faah_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_faah_d.getLength() THEN
               LET g_detail_idx = g_faah_d.getLength()
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
 
{<section id="afaq120.mask_functions" >}
 &include "erp/afa/afaq120_mask.4gl"
 
{</section>}
 
{<section id="afaq120.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查詢
# Memo...........:
# Usage..........: CALL afaq120_query_1()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/01/14 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq120_query_1()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   DEFINE l_success  LIKE type_t.chr1
   DEFINE l_origin_str  STRING
   DEFINE l_ld_str    STRING  #161111-00049#5 
   DEFINE l_comp_str  STRING  #161111-00049#5 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_faah_d.clear()
   CALL g_faah2_d.clear()
   LET g_wc_filter = " 1=1"
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac
   INITIALIZE g_master2.* TO NULL 
   INITIALIZE g_master2_t.* TO NULL 
   LET g_master2.glaa014 = 'Y'
   LET g_master2.fabgsite = g_site
   LET g_master2.bdate = g_today
   LET g_master2.edate = g_today
   LET g_master2.fabgstus = '1'
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT BY NAME g_master2.fabgsite,g_master2.bdate,g_master2.edate,g_master2.fabgstus,g_master2.glaa014
       ATTRIBUTE(WITHOUT DEFAULTS)
      
          BEFORE INPUT    
             CALL afaq120_get_fabgsite_desc()
             DISPLAY BY NAME g_master2.fabgsite,g_master2.fabgsite_desc,g_master2.bdate,g_master2.edate,
                             g_master2.fabgstus,g_master2.glaa014
         
          AFTER FIELD fabgsite
             #150908-00002#2---s
             LET g_master2.fabgsite_desc = ''
             DISPLAY BY NAME g_master2.fabgsite_desc
             #150908-00002#2---e
             IF NOT cl_null(g_master2.fabgsite) THEN 
                 #检查组织资料的合理性
                IF NOT s_afat502_site_chk(g_master2.fabgsite) THEN
                   LET g_master2.fabgsite = g_master2_t.fabgsite
                   CALL afaq120_get_fabgsite_desc()
                   DISPLAY BY NAME g_master2.fabgsite
                   NEXT FIELD CURRENT
                END IF
                #user需要檢查和資產中心的權限
                IF NOT s_afat502_site_user_chk(g_master2.fabgsite,g_user) THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = g_errno
                   LET g_errparam.extend = g_master2.fabgsite
                   LET g_errparam.popup = FALSE
                   CALL cl_err()
                   LET g_master2.fabgsite = g_master2_t.fabgsite
                   CALL afaq120_get_fabgsite_desc()
                   DISPLAY BY NAME g_master2.fabgsite
                   NEXT FIELD CURRENT  
                END IF
                CALL afaq120_get_fabgsite_desc()
             ELSE
                CALL afaq120_get_fabgsite_desc()
                DISPLAY BY NAME g_master2.fabgsite
             END IF 
              
           ON ACTION controlp INFIELD fabgsite
	           INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
	           LET g_qryparam.reqry = FALSE
              LET g_qryparam.default1 = g_master2.fabgsite      #給予default值
              LET g_qryparam.where = " ooef207 = 'Y' "
              #160426-00014#33--mark--str--lujh
              ##160125-00005#7--add--str--
              #IF NOT cl_null(g_wc_cs_orga) THEN
			     #   LET g_qryparam.where = g_wc_cs_orga
			     #END IF
			     ##160125-00005#7--add--end     
              #160426-00014#33--mark--end--lujh			     
              CALL q_ooef001() 
              LET g_master2.fabgsite = g_qryparam.return1       #將開窗取得的值回傳到變數
              DISPLAY g_master2.fabgsite TO fabgsite             #顯示到畫面上
              CALL afaq120_get_fabgsite_desc()
              NEXT FIELD fabgsite                              #返回原欄位  
         
         AFTER INPUT
     
      END INPUT
      #單身根據table分拆construct
      CONSTRUCT g_wc ON ooef001,faah001,faah003,faah004
           FROM s_detail1[1].b_ooef001,s_detail1[1].b_faah001,s_detail1[1].b_faah003,s_detail1[1].b_faah004                
         BEFORE CONSTRUCT
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_faah001
            #add-point:ON ACTION controlp INFIELD b_faah001
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
			   #161111-00049#5 add s--- 
            IF NOT cl_null(g_master2.fabgsite) THEN 
               CALL s_fin_create_account_center_tmp()
               CALL s_fin_account_center_sons_query('5',g_master2.fabgsite,g_today,'1')
               CALL s_fin_account_center_comp_str()RETURNING l_origin_str
               CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
               LET g_qryparam.where = " faah032 IN(",l_origin_str CLIPPED,") "
            END IF 
			   #161111-00049#5 add e---              
            CALL q_faah001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah001  #顯示到畫面上
            NEXT FIELD b_faah001                     #返回原欄位

          ON ACTION controlp INFIELD b_ooef001
	          INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
	          LET g_qryparam.reqry = FALSE	          
             IF NOT cl_null(g_master2.fabgsite) THEN 
                CALL s_fin_create_account_center_tmp()
                CALL s_fin_account_center_sons_query('5',g_master2.fabgsite,g_today,'1')
                CALL s_fin_account_center_comp_str()RETURNING l_origin_str
                CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
                LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN(",l_origin_str CLIPPED,") "
             END IF
#             CALL q_ooef001()  #161111-00049#5 mark
             CALL q_ooef001_2() #161111-00049#5 add
                                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO b_ooef001
             NEXT FIELD b_ooef001                          #返回原欄位  

         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_faah003
            #add-point:ON ACTION controlp INFIELD b_faah003
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
			   #161111-00049#5 add s--- 
            IF NOT cl_null(g_master2.fabgsite) THEN 
               CALL s_fin_create_account_center_tmp()
               CALL s_fin_account_center_sons_query('5',g_master2.fabgsite,g_today,'1')
               CALL s_fin_account_center_comp_str()RETURNING l_origin_str
               CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
               LET g_qryparam.where = " faah032 IN(",l_origin_str CLIPPED,") "
            END IF 
			   #161111-00049#5 add e---            
            CALL q_faah003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah003  #顯示到畫面上
            NEXT FIELD b_faah003                     #返回原欄位
    
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_faah004
            #add-point:ON ACTION controlp INFIELD b_faah004
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " faah004 IS NOT NULL OR faah004 <> ' ' "
			   #161111-00049#5 add s--- 
            IF NOT cl_null(g_master2.fabgsite) THEN 
               CALL s_fin_create_account_center_tmp()
               CALL s_fin_account_center_sons_query('5',g_master2.fabgsite,g_today,'1')
               CALL s_fin_account_center_comp_str()RETURNING l_origin_str
               CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
               LET g_qryparam.where = " faah032 IN(",l_origin_str CLIPPED,") "
            END IF 
			   #161111-00049#5 add e---             
            CALL q_faah004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah004  #顯示到畫面上
            NEXT FIELD b_faah004                     #返回原欄位
       
      END CONSTRUCT
      #150908-00002#2---s
      CONSTRUCT g_wc_tmp ON fabgdocdt,fabg005,
                            fabhdocno   #160104-00020#1
           FROM s_detail1[1].b_fabgdocdt,s_detail1[1].b_fabg005,
                s_detail1[1].b_fabhdocno    #160104-00020#1
         BEFORE CONSTRUCT
         
         
          #albireo #160104-00020#1-----s
          ON ACTION controlp INFIELD b_fabhdocno
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c' 
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.where = "fabgdocdt BETWEEN '",g_master2.bdate,"' AND '",g_master2.edate,"' "
             CALL q_fabgdocno_1()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO b_fabhdocno  #顯示到畫面上
             NEXT FIELD b_fabhdocno
          #albireo #160104-00020#1-----e
      #150908-00002#2---e   
      END CONSTRUCT
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
 
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
 
 
   END DIALOG
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
      RETURN 
   ELSE
      LET g_master_idx = 1
   END IF
   LET g_error_show = 1
   
   CALL afaq120_ins_tmp()
   CALL afaq120_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
END FUNCTION

################################################################################
# Descriptions...: 資產中心名稱
# Memo...........:
# Usage..........: CALL afaq120_get_fabgsite_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/01/14 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq120_get_fabgsite_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master2.fabgsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master2.fabgsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master2.fabgsite_desc
END FUNCTION

################################################################################
# Descriptions...: 填充单身
# Memo...........:
# Usage..........: CALL afaq120_b_fill_1()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/01/15 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq120_b_fill_1()
   DEFINE l_faah001   LIKE faah_t.faah001
   DEFINE l_faah003   LIKE faah_t.faah003
   DEFINE l_faah004   LIKE faah_t.faah004
   DEFINE l_glav006   LIKE glav_t.glav006                     #150908-00002#2 add
   DEFINE l_year      LIKE type_t.chr20                       #150908-00002#2 add
   DEFINE l_ld_str      STRING  #160125-00005#7
   DEFINE l_origin_str  STRING  #160125-00005#7 
   DEFINE l_comp_str    STRING  #161111-00049#5
   #160125-00005#7 add s---
   CALL s_fin_create_account_center_tmp()   
   #取得资产組織下所屬成員
   CALL s_fin_account_center_sons_query('5',g_master2.fabgsite,g_today,'1')
   #取得资产中心下所屬成員之帳別   
   CALL s_fin_account_center_comp_str() RETURNING l_origin_str
   #將取回的字串轉換為SQL條件
   CALL s_fin_get_wc_str(l_origin_str) RETURNING l_origin_str
   LET l_origin_str=l_origin_str.substring(3,l_origin_str.getLength()-2)
   #账套范围
   CALL s_axrt300_get_site(g_user,l_origin_str,'2')  RETURNING l_ld_str 
   IF NOT cl_null(l_ld_str) THEN   
      LET l_ld_str = cl_replace_str(l_ld_str,"glaald","fabgld")
   END IF
   #160125-00005#7 add e---
#   #161214-00022#1 mark s---
#   #161111-00049#5 add s---
#   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
#   LET l_comp_str = cl_replace_str(l_comp_str,"ooef017","faah032") 
#   #161111-00049#5 add e---   
#   #161214-00022#1 mark e---
   #160104-00020-----s
   #LET g_sql = "SELECT  * FROM afaq120_tmp WHERE ",g_wc_tmp,  #150908-00002#2 add g_wc_tmp
   LET g_sql = "SELECT faah000,ooef001,faah003,faah004,faah001,",
               "       faah012,fabgld,fabgdocdt,fabg005,fabhdocno,",
               "       fabhseq,fabh007,fabh010,fabh018,demo,",
               "       fabh027,fabh033,fabh005,faam013,faam013_2,",
               "       fabh011,fabh004,fabg008,fabh030 ",
               "  FROM afaq120_tmp ",
               " WHERE ",g_wc_tmp,
               " AND   ",g_wc_filter,    #160419-00030#1 add 
   #160104-00020-----e
               " AND ",l_ld_str, #160125-00005#7
               #" AND ",l_comp_str, #161111-00049#5 #161214-00022#1 mark
               " ORDER BY faah003,faah004,faah001,fabhdocno,fabhseq "
  
   PREPARE afaq120_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR afaq120_pb2
   CALL g_faah_d.clear()
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
   
   FOREACH b_fill_curs2 INTO g_faah_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
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
      #150908-00002#2---s
      LET l_glav006 = ''
      LET l_year  = YEAR(g_faah_d[l_ac].fabgdocdt)
      SELECT glav006 INTO l_glav006
        FROM glaa_t,glav_t
       WHERE glaaent = glavent AND glav001 = glaa003 AND glaald = g_faah_d[l_ac].fabgld
         AND glav002 = l_year AND glav004 = g_faah_d[l_ac].fabgdocdt
      #本期提列折舊
      SELECT SUM(faam013) INTO g_faah_d[l_ac].l_faam013
        FROM faam_t
       WHERE faament = g_enterprise AND faam001 = g_faah_d[l_ac].faah003
         AND faam002 = g_faah_d[l_ac].faah004 AND faam000 = g_faah_d[l_ac].faah001
         AND faamld  = g_faah_d[l_ac].fabgld AND faam004 = l_year
         AND faam005 = l_glav006
      IF l_glav006 = '1' THEN
          LET l_year = l_year - 1
          SELECT MAX(glav006) INTO l_glav006
            FROM glaa_t,glav_t
           WHERE glaaent = glavent AND glav001 = glaa003 AND glaald = g_faah_d[l_ac].fabgld
             AND glav002 = l_year  AND glav004 = g_faah_d[l_ac].fabgdocdt
      END IF
      #前期提列折舊
      SELECT SUM(faam013) INTO g_faah_d[l_ac].l_faam013_2
        FROM faam_t
       WHERE faament = g_enterprise AND faam001 = g_faah_d[l_ac].faah003
         AND faam002 = g_faah_d[l_ac].faah004 AND faam000 = g_faah_d[l_ac].faah001
         AND faamld  = g_faah_d[l_ac].fabgld  AND faam004 = l_year
         AND faam005 = l_glav006
      
      IF cl_null(g_faah_d[l_ac].l_faam013)   THEN LET g_faah_d[l_ac].l_faam013 = 0   END IF
      IF cl_null(g_faah_d[l_ac].l_faam013_2) THEN LET g_faah_d[l_ac].l_faam013_2 = 0 END IF
      IF cl_null(g_faah_d[l_ac].l_fabh011)   THEN LET g_faah_d[l_ac].l_fabh011 = 0   END IF
      IF cl_null(g_faah_d[l_ac].l_fabh004)   THEN LET g_faah_d[l_ac].l_fabh004 = 0   END IF
      
      
      #150908-00002#2---e
      LET l_ac = l_ac + 1
   END FOREACH
   LET g_error_show = 0
   CALL g_faah_d.deleteElement(g_faah_d.getLength())
   LET g_detail_cnt = g_faah_d.getLength()
#   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET g_tot_cnt = g_faah_d.getLength()
   DISPLAY g_tot_cnt TO FORMONLY.h_count
   LET l_ac = 1
   #填充单身二
   CALL afaq120_b2_fill()
END FUNCTION

################################################################################
# Descriptions...: 单身二填充
# Memo...........:
# Usage..........: CALL afaq120_b2_fill()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/01/18 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq120_b2_fill()
   LET g_sql = " SELECT DISTINCT faah000,faah001,faah003,faah004,fabhdocno,fabhseq,faaiseq,faai004,",
               "        faai005,faai006,faai007,faai008,faai015,faai016,faai017,faai018",
               "   FROM afaq120_tmp,faai_t ",
               "  WHERE faah000 = faai000 AND ",g_wc_tmp,   #150908-00002#2 add g_wc_tmp
               "    AND faaient = '",g_enterprise,"'",
               "    AND faai001 = faah001 ",
               "    AND faai002 = faah003 ",
               "    AND faai003 = faah004 ",
               " ORDER BY fabhdocno,fabhseq,faaiseq"
   PREPARE afaq120_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR afaq120_pb3
   CALL g_faah2_d.clear()
 
   LET g_cnt = 1   
   
   FOREACH b_fill_curs3 INTO g_faah2_d[g_cnt].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
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
      LET g_cnt = g_cnt + 1
      
   END FOREACH
   CALL g_faah2_d.deleteElement(g_faah2_d.getLength())
   LET g_detail_cnt2 = g_faah2_d.getLength()
END FUNCTION

################################################################################
# Descriptions...: 建立临时表
# Memo...........:
# Usage..........: CALL afaq120_create_tmp()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/01/15 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq120_create_tmp()
   WHENEVER ERROR CONTINUE
   DROP TABLE afaq120_tmp;
   CREATE TEMP TABLE afaq120_tmp (
      faah000        VARCHAR(10),
      ooef001        VARCHAR(10),
      faah003        VARCHAR(20),
      faah004        VARCHAR(20),
      faah001        VARCHAR(10),
      fabgld         VARCHAR(10),
      fabgdocdt      DATE,
      fabg005        INTEGER,
      fabhdocno      VARCHAR(20),
      fabhseq        INTEGER,
      fabh007        INTEGER,
      fabh010        DECIMAL(20,6),
      fabh018        INTEGER,
      demo           VARCHAR(500),
      #150908-00002#2---add start
      fabh027        VARCHAR(10), 
      fabh033        VARCHAR(20), 
      faah012        VARCHAR(255), 
      fabh005        VARCHAR(10), 
      faam013        DECIMAL(20,6), 
      faam013_2      DECIMAL(20,6), 
      fabh011        DECIMAL(20,6), 
      fabh004        DECIMAL(20,6), 
      fabg008        VARCHAR(20), 
      fabh030        VARCHAR(10)
      #150908-00002#2---add end
      );

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create afaq120_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   #150908-00002#2---add start
   DROP TABLE afaq120_xg_tmp;
   CREATE TEMP TABLE afaq120_xg_tmp (
      faah000        VARCHAR(10),
      ooef001        VARCHAR(10),
      faah003        VARCHAR(20),
      faah004        VARCHAR(20),
      faah001        VARCHAR(10),
      fabgld         VARCHAR(10),
      fabgdocdt      DATE,
      fabg005        VARCHAR(500),
      fabhdocno      VARCHAR(20),
      fabhseq        INTEGER,
      fabh007        INTEGER,
      fabh010        DECIMAL(20,6),
      fabh018        VARCHAR(500),
      demo           VARCHAR(500),
      fabh027        VARCHAR(10), 
      fabh033        VARCHAR(20), 
      faah012        VARCHAR(255), 
      fabh005        VARCHAR(10), 
      faam013        DECIMAL(20,6), 
      faam013_2      DECIMAL(20,6), 
      fabh011        DECIMAL(20,6), 
      fabh004        DECIMAL(20,6), 
      fabg008        VARCHAR(20), 
      fabh030        VARCHAR(10),
      fabgsite       VARCHAR(500),
      l_fabgdocdt    VARCHAR(500),
      fabgstus       VARCHAR(500),      
      glaa014        VARCHAR(500)
      #150908-00002#2---add end
      );
END FUNCTION

################################################################################
# Descriptions...: 插入临时表
# Memo...........:
# Usage..........: CALL afaq120_ins_tmp()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/01/15 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq120_ins_tmp()
   DEFINE l_tmp   RECORD 
      faah000       LIKE faah_t.faah000,
      ooef001       LIKE ooef_t.ooef001,
      faah003       LIKE faah_t.faah003,
      faah004       LIKE faah_t.faah004,
      faah001       LIKE faah_t.faah001,
      fabgld        LIKE type_t.chr10,
      fabgdocdt     LIKE fabg_t.fabgdocdt,
      fabg005       LIKE fabg_t.fabg005,
      fabhdocno     LIKE fabh_t.fabhdocno,
      fabhseq       LIKE fabh_t.fabhseq,
      fabh007       LIKE fabh_t.fabh007,
      fabh010       LIKE fabh_t.fabh010,
      fabh018       LIKE fabh_t.fabh018,
      demo          LIKE type_t.chr500,
      #150908-00002#2---add start
      fabh027       LIKE fabh_t.fabh027, 
      fabh033       LIKE fabh_t.fabh033, 
      faah012       LIKE faah_t.faah012, 
      fabh005       LIKE fabh_t.fabh005, 
      faam013       LIKE type_t.num20_6, 
      faam013_2     LIKE type_t.num20_6, 
      fabh011       LIKE type_t.num20_6, 
      fabh004       LIKE type_t.num20_6, 
      fabg008       LIKE type_t.chr20, 
      fabh030       LIKE type_t.chr10 
      #150908-00002#2---add end
                  END RECORD 
#   DEFINE l_fabk007 LIKE fabk_t.fabk007  
   DEFINE l_fabn004 LIKE fabn_t.fabn004
   DEFINE l_fabn005 LIKE fabn_t.fabn005
   DEFINE l_fabn018 LIKE fabn_t.fabn018
   DEFINE l_ooef001 LIKE ooef_t.ooef001
#   DEFINE l_fabo019 LIKE fabo_t.fabo019
#   DEFINE l_fabo020 LIKE fabo_t.fabo020
#   DEFINE l_fabo025 LIKE fabo_t.fabo025
#   DEFINE l_fabh011 LIKE fabh_t.fabh011
#   DEFINE l_fabh015 LIKE fabh_t.fabh015
#   DEFINE l_fabh017 LIKE fabh_t.fabh017
#   DEFINE l_fabb007 LIKE fabb_t.fabb007
#   DEFINE l_fabd007 LIKE fabd_t.fabd007
#   DEFINE l_fabd010 LIKE fabd_t.fabd010
#   DEFINE l_fabk005 LIKE fabk_t.fabk005
#   DEFINE l_fabk006 LIKE fabk_t.fabk006
#   DEFINE l_fabh012 LIKE fabh_t.fabh012
#   DEFINE l_fabh014 LIKE fabh_t.fabh014
#   DEFINE l_fabh016 LIKE fabh_t.fabh016
   DEFINE l_faah003 LIKE faah_t.faah003
   DEFINE l_faah004 LIKE faah_t.faah004
   DEFINE l_faah001 LIKE faah_t.faah001
   DEFINE l_fabh007 LIKE fabh_t.fabh007
   DEFINE l_fabh010 LIKE fabh_t.fabh010
   DEFINE l_fabk007 LIKE type_t.num10
   DEFINE l_fabo019 LIKE type_t.num10
   DEFINE l_fabo020 LIKE type_t.num10
   DEFINE l_fabo025 LIKE type_t.num10
   DEFINE l_fabh011 LIKE type_t.num10
   DEFINE l_fabh015 LIKE type_t.num10
   DEFINE l_fabh017 LIKE type_t.num10
   DEFINE l_fabb007 LIKE type_t.num10
   DEFINE l_fabd007 LIKE type_t.num10
   DEFINE l_fabd010 LIKE type_t.num10
   DEFINE l_fabk005 LIKE type_t.num10
   DEFINE l_fabk006 LIKE type_t.num10
   DEFINE l_fabh012 LIKE type_t.num10
   DEFINE l_fabh014 LIKE type_t.num10
   DEFINE l_fabh016 LIKE type_t.num10
   DEFINE l_fabh018 LIKE fabh_t.fabh018
   DEFINE l_fabh004 LIKE fabh_t.fabh004   #150908-00002#2---add
   DEFINE l_msg     LIKE fabh_t.fabhdocno
   DEFINE l_str        STRING
   DEFINE l_str1       STRING
   DEFINE l_comp_str   STRING  #161214-00022#1 add
   
   DELETE FROM  afaq120_tmp   #albireo 151028
   
   #资产状态SCC：9965
   INITIALIZE l_tmp.* TO NULL
   
   #161214-00022#1 add s---
   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef017","faah032") 
   #161214-00022#1 add e---

   #抓取符合条件的1.资本化资料afat400
               #        批号/法人组织/財编/序号/卡片编号/帐套/单据日期/单据性质/单据编号/项次/处置数量/金额/异动后资产状态/异动内容
   LET g_sql = "SELECT DISTINCT faah000,ooef001,faah003,faah004,faah001,fabacomp,fabadocdt,'1',fabndocno,fabnseq,'','','1','' ",
               ",faba005,faba004,faah012,faah017,'','',0,0,'','' ",#150908-00002#2---add
               "  FROM faah_t,faba_t,fabn_t,ooef_t ",
               " WHERE fabaent = fabnent ",
               "   AND fabaent = ",g_enterprise," ",  #160104-00020#1 
               "   AND fabadocno = fabndocno ",
               "   AND fabacomp = ooef001 ",
               "   AND fabasite = '",g_master2.fabgsite,"'",
               "   AND faba003 = '1' ",
               "   AND fabadocdt BETWEEN '",g_master2.bdate,"' AND '",g_master2.edate,"'",
               "   AND faah003 = fabn001 ",
               "   AND faah004 = fabn002 ",
               "   AND faah001 = fabn003 ",
               "   AND ",l_comp_str, #161214-00022#1 add
               "   AND ",g_wc CLIPPED 
   #抓取符合条件的2.折旧中资料afat509
               #        批号/法人组织/財编/序号/卡片编号/帐套/单据日期/单据性质/单据编号/项次/处置数量/金额/异动后资产状态/异动内容
   LET g_sql2 = "SELECT DISTINCT faah000,ooef001,faah003,faah004,faah001,fabgld,fabgdocdt,'2',fabhdocno,fabhseq,'',fabh010,'2','' ",
                ",fabh027,fabh033,faah012,fabh005,'','',fabh011,fabh004,fabg008,fabh030 ",#150908-00002#2---add
                "  FROM faah_t,fabg_t,fabh_t,ooef_t,glaa_t ",
                " WHERE fabgent = fabhent ",
                "   AND fabgent = ",g_enterprise," ",  #160104-00020#1 
                "   AND fabgdocno = fabhdocno ",
                "   AND fabgld = fabhld ",
                "   AND fabgcomp = ooef001 ",
                "   AND glaaent = fabgent ",
                "   AND fabgld = glaald ",
                "   AND fabgcomp = glaacomp ",
                "   AND fabgsite = '",g_master2.fabgsite,"'",
                "   AND fabg005 = '0' ",
                "   AND fabgdocdt BETWEEN '",g_master2.bdate,"' AND '",g_master2.edate,"'",
                "   AND faah003 = fabh001 ",
                "   AND faah004 = fabh002 ",
                "   AND faah001 = fabh000 ",
                "   AND ",l_comp_str, #161214-00022#1 add
                "   AND ",g_wc CLIPPED 
   #抓取符合条件的3.外送资料afat440
               #        批号/法人组织/財编/序号/卡片编号/帐套/单据日期/单据性质/单据编号/项次/处置数量/金额/异动后资产状态/异动内容
   LET g_sql3 = "SELECT DISTINCT faah000,ooef001,faah003,faah004,faah001,fabacomp,fabadocdt,'3',fabkdocno,fabkseq,fabk006,'','3','' ",
                ",faba005,faba004,faah012,fabk003,'','',0,0,'','' ",#150908-00002#2---add
                "  FROM faah_t,faba_t,fabk_t,ooef_t ",
                " WHERE fabaent = fabkent ",
                "   AND fabaent = ",g_enterprise," ",  #160104-00020#1 
                "   AND fabadocno = fabkdocno ",
                "   AND fabacomp = ooef001 ",
                "   AND fabasite = '",g_master2.fabgsite,"'",
                "   AND faba003 = '10' ",
                "   AND fabadocdt BETWEEN '",g_master2.bdate,"' AND '",g_master2.edate,"'",
                "   AND faah003 = fabk001 ",
                "   AND faah004 = fabk002 ",
                "   AND faah001 = fabk000 ",
                "   AND ",l_comp_str, #161214-00022#1 add
                "   AND ",g_wc CLIPPED 
   #抓取符合条件的5.出售资料afat504
               #        批号/法人组织/財编/序号/卡片编号/帐套/单据日期/单据性质/单据编号/项次/处置数量/金额/异动后资产状态/异动内容
   LET g_sql5 = "SELECT DISTINCT faah000,ooef001,faah003,faah004,faah001,fabgld,fabgdocdt,'5',fabodocno,faboseq,fabo007,fabo018,'5','' ",
                #",fabo032,fabo038,faah012,fabo005,'','',0,0,'','' ",#150908-00002#2---add
                ",fabo032,fabo038,faah012,fabo005,'','',0,0,fabg008,fabg006 ",   #albireo 151028 add fabg008,fabg006
                "  FROM faah_t,fabg_t,fabo_t,ooef_t,glaa_t ",
                " WHERE fabgent = faboent ",
                "   AND fabgdocno = fabodocno ",
                "   AND fabgent = ",g_enterprise," ",  #160104-00020#1 
                "   AND fabgld = fabold ",
                "   AND fabgcomp = ooef001 ",
                "   AND glaaent = fabgent ",
                "   AND fabgld = glaald ",
                "   AND fabgcomp = glaacomp ",
                "   AND fabgsite = '",g_master2.fabgsite,"'",
                "   AND fabg005 = '4' ",
                "   AND fabgdocdt BETWEEN '",g_master2.bdate,"' AND '",g_master2.edate,"'",
                "   AND faah003 = fabo001 ",
                "   AND faah004 = fabo002 ",
                "   AND faah001 = fabo003 ",
                "   AND ",l_comp_str, #161214-00022#1 add
                "   AND ",g_wc CLIPPED 
   #抓取符合条件的6.销帐资料afat506
               #        批号/法人组织/財编/序号/卡片编号/帐套/单据日期/单据性质/单据编号/项次/处置数量/金额/异动后资产状态/异动内容
   LET g_sql6 = "SELECT DISTINCT faah000,ooef001,faah003,faah004,faah001,fabgld,fabgdocdt,'6',fabhdocno,fabhseq,fabh007,fabh008,'6','' ",
                ",fabh027,fabh033,faah012,fabh005,'','',fabh011,fabh004,fabg008,fabh030 ",#150908-00002#2---add
                "  FROM faah_t,fabg_t,fabh_t,ooef_t,glaa_t ",
                " WHERE fabgent = fabhent ",
                "   AND fabgdocno = fabhdocno ",
                "   AND fabgent = ",g_enterprise," ",  #160104-00020#1 
                "   AND fabgld = fabhld ",
                "   AND fabgcomp = ooef001 ",
                "   AND glaaent = fabgent ",
                "   AND fabgld = glaald ",
                "   AND fabgcomp = glaacomp ",
                "   AND fabgsite = '",g_master2.fabgsite,"'",
                "   AND fabg005 = '6' ",
                "   AND fabgdocdt BETWEEN '",g_master2.bdate,"' AND '",g_master2.edate,"'",
                "   AND faah003 = fabh001 ",
                "   AND faah004 = fabh002 ",
                "   AND faah001 = fabh000 ",
                "   AND ",l_comp_str, #161214-00022#1 add
                "   AND ",g_wc CLIPPED 
   #抓取符合条件的7.折毕再提资料afat501
               #        批号/法人组织/財编/序号/卡片编号/帐套/单据日期/单据性质/单据编号/项次/处置数量/金额/异动后资产状态/异动内容
   LET g_sql7 = "SELECT DISTINCT faah000,ooef001,faah003,faah004,faah001,fabgld,fabgdocdt,'7',fabddocno,fabdseq,'','','7','' ",
                ",fabg003,fabg002,faah012,faah017,'','',0,0,'','' ",#150908-00002#2---add
                "  FROM faah_t,fabg_t,fabd_t,ooef_t,glaa_t ",
                " WHERE fabgent = fabdent ",
                "   AND fabgdocno = fabddocno ",
                "   AND fabgent = ",g_enterprise," ",  #160104-00020#1 
                "   AND fabgld = fabdld ",
                "   AND fabgcomp = ooef001 ",
                "   AND glaaent = fabgent ",
                "   AND fabgld = glaald ",
                "   AND fabgcomp = glaacomp ",
                "   AND fabgsite = '",g_master2.fabgsite,"'",
                "   AND fabg005 = '12' ",
                "   AND fabgdocdt BETWEEN '",g_master2.bdate,"' AND '",g_master2.edate,"'",
                "   AND faah003 = fabd001 ",
                "   AND faah004 = fabd002 ",
                "   AND faah001 = fabd000 ",
                "   AND ",l_comp_str, #161214-00022#1 add
                "   AND ",g_wc CLIPPED  
   #抓取符合条件的8.停用资料afat430
               #        批号/法人组织/財编/序号/卡片编号/帐套/单据日期/单据性质/单据编号/项次/处置数量/金额/异动后资产状态/异动内容
   LET g_sql8 = "SELECT DISTINCT faah000,ooef001,faah003,faah004,faah001,fabacomp,fabadocdt,'8',fabbdocno,fabbseq,'','','8','' ",
               ",faba005,faba004,faah012,faah017,'','',0,0,'','' ",#150908-00002#2---add
               "  FROM faah_t,faba_t,fabb_t,ooef_t ",
               " WHERE fabaent = fabbent ",
               "   AND fabadocno = fabbdocno ",
               "   AND fabaent = ",g_enterprise," ",  #160104-00020#1 
               "   AND fabacomp = ooef001 ",
               "   AND fabasite = '",g_master2.fabgsite,"'",
               "   AND faba003 = '7' ",
               "   AND fabadocdt BETWEEN '",g_master2.bdate,"' AND '",g_master2.edate,"'",
               "   AND faah003 = fabb001 ",
               "   AND faah004 = fabb002 ",
               "   AND faah001 = fabb000 ",
               "   AND ",l_comp_str, #161214-00022#1 add
               "   AND ",g_wc CLIPPED 
   #抓取符合条件的9.重估 afat503
               #        批号/法人组织/財编/序号/卡片编号/帐套/单据日期/单据性质/单据编号/项次/处置数量/金额/异动后资产状态/异动内容
   LET g_sql9 = "SELECT DISTINCT faah000,ooef001,faah003,faah004,faah001,fabgld,fabgdocdt,'9',fabhdocno,fabhseq,fabh007,fabh010,'9','' ",
                ",fabh027,fabh033,faah012,fabh005,'','',fabh011,fabh004,fabg008,fabh030 ",#150908-00002#2---add
                "  FROM faah_t,fabg_t,fabh_t,ooef_t,glaa_t ",
                " WHERE fabgent = fabhent ",
                "   AND fabgdocno = fabhdocno ",
                "   AND fabgent = ",g_enterprise," ",  #160104-00020#1 
                "   AND fabgld = fabhld ",
                "   AND fabgcomp = ooef001 ",
                "   AND glaaent = fabgent ",
                "   AND fabgld = glaald ",
                "   AND fabgcomp = glaacomp ",
                "   AND fabgsite = '",g_master2.fabgsite,"'",
                "   AND fabg005 = '8' ",
                "   AND fabgdocdt BETWEEN '",g_master2.bdate,"' AND '",g_master2.edate,"'",
                "   AND faah003 = fabh001 ",
                "   AND faah004 = fabh002 ",
                "   AND faah001 = fabh000 ",
                "   AND ",l_comp_str, #161214-00022#1 add
                "   AND ",g_wc CLIPPED 
   #抓取符合条件的13.合并
   #批号/法人组织/財编/序号/卡片编号/帐套/单据日期/单据性质/单据编号/项次/处置数量/金额/异动后资产状态/异动内容
   LET g_sql13 = "SELECT DISTINCT faah000,ooef001,faah003,faah004,faah001,fabacomp,fabadocdt,'13',fabldocno,fablseq,'','','11','' ",
                ",faba005,faba004,faah012,faah017,'','',0,0,'','' ",#150908-00002#2---add
                "  FROM faah_t,faba_t,fabl_t,ooef_t ",
                " WHERE fabaent = fablent ",
                "   AND fabadocno = fabldocno ",
                "   AND fabaent = ",g_enterprise," ",  #160104-00020#1 
                "   AND fabacomp = ooef001 ",
                "   AND fabasite = '",g_master2.fabgsite,"'",
                "   AND faba003 = '18' ",
                "   AND fabadocdt BETWEEN '",g_master2.bdate,"' AND '",g_master2.edate,"'",
                "   AND faah003 = fabl001 ",
                "   AND faah004 = fabl002 ",
                "   AND faah001 = fabl003 ",
                "   AND ",l_comp_str, #161214-00022#1 add
                "   AND ",g_wc CLIPPED 
   #抓取符合条件的14.分割
               #        批号/法人组织/財编/序号/卡片编号/帐套/单据日期/单据性质/单据编号/项次/处置数量/金额/异动后资产状态/异动内容
   LET g_sql14 = "SELECT DISTINCT faah000,ooef001,faah003,faah004,faah001,fabacomp,fabadocdt,'14',fabldocno,fablseq,'','','11','' ",
                ",faba005,faba004,faah012,faah017,'','',0,0,'','' ",#150908-00002#2---add
                "  FROM faah_t,faba_t,fabl_t,ooef_t ",
                " WHERE fabaent = fablent ",
                "   AND fabadocno = fabldocno ",
                "   AND fabaent = ",g_enterprise," ",  #160104-00020#1 
                "   AND fabacomp = ooef001 ",
                "   AND fabasite = '",g_master2.fabgsite,"'",
                "   AND faba003 = '19' ",
                "   AND fabadocdt BETWEEN '",g_master2.bdate,"' AND '",g_master2.edate,"'",
                "   AND faah003 = fabl001 ",
                "   AND faah004 = fabl002 ",
                "   AND faah001 = fabl003 ",
                "   AND ",l_comp_str, #161214-00022#1 add
                "   AND ",g_wc CLIPPED 
   #抓取符合条件的15.减值准备资料afat502
               #        批号/法人组织/財编/序号/卡片编号/帐套/单据日期/单据性质/单据编号/项次/处置数量/金额/异动后资产状态/异动内容
   LET g_sql15 = "SELECT DISTINCT faah000,ooef001,faah003,faah004,faah001,fabgld,fabgdocdt,'15',fabhdocno,fabhseq,'',fabh019,'2','' ",
                ",fabh027,fabh033,faah012,fabh005,'','',fabh011,fabh004,fabg008,fabh030 ",#150908-00002#2---add
                "  FROM faah_t,fabg_t,fabh_t,ooef_t,glaa_t ",
                " WHERE fabgent = fabhent ",
                "   AND fabgdocno = fabhdocno ",
                "   AND fabgld = fabhld ",
                "   AND fabgent = ",g_enterprise," ",  #160104-00020#1 
                "   AND fabgld = glaald ",
                "   AND fabgcomp = ooef001 ",
                "   AND fabgsite = '",g_master2.fabgsite,"'",
                "   AND fabg005 = '14' ",
                "   AND fabgdocdt BETWEEN '",g_master2.bdate,"' AND '",g_master2.edate,"'",
                "   AND faah003 = fabh001 ",
                "   AND faah004 = fabh002 ",
                "   AND faah001 = fabh000 ",
                "   AND ",l_comp_str, #161214-00022#1 add
                "   AND ",g_wc CLIPPED  
   #抓取符合条件的16.回收资料afat450
               #        批号/法人组织/財编/序号/卡片编号/帐套/单据日期/单据性质/单据编号/项次/处置数量/金额/异动后资产状态/异动内容
   LET g_sql16 = "SELECT DISTINCT faah000,ooef001,faah003,faah004,faah001,fabacomp,fabadocdt,'16',fabkdocno,fabkseq,fabk006,'','3','' ",
                ",faba005,faba004,faah012,fabk003,'','',0,0,'','' ",#150908-00002#2---add
                "  FROM faah_t,faba_t,fabk_t,ooef_t ",
                " WHERE fabaent = fabkent ",
                "   AND fabaent = ",g_enterprise," ",  #160104-00020#1 
                "   AND fabadocno = fabkdocno ",
                "   AND fabacomp = ooef001 ",
                "   AND fabasite = '",g_master2.fabgsite,"'",
                "   AND faba003 = '11' ",
                "   AND fabadocdt BETWEEN '",g_master2.bdate,"' AND '",g_master2.edate,"'",
                "   AND faah003 = fabk001 ",
                "   AND faah004 = fabk002 ",
                "   AND faah001 = fabk000 ",
                "   AND ",l_comp_str, #161214-00022#1 add
                "   AND ",g_wc CLIPPED 
   #抓取符合条件的17.调拨资料
               #        批号/法人组织/財编/序号/卡片编号/帐套/单据日期/单据性质/单据编号/项次/处置数量/金额/异动后资产状态/异动内容
   LET g_sql17 = ""
   
   #抓取符合条件的18.改良资料afat508
               #        批号/法人组织/財编/序号/卡片编号/帐套/单据日期/单据性质/单据编号/项次/处置数量/金额/异动后资产状态/异动内容
   LET g_sql18 = "SELECT DISTINCT faah000,ooef001,faah003,faah004,faah001,fabgld,fabgdocdt,'18',fabhdocno,fabhseq,fabh007,fabh010,'9','' ",
                ",fabh027,fabh033,faah012,fabh005,'','',fabh011,fabh004,fabg008,fabh030 ",#150908-00002#2---add
                "  FROM faah_t,fabg_t,fabh_t,ooef_t,glaa_t ",
                " WHERE fabgent = fabhent ",
                "   AND fabgent = ",g_enterprise," ",  #160104-00020#1 
                "   AND fabgdocno = fabhdocno ",
                "   AND fabgld = fabhld ",
                "   AND fabgcomp = ooef001 ",
                "   AND glaaent = fabgent ",
                "   AND fabgld = glaald ",
                "   AND fabgcomp = glaacomp ",
                "   AND fabgsite = '",g_master2.fabgsite,"'",
                "   AND fabg005 = '9' ",
                "   AND fabgdocdt BETWEEN '",g_master2.bdate,"' AND '",g_master2.edate,"'",
                "   AND faah003 = fabh001 ",
                "   AND faah004 = fabh002 ",
                "   AND faah001 = fabh000 ",
                "   AND ",l_comp_str, #161214-00022#1 add
                "   AND ",g_wc CLIPPED  
                
   #抓取符合条件的19.报废资料afat507
               #        批号/法人组织/財编/序号/卡片编号/帐套/单据日期/单据性质/单据编号/项次/处置数量/金额/异动后资产状态/异动内容
   LET g_sql19 = "SELECT DISTINCT faah000,ooef001,faah003,faah004,faah001,fabgld,fabgdocdt,'19',fabhdocno,fabhseq,fabh007,fabh008,'6','' ",
                ",fabh027,fabh033,faah012,fabh005,'','',fabh011,fabh004,fabg008,fabh030 ",#150908-00002#2---add
                "  FROM faah_t,fabg_t,fabh_t,ooef_t,glaa_t ",
                " WHERE fabgent = fabhent ",
                "   AND fabgent = ",g_enterprise," ",  #160104-00020#1 
                "   AND fabgdocno = fabhdocno ",
                "   AND fabgld = fabhld ",
                "   AND fabgcomp = ooef001 ",
                "   AND glaaent = fabgent ",
                "   AND fabgld = glaald ",
                "   AND fabgcomp = glaacomp ",
                "   AND fabgsite = '",g_master2.fabgsite,"'",
                "   AND fabg005 = '21' ",
                "   AND fabgdocdt BETWEEN '",g_master2.bdate,"' AND '",g_master2.edate,"'",
                "   AND faah003 = fabh001 ",
                "   AND faah004 = fabh002 ",
                "   AND faah001 = fabh000 ",
                "   AND ",l_comp_str, #161214-00022#1 add
                "   AND ",g_wc CLIPPED  
       #抓取符合条件的27.资产部门转移维护作业afat421
               #        批号/法人组织/財编/序号/卡片编号/帐套/单据日期/单据性质/单据编号/项次/处置数量/金额/异动后资产状态/异动内容
   LET g_sql27 = "SELECT DISTINCT faah000,ooef001,faah003,faah004,faah001,fabacomp,fabadocdt,'27',fabbdocno,fabbseq,'',0,faah015,'' ",
               ",faba005,faba004,faah012,faah017,'','',0,0,'','' ",#150908-00002#2---add
               "  FROM faah_t,faba_t,fabb_t,ooef_t ",
               " WHERE fabaent = fabbent ",
               #"   AND fabgent = ",g_enterprise," ",  #160104-00020#1   #161031-00005#1 mark lujh
               "   AND fabaent = ",g_enterprise,                         #161031-00005#1 add lujh
               "   AND fabadocno = fabbdocno ",           
               "   AND fabacomp = ooef001 ",
               "   AND fabasite = '",g_master2.fabgsite,"'",
               "   AND faba003 = '27' ",
               "   AND fabadocdt BETWEEN '",g_master2.bdate,"' AND '",g_master2.edate,"'",
               "   AND faah003 = fabb001 ",
               "   AND faah004 = fabb002 ",
               "   AND faah001 = fabb000 ",
               "   AND ",l_comp_str, #161214-00022#1 add
               "   AND ",g_wc CLIPPED 
       
    #抓取afat4*已审核的单据和afat5*已过账的单据
    IF g_master2.fabgstus = '1' THEN 
       LET g_sql = g_sql," AND fabastus = 'Y' "
       LET g_sql2 = g_sql2," AND fabgstus = 'S' "
       LET g_sql3 = g_sql3," AND fabastus = 'Y' "
       LET g_sql5 = g_sql5," AND fabgstus = 'S' "
       LET g_sql6 = g_sql6," AND fabgstus = 'S' "
       LET g_sql7 = g_sql7," AND fabgstus = 'S' "
       LET g_sql8 = g_sql8," AND fabastus = 'Y' "
       LET g_sql9 = g_sql9," AND fabgstus = 'S' "
       LET g_sql13 = g_sql13," AND fabastus = 'Y' "
       LET g_sql14 = g_sql14," AND fabastus = 'Y' "
       LET g_sql15 = g_sql15," AND fabgstus = 'S' "
       LET g_sql16 = g_sql16," AND fabastus = 'Y' "
       LET g_sql18 = g_sql18," AND fabgstus = 'S' "
       LET g_sql19 = g_sql19," AND fabgstus = 'S' "
       LET g_sql27 = g_sql27," AND fabastus = 'Y' "
    END IF 
    #抓取afat4*已审核的单据和afat5*已审核未过账的单据
    IF g_master2.fabgstus = '2' THEN 
       LET g_sql = g_sql," AND fabastus = 'Y' "
       LET g_sql2 = g_sql2," AND fabgstus = 'Y' "
       LET g_sql3 = g_sql3," AND fabastus = 'Y' "
       LET g_sql5 = g_sql5," AND fabgstus = 'Y' "
       LET g_sql6 = g_sql6," AND fabgstus = 'Y' "
       LET g_sql7 = g_sql7," AND fabgstus = 'Y' "
       LET g_sql8 = g_sql8," AND fabastus = 'Y' "
       LET g_sql9 = g_sql9," AND fabgstus = 'Y' "
       LET g_sql13 = g_sql13," AND fabastus = 'Y' "
       LET g_sql14 = g_sql14," AND fabastus = 'Y' "
       LET g_sql15 = g_sql15," AND fabgstus = 'Y' "
       LET g_sql16 = g_sql16," AND fabastus = 'Y' "
       LET g_sql18 = g_sql18," AND fabgstus = 'Y' "
       LET g_sql19 = g_sql19," AND fabgstus = 'Y' "
       LET g_sql27 = g_sql27," AND fabastus = 'Y' "
    END IF 
    #抓取afat4*和afat5*未作废的单据
    IF g_master2.fabgstus = '3' THEN 
       LET g_sql = g_sql," AND fabastus <> 'X' "
       LET g_sql2 = g_sql2," AND fabgstus <> 'X' "
       LET g_sql3 = g_sql3," AND fabastus <> 'X' "
       LET g_sql5 = g_sql5," AND fabgstus <> 'X' "
       LET g_sql6 = g_sql6," AND fabgstus <> 'X' "
       LET g_sql7 = g_sql7," AND fabgstus <> 'X' "
       LET g_sql8 = g_sql8," AND fabastus <> 'X' "
       LET g_sql9 = g_sql9," AND fabgstus <> 'X' "
       LET g_sql13 = g_sql13," AND fabastus <> 'X' "
       LET g_sql14 = g_sql14," AND fabastus <> 'X' "
       LET g_sql15 = g_sql15," AND fabgstus <> 'X' "
       LET g_sql16 = g_sql16," AND fabastus <> 'X' "
       LET g_sql18 = g_sql18," AND fabgstus <> 'X' "
       LET g_sql19 = g_sql19," AND fabgstus <> 'X' "
       LET g_sql27 = g_sql27," AND fabastus <> 'X' "
    END IF 
    IF g_master2.glaa014 = 'Y' THEN 
       LET g_sql2 = g_sql2," AND glaa014 = 'Y' "
       LET g_sql5 = g_sql5," AND glaa014 = 'Y' "
       LET g_sql6 = g_sql6," AND glaa014 = 'Y' "
       LET g_sql7 = g_sql7," AND glaa014 = 'Y' "
       LET g_sql9 = g_sql9," AND glaa014 = 'Y' "
       LET g_sql15 = g_sql15," AND glaa014 = 'Y' "
       LET g_sql18 = g_sql18," AND glaa014 = 'Y' "
       LET g_sql19 = g_sql19," AND glaa014 = 'Y' "
    END IF 
    PREPARE afaq120_faba_pb FROM g_sql
    DECLARE afaq120_curs CURSOR FOR afaq120_faba_pb
    PREPARE afaq120_faba_pb2 FROM g_sql2
    DECLARE afaq120_curs2 CURSOR FOR afaq120_faba_pb2
    PREPARE afaq120_faba_pb3 FROM g_sql3
    DECLARE afaq120_curs3 CURSOR FOR afaq120_faba_pb3
    PREPARE afaq120_faba_pb5 FROM g_sql5
    DECLARE afaq120_curs5 CURSOR FOR afaq120_faba_pb5
    PREPARE afaq120_faba_pb6 FROM g_sql6
    DECLARE afaq120_curs6 CURSOR FOR afaq120_faba_pb6
    PREPARE afaq120_faba_pb7 FROM g_sql7
    DECLARE afaq120_curs7 CURSOR FOR afaq120_faba_pb7
    PREPARE afaq120_faba_pb8 FROM g_sql8
    DECLARE afaq120_curs8 CURSOR FOR afaq120_faba_pb8
    PREPARE afaq120_faba_pb9 FROM g_sql9
    DECLARE afaq120_curs9 CURSOR FOR afaq120_faba_pb9
    PREPARE afaq120_faba_pb13 FROM g_sql13
    DECLARE afaq120_curs13 CURSOR FOR afaq120_faba_pb13
    PREPARE afaq120_faba_pb14 FROM g_sql14
    DECLARE afaq120_curs14 CURSOR FOR afaq120_faba_pb14
    PREPARE afaq120_faba_pb15 FROM g_sql15
    DECLARE afaq120_curs15 CURSOR FOR afaq120_faba_pb15
    PREPARE afaq120_faba_pb16 FROM g_sql16
    DECLARE afaq120_curs16 CURSOR FOR afaq120_faba_pb16
    PREPARE afaq120_faba_pb18 FROM g_sql18
    DECLARE afaq120_curs18 CURSOR FOR afaq120_faba_pb18
    PREPARE afaq120_faba_pb19 FROM g_sql19
    DECLARE afaq120_curs19 CURSOR FOR afaq120_faba_pb19  
    PREPARE afaq120_faba_pb27 FROM g_sql27
    DECLARE afaq120_curs27 CURSOR FOR afaq120_faba_pb27  
    #资本化资料afat400
    FOREACH afaq120_curs INTO l_tmp.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
       #获取正式財编，附号，卡号
       SELECT fabn004,fabn005,fabn018
         INTO l_fabn004,l_fabn005,l_fabn018
         FROM fabn_t
        WHERE fabndocno = l_tmp.fabhdocno
          AND fabnseq = l_tmp.fabhseq
          AND fabnent = g_enterprise
       #主键不同则异动后状态为12.被资本化
       IF l_tmp.faah003 != l_fabn004 OR l_tmp.faah004 != l_fabn005 OR l_tmp.faah001 != l_fabn018 THEN 
          LET l_tmp.fabh018 = '12'
       END IF 
       INSERT INTO afaq120_tmp VALUES(l_tmp.*)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INS afaq120_tmp " 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          RETURN 
       END IF
    END FOREACH 
    #折旧afat509
    FOREACH afaq120_curs2 INTO l_tmp.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
       SELECT fabh018 INTO l_fabh018
         FROM fabh_t
        WHERE fabhent = g_enterprise
          AND fabhdocno = l_tmp.fabhdocno
          AND fabhseq = l_tmp.fabhseq
       IF l_fabh018 = '2' THEN 
          LET l_tmp.fabh010 = l_tmp.fabh010 * (-1)
       END IF 
       INSERT INTO afaq120_tmp VALUES(l_tmp.*)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INS afaq120_tmp " 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          RETURN 
       END IF
    END FOREACH 
    #外送资料afat440
    FOREACH afaq120_curs3 INTO l_tmp.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
       SELECT fabk007 INTO l_fabk007
         FROM fabk_t
        WHERE fabkent = g_enterprise
          AND fabkdocno = l_tmp.fabhdocno
          AND fabkseq = l_tmp.fabhseq
       IF NOT cl_null(l_fabk007) THEN 
          LET l_tmp.demo = cl_getmsg('afa-00385',g_dlang)
          LET l_tmp.demo = l_tmp.demo,l_fabk007
       END IF
       INSERT INTO afaq120_tmp VALUES(l_tmp.*)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INS afaq120_tmp " 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          RETURN 
       END IF
    END FOREACH 
    #出售资料afat504
    FOREACH afaq120_curs5 INTO l_tmp.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
       SELECT fabo019,fabo020,fabo025
         INTO l_fabo019,l_fabo020,l_fabo025
         FROM fabo_t
        WHERE faboent  = g_enterprise
          AND fabodocno = l_tmp.fabhdocno
          AND faboseq = l_tmp.fabhseq
       IF cl_null(l_fabo019) THEN 
          LET l_fabo019 = 0
       END IF 
       IF cl_null(l_fabo020) THEN 
          LET l_fabo020 = 0
       END IF 
       IF cl_null(l_fabo025) THEN 
          LET l_fabo025 = 0
       END IF
       LET l_str1 = cl_getmsg("afa-00386", g_lang)
       LET l_str = l_str1.trim(),l_fabo019
       LET l_str1 = cl_getmsg("afa-00392", g_lang)
       LET l_str = l_str.trim(),l_str1.trim(),l_fabo020
       LET l_str1 = cl_getmsg("afa-00393", g_lang)
       LET l_str = l_str.trim(),l_str1.trim(),l_fabo025
       LET l_tmp.demo = l_str.trim()
       INSERT INTO afaq120_tmp VALUES(l_tmp.*)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INS afaq120_tmp " 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          RETURN 
       END IF
    END FOREACH
    #销帐资料afat506
    FOREACH afaq120_curs6 INTO l_tmp.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
       SELECT fabh011,fabh015,fabh017,fabh018
         INTO l_fabh011,l_fabh015,l_fabh017,l_fabh018
         FROM fabh_t
        WHERE fabhent = g_enterprise
          AND fabhdocno = l_tmp.fabhdocno
          AND fabhseq = l_tmp.fabhseq
       IF cl_null(l_fabh011) THEN 
          LET l_fabh011 = 0
       END IF 
       IF cl_null(l_fabh015) THEN 
          LET l_fabh015 = 0
       END IF 
       IF cl_null(l_fabh017) THEN 
          LET l_fabh017 = 0
       END IF 
       IF l_fabh018 = '2' THEN 
          LET l_tmp.fabh010 = l_tmp.fabh010 * (-1)
       END IF 
       LET l_str1 = cl_getmsg("afa-00387", g_lang)
       LET l_str = l_str1.trim(),l_fabh011
       LET l_str1 = cl_getmsg("afa-00394", g_lang)
       LET l_str = l_str.trim(),l_str1.trim(),l_fabh015
       LET l_str1 = cl_getmsg("afa-00395", g_lang)
       LET l_str = l_str.trim(),l_str1.trim(),l_fabh017
       LET l_tmp.demo = l_str.trim()
       INSERT INTO afaq120_tmp VALUES(l_tmp.*)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INS afaq120_tmp " 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          RETURN 
       END IF
    END FOREACH
    #折毕再提资料afat501
    FOREACH afaq120_curs7 INTO l_tmp.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
       SELECT fabd007,fabd010
         INTO l_fabd007,l_fabd010
         FROM fabd_t
        WHERE fabdent = g_enterprise
          AND fabddocno = l_tmp.fabhdocno
          AND fabdseq = l_tmp.fabhseq
       IF cl_null(l_fabd007) THEN 
          LET l_fabd007 = 0
       END IF 
       IF cl_null(l_fabd010) THEN 
          LET l_fabd010 = 0
       END IF 
       LET l_str1 = cl_getmsg("afa-00388", g_lang)
       LET l_str = l_str1.trim(),l_fabd007
       LET l_str1 = cl_getmsg("afa-00396", g_lang)
       LET l_str = l_str.trim(),l_str1.trim(),l_fabd010
       LET l_tmp.demo = l_str.trim()
       INSERT INTO afaq120_tmp VALUES(l_tmp.*)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INS afaq120_tmp " 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          RETURN 
       END IF
    END FOREACH
    #停用资料afat430
    FOREACH afaq120_curs8 INTO l_tmp.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
       SELECT fabb007 INTO l_fabb007 
         FROM fabb_t
        WHERE fabbent = g_enterprise
          AND fabbdocno = l_tmp.fabhdocno
          AND fabbseq = l_tmp.fabhseq
       IF l_fabb007 = '8' THEN 
          LET l_tmp.fabh018 = '2'
       ELSE 
          LET l_tmp.fabh018 = '8' 
       END IF 
       INSERT INTO afaq120_tmp VALUES(l_tmp.*)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INS afaq120_tmp " 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          RETURN 
       END IF
    END FOREACH
    #重估 afat503
    FOREACH afaq120_curs9 INTO l_tmp.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
       SELECT fabh012,fabh014,fabh016,fabh018
         INTO l_fabh012,l_fabh014,l_fabh016,l_fabh018
         FROM fabh_t
        WHERE fabhent = g_enterprise
          AND fabhdocno = l_tmp.fabhdocno
          AND fabhseq = l_tmp.fabhseq
       IF cl_null(l_fabh012) THEN 
          LET l_fabh012 = 0
       END IF 
       IF cl_null(l_fabh014) THEN 
          LET l_fabh014 = 0
       END IF 
       IF cl_null(l_fabh016) THEN 
          LET l_fabh016 = 0
       END IF 
       SELECT fabh018 INTO l_fabh018
         FROM fabh_t
        WHERE fabhent = g_enterprise
          AND fabhdocno = l_tmp.fabhdocno
          AND fabhseq = l_tmp.fabhseq
       IF l_fabh018 = '2' THEN 
          LET l_tmp.fabh010 = l_tmp.fabh010 * (-1)
       END IF 
       LET l_str1 = cl_getmsg("afa-00389", g_lang)
       LET l_str = l_str1.trim(),l_fabh012
       LET l_str1 = cl_getmsg("afa-00397", g_lang)
       LET l_str = l_str.trim(),l_str1.trim(),l_fabh014
       LET l_str1 = cl_getmsg("afa-00398", g_lang)
       LET l_str = l_str.trim(),l_str1.trim(),l_fabh016
       LET l_tmp.demo = l_str.trim()
       INSERT INTO afaq120_tmp VALUES(l_tmp.*)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INS afaq120_tmp " 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          RETURN 
       END IF
    END FOREACH
    #合并 afat470
    FOREACH afaq120_curs13 INTO l_tmp.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
       INSERT INTO afaq120_tmp VALUES(l_tmp.*)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INS afaq120_tmp " 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          RETURN 
       END IF
    END FOREACH
    #分割afat480
    FOREACH afaq120_curs14 INTO l_tmp.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
       INSERT INTO afaq120_tmp VALUES(l_tmp.*)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INS afaq120_tmp " 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          RETURN 
       END IF
    END FOREACH
    #减值准备资料afat502
    FOREACH afaq120_curs15 INTO l_tmp.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
       SELECT fabh018 INTO l_fabh018
         FROM fabh_t
        WHERE fabhent = g_enterprise
          AND fabhdocno = l_tmp.fabhdocno
          AND fabhseq = l_tmp.fabhseq
       IF l_fabh018 = '2' THEN 
          LET l_tmp.fabh010 = l_tmp.fabh010 * (-1)
       END IF 
       INSERT INTO afaq120_tmp VALUES(l_tmp.*)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INS afaq120_tmp " 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          RETURN 
       END IF
    END FOREACH
    #回收资料afat450
    FOREACH afaq120_curs16 INTO l_tmp.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
       SElECT fabk005,fabk006
         INTO l_fabk005,l_fabk006
         FROM fabk_t
        WHERE fabkent = g_enterprise
          AND fabkdocno = l_tmp.fabhdocno
          AND fabkseq = l_tmp.fabhseq
       IF l_fabk006 = l_fabk005 THEN 
          LET l_tmp.fabh018 = '2'
       END IF 
       INSERT INTO afaq120_tmp VALUES(l_tmp.*)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INS afaq120_tmp " 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          RETURN 
       END IF
    END FOREACH
    #改良资料afat508
    FOREACH afaq120_curs18 INTO l_tmp.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
       SELECT fabh014,fabh016
         INTO l_fabh014,l_fabh016
         FROM fabh_t
        WHERE fabhent = g_enterprise
          AND fabhdocno = l_tmp.fabhdocno
          AND fabhseq = l_tmp.fabhseq
       IF cl_null(l_fabh014) THEN 
          LET l_fabh014 = 0
       END IF 
       IF cl_null(l_fabh016) THEN 
          LET l_fabh016 = 0
       END IF 
       LET l_str1 = cl_getmsg("afa-00390", g_lang)
       LET l_str = l_str1.trim(),l_fabh014
       LET l_str1 = cl_getmsg("afa-00399", g_lang)
       LET l_str = l_str.trim(),l_str1.trim(),l_fabh016
       LET l_tmp.demo = l_str.trim()
       INSERT INTO afaq120_tmp VALUES(l_tmp.*)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INS afaq120_tmp " 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          RETURN 
       END IF
    END FOREACH
    #报废资料afat507
    FOREACH afaq120_curs19 INTO l_tmp.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
       SELECT fabh011,fabh015,fabh017,fabh018
         INTO l_fabh011,l_fabh015,l_fabh017,l_fabh018
         FROM fabh_t
        WHERE fabhent = g_enterprise
          AND fabhdocno = l_tmp.fabhdocno
          AND fabhseq = l_tmp.fabhseq
       IF cl_null(l_fabh011) THEN 
          LET l_fabh011 = 0
       END IF 
       IF cl_null(l_fabh015) THEN 
          LET l_fabh015 = 0
       END IF 
       IF cl_null(l_fabh017) THEN 
          LET l_fabh017 = 0
       END IF 
       IF l_fabh018 = '2' THEN 
          LET l_tmp.fabh010 = l_tmp.fabh010 * (-1)
       END IF 
       LET l_str1 = cl_getmsg("afa-00391", g_lang)
       LET l_str = l_str1.trim(),l_fabh011
       LET l_str1 = cl_getmsg("afa-00400", g_lang)
       LET l_str = l_str.trim(),l_str1.trim(),l_fabh015
       LET l_str1 = cl_getmsg("afa-00401", g_lang)
       LET l_str = l_str.trim(),l_str1.trim(),l_fabh017
       LET l_tmp.demo = l_str.trim()
       INSERT INTO afaq120_tmp VALUES(l_tmp.*)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INS afaq120_tmp " 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          RETURN 
       END IF
    END FOREACH

    #部门转移资料afat421
    FOREACH afaq120_curs27 INTO l_tmp.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
       LET l_str = cl_getmsg("afa-00450", g_lang)
       LET l_tmp.demo = l_str.trim()
       INSERT INTO afaq120_tmp VALUES(l_tmp.*)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "INS afaq120_tmp " 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          RETURN 
       END IF
    END FOREACH 

    #新增合计项
    #150908-00002#2---modify add fabh011,fabh004
    LET l_fabh007 = 0 
    LET l_fabh010 = 0 
    LET l_fabh011 = 0 
    LET l_fabh004 = 0 
    LET g_sql = "SELECT SUM(fabh007),SUM(fabh010),SUM(fabh011),SUM(fabh004) ",
                "  FROM afaq120_tmp "
    PREPARE ins_tmp FROM g_sql
    DECLARE ins_tmp_curs CURSOR FOR ins_tmp  
    FOREACH ins_tmp_curs INTO l_fabh007,l_fabh010,l_fabh011,l_fabh004
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
       LET l_msg = cl_getmsg("aps-00134", g_lang)
       INSERT INTO afaq120_tmp(fabhdocno,fabh007,fabh010,fabh011,fabh004)
       VALUES(l_msg,l_fabh007,l_fabh010,l_fabh011,l_fabh004)
       #150908-00002#2---
    END FOREACH 
    
END FUNCTION
################################################################################
# Descriptions...: 透過RECORD把資料放入TEMP TABLE
# Memo...........: #150908-00002#2
#
# Date & Author..: 151007 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq120_ins_xg_tmp()
DEFINE l_i like type_t.num10
DEFINE l_fabg005_desc  LIKE type_t.chr500    #取得SCC的說明文字
DEFINE l_fabgstus_desc LIKE type_t.chr500    #取得SCC的說明文字
DEFINE l_fabh018_desc  LIKE type_t.chr500    #取得SCC的說明文字
DEFINE l_x01_tmp    RECORD
      faah000       LIKE faah_t.faah000,
      ooef001       LIKE ooef_t.ooef001,
      faah003       LIKE faah_t.faah003,
      faah004       LIKE faah_t.faah004,
      faah001       LIKE faah_t.faah001,
      fabgld        LIKE type_t.chr10,
      fabgdocdt     LIKE fabg_t.fabgdocdt,
      fabg005       LIKE type_t.chr500,
      fabhdocno     LIKE fabh_t.fabhdocno,
      fabhseq       LIKE fabh_t.fabhseq,
      fabh007       LIKE fabh_t.fabh007,
      fabh010       LIKE fabh_t.fabh010,
      fabh018       LIKE type_t.chr500,
      demo          LIKE type_t.chr500,
      fabh027       LIKE fabh_t.fabh027, 
      fabh033       LIKE fabh_t.fabh033, 
      faah012       LIKE faah_t.faah012, 
      fabh005       LIKE fabh_t.fabh005, 
      faam013       LIKE type_t.num20_6, 
      faam013_2     LIKE type_t.num20_6, 
      fabh011       LIKE type_t.num20_6, 
      fabh004       LIKE type_t.num20_6, 
      fabg008       LIKE type_t.chr20, 
      fabh030       LIKE type_t.chr10,
      fabgsite      LIKE type_t.chr500,
      l_fabgdocdt   LIKE type_t.chr500,
      fabgstus      LIKE type_t.chr500,      
      glaa014       LIKE type_t.chr500
                END RECORD
   DELETE FROM afaq120_xg_tmp
   FOR l_i = 1 TO g_faah_d.getLength()
      CALL s_desc_gzcbl004_desc('9965',g_faah_d[l_i].fabg005) RETURNING l_fabg005_desc 
      CALL s_desc_gzcbl004_desc('9922',g_master2.fabgstus) RETURNING l_fabgstus_desc
      CALL s_desc_gzcbl004_desc('9965',g_faah_d[l_i].fabh018) RETURNING l_fabh018_desc 
      INITIALIZE l_x01_tmp.* TO NULL
      LET l_x01_tmp.faah000   = g_faah_d[l_i].faah000    
      LET l_x01_tmp.ooef001   = g_faah_d[l_i].ooef001    
      LET l_x01_tmp.faah003   = g_faah_d[l_i].faah003    
      LET l_x01_tmp.faah004   = g_faah_d[l_i].faah004    
      LET l_x01_tmp.faah001   = g_faah_d[l_i].faah001    
      LET l_x01_tmp.fabgld    = g_faah_d[l_i].fabgld     
      LET l_x01_tmp.fabgdocdt = g_faah_d[l_i].fabgdocdt  
      IF NOT cl_null(g_faah_d[l_i].fabg005) THEN
         LET l_x01_tmp.fabg005   = g_faah_d[l_i].fabg005,":",l_fabg005_desc  
      END IF
      LET l_x01_tmp.fabhdocno = g_faah_d[l_i].fabhdocno  
      LET l_x01_tmp.fabhseq   = g_faah_d[l_i].fabhseq    
      LET l_x01_tmp.fabh007   = g_faah_d[l_i].fabh007    
      LET l_x01_tmp.fabh010   = g_faah_d[l_i].fabh010    
      IF NOT cl_null(g_faah_d[l_i].fabh018) THEN
         LET l_x01_tmp.fabh018   = g_faah_d[l_i].fabh018,":",l_fabh018_desc  
      END IF
      LET l_x01_tmp.demo      = g_faah_d[l_i].demo       
      LET l_x01_tmp.fabh027   = g_faah_d[l_i].l_fabh027  
      LET l_x01_tmp.fabh033   = g_faah_d[l_i].l_fabh033  
      LET l_x01_tmp.faah012   = g_faah_d[l_i].faah012    
      LET l_x01_tmp.fabh005   = g_faah_d[l_i].l_fabh005  
      LET l_x01_tmp.faam013   = g_faah_d[l_i].l_faam013  
      LET l_x01_tmp.faam013_2 = g_faah_d[l_i].l_faam013_2
      LET l_x01_tmp.fabh011   = g_faah_d[l_i].l_fabh011  
      LET l_x01_tmp.fabh004   = g_faah_d[l_i].l_fabh004  
      LET l_x01_tmp.fabg008   = g_faah_d[l_i].l_fabg008  
      LET l_x01_tmp.fabh030   = g_faah_d[l_i].l_fabh030  
      LET l_x01_tmp.fabgsite  = g_master2.fabgsite,":",g_master2.fabgsite_desc
      LET l_x01_tmp.l_fabgdocdt = g_master2.bdate,"~",g_master2.edate
      LET l_x01_tmp.fabgstus  = g_master2.fabgstus,":",l_fabgstus_desc
      LET l_x01_tmp.glaa014   = g_master2.glaa014
      INSERT INTO afaq120_xg_tmp VALUES(l_x01_tmp.*)
   END FOR
END FUNCTION

 
{</section>}
 
