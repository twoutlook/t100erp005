#該程式未解開Section, 採用最新樣板產出!
{<section id="afaq151.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:12(2016-07-23 12:38:48), PR版次:0012(2016-12-05 14:38:17)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000096
#+ Filename...: afaq151
#+ Description: 資產在冊清單查詢(依帳套)
#+ Creator....: 02003(2015-01-09 10:09:28)
#+ Modifier...: 01531 -SD/PR- 02599
 
{</section>}
 
{<section id="afaq151.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160505-00007#3  2016/05/10  By 01531  效能优化
#160426-00014#9  2016/07/22  By 01531  查询增加列管与列帐
#160727-00019#1  2016/07/29  By 08742  系统中定义的临时表名称超过15码在执行时会出错,所以将系统中定义的临时表长度超过15码的全部改掉
#160804-00054#1  2016/08/07  By 01531  查询出资料栏位错乱
#160125-00005#7  2016/08/09  By 01531  查詢時加上帳套人員權限條件過濾
#161006-00005#22 2016/10/24  By 06137  組織類型與職能開窗清單需測試及調整開窗內容
#161017-00023#1  2016/10/26  By 02114  权限调整
#161111-00049#5  2016/11/16  By 01531  固资栏位过滤
#161205-00016#1  2016/12/05  By 02599  '取的日期'栏位开放查询
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
       
       faah032 LIKE faah_t.faah032, 
   faah032_desc LIKE type_t.chr500, 
   faah003 LIKE faah_t.faah003, 
   faah004 LIKE faah_t.faah004, 
   faah001 LIKE faah_t.faah001, 
   faah000 LIKE faah_t.faah000, 
   faah012 LIKE faah_t.faah012, 
   faah013 LIKE faah_t.faah013, 
   faah014 LIKE faah_t.faah014, 
   faah018 LIKE faah_t.faah018, 
   faah019 LIKE faah_t.faah019, 
   faah015 LIKE type_t.chr500, 
   faah025 LIKE faah_t.faah025, 
   faah025_desc LIKE type_t.chr500, 
   faah026 LIKE faah_t.faah026, 
   faah026_desc LIKE type_t.chr500, 
   faah005 LIKE type_t.chr500, 
   faah006 LIKE faah_t.faah006, 
   faah006_desc LIKE type_t.chr500, 
   faaj048 LIKE faaj_t.faaj048, 
   faah027 LIKE faah_t.faah027, 
   faah027_desc LIKE type_t.chr500, 
   faah028 LIKE faah_t.faah028, 
   faah028_desc LIKE type_t.chr500, 
   faah030 LIKE faah_t.faah030, 
   faah030_desc LIKE type_t.chr500, 
   faah031 LIKE faah_t.faah031, 
   faah031_desc LIKE type_t.chr500, 
   faah039 LIKE faah_t.faah039, 
   faajld LIKE faaj_t.faajld, 
   faaj014 LIKE faaj_t.faaj014, 
   faaj006 LIKE type_t.chr500, 
   faaj007 LIKE faaj_t.faaj007, 
   faaj007_desc LIKE type_t.chr500, 
   faaj025 LIKE faaj_t.faaj025, 
   faaj025_desc LIKE type_t.chr500, 
   faaj003 LIKE type_t.chr500, 
   faaj008 LIKE faaj_t.faaj008, 
   faaj004 LIKE faaj_t.faaj004, 
   faaj005 LIKE faaj_t.faaj005, 
   faaj016 LIKE faaj_t.faaj016, 
   faaj020 LIKE faaj_t.faaj020, 
   faaj028 LIKE faaj_t.faaj028, 
   faaj017 LIKE faaj_t.faaj017, 
   faaj021 LIKE faaj_t.faaj021, 
   faaj019 LIKE faaj_t.faaj019, 
   faah046 LIKE faah_t.faah046 
       END RECORD
PRIVATE TYPE type_g_faah2_d RECORD
       faah003 LIKE faah_t.faah003, 
   faah004 LIKE faah_t.faah004, 
   faah001 LIKE faah_t.faah001, 
   faajld LIKE faaj_t.faajld, 
   faaj101 LIKE faaj_t.faaj101, 
   faaj103 LIKE faaj_t.faaj103, 
   faaj117 LIKE faaj_t.faaj117, 
   faaj108 LIKE faaj_t.faaj108, 
   faaj104 LIKE faaj_t.faaj104, 
   faaj112 LIKE faaj_t.faaj112, 
   faaj105 LIKE faaj_t.faaj105, 
   faaj151 LIKE faaj_t.faaj151, 
   faaj153 LIKE faaj_t.faaj153, 
   faaj167 LIKE faaj_t.faaj167, 
   faaj158 LIKE faaj_t.faaj158, 
   faaj161 LIKE faaj_t.faaj161, 
   faaj162 LIKE faaj_t.faaj162, 
   faaj155 LIKE faaj_t.faaj155
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_master2   RECORD 
            faansite      LIKE faan_t.faansite,
            faansite_desc LIKE type_t.chr80
                   END RECORD 
DEFINE g_master2_t   RECORD 
            faansite      LIKE faan_t.faansite,
            faansite_desc LIKE type_t.chr80
                   END RECORD 
DEFINE g_glaald   LIKE glaa_t.glaald
DEFINE g_cnt2     LIKE type_t.num10   
DEFINE g_glaa015  LIKE glaa_t.glaa015  #報表參數
DEFINE g_glaa019  LIKE glaa_t.glaa019  #報表參數
DEFINE g_wc_cs_orga          STRING      #160125-00005#7
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_faah_d
DEFINE g_master_t                   type_g_faah_d
DEFINE g_faah_d          DYNAMIC ARRAY OF type_g_faah_d
DEFINE g_faah_d_t        type_g_faah_d
DEFINE g_faah2_d   DYNAMIC ARRAY OF type_g_faah2_d
DEFINE g_faah2_d_t type_g_faah2_d
 
 
      
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
 
{<section id="afaq151.main" >}
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
   DECLARE afaq151_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afaq151_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afaq151_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afaq151 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afaq151_init()   
 
      #進入選單 Menu (="N")
      CALL afaq151_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afaq151
      
   END IF 
   
   CLOSE afaq151_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afaq151.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afaq151_init()
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
   
      CALL cl_set_combo_scc('b_faah015','9914') 
   CALL cl_set_combo_scc('b_faah005','9903') 
   CALL cl_set_combo_scc('b_faaj048','9897') 
   CALL cl_set_combo_scc('b_faaj006','9912') 
   CALL cl_set_combo_scc('b_faaj003','9904') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_faah005','9903')
   CALL cl_set_combo_scc('b_faah015','9914')
   CALL cl_set_combo_scc('b_faaj006','9912')
   CALL cl_set_combo_scc('b_faaj003','9904')
   CALL cl_set_comp_visible("page_2",FALSE)
   CALL cl_set_comp_visible("b_faaj151_2,b_faaj153_2,b_faaj158_2,b_faaj161_2,b_faaj162_2,b_faaj155_2",FALSE)
   CALL cl_set_comp_visible("b_faaj101_2,b_faaj103_2,b_faaj108_2,b_faaj104_2,b_faaj112_2,b_faaj105_2",FALSE)
   CALL cl_set_combo_scc('b_faaj048','9897') #160426-00014#9 
   #营运据点范围
   CALL s_axrt300_get_site(g_user,'','1') RETURNING g_wc_cs_orga #160125-00005#7     
   CALL s_fin_create_account_center_tmp()   #161111-00049#5 add
   #end add-point
 
   CALL afaq151_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="afaq151.default_search" >}
PRIVATE FUNCTION afaq151_default_search()
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
 
{<section id="afaq151.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION afaq151_ui_dialog()
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
      CALL afaq151_b_fill()
   ELSE
      CALL afaq151_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_faah_d.clear()
         CALL g_faah2_d.clear()
 
 
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
 
         CALL afaq151_init()
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
               CALL afaq151_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL afaq151_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page1_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_afai020
                  LET g_action_choice="prog_afai020"
                  IF cl_auth_chk_act("prog_afai020") THEN
                     
                     #add-point:ON ACTION prog_afai020 name="menu.detail_show.page1_sub.prog_afai020"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'afai020'
               LET la_param.param[1] = g_faah_d[g_detail_idx].faah005

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


                     #END add-point
                     
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
               
 
 
 
 
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
         DISPLAY ARRAY g_faah2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_faah2_d.getLength() TO FORMONLY.h_count
               CALL afaq151_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point  
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL afaq151_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("insert", FALSE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afaq151_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL afaq151_x01('1=1','afaq151_tmp01',g_glaa015,g_glaa019)     # 160727-00019#1 Mod  afaq151_print_tmp--> afaq151_tmp01
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL afaq151_x01('1=1','afaq151_tmp01',g_glaa015,g_glaa019)     # 160727-00019#1 Mod  afaq151_print_tmp--> afaq151_tmp01
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afaq151_query()
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
            CALL afaq151_filter()
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
            CALL afaq151_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_faah_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_faah2_d)
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
            CALL afaq151_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL afaq151_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL afaq151_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL afaq151_b_fill()
 
         
         
 
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
 
{<section id="afaq151.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afaq151_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   CALL afaq151_query_1()
   RETURN 
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_faah_d.clear()
   CALL g_faah2_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON faah032,faah003,faah004,faah001,faah012,faah013,faah014,faah025,faah026, 
          faah006,faaj048,faajld,faah046
           FROM s_detail1[1].b_faah032,s_detail1[1].b_faah003,s_detail1[1].b_faah004,s_detail1[1].b_faah001, 
               s_detail1[1].b_faah012,s_detail1[1].b_faah013,s_detail1[1].b_faah014,s_detail1[1].b_faah025, 
               s_detail1[1].b_faah026,s_detail1[1].b_faah006,s_detail1[1].b_faaj048,s_detail1[1].b_faajld, 
               s_detail1[1].b_faah046
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_faah032>>----
         #Ctrlp:construct.c.page1.b_faah032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah032
            #add-point:ON ACTION controlp INFIELD b_faah032 name="construct.c.page1.b_faah032"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah032  #顯示到畫面上
            NEXT FIELD b_faah032                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah032
            #add-point:BEFORE FIELD b_faah032 name="construct.b.page1.b_faah032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah032
            
            #add-point:AFTER FIELD b_faah032 name="construct.a.page1.b_faah032"
            
            #END add-point
            
 
 
         #----<<b_faah032_desc>>----
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
            
 
 
         #----<<b_faah000>>----
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
 
 
         #----<<b_faah013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah013
            #add-point:BEFORE FIELD b_faah013 name="construct.b.page1.b_faah013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah013
            
            #add-point:AFTER FIELD b_faah013 name="construct.a.page1.b_faah013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faah013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah013
            #add-point:ON ACTION controlp INFIELD b_faah013 name="construct.c.page1.b_faah013"
            
            #END add-point
 
 
         #----<<b_faah014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah014
            #add-point:BEFORE FIELD b_faah014 name="construct.b.page1.b_faah014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah014
            
            #add-point:AFTER FIELD b_faah014 name="construct.a.page1.b_faah014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faah014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah014
            #add-point:ON ACTION controlp INFIELD b_faah014 name="construct.c.page1.b_faah014"
            
            #END add-point
 
 
         #----<<b_faah018>>----
         #----<<b_faah019>>----
         #----<<b_faah015>>----
         #----<<b_faah025>>----
         #Ctrlp:construct.c.page1.b_faah025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah025
            #add-point:ON ACTION controlp INFIELD b_faah025 name="construct.c.page1.b_faah025"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah025  #顯示到畫面上
            NEXT FIELD b_faah025                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah025
            #add-point:BEFORE FIELD b_faah025 name="construct.b.page1.b_faah025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah025
            
            #add-point:AFTER FIELD b_faah025 name="construct.a.page1.b_faah025"
            
            #END add-point
            
 
 
         #----<<b_faah025_desc>>----
         #----<<b_faah026>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah026
            #add-point:BEFORE FIELD b_faah026 name="construct.b.page1.b_faah026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah026
            
            #add-point:AFTER FIELD b_faah026 name="construct.a.page1.b_faah026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faah026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah026
            #add-point:ON ACTION controlp INFIELD b_faah026 name="construct.c.page1.b_faah026"
            
            #END add-point
 
 
         #----<<b_faah026_desc>>----
         #----<<b_faah005>>----
         #----<<b_faah006>>----
         #Ctrlp:construct.c.page1.b_faah006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah006
            #add-point:ON ACTION controlp INFIELD b_faah006 name="construct.c.page1.b_faah006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faac001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah006  #顯示到畫面上
            NEXT FIELD b_faah006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah006
            #add-point:BEFORE FIELD b_faah006 name="construct.b.page1.b_faah006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah006
            
            #add-point:AFTER FIELD b_faah006 name="construct.a.page1.b_faah006"
            
            #END add-point
            
 
 
         #----<<b_faah006_desc>>----
         #----<<b_faaj048>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faaj048
            #add-point:BEFORE FIELD b_faaj048 name="construct.b.page1.b_faaj048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faaj048
            
            #add-point:AFTER FIELD b_faaj048 name="construct.a.page1.b_faaj048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faaj048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faaj048
            #add-point:ON ACTION controlp INFIELD b_faaj048 name="construct.c.page1.b_faaj048"
            
            #END add-point
 
 
         #----<<b_faah027>>----
         #----<<b_faah027_desc>>----
         #----<<b_faah028>>----
         #----<<b_faah028_desc>>----
         #----<<b_faah030>>----
         #----<<b_faah030_desc>>----
         #----<<b_faah031>>----
         #----<<b_faah031_desc>>----
         #----<<b_faah039>>----
         #----<<b_faajld>>----
         #Ctrlp:construct.c.page1.b_faajld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faajld
            #add-point:ON ACTION controlp INFIELD b_faajld name="construct.c.page1.b_faajld"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faajld  #顯示到畫面上
            NEXT FIELD b_faajld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faajld
            #add-point:BEFORE FIELD b_faajld name="construct.b.page1.b_faajld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faajld
            
            #add-point:AFTER FIELD b_faajld name="construct.a.page1.b_faajld"
            
            #END add-point
            
 
 
         #----<<b_faaj014>>----
         #----<<b_faaj006>>----
         #----<<b_faaj007>>----
         #----<<b_faaj007_desc>>----
         #----<<b_faaj025>>----
         #----<<b_faaj025_desc>>----
         #----<<b_faaj003>>----
         #----<<b_faaj008>>----
         #----<<b_faaj004>>----
         #----<<b_faaj005>>----
         #----<<b_faaj016>>----
         #----<<b_faaj020>>----
         #----<<b_faaj028>>----
         #----<<b_faaj017>>----
         #----<<b_faaj021>>----
         #----<<b_faaj019>>----
         #----<<b_faah046>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah046
            #add-point:BEFORE FIELD b_faah046 name="construct.b.page1.b_faah046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah046
            
            #add-point:AFTER FIELD b_faah046 name="construct.a.page1.b_faah046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faah046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah046
            #add-point:ON ACTION controlp INFIELD b_faah046 name="construct.c.page1.b_faah046"
            
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
   CALL afaq151_b_fill()
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
 
{<section id="afaq151.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afaq151_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL afaq151_b2_fill()
   RETURN 
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
 
   LET ls_sql_rank = "SELECT  UNIQUE faah032,'',faah003,faah004,faah001,faah000,faah012,faah013,faah014, 
       faah018,faah019,'',faah025,'',faah026,'','',faah006,'','',faah027,'',faah028,'',faah030,'',faah031, 
       '',faah039,'','','','','','','','','','','','','','','','','',faah046,'','','','','','','','', 
       '','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY faah_t.faah000,faah_t.faah001,faah_t.faah003, 
       faah_t.faah004) AS RANK FROM faah_t",
 
 
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
 
   LET g_sql = "SELECT faah032,'',faah003,faah004,faah001,faah000,faah012,faah013,faah014,faah018,faah019, 
       '',faah025,'',faah026,'','',faah006,'','',faah027,'',faah028,'',faah030,'',faah031,'',faah039, 
       '','','','','','','','','','','','','','','','','',faah046,'','','','','','','','','','','','', 
       '','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afaq151_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afaq151_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_faah_d.clear()
   CALL g_faah2_d.clear()   
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_faah_d[l_ac].faah032,g_faah_d[l_ac].faah032_desc,g_faah_d[l_ac].faah003, 
       g_faah_d[l_ac].faah004,g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah000,g_faah_d[l_ac].faah012,g_faah_d[l_ac].faah013, 
       g_faah_d[l_ac].faah014,g_faah_d[l_ac].faah018,g_faah_d[l_ac].faah019,g_faah_d[l_ac].faah015,g_faah_d[l_ac].faah025, 
       g_faah_d[l_ac].faah025_desc,g_faah_d[l_ac].faah026,g_faah_d[l_ac].faah026_desc,g_faah_d[l_ac].faah005, 
       g_faah_d[l_ac].faah006,g_faah_d[l_ac].faah006_desc,g_faah_d[l_ac].faaj048,g_faah_d[l_ac].faah027, 
       g_faah_d[l_ac].faah027_desc,g_faah_d[l_ac].faah028,g_faah_d[l_ac].faah028_desc,g_faah_d[l_ac].faah030, 
       g_faah_d[l_ac].faah030_desc,g_faah_d[l_ac].faah031,g_faah_d[l_ac].faah031_desc,g_faah_d[l_ac].faah039, 
       g_faah_d[l_ac].faajld,g_faah_d[l_ac].faaj014,g_faah_d[l_ac].faaj006,g_faah_d[l_ac].faaj007,g_faah_d[l_ac].faaj007_desc, 
       g_faah_d[l_ac].faaj025,g_faah_d[l_ac].faaj025_desc,g_faah_d[l_ac].faaj003,g_faah_d[l_ac].faaj008, 
       g_faah_d[l_ac].faaj004,g_faah_d[l_ac].faaj005,g_faah_d[l_ac].faaj016,g_faah_d[l_ac].faaj020,g_faah_d[l_ac].faaj028, 
       g_faah_d[l_ac].faaj017,g_faah_d[l_ac].faaj021,g_faah_d[l_ac].faaj019,g_faah_d[l_ac].faah046,g_faah2_d[l_ac].faah003, 
       g_faah2_d[l_ac].faah004,g_faah2_d[l_ac].faah001,g_faah2_d[l_ac].faajld,g_faah2_d[l_ac].faaj101, 
       g_faah2_d[l_ac].faaj103,g_faah2_d[l_ac].faaj117,g_faah2_d[l_ac].faaj108,g_faah2_d[l_ac].faaj104, 
       g_faah2_d[l_ac].faaj112,g_faah2_d[l_ac].faaj105,g_faah2_d[l_ac].faaj151,g_faah2_d[l_ac].faaj153, 
       g_faah2_d[l_ac].faaj167,g_faah2_d[l_ac].faaj158,g_faah2_d[l_ac].faaj161,g_faah2_d[l_ac].faaj162, 
       g_faah2_d[l_ac].faaj155
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
 
      CALL afaq151_detail_show("'1'")      
 
      CALL afaq151_faah_t_mask()
 
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
   CALL g_faah2_d.deleteElement(g_faah2_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_faah_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE afaq151_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL afaq151_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL afaq151_detail_action_trans()
 
   IF g_faah_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL afaq151_fetch()
   END IF
   
      CALL afaq151_filter_show('faah032','b_faah032')
   CALL afaq151_filter_show('faah003','b_faah003')
   CALL afaq151_filter_show('faah004','b_faah004')
   CALL afaq151_filter_show('faah001','b_faah001')
   CALL afaq151_filter_show('faah012','b_faah012')
   CALL afaq151_filter_show('faah013','b_faah013')
   CALL afaq151_filter_show('faah014','b_faah014')
   CALL afaq151_filter_show('faah025','b_faah025')
   CALL afaq151_filter_show('faah026','b_faah026')
   CALL afaq151_filter_show('faah006','b_faah006')
   CALL afaq151_filter_show('faaj048','b_faaj048')
   CALL afaq151_filter_show('faajld','b_faajld')
   CALL afaq151_filter_show('faah046','b_faah046')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afaq151.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afaq151_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_glaa015   LIKE glaa_t.glaa015
   DEFINE l_glaa019   LIKE glaa_t.glaa019
   DEFINE l_origin_str  STRING
   DEFINE l_flag_1    LIKE type_t.num5  #160511-00016#1
   DEFINE l_flag_0    LIKE type_t.num5  #160511-00016#1
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
   CALL s_fin_account_center_comp_str()RETURNING l_origin_str
   CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
   
   #
   
   #160505-00007#3 add--str--
   CALL cl_set_comp_visible("b_faaj101_2,b_faaj103_2,b_faaj108_2,b_faaj104_2,b_faaj112_2,b_faaj105_2",FALSE) 
   CALL cl_set_comp_visible("b_faaj151_2,b_faaj153_2,b_faaj158_2,b_faaj161_2,b_faaj162_2,b_faaj155_2",FALSE)  
   LET l_flag_0 = FALSE
   LET l_flag_1 = FALSE
   #160505-00007#3 add--end--
   
   LET g_sql = "SELECT  UNIQUE faah003,faah004,faah001,faajld,faaj101,faaj103,faaj117,faaj108,faaj104,faaj112,",
               "               faaj105,faaj151,faaj153,faaj167,faaj158,faaj161,faaj162,faaj155, ",
               "               glaa015,glaa019 ",    #160505-00007#3 add
               "  FROM faah_t,faaj_t ",
               "  LEFT JOIN glaa_t ON glaald = faajld AND glaaent = faajent ", #160505-00007#3 add
               " WHERE faajent = faahent ",
               "   AND faaj001 = faah003 ",
               "   AND faaj002 = faah004 ",
               "   AND faaj037 = faah001 ",
               "   AND faahent = '",g_enterprise,"'",
               "   AND faah032 IN(",l_origin_str CLIPPED,")",
               "   AND ",g_wc CLIPPED, 
               " ORDER BY faah003,faah004,faah001 "
   PREPARE afaq151_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR afaq151_pb3
   CALL g_faah2_d.clear()
   LET g_cnt = 1
   FOREACH b_fill_curs3 INTO g_faah2_d[g_cnt].*,l_glaa015,l_glaa019  #160505-00007#3 add l_glaa015,l_glaa019 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      SELECT glaa015,glaa019
        INTO l_glaa015,l_glaa019
        FROM glaa_t
       WHERE glaald = g_faah2_d[g_cnt].faajld
         AND glaaent = g_enterprise
      #160505-00007#3 mod--str--   
      #IF l_glaa015 = 'Y' THEN 
      #   CALL cl_set_comp_visible("b_faaj101_2,b_faaj103_2,b_faaj108_2,b_faaj104_2,b_faaj112_2,b_faaj105_2",TRUE)
      #END IF 
      #IF l_glaa019 = 'Y' THEN 
      #   CALL cl_set_comp_visible("b_faaj151_2,b_faaj153_2,b_faaj158_2,b_faaj161_2,b_faaj162_2,b_faaj155_2",TRUE)
      #END IF
      IF l_flag_0 = TRUE THEN
         IF l_glaa015 = 'Y' THEN
            LET l_flag_0 = FALSE      
         END IF
      END IF
      IF l_flag_1 = TRUE THEN      
         IF l_glaa019 = 'Y' THEN
            LET l_flag_1 = FALSE
         END IF
      END IF   
      #160505-00007#3 mod--end--
      #更新報表臨時表
      UPDATE afaq151_tmp01 SET faaj101 = g_faah2_d[g_cnt].faaj101,     # 160727-00019#1 Mod  afaq151_print_tmp--> afaq151_tmp01
                                   faaj103 = g_faah2_d[g_cnt].faaj103, 
                                   faaj117 = g_faah2_d[g_cnt].faaj117, 
                                   faaj108 = g_faah2_d[g_cnt].faaj108, 
                                   faaj104 = g_faah2_d[g_cnt].faaj104, 
                                   faaj112 = g_faah2_d[g_cnt].faaj112, 
                                   faaj105 = g_faah2_d[g_cnt].faaj105, 
                                   faaj151 = g_faah2_d[g_cnt].faaj151, 
                                   faaj153 = g_faah2_d[g_cnt].faaj153, 
                                   faaj167 = g_faah2_d[g_cnt].faaj167, 
                                   faaj158 = g_faah2_d[g_cnt].faaj158, 
                                   faaj161 = g_faah2_d[g_cnt].faaj161, 
                                   faaj162 = g_faah2_d[g_cnt].faaj162, 
                                   faaj155 = g_faah2_d[g_cnt].faaj155                     
       WHERE faah003 = g_faah2_d[g_cnt].faah003
         AND faah004 = g_faah2_d[g_cnt].faah004
         AND faah001 = g_faah2_d[g_cnt].faah001
         AND faajld = g_faah2_d[g_cnt].faajld
         
         
#      IF l_ac > g_max_rec THEN
#         IF g_error_show = 1 THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend =  "" 
#            LET g_errparam.code   =  9035 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
# 
#         END IF
#         EXIT FOREACH
#      END IF
      LET g_cnt = g_cnt + 1
      
   END FOREACH
   
   #160505-00007#3 add--str--
   IF l_flag_0 = FALSE THEN
      CALL cl_set_comp_visible("b_faaj101_2,b_faaj103_2,b_faaj108_2,b_faaj104_2,b_faaj112_2,b_faaj105_2",TRUE)
   END IF
   IF l_flag_1 = FALSE THEN
      CALL cl_set_comp_visible("b_faaj151_2,b_faaj153_2,b_faaj158_2,b_faaj161_2,b_faaj162_2,b_faaj155_2",TRUE)
   END IF  
   #160505-00007#3 add--end--   
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="afaq151.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afaq151_detail_show(ps_page)
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
 
{<section id="afaq151.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afaq151_filter()
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
      CONSTRUCT g_wc_filter ON faah032,faah003,faah004,faah001,faah012,faah013,faah014,faah025,faah026, 
          faah006,faaj048,faajld,faah046
                          FROM s_detail1[1].b_faah032,s_detail1[1].b_faah003,s_detail1[1].b_faah004, 
                              s_detail1[1].b_faah001,s_detail1[1].b_faah012,s_detail1[1].b_faah013,s_detail1[1].b_faah014, 
                              s_detail1[1].b_faah025,s_detail1[1].b_faah026,s_detail1[1].b_faah006,s_detail1[1].b_faaj048, 
                              s_detail1[1].b_faajld,s_detail1[1].b_faah046
 
         BEFORE CONSTRUCT
                     DISPLAY afaq151_filter_parser('faah032') TO s_detail1[1].b_faah032
            DISPLAY afaq151_filter_parser('faah003') TO s_detail1[1].b_faah003
            DISPLAY afaq151_filter_parser('faah004') TO s_detail1[1].b_faah004
            DISPLAY afaq151_filter_parser('faah001') TO s_detail1[1].b_faah001
            DISPLAY afaq151_filter_parser('faah012') TO s_detail1[1].b_faah012
            DISPLAY afaq151_filter_parser('faah013') TO s_detail1[1].b_faah013
            DISPLAY afaq151_filter_parser('faah014') TO s_detail1[1].b_faah014
            DISPLAY afaq151_filter_parser('faah025') TO s_detail1[1].b_faah025
            DISPLAY afaq151_filter_parser('faah026') TO s_detail1[1].b_faah026
            DISPLAY afaq151_filter_parser('faah006') TO s_detail1[1].b_faah006
            DISPLAY afaq151_filter_parser('faaj048') TO s_detail1[1].b_faaj048
            DISPLAY afaq151_filter_parser('faajld') TO s_detail1[1].b_faajld
            DISPLAY afaq151_filter_parser('faah046') TO s_detail1[1].b_faah046
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_faah032>>----
         #Ctrlp:construct.c.page1.b_faah032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah032
            #add-point:ON ACTION controlp INFIELD b_faah032 name="construct.c.filter.page1.b_faah032"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah032  #顯示到畫面上
            NEXT FIELD b_faah032                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_faah032_desc>>----
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
 
 
         #----<<b_faah000>>----
         #----<<b_faah012>>----
         #Ctrlp:construct.c.filter.page1.b_faah012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah012
            #add-point:ON ACTION controlp INFIELD b_faah012 name="construct.c.filter.page1.b_faah012"
            
            #END add-point
 
 
         #----<<b_faah013>>----
         #Ctrlp:construct.c.filter.page1.b_faah013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah013
            #add-point:ON ACTION controlp INFIELD b_faah013 name="construct.c.filter.page1.b_faah013"
            
            #END add-point
 
 
         #----<<b_faah014>>----
         #Ctrlp:construct.c.filter.page1.b_faah014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah014
            #add-point:ON ACTION controlp INFIELD b_faah014 name="construct.c.filter.page1.b_faah014"
            
            #END add-point
 
 
         #----<<b_faah018>>----
         #----<<b_faah019>>----
         #----<<b_faah015>>----
         #----<<b_faah025>>----
         #Ctrlp:construct.c.page1.b_faah025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah025
            #add-point:ON ACTION controlp INFIELD b_faah025 name="construct.c.filter.page1.b_faah025"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah025  #顯示到畫面上
            NEXT FIELD b_faah025                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_faah025_desc>>----
         #----<<b_faah026>>----
         #Ctrlp:construct.c.filter.page1.b_faah026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah026
            #add-point:ON ACTION controlp INFIELD b_faah026 name="construct.c.filter.page1.b_faah026"
            
            #END add-point
 
 
         #----<<b_faah026_desc>>----
         #----<<b_faah005>>----
         #----<<b_faah006>>----
         #Ctrlp:construct.c.page1.b_faah006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah006
            #add-point:ON ACTION controlp INFIELD b_faah006 name="construct.c.filter.page1.b_faah006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faac001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah006  #顯示到畫面上
            NEXT FIELD b_faah006                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_faah006_desc>>----
         #----<<b_faaj048>>----
         #Ctrlp:construct.c.filter.page1.b_faaj048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faaj048
            #add-point:ON ACTION controlp INFIELD b_faaj048 name="construct.c.filter.page1.b_faaj048"
            
            #END add-point
 
 
         #----<<b_faah027>>----
         #----<<b_faah027_desc>>----
         #----<<b_faah028>>----
         #----<<b_faah028_desc>>----
         #----<<b_faah030>>----
         #----<<b_faah030_desc>>----
         #----<<b_faah031>>----
         #----<<b_faah031_desc>>----
         #----<<b_faah039>>----
         #----<<b_faajld>>----
         #Ctrlp:construct.c.page1.b_faajld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faajld
            #add-point:ON ACTION controlp INFIELD b_faajld name="construct.c.filter.page1.b_faajld"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faajld  #顯示到畫面上
            NEXT FIELD b_faajld                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_faaj014>>----
         #----<<b_faaj006>>----
         #----<<b_faaj007>>----
         #----<<b_faaj007_desc>>----
         #----<<b_faaj025>>----
         #----<<b_faaj025_desc>>----
         #----<<b_faaj003>>----
         #----<<b_faaj008>>----
         #----<<b_faaj004>>----
         #----<<b_faaj005>>----
         #----<<b_faaj016>>----
         #----<<b_faaj020>>----
         #----<<b_faaj028>>----
         #----<<b_faaj017>>----
         #----<<b_faaj021>>----
         #----<<b_faaj019>>----
         #----<<b_faah046>>----
         #Ctrlp:construct.c.filter.page1.b_faah046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah046
            #add-point:ON ACTION controlp INFIELD b_faah046 name="construct.c.filter.page1.b_faah046"
            
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
   
      CALL afaq151_filter_show('faah032','b_faah032')
   CALL afaq151_filter_show('faah003','b_faah003')
   CALL afaq151_filter_show('faah004','b_faah004')
   CALL afaq151_filter_show('faah001','b_faah001')
   CALL afaq151_filter_show('faah012','b_faah012')
   CALL afaq151_filter_show('faah013','b_faah013')
   CALL afaq151_filter_show('faah014','b_faah014')
   CALL afaq151_filter_show('faah025','b_faah025')
   CALL afaq151_filter_show('faah026','b_faah026')
   CALL afaq151_filter_show('faah006','b_faah006')
   CALL afaq151_filter_show('faaj048','b_faaj048')
   CALL afaq151_filter_show('faajld','b_faajld')
   CALL afaq151_filter_show('faah046','b_faah046')
 
    
   CALL afaq151_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="afaq151.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afaq151_filter_parser(ps_field)
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
 
{<section id="afaq151.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afaq151_filter_show(ps_field,ps_object)
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
   LET ls_condition = afaq151_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afaq151.insert" >}
#+ insert
PRIVATE FUNCTION afaq151_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afaq151.modify" >}
#+ modify
PRIVATE FUNCTION afaq151_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afaq151.reproduce" >}
#+ reproduce
PRIVATE FUNCTION afaq151_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afaq151.delete" >}
#+ delete
PRIVATE FUNCTION afaq151_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afaq151.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION afaq151_detail_action_trans()
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
 
{<section id="afaq151.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION afaq151_detail_index_setting()
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
 
{<section id="afaq151.mask_functions" >}
 &include "erp/afa/afaq151_mask.4gl"
 
{</section>}
 
{<section id="afaq151.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查詢條件設定
# Memo...........:
# Usage..........: CALL afaq151_query_1()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/01/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq151_query_1()
   DEFINE ls_wc          LIKE type_t.chr500
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE l_origin_str   STRING
   DEFINE l_comp_str     STRING       #161017-00023#1 add lujh
   DEFINE l_ld_str       STRING   #161111-00049#5
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
   #預設值
   LET g_master2.faansite = g_site
   LET g_master2_t.* = g_master2.*
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      INPUT BY NAME g_master2.faansite
       ATTRIBUTE(WITHOUT DEFAULTS)
      
         BEFORE INPUT    
            CALL afaq151_get_faansite_desc()
            DISPLAY BY NAME g_master2.faansite
      
         AFTER FIELD faansite
            IF NOT cl_null(g_master2.faansite) THEN 
                #检查组织资料的合理性
               IF NOT s_afat502_site_chk(g_master2.faansite) THEN
                  LET g_master2.faansite = g_master2_t.faansite
                  CALL afaq151_get_faansite_desc()
                  DISPLAY BY NAME g_master2.faansite
                  NEXT FIELD CURRENT
               END IF
               #user需要檢查和資產中心的權限
               IF NOT s_afat502_site_user_chk(g_master2.faansite,g_user) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_master2.faansite
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_master2.faansite = g_master2_t.faansite
                  CALL afaq151_get_faansite_desc()
                  DISPLAY BY NAME g_master2.faansite
                  NEXT FIELD CURRENT  
               END IF
            ELSE
               CALL afaq151_get_faansite_desc()
               DISPLAY BY NAME g_master2.faansite
            END IF 
            
          ON ACTION controlp INFIELD faansite
	          INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'i'
	          LET g_qryparam.reqry = FALSE
             LET g_qryparam.default1 = g_master2.faansite      #給予default值
             LET g_qryparam.where = " ooef207 = 'Y' "
             #160426-00014#33--mark--str--lujh
             ##160125-00005#7--add--str--
             #IF NOT cl_null(g_wc_cs_orga) THEN
			    #   LET g_qryparam.where = g_wc_cs_orga
			    #END IF
			    ##160125-00005#7--add--end      
             #160426-00014#33--mark--end--lujh			    
             #CALL q_ooef001()      #161006-00005#22 Mark By Ken 161024
             CALL q_ooef001_47()    #161006-00005#22 Add By Ken 161024
             LET g_master2.faansite = g_qryparam.return1       #將開窗取得的值回傳到變數
             DISPLAY g_master2.faansite TO faansite             #顯示到畫面上
             CALL afaq151_get_faansite_desc()
             NEXT FIELD faansite                              #返回原欄位  

        AFTER INPUT
     
     END INPUT
     CONSTRUCT g_wc ON faah032,faah003,faah004,faah001,faah013,faah014,faah018,faah019,faah015,faah025, #161205-00016#1 add faah014
               faah026,faah005,faah006,faaj048,faah027,faah028,faah030,faah031,faajld  #160426-00014#9 add faaj048
          FROM b_faah032,b_faah003,b_faah004,b_faah001,b_faah013,b_faah014,b_faah018,b_faah019,b_faah015,b_faah025, #161205-00016#1 add faah014
               b_faah026,b_faah005,b_faah006,b_faaj048,b_faah027,b_faah028,b_faah030,b_faah031,b_faajld #160426-00014#9 add faaj048
                     
        BEFORE CONSTRUCT
 
          ON ACTION controlp INFIELD b_faah032
	          INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
	          LET g_qryparam.reqry = FALSE
             IF NOT cl_null(g_master2.faansite) THEN 
                #CALL s_fin_create_account_center_tmp() #161111-00049#5 mark
                CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
                CALL s_fin_account_center_comp_str()RETURNING l_origin_str
                CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
                LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN(",l_origin_str CLIPPED,") "
             END IF             
             #CALL q_ooef001()      #161006-00005#22 Mark By Ken 161024
             CALL q_ooef001_2()     #161006-00005#22 Add By Ken 161024
             DISPLAY g_qryparam.return1 TO b_faah032
             NEXT FIELD b_faah032                              #返回原欄位  

        ON ACTION controlp INFIELD b_faah003
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
			  #161111-00049#5 add s--- 
           IF NOT cl_null(g_master2.faansite) THEN 
              CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
              CALL s_fin_account_center_comp_str()RETURNING l_origin_str
              CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
              LET g_qryparam.where = " faah032 IN(",l_origin_str CLIPPED,") "
           END IF			  
			  #161111-00049#5 add e---             
           CALL q_faah003()                       #呼叫開窗
           DISPLAY g_qryparam.return1 TO b_faah003  #顯示到畫面上
           NEXT FIELD b_faah003                     #返回原欄位
           
        ON ACTION controlp INFIELD b_faah004
           INITIALIZE g_qryparam.* TO NULL                                                                                                           
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
			  #161111-00049#5 add s--- 
           IF NOT cl_null(g_master2.faansite) THEN 
              CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
              CALL s_fin_account_center_comp_str()RETURNING l_origin_str
              CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
              LET g_qryparam.where = " faah032 IN(",l_origin_str CLIPPED,") "
           END IF			  
			  #161111-00049#5 add e---               
           CALL q_faah004()                           #呼叫開窗
           DISPLAY g_qryparam.return1 TO b_faah004      #顯示到畫面上
           NEXT FIELD b_faah004   
           
        ON ACTION controlp INFIELD b_faah001
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
			  #161111-00049#5 add s--- 
           IF NOT cl_null(g_master2.faansite) THEN 
              CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
              CALL s_fin_account_center_comp_str()RETURNING l_origin_str
              CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
              LET g_qryparam.where = " faah032 IN(",l_origin_str CLIPPED,") "
           END IF			  
			  #161111-00049#5 add e---               
           CALL q_faah001()                           #呼叫開窗
           DISPLAY g_qryparam.return1 TO b_faah001      #顯示到畫面上
           NEXT FIELD b_faah001                         #返回原欄位    
           
        ON ACTION controlp INFIELD b_faah006
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
			  #161111-00049#5 add s---
           IF NOT cl_null(g_master2.faansite) THEN 
              CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
              CALL s_fin_account_center_comp_str()RETURNING l_origin_str
              CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
              LET g_qryparam.where = " faalld IN (SELECT glaald FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaacomp IN(",l_origin_str CLIPPED,") )"
           END IF		
           CALL q_faal001_1() 
           #161111-00049#5 add e---             
           #CALL q_faac001() #161111-00049#5
           DISPLAY g_qryparam.return1 TO b_faah006      #顯示到畫面上
           NEXT FIELD b_faah006                         #返回原欄位
           
        ON ACTION controlp INFIELD b_faah025
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
           CALL q_ooag001()                         #呼叫開窗
           DISPLAY g_qryparam.return1 TO b_faah025      #顯示到畫面上
           NEXT FIELD b_faah025                         #返回原欄位
           
        ON ACTION controlp INFIELD b_faah026
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
           LET g_qryparam.arg1 = g_today
           CALL q_ooeg001_4()                         #呼叫開窗
           DISPLAY g_qryparam.return1 TO b_faah026      #顯示到畫面上
           NEXT FIELD b_faah026                         #返回原欄位
           
         ON ACTION controlp INFIELD b_faah027
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '3900'
			   #161111-00049#5 add s---
            IF NOT cl_null(g_master2.faansite) THEN 
               CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
               CALL s_fin_account_center_comp_str()RETURNING l_origin_str
               CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
               LET g_qryparam.where = "( oocq004 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 IN (",l_origin_str,")) OR oocq004 IS NULL)"  
            END IF			   
            #161111-00049#5 add e---
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah027  #顯示到畫面上
            NEXT FIELD b_faah027                     #返回原欄位
            
            
         ON ACTION controlp INFIELD b_faah028
            #CALL s_axrt300_get_site(g_user,g_master2.faansite,'1') RETURNING l_comp_str    #161017-00023#1 add lujh #161111-00049#5 mark
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #LET g_qryparam.where = l_comp_str     #161017-00023#1 add lujh #161017-00023#1 mark
			   #161111-00049#5 add s--- 
            IF NOT cl_null(g_master2.faansite) THEN 
               CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
               CALL s_fin_account_center_comp_str()RETURNING l_origin_str
               CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
               LET g_qryparam.where = " ooef017 IN(",l_origin_str CLIPPED,") "
            END IF			  
			   #161111-00049#5 add e--- 			   
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah028  #顯示到畫面上
            NEXT FIELD b_faah028                     #返回原欄位
            
         ON ACTION controlp INFIELD b_faah030
            #CALL s_axrt300_get_site(g_user,g_master2.faansite,'1') RETURNING l_comp_str    #161017-00023#1 add lujh ##161111-00049#5 mark
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #LET g_qryparam.where = " ooef207 = 'Y' AND ",l_comp_str    #161006-00005#22 Add By Ken 161024  #161017-00023#1 add l_comp_str lujh ##161111-00049#5 mark
			   #161111-00049#5 add s--- 
            IF NOT cl_null(g_master2.faansite) THEN 
               CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
               CALL s_fin_account_center_comp_str()RETURNING l_origin_str
               CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
               LET g_qryparam.where = " ooef207 = 'Y' AND ooef017 IN(",l_origin_str CLIPPED,") "
            END IF			  
			   #161111-00049#5 add e--- 	            
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah030  #顯示到畫面上
            NEXT FIELD b_faah030                     #返回原欄位
            
         ON ACTION controlp INFIELD b_faah031
            #CALL s_axrt300_get_site(g_user,g_master2.faansite,'1') RETURNING l_comp_str    #161017-00023#1 add lujh #161111-00049#5 mark
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161017-00023#1--mark--str--lujh
			   #LET g_qryparam.where = " ooef204 = 'Y' OR ooef003 = 'Y' "
            #CALL q_ooef001_10()                           #呼叫開窗
            #161017-00023#1--mark--end--lujh
            #161017-00023#1--add--str--lujh
            #LET g_qryparam.where = " ooef204 = 'Y' AND ",l_comp_str #161111-00049#5 mark
			   #161111-00049#5 add s--- 
            IF NOT cl_null(g_master2.faansite) THEN 
               CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
               CALL s_fin_account_center_comp_str()RETURNING l_origin_str
               CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
               LET g_qryparam.where = " ooef207 = 'Y' AND ooef017 IN(",l_origin_str CLIPPED,") "
            END IF			  
			   #161111-00049#5 add e---            
            CALL q_ooef001()       
            #161017-00023#1--add--end--lujh            
            DISPLAY g_qryparam.return1 TO b_faah031  #顯示到畫面上
            NEXT FIELD b_faah031                     #返回原欄位
            
         ON ACTION controlp INFIELD b_faajld
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_glaald()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faajld  #顯示到畫面上
            NEXT FIELD b_faajld                     #返回原欄位
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
   ELSE
      LET g_master_idx = 1
   END IF
   LET g_error_show = 1
#   CALL afaq151_set_entry()
   CALL afaq151_b_fill()
   LET l_ac = g_master_idx
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
END FUNCTION

################################################################################
# Descriptions...: 獲取資產中心名稱
# Memo...........:
# Usage..........: CALL afaq151_get_faansite_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/01/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq151_get_faansite_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master2.faansite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master2.faansite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master2.faansite_desc
END FUNCTION

################################################################################
# Descriptions...: 填充单身一
# Memo...........:
# Usage..........: CALL afaq151_b2_fill()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/01/05 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq151_b2_fill()
   DEFINE l_origin_str  STRING
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_glaa004     LIKE glaa_t.glaa004
   DEFINE l_faansite_desc LIKE type_t.chr500
   DEFINE l_ld_str      STRING  #160125-00005#7
   DEFINE l_origin_str1 STRING  #160125-00005#7
   
   CALL afaq151_create_tmp()
   DELETE FROM afaq151_tmp01           # 160727-00019#1 Mod  afaq151_print_tmp--> afaq151_tmp01
   LET l_faansite_desc = NULL
   LET l_faansite_desc = g_master2.faansite,"   ",g_master2.faansite_desc
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
   CALL s_fin_account_center_comp_str()RETURNING l_origin_str   
   CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
   #160125-00005#7 add s---   
   LET l_origin_str1=l_origin_str.substring(2,l_origin_str.getLength()-1)
   #账套范围
   CALL s_axrt300_get_site(g_user,l_origin_str1,'2')  RETURNING l_ld_str 
   IF NOT cl_null(l_ld_str) THEN   
      LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faajld")
      LET g_wc = g_wc, " AND ",l_ld_str
   END IF
   #160125-00005#7 add e--- 

   
   LET g_sql = "SELECT  UNIQUE faah032,t7.ooefl003,faah003,faah004,faah001,faah000,faah012,faah013,faah014,faah018,faah019,faah015,faah025,ooag011,faah026,t1.ooefl003,faah005,faah006,faacl003,faaj048,",   #160426-00014#9 add faaj048  #160804-00054#1 add faaj048--->faaj048,
               "               faah027,t2.oocql004,faah028,t3.ooefl003,faah030,t4.ooefl003,faah031,t5.ooefl003,faah039,faajld,faaj014,faaj006,faaj007,t6.ooefl003,faaj025,'',faaj003,faaj008,faaj004,faaj005,faaj016,faaj020,",
               "               faaj028,faaj017,faaj021,faaj019,faah046 ",
               "  FROM faaj_t ",
               "                     LEFT JOIN ooefl_t t6 ON t6.ooeflent='"||g_enterprise||"' AND t6.ooefl001=faaj007 AND t6.ooefl002='"||g_dlang||"' ",
               "      ,faah_t ",
               "                     LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=faah026 AND t1.ooefl002='"||g_dlang||"' ",
               "                     LEFT JOIN oocql_t t2 ON t2.oocqlent='"||g_enterprise||"' AND t2.oocql001='3900' AND t2.oocql002=faah027 AND t2.oocql003='"||g_dlang||"' ",
               "                     LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=faah028 AND t3.ooefl002='"||g_dlang||"' ",
               "                     LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=faah030 AND t4.ooefl002='"||g_dlang||"' ",
               "                     LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=faah031 AND t5.ooefl002='"||g_dlang||"' ",
               "                     LEFT JOIN ooefl_t t7 ON t7.ooeflent='"||g_enterprise||"' AND t7.ooefl001=faah032 AND t7.ooefl002='"||g_dlang||"' ",
               "                     LEFT JOIN faacl_t ON faaclent='"||g_enterprise||"' AND faacl001=faah006 AND faacl002='"||g_dlang||"' ",
               "                     LEFT JOIN ooag_t ON ooagent='"||g_enterprise||"' AND ooag001 = faah025 ",
               " WHERE faajent = faahent ",
               "   AND faaj001 = faah003 ",
               "   AND faaj002 = faah004 ",
               "   AND faaj037 = faah001 ",
#               "   AND faah015 <> '10' ",
               "   AND faahstus <> 'X' ",
               "   AND faahent = '",g_enterprise,"'",
               "   AND faah032 IN(",l_origin_str CLIPPED,")",
               "   AND ",g_wc CLIPPED, 
               " ORDER BY faah003,faah004,faah001 "
   PREPARE afaq151_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR afaq151_pb2
   CALL g_faah_d.clear()
   LET g_cnt = l_ac
   LET l_ac = 1   
   FOREACH b_fill_curs2 INTO g_faah_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = g_faah_d[l_ac].faah032
         AND glaa015 ='Y'
      IF l_n > 0 THEN 
         LET g_glaa015 = 'Y'  #報表參數
         CALL cl_set_comp_visible("page_2",TRUE)
         CALL cl_set_comp_visible("b_faaj101_2,b_faaj103_2,b_faaj108_2,b_faaj104_2,b_faaj112_2,b_faaj105_2",TRUE)
      END IF 
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = g_faah_d[l_ac].faah032
         AND glaa019 ='Y'
      IF l_n > 0 THEN 
         LET g_glaa019 = 'Y'  #報表參數
         CALL cl_set_comp_visible("page_2",TRUE)
         CALL cl_set_comp_visible("b_faaj151_2,b_faaj153_2,b_faaj158_2,b_faaj161_2,b_faaj162_2,b_faaj155_2",TRUE)
      END IF 
      SELECT glaa004 INTO l_glaa004
        FROM glaa_t
       WHERE glaaent =  g_enterprise
         AND glaald = g_faah_d[l_ac].faajld
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaa004
      LET g_ref_fields[2] = g_faah_d[l_ac].faaj025
      CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_faah_d[l_ac].faaj025_desc = '', g_rtn_fields[1] , ''
      #資產性質
      CASE g_faah_d[l_ac].faah005
         WHEN '1'
                 LET g_faah_d[l_ac].faah005 = cl_getmsg("afa-00424",g_lang)
         WHEN '2'
                 LET g_faah_d[l_ac].faah005 = cl_getmsg("afa-00425",g_lang)
         WHEN '3'
                 LET g_faah_d[l_ac].faah005 = cl_getmsg("afa-00426",g_lang)
         WHEN '4'
                 LET g_faah_d[l_ac].faah005 = cl_getmsg("afa-00427",g_lang)
         WHEN '5'
                 LET g_faah_d[l_ac].faah005 = cl_getmsg("afa-00428",g_lang)
      END CASE 
      #資產狀態
      CASE g_faah_d[l_ac].faah015
         WHEN '0'
                LET g_faah_d[l_ac].faah015 = cl_getmsg("afa-00438",g_lang)
         WHEN '1'
                LET g_faah_d[l_ac].faah015 = cl_getmsg("afa-00439",g_lang)
         WHEN '2'
                LET g_faah_d[l_ac].faah015 = cl_getmsg("afa-00440",g_lang)
         WHEN '3'
                LET g_faah_d[l_ac].faah015 = cl_getmsg("afa-00441",g_lang)
         WHEN '4'
                LET g_faah_d[l_ac].faah015 = cl_getmsg("afa-00442",g_lang)
         WHEN '5'
                LET g_faah_d[l_ac].faah015 = cl_getmsg("afa-00443",g_lang)
         WHEN '6'
                LET g_faah_d[l_ac].faah015 = cl_getmsg("afa-00444",g_lang)
         WHEN '7'
                LET g_faah_d[l_ac].faah015 = cl_getmsg("afa-00445",g_lang)
         WHEN '8'
                LET g_faah_d[l_ac].faah015 = cl_getmsg("afa-00446",g_lang)
         WHEN '9'
                LET g_faah_d[l_ac].faah015 = cl_getmsg("afa-00447",g_lang)
         WHEN '10'
                LET g_faah_d[l_ac].faah015 = cl_getmsg("afa-00448",g_lang)
      END CASE 
      #折舊方式
      CASE g_faah_d[l_ac].faaj003
         WHEN '1'
                LET g_faah_d[l_ac].faaj003 = cl_getmsg("afa-00429",g_lang)
         WHEN '2'
                LET g_faah_d[l_ac].faaj003 = cl_getmsg("afa-00430",g_lang)
         WHEN '3'
                LET g_faah_d[l_ac].faaj003 = cl_getmsg("afa-00431",g_lang)
         WHEN '4'
                LET g_faah_d[l_ac].faaj003 = cl_getmsg("afa-00432",g_lang)
         WHEN '5'
                LET g_faah_d[l_ac].faaj003 = cl_getmsg("afa-00433",g_lang)
         WHEN '6'
                LET g_faah_d[l_ac].faaj003 = cl_getmsg("afa-00434",g_lang)
      END CASE 
      #分攤方式
      CASE g_faah_d[l_ac].faaj006
         WHEN '1'
                LET g_faah_d[l_ac].faaj006 = cl_getmsg("afa-00435",g_lang)
         WHEN '2'
                LET g_faah_d[l_ac].faaj006 = cl_getmsg("afa-00436",g_lang)
         WHEN '3'
                LET g_faah_d[l_ac].faaj006 = cl_getmsg("afa-00437",g_lang)
      END CASE 
      
      #yangtt 2015/05/18--add---XG报表用
      INSERT INTO afaq151_tmp01(faansite_desc,faah032,faah032_desc,faah003,faah004,faah001,faah000,faah012,faah013,faah014,    # 160727-00019#1 Mod  afaq151_print_tmp--> afaq151_tmp01
              faah018,faah019,faah015,faah025,faah025_desc,faah026,faah026_desc,faah005,faah006,faah006_desc, 
              faah027,faah027_desc,faah028,faah028_desc,faah030,faah030_desc,faah031,faah031_desc,faah039,faajld,
              faaj014,faaj006,faaj007,faaj007_desc,faaj025,faaj025_desc,faaj003,faaj008, 
              faaj004,faaj005,faaj016,faaj020,faaj028,faaj017,faaj021,faaj019,faah046)
       VALUES(l_faansite_desc,g_faah_d[l_ac].*)
      
#      IF l_ac > g_max_rec THEN
#         IF g_error_show = 1 THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend =  "" 
#            LET g_errparam.code   =  9035 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
# 
#         END IF
#         EXIT FOREACH
#      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   CALL g_faah_d.deleteElement(g_faah_d.getLength())   
   LET g_detail_cnt = g_faah_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   LET l_ac = 1
   CALL afaq151_fetch()
 
END FUNCTION

################################################################################
# Descriptions...: 设置栏位开启关闭
# Memo...........:
# Usage..........: CALL afaq151_set_entry()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/01/08 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq151_set_entry()
   DEFINE l_glaa015   LIKE glaa_t.glaa015
   DEFINE l_glaa019   LIKE glaa_t.glaa019
   DEFINE l_n         LIKE type_t.num5
   
#   SELECT glaa015,glaa019
#     INTO l_glaa015,l_glaa019
#     FROM glaa_t
#    WHERE glaald = g_master2.faanld
#      AND glaaent = g_enterprise
   CALL cl_set_comp_visible("b_faaj101_2,b_faaj103_2,b_faaj108_2,b_faaj104_2,b_faaj112_2,b_faaj105_2",FALSE)
   CALL cl_set_comp_visible("b_faaj151_2,b_faaj153_2,b_faaj158_2,b_faaj161_2,b_faaj162_2,b_faaj155_2",FALSE)
   IF l_glaa015 = 'Y' THEN 
      CALL cl_set_comp_visible("b_faaj101_2,b_faaj103_2,b_faaj108_2,b_faaj104_2,b_faaj112_2,b_faaj105_2",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_faaj101_2,b_faaj103_2,b_faaj108_2,b_faaj104_2,b_faaj112_2,b_faaj105_2",FALSE)
   END IF 
   IF l_glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible("b_faaj151_2,b_faaj153_2,b_faaj158_2,b_faaj161_2,b_faaj162_2,b_faaj155_2",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_faaj151_2,b_faaj153_2,b_faaj158_2,b_faaj161_2,b_faaj162_2,b_faaj155_2",FALSE)
   END IF
   IF l_glaa015 != 'Y' AND l_glaa019 != 'Y' THEN 
      CALL cl_set_comp_visible("page_2",FALSE)
   ELSE
      CALL cl_set_comp_visible("page_2",TRUE)
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 新建臨時表
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq151_create_tmp()
      DROP TABLE afaq151_tmp01;            # 160727-00019#1 Mod  afaq151_print_tmp--> afaq151_tmp01
      CREATE TEMP TABLE afaq151_tmp01(     # 160727-00019#1 Mod  afaq151_print_tmp--> afaq151_tmp01
   faansite_desc  VARCHAR(500),
   faah032  VARCHAR(10), 
   faah032_desc  VARCHAR(500), 
   faah003  VARCHAR(20), 
   faah004  VARCHAR(20), 
   faah001  VARCHAR(10), 
   faah000  VARCHAR(10), 
   faah012  VARCHAR(255), 
   faah013  VARCHAR(255), 
   faah014  DATE, 
   faah018  DECIMAL(20,6), 
   faah019  DECIMAL(20,6), 
   faah015  VARCHAR(80), 
   faah025  VARCHAR(20), 
   faah025_desc  VARCHAR(500), 
   faah026  VARCHAR(10), 
   faah026_desc  VARCHAR(500), 
   faah005  VARCHAR(80), 
   faah006  VARCHAR(10), 
   faah006_desc  VARCHAR(500), 
   faah027  VARCHAR(10), 
   faah027_desc  VARCHAR(500), 
   faah028  VARCHAR(10), 
   faah028_desc  VARCHAR(500), 
   faah030  VARCHAR(10), 
   faah030_desc  VARCHAR(500),
   faah031  VARCHAR(10),
   faah031_desc  VARCHAR(500),
   faah039  VARCHAR(20),
   faajld  VARCHAR(5),
   faaj014  VARCHAR(10), 
   faaj006  VARCHAR(80), 
   faaj007  VARCHAR(80), 
   faaj007_desc  VARCHAR(500), 
   faaj025  VARCHAR(24), 
   faaj025_desc  VARCHAR(500), 
   faaj003  VARCHAR(80), 
   faaj008  VARCHAR(10), 
   faaj004  INTEGER, 
   faaj005  INTEGER, 
   faaj016  DECIMAL(20,6), 
   faaj020  DECIMAL(20,6), 
   faaj028  DECIMAL(20,6), 
   faaj017  DECIMAL(20,6), 
   faaj021  DECIMAL(20,6), 
   faaj019  DECIMAL(20,6), 
   faah046  VARCHAR(255),
   faaj101  VARCHAR(10), 
   faaj103  DECIMAL(20,6), 
   faaj117  DECIMAL(20,6), 
   faaj108  DECIMAL(20,6), 
   faaj104  DECIMAL(20,6), 
   faaj112  DECIMAL(20,6), 
   faaj105  DECIMAL(20,6), 
   faaj151  VARCHAR(10), 
   faaj153  DECIMAL(20,6), 
   faaj167  DECIMAL(20,6), 
   faaj158  DECIMAL(20,6), 
   faaj161  DECIMAL(20,6), 
   faaj162  DECIMAL(20,6), 
   faaj155  DECIMAL(20,6)
                   )
END FUNCTION

 
{</section>}
 
