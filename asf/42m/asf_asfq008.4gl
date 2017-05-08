#該程式未解開Section, 採用最新樣板產出!
{<section id="asfq008.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-06-21 14:52:05), PR版次:0004(2016-06-20 17:26:32)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000089
#+ Filename...: asfq008
#+ Description: 工單用料交期綜合查詢
#+ Creator....: 01534(2014-07-31 12:09:41)
#+ Modifier...: 04441 -SD/PR- 04441
 
{</section>}
 
{<section id="asfq008.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160512-00004#1   16/06/20  By Whitney inai012製造日期改抓inae010
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
   sfaadocno LIKE sfaa_t.sfaadocno, 
   sfaadocdt LIKE sfaa_t.sfaadocdt, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   sfaa010_desc LIKE type_t.chr500, 
   sfaa010_desc_desc LIKE type_t.chr500, 
   sfaa011 LIKE sfaa_t.sfaa011, 
   sfaa012 LIKE sfaa_t.sfaa012, 
   sfaa013 LIKE sfaa_t.sfaa013, 
   sfaa013_desc LIKE type_t.chr500, 
   sfaa050 LIKE sfaa_t.sfaa050, 
   sfaa049 LIKE sfaa_t.sfaa049, 
   sfaa017 LIKE sfaa_t.sfaa017, 
   sfaa017_desc LIKE type_t.chr500, 
   sfaa002 LIKE sfaa_t.sfaa002, 
   sfaa002_desc LIKE type_t.chr500, 
   sfaa019 LIKE sfaa_t.sfaa019, 
   sfaa020 LIKE sfaa_t.sfaa020
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 type type_g_sfaa_m        RECORD
   sfaadocno LIKE sfaa_t.sfaadocno, 
   sfaadocdt LIKE sfaa_t.sfaadocdt, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   sfaa010_desc LIKE type_t.chr500, 
   sfaa010_desc_desc LIKE type_t.chr500, 
   sfaa011 LIKE sfaa_t.sfaa011, 
   sfaa012 LIKE sfaa_t.sfaa012, 
   sfaa013 LIKE sfaa_t.sfaa013, 
   sfaa013_desc LIKE type_t.chr500, 
   sfaa050 LIKE sfaa_t.sfaa050, 
   sfaa049 LIKE sfaa_t.sfaa049, 
   sfaa017 LIKE sfaa_t.sfaa017, 
   sfaa017_desc LIKE type_t.chr500, 
   sfaa002 LIKE sfaa_t.sfaa002, 
   sfaa002_desc LIKE type_t.chr500, 
   sfaa019 LIKE sfaa_t.sfaa019, 
   sfaa020 LIKE sfaa_t.sfaa020
       END RECORD
       
 TYPE type_g_sfba_d RECORD
   chk        LIKE inpa_t.inpa009,
   sfbasite   LIKE sfba_t.sfbasite,
   sfbaseq    LIKE sfba_t.sfba014,
   sfbaseq1   LIKE sfba_t.sfbaseq1,
   sfba006    LIKE sfba_t.sfba006,
   sfba006_desc      LIKE type_t.chr500,
   sfba006_desc_1    LIKE type_t.chr500,
   sfba021    LIKE sfba_t.sfba021,
   sfba014    LIKE sfba_t.sfba014,
   sfba014_desc    LIKE type_t.chr500,
   sfba013    LIKE sfba_t.sfba013,
   sfba016    LIKE sfba_t.sfba016,
   sfba016_w    LIKE sfba_t.sfba016,
   sfaa049_w    LIKE sfaa_t.sfaa049,
   sfba019    LIKE sfba_t.sfba019,
   sfba019_desc  LIKE type_t.chr500, 
   sfba020    LIKE sfba_t.sfba020,
   sfba020_desc  LIKE type_t.chr500,  
   used_num      LIKE sfba_t.sfba013,
   set           LIKE sfba_t.sfba013   
       END RECORD

 TYPE type_g_inag_d RECORD
   inagsite LIKE inag_t.inagsite,
   inag004 LIKE inag_t.inag004, 
   inag004_desc LIKE type_t.chr500, 
   inag005 LIKE inag_t.inag005, 
   inag005_desc LIKE type_t.chr500, 
   inag006 LIKE inag_t.inag006, 
   inag002 LIKE inag_t.inag002, 
   inag003 LIKE inag_t.inag003, 
   inag007 LIKE inag_t.inag007, 
   inag007_desc LIKE type_t.chr500, 
   inag008 LIKE inag_t.inag008, 
   inag033 LIKE inag_t.inag033,
   inag010 LIKE inag_t.inag010,
   inag011 LIKE inag_t.inag011,
   inag012 LIKE inag_t.inag012,
   inaa015 LIKE inaa_t.inaa015,
   inag018 LIKE inag_t.inag018,
   inag022 LIKE inag_t.inag022   
       END RECORD

     
 TYPE type_g_inai_d RECORD
   inai004 LIKE inai_t.inai004, 
   inai004_desc LIKE type_t.chr500, 
   inai005 LIKE inai_t.inai005, 
   inai005_desc LIKE type_t.chr500,
   inai006 LIKE inai_t.inai006, 
   inai002 LIKE inai_t.inai002, 
   inai003 LIKE inai_t.inai003, 
   inai007 LIKE inai_t.inai007, 
   inai008 LIKE inai_t.inai008, 
   inai009 LIKE inai_t.inai009, 
   inai009_desc LIKE type_t.chr500,
   inai011 LIKE inai_t.inai011, 
  #inai012 LIKE inai_t.inai012  #160512-00004#1 by whitney mark
   inae010 LIKE inae_t.inae010  #160512-00004#1 by whitney add
       END RECORD     
       
 TYPE type_g_sfaa2_d RECORD
   date1    LIKE inag_t.inag014,
   type1    LIKE inag_t.inag010,
   gj_num   LIKE inag_t.inag008, 
   xq_num   LIKE inag_t.inag008,  
   docno    LIKE inaj_t.inaj001, 
   seq      LIKE inaj_t.inaj002,
   object   LIKE inaj_t.inaj001,
   object_desc  LIKE type_t.chr500, 
   ck_docno LIKE inaj_t.inaj001,
   stock    LIKE inag_t.inag008, 
   ooag001  LIKE ooag_t.ooag001,
   ooag011  LIKE ooag_t.ooag011,
   ooeg001  LIKE ooeg_t.ooeg001,
   ooeg001_desc LIKE ooefl_t.ooefl003,
   prog     LIKE inaj_t.inaj035   
   
       END RECORD
       
DEFINE g_sfaa2_d            DYNAMIC ARRAY OF type_g_sfaa2_d
DEFINE g_sfaa2_d_t          type_g_sfaa2_d   
DEFINE g_sfba_d             DYNAMIC ARRAY OF type_g_sfba_d
DEFINE g_sfba_d_t           type_g_sfba_d 
DEFINE g_inag_d             DYNAMIC ARRAY OF type_g_inag_d
DEFINE g_inag_d_t           type_g_inag_d   
DEFINE g_inai_d             DYNAMIC ARRAY OF type_g_inai_d
DEFINE g_inai_d_t           type_g_inai_d 
DEFINE l_ac2                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE l_ac3                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE l_ac4                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE l_ac5                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE l_ac6                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE g_detail_idx3          LIKE type_t.num5
DEFINE g_detail_idx4          LIKE type_t.num5
DEFINE g_detail_idx5          LIKE type_t.num5
DEFINE g_detail_cnt2          LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_cnt3          LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_cnt4          LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_cnt5          LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_sfaa019_q            LIKE sfaa_t.sfaa019
DEFINE g_last_day             LIKE sfaa_t.sfaa019
DEFINE g_sfaa019              LIKE sfaa_t.sfaa019
DEFINE g_sfaa019_q_t          LIKE sfaa_t.sfaa019
DEFINE g_gxdate               LIKE type_t.chr1
DEFINE g_invent               LIKE type_t.chr1
DEFINE g_bdate                LIKE sfaa_t.sfaa019 
DEFINE g_imaa006              LIKE imaa_t.imaa006
DEFINE g_sum1                 LIKE inag_t.inag008
DEFINE g_sum2                 LIKE inag_t.inag008
DEFINE g_sum3                 LIKE inag_t.inag008
#end add-point
 
#模組變數(Module Variables)
DEFINE g_sfaa_d            DYNAMIC ARRAY OF type_g_sfaa_d
DEFINE g_sfaa_d_t          type_g_sfaa_d
 
 
 
 
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
 
{<section id="asfq008.main" >}
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
   DECLARE asfq008_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE asfq008_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asfq008_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfq008 WITH FORM cl_ap_formpath("asf",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asfq008_init()   
 
      #進入選單 Menu (="N")
      CALL asfq008_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asfq008
      
   END IF 
   
   CLOSE asfq008_cl
   
   
 
   #add-point:作業離開前 name="main.exit"

   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asfq008.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION asfq008_init()
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
   CALL cl_set_combo_scc('type','1020')   
   CALL cl_set_combo_scc('gxdate','4032')
   CALL cl_set_combo_scc('invent','1021')  
   LET g_gxdate = '1'
   LET g_invent = '1'
   DISPLAY g_gxdate TO gxdate
   DISPLAY g_invent TO invent
   LET g_sfaa019_q = g_today
   LET g_sfaa019_q_t = g_today
   DISPLAY g_sfaa019_q TO sfaa019_q
   DISPLAY g_today TO day  
   
   DROP TABLE asfq008_temp

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop asfq008_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF   
   CREATE TEMP TABLE asfq008_temp(
          date1         DATE,
          type1         VARCHAR(1),
          gj_num        DECIMAL(20,6), 
          xq_num        DECIMAL(20,6), 
          docno         VARCHAR(20), 
          seq           INTEGER,
          object        VARCHAR(20),
          object_desc   VARCHAR(500), 
          ck_docno      VARCHAR(20),
          stock         DECIMAL(20,6), 
          ooag001       VARCHAR(20),
          ooag011       VARCHAR(255),
          ooeg001       VARCHAR(10),
          ooeg001_desc  VARCHAR(500),
          prog          VARCHAR(20)
          )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create asfq008_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF      
   #end add-point
 
   CALL asfq008_default_search()
END FUNCTION
 
{</section>}
 
{<section id="asfq008.default_search" >}
PRIVATE FUNCTION asfq008_default_search()
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
 
{<section id="asfq008.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfq008_ui_dialog() 
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
#   DEFINE la_param  RECORD                  #程式串查用變數
#             prog   STRING,                 #串查程式名稱
#             param  DYNAMIC ARRAY OF STRING #傳遞變數
#                    END RECORD
#   DEFINE ls_js     STRING                  #轉換後的json字串   
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
   LET g_sfaa019_q = g_today
   DISPLAY g_sfaa019_q TO sfaa019_q
   DISPLAY g_today TO day
#   CALL asfq008_construct()
   CALL cl_set_combo_scc('gxdate','4032')
   CALL cl_set_combo_scc('invent','1021') 
   DISPLAY g_gxdate TO gxdate
   DISPLAY g_invent TO invent
   DISPLAY g_sfaa019_q TO sfaa019_q
   DISPLAY g_today TO day
   #end add-point
 
   
   CALL asfq008_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_sfaa_d.clear()
 
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
 
         CALL asfq008_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT g_gxdate,g_invent,g_sfaa019_q FROM gxdate,invent,sfaa019_q
               ATTRIBUTE(WITHOUT DEFAULTS)         
            BEFORE INPUT
               IF cl_null(g_gxdate) THEN LET g_gxdate = '1' END IF
               IF cl_null(g_invent) THEN LET g_invent = '6' END IF
               DISPLAY g_gxdate TO gxdate
               DISPLAY g_invent TO invent   
               DISPLAY g_sfaa019_q TO sfaa019_q
            
            AFTER FIELD sfaa019_q
               IF g_gxdate = '1' THEN
                  LET g_last_day = g_today + 7
               END IF
               IF g_gxdate = '2' THEN
                  LET g_last_day = g_today + 14
               END IF  
               IF g_gxdate = '3' THEN
                  LET g_last_day = g_today + 30
               END IF 
               IF g_gxdate = '4' THEN
                  LET g_last_day = g_today + 90
               END IF                
               IF g_sfaa019_q > g_last_day THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_last_day 
                  LET g_errparam.code   = 'ain-00322' 
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()                       
                  LET g_sfaa019_q = g_sfaa019_q_t
                  NEXT FIELD sfaa019_q
               END IF
               LET g_sfaa019_q_t = g_sfaa019_q           
               CALL asfq008_b_fill2() 
               CALL ui.interface.refresh() 
               
            ON CHANGE gxdate
               CALL asfq008_b_fill5('N')
               CALL ui.interface.refresh()
               
            ON CHANGE invent
               CALL asfq008_b_fill3()
               CALL ui.interface.refresh()  
               
            ON CHANGE g_sfaa019_q
               IF g_sfaa019_q > g_last_day THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_last_day
                  LET g_errparam.code   = 'ain-00322' 
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()                       
                  LET g_sfaa019_q = g_sfaa019_q_t
                  NEXT FIELD sfaa019_q
               END IF
               LET g_sfaa019_q_t = g_sfaa019_q            
               CALL asfq008_b_fill2() 
               CALL ui.interface.refresh()              

         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON sfaadocno,sfaadocdt,sfaa010,sfaa011,sfaa012,sfaa013,sfaa050,sfaa049,sfaa017,sfaa002,
                                   sfaa019,sfaa020                               
            BEFORE CONSTRUCT   
            
            ON ACTION controlp INFIELD sfaadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_sfaadocno_1()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaadocno  #顯示到畫面上
         
               NEXT FIELD sfaadocno      
         
            ON ACTION controlp INFIELD sfaa010
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001_9()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa010  #顯示到畫面上
         
               NEXT FIELD sfaa010
               
            ON ACTION controlp INFIELD sfaa011
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_sfaa011()                             #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa011        #顯示到畫面上
         
               NEXT FIELD sfaa011               
         
            ON ACTION controlp INFIELD sfaa013
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooca001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa013  #顯示到畫面上
         
               NEXT FIELD sfaa013
               
            ON ACTION controlp INFIELD sfaa017
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001_1()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa017  #顯示到畫面上
               NEXT FIELD sfaa017             
               
            ON ACTION controlp INFIELD sfaa002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001_2()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa002  #顯示到畫面上
               NEXT FIELD sfaa002
                                         
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_sfaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL asfq008_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL asfq008_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"

               DISPLAY g_sfaa019_q TO sfaa019_q
               DISPLAY g_today TO day  
               DISPLAY g_sfaa_d.getLength() TO FORMONLY.cnt
               DISPLAY g_sfaa_d.getLength() TO FORMONLY.h_count               
               DISPLAY g_detail_idx TO FORMONLY.idx
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_sfba_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2)
 
            BEFORE DISPLAY
               LET g_current_page = 1
               DISPLAY g_sfaa019_q TO sfaa019_q
               DISPLAY g_today TO day  
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac2 = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_sfba_d.getLength() TO FORMONLY.h_count
               DISPLAY g_sfba_d.getLength() TO FORMONLY.cnt
               DISPLAY g_detail_idx2 TO FORMONLY.idx               
               LET g_master_idx = l_ac2
               CALL asfq008_b_fill3()
               CALL asfq008_b_fill4()              
               CALL asfq008_b_fill5('N')
                           
         END DISPLAY

         DISPLAY ARRAY g_inag_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt3)
 
            BEFORE DISPLAY
               LET g_current_page = 1
               DISPLAY g_sfaa019_q TO sfaa019_q
               DISPLAY g_today TO day   
            BEFORE ROW
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac3 = g_detail_idx3
               DISPLAY g_detail_idx3 TO FORMONLY.h_index
               DISPLAY g_inag_d.getLength() TO FORMONLY.h_count
               DISPLAY g_inag_d.getLength() TO FORMONLY.cnt
               DISPLAY g_detail_idx3 TO FORMONLY.idx               
               LET g_master_idx = l_ac3
               CALL asfq008_b_fill4()
           
         END DISPLAY
         
         DISPLAY ARRAY g_inai_d TO s_detail4.* ATTRIBUTE(COUNT=g_detail_cnt4)
 
            BEFORE DISPLAY
               LET g_current_page = 1
               DISPLAY g_sfaa019_q TO sfaa019_q
               DISPLAY g_today TO day   
            BEFORE ROW
               LET g_detail_idx4 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac4 = g_detail_idx4
               DISPLAY g_detail_idx4 TO FORMONLY.h_index
               DISPLAY g_inai_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac4
               DISPLAY g_inai_d.getLength() TO FORMONLY.cnt
               DISPLAY g_detail_idx4 TO FORMONLY.idx            
         END DISPLAY  
  
         DISPLAY ARRAY g_sfaa2_d TO s_detail5.* ATTRIBUTE(COUNT=g_detail_cnt5)
 
            BEFORE DISPLAY
               LET g_current_page = 1
               DISPLAY g_sfaa019_q TO sfaa019_q
               DISPLAY g_today TO day  
               
            BEFORE ROW
               LET g_detail_idx5 = DIALOG.getCurrentRow("s_detail5")
               LET l_ac5 = g_detail_idx5
               DISPLAY g_detail_idx5 TO FORMONLY.h_index
               DISPLAY g_sfaa2_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac5
               DISPLAY g_sfaa2_d.getLength() TO FORMONLY.cnt
               DISPLAY g_detail_idx5 TO FORMONLY.idx
               
            ON ACTION modify_detail
               LET g_action_choice="modify_detail"
               IF cl_auth_chk_act("query") THEN
                  LET la_param.prog = g_sfaa2_d[l_ac5].prog
                  LET la_param.param[1] = g_sfaa2_d[l_ac5].docno
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
                  EXIT DIALOG
               END IF      
            
         END DISPLAY 
   
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL asfq008_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            DISPLAY g_today TO day
            DISPLAY g_sfaa019_q TO sfaa019_q
            DISPLAY g_today TO day
            NEXT FIELD sfaadocno
            #end add-point
            NEXT FIELD sfaadocno
 
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
            CALL asfq008_b_fill()
 
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
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL asfq008_b_fill()
 
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
            CALL asfq008_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL asfq008_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL asfq008_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL asfq008_b_fill()
 
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
            CALL asfq008_filter()
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
               CALL asfq008_query()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION subtract
            LET g_action_choice="subtract"
               
               #add-point:ON ACTION subtract name="menu.subtract"
               IF g_sfaa019_q = g_today THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "FOREACH:" 
                  LET g_errparam.code   = 'ain-00321' 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()                  
               END IF
               IF g_sfaa019_q > g_today THEN
                  LET g_sfaa019_q = g_sfaa019_q - 1
               END IF   
               DISPLAY g_sfaa019_q TO sfaa019_q
#               CALL asfq008_b_fill5('Y')
               CALL asfq008_b_fill2() 
               #END add-point
               
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION add
            LET g_action_choice="add"
               
               #add-point:ON ACTION add name="menu.add"
               IF g_gxdate = '1' THEN
                  LET g_last_day = g_today + 7
               END IF
               IF g_gxdate = '2' THEN
                  LET g_last_day = g_today + 14
               END IF  
               IF g_gxdate = '3' THEN
                  LET g_last_day = g_today + 30
               END IF 
               IF g_gxdate = '4' THEN
                  LET g_last_day = g_today + 90
               END IF 
               IF g_gxdate <> '5' AND g_sfaa019_q < g_last_day THEN                
                  LET g_sfaa019_q = g_sfaa019_q + 1                                 
               END IF   
               IF g_gxdate = '5' THEN
                  LET g_sfaa019_q = g_sfaa019_q + 1          
               END IF
               DISPLAY g_sfaa019_q TO sfaa019_q
               DISPLAY g_today TO day
#               CALL asfq008_b_fill5('Y')
               CALL asfq008_b_fill2() 
               #END add-point
               
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               IF g_sfaa019_q > g_today THEN
                  LET g_sfaa019_q = g_sfaa019_q - 1
               END IF   
               DISPLAY g_sfaa019_q TO sfaa019_q
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
 
{<section id="asfq008.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asfq008_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_detail_idx3 = 1
   LET g_detail_idx4 = 1
   LET g_detail_idx5 = 1
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

   CALL g_sfba_d.clear()
   CALL g_inai_d.clear()
   CALL g_sfaa2_d.clear()
   CALL g_inag_d.clear()  
   #add by lixh 20150521
   LET g_sum1 = ''
   LET g_sum2 = ''
   LET g_sum3 = ''
   DISPLAY g_sum1 TO sum1
   DISPLAY g_sum2 TO sum2
   DISPLAY g_sum3 TO sum3
   #add by lixh 20150521   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',sfaadocno,sfaadocdt,sfaa010,'','',sfaa011,sfaa012,sfaa013,'', 
       sfaa050,sfaa049,sfaa017,'',sfaa002,'',sfaa019,sfaa020  ,DENSE_RANK() OVER( ORDER BY sfaa_t.sfaadocno) AS RANK FROM sfaa_t", 
 
 
 
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
 
   LET g_sql = "SELECT '',sfaadocno,sfaadocdt,sfaa010,'','',sfaa011,sfaa012,sfaa013,'',sfaa050,sfaa049, 
       sfaa017,'',sfaa002,'',sfaa019,sfaa020",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  UNIQUE 'Y',sfaadocno,sfaadocdt,sfaa010,'','',sfaa011,sfaa012,sfaa013,'',sfaa050, 
       sfaa049,sfaa017,'',sfaa002,'',sfaa019,sfaa020 FROM sfaa_t",
 
 
               "",
#               " WHERE sfaaent= ? AND sfaasite = '",g_site,"' AND 1=1  AND sfaa019 > = '",g_sfaa019_q,"'", " AND ", ls_wc
               " WHERE sfaaent= ?  AND sfaastus = 'F' AND sfaasite = '",g_site,"' AND 1=1 ", " AND ", ls_wc               
 
   LET g_sql = g_sql, cl_sql_add_filter("sfaa_t"),
                      " ORDER BY sfaa_t.sfaadocno"   
                      
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asfq008_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asfq008_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_sfaa_d[l_ac].sel,g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfaadocdt,g_sfaa_d[l_ac].sfaa010, 
       g_sfaa_d[l_ac].sfaa010_desc,g_sfaa_d[l_ac].sfaa010_desc_desc,g_sfaa_d[l_ac].sfaa011,g_sfaa_d[l_ac].sfaa012, 
       g_sfaa_d[l_ac].sfaa013,g_sfaa_d[l_ac].sfaa013_desc,g_sfaa_d[l_ac].sfaa050,g_sfaa_d[l_ac].sfaa049, 
       g_sfaa_d[l_ac].sfaa017,g_sfaa_d[l_ac].sfaa017_desc,g_sfaa_d[l_ac].sfaa002,g_sfaa_d[l_ac].sfaa002_desc, 
       g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020
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
 
      CALL asfq008_detail_show("'1'")
 
      CALL asfq008_sfaa_t_mask()
 
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
 
   CALL g_sfaa_d.deleteElement(g_sfaa_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   LET g_detail_cnt = g_sfaa_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   DISPLAY g_detail_idx TO FORMONLY.idx
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_sfaa_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE asfq008_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL asfq008_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL asfq008_detail_action_trans()
 
   LET l_ac = 1
   IF g_sfaa_d.getLength() > 0 THEN
      CALL asfq008_b_fill2()
   END IF
 
      CALL asfq008_filter_show('sfaadocno','b_sfaadocno')
   CALL asfq008_filter_show('sfaadocdt','b_sfaadocdt')
   CALL asfq008_filter_show('sfaa010','b_sfaa010')
   CALL asfq008_filter_show('sfaa011','b_sfaa011')
   CALL asfq008_filter_show('sfaa012','b_sfaa012')
   CALL asfq008_filter_show('sfaa013','b_sfaa013')
   CALL asfq008_filter_show('sfaa050','b_sfaa050')
   CALL asfq008_filter_show('sfaa049','b_sfaa049')
   CALL asfq008_filter_show('sfaa017','b_sfaa017')
   CALL asfq008_filter_show('sfaa002','b_sfaa002')
   CALL asfq008_filter_show('sfaa019','b_sfaa019')
   CALL asfq008_filter_show('sfaa020','b_sfaa020')
 
 
END FUNCTION
 
{</section>}
 
{<section id="asfq008.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asfq008_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   DEFINE l_sfba010       LIKE sfba_t.sfba010
   DEFINE l_sfba011       LIKE sfba_t.sfba011
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"

   CALL g_sfba_d.clear()
   LET l_sql = " SELECT '',sfbasite,sfbaseq,sfbaseq1,sfba006,'','',sfba021,sfba014,'',sfba013,sfba016,'','',sfba019,'',sfba020,'','','',sfba010,sfba011,sfaa019 FROM sfba_t,sfaa_t ",
               "  WHERE sfaaent = sfbaent ",
               "    AND sfaadocno = sfbadocno ",
               "    AND sfbaent = '",g_enterprise,"'",
               "    AND sfaasite = '",g_site,"'",
               "    AND sfbadocno ='",g_sfaa_d[l_ac].sfaadocno,"'"
               
   PREPARE asfq008_sfba_pre FROM l_sql
   DECLARE asfq008_sfba_cur CURSOR FOR asfq008_sfba_pre
   LET l_ac2 = 1 
   FOREACH asfq008_sfba_cur INTO g_sfba_d[l_ac2].chk,g_sfba_d[l_ac2].sfbasite,g_sfba_d[l_ac2].sfbaseq,g_sfba_d[l_ac2].sfbaseq1,g_sfba_d[l_ac2].sfba006,g_sfba_d[l_ac2].sfba006_desc,g_sfba_d[l_ac2].sfba006_desc_1,g_sfba_d[l_ac2].sfba021,
                                 g_sfba_d[l_ac2].sfba014,g_sfba_d[l_ac2].sfba014_desc,g_sfba_d[l_ac2].sfba013,g_sfba_d[l_ac2].sfba016,g_sfba_d[l_ac2].sfba016_w,
                                 g_sfba_d[l_ac2].sfaa049_w,g_sfba_d[l_ac2].sfba019,g_sfba_d[l_ac2].sfba019_desc,g_sfba_d[l_ac2].sfba020,g_sfba_d[l_ac2].sfba020_desc,
                                 g_sfba_d[l_ac2].used_num,g_sfba_d[l_ac2].set,l_sfba010,l_sfba011,g_sfaa019
                                 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET g_sfba_d[l_ac2].sfba016_w = g_sfba_d[l_ac2].sfba013 - g_sfba_d[l_ac2].sfba016
      CALL s_desc_get_item_desc(g_sfba_d[l_ac2].sfba006) RETURNING g_sfba_d[l_ac2].sfba006_desc,g_sfba_d[l_ac2].sfba006_desc_1
      CALL s_desc_get_unit_desc(g_sfba_d[l_ac2].sfba014) RETURNING g_sfba_d[l_ac2].sfba014_desc
      CALL s_desc_get_stock_desc(g_sfba_d[l_ac2].sfbasite,g_sfba_d[l_ac2].sfba019) RETURNING g_sfba_d[l_ac2].sfba019_desc
      CALL s_desc_get_locator_desc(g_sfba_d[l_ac2].sfbasite,g_sfba_d[l_ac2].sfba019,g_sfba_d[l_ac2].sfba020) 
           RETURNING g_sfba_d[l_ac2].sfba020_desc   
           
      CALL asfq008_b_fill5('Y')    
      LET g_sfba_d[l_ac2].used_num = g_sum3  
      
      LET g_sfba_d[l_ac2].used_num = g_sum3  
#      IF g_sfba_d[l_ac2].used_num > g_sfba_d[l_ac2].sfba016_w THEN
#         LET g_sfba_d[l_ac2].sfbaseq = g_sfba_d[l_ac2].sfbaseq,"*"
#      END IF
      IF g_sfba_d[l_ac2].used_num < g_sfba_d[l_ac2].sfba016_w THEN    #add by lixh 20150121
         LET g_sfba_d[l_ac2].chk = '*'
      END IF
      
      IF NOT cl_null(l_sfba010) AND NOT cl_null(l_sfba011) THEN
         LET g_sfba_d[l_ac2].set = g_sfba_d[l_ac2].used_num/(l_sfba010*l_sfba011)
      END IF    
      IF NOT cl_null(l_sfba010) AND NOT cl_null(l_sfba011) THEN
         LET g_sfba_d[l_ac2].sfaa049_w = g_sfba_d[l_ac2].sfba016_w/(l_sfba010*l_sfba011)
      END IF       
      LET l_ac2 = l_ac2 + 1
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
   END FOREACH 
   LET g_error_show = 0   
   LET g_detail_cnt2 = l_ac2 - 1
#   DISPLAY g_detail_cnt2 TO FORMONLY.h_count 
#   DISPLAY g_detail_cnt2 TO FORMONLY.cnt  
   CALL g_sfba_d.deleteElement(g_sfba_d.getLength())  
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   DISPLAY ARRAY g_sfba_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2)
      BEFORE DISPLAY 
         EXIT DISPLAY
   END DISPLAY   
   CALL asfq008_b_fill3()
   CALL asfq008_b_fill4()
   IF g_detail_cnt2 > 0 THEN
      CALL asfq008_b_fill5('N') 
   END IF      
   DISPLAY g_sfaa019_q TO sfaa019_q
   DISPLAY g_today TO day     
   #add-point:陣列長度調整

   #end add-point
 

 

   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="asfq008.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asfq008_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_sfaa_d[l_ac].sfaa010
            LET ls_sql = "SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_sfaa_d[l_ac].sfaa010_desc = '', g_rtn_fields[1] , ''
            LET g_sfaa_d[l_ac].sfaa010_desc_desc = '', g_rtn_fields[2] , ''
            DISPLAY BY NAME g_sfaa_d[l_ac].sfaa010_desc,g_sfaa_d[l_ac].sfaa010_desc_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfaa_d[l_ac].sfaa010
            LET ls_sql = "SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_sfaa_d[l_ac].sfaa010_desc_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfaa_d[l_ac].sfaa010_desc_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfaa_d[l_ac].sfaa013
            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_sfaa_d[l_ac].sfaa013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfaa_d[l_ac].sfaa013_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfaa_d[l_ac].sfaa017
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_sfaa_d[l_ac].sfaa017_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfaa_d[l_ac].sfaa017_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfaa_d[l_ac].sfaa002
            LET ls_sql = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? "
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_sfaa_d[l_ac].sfaa002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfaa_d[l_ac].sfaa002_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfq008.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION asfq008_filter()
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
      CONSTRUCT g_wc_filter ON sfaadocno,sfaadocdt,sfaa010,sfaa011,sfaa012,sfaa013,sfaa050,sfaa049,sfaa017, 
          sfaa002,sfaa019,sfaa020
                          FROM s_detail1[1].b_sfaadocno,s_detail1[1].b_sfaadocdt,s_detail1[1].b_sfaa010, 
                              s_detail1[1].b_sfaa011,s_detail1[1].b_sfaa012,s_detail1[1].b_sfaa013,s_detail1[1].b_sfaa050, 
                              s_detail1[1].b_sfaa049,s_detail1[1].b_sfaa017,s_detail1[1].b_sfaa002,s_detail1[1].b_sfaa019, 
                              s_detail1[1].b_sfaa020
 
         BEFORE CONSTRUCT
                     DISPLAY asfq008_filter_parser('sfaadocno') TO s_detail1[1].b_sfaadocno
            DISPLAY asfq008_filter_parser('sfaadocdt') TO s_detail1[1].b_sfaadocdt
            DISPLAY asfq008_filter_parser('sfaa010') TO s_detail1[1].b_sfaa010
            DISPLAY asfq008_filter_parser('sfaa011') TO s_detail1[1].b_sfaa011
            DISPLAY asfq008_filter_parser('sfaa012') TO s_detail1[1].b_sfaa012
            DISPLAY asfq008_filter_parser('sfaa013') TO s_detail1[1].b_sfaa013
            DISPLAY asfq008_filter_parser('sfaa050') TO s_detail1[1].b_sfaa050
            DISPLAY asfq008_filter_parser('sfaa049') TO s_detail1[1].b_sfaa049
            DISPLAY asfq008_filter_parser('sfaa017') TO s_detail1[1].b_sfaa017
            DISPLAY asfq008_filter_parser('sfaa002') TO s_detail1[1].b_sfaa002
            DISPLAY asfq008_filter_parser('sfaa019') TO s_detail1[1].b_sfaa019
            DISPLAY asfq008_filter_parser('sfaa020') TO s_detail1[1].b_sfaa020
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
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
 
 
         #----<<b_sfaadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_sfaadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaadocdt
            #add-point:ON ACTION controlp INFIELD b_sfaadocdt name="construct.c.filter.page1.b_sfaadocdt"
            
            #END add-point
 
 
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
         #----<<b_sfaa010_desc_desc>>----
         #----<<b_sfaa011>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa011
            #add-point:ON ACTION controlp INFIELD b_sfaa011 name="construct.c.filter.page1.b_sfaa011"
            
            #END add-point
 
 
         #----<<b_sfaa012>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa012
            #add-point:ON ACTION controlp INFIELD b_sfaa012 name="construct.c.filter.page1.b_sfaa012"
            
            #END add-point
 
 
         #----<<b_sfaa013>>----
         #Ctrlp:construct.c.page1.b_sfaa013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa013
            #add-point:ON ACTION controlp INFIELD b_sfaa013 name="construct.c.filter.page1.b_sfaa013"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfaa013  #顯示到畫面上
            NEXT FIELD b_sfaa013                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_sfaa013_desc>>----
         #----<<b_sfaa050>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa050
            #add-point:ON ACTION controlp INFIELD b_sfaa050 name="construct.c.filter.page1.b_sfaa050"
            
            #END add-point
 
 
         #----<<b_sfaa049>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa049
            #add-point:ON ACTION controlp INFIELD b_sfaa049 name="construct.c.filter.page1.b_sfaa049"
            
            #END add-point
 
 
         #----<<b_sfaa017>>----
         #Ctrlp:construct.c.page1.b_sfaa017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa017
            #add-point:ON ACTION controlp INFIELD b_sfaa017 name="construct.c.filter.page1.b_sfaa017"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfaa017  #顯示到畫面上
            NEXT FIELD b_sfaa017                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_sfaa017_desc>>----
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
 
      CALL asfq008_filter_show('sfaadocno','b_sfaadocno')
   CALL asfq008_filter_show('sfaadocdt','b_sfaadocdt')
   CALL asfq008_filter_show('sfaa010','b_sfaa010')
   CALL asfq008_filter_show('sfaa011','b_sfaa011')
   CALL asfq008_filter_show('sfaa012','b_sfaa012')
   CALL asfq008_filter_show('sfaa013','b_sfaa013')
   CALL asfq008_filter_show('sfaa050','b_sfaa050')
   CALL asfq008_filter_show('sfaa049','b_sfaa049')
   CALL asfq008_filter_show('sfaa017','b_sfaa017')
   CALL asfq008_filter_show('sfaa002','b_sfaa002')
   CALL asfq008_filter_show('sfaa019','b_sfaa019')
   CALL asfq008_filter_show('sfaa020','b_sfaa020')
 
 
   CALL asfq008_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="asfq008.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION asfq008_filter_parser(ps_field)
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
 
{<section id="asfq008.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION asfq008_filter_show(ps_field,ps_object)
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
   LET ls_condition = asfq008_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="asfq008.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION asfq008_detail_action_trans()
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
 
{<section id="asfq008.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION asfq008_detail_index_setting()
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
 
{<section id="asfq008.mask_functions" >}
 &include "erp/asf/asfq008_mask.4gl"
 
{</section>}
 
{<section id="asfq008.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 開啟查詢
# Memo...........:
# Usage..........: CALL asfq008_construct()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq008_construct()
#  CLEAR FORM
   CALL g_sfaa_d.clear()
   CALL g_sfaa2_d.clear()
   CALL g_inai_d.clear()
   CALL g_inag_d.clear()
   CALL g_sfba_d.clear()
   LET g_action_choice = ""
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc_filter TO NULL
   LET g_qryparam.state = 'c'
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
       CONSTRUCT BY NAME g_wc ON sfaadocno,sfaadocdt,sfaa010,sfaa011,sfaa012,sfaa013,sfaa050,sfaa049,sfaa017,sfaa002,
                                 sfaa019,sfaa020                               
          BEFORE CONSTRUCT   
          
          ON ACTION controlp INFIELD sfaadocno
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             CALL q_sfaadocno_1()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO sfaadocno  #顯示到畫面上

             NEXT FIELD sfaadocno      

          ON ACTION controlp INFIELD sfaa010
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             CALL q_imaa001_9()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO sfaa010  #顯示到畫面上

             NEXT FIELD sfaa010

          ON ACTION controlp INFIELD sfaa013
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             CALL q_ooca001()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO sfaa013  #顯示到畫面上

             NEXT FIELD sfaa013
             
          ON ACTION controlp INFIELD sfaa017
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             CALL q_ooeg001_1()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO sfaa017  #顯示到畫面上
             NEXT FIELD sfaa017             
             
          ON ACTION controlp INFIELD sfaa002
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             CALL q_ooag001_2()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO sfaa002  #顯示到畫面上
             NEXT FIELD sfaa002
                                       
       END CONSTRUCT
       
       ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
   
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      RETURN
   END IF           
END FUNCTION

################################################################################
# Descriptions...: 查詢
# Memo...........:
# Usage..........: CALL asfq008_query()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq008_query()
DEFINE ls_wc   STRING    
   #清除畫面
   CLEAR FORM  
   CALL g_sfaa_d.clear()
   CALL g_sfba_d.clear()
   CALL g_inai_d.clear()
   CALL g_sfaa2_d.clear()
   CALL g_inag_d.clear()   
   
   LET ls_wc = g_wc
   CALL asfq008_construct()
   DISPLAY g_sfaa019_q TO sfaa019_q
   DISPLAY g_today TO day 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL asfq008_b_fill()
      RETURN
   END IF
   CALL asfq008_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 批序號明細
# Memo...........:
# Usage..........: CALL asfq008_b_fill4()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq008_b_fill4()
DEFINE  l_sql    STRING
   #清除畫面
#   CLEAR FORM  
   CALL g_inai_d.clear() 
   IF g_detail_idx2 = 0 AND cl_null(g_detail_idx2) THEN
      RETURN
   END IF   
   IF l_ac3 = 0 THEN
      RETURN
   END IF
   #add by lixh 20150521
   IF g_detail_cnt2 > 0 AND g_detail_cnt3 > 0 THEN
   ELSE
      RETURN
   END IF
   #add by lixh 20150521
   #160512-00004#1 by whitney modify start
   #LET l_sql = " SELECT inai004,'',inai005,'',inai006,inai002,inai003,inai007,inai008,inai009,'',inai011,inai012 FROM inai_t ",
   #            "  WHERE inaient = '",g_enterprise,"'",
   #            "    AND inaisite = '",g_site,"'"
   LET l_sql = " SELECT inai004,'',inai005,'',inai006,inai002,inai003,inai007,inai008,inai009,'',inai011,inae010 ",
               "   FROM inai_t ",
               "   LEFT JOIN inae_t ON inaeent=inaient AND inae001=inai001 AND inaesite=inaisite AND inae002=inai002 AND inae003=inai007 AND inae004=inai008 ",
               "  WHERE inaient = '",g_enterprise,"'",
               "    AND inaisite = '",g_site,"'"
   #160512-00004#1 by whitney modify end
   IF NOT cl_null(g_sfba_d[g_detail_idx2].sfba006) THEN    
      LET l_sql = l_sql, " AND inai001 = '",g_sfba_d[g_detail_idx2].sfba006,"'"
   END IF   
#   IF NOT cl_null(g_sfba_d[g_detail_idx2].sfba021) THEN    
#      LET l_sql = l_sql, " AND inai014 = '",g_sfba_d[g_detail_idx2].sfba021,"'"
#   END IF   
   IF NOT cl_null(g_inag_d[l_ac3].inag004) THEN    
      LET l_sql = l_sql, " AND inai004 = '",g_inag_d[l_ac3].inag004,"'"
   END IF 
   IF NOT cl_null(g_inag_d[l_ac3].inag005) THEN    
      LET l_sql = l_sql, " AND inai005 = '",g_inag_d[l_ac3].inag005,"'"
   END IF  
   IF NOT cl_null(g_inag_d[l_ac3].inag006) THEN    
      LET l_sql = l_sql, " AND inai006 = '",g_inag_d[l_ac3].inag006,"'"
   END IF  
   IF NOT cl_null(g_inag_d[l_ac3].inag002) THEN    
      LET l_sql = l_sql, " AND inai002 = '",g_inag_d[l_ac3].inag002,"'"
   END IF     
   IF NOT cl_null(g_inag_d[l_ac3].inag003) THEN    
      LET l_sql = l_sql, " AND inai003 = '",g_inag_d[l_ac3].inag003,"'"
   END IF  
   IF NOT cl_null(g_inag_d[l_ac3].inag007) THEN    
      LET l_sql = l_sql, " AND inai009 = '",g_inag_d[l_ac3].inag007,"'"
   END IF 
  
   PREPARE asfq008_inai_pre FROM l_sql
   DECLARE asfq008_inai_cur CURSOR FOR asfq008_inai_pre  
   
   LET l_ac4 = 1
   FOREACH asfq008_inai_cur INTO g_inai_d[l_ac4].inai004,g_inai_d[l_ac4].inai004_desc,g_inai_d[l_ac4].inai005,g_inai_d[l_ac4].inai005_desc,
                                 g_inai_d[l_ac4].inai006,g_inai_d[l_ac4].inai002,g_inai_d[l_ac4].inai003,g_inai_d[l_ac4].inai007,g_inai_d[l_ac4].inai008,
                                 g_inai_d[l_ac4].inai009,g_inai_d[l_ac4].inai009_desc,g_inai_d[l_ac4].inai011,g_inai_d[l_ac4].inae010  #160512-00004#1 by whitney modify inai012->inae010
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      
         EXIT FOREACH
      END IF   
      LET l_ac4 = l_ac4 + 1      
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
   END FOREACH
   CALL g_inai_d.deleteElement(g_inai_d.getLength())   
   LET g_detail_cnt4 = l_ac4 - 1       
   DISPLAY ARRAY g_inai_d TO s_detail4.* ATTRIBUTE(COUNT=g_detail_cnt4)
      BEFORE DISPLAY 
         EXIT DISPLAY
   END DISPLAY   
   DISPLAY g_sfaa019_q TO sfaa019_q
   DISPLAY g_today TO day     
END FUNCTION

################################################################################
# Descriptions...: 供需明細
# Memo...........:
# Usage..........: CALL asfq008_b_fill5(p_type)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq008_b_fill5(p_type)
   DEFINE l_sql           STRING 
   DEFINE l_xmdd004       LIKE xmdd_t.xmdd004
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_rate          LIKE inaj_t.inaj014
   DEFINE l_stock         LIKE inag_t.inag008
   DEFINE l_gj_sum        LIKE inag_t.inag008
   DEFINE l_xq_sum        LIKE inag_t.inag008
   DEFINE l_sfba014       LIKE sfba_t.sfba014
   DEFINE l_sfaa013       LIKE sfaa_t.sfaa013
   DEFINE l_pmdb007       LIKE pmdb_t.pmdb007
   DEFINE l_pmdt019       LIKE pmdt_t.pmdt019
   DEFINE l_inag032       LIKE inag_t.inag032
   DEFINE l_qcba016       LIKE qcba_t.qcba016
   DEFINE l_inag008       LIKE inag_t.inag008
   DEFINE l_sum_inag008   LIKE inag_t.inag008
   DEFINE l_zj_sum        LIKE inag_t.inag008 
   DEFINE l_pmdo004       LIKE pmdo_t.pmdo004  
   DEFINE p_type          LIKE type_t.chr1
   DEFINE l_yy            LIKE type_t.num5 
   DEFINE l_mm            LIKE type_t.num5
   DEFINE l_dd            LIKE type_t.num5
   
#   CLEAR FORM  
   CALL g_sfaa2_d.clear()  
   LET l_sql = ''   

   LET l_yy = YEAR(g_today)
   LET l_mm = MONTH(g_today)
   LET l_dd = DAY(g_today)
   

 
   #add-point:陣列長度調整
   IF p_type = 'N' THEN
      IF g_detail_idx2 = 0 AND cl_null(g_detail_idx2) THEN
         RETURN
      ELSE 
        LET l_ac6 = g_detail_idx2   
      END IF
   END IF
   IF p_type = 'Y' THEN
      IF p_type = 'Y' AND l_ac2 = 0 AND cl_null(l_ac2) THEN
         RETURN
      ELSE 
         LET l_ac6 = l_ac2
      END IF  
   END IF   
   SELECT imaa006 INTO g_imaa006 FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_sfba_d[g_detail_idx2].sfba006
      
   LET l_sql = " SELECT inag008,inag032 FROM inag_t ",
               "  WHERE inagent = '",g_enterprise,"'",
               "    AND inagsite = '",g_site,"'",
#               "    AND inag001 = '",g_sfba_d[g_detail_idx2].sfba006,"'",
               "    AND inag001 = '",g_sfba_d[l_ac6].sfba006,"'",
               "    AND inag010 = 'Y' "
   IF g_gxdate = 1 THEN
#      LET g_bdate = g_today - 7              
      LET g_bdate = g_today + 7     
   END IF
   IF g_gxdate = 2 THEN
#      LET g_bdate = g_today - 14
      LET g_bdate = g_today + 14
   END IF     
   IF g_gxdate = 3 THEN
#      LET g_bdate = g_today - 30
      IF l_mm = 12 THEN
         LET l_yy = l_yy + 1
         LET l_mm = 1
         LET g_bdate = MDY(l_mm,l_dd+1,l_yy)   
      ELSE 
         LET g_bdate = MDY(l_mm+1,l_dd+1,l_yy)         
      END IF      
   END IF
   IF g_gxdate = 4 THEN
       #LET g_bdate = g_today - 90
       IF l_mm >= 10 THEN
         IF l_mm = 10 THEN 
            LET l_yy = l_yy + 1
            LET l_mm = 1
            LET g_bdate = MDY(l_mm,l_dd+1,l_yy)  
         END IF
         IF l_mm = 11 THEN 
            LET l_yy = l_yy + 1
            LET l_mm = 2
            LET g_bdate = MDY(l_mm,l_dd+1,l_yy)  
         END IF 
         IF l_mm = 12 THEN 
            LET l_yy = l_yy + 1
            LET l_mm = 3
            LET g_bdate = MDY(l_mm,l_dd+1,l_yy)  
         END IF        
      ELSE 
         LET g_bdate = MDY(l_mm+3,l_dd+1,l_yy)         
      END IF      
   END IF 
   IF p_type <> 'Y' THEN
      IF g_gxdate <> '5' THEN
#         LET l_sql = l_sql," AND inag015 BETWEEN '",g_bdate,"'"," AND '",g_today,"'"   
         LET l_sql = l_sql," AND inag015 < = '",g_bdate,"'"
      END IF  
   ELSE
      LET l_sql = l_sql," AND inag015 < = '",g_sfaa019_q,"'"
   END IF   
   PREPARE asfq008_inag008_pre FROM l_sql
   DECLARE asfq008_inag008_cur CURSOR FOR asfq008_inag008_pre
   LET l_ac5 = 1
   LET l_stock = 0
   LET l_gj_sum = 0
   LET l_xq_sum = 0
   LET l_zj_sum = 0
   LET l_sum_inag008 = 0
   DELETE FROM asfq008_temp
   FOREACH asfq008_inag008_cur INTO l_inag008,l_inag032
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()    
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_inag032) AND NOT cl_null(g_imaa006) AND NOT cl_null(l_inag008)  THEN
#         CALL s_aimi190_get_convert(g_sfba_d[g_detail_idx2].sfba006,l_inag032,g_imaa006)
#         CALL s_aimi190_get_convert(g_sfba_d[l_ac6].sfba006,l_inag032,g_imaa006)  #xj mod
#              RETURNING r_success,r_rate   
         CALL s_aooi250_convert_qty(g_sfba_d[l_ac6].sfba006,l_inag032,g_imaa006,l_inag008)
            RETURNING r_success,l_inag008
#         IF r_success THEN
#            LET l_inag008 = l_inag008 * r_rate
#         END IF   #xj mod
      END IF  
      LET l_sum_inag008 = l_sum_inag008 + l_inag008   
         
   END FOREACH 
 
   LET g_sfaa2_d[1].type1 = '1' 
   IF cl_null(l_sum_inag008) THEN
      LET l_sum_inag008 = 0
   END IF   
   LET g_sfaa2_d[1].gj_num = l_sum_inag008
   LET g_sfaa2_d[1].xq_num = 0
   LET g_sfaa2_d[1].stock = l_sum_inag008 
   LET g_sfaa2_d[1].date1 = '1888/01/01'   
   INSERT INTO asfq008_temp (date1,type1,gj_num,xq_num,docno,seq,object,object_desc,ck_docno,stock,
                             ooag001,ooag011,ooeg001,ooeg001_desc,prog)      
                      VALUES(g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                 g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                 g_sfaa2_d[l_ac5].ck_docno,g_sfaa2_d[l_ac5].stock,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                 g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog) 
                                       
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "INSERT INTO asfq008_temp:" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()    
   END IF    
   LET l_sql = ""
   #受訂量(需求)
   LET l_ac5 = 2
   LET l_sql = " SELECT xmdd011,'2',0,(xmdd006-xmdd014+xmdd015+xmdd016),xmdddocno,xmddseq,'','',xmda008,0,xmda002,'',xmda003,'','axmt500',xmdd004 FROM xmdd_t,xmda_t ",
               "  WHERE xmdaent = xmddent ",
               "    AND xmdasite = xmddsite ",
               "    AND xmdadocno = xmdddocno ",              
               "    AND xmdaent = '",g_enterprise,"'",
               "    AND xmdasite = '",g_site,"'",
               "    AND xmdastus = 'Y' ",
#               "    AND xmdd001 = '",g_sfba_d[g_detail_idx2].sfba006,"'"
               "    AND xmdd001 = '",g_sfba_d[l_ac6].sfba006,"'"
   IF p_type = 'Y' THEN             
      IF g_gxdate <> '5' THEN
#         LET l_sql = l_sql," AND xmdd011 BETWEEN '",g_bdate,"'"," AND '",g_today,"'"   
         LET l_sql = l_sql," AND xmdd011 < = '",g_bdate,"'"    
      END IF 
   ELSE
      LET l_sql = l_sql," AND xmdd011 < = '",g_sfaa019_q,"'"  
   END IF   
   PREPARE asfq008_xmdd_pre FROM l_sql
   DECLARE asfq008_xmdd_cur CURSOR FOR asfq008_xmdd_pre
   LET l_stock = g_sfaa2_d[1].stock
   LET l_gj_sum = g_sfaa2_d[1].gj_num
   LET l_xq_sum = 0
   FOREACH asfq008_xmdd_cur INTO g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                    g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                    g_sfaa2_d[l_ac5].ck_docno,g_sfaa2_d[l_ac5].stock,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                    g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog,l_xmdd004

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_xmdd004) AND NOT cl_null(g_imaa006) AND NOT cl_null(g_sfaa2_d[l_ac5].xq_num) THEN
#         CALL s_aimi190_get_convert(g_sfba_d[g_detail_idx2].sfba006,l_xmdd004,g_imaa006)
#         CALL s_aimi190_get_convert(g_sfba_d[l_ac6].sfba006,l_xmdd004,g_imaa006)
#              RETURNING r_success,r_rate     #xj mod
         CALL s_aooi250_convert_qty(g_sfba_d[l_ac6].sfba006,l_xmdd004,g_imaa006,g_sfaa2_d[l_ac5].xq_num)
            RETURNING r_success,g_sfaa2_d[l_ac5].xq_num
#         IF r_success THEN
#            LET g_sfaa2_d[l_ac5].xq_num = g_sfaa2_d[l_ac5].xq_num * r_rate
#         END IF      #xj mod
      END IF
      IF NOT cl_null(g_sfaa2_d[l_ac5].ooag001) THEN
         CALL s_desc_get_person_desc(g_sfaa2_d[l_ac5].ooag001) RETURNING g_sfaa2_d[l_ac5].ooag011
      END IF
      IF NOT cl_null(g_sfaa2_d[l_ac5].ooeg001) THEN
         CALL s_desc_get_department_desc(g_sfaa2_d[l_ac5].ooeg001) RETURNING g_sfaa2_d[l_ac5].ooeg001_desc
      END IF   
      LET l_xq_sum = l_xq_sum + g_sfaa2_d[l_ac5].xq_num
      LET g_sfaa2_d[l_ac5].stock = l_stock - g_sfaa2_d[l_ac5].xq_num
      LET l_stock = g_sfaa2_d[l_ac5].stock
      
      INSERT INTO asfq008_temp (date1,type1,gj_num,xq_num,docno,seq,object,object_desc,ck_docno,stock,
                                ooag001,ooag011,ooeg001,ooeg001_desc,prog)      
                         VALUES(g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                    g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                    g_sfaa2_d[l_ac5].ck_docno,0,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                    g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog)
                                          
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT INTO asfq008_temp:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()    
         EXIT FOREACH
      END IF   
      
      LET l_ac5 = l_ac5 + 1 
      IF l_ac5 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
      
         END IF
         EXIT FOREACH
      END IF  
   END FOREACH 
   LET l_sql = ''
   #工單備料量(需求)
   LET l_sql = " SELECT sfaa019,'3',0,(sfba013-sfba016-sfba015+sfba017-sfba025),sfbadocno,sfbaseq,sfaa017,'',sfaa022,0,sfaa002,'','','','asft300',sfba014 FROM sfaa_t,sfba_t ",
               "  WHERE sfaaent = sfbaent ", 
               "    AND sfaadocno = sfbadocno ",
               "    AND sfaaent = '",g_enterprise,"'",
               "    AND sfaasite = '",g_site,"'",
#               "    AND sfba006 = '",g_sfba_d[g_detail_idx2].sfba006,"'",
               "    AND sfba006 = '",g_sfba_d[l_ac6].sfba006,"'",
               "    AND sfaa003 <> '4' ",
               "    AND sfaastus <> 'X'",
               "    AND sfaastus <> 'C'",
               "    AND sfaa057 = '1' "
   IF p_type <> 'Y' THEN
      IF g_gxdate <> '5' THEN
#         LET l_sql = l_sql," AND sfaa019 BETWEEN '",g_bdate,"'"," AND '",g_today,"'"   
         LET l_sql = l_sql," AND sfaa019 < = '",g_bdate,"'"    
      END IF 
   ELSE
      LET l_sql = l_sql," AND sfaa019 < = '",g_sfaa019_q,"'"  
   END IF   
   PREPARE asfq008_sfba_pre1 FROM l_sql
   DECLARE asfq008_sfba_cur1 CURSOR FOR asfq008_sfba_pre1 
   FOREACH asfq008_sfba_cur1 INTO g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                  g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                  g_sfaa2_d[l_ac5].ck_docno,g_sfaa2_d[l_ac5].stock,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                  g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog,l_sfba014
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_sfba014) AND NOT cl_null(g_imaa006) AND NOT cl_null(g_sfaa2_d[l_ac5].xq_num) THEN
#         CALL s_aimi190_get_convert(g_sfba_d[g_detail_idx2].sfba006,l_sfba014,g_imaa006)
#         CALL s_aimi190_get_convert(g_sfba_d[l_ac6].sfba006,l_sfba014,g_imaa006)
#              RETURNING r_success,r_rate     #xj mod
         CALL s_aooi250_convert_qty(g_sfba_d[l_ac6].sfba006,l_sfba014,g_imaa006,g_sfaa2_d[l_ac5].xq_num)
            RETURNING r_success,g_sfaa2_d[l_ac5].xq_num
#         IF r_success THEN
#            LET g_sfaa2_d[l_ac5].xq_num = g_sfaa2_d[l_ac5].xq_num * r_rate
#         END IF      #xj mod
      END IF
      IF NOT cl_null(g_sfaa2_d[l_ac5].ooag001) THEN
         CALL s_desc_get_person_desc(g_sfaa2_d[l_ac5].ooag001) RETURNING g_sfaa2_d[l_ac5].ooag011
      END IF
      IF NOT cl_null(g_sfaa2_d[l_ac5].ooeg001) THEN
         CALL s_desc_get_department_desc(g_sfaa2_d[l_ac5].ooeg001) RETURNING g_sfaa2_d[l_ac5].ooeg001_desc
      END IF  
      IF NOT cl_null(g_sfaa2_d[l_ac5].object) THEN     
         CALL s_desc_get_department_desc(g_sfaa2_d[l_ac5].object) RETURNING g_sfaa2_d[l_ac5].object_desc
      END IF        
      LET l_xq_sum = l_xq_sum + g_sfaa2_d[l_ac5].xq_num
      LET g_sfaa2_d[l_ac5].stock = l_stock - g_sfaa2_d[l_ac5].xq_num
      LET l_stock = g_sfaa2_d[l_ac5].stock    
      INSERT INTO asfq008_temp (date1,type1,gj_num,xq_num,docno,seq,object,object_desc,ck_docno,stock,
                                ooag001,ooag011,ooeg001,ooeg001_desc,prog)      
                         VALUES(g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                    g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                    g_sfaa2_d[l_ac5].ck_docno,0,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                    g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog) 
                                          
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT INTO asfq008_temp:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()    
         EXIT FOREACH
      END IF        
      LET l_ac5 = l_ac5 + 1 
      
   END FOREACH 
   LET l_sql = ''
   #供需類型：請購量(供給)
   LET l_sql = " SELECT pmdb030,'4',(pmdb006-pmdb049),0,pmdbdocno,pmdbseq,pmdb015,'',pmdb001,0,pmda002,'',pmda003,'','apmt400',pmdb007 FROM pmda_t,pmdb_t ",
               "  WHERE pmdaent = pmdbent ",
               "    AND pmdasite = '",g_site,"'",
               "    AND pmdadocno = pmdbdocno ",
#               "    AND pmdb004 = '",g_sfba_d[g_detail_idx2].sfba006,"'", 
               "    AND pmdb004 = '",g_sfba_d[l_ac6].sfba006,"'", 
               "    AND pmdastus <> 'X' AND pmdastus <> 'C' " 
   IF p_type <> 'Y' THEN            
      IF g_gxdate <> '5' THEN
#         LET l_sql = l_sql," AND pmdb030 BETWEEN '",g_bdate,"'"," AND '",g_today,"'"   
         LET l_sql = l_sql," AND pmdb030 < = '",g_bdate,"'"  
      END IF 
   ELSE
      LET l_sql = l_sql," AND pmdb030 < = '",g_sfaa019_q,"'"  
   END IF   
   PREPARE asfq008_pmda_pre FROM l_sql
   DECLARE asfq008_pmda_cur CURSOR FOR asfq008_pmda_pre 
   FOREACH asfq008_pmda_cur INTO g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                 g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                 g_sfaa2_d[l_ac5].ck_docno,g_sfaa2_d[l_ac5].stock,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                 g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog,l_pmdb007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_pmdb007) AND NOT cl_null(g_imaa006) AND NOT cl_null(g_sfaa2_d[l_ac5].gj_num) THEN
#        CALL s_aimi190_get_convert(g_sfba_d[g_detail_idx2].sfba006,l_pmdb007,g_imaa006)
#         CALL s_aimi190_get_convert(g_sfba_d[l_ac6].sfba006,l_pmdb007,g_imaa006)
#              RETURNING r_success,r_rate   
         CALL s_aooi250_convert_qty(g_sfba_d[l_ac6].sfba006,l_pmdb007,g_imaa006,g_sfaa2_d[l_ac5].gj_num)
            RETURNING r_success,g_sfaa2_d[l_ac5].gj_num
#         IF r_success THEN
#            LET g_sfaa2_d[l_ac5].gj_num = g_sfaa2_d[l_ac5].gj_num * r_rate
#         END IF      #xj mod
      END IF
      IF NOT cl_null(g_sfaa2_d[l_ac5].ooag001) THEN
         CALL s_desc_get_person_desc(g_sfaa2_d[l_ac5].ooag001) RETURNING g_sfaa2_d[l_ac5].ooag011
      END IF
      IF NOT cl_null(g_sfaa2_d[l_ac5].ooeg001) THEN
         CALL s_desc_get_department_desc(g_sfaa2_d[l_ac5].ooeg001) RETURNING g_sfaa2_d[l_ac5].ooeg001_desc
      END IF    
      IF NOT cl_null(g_sfaa2_d[l_ac5].object) THEN     
         CALL s_desc_get_department_desc(g_sfaa2_d[l_ac5].object) RETURNING g_sfaa2_d[l_ac5].object_desc
      END IF        
      LET l_gj_sum = l_gj_sum + g_sfaa2_d[l_ac5].gj_num
      LET g_sfaa2_d[l_ac5].stock = l_stock + g_sfaa2_d[l_ac5].gj_num
      LET l_stock = g_sfaa2_d[l_ac5].stock     
      INSERT INTO asfq008_temp (date1,type1,gj_num,xq_num,docno,seq,object,object_desc,ck_docno,stock,
                                ooag001,ooag011,ooeg001,ooeg001_desc,prog)      
                         VALUES(g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                    g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                    g_sfaa2_d[l_ac5].ck_docno,0,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                    g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog) 
                                          
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT INTO asfq008_temp:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()    
         EXIT FOREACH
      END IF        
      LET l_ac5 = l_ac5 + 1 
      
   END FOREACH     

   #採購量(供給)
   
   LET l_sql = " SELECT pmdo012,'5',(pmdo006-pmdo019+pmdo017),0,pmdodocno,pmdoseq,pmdl004,'',pmdl008,0,pmdl002,'',pmdl003,'','apmt500',pmdo004 FROM pmdl_t,pmdo_t ",
               "  WHERE pmdlent = pmdoent ",
               "    AND pmdosite = '",g_site,"'",
               "    AND pmdldocno = pmdodocno ",
#               "    AND pmdo001 = '",g_sfba_d[g_detail_idx2].sfba006,"'", 
               "    AND pmdo001 = '",g_sfba_d[l_ac6].sfba006,"'", 
               "    AND pmdlstus <> 'X' AND pmdlstus <> 'C' "
   IF p_type <> 'Y' THEN                         
      IF g_gxdate <> '5' THEN
#         LET l_sql = l_sql," AND pmdo012 BETWEEN '",g_bdate,"'"," AND '",g_today,"'"   
         LET l_sql = l_sql," AND pmdo012 < = '",g_bdate,"'"          
      END IF   
   ELSE
      LET l_sql = l_sql," AND pmdo012 < = '",g_sfaa019_q,"'"  
   END IF   
   LET l_sql = l_sql,"  ORDER BY pmdldocdt,pmdodocno,pmdoseq "     
   PREPARE asfq008_pmdl_pre FROM l_sql
   DECLARE asfq008_pmdl_cur CURSOR FOR asfq008_pmdl_pre 
   FOREACH asfq008_pmdl_cur INTO g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                 g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                 g_sfaa2_d[l_ac5].ck_docno,g_sfaa2_d[l_ac5].stock,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                 g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog,l_pmdo004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_pmdo004) AND NOT cl_null(g_imaa006) AND NOT cl_null(g_sfaa2_d[l_ac5].gj_num) THEN
#         CALL s_aimi190_get_convert(g_sfba_d[g_detail_idx2].sfba006,l_pmdo004,g_imaa006)
#         CALL s_aimi190_get_convert(g_sfba_d[l_ac6].sfba006,l_pmdo004,g_imaa006)
#              RETURNING r_success,r_rate     #xj mod
         CALL s_aooi250_convert_qty(g_sfba_d[l_ac6].sfba006,l_pmdo004,g_imaa006,g_sfaa2_d[l_ac5].gj_num)
            RETURNING r_success,g_sfaa2_d[l_ac5].gj_num
#         IF r_success THEN
#            LET g_sfaa2_d[l_ac5].gj_num = g_sfaa2_d[l_ac5].gj_num * r_rate
#         END IF     #xj mod
      END IF
      IF NOT cl_null(g_sfaa2_d[l_ac5].ooag001) THEN
         CALL s_desc_get_person_desc(g_sfaa2_d[l_ac5].ooag001) RETURNING g_sfaa2_d[l_ac5].ooag011
      END IF
      IF NOT cl_null(g_sfaa2_d[l_ac5].ooeg001) THEN
         CALL s_desc_get_department_desc(g_sfaa2_d[l_ac5].ooeg001) RETURNING g_sfaa2_d[l_ac5].ooeg001_desc
      END IF      
      IF NOT cl_null(g_sfaa2_d[l_ac5].object) THEN      
         CALL s_desc_get_trading_partner_abbr_desc(g_sfaa2_d[l_ac5].object) RETURNING g_sfaa2_d[l_ac5].object_desc 
      END IF          
      LET l_gj_sum = l_gj_sum + g_sfaa2_d[l_ac5].gj_num
      LET g_sfaa2_d[l_ac5].stock = l_stock + g_sfaa2_d[l_ac5].gj_num
      LET l_stock = g_sfaa2_d[l_ac5].stock      
      INSERT INTO asfq008_temp (date1,type1,gj_num,xq_num,docno,seq,object,object_desc,ck_docno,stock,
                                ooag001,ooag011,ooeg001,ooeg001_desc,prog)      
                         VALUES(g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                    g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                    g_sfaa2_d[l_ac5].ck_docno,0,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                    g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog)
                                          
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT INTO asfq008_temp:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()    
         EXIT FOREACH
      END IF        
      LET l_ac5 = l_ac5 + 1 
      
   END FOREACH   

   #工單在製量(供給)
   LET l_sql = " SELECT sfaa020,'6',(sfaa012-sfaa050-sfaa051-sfaa056-sfaa055),0,sfaadocno,0,sfaa017,'',sfaa006,0,sfaa002,'','','','asft300',sfaa013 FROM sfaa_t ",
               "  WHERE sfaaent = '",g_enterprise,"'",
               "    AND sfaasite = '",g_site,"'",
#               "    AND sfaa010 = '",g_sfba_d[g_detail_idx2].sfba006,"'",
               "    AND sfaa010 = '",g_sfba_d[l_ac6].sfba006,"'",
               "    AND sfaa003 <> '4' ",
               "    AND sfaastus <> 'X'",
               "    AND sfaastus <> 'C'",
               "    AND sfaa057 = '1' "   
   IF p_type <> 'Y' THEN             
      IF g_gxdate <> '5' THEN
#         LET l_sql = l_sql," AND sfaa020 BETWEEN '",g_bdate,"'"," AND '",g_today,"'"   
         LET l_sql = l_sql," AND sfaa020 < = '",g_bdate,"'"  
      END IF 
   ELSE
     LET l_sql = l_sql," AND sfaa020 < = '",g_sfaa019_q,"'"  
   END IF   
   PREPARE asfq008_sfaa_pre1 FROM l_sql
   DECLARE asfq008_sfaa_cur1 CURSOR FOR asfq008_sfaa_pre1
   FOREACH asfq008_sfaa_cur1 INTO g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                  g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                  g_sfaa2_d[l_ac5].ck_docno,g_sfaa2_d[l_ac5].stock,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                  g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog,l_sfaa013
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_sfaa013) AND NOT cl_null(g_imaa006) AND NOT cl_null(g_sfaa2_d[l_ac5].gj_num) THEN
#         CALL s_aimi190_get_convert(g_sfba_d[g_detail_idx2].sfba006,l_sfaa013,g_imaa006)
#         CALL s_aimi190_get_convert(g_sfba_d[l_ac6].sfba006,l_sfaa013,g_imaa006)
#              RETURNING r_success,r_rate   
          CALL s_aooi250_convert_qty(g_sfba_d[l_ac6].sfba006,l_sfaa013,g_imaa006,g_sfaa2_d[l_ac5].gj_num) 
             RETURNING r_success,g_sfaa2_d[l_ac5].gj_num
#         IF r_success THEN
#            LET g_sfaa2_d[l_ac5].gj_num = g_sfaa2_d[l_ac5].gj_num * r_rate
#         END IF    
      END IF
      IF NOT cl_null(g_sfaa2_d[l_ac5].ooag001) THEN
         CALL s_desc_get_person_desc(g_sfaa2_d[l_ac5].ooag001) RETURNING g_sfaa2_d[l_ac5].ooag011
      END IF
      IF NOT cl_null(g_sfaa2_d[l_ac5].ooeg001) THEN
         CALL s_desc_get_department_desc(g_sfaa2_d[l_ac5].ooeg001) RETURNING g_sfaa2_d[l_ac5].ooeg001_desc
      END IF  
      IF NOT cl_null(g_sfaa2_d[l_ac5].object) THEN     
         CALL s_desc_get_department_desc(g_sfaa2_d[l_ac5].object) RETURNING g_sfaa2_d[l_ac5].object_desc
      END IF        
      LET l_gj_sum = l_gj_sum + g_sfaa2_d[l_ac5].gj_num
      LET g_sfaa2_d[l_ac5].stock = l_stock + g_sfaa2_d[l_ac5].gj_num
      LET l_stock = g_sfaa2_d[l_ac5].stock    
      INSERT INTO asfq008_temp (date1,type1,gj_num,xq_num,docno,seq,object,object_desc,ck_docno,stock,
                                ooag001,ooag011,ooeg001,ooeg001_desc,prog)      
                         VALUES(g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                    g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                    g_sfaa2_d[l_ac5].ck_docno,0,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                    g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog)
                                          
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT INTO asfq008_temp:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()    
         EXIT FOREACH
      END IF        
      LET l_ac5 = l_ac5 + 1 
      
   END FOREACH 
   #委外在製量(供給)
   LET l_sql = " SELECT sfaa020,'7',(sfaa012-sfaa050-sfaa051-sfaa056-sfaa055),0,sfaadocno,0,sfaa017,'',sfaa006,0,sfaa002,'','','','asft300',sfaa013 FROM sfaa_t ",
               "  WHERE sfaaent = '",g_enterprise,"'",
               "    AND sfaasite = '",g_site,"'",
#               "    AND sfaa010 = '",g_sfba_d[g_detail_idx2].sfba006,"'",
               "    AND sfaa010 = '",g_sfba_d[l_ac6].sfba006,"'",
               "    AND sfaa003 <> '4' ",
               "    AND sfaastus <> 'X'",
               "    AND sfaastus <> 'C'",
               "    AND sfaa057 = '2' "   
   IF p_type <> 'Y' THEN            
      IF g_gxdate <> '5' THEN
#         LET l_sql = l_sql," AND sfaa020 BETWEEN '",g_bdate,"'"," AND '",g_today,"'"   
         LET l_sql = l_sql," AND sfaa020 < = '",g_bdate,"'"  
      END IF 
   ELSE
      LET l_sql = l_sql," AND sfaa020 < = '",g_sfaa019_q,"'"  
   END IF   
   PREPARE asfq008_sfaa_pre2 FROM l_sql
   DECLARE asfq008_sfaa_cur2 CURSOR FOR asfq008_sfaa_pre2
   FOREACH asfq008_sfaa_cur2 INTO g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                  g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                  g_sfaa2_d[l_ac5].ck_docno,g_sfaa2_d[l_ac5].stock,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                  g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog,l_sfaa013
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_sfaa013) AND NOT cl_null(g_imaa006) AND NOT cl_null(g_sfaa2_d[l_ac5].gj_num) THEN
#         CALL s_aimi190_get_convert(g_sfba_d[g_detail_idx2].sfba006,l_sfaa013,g_imaa006)
#              RETURNING r_success,r_rate   
         CALL s_aooi250_convert_qty(g_sfba_d[g_detail_idx2].sfba006,l_sfaa013,g_imaa006,g_sfaa2_d[l_ac5].gj_num)
            RETURNING r_success,g_sfaa2_d[l_ac5].gj_num
#         IF r_success THEN
#            LET g_sfaa2_d[l_ac5].gj_num = g_sfaa2_d[l_ac5].gj_num * r_rate
#         END IF      #xj mod
      END IF
      IF NOT cl_null(g_sfaa2_d[l_ac5].ooag001) THEN
         CALL s_desc_get_person_desc(g_sfaa2_d[l_ac5].ooag001) RETURNING g_sfaa2_d[l_ac5].ooag011
      END IF
      IF NOT cl_null(g_sfaa2_d[l_ac5].ooeg001) THEN
         CALL s_desc_get_department_desc(g_sfaa2_d[l_ac5].ooeg001) RETURNING g_sfaa2_d[l_ac5].ooeg001_desc
      END IF 
      IF NOT cl_null(g_sfaa2_d[l_ac5].object) THEN     
         CALL s_desc_get_department_desc(g_sfaa2_d[l_ac5].object) RETURNING g_sfaa2_d[l_ac5].object_desc
      END IF        
      LET l_gj_sum = l_gj_sum + g_sfaa2_d[l_ac5].gj_num
      LET g_sfaa2_d[l_ac5].stock = l_stock + g_sfaa2_d[l_ac5].gj_num
      LET l_stock = g_sfaa2_d[l_ac5].stock     
      INSERT INTO asfq008_temp (date1,type1,gj_num,xq_num,docno,seq,object,object_desc,ck_docno,stock,
                                ooag001,ooag011,ooeg001,ooeg001_desc,prog)      
                         VALUES(g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                    g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                    g_sfaa2_d[l_ac5].ck_docno,0,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                    g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog)
                                          
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT INTO asfq008_temp:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()    
         EXIT FOREACH
      END IF        
      LET l_ac5 = l_ac5 + 1 
      
   END FOREACH 
   
   #IQC在驗量(供給)
   LET l_sql = " SELECT pmdsdocdt,'8',(pmdt053+pmdt054-pmdt055),0,pmdtdocno,pmdtseq,pmds007,'',pmdt001,0,pmds002,'',pmds003,'','apmt530',pmdt019 FROM pmds_t,pmdt_t ",
               "  WHERE pmdsent = pmdtent ",
               "    AND pmdssite = '",g_site,"'",
               "    AND pmdsdocno = pmdtdocno ",
               "    AND pmds000 = '3' ",
               "    AND pmds011 IN ('1','3','7','8','9','10')",
               "    AND pmdsstus = 'Y' ",
#               "    AND pmdt006 = '",g_sfba_d[g_detail_idx2].sfba006,"'"
               "    AND pmdt006 = '",g_sfba_d[l_ac6].sfba006,"'" 
   IF p_type <> 'Y' THEN           
      IF g_gxdate <> '5' THEN
#         LET l_sql = l_sql," AND pmdsdocdt BETWEEN '",g_bdate,"'"," AND '",g_today,"'"   
         LET l_sql = l_sql," AND pmdsdocdt < = '",g_bdate,"'"  
      END IF  
   ELSE
      LET l_sql = l_sql," AND pmdsdocdt < = '",g_sfaa019_q,"'"  
   END IF   
   PREPARE asfq008_pmds_pre FROM l_sql
   DECLARE asfq008_pmds_cur CURSOR FOR asfq008_pmds_pre
   FOREACH asfq008_pmds_cur INTO g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                 g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                 g_sfaa2_d[l_ac5].ck_docno,g_sfaa2_d[l_ac5].stock,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                 g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog,l_pmdt019
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_pmdt019) AND NOT cl_null(g_imaa006) AND NOT cl_null(g_sfaa2_d[l_ac5].gj_num) THEN
#         CALL s_aimi190_get_convert(g_sfba_d[g_detail_idx2].sfba006,l_pmdt019,g_imaa006)
#         CALL s_aimi190_get_convert(g_sfba_d[l_ac6].sfba006,l_pmdt019,g_imaa006)
#              RETURNING r_success,r_rate   
         CALL s_aooi250_convert_qty(g_sfba_d[l_ac6].sfba006,l_pmdt019,g_imaa006,g_sfaa2_d[l_ac5].gj_num) 
             RETURNING r_success,g_sfaa2_d[l_ac5].gj_num  
#         IF r_success THEN
#            LET g_sfaa2_d[l_ac5].gj_num = g_sfaa2_d[l_ac5].gj_num * r_rate
#         END IF    
      END IF
      IF NOT cl_null(g_sfaa2_d[l_ac5].ooag001) THEN
         CALL s_desc_get_person_desc(g_sfaa2_d[l_ac5].ooag001) RETURNING g_sfaa2_d[l_ac5].ooag011
      END IF
      IF NOT cl_null(g_sfaa2_d[l_ac5].ooeg001) THEN
         CALL s_desc_get_department_desc(g_sfaa2_d[l_ac5].ooeg001) RETURNING g_sfaa2_d[l_ac5].ooeg001_desc
      END IF 
      IF NOT cl_null(g_sfaa2_d[l_ac5].object) THEN     
         CALL s_desc_get_department_desc(g_sfaa2_d[l_ac5].object) RETURNING g_sfaa2_d[l_ac5].object_desc
      END IF        
      LET l_gj_sum = l_gj_sum + g_sfaa2_d[l_ac5].gj_num
      LET g_sfaa2_d[l_ac5].stock = l_stock + g_sfaa2_d[l_ac5].gj_num
      LET l_stock = g_sfaa2_d[l_ac5].stock    
      INSERT INTO asfq008_temp (date1,type1,gj_num,xq_num,docno,seq,object,object_desc,ck_docno,stock,
                                ooag001,ooag011,ooeg001,ooeg001_desc,prog)      
                         VALUES(g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                    g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                    g_sfaa2_d[l_ac5].ck_docno,0,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                    g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog)
                                          
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT INTO asfq008_temp:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()    
         EXIT FOREACH
      END IF        
      LET l_ac5 = l_ac5 + 1 
      
   END FOREACH      
   
   #FQC在驗量(供給) 
   LET l_sql = " SELECT qcbadocdt,'9',(qcba017-qcba023),0,qcbadocno,'',qcba005,'',qcba003,0,qcba900,'',qcba901,'','aqct300',qcba016 FROM qcba_t ",
               "  WHERE qcbaent = '",g_enterprise,"'",
               "    AND qcbasite = '",g_site,"'",
               "    AND qcba000 = '2' ",
               "    AND qcbastus = 'Y' ",
#               "    AND qcba010 = '",g_sfba_d[g_detail_idx2].sfba006,"'"
               "    AND qcba010 = '",g_sfba_d[l_ac6].sfba006,"'"
   IF p_type = 'Y' THEN
      IF g_gxdate <> '5' THEN
#         LET l_sql = l_sql," AND qcbadocdt BETWEEN '",g_bdate,"'"," AND '",g_today,"'"   
         LET l_sql = l_sql," AND qcbadocdt < = '",g_bdate,"'"  
      END IF
   ELSE
      LET l_sql = l_sql," AND qcbadocdt < = '",g_sfaa019_q,"'"
   END IF   
   PREPARE asfq008_qcba_pre FROM l_sql
   DECLARE asfq008_qcba_cur CURSOR FOR asfq008_qcba_pre
   FOREACH asfq008_qcba_cur INTO g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                 g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                 g_sfaa2_d[l_ac5].ck_docno,g_sfaa2_d[l_ac5].stock,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                 g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog,l_qcba016
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_qcba016) AND NOT cl_null(g_imaa006) AND NOT cl_null(g_sfaa2_d[l_ac5].gj_num) THEN
#         CALL s_aimi190_get_convert(g_sfba_d[g_detail_idx2].sfba006,l_qcba016,g_imaa006)
#         CALL s_aimi190_get_convert(g_sfba_d[l_ac6].sfba006,l_qcba016,g_imaa006)
#              RETURNING r_success,r_rate    #xj mod
         CALL s_aooi250_convert_qty(g_sfba_d[l_ac6].sfba006,l_qcba016,g_imaa006,g_sfaa2_d[l_ac5].gj_num)
            RETURNING r_success,g_sfaa2_d[l_ac5].gj_num
#         IF r_success THEN
#            LET g_sfaa2_d[l_ac5].gj_num = g_sfaa2_d[l_ac5].gj_num * r_rate
#         END IF     #xj mod
      END IF
      IF NOT cl_null(g_sfaa2_d[l_ac5].ooag001) THEN
         CALL s_desc_get_person_desc(g_sfaa2_d[l_ac5].ooag001) RETURNING g_sfaa2_d[l_ac5].ooag011
      END IF
      IF NOT cl_null(g_sfaa2_d[l_ac5].ooeg001) THEN
         CALL s_desc_get_department_desc(g_sfaa2_d[l_ac5].ooeg001) RETURNING g_sfaa2_d[l_ac5].ooeg001_desc
      END IF 
      IF NOT cl_null(g_sfaa2_d[l_ac5].object) THEN     
         CALL s_desc_get_department_desc(g_sfaa2_d[l_ac5].object) RETURNING g_sfaa2_d[l_ac5].object_desc
      END IF        
      LET l_gj_sum = l_gj_sum + g_sfaa2_d[l_ac5].gj_num
      LET g_sfaa2_d[l_ac5].stock = l_stock + g_sfaa2_d[l_ac5].gj_num
      LET l_stock = g_sfaa2_d[l_ac5].stock  
      INSERT INTO asfq008_temp (date1,type1,gj_num,xq_num,docno,seq,object,object_desc,ck_docno,stock,
                                ooag001,ooag011,ooeg001,ooeg001_desc,prog)      
                         VALUES(g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                    g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                    g_sfaa2_d[l_ac5].ck_docno,0,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                    g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog)
                                          
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT INTO asfq008_temp:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()    
         EXIT FOREACH
      END IF        
      LET l_ac5 = l_ac5 + 1 
      
   END FOREACH     
   
   CALL g_sfaa2_d.deleteElement(g_sfaa2_d.getLength())   
   LET g_detail_cnt5 = l_ac5 - 1    
   LET l_sql = ''
   LET l_sql = " SELECT * FROM asfq008_temp WHERE 1=1 ORDER BY date1,type1 "
   PREPARE asfq008_temp_pre FROM l_sql
   DECLARE asfq008_temp_cur CURSOR FOR asfq008_temp_pre
   CALL g_sfaa2_d.clear()  
   LET l_ac5 = 1
   LET l_stock = 0
   FOREACH asfq008_temp_cur INTO g_sfaa2_d[l_ac5].date1,g_sfaa2_d[l_ac5].type1,g_sfaa2_d[l_ac5].gj_num,g_sfaa2_d[l_ac5].xq_num,
                                 g_sfaa2_d[l_ac5].docno,g_sfaa2_d[l_ac5].seq,g_sfaa2_d[l_ac5].object,g_sfaa2_d[l_ac5].object_desc,
                                 g_sfaa2_d[l_ac5].ck_docno,g_sfaa2_d[l_ac5].stock,g_sfaa2_d[l_ac5].ooag001,g_sfaa2_d[l_ac5].ooag011,
                                 g_sfaa2_d[l_ac5].ooeg001,g_sfaa2_d[l_ac5].ooeg001_desc,g_sfaa2_d[l_ac5].prog
      IF g_sfaa2_d[l_ac5].type1 = '1' THEN
         LET g_sfaa2_d[l_ac5].date1 = ''
         LET l_stock = g_sfaa2_d[l_ac5].stock 
      END IF
      
      IF g_sfaa2_d[l_ac5].type1 MATCHES '[456789]' THEN  #供給
#         LET l_gj_sum = l_gj_sum + g_sfaa2_d[l_ac5].gj_num
         LET g_sfaa2_d[l_ac5].stock = l_stock + g_sfaa2_d[l_ac5].gj_num
         LET l_stock = g_sfaa2_d[l_ac5].stock          
      END IF
      IF g_sfaa2_d[l_ac5].type1 MATCHES '[23]' THEN  #需求
         LET g_sfaa2_d[l_ac5].stock = l_stock - g_sfaa2_d[l_ac5].xq_num
         LET l_stock = g_sfaa2_d[l_ac5].stock           
      END IF      
      IF SQLCA.sqlcode THEN
      
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      LET l_ac5 = l_ac5 + 1       
   END FOREACH                              
   CALL g_sfaa2_d.deleteElement(g_sfaa2_d.getLength()) 
   LET l_ac5 = l_ac5 - 1   
   LET g_detail_cnt5 = l_ac5 - 1       
   DISPLAY ARRAY g_sfaa2_d TO s_detail5.* ATTRIBUTE(COUNT=g_detail_cnt5)
      BEFORE DISPLAY 
         EXIT DISPLAY
   END DISPLAY  
   DISPLAY g_sfaa019_q TO sfaa019_q
   DISPLAY g_today TO day      
   LET l_zj_sum = l_gj_sum - l_xq_sum
   DISPLAY l_gj_sum TO sum1
   DISPLAY l_xq_sum TO sum2
   DISPLAY l_zj_sum TO sum3
   LET g_sum1 = l_gj_sum
   LET g_sum2 = l_xq_sum
   LET g_sum3 = l_zj_sum
END FUNCTION

################################################################################
# Descriptions...: 庫存明細
# Memo...........:
# Usage..........: CALL asfq008_b_fill3()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq008_b_fill3()
DEFINE  l_sql           STRING
DEFINE  l_sql1          STRING
DEFINE  l_sql2          STRING
DEFINE  l_yy            LIKE type_t.num5 
DEFINE  l_mm            LIKE type_t.num5
DEFINE  l_dd            LIKE type_t.num5
   #清除畫面
#   CLEAR FORM  
   CALL g_inag_d.clear() 
   LET l_yy = YEAR(g_today)
   LET l_mm = MONTH(g_today)
   LET l_dd = DAY(g_today)
   
   IF g_detail_idx2 <> 0 AND NOT cl_null(g_detail_idx2) THEN
      IF NOT cl_null(g_sfba_d[g_detail_idx2].sfba006) THEN
         LET l_sql1 = " SELECT inagsite,inag004,'',inag005,'',inag006,inag002,inag003,inag007,'',inag008,inag033,inag010,inag011,inag012,'',inag018,inag022 FROM inag_t ",
                     "  WHERE inagent = '",g_enterprise,"'",
                     "    AND inagsite = '",g_site,"'",
                     "    AND inag001 = '",g_sfba_d[g_detail_idx2].sfba006,"'"
         IF NOT cl_null(g_sfba_d[g_detail_idx2].sfba021) THEN
            LET l_sql1 = l_sql1," AND inag002 = '",g_sfba_d[g_detail_idx2].sfba021,"'"
         END IF 
         LET l_sql2 = l_sql1," AND inag008 = 0 " 
         
         IF g_invent <> '5' THEN
            LET l_sql1 = l_sql1," AND inag008 <> 0 "   
         END IF    
         IF g_invent <> '5' AND g_invent <> '6' THEN
            IF g_invent = 1 THEN
#               LET g_bdate = g_today - 30               
               IF l_mm = 1 THEN 
                  LET l_yy = l_yy - 1
                  LET l_mm = 12
                  LET g_bdate = MDY(l_mm,l_dd+1,l_yy)       
               ELSE 
                  LET g_bdate = MDY(l_mm-1,l_dd+1,l_yy)         
               END IF
            END IF
            IF g_invent = 2 THEN
#               LET g_bdate = g_today - 60
               IF l_mm <=2 THEN
                  IF l_mm = 1 THEN 
                     LET l_yy = l_yy - 1
                     LET l_mm = 11
                     LET g_bdate = MDY(l_mm,l_dd+1,l_yy)  
                  END IF
                  IF l_mm = 2 THEN 
                     LET l_yy = l_yy - 1
                     LET l_mm = 12
                     LET g_bdate = MDY(l_mm,l_dd+1,l_yy)  
                  END IF         
               ELSE 
                  LET g_bdate = MDY(l_mm-2,l_dd+1,l_yy)         
               END IF
            END IF     
            IF g_invent = 3 THEN
#               LET g_bdate = g_today - 90
               IF l_mm <= 3 THEN
                  IF l_mm = 1 THEN 
                     LET l_yy = l_yy - 1
                     LET l_mm = 10
                     LET g_bdate = MDY(l_mm,l_dd+1,l_yy)  
                  END IF
                  IF l_mm = 2 THEN 
                     LET l_yy = l_yy - 1
                     LET l_mm = 11
                     LET g_bdate = MDY(l_mm,l_dd+1,l_yy)  
                  END IF 
                  IF l_mm = 3 THEN 
                     LET l_yy = l_yy - 1
                     LET l_mm = 12
                     LET g_bdate = MDY(l_mm,l_dd+1,l_yy)  
                  END IF        
               ELSE 
                  LET g_bdate = MDY(l_mm-3,l_dd+1,l_yy)         
               END IF
            END IF
            IF g_invent = 4 THEN
#               LET g_bdate = g_today - 180
               IF l_mm <= 6 THEN
                  IF l_mm = 1 THEN 
                     LET l_yy = l_yy - 1
                     LET l_mm = 7
                     LET g_bdate = MDY(l_mm,l_dd+1,l_yy)  
                  END IF
                  IF l_mm = 2 THEN 
                     LET l_yy = l_yy - 1
                     LET l_mm = 8
                     LET g_bdate = MDY(l_mm,l_dd+1,l_yy)  
                  END IF 
                  IF l_mm = 3 THEN 
                     LET l_yy = l_yy - 1
                     LET l_mm = 9
                     LET g_bdate = MDY(l_mm,l_dd+1,l_yy)  
                  END IF    
                  IF l_mm = 4 THEN 
                     LET l_yy = l_yy - 1
                     LET l_mm = 10
                     LET g_bdate = MDY(l_mm,l_dd+1,l_yy)  
                  END IF  
                  IF l_mm = 5 THEN 
                     LET l_yy = l_yy - 1
                     LET l_mm = 11
                     LET g_bdate = MDY(l_mm,l_dd+1,l_yy)  
                  END IF   
                  IF l_mm = 6 THEN 
                     LET l_yy = l_yy - 1
                     LET l_mm = 12
                     LET g_bdate = MDY(l_mm,l_dd+1,l_yy)  
                  END IF                   
               ELSE 
                  LET g_bdate = MDY(l_mm-6,l_dd+1,l_yy)         
               END IF
            END IF    
            LET l_sql2 = l_sql2," AND inag015 BETWEEN '",g_bdate,"'"," AND '",g_today,"'"   
            LET l_sql = l_sql1," UNION ",l_sql2, " ORDER BY inag004,inag005,inag006 "      
         ELSE
            LET l_sql = l_sql1         
         END IF   
         PREPARE asfq008_inag_pre FROM l_sql
         DECLARE asfq008_inag_cur CURSOR FOR asfq008_inag_pre
         LET l_ac3 = 1
         FOREACH asfq008_inag_cur INTO g_inag_d[l_ac3].inagsite,g_inag_d[l_ac3].inag004,g_inag_d[l_ac3].inag004_desc,g_inag_d[l_ac3].inag005,g_inag_d[l_ac3].inag005_desc,g_inag_d[l_ac3].inag006,g_inag_d[l_ac3].inag002,
                                       g_inag_d[l_ac3].inag003,g_inag_d[l_ac3].inag007,g_inag_d[l_ac3].inag007_desc,g_inag_d[l_ac3].inag008,g_inag_d[l_ac3].inag033,g_inag_d[l_ac3].inag010,g_inag_d[l_ac3].inag011,
                                       g_inag_d[l_ac3].inag012,g_inag_d[l_ac3].inaa015,g_inag_d[l_ac3].inag018,g_inag_d[l_ac3].inag022
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            
               EXIT FOREACH
            END IF    
            CALL s_desc_get_stock_desc(g_inag_d[l_ac3].inagsite,g_inag_d[l_ac3].inag004) RETURNING g_inag_d[l_ac3].inag004_desc
            CALL s_desc_get_locator_desc(g_inag_d[l_ac3].inagsite,g_inag_d[l_ac3].inag004,g_inag_d[l_ac3].inag005) 
                 RETURNING g_inag_d[l_ac3].inag005_desc   
            CALL s_desc_get_unit_desc(g_inag_d[l_ac3].inag007) RETURNING g_inag_d[l_ac3].inag007_desc     
            LET l_ac3 = l_ac3 + 1 
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
            
         END FOREACH  
         CALL g_inag_d.deleteElement(g_inag_d.getLength())     
         LET g_detail_cnt3 = l_ac3 - 1    
         LET l_ac3 = l_ac3 - 1         
         DISPLAY ARRAY g_inag_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt3)
            BEFORE DISPLAY 
               EXIT DISPLAY
         END DISPLAY         
      END IF
      DISPLAY g_sfaa019_q TO sfaa019_q
      DISPLAY g_today TO day        
   END IF
END FUNCTION

 
{</section>}
 
