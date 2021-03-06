#該程式未解開Section, 採用最新樣板產出!
{<section id="asfq001.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2015-11-11 19:52:23), PR版次:0005(2016-08-04 15:14:09)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000085
#+ Filename...: asfq001
#+ Description: 待發放工單查詢作業
#+ Creator....: 03079(2014-08-19 14:14:01)
#+ Modifier...: 01534 -SD/PR- 08734
 
{</section>}
 
{<section id="asfq001.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfq001_qty03_tmp ——> asfq001_tmp01
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
PRIVATE TYPE type_g_sfaa_d RECORD
       
       sel LIKE type_t.chr1, 
   sfaa003 LIKE sfaa_t.sfaa003, 
   sfaadocno LIKE sfaa_t.sfaadocno, 
   prog_b_sfaadocno STRING, 
   sfaadocdt LIKE sfaa_t.sfaadocdt, 
   sfaa002 LIKE sfaa_t.sfaa002, 
   sfaa002_desc LIKE type_t.chr500, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   sfaa010_desc LIKE type_t.chr500, 
   sfaa010_desc_1 LIKE type_t.chr500, 
   sfaa012 LIKE sfaa_t.sfaa012, 
   sfaa019 LIKE sfaa_t.sfaa019, 
   sfaa020 LIKE sfaa_t.sfaa020, 
   sfaastus LIKE sfaa_t.sfaastus
       END RECORD
PRIVATE TYPE type_g_sfaa2_d RECORD
       sfbaseq LIKE sfba_t.sfbaseq, 
   sfbaseq1 LIKE sfba_t.sfbaseq1, 
   sfba006 LIKE sfba_t.sfba006, 
   sfba006_desc LIKE type_t.chr500, 
   sfba006_desc_1 LIKE type_t.chr500, 
   sfba021 LIKE sfba_t.sfba021, 
   sfba014 LIKE sfba_t.sfba014, 
   sfba014_desc LIKE type_t.chr500, 
   sfba013 LIKE sfba_t.sfba013, 
   sfba019 LIKE sfba_t.sfba019, 
   sfba019_desc LIKE type_t.chr500, 
   sfba020 LIKE sfba_t.sfba020, 
   sfba020_desc LIKE type_t.chr500, 
   inag008 LIKE inag_t.inag008, 
   qty01 LIKE type_t.num20_6, 
   inan010 LIKE inan_t.inan010, 
   qty02 LIKE type_t.num20_6, 
   str01 LIKE type_t.chr500, 
   qty03 LIKE type_t.num20_6
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_tm                 RECORD
                                radio01     LIKE type_t.chr1,
                                check01     LIKE type_t.chr1
                             END RECORD
DEFINE tm                    type_tm
#end add-point
 
#模組變數(Module Variables)
DEFINE g_sfaa_d            DYNAMIC ARRAY OF type_g_sfaa_d
DEFINE g_sfaa_d_t          type_g_sfaa_d
DEFINE g_sfaa2_d     DYNAMIC ARRAY OF type_g_sfaa2_d
DEFINE g_sfaa2_d_t   type_g_sfaa2_d
 
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num10             #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
DEFINE g_wc2_table2   STRING
DEFINE g_detail2_page_action2 STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
DEFINE g_wc2_filter_table2   STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="asfq001.main" >}
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
   CALL asfq001_create_tmp()
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
   DECLARE asfq001_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE asfq001_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asfq001_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfq001 WITH FORM cl_ap_formpath("asf",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asfq001_init()   
 
      #進入選單 Menu (="N")
      CALL asfq001_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asfq001
      
   END IF 
   
   CLOSE asfq001_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL asfq001_drop_tmp()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asfq001.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION asfq001_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('b_sfaastus','13','C,D,F,M,N,R,W,Y,X')
 
      CALL cl_set_combo_scc('b_sfaa003','4007') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('sfaa003','4007') 
   
   LET tm.radio01 = '2'
   LET tm.check01 = 'N'
   #end add-point
 
   CALL asfq001_default_search()
END FUNCTION
 
{</section>}
 
{<section id="asfq001.default_search" >}
PRIVATE FUNCTION asfq001_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " sfaadocno = '", g_argv[01], "' AND "
   END IF
 
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfq001.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfq001_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   DEFINE ls_js     STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
 
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   #應用 qs03 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT後，需先將顯示欄位開啟、查詢欄位隱藏 
   CALL gfrm_curr.setFieldHidden('b_sfaadocno', TRUE) 
   CALL gfrm_curr.setFieldHidden('prog_b_sfaadocno', FALSE) 
 
  
 
 
 
   CALL asfq001_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_sfaa_d.clear()
         CALL g_sfaa2_d.clear()
 
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL asfq001_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         CONSTRUCT BY NAME g_wc ON sfaa003,sfaadocno,sfaadocdt,sfaa002,
                                   sfaa010,sfaa012,sfaa019,sfaa020
            ON ACTION controlp INFIELD sfaadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "sfaasite = '",g_site,"' "
               CALL q_sfaadocno_1()
               DISPLAY g_qryparam.return1 TO sfaadocno
               NEXT FIELD sfaadocno
         
            ON ACTION controlp INFIELD sfaa002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO sfaa002
               NEXT FIELD sfaa002
         
            ON ACTION controlp INFIELD sfaa010
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001_9()
               DISPLAY g_qryparam.return1 TO sfaa010
                     NEXT FIELD sfaa010
         
         END CONSTRUCT 
         
         INPUT BY NAME tm.radio01,tm.check01 ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT

            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF
         END INPUT 
         
         INPUT ARRAY g_sfaa_d FROM s_detail1.*
               ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec, WITHOUT DEFAULTS,
                         INSERT ROW = FALSE,
                         DELETE ROW = FALSE,
                         APPEND ROW = FALSE)
            BEFORE INPUT
               LET g_detail_cnt = g_sfaa_d.getLength()
               
            BEFORE ROW
               LET g_detail_idx = ARR_CURR()
               DISPLAY g_detail_idx TO FORMONLY.h_index
               LET g_detail_cnt = g_sfaa_d.getLength()
               CALL asfq001_b_fill()   #151112 Sarah add
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
#         #end add-point
#     
#         DISPLAY ARRAY g_sfaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
# 
#            BEFORE DISPLAY
#               LET g_current_page = 1
# 
#            BEFORE ROW
#               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
#               LET l_ac = g_detail_idx
#               CALL asfq001_detail_action_trans()
# 
#               LET g_master_idx = l_ac
#               #為避免按上下筆時影響執行效能，所以做一些處理
#               LET lc_action_choice_old = g_action_choice
#               LET g_action_choice = "fetch"
#               CALL asfq001_b_fill2()
#               LET g_action_choice = lc_action_choice_old
# 
#               #add-point:input段before row name="input.body.before_row"
 
#               #end add-point
# 
#            
# 
#            #自訂ACTION(detail_show,page_1)
#            
# 
#         #應用 a43 樣板自動產生(Version:4)
#         ON ACTION detail_qrystr
#               MENU "" ATTRIBUTE(STYLE="popup")
#                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page1_sub."
 
#                  #END add-point
#                                 #應用 a43 樣板自動產生(Version:4)
#               ON ACTION prog_asft300
#                  LET g_action_choice="prog_asft300"
#                  IF cl_auth_chk_act("prog_asft300") THEN
#                     
#                     #add-point:ON ACTION prog_asft300 name="menu.detail_show.page1_sub.prog_asft300"
 
#                     #END add-point
#                     
#                     
#                  END IF
# 
# 
# 
#               #應用 a43 樣板自動產生(Version:4)
#               ON ACTION prog_saft300
#                  LET g_action_choice="prog_saft300"
#                  IF cl_auth_chk_act("prog_saft300") THEN
#                     
#                     #add-point:ON ACTION prog_saft300 name="menu.detail_show.page1_sub.prog_saft300"
 
#                     #END add-point
#                     
#                     
#                  END IF
# 
# 
# 
# 
#               END MENU
# 
# 
# 
#               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
               
 
 
 
 
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
 
#            #end add-point
# 
#         END DISPLAY
# 
#         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_sfaa2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
 
#               #end add-point
# 
#            #自訂ACTION(detail_show,page_2)
#            
# 
#            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
 
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL asfq001_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
            NEXT FIELD sfaa003
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
 
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table2
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table2
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL asfq001_b_fill()
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_sfaa_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_sfaa2_d)
               LET g_export_id[2]   = "s_detail2"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL asfq001_b_fill()
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL asfq001_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL asfq001_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL asfq001_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL asfq001_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_sfaa_d.getLength()
               LET g_sfaa_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_sfaa_d.getLength()
               LET g_sfaa_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_sfaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_sfaa_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_sfaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_sfaa_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL asfq001_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert name="menu.insert"
               
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
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION updstus
            LET g_action_choice="updstus"
            IF cl_auth_chk_act("updstus") THEN
               
               #add-point:ON ACTION updstus name="menu.updstus"
               CALL asfq001_updstus()
               CALL asfq001_b_fill()
               #END add-point
               
               
            END IF
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"
            
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="asfq001.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asfq001_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_success       LIKE type_t.num5 
   
   DEFINE l_sfba006       LIKE sfba_t.sfba006
   DEFINE l_sfba013       LIKE sfba_t.sfba013
   DEFINE l_sfba014       LIKE sfba_t.sfba014
   DEFINE l_sql           STRING 
   DEFINE l_i             LIKE type_t.num5 
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
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_sfaa_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #temp table的資料清空
   DELETE FROM asfq001_tmp01  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfq001_qty03_tmp ——> asfq001_tmp01
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',sfaa003,sfaadocno,sfaadocdt,sfaa002,'',sfaa010,'','',sfaa012, 
       sfaa019,sfaa020,sfaastus  ,DENSE_RANK() OVER( ORDER BY sfaa_t.sfaadocno) AS RANK FROM sfaa_t", 
 
 
#table2
                     " LEFT JOIN sfba_t ON sfbaent = sfaaent AND sfaadocno = sfbadocno",
 
                     "",
                     " WHERE sfaaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("sfaa_t"),
                     " ORDER BY sfaa_t.sfaadocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
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
 
   LET g_sql = "SELECT '',sfaa003,sfaadocno,sfaadocdt,sfaa002,'',sfaa010,'','',sfaa012,sfaa019,sfaa020, 
       sfaastus",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT UNIQUE 'N',sfaa003,sfaadocno,sfaadocdt,sfaa002,'', ",
               "       sfaa010,'','',sfaa012,sfaa019,sfaa020,sfaastus ",
               "  FROM sfaa_t LEFT JOIN sfba_t ON sfbaent = sfaaent AND sfaadocno = sfbadocno",
               " WHERE sfaaent = ? ",
               "   AND sfaasite = '",g_site,"' ",
               "   AND 1=1 ",
               "   AND ", ls_wc
               
   CASE tm.radio01
      WHEN '1'
         LET g_sql = g_sql CLIPPED," AND sfaastus = 'N' "
      WHEN '2'
         LET g_sql = g_sql CLIPPED," AND sfaastus = 'Y' "
      WHEN '3'
         LET g_sql = g_sql CLIPPED," AND (sfaastus = 'N' OR sfaastus = 'Y') "
      OTHERWISE
         EXIT CASE
   END CASE

   LET g_sql = g_sql, cl_sql_add_filter("sfaa_t"),
                      " ORDER BY sfaa_t.sfaadocno" 
                      
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asfq001_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asfq001_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_sfaa_d[l_ac].sel,g_sfaa_d[l_ac].sfaa003,g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfaadocdt, 
       g_sfaa_d[l_ac].sfaa002,g_sfaa_d[l_ac].sfaa002_desc,g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa010_desc, 
       g_sfaa_d[l_ac].sfaa010_desc_1,g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020, 
       g_sfaa_d[l_ac].sfaastus
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      #應用 qs24 樣板自動產生(Version:5) 
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = asfq001_get_hyper_data("prog_b_sfaadocno")
         LET g_sfaa_d[l_ac].prog_b_sfaadocno = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_sfaa_d[l_ac].sfaadocno), 
             "</a>"
 
      ELSE 
         LET g_sfaa_d[l_ac].prog_b_sfaadocno = g_sfaa_d[l_ac].sfaadocno
 
      END IF 
 
 
 
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      LET l_sql = " SELECT sfba006,sfba013,sfba014 ",
                  "   FROM sfba_t ",
                  "  WHERE sfbaent = '",g_enterprise,"' ",
                  "    AND sfbasite = '",g_site,"' ",
                  "    AND sfbadocno = '",g_sfaa_d[l_ac].sfaadocno,"' ",
                  "  ORDER BY sfbaseq "
      PREPARE asfq001_ins_qty03_tmp_prep FROM l_sql
      DECLARE asfq001_ins_qty03_tmp_curs CURSOR FOR asfq001_ins_qty03_tmp_prep
      FOREACH asfq001_ins_qty03_tmp_curs INTO l_sfba006,l_sfba013,l_sfba014
         INSERT INTO asfq001_tmp01(sfaaent,sfaasite,sfaadocno,sfba006,sfba013,sfba014)  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfq001_qty03_tmp ——> asfq001_tmp01
              VALUES(g_enterprise,g_site,g_sfaa_d[l_ac].sfaadocno,l_sfba006,l_sfba013,l_sfba014)
      END FOREACH
      #end add-point
 
      CALL asfq001_detail_show("'1'")
 
      CALL asfq001_sfaa_t_mask()
 
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
 
 
 
 
 
   #應用 qs05 樣板自動產生(Version:4)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   CALL cl_err_collect_init()
   
   FOR l_i = 1 TO l_ac-1 
      IF tm.check01 = 'Y' THEN
         LET l_success = ''
         CALL asfq001_auto_select(g_sfaa_d[l_i].sfaadocno) RETURNING l_success
         IF l_success THEN
            LET g_sfaa_d[l_i].sel = 'Y'
         END IF
      END IF 
   END FOR  
   
   CALL cl_err_collect_init()
   CALL cl_err_collect_show() 
    
   #end add-point
 
   CALL g_sfaa_d.deleteElement(g_sfaa_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_sfaa_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE asfq001_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL asfq001_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL asfq001_detail_action_trans()
 
   LET l_ac = 1
   IF g_sfaa_d.getLength() > 0 THEN
      CALL asfq001_b_fill2()
   END IF
 
      CALL asfq001_filter_show('sfaa003','b_sfaa003')
   CALL asfq001_filter_show('sfaadocno','b_sfaadocno')
   CALL asfq001_filter_show('sfaadocdt','b_sfaadocdt')
   CALL asfq001_filter_show('sfaa002','b_sfaa002')
   CALL asfq001_filter_show('sfaa010','b_sfaa010')
   CALL asfq001_filter_show('sfaa012','b_sfaa012')
   CALL asfq001_filter_show('sfaa019','b_sfaa019')
   CALL asfq001_filter_show('sfaa020','b_sfaa020')
   CALL asfq001_filter_show('sfaastus','b_sfaastus')
   CALL asfq001_filter_show('sfbaseq','b_sfbaseq')
   CALL asfq001_filter_show('sfbaseq1','b_sfbaseq1')
   CALL asfq001_filter_show('sfba006','b_sfba006')
   CALL asfq001_filter_show('sfba021','b_sfba021')
   CALL asfq001_filter_show('sfba014','b_sfba014')
   CALL asfq001_filter_show('sfba013','b_sfba013')
   CALL asfq001_filter_show('sfba019','b_sfba019')
   CALL asfq001_filter_show('sfba020','b_sfba020')
   CALL asfq001_filter_show('inag008','b_inag008')
   CALL asfq001_filter_show('inan010','b_inan010')
 
 
END FUNCTION
 
{</section>}
 
{<section id="asfq001.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asfq001_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
#Page2
   CALL g_sfaa2_d.clear()
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   
   #end add-point
 
#table2
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE sfbaseq,sfbaseq1,sfba006,'','',sfba021,sfba014,'',sfba013,sfba019, 
          '',sfba020,'','','','','','','' FROM sfba_t",
                  "",
                  " WHERE sfbaent=? AND sfbadocno=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY sfba_t.sfbaseq,sfba_t.sfbaseq1"
  
      #add-point:單身填充前 name="b_fill2.before_fill2"
   LET g_sql = "SELECT UNIQUE sfbaseq,sfbaseq1,sfba006,'','', ",
               "       sfba021,sfba014,'',sfba013,sfba019,'', ",
               "       sfba020,'','0','0','0','0','','0' ",
               "  FROM sfba_t",
               " WHERE sfbaent = ? ",
               "   AND sfbadocno = ? ",
               "   AND sfbasite = '",g_site,"' "

   IF NOT cl_null(g_wc2_table2) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
   END IF

   LET g_sql = g_sql, " ORDER BY sfba_t.sfbaseq,sfba_t.sfbaseq1" 
   
   CALL cl_err_collect_init()
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE asfq001_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR asfq001_pb2
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs2 USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs2
      USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
      INTO g_sfaa2_d[l_ac].sfbaseq,g_sfaa2_d[l_ac].sfbaseq1,g_sfaa2_d[l_ac].sfba006,g_sfaa2_d[l_ac].sfba006_desc, 
          g_sfaa2_d[l_ac].sfba006_desc_1,g_sfaa2_d[l_ac].sfba021,g_sfaa2_d[l_ac].sfba014,g_sfaa2_d[l_ac].sfba014_desc, 
          g_sfaa2_d[l_ac].sfba013,g_sfaa2_d[l_ac].sfba019,g_sfaa2_d[l_ac].sfba019_desc,g_sfaa2_d[l_ac].sfba020, 
          g_sfaa2_d[l_ac].sfba020_desc,g_sfaa2_d[l_ac].inag008,g_sfaa2_d[l_ac].qty01,g_sfaa2_d[l_ac].inan010, 
          g_sfaa2_d[l_ac].qty02,g_sfaa2_d[l_ac].str01,g_sfaa2_d[l_ac].qty03
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill2"
      #取得庫存可用量 
      CALL s_inventory_get_inag008_2(g_site,g_sfaa2_d[l_ac].sfba006,g_sfaa2_d[l_ac].sfba021,
                                     g_sfaa2_d[l_ac].sfba019,g_sfaa2_d[l_ac].sfba020,'','',
                                     g_sfaa2_d[l_ac].sfba014)
           RETURNING l_success,g_sfaa2_d[l_ac].inag008

      #取得在揀量
      CALL s_inventory_get_inan010_2(g_site,g_sfaa2_d[l_ac].sfba006,g_sfaa2_d[l_ac].sfba021,
                                     g_sfaa2_d[l_ac].sfba019,g_sfaa2_d[l_ac].sfba020,'','',
                                     g_sfaa2_d[l_ac].sfba014)
           RETURNING l_success,g_sfaa2_d[l_ac].inan010 
           
      #計算可用餘量 
      #庫存可用量 - 在檢量 - 備置量 
      LET g_sfaa2_d[l_ac].qty02 = g_sfaa2_d[l_ac].inag008 -
                                  g_sfaa2_d[l_ac].inan010 -
                                  g_sfaa2_d[l_ac].qty01

      #計算其他工單備料量 
      CALL asfq001_get_qty03(g_sfaa_d[g_detail_idx].sfaadocno,g_sfaa2_d[l_ac].sfba006,
                             g_sfaa2_d[l_ac].sfba014)
           RETURNING g_sfaa2_d[l_ac].qty03

      CASE
         WHEN (g_sfaa2_d[l_ac].qty02>g_sfaa2_d[l_ac].sfba013+g_sfaa2_d[l_ac].qty03)
            #是 
            LET g_sfaa2_d[l_ac].str01 = cl_getmsg('asf-00416',g_lang)

         WHEN (g_sfaa2_d[l_ac].qty02<g_sfaa2_d[l_ac].sfba013)
            #否 
            LET g_sfaa2_d[l_ac].str01 = cl_getmsg('asf-00417',g_lang)

         WHEN (g_sfaa2_d[l_ac].sfba013 <= g_sfaa2_d[l_ac].qty02 <= g_sfaa2_d[l_ac].sfba013+g_sfaa2_d[l_ac].qty03)
            #需人工判斷 
            LET g_sfaa2_d[l_ac].str01 = cl_getmsg('asf-00418',g_lang)

         OTHERWISE
            EXIT CASE
      END CASE
      #end add-point
 
      CALL asfq001_detail_show("'2'")
 
      CALL asfq001_sfba_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
#Page2
   CALL g_sfaa2_d.deleteElement(g_sfaa2_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   CALL cl_err_collect_init()
   CALL cl_err_collect_show() 
   #end add-point
 
#Page2
   LET li_ac = g_sfaa2_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="asfq001.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asfq001_detail_show(ps_page)
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

      CALL asfq001_sfaa002_ref(g_sfaa_d[l_ac].sfaa002)
           RETURNING g_sfaa_d[l_ac].sfaa002_desc
      DISPLAY BY NAME g_sfaa_d[l_ac].sfaa002_desc

      CALL asfq001_sfaa010_ref01(g_sfaa_d[l_ac].sfaa010)
           RETURNING g_sfaa_d[l_ac].sfaa010_desc
      DISPLAY BY NAME g_sfaa_d[l_ac].sfaa010_desc

      CALL asfq001_sfaa010_ref02(g_sfaa_d[l_ac].sfaa010)
           RETURNING g_sfaa_d[l_ac].sfaa010_desc_1
      DISPLAY BY NAME g_sfaa_d[l_ac].sfaa010_desc_1
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body2.reference"

      CALL asfq001_sfaa010_ref01(g_sfaa2_d[l_ac].sfba006)
           RETURNING g_sfaa2_d[l_ac].sfba006_desc
      DISPLAY BY NAME g_sfaa2_d[l_ac].sfba006_desc 
            
      CALL asfq001_sfaa010_ref02(g_sfaa2_d[l_ac].sfba006)
           RETURNING g_sfaa2_d[l_ac].sfba006_desc_1
      DISPLAY BY NAME g_sfaa2_d[l_ac].sfba006_desc_1

      CALL asfq001_sfba014_ref(g_sfaa2_d[l_ac].sfba014)
           RETURNING g_sfaa2_d[l_ac].sfba014_desc
      DISPLAY BY NAME g_sfaa2_d[l_ac].sfba014_desc

      CALL asfq001_sfba019_ref(g_site,g_sfaa2_d[l_ac].sfba019)
           RETURNING g_sfaa2_d[l_ac].sfba019_desc
      DISPLAY BY NAME g_sfaa2_d[l_ac].sfba019_desc

      CALL asfq001_sfba020_ref(g_site,g_sfaa2_d[l_ac].sfba019,g_sfaa2_d[l_ac].sfba020)
           RETURNING g_sfaa2_d[l_ac].sfba020_desc
      DISPLAY BY NAME g_sfaa2_d[l_ac].sfba020_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfq001.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION asfq001_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   #應用 qs02 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT前，需先將查詢欄位開啟、顯示欄位隱藏 
   CALL gfrm_curr.setFieldHidden('prog_b_sfaadocno', TRUE) 
   CALL gfrm_curr.setFieldHidden('b_sfaadocno', FALSE) 
 
  
 
 
 
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON sfaa003,sfaadocno,sfaadocdt,sfaa002,sfaa010,sfaa012,sfaa019,sfaa020,sfaastus 
 
                          FROM s_detail1[1].b_sfaa003,s_detail1[1].b_sfaadocno,s_detail1[1].b_sfaadocdt, 
                              s_detail1[1].b_sfaa002,s_detail1[1].b_sfaa010,s_detail1[1].b_sfaa012,s_detail1[1].b_sfaa019, 
                              s_detail1[1].b_sfaa020,s_detail1[1].b_sfaastus
 
         BEFORE CONSTRUCT
                     DISPLAY asfq001_filter_parser('sfaa003') TO s_detail1[1].b_sfaa003
            DISPLAY asfq001_filter_parser('sfaadocno') TO s_detail1[1].b_sfaadocno
            DISPLAY asfq001_filter_parser('sfaadocdt') TO s_detail1[1].b_sfaadocdt
            DISPLAY asfq001_filter_parser('sfaa002') TO s_detail1[1].b_sfaa002
            DISPLAY asfq001_filter_parser('sfaa010') TO s_detail1[1].b_sfaa010
            DISPLAY asfq001_filter_parser('sfaa012') TO s_detail1[1].b_sfaa012
            DISPLAY asfq001_filter_parser('sfaa019') TO s_detail1[1].b_sfaa019
            DISPLAY asfq001_filter_parser('sfaa020') TO s_detail1[1].b_sfaa020
            DISPLAY asfq001_filter_parser('sfaastus') TO s_detail1[1].b_sfaastus
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_sfaa003>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa003
            #add-point:ON ACTION controlp INFIELD b_sfaa003 name="construct.c.filter.page1.b_sfaa003"
            
            #END add-point
 
 
         #----<<b_sfaadocno>>----
         #Ctrlp:construct.c.page1.b_sfaadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaadocno
            #add-point:ON ACTION controlp INFIELD b_sfaadocno name="construct.c.filter.page1.b_sfaadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_sfaadocno_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfaadocno  #顯示到畫面上
            NEXT FIELD b_sfaadocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<prog_b_sfaadocno>>----
         #----<<b_sfaadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_sfaadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaadocdt
            #add-point:ON ACTION controlp INFIELD b_sfaadocdt name="construct.c.filter.page1.b_sfaadocdt"
            
            #END add-point
 
 
         #----<<b_sfaa002>>----
         #Ctrlp:construct.c.page1.b_sfaa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa002
            #add-point:ON ACTION controlp INFIELD b_sfaa002 name="construct.c.filter.page1.b_sfaa002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfaa002  #顯示到畫面上
            NEXT FIELD b_sfaa002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_sfaa002_desc>>----
         #----<<b_sfaa010>>----
         #Ctrlp:construct.c.page1.b_sfaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa010
            #add-point:ON ACTION controlp INFIELD b_sfaa010 name="construct.c.filter.page1.b_sfaa010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfaa010  #顯示到畫面上
            NEXT FIELD b_sfaa010                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_sfaa010_desc>>----
         #----<<b_sfaa010_desc_1>>----
         #----<<b_sfaa012>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa012
            #add-point:ON ACTION controlp INFIELD b_sfaa012 name="construct.c.filter.page1.b_sfaa012"
            
            #END add-point
 
 
         #----<<b_sfaa019>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa019
            #add-point:ON ACTION controlp INFIELD b_sfaa019 name="construct.c.filter.page1.b_sfaa019"
            
            #END add-point
 
 
         #----<<b_sfaa020>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa020
            #add-point:ON ACTION controlp INFIELD b_sfaa020 name="construct.c.filter.page1.b_sfaa020"
            
            #END add-point
 
 
         #----<<b_sfaastus>>----
         #Ctrlp:construct.c.filter.page1.b_sfaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaastus
            #add-point:ON ACTION controlp INFIELD b_sfaastus name="construct.c.filter.page1.b_sfaastus"
            
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
 
 
 
 
 
   #應用 qs03 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT後，需先將顯示欄位開啟、查詢欄位隱藏 
   CALL gfrm_curr.setFieldHidden('b_sfaadocno', TRUE) 
   CALL gfrm_curr.setFieldHidden('prog_b_sfaadocno', FALSE) 
 
  
 
 
 
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL asfq001_filter_show('sfaa003','b_sfaa003')
   CALL asfq001_filter_show('sfaadocno','b_sfaadocno')
   CALL asfq001_filter_show('sfaadocdt','b_sfaadocdt')
   CALL asfq001_filter_show('sfaa002','b_sfaa002')
   CALL asfq001_filter_show('sfaa010','b_sfaa010')
   CALL asfq001_filter_show('sfaa012','b_sfaa012')
   CALL asfq001_filter_show('sfaa019','b_sfaa019')
   CALL asfq001_filter_show('sfaa020','b_sfaa020')
   CALL asfq001_filter_show('sfaastus','b_sfaastus')
   CALL asfq001_filter_show('sfbaseq','b_sfbaseq')
   CALL asfq001_filter_show('sfbaseq1','b_sfbaseq1')
   CALL asfq001_filter_show('sfba006','b_sfba006')
   CALL asfq001_filter_show('sfba021','b_sfba021')
   CALL asfq001_filter_show('sfba014','b_sfba014')
   CALL asfq001_filter_show('sfba013','b_sfba013')
   CALL asfq001_filter_show('sfba019','b_sfba019')
   CALL asfq001_filter_show('sfba020','b_sfba020')
   CALL asfq001_filter_show('inag008','b_inag008')
   CALL asfq001_filter_show('inan010','b_inan010')
 
 
   CALL asfq001_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="asfq001.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION asfq001_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
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
 
{<section id="asfq001.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION asfq001_filter_show(ps_field,ps_object)
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
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = asfq001_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="asfq001.get_hyper_data" >}
#應用 qs01 樣板自動產生(Version:9) 
#+ 取得單身串查網址(包含程式代號及參數) 
PRIVATE FUNCTION asfq001_get_hyper_data(ps_field_name) 
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
      WHEN ps_field_name = "prog_b_sfaadocno" 
         LET la_param.prog = "asft300" 
  
         # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、... 
         #應用 qs25 樣板自動產生(Version:3)
         #+ 產生串查功能傳入參數部分
 
 
 
         LET la_param.param[1] = g_sfaa_d[l_ac].sfaadocno 
         #add-point:傳入參數設定 name="get_hyper_data.set_parameter_prog_b_sfaadocno" 
         
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
 
{<section id="asfq001.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION asfq001_detail_action_trans()
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
 
{<section id="asfq001.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION asfq001_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
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
            IF g_sfaa_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_sfaa_d.getLength() AND g_sfaa_d.getLength() > 0
            LET g_detail_idx = g_sfaa_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_sfaa_d.getLength() THEN
               LET g_detail_idx = g_sfaa_d.getLength()
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
 
{<section id="asfq001.mask_functions" >}
 &include "erp/asf/asfq001_mask.4gl"
 
{</section>}
 
{<section id="asfq001.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 計算其他工單備料量 
# Memo...........:
# Usage..........: CALL asfq001_get_qty03(p_sfaadocno,p_sfba006,p_unit)
#                  RETURNING r_qty 
# Input parameter: p_sfaadocno：單號 
#                : p_sfba006  ：料號 
#                : p_unit     ：單位 
# Return code....: r_qty      ：數量 
# Date & Author..: 2014/08/20 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq001_get_qty03(p_sfaadocno,p_sfba006,p_unit)
   DEFINE p_sfaadocno     LIKE sfaa_t.sfaadocno    #單號  
   DEFINE p_sfba006       LIKE sfba_t.sfba006      #料號  
   DEFINE p_unit          LIKE sfba_t.sfba014
   DEFINE l_sfba013       LIKE sfba_t.sfba013      #總應發數量  
   DEFINE l_sfba014       LIKE sfba_t.sfba014      #單位  
   DEFINE l_rate          LIKE inaj_t.inaj014      #單位換算率 
   DEFINE l_sql           STRING
   DEFINE l_success       LIKE type_t.num5
   DEFINE r_qty           LIKE type_t.num20_6  
   
   IF cl_null(p_sfaadocno) OR cl_null(p_sfba006) OR cl_null(p_unit) THEN
      RETURN 0
   END IF
   
   LET l_sql = "SELECT sfba013,sfba014 ",
               "  FROM asfq001_tmp01 ",  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfq001_qty03_tmp ——> asfq001_tmp01
               " WHERE sfaaent = '",g_enterprise,"' ",
               "   AND sfaasite = '",g_site,"' ",
               "   AND sfaadocno <> '",p_sfaadocno,"' ",
               "   AND sfba006 = '",p_sfba006,"' "
   PREPARE asfq001_get_qty03_prep FROM l_sql
   DECLARE asfq001_get_qty03_curs CURSOR FOR asfq001_get_qty03_prep

   LET r_qty = 0
   LET l_sfba013 = ''
   LET l_sfba014 = ''
   FOREACH asfq001_get_qty03_curs INTO l_sfba013,l_sfba014 
      #避免錯誤的資料導致單位是空的 
      IF cl_null(l_sfba014) THEN
         CONTINUE FOREACH
      END IF
      
      IF cl_null(l_sfba013) THEN
         LET l_sfba013 = 0
      END IF
      
      IF p_unit != l_sfba014 THEN 
         CALL s_aooi250_convert_qty(p_sfba006,l_sfba014,p_unit,l_sfba013) 
              RETURNING l_success,l_sfba013 
      END IF 
      
      LET r_qty = r_qty + l_sfba013 
      
   END FOREACH 
   
   RETURN r_qty
END FUNCTION

PRIVATE FUNCTION asfq001_sfaa002_ref(p_sfaa002)
   DEFINE p_sfaa002     LIKE sfaa_t.sfaa002
   DEFINE r_ooag011     LIKE ooag_t.ooag011
   DEFINE ls_sql        STRING

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_sfaa002
   LET ls_sql = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? "
   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
   LET r_ooag011 = '', g_rtn_fields[1] , ''

   RETURN r_ooag011
END FUNCTION

PRIVATE FUNCTION asfq001_sfaa010_ref01(p_sfaa010)
   DEFINE p_sfaa010     LIKE sfaa_t.sfaa010
   DEFINE r_imaal003    LIKE imaal_t.imaal003
   DEFINE ls_sql        STRING

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_sfaa010
   LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
   LET r_imaal003 = '', g_rtn_fields[1] , ''

   RETURN r_imaal003
END FUNCTION

PRIVATE FUNCTION asfq001_sfaa010_ref02(p_sfaa010)
   DEFINE p_sfaa010     LIKE sfaa_t.sfaa010
   DEFINE r_imaal004    LIKE imaal_t.imaal004
   DEFINE ls_sql        STRING

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_sfaa010
   LET ls_sql = "SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
   LET r_imaal004 = '', g_rtn_fields[1] , ''

   RETURN r_imaal004
END FUNCTION

PRIVATE FUNCTION asfq001_sfba014_ref(p_sfba014)
   DEFINE p_sfba014     LIKE sfba_t.sfba014
   DEFINE r_oocal003    LIKE oocal_t.oocal003
   DEFINE ls_sql        STRING

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_sfba014
   LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
   LET r_oocal003 = '', g_rtn_fields[1] , ''

   RETURN r_oocal003
END FUNCTION

PRIVATE FUNCTION asfq001_sfba019_ref(p_site,p_sfba019)
   DEFINE p_site     LIKE sfaa_t.sfaasite
   DEFINE p_sfba019  LIKE sfba_t.sfba019
   DEFINE r_inaa002  LIKE inaa_t.inaa002
   DEFINE ls_sql     STRING

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_site
   LET g_ref_fields[2] = p_sfba019
   LET ls_sql = "SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite=? AND inaa001=? "
   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
   LET r_inaa002 = '', g_rtn_fields[1] , ''

   RETURN r_inaa002
END FUNCTION

PRIVATE FUNCTION asfq001_sfba020_ref(p_site,p_sfba019,p_sfba020)
   DEFINE p_site      LIKE sfaa_t.sfaasite
   DEFINE p_sfba019   LIKE sfba_t.sfba019
   DEFINE p_sfba020   LIKE sfba_t.sfba020
   DEFINE r_inab003   LIKE inab_t.inab003
   DEFINE ls_sql      STRING

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_site
   LET g_ref_fields[2] = p_sfba019
   LET g_ref_fields[3] = p_sfba020
   LET ls_sql = "SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite=? AND inab001=? AND inab002 = ? "
   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
   LET r_inab003 = '', g_rtn_fields[1] , ''

   RETURN r_inab003
END FUNCTION

################################################################################
# Descriptions...: 檢查是否自動勾選
# Memo...........:
# Usage..........: CALL asfq001_auto_select(p_sfaadocno)
#                  RETURNING r_success
# Input parameter: p_sfaadocno：單號
# Return code....: r_success  ：true/false 
# Date & Author..: 2014/08/20 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq001_auto_select(p_sfaadocno)
   DEFINE p_sfaadocno     LIKE sfaa_t.sfaadocno
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE l_sfba          type_g_sfaa2_d
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.chr1

   INITIALIZE l_sfba.* TO NULL

   LET l_sql = "SELECT UNIQUE sfbaseq,sfbaseq1,sfba006,'','', ",
               "       sfba021,sfba014,'',sfba013,sfba019,'', ",
               "       sfba020,'','0','0','0','0','','0' ",
               "  FROM sfba_t",
               " WHERE sfbaent = '",g_enterprise,"' ",
               "   AND sfbadocno = '",p_sfaadocno,"' ",
               "   AND sfbasite = '",g_site,"' "

   IF NOT cl_null(g_wc2_table2) THEN
      LET l_sql = l_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
   END IF

   LET l_sql = l_sql, " ORDER BY sfba_t.sfbaseq,sfba_t.sfbaseq1" 
   
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE asfq001_auto_select_prep FROM l_sql
   DECLARE asfq001_auto_select_curs CURSOR FOR asfq001_auto_select_prep

   LET r_success = TRUE
   LET l_flag = '0'
   FOREACH asfq001_auto_select_curs INTO l_sfba.sfbaseq,l_sfba.sfbaseq1,l_sfba.sfba006,
                                         l_sfba.sfba006_desc,l_sfba.sfba006_desc_1,l_sfba.sfba021,l_sfba.sfba014,
                                         l_sfba.sfba014_desc,l_sfba.sfba013,l_sfba.sfba019,l_sfba.sfba019_desc,
                                         l_sfba.sfba020,l_sfba.sfba020_desc,l_sfba.inag008,l_sfba.qty01,
                                         l_sfba.inan010,l_sfba.qty02,l_sfba.str01,l_sfba.qty03
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_flag = '1' 
      
      #取得庫存可用量 
      CALL s_inventory_get_inag008_2(g_site,l_sfba.sfba006,l_sfba.sfba021,
                                     l_sfba.sfba019,l_sfba.sfba020,'','',
                                     l_sfba.sfba014)
           RETURNING l_success,l_sfba.inag008

      #取得在揀量
      CALL s_inventory_get_inan010_2(g_site,l_sfba.sfba006,l_sfba.sfba021,
                                     l_sfba.sfba019,l_sfba.sfba020,'','',
                                     l_sfba.sfba014)
           RETURNING l_success,l_sfba.inan010

      #計算可用餘量 
      #庫存可用量 - 在檢量 - 備置量 
      LET l_sfba.qty02 = l_sfba.inag008 -
                         l_sfba.inan010 -
                         l_sfba.qty01

      #計算其他工單備料量 
      CALL asfq001_get_qty03(p_sfaadocno,l_sfba.sfba006,
                             l_sfba.sfba014)
           RETURNING l_sfba.qty03 
      CASE
         WHEN (l_sfba.qty02>l_sfba.sfba013+l_sfba.qty03)
            #是 
            #LET l_sfba.str01 = cl_getmsg('asf-00416',g_lang)

         WHEN (l_sfba.qty02<l_sfba.sfba013)
            #否 
            #LET l_sfba.str01 = cl_getmsg('asf-00417',g_lang)
            LET r_success = FALSE
            EXIT FOREACH

         WHEN (l_sfba.sfba013 <= l_sfba.qty02 <= l_sfba.sfba013+l_sfba.qty03)
            #需人工判斷 
            #LET l_sfba.str01 = cl_getmsg('asf-00418',g_lang)
            LET r_success = FALSE
            EXIT FOREACH

         OTHERWISE
            EXIT CASE
      END CASE

      INITIALIZE l_sfba.* TO NULL
   END FOREACH

   IF l_flag = '0' THEN
      LET r_success = FALSE
   END IF 
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 更新工單狀態為已發放
# Memo...........:
# Usage..........: CALL asfq001_updstus()
# Date & Author..: 2014/08/20 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq001_updstus()
   DEFINE l_i        LIKE type_t.num5
   DEFINE l_success  LIKE type_t.num5
   
   DEFINE l_sfaastus LIKE sfaa_t.sfaastus
   DEFINE l_sfaasite LIKE sfaa_t.sfaasite
   DEFINE l_sfaa003  LIKE sfaa_t.sfaa003
   DEFINE l_sfaa010  LIKE sfaa_t.sfaa010
   DEFINE l_sfaa011  LIKE sfaa_t.sfaa011
   DEFINE l_sfaa012  LIKE sfaa_t.sfaa012
   DEFINE l_sfaa015  LIKE sfaa_t.sfaa015
   DEFINE l_ooba002  LIKE ooba_t.ooba002
   DEFINE l_n        LIKE type_t.num5
   DEFINE l_num      LIKE type_t.num5

   IF g_sfaa_d.getLength() < 1 THEN
      RETURN
   END IF

   CALL s_transaction_begin()
   LET l_success = TRUE
   FOR l_i = 1 TO g_sfaa_d.getLength()
      #如果沒有被選取的就直接跳下一筆 
      IF g_sfaa_d[l_i].sel = 'N' THEN
         CONTINUE FOR
      END IF

      LET l_sfaasite = ''
      LET l_sfaa003 = ''
      LET l_sfaa010 = ''
      LET l_sfaa011 = ''
      LET l_sfaa012 = ''
      LET l_sfaa015 = ''

      SELECT sfaastus  ,sfaasite  ,sfaa003  ,sfaa010  ,sfaa011  ,sfaa012  ,sfaa015
        INTO l_sfaastus,l_sfaasite,l_sfaa003,l_sfaa010,l_sfaa011,l_sfaa012,l_sfaa015
        FROM sfaa_t
       WHERE sfaaent   = g_enterprise
         AND sfaadocno = g_sfaa_d[l_i].sfaadocno

      IF l_sfaastus = 'Y' THEN
         #已確認的資料就直接發放即可 
         UPDATE sfaa_t SET sfaastus = 'F'
          WHERE sfaaent   = g_enterprise
            AND sfaadocno = g_sfaa_d[l_i].sfaadocno

          CASE
             WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = ''
                LET g_errparam.code   = 'std-00009' 
                LET g_errparam.popup  = TRUE
                CALL cl_err()

                LET l_success = FALSE
                EXIT FOR

             WHEN SQLCA.sqlcode #其他錯誤
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = SQLCA.sqlcode
                LET g_errparam.code   = SQLCA.sqlcode
                LET g_errparam.popup  = TRUE
                CALL cl_err()

                LET l_success = FALSE
                EXIT FOR
          END CASE

      ELSE
         #未確認的資料需先做確認，再看單別的參數決定是否自動發放，如果為N，就停在已確認 
         CALL s_asft300_01_confirm(g_sfaa_d[l_i].sfaadocno)
              RETURNING l_success

         IF NOT l_success THEN
            EXIT FOR
         END IF

         CALL s_aooi200_get_slip(g_sfaa_d[l_i].sfaadocno) RETURNING l_success,l_ooba002
         IF cl_get_doc_para(g_enterprise,l_sfaasite,l_ooba002,'D-MFG-0040') = 'Y' THEN
            IF cl_get_doc_para(g_enterprise,l_sfaasite,l_ooba002,'D-MFG-0038') = '2' THEN
               SELECT COUNT(*) INTO l_n
                 FROM sfba_t
                WHERE sfbaent   = g_enterprise
                  AND sfbasite  = l_sfaasite
                  AND sfbadocno = g_sfaa_d[l_i].sfaadocno
               IF l_n = 0 THEN
                  CALL s_asft300_02(g_sfaa_d[l_i].sfaadocno,l_sfaa003,l_sfaa010,
                                    l_sfaa011,l_sfaa015,l_sfaa012,'N')
                       RETURNING l_success,l_num
                  IF NOT l_success THEN
                     EXIT FOR
                  END IF
               END IF
            END IF

            #IF g_sfaa_m.sfaa004 = '2' THEN
            #   IF NOT asft300_upd_sfcb('INIT','0') THEN
            #      RETURN
            #   END IF
            #END IF

            LET l_sfaastus = ''
            SELECT sfaastus INTO l_sfaastus
              FROM sfaa_t
             WHERE sfaaent   = g_enterprise
               AND sfaadocno = g_sfaa_d[l_i].sfaadocno

            IF l_sfaastus = 'Y' THEN
               UPDATE sfaa_t SET sfaastus = 'F'
                WHERE sfaaent   = g_enterprise
                  AND sfaadocno = g_sfaa_d[l_i].sfaadocno

               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'std-00009'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     LET l_success = FALSE
                     EXIT FOR

                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = SQLCA.sqlcode
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()

                     LET l_success = FALSE
                     EXIT FOR
               END CASE
            END IF
         END IF
      END IF
   END FOR

   IF l_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
END FUNCTION

PRIVATE FUNCTION asfq001_create_tmp()
   CREATE TEMP TABLE asfq001_tmp01(  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfq001_qty03_tmp ——> asfq001_tmp01
      sfaaent        LIKE sfaa_t.sfaaent,
      sfaasite       LIKE sfaa_t.sfaasite,
      sfaadocno      LIKE sfaa_t.sfaadocno,
      sfba006        LIKE sfba_t.sfba006,
      sfba013        LIKE sfba_t.sfba013,
      sfba014        LIKE sfba_t.sfba014
   )
END FUNCTION

PRIVATE FUNCTION asfq001_drop_tmp()
   DROP TABLE asfq001_tmp01  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfq001_qty03_tmp ——> asfq001_tmp01
END FUNCTION

 
{</section>}
 
