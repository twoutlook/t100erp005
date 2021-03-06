#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq402.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-12-30 11:23:56), PR版次:0001(2016-01-11 10:25:41)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: adeq402
#+ Description: 收銀員款別日報表
#+ Creator....: 06815(2015-12-29 10:53:31)
#+ Modifier...: 06815 -SD/PR- 06815
 
{</section>}
 
{<section id="adeq402.global" >}
#應用 q01 樣板自動產生(Version:34)
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
PRIVATE TYPE type_g_deag_d RECORD
       
       sel LIKE type_t.chr1, 
   deagsite LIKE deag_t.deagsite, 
   deagsite_desc LIKE type_t.chr500, 
   deagdocdt LIKE deag_t.deagdocdt, 
   deag004 LIKE deag_t.deag004, 
   deag004_desc LIKE type_t.chr500, 
   l_deaf00601 LIKE type_t.num20_6, 
   l_deaf00602 LIKE type_t.num20_6, 
   l_deaf00603 LIKE type_t.num20_6, 
   l_deaf00604 LIKE type_t.num20_6, 
   l_deaf00605 LIKE type_t.num20_6, 
   l_deaf00606 LIKE type_t.num20_6, 
   l_deaf00607 LIKE type_t.num20_6, 
   l_deaf00608 LIKE type_t.num20_6, 
   l_deaf00609 LIKE type_t.num20_6, 
   l_deaf00610 LIKE type_t.num20_6, 
   l_deaf00611 LIKE type_t.num20_6, 
   l_deaf00612 LIKE type_t.num20_6, 
   l_deaf00613 LIKE type_t.num20_6, 
   l_deaf00614 LIKE type_t.chr500, 
   l_deaf00615 LIKE type_t.chr500, 
   l_deaf00616 LIKE type_t.chr500, 
   l_deaf00617 LIKE type_t.chr500, 
   l_deaf00618 LIKE type_t.chr500, 
   l_deaf00619 LIKE type_t.chr500, 
   l_deaf00620 LIKE type_t.chr500, 
   l_deaf00621 LIKE type_t.chr500, 
   l_deaf00622 LIKE type_t.chr500, 
   l_deaf00623 LIKE type_t.chr500, 
   l_deaf00624 LIKE type_t.chr500, 
   l_deaf00625 LIKE type_t.chr500, 
   l_deaf00626 LIKE type_t.chr500, 
   l_deaf00627 LIKE type_t.chr500, 
   l_deaf00628 LIKE type_t.chr500, 
   l_deaf00629 LIKE type_t.chr500, 
   l_deaf00630 LIKE type_t.chr500, 
   deaf006 LIKE deaf_t.deaf006, 
   deaf007 LIKE deaf_t.deaf007, 
   l_lsmoney LIKE type_t.num20_6, 
   deagdocno LIKE deag_t.deagdocno
       END RECORD
PRIVATE TYPE type_g_deag2_d RECORD
       deagsite LIKE deag_t.deagsite, 
   deagsite_1_desc LIKE type_t.chr500, 
   deagdocdt LIKE deag_t.deagdocdt, 
   deag004 LIKE deag_t.deag004, 
   deag004_1_desc LIKE type_t.chr500, 
   deaf006 LIKE deaf_t.deaf006, 
   deaf007 LIKE deaf_t.deaf007, 
   l_lsmoney_1 LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_deag3_d RECORD
       deagdocdt LIKE deag_t.deagdocdt, 
   l_deaf006a01 LIKE type_t.num20_6, 
   l_deaf006a02 LIKE type_t.num20_6, 
   l_deaf006a03 LIKE type_t.num20_6, 
   l_deaf006a04 LIKE type_t.num20_6, 
   l_deaf006a05 LIKE type_t.num20_6, 
   l_deaf006a06 LIKE type_t.num20_6, 
   l_deaf006a07 LIKE type_t.num20_6, 
   l_deaf006a08 LIKE type_t.num20_6, 
   l_deaf006a09 LIKE type_t.num20_6, 
   l_deaf006a10 LIKE type_t.num20_6, 
   l_deaf006a11 LIKE type_t.num20_6, 
   l_deaf006a12 LIKE type_t.num20_6, 
   l_deaf006a13 LIKE type_t.num20_6, 
   l_deaf006a14 LIKE type_t.num20_6, 
   l_deaf006a15 LIKE type_t.num20_6, 
   l_deaf006a16 LIKE type_t.num20_6, 
   l_deaf006a17 LIKE type_t.num20_6, 
   l_deaf006a18 LIKE type_t.num20_6, 
   l_deaf006a19 LIKE type_t.num20_6, 
   l_deaf006a20 LIKE type_t.num20_6, 
   l_deaf006a21 LIKE type_t.num20_6, 
   l_deaf006a22 LIKE type_t.num20_6, 
   l_deaf006a23 LIKE type_t.num20_6, 
   l_deaf006a24 LIKE type_t.num20_6, 
   l_deaf006a25 LIKE type_t.num20_6, 
   l_deaf006a26 LIKE type_t.num20_6, 
   l_deaf006a27 LIKE type_t.num20_6, 
   l_deaf006a28 LIKE type_t.num20_6, 
   l_deaf006a29 LIKE type_t.num20_6, 
   l_deaf006a30 LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_deag4_d RECORD
       deag004 LIKE deag_t.deag004, 
   deag004_2_desc LIKE type_t.chr500, 
   l_type LIKE type_t.chr500, 
   l_sum LIKE type_t.num20_6, 
   deaf019 LIKE deaf_t.deaf019, 
   deaf007 LIKE deaf_t.deaf007, 
   deaf020 LIKE deaf_t.deaf020, 
   deaf015 LIKE deaf_t.deaf015, 
   deaf008 LIKE deaf_t.deaf008, 
   deaf009 LIKE deaf_t.deaf009, 
   deaf016 LIKE deaf_t.deaf016, 
   deaf017 LIKE deaf_t.deaf017, 
   deaf017_desc LIKE type_t.chr500, 
   deaf018 LIKE deaf_t.deaf018, 
   deaf010 LIKE deaf_t.deaf010
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_scc_sql STRING
DEFINE g_date1   LIKE deag_t.deagdocdt
DEFINE g_date2   LIKE deag_t.deagdocdt
DEFINE g_sql2    STRING
DEFINE g_sql3    STRING
DEFINE g_sql4    STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_deag_d            DYNAMIC ARRAY OF type_g_deag_d
DEFINE g_deag_d_t          type_g_deag_d
DEFINE g_deag2_d     DYNAMIC ARRAY OF type_g_deag2_d
DEFINE g_deag2_d_t   type_g_deag2_d
 
DEFINE g_deag3_d     DYNAMIC ARRAY OF type_g_deag3_d
DEFINE g_deag3_d_t   type_g_deag3_d
 
DEFINE g_deag4_d     DYNAMIC ARRAY OF type_g_deag4_d
DEFINE g_deag4_d_t   type_g_deag4_d
 
 
 
 
 
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
 
{<section id="adeq402.main" >}
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
   CALL cl_ap_init("ade","")
 
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
   DECLARE adeq402_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq402_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq402_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq402 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq402_init()   
 
      #進入選單 Menu (="N")
      CALL adeq402_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq402
      
   END IF 
   
   CLOSE adeq402_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq402.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adeq402_init()
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
   
      CALL cl_set_combo_scc('b_deaf009','6736') 
   CALL cl_set_combo_scc('b_deaf016','8310') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL adeq402_init_set()
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL cl_set_combo_scc('l_type','8310')
   #end add-point
 
   CALL adeq402_default_search()
END FUNCTION
 
{</section>}
 
{<section id="adeq402.default_search" >}
PRIVATE FUNCTION adeq402_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " deagdocno = '", g_argv[01], "' AND "
   END IF
 
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   LET g_wc = "1=1"
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq402.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adeq402_ui_dialog() 
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
   LET g_date1 = g_today-1
   LET g_date2 = g_today-1
   #end add-point
 
   
   CALL adeq402_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_deag_d.clear()
         CALL g_deag2_d.clear()
 
         CALL g_deag3_d.clear()
 
         CALL g_deag4_d.clear()
 
 
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
 
         CALL adeq402_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT g_date1,g_date2 FROM l_bdate,l_edate  ATTRIBUTE(WITHOUT DEFAULTS)         
         BEFORE INPUT 
             DISPLAY g_date1,g_date2
                  TO l_bdate,l_edate
          
         AFTER INPUT
         
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON deagsite,deag004
         
         ON ACTION controlp INFIELD deagsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE                        
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'deagsite',g_site,'c') 
            CALL q_ooef001_24()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO deagsite  #顯示到畫面上
            NEXT FIELD deagsite
      
         ON ACTION controlp INFIELD deag004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pcab001_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO deag004    #顯示到畫面上
            NEXT FIELD deag004                       #返回原欄位
      
         END CONSTRUCT      
         #end add-point
     
         DISPLAY ARRAY g_deag_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL adeq402_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq402_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_deag2_d TO s_detail2.*
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
 
         DISPLAY ARRAY g_deag3_d TO s_detail3.*
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
 
         DISPLAY ARRAY g_deag4_d TO s_detail4.*
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
            CALL adeq402_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            DISPLAY g_site TO deagsite
            CALL cl_set_act_visible("selall,selnone,sel,unsel,filter", FALSE) 
            CALL cl_set_comp_visible("sel", FALSE)  
            #end add-point
            NEXT FIELD deagsite
 
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
            CALL adeq402_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_deag_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_deag2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_deag3_d)
               LET g_export_id[3]   = "s_detail3"
 
               LET g_export_node[4] = base.typeInfo.create(g_deag4_d)
               LET g_export_id[4]   = "s_detail4"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL adeq402_b_fill()
 
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
            CALL adeq402_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq402_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq402_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq402_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_deag_d.getLength()
               LET g_deag_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_deag_d.getLength()
               LET g_deag_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_deag_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_deag_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_deag_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_deag_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL adeq402_filter()
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
 
{<section id="adeq402.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq402_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   DEFINE l_str           STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'deagsite') RETURNING l_where
   CALL adeq402_create_temp_table() 
   #LET g_wc = " 1=1"
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
 
   CALL g_deag_d.clear()
   CALL g_deag2_d.clear()
 
   CALL g_deag3_d.clear()
 
   CALL g_deag4_d.clear()
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   IF NOT cl_null(g_date1) THEN 
      LET l_str = " AND deagdocdt >= to_date('",g_date1 ,"','yy_mm_dd')"
   END IF 
   IF NOT cl_null(g_date2) THEN 
      IF cl_null(l_str) THEN 
         LET l_str = " AND deagdocdt <= to_date('",g_date2 ,"','yy_mm_dd')"
      ELSE
         LET l_str = l_str," AND deagdocdt <= to_date('",g_date2 ,"','yy_mm_dd')"
      END IF 
   END IF 
   
   LET ls_wc = ls_wc CLIPPED,l_str
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',deagsite,'',deagdocdt,deag004,'','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','',deagdocno,'','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY deag_t.deagdocno) AS RANK FROM deag_t", 
 
 
 
                     " LEFT JOIN deaf_t ON deagdocno = deafdocno AND",
                     " WHERE deagent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("deag_t"),
                     " ORDER BY deag_t.deagdocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
    LET ls_sql_rank = " SELECT  UNIQUE deagent,deagsite,ooefl003,deagdocdt,deag004,pcab003,deaf012,", g_scc_sql,
                      " SUM(deaf006) b,",
                      " SUM(deaf007) c,",
                      " SUM(deaf006)-SUM(deaf007) d, ",
                      " deaf019,deaf007,deaf020,deaf015,deaf008,deaf009,deaf016,deaf017,ooial003,deaf018,deaf010 ",
                      " FROM deaf_t ",
                      " LEFT JOIN ooial_t ON ooialent = deafent AND ooial001 = deaf017 AND ooial002= '",g_dlang,"'",
                      " ,deag_t ",
                      " LEFT JOIN ooefl_t ON ooeflent = deagent AND ooefl001 = deagsite AND ooefl002= '",g_dlang,"'",
                      " LEFT JOIN pcab_t ON pcabent = deagent AND pcab001 = deag004",
                      " WHERE deagent= '",g_enterprise,"' AND 1=1  AND ", ls_wc,
                      "   AND ",l_where,
                      "   AND deagent = deafent AND  deafdocno = deagdocno",
                      " GROUP BY deagent,deagsite,ooefl003,deagdocdt,deag004,pcab003,deaf012,deaf019,deaf007,deaf020,deaf015,deaf008,deaf009,deaf016,deaf017,ooial003,deaf018,deaf010 ",
                      " ORDER BY deagsite,deagdocdt,deag004 "
    
   LET ls_sql_rank = " INSERT INTO adeq402_tmp ",ls_sql_rank
 
   EXECUTE IMMEDIATE ls_sql_rank  
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ERROR:" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
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
 
   LET g_sql = "SELECT '',deagsite,'',deagdocdt,deag004,'','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','',deagdocno,'','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  UNIQUE '',deagsite,ooefl003,deagdocdt,deag004,pcab003,deaf00601,deaf00602,",
               " deaf00603,deaf00604,deaf00605,deaf00606,deaf00607,deaf00608,deaf00609,deaf00610, ",
               " deaf00611,deaf00612,deaf00613,deaf00614,deaf00615,deaf00616,deaf00617,deaf00618, ",
               " deaf00619,deaf00620,deaf00621,deaf00622,deaf00623,deaf00624,deaf00625,deaf00626, ",
               " deaf00627,deaf00628,deaf00629,deaf00630, ",
               " deaf006,deaf007,lsmoney,'',       ",            
               " '','','','','','','','',          ",
               " '','','','','','','','','','','', ",
               "    '','','','','','','','','','', ",
               "    '','','','','','','','','','', ",
               " '','','','', ",
               " '','','','','','','','','','',''  ",
               " FROM adeq402_tmp ",
               " WHERE deagent = ? ",
               " ORDER BY deagsite,deag004 "
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq402_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq402_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_deag_d[l_ac].sel,g_deag_d[l_ac].deagsite,g_deag_d[l_ac].deagsite_desc, 
       g_deag_d[l_ac].deagdocdt,g_deag_d[l_ac].deag004,g_deag_d[l_ac].deag004_desc,g_deag_d[l_ac].l_deaf00601, 
       g_deag_d[l_ac].l_deaf00602,g_deag_d[l_ac].l_deaf00603,g_deag_d[l_ac].l_deaf00604,g_deag_d[l_ac].l_deaf00605, 
       g_deag_d[l_ac].l_deaf00606,g_deag_d[l_ac].l_deaf00607,g_deag_d[l_ac].l_deaf00608,g_deag_d[l_ac].l_deaf00609, 
       g_deag_d[l_ac].l_deaf00610,g_deag_d[l_ac].l_deaf00611,g_deag_d[l_ac].l_deaf00612,g_deag_d[l_ac].l_deaf00613, 
       g_deag_d[l_ac].l_deaf00614,g_deag_d[l_ac].l_deaf00615,g_deag_d[l_ac].l_deaf00616,g_deag_d[l_ac].l_deaf00617, 
       g_deag_d[l_ac].l_deaf00618,g_deag_d[l_ac].l_deaf00619,g_deag_d[l_ac].l_deaf00620,g_deag_d[l_ac].l_deaf00621, 
       g_deag_d[l_ac].l_deaf00622,g_deag_d[l_ac].l_deaf00623,g_deag_d[l_ac].l_deaf00624,g_deag_d[l_ac].l_deaf00625, 
       g_deag_d[l_ac].l_deaf00626,g_deag_d[l_ac].l_deaf00627,g_deag_d[l_ac].l_deaf00628,g_deag_d[l_ac].l_deaf00629, 
       g_deag_d[l_ac].l_deaf00630,g_deag_d[l_ac].deaf006,g_deag_d[l_ac].deaf007,g_deag_d[l_ac].l_lsmoney, 
       g_deag_d[l_ac].deagdocno,g_deag2_d[l_ac].deagsite,g_deag2_d[l_ac].deagsite_1_desc,g_deag2_d[l_ac].deagdocdt, 
       g_deag2_d[l_ac].deag004,g_deag2_d[l_ac].deag004_1_desc,g_deag2_d[l_ac].deaf006,g_deag2_d[l_ac].deaf007, 
       g_deag2_d[l_ac].l_lsmoney_1,g_deag3_d[l_ac].deagdocdt,g_deag3_d[l_ac].l_deaf006a01,g_deag3_d[l_ac].l_deaf006a02, 
       g_deag3_d[l_ac].l_deaf006a03,g_deag3_d[l_ac].l_deaf006a04,g_deag3_d[l_ac].l_deaf006a05,g_deag3_d[l_ac].l_deaf006a06, 
       g_deag3_d[l_ac].l_deaf006a07,g_deag3_d[l_ac].l_deaf006a08,g_deag3_d[l_ac].l_deaf006a09,g_deag3_d[l_ac].l_deaf006a10, 
       g_deag3_d[l_ac].l_deaf006a11,g_deag3_d[l_ac].l_deaf006a12,g_deag3_d[l_ac].l_deaf006a13,g_deag3_d[l_ac].l_deaf006a14, 
       g_deag3_d[l_ac].l_deaf006a15,g_deag3_d[l_ac].l_deaf006a16,g_deag3_d[l_ac].l_deaf006a17,g_deag3_d[l_ac].l_deaf006a18, 
       g_deag3_d[l_ac].l_deaf006a19,g_deag3_d[l_ac].l_deaf006a20,g_deag3_d[l_ac].l_deaf006a21,g_deag3_d[l_ac].l_deaf006a22, 
       g_deag3_d[l_ac].l_deaf006a23,g_deag3_d[l_ac].l_deaf006a24,g_deag3_d[l_ac].l_deaf006a25,g_deag3_d[l_ac].l_deaf006a26, 
       g_deag3_d[l_ac].l_deaf006a27,g_deag3_d[l_ac].l_deaf006a28,g_deag3_d[l_ac].l_deaf006a29,g_deag3_d[l_ac].l_deaf006a30, 
       g_deag4_d[l_ac].deag004,g_deag4_d[l_ac].deag004_2_desc,g_deag4_d[l_ac].l_type,g_deag4_d[l_ac].l_sum, 
       g_deag4_d[l_ac].deaf019,g_deag4_d[l_ac].deaf007,g_deag4_d[l_ac].deaf020,g_deag4_d[l_ac].deaf015, 
       g_deag4_d[l_ac].deaf008,g_deag4_d[l_ac].deaf009,g_deag4_d[l_ac].deaf016,g_deag4_d[l_ac].deaf017, 
       g_deag4_d[l_ac].deaf017_desc,g_deag4_d[l_ac].deaf018,g_deag4_d[l_ac].deaf010
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
 
      CALL adeq402_detail_show("'1'")
 
      CALL adeq402_deag_t_mask()
 
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
   CALL adeq402_b2_fill()
   CALL adeq402_b3_fill()
   CALL adeq402_b4_fill()
   #end add-point
 
   CALL g_deag_d.deleteElement(g_deag_d.getLength())
   CALL g_deag2_d.deleteElement(g_deag2_d.getLength())
 
   CALL g_deag3_d.deleteElement(g_deag3_d.getLength())
 
   CALL g_deag4_d.deleteElement(g_deag4_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_deag_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE adeq402_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq402_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq402_detail_action_trans()
 
   LET l_ac = 1
   IF g_deag_d.getLength() > 0 THEN
      CALL adeq402_b_fill2()
   END IF
 
      CALL adeq402_filter_show('deagsite','b_deagsite')
   CALL adeq402_filter_show('deagdocdt','b_deagdocdt')
   CALL adeq402_filter_show('deag004','b_deag004')
   CALL adeq402_filter_show('deaf006','b_deaf006')
   CALL adeq402_filter_show('deaf007','b_deaf007')
   CALL adeq402_filter_show('deagdocno','b_deagdocno')
   CALL adeq402_filter_show('deaf019','b_deaf019')
   CALL adeq402_filter_show('deaf020','b_deaf020')
   CALL adeq402_filter_show('deaf015','b_deaf015')
   CALL adeq402_filter_show('deaf008','b_deaf008')
   CALL adeq402_filter_show('deaf009','b_deaf009')
   CALL adeq402_filter_show('deaf016','b_deaf016')
   CALL adeq402_filter_show('deaf017','b_deaf017')
   CALL adeq402_filter_show('deaf018','b_deaf018')
   CALL adeq402_filter_show('deaf010','b_deaf010')
 
 
END FUNCTION
 
{</section>}
 
{<section id="adeq402.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq402_b_fill2()
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
 
{<section id="adeq402.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq402_detail_show(ps_page)
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

      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_deag_d[l_ac].deagsite
      #LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_deag_d[l_ac].deagsite_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_deag_d[l_ac].deagsite_desc
      # 
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_deag_d[l_ac].deag004
      #LET ls_sql = "SELECT pcab003 FROM pcab_t WHERE pcabent='"||g_enterprise||"' AND pcab001=? "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_deag_d[l_ac].deag004_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_deag_d[l_ac].deag004_desc

      #INITIALIZE g_ref_fields TO NULL 
      #LET g_ref_fields[1] = .deagdocno
      #LET ls_sql = " SELECT deaf006_1,deaf007_1 FROM deaf_t WHERE deafent = '"||g_enterprise||"' AND "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields 
      #LET g_deag_d[l_ac].deaf006_1 = g_rtn_fields[1] 
      #LET g_deag_d[l_ac].deaf007_1 = g_rtn_fields[2] 
      #DISPLAY BY NAME g_deag_d[l_ac].deaf006_1,g_deag_d[l_ac].deaf007_1
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"

      # INITIALIZE g_ref_fields TO NULL
      # LET g_ref_fields[1] = g_deag2_d[l_ac].deagsite_1
      # LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
      # LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      # CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      # LET g_deag2_d[l_ac].deagsite_1_desc = '', g_rtn_fields[1] , ''
      # DISPLAY BY NAME g_deag2_d[l_ac].deagsite_1_desc
      #
      # INITIALIZE g_ref_fields TO NULL
      # LET g_ref_fields[1] = g_deag2_d[l_ac].deag004_1
      # LET ls_sql = "SELECT pcab003 FROM pcab_t WHERE pcabent='"||g_enterprise||"' AND pcab001=? "
      # LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      # CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      # LET g_deag2_d[l_ac].deag004_1_desc = '', g_rtn_fields[1] , ''
      # DISPLAY BY NAME g_deag2_d[l_ac].deag004_1_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'4'",1) > 0 THEN
      #帶出公用欄位reference值page4
      
 
      #add-point:show段單身reference name="detail_show.body4.reference"

      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_deag4_d[l_ac].deag004_2
      #LET ls_sql = "SELECT pcab003 FROM pcab_t WHERE pcabent='"||g_enterprise||"' AND pcab001=? "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_deag4_d[l_ac].deag004_2_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_deag4_d[l_ac].deag004_2_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq402.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION adeq402_filter()
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
      CONSTRUCT g_wc_filter ON deagsite,deagdocdt,deag004,deaf006,deaf007,deagdocno,deaf019,deaf020, 
          deaf015,deaf008,deaf009,deaf016,deaf017,deaf018,deaf010
                          FROM s_detail1[1].b_deagsite,s_detail1[1].b_deagdocdt,s_detail1[1].b_deag004, 
                              s_detail1[1].b_deaf006,s_detail1[1].b_deaf007,s_detail1[1].b_deagdocno, 
                              s_detail4[1].b_deaf019,s_detail4[1].b_deaf020,s_detail4[1].b_deaf015,s_detail4[1].b_deaf008, 
                              s_detail4[1].b_deaf009,s_detail4[1].b_deaf016,s_detail4[1].b_deaf017,s_detail4[1].b_deaf018, 
                              s_detail4[1].b_deaf010
 
         BEFORE CONSTRUCT
                     DISPLAY adeq402_filter_parser('deagsite') TO s_detail1[1].b_deagsite
            DISPLAY adeq402_filter_parser('deagdocdt') TO s_detail1[1].b_deagdocdt
            DISPLAY adeq402_filter_parser('deag004') TO s_detail1[1].b_deag004
            DISPLAY adeq402_filter_parser('deaf006') TO s_detail1[1].b_deaf006
            DISPLAY adeq402_filter_parser('deaf007') TO s_detail1[1].b_deaf007
            DISPLAY adeq402_filter_parser('deagdocno') TO s_detail1[1].b_deagdocno
            DISPLAY adeq402_filter_parser('deaf019') TO s_detail4[1].b_deaf019
            DISPLAY adeq402_filter_parser('deaf020') TO s_detail4[1].b_deaf020
            DISPLAY adeq402_filter_parser('deaf015') TO s_detail4[1].b_deaf015
            DISPLAY adeq402_filter_parser('deaf008') TO s_detail4[1].b_deaf008
            DISPLAY adeq402_filter_parser('deaf009') TO s_detail4[1].b_deaf009
            DISPLAY adeq402_filter_parser('deaf016') TO s_detail4[1].b_deaf016
            DISPLAY adeq402_filter_parser('deaf017') TO s_detail4[1].b_deaf017
            DISPLAY adeq402_filter_parser('deaf018') TO s_detail4[1].b_deaf018
            DISPLAY adeq402_filter_parser('deaf010') TO s_detail4[1].b_deaf010
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_deagsite>>----
         #Ctrlp:construct.c.page1.b_deagsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deagsite
            #add-point:ON ACTION controlp INFIELD b_deagsite name="construct.c.filter.page1.b_deagsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'deagsite',g_site,'c')             
            CALL q_ooef001_24()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deagsite  #顯示到畫面上
            NEXT FIELD b_deagsite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_deagsite_desc>>----
         #----<<b_deagdocdt>>----
         #Ctrlp:construct.c.filter.page1.b_deagdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deagdocdt
            #add-point:ON ACTION controlp INFIELD b_deagdocdt name="construct.c.filter.page1.b_deagdocdt"
            
            #END add-point
 
 
         #----<<b_deag004>>----
         #Ctrlp:construct.c.page1.b_deag004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deag004
            #add-point:ON ACTION controlp INFIELD b_deag004 name="construct.c.filter.page1.b_deag004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pcab001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deag004  #顯示到畫面上
            NEXT FIELD b_deag004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_deag004_desc>>----
         #----<<l_deaf00601>>----
         #----<<l_deaf00602>>----
         #----<<l_deaf00603>>----
         #----<<l_deaf00604>>----
         #----<<l_deaf00605>>----
         #----<<l_deaf00606>>----
         #----<<l_deaf00607>>----
         #----<<l_deaf00608>>----
         #----<<l_deaf00609>>----
         #----<<l_deaf00610>>----
         #----<<l_deaf00611>>----
         #----<<l_deaf00612>>----
         #----<<l_deaf00613>>----
         #----<<l_deaf00614>>----
         #----<<l_deaf00615>>----
         #----<<l_deaf00616>>----
         #----<<l_deaf00617>>----
         #----<<l_deaf00618>>----
         #----<<l_deaf00619>>----
         #----<<l_deaf00620>>----
         #----<<l_deaf00621>>----
         #----<<l_deaf00622>>----
         #----<<l_deaf00623>>----
         #----<<l_deaf00624>>----
         #----<<l_deaf00625>>----
         #----<<l_deaf00626>>----
         #----<<l_deaf00627>>----
         #----<<l_deaf00628>>----
         #----<<l_deaf00629>>----
         #----<<l_deaf00630>>----
         #----<<b_deaf006>>----
         #Ctrlp:construct.c.filter.page1.b_deaf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaf006
            #add-point:ON ACTION controlp INFIELD b_deaf006 name="construct.c.filter.page1.b_deaf006"
            
            #END add-point
 
 
         #----<<b_deaf007>>----
         #Ctrlp:construct.c.filter.page1.b_deaf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaf007
            #add-point:ON ACTION controlp INFIELD b_deaf007 name="construct.c.filter.page1.b_deaf007"
            
            #END add-point
 
 
         #----<<l_lsmoney>>----
         #----<<b_deagdocno>>----
         #Ctrlp:construct.c.page1.b_deagdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deagdocno
            #add-point:ON ACTION controlp INFIELD b_deagdocno name="construct.c.filter.page1.b_deagdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_deagdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deagdocno  #顯示到畫面上
            NEXT FIELD b_deagdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_deagsite_1>>----
         #----<<b_deagsite_1_desc>>----
         #----<<b_deagdocdt_1>>----
         #----<<b_deag004_1>>----
         #----<<b_deag004_1_desc>>----
         #----<<b_deaf006_1>>----
         #----<<b_deaf007_1>>----
         #----<<l_lsmoney_1>>----
         #----<<b_deagdocdt_2>>----
         #----<<l_deaf006a01>>----
         #----<<l_deaf006a02>>----
         #----<<l_deaf006a03>>----
         #----<<l_deaf006a04>>----
         #----<<l_deaf006a05>>----
         #----<<l_deaf006a06>>----
         #----<<l_deaf006a07>>----
         #----<<l_deaf006a08>>----
         #----<<l_deaf006a09>>----
         #----<<l_deaf006a10>>----
         #----<<l_deaf006a11>>----
         #----<<l_deaf006a12>>----
         #----<<l_deaf006a13>>----
         #----<<l_deaf006a14>>----
         #----<<l_deaf006a15>>----
         #----<<l_deaf006a16>>----
         #----<<l_deaf006a17>>----
         #----<<l_deaf006a18>>----
         #----<<l_deaf006a19>>----
         #----<<l_deaf006a20>>----
         #----<<l_deaf006a21>>----
         #----<<l_deaf006a22>>----
         #----<<l_deaf006a23>>----
         #----<<l_deaf006a24>>----
         #----<<l_deaf006a25>>----
         #----<<l_deaf006a26>>----
         #----<<l_deaf006a27>>----
         #----<<l_deaf006a28>>----
         #----<<l_deaf006a29>>----
         #----<<l_deaf006a30>>----
         #----<<b_deag004_2>>----
         #----<<b_deag004_2_desc>>----
         #----<<l_type>>----
         #----<<l_sum>>----
         #----<<b_deaf019>>----
         #Ctrlp:construct.c.filter.page4.b_deaf019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaf019
            #add-point:ON ACTION controlp INFIELD b_deaf019 name="construct.c.filter.page4.b_deaf019"
            
            #END add-point
 
 
         #----<<b_deaf007_2>>----
         #----<<b_deaf020>>----
         #Ctrlp:construct.c.filter.page4.b_deaf020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaf020
            #add-point:ON ACTION controlp INFIELD b_deaf020 name="construct.c.filter.page4.b_deaf020"
            
            #END add-point
 
 
         #----<<b_deaf015>>----
         #Ctrlp:construct.c.filter.page4.b_deaf015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaf015
            #add-point:ON ACTION controlp INFIELD b_deaf015 name="construct.c.filter.page4.b_deaf015"
            
            #END add-point
 
 
         #----<<b_deaf008>>----
         #Ctrlp:construct.c.filter.page4.b_deaf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaf008
            #add-point:ON ACTION controlp INFIELD b_deaf008 name="construct.c.filter.page4.b_deaf008"
            
            #END add-point
 
 
         #----<<b_deaf009>>----
         #Ctrlp:construct.c.filter.page4.b_deaf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaf009
            #add-point:ON ACTION controlp INFIELD b_deaf009 name="construct.c.filter.page4.b_deaf009"
            
            #END add-point
 
 
         #----<<b_deaf016>>----
         #Ctrlp:construct.c.filter.page4.b_deaf016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaf016
            #add-point:ON ACTION controlp INFIELD b_deaf016 name="construct.c.filter.page4.b_deaf016"
            
            #END add-point
 
 
         #----<<b_deaf017>>----
         #Ctrlp:construct.c.filter.page4.b_deaf017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaf017
            #add-point:ON ACTION controlp INFIELD b_deaf017 name="construct.c.filter.page4.b_deaf017"
            
            #END add-point
 
 
         #----<<b_deaf017_desc>>----
         #----<<b_deaf018>>----
         #Ctrlp:construct.c.filter.page4.b_deaf018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaf018
            #add-point:ON ACTION controlp INFIELD b_deaf018 name="construct.c.filter.page4.b_deaf018"
            
            #END add-point
 
 
         #----<<b_deaf010>>----
         #Ctrlp:construct.c.filter.page4.b_deaf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaf010
            #add-point:ON ACTION controlp INFIELD b_deaf010 name="construct.c.filter.page4.b_deaf010"
            
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
 
 
 
 
 
   
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL adeq402_filter_show('deagsite','b_deagsite')
   CALL adeq402_filter_show('deagdocdt','b_deagdocdt')
   CALL adeq402_filter_show('deag004','b_deag004')
   CALL adeq402_filter_show('deaf006','b_deaf006')
   CALL adeq402_filter_show('deaf007','b_deaf007')
   CALL adeq402_filter_show('deagdocno','b_deagdocno')
   CALL adeq402_filter_show('deaf019','b_deaf019')
   CALL adeq402_filter_show('deaf020','b_deaf020')
   CALL adeq402_filter_show('deaf015','b_deaf015')
   CALL adeq402_filter_show('deaf008','b_deaf008')
   CALL adeq402_filter_show('deaf009','b_deaf009')
   CALL adeq402_filter_show('deaf016','b_deaf016')
   CALL adeq402_filter_show('deaf017','b_deaf017')
   CALL adeq402_filter_show('deaf018','b_deaf018')
   CALL adeq402_filter_show('deaf010','b_deaf010')
 
 
   CALL adeq402_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq402.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION adeq402_filter_parser(ps_field)
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
 
{<section id="adeq402.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq402_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq402_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="adeq402.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq402_detail_action_trans()
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
 
{<section id="adeq402.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq402_detail_index_setting()
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
            IF g_deag_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_deag_d.getLength() AND g_deag_d.getLength() > 0
            LET g_detail_idx = g_deag_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_deag_d.getLength() THEN
               LET g_detail_idx = g_deag_d.getLength()
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
 
{<section id="adeq402.mask_functions" >}
 &include "erp/ade/adeq402_mask.4gl"
 
{</section>}
 
{<section id="adeq402.other_function" readonly="Y" >}

################################################################################
# Descriptions...: TEMP TABLE
# Memo...........:
# Usage..........: CALL adeq402_create_temp_table()
# Date & Author..: 20151230 By s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq402_create_temp_table()
   DROP TABLE adeq402_tmp;
   CREATE TEMP TABLE adeq402_tmp(
   deagent     SMALLINT,
   deagsite    VARCHAR(10), 
   ooefl003    VARCHAR(500), 
   deagdocdt   DATE, 
   deag004     VARCHAR(20), 
   pcab003     VARCHAR(500), 
   deaf012     VARCHAR(10),
   deaf00601   DECIMAL(20,6), 
   deaf00602   DECIMAL(20,6), 
   deaf00603   DECIMAL(20,6), 
   deaf00604   DECIMAL(20,6), 
   deaf00605   DECIMAL(20,6), 
   deaf00606   DECIMAL(20,6), 
   deaf00607   DECIMAL(20,6), 
   deaf00608   DECIMAL(20,6), 
   deaf00609   DECIMAL(20,6), 
   deaf00610   DECIMAL(20,6), 
   deaf00611   DECIMAL(20,6), 
   deaf00612   DECIMAL(20,6), 
   deaf00613   DECIMAL(20,6), 
   deaf00614   DECIMAL(20,6), 
   deaf00615   DECIMAL(20,6), 
   deaf00616   DECIMAL(20,6), 
   deaf00617   DECIMAL(20,6), 
   deaf00618   DECIMAL(20,6), 
   deaf00619   DECIMAL(20,6), 
   deaf00620   DECIMAL(20,6), 
   deaf00621   DECIMAL(20,6), 
   deaf00622   DECIMAL(20,6), 
   deaf00623   DECIMAL(20,6), 
   deaf00624   DECIMAL(20,6), 
   deaf00625   DECIMAL(20,6), 
   deaf00626   DECIMAL(20,6), 
   deaf00627   DECIMAL(20,6), 
   deaf00628   DECIMAL(20,6), 
   deaf00629   DECIMAL(20,6), 
   deaf00630   DECIMAL(20,6),
   deaf006     DECIMAL(20,6), 
   deaf007     DECIMAL(20,6), 
   lsmoney     DECIMAL(20,6),
   deaf019     DECIMAL(20,6), 
   deaf007_2   DECIMAL(20,6), 
   deaf020     DECIMAL(20,6),
   deaf015     DECIMAL(20,6),
   deaf008     DECIMAL(20,6),
   deaf009     VARCHAR(10),
   deaf016     VARCHAR(10),
   deaf017     VARCHAR(10),
   ooial003    VARCHAR(500), 
   deaf018     VARCHAR(20),
   deaf010     VARCHAR(80)
   )
END FUNCTION

################################################################################
# Descriptions...: 依SCC內容動態調整畫面上欄位
# Memo...........:
# Usage..........: CALL adeq402_init_set()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015 BY s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq402_init_set()
   DEFINE l_cnt          LIKE type_t.num10    
   DEFINE l_sql          STRING   
   DEFINE l_gzcb002      LIKE gzcb_t.gzcb002   #系統分類碼值
   DEFINE l_gzcbl004     LIKE gzcbl_t.gzcbl004 #說明
   DEFINE l_seq          LIKE type_t.num10     #排序
   
   LET l_cnt = 0
   LET l_sql = "SELECT gzcb002,gzcbl004,ROW_NUMBER() over(ORDER BY gzcb002) as seq ",
               "  FROM gzcb_t ",
               "       LEFT JOIN gzcbl_t ON  gzcbl001 = gzcb001 AND gzcbl002 = gzcb002 AND gzcbl003 = '",g_dlang,"' ",
               " WHERE gzcb001 = '8310'  ",
               " ORDER BY seq " 
   PREPARE adeq402_scc FROM l_sql
   DECLARE b_adeq402_scc CURSOR FOR adeq402_scc  
   FOREACH b_adeq402_scc INTO  l_gzcb002,l_gzcbl004,l_seq
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err() 
         EXIT FOREACH
      END IF
      
      CASE l_seq
        WHEN 1        
          CALL cl_set_comp_att_text('l_deaf006a01',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00601',l_gzcbl004)
          LET g_scc_sql = " SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a1, "
        WHEN 2        
          CALL cl_set_comp_att_text('l_deaf006a02',l_gzcbl004)
           CALL cl_set_comp_att_text('l_deaf00602',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a2, "
        WHEN 3        
          CALL cl_set_comp_att_text('l_deaf006a03',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00603',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a3, "
        WHEN 4        
          CALL cl_set_comp_att_text('l_deaf006a04',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00604',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a4, "
        WHEN 5        
          CALL cl_set_comp_att_text('l_deaf006a05',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00605',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a5, "
        WHEN 6        
          CALL cl_set_comp_att_text('l_deaf006a06',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00606',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a6, "
        WHEN 7        
          CALL cl_set_comp_att_text('l_deaf006a07',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00607',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a7, "
        WHEN 8        
          CALL cl_set_comp_att_text('l_deaf006a08',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00608',l_gzcbl004)
           LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a8, "
        WHEN 9        
          CALL cl_set_comp_att_text('l_deaf006a09',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00609',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a9, "
        WHEN 10        
          CALL cl_set_comp_att_text('l_deaf006a10',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00610',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a10, "
        WHEN 11        
          CALL cl_set_comp_att_text('l_deaf006a11',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00611',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a11, "
        WHEN 12      
          CALL cl_set_comp_att_text('l_deaf006a12',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00612',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a12, "        
        WHEN 13
          CALL cl_set_comp_att_text('l_deaf006a13',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00613',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a13, "  
        WHEN 14
          CALL cl_set_comp_att_text('l_deaf006a14',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00614',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a14, "          
        WHEN 15
          CALL cl_set_comp_att_text('l_deaf006a15',l_gzcbl004) 
          CALL cl_set_comp_att_text('l_deaf00615',l_gzcbl004) 
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a15, "        
        
        WHEN 16
          CALL cl_set_comp_att_text('l_deaf006a16',l_gzcbl004)
           CALL cl_set_comp_att_text('l_deaf00616',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a16, "        
        
        WHEN 17
          CALL cl_set_comp_att_text('l_deaf006a17',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00617',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a17, "         
        
        WHEN 18
          CALL cl_set_comp_att_text('l_deaf006a18',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00618',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a18, "        
        
        WHEN 19
          CALL cl_set_comp_att_text('l_deaf006a19',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00619',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a19, "        
        
        WHEN 20
          CALL cl_set_comp_att_text('l_deaf006a20',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00620',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a20, "        
        
        WHEN 21
          CALL cl_set_comp_att_text('l_deaf006a21',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00621',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a21, "        
        
        WHEN 22
          CALL cl_set_comp_att_text('l_deaf006a22',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00622',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a22, "        
        
        WHEN 23
          CALL cl_set_comp_att_text('l_deaf006a23',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00623',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a23, "        
        
        WHEN 24
          CALL cl_set_comp_att_text('l_deaf006a24',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00624',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a24, "        
        
        WHEN 25
          CALL cl_set_comp_att_text('l_deaf006a25',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00625',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a25, "        
        
        WHEN 26
          CALL cl_set_comp_att_text('l_deaf006a26',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00626',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a26, "        
        
        WHEN 27
          CALL cl_set_comp_att_text('l_deaf006a27',l_gzcbl004)    
          CALL cl_set_comp_att_text('l_deaf00627',l_gzcbl004)           
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a27, "        
        
        WHEN 28
          CALL cl_set_comp_att_text('l_deaf006a28',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00628',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a28, "        
        
        WHEN 29
          CALL cl_set_comp_att_text('l_deaf006a29',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00629',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a29, "        
        
        WHEN 30
          CALL cl_set_comp_att_text('l_deaf006a30',l_gzcbl004)
          CALL cl_set_comp_att_text('l_deaf00630',l_gzcbl004)
          LET g_scc_sql = g_scc_sql," SUM(CASE WHEN deaf012 = '"||l_gzcb002||"' THEN deaf006 ELSE 0 END) a30, "        
      END CASE
      
      LET l_cnt = l_cnt + 1
               
   END FOREACH  
   
   CASE l_cnt
       WHEN 12   
         CALL cl_set_comp_visible("l_deaf00613,l_deaf00614,l_deaf00615,l_deaf00616,l_deaf00617,l_deaf00618,l_deaf00619,l_deaf00620,l_deaf00621",FALSE)
         CALL cl_set_comp_visible("l_deaf00622,l_deaf00623,l_deaf00624,l_deaf00625,l_deaf00626,l_deaf00627,l_deaf00628,l_deaf00629,l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a13,l_deaf006a14,l_deaf006a15,l_deaf006a16,l_deaf006a17,l_deaf006a18,l_deaf006a19,l_deaf006a20,l_deaf006a21",FALSE)
         CALL cl_set_comp_visible("l_deaf006a22,l_deaf006a23,l_deaf006a24,l_deaf006a25,l_deaf006a26,l_deaf006a27,l_deaf006a28,l_deaf006a29,l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '','','','','','','','','','','','','','','','','','', " 
       WHEN 13
         CALL cl_set_comp_visible("l_deaf00614,l_deaf00615,l_deaf00616,l_deaf00617,l_deaf00618,l_deaf00619,l_deaf00620,l_deaf00621",FALSE)
         CALL cl_set_comp_visible("l_deaf00622,l_deaf00623,l_deaf00624,l_deaf00625,l_deaf00626,l_deaf00627,l_deaf00628,l_deaf00629,l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a14,l_deaf006a15,l_deaf006a16,l_deaf006a17,l_deaf006a18,l_deaf006a19,l_deaf006a20,l_deaf006a21",FALSE)
         CALL cl_set_comp_visible("l_deaf006a22,l_deaf006a23,l_deaf006a24,l_deaf006a25,l_deaf006a26,l_deaf006a27,l_deaf006a28,l_deaf006a29,l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '','','','','','','','','','','','','','','','','', " 
       WHEN 14
         CALL cl_set_comp_visible("l_deaf00615,l_deaf00616,l_deaf00617,l_deaf00618,l_deaf00619,l_deaf00620,l_deaf00621",FALSE)
         CALL cl_set_comp_visible("l_deaf00622,l_deaf00623,l_deaf00624,l_deaf00625,l_deaf00626,l_deaf00627,l_deaf00628,l_deaf00629,l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a15,l_deaf006a16,l_deaf006a17,l_deaf006a18,l_deaf006a19,l_deaf006a20,l_deaf006a21",FALSE)
         CALL cl_set_comp_visible("l_deaf006a22,l_deaf006a23,l_deaf006a24,l_deaf006a25,l_deaf006a26,l_deaf006a27,l_deaf006a28,l_deaf006a29,l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '','','','','','','','','','','','','','','','', " 
       WHEN 15
         CALL cl_set_comp_visible("l_deaf00616,l_deaf00617,l_deaf00618,l_deaf00619,l_deaf00620,l_deaf00621",FALSE)
         CALL cl_set_comp_visible("l_deaf00622,l_deaf00623,l_deaf00624,l_deaf00625,l_deaf00626,l_deaf00627,l_deaf00628,l_deaf00629,l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a16,l_deaf006a17,l_deaf006a18,l_deaf006a19,l_deaf006a20,l_deaf006a21",FALSE)
         CALL cl_set_comp_visible("l_deaf006a22,l_deaf006a23,l_deaf006a24,l_deaf006a25,l_deaf006a26,l_deaf006a27,l_deaf006a28,l_deaf006a29,l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '','','','','','','','','','','','','','','', "    
       WHEN 16
         CALL cl_set_comp_visible("l_deaf00617,l_deaf00618,l_deaf00619,l_deaf00620,l_deaf00621",FALSE)
         CALL cl_set_comp_visible("l_deaf00622,l_deaf00623,l_deaf00624,l_deaf00625,l_deaf00626,l_deaf00627,l_deaf00628,l_deaf00629,l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a17,l_deaf006a18,l_deaf006a19,l_deaf006a20,l_deaf006a21",FALSE)
         CALL cl_set_comp_visible("l_deaf006a22,l_deaf006a23,l_deaf006a24,l_deaf006a25,l_deaf006a26,l_deaf006a27,l_deaf006a28,l_deaf006a29,l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '','','','','','','','','','','','','','', " 
       WHEN 17
         CALL cl_set_comp_visible("l_deaf00618,l_deaf00619,l_deaf00620,l_deaf00621",FALSE)
         CALL cl_set_comp_visible("l_deaf00622,l_deaf00623,l_deaf00624,l_deaf00625,l_deaf00626,l_deaf00627,l_deaf00628,l_deaf00629,l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a18,l_deaf006a19,l_deaf006a20,l_deaf006a21",FALSE)
         CALL cl_set_comp_visible("l_deaf006a22,l_deaf006a23,l_deaf006a24,l_deaf006a25,l_deaf006a26,l_deaf006a27,l_deaf006a28,l_deaf006a29,l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '','','','','','','','','','','','',''," 
       WHEN 18
         CALL cl_set_comp_visible("l_deaf00619,l_deaf00620,l_deaf00621",FALSE)
         CALL cl_set_comp_visible("l_deaf00622,l_deaf00623,l_deaf00624,l_deaf00625,l_deaf00626,l_deaf00627,l_deaf00628,l_deaf00629,l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a19,l_deaf006a20,l_deaf006a21",FALSE)
         CALL cl_set_comp_visible("l_deaf006a22,l_deaf006a23,l_deaf006a24,l_deaf006a25,l_deaf006a26,l_deaf006a27,l_deaf006a28,l_deaf006a29,l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '','','','','','','','','','','',''," 
       WHEN 19
         CALL cl_set_comp_visible("l_deaf00620,l_deaf00621",FALSE)
         CALL cl_set_comp_visible("l_deaf00622,l_deaf00623,l_deaf00624,l_deaf00625,l_deaf00626,l_deaf00627,l_deaf00628,l_deaf00629,l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a20,l_deaf006a21",FALSE)
         CALL cl_set_comp_visible("l_deaf006a22,l_deaf006a23,l_deaf006a24,l_deaf006a25,l_deaf006a26,l_deaf006a27,l_deaf006a28,l_deaf006a29,l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '','','','','','','','','','','',"       
       WHEN 20
         CALL cl_set_comp_visible("l_deaf00621",FALSE)
         CALL cl_set_comp_visible("l_deaf00622,l_deaf00623,l_deaf00624,l_deaf00625,l_deaf00626,l_deaf00627,l_deaf00628,l_deaf00629,l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a21",FALSE)
         CALL cl_set_comp_visible("l_deaf006a22,l_deaf006a23,l_deaf006a24,l_deaf006a25,l_deaf006a26,l_deaf006a27,l_deaf006a28,l_deaf006a29,l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '','','','','','','','','',''," 
       WHEN 21
         CALL cl_set_comp_visible("l_deaf00622,l_deaf00623,l_deaf00624,l_deaf00625,l_deaf00626,l_deaf00627,l_deaf00628,l_deaf00629,l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a22,l_deaf006a23,l_deaf006a24,l_deaf006a25,l_deaf006a26,l_deaf006a27,l_deaf006a28,l_deaf006a29,l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '','','','','','','','','',"    
       WHEN 22
         CALL cl_set_comp_visible("l_deaf00623,l_deaf00624,l_deaf00625,l_deaf00626,l_deaf00627,l_deaf00628,l_deaf00629,l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a23,l_deaf006a24,l_deaf006a25,l_deaf006a26,l_deaf006a27,l_deaf006a28,l_deaf006a29,l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '','','','','','','','',"
       WHEN 23
         CALL cl_set_comp_visible("l_deaf00624,l_deaf00625,l_deaf00626,l_deaf00627,l_deaf00628,l_deaf00629,l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a24,l_deaf006a25,l_deaf006a26,l_deaf006a27,l_deaf006a28,l_deaf006a29,l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '','','','','','','',"       
       WHEN 24
         CALL cl_set_comp_visible("l_deaf00625,l_deaf00626,l_deaf00627,l_deaf00628,l_deaf00629,l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a25,l_deaf006a26,l_deaf006a27,l_deaf006a28,l_deaf006a29,l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '','','','','','',"
       WHEN 25
         CALL cl_set_comp_visible("l_deaf00626,l_deaf00627,l_deaf00628,l_deaf00629,l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a26,l_deaf006a27,l_deaf006a28,l_deaf006a29,l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '','','','',''," 
       WHEN 26 
         CALL cl_set_comp_visible("l_deaf00627,l_deaf00628,l_deaf00629,l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a27,l_deaf006a28,l_deaf006a29,l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '','','','',"     
       WHEN 27
         CALL cl_set_comp_visible("l_deaf00628,l_deaf00629,l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a28,l_deaf006a29,l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '','',''," 
       WHEN 28
         CALL cl_set_comp_visible("l_deaf00629,l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a29,l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '',''," 
       WHEN 29
         CALL cl_set_comp_visible("l_deaf00630",FALSE)
         CALL cl_set_comp_visible("l_deaf006a30",FALSE)
         LET g_scc_sql = g_scc_sql," '',"         
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 收銀滙總頁簽
# Memo...........:
# Usage..........: CALL adeq402_b2_fill()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20151231 By s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq402_b2_fill()
   LET g_sql2 =  " SELECT  UNIQUE deagsite,ooefl003,deagdocdt,deag004,pcab003,SUM(deaf006),SUM(deaf007),SUM(lsmoney)",
                 " FROM adeq402_tmp ",
                 " WHERE deagent = ?",
                 " GROUP BY deagsite,ooefl003,deagdocdt,deag004,pcab003",
                 " ORDER BY deagsite,deagdocdt,deag004"

   #end add-point
 
   LET g_sql2 = cl_sql_add_mask(g_sql2)              #遮蔽特定資料
   PREPARE adeq402_pb2 FROM g_sql2
   DECLARE b_fill_curs2 CURSOR FOR adeq402_pb2
   
   OPEN b_fill_curs2 USING g_enterprise
 
   CALL g_deag2_d.clear()
 
   #add-point:陣列清空

   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
    FOREACH b_fill_curs2 INTO   g_deag2_d[l_ac].deagsite,g_deag2_d[l_ac].deagsite_1_desc,g_deag2_d[l_ac].deagdocdt, 
                                g_deag2_d[l_ac].deag004,g_deag2_d[l_ac].deag004_1_desc,g_deag2_d[l_ac].deaf006,
                                g_deag2_d[l_ac].deaf007,g_deag2_d[l_ac].l_lsmoney_1
    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
   
 
      #add-point:b_fill段資料填充

      #end add-point 
 
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
   
  
 

   FREE adeq402_pb2
END FUNCTION

################################################################################
# Descriptions...: 款別滙總頁簽
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
PRIVATE FUNCTION adeq402_b3_fill()
   LET g_sql3 =  " SELECT  UNIQUE deagdocdt, ",
                 " sum(deaf00601),sum(deaf00602),sum(deaf00603), ",
                 " sum(deaf00604),sum(deaf00605),sum(deaf00606), ",
                 " sum(deaf00607),sum(deaf00608),sum(deaf00609), ",
                 " sum(deaf00610),sum(deaf00611),sum(deaf00612), ",
                 " sum(deaf00613),sum(deaf00614),sum(deaf00615), ",
                 " sum(deaf00616),sum(deaf00617),sum(deaf00618), ",
                 " sum(deaf00619),sum(deaf00620),sum(deaf00621), ",
                 " sum(deaf00622),sum(deaf00623),sum(deaf00624), ",
                 " sum(deaf00625),sum(deaf00626),sum(deaf00627), ",
                 " sum(deaf00628),sum(deaf00629),sum(deaf00630) ",
                 " FROM adeq402_tmp ",
                 " WHERE deagent = ?",
                 " GROUP BY deagdocdt ",
                 " ORDER BY deagdocdt "

   #end add-point
 
   LET g_sql3 = cl_sql_add_mask(g_sql3)              #遮蔽特定資料
   PREPARE adeq402_pb3 FROM g_sql3
   DECLARE b_fill_curs3 CURSOR FOR adeq402_pb3
   
   OPEN b_fill_curs3 USING g_enterprise
 
   CALL g_deag3_d.clear()
 
   #add-point:陣列清空

   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
    FOREACH b_fill_curs3 INTO  g_deag3_d[l_ac].deagdocdt,g_deag3_d[l_ac].l_deaf006a01,g_deag3_d[l_ac].l_deaf006a02, 
                               g_deag3_d[l_ac].l_deaf006a03,g_deag3_d[l_ac].l_deaf006a04,g_deag3_d[l_ac].l_deaf006a05,g_deag3_d[l_ac].l_deaf006a06, 
                               g_deag3_d[l_ac].l_deaf006a07,g_deag3_d[l_ac].l_deaf006a08,g_deag3_d[l_ac].l_deaf006a09,g_deag3_d[l_ac].l_deaf006a10, 
                               g_deag3_d[l_ac].l_deaf006a11,g_deag3_d[l_ac].l_deaf006a12,g_deag3_d[l_ac].l_deaf006a13,g_deag3_d[l_ac].l_deaf006a14, 
                               g_deag3_d[l_ac].l_deaf006a15,g_deag3_d[l_ac].l_deaf006a16,g_deag3_d[l_ac].l_deaf006a17,g_deag3_d[l_ac].l_deaf006a18, 
                               g_deag3_d[l_ac].l_deaf006a19,g_deag3_d[l_ac].l_deaf006a20,g_deag3_d[l_ac].l_deaf006a21,g_deag3_d[l_ac].l_deaf006a22, 
                               g_deag3_d[l_ac].l_deaf006a23,g_deag3_d[l_ac].l_deaf006a24,g_deag3_d[l_ac].l_deaf006a25,g_deag3_d[l_ac].l_deaf006a26, 
                               g_deag3_d[l_ac].l_deaf006a27,g_deag3_d[l_ac].l_deaf006a28,g_deag3_d[l_ac].l_deaf006a29,g_deag3_d[l_ac].l_deaf006a30 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
   
 
      #add-point:b_fill段資料填充

      #end add-point 
 
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
   
  
   

   FREE adeq402_pb3
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL adeq402_b4_fill()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20151231 By s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq402_b4_fill()
   LET g_sql4 =  " SELECT  UNIQUE deag004,pcab003,deaf012,sum(deaf006),SUM(deaf019),SUM(deaf007),SUM(deaf020),SUM(deaf015),SUM(deaf008), ",
                 "                deaf009,deaf016,deaf017,ooial003,deaf018,deaf010 ",
                 " FROM adeq402_tmp ",
                 " WHERE deagent = ?",
                 " GROUP BY deag004,pcab003,deaf012,deaf009,deaf016,deaf017,ooial003,deaf018,deaf010 ",
                 " ORDER BY deag004,pcab003,deaf012,deaf009,deaf016,deaf017,ooial003,deaf018 "

   #end add-point
 
   LET g_sql4 = cl_sql_add_mask(g_sql4)              #遮蔽特定資料
   PREPARE adeq402_pb4 FROM g_sql4
   DECLARE b_fill_curs4 CURSOR FOR adeq402_pb4
   
   OPEN b_fill_curs4 USING g_enterprise
 
   CALL g_deag4_d.clear()
 
   #add-point:陣列清空

   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
    FOREACH b_fill_curs4 INTO  g_deag4_d[l_ac].deag004,      g_deag4_d[l_ac].deag004_2_desc, g_deag4_d[l_ac].l_type,  g_deag4_d[l_ac].l_sum,
                               g_deag4_d[l_ac].deaf019,      g_deag4_d[l_ac].deaf007,        g_deag4_d[l_ac].deaf020, g_deag4_d[l_ac].deaf015,
                               g_deag4_d[l_ac].deaf008,      g_deag4_d[l_ac].deaf009,        g_deag4_d[l_ac].deaf016, g_deag4_d[l_ac].deaf017,
                               g_deag4_d[l_ac].deaf017_desc, g_deag4_d[l_ac].deaf018,        g_deag4_d[l_ac].deaf010
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
   
 
      #add-point:b_fill段資料填充

      #end add-point 
 
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
   
  
  

   FREE adeq402_pb4
END FUNCTION

 
{</section>}
 
