#該程式未解開Section, 採用最新樣板產出!
{<section id="astq521.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-03-29 09:31:00), PR版次:0004(2016-10-24 17:38:27)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000043
#+ Filename...: astq521
#+ Description: 專櫃會員積分查詢
#+ Creator....: 06778(2015-09-08 17:48:30)
#+ Modifier...: 06815 -SD/PR- 06189
 
{</section>}
 
{<section id="astq521.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#add by geza 20161024 #161024-00025#10 aooi500规范调整
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
PRIVATE TYPE type_g_rtjb_d RECORD
       #statepic       LIKE type_t.chr1,
       
       rtjbent LIKE rtjb_t.rtjbent, 
   rtjbdocno LIKE rtjb_t.rtjbdocno, 
   rtjbseq LIKE rtjb_t.rtjbseq, 
   l_sdate1 LIKE type_t.dat, 
   l_edate1 LIKE type_t.dat, 
   rtjbsite LIKE rtjb_t.rtjbsite, 
   rtjbsite_desc LIKE type_t.chr500, 
   rtjb028 LIKE rtjb_t.rtjb028, 
   rtjb028_desc LIKE type_t.chr500, 
   stfa051 LIKE stfa_t.stfa051, 
   stfa051_desc LIKE type_t.chr500, 
   stfa011 LIKE stfa_t.stfa011, 
   stfa011_desc LIKE type_t.chr500, 
   rtjb021 LIKE rtjb_t.rtjb021, 
   rtjb029 LIKE rtjb_t.rtjb029 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_rtjb2_d RECORD
             rtjadocdt     LIKE type_t.dat,
             rtjb028 LIKE rtjb_t.rtjb028, 
             rtjb028_desc LIKE type_t.chr500, 
             stfa051 LIKE stfa_t.stfa051,
             stfa051_desc LIKE type_t.chr500,              
             stfa011 LIKE stfa_t.stfa011,
             stfa011_desc LIKE type_t.chr500,              
             rtjb021 LIKE rtjb_t.rtjb021, 
             rtjb029 LIKE rtjb_t.rtjb029
       END RECORD
 
 TYPE type_g_rtjb3_d RECORD
             rtjadocdt     LIKE type_t.dat,
             rtjbsite LIKE rtjb_t.rtjbsite, 
             rtjb004 LIKE type_t.chr500,
             rtjb004_desc LIKE type_t.chr500,              
             rtjb025 LIKE type_t.chr500,
             rtjb025_desc LIKE type_t.chr500,              
             rtjb028 LIKE rtjb_t.rtjb028,
             rtjb028_desc LIKE type_t.chr500,              
             stfa051 LIKE stfa_t.stfa051,
             stfa051_desc LIKE type_t.chr500,              
             stfa011 LIKE stfa_t.stfa011,
             stfa011_desc LIKE type_t.chr500,              
             rtjb021 LIKE rtjb_t.rtjb021, 
             rtjb029 LIKE rtjb_t.rtjb029
       END RECORD
 
 TYPE type_g_rtjb4_d RECORD
             l_sdate4 LIKE type_t.dat, 
             l_edate4 LIKE type_t.dat, 
             stfa051 LIKE stfa_t.stfa051,
             stfa051_desc LIKE type_t.chr500,             
             rtjb021 LIKE rtjb_t.rtjb021, 
             rtjb029 LIKE rtjb_t.rtjb029
       END RECORD
       
DEFINE g_rtjb2_d   DYNAMIC ARRAY OF type_g_rtjb2_d
DEFINE g_rtjb2_d_t type_g_rtjb2_d
 
DEFINE g_rtjb3_d   DYNAMIC ARRAY OF type_g_rtjb3_d
DEFINE g_rtjb3_d_t type_g_rtjb3_d
 
DEFINE g_rtjb4_d   DYNAMIC ARRAY OF type_g_rtjb4_d
DEFINE g_rtjb4_d_t type_g_rtjb4_d  


 TYPE type_g_tm RECORD
             l_sdate LIKE type_t.dat, 
             l_edate LIKE type_t.dat, 
             rtjbsite LIKE rtjb_t.rtjbsite, 
             rtjb028 LIKE rtjb_t.rtjb028, 
             rtaw001 LIKE rtaw_t.rtaw001, 
             rtax003 LIKE rtax_t.rtax003, 
             rtjb004 LIKE type_t.chr500, 
             rtjb025 LIKE type_t.chr500 
       END RECORD
       
DEFINE g_tm     type_g_tm 
DEFINE g_wc_table1           STRING
DEFINE g_sql_t               STRING
DEFINE l_ac2                 LIKE type_t.num10
DEFINE l_ac3                 LIKE type_t.num10
DEFINE l_ac4                 LIKE type_t.num10

DEFINE g_detail_cnt5         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_detail_cnt3         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_detail_cnt4         LIKE type_t.num10             #單身 總筆數(所有資料)
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_rtjb_d
DEFINE g_master_t                   type_g_rtjb_d
DEFINE g_rtjb_d          DYNAMIC ARRAY OF type_g_rtjb_d
DEFINE g_rtjb_d_t        type_g_rtjb_d
 
      
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
 
{<section id="astq521.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #add by geza 20161024 #161024-00025#10 
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
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
   DECLARE astq521_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE astq521_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astq521_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astq521 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astq521_init()   
 
      #進入選單 Menu (="N")
      CALL astq521_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_astq521
      
   END IF 
   
   CLOSE astq521_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE astq521_tmp
   CALL s_aooi500_drop_temp() RETURNING l_success #add by geza 20161024 #161024-00025#10 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="astq521.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION astq521_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
 
   CALL astq521_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="astq521.default_search" >}
PRIVATE FUNCTION astq521_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " rtjbdocno = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " rtjbseq = '", g_argv[02], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段開始後 name="default_search.after"
   INITIALIZE g_tm.* TO NULL   
   CALL astq521_create_temp() RETURNING l_success
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astq521.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION astq521_ui_dialog()
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
   LET g_wc = g_wc," AND 1=1"   #160126-00002#3 160130 By s983961 add
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL astq521_b_fill()
   ELSE
      CALL astq521_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_rtjb_d.clear()
 
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
 
         CALL astq521_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_rtjb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL astq521_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL astq521_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #160126-00002#3 160130 By s983961 add(S)
         CONSTRUCT g_wc_table1 ON rtjbsite,rtjb028,rtaw001,rtjb025,rtjb004,rtax003
                          FROM rtjbsite,rtjb028,rtaw001,rtjb025,rtjb004,rtax003
          
           ON ACTION controlp INFIELD rtjbsite
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c' 
              LET g_qryparam.reqry = FALSE
              LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjbsite',g_site,'c')
              CALL q_ooef001_24()                           #呼叫開窗
              DISPLAY g_qryparam.return1 TO rtjbsite  #顯示到畫面上
              NEXT FIELD rtjbsite
           
           ON ACTION controlp INFIELD rtjb028
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c' 
              LET g_qryparam.reqry = FALSE
              CALL q_inaa120()                           #呼叫開窗
              DISPLAY g_qryparam.return1 TO rtjb028  #顯示到畫面上
              NEXT FIELD rtjb028
              
           ON ACTION controlp INFIELD rtaw001
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
		    	  LET g_qryparam.reqry = FALSE
			     LET g_qryparam.where = " rtax004 ='",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"
              CALL q_rtax001()                       #呼叫開窗
              DISPLAY g_qryparam.return1 TO rtaw001  #顯示到畫面上
              NEXT FIELD rtaw001     
             
           ON ACTION controlp INFIELD rtjb004
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c' 
              LET g_qryparam.reqry = FALSE
              CALL q_rtdx001()                           #呼叫開窗
              DISPLAY g_qryparam.return1 TO rtjb004  #顯示到畫面上
              NEXT FIELD rtjb004                     #返回原欄位
           
           ON ACTION controlp INFIELD rtjb025
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c' 
              LET g_qryparam.reqry = FALSE
              CALL q_inaa001_1()                           #呼叫開窗
              DISPLAY g_qryparam.return1 TO rtjb025  #顯示到畫面上
              NEXT FIELD rtjb025 
           
           ON ACTION controlp INFIELD rtax003
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
		    	  LET g_qryparam.reqry = FALSE
			     LET g_qryparam.where = " rtax004 ='4' "  #'",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"
              CALL q_rtax001()                       #呼叫開窗
              DISPLAY g_qryparam.return1 TO rtax003  #顯示到畫面上
              NEXT FIELD rtax003           
                         
         END CONSTRUCT
         
         INPUT g_tm.l_sdate,g_tm.l_edate FROM l_sdate,l_edate
            
            BEFORE INPUT
               
               
            AFTER INPUT
            
         END INPUT
         #160126-00002#3 160130 By s983961 add(E)
         DISPLAY ARRAY g_rtjb2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt3)
            BEFORE DISPLAY
               LET g_current_page = 2
            BEFORE ROW
              LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
              LET l_ac2 = g_detail_idx
              DISPLAY l_ac2 TO FORMONLY.h_index
              DISPLAY g_rtjb2_d.getLength() TO FORMONLY.h_count
              DISPLAY ' ' TO FORMONLY.p_start
              DISPLAY ' ' TO FORMONLY.p_end
  
         END DISPLAY
         
         DISPLAY ARRAY g_rtjb3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt4)
            BEFORE DISPLAY
               LET g_current_page = 3
            BEFORE ROW
              LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
              LET l_ac3 = g_detail_idx
              DISPLAY l_ac3 TO FORMONLY.h_index
              DISPLAY g_rtjb3_d.getLength() TO FORMONLY.h_count
              DISPLAY ' ' TO FORMONLY.p_start
              DISPLAY ' ' TO FORMONLY.p_end
  
         END DISPLAY
         
         DISPLAY ARRAY g_rtjb4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt5)
            BEFORE DISPLAY
               LET g_current_page = 4
            BEFORE ROW
              LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
              LET l_ac4 = g_detail_idx
              DISPLAY l_ac4 TO FORMONLY.h_index
              DISPLAY g_rtjb4_d.getLength() TO FORMONLY.h_count
              DISPLAY ' ' TO FORMONLY.p_start
              DISPLAY ' ' TO FORMONLY.p_end
  
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL astq521_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            #160126-00002#3 160130 By s983961 add(S)
            CALL cl_set_act_visible("insert,query", FALSE)
            CALL cl_set_act_visible("selall,selnone,sel,unsel,filter", FALSE)
            CALL cl_set_comp_visible("sel", FALSE)
            
            #DISPLAY g_site TO rtjbsite #lanjj mark on 2016-04-27
            LET g_tm.l_sdate = g_today
            LET g_tm.l_edate = g_today
            DISPLAY g_tm.l_sdate TO l_sdate
            DISPLAY g_tm.l_edate TO l_edate
            #160126-00002#3 160130 By s983961 add(E)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL astq521_insert()
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
               CALL astq521_query()
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
            CALL astq521_filter()
            #add-point:ON ACTION filter name="menu.filter"
            CALL cl_set_comp_visible("sel", FALSE)   #160126-00002#3 160127 By s983961 add
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
            CALL astq521_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_rtjb_d)
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
            CALL astq521_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL astq521_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL astq521_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL astq521_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         #160126-00002#3 160127 By s983961 add(s)
         ON ACTION ACCEPT
            IF cl_null(g_tm.l_sdate) THEN 
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'acr-00015'
              LET g_errparam.extend = ''
              LET g_errparam.popup = FALSE
              CALL cl_err()
              NEXT FIELD l_sdate             
            END IF
            
            IF cl_null(g_tm.l_edate) THEN 
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'acr-00015'
              LET g_errparam.extend = ''
              LET g_errparam.popup = FALSE
              CALL cl_err()
              NEXT FIELD l_edate             
            END IF
            
            LET g_wc = g_wc_table1 
            LET g_wc2 = " 1=1"  
            
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL astq521_b_fill()
            IF g_rtjb_d.getLength() > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            END IF
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
         #160126-00002#3 160127 By s983961 add(e) 
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
 
{<section id="astq521.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION astq521_query()
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
   CALL g_rtjb_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON rtjbent
           FROM s_detail1[1].b_rtjbent
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_rtjbent>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtjbent
            #add-point:BEFORE FIELD b_rtjbent name="construct.b.page1.b_rtjbent"
            NEXT FIELD rtjbsite
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtjbent
            
            #add-point:AFTER FIELD b_rtjbent name="construct.a.page1.b_rtjbent"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtjbent
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjbent
            #add-point:ON ACTION controlp INFIELD b_rtjbent name="construct.c.page1.b_rtjbent"
            
            #END add-point
 
 
         #----<<b_rtjbdocno>>----
         #----<<b_rtjbseq>>----
         #----<<l_sdate1>>----
         #----<<l_edate1>>----
         #----<<b_rtjbsite>>----
         #----<<b_rtjbsite_desc>>----
         #----<<b_rtjb028>>----
         #----<<b_rtjb028_desc>>----
         #----<<b_stfa051>>----
         #----<<b_stfa051_desc>>----
         #----<<b_stfa011>>----
         #----<<b_stfa011_desc>>----
         #----<<b_rtjb021>>----
         #----<<b_rtjb029>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
       CONSTRUCT g_wc_table1 ON rtjbsite,rtjb028,rtaw001,rtjb025,rtjb004,rtax003
                          FROM rtjbsite,rtjb028,rtaw001,rtjb025,rtjb004,rtax003
          
           ON ACTION controlp INFIELD rtjbsite
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c' 
              LET g_qryparam.reqry = FALSE
              LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjbsite',g_site,'c')
              CALL q_ooef001_24()                           #呼叫開窗
              DISPLAY g_qryparam.return1 TO rtjbsite  #顯示到畫面上
              NEXT FIELD rtjbsite
           
           ON ACTION controlp INFIELD rtjb028
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c' 
              LET g_qryparam.reqry = FALSE
              CALL q_inaa120()                           #呼叫開窗
              DISPLAY g_qryparam.return1 TO rtjb028  #顯示到畫面上
              NEXT FIELD rtjb028
              
           ON ACTION controlp INFIELD rtaw001
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
		    	  LET g_qryparam.reqry = FALSE
			     LET g_qryparam.where = " rtax004 ='",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"
              CALL q_rtax001()                       #呼叫開窗
              DISPLAY g_qryparam.return1 TO rtaw001  #顯示到畫面上
              NEXT FIELD rtaw001     
             
           ON ACTION controlp INFIELD rtjb004
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c' 
              LET g_qryparam.reqry = FALSE
              CALL q_rtdx001()                           #呼叫開窗
              DISPLAY g_qryparam.return1 TO rtjb004  #顯示到畫面上
              NEXT FIELD rtjb004                     #返回原欄位
           
           ON ACTION controlp INFIELD rtjb025
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c' 
              LET g_qryparam.reqry = FALSE
              CALL q_inaa001_1()                           #呼叫開窗
              DISPLAY g_qryparam.return1 TO rtjb025  #顯示到畫面上
              NEXT FIELD rtjb025 
           
           ON ACTION controlp INFIELD rtax003
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
		    	  LET g_qryparam.reqry = FALSE
			     LET g_qryparam.where = " rtax004 ='4' "  #'",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"
              CALL q_rtax001()                       #呼叫開窗
              DISPLAY g_qryparam.return1 TO rtax003  #顯示到畫面上
              NEXT FIELD rtax003           
                         
      END CONSTRUCT
      
      INPUT g_tm.l_sdate,g_tm.l_edate FROM l_sdate,l_edate
         
         BEFORE INPUT
            
            
         AFTER INPUT
         
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
      BEFORE DIALOG 
             #DISPLAY g_site TO rtjbsite #lanjj mark on 2016-04-27
             LET g_tm.l_sdate = g_today
             LET g_tm.l_edate = g_today
             DISPLAY g_tm.l_sdate TO l_sdate
             DISPLAY g_tm.l_edate TO l_edate
            
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

   LET g_wc = g_wc_table1 
 
 
        
   LET g_wc2 = " 1=1"


   #end add-point
        
   LET g_error_show = 1
   CALL astq521_b_fill()
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
 
{<section id="astq521.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astq521_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
#   DEFINE l_success       LIKE type_t.num5
#   
#   CALL astq521_create_temp() RETURNING l_success
   DEFINE l_where       STRING
   DEFINE l_success     LIKE type_t.num5
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'rtjbsite') RETURNING l_where
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   LET g_wc = g_wc," AND ",l_where
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
 
   LET ls_sql_rank = "SELECT  UNIQUE rtjbent,rtjbdocno,rtjbseq,'','',rtjbsite,'',rtjb028,'','','','', 
       '',rtjb021,rtjb029  ,DENSE_RANK() OVER( ORDER BY rtjb_t.rtjbdocno,rtjb_t.rtjbseq) AS RANK FROM rtjb_t", 
 
 
 
                     "",
                     " WHERE rtjbent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("rtjb_t"),
                     " ORDER BY rtjb_t.rtjbdocno,rtjb_t.rtjbseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   LET ls_wc = cl_replace_str(ls_wc, "rtaw", "t8.rtaw") 
   LET ls_wc = cl_replace_str(ls_wc, "rtax", "t10.rtax") 
   
   
   LET g_sql_t = "SELECT  UNIQUE rtjbent,rtjbdocno,rtjbseq, ",
                     "               to_date('",g_tm.l_sdate,"','yy/mm/dd') l_sdate ,",
                     "               to_date('",g_tm.l_edate,"','yy/mm/dd') l_edate ,",
                     "               to_date(to_char(rtjadocdt,'yy/mm/dd'),'yy/mm/dd') rtjadocdt  ,",
                     "               rtjbsite,t1.ooefl003 rtjbsite_desc,
                                     rtjb004,t3.imaal003 rtjb004_desc ,
                                     rtjb025,t4.inaa002  rtjb025_desc  ,
                                     rtjb028, t5.mhael024 rtjb028_desc ,
                                     t8.rtaw001 stfa051,t6.rtaxl003 stfa051_desc,
                                     t10.rtax003 stfa011,t7.rtaxl003 stfa011_desc,
                                     COALESCE(rtjb021,0) rtjb021, COALESCE(rtjb029,0) rtjb029
                                     FROM rtja_t,rtjb_t",
 
 
                     "  LEFT JOIN ooefl_t t1 ON t1.ooefl001=rtjbsite   AND t1.ooefl002='",g_dlang,"'",
                     
                   # "  LEFT JOIN stfa_t  t2 ON t2.stfaent =rtjbent    AND t2.stfa005=rtjb028 ",
                    
                     "  LEFT JOIN imaa_t t0  ON t0.imaaent=rtjbent     AND t0.imaa001=rtjb004 ",
                     "  LEFT JOIN rtaw_t t8  ON t8.rtawent=t0.imaaent  AND t8.rtaw002=t0.imaa009 
                                                                       AND t8.rtaw003='",cl_get_para(g_enterprise,"","E-CIR-0001"),"' ",
                     "  LEFT JOIN rtaxl_t t6 ON t6.rtaxlent=t8.rtawent AND t6.rtaxl001=t8.rtaw001 AND t6.rtaxl002='",g_dlang,"'",                      
                     
                     "  LEFT JOIN rtax_t  t9  ON t9.rtaxent =t0.imaaent   AND t9.rtax001=t0.imaa009 ",
                     "  LEFT JOIN rtax_t  t10 ON t10.rtaxent=t9.rtaxent   AND t10.rtax001=t9.rtax003 ",
                     
                     "  LEFT JOIN rtaxl_t t7 ON t7.rtaxlent=t10.rtaxent AND t7.rtaxl001=t10.rtax003 AND t7.rtaxl002='",g_dlang,"'",
                     
                     "  LEFT JOIN imaal_t t3 ON t3.imaalent=rtjbent    AND t3.imaal001=rtjb004 AND t3.imaal002='",g_dlang,"'",
                     "  LEFT JOIN inaa_t  t4 ON t4.inaaent =rtjbent    AND t4.inaa001 =rtjb025 ",
                     "  LEFT JOIN mhael_t t5 ON t5.mhaelent=rtjbent    AND t5.mhael001=rtjb028 AND t5.mhael022='",g_dlang,"'",
                     
                     
                     
                     " WHERE rtjbent=",g_enterprise," AND 1=1 ",#AND rtjbsite='",g_site,"'", #lanjj mark on 2016-04-27
                     "   AND rtjaent=rtjbent AND rtjadocno=rtjbdocno ",
                     "   AND rtjadocdt BETWEEN to_date('",g_tm.l_sdate,"','yy/mm/dd')",
                     "   AND                   to_date('",g_tm.l_edate,"','yy/mm/dd')",
                     "   AND ", ls_wc
                     
   LET g_sql_t = g_sql_t, cl_sql_add_filter("rtjb_t"), " ORDER BY rtjbsite" 
   
   DELETE FROM astq521_tmp
   LET g_sql =    " INSERT INTO astq521_tmp(   rtjbent,rtjbdocno,rtjbseq,l_sdate,l_edate,
                                               rtjadocdt,rtjbsite,rtjbsite_desc,rtjb004,rtjb004_desc,rtjb025,rtjb025_desc,
                                               rtjb028,rtjb028_desc, 
                                               stfa051,stfa051_desc,stfa011,stfa011_desc,rtjb021,rtjb029 ) ",g_sql_t
   EXECUTE IMMEDIATE g_sql

   LET ls_sql_rank = " SELECT l_sdate,l_edate,rtjbsite,rtjbsite_desc,rtjb028,rtjb028_desc,stfa051,stfa051_desc,
                              stfa011,stfa011_desc,SUM(rtjb021),SUM(rtjb029) 
                         FROM astq521_tmp 
                        WHERE rtjbent=?
                        GROUP BY l_sdate,l_edate,rtjbsite,rtjbsite_desc,rtjb028,rtjb028_desc,
                                 stfa051,stfa051_desc,stfa011,stfa011_desc ",
                     "  ORDER BY l_sdate"
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
 
   LET g_sql = "SELECT rtjbent,rtjbdocno,rtjbseq,'','',rtjbsite,'',rtjb028,'','','','','',rtjb021,rtjb029", 
 
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = " SELECT '','','',l_sdate,l_edate,rtjbsite,rtjbsite_desc,rtjb028,rtjb028_desc,
                        stfa051,stfa051_desc,stfa011,stfa011_desc,SUM(rtjb021),SUM(rtjb029) 
                   FROM astq521_tmp 
                  WHERE rtjbent=?
                  GROUP BY l_sdate,l_edate,rtjbsite,rtjbsite_desc,rtjb028,rtjb028_desc,
                           stfa051,stfa051_desc,stfa011,stfa011_desc ",
               "  ORDER BY l_sdate"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE astq521_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR astq521_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_rtjb_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_rtjb_d[l_ac].rtjbent,g_rtjb_d[l_ac].rtjbdocno,g_rtjb_d[l_ac].rtjbseq,g_rtjb_d[l_ac].l_sdate1, 
       g_rtjb_d[l_ac].l_edate1,g_rtjb_d[l_ac].rtjbsite,g_rtjb_d[l_ac].rtjbsite_desc,g_rtjb_d[l_ac].rtjb028, 
       g_rtjb_d[l_ac].rtjb028_desc,g_rtjb_d[l_ac].stfa051,g_rtjb_d[l_ac].stfa051_desc,g_rtjb_d[l_ac].stfa011, 
       g_rtjb_d[l_ac].stfa011_desc,g_rtjb_d[l_ac].rtjb021,g_rtjb_d[l_ac].rtjb029
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_rtjb_d[l_ac].statepic = cl_get_actipic(g_rtjb_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL astq521_detail_show("'1'")      
 
      CALL astq521_rtjb_t_mask()
 
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
   
 
   
   CALL g_rtjb_d.deleteElement(g_rtjb_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   CALL astq521_b_fill2()
   CALL astq521_b_fill3()
   CALL astq521_b_fill4()
   #end add-point
 
   LET g_detail_cnt = g_rtjb_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE astq521_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL astq521_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL astq521_detail_action_trans()
 
   IF g_rtjb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL astq521_fetch()
   END IF
   
      CALL astq521_filter_show('rtjbent','b_rtjbent')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astq521.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astq521_fetch()
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
 
{<section id="astq521.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION astq521_detail_show(ps_page)
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

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_rtjb_d[l_ac].rtjbsite
#            LET ls_sql = "SELECT ooefl002 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl003='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_rtjb_d[l_ac].rtjbsite_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_rtjb_d[l_ac].rtjbsite_desc
#
#   INITIALIZE g_ref_fields TO NULL 
#   LET g_ref_fields[1] = .rtjbdocno
#   LET g_ref_fields[2] = .rtjbseq
#   LET ls_sql = " SELECT stfa011_3 FROM stfa_t WHERE stfaent = '"||g_enterprise||"' AND "
#   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#   CALL ap_ref_array2(g_ref_fields,ls_sel_sql,"") RETURNING g_rtn_fields 
#   LET g_rtjb_d[l_ac].stfa011_3 = g_rtn_fields[1] 
#   DISPLAY BY NAME g_rtjb_d[l_ac].stfa011_3
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astq521.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION astq521_filter()
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
      CONSTRUCT g_wc_filter ON rtjbent
                          FROM s_detail1[1].b_rtjbent
 
         BEFORE CONSTRUCT
                     DISPLAY astq521_filter_parser('rtjbent') TO s_detail1[1].b_rtjbent
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_rtjbent>>----
         #Ctrlp:construct.c.filter.page1.b_rtjbent
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjbent
            #add-point:ON ACTION controlp INFIELD b_rtjbent name="construct.c.filter.page1.b_rtjbent"
            
            #END add-point
 
 
         #----<<b_rtjbdocno>>----
         #----<<b_rtjbseq>>----
         #----<<l_sdate1>>----
         #----<<l_edate1>>----
         #----<<b_rtjbsite>>----
         #----<<b_rtjbsite_desc>>----
         #----<<b_rtjb028>>----
         #----<<b_rtjb028_desc>>----
         #----<<b_stfa051>>----
         #----<<b_stfa051_desc>>----
         #----<<b_stfa011>>----
         #----<<b_stfa011_desc>>----
         #----<<b_rtjb021>>----
         #----<<b_rtjb029>>----
   
 
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
   
      CALL astq521_filter_show('rtjbent','b_rtjbent')
 
    
   CALL astq521_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="astq521.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION astq521_filter_parser(ps_field)
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
 
{<section id="astq521.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION astq521_filter_show(ps_field,ps_object)
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
   LET ls_condition = astq521_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="astq521.insert" >}
#+ insert
PRIVATE FUNCTION astq521_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="astq521.modify" >}
#+ modify
PRIVATE FUNCTION astq521_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astq521.reproduce" >}
#+ reproduce
PRIVATE FUNCTION astq521_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astq521.delete" >}
#+ delete
PRIVATE FUNCTION astq521_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astq521.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION astq521_detail_action_trans()
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
 
{<section id="astq521.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION astq521_detail_index_setting()
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
            IF g_rtjb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_rtjb_d.getLength() AND g_rtjb_d.getLength() > 0
            LET g_detail_idx = g_rtjb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_rtjb_d.getLength() THEN
               LET g_detail_idx = g_rtjb_d.getLength()
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
 
{<section id="astq521.mask_functions" >}
 &include "erp/ast/astq521_mask.4gl"
 
{</section>}
 
{<section id="astq521.other_function" readonly="Y" >}

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
PRIVATE FUNCTION astq521_create_temp()

   DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
    
   # 创建明细资料页签临时表
   DROP TABLE astq521_tmp
   CREATE TEMP TABLE astq521_tmp(
               rtjbent       LIKE rtjb_t.rtjbent, 
               rtjbdocno     LIKE rtjb_t.rtjbdocno, 
               rtjbseq       LIKE rtjb_t.rtjbseq, 
               l_sdate       LIKE type_t.dat, 
               l_edate       LIKE type_t.dat,
               rtjadocdt     LIKE type_t.dat,
               rtjbsite      LIKE rtjb_t.rtjbsite, 
               rtjbsite_desc LIKE type_t.chr500,
               rtjb004       LIKE rtjb_t.rtjb004,
               rtjb004_desc  LIKE type_t.chr500,               
               rtjb025       LIKE rtjb_t.rtjb025,
               rtjb025_desc  LIKE type_t.chr500,               
               rtjb028       LIKE rtjb_t.rtjb028,
               rtjb028_desc  LIKE type_t.chr500,               
               stfa051       LIKE stfa_t.stfa051,
               stfa051_desc  LIKE type_t.chr500,               
               stfa011       LIKE stfa_t.stfa011,
               stfa011_desc  LIKE type_t.chr500,             
               rtjb021       LIKE rtjb_t.rtjb021, 
               rtjb029       LIKE rtjb_t.rtjb029 )
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create Temp Table astq521_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   CREATE INDEX astq521_tmp_01 ON astq521_tmp(rtjbsite)
     
   RETURN r_success

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
PRIVATE FUNCTION astq521_b_fill2()

   LET g_sql = " SELECT rtjadocdt,rtjb028,rtjb028_desc,stfa051,stfa051_desc,stfa011,stfa011_desc,SUM(rtjb021),SUM(rtjb029) 
                   FROM astq521_tmp 
                  WHERE rtjbent=?
                  GROUP BY rtjadocdt,rtjb028,rtjb028_desc,stfa051,stfa051_desc,stfa011,stfa011_desc ",
               "  ORDER BY rtjadocdt"
  
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE astq521_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR astq521_pb2
   
   OPEN b_fill_curs2 USING g_enterprise
 
   CALL g_rtjb2_d.clear()
  
   LET l_ac2 = 1   
 
   FOREACH b_fill_curs2 INTO g_rtjb2_d[l_ac2].rtjadocdt,g_rtjb2_d[l_ac2].rtjb028,g_rtjb2_d[l_ac2].rtjb028_desc,
                             g_rtjb2_d[l_ac2].stfa051,  g_rtjb2_d[l_ac2].stfa051_desc,
                             g_rtjb2_d[l_ac2].stfa011,  g_rtjb2_d[l_ac2].stfa011_desc,
                             g_rtjb2_d[l_ac2].rtjb021,  g_rtjb2_d[l_ac2].rtjb029
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs2:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
     
      IF l_ac2 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      LET l_ac2 = l_ac2 + 1
      
   END FOREACH
   
   CALL g_rtjb2_d.deleteElement(g_rtjb2_d.getLength()) 
   
   LET g_detail_cnt3 = g_rtjb2_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
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
PRIVATE FUNCTION astq521_b_fill3()


   LET g_sql = " SELECT rtjadocdt,rtjbsite,rtjb004,rtjb004_desc,rtjb025,rtjb025_desc,rtjb028,rtjb028_desc,
                        stfa051,stfa051_desc,stfa011,stfa011_desc,SUM(rtjb021),SUM(rtjb029) 
                   FROM astq521_tmp 
                  WHERE rtjbent=?
                  GROUP BY rtjadocdt,rtjbsite,rtjb004,rtjb004_desc,rtjb025,rtjb025_desc,rtjb028,rtjb028_desc,
                           stfa051,stfa051_desc,stfa011,stfa011_desc ",
               "  ORDER BY rtjadocdt "
  
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE astq521_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR astq521_pb3
   
   OPEN b_fill_curs3 USING g_enterprise
 
   CALL g_rtjb3_d.clear()
  
   LET l_ac3 = 1   
 
   FOREACH b_fill_curs3 INTO g_rtjb3_d[l_ac3].rtjadocdt,g_rtjb3_d[l_ac3].rtjbsite,g_rtjb3_d[l_ac3].rtjb004,
                             g_rtjb3_d[l_ac3].rtjb004_desc,
                             g_rtjb3_d[l_ac3].rtjb025, g_rtjb3_d[l_ac3].rtjb025_desc,  
                             g_rtjb3_d[l_ac3].rtjb028, g_rtjb3_d[l_ac3].rtjb028_desc, 
                             g_rtjb3_d[l_ac3].stfa051, g_rtjb3_d[l_ac3].stfa051_desc,
                             g_rtjb3_d[l_ac3].stfa011, g_rtjb3_d[l_ac3].stfa011_desc,  
                             g_rtjb3_d[l_ac3].rtjb021, g_rtjb3_d[l_ac3].rtjb029
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs3:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
     
      IF l_ac3 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      LET l_ac3 = l_ac3 + 1
      
   END FOREACH
   
   CALL g_rtjb3_d.deleteElement(g_rtjb3_d.getLength()) 

   LET g_detail_cnt4 = g_rtjb3_d.getLength()
   LET l_ac3 = g_cnt
   LET g_cnt = 0

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
PRIVATE FUNCTION astq521_b_fill4()


   LET g_sql = " SELECT l_sdate,l_edate,stfa051,stfa051_desc,SUM(rtjb021),SUM(rtjb029) 
                   FROM astq521_tmp 
                  WHERE rtjbent=?
                  GROUP BY l_sdate,l_edate,stfa051,stfa051_desc ",
               "  ORDER BY l_sdate "
  
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE astq521_pb4 FROM g_sql
   DECLARE b_fill_curs4 CURSOR FOR astq521_pb4
   
   OPEN b_fill_curs4 USING g_enterprise
 
   CALL g_rtjb4_d.clear()
  
   LET l_ac4 = 1   
 
   FOREACH b_fill_curs4 INTO g_rtjb4_d[l_ac4].l_sdate4,g_rtjb4_d[l_ac4].l_edate4,
                             g_rtjb4_d[l_ac4].stfa051, g_rtjb4_d[l_ac4].stfa051_desc,
                             g_rtjb4_d[l_ac4].rtjb021, g_rtjb4_d[l_ac4].rtjb029
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs4:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
     
      IF l_ac4 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      LET l_ac4 = l_ac4 + 1
      
   END FOREACH
   
   CALL g_rtjb4_d.deleteElement(g_rtjb4_d.getLength()) 
   LET g_detail_cnt5 = g_rtjb4_d.getLength()
   LET l_ac4 = g_cnt
   LET g_cnt = 0


END FUNCTION

 
{</section>}
 
