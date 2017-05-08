#該程式未解開Section, 採用最新樣板產出!
{<section id="ainq808.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-01-12 10:34:36), PR版次:0002(2016-10-19 17:22:17)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000033
#+ Filename...: ainq808
#+ Description: 盤點盈虧查詢
#+ Creator....: 01251(2015-12-30 15:31:01)
#+ Modifier...: 01251 -SD/PR- 06814
 
{</section>}
 
{<section id="ainq808.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#161006-00008#9 2016/10/19 By 06814            補上aooi500相關邏輯
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
PRIVATE TYPE type_g_ineg_d RECORD
       
       inegsite LIKE ineg_t.inegsite, 
   inegsite_desc LIKE type_t.chr500, 
   ineg002 LIKE type_t.chr500, 
   ineg002_desc LIKE type_t.chr500, 
   ineg003 LIKE ineg_t.ineg003, 
   inegdocno LIKE type_t.chr500, 
   inegdocdt LIKE ineg_t.inegdocdt, 
   rtaw001 LIKE rtaw_t.rtaw001, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_desc LIKE type_t.chr500, 
   ineh001 LIKE ineh_t.ineh001, 
   ineh001_desc LIKE type_t.chr500, 
   ineh008 LIKE ineh_t.ineh008, 
   ineh006 LIKE ineh_t.ineh006, 
   imaf153 LIKE imaf_t.imaf153, 
   imaf153_desc LIKE type_t.chr500, 
   ineh015 LIKE ineh_t.ineh015, 
   inee003 LIKE inee_t.inee003, 
   inei011 LIKE inei_t.inei011, 
   l_ineh015a LIKE type_t.num20_6, 
   l_ineh015b LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_ineg2_d RECORD
       inegsite LIKE ineg_t.inegsite, 
   ineg003 LIKE ineg_t.ineg003, 
   rtaw001 LIKE rtaw_t.rtaw001, 
   rtaw001_2_desc LIKE type_t.chr500, 
   l_sum_amt1 LIKE type_t.num20_6, 
   l_sum_amt2 LIKE type_t.num20_6, 
   l_sum_amt3 LIKE type_t.num20_6, 
   l_yucost_2 LIKE type_t.num20_6, 
   l_shicost_2 LIKE type_t.num20_6, 
   l_yingkuicost_2 LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_ineg3_d RECORD
       inegsite LIKE ineg_t.inegsite, 
   rtaw001 LIKE rtaw_t.rtaw001, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_1_desc LIKE type_t.chr500, 
   ineh001 LIKE ineh_t.ineh001, 
   ineh001_3_desc LIKE type_t.chr500, 
   ineh002 LIKE ineh_t.ineh002, 
   ineh008 LIKE ineh_t.ineh008, 
   l_inef010_3 LIKE type_t.num20_6, 
   l_yucost_3 LIKE type_t.num20_6, 
   l_ineh009_3 LIKE type_t.num20_6, 
   l_shicost_3 LIKE type_t.num20_6, 
   l_ineh015_3 LIKE type_t.num20_6, 
   l_yingkuicost LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_ineg4_d RECORD
       inegsite LIKE ineg_t.inegsite, 
   ineg003 LIKE ineg_t.ineg003, 
   inegdocdt LIKE ineg_t.inegdocdt, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_4_desc LIKE type_t.chr500, 
   l_ineh015_4 LIKE type_t.num20_6, 
   l_ygsum LIKE type_t.num20_6, 
   l_yigkuicost_4 LIKE type_t.num20_6
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_table1      STRING
DEFINE l_sdate          LIKE ineg_t.ineg003
DEFINE l_edate          LIKE ineg_t.ineg003
DEFINE l_sdate_1        LIKE ineg_t.ineg003
DEFINE l_edate_1        LIKE ineg_t.ineg003
DEFINE inegsite         LIKE ineg_t.inegsite
DEFINE inei009          LIKE inei_t.inei009
DEFINE inei012          LIKE inei_t.inei012
DEFINE check_1          STRING
DEFINE check_2          STRING
 TYPE type_g_tm     RECORD
             l_sdate      LIKE type_t.dat,
             l_edate      LIKE type_t.dat,
             l_sdate_1    LIKE type_t.dat,
             l_edate_1    LIKE type_t.dat,
             inegsite     STRING,
             rtaw001      STRING,
             rtax001      STRING,
             imaf153      STRING,
             inei005      STRING,
             ineh006      STRING,
             ineh001      STRING,
             ineh002      STRING,
             inei009      STRING,
             inei012      STRING
                          END RECORD
DEFINE g_tm        type_g_tm                          
DEFINE g_wct       STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_ineg_d            DYNAMIC ARRAY OF type_g_ineg_d
DEFINE g_ineg_d_t          type_g_ineg_d
DEFINE g_ineg2_d     DYNAMIC ARRAY OF type_g_ineg2_d
DEFINE g_ineg2_d_t   type_g_ineg2_d
 
DEFINE g_ineg3_d     DYNAMIC ARRAY OF type_g_ineg3_d
DEFINE g_ineg3_d_t   type_g_ineg3_d
 
DEFINE g_ineg4_d     DYNAMIC ARRAY OF type_g_ineg4_d
DEFINE g_ineg4_d_t   type_g_ineg4_d
 
 
 
 
 
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
 
{<section id="ainq808.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #161006-00008#9 20161019 add by beckxie
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
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
   DECLARE ainq808_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE ainq808_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ainq808_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainq808 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ainq808_init()   
 
      #進入選單 Menu (="N")
      CALL ainq808_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ainq808
      
   END IF 
   
   CLOSE ainq808_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #161006-00008#9 20161019 add by beckxie
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="ainq808.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION ainq808_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #161006-00008#9 20161019 add by beckxie
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
 
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #161006-00008#9 20161019 add by beckxie
   #end add-point
 
   CALL ainq808_default_search()
END FUNCTION
 
{</section>}
 
{<section id="ainq808.default_search" >}
PRIVATE FUNCTION ainq808_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " inegsite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " inegdocno = '", g_argv[02], "' AND "
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
 
{<section id="ainq808.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainq808_ui_dialog() 
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

   LET g_tm.inegsite=g_site
   LET g_tm.l_sdate = g_today            
   LET g_tm.l_edate = g_today            
   LET g_tm.l_sdate_1 = g_today           
   LET g_tm.l_edate_1 = g_today
   #end add-point
 
   
   CALL ainq808_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_ineg_d.clear()
         CALL g_ineg2_d.clear()
 
         CALL g_ineg3_d.clear()
 
         CALL g_ineg4_d.clear()
 
 
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
 
         CALL ainq808_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT l_sdate,l_edate,l_sdate_1,l_edate_1,inei009,inei012,check_1,check_2  
          FROM l_sdate,l_edate,l_sdate_1,l_edate_1,inei009,inei012,check_1,check_2
         
               AFTER FIELD l_sdate
                     LET g_tm.l_sdate   = l_sdate
                     LET g_tm.l_sdate_1 = l_sdate
                     LET l_sdate_1 = l_sdate
                     DISPLAY BY NAME l_edate_1
               AFTER FIELD l_edate
                     LET g_tm.l_edate   = l_edate
                     LET g_tm.l_edate_1 = l_edate
                     LET l_edate_1 = l_edate
                     DISPLAY BY NAME l_edate_1
         
               AFTER FIELD l_sdate_1
                     LET g_tm.l_sdate_1 = l_sdate_1
                     
               AFTER FIELD l_edate_1
                     LET g_tm.l_edate_1 = l_edate_1
         
         
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT g_wc_table1 ON inegsite,rtaw001,imaf153,inei005,ineh001,ineh002,rtax001,ineh006
                             FROM inegsite,rtaw001,imaf153,inei005,ineh001,ineh002,rtax001,ineh006
               
         
           BEFORE CONSTRUCT 
              
             ON ACTION controlp INFIELD inegsite    #门店编号开窗
                #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c' 
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.where  = s_aooi500_q_where(g_prog,'inegsite',g_site,'c')
                CALL q_ooef001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO inefsite     #顯示到畫面上
                NEXT FIELD inegsite                       #返回原欄位 
         
             ON ACTION controlp INFIELD imaf153
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c' 
                LET g_qryparam.reqry = FALSE
                CALL q_pmaa001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO imaf153      #顯示到畫面上
                NEXT FIELD imaf153                         #返回原欄位
                    
             ON ACTION controlp INFIELD ineh001
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c' 
                LET g_qryparam.reqry = FALSE
                CALL q_rtdx001_6()                         #呼叫開窗
                DISPLAY g_qryparam.return1 TO ineh001      #顯示到畫面上
                NEXT FIELD ineh001                         #返回原欄位
         
             ON ACTION controlp INFIELD ineh002
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c' 
                LET g_qryparam.reqry = FALSE
                CALL q_imaa014()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO ineh002      #顯示到畫面上
                NEXT FIELD ineh002                         #返回原欄位
                
             ON ACTION controlp INFIELD rtaw001
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
		    	   LET g_qryparam.reqry = FALSE
		    	   LET g_qryparam.where = " rtax004 ='",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"
                CALL q_rtax001()                             #呼叫開窗
                DISPLAY g_qryparam.return1 TO rtaw001      #顯示到畫面上
                NEXT FIELD rtaw001                         #返回原欄位      
         
             ON ACTION controlp INFIELD inei005
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c' 
                LET g_qryparam.reqry = FALSE
                CALL q_inaa001_12()                        #呼叫開窗
                DISPLAY g_qryparam.return1 TO inei005    #顯示到畫面上
                NEXT FIELD inei005                       #返回原欄位   
              
             ON ACTION controlp INFIELD rtax001
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c' 
                LET g_qryparam.reqry = FALSE
                CALL q_rtax001()                                     #呼叫開窗
                DISPLAY g_qryparam.return1 TO rtax001  #顯示到畫面上
                NEXT FIELD rtax001                     #返回原欄位
            
            
            
             AFTER FIELD inegsite
                   CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.inegsite
             AFTER FIELD rtaw001
                   CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.rtaw001
             AFTER FIELD imaf153
                   CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.imaf153
             AFTER FIELD inei005
                   CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.inei005
             AFTER FIELD ineh001
                   CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.ineh001
             AFTER FIELD ineh002
                   CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.ineh002
             AFTER FIELD rtax001
                   CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.rtax001
             AFTER FIELD ineh006
                   CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.ineh006
          END CONSTRUCT 
      
         #end add-point
     
         DISPLAY ARRAY g_ineg_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL ainq808_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL ainq808_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_ineg2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_ineg3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 3
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_ineg4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 4
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body4.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_4)
            
 
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL ainq808_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
  
            LET check_1 ='Y'
            LET check_2 ='N'
                        
            IF cl_null(g_tm.inegsite) THEN
               LET g_tm.inegsite=g_site
            END IF
            DISPLAY BY NAME g_tm.*
            
            IF cl_null(g_tm.l_sdate) THEN
               LET l_sdate = g_today
            ELSE 
               LET l_sdate = g_tm.l_sdate
            END IF
            
            IF cl_null(g_tm.l_edate) THEN
               LET l_edate = g_today
            ELSE 
               LET l_edate = g_tm.l_edate
            END IF
            
            IF cl_null(g_tm.l_sdate_1) THEN
               LET l_sdate_1 = g_today
            ELSE 
               LET l_sdate_1 = g_tm.l_sdate_1
            END IF
            
            IF cl_null(g_tm.l_edate_1) THEN
               LET l_edate_1 = g_today
            ELSE 
               LET l_edate_1 = g_tm.l_edate_1
            END IF
            
            DISPLAY BY NAME l_sdate,l_edate,l_sdate_1,l_edate_1,inei009,inei012,check_1,check_2
            #end add-point
            NEXT FIELD l_sdate
 
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
            
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL ainq808_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_ineg_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_ineg2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_ineg3_d)
               LET g_export_id[3]   = "s_detail3"
 
               LET g_export_node[4] = base.typeInfo.create(g_ineg4_d)
               LET g_export_id[4]   = "s_detail4"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL ainq808_b_fill()
 
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
            CALL ainq808_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL ainq808_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL ainq808_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL ainq808_b_fill()
 
         
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL ainq808_filter()
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
 
{<section id="ainq808.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ainq808_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING   #161006-00008#9 20161019 add by beckxie
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #成本仓和非成本仓的查询条件  
   IF check_1 ='Y' AND check_2 <>'Y' THEN
      LET g_wct = " inaa010='Y' "  
   END IF
   
   IF check_2 ='Y' AND check_1 <>'Y' THEN
      LET g_wct = " inaa010='N' "  
   END IF
   
   IF check_2 ='Y' AND check_1 ='Y' THEN
      LET g_wct = " ( inaa010='Y' OR inaa010='N' ) "
      # LET g_wct = " inaa010='1=1' "  
   END IF
   
   IF check_2 <>'Y' AND check_1 <>'Y' THEN
      LET g_wct = " inaa010='1=2'"
   END IF
   
   IF cl_null(g_wct) THEN
      LET g_wct=' 1=1'
   END IF
   IF cl_null(g_wc_table1) THEN
      LET g_wc_table1=' 1=1'
   END IF   
   
   LET g_wc = g_wc_table1 
   
   CALL s_aooi500_sql_where(g_prog,'inegsite') RETURNING l_where   #161006-00008#9 20161019 add by beckxie
        
   LET g_wc2 = " 1=1"
         
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
 
   CALL g_ineg_d.clear()
   CALL g_ineg2_d.clear()
 
   CALL g_ineg3_d.clear()
 
   CALL g_ineg4_d.clear()
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET ls_wc = ls_wc CLIPPED," AND ",l_where
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE inegsite,'','','',ineg003,'',inegdocdt,'','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','',''  ,DENSE_RANK() OVER( ORDER BY ineg_t.inegsite,ineg_t.inegdocno) AS RANK FROM ineg_t", 
 
 
 
                     "",
                     " WHERE inegent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("ineg_t"),
                     " ORDER BY ineg_t.inegsite,ineg_t.inegdocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_sql_rank = "SELECT inegsite,ooefl003,ineg002,inea001,ineg003,inegdocno,inegdocdt,rtaw001,imaa009,rtaxl003,ineh001, 
       imaal003,ineh008,ineh006,imaf153,pmaal003,inei009,inei011,inei012,DENSE_RANK() OVER( ORDER BY inegsite,inegdocno,ineh001) AS RANK ",
       "  FROM ineg_t", 

                     
                     
                     
                     "   LEFT JOIN ooefl_t ON inegsite = ooefl001  AND inegent = ooeflent AND ooefl002 = '",g_dlang ,"'",
                     "   LEFT JOIN inea_t  ON inegent = ineaent AND ineadocno = ineg002 ",                
                     "   ,ineh_t ",
                     "   LEFT JOIN imaal_t ON ineh001 = imaal001  AND inehent = imaalent  AND imaal002 = '",g_dlang ,"'", 
                     "   LEFT JOIN imaf_t  ON ineh001 = imaf001 AND inehent = imafent AND inehsite = imafsite  ",
                     "   LEFT JOIN imaa_t  ON ineh001 = imaa001 AND inehent = imaaent    ",
                     "   LEFT JOIN pmaal_t ON imaf153 = pmaal001 AND imafent =pmaalent AND pmaal002 = '",g_dlang ,"'",                                        
                     "   LEFT JOIN rtaxl_t ON imaa009 = rtaxl001 AND imaaent =rtaxlent AND rtaxl002 = '",g_dlang ,"'",
                     "   LEFT JOIN rtaw_t  ON rtawent = imaaent  AND rtaw002 = imaa009   AND rtaw003 = '3'",                     
                     "   LEFT JOIN rtax_t  ON rtaxent = imaaent AND rtax001=imaa009 ",
                     "   ,inei_t ",
                     "   LEFT JOIN inaa_t  ON inaaent=ineient AND inaasite=ineisite AND inaa001=inei005 ",
                     
                     " WHERE inegent=  ? ",                   
                     "   AND ineg003 BETWEEN to_date('",l_sdate,"','yy/mm/dd') AND to_date('",l_edate,"','yy/mm/dd')",  
                     "   AND inegdocdt BETWEEN to_date('",l_sdate_1,"','yy/mm/dd') AND to_date('",l_edate_1,"','yy/mm/dd')",                     
                     "   AND 1=1 AND ", ls_wc,
                     "   AND ", g_wct,
                     
                     "   AND ineg001 = '4' ",
                     "   AND inegent = inehent AND inegsite = inehsite AND inegdocno = inehdocno ",
                     "   AND inehent = ineient AND inehsite = ineisite AND inehdocno = ineidocno AND inehseq = ineiseq "
                     
                        
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("ineg_t"),
                     " ORDER BY ineg003,inegdocno,ineh001"
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
 
   LET g_sql = "SELECT inegsite,'','','',ineg003,'',inegdocdt,'','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT inegsite,ooefl003,ineg002,inea001,ineg003,inegdocno,inegdocdt,rtaw001,imaa009,rtaxl003,ineh001, 
          imaal003,ineh008,ineh006,imaf153,pmaal003,inei009,'',inei011,'',inei012  ",   #add by geza 20160316
       #imaal003,ineh008,ineh006,imaf153,pmaal003,inei009,'','',inei011,inei012  ",   #20150829 dongsz add '','' #mark by geza 20160316
               " FROM (",ls_sql_rank,")"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE ainq808_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ainq808_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_ineg_d[l_ac].inegsite,g_ineg_d[l_ac].inegsite_desc,g_ineg_d[l_ac].ineg002, 
       g_ineg_d[l_ac].ineg002_desc,g_ineg_d[l_ac].ineg003,g_ineg_d[l_ac].inegdocno,g_ineg_d[l_ac].inegdocdt, 
       g_ineg_d[l_ac].rtaw001,g_ineg_d[l_ac].imaa009,g_ineg_d[l_ac].imaa009_desc,g_ineg_d[l_ac].ineh001, 
       g_ineg_d[l_ac].ineh001_desc,g_ineg_d[l_ac].ineh008,g_ineg_d[l_ac].ineh006,g_ineg_d[l_ac].imaf153, 
       g_ineg_d[l_ac].imaf153_desc,g_ineg_d[l_ac].ineh015,g_ineg_d[l_ac].inee003,g_ineg_d[l_ac].inei011, 
       g_ineg_d[l_ac].l_ineh015a,g_ineg_d[l_ac].l_ineh015b,g_ineg2_d[l_ac].inegsite,g_ineg2_d[l_ac].ineg003, 
       g_ineg2_d[l_ac].rtaw001,g_ineg2_d[l_ac].rtaw001_2_desc,g_ineg2_d[l_ac].l_sum_amt1,g_ineg2_d[l_ac].l_sum_amt2, 
       g_ineg2_d[l_ac].l_sum_amt3,g_ineg2_d[l_ac].l_yucost_2,g_ineg2_d[l_ac].l_shicost_2,g_ineg2_d[l_ac].l_yingkuicost_2, 
       g_ineg3_d[l_ac].inegsite,g_ineg3_d[l_ac].rtaw001,g_ineg3_d[l_ac].imaa009,g_ineg3_d[l_ac].imaa009_1_desc, 
       g_ineg3_d[l_ac].ineh001,g_ineg3_d[l_ac].ineh001_3_desc,g_ineg3_d[l_ac].ineh002,g_ineg3_d[l_ac].ineh008, 
       g_ineg3_d[l_ac].l_inef010_3,g_ineg3_d[l_ac].l_yucost_3,g_ineg3_d[l_ac].l_ineh009_3,g_ineg3_d[l_ac].l_shicost_3, 
       g_ineg3_d[l_ac].l_ineh015_3,g_ineg3_d[l_ac].l_yingkuicost,g_ineg4_d[l_ac].inegsite,g_ineg4_d[l_ac].ineg003, 
       g_ineg4_d[l_ac].inegdocdt,g_ineg4_d[l_ac].imaa009,g_ineg4_d[l_ac].imaa009_4_desc,g_ineg4_d[l_ac].l_ineh015_4, 
       g_ineg4_d[l_ac].l_ygsum,g_ineg4_d[l_ac].l_yigkuicost_4
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #预估成本，预估盈亏金额
      SELECT inee003 INTO g_ineg_d[l_ac].inee003
        FROM inee_t
       WHERE ineeent = g_enterprise
         AND ineesite = g_ineg_d[l_ac].inegsite
         AND inee001 = g_ineg_d[l_ac].ineg002
         AND inee002 = g_ineg_d[l_ac].ineh001
         
      #预估盈亏金额
      LET g_ineg_d[l_ac].l_ineh015a= g_ineg_d[l_ac].inee003 * g_ineg_d[l_ac].ineh015

      LET g_max_rec = 10000000   
      
      
      #end add-point
 
      CALL ainq808_detail_show("'1'")
 
      CALL ainq808_ineg_t_mask()
 
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
   CALL ainq808_b2_fill(ls_wc) 
   CALL ainq808_b3_fill(ls_wc) 
   CALL ainq808_b4_fill(ls_wc) 
   #end add-point
 
   CALL g_ineg_d.deleteElement(g_ineg_d.getLength())
   CALL g_ineg2_d.deleteElement(g_ineg2_d.getLength())
 
   CALL g_ineg3_d.deleteElement(g_ineg3_d.getLength())
 
   CALL g_ineg4_d.deleteElement(g_ineg4_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_ineg_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE ainq808_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL ainq808_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL ainq808_detail_action_trans()
 
   LET l_ac = 1
   IF g_ineg_d.getLength() > 0 THEN
      CALL ainq808_b_fill2()
   END IF
 
      CALL ainq808_filter_show('inegsite','b_inegsite')
   CALL ainq808_filter_show('ineg003','b_ineg003')
   CALL ainq808_filter_show('inegdocdt','b_inegdocdt')
   CALL ainq808_filter_show('rtaw001','b_rtaw001')
   CALL ainq808_filter_show('imaa009','b_imaa009')
   CALL ainq808_filter_show('ineh001','b_ineh001')
   CALL ainq808_filter_show('ineh008','b_ineh008')
   CALL ainq808_filter_show('ineh006','b_ineh006')
   CALL ainq808_filter_show('imaf153','b_imaf153')
   CALL ainq808_filter_show('ineh015','b_ineh015')
   CALL ainq808_filter_show('inee003','b_inee003')
   CALL ainq808_filter_show('inei011','b_inei011')
 
 
END FUNCTION
 
{</section>}
 
{<section id="ainq808.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ainq808_b_fill2()
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
 
{<section id="ainq808.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION ainq808_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_ineg_d[l_ac].inegsite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_ineg_d[l_ac].inegsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg_d[l_ac].inegsite_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_d[l_ac].ineg002
            LET ls_sql = "SELECT inea001 FROM inea_t WHERE ineaent='"||g_enterprise||"' AND ineadocno=? "
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_ineg_d[l_ac].ineg002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg_d[l_ac].ineg002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_d[l_ac].imaa009
            LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_ineg_d[l_ac].imaa009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg_d[l_ac].imaa009_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_d[l_ac].ineh001
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_ineg_d[l_ac].ineh001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg_d[l_ac].ineh001_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_d[l_ac].imaf153
            LET ls_sql = "SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_ineg_d[l_ac].imaf153_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg_d[l_ac].imaf153_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg2_d[l_ac].rtaw001
            LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_ineg2_d[l_ac].rtaw001_2_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg2_d[l_ac].rtaw001_2_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg3_d[l_ac].imaa009
            LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_ineg3_d[l_ac].imaa009_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg3_d[l_ac].imaa009_1_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg3_d[l_ac].ineh001
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_ineg3_d[l_ac].ineh001_3_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg3_d[l_ac].ineh001_3_desc


      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'4'",1) > 0 THEN
      #帶出公用欄位reference值page4
      
 
      #add-point:show段單身reference name="detail_show.body4.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg4_d[l_ac].imaa009
            LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_ineg4_d[l_ac].imaa009_4_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg4_d[l_ac].imaa009_4_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainq808.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION ainq808_filter()
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
      CONSTRUCT g_wc_filter ON inegsite,ineg003,inegdocdt,rtaw001,imaa009,ineh001,ineh008,ineh006,imaf153, 
          ineh015,inee003,inei011
                          FROM s_detail1[1].b_inegsite,s_detail1[1].b_ineg003,s_detail1[1].b_inegdocdt, 
                              s_detail1[1].b_rtaw001,s_detail1[1].b_imaa009,s_detail1[1].b_ineh001,s_detail1[1].b_ineh008, 
                              s_detail1[1].b_ineh006,s_detail1[1].b_imaf153,s_detail1[1].b_ineh015,s_detail1[1].b_inee003, 
                              s_detail1[1].b_inei011
 
         BEFORE CONSTRUCT
                     DISPLAY ainq808_filter_parser('inegsite') TO s_detail1[1].b_inegsite
            DISPLAY ainq808_filter_parser('ineg003') TO s_detail1[1].b_ineg003
            DISPLAY ainq808_filter_parser('inegdocdt') TO s_detail1[1].b_inegdocdt
            DISPLAY ainq808_filter_parser('rtaw001') TO s_detail1[1].b_rtaw001
            DISPLAY ainq808_filter_parser('imaa009') TO s_detail1[1].b_imaa009
            DISPLAY ainq808_filter_parser('ineh001') TO s_detail1[1].b_ineh001
            DISPLAY ainq808_filter_parser('ineh008') TO s_detail1[1].b_ineh008
            DISPLAY ainq808_filter_parser('ineh006') TO s_detail1[1].b_ineh006
            DISPLAY ainq808_filter_parser('imaf153') TO s_detail1[1].b_imaf153
            DISPLAY ainq808_filter_parser('ineh015') TO s_detail1[1].b_ineh015
            DISPLAY ainq808_filter_parser('inee003') TO s_detail1[1].b_inee003
            DISPLAY ainq808_filter_parser('inei011') TO s_detail1[1].b_inei011
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<b_inegsite>>----
         #Ctrlp:construct.c.page1.b_inegsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_inegsite
            #add-point:ON ACTION controlp INFIELD b_inegsite name="construct.c.filter.page1.b_inegsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooed004_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inegsite  #顯示到畫面上
            NEXT FIELD b_inegsite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_inegsite_desc>>----
         #----<<b_ineg002>>----
         #----<<b_ineg002_desc>>----
         #----<<b_ineg003>>----
         #Ctrlp:construct.c.filter.page1.b_ineg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_ineg003
            #add-point:ON ACTION controlp INFIELD b_ineg003 name="construct.c.filter.page1.b_ineg003"
            
            #END add-point
 
 
         #----<<b_inegdocno>>----
         #----<<b_inegdocdt>>----
         #Ctrlp:construct.c.filter.page1.b_inegdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_inegdocdt
            #add-point:ON ACTION controlp INFIELD b_inegdocdt name="construct.c.filter.page1.b_inegdocdt"
            
            #END add-point
 
 
         #----<<b_rtaw001>>----
         #Ctrlp:construct.c.filter.page1.b_rtaw001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtaw001
            #add-point:ON ACTION controlp INFIELD b_rtaw001 name="construct.c.filter.page1.b_rtaw001"
            
            #END add-point
 
 
         #----<<b_imaa009>>----
         #Ctrlp:construct.c.page1.b_imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa009
            #add-point:ON ACTION controlp INFIELD b_imaa009 name="construct.c.filter.page1.b_imaa009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa009  #顯示到畫面上
            NEXT FIELD b_imaa009                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa009_desc>>----
         #----<<b_ineh001>>----
         #Ctrlp:construct.c.page1.b_ineh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_ineh001
            #add-point:ON ACTION controlp INFIELD b_ineh001 name="construct.c.filter.page1.b_ineh001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtdx001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_ineh001  #顯示到畫面上
            NEXT FIELD b_ineh001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_ineh001_desc>>----
         #----<<b_ineh008>>----
         #Ctrlp:construct.c.page1.b_ineh008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_ineh008
            #add-point:ON ACTION controlp INFIELD b_ineh008 name="construct.c.filter.page1.b_ineh008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_ineh008  #顯示到畫面上
            NEXT FIELD b_ineh008                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_ineh006>>----
         #Ctrlp:construct.c.filter.page1.b_ineh006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_ineh006
            #add-point:ON ACTION controlp INFIELD b_ineh006 name="construct.c.filter.page1.b_ineh006"
            
            #END add-point
 
 
         #----<<b_imaf153>>----
         #Ctrlp:construct.c.page1.b_imaf153
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf153
            #add-point:ON ACTION controlp INFIELD b_imaf153 name="construct.c.filter.page1.b_imaf153"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaf153  #顯示到畫面上
            NEXT FIELD b_imaf153                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaf153_desc>>----
         #----<<b_ineh015>>----
         #Ctrlp:construct.c.filter.page1.b_ineh015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_ineh015
            #add-point:ON ACTION controlp INFIELD b_ineh015 name="construct.c.filter.page1.b_ineh015"
            
            #END add-point
 
 
         #----<<b_inee003>>----
         #Ctrlp:construct.c.filter.page1.b_inee003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_inee003
            #add-point:ON ACTION controlp INFIELD b_inee003 name="construct.c.filter.page1.b_inee003"
            
            #END add-point
 
 
         #----<<b_inei011>>----
         #Ctrlp:construct.c.filter.page1.b_inei011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_inei011
            #add-point:ON ACTION controlp INFIELD b_inei011 name="construct.c.filter.page1.b_inei011"
            
            #END add-point
 
 
         #----<<l_ineh015a>>----
         #----<<l_ineh015b>>----
         #----<<b_inegsite_2>>----
         #----<<b_ineg003_2>>----
         #----<<b_rtaw001_2>>----
         #----<<b_rtaw001_2_desc>>----
         #----<<l_sum_amt1>>----
         #----<<l_sum_amt2>>----
         #----<<l_sum_amt3>>----
         #----<<l_yucost_2>>----
         #----<<l_shicost_2>>----
         #----<<l_yingkuicost_2>>----
         #----<<b_inegsite_3>>----
         #----<<b_rtaw001_3>>----
         #----<<b_imaa009_1>>----
         #----<<b_imaa009_1_desc>>----
         #----<<b_ineh001_3>>----
         #----<<b_ineh001_3_desc>>----
         #----<<b_ineh002_3>>----
         #----<<b_ineh008_3>>----
         #----<<l_inef010_3>>----
         #----<<l_yucost_3>>----
         #----<<l_ineh009_3>>----
         #----<<l_shicost_3>>----
         #----<<l_ineh015_3>>----
         #----<<l_yingkuicost>>----
         #----<<b_inegsite_4>>----
         #----<<b_ineg003_4>>----
         #----<<b_inegdocdt_4>>----
         #----<<b_imaa009_4>>----
         #----<<b_imaa009_4_desc>>----
         #----<<l_ineh015_4>>----
         #----<<l_ygsum>>----
         #----<<l_yigkuicost_4>>----
 
 
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
 
      CALL ainq808_filter_show('inegsite','b_inegsite')
   CALL ainq808_filter_show('ineg003','b_ineg003')
   CALL ainq808_filter_show('inegdocdt','b_inegdocdt')
   CALL ainq808_filter_show('rtaw001','b_rtaw001')
   CALL ainq808_filter_show('imaa009','b_imaa009')
   CALL ainq808_filter_show('ineh001','b_ineh001')
   CALL ainq808_filter_show('ineh008','b_ineh008')
   CALL ainq808_filter_show('ineh006','b_ineh006')
   CALL ainq808_filter_show('imaf153','b_imaf153')
   CALL ainq808_filter_show('ineh015','b_ineh015')
   CALL ainq808_filter_show('inee003','b_inee003')
   CALL ainq808_filter_show('inei011','b_inei011')
 
 
   CALL ainq808_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="ainq808.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION ainq808_filter_parser(ps_field)
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
 
{<section id="ainq808.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION ainq808_filter_show(ps_field,ps_object)
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
   LET ls_condition = ainq808_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="ainq808.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION ainq808_detail_action_trans()
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
 
{<section id="ainq808.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION ainq808_detail_index_setting()
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
            IF g_ineg_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_ineg_d.getLength() AND g_ineg_d.getLength() > 0
            LET g_detail_idx = g_ineg_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_ineg_d.getLength() THEN
               LET g_detail_idx = g_ineg_d.getLength()
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
 
{<section id="ainq808.mask_functions" >}
 &include "erp/ain/ainq808_mask.4gl"
 
{</section>}
 
{<section id="ainq808.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: ainq808_b2_fill(p_wc)
# Input parameter: p_wc  查询条件
# Return code....: 
# Date & Author..: 20160105 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainq808_b2_fill(p_wc)
DEFINE p_wc            STRING
DEFINE l_sql           STRING
DEFINE ls_wc           STRING
DEFINE l_success       LIKE type_t.chr1
  
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET ls_wc = g_wc," AND ",g_wc_table1, " AND ", g_wc2, " AND ", g_wc_filter

   CALL g_ineg2_d.clear()
 
  
   
    LET l_sql = "SELECT DISTINCT inegsite,ineg003,rtaw001,rtaxl003,",
                     "  SUM(DISTINCT NVL(INEH014,0)* DECODE(rtdx051,NULL ,rtdx034,0,rtdx034,rtdx051)) - SUM(nvl(inei009, 0) * DECODE(rtdx051,NULL ,rtdx034,0,rtdx034,rtdx051)),",       # 盘点前预估金额
                     "  SUM(DISTINCT nvl(ineh014,0)* DECODE(rtdx051,NULL ,rtdx034,0,rtdx034,rtdx051)),",       # 盘点后预估金额
                     "  SUM(nvl(inei009, 0) * DECODE(rtdx051,NULL ,rtdx034,0,rtdx034,rtdx051)),", # 盘点预估盈亏金额
                     "  sum(DISTINCT NVL(INEH014, 0)* nvl(ineh016,0)) - SUM(nvl(inei009, 0) * nvl(ineh016,0)),",  # 盘点前库存成本金额
                     "  sum(DISTINCT NVL(INEH014, 0)* nvl(ineh016,0)) - SUM(nvl(inei009, 0) * nvl(ineh016,0))+sum(NVL(inei012,0)),",   # 盘点后库存成本金额
                     "  sum(nvl(inei012,0)) ",                                       # 盘点实际盈亏成本金额
                     "  FROM inee_t, ineg_t,ineh_t ",                                          
                     "   LEFT JOIN rtdx_t  ON rtdxent=inehent AND rtdxsite=inehsite AND rtdx001=ineh001 ",
                     
                     "   LEFT JOIN imaa_t  ON ineh001 = imaa001 AND inehent = imaaent    ",
                     
                     "   LEFT JOIN rtax_t  ON rtaxent = imaaent AND rtax001=imaa009 ",  
                     
                     "   LEFT JOIN rtaw_t  ON rtawent = imaaent AND rtaw002 = imaa009   AND rtaw003 = '3'",
                     "   LEFT JOIN rtaxl_t ON rtaw001 = rtaxl001 AND rtawent =rtaxlent AND rtaxl002 = '",g_dlang ,"'", 
                     "   LEFT JOIN imaf_t  ON ineh001 = imaf001 AND inehent = imafent AND inehsite = imafsite  ",                     
                     "   ,inei_t ",
                     "   LEFT JOIN inaa_t  ON inaaent=ineient AND inaasite=ineisite AND inaa001=inei005 ",
                     
                    
                     " WHERE inegent= ?  ",
                     "   AND ineg003 BETWEEN to_date('",l_sdate ,"','yy/mm/dd') AND to_date('",l_edate ,"','yy/mm/dd')",
                     "   AND inegdocdt BETWEEN to_date('",l_sdate_1,"','yy/mm/dd') AND to_date('",l_edate_1,"','yy/mm/dd')",                     
                     "   AND 1=1 AND ", ls_wc,
                     "   AND ", g_wct,
                     "   AND ineg001 = '4' ",
                     "   AND inegent = inehent AND inegsite = inehsite AND inegdocno = inehdocno ",
                     "   AND inehent = ineient AND inehsite = ineisite AND inehdocno = ineidocno AND inehseq = ineiseq ",
                     "   AND ineeent = inegent  AND ineesite = inegsite  AND inee001 = ineg002 AND inee002 = ineh001 ",
                     "   GROUP BY inegsite,ineg003,rtaw001,rtaxl003 ",
                     "   ORDER BY ineg_t.ineg003 "
   
  

   DISPLAY "l_sql:",l_sql
   
   PREPARE ainq808_bp2 FROM l_sql
   DECLARE b_fill_curs2 CURSOR FOR ainq808_bp2
   
   OPEN b_fill_curs2 USING g_enterprise
#   LET g_cnt = l_ac
#   IF g_cnt = 0 THEN
#      LET g_cnt = 1
#   END IF
   LET l_ac = 1   
 
  CALL g_ineg2_d.clear()

   FOREACH b_fill_curs2 INTO  g_ineg2_d[l_ac].inegsite,     g_ineg2_d[l_ac].ineg003,   g_ineg2_d[l_ac].rtaw001,
                              g_ineg2_d[l_ac].rtaw001_2_desc, g_ineg2_d[l_ac].l_sum_amt1,  g_ineg2_d[l_ac].l_sum_amt2,
                              g_ineg2_d[l_ac].l_sum_amt3, g_ineg2_d[l_ac].l_yucost_2,  g_ineg2_d[l_ac].l_shicost_2,
                              g_ineg2_d[l_ac].l_yingkuicost_2
                              
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
         
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
#   CALL g_ineg2_d.deleteElement(g_ineg2_d.getLength())   
 
#   LET l_ac = g_cnt
#   LET g_cnt = 0
   
   CLOSE b_fill_curs2
   FREE ainq808_bp2
   
#   DISPLAY ARRAY g_ineg2_d TO s_detail2.* ATTRIBUTES(COUNT=g_detail_cnt_2)
#      BEFORE DISPLAY
#         EXIT DISPLAY
#   END DISPLAY
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ainq808_b3_fill(p_wc)
# Input parameter: 
# Return code....: 
# Date & Author..: 20150105 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainq808_b3_fill(p_wc)
DEFINE p_wc            STRING
DEFINE l_sql           STRING
DEFINE ls_wc           STRING
DEFINE l_sql_t         STRING
DEFINE l_success       LIKE type_t.chr1
  
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET ls_wc = g_wc," AND ",g_wc_table1, " AND ", g_wc2, " AND ", g_wc_filter
   
   CALL g_ineg3_d.clear()
 
 
  
   LET l_sql = "SELECT DISTINCT inegsite,rtaw001,imaa009,rtaxl003,ineh001,imaal003,ineh002,ineh008, ", 
               "       SUM(DISTINCT NVL(INEH014,0))-sum(nvl(inei009,0)),",                   # 预盘数量
               "       SUM(DISTINCT NVL(INEH014, 0) * nvl(ineh016, 0)) - sum(nvl(inei009, 0) * nvl(ineh016, 0)),",         # 预盘成本金额
               "       SUM(DISTINCT NVL(INEH014,0)), ",              # 实盘数量
               "       SUM(DISTINCT NVL(INEH014, 0) * nvl(ineh016, 0)) - sum(nvl(inei009, 0) * nvl(ineh016, 0)) + SUM(NVL(inei012, 0)),",       # 实盘成本金额 = 预盘成本金额 + 盈亏成本金额 
               "       sum(nvl(inei009,0)),",               # 盈亏数量
               "       SUM(NVL(inei012,0)) ",               # 盈亏成本金额
               "  FROM ineg_t,inee_t, ineh_t ",

             
               "   LEFT JOIN imaal_t ON ineh001 = imaal001  AND inehent = imaalent  AND imaal002 = '",g_dlang ,"'", 
               "   LEFT JOIN imaa_t  ON ineh001 = imaa001 AND inehent = imaaent    ",                                      
               "   LEFT JOIN rtax_t  ON rtaxent = imaaent AND rtax001=imaa009 ",              
               "   LEFT JOIN rtaw_t  ON rtawent = imaaent AND rtaw002 = imaa009   AND rtaw003 = '3'",
               "   LEFT JOIN rtaxl_t ON imaa009 = rtaxl001 AND rtawent =rtaxlent AND rtaxl002 = '",g_dlang ,"'",
               "   LEFT JOIN imaf_t  ON ineh001 = imaf001 AND inehent = imafent AND inehsite = imafsite  ",               
               "   ,inei_t   ",
               "   LEFT JOIN inaa_t  ON inaaent=ineient AND inaasite=ineisite AND inaa001=inei005 ",
               
               " WHERE inegent= ?  ",
               "   AND ineg003 BETWEEN to_date('",l_sdate ,"','yy/mm/dd') AND to_date('",l_edate ,"','yy/mm/dd')", 
               "   AND inegdocdt BETWEEN to_date('",l_sdate_1,"','yy/mm/dd') AND to_date('",l_edate_1,"','yy/mm/dd')",               
               "   AND 1=1 AND ", ls_wc,
               "   AND ", g_wct,
               "   AND ineg001 = '4' ",
               "   AND inegent = inehent AND inegsite = inehsite AND inegdocno = inehdocno ",
               "   AND ineeent = inegent AND ineesite = inegsite  AND inee001 = ineg002 AND inee002 = ineh001 ",
               "   AND inehent = ineient AND inehsite = ineisite AND inehdocno = ineidocno AND inehseq = ineiseq ",     
               " GROUP BY inegsite,rtaw001,imaa009,rtaxl003,ineh001,imaal003,ineh002,ineh008 "
 

   DISPLAY "l_sql:",l_sql
   
   PREPARE ainq808_bp3 FROM l_sql
   DECLARE b_fill_curs3 CURSOR FOR ainq808_bp3
   
   OPEN b_fill_curs3 USING g_enterprise
#   LET g_cnt = l_ac
#   IF g_cnt = 0 THEN
#      LET g_cnt = 1
#   END IF
   LET l_ac = 1   
 
   CALL g_ineg3_d.clear()

   FOREACH b_fill_curs3 INTO  g_ineg3_d[l_ac].inegsite,  g_ineg3_d[l_ac].rtaw001,      g_ineg3_d[l_ac].imaa009,
                              g_ineg3_d[l_ac].imaa009_1_desc,
                              g_ineg3_d[l_ac].ineh001,   g_ineg3_d[l_ac].ineh001_3_desc, g_ineg3_d[l_ac].ineh002,
                              g_ineg3_d[l_ac].ineh008,   g_ineg3_d[l_ac].l_inef010_3,      
                              g_ineg3_d[l_ac].l_yucost_3,  g_ineg3_d[l_ac].l_ineh009_3,      
                              g_ineg3_d[l_ac].l_shicost_3,    g_ineg3_d[l_ac].l_ineh015_3,   
                              g_ineg3_d[l_ac].l_yingkuicost                             

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
         
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
#   CALL g_ineg3_d.deleteElement(g_ineg3_d.getLength())   
#   
#   LET l_ac = g_cnt
#   LET g_cnt = 0
   
   CLOSE b_fill_curs3
   FREE ainq808_bp3
   
#   DISPLAY ARRAY g_ineg3_d TO s_detail3.* ATTRIBUTES(COUNT=g_detail_cnt_3)
#      BEFORE DISPLAY
#         EXIT DISPLAY
#   END DISPLAY
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ainq808_b4_fill(p_wc)
# Input parameter: 
# Return code....: 
# Date & Author..: 20150105 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainq808_b4_fill(p_wc)
DEFINE p_wc            STRING
DEFINE l_sql           STRING
DEFINE ls_wc           STRING
DEFINE l_success       LIKE type_t.chr1
DEFINE l_rtaw003       LIKE rtaw_t.rtaw003   
  
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET ls_wc = g_wc," AND ",g_wc_table1, " AND ", g_wc2, " AND ", g_wc_filter
   
   CALL g_ineg4_d.clear()
 
   
   LET l_rtaw003 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')   

   
    LET l_sql = "SELECT  inegsite,ineg003,inegdocdt,imaa009,rtaxl003,sum(inei009),sum(inei009*inee003),sum(nvl(inei012,0)) ",    
                   "   FROM ineg_t,inee_t,ineh_t  ", 
   
                     
                     "   LEFT JOIN imaa_t  ON ineh001 = imaa001 AND inehent = imaaent    ",                    
                     "   LEFT JOIN rtax_t  ON rtaxent = imaaent AND rtax001=imaa009 ",                      
                     "   LEFT JOIN rtaw_t  ON rtawent = imaaent AND rtaw002 = imaa009   AND rtaw003 = '",l_rtaw003,"' ",  
                     "   LEFT JOIN rtaxl_t ON imaa009 = rtaxl001 AND imaaent =rtaxlent AND rtaxl002 = '",g_dlang ,"'",
                     "   LEFT JOIN imaf_t  ON ineh001 = imaf001 AND inehent = imafent AND inehsite = imafsite  ",                     
                     "   ,inei_t ",
                     "   LEFT JOIN inaa_t  ON inaaent=ineient AND inaasite=ineisite AND inaa001=inei005 ",
                     
                    
                     " WHERE inegent=  ? ",                   
                     "   AND ineg003 BETWEEN to_date('",l_sdate,"','yy/mm/dd') AND to_date('",l_edate,"','yy/mm/dd')", 
                     "   AND inegdocdt BETWEEN to_date('",l_sdate_1,"','yy/mm/dd') AND to_date('",l_edate_1,"','yy/mm/dd')",                     
                     "   AND 1=1 AND ", ls_wc,
                     "   AND ", g_wct,
                     "   AND ineg001 = '4' ",
                     "   AND inegent = inehent AND inegsite = inehsite AND inegdocno = inehdocno ",
                     "   AND ineeent = inegent  AND ineesite = inegsite  AND inee001 = ineg002 AND inee002 = ineh001 ",
                     "   AND inehent = ineient AND inehsite = ineisite AND inehdocno = ineidocno AND inehseq = ineiseq ",
               
                     " GROUP BY  inegsite,ineg003,inegdocdt,imaa009,rtaxl003 "

  
   
   DISPLAY "l_sql:",l_sql
   
   PREPARE ainq808_bp4 FROM l_sql
   DECLARE b_fill_curs4 CURSOR FOR ainq808_bp4
   
   OPEN b_fill_curs4 USING g_enterprise
#   LET g_cnt = l_ac
#   IF g_cnt = 0 THEN
#      LET g_cnt = 1
#   END IF
   LET l_ac = 1   
 
   CALL g_ineg4_d.clear()

   FOREACH b_fill_curs4 INTO  g_ineg4_d[l_ac].inegsite, g_ineg4_d[l_ac].ineg003,      g_ineg4_d[l_ac].inegdocdt,
                              g_ineg4_d[l_ac].imaa009,  g_ineg4_d[l_ac].imaa009_4_desc, g_ineg4_d[l_ac].l_ineh015_4,
                              g_ineg4_d[l_ac].l_ygsum,  g_ineg4_d[l_ac].l_yigkuicost_4 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
         
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
#   CALL g_ineg4_d.deleteElement(g_ineg4_d.getLength())   
#
#   LET l_ac = g_cnt
#   LET g_cnt = 0
   
   CLOSE b_fill_curs4
   FREE ainq808_bp4
   
#   DISPLAY ARRAY g_ineg4_d TO s_detail4.* ATTRIBUTES(COUNT=g_detail_cnt_4)
#      BEFORE DISPLAY
#         EXIT DISPLAY
#   END DISPLAY
   
END FUNCTION

 
{</section>}
 
