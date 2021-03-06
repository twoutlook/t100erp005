#該程式未解開Section, 採用最新樣板產出!
{<section id="afaq110.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2016-02-14 14:51:22), PR版次:0008(2016-11-30 10:20:20)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000075
#+ Filename...: afaq110
#+ Description: 資產異動匯總查詢作業
#+ Creator....: 02003(2015-01-13 10:07:50)
#+ Modifier...: 02114 -SD/PR- 01531
 
{</section>}
 
{<section id="afaq110.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#7   2016/04/20 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160125-00005#7   16/08/09   By 01531       查詢時加上帳套人員權限條件過濾
#161024-00008#1   2016/10/24 By Hans        AFA組織類型與職能開窗清單調整。
#161111-00049#5   2016/11/16 By 01531       固资栏位过滤
#161111-00028#6   2016/11/23 by 06189       标准程式定义采用宣告模式,弃用.*写
#161111-00049#11  2016/11/16 By 01531       固资栏位过滤（修复调整：以账套法人限制)
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
       
       faah003 LIKE faah_t.faah003, 
   faah004 LIKE faah_t.faah004, 
   faah001 LIKE faah_t.faah001, 
   faah000 LIKE faah_t.faah000, 
   faan001 LIKE faan_t.faan001, 
   faan002 LIKE faan_t.faan002, 
   faan007 LIKE faan_t.faan007, 
   faah016 LIKE faah_t.faah016, 
   faah012 LIKE faah_t.faah012, 
   faah013 LIKE faah_t.faah013, 
   faan008 LIKE faan_t.faan008, 
   faan010 LIKE faan_t.faan010, 
   faan013 LIKE faan_t.faan013, 
   faan014 LIKE faan_t.faan014, 
   faan015 LIKE faan_t.faan015, 
   faan016 LIKE faan_t.faan016, 
   faan018 LIKE faan_t.faan018, 
   faan019 LIKE faan_t.faan019, 
   faan020 LIKE faan_t.faan020, 
   faan017 LIKE faan_t.faan017, 
   sum1 LIKE type_t.num20_6, 
   sum2 LIKE type_t.num20_6, 
   sum3 LIKE type_t.num20_6, 
   sum4 LIKE type_t.num20_6, 
   faan092 LIKE faan_t.faan092, 
   faan092_desc LIKE type_t.chr1 
       END RECORD
PRIVATE TYPE type_g_faah2_d RECORD
       faan004 LIKE faan_t.faan004, 
   faan005 LIKE faan_t.faan005, 
   faan003 LIKE faan_t.faan003, 
   faanld LIKE faan_t.faanld, 
   faan100 LIKE faan_t.faan100, 
   faan102 LIKE faan_t.faan102, 
   faan103 LIKE faan_t.faan103, 
   faan104 LIKE faan_t.faan104, 
   faan105 LIKE faan_t.faan105, 
   faan106 LIKE faan_t.faan106, 
   faan107 LIKE faan_t.faan107, 
   faan108 LIKE faan_t.faan108
       END RECORD
 
PRIVATE TYPE type_g_faah3_d RECORD
       faan004 LIKE faan_t.faan004, 
   faan005 LIKE faan_t.faan005, 
   faan003 LIKE faan_t.faan003, 
   faanld LIKE faan_t.faanld, 
   faan200 LIKE faan_t.faan200, 
   faan202 LIKE faan_t.faan202, 
   faan203 LIKE faan_t.faan203, 
   faan204 LIKE faan_t.faan204, 
   faan205 LIKE faan_t.faan205, 
   faan206 LIKE faan_t.faan206, 
   faan207 LIKE faan_t.faan207, 
   faan208 LIKE faan_t.faan208
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_master2   RECORD 
            faansite      LIKE faan_t.faansite,
            faansite_desc LIKE type_t.chr80,
            faanld        LIKE faan_t.faanld,
            faanld_desc   LIKE type_t.chr80,
            ooef001       LIKE ooef_t.ooef001,
            faan001       LIKE faan_t.faan001,
            faan001_1     LIKE faan_t.faan001,
            faan002       LIKE faan_t.faan002,
            faan002_1     LIKE faan_t.faan002
                   END RECORD 
DEFINE g_master2_t   RECORD 
            faansite      LIKE faan_t.faansite,
            faansite_desc LIKE type_t.chr80,
            faanld        LIKE faan_t.faanld,
            faanld_desc   LIKE type_t.chr80,
            ooef001       LIKE ooef_t.ooef001,
            faan001       LIKE faan_t.faan001,
            faan001_1     LIKE faan_t.faan001,
            faan002       LIKE faan_t.faan002,
            faan002_1     LIKE faan_t.faan002
                   END RECORD 
DEFINE g_glaald   LIKE glaa_t.glaald
DEFINE g_cnt2     LIKE type_t.num10 
DEFINE g_wc_cs_ld           STRING      #160125-00005#7
DEFINE g_wc_cs_orga         STRING      #160125-00005#7
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_faah_d
DEFINE g_master_t                   type_g_faah_d
DEFINE g_faah_d          DYNAMIC ARRAY OF type_g_faah_d
DEFINE g_faah_d_t        type_g_faah_d
DEFINE g_faah2_d   DYNAMIC ARRAY OF type_g_faah2_d
DEFINE g_faah2_d_t type_g_faah2_d
 
DEFINE g_faah3_d   DYNAMIC ARRAY OF type_g_faah3_d
DEFINE g_faah3_d_t type_g_faah3_d
 
 
      
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
 
{<section id="afaq110.main" >}
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
   DECLARE afaq110_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afaq110_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afaq110_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afaq110 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afaq110_init()   
 
      #進入選單 Menu (="N")
      CALL afaq110_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afaq110
      
   END IF 
   
   CLOSE afaq110_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afaq110.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afaq110_init()
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
   
      CALL cl_set_combo_scc('b_faah016','9913') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('faah005','9903')
   CALL cl_set_combo_scc('b_faah005','9903')
   CALL cl_set_combo_scc('b_faan007','9914')
   CALL cl_set_combo_scc('b_faaj006','9912')
   CALL cl_set_combo_scc('b_faai023','9914')
   #151202-00004#1--add--str--lujh
   CALL cl_set_combo_scc('faah015','9914')     
   CALL cl_set_combo_scc('faah016','9913') 
   CALL cl_set_combo_scc('b_faah016','9913') 
   #151202-00004#1--add--end--lujh
   CALL afaq110_create_tmp()   #151202-00004#16 add lujh
   #营运据点范围
   CALL s_axrt300_get_site(g_user,'','1') RETURNING g_wc_cs_orga #160125-00005#7    
   #end add-point
 
   CALL afaq110_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="afaq110.default_search" >}
PRIVATE FUNCTION afaq110_default_search()
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
 
{<section id="afaq110.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION afaq110_ui_dialog()
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
   LET g_wc = " 1=1"
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
      CALL afaq110_b_fill()
   ELSE
      CALL afaq110_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_faah_d.clear()
         CALL g_faah2_d.clear()
 
         CALL g_faah3_d.clear()
 
 
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
 
         CALL afaq110_init()
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
               CALL afaq110_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL afaq110_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
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
               CALL afaq110_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point  
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_faah3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_faah3_d.getLength() TO FORMONLY.h_count
               CALL afaq110_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point  
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL afaq110_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("insert", FALSE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afaq110_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL afaq110_ins_xg_tmp()
               CALL afaq110_x01("1 = 1","afaq110_xg_tmp") 
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL afaq110_ins_xg_tmp()
               CALL afaq110_x01("1 = 1","afaq110_xg_tmp") 
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afaq110_query()
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
            CALL afaq110_filter()
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
            CALL afaq110_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_faah_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_faah2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_faah3_d)
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
            CALL afaq110_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL afaq110_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL afaq110_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL afaq110_b_fill()
 
         
         
 
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
 
{<section id="afaq110.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afaq110_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   CALL afaq110_query_1()
   RETURN 
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_faah_d.clear()
   CALL g_faah2_d.clear()
 
   CALL g_faah3_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON faah003,faah000,faah016,faah012,faah013
           FROM s_detail1[1].b_faah003,s_detail1[1].b_faah000,s_detail1[1].b_faah016,s_detail1[1].b_faah012, 
               s_detail1[1].b_faah013
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
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
         #----<<b_faah001>>----
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
 
 
         #----<<b_faan001>>----
         #----<<b_faan002>>----
         #----<<b_faan007>>----
         #----<<b_faah016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah016
            #add-point:BEFORE FIELD b_faah016 name="construct.b.page1.b_faah016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah016
            
            #add-point:AFTER FIELD b_faah016 name="construct.a.page1.b_faah016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faah016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah016
            #add-point:ON ACTION controlp INFIELD b_faah016 name="construct.c.page1.b_faah016"
            
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
 
 
         #----<<b_faan008>>----
         #----<<b_faan010>>----
         #----<<b_faan013>>----
         #----<<b_faan014>>----
         #----<<b_faan015>>----
         #----<<b_faan016>>----
         #----<<b_faan018>>----
         #----<<b_faan019>>----
         #----<<b_faan020>>----
         #----<<b_faan017>>----
         #----<<sum1>>----
         #----<<sum2>>----
         #----<<sum3>>----
         #----<<sum4>>----
         #----<<b_faan092>>----
         #----<<faan092_desc>>----
   
       
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
   CALL afaq110_b_fill()
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
 
{<section id="afaq110.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afaq110_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL afaq110_b2_fill()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE faah003,faah004,faah001,faah000,'','','',faah016,faah012,faah013, 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY faah_t.faah000,faah_t.faah001,faah_t.faah003, 
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
 
   LET g_sql = "SELECT faah003,faah004,faah001,faah000,'','','',faah016,faah012,faah013,'','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afaq110_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afaq110_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_faah_d.clear()
   CALL g_faah2_d.clear()   
 
   CALL g_faah3_d.clear()   
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_faah_d[l_ac].faah003,g_faah_d[l_ac].faah004,g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah000, 
       g_faah_d[l_ac].faan001,g_faah_d[l_ac].faan002,g_faah_d[l_ac].faan007,g_faah_d[l_ac].faah016,g_faah_d[l_ac].faah012, 
       g_faah_d[l_ac].faah013,g_faah_d[l_ac].faan008,g_faah_d[l_ac].faan010,g_faah_d[l_ac].faan013,g_faah_d[l_ac].faan014, 
       g_faah_d[l_ac].faan015,g_faah_d[l_ac].faan016,g_faah_d[l_ac].faan018,g_faah_d[l_ac].faan019,g_faah_d[l_ac].faan020, 
       g_faah_d[l_ac].faan017,g_faah_d[l_ac].sum1,g_faah_d[l_ac].sum2,g_faah_d[l_ac].sum3,g_faah_d[l_ac].sum4, 
       g_faah_d[l_ac].faan092,g_faah_d[l_ac].faan092_desc,g_faah2_d[l_ac].faan004,g_faah2_d[l_ac].faan005, 
       g_faah2_d[l_ac].faan003,g_faah2_d[l_ac].faanld,g_faah2_d[l_ac].faan100,g_faah2_d[l_ac].faan102, 
       g_faah2_d[l_ac].faan103,g_faah2_d[l_ac].faan104,g_faah2_d[l_ac].faan105,g_faah2_d[l_ac].faan106, 
       g_faah2_d[l_ac].faan107,g_faah2_d[l_ac].faan108,g_faah3_d[l_ac].faan004,g_faah3_d[l_ac].faan005, 
       g_faah3_d[l_ac].faan003,g_faah3_d[l_ac].faanld,g_faah3_d[l_ac].faan200,g_faah3_d[l_ac].faan202, 
       g_faah3_d[l_ac].faan203,g_faah3_d[l_ac].faan204,g_faah3_d[l_ac].faan205,g_faah3_d[l_ac].faan206, 
       g_faah3_d[l_ac].faan207,g_faah3_d[l_ac].faan208
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
 
      CALL afaq110_detail_show("'1'")      
 
      CALL afaq110_faah_t_mask()
 
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
 
   CALL g_faah3_d.deleteElement(g_faah3_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_faah_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE afaq110_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL afaq110_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL afaq110_detail_action_trans()
 
   IF g_faah_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL afaq110_fetch()
   END IF
   
      CALL afaq110_filter_show('faah003','b_faah003')
   CALL afaq110_filter_show('faah000','b_faah000')
   CALL afaq110_filter_show('faah016','b_faah016')
   CALL afaq110_filter_show('faah012','b_faah012')
   CALL afaq110_filter_show('faah013','b_faah013')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afaq110.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afaq110_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_glaa015   LIKE glaa_t.glaa015
   DEFINE l_glaa019   LIKE glaa_t.glaa019
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   CALL cl_set_comp_visible("page_2",FALSE)
   LET g_sql = "SELECT  UNIQUE faan004,faan005,faan003,faanld,faan100,faan102,faan103,faan104,faan105,",
               "               faan106,faan107,faan108 ",
               "  FROM faan_t,faah_t ",
               " WHERE faanent = faahent ",
               "   AND faan004 = faah003 ",
               "   AND faan005 = faah004 ",
               "   AND faan003 = faah001 ",
               "   AND faanld = '",g_master2.faanld,"'",
               "   AND faanent = '",g_enterprise,"'",
               "   AND faan001||faan002 >= '",g_master2.faan001||g_master2.faan002,"'",
               "   AND faan001||faan002 <= '",g_master2.faan001_1||g_master2.faan002_1,"'",
               "   AND faansite = '",g_master2.faansite,"'",
               "   AND ",g_wc CLIPPED, 
               " ORDER BY faan004,faan005,faan003 "
   PREPARE afaq110_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR afaq110_pb3
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
      SELECT glaa015
        INTO l_glaa015
        FROM glaa_t
       WHERE glaald = g_faah2_d[g_cnt].faanld
         AND glaaent = g_enterprise
      IF l_glaa015 = 'Y' THEN 
         CALL cl_set_comp_visible("page_2",TRUE)
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
   CALL cl_set_comp_visible("page_3",FALSE)
   LET g_sql = "SELECT  UNIQUE faan004,faan005,faan003,faanld,faan200,faan202,faan203,faan204,faan205,faan206,faan207,faan208",
               "  FROM faan_t,faah_t ",
               " WHERE faanent = faahent ",
               "   AND faan004 = faah003 ",
               "   AND faan005 = faah004 ",
               "   AND faan003 = faah001 ",
               "   AND faanld = '",g_master2.faanld,"'",
               "   AND faanent = '",g_enterprise,"'",
               "   AND faan001||faan002 >= '",g_master2.faan001||g_master2.faan002,"'",
               "   AND faan001||faan002 <= '",g_master2.faan001_1||g_master2.faan002_1,"'",
               "   AND faansite = '",g_master2.faansite,"'",
               "   AND ",g_wc CLIPPED, 
               " ORDER BY faan004,faan005,faan003 "
   PREPARE afaq110_pb4 FROM g_sql
   DECLARE b_fill_curs4 CURSOR FOR afaq110_pb4
   CALL g_faah3_d.clear()
   LET g_cnt2 = 1
   FOREACH b_fill_curs4 INTO g_faah3_d[g_cnt2].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      SELECT glaa019
        INTO l_glaa019
        FROM glaa_t
       WHERE glaald = g_faah3_d[g_cnt2].faanld
         AND glaaent = g_enterprise
      IF l_glaa019 = 'Y' THEN 
         CALL cl_set_comp_visible("page_3",TRUE)
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
      LET g_cnt2 = g_cnt2 + 1
   END FOREACH
   CALL g_faah2_d.deleteElement(g_faah2_d.getLength())
   CALL g_faah3_d.deleteElement(g_faah3_d.getLength())   
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="afaq110.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afaq110_detail_show(ps_page)
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
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afaq110.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afaq110_filter()
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
      CONSTRUCT g_wc_filter ON faah003,faah000,faah016,faah012,faah013
                          FROM s_detail1[1].b_faah003,s_detail1[1].b_faah000,s_detail1[1].b_faah016, 
                              s_detail1[1].b_faah012,s_detail1[1].b_faah013
 
         BEFORE CONSTRUCT
                     DISPLAY afaq110_filter_parser('faah003') TO s_detail1[1].b_faah003
            DISPLAY afaq110_filter_parser('faah000') TO s_detail1[1].b_faah000
            DISPLAY afaq110_filter_parser('faah016') TO s_detail1[1].b_faah016
            DISPLAY afaq110_filter_parser('faah012') TO s_detail1[1].b_faah012
            DISPLAY afaq110_filter_parser('faah013') TO s_detail1[1].b_faah013
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
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
         #----<<b_faah001>>----
         #----<<b_faah000>>----
         #Ctrlp:construct.c.filter.page1.b_faah000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah000
            #add-point:ON ACTION controlp INFIELD b_faah000 name="construct.c.filter.page1.b_faah000"
            
            #END add-point
 
 
         #----<<b_faan001>>----
         #----<<b_faan002>>----
         #----<<b_faan007>>----
         #----<<b_faah016>>----
         #Ctrlp:construct.c.filter.page1.b_faah016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah016
            #add-point:ON ACTION controlp INFIELD b_faah016 name="construct.c.filter.page1.b_faah016"
            
            #END add-point
 
 
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
 
 
         #----<<b_faan008>>----
         #----<<b_faan010>>----
         #----<<b_faan013>>----
         #----<<b_faan014>>----
         #----<<b_faan015>>----
         #----<<b_faan016>>----
         #----<<b_faan018>>----
         #----<<b_faan019>>----
         #----<<b_faan020>>----
         #----<<b_faan017>>----
         #----<<sum1>>----
         #----<<sum2>>----
         #----<<sum3>>----
         #----<<sum4>>----
         #----<<b_faan092>>----
         #----<<faan092_desc>>----
   
 
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
   
      CALL afaq110_filter_show('faah003','b_faah003')
   CALL afaq110_filter_show('faah000','b_faah000')
   CALL afaq110_filter_show('faah016','b_faah016')
   CALL afaq110_filter_show('faah012','b_faah012')
   CALL afaq110_filter_show('faah013','b_faah013')
 
    
   CALL afaq110_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="afaq110.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afaq110_filter_parser(ps_field)
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
 
{<section id="afaq110.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afaq110_filter_show(ps_field,ps_object)
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
   LET ls_condition = afaq110_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afaq110.insert" >}
#+ insert
PRIVATE FUNCTION afaq110_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afaq110.modify" >}
#+ modify
PRIVATE FUNCTION afaq110_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afaq110.reproduce" >}
#+ reproduce
PRIVATE FUNCTION afaq110_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afaq110.delete" >}
#+ delete
PRIVATE FUNCTION afaq110_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afaq110.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION afaq110_detail_action_trans()
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
 
{<section id="afaq110.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION afaq110_detail_index_setting()
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
 
{<section id="afaq110.mask_functions" >}
 &include "erp/afa/afaq110_mask.4gl"
 
{</section>}
 
{<section id="afaq110.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查詢條件設定
# Memo...........:
# Usage..........: CALL afaq110_query_1()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/01/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq110_query_1()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
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
   #預設值
   LET g_master2.faansite = g_site 
   CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,g_master2.ooef001,g_master2.faanld
   CALL s_fin_account_center_with_ld_chk(g_site,g_glaald,g_user,'5','N','',g_today) RETURNING g_sub_success,g_errno
   IF NOT g_sub_success THEN 
      LET g_master2.faanld = ''
   END IF
   CALL cl_get_para(g_enterprise,g_master2.ooef001,'S-FIN-9018') RETURNING g_master2.faan001
   CALL cl_get_para(g_enterprise,g_master2.ooef001,'S-FIN-9018') RETURNING g_master2.faan001_1
   CALL cl_get_para(g_enterprise,g_master2.ooef001,'S-FIN-9019') RETURNING g_master2.faan002
   CALL cl_get_para(g_enterprise,g_master2.ooef001,'S-FIN-9019') RETURNING g_master2.faan002_1
   LET g_master2_t.* = g_master2.*
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      INPUT BY NAME g_master2.faansite,g_master2.faanld,g_master2.faan001,g_master2.faan001_1,
                    g_master2.faan002,g_master2.faan002_1
       ATTRIBUTE(WITHOUT DEFAULTS)
      
         BEFORE INPUT    
            CALL afaq110_get_faansite_desc()
            CALL afaq110_get_faald_desc()
            DISPLAY BY NAME g_master2.faansite,g_master2.faansite_desc,g_master2.faanld,g_master2.faanld_desc,
                            g_master2.faan001,g_master2.faan001_1,g_master2.faan002,g_master2.faan002_1
      
         AFTER FIELD faansite
            IF NOT cl_null(g_master2.faansite) THEN 
               CALL s_fin_orga_get_comp_ld(g_master2.faansite) RETURNING g_sub_success,g_errno,g_master2.ooef001,g_master2.faanld  #151202-00004#16 add lujh
                #检查组织资料的合理性
               IF NOT s_afat502_site_chk(g_master2.faansite) THEN
                  LET g_master2.faansite = g_master2_t.faansite
                  CALL afaq110_get_faansite_desc()
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
                  CALL afaq110_get_faansite_desc()
                  DISPLAY BY NAME g_master2.faansite
                  NEXT FIELD CURRENT  
               END IF
               #帳套不為空，檢查帳套與資產中心法人歸屬
               IF NOT cl_null(g_master2.faanld) THEN
                  IF NOT s_afat502_site_ld_chk(g_master2.faansite,g_master2.faanld) THEN
                     LET g_master2.faansite = g_master2_t.faansite
                     CALL afaq110_get_faansite_desc()
                     DISPLAY BY NAME g_master2.faansite
                     NEXT FIELD CURRENT  
                  END IF
               END IF
               CALL afaq110_get_faansite_desc()
            ELSE
               CALL afaq110_get_faansite_desc()
               DISPLAY BY NAME g_master2.faansite
            END IF 

         AFTER FIELD faanld
        
            IF NOT cl_null(g_master2.faanld) THEN
                
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=g_master2.faanld
               #160318-00025#7--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#7--add--end 
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  
               ELSE
                  LET g_master2.faanld = g_master2_t.faanld
                  CALL afaq110_get_faald_desc()                
               END IF               
            
               IF NOT s_ld_chk_authorization(g_user,g_master2.faanld) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00165'
                  LET g_errparam.extend = g_master2.faanld
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_master2.faanld = g_master2_t.faanld
                  CALL afaq110_get_faald_desc() 
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(g_master2.ooef001) THEN 
                  IF NOT afaq110_faanld_ooef001_chk() THEN 
                     LET g_master2.faanld = g_master2_t.faanld
                     CALL afaq110_get_faald_desc() 
                     NEXT FIELD CURRENT
                  END IF
               END IF 
               #资产中心不为空时
               IF NOT cl_null(g_master2.faansite) THEN
                  IF NOT s_afat502_site_ld_chk(g_master2.faansite,g_master2.faanld) THEN
                     LET g_master2.faanld = g_master2_t.faanld
                     CALL afaq110_get_faald_desc() 
                     DISPLAY BY NAME g_master2.faanld
                     NEXT FIELD CURRENT
                  END IF
               END IF  
               
            END IF   

          AFTER FIELD faan001
             IF NOT cl_null(g_master2.faan001) THEN 
                IF NOT cl_null(g_master2.faan001_1) AND g_master2.faan001_1 < g_master2.faan001 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'afa-00378'
                   LET g_errparam.extend = g_master2.faan001
                   LET g_errparam.popup = FALSE
                   CALL cl_err()
                   LET g_master2.faan001 = g_master2_t.faan001
                   NEXT FIELD faan001
                END IF 
                IF NOT afaq110_faan001_faan002_chk() THEN 
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'afa-00379'
                   LET g_errparam.extend = g_master2.faan001
                   LET g_errparam.popup = FALSE
                   CALL cl_err()
                   LET g_master2.faan001 = g_master2_t.faan001
                   NEXT FIELD faan001
                END IF
             END IF 

          AFTER FIELD faan001_1
             IF NOT cl_null(g_master2.faan001_1) THEN 
                IF NOT cl_null(g_master2.faan001) AND g_master2.faan001_1 < g_master2.faan001 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'afa-00378'
                   LET g_errparam.extend = g_master2.faan001_1
                   LET g_errparam.popup = FALSE
                   CALL cl_err()
                   LET g_master2.faan001_1 = g_master2_t.faan001_1
                   NEXT FIELD faan001_1
                END IF 
                IF NOT afaq110_faan001_faan002_chk() THEN 
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'afa-00379'
                   LET g_errparam.extend = g_master2.faan001_1
                   LET g_errparam.popup = FALSE
                   CALL cl_err()
                   LET g_master2.faan001_1 = g_master2_t.faan001_1
                   NEXT FIELD faan001_1
                END IF
             END IF 
             
          AFTER FIELD faan002
             IF NOT cl_null(g_master2.faan002) THEN 
                IF g_master2.faan002 < 1 OR g_master2.faan002 > 12 THEN 
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'afa-00380'
                   LET g_errparam.extend = g_master2.faan002
                   LET g_errparam.popup = FALSE
                   CALL cl_err()
                   LET g_master2.faan002 = g_master2_t.faan002
                   NEXT FIELD faan002
                END IF 
                IF NOT afaq110_faan001_faan002_chk() THEN 
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'afa-00379'
                   LET g_errparam.extend = g_master2.faan002
                   LET g_errparam.popup = FALSE
                   CALL cl_err()
                   LET g_master2.faan002 = g_master2_t.faan002
                   NEXT FIELD faan002
                END IF 
             END IF 
             
          AFTER FIELD faan002_1
             IF NOT cl_null(g_master2.faan002_1) THEN 
                IF g_master2.faan002_1 < 1 OR g_master2.faan002_1 > 12 THEN 
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'afa-00380'
                   LET g_errparam.extend = g_master2.faan002_1
                   LET g_errparam.popup = FALSE
                   CALL cl_err()
                   LET g_master2.faan002_1 = g_master2_t.faan002_1
                   NEXT FIELD faan002_1
                END IF 
                IF NOT afaq110_faan001_faan002_chk() THEN 
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'afa-00379'
                   LET g_errparam.extend = g_master2.faan002_1
                   LET g_errparam.popup = FALSE
                   CALL cl_err()
                   LET g_master2.faan002_1 = g_master2_t.faan002_1
                   NEXT FIELD faan002_1
                END IF 
             END IF 
             
          ON ACTION controlp INFIELD faansite
	          INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'i'
	          LET g_qryparam.reqry = FALSE
             LET g_qryparam.default1 = g_master2.faansite      #給予default值
             LET g_qryparam.where = " ooef207 = 'Y' "
             #160125-00005#7--add--str--
             IF NOT cl_null(g_wc_cs_orga) THEN
			       LET g_qryparam.where = g_wc_cs_orga
			    END IF
			    #160125-00005#7--add--end             
             #CALL q_ooef001()                                     #161024-00008#1 
             CALL q_ooef001_47()                                  #161024-00008#1 
             LET g_master2.faansite = g_qryparam.return1       #將開窗取得的值回傳到變數
             DISPLAY g_master2.faansite TO faansite             #顯示到畫面上
             CALL afaq110_get_faansite_desc()
             NEXT FIELD faansite                              #返回原欄位  
     
          ON ACTION controlp INFIELD faanld
	  	     #此段落由子樣板a07產生
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master2.faanld             #給予default值
 
            CALL s_fin_create_account_center_tmp()   
            #取得资产組織下所屬成員
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            #取得资产中心下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL s_afat502_change_to_sql(l_origin_str) RETURNING l_origin_str  
            LET l_origin_str=l_origin_str.substring(2,l_origin_str.getLength()-1) #160125-00005#7 add 
            #LET g_qryparam.where = " (glaa008 = 'Y') AND glaacomp IN (",l_origin_str," )"    #151202-00004#16 mark lujh
            #LET g_qryparam.where = " (glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )"     #151202-00004#16 add lujh #160125-00005#7 add
             LET g_qryparam.where = " glaa014 = 'Y'" #160125-00005#7 add 
            #給予arg
            LET g_qryparam.arg1 = g_user #
            LET g_qryparam.arg2 = g_dept #
            #160125-00005#7--add--str--
            #账套范围
            CALL s_axrt300_get_site(g_user,l_origin_str,'2')  RETURNING g_wc_cs_ld
            IF NOT cl_null(g_wc_cs_ld) THEN   
               LET g_qryparam.where = g_qryparam.where," AND ",g_wc_cs_ld
            END IF
            #160125-00005#7--add--end             
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_master2.faanld = g_qryparam.return1              

            DISPLAY g_master2.faanld TO faanld 
        AFTER INPUT
     
     END INPUT
     CONSTRUCT g_wc ON faah003,faah004,faah001,faah026,faah006,faah005,faah015,faah016   #151202-00004#1 add faah015,faah016 lujh
          FROM faah003,faah004,faah001,faah026,faah006,faah005,faah015,faah016           #151202-00004#1 add faah015,faah016 lujh
                     
        BEFORE CONSTRUCT
 
        ON ACTION controlp INFIELD faah003
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
#161111-00049#11 mod s---           
#			  #161111-00049#5 add s--- 
#           IF NOT cl_null(g_master2.faansite) THEN 
#              CALL s_fin_create_account_center_tmp()
#              CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
#              CALL s_fin_account_center_comp_str()RETURNING l_origin_str
#              CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
#              LET g_qryparam.where = " faah032 IN(",l_origin_str CLIPPED,") "
#           END IF 
#			  #161111-00049#5 add e--- 
           IF NOT cl_null(g_master2.faanld) THEN
              LET g_qryparam.where = " faah032 IN(SELECT glaacomp FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_master2.faanld,"')"
           END IF
#161111-00049#5 mod e---
           CALL q_faah003()                       #呼叫開窗
           DISPLAY g_qryparam.return1 TO faah003  #顯示到畫面上
           NEXT FIELD faah003                     #返回原欄位
           
        ON ACTION controlp INFIELD faah004
           INITIALIZE g_qryparam.* TO NULL                                                                                                           
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
			  #161111-00049#5 add s--- 
           IF NOT cl_null(g_master2.faansite) THEN 
#161111-00049#11 mod s---           
#              CALL s_fin_create_account_center_tmp()
#              CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
#              CALL s_fin_account_center_comp_str()RETURNING l_origin_str
#              CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
#              LET g_qryparam.where = " faah032 IN(",l_origin_str CLIPPED,") "
              IF NOT cl_null(g_master2.faanld) THEN
                 LET g_qryparam.where = " faah032 IN(SELECT glaacomp FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_master2.faanld,"')"
              END IF
#161111-00049#11 mod e---              
           END IF 
			  #161111-00049#5 add e---            
           CALL q_faah004()                           #呼叫開窗
           DISPLAY g_qryparam.return1 TO faah004      #顯示到畫面上
           NEXT FIELD faah004   
           
        ON ACTION controlp INFIELD faah001
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
			  #161111-00049#5 add s--- 
           IF NOT cl_null(g_master2.faansite) THEN 
#161111-00049#11 mod s---            
#              CALL s_fin_create_account_center_tmp()
#              CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
#              CALL s_fin_account_center_comp_str()RETURNING l_origin_str
#              CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
#              LET g_qryparam.where = " faah032 IN(",l_origin_str CLIPPED,") "
              IF NOT cl_null(g_master2.faanld) THEN
                 LET g_qryparam.where = " faah032 IN(SELECT glaacomp FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_master2.faanld,"')"
              END IF
#161111-00049#11 mod e---                
           END IF 
			  #161111-00049#5 add e---            
           CALL q_faah001()                           #呼叫開窗
           DISPLAY g_qryparam.return1 TO faah001      #顯示到畫面上
           NEXT FIELD faah001                         #返回原欄位    
           
        ON ACTION controlp INFIELD faah006
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
			  #161111-00049#5 add s---		   
           LET g_qryparam.where = " faalld = '",g_master2.faanld,"'"
           CALL q_faal001_1() 
           #161111-00049#5 add e---             
           #CALL q_faac001() #161111-00049#5 mark                 
           DISPLAY g_qryparam.return1 TO faah006      #顯示到畫面上
           NEXT FIELD faah006                         #返回原欄位
           
        ON ACTION controlp INFIELD faah026
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
           LET g_qryparam.arg1 = g_today
           CALL q_ooeg001_4()                         #呼叫開窗
           DISPLAY g_qryparam.return1 TO faah026      #顯示到畫面上
           NEXT FIELD faah026                         #返回原欄位
            
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
   CALL afaq110_set_entry()
   CALL afaq110_b_fill()
   LET l_ac = g_master_idx
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
END FUNCTION

################################################################################
# Descriptions...: 獲取資產中心名稱
# Memo...........:
# Usage..........: CALL afaq110_get_faansite_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/01/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq110_get_faansite_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master2.faansite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master2.faansite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master2.faansite_desc
END FUNCTION

################################################################################
# Descriptions...: 资产中心与法人检查
# Memo...........:
# Usage..........: CALL afaq110_site_comp_chk(p_site,p_comp)
# Input parameter: p_site         资产中心 
#                : p_comp         法人
# Return code....: r_success
# Date & Author..: 2015/01/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq110_site_comp_chk(p_site,p_comp)
DEFINE p_site      LIKE faba_t.fabasite
DEFINE p_comp      LIKE faba_t.fabacomp
DEFINE l_sql       STRING
DEFINE l_count     LIKE type_t.num5
DEFINE l_origin_str  STRING

  LET g_errno = ''
  CALL s_fin_create_account_center_tmp()
  CALL s_fin_account_center_sons_query('5',p_site,g_today,'1')
  CALL s_fin_account_center_comp_str() RETURNING l_origin_str
  CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
  LET l_origin_str = "(",l_origin_str,")"
  LET l_sql = " SELECT COUNT(*) FROM ooef_t ",
              "  WHERE ooefent = '",g_enterprise,"' AND ooef017='",p_comp,"'",
              "    AND ooef001 IN ",l_origin_str
   PREPARE sel_fabacomp FROM l_sql
   EXECUTE sel_fabacomp INTO l_count
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      LET g_errno = 'afa-00306'
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()   
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 填充单身一
# Memo...........:
# Usage..........: CALL afaq110_b2_fill()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/01/05 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq110_b2_fill()
#DEFINE l_faan   RECORD LIKE faan_t.* #mark by geza 20161123 #161111-00028#6 
#add by geza 20161123 #161111-00028#6(S)
DEFINE l_faan RECORD  #資產月結檔
       faanent LIKE faan_t.faanent, #企业编码
       faancomp LIKE faan_t.faancomp, #法人
       faansite LIKE faan_t.faansite, #资产中心
       faan001 LIKE faan_t.faan001, #年度
       faan002 LIKE faan_t.faan002, #月份
       faan003 LIKE faan_t.faan003, #卡片编号
       faan004 LIKE faan_t.faan004, #财产编号
       faan005 LIKE faan_t.faan005, #附号
       faan006 LIKE faan_t.faan006, #数量
       faan007 LIKE faan_t.faan007, #资产状态
       faan008 LIKE faan_t.faan008, #外送数量
       faanld LIKE faan_t.faanld, #账套
       faan010 LIKE faan_t.faan010, #币种
       faan011 LIKE faan_t.faan011, #汇率
       faan012 LIKE faan_t.faan012, #耐用年限
       faan013 LIKE faan_t.faan013, #未使用年限
       faan014 LIKE faan_t.faan014, #账面余额
       faan015 LIKE faan_t.faan015, #账面净值
       faan016 LIKE faan_t.faan016, #账面价值
       faan017 LIKE faan_t.faan017, #本月折旧
       faan018 LIKE faan_t.faan018, #累计折旧
       faan019 LIKE faan_t.faan019, #已计提减值准备金额
       faan020 LIKE faan_t.faan020, #预留残值
       faan030 LIKE faan_t.faan030, #重估数量
       faan031 LIKE faan_t.faan031, #重估成本
       faan032 LIKE faan_t.faan032, #重估异动累计折旧
       faan033 LIKE faan_t.faan033, #重估异动年限
       faan034 LIKE faan_t.faan034, #重估异动预留残值
       faan035 LIKE faan_t.faan035, #重估未折减额
       faan040 LIKE faan_t.faan040, #内部销售数量
       faan041 LIKE faan_t.faan041, #内部销售成本
       faan042 LIKE faan_t.faan042, #内部销售累计折旧
       faan043 LIKE faan_t.faan043, #内部销售计提减值准备
       faan044 LIKE faan_t.faan044, #内部销售预留残值
       faan045 LIKE faan_t.faan045, #内部销售未折减额
       faan050 LIKE faan_t.faan050, #销账数量
       faan051 LIKE faan_t.faan051, #销账成本
       faan052 LIKE faan_t.faan052, #销账累计折旧
       faan053 LIKE faan_t.faan053, #销账已计提减值准备
       faan054 LIKE faan_t.faan054, #销账预留残值
       faan055 LIKE faan_t.faan055, #销账未折减额
       faan060 LIKE faan_t.faan060, #报废数量
       faan061 LIKE faan_t.faan061, #报废成本
       faan062 LIKE faan_t.faan062, #报废累计折旧
       faan063 LIKE faan_t.faan063, #报废计提减值准备
       faan064 LIKE faan_t.faan064, #报废预留残值
       faan065 LIKE faan_t.faan065, #报废未折减额
       faan070 LIKE faan_t.faan070, #改良数量
       faan071 LIKE faan_t.faan071, #改良成本
       faan072 LIKE faan_t.faan072, #改良异动未用年限
       faan073 LIKE faan_t.faan073, #改良异动预留残值
       faan074 LIKE faan_t.faan074, #改良未折减额
       faan080 LIKE faan_t.faan080, #一般销售数量
       faan081 LIKE faan_t.faan081, #一般销售成本
       faan082 LIKE faan_t.faan082, #一般销售累计折旧
       faan083 LIKE faan_t.faan083, #一般销售计提减值准备
       faan084 LIKE faan_t.faan084, #一般销售预留残值
       faan085 LIKE faan_t.faan085, #一般销售未折减额
       faan090 LIKE faan_t.faan090, #折毕再提预留残值
       faan091 LIKE faan_t.faan091, #折毕再提未用年限
       faan092 LIKE faan_t.faan092, #减值准备金额
       faan100 LIKE faan_t.faan100, #本位币二币种
       faan101 LIKE faan_t.faan101, #本位币二汇率
       faan102 LIKE faan_t.faan102, #本位币二账面余额
       faan103 LIKE faan_t.faan103, #本位币二账面净值
       faan104 LIKE faan_t.faan104, #本位币二账面价值
       faan105 LIKE faan_t.faan105, #本位币二本月折旧
       faan106 LIKE faan_t.faan106, #本位币二累计折旧
       faan107 LIKE faan_t.faan107, #本位币二减值准备金额
       faan108 LIKE faan_t.faan108, #本位币二预留残值
       faan120 LIKE faan_t.faan120, #本位币二重估成本
       faan121 LIKE faan_t.faan121, #本位币二重估异动累计折旧
       faan122 LIKE faan_t.faan122, #本位币二重估已计提减值准备
       faan123 LIKE faan_t.faan123, #本位币二重估预留残值
       faan124 LIKE faan_t.faan124, #本位币二重估未折减额
       faan130 LIKE faan_t.faan130, #本位币二内部销售成本
       faan131 LIKE faan_t.faan131, #本位币二内部销售累折
       faan132 LIKE faan_t.faan132, #本位币二内部销售计提减值准备
       faan133 LIKE faan_t.faan133, #本位币二内部销售预留残值
       faan134 LIKE faan_t.faan134, #本位币二内部销售未折减额
       faan140 LIKE faan_t.faan140, #本位币二销账成本
       faan141 LIKE faan_t.faan141, #本位币二销账累计折旧
       faan142 LIKE faan_t.faan142, #本位币二销账已计提减值准备
       faan143 LIKE faan_t.faan143, #本位币二销账预留残值
       faan144 LIKE faan_t.faan144, #本位币二销账未折减额
       faan150 LIKE faan_t.faan150, #本位币二报废成本
       faan151 LIKE faan_t.faan151, #本位币二报废累计折旧
       faan152 LIKE faan_t.faan152, #本位币二报废计提减值准备
       faan153 LIKE faan_t.faan153, #本位币二报废预留残值
       faan154 LIKE faan_t.faan154, #本位币二报废未折减额
       faan160 LIKE faan_t.faan160, #本位币二改良成本
       faan161 LIKE faan_t.faan161, #本位币二改良异动预留残值
       faan162 LIKE faan_t.faan162, #本位币二改良未折减额
       faan170 LIKE faan_t.faan170, #本位币二一般销售成本
       faan171 LIKE faan_t.faan171, #本位币二一般销售累计折旧
       faan172 LIKE faan_t.faan172, #本位币二一般销售计提减值准备
       faan173 LIKE faan_t.faan173, #本位币二一般销售预留残值
       faan174 LIKE faan_t.faan174, #本位币二一般销售未折减额
       faan190 LIKE faan_t.faan190, #本位币二折毕再提预留残值
       faan191 LIKE faan_t.faan191, #本位币二减值准备金额
       faan200 LIKE faan_t.faan200, #本位币三币种
       faan201 LIKE faan_t.faan201, #本位币三汇率
       faan202 LIKE faan_t.faan202, #本位币三账面余额
       faan203 LIKE faan_t.faan203, #本位币三账面净值
       faan204 LIKE faan_t.faan204, #本位币三账面价值
       faan205 LIKE faan_t.faan205, #本位币三本月折旧
       faan206 LIKE faan_t.faan206, #本位币三累计折旧
       faan207 LIKE faan_t.faan207, #本位币三减值准备
       faan208 LIKE faan_t.faan208, #本位币三预留残值
       faan220 LIKE faan_t.faan220, #本位币三重估成本
       faan221 LIKE faan_t.faan221, #本位币三重估异动累计折旧
       faan222 LIKE faan_t.faan222, #本位币二重估已计提减值准备
       faan223 LIKE faan_t.faan223, #本位币三重估异动预留残值
       faan224 LIKE faan_t.faan224, #本位币三重估后未折减额
       faan230 LIKE faan_t.faan230, #本位币三内部销售成本
       faan231 LIKE faan_t.faan231, #本位币三内部销售累折
       faan232 LIKE faan_t.faan232, #本位币三内部销售计提减值准备
       faan233 LIKE faan_t.faan233, #本位币三内部销售预留残值
       faan234 LIKE faan_t.faan234, #本位币三内部销售未折减额
       faan240 LIKE faan_t.faan240, #本位币三销账成本
       faan241 LIKE faan_t.faan241, #本位币三销账累折
       faan242 LIKE faan_t.faan242, #本位币三销账计提减值准备
       faan243 LIKE faan_t.faan243, #本位币三销账预留残值
       faan244 LIKE faan_t.faan244, #本位币三销账未折减额
       faan250 LIKE faan_t.faan250, #本位币三报废成本
       faan251 LIKE faan_t.faan251, #本位币三报废累折
       faan252 LIKE faan_t.faan252, #本位币三报废计提减值准备
       faan253 LIKE faan_t.faan253, #本位币三报废预留残值
       faan254 LIKE faan_t.faan254, #本位币三报废未折减额
       faan260 LIKE faan_t.faan260, #本位币三改良成本
       faan261 LIKE faan_t.faan261, #本位币三改良异动预留残值
       faan262 LIKE faan_t.faan262, #本位币三改良未折减额
       faan270 LIKE faan_t.faan270, #本位币三一般销售成本
       faan271 LIKE faan_t.faan271, #本位币三一般销售累折
       faan272 LIKE faan_t.faan272, #本位币三一般销售计提减值准备
       faan273 LIKE faan_t.faan273, #本位币三一般销售预留残值
       faan274 LIKE faan_t.faan274, #本位币三一般销售未折减额
       faan290 LIKE faan_t.faan290, #本位币三折毕再提预留残值
       faan291 LIKE faan_t.faan291, #本位币三减值准备金额
       faan009 LIKE faan_t.faan009  #列账/列管
END RECORD
#add by geza 20161123 #161111-00028#6(E)
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   LET g_sql = "SELECT  UNIQUE faan004,faan005,faan003,faah000,faan001,faan002,faan007,faah016,faah012,faah013,faan008,faan010,faan013, ",    #151202-00004#1 add  faah016,faah012,faah013 lujh
               "               faan014,faan015,faan016,faan018,faan019,faan020,faan017,0,0,0,0,faan092,'N' ",
               "  FROM faan_t,faah_t,faaj_t ",
               " WHERE faanent = faahent ",
               "   AND faan004 = faah003 ",
               "   AND faan005 = faah004 ",
               "   AND faan003 = faah001 ",
               "   AND faanent = faajent ",
               "   AND faan004 = faaj001 ",
               "   AND faan005 = faaj002 ",
               "   AND faan003 = faaj037 ",
               "   AND faanld = faajld ",
               "   AND faajld = '",g_master2.faanld,"'",
               "   AND faanent = '",g_enterprise,"'",
               "   AND faan001||faan002 >= '",g_master2.faan001||g_master2.faan002,"'",
               "   AND faan001||faan002 <= '",g_master2.faan001_1||g_master2.faan002_1,"'",
               "   AND faansite = '",g_master2.faansite,"'",
               "   AND ",g_wc CLIPPED, 
               " ORDER BY faan004,faan005,faan003,faan001,faan002 "
   PREPARE afaq110_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR afaq110_pb2
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
      INITIALIZE l_faan.* TO NULL
      #SELECT * INTO l_faan.*  #mark by geza 20161123 #161111-00028#6
      SELECT faanent,faancomp,faansite,faan001,faan002,
             faan003,faan004,faan005,faan006,faan007,
             faan008,faanld,faan010,faan011,faan012,
             faan013,faan014,faan015,faan016,faan017,
             faan018,faan019,faan020,faan030,faan031,
             faan032,faan033,faan034,faan035,faan040,
             faan041,faan042,faan043,faan044,faan045,
             faan050,faan051,faan052,faan053,faan054,
             faan055,faan060,faan061,faan062,faan063,
             faan064,faan065,faan070,faan071,faan072,
             faan073,faan074,faan080,faan081,faan082,
             faan083,faan084,faan085,faan090,faan091,
             faan092,faan100,faan101,faan102,faan103,
             faan104,faan105,faan106,faan107,faan108,
             faan120,faan121,faan122,faan123,faan124,
             faan130,faan131,faan132,faan133,faan134,
             faan140,faan141,faan142,faan143,faan144,
             faan150,faan151,faan152,faan153,faan154,
             faan160,faan161,faan162,faan170,faan171,
             faan172,faan173,faan174,faan190,faan191,
             faan200,faan201,faan202,faan203,faan204,
             faan205,faan206,faan207,faan208,faan220,
             faan221,faan222,faan223,faan224,faan230,
             faan231,faan232,faan233,faan234,faan240,
             faan241,faan242,faan243,faan244,faan250,
             faan251,faan252,faan253,faan254,faan260,
             faan261,faan262,faan270,faan271,faan272,
             faan273,faan274,faan290,faan291,faan009 
        INTO l_faan.faanent,l_faan.faancomp,l_faan.faansite,l_faan.faan001,l_faan.faan002,
             l_faan.faan003,l_faan.faan004,l_faan.faan005,l_faan.faan006,l_faan.faan007,
             l_faan.faan008,l_faan.faanld,l_faan.faan010,l_faan.faan011,l_faan.faan012,
             l_faan.faan013,l_faan.faan014,l_faan.faan015,l_faan.faan016,l_faan.faan017,
             l_faan.faan018,l_faan.faan019,l_faan.faan020,l_faan.faan030,l_faan.faan031,
             l_faan.faan032,l_faan.faan033,l_faan.faan034,l_faan.faan035,l_faan.faan040,
             l_faan.faan041,l_faan.faan042,l_faan.faan043,l_faan.faan044,l_faan.faan045,
             l_faan.faan050,l_faan.faan051,l_faan.faan052,l_faan.faan053,l_faan.faan054,
             l_faan.faan055,l_faan.faan060,l_faan.faan061,l_faan.faan062,l_faan.faan063,
             l_faan.faan064,l_faan.faan065,l_faan.faan070,l_faan.faan071,l_faan.faan072,
             l_faan.faan073,l_faan.faan074,l_faan.faan080,l_faan.faan081,l_faan.faan082,
             l_faan.faan083,l_faan.faan084,l_faan.faan085,l_faan.faan090,l_faan.faan091,
             l_faan.faan092,l_faan.faan100,l_faan.faan101,l_faan.faan102,l_faan.faan103,
             l_faan.faan104,l_faan.faan105,l_faan.faan106,l_faan.faan107,l_faan.faan108,
             l_faan.faan120,l_faan.faan121,l_faan.faan122,l_faan.faan123,l_faan.faan124,
             l_faan.faan130,l_faan.faan131,l_faan.faan132,l_faan.faan133,l_faan.faan134,
             l_faan.faan140,l_faan.faan141,l_faan.faan142,l_faan.faan143,l_faan.faan144,
             l_faan.faan150,l_faan.faan151,l_faan.faan152,l_faan.faan153,l_faan.faan154,
             l_faan.faan160,l_faan.faan161,l_faan.faan162,l_faan.faan170,l_faan.faan171,
             l_faan.faan172,l_faan.faan173,l_faan.faan174,l_faan.faan190,l_faan.faan191,
             l_faan.faan200,l_faan.faan201,l_faan.faan202,l_faan.faan203,l_faan.faan204,
             l_faan.faan205,l_faan.faan206,l_faan.faan207,l_faan.faan208,l_faan.faan220,
             l_faan.faan221,l_faan.faan222,l_faan.faan223,l_faan.faan224,l_faan.faan230,
             l_faan.faan231,l_faan.faan232,l_faan.faan233,l_faan.faan234,l_faan.faan240,
             l_faan.faan241,l_faan.faan242,l_faan.faan243,l_faan.faan244,l_faan.faan250,
             l_faan.faan251,l_faan.faan252,l_faan.faan253,l_faan.faan254,l_faan.faan260,
             l_faan.faan261,l_faan.faan262,l_faan.faan270,l_faan.faan271,l_faan.faan272,
             l_faan.faan273,l_faan.faan274,l_faan.faan290,l_faan.faan291,l_faan.faan009   #add by geza 20161123 #161111-00028#6      
        FROM faan_t
       WHERE faanent = g_enterprise
         AND faan001 = g_faah_d[l_ac].faan001
         AND faan002 = g_faah_d[l_ac].faan002
         AND faan003 = g_faah_d[l_ac].faah001
         AND faan004 = g_faah_d[l_ac].faah003
         AND faan005 = g_faah_d[l_ac].faah004
      IF cl_null(l_faan.faan040) THEN 
         LET l_faan.faan040 = 0
      END IF
      IF cl_null(l_faan.faan050) THEN 
         LET l_faan.faan050 = 0
      END IF
      IF cl_null(l_faan.faan060) THEN 
         LET l_faan.faan060 = 0
      END IF
      IF cl_null(l_faan.faan080) THEN 
         LET l_faan.faan080 = 0
      END IF
      IF cl_null(l_faan.faan031) THEN 
         LET l_faan.faan031 = 0
      END IF
      IF cl_null(l_faan.faan041) THEN 
         LET l_faan.faan041 = 0
      END IF
      IF cl_null(l_faan.faan051) THEN 
         LET l_faan.faan051 = 0
      END IF
      IF cl_null(l_faan.faan061) THEN 
         LET l_faan.faan061 = 0
      END IF
      IF cl_null(l_faan.faan071) THEN 
         LET l_faan.faan071 = 0
      END IF
      IF cl_null(l_faan.faan081) THEN 
         LET l_faan.faan081 = 0
      END IF
      IF cl_null(l_faan.faan032) THEN 
         LET l_faan.faan032 = 0
      END IF
      IF cl_null(l_faan.faan042) THEN 
         LET l_faan.faan042 = 0
      END IF
      IF cl_null(l_faan.faan052) THEN 
         LET l_faan.faan052 = 0
      END IF
      IF cl_null(l_faan.faan062) THEN 
         LET l_faan.faan062 = 0
      END IF
      IF cl_null(l_faan.faan082) THEN 
         LET l_faan.faan082 = 0
      END IF
      IF cl_null(l_faan.faan043) THEN 
         LET l_faan.faan043 = 0
      END IF
      IF cl_null(l_faan.faan053) THEN 
         LET l_faan.faan053 = 0
      END IF
      IF cl_null(l_faan.faan063) THEN 
         LET l_faan.faan063 = 0
      END IF
      IF cl_null(l_faan.faan083) THEN 
         LET l_faan.faan083 = 0
      END IF
      LET g_faah_d[l_ac].sum1 = l_faan.faan040 + l_faan.faan050 + l_faan.faan060 + l_faan.faan080
      LET g_faah_d[l_ac].sum2 = l_faan.faan031 + l_faan.faan041 + l_faan.faan051 + l_faan.faan061
                              + l_faan.faan071 + l_faan.faan081
      LET g_faah_d[l_ac].sum3 = l_faan.faan032 + l_faan.faan042 + l_faan.faan052 + l_faan.faan062
                              + l_faan.faan082
      LET g_faah_d[l_ac].sum4 = l_faan.faan043 + l_faan.faan053 + l_faan.faan063 + l_faan.faan083
      IF NOT cl_null(g_faah_d[l_ac].faan092) AND g_faah_d[l_ac].faan092 != 0 THEN 
         LET g_faah_d[l_ac].faan092_desc = 'Y' 
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
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   CALL g_faah_d.deleteElement(g_faah_d.getLength())   
   LET g_detail_cnt = g_faah_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   LET l_ac = 1
   CALL afaq110_fetch()

END FUNCTION

################################################################################
# Descriptions...: 设置栏位开启关闭
# Memo...........:
# Usage..........: CALL afaq110_set_entry()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/01/08 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq110_set_entry()
   DEFINE l_glaa015   LIKE glaa_t.glaa015
   DEFINE l_glaa019   LIKE glaa_t.glaa019
   DEFINE l_n         LIKE type_t.num5
   
   SELECT glaa015,glaa019
     INTO l_glaa015,l_glaa019
     FROM glaa_t
    WHERE glaald = g_master2.faanld
      AND glaaent = g_enterprise
   CALL cl_set_comp_visible("b_faan100_2,b_faan102_2,b_faan103_2,b_faan104_2,b_faan105_2,b_faan106_2,b_faan107_2,b_faan108_2",FALSE)
   CALL cl_set_comp_visible("b_faan200_2,b_faan202_2,b_faan203_2,b_faan204_2,b_faan205_2,b_faan206_2,b_faan207_2,b_faan208_2",FALSE)
   IF l_glaa015 = 'Y' THEN 
      CALL cl_set_comp_visible("b_faan100_2,b_faan102_2,b_faan103_2,b_faan104_2,b_faan105_2,b_faan106_2,b_faan107_2,b_faan108_2",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_faan100_2,b_faan102_2,b_faan103_2,b_faan104_2,b_faan105_2,b_faan106_2,b_faan107_2,b_faan108_2",FALSE)
   END IF 
   IF l_glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible("b_faan200_2,b_faan202_2,b_faan203_2,b_faan204_2,b_faan205_2,b_faan206_2,b_faan207_2,b_faan208_2",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_faan200_2,b_faan202_2,b_faan203_2,b_faan204_2,b_faan205_2,b_faan206_2,b_faan207_2,b_faan208_2",FALSE)
   END IF
   IF l_glaa015 != 'Y' AND l_glaa019 != 'Y' THEN 
      CALL cl_set_comp_visible("page_2",FALSE)
   ELSE
      CALL cl_set_comp_visible("page_2",TRUE)
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 獲取法人組織名稱
# Memo...........:
# Usage..........: CALL afaq110_get_faald_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/01/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq110_get_faald_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master2.faanld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master2.faanld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master2.faanld_desc
END FUNCTION

################################################################################
# Descriptions...: 法人組織與帳套檢查
# Memo...........:
# Usage..........: CALL afaq110_faanld_ooef001_chk()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/01/09 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq110_faanld_ooef001_chk()
   DEFINE l_glaacomp   LIKE glaa_t.glaacomp
   
   SELECT glaacomp INTO l_glaacomp
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_master2.faanld
   IF l_glaacomp <> g_master2.ooef001 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00377'
      LET g_errparam.extend = g_master2.faanld
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN FALSE
   END IF 
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 检查日期区间是否正确
# Memo...........:
# Usage..........: CALL afaq110_faan001_faan002_chk()
# Input parameter: 无
# Return code....: r_success
# Date & Author..: 2015/01/13 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq110_faan001_faan002_chk()
   IF cl_null(g_master2.faan001) OR cl_null(g_master2.faan002) 
   OR cl_null(g_master2.faan001_1) OR cl_null(g_master2.faan002_1) THEN 
      RETURN TRUE
   END IF
   IF g_master2.faan001 < g_master2.faan001_1 THEN 
      RETURN TRUE 
   ELSE
      IF g_master2.faan002 > g_master2.faan002_1 THEN 
         RETURN FALSE
      END IF 
   END IF
   RETURN TRUE
END FUNCTION
# 创建临时表
#151202-00004#16 add lujh
PRIVATE FUNCTION afaq110_create_tmp()
   WHENEVER ERROR CONTINUE
   DROP TABLE afaq110_xg_tmp;
   CREATE TEMP TABLE afaq110_xg_tmp (
      faan004 LIKE faan_t.faan004, 
      faan005 LIKE faan_t.faan005, 
      faan003 LIKE faan_t.faan003, 
      faan001 LIKE faan_t.faan001, 
      faan002 LIKE faan_t.faan002, 
      faan007 LIKE type_t.chr80,
      faah016 LIKE type_t.chr80, 
      faah012 LIKE type_t.chr80, 
      faah013 LIKE type_t.chr80, 
      faan008 LIKE faan_t.faan008, 
      faan010 LIKE faan_t.faan010, 
      faan013 LIKE faan_t.faan013, 
      faan014 LIKE faan_t.faan014, 
      faan015 LIKE faan_t.faan015, 
      faan016 LIKE faan_t.faan016, 
      faan018 LIKE faan_t.faan018, 
      faan019 LIKE faan_t.faan019, 
      faan020 LIKE faan_t.faan020, 
      faan017 LIKE faan_t.faan017, 
      l_sum1  LIKE type_t.num15_3, 
      l_sum2  LIKE type_t.num26_10, 
      l_sum3  LIKE type_t.num20_6, 
      l_sum4  LIKE type_t.num26_10, 
      faan092 LIKE faan_t.faan092, 
      faan092_desc LIKE type_t.chr10
      );
END FUNCTION

################################################################################
# Descriptions...: 透過RECORD把資料放入TEMP TABLE
# Memo...........: #150908-00002#2
#
# Date & Author..: 151202-00004#16 By lujh
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq110_ins_xg_tmp()
   DEFINE l_i like type_t.num10
   DEFINE l_faan007_desc  LIKE type_t.chr500    #取得SCC的說明文字
   DEFINE l_faah016_desc  LIKE type_t.chr500    #取得SCC的說明文字
   DEFINE l_x01_tmp    RECORD
      faan004 LIKE faan_t.faan004, 
      faan005 LIKE faan_t.faan005, 
      faan003 LIKE faan_t.faan003, 
      faan001 LIKE faan_t.faan001, 
      faan002 LIKE faan_t.faan002, 
      faan007 LIKE type_t.chr80, 
      faah016 LIKE type_t.chr80, 
      faah012 LIKE type_t.chr80, 
      faah013 LIKE type_t.chr80, 
      faan008 LIKE faan_t.faan008, 
      faan010 LIKE faan_t.faan010, 
      faan013 LIKE faan_t.faan013, 
      faan014 LIKE faan_t.faan014, 
      faan015 LIKE faan_t.faan015, 
      faan016 LIKE faan_t.faan016, 
      faan018 LIKE faan_t.faan018, 
      faan019 LIKE faan_t.faan019, 
      faan020 LIKE faan_t.faan020, 
      faan017 LIKE faan_t.faan017, 
      l_sum1  LIKE type_t.num15_3, 
      l_sum2  LIKE type_t.num26_10, 
      l_sum3  LIKE type_t.num20_6, 
      l_sum4  LIKE type_t.num26_10, 
      faan092 LIKE faan_t.faan092, 
      faan092_desc LIKE type_t.chr10
                END RECORD
   DELETE FROM afaq110_xg_tmp
   FOR l_i = 1 TO g_faah_d.getLength()
      CALL s_desc_gzcbl004_desc('9914',g_faah_d[l_i].faan007) RETURNING l_faan007_desc 
      CALL s_desc_gzcbl004_desc('9913',g_faah_d[l_i].faah016) RETURNING l_faah016_desc 
      INITIALIZE l_x01_tmp.* TO NULL
      LET l_x01_tmp.faan004   = g_faah_d[l_i].faah003    
      LET l_x01_tmp.faan005   = g_faah_d[l_i].faah004    
      LET l_x01_tmp.faan003   = g_faah_d[l_i].faah001    
      LET l_x01_tmp.faan001   = g_faah_d[l_i].faan001    
      LET l_x01_tmp.faan002   = g_faah_d[l_i].faan002 
      IF NOT cl_null(g_faah_d[l_i].faan007) THEN
         LET l_x01_tmp.faan007   = g_faah_d[l_i].faan007,":",l_faan007_desc  
      END IF   
      IF NOT cl_null(g_faah_d[l_i].faah016) THEN
         LET l_x01_tmp.faah016   = g_faah_d[l_i].faah016,":",l_faah016_desc  
      END IF           
      LET l_x01_tmp.faah012 = g_faah_d[l_i].faah012 
      LET l_x01_tmp.faah013 = g_faah_d[l_i].faah013       
      LET l_x01_tmp.faan008 = g_faah_d[l_i].faan008  
      LET l_x01_tmp.faan010 = g_faah_d[l_i].faan010    
      LET l_x01_tmp.faan013 = g_faah_d[l_i].faan013    
      LET l_x01_tmp.faan014 = g_faah_d[l_i].faan014    
      LET l_x01_tmp.faan015 = g_faah_d[l_i].faan015       
      LET l_x01_tmp.faan016 = g_faah_d[l_i].faan016  
      LET l_x01_tmp.faan018 = g_faah_d[l_i].faan018  
      LET l_x01_tmp.faan019 = g_faah_d[l_i].faan019    
      LET l_x01_tmp.faan020 = g_faah_d[l_i].faan020  
      LET l_x01_tmp.faan017 = g_faah_d[l_i].faan017  
      LET l_x01_tmp.l_sum1  = g_faah_d[l_i].sum1
      LET l_x01_tmp.l_sum2  = g_faah_d[l_i].sum2  
      LET l_x01_tmp.l_sum3  = g_faah_d[l_i].sum3  
      LET l_x01_tmp.l_sum4  = g_faah_d[l_i].sum4  
      LET l_x01_tmp.faan092 = g_faah_d[l_i].faan092 
      LET l_x01_tmp.faan092_desc = g_faah_d[l_i].faan092_desc      
      INSERT INTO afaq110_xg_tmp VALUES(l_x01_tmp.*)
   END FOR
END FUNCTION

 
{</section>}
 
