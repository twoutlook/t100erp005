#該程式未解開Section, 採用最新樣板產出!
{<section id="astq801.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-07-31 14:26:13), PR版次:0004(2016-07-31 16:45:39)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: astq801
#+ Description: 合約帳單明細查詢
#+ Creator....: 02159(2016-05-18 16:48:50)
#+ Modifier...: 07142 -SD/PR- 07142
 
{</section>}
 
{<section id="astq801.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160604-00009#36 2016/06/14  By dongsz   增加合同的QBE條件，及單身合同/商戶/鋪位欄位
#160604-00009#64 20160623  By geza   新增提前出账的逻辑,不控管是否到出账日期，可以提前产生费用单
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
PRIVATE TYPE type_g_stjm_d RECORD
       #statepic       LIKE type_t.chr1,
       
       stjm001 LIKE stjm_t.stjm001, 
   stje007 LIKE type_t.chr500, 
   stje007_desc LIKE type_t.chr500, 
   stje008 LIKE type_t.chr500, 
   stje008_desc LIKE type_t.chr500, 
   stjmseq LIKE stjm_t.stjmseq, 
   stjm002 LIKE stjm_t.stjm002, 
   stjm003 LIKE stjm_t.stjm003, 
   stjm003_desc LIKE type_t.chr500, 
   stjm004 LIKE stjm_t.stjm004, 
   stjm005 LIKE stjm_t.stjm005, 
   stjm006 LIKE stjm_t.stjm006, 
   stjm007 LIKE stjm_t.stjm007, 
   stjm008 LIKE stjm_t.stjm008, 
   stjm009 LIKE stjm_t.stjm009, 
   stjm010 LIKE stjm_t.stjm010, 
   stjm011 LIKE stjm_t.stjm011, 
   stjm012 LIKE stjm_t.stjm012, 
   stjm013 LIKE stjm_t.stjm013, 
   stjm014 LIKE stjm_t.stjm014, 
   stjm015 LIKE stjm_t.stjm015, 
   stjm016 LIKE stjm_t.stjm016, 
   stjm017 LIKE stjm_t.stjm017 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sql2                STRING
TYPE type_g_stjn2_d RECORD
       stjnent LIKE stjn_t.stjnent, #企業編號
       stjnseq LIKE stjn_t.stjnseq, #項次
       stjn001 LIKE stjn_t.stjn001, #合約編號
       stjn002 LIKE stjn_t.stjn002, #分攤日期
       stjn004 LIKE stjn_t.stjn004, #資料類型
       stjn003 LIKE stjn_t.stjn003, #優惠類型	   
       stjn005 LIKE stjn_t.stjn005, #費用編號
	    stjn005_desc LIKE type_t.chr500, #費用名稱
       stjn006 LIKE stjn_t.stjn006, #费用金额
       stjn007 LIKE stjn_t.stjn007, #參考單號
       stjn008 LIKE stjn_t.stjn008  #參考單號版本
       END RECORD
#模組變數(Module Variables)
DEFINE g_stjn2_d          DYNAMIC ARRAY OF type_g_stjn2_d
DEFINE g_stjn2_d_t        type_g_stjn2_d

#INPUT 條件
DEFINE g_input     RECORD
       stjm004_s   LIKE stjm_t.stjm004,
       stjm004_e   LIKE stjm_t.stjm004
                   END RECORD       
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_stjm_d
DEFINE g_master_t                   type_g_stjm_d
DEFINE g_stjm_d          DYNAMIC ARRAY OF type_g_stjm_d
DEFINE g_stjm_d_t        type_g_stjm_d
 
      
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
 
{<section id="astq801.main" >}
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
   DECLARE astq801_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE astq801_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astq801_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astq801 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astq801_init()   
 
      #進入選單 Menu (="N")
      CALL astq801_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_astq801
      
   END IF 
   
   CLOSE astq801_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="astq801.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION astq801_init()
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
   INITIALIZE g_input.* TO NULL
   CALL cl_set_combo_scc('b_stjn004','6915')
   CALL cl_set_combo_scc('b_stjn003','6916')
   CALL s_asti800_set_comp_format("b_stjm007",g_site,'1')
   CALL s_asti800_set_comp_format("b_stjm008",g_site,'1')
   CALL s_asti800_set_comp_format("b_stjm009",g_site,'1')
   CALL s_asti800_set_comp_format("b_stjm010",g_site,'1')
   CALL s_asti800_set_comp_format("b_stjn006",g_site,'1')   
   #end add-point
 
   CALL astq801_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="astq801.default_search" >}
PRIVATE FUNCTION astq801_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
    
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
 
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " stjmseq = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " stjm001 = '", g_argv[02], "' AND "
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
 
{<section id="astq801.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION astq801_ui_dialog()
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
   DEFINE l_current_row           LIKE type_t.num10 #add by geza 20160623 #160604-00009#64 #获取当前的行数
   DEFINE l_string                STRING            #add by geza 20160623 #160604-00009#64
   DEFINE l_success               LIKE type_t.num5  #add by geza 20160623 #160604-00009#64 
   DEFINE l_stjf009               LIKE stjf_t.stjf009            #add by geza 20160623 #160604-00009#64
   DEFINE l_wc                    STRING            #add by geza 20160623 #160604-00009#64 
   #DEFINE l_where    string 
   #end add-point 
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   # CALL s_aooi500_sql_where(g_prog,'stjesite') RETURNING l_where
   #end add-point
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
         
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   LET g_wc = g_wc," AND 1=1"
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL astq801_b_fill()
   ELSE
      CALL astq801_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_stjm_d.clear()
 
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
 
         CALL astq801_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_stjm_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL astq801_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL astq801_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               CALL astq801_b_fill2()
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_stjn2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL astq801_fetch()
               LET g_action_choice = lc_action_choice_old
 
         END DISPLAY
         CONSTRUCT BY NAME g_wc  ON stjesite,stje001,stje007,stje008,stje019,stje020,stje021,stje028,stje029   #160604-00009#36 dongsz add stje001 #160604-00009#64 #mark by geza 20160624

            ON ACTION controlp INFIELD stjesite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stjesite',g_site,'c')
               CALL q_ooef001_24()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stjesite  #顯示到畫面上
               NEXT FIELD stjesite                     #返回原欄位  
               
            #160604-00009#36--dongsz add--s
            ON ACTION controlp INFIELD stje001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_stje001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stje001  #顯示到畫面上
               NEXT FIELD stje001                     #返回原欄位
            #160604-00009#36--dongsz add--e
            
            ON ACTION controlp INFIELD stje007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "('1','3')" 
               CALL q_pmaa001_1()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stje007  #顯示到畫面上
               NEXT FIELD stje007                     #返回原欄位
            
            ON ACTION controlp INFIELD stje008
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stjesite',g_site,'c')
               LET g_qryparam.where = cl_replace_str(g_qryparam.where,"ooef001","mhbesite")
               CALL q_mhbe001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stje008  #顯示到畫面上
               NEXT FIELD stje008                     #返回原欄位
            
            ON ACTION controlp INFIELD stje019
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stjesite',g_site,'c')
               LET g_qryparam.where = cl_replace_str(g_qryparam.where,"ooef001","mhaasite")
               CALL q_mhaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stje019  #顯示到畫面上
               NEXT FIELD stje019                     #返回原欄位
            
            ON ACTION controlp INFIELD stje020
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stjesite',g_site,'c')
               LET g_qryparam.where = cl_replace_str(g_qryparam.where,"ooef001","mhabsite")
               CALL q_mhab002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stje020  #顯示到畫面上
               NEXT FIELD stje020                     #返回原欄位
            
            ON ACTION controlp INFIELD stje021
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stjesite',g_site,'c')
               LET g_qryparam.where = cl_replace_str(g_qryparam.where,"ooef001","mhacsite")
               CALL q_mhac003()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stje021  #顯示到畫面上
               NEXT FIELD stje021                     #返回原欄位
            
            ON ACTION controlp INFIELD stje028
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = cl_get_para(g_enterprise,g_site,'E-CIR-0001') #
               CALL q_rtax001_3()                              #呼叫開窗
               DISPLAY g_qryparam.return1 TO stje028  #顯示到畫面上
               NEXT FIELD stje028                     #返回原欄位
            
            ON ACTION controlp INFIELD stje029
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_oocq002_2002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stje029  #顯示到畫面上
               NEXT FIELD stje029                     #返回原欄位			
                      
         END CONSTRUCT
         INPUT g_input.stjm004_s,g_input.stjm004_e
          FROM stjm004_s,stjm004_e
               ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT
               IF g_wc = " 1=2 AND 1=1" THEN
                  LET g_wc = " 1=1"
               END IF            
            AFTER FIELD stjm004_s
               IF NOT cl_null(g_input.stjm004_s) AND NOT cl_null(g_input.stjm004_e) THEN
                  IF g_input.stjm004_s > g_input.stjm004_e THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "amm-00081"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.stjm004_e = g_input.stjm004_s
                  END IF
               END IF
               
            AFTER FIELD stjm004_e
               IF NOT cl_null(g_input.stjm004_s) AND NOT cl_null(g_input.stjm004_e) THEN
                  IF g_input.stjm004_s > g_input.stjm004_e THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "amm-00081"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.stjm004_s = s_date_get_first_date(g_input.stjm004_e)
                  END IF
               END IF
            
         END INPUT         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL astq801_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("insert,query", FALSE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL astq801_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION advance_account
            LET g_action_choice="advance_account"
            IF cl_auth_chk_act("advance_account") THEN
               
               #add-point:ON ACTION advance_account name="menu.advance_account"
               #add by geza 20160623 #160604-00009#64 (S)
               IF g_stjm_d.getLength() > 0 THEN
                  INITIALIZE l_current_row TO NULL
                  LET l_current_row = DIALOG.getCurrentRow("s_detail1")
                  IF l_current_row IS NOT NULL AND g_stjm_d[l_current_row].stjm001 IS NOT NULL THEN
                     IF g_stjm_d[l_current_row].stjm015 = 'Y' THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = "ast-00820" 
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        CONTINUE DIALOG 
                     ELSE
                        SELECT DISTINCT stjf009 INTO l_stjf009
                          FROM stjf_t
                         WHERE stjfent = g_enterprise
                           AND stjf001 = g_stjm_d[l_current_row].stjm001
                           AND stjf004 = g_stjm_d[l_current_row].stjm003
                        IF l_stjf009 = '2' THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "" 
                           LET g_errparam.code   = "ast-00821" 
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           CONTINUE DIALOG 
                        ELSE
                           CALL s_transaction_begin()
                           #该账期出账
                           LET l_wc = " stjm001 = '",g_stjm_d[l_current_row].stjm001,"' AND stjmseq = '",g_stjm_d[l_current_row].stjmseq,"' "
                           #账单这一期费用单都产生
                           CALL s_astp810_insert(l_wc,'','3','N')  RETURNING l_success,l_string 
                           IF NOT l_success THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.extend = ""
                              LET g_errparam.code = 'adz-00218'
                              LET g_errparam.popup = TRUE
                              CALL cl_err() 
                              CALL s_transaction_end('N','0')
                              CONTINUE DIALOG 
                           ELSE
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.extend = ""
                              LET g_errparam.code = 'adz-00217'
                              LET g_errparam.popup = TRUE
                              CALL cl_err() 
                              CALL s_transaction_end('Y','0')                           
                           END IF
                           CALL astq801_b_fill()
                        END IF
                     END IF   
                  ELSE
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "adb-00078" 
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "std-00003" 
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG 
               
               END IF
               #add by geza 20160623 #160604-00009#64 (E)
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
            CALL astq801_filter()
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
            CALL astq801_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_stjm_d)
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
            CALL astq801_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL astq801_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL astq801_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL astq801_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION ACCEPT
            LET g_detail_idx = 1
            CALL astq801_b_fill()
            IF g_stjm_d.getLength() > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            END IF
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
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
 
{<section id="astq801.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION astq801_query()
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
   CALL g_stjm_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON stjm001,stjmseq,stjm002,stjm003,stjm004,stjm005,stjm006,stjm007,stjm008, 
          stjm009,stjm010,stjm011,stjm012,stjm013,stjm014,stjm015,stjm016,stjm017
           FROM s_detail1[1].b_stjm001,s_detail1[1].b_stjmseq,s_detail1[1].b_stjm002,s_detail1[1].b_stjm003, 
               s_detail1[1].b_stjm004,s_detail1[1].b_stjm005,s_detail1[1].b_stjm006,s_detail1[1].b_stjm007, 
               s_detail1[1].b_stjm008,s_detail1[1].b_stjm009,s_detail1[1].b_stjm010,s_detail1[1].b_stjm011, 
               s_detail1[1].b_stjm012,s_detail1[1].b_stjm013,s_detail1[1].b_stjm014,s_detail1[1].b_stjm015, 
               s_detail1[1].b_stjm016,s_detail1[1].b_stjm017
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_stjm001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjm001
            #add-point:BEFORE FIELD b_stjm001 name="construct.b.page1.b_stjm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjm001
            
            #add-point:AFTER FIELD b_stjm001 name="construct.a.page1.b_stjm001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stjm001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm001
            #add-point:ON ACTION controlp INFIELD b_stjm001 name="construct.c.page1.b_stjm001"
            
            #END add-point
 
 
         #----<<b_stje007>>----
         #----<<b_stje007_desc>>----
         #----<<b_stje008>>----
         #----<<b_stje008_desc>>----
         #----<<b_stjmseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjmseq
            #add-point:BEFORE FIELD b_stjmseq name="construct.b.page1.b_stjmseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjmseq
            
            #add-point:AFTER FIELD b_stjmseq name="construct.a.page1.b_stjmseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stjmseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjmseq
            #add-point:ON ACTION controlp INFIELD b_stjmseq name="construct.c.page1.b_stjmseq"
            
            #END add-point
 
 
         #----<<b_stjm002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjm002
            #add-point:BEFORE FIELD b_stjm002 name="construct.b.page1.b_stjm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjm002
            
            #add-point:AFTER FIELD b_stjm002 name="construct.a.page1.b_stjm002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stjm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm002
            #add-point:ON ACTION controlp INFIELD b_stjm002 name="construct.c.page1.b_stjm002"
            
            #END add-point
 
 
         #----<<b_stjm003>>----
         #Ctrlp:construct.c.page1.b_stjm003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm003
            #add-point:ON ACTION controlp INFIELD b_stjm003 name="construct.c.page1.b_stjm003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stjm003  #顯示到畫面上
            NEXT FIELD b_stjm003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjm003
            #add-point:BEFORE FIELD b_stjm003 name="construct.b.page1.b_stjm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjm003
            
            #add-point:AFTER FIELD b_stjm003 name="construct.a.page1.b_stjm003"
            
            #END add-point
            
 
 
         #----<<b_stjm003_desc>>----
         #----<<b_stjm004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjm004
            #add-point:BEFORE FIELD b_stjm004 name="construct.b.page1.b_stjm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjm004
            
            #add-point:AFTER FIELD b_stjm004 name="construct.a.page1.b_stjm004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stjm004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm004
            #add-point:ON ACTION controlp INFIELD b_stjm004 name="construct.c.page1.b_stjm004"
            
            #END add-point
 
 
         #----<<b_stjm005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjm005
            #add-point:BEFORE FIELD b_stjm005 name="construct.b.page1.b_stjm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjm005
            
            #add-point:AFTER FIELD b_stjm005 name="construct.a.page1.b_stjm005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stjm005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm005
            #add-point:ON ACTION controlp INFIELD b_stjm005 name="construct.c.page1.b_stjm005"
            
            #END add-point
 
 
         #----<<b_stjm006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjm006
            #add-point:BEFORE FIELD b_stjm006 name="construct.b.page1.b_stjm006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjm006
            
            #add-point:AFTER FIELD b_stjm006 name="construct.a.page1.b_stjm006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stjm006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm006
            #add-point:ON ACTION controlp INFIELD b_stjm006 name="construct.c.page1.b_stjm006"
            
            #END add-point
 
 
         #----<<b_stjm007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjm007
            #add-point:BEFORE FIELD b_stjm007 name="construct.b.page1.b_stjm007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjm007
            
            #add-point:AFTER FIELD b_stjm007 name="construct.a.page1.b_stjm007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stjm007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm007
            #add-point:ON ACTION controlp INFIELD b_stjm007 name="construct.c.page1.b_stjm007"
            
            #END add-point
 
 
         #----<<b_stjm008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjm008
            #add-point:BEFORE FIELD b_stjm008 name="construct.b.page1.b_stjm008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjm008
            
            #add-point:AFTER FIELD b_stjm008 name="construct.a.page1.b_stjm008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stjm008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm008
            #add-point:ON ACTION controlp INFIELD b_stjm008 name="construct.c.page1.b_stjm008"
            
            #END add-point
 
 
         #----<<b_stjm009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjm009
            #add-point:BEFORE FIELD b_stjm009 name="construct.b.page1.b_stjm009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjm009
            
            #add-point:AFTER FIELD b_stjm009 name="construct.a.page1.b_stjm009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stjm009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm009
            #add-point:ON ACTION controlp INFIELD b_stjm009 name="construct.c.page1.b_stjm009"
            
            #END add-point
 
 
         #----<<b_stjm010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjm010
            #add-point:BEFORE FIELD b_stjm010 name="construct.b.page1.b_stjm010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjm010
            
            #add-point:AFTER FIELD b_stjm010 name="construct.a.page1.b_stjm010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stjm010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm010
            #add-point:ON ACTION controlp INFIELD b_stjm010 name="construct.c.page1.b_stjm010"
            
            #END add-point
 
 
         #----<<b_stjm011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjm011
            #add-point:BEFORE FIELD b_stjm011 name="construct.b.page1.b_stjm011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjm011
            
            #add-point:AFTER FIELD b_stjm011 name="construct.a.page1.b_stjm011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stjm011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm011
            #add-point:ON ACTION controlp INFIELD b_stjm011 name="construct.c.page1.b_stjm011"
            
            #END add-point
 
 
         #----<<b_stjm012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjm012
            #add-point:BEFORE FIELD b_stjm012 name="construct.b.page1.b_stjm012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjm012
            
            #add-point:AFTER FIELD b_stjm012 name="construct.a.page1.b_stjm012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stjm012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm012
            #add-point:ON ACTION controlp INFIELD b_stjm012 name="construct.c.page1.b_stjm012"
            
            #END add-point
 
 
         #----<<b_stjm013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjm013
            #add-point:BEFORE FIELD b_stjm013 name="construct.b.page1.b_stjm013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjm013
            
            #add-point:AFTER FIELD b_stjm013 name="construct.a.page1.b_stjm013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stjm013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm013
            #add-point:ON ACTION controlp INFIELD b_stjm013 name="construct.c.page1.b_stjm013"
            
            #END add-point
 
 
         #----<<b_stjm014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjm014
            #add-point:BEFORE FIELD b_stjm014 name="construct.b.page1.b_stjm014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjm014
            
            #add-point:AFTER FIELD b_stjm014 name="construct.a.page1.b_stjm014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stjm014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm014
            #add-point:ON ACTION controlp INFIELD b_stjm014 name="construct.c.page1.b_stjm014"
            
            #END add-point
 
 
         #----<<b_stjm015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjm015
            #add-point:BEFORE FIELD b_stjm015 name="construct.b.page1.b_stjm015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjm015
            
            #add-point:AFTER FIELD b_stjm015 name="construct.a.page1.b_stjm015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stjm015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm015
            #add-point:ON ACTION controlp INFIELD b_stjm015 name="construct.c.page1.b_stjm015"
            
            #END add-point
 
 
         #----<<b_stjm016>>----
         #Ctrlp:construct.c.page1.b_stjm016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm016
            #add-point:ON ACTION controlp INFIELD b_stjm016 name="construct.c.page1.b_stjm016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stjm016  #顯示到畫面上
            NEXT FIELD b_stjm016                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjm016
            #add-point:BEFORE FIELD b_stjm016 name="construct.b.page1.b_stjm016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjm016
            
            #add-point:AFTER FIELD b_stjm016 name="construct.a.page1.b_stjm016"
            
            #END add-point
            
 
 
         #----<<b_stjm017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stjm017
            #add-point:BEFORE FIELD b_stjm017 name="construct.b.page1.b_stjm017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stjm017
            
            #add-point:AFTER FIELD b_stjm017 name="construct.a.page1.b_stjm017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stjm017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm017
            #add-point:ON ACTION controlp INFIELD b_stjm017 name="construct.c.page1.b_stjm017"
            
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
   CALL astq801_b_fill()
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
 
{<section id="astq801.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astq801_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'stjesite') RETURNING l_where
   #add by geza 20160623 #160604-00009#64  (S)
   IF g_wc = " 1=2" THEN
      LET g_wc = " 1=1"
   END IF
   #add by geza 20160623 #160604-00009#64  (E)
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
 
   LET ls_sql_rank = "SELECT  UNIQUE stjm001,'','','','',stjmseq,stjm002,stjm003,'',stjm004,stjm005, 
       stjm006,stjm007,stjm008,stjm009,stjm010,stjm011,stjm012,stjm013,stjm014,stjm015,stjm016,stjm017  , 
       DENSE_RANK() OVER( ORDER BY stjm_t.stjmseq,stjm_t.stjm001) AS RANK FROM stjm_t",
 
 
                     "",
                     " WHERE stjment= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("stjm_t"),
                     " ORDER BY stjm_t.stjmseq,stjm_t.stjm001"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_wc = ls_wc CLIPPED," AND ",l_where
   IF NOT cl_null(g_input.stjm004_s) AND NOT cl_null(g_input.stjm004_e) THEN
      LET ls_wc = ls_wc CLIPPED," AND stjm004 BETWEEN '",g_input.stjm004_s,"' AND '",g_input.stjm004_e,"'"
   END IF   
   #160604-00009#36--dongsz mark-s
#   LET ls_sql_rank = "SELECT  UNIQUE stjm001,stjmseq,stjm002,stjm003,",
#                     "               (SELECT stael003 FROM stael_t WHERE staelent = stjment AND stael001 = stjm003 AND stael002='"||g_dlang||"') stjm003_desc,",
#                     "               stjm004,stjm005,stjm006,stjm007, ",
#                     "               stjm008,stjm009,stjm010,stjm011,stjm012,stjm013,stjm014,stjm015,    ",
#                     "               stjm016,stjm017  ,DENSE_RANK() OVER( ORDER BY stjm_t.stjmseq,       ",
#                     "               stjm_t.stjm001) AS RANK",
#                     "  FROM stje_t ",
#                     "  LEFT JOIN stjm_t ON stjeent = stjment AND stje001 = stjm001 ",
#                     " WHERE stjment= ? AND 1=1 AND ", ls_wc
#    
#   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("stjm_t"),
#                     " ORDER BY stjm_t.stjmseq,stjm_t.stjm001"
   #160604-00009#36--dongsz mark-e
   #160604-00009#36--dongsz add-s
   LET ls_sql_rank = "SELECT  UNIQUE stjm001,stje007, ",
                     "               (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = stjeent AND pmaal001 = stje007 AND pmaal002='"||g_dlang||"') stje007_desc, ",
                     "               stje008, ",
                     "               (SELECT mhbel003 FROM mhbel_t WHERE mhbelent = stjeent AND mhbel001 = stje008 AND mhbel002='"||g_dlang||"') stje008_desc, ",
                     "               stjmseq,stjm002,stjm003,",
                     "               (SELECT stael003 FROM stael_t WHERE staelent = stjment AND stael001 = stjm003 AND stael002='"||g_dlang||"') stjm003_desc,",
                     "               stjm004,stjm005,stjm006,stjm007, ",
                     "               stjm008,stjm009,stjm010,stjm011,stjm012,stjm013,stjm014,stjm015,    ",
                     "               stjm016,stjm017  ,DENSE_RANK() OVER( ORDER BY stjm_t.stjmseq,       ",
                     "               stjm_t.stjm001) AS RANK",
                     "  FROM stje_t ",
                     "  LEFT JOIN stjm_t ON stjeent = stjment AND stje001 = stjm001 ",
                     " WHERE stjment= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("stjm_t"),
                     " ORDER BY stjm_t.stjm001,stje_t.stje007,stje_t.stje008,stjm_t.stjmseq "
   #160604-00009#36--dongsz add-e
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
 
   LET g_sql = "SELECT stjm001,'','','','',stjmseq,stjm002,stjm003,'',stjm004,stjm005,stjm006,stjm007, 
       stjm008,stjm009,stjm010,stjm011,stjm012,stjm013,stjm014,stjm015,stjm016,stjm017",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #160604-00009#36--dongsz mark-s
#   LET g_sql = "SELECT stjm001,stjmseq,stjm002,stjm003,",
#               "       stjm003_desc, ",
#               "       stjm004,stjm005,stjm006,stjm007,",
#               "       stjm008,stjm009,stjm010,stjm011,stjm012,stjm013,stjm014,stjm015,",
#               "       stjm016,stjm017",
#               " FROM (",ls_sql_rank,")",
#               " WHERE RANK >= ",g_pagestart,
#               " AND RANK < ",g_pagestart + g_num_in_page 
   #160604-00009#36--dongsz mark-e    
   #160604-00009#36--dongsz add-s
   LET g_sql = "SELECT stjm001,stje007,stje007_desc,stje008,stje008_desc, ",
               "       stjmseq,stjm002,stjm003,",
               "       stjm003_desc, ",
               "       stjm004,stjm005,stjm006,stjm007,",
               "       stjm008,stjm009,stjm010,stjm011,stjm012,stjm013,stjm014,stjm015,",
               "       stjm016,stjm017",
               " FROM (",ls_sql_rank,")",
               " WHERE RANK >= ",g_pagestart,
               " AND RANK < ",g_pagestart + g_num_in_page 
   #160604-00009#36--dongsz add-e               
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE astq801_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR astq801_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_stjm_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_stjm_d[l_ac].stjm001,g_stjm_d[l_ac].stje007,g_stjm_d[l_ac].stje007_desc, 
       g_stjm_d[l_ac].stje008,g_stjm_d[l_ac].stje008_desc,g_stjm_d[l_ac].stjmseq,g_stjm_d[l_ac].stjm002, 
       g_stjm_d[l_ac].stjm003,g_stjm_d[l_ac].stjm003_desc,g_stjm_d[l_ac].stjm004,g_stjm_d[l_ac].stjm005, 
       g_stjm_d[l_ac].stjm006,g_stjm_d[l_ac].stjm007,g_stjm_d[l_ac].stjm008,g_stjm_d[l_ac].stjm009,g_stjm_d[l_ac].stjm010, 
       g_stjm_d[l_ac].stjm011,g_stjm_d[l_ac].stjm012,g_stjm_d[l_ac].stjm013,g_stjm_d[l_ac].stjm014,g_stjm_d[l_ac].stjm015, 
       g_stjm_d[l_ac].stjm016,g_stjm_d[l_ac].stjm017
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_stjm_d[l_ac].statepic = cl_get_actipic(g_stjm_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL astq801_detail_show("'1'")      
 
      CALL astq801_stjm_t_mask()
 
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
   
 
   
   CALL g_stjm_d.deleteElement(g_stjm_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   CALL astq801_b_fill2()
   #end add-point
 
   LET g_detail_cnt = g_stjm_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE astq801_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL astq801_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL astq801_detail_action_trans()
 
   IF g_stjm_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL astq801_fetch()
   END IF
   
      CALL astq801_filter_show('stjm001','b_stjm001')
   CALL astq801_filter_show('stjmseq','b_stjmseq')
   CALL astq801_filter_show('stjm002','b_stjm002')
   CALL astq801_filter_show('stjm003','b_stjm003')
   CALL astq801_filter_show('stjm004','b_stjm004')
   CALL astq801_filter_show('stjm005','b_stjm005')
   CALL astq801_filter_show('stjm006','b_stjm006')
   CALL astq801_filter_show('stjm007','b_stjm007')
   CALL astq801_filter_show('stjm008','b_stjm008')
   CALL astq801_filter_show('stjm009','b_stjm009')
   CALL astq801_filter_show('stjm010','b_stjm010')
   CALL astq801_filter_show('stjm011','b_stjm011')
   CALL astq801_filter_show('stjm012','b_stjm012')
   CALL astq801_filter_show('stjm013','b_stjm013')
   CALL astq801_filter_show('stjm014','b_stjm014')
   CALL astq801_filter_show('stjm015','b_stjm015')
   CALL astq801_filter_show('stjm016','b_stjm016')
   CALL astq801_filter_show('stjm017','b_stjm017')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astq801.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astq801_fetch()
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
 
{<section id="astq801.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION astq801_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_stjm_d[l_ac].stjm003
            LET ls_sql = "SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stjm_d[l_ac].stjm003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stjm_d[l_ac].stjm003_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astq801.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION astq801_filter()
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
      CONSTRUCT g_wc_filter ON stjm001,stjmseq,stjm002,stjm003,stjm004,stjm005,stjm006,stjm007,stjm008, 
          stjm009,stjm010,stjm011,stjm012,stjm013,stjm014,stjm015,stjm016,stjm017
                          FROM s_detail1[1].b_stjm001,s_detail1[1].b_stjmseq,s_detail1[1].b_stjm002, 
                              s_detail1[1].b_stjm003,s_detail1[1].b_stjm004,s_detail1[1].b_stjm005,s_detail1[1].b_stjm006, 
                              s_detail1[1].b_stjm007,s_detail1[1].b_stjm008,s_detail1[1].b_stjm009,s_detail1[1].b_stjm010, 
                              s_detail1[1].b_stjm011,s_detail1[1].b_stjm012,s_detail1[1].b_stjm013,s_detail1[1].b_stjm014, 
                              s_detail1[1].b_stjm015,s_detail1[1].b_stjm016,s_detail1[1].b_stjm017
 
         BEFORE CONSTRUCT
                     DISPLAY astq801_filter_parser('stjm001') TO s_detail1[1].b_stjm001
            DISPLAY astq801_filter_parser('stjmseq') TO s_detail1[1].b_stjmseq
            DISPLAY astq801_filter_parser('stjm002') TO s_detail1[1].b_stjm002
            DISPLAY astq801_filter_parser('stjm003') TO s_detail1[1].b_stjm003
            DISPLAY astq801_filter_parser('stjm004') TO s_detail1[1].b_stjm004
            DISPLAY astq801_filter_parser('stjm005') TO s_detail1[1].b_stjm005
            DISPLAY astq801_filter_parser('stjm006') TO s_detail1[1].b_stjm006
            DISPLAY astq801_filter_parser('stjm007') TO s_detail1[1].b_stjm007
            DISPLAY astq801_filter_parser('stjm008') TO s_detail1[1].b_stjm008
            DISPLAY astq801_filter_parser('stjm009') TO s_detail1[1].b_stjm009
            DISPLAY astq801_filter_parser('stjm010') TO s_detail1[1].b_stjm010
            DISPLAY astq801_filter_parser('stjm011') TO s_detail1[1].b_stjm011
            DISPLAY astq801_filter_parser('stjm012') TO s_detail1[1].b_stjm012
            DISPLAY astq801_filter_parser('stjm013') TO s_detail1[1].b_stjm013
            DISPLAY astq801_filter_parser('stjm014') TO s_detail1[1].b_stjm014
            DISPLAY astq801_filter_parser('stjm015') TO s_detail1[1].b_stjm015
            DISPLAY astq801_filter_parser('stjm016') TO s_detail1[1].b_stjm016
            DISPLAY astq801_filter_parser('stjm017') TO s_detail1[1].b_stjm017
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_stjm001>>----
         #Ctrlp:construct.c.filter.page1.b_stjm001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm001
            #add-point:ON ACTION controlp INFIELD b_stjm001 name="construct.c.filter.page1.b_stjm001"
            
            #END add-point
 
 
         #----<<b_stje007>>----
         #----<<b_stje007_desc>>----
         #----<<b_stje008>>----
         #----<<b_stje008_desc>>----
         #----<<b_stjmseq>>----
         #Ctrlp:construct.c.filter.page1.b_stjmseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjmseq
            #add-point:ON ACTION controlp INFIELD b_stjmseq name="construct.c.filter.page1.b_stjmseq"
            
            #END add-point
 
 
         #----<<b_stjm002>>----
         #Ctrlp:construct.c.filter.page1.b_stjm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm002
            #add-point:ON ACTION controlp INFIELD b_stjm002 name="construct.c.filter.page1.b_stjm002"
            
            #END add-point
 
 
         #----<<b_stjm003>>----
         #Ctrlp:construct.c.page1.b_stjm003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm003
            #add-point:ON ACTION controlp INFIELD b_stjm003 name="construct.c.filter.page1.b_stjm003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stjm003  #顯示到畫面上
            NEXT FIELD b_stjm003                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_stjm003_desc>>----
         #----<<b_stjm004>>----
         #Ctrlp:construct.c.filter.page1.b_stjm004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm004
            #add-point:ON ACTION controlp INFIELD b_stjm004 name="construct.c.filter.page1.b_stjm004"
            
            #END add-point
 
 
         #----<<b_stjm005>>----
         #Ctrlp:construct.c.filter.page1.b_stjm005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm005
            #add-point:ON ACTION controlp INFIELD b_stjm005 name="construct.c.filter.page1.b_stjm005"
            
            #END add-point
 
 
         #----<<b_stjm006>>----
         #Ctrlp:construct.c.filter.page1.b_stjm006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm006
            #add-point:ON ACTION controlp INFIELD b_stjm006 name="construct.c.filter.page1.b_stjm006"
            
            #END add-point
 
 
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
 
 
         #----<<b_stjm009>>----
         #Ctrlp:construct.c.filter.page1.b_stjm009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm009
            #add-point:ON ACTION controlp INFIELD b_stjm009 name="construct.c.filter.page1.b_stjm009"
            
            #END add-point
 
 
         #----<<b_stjm010>>----
         #Ctrlp:construct.c.filter.page1.b_stjm010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm010
            #add-point:ON ACTION controlp INFIELD b_stjm010 name="construct.c.filter.page1.b_stjm010"
            
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
 
 
         #----<<b_stjm014>>----
         #Ctrlp:construct.c.filter.page1.b_stjm014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm014
            #add-point:ON ACTION controlp INFIELD b_stjm014 name="construct.c.filter.page1.b_stjm014"
            
            #END add-point
 
 
         #----<<b_stjm015>>----
         #Ctrlp:construct.c.filter.page1.b_stjm015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm015
            #add-point:ON ACTION controlp INFIELD b_stjm015 name="construct.c.filter.page1.b_stjm015"
            
            #END add-point
 
 
         #----<<b_stjm016>>----
         #Ctrlp:construct.c.page1.b_stjm016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm016
            #add-point:ON ACTION controlp INFIELD b_stjm016 name="construct.c.filter.page1.b_stjm016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stjm016  #顯示到畫面上
            NEXT FIELD b_stjm016                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_stjm017>>----
         #Ctrlp:construct.c.filter.page1.b_stjm017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjm017
            #add-point:ON ACTION controlp INFIELD b_stjm017 name="construct.c.filter.page1.b_stjm017"
            
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
   
      CALL astq801_filter_show('stjm001','b_stjm001')
   CALL astq801_filter_show('stjmseq','b_stjmseq')
   CALL astq801_filter_show('stjm002','b_stjm002')
   CALL astq801_filter_show('stjm003','b_stjm003')
   CALL astq801_filter_show('stjm004','b_stjm004')
   CALL astq801_filter_show('stjm005','b_stjm005')
   CALL astq801_filter_show('stjm006','b_stjm006')
   CALL astq801_filter_show('stjm007','b_stjm007')
   CALL astq801_filter_show('stjm008','b_stjm008')
   CALL astq801_filter_show('stjm009','b_stjm009')
   CALL astq801_filter_show('stjm010','b_stjm010')
   CALL astq801_filter_show('stjm011','b_stjm011')
   CALL astq801_filter_show('stjm012','b_stjm012')
   CALL astq801_filter_show('stjm013','b_stjm013')
   CALL astq801_filter_show('stjm014','b_stjm014')
   CALL astq801_filter_show('stjm015','b_stjm015')
   CALL astq801_filter_show('stjm016','b_stjm016')
   CALL astq801_filter_show('stjm017','b_stjm017')
 
    
   CALL astq801_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="astq801.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION astq801_filter_parser(ps_field)
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
 
{<section id="astq801.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION astq801_filter_show(ps_field,ps_object)
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
   LET ls_condition = astq801_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="astq801.insert" >}
#+ insert
PRIVATE FUNCTION astq801_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="astq801.modify" >}
#+ modify
PRIVATE FUNCTION astq801_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astq801.reproduce" >}
#+ reproduce
PRIVATE FUNCTION astq801_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astq801.delete" >}
#+ delete
PRIVATE FUNCTION astq801_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astq801.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION astq801_detail_action_trans()
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
 
{<section id="astq801.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION astq801_detail_index_setting()
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
            IF g_stjm_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_stjm_d.getLength() AND g_stjm_d.getLength() > 0
            LET g_detail_idx = g_stjm_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_stjm_d.getLength() THEN
               LET g_detail_idx = g_stjm_d.getLength()
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
 
{<section id="astq801.mask_functions" >}
 &include "erp/ast/astq801_mask.4gl"
 
{</section>}
 
{<section id="astq801.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 日核算明细
# Memo...........:
# Usage..........: CALL astq801_b_fill2()
# Input parameter: 
# Date & Author..: 20160519 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION astq801_b_fill2()
   DEFINE li_ac           LIKE type_t.num10
   DEFINE l_sql           STRING
   
   LET li_ac = l_ac

   IF g_current_page = 1 THEN
      CALL g_stjn2_d.clear()
   END IF
   
   #FOREACH
   LET g_sql = "SELECT  DISTINCT stjnent,stjnseq,stjn001,stjn002,stjn004,stjn003,stjn005,",
               "        (SELECT stael003 FROM stael_t WHERE staelent = stjnent AND stael001 = stjn005 AND stael002='"||g_dlang||"') stjn005_desc,",
               "        stjn006,stjn007,stjn008 ",
               "  FROM stjn_t ",
               " WHERE stjnent = ? AND stjn001 = ?"  
   IF g_stjm_d.getLength() > 0 AND g_stjm_d[g_detail_idx].stjmseq IS NOT NULL THEN
   
      LET g_sql = g_sql CLIPPED," AND stjn002 BETWEEN '",g_stjm_d[g_detail_idx].stjm005,"' AND '",g_stjm_d[g_detail_idx].stjm006,"' ",
	                             " AND stjn005 = '",g_stjm_d[g_detail_idx].stjm003,"'"
   END IF
   LET g_sql = g_sql, " ORDER BY stjn_t.stjnseq"
   
   PREPARE astq801_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR astq801_pb1
   
   OPEN b_fill_curs1 USING g_enterprise,g_stjm_d[g_detail_idx].stjm001
   LET li_ac = 1
   FOREACH b_fill_curs1 INTO g_stjn2_d[li_ac].stjnent,g_stjn2_d[li_ac].stjnseq,g_stjn2_d[li_ac].stjn001,g_stjn2_d[li_ac].stjn002,
                             g_stjn2_d[li_ac].stjn004,g_stjn2_d[li_ac].stjn003,g_stjn2_d[li_ac].stjn005,g_stjn2_d[li_ac].stjn005_desc,
							        g_stjn2_d[li_ac].stjn006,g_stjn2_d[li_ac].stjn007,g_stjn2_d[li_ac].stjn008
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:b_fill_curs1" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      LET li_ac = li_ac + 1
      IF li_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9035
               LET g_errparam.extend =  ""
               LET g_errparam.popup = TRUE
               CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   CALL g_stjn2_d.deleteElement(g_stjn2_d.getLength())
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
END FUNCTION

 
{</section>}
 
