#該程式未解開Section, 採用最新樣板產出!
{<section id="astq522.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-03-29 17:16:46), PR版次:0002(2016-10-28 09:05:14)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: astq522
#+ Description: 週期銷售毛利及坪效對比查詢作業
#+ Creator....: 06540(2015-09-21 15:28:32)
#+ Modifier...: 06815 -SD/PR- 08742
 
{</section>}
 
{<section id="astq522.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#161024-00025#11   2016/10/27  by 08742  组织开窗调整
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
PRIVATE TYPE type_g_debg_d RECORD
       #statepic       LIKE type_t.chr1,
       
       debg007 LIKE debg_t.debg007, 
   rtaxl003 LIKE rtaxl_t.rtaxl003, 
   debg005 LIKE debg_t.debg005, 
   stfal003 LIKE stfal_t.stfal003, 
   l_un_day LIKE type_t.num5, 
   l_debg017 LIKE type_t.num20_6, 
   l_stgg009 LIKE type_t.num20_6, 
   l_debg020 LIKE type_t.num20_6, 
   l_rank LIKE type_t.chr500, 
   l_stea008 LIKE type_t.num15_3, 
   l_ping LIKE type_t.num20_6, 
   l_rank11 LIKE type_t.chr500, 
   l_ping_12 LIKE type_t.num20_6, 
   l_rank12 LIKE type_t.chr500, 
   l_debg017_2 LIKE type_t.num20_6, 
   l_stgg009_2 LIKE type_t.num20_6, 
   l_debg020_2 LIKE type_t.num20_6, 
   l_rank_2 LIKE type_t.chr500, 
   l_stea008_2 LIKE type_t.num15_3, 
   l_ping_2 LIKE type_t.num20_6, 
   l_rank21 LIKE type_t.chr500, 
   l_ping_22 LIKE type_t.num20_6, 
   l_rank_22 LIKE type_t.chr500, 
   l_debg017_3 LIKE type_t.num20_6, 
   l_stgg009_3 LIKE type_t.num20_6, 
   l_debg020_3 LIKE type_t.num20_6, 
   l_rank_3 LIKE type_t.chr500, 
   l_stea008_3 LIKE type_t.num15_3, 
   l_ping_3 LIKE type_t.num20_6, 
   l_rank31 LIKE type_t.chr500, 
   l_ping_32 LIKE type_t.num20_6, 
   l_rank32 LIKE type_t.chr500, 
   l_rate1 LIKE type_t.num20_6, 
   l_rate2 LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE ls_unlist_sql    STRING
DEFINE ls_now_sql       STRING
DEFINE last_period_sql  STRING
DEFINE last_year_sql    STRING
DEFINE ls_unlist_day    STRING 
DEFINE g_sql_del        STRING
DEFINE g_sql_ins        STRING
DEFINE merge_margin1    STRING
DEFINE merge_margin2    STRING
DEFINE merge_margin3    STRING
DEFINE merge_sql1       STRING
DEFINE merge_sql2       STRING
DEFINE merge_sql3       STRING
DEFINE merge_sql4       STRING
DEFINE merge_sql5       STRING
DEFINE merge_sql6       STRING
DEFINE merge_sql7       STRING
DEFINE merge_sql8       STRING
DEFINE merge_sql9       STRING 
DEFINE upd_sql1         STRING
DEFINE ls_sql_union     STRING 
DEFINE l_days           LIKE type_t.num5 #前后差异天数DEFINE 

#INPUT条件
DEFINE queryby          LIKE type_t.chr10
DEFINE bdate            DATE
DEFINE edate            DATE
DEFINE bdate1           DATE
DEFINE edate1           DATE
DEFINE bdate11          DATE
DEFINE edate11          DATE
DEFINE dateinput        DATE
DEFINE l_monday         DATE

#存旧值
DEFINE ldebgsite        STRING
DEFINE lrtaw001         STRING
DEFINE lstfa003         STRING
DEFINE ldebg005         STRING
DEFINE lstfa010         STRING

#第二页签 按专柜汇总 
DEFINE g_debg_d1 DYNAMIC ARRAY OF RECORD  #按库区汇总
   l_rtaw001    LIKE type_t.chr10, 
   l_rtaxl003   LIKE type_t.chr500, 
   l_un_day_1   LIKE type_t.num5, 
   l_debg017_11 LIKE type_t.num20_6, 
   l_stgg009_11 LIKE type_t.num20_6, 
   l_debg020_11 LIKE type_t.num20_6, 
   l_stea008_11 LIKE stea_t.stea008,
   l_ping_11    LIKE type_t.num20_6, 
   l_ping_111   LIKE type_t.num20_6, 
   l_debg017_21 LIKE type_t.num20_6,
   l_stgg009_21 LIKE type_t.num20_6,   
   l_debg020_21 LIKE type_t.num20_6, 
   l_stea008_21 LIKE stea_t.stea008,
   l_ping_21    LIKE type_t.num20_6, 
   l_ping_211   LIKE type_t.num20_6, 
   l_debg017_31 LIKE type_t.num20_6, 
   l_stgg009_31 LIKE type_t.num20_6, 
   l_debg020_31 LIKE type_t.num20_6,
   l_stea008_31 LIKE stea_t.stea008,
   l_ping_31    LIKE type_t.num20_6,
   l_ping_311   LIKE type_t.num20_6,   
   l_rate11     LIKE type_t.num20_6, 
   l_rate21     LIKE type_t.num20_6
       END RECORD
       
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_debg_d
DEFINE g_master_t                   type_g_debg_d
DEFINE g_debg_d          DYNAMIC ARRAY OF type_g_debg_d
DEFINE g_debg_d_t        type_g_debg_d
 
      
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
 
{<section id="astq522.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5
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
   DECLARE astq522_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE astq522_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astq522_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astq522 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astq522_init()   
 
      #進入選單 Menu (="N")
      CALL astq522_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_astq522
      
   END IF 
   
   CLOSE astq522_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL astq522_drop_tmp() RETURNING l_success
   CALL s_aooi500_drop_temp() RETURNING l_success   #161024-00025#11   2016/10/27  by 08742  add
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="astq522.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION astq522_init()
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
   CALL astq522_create_tmp() RETURNING l_success
   
   #combobox
   CALL cl_set_combo_scc_part('stfa003','6013','4,5')
   
   #清空
   LET lrtaw001 = ''
   LET lstfa003 = ''
   LET ldebg005 = ''
   LET lstfa010 = ''
   
   #赋初值
   LET dateinput = g_today 
   SELECT trunc(dateinput,'d') 
     INTO bdate 
     FROM dual  
   LET edate = bdate + 6
   LET l_days = edate - bdate + 1
   #上周期
   LET bdate11 = bdate - l_days
   LET edate11 = edate - l_days
   LET edate1 = s_date_get_date(edate,-12,0)
   LET bdate1 = s_date_get_date(bdate,-12,0)
   LET queryby = '1'
   DISPLAY BY NAME dateinput,edate,bdate,edate11,bdate11,edate1,bdate1,queryby

   #end add-point
 
   CALL astq522_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="astq522.default_search" >}
PRIVATE FUNCTION astq522_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " debg002 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " debg005 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " debg007 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " debg008 = '", g_argv[04], "' AND "
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
 
{<section id="astq522.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION astq522_ui_dialog()
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
      CALL astq522_b_fill()
   ELSE
      CALL astq522_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_debg_d.clear()
 
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
 
         CALL astq522_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_debg_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL astq522_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL astq522_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #160126-00002#3 s983961 --add(s)
         CONSTRUCT g_wc ON debgsite,rtaw001,stfa003,debg005,stfa010
                         FROM debgsite,rtaw001,stfa003,debg005,stfa010
                      
         BEFORE CONSTRUCT
        
         ON ACTION controlp INFIELD debgsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'debgsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO debgsite  #顯示到畫面上
            NEXT FIELD debgsite                     #返回原欄位
            
         ON ACTION controlp INFIELD rtaw001
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtax004 ='",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtaw001  #顯示到畫面上
            NEXT FIELD rtaw001                     #返回原欄位

         ON ACTION controlp INFIELD debg005
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa120()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO debg005  #顯示到畫面上
            NEXT FIELD debg005                     #返回原欄位
         
         ON ACTION controlp INFIELD stfa010
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"      #供应商类型
            CALL q_pmaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfa010  #顯示到畫面上
            NEXT FIELD stfa010                     #返回原欄位
         #旧值写入
         AFTER FIELD debgsite CALL FGL_DIALOG_GETBUFFER() RETURNING ldebgsite
         AFTER FIELD rtaw001 CALL FGL_DIALOG_GETBUFFER() RETURNING lrtaw001 
         AFTER FIELD stfa003 CALL FGL_DIALOG_GETBUFFER() RETURNING lstfa003
         AFTER FIELD debg005 CALL FGL_DIALOG_GETBUFFER() RETURNING ldebg005
         AFTER FIELD stfa010 CALL FGL_DIALOG_GETBUFFER() RETURNING lstfa010
         
         END CONSTRUCT
         
         INPUT dateinput,bdate,edate,bdate11,edate11,bdate1,edate1,queryby 
          FROM dateinput,bdate,edate,bdate11,edate11,bdate1,edate1,queryby
            ATTRIBUTE(WITHOUT DEFAULTS)
          
          AFTER FIELD queryby
             IF queryby = '1' THEN 
                SELECT trunc(dateinput,'d') 
                  INTO bdate 
                  FROM dual  
                LET edate = bdate + 6
                LET l_days = edate - bdate + 1
                #上周期
                LET bdate11 = bdate - l_days
                LET edate11 = edate - l_days
                LET edate1 = s_date_get_date(edate,-12,0)
                LET bdate1 = s_date_get_date(bdate,-12,0)
                DISPLAY BY NAME dateinput,edate,bdate,edate11,bdate11,edate1,bdate1
                SELECT trunc(dateinput, 'iw') 
                  INTO l_monday 
                  from dual 
             END IF 
             IF queryby = '2' THEN 
                SELECT last_day(dateinput) INTO edate FROM dual 
                SELECT trunc(dateinput, 'mm') INTO bdate FROM dual 
                LET l_days = edate - bdate + 1
                #上周期
                LET bdate11 = bdate - l_days
                LET edate11 = edate - l_days
                LET edate1 = s_date_get_date(edate,-12,0)
                LET bdate1 = s_date_get_date(bdate,-12,0)
                DISPLAY BY NAME dateinput,edate,bdate,edate11,bdate11,edate1,bdate1
             END IF 
          
          
          AFTER FIELD dateinput 
             IF queryby = '1' THEN 
                SELECT trunc(dateinput,'d') 
                  INTO bdate 
                  FROM dual  
                LET edate = bdate + 6
                LET l_days = edate - bdate + 1
                #上周期
                LET bdate11 = bdate - l_days
                LET edate11 = edate - l_days
                LET edate1 = s_date_get_date(edate,-12,0)
                LET bdate1 = s_date_get_date(bdate,-12,0)
                SELECT trunc(dateinput, 'iw') 
                  INTO l_monday 
                  from dual 
                DISPLAY BY NAME dateinput,edate,bdate,edate11,bdate11,edate1,bdate1
             END IF 
             IF queryby = '2' THEN 
                SELECT last_day(dateinput) INTO edate FROM dual 
                SELECT trunc(dateinput, 'mm') INTO bdate FROM dual 
                LET l_days = edate - bdate + 1
                #上周期
                LET bdate11 = bdate - l_days
                LET edate11 = edate - l_days
                LET edate1 = s_date_get_date(edate,-12,0)
                LET bdate1 = s_date_get_date(bdate,-12,0)
                DISPLAY BY NAME dateinput,edate,bdate,edate11,bdate11,edate1,bdate1
             END IF 
             
             
#          AFTER FIELD bdate
#             IF NOT cl_null(bdate) THEN
#                IF bdate > edate THEN
#                   INITIALIZE g_errparam TO NULL 
#                   LET g_errparam.extend = "" 
#                   LET g_errparam.code   = 'amr-00072' # 起始时间不可大于截止时间
#                   LET g_errparam.popup  = TRUE 
#                   CALL cl_err()
#                   NEXT FIELD bdate
#                END IF
#             END IF
          AFTER FIELD edate
             IF NOT cl_null(edate) THEN
                IF edate < bdate THEN
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = "" 
                   LET g_errparam.code   = 'amm-00094' # 结束时间必须大于等于开始时间
                   LET g_errparam.popup  = TRUE 
                   CALL cl_err()
                   NEXT FIELD edate
                   END IF
             END IF
#           AFTER FIELD bdate1
#             IF NOT cl_null(bdate1) THEN
#                IF bdate1 > edate1 THEN
#                   INITIALIZE g_errparam TO NULL 
#                   LET g_errparam.extend = "" 
#                   LET g_errparam.code   = 'amr-00072' # 起始时间不可大于截止时间
#                   LET g_errparam.popup  = TRUE 
#                   CALL cl_err()
#                   NEXT FIELD bdate1
#                END IF
#             END IF
          AFTER FIELD edate1
             IF NOT cl_null(edate1) THEN
                IF edate1 < bdate1 THEN
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = "" 
                   LET g_errparam.code   = 'amm-00094' # 结束时间必须大于等于开始时间
                   LET g_errparam.popup  = TRUE 
                   CALL cl_err()
                   NEXT FIELD edate1
                END IF
            END IF
            
            AFTER INPUT
               IF INT_FLAG THEN
#               	LET INT_FLAG=0
#                  EXIT INPUT
                  RETURN
               END IF
         END INPUT       
         #160126-00002#3 s983961 --add(e)
         
         #DISPLAY第二页签
         DISPLAY ARRAY g_debg_d1 TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_debg_d1.getLength() TO FORMONLY.h_count
               CALL astq522_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row

               #end add-point  
 
            #自訂ACTION(detail_show,page_2)
            
            #add-point:page2自定義行為

            #end add-point
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL astq522_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            #160126-00002#3 160203 By s983961 add(S)
            CALL cl_set_act_visible("insert,query", FALSE)
            CALL cl_set_act_visible("selall,selnone,sel,unsel,filter", FALSE)
            CALL cl_set_comp_visible("sel", FALSE)
            
             DISPLAY ldebgsite,
                 lrtaw001,
                 lstfa003,
                 ldebg005,
                 lstfa010
              TO debgsite,
                 rtaw001, 
                 stfa003,
                 debg005,
                 stfa010
                     
            AFTER DIALOG     
            LET l_days = edate - bdate + 1         
            #160126-00002#3 160203 By s983961 add(E)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL astq522_insert()
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
               CALL astq522_query()
               #add-point:ON ACTION query name="menu.query"
               #CALL astq522_query2()  #160126-00002#3 s983961--mark
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
            CALL astq522_filter()
            #add-point:ON ACTION filter name="menu.filter"
            CALL cl_set_comp_visible("sel", FALSE)   #160126-00002#3 160203 By s983961
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
            CALL astq522_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_debg_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_debg_d1)
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
            CALL astq522_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL astq522_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL astq522_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL astq522_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         #160126-00002#3 160203 By s983961(s)
         ON ACTION ACCEPT
            
            IF cl_null(dateinput) THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'acr-00015'
              LET g_errparam.extend = ''
              LET g_errparam.popup = FALSE
              CALL cl_err()
              NEXT FIELD dateinput
            END IF         
         
            #LET g_wc = g_wc_table        
            
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL astq522_b_fill()
            IF g_debg_d.getLength() > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            END IF
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
         #160126-00002#3 160203 By s983961(e)          
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
 
{<section id="astq522.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION astq522_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   #不走本段query，自定单头QBE
   RETURN 
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_debg_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON debg007,rtaxl003,debg005,stfal003
           FROM s_detail1[1].b_debg007,s_detail1[1].b_rtaxl003,s_detail1[1].b_debg005,s_detail1[1].b_stfal003 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_debg007>>----
         #Ctrlp:construct.c.page1.b_debg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debg007
            #add-point:ON ACTION controlp INFIELD b_debg007 name="construct.c.page1.b_debg007"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debg007
            #add-point:BEFORE FIELD b_debg007 name="construct.b.page1.b_debg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debg007
            
            #add-point:AFTER FIELD b_debg007 name="construct.a.page1.b_debg007"
            
            #END add-point
            
 
 
         #----<<b_rtaxl003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtaxl003
            #add-point:BEFORE FIELD b_rtaxl003 name="construct.b.page1.b_rtaxl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtaxl003
            
            #add-point:AFTER FIELD b_rtaxl003 name="construct.a.page1.b_rtaxl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtaxl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtaxl003
            #add-point:ON ACTION controlp INFIELD b_rtaxl003 name="construct.c.page1.b_rtaxl003"
            
            #END add-point
 
 
         #----<<b_debg005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debg005
            #add-point:BEFORE FIELD b_debg005 name="construct.b.page1.b_debg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debg005
            
            #add-point:AFTER FIELD b_debg005 name="construct.a.page1.b_debg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debg005
            #add-point:ON ACTION controlp INFIELD b_debg005 name="construct.c.page1.b_debg005"
            
            #END add-point
 
 
         #----<<b_stfal003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stfal003
            #add-point:BEFORE FIELD b_stfal003 name="construct.b.page1.b_stfal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stfal003
            
            #add-point:AFTER FIELD b_stfal003 name="construct.a.page1.b_stfal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stfal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stfal003
            #add-point:ON ACTION controlp INFIELD b_stfal003 name="construct.c.page1.b_stfal003"
            
            #END add-point
 
 
         #----<<l_un_day>>----
         #----<<l_debg017>>----
         #----<<l_stgg009>>----
         #----<<l_debg020>>----
         #----<<l_rank>>----
         #----<<l_stea008>>----
         #----<<l_ping>>----
         #----<<l_rank11>>----
         #----<<l_ping_12>>----
         #----<<l_rank12>>----
         #----<<l_debg017_2>>----
         #----<<l_stgg009_2>>----
         #----<<l_debg020_2>>----
         #----<<l_rank_2>>----
         #----<<l_stea008_2>>----
         #----<<l_ping_2>>----
         #----<<l_rank21>>----
         #----<<l_ping_22>>----
         #----<<l_rank_22>>----
         #----<<l_debg017_3>>----
         #----<<l_stgg009_3>>----
         #----<<l_debg020_3>>----
         #----<<l_rank_3>>----
         #----<<l_stea008_3>>----
         #----<<l_ping_3>>----
         #----<<l_rank31>>----
         #----<<l_ping_32>>----
         #----<<l_rank32>>----
         #----<<l_rate1>>----
         #----<<l_rate2>>----
   
       
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
   CALL astq522_b_fill()
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
 
{<section id="astq522.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astq522_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where       STRING
   DEFINE l_success     LIKE type_t.num5
   DEFINE i             LIKE type_t.num5 #用作g_unlist_week数组
#   DEFINE l_days        LIKE type_t.num5 #前后差异天数
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
#   LET l_days = edate - bdate + 1
   CALL s_aooi500_sql_where(g_prog,'debgsite') RETURNING l_where
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
 
   LET ls_sql_rank = "SELECT  UNIQUE debg007,'',debg005,'','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY debg_t.debg002, 
       debg_t.debg005,debg_t.debg007,debg_t.debg008) AS RANK FROM debg_t",
 
 
                     "",
                     " WHERE debgent= ? AND debgsite= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("debg_t"),
                     " ORDER BY debg_t.debg002,debg_t.debg005,debg_t.debg007,debg_t.debg008"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
    #未开单专柜，未开单天数 经营方式限制为4或5
     LET ls_unlist_sql = " SELECT debgent,debgsite,debg005 C,rtaw001 A,'",l_days,"'-COUNT(A) days ",
                         "   FROM (      SELECT DISTINCT debgent,debgsite,debg002,debg005,rtaw001,SUM(DECODE(debg002, NULL, 0, 1)) A ",
                         "                 FROM debg_t ",
                         "            LEFT JOIN stfa_t ON debgent = stfaent AND debg005 = stfa005 ",
                         "            LEFT JOIN rtaw_t ON rtawent = debgent AND rtaw002 = debg007 AND rtaw003 = '",cl_get_para(g_enterprise,"","E-CIR-0001"),"' ",
                         "                WHERE debg002 BETWEEN TO_date('",bdate,"','yy/mm/dd') 
                                                            AND TO_date('",edate,"','yy/mm/dd') ",
                         "                  AND debgent = ?  AND stfa003 IN ('4','5') AND ",ls_wc,
                         "             GROUP BY debgent,debgsite,debg002,debg005,rtaw001 ",
                         "        ) ",
                         "  GROUP BY debgent,debgsite,debg005,rtaw001 "                

   #本周期数据（销售额，客单数，销售排名，面积(能抓到执行日期)  ）  经营方式限制为4或5
    LET ls_now_sql = "  SELECT A1,B1,C1,D1,E1,F1,G1,l_rank1 FROM ( ",
                     "      SELECT rtaw001 A1,rtaxl003 B1,debg005 C1,mhael023 D1,SUM(debg017) E1,SUM(debg020) F1,",
                     "             stea008 G1,",
                     "             DENSE_RANK() OVER(PARTITION BY rtaw001 ORDER BY SUM(debg017) DESC) l_rank1, ",
                     "             RANK() OVER(partition BY debg005 ORDER BY stea002 desc) MM ",
                     "       FROM debg_t ",
                     #"  LEFT JOIN stgg_t ON debgent = stggent and debgsite = stggsite and debg005 = stgg003 AND stgg001 = debg002 AND stgg001 between to_date('",bdate,"','yy/mm/dd') and to_date('",edate,"','yy/mm/dd') ",
                     "  LEFT JOIN stfa_t ON debgent = stfaent AND debg005 = stfa005 ",
                     "  LEFT JOIN stea_t ON steaent = debgent AND stea005 = debg005 AND stea054 <= to_date('",edate,"','yy/mm/dd') AND stea004 IN ('2','3','4','5','6','7')",
                     "  LEFT JOIN mhael_t ON mhaelent = debgent AND mhael001 = debg005 AND mhael022 = '",g_dlang,"' ",  
                     "  LEFT JOIN rtaw_t ON rtawent = debgent AND rtaw002 = debg007 AND rtaw003 = '",cl_get_para(g_enterprise,"","E-CIR-0001"),"' ",
                     "  LEFT JOIN rtaxl_t ON rtaxlent = debgent AND rtaxl001 = rtaw001 AND rtaxl002 = '",g_dlang,"' ",
                     "      WHERE debg002 BETWEEN TO_date('",bdate,"','yy/mm/dd') 
                                              AND TO_date('",edate,"','yy/mm/dd')",
                     "        AND debgent = '",g_enterprise,"' AND stfa003 IN ('4','5') AND ",ls_wc,
                     "   GROUP BY rtaw001,rtaxl003,debg005,mhael023,stea008,stea002 ",
                     "   ) WHERE MM = 1"                                      
                                        
                     
   #上周期数据（销售额，客单数，销售排名，面积(能抓到执行日期)  ）  经营方式限制为4或5
    LET last_period_sql = " SELECT A2,C2,E2,F2,G2,l_rank2 FROM ( ",
                          "    SELECT rtaw001 A2,debg005 C2,SUM(debg017) E2,SUM(debg020) F2,",
                          "           stea008 G2,",
                          "           DENSE_RANK() OVER(PARTITION BY rtaw001 ORDER BY SUM(debg017) DESC) l_rank2, ",
                          "           RANK() OVER(partition BY debg005 ORDER BY stea002 desc) MM ",
                          "      FROM debg_t ",
                          #" LEFT JOIN stgg_t ON debgent = stggent and debgsite = stggsite and debg005 = stgg003 AND stgg001 = debg002 AND stgg001 between to_date('",bdate,"','yy/mm/dd') and to_date('",edate,"','yy/mm/dd') ",
                          " LEFT JOIN stfa_t ON debgent = stfaent AND debg005 = stfa005 ",
                          " LEFT JOIN stea_t ON steaent = debgent AND stea005 = debg005 AND stea054 <= to_date('",edate11,"','yy/mm/dd') AND stea004 IN ('2','3','4','5','6','7')",
                          " LEFT JOIN rtaw_t ON rtawent = debgent AND rtaw002 = debg007 AND rtaw003 = '",cl_get_para(g_enterprise,"","E-CIR-0001"),"' ",
                          "     WHERE debg002 BETWEEN TO_date('",bdate11,"','yy/mm/dd') 
                                                  AND TO_date('",edate11,"','yy/mm/dd')",
                          "       AND debgent = '",g_enterprise,"'  AND stfa003 IN ('4','5') AND ",ls_wc,
                          "  GROUP BY rtaw001,debg005,stea008,stea002 ",
                          "   ) WHERE MM = 1" 

                          
   #对比周期数据（销售额，客单数，销售排名，面积(能抓到执行日期)  ）  经营方式限制为4或5
    LET last_year_sql = " SELECT A3,C3,E3,F3,G3,l_rank3 FROM ( ",
                        "    SELECT rtaw001 A3,debg005 C3,SUM(debg017) E3,SUM(debg020) F3,",
                        "           stea008 G3,",   
                        "           DENSE_RANK() OVER(PARTITION BY rtaw001 ORDER BY SUM(debg017) DESC) l_rank3, ",
                        "           RANK() OVER(partition BY debg005 ORDER BY stea002 desc) MM ",
                        "      FROM debg_t ", 
                        #" LEFT JOIN stgg_t ON debgent = stggent and debgsite = stggsite and debg005 = stgg003 AND stgg001 = debg002 AND stgg001 between to_date('",bdate,"','yy/mm/dd') and to_date('",edate,"','yy/mm/dd') ",
                        " LEFT JOIN stfa_t ON debgent = stfaent AND debg005 = stfa005 ",
                        " LEFT JOIN stea_t ON steaent = debgent AND stea005 = debg005 AND stea054 <= to_date('",edate1,"','yy/mm/dd') AND stea004 IN ('2','3','4','5','6','7')",
                        " LEFT JOIN rtaw_t ON rtawent = debgent AND rtaw002 = debg007 AND rtaw003 = '",cl_get_para(g_enterprise,"","E-CIR-0001"),"' ",
                        "     WHERE debg002 BETWEEN TO_date('",bdate1,"','yy/mm/dd') 
                                                AND TO_date('",edate1,"','yy/mm/dd')",
                        "       AND debgent = '",g_enterprise,"'  AND stfa003 IN ('4','5') AND ",ls_wc,
                        "  GROUP BY rtaw001,debg005,stea008,stea002 ",
                        "   ) WHERE MM = 1" 
                        
                                           
   #联合sql，用作插表                                    
    LET ls_sql_union = "    SELECT '",g_enterprise,"','",g_site,"',",
                       "           A,B1,C,D1,days,",
                       "           E1,'',F1,l_rank1,G1,'','','','',", #本周期
                       "           E2,'',F2,l_rank2,G2,'','','','',", #上周期
                       "           E3,'',F3,l_rank3,G3,'','','','',", #对比周期
                       "           E1/E2,E1/E3",
                       "      FROM (",ls_unlist_sql,") ",
                       " LEFT JOIN (",ls_now_sql,") ON A = A1 AND C = C1 ",
                       " LEFT JOIN (",last_period_sql,") ON A = A2 AND C = C2 ",
                       " LEFT JOIN (",last_year_sql,") ON A = A3 AND C = C3 "
   #清空临时表
    LET g_sql_del = "DELETE FROM astq522_tmp "
    EXECUTE IMMEDIATE g_sql_del
   
   #数据插入临时表
    LET g_sql_ins = " INSERT INTO astq522_tmp 
                      (   enterprise,site,rtaw001,rtaxl003,debg005,stfal003,l_un_day,   
                          l_debg017,      l_stgg009,     l_debg020,     l_rank1,    l_stea008,     l_ping11,   l_rank11,   l_ping12,   l_rank12,
                          l_debg017_2,    l_stgg009_2,   l_debg020_2,   l_rank2,    l_stea008_2,   l_ping21,   l_rank21,   l_ping22,   l_rank22,   
                          l_debg017_3,    l_stgg009_3,   l_debg020_3,   l_rank3,    l_stea008_3,   l_ping31,   l_rank31,   l_ping32,   l_rank32,   
                          l_rate1,l_rate2  
                      )",ls_sql_union         
    PREPARE ins_tmp FROM g_sql_ins
    EXECUTE ins_tmp USING g_enterprise

    #更新临时表 本期毛利额
    LET merge_margin1 = " MERGE INTO astq522_tmp O",
                        " USING ( SELECT stgg003,SUM(stgg009) A ",
                        "           FROM stgg_t ",
                        "          WHERE stgg001 BETWEEN TO_date('",bdate,"','yy/mm/dd') 
                                                     AND TO_date('",edate,"','yy/mm/dd')",
                        "            AND stggent = '",g_enterprise,"' ",
                        "       GROUP BY stgg003  ) U ",
                        "   ON (O.debg005 = U.stgg003 ) ",
                        " WHEN MATCHED THEN ",
                        "      UPDATE SET O.l_stgg009 = U.A "
    PREPARE upd_margin1 FROM merge_margin1
    EXECUTE upd_margin1

    #更新临时表 上周期毛利额
    LET merge_margin2 = " MERGE INTO astq522_tmp O",
                        " USING ( SELECT stgg003,SUM(stgg009) A ",
                        "           FROM stgg_t ",
                        "          WHERE stgg001 BETWEEN TO_date('",bdate11,"','yy/mm/dd') 
                                                     AND TO_date('",edate11,"','yy/mm/dd')",
                        "            AND stggent = '",g_enterprise,"' ",
                        "       GROUP BY stgg003  ) U ",
                        "   ON (O.debg005 = U.stgg003 ) ",
                        " WHEN MATCHED THEN ",
                        "      UPDATE SET O.l_stgg009_2 = U.A "
    PREPARE upd_margin2 FROM merge_margin2
    EXECUTE upd_margin2

    #更新临时表 对比周期毛利额
    LET merge_margin3 = " MERGE INTO astq522_tmp O",
                        " USING ( SELECT stgg003,SUM(stgg009) A ",
                        "           FROM stgg_t ",
                        "          WHERE stgg001 BETWEEN TO_date('",bdate1,"','yy/mm/dd') 
                                                     AND TO_date('",edate1,"','yy/mm/dd')",
                        "            AND stggent = '",g_enterprise,"' ",
                        "       GROUP BY stgg003  ) U ",
                        "   ON (O.debg005 = U.stgg003 ) ",
                        " WHEN MATCHED THEN ",
                        "      UPDATE SET O.l_stgg009_3 = U.A "
    PREPARE upd_margin3 FROM merge_margin3
    EXECUTE upd_margin3

       #更新临时表 #本周期面积 (不能抓到执行日期)
    LET merge_sql1 = " MERGE INTO (SELECT * FROM astq522_tmp WHERE l_stea008 IS NULL) O",
                     " USING (  SELECT stea005,stea008,MAX(stea002) FROM stea_t 
                       WHERE steaent = '",g_enterprise,"' AND stea004 IN ('2','3','4','5','6','7') AND stea054 IS NULL
                       GROUP BY stea005,stea008 ) U ",
                     "   ON (O.debg005 = U.stea005 ) ",
                     " WHEN MATCHED THEN ",
                     "      UPDATE SET O.l_stea008 = U.stea008 "
    PREPARE upd_tmp1 FROM merge_sql1
    EXECUTE upd_tmp1
   
   #更新临时表 #上周期面积 (不能抓到执行日期)
    LET merge_sql2 = " MERGE INTO (SELECT * FROM astq522_tmp WHERE l_stea008_2 IS NULL) O",
                     " USING (  SELECT stea005,stea008,MAX(stea002) FROM stea_t 
                       WHERE steaent = '",g_enterprise,"' AND stea004 IN ('2','3','4','5','6','7') AND stea054 IS NULL
                       GROUP BY stea005,stea008) U ",
                     "   ON (O.debg005 = U.stea005 ) ",
                     " WHEN MATCHED THEN ",
                     "      UPDATE SET O.l_stea008_2 = U.stea008 "
    PREPARE upd_tmp2 FROM merge_sql2
    EXECUTE upd_tmp2
                     
   #更新临时表 #对比周期面积 (不能抓到执行日期)
    LET merge_sql3 = " MERGE INTO (SELECT * FROM astq522_tmp WHERE l_stea008_3 IS NULL) O",
                     " USING (  SELECT stea005,stea008,MAX(stea002) FROM stea_t 
                       WHERE steaent = '",g_enterprise,"' AND stea004 IN ('2','3','4','5','6','7') AND stea054 IS NULL
                       GROUP BY stea005,stea008) U ",
                     "   ON (O.debg005 = U.stea005 ) ",
                     " WHEN MATCHED THEN ",
                     "      UPDATE SET O.l_stea008_3 = U.stea008 "
    PREPARE upd_tmp3 FROM merge_sql3
    EXECUTE upd_tmp3
   #更新临时表 本周期、上周期、对比周期 的 【销售坪效】【毛利坪效】
     LET upd_sql1 = " UPDATE astq522_tmp ",
                    "    SET l_ping11 = DECODE(l_stea008,0,l_debg017,l_debg017/l_stea008), ",
                    "        l_ping21 = DECODE(l_stea008_2,0,l_debg017_2,l_debg017_2/l_stea008_2), ",
                    "        l_ping31 = DECODE(l_stea008_3,0,l_debg017_3,l_debg017_3/l_stea008_3), ",
                    "        l_ping12 = DECODE(l_stea008,0,l_stgg009,l_stgg009/l_stea008), ",
                    "        l_ping22 = DECODE(l_stea008_2,0,l_stgg009_2,l_stgg009_2/l_stea008_2), ",
                    "        l_ping32 = DECODE(l_stea008_3,0,l_stgg009_3,l_stgg009_3/l_stea008_3) "
     PREPARE upd_tmp4 FROM upd_sql1
     EXECUTE upd_tmp4
   
   #更新临时表 本周期、上周期、对比周期 的 【销售坪效排名】【毛利坪效排名】
     LET merge_sql4 = " MERGE INTO astq522_tmp O",
                      " USING ( SELECT rtaw001,debg005,l_ping11,
                                       DENSE_RANK() OVER(PARTITION BY rtaw001 ORDER BY L_PING11 DESC) AS l_rank11
                                  FROM astq522_tmp ) U ",
                      "   ON (O.rtaw001= U.rtaw001 AND O.debg005 = U.debg005 ) ",
                      " WHEN MATCHED THEN ",
                      "      UPDATE SET O.l_rank11 = U.l_rank11 "
     PREPARE upd_tmp5 FROM merge_sql4
     EXECUTE upd_tmp5
     
     LET merge_sql5 = " MERGE INTO astq522_tmp O",
                      " USING ( SELECT rtaw001,debg005,l_ping21,
                                       DENSE_RANK() OVER(PARTITION BY rtaw001 ORDER BY L_PING21 DESC) AS l_rank21
                                  FROM astq522_tmp ) U ",
                      "   ON (O.rtaw001= U.rtaw001 AND O.debg005 = U.debg005 ) ",
                      " WHEN MATCHED THEN ",
                      "      UPDATE SET O.l_rank21 = U.l_rank21 "
     PREPARE upd_tmp6 FROM merge_sql5
     EXECUTE upd_tmp6
     
     LET merge_sql6 = " MERGE INTO astq522_tmp O",
                      " USING ( SELECT rtaw001,debg005,l_ping31,
                                       DENSE_RANK() OVER(PARTITION BY rtaw001 ORDER BY L_PING31 DESC) AS l_rank31
                                  FROM astq522_tmp ) U ",
                      "   ON (O.rtaw001= U.rtaw001 AND O.debg005 = U.debg005 ) ",
                      " WHEN MATCHED THEN ",
                      "      UPDATE SET O.l_rank31 = U.l_rank31 "
     PREPARE upd_tmp7 FROM merge_sql6
     EXECUTE upd_tmp7

     LET merge_sql7 = " MERGE INTO astq522_tmp O",
                      " USING ( SELECT rtaw001,debg005,l_ping12,
                                       DENSE_RANK() OVER(PARTITION BY rtaw001 ORDER BY L_PING12 DESC) AS l_rank12
                                  FROM astq522_tmp ) U ",
                      "   ON (O.rtaw001= U.rtaw001 AND O.debg005 = U.debg005 ) ",
                      " WHEN MATCHED THEN ",
                      "      UPDATE SET O.l_rank12 = U.l_rank12 "
     PREPARE upd_tmp8 FROM merge_sql7
     EXECUTE upd_tmp8
     
     LET merge_sql8 = " MERGE INTO astq522_tmp O",
                      " USING ( SELECT rtaw001,debg005,l_ping22,
                                       DENSE_RANK() OVER(PARTITION BY rtaw001 ORDER BY L_PING22 DESC) AS l_rank22
                                  FROM astq522_tmp ) U ",
                      "   ON (O.rtaw001= U.rtaw001 AND O.debg005 = U.debg005 ) ",
                      " WHEN MATCHED THEN ",
                      "      UPDATE SET O.l_rank22 = U.l_rank22 "
     PREPARE upd_tmp9 FROM merge_sql8
     EXECUTE upd_tmp9

     LET merge_sql9 = " MERGE INTO astq522_tmp O",
                      " USING ( SELECT rtaw001,debg005,l_ping32,
                                       DENSE_RANK() OVER(PARTITION BY rtaw001 ORDER BY L_PING32 DESC) AS l_rank32
                                  FROM astq522_tmp ) U ",
                      "   ON (O.rtaw001= U.rtaw001 AND O.debg005 = U.debg005 ) ",
                      " WHEN MATCHED THEN ",
                      "      UPDATE SET O.l_rank32 = U.l_rank32 "
     PREPARE upd_tmp10 FROM merge_sql9
     EXECUTE upd_tmp10
   
   #从临时表取数，填充g_debg_d
    LET ls_sql_rank = " SELECT 
                          rtaw001,        rtaxl003,      debg005,       stfal003,   l_un_day,   
                          l_debg017,      l_stgg009,     l_debg020,     l_rank1,    l_stea008,     l_ping11,   l_rank11,   l_ping12,   l_rank12,
                          l_debg017_2,    l_stgg009_2,   l_debg020_2,   l_rank2,    l_stea008_2,   l_ping21,   l_rank21,   l_ping22,   l_rank22,   
                          l_debg017_3,    l_stgg009_3,   l_debg020_3,   l_rank3,    l_stea008_3,   l_ping31,   l_rank31,   l_ping32,   l_rank32,   
                          l_rate1,l_rate2  ",
                      "   FROM astq522_tmp ",
                      "  WHERE enterprise = ? AND site = ? "
                      
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
 
   LET g_sql = "SELECT debg007,'',debg005,'','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = ls_sql_rank
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE astq522_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR astq522_pb
   
   OPEN b_fill_curs USING g_enterprise, g_site
 
   CALL g_debg_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_debg_d[l_ac].debg007,g_debg_d[l_ac].rtaxl003,g_debg_d[l_ac].debg005,g_debg_d[l_ac].stfal003, 
       g_debg_d[l_ac].l_un_day,g_debg_d[l_ac].l_debg017,g_debg_d[l_ac].l_stgg009,g_debg_d[l_ac].l_debg020, 
       g_debg_d[l_ac].l_rank,g_debg_d[l_ac].l_stea008,g_debg_d[l_ac].l_ping,g_debg_d[l_ac].l_rank11, 
       g_debg_d[l_ac].l_ping_12,g_debg_d[l_ac].l_rank12,g_debg_d[l_ac].l_debg017_2,g_debg_d[l_ac].l_stgg009_2, 
       g_debg_d[l_ac].l_debg020_2,g_debg_d[l_ac].l_rank_2,g_debg_d[l_ac].l_stea008_2,g_debg_d[l_ac].l_ping_2, 
       g_debg_d[l_ac].l_rank21,g_debg_d[l_ac].l_ping_22,g_debg_d[l_ac].l_rank_22,g_debg_d[l_ac].l_debg017_3, 
       g_debg_d[l_ac].l_stgg009_3,g_debg_d[l_ac].l_debg020_3,g_debg_d[l_ac].l_rank_3,g_debg_d[l_ac].l_stea008_3, 
       g_debg_d[l_ac].l_ping_3,g_debg_d[l_ac].l_rank31,g_debg_d[l_ac].l_ping_32,g_debg_d[l_ac].l_rank32, 
       g_debg_d[l_ac].l_rate1,g_debg_d[l_ac].l_rate2
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_debg_d[l_ac].statepic = cl_get_actipic(g_debg_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
   
      #end add-point
 
      CALL astq522_detail_show("'1'")      
 
      CALL astq522_debg_t_mask()
 
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
   
 
   
   CALL g_debg_d.deleteElement(g_debg_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   CALL astq522_b_fill1()
   #end add-point
 
   LET g_detail_cnt = g_debg_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE astq522_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL astq522_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL astq522_detail_action_trans()
 
   IF g_debg_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL astq522_fetch()
   END IF
   
      CALL astq522_filter_show('debg007','b_debg007')
   CALL astq522_filter_show('rtaxl003','b_rtaxl003')
   CALL astq522_filter_show('debg005','b_debg005')
   CALL astq522_filter_show('stfal003','b_stfal003')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astq522.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astq522_fetch()
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
 
{<section id="astq522.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION astq522_detail_show(ps_page)
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
 
{<section id="astq522.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION astq522_filter()
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
      CONSTRUCT g_wc_filter ON debg007,rtaxl003,debg005,stfal003
                          FROM s_detail1[1].b_debg007,s_detail1[1].b_rtaxl003,s_detail1[1].b_debg005, 
                              s_detail1[1].b_stfal003
 
         BEFORE CONSTRUCT
                     DISPLAY astq522_filter_parser('debg007') TO s_detail1[1].b_debg007
            DISPLAY astq522_filter_parser('rtaxl003') TO s_detail1[1].b_rtaxl003
            DISPLAY astq522_filter_parser('debg005') TO s_detail1[1].b_debg005
            DISPLAY astq522_filter_parser('stfal003') TO s_detail1[1].b_stfal003
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_debg007>>----
         #Ctrlp:construct.c.page1.b_debg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debg007
            #add-point:ON ACTION controlp INFIELD b_debg007 name="construct.c.filter.page1.b_debg007"
 
            #END add-point
 
 
         #----<<b_rtaxl003>>----
         #Ctrlp:construct.c.filter.page1.b_rtaxl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtaxl003
            #add-point:ON ACTION controlp INFIELD b_rtaxl003 name="construct.c.filter.page1.b_rtaxl003"
            
            #END add-point
 
 
         #----<<b_debg005>>----
         #Ctrlp:construct.c.filter.page1.b_debg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debg005
            #add-point:ON ACTION controlp INFIELD b_debg005 name="construct.c.filter.page1.b_debg005"
            
            #END add-point
 
 
         #----<<b_stfal003>>----
         #Ctrlp:construct.c.filter.page1.b_stfal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stfal003
            #add-point:ON ACTION controlp INFIELD b_stfal003 name="construct.c.filter.page1.b_stfal003"
            
            #END add-point
 
 
         #----<<l_un_day>>----
         #----<<l_debg017>>----
         #----<<l_stgg009>>----
         #----<<l_debg020>>----
         #----<<l_rank>>----
         #----<<l_stea008>>----
         #----<<l_ping>>----
         #----<<l_rank11>>----
         #----<<l_ping_12>>----
         #----<<l_rank12>>----
         #----<<l_debg017_2>>----
         #----<<l_stgg009_2>>----
         #----<<l_debg020_2>>----
         #----<<l_rank_2>>----
         #----<<l_stea008_2>>----
         #----<<l_ping_2>>----
         #----<<l_rank21>>----
         #----<<l_ping_22>>----
         #----<<l_rank_22>>----
         #----<<l_debg017_3>>----
         #----<<l_stgg009_3>>----
         #----<<l_debg020_3>>----
         #----<<l_rank_3>>----
         #----<<l_stea008_3>>----
         #----<<l_ping_3>>----
         #----<<l_rank31>>----
         #----<<l_ping_32>>----
         #----<<l_rank32>>----
         #----<<l_rate1>>----
         #----<<l_rate2>>----
   
 
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
   
      CALL astq522_filter_show('debg007','b_debg007')
   CALL astq522_filter_show('rtaxl003','b_rtaxl003')
   CALL astq522_filter_show('debg005','b_debg005')
   CALL astq522_filter_show('stfal003','b_stfal003')
 
    
   CALL astq522_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="astq522.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION astq522_filter_parser(ps_field)
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
 
{<section id="astq522.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION astq522_filter_show(ps_field,ps_object)
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
   LET ls_condition = astq522_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="astq522.insert" >}
#+ insert
PRIVATE FUNCTION astq522_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="astq522.modify" >}
#+ modify
PRIVATE FUNCTION astq522_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astq522.reproduce" >}
#+ reproduce
PRIVATE FUNCTION astq522_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astq522.delete" >}
#+ delete
PRIVATE FUNCTION astq522_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astq522.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION astq522_detail_action_trans()
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
 
{<section id="astq522.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION astq522_detail_index_setting()
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
            IF g_debg_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_debg_d.getLength() AND g_debg_d.getLength() > 0
            LET g_detail_idx = g_debg_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_debg_d.getLength() THEN
               LET g_detail_idx = g_debg_d.getLength()
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
 
{<section id="astq522.mask_functions" >}
 &include "erp/ast/astq522_mask.4gl"
 
{</section>}
 
{<section id="astq522.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 录入查询条件
# Date & Author..: 2015-09-09 BY LanJJ
# Modify.........:
################################################################################
PRIVATE FUNCTION astq522_query2()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準

   #end add-point 
   #add-point:query段define-客製

   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_debg_d.clear()
   
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
      CONSTRUCT g_wc_table ON debgsite,rtaw001,stfa003,debg005,stfa010
                         FROM debgsite,rtaw001,stfa003,debg005,stfa010
                      
         BEFORE CONSTRUCT
        
         ON ACTION controlp INFIELD debgsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'debgsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO debgsite  #顯示到畫面上
            NEXT FIELD debgsite                     #返回原欄位
            
         ON ACTION controlp INFIELD rtaw001
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtax004 ='",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtaw001  #顯示到畫面上
            NEXT FIELD rtaw001                     #返回原欄位

         ON ACTION controlp INFIELD debg005
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa120()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO debg005  #顯示到畫面上
            NEXT FIELD debg005                     #返回原欄位
         
         ON ACTION controlp INFIELD stfa010
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"      #供应商类型
            CALL q_pmaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfa010  #顯示到畫面上
            NEXT FIELD stfa010                     #返回原欄位
         #旧值写入
         AFTER FIELD debgsite CALL FGL_DIALOG_GETBUFFER() RETURNING ldebgsite
         AFTER FIELD rtaw001 CALL FGL_DIALOG_GETBUFFER() RETURNING lrtaw001 
         AFTER FIELD stfa003 CALL FGL_DIALOG_GETBUFFER() RETURNING lstfa003
         AFTER FIELD debg005 CALL FGL_DIALOG_GETBUFFER() RETURNING ldebg005
         AFTER FIELD stfa010 CALL FGL_DIALOG_GETBUFFER() RETURNING lstfa010
         
      END CONSTRUCT

      INPUT dateinput,bdate,edate,bdate11,edate11,bdate1,edate1,queryby 
       FROM dateinput,bdate,edate,bdate11,edate11,bdate1,edate1,queryby
         ATTRIBUTE(WITHOUT DEFAULTS)
       
       AFTER FIELD queryby
          IF queryby = '1' THEN 
             SELECT trunc(dateinput,'d') 
               INTO bdate 
               FROM dual  
             LET edate = bdate + 6
             LET l_days = edate - bdate + 1
             #上周期
             LET bdate11 = bdate - l_days
             LET edate11 = edate - l_days
             LET edate1 = s_date_get_date(edate,-12,0)
             LET bdate1 = s_date_get_date(bdate,-12,0)
             DISPLAY BY NAME dateinput,edate,bdate,edate11,bdate11,edate1,bdate1
             SELECT trunc(dateinput, 'iw') 
               INTO l_monday 
               from dual 
          END IF 
          IF queryby = '2' THEN 
             SELECT last_day(dateinput) INTO edate FROM dual 
             SELECT trunc(dateinput, 'mm') INTO bdate FROM dual 
             LET l_days = edate - bdate + 1
             #上周期
             LET bdate11 = bdate - l_days
             LET edate11 = edate - l_days
             LET edate1 = s_date_get_date(edate,-12,0)
             LET bdate1 = s_date_get_date(bdate,-12,0)
             DISPLAY BY NAME dateinput,edate,bdate,edate11,bdate11,edate1,bdate1
          END IF 
       
       
       AFTER FIELD dateinput 
          IF queryby = '1' THEN 
             SELECT trunc(dateinput,'d') 
               INTO bdate 
               FROM dual  
             LET edate = bdate + 6
             LET l_days = edate - bdate + 1
             #上周期
             LET bdate11 = bdate - l_days
             LET edate11 = edate - l_days
             LET edate1 = s_date_get_date(edate,-12,0)
             LET bdate1 = s_date_get_date(bdate,-12,0)
             SELECT trunc(dateinput, 'iw') 
               INTO l_monday 
               from dual 
             DISPLAY BY NAME dateinput,edate,bdate,edate11,bdate11,edate1,bdate1
          END IF 
          IF queryby = '2' THEN 
             SELECT last_day(dateinput) INTO edate FROM dual 
             SELECT trunc(dateinput, 'mm') INTO bdate FROM dual 
             LET l_days = edate - bdate + 1
             #上周期
             LET bdate11 = bdate - l_days
             LET edate11 = edate - l_days
             LET edate1 = s_date_get_date(edate,-12,0)
             LET bdate1 = s_date_get_date(bdate,-12,0)
             DISPLAY BY NAME dateinput,edate,bdate,edate11,bdate11,edate1,bdate1
          END IF 
          
          
#       AFTER FIELD bdate
#          IF NOT cl_null(bdate) THEN
#             IF bdate > edate THEN
#                INITIALIZE g_errparam TO NULL 
#                LET g_errparam.extend = "" 
#                LET g_errparam.code   = 'amr-00072' # 起始时间不可大于截止时间
#                LET g_errparam.popup  = TRUE 
#                CALL cl_err()
#                NEXT FIELD bdate
#             END IF
#          END IF
       AFTER FIELD edate
          IF NOT cl_null(edate) THEN
             IF edate < bdate THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "" 
                LET g_errparam.code   = 'amm-00094' # 结束时间必须大于等于开始时间
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                NEXT FIELD edate
                END IF
          END IF
#        AFTER FIELD bdate1
#          IF NOT cl_null(bdate1) THEN
#             IF bdate1 > edate1 THEN
#                INITIALIZE g_errparam TO NULL 
#                LET g_errparam.extend = "" 
#                LET g_errparam.code   = 'amr-00072' # 起始时间不可大于截止时间
#                LET g_errparam.popup  = TRUE 
#                CALL cl_err()
#                NEXT FIELD bdate1
#             END IF
#          END IF
       AFTER FIELD edate1
          IF NOT cl_null(edate1) THEN
             IF edate1 < bdate1 THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "" 
                LET g_errparam.code   = 'amm-00094' # 结束时间必须大于等于开始时间
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                NEXT FIELD edate1
             END IF
         END IF
         
         AFTER INPUT
            IF INT_FLAG THEN
#            	LET INT_FLAG=0
#               EXIT INPUT
               RETURN
            END IF
      END INPUT       
 
      ON ACTION accept
         #add-point:ON ACTION accept

         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         RETURN
         EXIT DIALOG
         
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前
      BEFORE DIALOG    
            
         DISPLAY ldebgsite,
                 lrtaw001,
                 lstfa003,
                 ldebg005,
                 lstfa010
              TO debgsite,
                 rtaw001, 
                 stfa003,
                 debg005,
                 stfa010
                     
      AFTER DIALOG     
         LET l_days = edate - bdate + 1          
      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後

         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後

      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
      LET g_wc2 = ls_wc2
      LET g_wc_filter = g_wc_filter_t
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct

   #end add-point
        
   LET g_error_show = 1
   CALL astq522_b_fill()
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
# Descriptions...: 按专柜汇总
# Date & Author..: 2015-09-13 BY LanJJ
# Modify.........:
################################################################################
PRIVATE FUNCTION astq522_b_fill1()
DEFINE l_sql    STRING
DEFINE l_sql1   STRING
DEFINE l_sql3   STRING
DEFINE l_cnt2   LIKE type_t.num5 
 
   CALL g_debg_d1.clear()
   LET l_sql1 = "   SELECT rtaw001,      rtaxl003,     SUM(l_un_day), ",
                "          SUM(l_debg017),   SUM(l_stgg009),   '',  SUM(l_stea008),    SUM(l_debg017)/SUM(l_stea008),     SUM(l_stgg009)/SUM(l_stea008),    ",   
                "          SUM(l_debg017_2), SUM(l_stgg009_2), '',  SUM(l_stea008_2),  SUM(l_debg017_2)/SUM(l_stea008_2), SUM(l_stgg009_2)/SUM(l_stea008_2),",
                "          SUM(l_debg017_3), SUM(l_stgg009_3), '',  SUM(l_stea008_3),  SUM(l_debg017_3)/SUM(l_stea008_3), SUM(l_stgg009_3)/SUM(l_stea008_3),",
                "          SUM(l_debg017)/SUM(l_debg017_2), ",
                "          SUM(l_debg017)/SUM(l_debg017_3)  ",                       
                "     FROM astq522_tmp ",
                " GROUP BY rtaw001,rtaxl003 "

   DISPLAY "l_sql1:",l_sql1  
   PREPARE sel_debg1_pre1 FROM l_sql1
   DECLARE sel_debg1_cs1  CURSOR FOR sel_debg1_pre1   
   
   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH sel_debg1_cs1 # USING g_enterprise,g_site
                       INTO g_debg_d1[l_ac].l_rtaw001,   
                            g_debg_d1[l_ac].l_rtaxl003,  
                            g_debg_d1[l_ac].l_un_day_1,  
                            g_debg_d1[l_ac].l_debg017_11,
                            g_debg_d1[l_ac].l_stgg009_11,
                            g_debg_d1[l_ac].l_debg020_11,
                            g_debg_d1[l_ac].l_stea008_11,
                            g_debg_d1[l_ac].l_ping_11,   
                            g_debg_d1[l_ac].l_ping_111,  
                            g_debg_d1[l_ac].l_debg017_21,
                            g_debg_d1[l_ac].l_stgg009_21,
                            g_debg_d1[l_ac].l_debg020_21,
                            g_debg_d1[l_ac].l_stea008_21,
                            g_debg_d1[l_ac].l_ping_21,   
                            g_debg_d1[l_ac].l_ping_211,  
                            g_debg_d1[l_ac].l_debg017_31,
                            g_debg_d1[l_ac].l_stgg009_31,
                            g_debg_d1[l_ac].l_debg020_31, 
                            g_debg_d1[l_ac].l_stea008_31,
                            g_debg_d1[l_ac].l_ping_31,   
                            g_debg_d1[l_ac].l_ping_311,  
                            g_debg_d1[l_ac].l_rate11,    
                            g_debg_d1[l_ac].l_rate21    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH
   
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CALL g_debg_d1.deleteElement(g_debg_d1.getLength())
   
   DISPLAY ARRAY g_debg_d1 TO s_detail2.* ATTRIBUTES(COUNT=g_detail_cnt)  
   
      BEFORE DISPLAY 
         EXIT DISPLAY

   END DISPLAY

   FREE sel_debg1_cs1
   
END FUNCTION

################################################################################
# Descriptions...: 创建临时表
# Date & Author..: 2015-09-18 By LanJJ
# Modify.........:
################################################################################
PRIVATE FUNCTION astq522_create_tmp()
DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT astq522_drop_tmp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE TEMP TABLE astq522_tmp(
   enterprise    LIKE type_t.chr500, 
   site          LIKE debg_t.debgsite,
   rtaw001       LIKE rtaw_t.rtaw001, 
   rtaxl003      LIKE rtaxl_t.rtaxl003, 
   debg005       LIKE debg_t.debg005, 
   stfal003      LIKE stfal_t.stfal003, 
   l_un_day      LIKE type_t.num5, 
   l_debg017     LIKE type_t.num20_6, #本周期 
   l_stgg009     LIKE type_t.num20_6, 
   l_debg020     LIKE type_t.num20_6, 
   l_rank1       LIKE type_t.chr500, 
   l_stea008     LIKE type_t.num15_3, 
   l_ping11      LIKE type_t.num20_6, 
   l_rank11      LIKE type_t.chr500, 
   l_ping12      LIKE type_t.num20_6, 
   l_rank12      LIKE type_t.chr500, 
   l_debg017_2   LIKE type_t.num20_6, #上周期 
   l_stgg009_2   LIKE type_t.num20_6,
   l_debg020_2   LIKE type_t.num20_6, 
   l_rank2       LIKE type_t.chr500, 
   l_stea008_2   LIKE type_t.num15_3, 
   l_ping21      LIKE type_t.num20_6, 
   l_rank21      LIKE type_t.chr500, 
   l_ping22      LIKE type_t.num20_6, 
   l_rank22      LIKE type_t.chr500, 
   l_debg017_3   LIKE type_t.num20_6, #对比周期
   l_stgg009_3   LIKE type_t.num20_6,
   l_debg020_3   LIKE type_t.num20_6, 
   l_rank3       LIKE type_t.chr500, 
   l_stea008_3   LIKE type_t.num15_3, 
   l_ping31      LIKE type_t.num20_6, 
   l_rank31      LIKE type_t.chr500, 
   l_ping32      LIKE type_t.num20_6, 
   l_rank32      LIKE type_t.chr500, 
   l_rate1       LIKE type_t.num20_6, 
   l_rate2       LIKE type_t.chr500
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create astq522_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: drop临时表
# Date & Author..: 2015-09-18 By lanjj
# Modify.........:
################################################################################
PRIVATE FUNCTION astq522_drop_tmp()
DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE astq522_tmp

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop astq522_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
