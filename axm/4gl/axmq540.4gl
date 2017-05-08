#該程式未解開Section, 採用最新樣板產出!
{<section id="axmq540.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2017-01-19 10:33:33), PR版次:0008(2017-01-19 11:27:15)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000073
#+ Filename...: axmq540
#+ Description: 出貨資料查詢作業
#+ Creator....: 04441(2014-10-01 15:34:14)
#+ Modifier...: 06978 -SD/PR- 06978
 
{</section>}
 
{<section id="axmq540.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160331-00006#1  2016/05/30 By shiun     修改已銷退數量來源(如果該出貨性質為簽收訂單則加總簽收單之已銷退量)
#160906-00038#1  2016/09/22 By Sarah     資料清單單身上下移動時,明細資料的單身資料應該要重新顯示
#170118-00026#1  2017/01/19 By ywtsai    查詢時訂單單號判斷出貨單身xmdl_t的訂單單號xmdl003
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
PRIVATE TYPE type_g_xmdk_d RECORD
       
       sel LIKE type_t.chr1, 
   xmdk007 LIKE xmdk_t.xmdk007, 
   xmdk007_desc LIKE type_t.chr500, 
   xmdkdocno LIKE xmdk_t.xmdkdocno, 
   xmdkdocdt LIKE xmdk_t.xmdkdocdt, 
   xmdk003 LIKE xmdk_t.xmdk003, 
   xmdk003_desc LIKE type_t.chr500, 
   xmdk004 LIKE xmdk_t.xmdk004, 
   xmdk004_desc LIKE type_t.chr500, 
   xmdk006 LIKE xmdk_t.xmdk006, 
   xmda033 LIKE xmda_t.xmda033, 
   xmdl008 LIKE xmdl_t.xmdl008, 
   xmdl008_desc LIKE type_t.chr500, 
   xmdl008_desc_desc LIKE type_t.chr500, 
   xmdl009 LIKE xmdl_t.xmdl009, 
   xmdl014 LIKE xmdl_t.xmdl014, 
   xmdl014_desc LIKE type_t.chr500, 
   xmdl015 LIKE xmdl_t.xmdl015, 
   xmdl015_desc LIKE type_t.chr500, 
   xmdl016 LIKE xmdl_t.xmdl016, 
   xmdl052 LIKE xmdl_t.xmdl052
       END RECORD
PRIVATE TYPE type_g_xmdk3_d RECORD
       xmdk007 LIKE xmdk_t.xmdk007, 
   xmdk007_1_desc LIKE type_t.chr500, 
   xmdmdocno LIKE xmdm_t.xmdmdocno, 
   xmdkdocdt LIKE xmdk_t.xmdkdocdt, 
   xmdk003 LIKE xmdk_t.xmdk003, 
   xmdk003_1_desc LIKE type_t.chr500, 
   xmdk004 LIKE xmdk_t.xmdk004, 
   xmdk004_1_desc LIKE type_t.chr500, 
   xmdmseq LIKE xmdm_t.xmdmseq, 
   xmdmseq1 LIKE xmdm_t.xmdmseq1, 
   xmdl003 LIKE xmdl_t.xmdl003, 
   xmda033 LIKE xmda_t.xmda033, 
   xmdm001 LIKE xmdm_t.xmdm001, 
   xmdm001_desc LIKE type_t.chr500, 
   xmdm001_desc_desc LIKE type_t.chr500, 
   xmdm002 LIKE xmdm_t.xmdm002, 
   xmdm008 LIKE xmdm_t.xmdm008, 
   xmdm008_desc LIKE type_t.chr500, 
   xmdm009 LIKE xmdm_t.xmdm009, 
   xmdl024 LIKE xmdl_t.xmdl024, 
   xmdl028 LIKE xmdl_t.xmdl028, 
   xmdm005 LIKE xmdm_t.xmdm005, 
   xmdm005_desc LIKE type_t.chr500, 
   xmdm006 LIKE xmdm_t.xmdm006, 
   xmdm006_desc LIKE type_t.chr500, 
   xmdm007 LIKE xmdm_t.xmdm007, 
   xmdm033 LIKE xmdm_t.xmdm033, 
   xmdl051 LIKE xmdl_t.xmdl051, 
   xmdm012 LIKE xmdm_t.xmdm012, 
   xmdm013 LIKE xmdm_t.xmdm013, 
   xmdm014 LIKE xmdm_t.xmdm014
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_tm  RECORD
    chk1  LIKE type_t.chr1,
    chk2  LIKE type_t.chr1,
    chk3  LIKE type_t.chr1,
    chk4  LIKE type_t.chr1,
    chk5  LIKE type_t.chr1,
    chk6  LIKE type_t.chr1,
    chk7  LIKE type_t.chr1,
    chk8  LIKE type_t.chr1,
    chk9  LIKE type_t.chr1
          END RECORD
DEFINE tm     type_tm
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xmdk_d            DYNAMIC ARRAY OF type_g_xmdk_d
DEFINE g_xmdk_d_t          type_g_xmdk_d
DEFINE g_xmdk3_d     DYNAMIC ARRAY OF type_g_xmdk3_d
DEFINE g_xmdk3_d_t   type_g_xmdk3_d
 
 
 
 
 
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
 
{<section id="axmq540.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:作業初始化 name="main.init"
   CALL axmq540_cre_tmp()   #add--160331-00006#1 By shiun
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
   DECLARE axmq540_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axmq540_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmq540_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmq540 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmq540_init()   
 
      #進入選單 Menu (="N")
      CALL axmq540_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axmq540
      
   END IF 
   
   CLOSE axmq540_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE axmq540_tmp;   #add--160331-00006#1 By shiun
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axmq540.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axmq540_init()
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
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   LET tm.chk1 = "Y"
   LET tm.chk2 = "Y"
   LET tm.chk3 = "N"
   LET tm.chk4 = "N"
   LET tm.chk5 = "N"
   LET tm.chk6 = "N"
   LET tm.chk7 = "N"
   LET tm.chk8 = "N"
   LET tm.chk9 = "N"
   
   #end add-point
 
   CALL axmq540_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axmq540.default_search" >}
PRIVATE FUNCTION axmq540_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xmdkdocno = '", g_argv[01], "' AND "
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
 
{<section id="axmq540.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmq540_ui_dialog() 
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
 
   
   CALL axmq540_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xmdk_d.clear()
         CALL g_xmdk3_d.clear()
 
 
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
 
         CALL axmq540_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME tm.chk1,tm.chk2,tm.chk3,tm.chk4,tm.chk5,tm.chk6,tm.chk7,tm.chk8,tm.chk9 ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT

            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF
         END INPUT

         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         #CONSTRUCT BY NAME g_wc ON xmdkdocno,xmdkdocdt,xmdk007,xmdk006,xmda033,xmdk003,xmdk004,xmdm001,xmdm005,xmdm006,xmdm007   #170118-00026#1 mark
         CONSTRUCT BY NAME g_wc ON xmdkdocno,xmdkdocdt,xmdk007,xmdl003,xmda033,xmdk003,xmdk004,xmdm001,xmdm005,xmdm006,xmdm007    #170118-00026#1 add
            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD xmdkdocno
   		   	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   		   	LET g_qryparam.reqry = FALSE
               CALL q_xmdkdocno()
               DISPLAY g_qryparam.return1 TO xmdkdocno
               NEXT FIELD xmdkdocno

            ON ACTION controlp INFIELD xmdk007
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      
			      LET g_qryparam.arg1 = g_site
			      
               CALL q_pmaa001_6()
               DISPLAY g_qryparam.return1 TO xmdk007
               NEXT FIELD xmdk007

            #ON ACTION controlp INFIELD xmdk006       #170118-00026#1 mark
            ON ACTION controlp INFIELD xmdl003        #170118-00026#1 add
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_xmdadocno_2()
               #170118-00026#1 mark---start---
               #DISPLAY g_qryparam.return1 TO xmdk006
               #NEXT FIELD xmdk006
               #170118-00026#1 mark---end---
               #170118-00026#1 add---start---
               DISPLAY g_qryparam.return1 TO xmdl003
               NEXT FIELD xmdl003
               #170118-00026#1 add---end---

            ON ACTION controlp INFIELD xmda033
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_xmda033()
               DISPLAY g_qryparam.return1 TO xmda033
               NEXT FIELD xmda033

            ON ACTION controlp INFIELD xmdk003
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		      	LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO xmdk003
               NEXT FIELD xmdk003

            ON ACTION controlp INFIELD xmdk004
	     	 	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		      	LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()
               DISPLAY g_qryparam.return1 TO xmdk004
               NEXT FIELD xmdk004

            ON ACTION controlp INFIELD xmdm001
	     	 	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		      	LET g_qryparam.reqry = FALSE
               CALL q_imaf001_15()
               DISPLAY g_qryparam.return1 TO xmdm001
               NEXT FIELD xmdm001

            ON ACTION controlp INFIELD xmdm005
	     	 	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		      	LET g_qryparam.reqry = FALSE
               CALL q_inag004_2()
               DISPLAY g_qryparam.return1 TO xmdm005
               NEXT FIELD xmdm005

            ON ACTION controlp INFIELD xmdm006
	     	 	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		      	LET g_qryparam.reqry = FALSE
               CALL q_inag005_5()
               DISPLAY g_qryparam.return1 TO xmdm006
               NEXT FIELD xmdm006

         END CONSTRUCT


         #end add-point
     
         DISPLAY ARRAY g_xmdk_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axmq540_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axmq540_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_xmdk3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axmq540_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
            NEXT FIELD xmdkdocno
 
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
            CALL axmq540_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_xmdk_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_xmdk3_d)
               LET g_export_id[2]   = "s_detail3"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL axmq540_b_fill()
 
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
            CALL axmq540_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axmq540_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axmq540_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axmq540_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               LET g_xmdk_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               LET g_xmdk_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmdk_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmdk_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axmq540_filter()
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
 
{<section id="axmq540.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmq540_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_group         STRING
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
 
   CALL g_xmdk_d.clear()
   CALL g_xmdk3_d.clear()
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   IF tm.chk1 = 'N' AND tm.chk2 = 'N' AND tm.chk3 = 'N' AND
      tm.chk4 = 'N' AND tm.chk5 = 'N' AND tm.chk6 = 'N' AND
      tm.chk7 = 'N' AND tm.chk8 = 'N' AND tm.chk9 = 'N' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.code   = 'aqc-00071'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF

   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',xmdk007,'',xmdkdocno,xmdkdocdt,xmdk003,'',xmdk004,'',xmdk006, 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY xmdk_t.xmdkdocno) AS RANK FROM xmdk_t", 
 
 
 
                     " LEFT JOIN xmdm_t ON xmdkdocno = xmdmdocno AND  LEFT JOIN xmdl_t ON xmdkdocno = xmdldocno AND",
                     " WHERE xmdkent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xmdk_t"),
                     " ORDER BY xmdk_t.xmdkdocno"
 
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
 
   LET g_sql = "SELECT '',xmdk007,'',xmdkdocno,xmdkdocdt,xmdk003,'',xmdk004,'',xmdk006,'','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"

   LET g_sql = " SELECT UNIQUE '',"
   LET l_group = " GROUP BY ''"
   
   IF tm.chk1 = 'Y' THEN
      LET g_sql = g_sql,"xmdk007,'',"
      LET l_group = l_group,",xmdk007"
   ELSE
      LET g_sql = g_sql,"'','',"
   END IF

   IF tm.chk2 = 'Y' THEN
      LET g_sql = g_sql,"xmdkdocno,"
      LET l_group = l_group,",xmdkdocno"
   ELSE 
      LET g_sql = g_sql,"'',"
   END IF

   IF tm.chk3 = 'Y' THEN
      LET g_sql = g_sql,"xmdkdocdt,"
      LET l_group = l_group,",xmdkdocdt"
   ELSE
      LET g_sql = g_sql,"''," 
   END IF

   IF tm.chk6 = 'Y' THEN
      LET g_sql = g_sql,"xmdk003,'',"
      LET l_group = l_group,",xmdk003"
   ELSE
      LET g_sql = g_sql,"'','',"
   END IF

   IF tm.chk7 = 'Y' THEN
      LET g_sql = g_sql,"xmdk004,'',"
      LET l_group = l_group,",xmdk004"
   ELSE
      LET g_sql = g_sql,"'','',"
   END IF

   IF tm.chk4 = 'Y' THEN
      LET g_sql = g_sql,"xmdk006,xmda033,"
      LET l_group = l_group,",xmdk006,xmda033"
   ELSE
      LET g_sql = g_sql,"'','',"
   END IF

   IF tm.chk5 = 'Y' THEN
      LET g_sql = g_sql,"xmdm001,'','',xmdm002,"
      LET l_group = l_group,",xmdm001,xmdm002"
   ELSE
      LET g_sql = g_sql,"'','','','',"
   END IF

   IF tm.chk8 = 'Y' THEN
      LET g_sql = g_sql,"xmdm005,'',xmdm006,'',"
      LET l_group = l_group,",xmdm005,xmdm006"
   ELSE
      LET g_sql = g_sql,"'','','','',"
   END IF

   IF tm.chk9 = 'Y' THEN
      LET g_sql = g_sql,"xmdm007,"
      LET l_group = l_group,",xmdm007"
   ELSE
      LET g_sql = g_sql,"'',"
   END IF

   IF tm.chk8 = 'Y' THEN
      LET g_sql = g_sql,"xmdm033 "
      LET l_group = l_group,",xmdm033"
   ELSE
      LET g_sql = g_sql,"''"
   END IF

   IF tm.chk6 = 'Y' THEN
      LET l_group = l_group,",xmdk003"
   END IF

   IF tm.chk7 = 'Y' THEN
      LET l_group = l_group,",xmdk004"
   END IF

   LET g_sql = g_sql," FROM xmdm_t,xmdk_t LEFT OUTER JOIN xmda_t ON xmdadocno = xmdk006 AND xmdaent = xmdkent "
   LET g_sql = g_sql,",xmdl_t "     #170118-00026#1 add

   LET g_sql = g_sql," WHERE xmdkent = ? AND xmdksite = '",g_site,"' AND xmdk000 IN ('1','2','3') ",
                     #"   AND xmdment = xmdkent AND xmdmsite = xmdksite AND xmdmdocno = xmdkdocno AND ",ls_wc,l_group   #170118-00026#1 mark
                     #170118-00026#1 add---start---
                     "   AND xmdment = xmdkent AND xmdmsite = xmdksite AND xmdmdocno = xmdkdocno ",
                     "   AND xmdlent = xmdkent AND xmdlsite = xmdksite AND xmdldocno = xmdkdocno ",
                     "   AND xmdlent = xmdment AND xmdlsite = xmdmsite AND xmdldocno = xmdmdocno AND ",ls_wc,l_group
                     #170118-00026#1 add---end---

   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axmq540_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axmq540_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xmdk_d[l_ac].sel,g_xmdk_d[l_ac].xmdk007,g_xmdk_d[l_ac].xmdk007_desc,g_xmdk_d[l_ac].xmdkdocno, 
       g_xmdk_d[l_ac].xmdkdocdt,g_xmdk_d[l_ac].xmdk003,g_xmdk_d[l_ac].xmdk003_desc,g_xmdk_d[l_ac].xmdk004, 
       g_xmdk_d[l_ac].xmdk004_desc,g_xmdk_d[l_ac].xmdk006,g_xmdk_d[l_ac].xmda033,g_xmdk_d[l_ac].xmdl008, 
       g_xmdk_d[l_ac].xmdl008_desc,g_xmdk_d[l_ac].xmdl008_desc_desc,g_xmdk_d[l_ac].xmdl009,g_xmdk_d[l_ac].xmdl014, 
       g_xmdk_d[l_ac].xmdl014_desc,g_xmdk_d[l_ac].xmdl015,g_xmdk_d[l_ac].xmdl015_desc,g_xmdk_d[l_ac].xmdl016, 
       g_xmdk_d[l_ac].xmdl052,g_xmdk3_d[l_ac].xmdk007,g_xmdk3_d[l_ac].xmdk007_1_desc,g_xmdk3_d[l_ac].xmdmdocno, 
       g_xmdk3_d[l_ac].xmdkdocdt,g_xmdk3_d[l_ac].xmdk003,g_xmdk3_d[l_ac].xmdk003_1_desc,g_xmdk3_d[l_ac].xmdk004, 
       g_xmdk3_d[l_ac].xmdk004_1_desc,g_xmdk3_d[l_ac].xmdmseq,g_xmdk3_d[l_ac].xmdmseq1,g_xmdk3_d[l_ac].xmdl003, 
       g_xmdk3_d[l_ac].xmda033,g_xmdk3_d[l_ac].xmdm001,g_xmdk3_d[l_ac].xmdm001_desc,g_xmdk3_d[l_ac].xmdm001_desc_desc, 
       g_xmdk3_d[l_ac].xmdm002,g_xmdk3_d[l_ac].xmdm008,g_xmdk3_d[l_ac].xmdm008_desc,g_xmdk3_d[l_ac].xmdm009, 
       g_xmdk3_d[l_ac].xmdl024,g_xmdk3_d[l_ac].xmdl028,g_xmdk3_d[l_ac].xmdm005,g_xmdk3_d[l_ac].xmdm005_desc, 
       g_xmdk3_d[l_ac].xmdm006,g_xmdk3_d[l_ac].xmdm006_desc,g_xmdk3_d[l_ac].xmdm007,g_xmdk3_d[l_ac].xmdm033, 
       g_xmdk3_d[l_ac].xmdl051,g_xmdk3_d[l_ac].xmdm012,g_xmdk3_d[l_ac].xmdm013,g_xmdk3_d[l_ac].xmdm014 
 
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
 
      CALL axmq540_detail_show("'1'")
 
      CALL axmq540_xmdk_t_mask()
 
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
   
   #end add-point
 
   CALL g_xmdk_d.deleteElement(g_xmdk_d.getLength())
   CALL g_xmdk3_d.deleteElement(g_xmdk3_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   CALL axmq540_set_visible()
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xmdk_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE axmq540_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axmq540_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axmq540_detail_action_trans()
 
   LET l_ac = 1
   IF g_xmdk_d.getLength() > 0 THEN
      CALL axmq540_b_fill2()
   END IF
 
      CALL axmq540_filter_show('xmdk007','b_xmdk007')
   CALL axmq540_filter_show('xmdkdocno','b_xmdkdocno')
   CALL axmq540_filter_show('xmdkdocdt','b_xmdkdocdt')
   CALL axmq540_filter_show('xmdk003','b_xmdk003')
   CALL axmq540_filter_show('xmdk004','b_xmdk004')
   CALL axmq540_filter_show('xmdk006','b_xmdk006')
   CALL axmq540_filter_show('xmda033','b_xmda033')
   CALL axmq540_filter_show('xmdl008','b_xmdl008')
   CALL axmq540_filter_show('xmdl009','b_xmdl009')
   CALL axmq540_filter_show('xmdl014','b_xmdl014')
   CALL axmq540_filter_show('xmdl015','b_xmdl015')
   CALL axmq540_filter_show('xmdl016','b_xmdl016')
   CALL axmq540_filter_show('xmdl052','b_xmdl052')
 
 
END FUNCTION
 
{</section>}
 
{<section id="axmq540.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmq540_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   #add--160331-00006#1 By shiun--(S)
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_count     LIKE type_t.num5
   DEFINE l_xmdm014   LIKE xmdm_t.xmdm014
   DEFINE l_xmdk002   LIKE xmdk_t.xmdk002
   #add--160331-00006#1 By shiun--(E)
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   CALL g_xmdk3_d.clear()   #160906-00038#1 add
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   #add--160331-00006#1 By shiun--(S)
   DELETE FROM axmq540_tmp
   LET g_sql = "INSERT INTO axmq540_tmp ",
               " SELECT xmdl001,xmdl002,xmdm007,SUM(xmdm014) ",
               "   FROM xmdl_t,xmdm_t ",
               "  WHERE xmdlent = xmdment ",
               "    AND xmdldocno = xmdmdocno ",
               "    AND xmdlseq = xmdmseq ",
               "    AND xmdl001 = ? ",
               "    AND xmdl002 = ? ",
               "    AND xmdm007 = ? ",
               " GROUP BY xmdl001,xmdl002,xmdm007 "
   PREPARE axmq540_tmp_ins FROM g_sql
   LET g_sql = " SELECT COUNT(*) ",
               "   FROM axmq540_tmp ",
               "  WHERE xmdmdocno = ? ",
               "    AND xmdmseq = ? ",
               "    AND xmdm007 = ? "
   PREPARE axmq540_tmp_count FROM g_sql
   #add--160331-00006#1 By shiun--(E)
   LET g_sql = " SELECT xmdk007,'',xmdmdocno,xmdkdocdt,xmdk003,'',xmdk004,'',xmdmseq,xmdmseq1,xmdl003,xmda033,xmdm001,'','', ",
               "        xmdm002,xmdm008,'',xmdm009,xmdl024,xmdl028,xmdm005,'',xmdm006,'', ",
               "        xmdm007,xmdm033,xmdl051,xmdm012,xmdm013,xmdm014 ",
               "       ,xmdk002 ",  #add--160331-00006#1 By shiun
               "   FROM xmdl_t,xmdm_t,xmdk_t LEFT OUTER JOIN xmda_t ON xmdadocno = xmdk006 AND xmdaent = xmdkent ",
               "  WHERE xmdkent = ? AND xmdksite = '",g_site,"' AND xmdk000 IN ('1','2','3') ",
               "    AND xmdlent = xmdkent AND xmdldocno = xmdkdocno ",
               "    AND xmdment = xmdlent AND xmdmdocno = xmdldocno AND xmdmseq = xmdlseq ",
               "    AND ",g_wc, " AND ", g_wc2, " AND ", g_wc_filter

   IF tm.chk1 = 'Y' THEN
      LET g_sql = g_sql," AND xmdk007 = '",g_xmdk_d[g_detail_idx].xmdk007,"' "
   END IF

   IF tm.chk2 = 'Y' THEN
      LET g_sql = g_sql," AND xmdkdocno = '",g_xmdk_d[g_detail_idx].xmdkdocno,"' "
   END IF

   IF tm.chk3 = 'Y' THEN
      LET g_sql = g_sql," AND xmdkdocdt = '",g_xmdk_d[g_detail_idx].xmdkdocdt,"' "
   END IF

   IF tm.chk6 = 'Y' THEN
      LET g_sql = g_sql," AND xmdk003 = '",g_xmdk_d[g_detail_idx].xmdk003,"' "
   END IF

   IF tm.chk7 = 'Y' THEN
      LET g_sql = g_sql," AND xmdk004 = '",g_xmdk_d[g_detail_idx].xmdk004,"' "
   END IF

   IF tm.chk4 = 'Y' THEN
      IF NOT cl_null(g_xmdk_d[g_detail_idx].xmdk006) THEN                       #170118-00026#1 add
         LET g_sql = g_sql," AND xmdk006 = '",g_xmdk_d[g_detail_idx].xmdk006,"' "
      END IF                                                                   #170118-00026#1 add
   END IF

   IF tm.chk5 = 'Y' THEN
      LET g_sql = g_sql," AND xmdm001 = '",g_xmdk_d[g_detail_idx].xmdl008,"' "#AND xmdm002 = '",g_xmdk_d[g_detail_idx].xmdl009,"' "
   END IF

   IF tm.chk8 = 'Y' THEN
      LET g_sql = g_sql," AND xmdm005 = '",g_xmdk_d[g_detail_idx].xmdl014,"' "#AND xmdm006 = '",g_xmdk_d[g_detail_idx].xmdl015,"' AND xmdm033 = '",g_xmdk_d[g_detail_idx].xmdl052,"' "
   END IF

   IF tm.chk9 = 'Y' THEN
      LET g_sql = g_sql," AND xmdm007 = '",g_xmdk_d[g_detail_idx].xmdl016,"' "
   END IF

   IF NOT cl_null(g_xmdk_d[g_detail_idx].xmda033) THEN
      LET g_sql = g_sql," AND xmda033 = '",g_xmdk_d[g_detail_idx].xmda033,"' "
   END IF

   LET g_sql = g_sql," ORDER BY xmdm_t.xmdmseq,xmdm_t.xmdmseq1"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axmq540_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR axmq540_pb2
 
   OPEN b_fill_curs2 USING g_enterprise
 
   LET l_ac = 1
   LET l_xmdk002 = ''
   FOREACH b_fill_curs2 INTO
      g_xmdk3_d[l_ac].xmdk007,g_xmdk3_d[l_ac].xmdk007_1_desc,g_xmdk3_d[l_ac].xmdmdocno, 
      g_xmdk3_d[l_ac].xmdkdocdt,g_xmdk3_d[l_ac].xmdk003,g_xmdk3_d[l_ac].xmdk003_1_desc,
      g_xmdk3_d[l_ac].xmdk004,g_xmdk3_d[l_ac].xmdk004_1_desc,g_xmdk3_d[l_ac].xmdmseq,g_xmdk3_d[l_ac].xmdmseq1,
      g_xmdk3_d[l_ac].xmdl003,g_xmdk3_d[l_ac].xmda033,g_xmdk3_d[l_ac].xmdm001,
      g_xmdk3_d[l_ac].xmdm001_desc,g_xmdk3_d[l_ac].xmdm001_desc_desc,g_xmdk3_d[l_ac].xmdm002, 
      g_xmdk3_d[l_ac].xmdm008,g_xmdk3_d[l_ac].xmdm008_desc,g_xmdk3_d[l_ac].xmdm009,
      g_xmdk3_d[l_ac].xmdl024, g_xmdk3_d[l_ac].xmdl028,g_xmdk3_d[l_ac].xmdm005,
      g_xmdk3_d[l_ac].xmdm005_desc,g_xmdk3_d[l_ac].xmdm006,g_xmdk3_d[l_ac].xmdm006_desc,
      g_xmdk3_d[l_ac].xmdm007,g_xmdk3_d[l_ac].xmdm033,g_xmdk3_d[l_ac].xmdl051, 
      g_xmdk3_d[l_ac].xmdm012,g_xmdk3_d[l_ac].xmdm013,g_xmdk3_d[l_ac].xmdm014,l_xmdk002   #mod--160331-00006#1 By shiun   新增l_xmdk002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF

      #add--160331-00006#1 By shiun--(S)
      IF l_xmdk002 = '3' THEN
#         SELECT xmdm007,SUM(xmdm014) INTO g_xmdk3_d[l_ac].xmdm014
#           FROM xmdk_t,xmdl_t,xmdm_t
#          WHERE xmdkent = xmdlent
#            AND xmdkdocno = xmdldocno
#            AND xmdment = xmdlent
#            AND xmdmdocno = xmdldocno
#            AND xmdmseq = xmdlseq
#            AND xmdl001 = g_xmdk3_d[l_ac].xmdmdocno
#            AND xmdl002 = g_xmdk3_d[l_ac].xmdmseq
#            AND xmdm007 = g_xmdk3_d[l_ac].xmdm007
         LET l_count = 0
         EXECUTE axmq540_tmp_count USING g_xmdk3_d[l_ac].xmdmdocno,g_xmdk3_d[l_ac].xmdmseq,g_xmdk3_d[l_ac].xmdm007 INTO l_count
         IF l_count = 0 THEN
            EXECUTE axmq540_tmp_ins USING g_xmdk3_d[l_ac].xmdmdocno,g_xmdk3_d[l_ac].xmdmseq,g_xmdk3_d[l_ac].xmdm007
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "execute:axmq540_tmp_ins" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
         END IF
      END IF
      #add--160331-00006#1 By shiun--(E)
      CALL axmq540_detail_show("'2'")
 
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

   CALL g_xmdk3_d.deleteElement(g_xmdk3_d.getLength())

   LET li_ac = g_xmdk3_d.getLength()

   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   LET g_sql = " SELECT COALESCE(xmdm014,0) ",
               "   FROM axmq540_tmp ",
               "  WHERE xmdmdocno = ? ",
               "    AND xmdmseq = ? ",
               "    AND xmdm007 = ? "
   PREPARE axmq540_xmdm014 FROM g_sql
   LET g_sql = " SELECT xmdk002 ",
               "   FROM xmdk_t ",
               "  WHERE xmdkent = ? ",
               "    AND xmdkdocno = ? "
   PREPARE axmq540_xmdk002 FROM g_sql
   #add--160331-00006#1 By shiun--(S)
   FOR l_i = 1 TO li_ac
      LET l_xmdk002 = ''
      EXECUTE axmq540_xmdk002 USING g_enterprise,g_xmdk3_d[l_i].xmdmdocno INTO l_xmdk002
      IF l_xmdk002 = '3' THEN
         LET l_xmdm014 = 0
         EXECUTE axmq540_xmdm014 USING g_xmdk3_d[l_i].xmdmdocno,g_xmdk3_d[l_i].xmdmseq,g_xmdk3_d[l_i].xmdm007 INTO l_xmdm014
         IF l_xmdm014 > 0 THEN
            IF (g_xmdk3_d[l_i].xmdm012 - g_xmdk3_d[l_i].xmdm013 ) < l_xmdm014 THEN
               LET g_xmdk3_d[l_i].xmdm014 = (g_xmdk3_d[l_i].xmdm012 - g_xmdk3_d[l_i].xmdm013 )
               LET l_xmdm014 = l_xmdm014 - g_xmdk3_d[l_i].xmdm014
               UPDATE axmq540_tmp SET xmdm014 = l_xmdm014
                WHERE xmdmdocno = g_xmdk3_d[l_i].xmdmdocno
                  AND xmdmseq = g_xmdk3_d[l_i].xmdmseq
                  AND xmdm007 = g_xmdk3_d[l_i].xmdm007
            ELSE
               LET g_xmdk3_d[l_i].xmdm014 = l_xmdm014
               DELETE FROM axmq540_tmp
                WHERE xmdmdocno = g_xmdk3_d[l_i].xmdmdocno
                  AND xmdmseq = g_xmdk3_d[l_i].xmdmseq
                  AND xmdm007 = g_xmdk3_d[l_i].xmdm007
            END IF
         END IF
      END IF
   END FOR
   #add--160331-00006#1 By shiun--(E)
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="axmq540.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axmq540_detail_show(ps_page)
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

      IF NOT cl_null(g_xmdk_d[l_ac].xmdk003) THEN
         CALL s_desc_get_person_desc(g_xmdk_d[l_ac].xmdk003) RETURNING g_xmdk_d[l_ac].xmdk003_desc
      END IF

      IF NOT cl_null(g_xmdk_d[l_ac].xmdk004) THEN
         CALL s_desc_get_department_desc(g_xmdk_d[l_ac].xmdk004) RETURNING g_xmdk_d[l_ac].xmdk004_desc
      END IF

      IF NOT cl_null(g_xmdk_d[l_ac].xmdk007) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmdk_d[l_ac].xmdk007) RETURNING g_xmdk_d[l_ac].xmdk007_desc
      END IF

      IF NOT cl_null(g_xmdk_d[l_ac].xmdl008) THEN
         CALL s_desc_get_item_desc(g_xmdk_d[l_ac].xmdl008) RETURNING g_xmdk_d[l_ac].xmdl008_desc,g_xmdk_d[l_ac].xmdl008_desc_desc
      END IF

      IF NOT cl_null(g_xmdk_d[l_ac].xmdl014) THEN
         CALL s_desc_get_stock_desc(g_site,g_xmdk_d[l_ac].xmdl014) RETURNING g_xmdk_d[l_ac].xmdl014_desc
      END IF

      IF NOT cl_null(g_xmdk_d[l_ac].xmdl014) THEN
         CALL s_desc_get_stock_desc(g_site,g_xmdk_d[l_ac].xmdl014) RETURNING g_xmdk_d[l_ac].xmdl014_desc
      END IF

      IF NOT cl_null(g_xmdk_d[l_ac].xmdl015) THEN
         CALL s_desc_get_locator_desc(g_site,g_xmdk_d[l_ac].xmdl014,g_xmdk_d[l_ac].xmdl015) RETURNING g_xmdk_d[l_ac].xmdl015_desc
      END IF

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"

      IF NOT cl_null(g_xmdk3_d[l_ac].xmdk003) THEN
         CALL s_desc_get_person_desc(g_xmdk3_d[l_ac].xmdk003) RETURNING g_xmdk3_d[l_ac].xmdk003_1_desc
      END IF

      IF NOT cl_null(g_xmdk3_d[l_ac].xmdk004) THEN
         CALL s_desc_get_department_desc(g_xmdk3_d[l_ac].xmdk004) RETURNING g_xmdk3_d[l_ac].xmdk004_1_desc
      END IF

      IF NOT cl_null(g_xmdk3_d[l_ac].xmdk007) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmdk3_d[l_ac].xmdk007) RETURNING  g_xmdk3_d[l_ac].xmdk007_1_desc
      END IF

      IF NOT cl_null(g_xmdk3_d[l_ac].xmdm001) THEN
         CALL s_desc_get_item_desc(g_xmdk3_d[l_ac].xmdm001) RETURNING g_xmdk3_d[l_ac].xmdm001_desc,g_xmdk3_d[l_ac].xmdm001_desc_desc
      END IF

      IF NOT cl_null(g_xmdk3_d[l_ac].xmdm008) THEN
         CALL s_desc_get_unit_desc(g_xmdk3_d[l_ac].xmdm008) RETURNING g_xmdk3_d[l_ac].xmdm008_desc
      END IF

      IF NOT cl_null(g_xmdk3_d[l_ac].xmdm005) THEN
         CALL s_desc_get_stock_desc(g_site,g_xmdk3_d[l_ac].xmdm005) RETURNING g_xmdk3_d[l_ac].xmdm005_desc
      END IF

      IF NOT cl_null(g_xmdk3_d[l_ac].xmdm006) THEN
         CALL s_desc_get_locator_desc(g_site,g_xmdk3_d[l_ac].xmdm005,g_xmdk3_d[l_ac].xmdm006) RETURNING g_xmdk3_d[l_ac].xmdm006_desc
      END IF

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmq540.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION axmq540_filter()
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
      CONSTRUCT g_wc_filter ON xmdk007,xmdkdocno,xmdkdocdt,xmdk003,xmdk004,xmdk006,xmda033,xmdl008,xmdl009, 
          xmdl014,xmdl015,xmdl016,xmdl052
                          FROM s_detail1[1].b_xmdk007,s_detail1[1].b_xmdkdocno,s_detail1[1].b_xmdkdocdt, 
                              s_detail1[1].b_xmdk003,s_detail1[1].b_xmdk004,s_detail1[1].b_xmdk006,s_detail1[1].b_xmda033, 
                              s_detail1[1].b_xmdl008,s_detail1[1].b_xmdl009,s_detail1[1].b_xmdl014,s_detail1[1].b_xmdl015, 
                              s_detail1[1].b_xmdl016,s_detail1[1].b_xmdl052
 
         BEFORE CONSTRUCT
                     DISPLAY axmq540_filter_parser('xmdk007') TO s_detail1[1].b_xmdk007
            DISPLAY axmq540_filter_parser('xmdkdocno') TO s_detail1[1].b_xmdkdocno
            DISPLAY axmq540_filter_parser('xmdkdocdt') TO s_detail1[1].b_xmdkdocdt
            DISPLAY axmq540_filter_parser('xmdk003') TO s_detail1[1].b_xmdk003
            DISPLAY axmq540_filter_parser('xmdk004') TO s_detail1[1].b_xmdk004
            DISPLAY axmq540_filter_parser('xmdk006') TO s_detail1[1].b_xmdk006
            DISPLAY axmq540_filter_parser('xmda033') TO s_detail1[1].b_xmda033
            DISPLAY axmq540_filter_parser('xmdl008') TO s_detail1[1].b_xmdl008
            DISPLAY axmq540_filter_parser('xmdl009') TO s_detail1[1].b_xmdl009
            DISPLAY axmq540_filter_parser('xmdl014') TO s_detail1[1].b_xmdl014
            DISPLAY axmq540_filter_parser('xmdl015') TO s_detail1[1].b_xmdl015
            DISPLAY axmq540_filter_parser('xmdl016') TO s_detail1[1].b_xmdl016
            DISPLAY axmq540_filter_parser('xmdl052') TO s_detail1[1].b_xmdl052
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xmdk007>>----
         #Ctrlp:construct.c.page1.b_xmdk007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk007
            #add-point:ON ACTION controlp INFIELD b_xmdk007 name="construct.c.filter.page1.b_xmdk007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk007  #顯示到畫面上
            NEXT FIELD b_xmdk007                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdk007_desc>>----
         #----<<b_xmdkdocno>>----
         #Ctrlp:construct.c.page1.b_xmdkdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdkdocno
            #add-point:ON ACTION controlp INFIELD b_xmdkdocno name="construct.c.filter.page1.b_xmdkdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmdkdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdkdocno  #顯示到畫面上
            NEXT FIELD b_xmdkdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdkdocdt>>----
         #Ctrlp:construct.c.filter.page1.b_xmdkdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdkdocdt
            #add-point:ON ACTION controlp INFIELD b_xmdkdocdt name="construct.c.filter.page1.b_xmdkdocdt"
            
            #END add-point
 
 
         #----<<b_xmdk003>>----
         #Ctrlp:construct.c.page1.b_xmdk003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk003
            #add-point:ON ACTION controlp INFIELD b_xmdk003 name="construct.c.filter.page1.b_xmdk003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk003  #顯示到畫面上
            NEXT FIELD b_xmdk003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdk003_desc>>----
         #----<<b_xmdk004>>----
         #Ctrlp:construct.c.page1.b_xmdk004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk004
            #add-point:ON ACTION controlp INFIELD b_xmdk004 name="construct.c.filter.page1.b_xmdk004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk004  #顯示到畫面上
            NEXT FIELD b_xmdk004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdk004_desc>>----
         #----<<b_xmdk006>>----
         #Ctrlp:construct.c.page1.b_xmdk006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk006
            #add-point:ON ACTION controlp INFIELD b_xmdk006 name="construct.c.filter.page1.b_xmdk006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmdadocno_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk006  #顯示到畫面上
            NEXT FIELD b_xmdk006                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmda033>>----
         #Ctrlp:construct.c.page1.b_xmda033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda033
            #add-point:ON ACTION controlp INFIELD b_xmda033 name="construct.c.filter.page1.b_xmda033"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmda033()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmda033  #顯示到畫面上
            NEXT FIELD b_xmda033                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdl008>>----
         #Ctrlp:construct.c.page1.b_xmdl008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl008
            #add-point:ON ACTION controlp INFIELD b_xmdl008 name="construct.c.filter.page1.b_xmdl008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdl008  #顯示到畫面上
            NEXT FIELD b_xmdl008                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdl008_desc>>----
         #----<<b_xmdl008_desc_desc>>----
         #----<<b_xmdl009>>----
         #Ctrlp:construct.c.page1.b_xmdl009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl009
            #add-point:ON ACTION controlp INFIELD b_xmdl009 name="construct.c.filter.page1.b_xmdl009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmdl009()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdl009  #顯示到畫面上
            NEXT FIELD b_xmdl009                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdl014>>----
         #Ctrlp:construct.c.page1.b_xmdl014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl014
            #add-point:ON ACTION controlp INFIELD b_xmdl014 name="construct.c.filter.page1.b_xmdl014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag004_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdl014  #顯示到畫面上
            NEXT FIELD b_xmdl014                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdl014_desc>>----
         #----<<b_xmdl015>>----
         #Ctrlp:construct.c.page1.b_xmdl015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl015
            #add-point:ON ACTION controlp INFIELD b_xmdl015 name="construct.c.filter.page1.b_xmdl015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag005_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdl015  #顯示到畫面上
            NEXT FIELD b_xmdl015                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdl015_desc>>----
         #----<<b_xmdl016>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl016
            #add-point:ON ACTION controlp INFIELD b_xmdl016 name="construct.c.filter.page1.b_xmdl016"
            
            #END add-point
 
 
         #----<<b_xmdl052>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl052
            #add-point:ON ACTION controlp INFIELD b_xmdl052 name="construct.c.filter.page1.b_xmdl052"
            
            #END add-point
 
 
         #----<<b_xmdk007_1>>----
         #----<<b_xmdk007_1_desc>>----
         #----<<b_xmdmdocno>>----
         #----<<b_xmdkdocdt_1>>----
         #----<<b_xmdk003_1>>----
         #----<<b_xmdk003_1_desc>>----
         #----<<b_xmdk004_1>>----
         #----<<b_xmdk004_1_desc>>----
         #----<<b_xmdmseq>>----
         #----<<b_xmdmseq1>>----
         #----<<b_xmdl003>>----
         #----<<b_xmda033_1>>----
         #----<<b_xmdm001>>----
         #----<<b_xmdm001_desc>>----
         #----<<b_xmdm001_desc_desc>>----
         #----<<b_xmdm002>>----
         #----<<b_xmdm008>>----
         #----<<b_xmdm008_desc>>----
         #----<<b_xmdm009>>----
         #----<<b_xmdl024>>----
         #----<<b_xmdl028>>----
         #----<<b_xmdm005>>----
         #----<<b_xmdm005_desc>>----
         #----<<b_xmdm006>>----
         #----<<b_xmdm006_desc>>----
         #----<<b_xmdm007>>----
         #----<<b_xmdm033>>----
         #----<<b_xmdl051>>----
         #----<<b_xmdm012>>----
         #----<<b_xmdm013>>----
         #----<<b_xmdm014>>----
 
 
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
 
      CALL axmq540_filter_show('xmdk007','b_xmdk007')
   CALL axmq540_filter_show('xmdkdocno','b_xmdkdocno')
   CALL axmq540_filter_show('xmdkdocdt','b_xmdkdocdt')
   CALL axmq540_filter_show('xmdk003','b_xmdk003')
   CALL axmq540_filter_show('xmdk004','b_xmdk004')
   CALL axmq540_filter_show('xmdk006','b_xmdk006')
   CALL axmq540_filter_show('xmda033','b_xmda033')
   CALL axmq540_filter_show('xmdl008','b_xmdl008')
   CALL axmq540_filter_show('xmdl009','b_xmdl009')
   CALL axmq540_filter_show('xmdl014','b_xmdl014')
   CALL axmq540_filter_show('xmdl015','b_xmdl015')
   CALL axmq540_filter_show('xmdl016','b_xmdl016')
   CALL axmq540_filter_show('xmdl052','b_xmdl052')
 
 
   CALL axmq540_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axmq540.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION axmq540_filter_parser(ps_field)
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
 
{<section id="axmq540.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION axmq540_filter_show(ps_field,ps_object)
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
   LET ls_condition = axmq540_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="axmq540.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axmq540_detail_action_trans()
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
 
{<section id="axmq540.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axmq540_detail_index_setting()
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
            IF g_xmdk_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xmdk_d.getLength() AND g_xmdk_d.getLength() > 0
            LET g_detail_idx = g_xmdk_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xmdk_d.getLength() THEN
               LET g_detail_idx = g_xmdk_d.getLength()
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
 
{<section id="axmq540.mask_functions" >}
 &include "erp/axm/axmq540_mask.4gl"
 
{</section>}
 
{<section id="axmq540.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 欄位隱藏控制
# Memo...........:
# Usage..........: CALL axmq540_set_visible()
# Input parameter: no
# Return code....: no
# Date & Author..: 141002 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmq540_set_visible()

   CALL cl_set_comp_visible("b_xmdk007,b_xmdk007_desc,b_xmdkdocno,b_xmdkdocdt,b_xmdk006,b_xmdl008,b_xmdl008_desc,b_xmdl008_desc_desc,b_xmdl009",TRUE)
   CALL cl_set_comp_visible("b_xmdk003,b_xmdk003_desc,b_xmdk004,b_xmdk004_desc",TRUE)
   CALL cl_set_comp_visible("b_xmdl014,b_xmdl014_desc,b_xmdl015,b_xmdl015_desc,b_xmdl052,b_xmdl016",TRUE)
   CALL cl_set_comp_visible("b_xmdk007_1,b_xmdk007_1_desc,b_xmdmdocno,b_xmdkdocdt_1,b_xmdl003,b_xmdm001,b_xmdm001_desc,b_xmdm001_desc_desc,b_xmdm002",TRUE)
   CALL cl_set_comp_visible("b_xmdk003_1,b_xmdk003_1_desc,b_xmdk004_1,b_xmdk004_1_desc",TRUE)
   CALL cl_set_comp_visible("b_xmdm005,b_xmdm005_desc,b_xmdm006,b_xmdm006_desc,b_xmdm033,b_xmdm007",TRUE)
   CALL cl_set_comp_visible("b_xmda033,b_xmda033_1",TRUE)

   IF tm.chk1 = 'Y' THEN
      CALL cl_set_comp_visible("b_xmdk007_1,b_xmdk007_1_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_xmdk007,b_xmdk007_desc",FALSE)
   END IF

   IF tm.chk2 = 'Y' THEN
      CALL cl_set_comp_visible("b_xmdmdocno",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_xmdkdocno",FALSE)
   END IF

   IF tm.chk3 = 'Y' THEN
      CALL cl_set_comp_visible("b_xmdkdocdt_1",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_xmdkdocdt",FALSE)
   END IF

   IF tm.chk6 = 'Y' THEN
      CALL cl_set_comp_visible("b_xmdk003_1,b_xmdk003_1_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_xmdk003,b_xmdk003_desc",FALSE)
   END IF

   IF tm.chk7 = 'Y' THEN
      CALL cl_set_comp_visible("b_xmdk004_1,b_xmdk004_1_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_xmdk004,b_xmdk004_desc",FALSE)
   END IF

   IF tm.chk4 = 'Y' THEN
      CALL cl_set_comp_visible("b_xmdl003",FALSE)
      CALL cl_set_comp_visible("b_xmda033_1",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_xmdk006",FALSE)
      CALL cl_set_comp_visible("b_xmda033",FALSE)
   END IF

   IF tm.chk5 = 'Y' THEN
      CALL cl_set_comp_visible("b_xmdm001,b_xmdm001_desc,b_xmdm001_desc_desc,b_xmdm002",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_xmdl008,b_xmdl008_desc,b_xmdl008_desc_desc,b_xmdl009",FALSE)
   END IF

   IF tm.chk8 = 'Y' THEN
      CALL cl_set_comp_visible("b_xmdm005,b_xmdm005_desc,b_xmdm006,b_xmdm006_desc,b_xmdm033",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_xmdl014,b_xmdl014_desc,b_xmdl015,b_xmdl015_desc,b_xmdl052",FALSE)
   END IF

   IF tm.chk9 = 'Y' THEN
      CALL cl_set_comp_visible("b_xmdm007",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_xmdl016",FALSE)
   END IF

END FUNCTION

################################################################################
# Descriptions...: 創建臨時表
# Memo...........:
# Usage..........: CALL axmq540_cre_tmp()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/05/30 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION axmq540_cre_tmp()
   
   WHENEVER ERROR CONTINUE 
   DROP TABLE axmq540_tmp;
   CREATE TEMP TABLE axmq540_tmp(
      xmdmdocno   LIKE xmdm_t.xmdmdocno,  #出貨單號
      xmdmseq     LIKE xmdm_t.xmdmseq,    #出貨項次
      xmdm007     LIKE xmdm_t.xmdm007,    #批號
      xmdm014     LIKE xmdm_t.xmdm014     #已銷退數量
   )  
   
END FUNCTION

 
{</section>}
 
