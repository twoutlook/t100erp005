#該程式未解開Section, 採用最新樣板產出!
{<section id="asfq360.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2015-04-24 10:43:47), PR版次:0004(2015-04-24 11:06:27)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000101
#+ Filename...: asfq360
#+ Description:  工單挪料查詢
#+ Creator....: 00768(2014-05-14 14:37:10)
#+ Modifier...: 05426 -SD/PR- 05426
 
{</section>}
 
{<section id="asfq360.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"

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
PRIVATE TYPE type_g_sfla_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   sfladocno LIKE sfla_t.sfladocno, 
   sfladocdt LIKE sfla_t.sfladocdt, 
   sfla001 LIKE sfla_t.sfla001, 
   sfla002 LIKE sfla_t.sfla002, 
   ooag011 LIKE type_t.chr500, 
   sfla003 LIKE sfla_t.sfla003, 
   prog_b_asft311 STRING, 
   prog_asft321 STRING, 
   sfla004 LIKE sfla_t.sfla004 
       END RECORD
PRIVATE TYPE type_g_sfla2_d RECORD
       sflb001 LIKE sflb_t.sflb001, 
   prog_asft300 STRING, 
   sfaa002 LIKE sfaa_t.sfaa002, 
   ooag011 LIKE ooag_t.ooag011, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   sflb002 LIKE sflb_t.sflb002, 
   sflb005 LIKE sflb_t.sflb005, 
   sfld002 LIKE sfld_t.sfld002, 
   sfld003 LIKE sfld_t.sfld003, 
   sfba002 LIKE sfba_t.sfba002, 
   sfba003 LIKE sfba_t.sfba003, 
   sfba004 LIKE sfba_t.sfba004, 
   sfld004 LIKE sfld_t.sfld004, 
   imaal003t LIKE type_t.chr500, 
   imaal004t LIKE type_t.chr500, 
   sfba021 LIKE sfba_t.sfba021, 
   sfba014 LIKE sfba_t.sfba014, 
   sfld009 LIKE sfld_t.sfld009
       END RECORD
 
PRIVATE TYPE type_g_sfla3_d RECORD
       sflc001 LIKE sflc_t.sflc001, 
   prog_asft300_sflc001 STRING, 
   sfaa002 LIKE sfaa_t.sfaa002, 
   ooag011 LIKE ooag_t.ooag011, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   sflc002 LIKE sflc_t.sflc002, 
   sflc005 LIKE sflc_t.sflc005, 
   sfle002 LIKE sfle_t.sfle002, 
   sfle003 LIKE sfle_t.sfle003, 
   sfba002 LIKE sfba_t.sfba002, 
   sfba003 LIKE sfba_t.sfba003, 
   sfcb004 LIKE sfcb_t.sfcb004, 
   sfle004 LIKE sfle_t.sfle004, 
   imaal003f LIKE type_t.chr500, 
   imaal004f LIKE type_t.chr500, 
   sfba021 LIKE sfba_t.sfba021, 
   sfba014 LIKE sfba_t.sfba014, 
   sfle009 LIKE sfle_t.sfle009
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_sfla_d
DEFINE g_master_t                   type_g_sfla_d
DEFINE g_sfla_d          DYNAMIC ARRAY OF type_g_sfla_d
DEFINE g_sfla_d_t        type_g_sfla_d
DEFINE g_sfla2_d   DYNAMIC ARRAY OF type_g_sfla2_d
DEFINE g_sfla2_d_t type_g_sfla2_d
 
DEFINE g_sfla3_d   DYNAMIC ARRAY OF type_g_sfla3_d
DEFINE g_sfla3_d_t type_g_sfla3_d
 
 
      
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
 
DEFINE g_wc2_table2   STRING
DEFINE g_wc2_filter_table2    STRING
DEFINE g_detail2_page_action2 STRING
 
DEFINE g_wc2_table3   STRING
DEFINE g_wc2_filter_table3    STRING
DEFINE g_detail2_page_action3 STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

##end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="asfq360.main" >}
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
   CALL cl_ap_init("asf","")
 
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
   DECLARE asfq360_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE asfq360_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asfq360_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfq360 WITH FORM cl_ap_formpath("asf",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asfq360_init()   
 
      #進入選單 Menu (="N")
      CALL asfq360_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asfq360
      
   END IF 
   
   CLOSE asfq360_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asfq360.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION asfq360_init()
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
   CALL cl_set_combo_scc('b_sfla001','4038')
   #end add-point
 
   CALL asfq360_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="asfq360.default_search" >}
PRIVATE FUNCTION asfq360_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " sfladocno = '", g_argv[01], "' AND "
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
 
{<section id="asfq360.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION asfq360_ui_dialog()
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
      CALL asfq360_b_fill()
   ELSE
      CALL asfq360_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_sfla_d.clear()
         CALL g_sfla2_d.clear()
 
         CALL g_sfla3_d.clear()
 
 
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
 
         CALL asfq360_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_sfla_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL asfq360_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL asfq360_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
 
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page1_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_asft311
                  LET g_action_choice="prog_asft311"
                  IF cl_auth_chk_act("prog_asft311") THEN
                     
                     #add-point:ON ACTION prog_asft311 name="menu.detail_show.page1_sub.prog_asft311"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'asft311'
               LET la_param.param[1] = g_sfla_d[g_detail_idx].sfla003

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


                     #END add-point
                     
                     
                  END IF
 
 
 
               #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_asft321
                  LET g_action_choice="prog_asft321"
                  IF cl_auth_chk_act("prog_asft321") THEN
                     
                     #add-point:ON ACTION prog_asft321 name="menu.detail_show.page1_sub.prog_asft321"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'asft321'
               LET la_param.param[1] = g_sfla_d[g_detail_idx].sfla004

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
      
 
         
         DISPLAY ARRAY g_sfla2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_sfla2_d.getLength() TO FORMONLY.cnt
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point 
 
            #自訂ACTION(detail_show,page_2)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page2_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_asft300
                  LET g_action_choice="prog_asft300"
                  IF cl_auth_chk_act("prog_asft300") THEN
                     
                     #add-point:ON ACTION prog_asft300 name="menu.detail_show.page2_sub.prog_asft300"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'asft300'
               LET la_param.param[1] = g_sfla2_d[g_detail_idx2].sflb001

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
 
         DISPLAY ARRAY g_sfla3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_sfla3_d.getLength() TO FORMONLY.cnt
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point 
 
            #自訂ACTION(detail_show,page_3)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page3_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_asft300
                  LET g_action_choice="prog_asft300"
                  IF cl_auth_chk_act("prog_asft300") THEN
                     
                     #add-point:ON ACTION prog_asft300 name="menu.detail_show.page3_sub.prog_asft300"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'asft300'
               LET la_param.param[1] = g_sfla3_d[g_detail_idx2].sflc001

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


                     #END add-point
                     
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page3.detail_qrystr"
               
               #END add-point
               
 
 
 
 
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL asfq360_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL asfq360_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL asfq360_query()
               #add-point:ON ACTION query name="menu.query"
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
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
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL asfq360_filter()
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
            CALL asfq360_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_sfla_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_sfla2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_sfla3_d)
               LET g_export_id[3]   = "s_detail3"
 
 
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
            CALL asfq360_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL asfq360_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL asfq360_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL asfq360_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_sfla_d.getLength()
               LET g_sfla_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_sfla_d.getLength()
               LET g_sfla_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_sfla_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_sfla_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_sfla_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_sfla_d[li_idx].sel = "N"
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
 
{<section id="asfq360.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION asfq360_query()
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
   CALL g_sfla_d.clear()
   CALL g_sfla2_d.clear()
 
   CALL g_sfla3_d.clear()
 
 
   
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
 
   #應用 qs02 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT前，需先將查詢欄位開啟、顯示欄位隱藏 
   CALL gfrm_curr.setFieldHidden('prog_b_asft311', TRUE) 
   CALL gfrm_curr.setFieldHidden('b_sfla003', FALSE) 
   CALL gfrm_curr.setFieldHidden('prog_asft321', TRUE)
   CALL gfrm_curr.setFieldHidden('b_sfla004', FALSE)
   CALL gfrm_curr.setFieldHidden('prog_asft300', TRUE)
   CALL gfrm_curr.setFieldHidden('b_sflb001', FALSE)
   CALL gfrm_curr.setFieldHidden('prog_asft300_sflc001', TRUE)
   CALL gfrm_curr.setFieldHidden('b_sflc001', FALSE)
 
  
 
 
 
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON sfladocno,sfladocdt,sfla001,sfla002,sfla003,sfla004
           FROM s_detail1[1].b_sfladocno,s_detail1[1].b_sfladocdt,s_detail1[1].b_sfla001,s_detail1[1].b_sfla002, 
               s_detail1[1].b_sfla003,s_detail1[1].b_sfla004
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_sfladocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfladocno
            #add-point:BEFORE FIELD b_sfladocno name="construct.b.page1.b_sfladocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfladocno
            
            #add-point:AFTER FIELD b_sfladocno name="construct.a.page1.b_sfladocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_sfladocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfladocno
            #add-point:ON ACTION controlp INFIELD b_sfladocno name="construct.c.page1.b_sfladocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " sflasite ='",g_site,"' "
            CALL q_sfladocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfladocno #顯示到畫面上
            NEXT FIELD b_sfladocno                   #返回原欄位
            #END add-point
 
 
         #----<<b_sfladocdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfladocdt
            #add-point:BEFORE FIELD b_sfladocdt name="construct.b.page1.b_sfladocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfladocdt
            
            #add-point:AFTER FIELD b_sfladocdt name="construct.a.page1.b_sfladocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_sfladocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfladocdt
            #add-point:ON ACTION controlp INFIELD b_sfladocdt name="construct.c.page1.b_sfladocdt"
            
            #END add-point
 
 
         #----<<b_sfla001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfla001
            #add-point:BEFORE FIELD b_sfla001 name="construct.b.page1.b_sfla001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfla001
            
            #add-point:AFTER FIELD b_sfla001 name="construct.a.page1.b_sfla001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_sfla001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfla001
            #add-point:ON ACTION controlp INFIELD b_sfla001 name="construct.c.page1.b_sfla001"
            
            #END add-point
 
 
         #----<<b_sfla002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfla002
            #add-point:BEFORE FIELD b_sfla002 name="construct.b.page1.b_sfla002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfla002
            
            #add-point:AFTER FIELD b_sfla002 name="construct.a.page1.b_sfla002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_sfla002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfla002
            #add-point:ON ACTION controlp INFIELD b_sfla002 name="construct.c.page1.b_sfla002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfla002 #顯示到畫面上
            NEXT FIELD b_sfla002                   #返回原欄位
            #END add-point
 
 
         #----<<ooag011>>----
         #----<<b_sfla003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfla003
            #add-point:BEFORE FIELD b_sfla003 name="construct.b.page1.b_sfla003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfla003
            
            #add-point:AFTER FIELD b_sfla003 name="construct.a.page1.b_sfla003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_sfla003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfla003
            #add-point:ON ACTION controlp INFIELD b_sfla003 name="construct.c.page1.b_sfla003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " sfda002 like '1%' "
            CALL q_sfdadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfla003 #顯示到畫面上
            NEXT FIELD b_sfla003                  #返回原欄位
            #END add-point
 
 
         #----<<prog_b_asft311>>----
         #----<<prog_asft321>>----
         #----<<b_sfla004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfla004
            #add-point:BEFORE FIELD b_sfla004 name="construct.b.page1.b_sfla004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfla004
            
            #add-point:AFTER FIELD b_sfla004 name="construct.a.page1.b_sfla004"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_sfla004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfla004
            #add-point:ON ACTION controlp INFIELD b_sfla004 name="construct.c.page1.b_sfla004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " sfda002 like '2%' "
            CALL q_sfdadocno()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfla004 #顯示到畫面上
            NEXT FIELD b_sfla004                  #返回原欄位
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON sflb001,sflb002,sflb005,sfld002,sfld003,sfld004,sfld009
           FROM s_detail2[1].b_sflb001,s_detail2[1].b_sflb002,s_detail2[1].b_sflb005,s_detail2[1].b_sfld002, 
               s_detail2[1].b_sfld003,s_detail2[1].b_sfld004,s_detail2[1].b_sfld009
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #----<<b_sflb001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sflb001
            #add-point:BEFORE FIELD b_sflb001 name="construct.b.page2.b_sflb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sflb001
            
            #add-point:AFTER FIELD b_sflb001 name="construct.a.page2.b_sflb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_sflb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sflb001
            #add-point:ON ACTION controlp INFIELD b_sflb001 name="construct.c.page2.b_sflb001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfaadocno_3()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sflb001 #顯示到畫面上
            NEXT FIELD b_sflb001                  #返回原欄位
            #END add-point
 
 
         #----<<prog_asft300>>----
         #----<<sfaa002_t>>----
         #----<<ooag011_t>>----
         #----<<sfaa010_t>>----
         #----<<imaal003_t>>----
         #----<<imaal004_t>>----
         #----<<b_sflb002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sflb002
            #add-point:BEFORE FIELD b_sflb002 name="construct.b.page2.b_sflb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sflb002
            
            #add-point:AFTER FIELD b_sflb002 name="construct.a.page2.b_sflb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_sflb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sflb002
            #add-point:ON ACTION controlp INFIELD b_sflb002 name="construct.c.page2.b_sflb002"
            
            #END add-point
 
 
         #----<<b_sflb005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sflb005
            #add-point:BEFORE FIELD b_sflb005 name="construct.b.page2.b_sflb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sflb005
            
            #add-point:AFTER FIELD b_sflb005 name="construct.a.page2.b_sflb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_sflb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sflb005
            #add-point:ON ACTION controlp INFIELD b_sflb005 name="construct.c.page2.b_sflb005"
            
            #END add-point
 
 
         #----<<b_sfld002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfld002
            #add-point:BEFORE FIELD b_sfld002 name="construct.b.page2.b_sfld002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfld002
            
            #add-point:AFTER FIELD b_sfld002 name="construct.a.page2.b_sfld002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_sfld002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfld002
            #add-point:ON ACTION controlp INFIELD b_sfld002 name="construct.c.page2.b_sfld002"
            
            #END add-point
 
 
         #----<<b_sfld003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfld003
            #add-point:BEFORE FIELD b_sfld003 name="construct.b.page2.b_sfld003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfld003
            
            #add-point:AFTER FIELD b_sfld003 name="construct.a.page2.b_sfld003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_sfld003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfld003
            #add-point:ON ACTION controlp INFIELD b_sfld003 name="construct.c.page2.b_sfld003"
            
            #END add-point
 
 
         #----<<sfba002_t>>----
         #----<<sfba003_t>>----
         #----<<sfba004_t>>----
         #----<<b_sfld004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfld004
            #add-point:BEFORE FIELD b_sfld004 name="construct.b.page2.b_sfld004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfld004
            
            #add-point:AFTER FIELD b_sfld004 name="construct.a.page2.b_sfld004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_sfld004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfld004
            #add-point:ON ACTION controlp INFIELD b_sfld004 name="construct.c.page2.b_sfld004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfba006()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfld004 #顯示到畫面上
            NEXT FIELD b_sfld004                  #返回原欄位
            #END add-point
 
 
         #----<<imaal003t>>----
         #----<<imaal004t>>----
         #----<<sfba021_t>>----
         #----<<sfba014_t>>----
         #----<<b_sfld009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfld009
            #add-point:BEFORE FIELD b_sfld009 name="construct.b.page2.b_sfld009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfld009
            
            #add-point:AFTER FIELD b_sfld009 name="construct.a.page2.b_sfld009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_sfld009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfld009
            #add-point:ON ACTION controlp INFIELD b_sfld009 name="construct.c.page2.b_sfld009"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON sflc001,sflc002,sflc005,sfle002,sfle003,sfle004,sfle009
           FROM s_detail3[1].b_sflc001,s_detail3[1].b_sflc002,s_detail3[1].b_sflc005,s_detail3[1].b_sfle002, 
               s_detail3[1].b_sfle003,s_detail3[1].b_sfle004,s_detail3[1].b_sfle009
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #----<<b_sflc001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sflc001
            #add-point:BEFORE FIELD b_sflc001 name="construct.b.page3.b_sflc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sflc001
            
            #add-point:AFTER FIELD b_sflc001 name="construct.a.page3.b_sflc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_sflc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sflc001
            #add-point:ON ACTION controlp INFIELD b_sflc001 name="construct.c.page3.b_sflc001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfaadocno_3()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sflc001 #顯示到畫面上
            NEXT FIELD b_sflc001                  #返回原欄位
            #END add-point
 
 
         #----<<prog_asft300_sflc001>>----
         #----<<sfaa002_f>>----
         #----<<ooag011_f>>----
         #----<<sfaa010_f>>----
         #----<<imaal003_f>>----
         #----<<imaal004_f>>----
         #----<<b_sflc002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sflc002
            #add-point:BEFORE FIELD b_sflc002 name="construct.b.page3.b_sflc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sflc002
            
            #add-point:AFTER FIELD b_sflc002 name="construct.a.page3.b_sflc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_sflc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sflc002
            #add-point:ON ACTION controlp INFIELD b_sflc002 name="construct.c.page3.b_sflc002"
            
            #END add-point
 
 
         #----<<b_sflc005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sflc005
            #add-point:BEFORE FIELD b_sflc005 name="construct.b.page3.b_sflc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sflc005
            
            #add-point:AFTER FIELD b_sflc005 name="construct.a.page3.b_sflc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_sflc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sflc005
            #add-point:ON ACTION controlp INFIELD b_sflc005 name="construct.c.page3.b_sflc005"
            
            #END add-point
 
 
         #----<<b_sfle002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfle002
            #add-point:BEFORE FIELD b_sfle002 name="construct.b.page3.b_sfle002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfle002
            
            #add-point:AFTER FIELD b_sfle002 name="construct.a.page3.b_sfle002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_sfle002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfle002
            #add-point:ON ACTION controlp INFIELD b_sfle002 name="construct.c.page3.b_sfle002"
            
            #END add-point
 
 
         #----<<b_sfle003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfle003
            #add-point:BEFORE FIELD b_sfle003 name="construct.b.page3.b_sfle003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfle003
            
            #add-point:AFTER FIELD b_sfle003 name="construct.a.page3.b_sfle003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_sfle003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfle003
            #add-point:ON ACTION controlp INFIELD b_sfle003 name="construct.c.page3.b_sfle003"
            
            #END add-point
 
 
         #----<<sfba002_f>>----
         #----<<sfba003_f>>----
         #----<<sfcb004_f>>----
         #----<<b_sfle004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfle004
            #add-point:BEFORE FIELD b_sfle004 name="construct.b.page3.b_sfle004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfle004
            
            #add-point:AFTER FIELD b_sfle004 name="construct.a.page3.b_sfle004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_sfle004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfle004
            #add-point:ON ACTION controlp INFIELD b_sfle004 name="construct.c.page3.b_sfle004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfba006()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfle004 #顯示到畫面上
            NEXT FIELD b_sfle004                  #返回原欄位
            #END add-point
 
 
         #----<<imaal003f>>----
         #----<<imaal004f>>----
         #----<<sfba021_f>>----
         #----<<sfba014_f>>----
         #----<<b_sfle009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfle009
            #add-point:BEFORE FIELD b_sfle009 name="construct.b.page3.b_sfle009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfle009
            
            #add-point:AFTER FIELD b_sfle009 name="construct.a.page3.b_sfle009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_sfle009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfle009
            #add-point:ON ACTION controlp INFIELD b_sfle009 name="construct.c.page3.b_sfle009"
            
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
 
   #應用 qs03 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT後，需先將顯示欄位開啟、查詢欄位隱藏 
   CALL gfrm_curr.setFieldHidden('b_sfla003', TRUE) 
   CALL gfrm_curr.setFieldHidden('prog_b_asft311', FALSE) 
   CALL gfrm_curr.setFieldHidden('b_sfla004', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_asft321', FALSE)
   CALL gfrm_curr.setFieldHidden('b_sflb001', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_asft300', FALSE)
   CALL gfrm_curr.setFieldHidden('b_sflc001', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_asft300_sflc001', FALSE)
 
  
 
 
 
 
   LET g_wc = g_wc_table 
 
   IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
      LET g_wc = g_wc, " AND ", g_wc2_table2
   END IF
 
   IF NOT cl_null(g_wc2_table3) AND g_wc2_table3 <> " 1=1" THEN
      LET g_wc = g_wc, " AND ", g_wc2_table3
   END IF
 
 
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2, " AND ", g_wc2_table2
   END IF
 
   IF NOT cl_null(g_wc2_table3) AND g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2, " AND ", g_wc2_table3
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
   CALL asfq360_b_fill()
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
 
{<section id="asfq360.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asfq360_b_fill()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',sfladocno,sfladocdt,sfla001,sfla002,'',sfla003,sfla004  ,DENSE_RANK() OVER( ORDER BY sfla_t.sfladocno) AS RANK FROM sfla_t", 
 
 
                     " LEFT JOIN sflb_t ON sflbent = sflaent AND sflbsite = sflasite AND sfladocno = sflbdocno",
 
                     " LEFT JOIN sflc_t ON sflcent = sflaent AND sflcsite = sflasite AND sfladocno = sflcdocno",
 
 
                     "",
                     " WHERE sflaent= ? AND sflasite= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("sfla_t"),
                     " ORDER BY sfla_t.sfladocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre USING g_enterprise, g_site INTO g_tot_cnt
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
 
   LET g_sql = "SELECT '',sfladocno,sfladocdt,sfla001,sfla002,'',sfla003,sfla004",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   ##g_sql 重新定义
   #LET g_sql = "SELECT  UNIQUE sfladocno,sfladocdt,sfla001,sfla002,'',sfla003,sfla004 ",
   #            "  FROM sfla_t,sflb_t,sflc_t,sfld_t,sfle_t ",
   #            " WHERE sflbent = sflaent AND sflbsite = sflasite AND sflbdocno = sfladocno ",
   #            "   AND sflcent = sflaent AND sflcsite = sflasite AND sflcdocno = sfladocno ",           
   #            "   AND sflbent = sfldent AND sflbsite = sfldsite AND sflbdocno = sflddocno AND sflbseq = sfldseq ",
   #            "   AND sflcent = sfleent AND sflcsite = sflesite AND sflcdocno = sfledocno AND sflcseq = sfleseq ",
   #            "   AND sflaent= ? AND sflasite= ? AND 1=1 AND ", ls_wc
   #LET g_sql = g_sql, " ORDER BY sfla_t.sfladocno"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asfq360_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asfq360_pb
   
   OPEN b_fill_curs USING g_enterprise, g_site
 
   CALL g_sfla_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_sfla_d[l_ac].sel,g_sfla_d[l_ac].sfladocno,g_sfla_d[l_ac].sfladocdt,g_sfla_d[l_ac].sfla001, 
       g_sfla_d[l_ac].sfla002,g_sfla_d[l_ac].ooag011,g_sfla_d[l_ac].sfla003,g_sfla_d[l_ac].sfla004
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_sfla_d[l_ac].statepic = cl_get_actipic(g_sfla_d[l_ac].statepic)
 
      #應用 qs24 樣板自動產生(Version:5) 
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = asfq360_get_hyper_data("prog_b_asft311")
         LET g_sfla_d[l_ac].prog_b_asft311 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_sfla_d[l_ac].sfla003), 
             "</a>"
         LET g_hyper_url = asfq360_get_hyper_data("prog_asft321")
         LET g_sfla_d[l_ac].prog_asft321 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_sfla_d[l_ac].sfla004), 
             "</a>"
 
      ELSE 
         LET g_sfla_d[l_ac].prog_b_asft311 = g_sfla_d[l_ac].sfla003
         LET g_sfla_d[l_ac].prog_asft321 = g_sfla_d[l_ac].sfla004
 
      END IF 
 
 
 
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL asfq360_detail_show("'1'")      
 
      CALL asfq360_sfla_t_mask()
 
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
   
 
   
   CALL g_sfla_d.deleteElement(g_sfla_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_sfla_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE asfq360_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL asfq360_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL asfq360_detail_action_trans()
 
   IF g_sfla_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL asfq360_fetch()
   END IF
   
      CALL asfq360_filter_show('sfladocno','b_sfladocno')
   CALL asfq360_filter_show('sfladocdt','b_sfladocdt')
   CALL asfq360_filter_show('sfla001','b_sfla001')
   CALL asfq360_filter_show('sfla002','b_sfla002')
   CALL asfq360_filter_show('sfla003','b_sfla003')
   CALL asfq360_filter_show('sfla004','b_sfla004')
   CALL asfq360_filter_show('sflb001','b_sflb001')
   CALL asfq360_filter_show('sflb002','b_sflb002')
   CALL asfq360_filter_show('sflb005','b_sflb005')
   CALL asfq360_filter_show('sfld002','b_sfld002')
   CALL asfq360_filter_show('sfld003','b_sfld003')
   CALL asfq360_filter_show('sfld004','b_sfld004')
   CALL asfq360_filter_show('sfld009','b_sfld009')
   CALL asfq360_filter_show('sflc001','b_sflc001')
   CALL asfq360_filter_show('sflc002','b_sflc002')
   CALL asfq360_filter_show('sflc005','b_sflc005')
   CALL asfq360_filter_show('sfle002','b_sfle002')
   CALL asfq360_filter_show('sfle003','b_sfle003')
   CALL asfq360_filter_show('sfle004','b_sfle004')
   CALL asfq360_filter_show('sfle009','b_sfle009')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfq360.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asfq360_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   CALL g_sfla2_d.clear()
 
   CALL g_sfla3_d.clear()
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
      LET g_detail_idx = 1
   END IF
   #end add-point
   
   LET li_ac = l_ac 
   
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE sflb001,'','','','','',sflb002,sflb005,'','','','','','','','','', 
          '','' FROM sflb_t",    
                  "",
                  " WHERE sflbent=? AND sflbsite=? AND sflbdocno=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY sflb_t.sflbseq" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"
   LET g_sql = "SELECT UNIQUE sfld001,'','','','','',sflb002,sflb005,sfld002,sfld003,'','','',sfld004,'','','','',sfld009 ",    
               "  FROM sfld_t LEFT JOIN sflb_t ON sflbent = sfldent AND sflbsite = sfldsite AND sflbdocno = sflddocno AND sflbseq = sfldseq ",
               " WHERE sfldent=? AND sfldsite=? AND sflddocno=?"
 
   IF NOT cl_null(g_wc2_table2) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY sfld_t.sfld001" 

      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
      PREPARE asfq360_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR asfq360_pb2
   END IF
 
#(ver:42) mark ---start---
#  OPEN b_fill_curs2 USING g_enterprise, g_site,g_sfla_d[g_detail_idx].sfladocno
 
#(ver:42) mark --- end ---
 
   LET l_ac = 1
   FOREACH b_fill_curs2 USING g_enterprise, g_site,g_sfla_d[g_detail_idx].sfladocno   #(ver:42)
 
        INTO g_sfla2_d[l_ac].sflb001,g_sfla2_d[l_ac].sfaa002,g_sfla2_d[l_ac].ooag011,g_sfla2_d[l_ac].sfaa010, 
            g_sfla2_d[l_ac].imaal003,g_sfla2_d[l_ac].imaal004,g_sfla2_d[l_ac].sflb002,g_sfla2_d[l_ac].sflb005, 
            g_sfla2_d[l_ac].sfld002,g_sfla2_d[l_ac].sfld003,g_sfla2_d[l_ac].sfba002,g_sfla2_d[l_ac].sfba003, 
            g_sfla2_d[l_ac].sfba004,g_sfla2_d[l_ac].sfld004,g_sfla2_d[l_ac].imaal003t,g_sfla2_d[l_ac].imaal004t, 
            g_sfla2_d[l_ac].sfba021,g_sfla2_d[l_ac].sfba014,g_sfla2_d[l_ac].sfld009   #(ver:42)
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #應用 qs24 樣板自動產生(Version:5) 
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = asfq360_get_hyper_data("prog_asft300")
         LET g_sfla2_d[l_ac].prog_asft300 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_sfla2_d[l_ac].sflb001), 
             "</a>"
 
      ELSE 
         LET g_sfla2_d[l_ac].prog_asft300 = g_sfla2_d[l_ac].sflb001
 
      END IF 
 
 
 
 
      #add-point:b_fill段資料填充 name="fetch.fill2"
 
      #end add-point
      
      CALL asfq360_detail_show("'2'")      
 
      CALL asfq360_sflb_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
 
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE sflc001,'','','','','',sflc002,sflc005,'','','','','','','','','', 
          '','' FROM sflc_t",    
                  "",
                  " WHERE sflcent=? AND sflcsite=? AND sflcdocno=?"
  
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY sflc_t.sflcseq" 
                         
      #add-point:單身填充前 name="fetch.before_fill3"
   LET g_sql = "SELECT UNIQUE sfle001,'','','','','',sflc002,sflc005,sfle002,sfle003,'','','',sfle004,'','','','',sfle009 ",
               "  FROM sfle_t LEFT JOIN sflc_t ON sflcent = sfleent AND sflcsite = sflesite AND sflcdocno = sfledocno AND sflcseq = sfleseq ",
               " WHERE sfleent=? AND sflesite=? AND sfledocno=?"
 
   IF NOT cl_null(g_wc2_table3) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY sfle_t.sfle001" 
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
      PREPARE asfq360_pb3 FROM g_sql
      DECLARE b_fill_curs3 CURSOR FOR asfq360_pb3
   END IF
 
#(ver:42) mark ---start---
#  OPEN b_fill_curs3 USING g_enterprise, g_site,g_sfla_d[g_detail_idx].sfladocno
 
#(ver:42) mark --- end ---
 
   LET l_ac = 1
   FOREACH b_fill_curs3 USING g_enterprise, g_site,g_sfla_d[g_detail_idx].sfladocno   #(ver:42)
 
        INTO g_sfla3_d[l_ac].sflc001,g_sfla3_d[l_ac].sfaa002,g_sfla3_d[l_ac].ooag011,g_sfla3_d[l_ac].sfaa010, 
            g_sfla3_d[l_ac].imaal003,g_sfla3_d[l_ac].imaal004,g_sfla3_d[l_ac].sflc002,g_sfla3_d[l_ac].sflc005, 
            g_sfla3_d[l_ac].sfle002,g_sfla3_d[l_ac].sfle003,g_sfla3_d[l_ac].sfba002,g_sfla3_d[l_ac].sfba003, 
            g_sfla3_d[l_ac].sfcb004,g_sfla3_d[l_ac].sfle004,g_sfla3_d[l_ac].imaal003f,g_sfla3_d[l_ac].imaal004f, 
            g_sfla3_d[l_ac].sfba021,g_sfla3_d[l_ac].sfba014,g_sfla3_d[l_ac].sfle009   #(ver:42)
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #應用 qs24 樣板自動產生(Version:5) 
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = asfq360_get_hyper_data("prog_asft300_sflc001")
         LET g_sfla3_d[l_ac].prog_asft300_sflc001 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_sfla3_d[l_ac].sflc001), 
             "</a>"
 
      ELSE 
         LET g_sfla3_d[l_ac].prog_asft300_sflc001 = g_sfla3_d[l_ac].sflc001
 
      END IF 
 
 
 
 
      #add-point:b_fill段資料填充 name="fetch.fill3"
      
      #end add-point
      
      CALL asfq360_detail_show("'3'")      
 
      CALL asfq360_sflc_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
 
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   CALL g_sfla2_d.deleteElement(g_sfla2_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_sfla2_d.getLength()
   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
 
   CALL g_sfla3_d.deleteElement(g_sfla3_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_sfla3_d.getLength()
   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
 
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="asfq360.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asfq360_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   DEFINE l_sfaa012  LIKE sfaa_t.sfaa012  #生产数量
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_sfla_d[l_ac].sfla002
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_sfla_d[l_ac].ooag011 = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_sfda_m.sfda004_desc
      #end add-point
   END IF
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      LET l_sfaa012=''
      SELECT sfaa002,ooag011,sfaa010,imaal003,imaal004,sfaa012
        INTO g_sfla2_d[l_ac].sfaa002,g_sfla2_d[l_ac].ooag011,g_sfla2_d[l_ac].sfaa010,g_sfla2_d[l_ac].imaal003,g_sfla2_d[l_ac].imaal004,l_sfaa012
        FROM sfaa_t LEFT OUTER JOIN imaal_t ON sfaaent = imaalent AND sfaa010 = imaal001 AND imaal002 = g_dlang
                    LEFT OUTER JOIN ooag_t ON sfaa002 = ooag001 AND sfaaent = ooagent
       WHERE sfaaent   = g_enterprise
         AND sfaadocno = g_sfla2_d[l_ac].sflb001
        
      SELECT sfba002,sfba003,sfba004,sfba021,sfba014
        INTO g_sfla2_d[l_ac].sfba002,g_sfla2_d[l_ac].sfba003,g_sfla2_d[l_ac].sfba004,g_sfla2_d[l_ac].sfba021,g_sfla2_d[l_ac].sfba014
        FROM sfba_t
       WHERE sfbaent   = g_enterprise
         AND sfbadocno = g_sfla2_d[l_ac].sflb001
         AND sfbaseq   = g_sfla2_d[l_ac].sfld002
         AND sfbaseq1  = g_sfla2_d[l_ac].sfld003

      CALL s_desc_get_item_desc(g_sfla2_d[l_ac].sfld004) RETURNING g_sfla2_d[l_ac].imaal003t,g_sfla2_d[l_ac].imaal004t
      
      IF cl_null(g_sfla2_d[l_ac].sflb002) THEN
         LET g_sfla2_d[l_ac].sflb002 = l_sfaa012
      END IF
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
      LET l_sfaa012=''
      SELECT sfaa002,ooag011,sfaa010,imaal003,imaal004,sfaa012
        INTO g_sfla3_d[l_ac].sfaa002,g_sfla3_d[l_ac].ooag011,g_sfla3_d[l_ac].sfaa010,g_sfla3_d[l_ac].imaal003,g_sfla3_d[l_ac].imaal004,l_sfaa012
        FROM sfaa_t LEFT OUTER JOIN imaal_t ON sfaaent = imaalent AND sfaa010 = imaal001 AND imaal002 = g_dlang
                    LEFT OUTER JOIN ooag_t ON sfaa002 = ooag001 AND sfaaent = ooagent
       WHERE sfaaent   = g_enterprise
         AND sfaadocno = g_sfla3_d[l_ac].sflc001
        
      SELECT sfba002,sfba003,sfba004,sfba021,sfba014
        INTO g_sfla3_d[l_ac].sfba002,g_sfla3_d[l_ac].sfba003,g_sfla3_d[l_ac].sfcb004,g_sfla3_d[l_ac].sfba021,g_sfla3_d[l_ac].sfba014
        FROM sfba_t
       WHERE sfbaent   = g_enterprise
         AND sfbadocno = g_sfla3_d[l_ac].sflc001
         AND sfbaseq   = g_sfla3_d[l_ac].sfle002
         AND sfbaseq1  = g_sfla3_d[l_ac].sfle003

      CALL s_desc_get_item_desc(g_sfla3_d[l_ac].sfle004) RETURNING g_sfla3_d[l_ac].imaal003f,g_sfla3_d[l_ac].imaal004f
      
      IF cl_null(g_sfla3_d[l_ac].sflc002) THEN
         LET g_sfla3_d[l_ac].sflc002 = l_sfaa012
      END IF
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfq360.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION asfq360_filter()
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
      CONSTRUCT g_wc_filter ON sfladocno,sfladocdt,sfla001,sfla002,sfla003,sfla004
                          FROM s_detail1[1].b_sfladocno,s_detail1[1].b_sfladocdt,s_detail1[1].b_sfla001, 
                              s_detail1[1].b_sfla002,s_detail1[1].b_sfla003,s_detail1[1].b_sfla004
 
         BEFORE CONSTRUCT
                     DISPLAY asfq360_filter_parser('sfladocno') TO s_detail1[1].b_sfladocno
            DISPLAY asfq360_filter_parser('sfladocdt') TO s_detail1[1].b_sfladocdt
            DISPLAY asfq360_filter_parser('sfla001') TO s_detail1[1].b_sfla001
            DISPLAY asfq360_filter_parser('sfla002') TO s_detail1[1].b_sfla002
            DISPLAY asfq360_filter_parser('sfla003') TO s_detail1[1].b_sfla003
            DISPLAY asfq360_filter_parser('sfla004') TO s_detail1[1].b_sfla004
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_sfladocno>>----
         #Ctrlp:construct.c.filter.page1.b_sfladocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfladocno
            #add-point:ON ACTION controlp INFIELD b_sfladocno name="construct.c.filter.page1.b_sfladocno"
            
            #END add-point
 
 
         #----<<b_sfladocdt>>----
         #Ctrlp:construct.c.filter.page1.b_sfladocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfladocdt
            #add-point:ON ACTION controlp INFIELD b_sfladocdt name="construct.c.filter.page1.b_sfladocdt"
            
            #END add-point
 
 
         #----<<b_sfla001>>----
         #Ctrlp:construct.c.filter.page1.b_sfla001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfla001
            #add-point:ON ACTION controlp INFIELD b_sfla001 name="construct.c.filter.page1.b_sfla001"
            
            #END add-point
 
 
         #----<<b_sfla002>>----
         #Ctrlp:construct.c.filter.page1.b_sfla002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfla002
            #add-point:ON ACTION controlp INFIELD b_sfla002 name="construct.c.filter.page1.b_sfla002"
            
            #END add-point
 
 
         #----<<ooag011>>----
         #----<<b_sfla003>>----
         #Ctrlp:construct.c.filter.page1.b_sfla003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfla003
            #add-point:ON ACTION controlp INFIELD b_sfla003 name="construct.c.filter.page1.b_sfla003"
            
            #END add-point
 
 
         #----<<prog_b_asft311>>----
         #----<<prog_asft321>>----
         #----<<b_sfla004>>----
         #Ctrlp:construct.c.filter.page1.b_sfla004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfla004
            #add-point:ON ACTION controlp INFIELD b_sfla004 name="construct.c.filter.page1.b_sfla004"
            
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
   
      CALL asfq360_filter_show('sfladocno','b_sfladocno')
   CALL asfq360_filter_show('sfladocdt','b_sfladocdt')
   CALL asfq360_filter_show('sfla001','b_sfla001')
   CALL asfq360_filter_show('sfla002','b_sfla002')
   CALL asfq360_filter_show('sfla003','b_sfla003')
   CALL asfq360_filter_show('sfla004','b_sfla004')
   CALL asfq360_filter_show('sflb001','b_sflb001')
   CALL asfq360_filter_show('sflb002','b_sflb002')
   CALL asfq360_filter_show('sflb005','b_sflb005')
   CALL asfq360_filter_show('sfld002','b_sfld002')
   CALL asfq360_filter_show('sfld003','b_sfld003')
   CALL asfq360_filter_show('sfld004','b_sfld004')
   CALL asfq360_filter_show('sfld009','b_sfld009')
   CALL asfq360_filter_show('sflc001','b_sflc001')
   CALL asfq360_filter_show('sflc002','b_sflc002')
   CALL asfq360_filter_show('sflc005','b_sflc005')
   CALL asfq360_filter_show('sfle002','b_sfle002')
   CALL asfq360_filter_show('sfle003','b_sfle003')
   CALL asfq360_filter_show('sfle004','b_sfle004')
   CALL asfq360_filter_show('sfle009','b_sfle009')
 
    
   CALL asfq360_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="asfq360.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION asfq360_filter_parser(ps_field)
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
 
{<section id="asfq360.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION asfq360_filter_show(ps_field,ps_object)
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
   LET ls_condition = asfq360_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="asfq360.insert" >}
#+ insert
PRIVATE FUNCTION asfq360_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asfq360.modify" >}
#+ modify
PRIVATE FUNCTION asfq360_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="asfq360.reproduce" >}
#+ reproduce
PRIVATE FUNCTION asfq360_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="asfq360.delete" >}
#+ delete
PRIVATE FUNCTION asfq360_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="asfq360.get_hyper_data" >}
#應用 qs01 樣板自動產生(Version:9) 
#+ 取得單身串查網址(包含程式代號及參數) 
PRIVATE FUNCTION asfq360_get_hyper_data(ps_field_name) 
   #add-point:get_hyper_data段define-客製 name="get_hyper_data.define_customerization" 
   
   #end add-point 
   DEFINE ps_field_name    STRING 
   DEFINE ps_url           STRING 
   DEFINE ls_js            STRING 
   DEFINE la_param         RECORD 
                           prog       STRING, 
                           actionid   STRING, 
                           background LIKE type_t.chr1, 
                           param      DYNAMIC ARRAY OF STRING 
                           END RECORD 
   DEFINE ps_type          LIKE type_t.chr10 
   #add-point:get_hyper_data段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="get_hyper_data.define" 
   
   #end add-point 
  
  
   #add-point:FUNCTION前置處理 name="get_hyper_data.before_function" 
   
   #end add-point 
  
   LET ps_url = NULL 
  
   # 設定要做串查的程式代碼 
   CASE 
      WHEN ps_field_name = "prog_b_asft311" 
         LET la_param.prog = "asft311" 
  
         # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、... 
         #應用 qs25 樣板自動產生(Version:3)
         #+ 產生串查功能傳入參數部分
 
 
 
         LET la_param.param[1] = g_sfla_d[l_ac].sfla003
         LET la_param.param[2] = g_sfla_d[l_ac].sfla003
         LET la_param.param[3] = g_sfla_d[l_ac].sfla003 
         #add-point:傳入參數設定 name="get_hyper_data.set_parameter_prog_b_asft311" 
         IF g_sfla_d[l_ac].sfla001='1' THEN 
            LET la_param.prog = "asft311"
            LET la_param.param[1] = NULL
            LET la_param.param[3] = NULL
            LET la_param.param[2] ="sfdadocno='",g_sfla_d[l_ac].sfla003 CLIPPED,"'" 
         END IF
         IF g_sfla_d[l_ac].sfla001='2' THEN 
            LET la_param.prog = "asft313"
            LET la_param.param[1] = NULL
            LET la_param.param[3] = NULL 
            LET la_param.param[2] ="sfdadocno='",g_sfla_d[l_ac].sfla003 CLIPPED,"'" 
         END IF 
         #liuym 2015/4/23 add-------end-----
         #end add-point 
  
      WHEN ps_field_name = "prog_asft321"
         LET la_param.prog = "asft321"
 
         # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、...
         #應用 qs25 樣板自動產生(Version:3)
         #+ 產生串查功能傳入參數部分
 
 
 
         LET la_param.param[1] = g_sfla_d[l_ac].sfla004
         LET la_param.param[2] = g_sfla_d[l_ac].sfla004
         LET la_param.param[3] = g_sfla_d[l_ac].sfla004
         #add-point:傳入參數設定 name="get_hyper_data.set_parameter_prog_asft321"
         #liuym 2015/4/23 add-------str-----
         IF g_sfla_d[l_ac].sfla001='1' THEN 
            LET la_param.prog = "asft321"
            LET la_param.param[1] = NULL
            LET la_param.param[3] = NULL
            LET la_param.param[2] ="sfdadocno='",g_sfla_d[l_ac].sfla004 CLIPPED,"'" 
         END IF
         IF g_sfla_d[l_ac].sfla001='2' THEN 
            LET la_param.prog = "asft323"
            LET la_param.param[1] = NULL
            LET la_param.param[3] = NULL 
            LET la_param.param[2] ="sfdadocno='",g_sfla_d[l_ac].sfla004 CLIPPED,"'" 
         END IF 
         #liuym 2015/4/23 add-------end-----         
         #end add-point
      WHEN ps_field_name = "prog_asft300"
         LET la_param.prog = "asft300"
 
         # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、...
         #應用 qs25 樣板自動產生(Version:3)
         #+ 產生串查功能傳入參數部分
 
 
 
         LET la_param.param[1] = g_sfla2_d[l_ac].sflb001
         LET la_param.param[2] = g_sfla2_d[l_ac].sflb001
         LET la_param.param[3] = g_sfla2_d[l_ac].sflb001
         #add-point:傳入參數設定 name="get_hyper_data.set_parameter_prog_asft300"
         #liuym 2015/4/23 add-------str-----
         LET la_param.param[2] = NULL
         LET la_param.param[3] = NULL
         #liuym 2015/4/23 add-------end-----
         #end add-point
      WHEN ps_field_name = "prog_asft300_sflc001"
         LET la_param.prog = "asft300"
 
         # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、...
         #應用 qs25 樣板自動產生(Version:3)
         #+ 產生串查功能傳入參數部分
 
 
 
         LET la_param.param[1] = g_sfla3_d[l_ac].sflc001
         LET la_param.param[2] = g_sfla3_d[l_ac].sflc001
         LET la_param.param[3] = g_sfla3_d[l_ac].sflc001
         #add-point:傳入參數設定 name="get_hyper_data.set_parameter_prog_asft300_sflc001"
         #liuym 2015/4/23 add-------str-----
         LET la_param.param[2] =NULL
         LET la_param.param[3] =NULL
         #liuym 2015/4/23 add-------end-----
         #end add-point
 
   END CASE 
  
   # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、... 
   #add-point:傳入參數設定 name="get_hyper_data.set_parameter" 
   
   #end add-point 
  
   #將陣列資料組合成一個string字串 
   LET ls_js = util.JSON.stringify(la_param) 
  
   #依環境設定要走GDC或GWC模式 (""表示會依據目前的環境判斷，若有自行定義，會依據所定義的模式去執行) 
   LET ps_type = "" 
   #add-point:定義執行模式 name="get_hyper_data.set_env" 
   
   #end add-point 
  
   #呼叫lib，取得完整的url資訊 
   CALL cl_ap_url(ps_type,ls_js) RETURNING ps_url 
 
   LET ps_url = cl_replace_str(ps_url, "&", "&amp;")  
   RETURN ps_url 
  
END FUNCTION 
 
{</section>}
 
{<section id="asfq360.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION asfq360_detail_action_trans()
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
 
{<section id="asfq360.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION asfq360_detail_index_setting()
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
            IF g_sfla_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_sfla_d.getLength() AND g_sfla_d.getLength() > 0
            LET g_detail_idx = g_sfla_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_sfla_d.getLength() THEN
               LET g_detail_idx = g_sfla_d.getLength()
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
 
{<section id="asfq360.mask_functions" >}
 &include "erp/asf/asfq360_mask.4gl"
 
{</section>}
 
{<section id="asfq360.other_function" readonly="Y" >}

 
{</section>}
 
