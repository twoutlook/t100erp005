#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq711.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-12-06 10:34:16), PR版次:0001(2017-01-05 18:28:06)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aglq711
#+ Description: 帳款客商餘額表查詢作業
#+ Creator....: 02114(2016-12-06 10:34:16)
#+ Modifier...: 02114 -SD/PR- 02114
 
{</section>}
 
{<section id="aglq711.global" >}
#應用 q04 樣板自動產生(Version:32)
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
 
#單頭 type 宣告
PRIVATE type type_g_master        RECORD
       glaald LIKE type_t.chr5, 
   glaald_desc LIKE type_t.chr80, 
   glaacomp LIKE type_t.chr10, 
   glaacomp_desc LIKE type_t.chr80, 
   glaa001 LIKE type_t.chr500, 
   glaa016 LIKE type_t.chr500, 
   glaa020 LIKE type_t.chr500, 
   year LIKE type_t.num5, 
   curr_o LIKE type_t.chr500, 
   show_acc LIKE type_t.chr500, 
   smm LIKE type_t.num5, 
   emm LIKE type_t.num5, 
   stus LIKE type_t.chr500, 
   curr_p LIKE type_t.chr500, 
   acc_p LIKE type_t.chr500, 
   ctype LIKE type_t.chr500
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       sel LIKE type_t.chr1, 
   glar001 LIKE glar_t.glar001, 
   glar001_desc LIKE type_t.chr500, 
   glar017 LIKE glar_t.glar017, 
   glar017_desc LIKE type_t.chr500, 
   glar009 LIKE type_t.chr10, 
   dir1 LIKE type_t.chr500, 
   oqc LIKE type_t.num20_6, 
   qc LIKE type_t.num20_6, 
   qc2 LIKE type_t.num20_6, 
   qc3 LIKE type_t.num20_6, 
   oqjd LIKE type_t.num20_6, 
   oqjc LIKE type_t.num20_6, 
   qjd LIKE type_t.num20_6, 
   qjc LIKE type_t.num20_6, 
   qjd2 LIKE type_t.num20_6, 
   qjc2 LIKE type_t.num20_6, 
   qjd3 LIKE type_t.num20_6, 
   qjc3 LIKE type_t.num20_6, 
   dir2 LIKE type_t.chr500, 
   oqm LIKE type_t.num20_6, 
   qm LIKE type_t.num20_6, 
   qm2 LIKE type_t.num20_6, 
   qm3 LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#依据当前账别，抓取账别所归属的法人，使用币别，汇率参照表号，会计科目参照表号
DEFINE g_bookno        LIKE glap_t.glapld
DEFINE g_glaald        LIKE glaa_t.glaald
DEFINE g_glaald_desc   LIKE glaal_t.glaal002
DEFINE g_glaacomp      LIKE glaa_t.glaacomp
DEFINE g_glaacomp_desc LIKE ooefl_t.ooefl003
DEFINE g_glaa001       LIKE glaa_t.glaa001
DEFINE g_glaa002       LIKE glaa_t.glaa002
DEFINE g_glaa003       LIKE glaa_t.glaa003
DEFINE g_glaa004       LIKE glaa_t.glaa004
DEFINE g_glaa013       LIKE glaa_t.glaa013
DEFINE g_glaa015       LIKE glaa_t.glaa015
DEFINE g_glaa016       LIKE glaa_t.glaa016
DEFINE g_glaa017       LIKE glaa_t.glaa017
DEFINE g_glaa018       LIKE glaa_t.glaa018
DEFINE g_glaa019       LIKE glaa_t.glaa019
DEFINE g_glaa020       LIKE glaa_t.glaa020
DEFINE g_glaa021       LIKE glaa_t.glaa021
DEFINE g_glaa022       LIKE glaa_t.glaa022
DEFINE g_glar001       LIKE glar_t.glar001
DEFINE g_glar009       LIKE glar_t.glar009
DEFINE g_glar_s        DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
       glar009         LIKE glar_t.glar009,
       glar001         LIKE glar_t.glar001
      END RECORD 
DEFINE g_xg_visible    STRING     #XG欄位隱藏條件
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master            type_g_master
DEFINE g_master_t          type_g_master
 
   
 
DEFINE g_detail            DYNAMIC ARRAY OF type_g_detail
DEFINE g_detail_t          type_g_detail
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_cnt_sql             STRING                        #組 sql 用 
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
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_msg                 STRING
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_row_count           LIKE type_t.num10
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
DEFINE g_master_row_move     LIKE type_t.chr1              #是否為單頭筆數更動
 
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
 
{<section id="aglq711.main" >}
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
   CALL cl_ap_init("agl","")
 
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
   DECLARE aglq711_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq711_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq711_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq711 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq711_init()   
 
      #進入選單 Menu (="N")
      CALL aglq711_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq711
      
   END IF 
   
   CLOSE aglq711_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE aglq711_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq711.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aglq711_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_pass      LIKE type_t.num5
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_master_row_move = "Y"
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_detail_idx  = 1
   CALL cl_set_combo_scc('stus','9922')
   CALL cl_set_combo_scc('dir1','9926')
   CALL cl_set_combo_scc('dir2','9926')
   #获取账别
   IF cl_null(g_master.glaald) THEN
      CALL s_ld_bookno()  RETURNING l_success,g_master.glaald
      IF l_success = FALSE THEN
         RETURN 
      END IF 
      CALL s_ld_chk_authorization(g_user,g_master.glaald) RETURNING l_pass
      IF l_pass = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00164'
         LET g_errparam.extend = g_master.glaald
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
   END IF    
   CALL aglq711_glaald_desc(g_master.glaald)
   CALL aglq711_set_default_value()
   CALL aglq711_create_tmp() RETURNING l_success
   #end add-point
 
   CALL aglq711_default_search()
END FUNCTION
 
{</section>}
 
{<section id="aglq711.default_search" >}
PRIVATE FUNCTION aglq711_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   
 
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
 
{<section id="aglq711.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq711_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old    STRING
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_glav006_max   LIKE glav_t.glav006
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_pass          LIKE type_t.num5
   DEFINE l_n             LIKE type_t.num5
   #end add-point
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   LET g_wc = " 1=1"
   #end add-point
 
   CLEAR FORM  
 
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
   LET g_master_row_move = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL aglq711_cs()
   END IF
 
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         INITIALIZE g_master.* TO NULL
         CALL g_detail.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_master_row_move = "Y"
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL aglq711_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.year,g_master.smm,g_master.emm,g_master.ctype,
                       g_master.stus,g_master.curr_o,g_master.curr_p,
                       g_master.show_acc,g_master.acc_p
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
             
            AFTER FIELD smm
               IF NOT cl_null(g_master.smm) THEN 
                  LET l_glav006_max = ''
                  SELECT MAX(glav006) INTO l_glav006_max
                    FROM glav_t
                   WHERE glavent = g_enterprise 
                     AND glav001 = g_glaa003 
                     AND glav002 = g_master.year     
               
                  IF g_master.smm < 1 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00266'
                     LET g_errparam.extend = g_master.smm
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.smm = ''
                     NEXT FIELD smm
                  END IF
                  
                  IF g_master.smm > l_glav006_max THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00267'
                     LET g_errparam.extend = g_master.smm
                     LET g_errparam.replace[1] = l_glav006_max
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.smm = ''
                     NEXT FIELD smm
                  END IF
                  
                  IF g_master.smm > g_master.emm THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00227'
                     LET g_errparam.extend = g_master.smm
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.smm = ''
                     NEXT FIELD smm
                  END IF
               END IF
               
            AFTER FIELD emm
               IF NOT cl_null(g_master.emm) THEN 
                  LET l_glav006_max = ''
                  SELECT MAX(glav006) INTO l_glav006_max
                    FROM glav_t
                   WHERE glavent = g_enterprise 
                     AND glav001 = g_glaa003 
                     AND glav002 = g_master.year      
                  
                  IF g_master.emm < 1 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00266'
                     LET g_errparam.extend = g_master.emm
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.emm = ''
                     NEXT FIELD emm
                  END IF
                  
                  IF g_master.emm > l_glav006_max THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00267'
                     LET g_errparam.extend = g_master.emm
                     LET g_errparam.replace[1] = l_glav006_max
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.emm = ''
                     NEXT FIELD emm
                  END IF
                  
                  IF g_master.emm < g_master.smm THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00228'
                     LET g_errparam.extend = g_master.emm
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.emm = ''
                     NEXT FIELD emm
                  END IF
               END IF
         
            ON CHANGE ctype
               IF g_master.ctype MATCHES '[0123]' THEN
                  CALL aglq711_set_curr_show()
               ELSE
                  NEXT FIELD ctype
               END IF
            
            ON CHANGE curr_o 
               IF g_master.curr_o MATCHES '[yYnN]' THEN
                  IF g_master.curr_o = 'Y' THEN
                     CALL cl_set_comp_visible('glar009,oqc,oqjd,oqjc,oqm',TRUE)
                     CALL aglq711_set_comp_entry('curr_p',TRUE)
                  ELSE
                     CALL cl_set_comp_visible('glar009,oqc,oqjd,oqjc,oqm',FALSE)
                     CALL aglq711_set_comp_entry('curr_p',FALSE)
                     LET g_master.curr_p = 'N'
                     DISPLAY g_master.curr_p TO curr_p
                  END IF                  
               ELSE
                  NEXT FIELD curr_o
               END IF
               
            ON CHANGE show_acc
               IF g_master.show_acc MATCHES '[yYnN]' THEN
                  IF g_master.show_acc = 'Y' THEN
                     CALL cl_set_comp_visible('b_glar001,b_glar001_desc',TRUE)
                     CALL aglq711_set_comp_entry('acc_p',TRUE)
                  ELSE
                     CALL cl_set_comp_visible('b_glar001,b_glar001_desc',FALSE)
                     CALL aglq711_set_comp_entry('acc_p',FALSE)
                     LET g_master.curr_p = 'N'
                     DISPLAY g_master.curr_p TO curr_p
                  END IF                  
               ELSE
                  NEXT FIELD show_acc
               END IF

         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON glar001
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD glar001
            #add-point:ON ACTION controlp INFIELD b_glar001
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND glac006 = '1'"
            #CALL aglt310_04()                           #呼叫開窗
            LET g_qryparam.where = " glad027 = 'Y' "
            LET g_qryparam.arg1 = g_master.glaald
            CALL q_glad001_1()
            DISPLAY g_qryparam.return1 TO glar001  #顯示到畫面上

            NEXT FIELD glar001                     #返回原欄位
         END CONSTRUCT
         
         
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aglq711_detail_action_trans()
               LET g_master_idx = l_ac
               CALL aglq711_b_fill2()
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段define name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL aglq711_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL aglq711_set_default_value()
            NEXT FIELD year
            #end add-point
            NEXT FIELD edit_1
 
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
            CALL aglq711_get_data()
            CALL aglq711_set_page()
            CALL aglq711_fetch("F")
            
            SELECT COUNT(1) INTO l_n
              FROM aglq711_tmp
            
            IF l_n = 0 THEN 
               DISPLAY '' TO FORMONLY.h_index
               DISPLAY '' TO FORMONLY.h_count
               DISPLAY '' TO FORMONLY.idx
               DISPLAY '' TO FORMONLY.cnt
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = '-100' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF

            #end add-point
 
            CALL aglq711_cs()
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_detail)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq711_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
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
 
         ON ACTION datainfo   #串查至主維護程式
            #add-point:ON ACTION datainfo name="ui_dialog.datainfo"
            
            #end add-point
            CALL aglq711_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq711_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq711_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq711_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq711_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq711_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL aglq711_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL aglq711_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL aglq711_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL aglq711_b_fill()
 
         
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
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
               CALL aglq711_output()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aglq711_output()
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
         ON ACTION exchange_ld
            LET g_action_choice="exchange_ld"
            IF cl_auth_chk_act("exchange_ld") THEN
               
               #add-point:ON ACTION exchange_ld name="menu.exchange_ld"
               CALL aglt310_01(g_master.glaald) RETURNING g_bookno
               IF g_master.glaald <> g_bookno THEN
                  CLEAR FORM
                  CALL g_glar_s.clear()
                  CALL g_detail.clear()
               END IF
               LET g_master.glaald = g_bookno
               #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
               CALL aglq711_glaald_desc(g_master.glaald)
               CALL aglq711_show()
               IF cl_null(g_wc) THEN
                  LET g_wc = " 1=1 "
               END IF 
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
            CALL aglq711_set_default_value()
            #end add-point 
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point 
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aglq711.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION aglq711_cs()
   #add-point:cs段define-客製 name="cs.define_customerization"
   
   #end add-point
   #add-point:cs段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="cs.before_function"
   RETURN
   #end add-point
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF g_wc2 = " 1=1" THEN
      #add-point:cs段單頭sql組成(未下單身條件) name="cs.sql_define_1"
      LET g_sql = "SELECT COUNT(1) FROM aglq711_tmp"
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件) name="cs.sql_define_2"
      LET g_sql = "SELECT COUNT(1) FROM aglq711_tmp"
      #end add-point
   END IF
 
   PREPARE aglq711_pre FROM g_sql
   DECLARE aglq711_curs SCROLL CURSOR WITH HOLD FOR aglq711_pre
   OPEN aglq711_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   
   #end add-point
   PREPARE aglq711_precount FROM g_cnt_sql
   EXECUTE aglq711_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL aglq711_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="aglq711.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION aglq711_fetch(p_flag)
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:3)
   #add-point:fetch段CURSOR移動 name="fetch.cursor_action"
 
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO glaald,glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020,year,curr_o, 
          show_acc,smm,emm,stus,curr_p,acc_p,ctype
      CALL g_detail.clear()
 
      #add-point:陣列清空 name="fetch.array_clear"
      
      #end add-point
      DISPLAY '' TO FORMONLY.h_index
      DISPLAY '' TO FORMONLY.h_count
      DISPLAY '' TO FORMONLY.idx
      DISPLAY '' TO FORMONLY.cnt
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = '-100' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   ELSE
      CASE p_flag
         WHEN 'F' LET g_current_idx = 1
         WHEN 'P' LET g_current_idx = g_current_idx - 1
         WHEN 'N' LET g_current_idx = g_current_idx + 1
         WHEN 'L' LET g_current_idx = g_row_count
         WHEN '/' LET g_current_idx = g_jump
      END CASE
      DISPLAY g_current_idx TO FORMONLY.h_index
      DISPLAY g_row_count TO FORMONLY.h_count
      CALL cl_navigator_setting( g_current_idx, g_row_count )
   END IF
 
   #add-point:fetch結束前 name="fetch.after"
   LET g_glar009 = g_glar_s[g_current_idx].glar009 
   LET g_glar001 = g_glar_s[g_current_idx].glar001
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL aglq711_show()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq711.show" >}
PRIVATE FUNCTION aglq711_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO glaald,glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020,year,curr_o, 
       show_acc,smm,emm,stus,curr_p,acc_p,ctype
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL aglq711_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq711.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq711_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_glar017_desc  STRING
   DEFINE l_sql           STRING
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   #账款客商
   CALL s_fin_get_trading_partner_abbr_sql('ta8','glarent','glar017') RETURNING l_glar017_desc
   
   IF g_master.show_acc = 'Y' THEN 
      LET g_sql = "SELECT UNIQUE glar001,t01.glacl004,glar017,",l_glar017_desc,",",
                  "       glar009,dir1,oqc,qc,qc2,qc3,",
                  "       oqjd,oqjc,qjd,qjc,qjd2,qjc2,qjd3,qjc3,",
                  "       dir2,oqm,qm,qm2,qm3",
                  "  FROM aglq711_tmp ",
                  "  LEFT JOIN glacl_t t01 ON glaclent=",g_enterprise," AND glacl001='",g_glaa004,"' AND glacl002=glar001 AND glacl003='",g_dlang,"'",
                  "  WHERE 1=1 "
       #是否按照幣別分頁
       IF NOT cl_null(g_glar009) THEN
          LET g_sql = g_sql," AND glar009 = '",g_glar009,"'" 
       END IF
       
       #是否按照科目分頁
       IF NOT cl_null(g_glar001) THEN
          LET g_sql = g_sql," AND glar001 = '",g_glar001,"'" 
       END IF
       
       LET g_sql = g_sql," ORDER BY glar001,glar017,glar009 "
   ELSE
      #不显示科目,按客商汇总
      IF g_master.curr_o = 'Y' THEN   #显示原币,也要按币别汇总
         LET l_sql = "SELECT UNIQUE glarent,'','',glar017,'',",
                     "       glar009,'',SUM(oqc) oqc,SUM(qc) qc,SUM(qc2) qc2,SUM(qc3) qc3,",
                     "       SUM(oqjd) oqjd,SUM(oqjc) oqjc,SUM(qjd) qjd,SUM(qjc) qjc,",
                     "       SUM(qjd2) qjd2,SUM(qjc2) qjc2,SUM(qjd3) qjd3,SUM(qjc3) qjc3,",
                     "       '',SUM(oqm) oqm,SUM(qm) qm,SUM(qm2) qm2,SUM(qm3) qm3",
                     "  FROM aglq711_tmp ",
                     "  LEFT JOIN glacl_t t01 ON glaclent=",g_enterprise," AND glacl001='",g_glaa004,"' AND glacl002=glar001 AND glacl003='",g_dlang,"'",
                     "  WHERE 1=1 "
                     
         #是否按照幣別分頁
         IF NOT cl_null(g_glar009) THEN
            LET l_sql = l_sql," AND glar009 = '",g_glar009,"'" 
         END IF
         
         LET l_sql = l_sql," GROUP BY glarent,glar017,glar009"
         
         LET g_sql = "SELECT UNIQUE '','',glar017,",l_glar017_desc,",",
                     "       glar009,CASE WHEN qc > 0 THEN '1' ELSE CASE WHEN qc < 0 THEN '2' ELSE '3' END END,",
                     "       oqc,qc,qc2,qc3,",
                     "       oqjd,oqjc,qjd,qjc,qjd2,qjc2,qjd3,qjc3,",
                     "       CASE WHEN qm > 0 THEN '1' ELSE CASE WHEN qm < 0 THEN '2' ELSE '3' END END,",
                     "       oqm,qm,qm2,qm3",
                     "  FROM (",l_sql,")",
                     " ORDER BY glar017,glar009"
      ELSE
         LET g_sql = "SELECT UNIQUE '','',glar017,",l_glar017_desc,",",
                     "       '',CASE WHEN qc > 0 THEN '1' ELSE CASE WHEN qc < 0 THEN '2' ELSE '3' END END,",
                     "       oqc,qc,qc2,qc3,",
                     "       oqjd,oqjc,qjd,qjc,qjd2,qjc2,qjd3,qjc3,",
                     "       CASE WHEN qm > 0 THEN '1' ELSE CASE WHEN qm < 0 THEN '2' ELSE '3' END END,",
                     "       oqm,qm,qm2,qm3",
                     "  FROM (",
                     "SELECT UNIQUE glarent,'','',glar017,'',",
                     "       '','',SUM(oqc) oqc,SUM(qc) qc,SUM(qc2) qc2,SUM(qc3) qc3,",
                     "       SUM(oqjd) oqjd,SUM(oqjc) oqjc,SUM(qjd) qjd,SUM(qjc) qjc,",
                     "       SUM(qjd2) qjd2,SUM(qjc2) qjc2,SUM(qjd3) qjd3,SUM(qjc3) qjc3,",
                     "       '',SUM(oqm) oqm,SUM(qm) qm,SUM(qm2) qm2,SUM(qm3) qm3",
                     "  FROM aglq711_tmp ",
                     "  LEFT JOIN glacl_t t01 ON glaclent=",g_enterprise," AND glacl001='",g_glaa004,"' AND glacl002=glar001 AND glacl003='",g_dlang,"'",
                     "  WHERE 1=1 ",
                     "  GROUP BY glarent,glar017 ",
                     "        )",
                     "  ORDER BY glar017"
      END IF
   END IF
   
   PREPARE aglq711_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq711_pb
   OPEN b_fill_curs
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:3)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql name="b_fill.sql"
   FOREACH b_fill_curs INTO g_detail[l_ac].glar001,g_detail[l_ac].glar001_desc,
                            g_detail[l_ac].glar017,g_detail[l_ac].glar017_desc,
                            g_detail[l_ac].glar009,g_detail[l_ac].dir1,
                            g_detail[l_ac].oqc,g_detail[l_ac].qc,g_detail[l_ac].qc2,g_detail[l_ac].qc3, 
                            g_detail[l_ac].oqjd,g_detail[l_ac].oqjc,g_detail[l_ac].qjd,g_detail[l_ac].qjc, 
                            g_detail[l_ac].qjd2,g_detail[l_ac].qjc2,g_detail[l_ac].qjd3,g_detail[l_ac].qjc3,
                            g_detail[l_ac].dir2,g_detail[l_ac].oqm,g_detail[l_ac].qm,g_detail[l_ac].qm2,
                            g_detail[l_ac].qm3

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      IF g_detail[l_ac].oqc < 0 THEN LET g_detail[l_ac].oqc = g_detail[l_ac].oqc * -1 END IF
      IF g_detail[l_ac].qc  < 0 THEN LET g_detail[l_ac].qc  = g_detail[l_ac].qc  * -1 END IF
      IF g_detail[l_ac].qc2 < 0 THEN LET g_detail[l_ac].qc2 = g_detail[l_ac].qc2 * -1 END IF
      IF g_detail[l_ac].qc3 < 0 THEN LET g_detail[l_ac].qc3 = g_detail[l_ac].qc3 * -1 END IF
      IF g_detail[l_ac].oqjd < 0 THEN LET g_detail[l_ac].oqjd = g_detail[l_ac].oqjd * -1 END IF
      IF g_detail[l_ac].oqjc < 0 THEN LET g_detail[l_ac].oqjc = g_detail[l_ac].oqjc * -1 END IF
      IF g_detail[l_ac].qjd  < 0 THEN LET g_detail[l_ac].qjd  = g_detail[l_ac].qjd  * -1 END IF
      IF g_detail[l_ac].qjc  < 0 THEN LET g_detail[l_ac].qjc  = g_detail[l_ac].qjc  * -1 END IF
      IF g_detail[l_ac].qjd2 < 0 THEN LET g_detail[l_ac].qjd2 = g_detail[l_ac].qjd2 * -1 END IF
      IF g_detail[l_ac].qjc2 < 0 THEN LET g_detail[l_ac].qjc2 = g_detail[l_ac].qjc2 * -1 END IF
      IF g_detail[l_ac].qjd3 < 0 THEN LET g_detail[l_ac].qjd3 = g_detail[l_ac].qjd3 * -1 END IF
      IF g_detail[l_ac].qjc3 < 0 THEN LET g_detail[l_ac].qjc3 = g_detail[l_ac].qjc3 * -1 END IF
      IF g_detail[l_ac].oqm < 0 THEN LET g_detail[l_ac].oqm = g_detail[l_ac].oqm * -1 END IF
      IF g_detail[l_ac].qm  < 0 THEN LET g_detail[l_ac].qm  = g_detail[l_ac].qm  * -1 END IF
      IF g_detail[l_ac].qm2 < 0 THEN LET g_detail[l_ac].qm2 = g_detail[l_ac].qm2 * -1 END IF
      IF g_detail[l_ac].qm3 < 0 THEN LET g_detail[l_ac].qm3 = g_detail[l_ac].qm3 * -1 END IF
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
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
   #end add-point
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   LET g_tot_cnt = l_ac - 1 
   DISPLAY g_tot_cnt TO FORMONLY.cnt
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq711_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq711_detail_action_trans()
 
   CALL aglq711_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aglq711.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq711_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = 1
 
   #單身組成
   #應用 qs11 樣板自動產生(Version:3)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
   #add-point:sql組成 name="b_fill2.fill"
   
   #end add-point
 
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq711.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq711_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_detail[l_ac].glar001
            LET ls_sql = "SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001='' AND glacl002=? AND glacl003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail[l_ac].glar001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail[l_ac].glar001_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_detail[l_ac].glar017
            LET ls_sql = "SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail[l_ac].glar017_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail[l_ac].glar017_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq711.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION aglq711_maintain_prog()
   #add-point:maintain_prog段define-客製 name="maintain_prog.define_customerization"
   
   #end add-point
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   DEFINE ls_j       LIKE type_t.num5
   #add-point:maintain_prog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="maintain_prog.define"
   
   #end add-point
 
 
   #add-point:maintain_prog段開始前 name="maintain_prog.before"
   
   #end add-point
 
   LET la_param.prog = ""
 
 
 
   IF NOT cl_null(la_param.prog) THEN
      LET ls_js = util.JSON.stringify(la_param)
      CALL cl_cmdrun_wait(ls_js)
   END IF
 
   #add-point:maintain_prog段結束前 name="maintain_prog.after"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq711.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq711_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.idx
   DISPLAY g_tot_cnt TO FORMONLY.cnt
 
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
 
{<section id="aglq711.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq711_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_master_row_move = "Y" THEN
      LET g_detail_idx = 1
      LET li_redirect = TRUE
   ELSE
      IF g_curr_diag IS NOT NULL THEN
         CASE
            WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
               LET g_detail_idx = 1
               IF g_detail.getLength() THEN
                  LET li_redirect = TRUE
               END IF
            WHEN g_curr_diag.getCurrentRow("s_detail1") > g_detail.getLength() AND g_detail.getLength() > 0
               LET g_detail_idx = g_detail.getLength()
               LET li_redirect = TRUE
            WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
               IF g_detail_idx > g_detail.getLength() THEN
                  LET g_detail_idx = g_detail.getLength()
               END IF
               LET li_redirect = TRUE
         END CASE
      END IF
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aglq711.mask_functions" >}
 &include "erp/agl/aglq711_mask.4gl"
 
{</section>}
 
{<section id="aglq711.other_function" readonly="Y" >}
# 抓取账套信息
PRIVATE FUNCTION aglq711_glaald_desc(p_glaald)
   DEFINE  p_glaald    LIKE glaa_t.glaald
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaald 
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.glaald_desc=g_rtn_fields[1]
   #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
   SELECT glaacomp,glaa001,glaa002,glaa003,glaa004,glaa013,
          glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
          glaa021,glaa022 
     INTO g_master.glaacomp,g_master.glaa001,g_glaa002,g_glaa003,g_glaa004,g_glaa013,
          g_glaa015,g_master.glaa016,g_glaa017,g_glaa018,g_glaa019,g_master.glaa020,
          g_glaa021,g_glaa022
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glaald 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.glaacomp_desc= g_rtn_fields[1]
   
   #本位幣二
   IF g_glaa015='Y' THEN
      CALL cl_set_comp_visible("glaa016",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa016",FALSE)
   END IF
   #本位幣三
   IF g_glaa019='Y' THEN
      CALL cl_set_comp_visible("glaa020",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa020",FALSE)
   END IF 
   #多本位幣
   CALL cl_set_comp_entry("ctype",TRUE)
   CASE
      WHEN g_glaa015<>'Y' AND g_glaa019<>'Y' 
         CALL cl_set_comp_entry("ctype",FALSE)
         CALL cl_set_combo_scc_part('ctype','9921','0')
      WHEN g_glaa015='Y' AND g_glaa019<>'Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1')
      WHEN g_glaa015<>'Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,2')
      WHEN g_glaa015='Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1,2,3')
   END CASE
   LET g_master.ctype='0'
   CALL aglq711_set_curr_show() #顯示本位幣二、本位幣三
END FUNCTION
# 设置默认值
PRIVATE FUNCTION aglq711_set_default_value()
   DEFINE l_flag           LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   
   CALL s_get_accdate(g_glaa003,g_today,'','')
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF
   LET g_master.year = l_glav002
   LET g_master.smm  = l_glav006
   LET g_master.emm  = l_glav006
  
   #原幣顯示設置
   LET g_master.curr_o = 'N'
   CALL cl_set_comp_visible('glar009,oqc,oqjd,oqjc,oqm',FALSE)
   
   LET g_master.curr_p = 'N'
   CALL aglq711_set_comp_entry('curr_p',FALSE)
   #显示科目
   LET g_master.show_acc = 'N'
   LET g_master.acc_p = 'N'
   CALL aglq711_set_comp_entry('acc_p',FALSE)
   CALL cl_set_comp_visible('b_glar001,b_glar001_desc',FALSE)
   #單據狀態
   LET g_master.stus = '1'
END FUNCTION
# 设置栏位开启与关闭
PRIVATE FUNCTION aglq711_set_comp_entry(ps_fields,pi_entry)
   DEFINE ps_fields STRING,
          pi_entry  LIKE type_t.num5           
   DEFINE lst_fields base.StringTokenizer,
          ls_field_name STRING
   DEFINE lwin_curr     ui.Window
   DEFINE lnode_win     om.DomNode,
          llst_items    om.NodeList,
          li_i          LIKE type_t.num5,        
          lnode_item    om.DomNode,
          ls_item_name  STRING
 
   IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]"  THEN  
      RETURN
   END IF
 
   IF (ps_fields IS NULL) THEN
      RETURN
   END IF
 
   LET ps_fields = ps_fields.toLowerCase()
 
   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
 
   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_win = lwin_curr.getNode()
 
   LET llst_items = lnode_win.selectByPath("//Form//*")
 
   WHILE lst_fields.hasMoreTokens()
     LET ls_field_name = lst_fields.nextToken()
     LET ls_field_name = ls_field_name.trim()
 
     IF (ls_field_name.getLength() > 0) THEN
        FOR li_i = 1 TO llst_items.getLength()
            LET lnode_item = llst_items.item(li_i)
            LET ls_item_name = lnode_item.getAttribute("colName")
 
            IF (ls_item_name IS NULL) THEN
               LET ls_item_name = lnode_item.getAttribute("name")
 
               IF (ls_item_name IS NULL) THEN
                  CONTINUE FOR
               END IF
            END IF
 
            LET ls_item_name = ls_item_name.trim()
 
            IF (ls_item_name.equals(ls_field_name)) THEN
               IF (pi_entry) THEN
                  CALL lnode_item.setAttribute("noEntry", "0")
                  CALL lnode_item.setAttribute("active", "1")
               ELSE
                  CALL lnode_item.setAttribute("noEntry", "1")
                  CALL lnode_item.setAttribute("active", "0")
               END IF
 
               EXIT FOR
            END IF
        END FOR
     END IF
   END WHILE
END FUNCTION
# 顯示本位幣二、本位幣三
PRIVATE FUNCTION aglq711_set_curr_show()
   #顯示本位幣二
   IF g_master.ctype='1' THEN
      CALL cl_set_comp_visible("qc2,qjd2,qjc2,qm2",TRUE)
   ELSE
      CALL cl_set_comp_visible("qc2,qjd2,qjc2,qm2",FALSE)
   END IF
   #顯示本位幣三
   IF g_master.ctype='2' THEN
      CALL cl_set_comp_visible("qc3,qjd3,qjc3,qm3",TRUE)
   ELSE
      CALL cl_set_comp_visible("qc3,qjd3,qjc3,qm3",FALSE)
   END IF
   #全部
   IF g_master.ctype='3' THEN
      CALL cl_set_comp_visible("qc2,qjd2,qjc2,qm2",TRUE)
      CALL cl_set_comp_visible("qc3,qjd3,qjc3,qm3",TRUE)
   END IF
END FUNCTION
# 抓取数据
PRIVATE FUNCTION aglq711_get_data()
   DEFINE l_pdate_s1       LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
   DEFINE l_pdate_e1       LIKE glav_t.glav004
   DEFINE l_pdate_s2       LIKE glav_t.glav004 #截止年度+期別對應的起始截止日期
   DEFINE l_pdate_e2       LIKE glav_t.glav004
   DEFINE l_flag1          LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   DEFINE l_flag           LIKE type_t.num5    #表示是否是完整期別
   DEFINE l_sql,l_sql1,l_sql2   STRING
   DEFINE l_sql3,l_sql4         STRING
   DEFINE l_wc                  STRING 
   DEFINE l_wc2                 STRING 
   DEFINE l_glad027        LIKE glad_t.glad027
   DEFINE l_glaq002        STRING
   DEFINE l_glar012        LIKE glar_t.glar012
   DEFINE l_glar013        LIKE glar_t.glar013
   DEFINE l_glar014        LIKE glar_t.glar014
   DEFINE l_glar015        LIKE glar_t.glar015
   DEFINE l_glar016        LIKE glar_t.glar016
   DEFINE l_glar017        LIKE glar_t.glar017
   DEFINE l_glar018        LIKE glar_t.glar018
   DEFINE l_glar019        LIKE glar_t.glar019
   DEFINE l_glar051        LIKE glar_t.glar051
   DEFINE l_glar052        LIKE glar_t.glar052
   DEFINE l_glar053        LIKE glar_t.glar053
   DEFINE l_glar020        LIKE glar_t.glar020 
   DEFINE l_glar022        LIKE glar_t.glar022
   DEFINE l_glar023        LIKE glar_t.glar023
   DEFINE l_glar024        LIKE glar_t.glar024 
   DEFINE l_glar025        LIKE glar_t.glar025
   DEFINE l_glar026        LIKE glar_t.glar026
   DEFINE l_glar027        LIKE glar_t.glar027 
   DEFINE l_glar028        LIKE glar_t.glar028
   DEFINE l_glar029        LIKE glar_t.glar029
   DEFINE l_glar030        LIKE glar_t.glar030 
   DEFINE l_glar031        LIKE glar_t.glar031
   DEFINE l_glar032        LIKE glar_t.glar032
   DEFINE l_glar033        LIKE glar_t.glar033
   DEFINE l_glar009        LIKE glar_t.glar009
   DEFINE l_oyeard         LIKE type_t.num20_6
   DEFINE l_oyearc         LIKE type_t.num20_6
   DEFINE l_yeard          LIKE type_t.num20_6
   DEFINE l_yearc          LIKE type_t.num20_6
   DEFINE l_yeard2         LIKE type_t.num20_6
   DEFINE l_yearc2         LIKE type_t.num20_6
   DEFINE l_yeard3         LIKE type_t.num20_6
   DEFINE l_yearc3         LIKE type_t.num20_6
   DEFINE l_dir1           LIKE type_t.chr1
   DEFINE l_dir2           LIKE type_t.chr1
   DEFINE l_oqc            LIKE type_t.num20_6
   DEFINE l_qc             LIKE type_t.num20_6
   DEFINE l_qc2            LIKE type_t.num20_6
   DEFINE l_qc3            LIKE type_t.num20_6
   DEFINE l_oqjd           LIKE type_t.num20_6
   DEFINE l_oqjc           LIKE type_t.num20_6
   DEFINE l_qjd            LIKE type_t.num20_6
   DEFINE l_qjc            LIKE type_t.num20_6
   DEFINE l_qjd2           LIKE type_t.num20_6
   DEFINE l_qjc2           LIKE type_t.num20_6
   DEFINE l_qjd3           LIKE type_t.num20_6
   DEFINE l_qjc3           LIKE type_t.num20_6
   DEFINE l_oqm            LIKE type_t.num20_6
   DEFINE l_qm             LIKE type_t.num20_6
   DEFINE l_qm2            LIKE type_t.num20_6
   DEFINE l_qm3            LIKE type_t.num20_6
   DEFINE l_osumd          LIKE type_t.num20_6
   DEFINE l_osumc          LIKE type_t.num20_6
   DEFINE l_sumd           LIKE type_t.num20_6
   DEFINE l_sumc           LIKE type_t.num20_6
   DEFINE l_sumd2          LIKE type_t.num20_6
   DEFINE l_sumc2          LIKE type_t.num20_6
   DEFINE l_sumd3          LIKE type_t.num20_6
   DEFINE l_sumc3          LIKE type_t.num20_6
   DEFINE l_amt1           LIKE type_t.num20_6
   DEFINE l_amt2           LIKE type_t.num20_6
   DEFINE l_amt3           LIKE type_t.num20_6
   DEFINE l_amt4           LIKE type_t.num20_6
   DEFINE l_amt5           LIKE type_t.num20_6
   DEFINE l_amt6           LIKE type_t.num20_6
   DEFINE l_amt7           LIKE type_t.num20_6
   DEFINE l_amt8           LIKE type_t.num20_6
   DEFINE l_period         LIKE glap_t.glap004
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_str,l_str1,l_str2  STRING
   DEFINE l_str3,l_str4        STRING
   DEFINE l_num,l_i        LIKE type_t.num5
   DEFINE l_glac002        LIKE glac_t.glac002
   DEFINE l_flag2          LIKE type_t.num5
   DEFINE l_glav004        LIKE glav_t.glav004
   DEFINE l_glav004_m      LIKE glav_t.glav004
   DEFINE l_glav004_e      LIKE glav_t.glav004
   DEFINE l_glac002_str    STRING
   DEFINE l_sql_pr1        STRING
   DEFINE l_sql_pr6        STRING
   DEFINE l_sql_pr7        STRING
   DEFINE l_sql_pr8        STRING
   DEFINE l_sql_pr6_1      STRING
   DEFINE l_sql_pr7_1      STRING
   DEFINE l_sql_pr8_1      STRING
   DEFINE l_sql_hsx        STRING
   DEFINE l_glac002_o      LIKE glac_t.glac002
   DEFINE l_glac002_t      LIKE glac_t.glac002
   DEFINE l_glac003        LIKE glac_t.glac003
   DEFINE l_sql_t01        STRING  
   DEFINE l_sql_t02        STRING 
   DEFINE l_sql_t03        STRING 
   DEFINE l_sql_nch        STRING 
   DEFINE l_sql_qch        STRING 
   DEFINE l_sql_qj         STRING 
   DEFINE l_sql_lj         STRING
   DEFINE l_hsx_nch        STRING
   DEFINE l_str01,l_str02  STRING
   
   #刪除臨時表中資料
   DELETE FROM aglq711_tmp
   
   CALL s_get_accdate(g_glaa003,'',g_master.year,g_master.smm) 
   RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s1,l_pdate_e1,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1 = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF

   CALL s_get_accdate(g_glaa003,'',g_master.year,g_master.emm) 
   RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s2,l_pdate_e2,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1 = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF

   #核算項條件篩選
   LET l_wc = cl_replace_str(g_wc,'glar001','glac002')
   LET l_wc2 = cl_replace_str(g_wc,'glar001','glaq002')
   
   LET l_num = g_wc.getIndexOf('glar001',1)
   IF l_num > 0 THEN
      LET l_i = g_wc.getIndexOf('and',1)
      IF l_i = 0 THEN
         LET l_sql1 = g_wc
      ELSE
         LET l_sql1 = g_wc.substring(l_num,l_i-1) 
      END IF
      LET l_sql1 = " AND ",cl_replace_str(l_sql1,'glar001','glac002')
   END IF

   #單據狀態
   CASE
      WHEN g_master.stus='1'
         LET l_sql4=l_sql4," AND glapstus='S' "
      WHEN g_master.stus='2'
         LET l_sql4=l_sql4," AND glapstus IN ('S','Y') "
      WHEN g_master.stus='3'
         LET l_sql4=l_sql4," AND glapstus IN ('S','Y','N') "
   END CASE
   #显示原币否
   CALL aglq711_fix_acc_get_sql() RETURNING l_str,l_str1,l_str2,l_str01,l_str02 
   
   #判斷是否勾選原幣
   LET l_num = l_str.getIndexOf('g',1)
   IF l_num > 0 THEN 
      LET l_flag2 = TRUE #表示勾選了顯示原幣或核算項  
   END IF
   
   CALL cl_err_collect_init()
   LET l_success = TRUE
   
   #抓出所有符合條件的會計科目+核算项
   LET g_sql="SELECT DISTINCT glac002,glac003,",l_str,
             "  FROM glac_t "
   #當勾選了顯示原幣或核算項等條件后，依勾選條件遍歷查詢資料
   IF l_flag2 = TRUE THEN
      IF g_master.stus = '1' THEN 
         LET g_sql = g_sql," LEFT JOIN (",
                           "            SELECT glar001 ",l_str01,
                           "              FROM glar_t",
                           "             WHERE glarent = ",g_enterprise," AND glarld = '",g_master.glaald,"'",
                           "               AND glar002 = ",g_master.year,
                           "               AND glar003 <= ",g_master.emm,
                           "               AND ",g_wc,
                           "           ) hsx ON hsx.glar001 = glac002" 
         
      ELSE 
         LET g_sql = g_sql," LEFT JOIN (",
                           "            SELECT glaq002 ",l_str02,
                           "              FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                           "             WHERE glaqent = ",g_enterprise," AND glaqld = '",g_master.glaald,"' ",
                           "               AND glap002 = ",g_master.year,
                           "               AND glap004 <= ",g_master.emm,
                           "               AND ",l_wc2,l_sql2,l_sql4,
                           "             UNION ",  #年初余额
                           "            SELECT glar001 glaq002",l_str01,
                           "              FROM glar_t",
                           "             WHERE glarent=",g_enterprise," AND glarld='",g_master.glaald,"'",
                           "               AND glar002=",g_master.year," AND glar003=0 ",
                           "               AND ",g_wc,
                           "           ) hsx ON hsx.glaq002=glac002"
      END IF
   END IF
   LET g_sql = g_sql," WHERE glacent = ",g_enterprise,
                     "   AND glac001 = '",g_glaa004,"' AND glacstus = 'Y' ",l_sql1,
                     " ORDER BY glac002,glac003,",l_str
   PREPARE aglq711_sel_glac_pr2 FROM g_sql
   DECLARE aglq711_sel_glac_cs2 CURSOR FOR aglq711_sel_glac_pr2     
   
   #當勾選了顯示原幣等條件后，依勾選條件遍歷查詢資料
   IF l_flag2=TRUE THEN
      IF g_master.stus='1' THEN #1.已过账  
         LET l_sql_hsx = "SELECT DISTINCT ",l_str,
                         "   FROM glar_t",
                         "  WHERE glarent = ",g_enterprise," AND glarld = '",g_master.glaald,"'",
                         "    AND glar002 = ",g_master.year,
                         "    AND glar003 <= ",g_master.emm,
                         "    AND ",g_wc
      ELSE 
         LET l_hsx_nch = "SELECT DISTINCT ",l_str,
                         "   FROM (",
                         "         SELECT ",l_str,
                         "            FROM glar_t",
                         "           WHERE glarent=",g_enterprise," AND glarld='",g_master.glaald,"'",
                         "             AND glar002=",g_master.year," AND glar003=0",
                         "             AND ",g_wc  
         LET l_sql_hsx = "SELECT ",l_str2,
                         "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                         " WHERE glaqent = ",g_enterprise," AND glaqld = '",g_master.glaald,"' ",
                         "   AND glap002 = ",g_master.year,
                         "   AND glap004 <= ",g_master.emm,
                         "   AND ",l_wc2,l_sql2,l_sql4
      END IF
   END IF

   #期初
   #傳票狀態是已過帳時抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
   IF g_master.stus = '1' THEN 
                      #        原幣借-貸            /本幣借-貸
      LET l_sql_qch = " SELECT SUM(glar010-glar011),SUM(glar005-glar006),",
                      #        本幣二借-貸          /本幣三借-貸
                      "        SUM(glar034-glar035),SUM(glar036-glar037) ",
                      "   FROM glar_t",    
                      "  WHERE glarent = ",g_enterprise," AND glarld = '",g_master.glaald,"' ",
                      "    AND glar002 = ",g_master.year,
                      "    AND glar003 <= ",g_master.smm - 1
   ELSE
                      #        原幣借-貸
      LET l_sql_qch = " SELECT SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END),",
                      #        本幣借-貸            /本幣二借-貸          /本幣三借-貸
                      "        SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044)",
                      "   FROM glaq_t INNER JOIN glap_t ON glapent = glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      "  WHERE glaqent=",g_enterprise," AND glaqld='",g_master.glaald,"' ",
                      "    AND glap002 = ",g_master.year,
                      "    AND glap004 <= ",g_master.smm - 1,
                      l_sql2,l_sql4
   END IF
   #期間異動
   #当傳票狀態是已過帳时，抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
   IF g_master.stus = '1' THEN
                     #        原幣借方金額  /原幣貸方金額 
      LET l_sql_qj = " SELECT SUM(glar010),SUM(glar011),",
                     #        本幣借方金額  /本幣貸方金額
                     "        SUM(glar005), SUM(glar006),",
                     #        本幣二借方金額 /本幣二貸方金額 /本幣三借方金額 /本幣三貸方金額
                     "        SUM(glar034), SUM(glar035), SUM(glar036), SUM(glar037)",
                     "   FROM glar_t",
                     "  WHERE glarent=",g_enterprise," AND glarld='",g_master.glaald,"'",
                     "    AND glar002=",g_master.year,
                     "    AND glar003 BETWEEN ",g_master.smm," AND ",g_master.emm,
                     "    AND ",g_wc
   ELSE
                     #        原幣借方金額
      LET l_sql_qj = " SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END ),",
                     #        原幣貸方金額
                     "        SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END ),",
                     #        本幣借方金額  /本幣貸方金額 /本幣二借方金額 /本幣二貸方金額 
                     "        SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                     #        本幣三借方金額 /本幣三貸方金額
                     "        SUM(glaq043),SUM(glaq044)",
                     "   FROM glaq_t INNER JOIN glap_t ON glapent = glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                     "  WHERE glaqent = ",g_enterprise," AND glaqld = '",g_master.glaald,"' ",
                     "    AND glap002 = ",g_master.year,
                     "    AND glap004 BETWEEN ",g_master.smm," AND ",g_master.emm,
                     l_sql2,l_sql4
   END IF
   
   
   #期初
   LET l_sql_pr1="SELECT SUM(glar010-glar011),SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037) FROM glar_t",    
                 " WHERE glarent = ",g_enterprise," AND glarld = '",g_master.glaald,"' ",
                 "   AND glar001 = ? AND glar002 = ? AND glar003 <= ? "
   
   #插入临时表
   LET l_sql="INSERT INTO aglq711_tmp ",
             "VALUES(",
             "   ?,?,?,?,?, ?,?,?,?,?,",
             "   ?,?,?,?,?, ?,?,?,?,?,",
             "   ?,?)"
   PREPARE aglq711_ins_pr2 FROM l_sql
   
   LET l_glac002_o = NULL
   LET l_glac002_t = NULL
   #科目遍歷
   FOREACH aglq711_sel_glac_cs2 INTO l_glac002,l_glac003,l_glar017,l_glar009
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'FOREACH aglq711_sel_glac_cs2'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      #若科目不做账款对象管理,则不抓出来
      SELECT glad027 INTO l_glad027
        FROM glad_t
       WHERE gladent = g_enterprise
         AND gladld = g_master.glaald
         AND glad001 = l_glac002
         
      IF l_glad027 <> 'Y' THEN 
         CONTINUE FOREACH
      END IF
      
      IF cl_null(l_glac002_o) OR l_glac002_o <> l_glac002 THEN
         #当科目是统治科目时，抓取下层明细科目
         LET l_glaq002 = '' 
         IF l_glac003 = '1' THEN
            #抓取科目对应的明细科目或者独立科目
            CALL s_voucher_get_glac_str(g_glaa004,l_glac002) RETURNING l_glaq002
         END IF 
         
         IF cl_null(l_glaq002) THEN 
            LET l_glaq002 = "'",l_glac002,"'"
         END IF
         
         #当该统治科目没有下层明细科目时，抓取该科目本身资料
         IF cl_null(l_glaq002) THEN
            LET l_glaq002 = " AND glaq002 = '",l_glac002,"'"
         ELSE
            LET l_glaq002 = " AND glaq002 IN (",l_glaq002,")"
         END IF
         
         LET l_glac002_o = l_glac002 #记录旧值
      END IF
      #当一下条件时，直接根据科目、币别、核算项等条件抓取金额资料
      #1.当没有勾选原币或核算项
      #2.當勾選了顯示原幣或核算項等條件后，科目不是统制科目或者科目是统制科目但凭证状态=1.已过账
      IF l_flag2 = FALSE OR l_glac003<>'1' OR (l_glac003='1' AND g_master.stus='1') THEN
         IF l_flag2 = TRUE THEN
            CALL aglq711_fix_acc_sql(l_glar009,l_glar017)
            RETURNING l_str3,l_str4
         ELSE
            LET l_str3=''
            LET l_str4=''
         END IF
   
         #期初
         #當傳票狀態是已過帳時抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
         IF g_master.stus='1' THEN
            LET g_sql = l_sql_qch," AND glar001 = '",l_glac002,"'",l_str3
         ELSE
            LET g_sql = l_sql_qch,l_glaq002,l_str4
         END IF
         PREPARE aglq711_sum_pr_qch FROM g_sql
         
         #期間異動
         #当傳票狀態是已過帳时，抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
         IF g_master.stus = '1' THEN
            LET g_sql = l_sql_qj," AND glar001 = '",l_glac002,"'",l_str3
         ELSE
            LET g_sql = l_sql_qj,l_glaq002,l_str4
         END IF
         PREPARE aglq711_sum_pr_qj FROM g_sql
         
         #年初、期初
         LET l_sql=l_sql_pr1,l_str3
         PREPARE aglq711_sel_pr1_2 FROM l_sql
         
         #抓取金额  
         #期初金額
         LET l_oqc = 0
         LET l_qc  = 0
         LET l_qc2 = 0
         LET l_qc3 = 0
         EXECUTE aglq711_sum_pr_qch INTO l_oqc,l_qc,l_qc2,l_qc3
         IF cl_null(l_oqc) THEN LET l_oqc = 0 END IF
         IF cl_null(l_qc)  THEN LET l_qc  = 0 END IF
         IF cl_null(l_qc2) THEN LET l_qc2 = 0 END IF
         IF cl_null(l_qc3) THEN LET l_qc3 = 0 END IF
         
         IF g_master.stus <> '1' THEN
            #抓取年初金額
            LET l_amt1 = 0
            LET l_amt2 = 0
            LET l_amt3 = 0
            LET l_amt4 = 0
            LET l_period = 0
            EXECUTE aglq711_sel_pr1_2 USING l_glac002,g_master.year,l_period
                                       INTO l_amt1,l_amt2,l_amt3,l_amt4
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq711_sel_pr1_2'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
            LET l_oqc = l_oqc + l_amt1
            LET l_qc  = l_qc  + l_amt2
            LET l_qc2 = l_qc2 + l_amt3
            LET l_qc3 = l_qc3 + l_amt4
         END IF

         IF l_qc > 0 THEN
            LET l_dir1 = '1'
         END IF
         
         IF l_qc < 0 THEN
            LET l_dir1 = '2'
         END IF
         
         IF l_qc = 0 THEN 
            LET l_dir1 = '3'
         END IF
                 
         #期間異動
         LET l_oqjd = 0         LET l_oqjc = 0
         LET l_qjd  = 0         LET l_qjc  = 0
         LET l_qjd2 = 0         LET l_qjc2 = 0
         LET l_qjd3 = 0         LET l_qjc3 = 0
         EXECUTE aglq711_sum_pr_qj INTO l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3
         IF cl_null(l_oqjd) THEN LET l_oqjd=0 END IF
         IF cl_null(l_oqjc) THEN LET l_oqjc=0 END IF
         IF cl_null(l_qjd)  THEN LET l_qjd=0  END IF
         IF cl_null(l_qjc)  THEN LET l_qjc=0  END IF
         IF cl_null(l_qjd2) THEN LET l_qjd2=0 END IF
         IF cl_null(l_qjc2) THEN LET l_qjc2=0 END IF
         IF cl_null(l_qjd3) THEN LET l_qjd3=0 END IF
         IF cl_null(l_qjc3) THEN LET l_qjc3=0 END IF

         #期末金額=期初+期間異動
         #原幣
         LET l_oqm = l_oqc + (l_oqjd - l_oqjc)

         #本幣
         LET l_qm = l_qc + (l_qjd - l_qjc)
         
         IF l_qm > 0 THEN 
            LET l_dir2 = '1'
         END IF
         
         IF l_qm < 0 THEN 
            LET l_dir2 = '2'
         END IF
         
         IF l_qm = 0 THEN 
            LET l_dir2 = '3'
         END IF
         
         #本幣二
         LET l_qm2 = l_qc2 + (l_qjd2 - l_qjc2)

         #本幣三
         LET l_qm3 = l_qc3 + (l_qjd3 - l_qjc3)
  
         IF l_qc = 0 AND                  #期初數
            l_qjd= 0 AND l_qjc=0 AND      #期間異動
            l_qm = 0 THEN                 #期末   以上全部等於0時該筆科目資料不顯示
            CONTINUE FOREACH
         END IF

         EXECUTE aglq711_ins_pr2 USING
                g_enterprise,l_glac002,l_glar017,l_glar009,
                l_dir1,l_oqc,l_qc,l_qc2,l_qc3,
                l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3,
                l_dir2,l_oqm,l_qm,l_qm2,l_qm3
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'insert'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET l_success = FALSE
         END IF
      ELSE
         #当统制科目，且抓取的资料有未过账的凭证资料时，需要通过统制科目对应明细科目范围抓取核算项资料，
         #通过抓取的核算项资料遍历抓取对应金额，且一统制科目只可以遍历一遍
         IF cl_null(l_glac002_t) OR l_glac002_t <> l_glac002 THEN
            LET l_glac002_t = l_glac002
         ELSE
            CONTINUE FOREACH
         END IF
         #统制科目，且抓取资料来源是glaq_t时，需要通过统制科目对应明细科目抓取金额
         IF g_master.stus='1' THEN #表示單據狀態为1.已过账 
            LET l_sql = l_sql_hsx," AND glar001 = '",l_glac002,"' ORDER BY ",l_str
         ELSE
            LET l_sql = l_hsx_nch," AND glar001='",l_glac002,"'",
                        " UNION ",
                        l_sql_hsx,l_glaq002,") ORDER BY ",l_str
         END IF
         PREPARE aglq711_sel_pr_3 FROM l_sql
         DECLARE aglq711_sel_cr_3 CURSOR FOR aglq711_sel_pr_3
         #原幣及核算項遍歷
         FOREACH aglq711_sel_cr_3 INTO l_glar017,l_glar009
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'FOREACH aglq711_sel_cr_3'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            
            CALL aglq711_fix_acc_sql(l_glar009,l_glar017)
            RETURNING l_str3,l_str4
            
            #期初
            #當傳票狀態是已過帳時抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
            IF g_master.stus='1' THEN
               LET g_sql = l_sql_qch," AND glar001 = '",l_glac002,"'",l_str3
            ELSE
               LET g_sql = l_sql_qch,l_glaq002,l_str4
            END IF
            PREPARE aglq711_sum_pr_qch_3 FROM g_sql
            
            #期間異動
            #当傳票狀態是已過帳时，抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
            IF g_master.stus='1' THEN
               LET g_sql = l_sql_qj," AND glar001 = '",l_glac002,"'",l_str3
            ELSE
               LET g_sql = l_sql_qj,l_glaq002,l_str4
            END IF
            PREPARE aglq711_sum_pr_qj_3 FROM g_sql
            
            #年初、期初
            LET l_sql = l_sql_pr1,l_str3
            PREPARE aglq711_sel_pr1_3 FROM l_sql
            
            #抓取金额  
            #期初金額
            LET l_oqc = 0
            LET l_qc  = 0
            LET l_qc2 = 0
            LET l_qc3 = 0
            EXECUTE aglq711_sum_pr_qch_3 INTO l_oqc,l_qc,l_qc2,l_qc3 
            IF cl_null(l_oqc) THEN LET l_oqc = 0 END IF
            IF cl_null(l_qc)  THEN LET l_qc  = 0 END IF
            IF cl_null(l_qc2) THEN LET l_qc2 = 0 END IF
            IF cl_null(l_qc3) THEN LET l_qc3 = 0 END IF
            
            IF g_master.stus <> '1' THEN 
               #抓取年初金額
               LET l_amt1 = 0
               LET l_amt2 = 0
               LET l_amt3 = 0
               LET l_amt4 = 0
               LET l_period = 0
               EXECUTE aglq711_sel_pr1_3 USING l_glac002,g_master.year,l_period
                                          INTO l_amt1,l_amt2,l_amt3,l_amt4
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq711_sel_pr1_3'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
               IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
               IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF
               IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
               LET l_oqc = l_oqc + l_amt1
               LET l_qc  = l_qc  + l_amt2
               LET l_qc2 = l_qc2 + l_amt3
               LET l_qc3 = l_qc3 + l_amt4
            END IF

            #本币
            IF l_qc > 0 THEN 
               LET l_dir1 = '1'
            END IF
            
            IF l_qc < 0 THEN 
               LET l_dir1 = '2'
            END IF

            IF l_qc = 0 THEN 
               LET l_dir1 = '3'
            END IF

            #期間異動
            LET l_oqjd = 0         LET l_oqjc = 0
            LET l_qjd  = 0         LET l_qjc  = 0
            LET l_qjd2 = 0         LET l_qjc2 = 0
            LET l_qjd3 = 0         LET l_qjc3 = 0
            EXECUTE aglq711_sum_pr_qj_3 INTO l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3
            IF cl_null(l_oqjd) THEN LET l_oqjd = 0 END IF
            IF cl_null(l_oqjc) THEN LET l_oqjc = 0 END IF
            IF cl_null(l_qjd)  THEN LET l_qjd  = 0 END IF
            IF cl_null(l_qjc)  THEN LET l_qjc  = 0 END IF
            IF cl_null(l_qjd2) THEN LET l_qjd2 = 0 END IF
            IF cl_null(l_qjc2) THEN LET l_qjc2 = 0 END IF
            IF cl_null(l_qjd3) THEN LET l_qjd3 = 0 END IF
            IF cl_null(l_qjc3) THEN LET l_qjc3 = 0 END IF
            
            
            #期末金額=期初+期間異動
            #原幣
            LET l_oqm = l_oqc + (l_oqjd - l_oqjc)

            #本幣
            LET l_qm = l_qc + (l_qjd - l_qjc)
            
            IF l_qm > 0 THEN 
               LET l_dir2 = '1'
            END IF
            
            IF l_qm < 0 THEN 
               LET l_dir2 = '2'
            END IF
            
            IF l_qm = 0 THEN 
               LET l_dir2 = '3'
            END IF
            
            #本幣二
            LET l_qm2 = l_qc2 + (l_qjd2 - l_qjc2)
            
            #本幣三
            LET l_qm3 = l_qc3 + (l_qjd3 - l_qjc3)
            
            IF l_qc = 0 AND                  #期初數
               l_qjd= 0 AND l_qjc=0 AND      #期間異動
               l_qm = 0 THEN                 #期末   以上全部等於0時該筆科目資料不顯示
               CONTINUE FOREACH
            END IF
        
            EXECUTE aglq711_ins_pr2 USING
                g_enterprise,l_glac002,l_glar017,l_glar009,
                l_dir1,l_oqc,l_qc,l_qc2,l_qc3,
                l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3,
                l_dir2,l_oqm,l_qm,l_qm2,l_qm3
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'insert'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
         END FOREACH
      END IF
   END FOREACH
   IF l_success = FALSE THEN
      CALL cl_err_collect_show()
      DELETE FROM aglq711_tmp
   ELSE
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
   END IF

END FUNCTION
# 创建临时表
PRIVATE FUNCTION aglq711_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   DROP TABLE aglq711_tmp
   CREATE TEMP TABLE aglq711_tmp(
   glarent       SMALLINT,  
   glar001       VARCHAR(24),
   glar017       VARCHAR(10),
   glar009       VARCHAR(10),
   dir1          VARCHAR(1),
   oqc           DECIMAL(20,6),
   qc            DECIMAL(20,6),
   qc2           DECIMAL(20,6),
   qc3           DECIMAL(20,6),
   oqjd          DECIMAL(20,6),
   oqjc          DECIMAL(20,6),
   qjd           DECIMAL(20,6),
   qjc           DECIMAL(20,6),
   qjd2          DECIMAL(20,6),
   qjc2          DECIMAL(20,6),
   qjd3          DECIMAL(20,6),
   qjc3          DECIMAL(20,6),
   dir2         VARCHAR(1),
   oqm           DECIMAL(20,6),
   qm            DECIMAL(20,6),
   qm2           DECIMAL(20,6),
   qm3           DECIMAL(20,6)
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   DROP TABLE aglq711_tmp01              
   CREATE TEMP TABLE aglq711_tmp01(     
   glaald_desc     VARCHAR(500),
   glaacomp_desc   VARCHAR(500),
   glaa001_desc    VARCHAR(500),
   year            VARCHAR(500),
   mm              VARCHAR(500),
   ctype           VARCHAR(500),
   stus            VARCHAR(500),
   glar001         VARCHAR(24), 
   glar001_desc    VARCHAR(500), 
   glar017         VARCHAR(10), 
   glar017_desc    VARCHAR(500), 
   glar009         VARCHAR(10), 
   dir1            VARCHAR(500),
   oqc             DECIMAL(20,6), 
   qc              DECIMAL(20,6), 
   qc2             DECIMAL(20,6), 
   qc3             DECIMAL(20,6), 
   oqjd            DECIMAL(20,6), 
   oqjc            DECIMAL(20,6), 
   qjd             DECIMAL(20,6), 
   qjc             DECIMAL(20,6), 
   qjd2            DECIMAL(20,6), 
   qjc2            DECIMAL(20,6), 
   qjd3            DECIMAL(20,6), 
   qjc3            DECIMAL(20,6), 
   dir2            VARCHAR(500),
   oqm             DECIMAL(20,6), 
   qm              DECIMAL(20,6), 
   qm2             DECIMAL(20,6), 
   qm3             DECIMAL(20,6)
   )
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
# 显示原币否
PRIVATE FUNCTION aglq711_fix_acc_get_sql()
   DEFINE r_sql,r_sql1,r_sql2   STRING 
   DEFINE r_sql3,r_sql4         STRING #160505-00007#14
   
   LET r_sql  = ''
   LET r_sql1 = ''
   LET r_sql2 = ''
   LET r_sql3 = ''  
   LET r_sql4 = ''  
      
   LET r_sql  = r_sql,"glar017"
   LET r_sql1 = r_sql1,"glaq022"
   LET r_sql2 = r_sql2,"glaq022 glar017"
   LET r_sql3 = r_sql3,",glar017"           
   LET r_sql4 = r_sql4,",glaq022 glar017"   
   
   IF g_master.curr_o = 'Y' THEN
      LET r_sql  = r_sql,",glar009"
      LET r_sql1 = r_sql1,",glaq005"
      LET r_sql2 = r_sql2,",glaq005 glar009"
      LET r_sql3 = r_sql3,",glar009"           
      LET r_sql4 = r_sql4,",glaq005 glar009"   
   ELSE
      LET r_sql  = r_sql,",''"
      LET r_sql1 = r_sql1,",''"
      LET r_sql2 = r_sql2,",''"
   END IF
   
   RETURN r_sql,r_sql1,r_sql2,r_sql3,r_sql4
END FUNCTION
#
PRIVATE FUNCTION aglq711_fix_acc_sql(p_glar009,p_glar017)
   DEFINE p_glar009            LIKE glar_t.glar009
   DEFINE p_glar017            LIKE glar_t.glar017
   DEFINE r_sql,r_sql1         STRING
   
   LET r_sql=''
   LET r_sql1=''
      
   LET r_sql=r_sql," AND glar017='",p_glar017,"'"
   LET r_sql1=r_sql1," AND glaq022='",p_glar017,"'"
   
   IF g_master.curr_o='Y' THEN
      LET r_sql=r_sql," AND glar009='",p_glar009,"'"
      LET r_sql1=r_sql1," AND glaq005='",p_glar009,"'"
   END IF
   
   RETURN r_sql,r_sql1
END FUNCTION
# 设置分页
PRIVATE FUNCTION aglq711_set_page()
   DEFINE l_sql    STRING
   DEFINE l_idx    LIKE type_t.num5
   
   CALL g_glar_s.clear()
   
   #不分页
   IF g_master.curr_p = 'N' AND g_master.acc_p = 'N' THEN
      LET g_glar_s[1].glar009 = ''
      LET g_glar_s[1].glar001 = ''
      LET g_row_count = 1
   END IF 
   
   #按币别分页
   IF g_master.curr_p = 'Y' AND g_master.acc_p = 'N' THEN
      LET l_sql = "SELECT DISTINCT glar009 FROM aglq711_tmp ORDER BY glar009 "
      PREPARE aglq711_sel_s_pr1 FROM l_sql
      DECLARE aglq711_sel_s_cr1 CURSOR FOR aglq711_sel_s_pr1
      LET l_idx = 1
      FOREACH aglq711_sel_s_cr1 INTO g_glar_s[l_idx].glar009
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq711_sel_s_cr1'
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         LET l_idx = l_idx + 1
         IF l_idx > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9035
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
      END FOREACH
      CALL g_glar_s.deleteElement(l_idx)
      LET g_row_count = g_glar_s.getLength()
   END IF 
   
   #按科目分页
   IF g_master.curr_p = 'N' AND g_master.acc_p = 'Y' THEN
      LET l_sql = "SELECT DISTINCT glar001 FROM aglq711_tmp ORDER BY glar001 "
      PREPARE aglq711_sel_s_pr2 FROM l_sql
      DECLARE aglq711_sel_s_cr2 CURSOR FOR aglq711_sel_s_pr2
      LET l_idx = 1
      FOREACH aglq711_sel_s_cr2 INTO g_glar_s[l_idx].glar001
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq711_sel_s_cr2'
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         LET l_idx = l_idx + 1
         IF l_idx > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9035
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
      END FOREACH
      CALL g_glar_s.deleteElement(l_idx)
      LET g_row_count = g_glar_s.getLength()
   END IF 
   
   #按币别、科目分页
   IF g_master.curr_p = 'Y' AND g_master.acc_p = 'Y' THEN
      LET l_sql = "SELECT DISTINCT glar009,glar001 FROM aglq711_tmp ORDER BY glar009,glar001 "
      PREPARE aglq711_sel_s_pr3 FROM l_sql
      DECLARE aglq711_sel_s_cr3 CURSOR FOR aglq711_sel_s_pr3
      LET l_idx = 1
      FOREACH aglq711_sel_s_cr3 INTO g_glar_s[l_idx].glar009,g_glar_s[l_idx].glar001
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq711_sel_s_cr2'
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         LET l_idx = l_idx + 1
         IF l_idx > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9035
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
      END FOREACH
      CALL g_glar_s.deleteElement(l_idx)
      LET g_row_count = g_glar_s.getLength()
   END IF 
   
   DISPLAY g_row_count TO FORMONLY.h_count
END FUNCTION
# 传进XG报表隐藏栏位设置
PRIVATE FUNCTION aglq711_xg_visible()
   LET g_xg_visible = NULL

   IF g_master.curr_o = 'N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar009|l_oqc|l_oqjd|l_oqjc|l_oqm"
   END IF     

   #顯示本位幣三
   IF g_master.ctype = '2' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_qc2|l_qjd2|l_qjc2|l_qm2"
   END IF
   #顯示本位幣二
   IF g_master.ctype = '1' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_qc3|l_qjd3|l_qjc3|l_qm3"
   END IF
   #只顯示本位幣一
   IF g_master.ctype='0' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_qc2|l_qjd2|l_qjc2|l_qm2|l_qc3|l_qjd3|l_qjc3|l_qm3"
   END IF
   
   #科目
   IF g_master.show_acc = 'N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar001|l_glar001_desc"
   END IF
END FUNCTION
# 打印
PRIVATE FUNCTION aglq711_output()
   DEFINE l_i,l_count      LIKE type_t.num5
   DEFINE l_smm,l_emm      STRING
   DEFINE l_glaald_desc    LIKE type_t.chr500,
          l_glaacomp_desc  LIKE type_t.chr500,
          l_glaa001_desc   LIKE type_t.chr500,
          l_year           LIKE type_t.chr500,
          l_mm             LIKE type_t.chr500,
          l_ctype          LIKE type_t.chr500,
          l_stus           LIKE type_t.chr500,
          l_dir1           LIKE type_t.chr500,
          l_dir2           LIKE type_t.chr500
       
   DELETE FROM aglq711_tmp01          
   LET l_count = g_detail.getLength()
   
   LET l_glaald_desc = g_master.glaald," ",g_master.glaald_desc
   LET l_glaacomp_desc = g_master.glaacomp," ",g_master.glaacomp_desc
   LET l_glaa001_desc = g_master.glaa001," ",g_master.glaa016," ",g_master.glaa020
   LET l_year = g_master.year
   LET l_smm = g_master.smm
   LET l_emm = g_master.emm
   LET l_mm = l_smm,"-",l_emm
   LET l_ctype = g_master.ctype,":",s_desc_gzcbl004_desc('9921',g_master.ctype)
   LET l_stus = g_master.stus,":",s_desc_gzcbl004_desc('9922',g_master.stus)
   
   FOR l_i = 1 TO l_count
      LET l_dir1 = g_detail[l_i].dir1,":",s_desc_gzcbl004_desc('9926',g_detail[l_i].dir1)
      LET l_dir2 = g_detail[l_i].dir2,":",s_desc_gzcbl004_desc('9926',g_detail[l_i].dir2)
      INSERT INTO aglq711_tmp01      
      VALUES(l_glaald_desc,l_glaacomp_desc,l_glaa001_desc,l_year,l_mm,
         l_ctype,l_stus,g_detail[l_i].glar001,g_detail[l_i].glar001_desc,
         g_detail[l_i].glar017,g_detail[l_i].glar017_desc,g_detail[l_i].glar009, 
         l_dir1,g_detail[l_i].oqc,g_detail[l_i].qc,g_detail[l_i].qc2,g_detail[l_i].qc3, 
         g_detail[l_i].oqjd,g_detail[l_i].oqjc,g_detail[l_i].qjd,g_detail[l_i].qjc, 
         g_detail[l_i].qjd2,g_detail[l_i].qjc2,g_detail[l_i].qjd3,g_detail[l_i].qjc3,
         l_dir2,g_detail[l_i].oqm,g_detail[l_i].qm,g_detail[l_i].qm2,g_detail[l_i].qm3)
         
   END FOR
   CALL aglq711_xg_visible()
   CALL aglq711_x01(' 1=1','aglq711_tmp01',g_xg_visible)
END FUNCTION

 
{</section>}
 
