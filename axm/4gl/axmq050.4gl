#該程式未解開Section, 採用最新樣板產出!
{<section id="axmq050.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-07-29 14:57:20), PR版次:0003(2016-12-01 16:46:18)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000036
#+ Filename...: axmq050
#+ Description: 銷售價格差異比較查詢作業
#+ Creator....: 04441(2015-07-21 13:51:16)
#+ Modifier...: 03079 -SD/PR- 08993
 
{</section>}
 
{<section id="axmq050.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160727-00019#25  2016/08/5 By 08742        系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#                                           Mod  axmq050_xmda004_t --> axmq050_tmp01 
#                                           Mod  axmq050_axmt500_t --> axmq050_tmp02 
#                                           Mod  axmq050_relest_t  --> axmq050_tmp03
#161109-00085#11  2016/11/14  By 08993      整批調整系統星號寫法
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
PRIVATE TYPE type_g_xmda_d RECORD
       
       sel LIKE type_t.chr1, 
   xmdc001 LIKE xmdc_t.xmdc001, 
   xmdc001_desc LIKE type_t.chr500, 
   xmdc001_desc_1 LIKE type_t.chr500, 
   xmda015 LIKE xmda_t.xmda015, 
   xmda015_desc LIKE type_t.chr500, 
   xmdc015 LIKE xmdc_t.xmdc015, 
   xmdc0151 LIKE type_t.num20_6, 
   xmda0041 LIKE type_t.chr500, 
   xmda0041_desc LIKE type_t.chr500, 
   xmdc0152 LIKE type_t.num20_6, 
   xmda0042 LIKE type_t.chr500, 
   xmda0042_desc LIKE type_t.chr500, 
   xmdc0153 LIKE type_t.num20_6, 
   xmda0043 LIKE type_t.chr500, 
   xmda0043_desc LIKE type_t.chr500, 
   xmdc0154 LIKE type_t.num20_6, 
   xmda0044 LIKE type_t.chr500, 
   xmda0044_desc LIKE type_t.chr500, 
   xmdc0155 LIKE type_t.num20_6, 
   xmda0045 LIKE type_t.chr500, 
   xmda0045_desc LIKE type_t.chr500, 
   xmdc0156 LIKE type_t.num20_6, 
   xmda0046 LIKE type_t.chr500, 
   xmda0046_desc LIKE type_t.chr500, 
   xmdc0157 LIKE type_t.num20_6, 
   xmda0047 LIKE type_t.chr500, 
   xmda0047_desc LIKE type_t.chr500, 
   xmdc0158 LIKE type_t.num20_6, 
   xmda0048 LIKE type_t.chr500, 
   xmda0048_desc LIKE type_t.chr500, 
   xmdc0159 LIKE type_t.num20_6, 
   xmda0049 LIKE type_t.chr500, 
   xmda0049_desc LIKE type_t.chr500, 
   xmdc01510 LIKE type_t.num20_6, 
   xmda00410 LIKE type_t.chr500, 
   xmda00410_desc LIKE type_t.chr500, 
   xmdc01511 LIKE type_t.num20_6, 
   xmda00411 LIKE type_t.chr500, 
   xmda00411_desc LIKE type_t.chr500, 
   xmdc01512 LIKE type_t.num20_6, 
   xmda00412 LIKE type_t.chr500, 
   xmda00412_desc LIKE type_t.chr500, 
   xmdc01513 LIKE type_t.num20_6, 
   xmda00413 LIKE type_t.chr500, 
   xmda00413_desc LIKE type_t.chr500, 
   xmdc01514 LIKE type_t.num20_6, 
   xmda00414 LIKE type_t.chr500, 
   xmda00414_desc LIKE type_t.chr500, 
   xmdc01515 LIKE type_t.num20_6, 
   xmda00415 LIKE type_t.chr500, 
   xmda00415_desc LIKE type_t.chr500, 
   xmdc01516 LIKE type_t.num20_6, 
   xmda00416 LIKE type_t.chr500, 
   xmda00416_desc LIKE type_t.chr500, 
   xmdc01517 LIKE type_t.num20_6, 
   xmda00417 LIKE type_t.chr500, 
   xmda00417_desc LIKE type_t.chr500, 
   xmdc01518 LIKE type_t.num20_6, 
   xmda00418 LIKE type_t.chr500, 
   xmda00418_desc LIKE type_t.chr500, 
   xmdc01519 LIKE type_t.num20_6, 
   xmda00419 LIKE type_t.chr500, 
   xmda00419_desc LIKE type_t.chr500, 
   xmdc01520 LIKE type_t.num20_6, 
   xmda00420 LIKE type_t.chr500, 
   xmda00420_desc LIKE type_t.chr500, 
   xmdc01521 LIKE type_t.num20_6, 
   xmda00421 LIKE type_t.chr500, 
   xmda00421_desc LIKE type_t.chr500, 
   xmdc01522 LIKE type_t.num20_6, 
   xmda00422 LIKE type_t.chr500, 
   xmda00422_desc LIKE type_t.chr500, 
   xmdc01523 LIKE type_t.num20_6, 
   xmda00423 LIKE type_t.chr500, 
   xmda00423_desc LIKE type_t.chr500, 
   xmdc01524 LIKE type_t.num20_6, 
   xmda00424 LIKE type_t.chr500, 
   xmda00424_desc LIKE type_t.chr500, 
   xmdc01525 LIKE type_t.num20_6, 
   xmda00425 LIKE type_t.chr500, 
   xmda00425_desc LIKE type_t.chr500, 
   xmdc01526 LIKE type_t.num20_6, 
   xmda00426 LIKE type_t.chr500, 
   xmda00426_desc LIKE type_t.chr500, 
   xmdc01527 LIKE type_t.num20_6, 
   xmda00427 LIKE type_t.chr500, 
   xmda00427_desc LIKE type_t.chr500, 
   xmdc01528 LIKE type_t.num20_6, 
   xmda00428 LIKE type_t.chr500, 
   xmda00428_desc LIKE type_t.chr500, 
   xmdc01529 LIKE type_t.num20_6, 
   xmda00429 LIKE type_t.chr500, 
   xmda00429_desc LIKE type_t.chr500, 
   xmdc01530 LIKE type_t.num20_6, 
   xmda00430 LIKE type_t.chr500, 
   xmda00430_desc LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_master RECORD
        date_s     LIKE type_t.dat,
        date_e     LIKE type_t.dat,
        radio      LIKE type_t.chr1
               END RECORD
DEFINE g_master    type_master
DEFINE g_master_o  type_master

 TYPE type_g_xmdc2_d RECORD
       xmdadocno LIKE xmda_t.xmdadocno,
   xmdadocdt LIKE xmda_t.xmdadocdt,
   xmda004 LIKE xmda_t.xmda004,
   xmda004_desc LIKE type_t.chr500,
   xmda002 LIKE xmda_t.xmda002,
   url_b_xmda002 STRING,
   xmda002_desc LIKE type_t.chr500,
   xmda003 LIKE xmda_t.xmda003,
   xmda003_desc LIKE type_t.chr500,
   xmdcseq LIKE xmdc_t.xmdcseq,
   xmdc019 LIKE xmdc_t.xmdc019,
   xmdc002 LIKE xmdc_t.xmdc002,
   xmdc002_desc LIKE type_t.chr500,
   xmdc006 LIKE xmdc_t.xmdc006,
   xmdc006_desc LIKE type_t.chr500,
   xmdc007 LIKE xmdc_t.xmdc007,
   xmdc015 LIKE xmdc_t.xmdc015,
   xmdc015_1 LIKE type_t.chr500
       END RECORD

DEFINE g_xmdc2_d     DYNAMIC ARRAY OF type_g_xmdc2_d
DEFINE g_xmdc2_d_t   type_g_xmdc2_d
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xmda_d            DYNAMIC ARRAY OF type_g_xmda_d
DEFINE g_xmda_d_t          type_g_xmda_d
 
 
 
 
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
 
{<section id="axmq050.main" >}
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
   CALL axmq050_create_temp_table()
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
   DECLARE axmq050_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axmq050_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmq050_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmq050 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmq050_init()   
 
      #進入選單 Menu (="N")
      CALL axmq050_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axmq050
      
   END IF 
   
   CLOSE axmq050_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL axmq050_drop_temp_table()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axmq050.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axmq050_init()
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
   LET g_master.date_s = g_today
   LET g_master.date_e = g_today
   LET g_master.radio  = '1' 
   
   CALL cl_set_comp_visible('b_xmda0041,b_xmda0041_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda0042,b_xmda0042_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda0043,b_xmda0043_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda0044,b_xmda0044_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda0045,b_xmda0045_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda0046,b_xmda0046_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda0047,b_xmda0047_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda0048,b_xmda0048_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda0049,b_xmda0049_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00410,b_xmda00410_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00411,b_xmda00411_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00412,b_xmda00412_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00413,b_xmda00413_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00414,b_xmda00414_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00415,b_xmda00415_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00416,b_xmda00416_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00417,b_xmda00417_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00418,b_xmda00418_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00419,b_xmda00419_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00420,b_xmda00420_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00421,b_xmda00421_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00422,b_xmda00422_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00423,b_xmda00423_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00424,b_xmda00424_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00425,b_xmda00425_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00426,b_xmda00426_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00427,b_xmda00427_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00428,b_xmda00428_desc',FALSE) 
   CALL cl_set_comp_visible('b_xmda00429,b_xmda00429_desc',FALSE)
   CALL cl_set_comp_visible('b_xmda00430,b_xmda00430_desc',FALSE)
   #end add-point
 
   CALL axmq050_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axmq050.default_search" >}
PRIVATE FUNCTION axmq050_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xmdadocno = '", g_argv[01], "' AND "
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
 
{<section id="axmq050.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmq050_ui_dialog() 
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
 
   
   CALL axmq050_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xmda_d.clear()
 
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
 
         CALL axmq050_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.date_s,g_master.date_e,g_master.radio
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               LET g_master_o.* = g_master.*
            
            AFTER FIELD date_s
               IF NOT cl_null(g_master.date_s) AND NOT cl_null(g_master.date_e) THEN
                  IF g_master.date_s <> g_master_o.date_s OR cl_null(g_master_o.date_s) THEN
                     #起始日期不可大於截止日期,請檢查！
                     IF g_master.date_e < g_master.date_s THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_master.date_e
                        LET g_errparam.code   = 'agl-00116'
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_master.date_s = g_master_o.date_s
                        DISPLAY BY NAME g_master.date_s
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               LET g_master_o.date_s = g_master.date_s
            
            AFTER FIELD date_e
               IF NOT cl_null(g_master.date_e) AND NOT cl_null(g_master.date_s) THEN
                  IF g_master.date_e <> g_master_o.date_e OR cl_null(g_master_o.date_e) THEN
                     #截止日期不可小於起始日期,請檢查！
                     IF g_master.date_e < g_master.date_s THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_master.date_s
                        LET g_errparam.code   = 'agl-00117'
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_master.date_e = g_master_o.date_e
                        DISPLAY BY NAME g_master.date_e
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               LET g_master_o.date_e = g_master.date_e
         
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON xmdc001,imaa009,xmda004,pmaa090,xmda002,xmda003,xmda015
            
            ON ACTION controlp INFIELD xmdc001
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_imaf001_15()
               DISPLAY g_qryparam.return1 TO xmdc001
               NEXT FIELD xmdc001
            
            ON ACTION controlp INFIELD imaa009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()
               DISPLAY g_qryparam.return1 TO imaa009
               NEXT FIELD imaa009
            
            ON ACTION controlp INFIELD xmda004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               CALL q_pmaa001_6()
               DISPLAY g_qryparam.return1 TO xmda004
               NEXT FIELD xmda004
            
            ON ACTION controlp INFIELD pmaa090
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "281"
               CALL q_oocq002()
               DISPLAY g_qryparam.return1 TO pmaa090
               NEXT FIELD pmaa090
            
            ON ACTION controlp INFIELD xmda002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO xmda002
               NEXT FIELD xmda002
            
            ON ACTION controlp INFIELD xmda003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()
               DISPLAY g_qryparam.return1 TO xmda003
               NEXT FIELD xmda003
            
            ON ACTION controlp INFIELD xmda015
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               CALL q_ooaj002_1()
               DISPLAY g_qryparam.return1 TO xmda015
               NEXT FIELD xmda015
            
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_xmda_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axmq050_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axmq050_b_fill2()
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
         DISPLAY ARRAY g_xmdc2_d TO s_detail2.* ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 2

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx

         END DISPLAY 
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axmq050_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("insert",FALSE) 
            #end add-point
            NEXT FIELD xmdc001
 
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
            CALL axmq050_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_xmda_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL axmq050_b_fill()
 
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
            CALL axmq050_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axmq050_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axmq050_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axmq050_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xmda_d.getLength()
               LET g_xmda_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xmda_d.getLength()
               LET g_xmda_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xmda_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmda_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xmda_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmda_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axmq050_filter()
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
 
{<section id="axmq050.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmq050_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql           STRING
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_xmdc001       LIKE xmdc_t.xmdc001
   DEFINE l_xmda015       LIKE xmda_t.xmda015
   DEFINE l_xmda004       LIKE xmda_t.xmda004
   DEFINE l_i             LIKE type_t.num5

   DEFINE l_seq           LIKE type_t.num5
   DEFINE l_xmdc015       LIKE xmdc_t.xmdc015

   DEFINE l_axmt500       RECORD
                             xmdadocno     LIKE xmda_t.xmdadocno,    #單號  
                             xmdadocdt     LIKE xmda_t.xmdadocdt,    #日期     
                             xmdc001       LIKE xmdc_t.xmdc001,      #料號  
                             xmda004       LIKE xmda_t.xmda004,      #客戶  
                             xmda015       LIKE xmda_t.xmda015,      #幣別  
                             xmdc015       LIKE xmdc_t.xmdc015,      #單價   
                             xmdc0152      LIKE xmdc_t.xmdc015,                             
                             xmda002       LIKE xmda_t.xmda002,
                             xmda003       LIKE xmda_t.xmda003,
                             xmdcseq       LIKE xmdc_t.xmdcseq,
                             xmdc019       LIKE xmdc_t.xmdc019,
                             xmdc002       LIKE xmdc_t.xmdc002,
                             xmdc006       LIKE xmdc_t.xmdc006,
                             xmdc007       LIKE xmdc_t.xmdc007
                          END RECORD

   DEFINE l_sr            RECORD
                             xmdc001     LIKE xmdc_t.xmdc001,        #料號 
                             xmda015     LIKE xmda_t.xmda015,        #幣別 
                             xmdc0151    LIKE xmdc_t.xmdc015, 
                             xmda0041    LIKE xmda_t.xmda004,
                             xmdc0152    LIKE xmdc_t.xmdc015, 
                             xmda0042    LIKE xmda_t.xmda004,
                             xmdc0153    LIKE xmdc_t.xmdc015, 
                             xmda0043    LIKE xmda_t.xmda004, 
                             xmdc0154    LIKE xmdc_t.xmdc015, 
                             xmda0044    LIKE xmda_t.xmda004,
                             xmdc0155    LIKE xmdc_t.xmdc015, 
                             xmda0045    LIKE xmda_t.xmda004,
                             xmdc0156    LIKE xmdc_t.xmdc015, 
                             xmda0046    LIKE xmda_t.xmda004,
                             xmdc0157    LIKE xmdc_t.xmdc015, 
                             xmda0047    LIKE xmda_t.xmda004,
                             xmdc0158    LIKE xmdc_t.xmdc015, 
                             xmda0048    LIKE xmda_t.xmda004,
                             xmdc0159    LIKE xmdc_t.xmdc015, 
                             xmda0049    LIKE xmda_t.xmda004,
                             xmdc01510   LIKE xmdc_t.xmdc015, 
                             xmda00410   LIKE xmda_t.xmda004,
                             xmdc01511   LIKE xmdc_t.xmdc015, 
                             xmda00411   LIKE xmda_t.xmda004,
                             xmdc01512   LIKE xmdc_t.xmdc015, 
                             xmda00412   LIKE xmda_t.xmda004,
                             xmdc01513   LIKE xmdc_t.xmdc015, 
                             xmda00413   LIKE xmda_t.xmda004,
                             xmdc01514   LIKE xmdc_t.xmdc015, 
                             xmda00414   LIKE xmda_t.xmda004,
                             xmdc01515   LIKE xmdc_t.xmdc015, 
                             xmda00415   LIKE xmda_t.xmda004,
                             xmdc01516   LIKE xmdc_t.xmdc015, 
                             xmda00416   LIKE xmda_t.xmda004,
                             xmdc01517   LIKE xmdc_t.xmdc015, 
                             xmda00417   LIKE xmda_t.xmda004, 
                             xmdc01518   LIKE xmdc_t.xmdc015, 
                             xmda00418   LIKE xmda_t.xmda004, 
                             xmdc01519   LIKE xmdc_t.xmdc015, 
                             xmda00419   LIKE xmda_t.xmda004,
                             xmdc01520   LIKE xmdc_t.xmdc015, 
                             xmda00420   LIKE xmda_t.xmda004, 
                             xmdc01521   LIKE xmdc_t.xmdc015, 
                             xmda00421   LIKE xmda_t.xmda004,
                             xmdc01522   LIKE xmdc_t.xmdc015, 
                             xmda00422   LIKE xmda_t.xmda004, 
                             xmdc01523   LIKE xmdc_t.xmdc015, 
                             xmda00423   LIKE xmda_t.xmda004,
                             xmdc01524   LIKE xmdc_t.xmdc015, 
                             xmda00424   LIKE xmda_t.xmda004,
                             xmdc01525   LIKE xmdc_t.xmdc015, 
                             xmda00425   LIKE xmda_t.xmda004, 
                             xmdc01526   LIKE xmdc_t.xmdc015, 
                             xmda00426   LIKE xmda_t.xmda004, 
                             xmdc01527   LIKE xmdc_t.xmdc015, 
                             xmda00427   LIKE xmda_t.xmda004,
                             xmdc01528   LIKE xmdc_t.xmdc015, 
                             xmda00428   LIKE xmda_t.xmda004,
                             xmdc01529   LIKE xmdc_t.xmdc015, 
                             xmda00429   LIKE xmda_t.xmda004,
                             xmdc01530   LIKE xmdc_t.xmdc015, 
                             xmda00430   LIKE xmda_t.xmda004 
                          END RECORD 
   DEFINE l_text          STRING 
   
   DEFINE l_xmda012       LIKE xmda_t.xmda012
   DEFINE l_xmda013       LIKE xmda_t.xmda013
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #依QBE與其他條件找出資料 
   LET l_sql = "SELECT DISTINCT xmdc001,xmda015,xmda004 ",
               "  FROM xmdc_t,xmda_t,imaa_t,pmaa_t  ",
               " WHERE xmdcent   = xmdaent ",
               "   AND xmdcdocno = xmdadocno ",
               "   AND xmdcent   = '",g_enterprise,"' ",
               "   AND xmdcent   = imaaent ",
               "   AND xmdc001   = imaa001 ",
               "   AND xmdaent   = pmaaent ",
               "   AND xmda004   = pmaa001 ", 
               "   AND xmdastus  = 'Y' ", 
               "   AND xmdadocdt BETWEEN '",g_master.date_s,"' ",
               "                     AND '",g_master.date_e,"' ",
               "   AND ",g_wc,
               " ORDER BY xmdc001,xmda015,xmda004 "
   PREPARE axmq050_get_basic_data_prep FROM l_sql
   DECLARE axmq050_get_basic_data_curs CURSOR FOR axmq050_get_basic_data_prep

   #清空舊資料 
   DELETE FROM axmq050_data1; 
   DELETE FROM axmq050_tmp01;         #160727-00019#25 Mod  axmq050_xmda004_t--> axmq050_tmp01
   DELETE FROM axmq050_tmp02;         #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
   DELETE FROM axmq050_tmp03;         #160727-00019#25 Mod  axmq050_relest_t--> axmq050_tmp03

   FOREACH axmq050_get_basic_data_curs INTO l_xmdc001,l_xmda015,l_xmda004
      #161109-00085#11-mod-s
      #INSERT INTO axmq050_data1 VALUES(l_xmdc001,l_xmda015,l_xmda004)
      INSERT INTO axmq050_data1 (xmdc001,xmda015,xmda004 )
      VALUES(l_xmdc001,l_xmda015,l_xmda004)
      #161109-00085#11-mod-e
   END FOREACH 
   
   LET l_sql = "SELECT DISTINCT xmdc001,xmda015 ",
               "  FROM axmq050_data1 ",
               " ORDER BY xmdc001,xmda015 "
   PREPARE axmq050_get_xmdc001_prep FROM l_sql
   DECLARE axmq050_get_xmdc001_curs CURSOR FOR axmq050_get_xmdc001_prep

   LET l_sql = "SELECT DISTINCT xmda004 ",
               "  FROM axmq050_data1 ",
               " WHERE xmdc001 = ? ",
               "   AND xmda015 = ? ",
               " ORDER BY xmda004 "
   PREPARE axmq050_get_xmda004_prep FROM l_sql
   DECLARE axmq050_get_xmda004_curs CURSOR FOR axmq050_get_xmda004_prep

   #選定最多30位客戶 
   DELETE FROM axmq050_tmp01;         #160727-00019#25 Mod  axmq050_xmda004_t--> axmq050_tmp01
   LET l_i = 1
   FOREACH axmq050_get_xmdc001_curs INTO l_xmdc001,l_xmda015

      FOREACH axmq050_get_xmda004_curs USING l_xmdc001,l_xmda015
                                        INTO l_xmda004
         SELECT COUNT(*) INTO l_cnt
           FROM axmq050_tmp01            #160727-00019#25 Mod  axmq050_xmda004_t--> axmq050_tmp01
          WHERE xmda004 = l_xmda004
         IF l_cnt > 0 THEN
            CONTINUE FOREACH
         END IF 
                  
         #161109-00085#11-mod-s
         #INSERT INTO axmq050_tmp01 VALUES(l_i,l_xmda004)           #160727-00019#25 Mod  axmq050_xmda004_t--> axmq050_tmp01
         INSERT INTO axmq050_tmp01 (seq,xmda004)
         VALUES(l_i,l_xmda004)
         #161109-00085#11-mod-e
         LET l_i = l_i + 1

         IF l_i > 30 THEN
            EXIT FOREACH
         END IF
      END FOREACH

      IF l_i > 30 THEN
         EXIT FOREACH
      END IF
   END FOREACH

   LET l_sql = "SELECT seq,xmda004 ",
               "  FROM axmq050_tmp01 ",          #160727-00019#25 Mod  axmq050_xmda004_t--> axmq050_tmp01
               " ORDER BY seq "
   PREPARE axmq050_xmda004_prep FROM l_sql
   DECLARE axmq050_xmda004_curs CURSOR FOR axmq050_xmda004_prep
   FOREACH axmq050_xmda004_curs INTO l_seq,l_xmda004
      FOREACH axmq050_get_xmdc001_curs INTO l_xmdc001,l_xmda015
         LET l_sql = "SELECT xmdadocno,xmdadocdt,xmdc001,xmda004,xmda015,xmdc015,xmdc015, ",
                     "       xmda002,xmda003,xmdcseq,xmdc019,xmdc002,xmdc006,xmdc007, ", 
                     "       xmda012,xmda013 ",
                     "  FROM xmda_t,xmdc_t ",
                     " WHERE xmdaent   = xmdcent ",
                     "   AND xmdadocno = xmdcdocno ",
                     "   AND xmdaent   = '",g_enterprise,"' ",
                     "   AND xmda004   = '",l_xmda004,"' ",
                     "   AND xmda015   = '",l_xmda015,"' ",
                     "   AND xmdc001   = '",l_xmdc001,"' ",
                     "   AND xmdadocdt BETWEEN '",g_master.date_s,"' ", 
                     "                     AND '",g_master.date_e,"' "
         PREPARE axmq050_axmt500_prep FROM l_sql
         DECLARE axmq050_axmt500_curs CURSOR FOR axmq050_axmt500_prep
         #161109-00085#11-mod-s
         #FOREACH axmq050_axmt500_curs INTO l_axmt500.*,l_xmda012,l_xmda013
         FOREACH axmq050_axmt500_curs INTO l_axmt500.xmdadocno,l_axmt500.xmdadocdt,l_axmt500.xmdc001,l_axmt500.xmda004,l_axmt500.xmda015,
                                           l_axmt500.xmdc015,l_axmt500.xmdc0152,l_axmt500.xmda002,l_axmt500.xmda003,l_axmt500.xmdcseq,
                                           l_axmt500.xmdc019,l_axmt500.xmdc002,l_axmt500.xmdc006,l_axmt500.xmdc007,l_xmda012,l_xmda013
         #161109-00085#11-mod-s
            IF l_xmda013 = 'Y' THEN
               LET l_axmt500.xmdc015= l_axmt500.xmdc015 / (1+ l_xmda012 / 100)
            END IF
            
            #161109-00085#11-mod-s
            #INSERT INTO axmq050_tmp02 VALUES(l_axmt500.*)       #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02   #161109-00085#11   mark
            INSERT INTO axmq050_tmp02(xmdadocno,xmdadocdt,xmdc001,xmda004,xmda015,xmdc015,xmdc0152,xmda002,xmda003,xmdcseq,xmdc019,xmdc002,xmdc006,xmdc007  )
                        VALUES(l_axmt500.xmdadocno,l_axmt500.xmdadocdt,l_axmt500.xmdc001,l_axmt500.xmda004,l_axmt500.xmda015,l_axmt500.xmdc015,l_axmt500.xmdc0152,
                               l_axmt500.xmda002,l_axmt500.xmda003,l_axmt500.xmdcseq,l_axmt500.xmdc019,l_axmt500.xmdc002,l_axmt500.xmdc006,l_axmt500.xmdc007)
            #161109-00085#11-mod-e                                 
         END FOREACH

      END FOREACH
   END FOREACH


   FOREACH axmq050_get_xmdc001_curs INTO l_xmdc001,l_xmda015
      LET l_sr.xmdc001 = l_xmdc001
      LET l_sr.xmda015 = l_xmda015

      FOREACH axmq050_xmda004_curs INTO l_seq,l_xmda004
         #最低單價 
         IF g_master.radio = '1' THEN
            LET l_sql = "SELECT MIN(xmdc015) ",
                        "  FROM axmq050_tmp02 ",               #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
                        " WHERE xmdc001 = '",l_xmdc001,"' ",
                        "   AND xmda015 = '",l_xmda015,"' ",
                        "   AND xmda004 = '",l_xmda004,"' "
         END IF

         #平均單價  
         IF g_master.radio = '2' THEN
            LET l_sql = "SELECT AVG(xmdc015) ",
                        "  FROM axmq050_tmp02 ",                #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
                        " WHERE xmdc001 = '",l_xmdc001,"' ",
                        "   AND xmda015 = '",l_xmda015,"' ",
                        "   AND xmda004 = '",l_xmda004,"' "
         END IF

         #最高單價 
         IF g_master.radio = '3' THEN
            LET l_sql = "SELECT MAX(xmdc015) ",
                        "  FROM axmq050_tmp02 ",                   #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
                        " WHERE xmdc001 = '",l_xmdc001,"' ",
                        "   AND xmda015 = '",l_xmda015,"' ",
                        "   AND xmda004 = '",l_xmda004,"' "
         END IF

         #最近單價 
         IF g_master.radio = '4' THEN
            LET l_sql = "SELECT xmdc015 ",
                        "  FROM axmq050_tmp02 ",         #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
                        " WHERE xmdc001 = '",l_xmdc001,"' ",
                        "   AND xmda015 = '",l_xmda015,"' ",
                        "   AND xmda004 = '",l_xmda004,"' ",
                        " ORDER BY xmdadocdt DESC "
         END IF

         PREPARE axmq050_get_xmdc015_prep FROM l_sql 
         EXECUTE axmq050_get_xmdc015_prep INTO l_xmdc015

         CASE l_seq
            WHEN '1'
               LET l_sr.xmdc0151  = l_xmdc015 
               LET l_sr.xmda0041  = l_xmda004
            WHEN '2'
               LET l_sr.xmdc0152  = l_xmdc015 
               LET l_sr.xmda0042  = l_xmda004
            WHEN '3'
               LET l_sr.xmdc0153  = l_xmdc015 
               LET l_sr.xmda0043  = l_xmda004
            WHEN '4'
               LET l_sr.xmdc0154  = l_xmdc015 
               LET l_sr.xmda0044  = l_xmda004
            WHEN '5'
               LET l_sr.xmdc0155  = l_xmdc015 
               LET l_sr.xmda0045  = l_xmda004
            WHEN '6'
               LET l_sr.xmdc0156  = l_xmdc015 
               LET l_sr.xmda0046  = l_xmda004
            WHEN '7'
               LET l_sr.xmdc0157  = l_xmdc015 
               LET l_sr.xmda0047  = l_xmda004
            WHEN '8'
               LET l_sr.xmdc0158  = l_xmdc015 
               LET l_sr.xmda0048  = l_xmda004
            WHEN '9'
               LET l_sr.xmdc0159  = l_xmdc015 
               LET l_sr.xmda0049  = l_xmda004
            WHEN '10'
               LET l_sr.xmdc01510 = l_xmdc015 
               LET l_sr.xmda00410 = l_xmda004
            WHEN '11'
               LET l_sr.xmdc01511 = l_xmdc015 
               LET l_sr.xmda00411 = l_xmda004
            WHEN '12'
               LET l_sr.xmdc01512 = l_xmdc015 
               LET l_sr.xmda00412 = l_xmda004 
            WHEN '13'
               LET l_sr.xmdc01513 = l_xmdc015 
               LET l_sr.xmda00413 = l_xmda004 
            WHEN '14' 
               LET l_sr.xmdc01514 = l_xmdc015 
               LET l_sr.xmda00414 = l_xmda004
            WHEN '15'
               LET l_sr.xmdc01515 = l_xmdc015 
               LET l_sr.xmda00415 = l_xmda004 
            WHEN '16'
               LET l_sr.xmdc01516 = l_xmdc015 
               LET l_sr.xmda00416 = l_xmda004 
            WHEN '17'
               LET l_sr.xmdc01517 = l_xmdc015 
               LET l_sr.xmda00417 = l_xmda004 
            WHEN '18'
               LET l_sr.xmdc01518 = l_xmdc015 
               LET l_sr.xmda00418 = l_xmda004 
            WHEN '19'
               LET l_sr.xmdc01519 = l_xmdc015 
               LET l_sr.xmda00419 = l_xmda004 
            WHEN '20'
               LET l_sr.xmdc01520 = l_xmdc015 
               LET l_sr.xmda00420 = l_xmda004 
            WHEN '21'
               LET l_sr.xmdc01521 = l_xmdc015 
               LET l_sr.xmda00421 = l_xmda004 
            WHEN '22'
               LET l_sr.xmdc01522 = l_xmdc015 
               LET l_sr.xmda00422 = l_xmda004 
            WHEN '23'
               LET l_sr.xmdc01523 = l_xmdc015 
               LET l_sr.xmda00423 = l_xmda004 
            WHEN '24'
               LET l_sr.xmdc01524 = l_xmdc015 
               LET l_sr.xmda00424 = l_xmda004 
            WHEN '25'
               LET l_sr.xmdc01525 = l_xmdc015 
               LET l_sr.xmda00425 = l_xmda004 
            WHEN '26'
               LET l_sr.xmdc01526 = l_xmdc015 
               LET l_sr.xmda00426 = l_xmda004 
            WHEN '27'
               LET l_sr.xmdc01527 = l_xmdc015 
               LET l_sr.xmda00427 = l_xmda004 
            WHEN '28'
               LET l_sr.xmdc01528 = l_xmdc015 
               LET l_sr.xmda00428 = l_xmda004 
            WHEN '29' 
               LET l_sr.xmdc01529 = l_xmdc015 
               LET l_sr.xmda00429 = l_xmda004 
            WHEN '30'
               LET l_sr.xmdc01530 = l_xmdc015 
               LET l_sr.xmda00430 = l_xmda004 
         END CASE

      END FOREACH

      
      #161109-00085#11-mod-s
      #INSERT INTO axmq050_tmp03 VALUES(l_sr.*)        #160727-00019#25 Mod  axmq050_relest_t--> axmq050_tmp03   #161109-00085#11   mark
      INSERT INTO axmq050_tmp03(xmdc001,xmda015,xmdc0151,xmda0041,xmdc0152,xmda0042,xmdc0153,xmda0043,xmdc0154,xmda0044,xmdc0155,xmda0045,
                                xmdc0156,xmda0046,xmdc0157,xmda0047,xmdc0158,xmda0048,xmdc0159,xmda0049,xmdc01510,xmda00410,xmdc01511,xmda00411,
                                xmdc01512,xmda00412,xmdc01513,xmda00413,xmdc01514,xmda00414,xmdc01515,xmda00415,xmdc01516,xmda00416,xmdc01517,
                                xmda00417,xmdc01518,xmda00418,xmdc01519,xmda00419,xmdc01520,xmda00420,xmdc01521,xmda00421,xmdc01522,xmda00422,
                                xmdc01523,xmda00423,xmdc01524,xmda00424,xmdc01525,xmda00425,xmdc01526,xmda00426,xmdc01527,xmda00427,xmdc01528,
                                xmda00428,xmdc01529,xmda00429,xmdc01530,xmda00430) 
                  VALUES(l_sr.xmdc001,l_sr.xmda015,l_sr.xmdc0151,l_sr.xmda0041,l_sr.xmdc0152,l_sr.xmda0042,l_sr.xmdc0153,l_sr.xmda0043,
                         l_sr.xmdc0154,l_sr.xmda0044,l_sr.xmdc0155,l_sr.xmda0045,l_sr.xmdc0156,l_sr.xmda0046,l_sr.xmdc0157,l_sr.xmda0047,
                         l_sr.xmdc0158,l_sr.xmda0048,l_sr.xmdc0159,l_sr.xmda0049,l_sr.xmdc01510,l_sr.xmda00410,l_sr.xmdc01511,l_sr.xmda00411,
                         l_sr.xmdc01512,l_sr.xmda00412,l_sr.xmdc01513,l_sr.xmda00413,l_sr.xmdc01514,l_sr.xmda00414,l_sr.xmdc01515,l_sr.xmda00415,
                         l_sr.xmdc01516,l_sr.xmda00416,l_sr.xmdc01517,l_sr.xmda00417,l_sr.xmdc01518,l_sr.xmda00418,l_sr.xmdc01519,l_sr.xmda00419,
                         l_sr.xmdc01520,l_sr.xmda00420,l_sr.xmdc01521,l_sr.xmda00421,l_sr.xmdc01522,l_sr.xmda00422,l_sr.xmdc01523,l_sr.xmda00423,
                         l_sr.xmdc01524,l_sr.xmda00424,l_sr.xmdc01525,l_sr.xmda00425,l_sr.xmdc01526,l_sr.xmda00426,l_sr.xmdc01527,l_sr.xmda00427,l_sr.xmdc01528,l_sr.xmda00428,l_sr.xmdc01529,l_sr.xmda00429,l_sr.xmdc01530,l_sr.xmda00430)
      #161109-00085#11-mod-e
   END FOREACH 
   
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
 
   CALL g_xmda_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '','','','',xmda015,'','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY xmda_t.xmdadocno) AS RANK FROM xmda_t", 
 
 
 
                     "",
                     " WHERE xmdaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xmda_t"),
                     " ORDER BY xmda_t.xmdadocno"
 
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
 
   LET g_sql = "SELECT '','','','',xmda015,'','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axmq050_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axmq050_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xmda_d[l_ac].sel,g_xmda_d[l_ac].xmdc001,g_xmda_d[l_ac].xmdc001_desc,g_xmda_d[l_ac].xmdc001_desc_1, 
       g_xmda_d[l_ac].xmda015,g_xmda_d[l_ac].xmda015_desc,g_xmda_d[l_ac].xmdc015,g_xmda_d[l_ac].xmdc0151, 
       g_xmda_d[l_ac].xmda0041,g_xmda_d[l_ac].xmda0041_desc,g_xmda_d[l_ac].xmdc0152,g_xmda_d[l_ac].xmda0042, 
       g_xmda_d[l_ac].xmda0042_desc,g_xmda_d[l_ac].xmdc0153,g_xmda_d[l_ac].xmda0043,g_xmda_d[l_ac].xmda0043_desc, 
       g_xmda_d[l_ac].xmdc0154,g_xmda_d[l_ac].xmda0044,g_xmda_d[l_ac].xmda0044_desc,g_xmda_d[l_ac].xmdc0155, 
       g_xmda_d[l_ac].xmda0045,g_xmda_d[l_ac].xmda0045_desc,g_xmda_d[l_ac].xmdc0156,g_xmda_d[l_ac].xmda0046, 
       g_xmda_d[l_ac].xmda0046_desc,g_xmda_d[l_ac].xmdc0157,g_xmda_d[l_ac].xmda0047,g_xmda_d[l_ac].xmda0047_desc, 
       g_xmda_d[l_ac].xmdc0158,g_xmda_d[l_ac].xmda0048,g_xmda_d[l_ac].xmda0048_desc,g_xmda_d[l_ac].xmdc0159, 
       g_xmda_d[l_ac].xmda0049,g_xmda_d[l_ac].xmda0049_desc,g_xmda_d[l_ac].xmdc01510,g_xmda_d[l_ac].xmda00410, 
       g_xmda_d[l_ac].xmda00410_desc,g_xmda_d[l_ac].xmdc01511,g_xmda_d[l_ac].xmda00411,g_xmda_d[l_ac].xmda00411_desc, 
       g_xmda_d[l_ac].xmdc01512,g_xmda_d[l_ac].xmda00412,g_xmda_d[l_ac].xmda00412_desc,g_xmda_d[l_ac].xmdc01513, 
       g_xmda_d[l_ac].xmda00413,g_xmda_d[l_ac].xmda00413_desc,g_xmda_d[l_ac].xmdc01514,g_xmda_d[l_ac].xmda00414, 
       g_xmda_d[l_ac].xmda00414_desc,g_xmda_d[l_ac].xmdc01515,g_xmda_d[l_ac].xmda00415,g_xmda_d[l_ac].xmda00415_desc, 
       g_xmda_d[l_ac].xmdc01516,g_xmda_d[l_ac].xmda00416,g_xmda_d[l_ac].xmda00416_desc,g_xmda_d[l_ac].xmdc01517, 
       g_xmda_d[l_ac].xmda00417,g_xmda_d[l_ac].xmda00417_desc,g_xmda_d[l_ac].xmdc01518,g_xmda_d[l_ac].xmda00418, 
       g_xmda_d[l_ac].xmda00418_desc,g_xmda_d[l_ac].xmdc01519,g_xmda_d[l_ac].xmda00419,g_xmda_d[l_ac].xmda00419_desc, 
       g_xmda_d[l_ac].xmdc01520,g_xmda_d[l_ac].xmda00420,g_xmda_d[l_ac].xmda00420_desc,g_xmda_d[l_ac].xmdc01521, 
       g_xmda_d[l_ac].xmda00421,g_xmda_d[l_ac].xmda00421_desc,g_xmda_d[l_ac].xmdc01522,g_xmda_d[l_ac].xmda00422, 
       g_xmda_d[l_ac].xmda00422_desc,g_xmda_d[l_ac].xmdc01523,g_xmda_d[l_ac].xmda00423,g_xmda_d[l_ac].xmda00423_desc, 
       g_xmda_d[l_ac].xmdc01524,g_xmda_d[l_ac].xmda00424,g_xmda_d[l_ac].xmda00424_desc,g_xmda_d[l_ac].xmdc01525, 
       g_xmda_d[l_ac].xmda00425,g_xmda_d[l_ac].xmda00425_desc,g_xmda_d[l_ac].xmdc01526,g_xmda_d[l_ac].xmda00426, 
       g_xmda_d[l_ac].xmda00426_desc,g_xmda_d[l_ac].xmdc01527,g_xmda_d[l_ac].xmda00427,g_xmda_d[l_ac].xmda00427_desc, 
       g_xmda_d[l_ac].xmdc01528,g_xmda_d[l_ac].xmda00428,g_xmda_d[l_ac].xmda00428_desc,g_xmda_d[l_ac].xmdc01529, 
       g_xmda_d[l_ac].xmda00429,g_xmda_d[l_ac].xmda00429_desc,g_xmda_d[l_ac].xmdc01530,g_xmda_d[l_ac].xmda00430, 
       g_xmda_d[l_ac].xmda00430_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      EXIT FOREACH
      #end add-point
 
      CALL axmq050_detail_show("'1'")
 
      CALL axmq050_xmda_t_mask()
 
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
   CALL g_xmda_d.clear()

   LET l_sql = "SELECT xmdc001,'','',xmda015,'',xmdc0151,xmda0041,'', ",
               "       xmdc0152,xmda0042,'',xmdc0153,xmda0043,'',xmdc0154,xmda0044,'',xmdc0155,xmda0045,'', ",
               "       xmdc0156,xmda0046,'',xmdc0157,xmda0047,'',xmdc0158,xmda0048,'',xmdc0159,xmda0049,'', ",
               "       xmdc01510,xmda00410,'',xmdc01511,xmda00411,'',xmdc01512,xmda00412,'',xmdc01513,xmda00413,'', ",
               "       xmdc01514,xmda00414,'',xmdc01515,xmda00415,'',xmdc01516,xmda00416,'',xmdc01517,xmda00417,'', ",
               "       xmdc01518,xmda00418,'',xmdc01519,xmda00419,'',xmdc01520,xmda00420,'',xmdc01521,xmda00421,'', ",
               "       xmdc01522,xmda00422,'',xmdc01523,xmda00423,'',xmdc01524,xmda00424,'',xmdc01525,xmda00425,'', ",
               "       xmdc01526,xmda00426,'',xmdc01527,xmda00427,'',xmdc01528,xmda00428,'',xmdc01529,xmda00429,'', ",
               "       xmdc01530,xmda00430,'' ",
               "  FROM axmq050_tmp03 "         #160727-00019#25 Mod  axmq050_relest_t--> axmq050_tmp03
   PREPARE axmq050_b_fill_prep FROM l_sql
   DECLARE axmq050_b_fill_curs CURSOR FOR axmq050_b_fill_prep

   FOREACH axmq050_b_fill_curs INTO g_xmda_d[l_ac].xmdc001,g_xmda_d[l_ac].xmdc001_desc,
                                    g_xmda_d[l_ac].xmdc001_desc_1,g_xmda_d[l_ac].xmda015,g_xmda_d[l_ac].xmda015_desc,
                                    g_xmda_d[l_ac].xmdc0151, 
                                    g_xmda_d[l_ac].xmda0041,g_xmda_d[l_ac].xmda0041_desc, 
                                    g_xmda_d[l_ac].xmdc0152, 
                                    g_xmda_d[l_ac].xmda0042,g_xmda_d[l_ac].xmda0042_desc, 
                                    g_xmda_d[l_ac].xmdc0153, 
                                    g_xmda_d[l_ac].xmda0043,g_xmda_d[l_ac].xmda0043_desc, 
                                    g_xmda_d[l_ac].xmdc0154, 
                                    g_xmda_d[l_ac].xmda0044,g_xmda_d[l_ac].xmda0044_desc, 
                                    g_xmda_d[l_ac].xmdc0155, 
                                    g_xmda_d[l_ac].xmda0045,g_xmda_d[l_ac].xmda0045_desc, 
                                    g_xmda_d[l_ac].xmdc0156, 
                                    g_xmda_d[l_ac].xmda0046,g_xmda_d[l_ac].xmda0046_desc, 
                                    g_xmda_d[l_ac].xmdc0157, 
                                    g_xmda_d[l_ac].xmda0047,g_xmda_d[l_ac].xmda0047_desc, 
                                    g_xmda_d[l_ac].xmdc0158,
                                    g_xmda_d[l_ac].xmda0048,g_xmda_d[l_ac].xmda0048_desc, 
                                    g_xmda_d[l_ac].xmdc0159, 
                                    g_xmda_d[l_ac].xmda0049,g_xmda_d[l_ac].xmda0049_desc, 
                                    g_xmda_d[l_ac].xmdc01510,
                                    g_xmda_d[l_ac].xmda00410,g_xmda_d[l_ac].xmda00410_desc, 
                                    g_xmda_d[l_ac].xmdc01511,
                                    g_xmda_d[l_ac].xmda00411,g_xmda_d[l_ac].xmda00411_desc, 
                                    g_xmda_d[l_ac].xmdc01512,
                                    g_xmda_d[l_ac].xmda00412,g_xmda_d[l_ac].xmda00412_desc,  
                                    g_xmda_d[l_ac].xmdc01513, 
                                    g_xmda_d[l_ac].xmda00413,g_xmda_d[l_ac].xmda00413_desc, 
                                    g_xmda_d[l_ac].xmdc01514, 
                                    g_xmda_d[l_ac].xmda00414,g_xmda_d[l_ac].xmda00414_desc, 
                                    g_xmda_d[l_ac].xmdc01515, 
                                    g_xmda_d[l_ac].xmda00415,g_xmda_d[l_ac].xmda00415_desc, 
                                    g_xmda_d[l_ac].xmdc01516, 
                                    g_xmda_d[l_ac].xmda00416,g_xmda_d[l_ac].xmda00416_desc, 
                                    g_xmda_d[l_ac].xmdc01517, 
                                    g_xmda_d[l_ac].xmda00417,g_xmda_d[l_ac].xmda00417_desc, 
                                    g_xmda_d[l_ac].xmdc01518, 
                                    g_xmda_d[l_ac].xmda00418,g_xmda_d[l_ac].xmda00418_desc, 
                                    g_xmda_d[l_ac].xmdc01519, 
                                    g_xmda_d[l_ac].xmda00419,g_xmda_d[l_ac].xmda00419_desc, 
                                    g_xmda_d[l_ac].xmdc01520, 
                                    g_xmda_d[l_ac].xmda00420,g_xmda_d[l_ac].xmda00420_desc, 
                                    g_xmda_d[l_ac].xmdc01521, 
                                    g_xmda_d[l_ac].xmda00421,g_xmda_d[l_ac].xmda00421_desc, 
                                    g_xmda_d[l_ac].xmdc01522, 
                                    g_xmda_d[l_ac].xmda00422,g_xmda_d[l_ac].xmda00422_desc, 
                                    g_xmda_d[l_ac].xmdc01523, 
                                    g_xmda_d[l_ac].xmda00423,g_xmda_d[l_ac].xmda00423_desc, 
                                    g_xmda_d[l_ac].xmdc01524, 
                                    g_xmda_d[l_ac].xmda00424,g_xmda_d[l_ac].xmda00424_desc, 
                                    g_xmda_d[l_ac].xmdc01525, 
                                    g_xmda_d[l_ac].xmda00425,g_xmda_d[l_ac].xmda00425_desc, 
                                    g_xmda_d[l_ac].xmdc01526, 
                                    g_xmda_d[l_ac].xmda00426,g_xmda_d[l_ac].xmda00426_desc, 
                                    g_xmda_d[l_ac].xmdc01527, 
                                    g_xmda_d[l_ac].xmda00427,g_xmda_d[l_ac].xmda00427_desc, 
                                    g_xmda_d[l_ac].xmdc01528, 
                                    g_xmda_d[l_ac].xmda00428,g_xmda_d[l_ac].xmda00428_desc,  
                                    g_xmda_d[l_ac].xmdc01529, 
                                    g_xmda_d[l_ac].xmda00429,g_xmda_d[l_ac].xmda00429_desc, 
                                    g_xmda_d[l_ac].xmdc01530,
                                    g_xmda_d[l_ac].xmda00430,g_xmda_d[l_ac].xmda00430_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF  
      
      #最低單價 
      IF g_master.radio = '1' THEN
         LET l_sql = "SELECT MIN(xmdc015) ",
                     "  FROM axmq050_tmp02 ",           #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
                     " WHERE xmdc001 = '",g_xmda_d[l_ac].xmdc001,"' ",
                     "   AND xmda015 = '",g_xmda_d[l_ac].xmda015,"' "
      END IF

      #平均單價 
      IF g_master.radio = '2' THEN
         LET l_sql = "SELECT AVG(xmdc015) ",
                     "  FROM axmq050_tmp02 ",            #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
                     " WHERE xmdc001 = '",g_xmda_d[l_ac].xmdc001,"' ",
                     "   AND xmda015 = '",g_xmda_d[l_ac].xmda015,"' "
      END IF 
      
      #最高單價 
      IF g_master.radio = '3' THEN
         LET l_sql = "SELECT MAX(xmdc015) ",
                     "  FROM axmq050_tmp02 ",            #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
                     " WHERE xmdc001 = '",g_xmda_d[l_ac].xmdc001,"' ",
                     "   AND xmda015 = '",g_xmda_d[l_ac].xmda015,"' "
      END IF

      IF g_master.radio = '4' THEN
         LET l_sql = "SELECT xmdc015 ",
                     "  FROM axmq050_tmp02 ",            #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
                     " WHERE xmdc001 = '",g_xmda_d[l_ac].xmdc001,"' ",
                     "   AND xmda015 = '",g_xmda_d[l_ac].xmda015,"' "
      END IF

      PREPARE axmq050_get_all_prep FROM l_sql
      EXECUTE axmq050_get_all_prep INTO g_xmda_d[l_ac].xmdc015
      
      CALL axmq050_detail_show("'1'")

      CALL axmq050_xmda_t_mask()

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
   
   CALL cl_set_comp_visible("b_xmdc0151",FALSE)
   CALL cl_set_comp_visible("b_xmdc0152",FALSE)
   CALL cl_set_comp_visible("b_xmdc0153",FALSE)
   CALL cl_set_comp_visible("b_xmdc0154",FALSE)
   CALL cl_set_comp_visible("b_xmdc0155",FALSE)
   CALL cl_set_comp_visible("b_xmdc0156",FALSE)
   CALL cl_set_comp_visible("b_xmdc0157",FALSE)
   CALL cl_set_comp_visible("b_xmdc0158",FALSE)
   CALL cl_set_comp_visible("b_xmdc0159",FALSE)
   CALL cl_set_comp_visible("b_xmdc01510",FALSE)
   CALL cl_set_comp_visible("b_xmdc01511",FALSE)
   CALL cl_set_comp_visible("b_xmdc01512",FALSE)
   CALL cl_set_comp_visible("b_xmdc01513",FALSE)
   CALL cl_set_comp_visible("b_xmdc01514",FALSE)
   CALL cl_set_comp_visible("b_xmdc01515",FALSE)
   CALL cl_set_comp_visible("b_xmdc01516",FALSE)
   CALL cl_set_comp_visible("b_xmdc01517",FALSE)
   CALL cl_set_comp_visible("b_xmdc01518",FALSE)
   CALL cl_set_comp_visible("b_xmdc01519",FALSE) 
   CALL cl_set_comp_visible("b_xmdc01520",FALSE)
   CALL cl_set_comp_visible("b_xmdc01521",FALSE)
   CALL cl_set_comp_visible("b_xmdc01522",FALSE)
   CALL cl_set_comp_visible("b_xmdc01523",FALSE)
   CALL cl_set_comp_visible("b_xmdc01524",FALSE)
   CALL cl_set_comp_visible("b_xmdc01525",FALSE)
   CALL cl_set_comp_visible("b_xmdc01526",FALSE)
   CALL cl_set_comp_visible("b_xmdc01527",FALSE)
   CALL cl_set_comp_visible("b_xmdc01528",FALSE)
   CALL cl_set_comp_visible("b_xmdc01529",FALSE)
   CALL cl_set_comp_visible("b_xmdc01530",FALSE) 
   
   IF l_ac > 1 THEN
      IF NOT cl_null(g_xmda_d[1].xmda0041) THEN
         LET l_text = g_xmda_d[1].xmda0041,".",g_xmda_d[1].xmda0041_desc
         CALL cl_set_comp_att_text('b_xmdc0151',l_text) 
         CALL cl_set_comp_visible('b_xmdc0151',TRUE)
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda0042) THEN
         LET l_text = g_xmda_d[1].xmda0042,".",g_xmda_d[1].xmda0042_desc
         CALL cl_set_comp_att_text('b_xmdc0152',l_text) 
         CALL cl_set_comp_visible('b_xmdc0152',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda0043) THEN
         LET l_text = g_xmda_d[1].xmda0043,".",g_xmda_d[1].xmda0043_desc
         CALL cl_set_comp_att_text('b_xmdc0153',l_text) 
         CALL cl_set_comp_visible('b_xmdc0153',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda0044) THEN
         LET l_text = g_xmda_d[1].xmda0044,".",g_xmda_d[1].xmda0044_desc
         CALL cl_set_comp_att_text('b_xmdc0154',l_text) 
         CALL cl_set_comp_visible('b_xmdc0154',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda0045) THEN
         LET l_text = g_xmda_d[1].xmda0045,".",g_xmda_d[1].xmda0045_desc
         CALL cl_set_comp_att_text('b_xmdc0155',l_text) 
         CALL cl_set_comp_visible('b_xmdc0155',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda0046) THEN
         LET l_text = g_xmda_d[1].xmda0046,".",g_xmda_d[1].xmda0046_desc
         CALL cl_set_comp_att_text('b_xmdc0156',l_text) 
         CALL cl_set_comp_visible('b_xmdc0156',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda0047) THEN
         LET l_text = g_xmda_d[1].xmda0047,".",g_xmda_d[1].xmda0047_desc
         CALL cl_set_comp_att_text('b_xmdc0157',l_text) 
         CALL cl_set_comp_visible('b_xmdc0157',TRUE) 
      END IF 
      
      IF NOT cl_null(g_xmda_d[1].xmda0048) THEN
         LET l_text = g_xmda_d[1].xmda0048,".",g_xmda_d[1].xmda0048_desc
         CALL cl_set_comp_att_text('b_xmdc0158',l_text) 
         CALL cl_set_comp_visible('b_xmdc0158',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda0049) THEN
         LET l_text = g_xmda_d[1].xmda0049,".",g_xmda_d[1].xmda0049_desc
         CALL cl_set_comp_att_text('b_xmdc0159',l_text) 
         CALL cl_set_comp_visible('b_xmdc0159',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00410) THEN
         LET l_text = g_xmda_d[1].xmda00410,".",g_xmda_d[1].xmda00410_desc
         CALL cl_set_comp_att_text('b_xmdc01510',l_text) 
         CALL cl_set_comp_visible('b_xmdc01510',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00411) THEN
         LET l_text = g_xmda_d[1].xmda00411,".",g_xmda_d[1].xmda00411_desc
         CALL cl_set_comp_att_text('b_xmdc01511',l_text) 
         CALL cl_set_comp_visible('b_xmdc01511',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00412) THEN
         LET l_text = g_xmda_d[1].xmda00412,".",g_xmda_d[1].xmda00412_desc
         CALL cl_set_comp_att_text('b_xmdc01512',l_text) 
         CALL cl_set_comp_visible('b_xmdc01512',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00413) THEN
         LET l_text = g_xmda_d[1].xmda00413,".",g_xmda_d[1].xmda00413_desc
         CALL cl_set_comp_att_text('b_xmdc01513',l_text) 
         CALL cl_set_comp_visible('b_xmdc01513',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00414) THEN
         LET l_text = g_xmda_d[1].xmda00414,".",g_xmda_d[1].xmda00414_desc
         CALL cl_set_comp_att_text('b_xmdc01514',l_text) 
         CALL cl_set_comp_visible('b_xmdc01514',TRUE) 
      END IF 
      IF NOT cl_null(g_xmda_d[1].xmda00415) THEN
         LET l_text = g_xmda_d[1].xmda00415,".",g_xmda_d[1].xmda00415_desc
         CALL cl_set_comp_att_text('b_xmdc01515',l_text) 
         CALL cl_set_comp_visible('b_xmdc01515',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00416) THEN
         LET l_text = g_xmda_d[1].xmda00416,".",g_xmda_d[1].xmda00416_desc
         CALL cl_set_comp_att_text('b_xmdc01516',l_text) 
         CALL cl_set_comp_visible('b_xmdc01516',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00417) THEN
         LET l_text = g_xmda_d[1].xmda00417,".",g_xmda_d[1].xmda00417_desc
         CALL cl_set_comp_att_text('b_xmdc01517',l_text) 
         CALL cl_set_comp_visible('b_xmdc01517',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00418) THEN
         LET l_text = g_xmda_d[1].xmda00418,".",g_xmda_d[1].xmda00418_desc
         CALL cl_set_comp_att_text('b_xmdc01518',l_text) 
         CALL cl_set_comp_visible('b_xmdc01518',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00419) THEN
         LET l_text = g_xmda_d[1].xmda00419,".",g_xmda_d[1].xmda00419_desc
         CALL cl_set_comp_att_text('b_xmdc01519',l_text) 
         CALL cl_set_comp_visible('b_xmdc01519',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00420) THEN
         LET l_text = g_xmda_d[1].xmda00420,".",g_xmda_d[1].xmda00420_desc
         CALL cl_set_comp_att_text('b_xmdc01520',l_text) 
         CALL cl_set_comp_visible('b_xmdc01520',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00421) THEN
         LET l_text = g_xmda_d[1].xmda00421,".",g_xmda_d[1].xmda00421_desc
         CALL cl_set_comp_att_text('b_xmdc01521',l_text) 
         CALL cl_set_comp_visible('b_xmdc01521',TRUE) 
      END IF 
      IF NOT cl_null(g_xmda_d[1].xmda00422) THEN
         LET l_text = g_xmda_d[1].xmda00422,".",g_xmda_d[1].xmda00422_desc
         CALL cl_set_comp_att_text('b_xmdc01522',l_text) 
         CALL cl_set_comp_visible('b_xmdc01522',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00423) THEN
         LET l_text = g_xmda_d[1].xmda00423,".",g_xmda_d[1].xmda00423_desc
         CALL cl_set_comp_att_text('b_xmdc01523',l_text) 
         CALL cl_set_comp_visible('b_xmdc01523',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00424) THEN
         LET l_text = g_xmda_d[1].xmda00424,".",g_xmda_d[1].xmda00424_desc
         CALL cl_set_comp_att_text('b_xmdc01524',l_text) 
         CALL cl_set_comp_visible('b_xmdc01524',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00425) THEN
         LET l_text = g_xmda_d[1].xmda00425,".",g_xmda_d[1].xmda00425_desc
         CALL cl_set_comp_att_text('b_xmdc01525',l_text) 
         CALL cl_set_comp_visible('b_xmdc01525',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00426) THEN
         LET l_text = g_xmda_d[1].xmda00426,".",g_xmda_d[1].xmda00426_desc
         CALL cl_set_comp_att_text('b_xmdc01526',l_text) 
         CALL cl_set_comp_visible('b_xmdc01526',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00427) THEN
         LET l_text = g_xmda_d[1].xmda00427,".",g_xmda_d[1].xmda00427_desc
         CALL cl_set_comp_att_text('b_xmdc01527',l_text) 
         CALL cl_set_comp_visible('b_xmdc01527',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00428) THEN
         LET l_text = g_xmda_d[1].xmda00428,".",g_xmda_d[1].xmda00428_desc
         CALL cl_set_comp_att_text('b_xmdc01528',l_text) 
         CALL cl_set_comp_visible('b_xmdc01528',TRUE) 
      END IF 
      IF NOT cl_null(g_xmda_d[1].xmda00429) THEN
         LET l_text = g_xmda_d[1].xmda00429,".",g_xmda_d[1].xmda00429_desc
         CALL cl_set_comp_att_text('b_xmdc01529',l_text) 
         CALL cl_set_comp_visible('b_xmdc01529',TRUE) 
      END IF
      IF NOT cl_null(g_xmda_d[1].xmda00430) THEN
         LET l_text = g_xmda_d[1].xmda00430,".",g_xmda_d[1].xmda00430_desc
         CALL cl_set_comp_att_text('b_xmdc01530',l_text) 
         CALL cl_set_comp_visible('b_xmdc01530',TRUE) 
      END IF

   END IF
   #end add-point
 
   CALL g_xmda_d.deleteElement(g_xmda_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xmda_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE axmq050_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axmq050_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axmq050_detail_action_trans()
 
   LET l_ac = 1
   IF g_xmda_d.getLength() > 0 THEN
      CALL axmq050_b_fill2()
   END IF
 
      CALL axmq050_filter_show('xmdc001','b_xmdc001')
   CALL axmq050_filter_show('xmda015','b_xmda015')
 
 
END FUNCTION
 
{</section>}
 
{<section id="axmq050.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmq050_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_success       LIKE type_t.num5 
   DEFINE l_xmda004       LIKE xmda_t.xmda004
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   CALL g_xmdc2_d.clear()

   LET l_sql = "SELECT DISTINCT xmda004 ",
               "  FROM axmq050_tmp02 ",                #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
               " WHERE xmdc001 = '",g_xmda_d[l_ac].xmdc001,"' ",
               "   AND xmda015 = '",g_xmda_d[l_ac].xmda015,"' "
   PREPARE axmq050_b_fill2_xmda004_prep FROM l_sql
   DECLARE axmq050_b_fill2_xmda004_curs CURSOR FOR axmq050_b_fill2_xmda004_prep

   LET l_i = 1
   FOREACH axmq050_b_fill2_xmda004_curs INTO l_xmda004
      #最低單價 
      IF g_master.radio = '1' THEN
         LET l_sql = "SELECT xmdadocno,xmdadocdt,xmda004,'',xmda002,'',xmda003,'', ",
                     "       xmdcseq,xmdc019,xmdc002,'',xmdc006,'',xmdc007,xmdc0152,xmdc015 ",
                     "  FROM axmq050_tmp02 ",            #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
                     " WHERE xmdc001 = '",g_xmda_d[l_ac].xmdc001,"' ",
                     "   AND xmda015 = '",g_xmda_d[l_ac].xmda015,"' ",
                     "   AND xmda004 = '",l_xmda004,"' ",
                     "   AND xmdc015 = (SELECT MIN(xmdc015) ",
                     "                    FROM axmq050_tmp02 ",         #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
                     "                   WHERE xmdc001 = '",g_xmda_d[l_ac].xmdc001,"' ",
                     "                     AND xmda015 = '",g_xmda_d[l_ac].xmda015,"' ",
                     "                     AND xmda004 = '",l_xmda004,"' ) "
      END IF

      #平均單價 
      IF g_master.radio = '2' THEN
         LET l_sql = "SELECT xmdadocno,xmdadocdt,xmda004,'',xmda002,'',xmda003,'', ",
                     "       xmdcseq,xmdc019,xmdc002,'',xmdc006,'',xmdc007,xmdc0152,xmdc015 ",
                     "  FROM axmq050_tmp02 ",            #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
                     " WHERE xmdc001 = '",g_xmda_d[l_ac].xmdc001,"' ", 
                     "   AND xmda015 = '",g_xmda_d[l_ac].xmda015,"' ",
                     "   AND xmda004 = '",l_xmda004,"' "
      END IF

      #最高單價 
      IF g_master.radio = '3' THEN
         LET l_sql = "SELECT xmdadocno,xmdadocdt,xmda004,'',xmda002,'',xmda003,'', ",
                     "       xmdcseq,xmdc019,xmdc002,'',xmdc006,'',xmdc007,xmdc0152,xmdc015 ",
                     "  FROM axmq050_tmp02 ",          #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
                     " WHERE xmdc001 = '",g_xmda_d[l_ac].xmdc001,"' ",
                     "   AND xmda015 = '",g_xmda_d[l_ac].xmda015,"' ",
                     "   AND xmda004 = '",l_xmda004,"' ",
                     "   AND xmdc015 = (SELECT MAX(xmdc015) ",
                     "                    FROM axmq050_tmp02 ",        #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
                     "                   WHERE xmdc001 = '",g_xmda_d[l_ac].xmdc001,"' ",
                     "                     AND xmda015 = '",g_xmda_d[l_ac].xmda015,"' ",
                     "                     AND xmda004 = '",l_xmda004,"' ) "
      END IF

      #最近單價 
      IF g_master.radio = '4' THEN
         LET l_sql = "SELECT xmdadocno,xmdadocdt,xmda004,'',xmda002,'',xmda003,'', ",
                     "       xmdcseq,xmdc019,xmdc002,'',xmdc006,'',xmdc007,xmdc0152,xmdc015 ",
                     "  FROM axmq050_tmp02 ",           #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
                     " WHERE xmdc001 = '",g_xmda_d[l_ac].xmdc001,"' ",
                     "   AND xmda015 = '",g_xmda_d[l_ac].xmda015,"' ",
                     "   AND xmda004 = '",l_xmda004,"' ",
                     "   AND xmdc015 = (SELECT MAX(xmdadocdt) ",
                     "                    FROM axmq050_tmp02 ",          #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
                     "                   WHERE xmdc001 = '",g_xmda_d[l_ac].xmdc001,"' ", 
                     "                     AND xmda015 = '",g_xmda_d[l_ac].xmda015,"' ",
                     "                     AND xmda004 = '",l_xmda004,"' ",
                     "                     AND xmdadocdt <= '",g_today,"') "
      END IF

      PREPARE axmq050_b_fill2_prep FROM l_sql
      DECLARE axmq050_b_fill2_curs CURSOR FOR axmq050_b_fill2_prep
      FOREACH axmq050_b_fill2_curs INTO g_xmdc2_d[l_i].xmdadocno,g_xmdc2_d[l_i].xmdadocdt,
                                        g_xmdc2_d[l_i].xmda004,g_xmdc2_d[l_i].xmda004_desc,
                                        g_xmdc2_d[l_i].xmda002,g_xmdc2_d[l_i].xmda002_desc,
                                        g_xmdc2_d[l_i].xmda003,g_xmdc2_d[l_i].xmda003_desc,
                                        g_xmdc2_d[l_i].xmdcseq,g_xmdc2_d[l_i].xmdc019,
                                        g_xmdc2_d[l_i].xmdc002,g_xmdc2_d[l_i].xmdc002_desc,
                                        g_xmdc2_d[l_i].xmdc006,g_xmdc2_d[l_i].xmdc006_desc,
                                        g_xmdc2_d[l_i].xmdc007,g_xmdc2_d[l_i].xmdc015, 
                                        g_xmdc2_d[l_i].xmdc015_1

         CALL s_desc_get_trading_partner_abbr_desc(g_xmdc2_d[l_i].xmda004)
              RETURNING g_xmdc2_d[l_i].xmda004_desc

         CALL s_desc_get_person_desc(g_xmdc2_d[l_i].xmda002)
              RETURNING g_xmdc2_d[l_i].xmda002_desc

         CALL s_desc_get_department_desc(g_xmdc2_d[l_i].xmda003)
              RETURNING g_xmdc2_d[l_i].xmda003_desc

         CALL s_feature_description(g_xmda_d[l_ac].xmdc001,g_xmdc2_d[l_i].xmdc002)
              RETURNING l_success,g_xmdc2_d[l_i].xmdc002_desc

         CALL s_desc_get_unit_desc(g_xmdc2_d[l_i].xmdc006)
              RETURNING g_xmdc2_d[l_i].xmdc006_desc

         LET l_i = l_i + 1
      END FOREACH

   END FOREACH
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
 
{<section id="axmq050.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axmq050_detail_show(ps_page)
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
      #取得品名、規格  
      CALL s_desc_get_item_desc(g_xmda_d[l_ac].xmdc001)
           RETURNING g_xmda_d[l_ac].xmdc001_desc,
                     g_xmda_d[l_ac].xmdc001_desc_1

      #取得幣別說明 
      CALL s_desc_get_currency_desc(g_xmda_d[l_ac].xmda015)
           RETURNING g_xmda_d[l_ac].xmda015_desc

      #取得交易對象說明 
      IF NOT cl_null(g_xmda_d[l_ac].xmda0041) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda0041)
              RETURNING g_xmda_d[l_ac].xmda0041_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda0042) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda0042)
              RETURNING g_xmda_d[l_ac].xmda0042_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda0043) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda0043)
              RETURNING g_xmda_d[l_ac].xmda0043_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda0044) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda0044)
              RETURNING g_xmda_d[l_ac].xmda0044_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda0045) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda0045)
              RETURNING g_xmda_d[l_ac].xmda0045_desc
      END IF 
      IF NOT cl_null(g_xmda_d[l_ac].xmda0046) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda0046)
              RETURNING g_xmda_d[l_ac].xmda0046_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda0047) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda0047)
              RETURNING g_xmda_d[l_ac].xmda0047_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda0048) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda0048)
              RETURNING g_xmda_d[l_ac].xmda0048_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda0049) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda0049)
              RETURNING g_xmda_d[l_ac].xmda0049_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00410) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00410)
              RETURNING g_xmda_d[l_ac].xmda00410_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00411) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00411)
              RETURNING g_xmda_d[l_ac].xmda00411_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00412) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00412)
              RETURNING g_xmda_d[l_ac].xmda00412_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00413) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00413)
              RETURNING g_xmda_d[l_ac].xmda00413_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00414) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00414)
              RETURNING g_xmda_d[l_ac].xmda00414_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00415) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00415)
              RETURNING g_xmda_d[l_ac].xmda00415_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00416) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00416)
              RETURNING g_xmda_d[l_ac].xmda00416_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00417) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00417)
              RETURNING g_xmda_d[l_ac].xmda00417_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00418) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00418)
              RETURNING g_xmda_d[l_ac].xmda00418_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00419) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00419)
              RETURNING g_xmda_d[l_ac].xmda00419_desc
      END IF 
      IF NOT cl_null(g_xmda_d[l_ac].xmda00420) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00420)
              RETURNING g_xmda_d[l_ac].xmda00420_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00421) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00421)
              RETURNING g_xmda_d[l_ac].xmda00421_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00422) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00422)
              RETURNING g_xmda_d[l_ac].xmda00422_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00423) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00423)
              RETURNING g_xmda_d[l_ac].xmda00423_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00424) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00424)
              RETURNING g_xmda_d[l_ac].xmda00424_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00425) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00425)
              RETURNING g_xmda_d[l_ac].xmda00425_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00426) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00426)
              RETURNING g_xmda_d[l_ac].xmda00426_desc
      END IF 
      IF NOT cl_null(g_xmda_d[l_ac].xmda00427) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00427)
              RETURNING g_xmda_d[l_ac].xmda00427_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00428) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00428)
              RETURNING g_xmda_d[l_ac].xmda00428_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00429) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00429)
              RETURNING g_xmda_d[l_ac].xmda00429_desc
      END IF
      IF NOT cl_null(g_xmda_d[l_ac].xmda00430) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_xmda_d[l_ac].xmda00430)
              RETURNING g_xmda_d[l_ac].xmda00430_desc
      END IF
      
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmq050.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION axmq050_filter()
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
      CONSTRUCT g_wc_filter ON xmdc001,xmda015
                          FROM s_detail1[1].b_xmdc001,s_detail1[1].b_xmda015
 
         BEFORE CONSTRUCT
                     DISPLAY axmq050_filter_parser('xmdc001') TO s_detail1[1].b_xmdc001
            DISPLAY axmq050_filter_parser('xmda015') TO s_detail1[1].b_xmda015
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xmdc001>>----
         #Ctrlp:construct.c.page1.b_xmdc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdc001
            #add-point:ON ACTION controlp INFIELD b_xmdc001 name="construct.c.filter.page1.b_xmdc001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdc001  #顯示到畫面上
            NEXT FIELD b_xmdc001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdc001_desc>>----
         #----<<b_xmdc001_desc_1>>----
         #----<<b_xmda015>>----
         #Ctrlp:construct.c.page1.b_xmda015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda015
            #add-point:ON ACTION controlp INFIELD b_xmda015 name="construct.c.filter.page1.b_xmda015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmda015  #顯示到畫面上
            NEXT FIELD b_xmda015                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmda015_desc>>----
         #----<<b_xmdc015_a>>----
         #----<<b_xmdc0151>>----
         #----<<b_xmda0041>>----
         #----<<b_xmda0041_desc>>----
         #----<<b_xmdc0152>>----
         #----<<b_xmda0042>>----
         #----<<b_xmda0042_desc>>----
         #----<<b_xmdc0153>>----
         #----<<b_xmda0043>>----
         #----<<b_xmda0043_desc>>----
         #----<<b_xmdc0154>>----
         #----<<b_xmda0044>>----
         #----<<b_xmda0044_desc>>----
         #----<<b_xmdc0155>>----
         #----<<b_xmda0045>>----
         #----<<b_xmda0045_desc>>----
         #----<<b_xmdc0156>>----
         #----<<b_xmda0046>>----
         #----<<b_xmda0046_desc>>----
         #----<<b_xmdc0157>>----
         #----<<b_xmda0047>>----
         #----<<b_xmda0047_desc>>----
         #----<<b_xmdc0158>>----
         #----<<b_xmda0048>>----
         #----<<b_xmda0048_desc>>----
         #----<<b_xmdc0159>>----
         #----<<b_xmda0049>>----
         #----<<b_xmda0049_desc>>----
         #----<<b_xmdc01510>>----
         #----<<b_xmda00410>>----
         #----<<b_xmda00410_desc>>----
         #----<<b_xmdc01511>>----
         #----<<b_xmda00411>>----
         #----<<b_xmda00411_desc>>----
         #----<<b_xmdc01512>>----
         #----<<b_xmda00412>>----
         #----<<b_xmda00412_desc>>----
         #----<<b_xmdc01513>>----
         #----<<b_xmda00413>>----
         #----<<b_xmda00413_desc>>----
         #----<<b_xmdc01514>>----
         #----<<b_xmda00414>>----
         #----<<b_xmda00414_desc>>----
         #----<<b_xmdc01515>>----
         #----<<b_xmda00415>>----
         #----<<b_xmda00415_desc>>----
         #----<<b_xmdc01516>>----
         #----<<b_xmda00416>>----
         #----<<b_xmda00416_desc>>----
         #----<<b_xmdc01517>>----
         #----<<b_xmda00417>>----
         #----<<b_xmda00417_desc>>----
         #----<<b_xmdc01518>>----
         #----<<b_xmda00418>>----
         #----<<b_xmda00418_desc>>----
         #----<<b_xmdc01519>>----
         #----<<b_xmda00419>>----
         #----<<b_xmda00419_desc>>----
         #----<<b_xmdc01520>>----
         #----<<b_xmda00420>>----
         #----<<b_xmda00420_desc>>----
         #----<<b_xmdc01521>>----
         #----<<b_xmda00421>>----
         #----<<b_xmda00421_desc>>----
         #----<<b_xmdc01522>>----
         #----<<b_xmda00422>>----
         #----<<b_xmda00422_desc>>----
         #----<<b_xmdc01523>>----
         #----<<b_xmda00423>>----
         #----<<b_xmda00423_desc>>----
         #----<<b_xmdc01524>>----
         #----<<b_xmda00424>>----
         #----<<b_xmda00424_desc>>----
         #----<<b_xmdc01525>>----
         #----<<b_xmda00425>>----
         #----<<b_xmda00425_desc>>----
         #----<<b_xmdc01526>>----
         #----<<b_xmda00426>>----
         #----<<b_xmda00426_desc>>----
         #----<<b_xmdc01527>>----
         #----<<b_xmda00427>>----
         #----<<b_xmda00427_desc>>----
         #----<<b_xmdc01528>>----
         #----<<b_xmda00428>>----
         #----<<b_xmda00428_desc>>----
         #----<<b_xmdc01529>>----
         #----<<b_xmda00429>>----
         #----<<b_xmda00429_desc>>----
         #----<<b_xmdc01530>>----
         #----<<b_xmda00430>>----
         #----<<b_xmda00430_desc>>----
 
 
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
 
      CALL axmq050_filter_show('xmdc001','b_xmdc001')
   CALL axmq050_filter_show('xmda015','b_xmda015')
 
 
   CALL axmq050_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axmq050.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION axmq050_filter_parser(ps_field)
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
 
{<section id="axmq050.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION axmq050_filter_show(ps_field,ps_object)
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
   LET ls_condition = axmq050_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="axmq050.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axmq050_detail_action_trans()
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
 
{<section id="axmq050.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axmq050_detail_index_setting()
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
            IF g_xmda_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xmda_d.getLength() AND g_xmda_d.getLength() > 0
            LET g_detail_idx = g_xmda_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xmda_d.getLength() THEN
               LET g_detail_idx = g_xmda_d.getLength()
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
 
{<section id="axmq050.mask_functions" >}
 &include "erp/axm/axmq050_mask.4gl"
 
{</section>}
 
{<section id="axmq050.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 建立temp table 
# Memo...........:
# Usage..........: CALL axmq050_create_temp_table()
# Date & Author..: 2015/07/27 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmq050_create_temp_table()
   DROP TABLE axmq050_data1;
   CREATE TEMP TABLE axmq050_data1(
      xmdc001        LIKE xmdc_t.xmdc001,
      xmda015        LIKE xmda_t.xmda015,
      xmda004        LIKE xmda_t.xmda004
   )

   DROP TABLE axmq050_tmp01;          #160727-00019#25 Mod  axmq050_xmda004_t--> axmq050_tmp01
   CREATE TEMP TABLE axmq050_tmp01(   #160727-00019#25 Mod  axmq050_xmda004_t--> axmq050_tmp01
      seq            LIKE type_t.num5,
      xmda004        LIKE xmda_t.xmda004
   )

   DROP TABLE axmq050_tmp02;              #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
   CREATE TEMP TABLE axmq050_tmp02(       #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
      xmdadocno      LIKE xmda_t.xmdadocno,
      xmdadocdt      LIKE xmda_t.xmdadocdt,
      xmdc001        LIKE xmdc_t.xmdc001,
      xmda004        LIKE xmda_t.xmda004,
      xmda015        LIKE xmda_t.xmda015,
      xmdc015        LIKE xmdc_t.xmdc015,  
      xmdc0152       LIKE xmdc_t.xmdc015,  
      xmda002        LIKE xmda_t.xmda002,
      xmda003        LIKE xmda_t.xmda003,
      xmdcseq        LIKE xmdc_t.xmdcseq,
      xmdc019        LIKE xmdc_t.xmdc019,
      xmdc002        LIKE xmdc_t.xmdc002,
      xmdc006        LIKE xmdc_t.xmdc006,
      xmdc007        LIKE xmdc_t.xmdc007
   ) 
   
   DROP TABLE axmq050_tmp03;               #160727-00019#25 Mod  axmq050_relest_t--> axmq050_tmp03
   CREATE TEMP TABLE axmq050_tmp03(        #160727-00019#25 Mod  axmq050_relest_t--> axmq050_tmp03
      xmdc001        LIKE xmdc_t.xmdc001,
      xmda015        LIKE xmda_t.xmda015,
      xmdc0151       LIKE xmdc_t.xmdc015, 
      xmda0041       LIKE xmda_t.xmda004, 
      xmdc0152       LIKE xmdc_t.xmdc015,
      xmda0042       LIKE xmda_t.xmda004, 
      xmdc0153       LIKE xmdc_t.xmdc015, 
      xmda0043       LIKE xmda_t.xmda004, 
      xmdc0154       LIKE xmdc_t.xmdc015, 
      xmda0044       LIKE xmda_t.xmda004, 
      xmdc0155       LIKE xmdc_t.xmdc015, 
      xmda0045       LIKE xmda_t.xmda004, 
      xmdc0156       LIKE xmdc_t.xmdc015, 
      xmda0046       LIKE xmda_t.xmda004, 
      xmdc0157       LIKE xmdc_t.xmdc015, 
      xmda0047       LIKE xmda_t.xmda004, 
      xmdc0158       LIKE xmdc_t.xmdc015, 
      xmda0048       LIKE xmda_t.xmda004, 
      xmdc0159       LIKE xmdc_t.xmdc015, 
      xmda0049       LIKE xmda_t.xmda004, 
      xmdc01510      LIKE xmdc_t.xmdc015, 
      xmda00410      LIKE xmda_t.xmda004, 
      xmdc01511      LIKE xmdc_t.xmdc015, 
      xmda00411      LIKE xmda_t.xmda004, 
      xmdc01512      LIKE xmdc_t.xmdc015, 
      xmda00412      LIKE xmda_t.xmda004, 
      xmdc01513      LIKE xmdc_t.xmdc015, 
      xmda00413      LIKE xmda_t.xmda004, 
      xmdc01514      LIKE xmdc_t.xmdc015, 
      xmda00414      LIKE xmda_t.xmda004, 
      xmdc01515      LIKE xmdc_t.xmdc015, 
      xmda00415      LIKE xmda_t.xmda004, 
      xmdc01516      LIKE xmdc_t.xmdc015, 
      xmda00416      LIKE xmda_t.xmda004, 
      xmdc01517      LIKE xmdc_t.xmdc015, 
      xmda00417      LIKE xmda_t.xmda004, 
      xmdc01518      LIKE xmdc_t.xmdc015, 
      xmda00418      LIKE xmda_t.xmda004, 
      xmdc01519      LIKE xmdc_t.xmdc015, 
      xmda00419      LIKE xmda_t.xmda004, 
      xmdc01520      LIKE xmdc_t.xmdc015, 
      xmda00420      LIKE xmda_t.xmda004, 
      xmdc01521      LIKE xmdc_t.xmdc015, 
      xmda00421      LIKE xmda_t.xmda004, 
      xmdc01522      LIKE xmdc_t.xmdc015, 
      xmda00422      LIKE xmda_t.xmda004, 
      xmdc01523      LIKE xmdc_t.xmdc015, 
      xmda00423      LIKE xmda_t.xmda004, 
      xmdc01524      LIKE xmdc_t.xmdc015, 
      xmda00424      LIKE xmda_t.xmda004, 
      xmdc01525      LIKE xmdc_t.xmdc015,  
      xmda00425      LIKE xmda_t.xmda004, 
      xmdc01526      LIKE xmdc_t.xmdc015, 
      xmda00426      LIKE xmda_t.xmda004, 
      xmdc01527      LIKE xmdc_t.xmdc015, 
      xmda00427      LIKE xmda_t.xmda004, 
      xmdc01528      LIKE xmdc_t.xmdc015, 
      xmda00428      LIKE xmda_t.xmda004, 
      xmdc01529      LIKE xmdc_t.xmdc015, 
      xmda00429      LIKE xmda_t.xmda004, 
      xmdc01530      LIKE xmdc_t.xmdc015, 
      xmda00430      LIKE xmda_t.xmda004 

   )

END FUNCTION

################################################################################
# Descriptions...: 移除temp table
# Memo...........:
# Usage..........: CALL axmq050_drop_temp_table()
# Date & Author..: 2015/07/27 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmq050_drop_temp_table()
   DROP TABLE axmq050_data1;
   DROP TABLE axmq050_tmp01;           #160727-00019#25 Mod  axmq050_xmda004_t--> axmq050_tmp01
   DROP TABLE axmq050_tmp02;           #160727-00019#25 Mod  axmq050_axmt500_t--> axmq050_tmp02
   DROP TABLE axmq050_tmp03;           #160727-00019#25 Mod  axmq050_relest_t--> axmq050_tmp03
END FUNCTION

 
{</section>}
 
