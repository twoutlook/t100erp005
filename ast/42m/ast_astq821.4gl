#該程式未解開Section, 採用最新樣板產出!
{<section id="astq821.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-09-07 19:38:00), PR版次:0005(2016-10-11 17:18:54)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: astq821
#+ Description: 鋪位費用執行對比查詢作業
#+ Creator....: 06814(2016-05-30 16:57:32)
#+ Modifier...: 06189 -SD/PR- 06189
 
{</section>}
 
{<section id="astq821.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160728-00006#32  2016/08/22  by 08172  新增费用编号作为查询条件
#add by geza 20160919 #160919-00073#1   未收 = 应收 -已收
#add by geza 20160920 #160919-00073#2   未收金额=合同账单产生的费用单对应的底稿，未结算金额汇总
#add by geza 20161011 #161011-00024#1   收取比例=（已结算金额+已收款金额）/应收金额
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
PRIVATE TYPE type_g_stje_d RECORD
       
       sel LIKE type_t.chr1, 
   stjesite LIKE stje_t.stjesite, 
   stjesite_desc LIKE type_t.chr500, 
   stje007 LIKE stje_t.stje007, 
   stje007_desc LIKE type_t.chr500, 
   stje007_desc_desc LIKE type_t.chr500, 
   stje008 LIKE stje_t.stje008, 
   stje008_desc LIKE type_t.chr500, 
   stje028 LIKE stje_t.stje028, 
   stje028_desc LIKE type_t.chr500, 
   stje029 LIKE stje_t.stje029, 
   stje029_desc LIKE type_t.chr500, 
   stje019 LIKE stje_t.stje019, 
   stje019_desc LIKE type_t.chr500, 
   stje020 LIKE stje_t.stje020, 
   stje020_desc LIKE type_t.chr500, 
   stje021 LIKE stje_t.stje021, 
   stje021_desc LIKE type_t.chr500, 
   stjm003 LIKE stjm_t.stjm003, 
   stjm003_desc LIKE type_t.chr500, 
   l_bdate_1 LIKE type_t.dat, 
   l_edate_1 LIKE type_t.dat, 
   l_day LIKE type_t.num10, 
   stjm007 LIKE stjm_t.stjm007, 
   stjm008 LIKE stjm_t.stjm008, 
   stjm010 LIKE stjm_t.stjm010, 
   stjm009 LIKE stjm_t.stjm009, 
   stjm011 LIKE stjm_t.stjm011, 
   stjm012 LIKE stjm_t.stjm012, 
   stjm013 LIKE stjm_t.stjm013, 
   l_percent LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_head   RECORD 
       l_bdate  LIKE type_t.dat,
       l_edate  LIKE type_t.dat
                END RECORD
DEFINE g_stjesite_flag LIKE type_t.chr1
DEFINE g_stje007_flag  LIKE type_t.chr1
DEFINE g_stje008_flag  LIKE type_t.chr1
DEFINE g_stje028_flag  LIKE type_t.chr1
DEFINE g_stje029_flag  LIKE type_t.chr1
DEFINE g_stje019_flag  LIKE type_t.chr1
DEFINE g_stje020_flag  LIKE type_t.chr1
DEFINE g_stje021_flag  LIKE type_t.chr1
#end add-point
 
#模組變數(Module Variables)
DEFINE g_stje_d            DYNAMIC ARRAY OF type_g_stje_d
DEFINE g_stje_d_t          type_g_stje_d
 
 
 
 
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
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="astq821.main" >}
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
   DECLARE astq821_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE astq821_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astq821_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astq821 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astq821_init()   
 
      #進入選單 Menu (="N")
      CALL astq821_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_astq821
      
   END IF 
   
   CLOSE astq821_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   CALL astq821_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="astq821.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION astq821_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL astq821_create_temp() RETURNING l_success
   #end add-point
 
   CALL astq821_default_search()
END FUNCTION
 
{</section>}
 
{<section id="astq821.default_search" >}
PRIVATE FUNCTION astq821_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " stje001 = '", g_argv[01], "' AND "
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
 
{<section id="astq821.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astq821_ui_dialog() 
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
 
   
   CALL astq821_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_stje_d.clear()
 
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
 
         CALL astq821_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT g_head.l_bdate,g_head.l_edate
          FROM l_bdate,l_edate
            AFTER FIELD l_bdate
               IF g_head.l_bdate > g_head.l_edate THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'art-00020'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            AFTER FIELD l_edate
               IF g_head.l_edate < g_head.l_bdate THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'ast-00797'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
         END INPUT
         INPUT g_stjesite_flag,g_stje007_flag,g_stje008_flag,g_stje028_flag,g_stje029_flag,g_stje019_flag,g_stje020_flag,g_stje021_flag
          FROM l_stjesite_flag,l_stje007_flag,l_stje008_flag,l_stje028_flag,l_stje029_flag,l_stje019_flag,l_stje020_flag,l_stje021_flag
            ON CHANGE l_stje019_flag
               IF g_stje019_flag = 'N' THEN
                  LET g_stje020_flag ='N'
                  LET g_stje021_flag ='N'
                  DISPLAY g_stje020_flag,g_stje021_flag TO l_stje020_flag,l_stje021_flag
               END IF
               
            ON CHANGE l_stje020_flag
               IF g_stje020_flag = 'Y' THEN 
                  LET g_stje019_flag ='Y'
                  DISPLAY g_stje019_flag TO l_stje019_flag
               ELSE
                  LET g_stje021_flag ='N'
                  DISPLAY g_stje021_flag TO l_stje021_flag
               END IF
               
            ON CHANGE l_stje021_flag
               IF g_stje021_flag = 'Y' THEN 
                  LET g_stje019_flag ='Y'
                  LET g_stje020_flag ='Y'
                  DISPLAY g_stje019_flag,g_stje020_flag TO l_stje019_flag,l_stje020_flag  
               END IF
               
            AFTER INPUT
               IF NOT astq821_flag_chk() THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'ast-00795'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_stjesite_flag ='Y'
                  NEXT FIELD CURRENT
               END IF
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON stjesite,stje007,stje008,stje019,stje020,stje021,stje028,stje029,stjm003   #160728-00006#32 add stjm003 by 08172
            ON ACTION controlp INFIELD stjesite
                  #開窗c段
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.where = s_aooi500_q_where(g_prog,'stjesite',g_site,'c')
                  CALL q_ooef001_24()                    #呼叫開窗
                  DISPLAY g_qryparam.return1 TO stjesite    #顯示到畫面上
                  NEXT FIELD stjesite                    #返回原欄位
                  
            ON ACTION controlp INFIELD stje007
                  #開窗c段
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.arg1 = "('1','3')"
                  CALL q_pmaa001_1()                    #呼叫開窗
                  DISPLAY g_qryparam.return1 TO stje007    #顯示到畫面上
                  NEXT FIELD stje007                    #返回原欄位
            ON ACTION controlp INFIELD stje008
                  #開窗c段
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  CALL q_mhbe001()                    #呼叫開窗
                  DISPLAY g_qryparam.return1 TO stje008    #顯示到畫面上
                  NEXT FIELD stje008                    #返回原欄位
            ON ACTION controlp INFIELD stje019
                  #開窗c段
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  CALL q_mhaa001()                    #呼叫開窗
                  DISPLAY g_qryparam.return1 TO stje019    #顯示到畫面上
                  NEXT FIELD stje019                    #返回原欄位
            ON ACTION controlp INFIELD stje020
                  #開窗c段
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  CALL q_mhab002()                    #呼叫開窗
                  DISPLAY g_qryparam.return1 TO stje020    #顯示到畫面上
                  NEXT FIELD stje020                    #返回原欄位
            ON ACTION controlp INFIELD stje021
                  #開窗c段
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  CALL q_mhac003()                    #呼叫開窗
                  DISPLAY g_qryparam.return1 TO stje021    #顯示到畫面上
                  NEXT FIELD stje021                    #返回原欄位
            ON ACTION controlp INFIELD stje028
                  #開窗c段
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.arg1 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')
                  CALL q_rtax001_3()                           #呼叫開窗
                  DISPLAY g_qryparam.return1 TO stje028    #顯示到畫面上
                  NEXT FIELD stje028                    #返回原欄位
            ON ACTION controlp INFIELD stje029
                  #開窗c段
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.arg1 = '2002'
                  CALL q_oocq002()                         #呼叫開窗
                  DISPLAY g_qryparam.return1 TO stje029    #顯示到畫面上
                  NEXT FIELD stje029                       #返回原欄位
            ON ACTION controlp INFIELD stjm003
                  #開窗c段
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  CALL q_stae001()                         #呼叫開窗
                  DISPLAY g_qryparam.return1 TO stjm003    #顯示到畫面上
                  NEXT FIELD stjm003                      #返回原欄位
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_stje_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL astq821_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL astq821_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL astq821_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("selall,selnone,sel,unsel,insert", FALSE) 
            CALL cl_set_act_visible("insert,query", FALSE)
            CALL cl_set_comp_visible("sel", FALSE)
            #開始日,結束日,預設 當月
            LET g_head.l_bdate = s_date_get_first_date(g_today)
            LET g_head.l_edate = s_date_get_last_date(g_today)
            DISPLAY g_head.l_bdate,g_head.l_edate TO l_bdate,l_edate
            #分析維度,預設
            LET g_stjesite_flag = 'Y'
            LET g_stje007_flag  = 'N'
            LET g_stje008_flag  = 'N'
            LET g_stje028_flag  = 'N'
            LET g_stje029_flag  = 'N'
            LET g_stje019_flag  = 'N'
            LET g_stje020_flag  = 'N'
            LET g_stje021_flag  = 'N' 
            #end add-point
            NEXT FIELD stjesite
 
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
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            IF NOT astq821_flag_chk() THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'ast-00795'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_stjesite_flag = 'Y'
               NEXT FIELD CURRENT
            END IF
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL astq821_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_stje_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL astq821_b_fill()
 
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
            CALL astq821_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL astq821_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL astq821_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL astq821_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_stje_d.getLength()
               LET g_stje_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_stje_d.getLength()
               LET g_stje_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_stje_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_stje_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_stje_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_stje_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL astq821_filter()
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
 
{<section id="astq821.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astq821_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_day           LIKE type_t.num10
   DEFINE l_sql           STRING
   DEFINE l_where         STRING
   DEFINE l_sel_1         STRING
   DEFINE l_sel_2         STRING
   DEFINE l_sel_3         STRING
   DEFINE l_sel_4         STRING
   DEFINE l_sel_5         STRING
   DEFINE l_sel_6         STRING
   DEFINE l_sel_7         STRING
   DEFINE l_sel_8         STRING
   DEFINE l_group_1       STRING
   DEFINE l_group_2       STRING
   DEFINE l_group_3       STRING
   DEFINE l_group_4       STRING
   DEFINE l_group_5       STRING
   DEFINE l_group_6       STRING
   DEFINE l_group_7       STRING
   DEFINE l_group_8       STRING
   DEFINE l_sum00         LIKE stjm_t.stjm011
   DEFINE l_sum01         LIKE stjm_t.stjm011
   DEFINE l_sum_per       LIKE stjm_t.stjm011
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'stjesite') RETURNING l_where
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF NOT cl_null(l_where) THEN 
      LET g_wc = g_wc , " AND ",l_where
   END IF
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
 
   CALL g_stje_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',stjesite,'',stje007,'','',stje008,'',stje028,'',stje029,'',stje019, 
       '',stje020,'',stje021,'','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY stje_t.stje001) AS RANK FROM stje_t", 
 
 
 
                     "",
                     " WHERE stjeent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("stje_t"),
                     " ORDER BY stje_t.stje001"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET l_sel_1   = "''"
   LET l_sel_2   = "''"
   LET l_sel_3   = "''"
   LET l_sel_4   = "''"
   LET l_sel_5   = "''"
   LET l_sel_6   = "''"
   LET l_sel_7   = "''"
   LET l_sel_8   = "''"
   LET l_group_1 = NULL
   LET l_group_2 = NULL
   LET l_group_3 = NULL
   LET l_group_4 = NULL
   LET l_group_5 = NULL
   LET l_group_6 = NULL
   LET l_group_7 = NULL
   LET l_group_8 = NULL
   #1.依勾選顯示維度組SQL
   IF g_stjesite_flag = 'Y' THEN
      LET l_sel_1 = " stjesite "
      LET l_group_1 = " ,stjesite "
   END IF
   IF g_stje007_flag = 'Y' THEN
      LET l_sel_2 = " stje007 "
      LET l_group_2 = " ,stje007 "
   END IF
   IF g_stje008_flag = 'Y' THEN
      LET l_sel_3 = " stje008 "
      LET l_group_3 = " ,stje008 "
   END IF
   IF g_stje019_flag = 'Y' THEN
      LET l_sel_4 = " stje019 "
      LET l_group_4 = " ,stje019 "
   END IF
   IF g_stje020_flag = 'Y' THEN
      LET l_sel_5 = " stje020 "
      LET l_group_5 = " ,stje020 "
   END IF
   IF g_stje021_flag = 'Y' THEN
      LET l_sel_6 = " stje021 "
      LET l_group_6 = " ,stje021 "
   END IF
   IF g_stje028_flag = 'Y' THEN
      LET l_sel_7 = " stje028 "
      LET l_group_7 = " ,stje028 "
   END IF
   IF g_stje029_flag = 'Y' THEN
      LET l_sel_8 = " stje029 "
      LET l_group_8 = " ,stje029 "
   END IF
   DELETE FROM astq821_temp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "DELETE astq821_temp" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   #mark by geza 20160907 #160728-00006#46(S)
#   LET l_sql = "SELECT UNIQUE stjeent,",
#               "       ",l_sel_1,",",
#               "       ",l_sel_2,", ",
#               "       ",l_sel_3,", ",
#               "       ",l_sel_7,", ",
#               "       ",l_sel_8,", ",
#               "       ",l_sel_4,", ",
#               "       ",l_sel_5,", ",
#               "       ",l_sel_6,", ",
#               "       stjm003,",
#               "       COALESCE(SUM(stjm007),0),COALESCE(SUM(stjm008),0),",
#               "       COALESCE(SUM(stjm010),0),COALESCE(SUM(stjm009),0),",
#               "       COALESCE(SUM(stjm011),0), ",
#              #"       COALESCE(SUM(stbc022+stbc024),0),",   #160604-00009#57 160621 by sakura mark
#               "       COALESCE(SUM(stbc020+stbc022),0),",   #160604-00009#57 160621 by sakura add
#              #"       COALESCE((SUM(stjm011)-SUM(stbc022+stbc024)),0), ",   #160604-00009#57 160621 by sakura mark
#               "       COALESCE (SUM (stjm011), 0) - SUM (COALESCE(stbc020,0) + COALESCE(stbc022,0)), ",   #160604-00009#57 160621 by sakura add
#               "       COALESCE((SUM(stbc022+stbc024)/(CASE WHEN COALESCE(SUM(stjm011),1)=0 THEN 1 ELSE COALESCE(SUM(stjm011),1) END )*100),0)",
#               "  FROM stje_t,stjm_t ",
#               "       LEFT JOIN stbc_t ON stbcent = stjment AND stbc003 = '3' AND stbc004 = stjm016 AND stbc012 = stjm003 ",
#               " WHERE stjeent = stjment AND stje001 = stjm001 ",
#               "   AND stjeent= ", g_enterprise,
#               #160728-00006#32 -s by 08172
##               "   AND stjm005 >= '",g_head.l_bdate,"' ",
##               "   AND stjm006 <= '",g_head.l_edate,"' ",
#               "   AND stjm004 >= '",g_head.l_bdate,"' ",
#               "   AND stjm004 <= '",g_head.l_edate,"' ",
#               #160728-00006#32 -e by 08172
#               "   AND ", ls_wc,
#               " GROUP BY stjeent ",l_group_1,l_group_2,l_group_3,l_group_4,l_group_5,l_group_6,l_group_7,l_group_8," ,stjm003"
   #mark by geza 20160907 #160728-00006#46(E) 
   #add by geza 20160907 #160728-00006#46(S)
   LET l_sql = "SELECT UNIQUE stjeent,",
               "       ",l_sel_1,",",
               "       ",l_sel_2,", ",
               "       ",l_sel_3,", ",
               "       ",l_sel_7,", ",
               "       ",l_sel_8,", ",
               "       ",l_sel_4,", ",
               "       ",l_sel_5,", ",
               "       ",l_sel_6,", ",
               "       stjm003,",
               "       COALESCE(SUM(stjm007),0),COALESCE(SUM(stjm008),0),",
               "       COALESCE(SUM(stjm010),0),COALESCE(SUM(stjm009),0),",
               "       COALESCE(SUM(stjm011),0), ",
               "       0,",   
               "       0, ",   
               "       0,0",
               "  FROM stje_t,stjm_t ",
               " WHERE stjeent = stjment AND stje001 = stjm001 ",
               "   AND stjeent= ", g_enterprise,
               "   AND stjm004 >= '",g_head.l_bdate,"' ",
               "   AND stjm004 <= '",g_head.l_edate,"' ",
               "   AND ", ls_wc,
               " GROUP BY stjeent ",l_group_1,l_group_2,l_group_3,l_group_4,l_group_5,l_group_6,l_group_7,l_group_8," ,stjm003"
   #add by geza 20160907 #160728-00006#46(E)     
   #DISPLAY "l_sql: \n" ,l_sql
   #2.ins_temp
   LET l_sql = " INSERT INTO astq821_temp ", l_sql
   PREPARE astq821_ins_temp_pre FROM l_sql  
   EXECUTE astq821_ins_temp_pre 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "EXECUTE:astq821_ins_temp_pre" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   #add by geza 20160907 #160728-00006#46(S)
   #更新临时表的资料
   LET l_sql = " MERGE INTO astq821_temp ",
               " USING( ",
               "SELECT UNIQUE stjeent ent,",
               "       ",l_sel_1," a1,",
               "       ",l_sel_2," a2, ",
               "       ",l_sel_3," a3, ",
               "       ",l_sel_7," a7, ",
               "       ",l_sel_8," a8, ",
               "       ",l_sel_4," a4, ",
               "       ",l_sel_5," a5, ",
               "       ",l_sel_6," a6, ",
               "       stjm003 a9,",
               "       COALESCE(SUM(stbc019),0) a19," , #add by geza 20160920 #160919-00073#2
               "       COALESCE(SUM(stbc020),0) a20," ,
               "       COALESCE(SUM(stbc022),0) a22," ,
               "       COALESCE(SUM(stbc024),0) a24" ,
               "   FROM stje_t,stbc_t,stjm_t ",
               " WHERE stjeent = stjment AND stje001 = stjm001 ",
               "   AND stbcent = stjment AND stbc003 = '3' AND stbc004 = stjm016 AND stbc012 = stjm003 ",
               "   AND stjeent= ", g_enterprise,
               "   AND stjm004 >= '",g_head.l_bdate,"' ",
               "   AND stjm004 <= '",g_head.l_edate,"' ",
               "   AND ", ls_wc,
               " GROUP BY stjeent ",l_group_1,l_group_2,l_group_3,l_group_4,l_group_5,l_group_6,l_group_7,l_group_8," ,stjm003",
               " ) ",
               " ON (stjeent=ent AND stjm003=a9 AND ((a1 IS NOT NULL AND a1 = stjesite) OR (a1 IS NULL AND stjesite IS NULL))  
                    AND ((a2 IS NOT NULL AND a2 = stje007) OR (a2 IS NULL AND stje007 IS NULL)) 
                    AND ((a3 IS NOT NULL AND a3 = stje008) OR (a3 IS NULL AND stje008 IS NULL)) 
                    AND ((a7 IS NOT NULL AND a7 = stje028) OR (a7 IS NULL AND stje028 IS NULL)) 
                    AND ((a8 IS NOT NULL AND a8 = stje029) OR (a8 IS NULL AND stje029 IS NULL))
                    AND ((a4 IS NOT NULL AND a4 = stje019) OR (a4 IS NULL AND stje019 IS NULL))
                    AND ((a5 IS NOT NULL AND a5 = stje020) OR (a5 IS NULL AND stje020 IS NULL))
                    AND ((a6 IS NOT NULL AND a6 = stje021) OR (a6 IS NULL AND stje021 IS NULL))
                    ) ",
               " WHEN MATCHED THEN  ",
               "   UPDATE SET stjm012 = COALESCE(a20+a22,0),  ", 
               #"              stjm013 = COALESCE(stjm011-a20+a22,0),  ", #mark by geza 20160919 #160919-00073#1
               #"              stjm013 = COALESCE(stjm011-a20-a22,0),  ", #add by geza 20160919 #160919-00073#1 #mark by geza 20160919 #160919-00073#2
               #未收金额=合同账单产生的费用单对应的底稿，未结算金额汇总
               "              stjm013 = COALESCE(a19,0),  ", #add by geza 20160920 #160919-00073#2
               #"              l_percent =COALESCE(((a22+a24)/(CASE WHEN COALESCE((stjm011),1)=0 THEN 1 ELSE COALESCE((stjm011),1) END )*100),0),  ", #mark by geza 20161011 #161011-00024#1    
               "              l_percent =COALESCE(((a22+a20)/(CASE WHEN COALESCE((stjm011),1)=0 THEN 1 ELSE COALESCE((stjm011),1) END )*100),0),  ", #add by geza 20161011 #161011-00024#1    
               "              l_per = COALESCE(a22+a24,0)   "               
   PREPARE astq821_upd_temp_pre FROM l_sql  
   EXECUTE astq821_upd_temp_pre 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "EXECUTE:astq821_upd_temp_pre" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF               
   #add by geza 20160907 #160728-00006#46(E)
   #3.撈取temp資料顯示   
   LET ls_sql_rank = "SELECT UNIQUE stjeent,",
                     "       stjesite,",
                     "       (SELECT ooefl003 FROM ooefl_t ",
                     "         WHERE ooeflent = ",g_enterprise,
                     "           AND ooefl001 = stjesite ",
                     "           AND ooefl002 = '",g_dlang,"' ) stjesite_desc, ",
                     "       stje007, ",
                     "       pmaal004 stje007_desc,pmaal003 stje007_desc_desc, ",
                     "       stje008, ",
                     "       (SELECT mhbel003 FROM mhbel_t ",
                     "         WHERE mhbelent = ",g_enterprise,
                     "           AND mhbel001 = stje008 ",
                     "           AND mhbel002 = '",g_dlang,"' ) stje008_desc, ",
                     "       stje028, ",
                     "       (SELECT rtaxl003 FROM rtaxl_t ",
                     "         WHERE rtaxlent = ",g_enterprise,
                     "           AND rtaxl001 = stje028 ",
                     "           AND rtaxl002 =  '",g_dlang,"' ) stje028_desc, ",
                     "       stje029, ",
                     "       (SELECT oocql004 FROM oocql_t ",
                     "         WHERE oocqlent = ",g_enterprise,
                     "           AND oocql001 = '2002'",
                     "           AND oocql002 = stje029 ",
                     "           AND oocql003 =  '",g_dlang,"' ) stje029_desc, ",
                     "       stje019, ",
                     "       (SELECT mhaal003 FROM mhaal_t ",
                     "          WHERE mhaalent = ",g_enterprise,
                     "            AND mhaal001 = stje019 ",
                     "            AND mhaal002 = '",g_dlang,"' ) stje019_desc, ",
                     "       stje020, ",
                     "       (SELECT mhabl004 FROM mhabl_t ",
                     "         WHERE mhablent = ",g_enterprise,
                     "           AND mhabl001 = stje019 ",
                     "           AND mhabl002 = stje020 ",
                     "           AND mhabl003 =  '",g_dlang,"' ) stje020_desc, ",
                     "       stje021, ",
                     "       (SELECT mhacl005 FROM mhacl_t ",
                     "         WHERE mhaclent = ",g_enterprise,
                     "           AND mhacl001 = stje019 ",
                     "           AND mhacl002 = stje020 ",
                     "           AND mhacl003 = stje021 ",
                     "           AND mhacl004 =  '",g_dlang,"' ) stje021_desc, ",
                     "       stjm003,",
                     "       (SELECT stael003 FROM stael_t ",
                     "         WHERE staelent = ",g_enterprise,
                     "           AND stael001 = stjm003 ",
                     "           AND stael002 = '",g_dlang,"' ) stjm003_desc, ",
                     "       '','','',",   #開始,截止,天數
                     "       sum_stjm007,sum_stjm008,sum_stjm010,sum_stjm009,  ",
                     "       stjm011,stjm012,stjm013,l_percent, ",
                     "       DENSE_RANK() OVER( ORDER BY stjesite,stje007,stje008,stje028,stje029,stje019,stje020,stje021) AS RANK ",
                     "  FROM astq821_temp ",
                     "       LEFT JOIN pmaal_t ON pmaalent = ",g_enterprise," AND pmaal001 = stje007 AND pmaal002 = '",g_dlang,"' ",
                     " WHERE stjeent = ? AND 1=1 "
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("stje_t"),
                     " ORDER BY stjesite,stje007,stje008,stje028,stje029,stje019,stje020,stje021,stjm003"
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
 
   LET g_sql = "SELECT '',stjesite,'',stje007,'','',stje008,'',stje028,'',stje029,'',stje019,'',stje020, 
       '',stje021,'','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET l_day = g_head.l_edate - g_head.l_bdate + 1
   LET g_sql = "SELECT 'N', ",
               "       stjesite,stjesite_desc,stje007,stje007_desc,stje007_desc_desc, ",
               "       stje008,stje008_desc,stje028,stje028_desc,stje029, ",
               "       stje029_desc,stje019,stje019_desc,stje020,stje020_desc, ",
               "       stje021,stje021_desc,stjm003,stjm003_desc, ",
               "       '",g_head.l_bdate,"','",g_head.l_edate,"','",l_day,"',",
               "       sum_stjm007,sum_stjm008,sum_stjm010,sum_stjm009,  ",
               "       stjm011,stjm012,stjm013,l_percent",
               " FROM (",ls_sql_rank,")",
               "WHERE RANK >= ",g_pagestart,
               "  AND RANK < ",g_pagestart + g_num_in_page
   #DISPLAY "g_sql:\n", g_sql
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE astq821_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR astq821_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_stje_d[l_ac].sel,g_stje_d[l_ac].stjesite,g_stje_d[l_ac].stjesite_desc, 
       g_stje_d[l_ac].stje007,g_stje_d[l_ac].stje007_desc,g_stje_d[l_ac].stje007_desc_desc,g_stje_d[l_ac].stje008, 
       g_stje_d[l_ac].stje008_desc,g_stje_d[l_ac].stje028,g_stje_d[l_ac].stje028_desc,g_stje_d[l_ac].stje029, 
       g_stje_d[l_ac].stje029_desc,g_stje_d[l_ac].stje019,g_stje_d[l_ac].stje019_desc,g_stje_d[l_ac].stje020, 
       g_stje_d[l_ac].stje020_desc,g_stje_d[l_ac].stje021,g_stje_d[l_ac].stje021_desc,g_stje_d[l_ac].stjm003, 
       g_stje_d[l_ac].stjm003_desc,g_stje_d[l_ac].l_bdate_1,g_stje_d[l_ac].l_edate_1,g_stje_d[l_ac].l_day, 
       g_stje_d[l_ac].stjm007,g_stje_d[l_ac].stjm008,g_stje_d[l_ac].stjm010,g_stje_d[l_ac].stjm009,g_stje_d[l_ac].stjm011, 
       g_stje_d[l_ac].stjm012,g_stje_d[l_ac].stjm013,g_stje_d[l_ac].l_percent
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
 
      #end add-point
 
      CALL astq821_detail_show("'1'")
 
      CALL astq821_stje_t_mask()
 
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
    ##add by zhangnan 比例汇总
    SELECT SUM(stjm011),SUM(l_per) INTO l_sum00,l_sum01
    FROM astq821_temp 
    IF cl_null(l_sum00) THEN LET l_sum00=1 END IF
    IF cl_null(l_sum01) THEN LET l_sum01=0 END IF
    LET l_sum_per=l_sum01/l_sum00 *100
    DISPLAY l_sum_per TO avg1        
    #add by zhangnan --end 
   #end add-point
 
   CALL g_stje_d.deleteElement(g_stje_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   CALL astq821_set_comp_visible()
   CALL astq821_set_comp_no_visible()
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_stje_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE astq821_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL astq821_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL astq821_detail_action_trans()
 
   LET l_ac = 1
   IF g_stje_d.getLength() > 0 THEN
      CALL astq821_b_fill2()
   END IF
 
      CALL astq821_filter_show('stjesite','b_stjesite')
   CALL astq821_filter_show('stje007','b_stje007')
   CALL astq821_filter_show('stje008','b_stje008')
   CALL astq821_filter_show('stje028','b_stje028')
   CALL astq821_filter_show('stje029','b_stje029')
   CALL astq821_filter_show('stje019','b_stje019')
   CALL astq821_filter_show('stje020','b_stje020')
   CALL astq821_filter_show('stje021','b_stje021')
   CALL astq821_filter_show('stjm003','b_stjm003')
   CALL astq821_filter_show('stjm007','b_stjm007')
   CALL astq821_filter_show('stjm008','b_stjm008')
   CALL astq821_filter_show('stjm010','b_stjm010')
   CALL astq821_filter_show('stjm009','b_stjm009')
   CALL astq821_filter_show('stjm011','b_stjm011')
   CALL astq821_filter_show('stjm012','b_stjm012')
   CALL astq821_filter_show('stjm013','b_stjm013')
 
 
END FUNCTION
 
{</section>}
 
{<section id="astq821.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astq821_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="astq821.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION astq821_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_stje_d[l_ac].stjesite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stje_d[l_ac].stjesite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stje_d[l_ac].stjesite_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stje_d[l_ac].stje007
            LET ls_sql = "SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stje_d[l_ac].stje007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stje_d[l_ac].stje007_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stje_d[l_ac].stje007
            LET ls_sql = "SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stje_d[l_ac].stje007_desc_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stje_d[l_ac].stje007_desc_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stje_d[l_ac].stje008
            LET ls_sql = "SELECT mhbel003 FROM mhbel_t WHERE mhbelent='"||g_enterprise||"' AND mhbel001=? AND mhbel002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stje_d[l_ac].stje008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stje_d[l_ac].stje008_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stje_d[l_ac].stje028
            LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stje_d[l_ac].stje028_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stje_d[l_ac].stje028_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stje_d[l_ac].stje029
            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stje_d[l_ac].stje029_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stje_d[l_ac].stje029_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stje_d[l_ac].stje019
            LET ls_sql = "SELECT mhaal003 FROM mhaal_t WHERE mhaalent='"||g_enterprise||"' AND mhaal001=? AND mhaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stje_d[l_ac].stje019_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stje_d[l_ac].stje019_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stje_d[l_ac].stje019
            LET g_ref_fields[2] = g_stje_d[l_ac].stje020
            LET ls_sql = "SELECT mhabl004 FROM mhabl_t WHERE mhablent='"||g_enterprise||"' AND mhabl001=? AND mhabl002=? AND mhabl003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stje_d[l_ac].stje020_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stje_d[l_ac].stje020_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stje_d[l_ac].stje019
            LET g_ref_fields[2] = g_stje_d[l_ac].stje020
            LET g_ref_fields[3] = g_stje_d[l_ac].stje021
            LET ls_sql = "SELECT mhacl005 FROM mhacl_t WHERE mhaclent='"||g_enterprise||"' AND mhacl001=? AND mhacl002=? AND mhacl003=? AND mhacl004='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stje_d[l_ac].stje021_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stje_d[l_ac].stje021_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stje_d[l_ac].stjm003
            LET ls_sql = "SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stje_d[l_ac].stjm003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stje_d[l_ac].stjm003_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astq821.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION astq821_filter()
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
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON stjesite,stje007,stje008,stje028,stje029,stje019,stje020,stje021,stjm003, 
          stjm007,stjm008,stjm010,stjm009,stjm011,stjm012,stjm013
                          FROM s_detail1[1].b_stjesite,s_detail1[1].b_stje007,s_detail1[1].b_stje008, 
                              s_detail1[1].b_stje028,s_detail1[1].b_stje029,s_detail1[1].b_stje019,s_detail1[1].b_stje020, 
                              s_detail1[1].b_stje021,s_detail1[1].b_stjm003,s_detail1[1].b_stjm007,s_detail1[1].b_stjm008, 
                              s_detail1[1].b_stjm010,s_detail1[1].b_stjm009,s_detail1[1].b_stjm011,s_detail1[1].b_stjm012, 
                              s_detail1[1].b_stjm013
 
         BEFORE CONSTRUCT
                     DISPLAY astq821_filter_parser('stjesite') TO s_detail1[1].b_stjesite
            DISPLAY astq821_filter_parser('stje007') TO s_detail1[1].b_stje007
            DISPLAY astq821_filter_parser('stje008') TO s_detail1[1].b_stje008
            DISPLAY astq821_filter_parser('stje028') TO s_detail1[1].b_stje028
            DISPLAY astq821_filter_parser('stje029') TO s_detail1[1].b_stje029
            DISPLAY astq821_filter_parser('stje019') TO s_detail1[1].b_stje019
            DISPLAY astq821_filter_parser('stje020') TO s_detail1[1].b_stje020
            DISPLAY astq821_filter_parser('stje021') TO s_detail1[1].b_stje021
            DISPLAY astq821_filter_parser('stjm003') TO s_detail1[1].b_stjm003
            DISPLAY astq821_filter_parser('stjm007') TO s_detail1[1].b_stjm007
            DISPLAY astq821_filter_parser('stjm008') TO s_detail1[1].b_stjm008
            DISPLAY astq821_filter_parser('stjm010') TO s_detail1[1].b_stjm010
            DISPLAY astq821_filter_parser('stjm009') TO s_detail1[1].b_stjm009
            DISPLAY astq821_filter_parser('stjm011') TO s_detail1[1].b_stjm011
            DISPLAY astq821_filter_parser('stjm012') TO s_detail1[1].b_stjm012
            DISPLAY astq821_filter_parser('stjm013') TO s_detail1[1].b_stjm013
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_stjesite>>----
         #Ctrlp:construct.c.filter.page1.b_stjesite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjesite
            #add-point:ON ACTION controlp INFIELD b_stjesite name="construct.c.filter.page1.b_stjesite"
            
            #END add-point
 
 
         #----<<b_stjesite_desc>>----
         #----<<b_stje007>>----
         #Ctrlp:construct.c.filter.page1.b_stje007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje007
            #add-point:ON ACTION controlp INFIELD b_stje007 name="construct.c.filter.page1.b_stje007"
            
            #END add-point
 
 
         #----<<b_stje007_desc>>----
         #----<<b_stje007_desc_desc>>----
         #----<<b_stje008>>----
         #Ctrlp:construct.c.filter.page1.b_stje008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje008
            #add-point:ON ACTION controlp INFIELD b_stje008 name="construct.c.filter.page1.b_stje008"
            
            #END add-point
 
 
         #----<<b_stje008_desc>>----
         #----<<b_stje028>>----
         #Ctrlp:construct.c.filter.page1.b_stje028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje028
            #add-point:ON ACTION controlp INFIELD b_stje028 name="construct.c.filter.page1.b_stje028"
            
            #END add-point
 
 
         #----<<b_stje028_desc>>----
         #----<<b_stje029>>----
         #Ctrlp:construct.c.filter.page1.b_stje029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje029
            #add-point:ON ACTION controlp INFIELD b_stje029 name="construct.c.filter.page1.b_stje029"
            
            #END add-point
 
 
         #----<<b_stje029_desc>>----
         #----<<b_stje019>>----
         #Ctrlp:construct.c.filter.page1.b_stje019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje019
            #add-point:ON ACTION controlp INFIELD b_stje019 name="construct.c.filter.page1.b_stje019"
            
            #END add-point
 
 
         #----<<b_stje019_desc>>----
         #----<<b_stje020>>----
         #Ctrlp:construct.c.filter.page1.b_stje020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje020
            #add-point:ON ACTION controlp INFIELD b_stje020 name="construct.c.filter.page1.b_stje020"
            
            #END add-point
 
 
         #----<<b_stje020_desc>>----
         #----<<b_stje021>>----
         #Ctrlp:construct.c.filter.page1.b_stje021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje021
            #add-point:ON ACTION controlp INFIELD b_stje021 name="construct.c.filter.page1.b_stje021"
            
            #END add-point
 
 
         #----<<b_stje021_desc>>----
         #----<<b_stjm003>>----
         #Ctrlp:construct.c.filter.page1.b_stjm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm003
            #add-point:ON ACTION controlp INFIELD b_stjm003 name="construct.c.filter.page1.b_stjm003"
            
            #END add-point
 
 
         #----<<b_stjm003_desc>>----
         #----<<l_bdate_1>>----
         #----<<l_edate_1>>----
         #----<<l_day>>----
         #----<<b_stjm007>>----
         #Ctrlp:construct.c.filter.page1.b_stjm007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm007
            #add-point:ON ACTION controlp INFIELD b_stjm007 name="construct.c.filter.page1.b_stjm007"
            
            #END add-point
 
 
         #----<<b_stjm008>>----
         #Ctrlp:construct.c.filter.page1.b_stjm008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm008
            #add-point:ON ACTION controlp INFIELD b_stjm008 name="construct.c.filter.page1.b_stjm008"
            
            #END add-point
 
 
         #----<<b_stjm010>>----
         #Ctrlp:construct.c.filter.page1.b_stjm010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm010
            #add-point:ON ACTION controlp INFIELD b_stjm010 name="construct.c.filter.page1.b_stjm010"
            
            #END add-point
 
 
         #----<<b_stjm009>>----
         #Ctrlp:construct.c.filter.page1.b_stjm009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm009
            #add-point:ON ACTION controlp INFIELD b_stjm009 name="construct.c.filter.page1.b_stjm009"
            
            #END add-point
 
 
         #----<<b_stjm011>>----
         #Ctrlp:construct.c.filter.page1.b_stjm011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm011
            #add-point:ON ACTION controlp INFIELD b_stjm011 name="construct.c.filter.page1.b_stjm011"
            
            #END add-point
 
 
         #----<<b_stjm012>>----
         #Ctrlp:construct.c.filter.page1.b_stjm012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm012
            #add-point:ON ACTION controlp INFIELD b_stjm012 name="construct.c.filter.page1.b_stjm012"
            
            #END add-point
 
 
         #----<<b_stjm013>>----
         #Ctrlp:construct.c.filter.page1.b_stjm013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm013
            #add-point:ON ACTION controlp INFIELD b_stjm013 name="construct.c.filter.page1.b_stjm013"
            
            #END add-point
 
 
         #----<<l_percent>>----
 
 
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
 
 
 
 
 
   
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL astq821_filter_show('stjesite','b_stjesite')
   CALL astq821_filter_show('stje007','b_stje007')
   CALL astq821_filter_show('stje008','b_stje008')
   CALL astq821_filter_show('stje028','b_stje028')
   CALL astq821_filter_show('stje029','b_stje029')
   CALL astq821_filter_show('stje019','b_stje019')
   CALL astq821_filter_show('stje020','b_stje020')
   CALL astq821_filter_show('stje021','b_stje021')
   CALL astq821_filter_show('stjm003','b_stjm003')
   CALL astq821_filter_show('stjm007','b_stjm007')
   CALL astq821_filter_show('stjm008','b_stjm008')
   CALL astq821_filter_show('stjm010','b_stjm010')
   CALL astq821_filter_show('stjm009','b_stjm009')
   CALL astq821_filter_show('stjm011','b_stjm011')
   CALL astq821_filter_show('stjm012','b_stjm012')
   CALL astq821_filter_show('stjm013','b_stjm013')
 
 
   CALL astq821_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="astq821.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION astq821_filter_parser(ps_field)
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
 
{<section id="astq821.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION astq821_filter_show(ps_field,ps_object)
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
   LET ls_condition = astq821_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="astq821.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION astq821_detail_action_trans()
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
 
{<section id="astq821.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION astq821_detail_index_setting()
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
            IF g_stje_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_stje_d.getLength() AND g_stje_d.getLength() > 0
            LET g_detail_idx = g_stje_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_stje_d.getLength() THEN
               LET g_detail_idx = g_stje_d.getLength()
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
 
{<section id="astq821.mask_functions" >}
 &include "erp/ast/astq821_mask.4gl"
 
{</section>}
 
{<section id="astq821.other_function" readonly="Y" >}

PRIVATE FUNCTION astq821_create_temp()
   DEFINE r_success         LIKE type_t.num5
   
   LET r_success = TRUE
   
   DROP TABLE astq821_temp
   
   CREATE TEMP TABLE astq821_temp(
      stjeent        SMALLINT,  
      stjesite       VARCHAR(10), 
      stje007        VARCHAR(10), 
      stje008        VARCHAR(20), 
      stje028        VARCHAR(10), 
      stje029        VARCHAR(10), 
      stje019        VARCHAR(10), 
      stje020        VARCHAR(10), 
      stje021        VARCHAR(10), 
      stjm003        VARCHAR(10), 
      sum_stjm007    DECIMAL(20,6), 
      sum_stjm008    DECIMAL(20,6), 
      sum_stjm010    DECIMAL(20,6), 
      sum_stjm009    DECIMAL(20,6), 
      stjm011        DECIMAL(20,6), 
      stjm012        DECIMAL(20,6), 
      stjm013        DECIMAL(20,6), 
      l_percent      DECIMAL(20,6),
      l_per          DECIMAL(20,6)     ##add by zhangnan 用于计算汇总比例
      )     
              
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create Temp Table astq821_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION astq821_drop_temp()
   DEFINE r_success LIKE type_t.num5
   
   LET r_success = TRUE
   
   DROP TABLE astq821_temp
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'DROP Temp Table astq821_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查是否勾選一個維度以上(至少需要勾選一個維度)
# Memo...........:
# Usage..........: CALL astq821_flag_chk()
#                  RETURNING r_success
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 20160527 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION astq821_flag_chk()
   DEFINE r_success LIKE type_t.num5
   
   LET r_success = FALSE
   
   #至少必須勾選一個
   IF g_stjesite_flag = 'Y' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   IF g_stje007_flag = 'Y' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   IF g_stje008_flag = 'Y' THEN
      LET r_success  = TRUE
      RETURN r_success
   END IF
   IF g_stje028_flag = 'Y' THEN
      LET r_success  = TRUE
      RETURN r_success
   END IF
   IF g_stje029_flag = 'Y' THEN
      LET r_success  = TRUE
      RETURN r_success
   END IF
   IF g_stje019_flag = 'Y' THEN
      LET r_success  = TRUE
      RETURN r_success
   END IF
   IF g_stje020_flag = 'Y' THEN
      LET r_success  = TRUE
      RETURN r_success
   END IF
   IF g_stje021_flag = 'Y' THEN
      LET r_success  = TRUE
      RETURN r_success
   END IF
               
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION astq821_set_comp_visible()
   CALL cl_set_comp_visible("b_stjesite,b_stjesite_desc", TRUE)   
   CALL cl_set_comp_visible("b_stje007,b_stje007_desc,b_stje007_desc_desc", TRUE)   
   CALL cl_set_comp_visible("b_stje008,b_stje008_desc,b_stje025,l_sell_area,l_rank_1", TRUE)
   CALL cl_set_comp_visible("b_stje019,b_stje019_desc", TRUE)
   CALL cl_set_comp_visible("b_stje020,b_stje020_desc", TRUE)
   CALL cl_set_comp_visible("b_stje021,b_stje021_desc", TRUE)
   CALL cl_set_comp_visible("b_stje028,b_stje028_desc", TRUE)
   CALL cl_set_comp_visible("b_stje029,b_stje029_desc", TRUE) 
END FUNCTION

PRIVATE FUNCTION astq821_set_comp_no_visible()
   IF g_stjesite_flag = 'N' THEN
      CALL cl_set_comp_visible("b_stjesite,b_stjesite_desc", FALSE)   
   END IF
   IF g_stje007_flag = 'N' THEN
      CALL cl_set_comp_visible("b_stje007,b_stje007_desc,b_stje007_desc_desc", FALSE)   
   END IF
   IF g_stje008_flag = 'N' THEN
      CALL cl_set_comp_visible("b_stje008,b_stje008_desc,b_stje025,l_sell_area,l_rank_1", FALSE)
   END IF
   IF g_stje019_flag = 'N' THEN
      CALL cl_set_comp_visible("b_stje019,b_stje019_desc", FALSE)
   END IF
   IF g_stje020_flag = 'N' THEN
      CALL cl_set_comp_visible("b_stje020,b_stje020_desc", FALSE)
   END IF
   IF g_stje021_flag = 'N' THEN
      CALL cl_set_comp_visible("b_stje021,b_stje021_desc", FALSE)
   END IF
   IF g_stje028_flag = 'N' THEN
      CALL cl_set_comp_visible("b_stje028,b_stje028_desc", FALSE) 
   END IF
   IF g_stje029_flag = 'N' THEN
      CALL cl_set_comp_visible("b_stje029,b_stje029_desc", FALSE) 
   END IF
END FUNCTION

 
{</section>}
 
