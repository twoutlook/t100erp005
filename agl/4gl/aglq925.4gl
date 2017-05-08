#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq925.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-11-27 14:49:14), PR版次:0001(2016-03-28 10:23:43)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000025
#+ Filename...: aglq925
#+ Description: 合併調整/沖銷/會計師調整傳票明細查詢
#+ Creator....: 02749(2015-11-24 15:36:25)
#+ Modifier...: 02749 -SD/PR- 05016
 
{</section>}
 
{<section id="aglq925.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"
#160322-00040#1  2016/03/24 By Hans TQC 1.合併障別資料未帶出 2.來源碼3.資料未帶出
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
       gldpld LIKE gldp_t.gldpld, 
   gldp001 LIKE gldp_t.gldp001, 
   gldp001_desc LIKE type_t.chr80, 
   gldp003 LIKE gldp_t.gldp003, 
   gldp004 LIKE gldp_t.gldp004, 
   gldp005 LIKE gldp_t.gldp005, 
   gldp006 LIKE gldp_t.gldp006, 
   gldp008 LIKE gldp_t.gldp008, 
   gldp008_desc LIKE type_t.chr80, 
   gldp011 LIKE gldp_t.gldp011, 
   gldp011_desc LIKE type_t.chr80, 
   gldp014 LIKE gldp_t.gldp014, 
   gldp014_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       sel LIKE type_t.chr1, 
   gldqdocno LIKE gldq_t.gldqdocno, 
   gldpdocdt LIKE gldp_t.gldpdocdt, 
   gldp007 LIKE gldp_t.gldp007, 
   gldqseq LIKE gldq_t.gldqseq, 
   gldq001 LIKE gldq_t.gldq001, 
   l_gldq001_desc LIKE type_t.chr500, 
   gldq017 LIKE gldq_t.gldq017, 
   gldq018 LIKE gldq_t.gldq018, 
   gldq023 LIKE gldq_t.gldq023
       END RECORD
PRIVATE TYPE type_g_detail2 RECORD
       gldqdocno LIKE gldq_t.gldqdocno, 
   gldpdocdt LIKE gldp_t.gldpdocdt, 
   gldp007 LIKE gldp_t.gldp007, 
   gldqseq LIKE gldq_t.gldqseq, 
   gldq001 LIKE gldq_t.gldq001, 
   l_gldq001_desc_2 LIKE type_t.chr500, 
   gldq019 LIKE gldq_t.gldq019, 
   gldq020 LIKE gldq_t.gldq020, 
   gldq023 LIKE gldq_t.gldq023
       END RECORD
 
PRIVATE TYPE type_g_detail3 RECORD
       gldqdocno LIKE gldq_t.gldqdocno, 
   gldpdocdt LIKE gldp_t.gldpdocdt, 
   gldp007 LIKE gldp_t.gldp007, 
   gldqseq LIKE gldq_t.gldqseq, 
   gldq001 LIKE gldq_t.gldq001, 
   l_gldq001_desc_3 LIKE type_t.chr500, 
   gldq021 LIKE gldq_t.gldq021, 
   gldq022 LIKE gldq_t.gldq022, 
   gldq023 LIKE gldq_t.gldq023
       END RECORD
 
PRIVATE TYPE type_g_detail4 RECORD
       gldq003 LIKE gldq_t.gldq003, 
   gldq004 LIKE gldq_t.gldq004, 
   gldq005 LIKE gldq_t.gldq005, 
   gldq006 LIKE gldq_t.gldq006, 
   gldq007 LIKE gldq_t.gldq007, 
   gldq008 LIKE gldq_t.gldq008, 
   gldq009 LIKE gldq_t.gldq009, 
   gldq010 LIKE gldq_t.gldq010, 
   gldq011 LIKE gldq_t.gldq011, 
   gldq012 LIKE gldq_t.gldq012, 
   gldq013 LIKE gldq_t.gldq013, 
   gldq014 LIKE gldq_t.gldq014, 
   gldq015 LIKE gldq_t.gldq015, 
   gldq016 LIKE gldq_t.gldq016
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_browser           DYNAMIC ARRAY OF type_g_master
DEFINE g_browser_t         DYNAMIC ARRAY OF type_g_master

DEFINE g_detail_show RECORD
   l_gldq003        LIKE gldq_t.gldq003, 
   l_gldq003_desc   LIKE ooefl_t.ooefl003,
   l_gldq004        LIKE gldq_t.gldq004, 
   l_gldq004_desc   LIKE ooefl_t.ooefl003,
   l_gldq005        LIKE gldq_t.gldq005, 
   l_gldq005_desc   LIKE ooefl_t.ooefl003,
   l_gldq006        LIKE gldq_t.gldq006, 
   l_gldq006_desc   LIKE oocql_t.oocql004,
   l_gldq007        LIKE gldq_t.gldq007, 
   l_gldq007_desc   LIKE pmaal_t.pmaal004,
   l_gldq008        LIKE gldq_t.gldq008, 
   l_gldq008_desc   LIKE pmaal_t.pmaal004,
   l_gldq009        LIKE gldq_t.gldq009, 
   l_gldq009_desc   LIKE oocql_t.oocql004,
   l_gldq010        LIKE gldq_t.gldq010, 
   l_gldq010_desc   LIKE rtaxl_t.rtaxl003,
   l_gldq011        LIKE gldq_t.gldq011, 
   l_gldq012        LIKE gldq_t.gldq012,
   l_gldq012_desc   LIKE oojdl_t.oojdl003,   
   l_gldq013        LIKE gldq_t.gldq013, 
   l_gldq013_desc   LIKE oocql_t.oocql004,
   l_gldq014        LIKE gldq_t.gldq014, 
   l_gldq014_desc   LIKE ooag_t.ooag011,
   l_gldq015        LIKE gldq_t.gldq015, 
   l_gldq016        LIKE gldq_t.gldq016
                     END RECORD

DEFINE g_gldp005_t LIKE gldp_t.gldp005
DEFINE g_gldp006_t LIKE gldp_t.gldp006
DEFINE g_gldp007_t LIKE gldp_t.gldp007

DEFINE g_input  RECORD
   b_gldp005   LIKE gldp_t.gldp005,
   b_gldp006   LIKE gldp_t.gldp006,
   gldp007     LIKE gldp_t.gldp006
   
  END RECORD
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master            type_g_master
DEFINE g_master_t          type_g_master
 
   
 
DEFINE g_detail            DYNAMIC ARRAY OF type_g_detail
DEFINE g_detail_t          type_g_detail
DEFINE g_detail2     DYNAMIC ARRAY OF type_g_detail2
DEFINE g_detail2_t   type_g_detail2
 
DEFINE g_detail3     DYNAMIC ARRAY OF type_g_detail3
DEFINE g_detail3_t   type_g_detail3
 
DEFINE g_detail4     DYNAMIC ARRAY OF type_g_detail4
DEFINE g_detail4_t   type_g_detail4
 
 
 
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
 
{<section id="aglq925.main" >}
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
   DECLARE aglq925_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq925_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq925_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq925 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq925_init()   
 
      #進入選單 Menu (="N")
      CALL aglq925_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq925
      
   END IF 
   
   CLOSE aglq925_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq925.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aglq925_init()
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
   LET g_master_row_move = "Y"
   
     
 
   #add-point:畫面資料初始化 name="init.init"

   
   #來源碼
   #CALL cl_set_combo_scc('gldp005','9974')  
   CALL cl_set_combo_scc_part('gldp005','9974','1,2,3,4') #160322-00040#1 
   CALL cl_set_combo_scc('b_gldp005','9974')
   
   #調整/沖銷類型
   CALL cl_set_combo_scc('gldp006','9973')
   CALL cl_set_combo_scc('b_gldp006','9973')
   
   #經營方式
   CALL cl_set_combo_scc('b_gldq011','6013')
   CALL cl_set_combo_scc('l_gldq011','6013')
   
   CALL cl_set_act_visible('sel,unsel,selall,selnone',FALSE)
   #end add-point
 
   CALL aglq925_default_search()
END FUNCTION
 
{</section>}
 
{<section id="aglq925.default_search" >}
PRIVATE FUNCTION aglq925_default_search()
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
 
{<section id="aglq925.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq925_ui_dialog() 
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
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
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
   #160322-00040#1 ---s---
   #調整/沖銷類型
   LET g_master.gldp005 = '1'
   CALL cl_set_combo_scc_part('gldp006','9973','0,M,V,U,W,8,9')
   LET g_gldp005_t = '1'
   LET g_master.gldp006 = 'M'
   LET g_gldp006_t ='M'
   LET g_input.gldp007 = 'N'
   #160322-00040#1 ---e---
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL aglq925_cs()
   END IF
 
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         INITIALIZE g_master.* TO NULL
         CALL g_detail.clear()
         CALL g_detail2.clear()
 
         CALL g_detail3.clear()
 
         CALL g_detail4.clear()
 
 
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
 
         CALL aglq925_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         #CONSTRUCT BY NAME g_wc ON gldpld, gldp001,gldp003,gldp004,gldp005,  #160322-00040#1 
         #                          gldp006,gldpdocno,gldpdocdt,gldp007       #160322-00040#1 
         CONSTRUCT BY NAME g_wc ON gldpld, gldp001,gldp003,gldp004,           #160322-00040#1   
                                   gldpdocno,gldpdocdt                        #160322-00040#1                      
                           
            BEFORE CONSTRUCT
               #160322-00040#1 ---s---
               #DISPLAY '1' TO gldp005  
               #DISPLAY 'M' TO gldp006 
               #DISPLAY 'N' TO gldp007               
               #160322-00040#1---e---
              
               
            ON ACTION controlp INFIELD gldpld
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               CALL q_authorised_ld()
               DISPLAY g_qryparam.return1 TO gldpld
               NEXT FIELD gldpld            
            
            ON ACTION controlp INFIELD gldp001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_glda001()                       
               DISPLAY g_qryparam.return1 TO gldp001  
               NEXT FIELD gldp001 

            ON ACTION controlp INFIELD gldpdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_gldpdocno()                       
               DISPLAY g_qryparam.return1 TO gldpdocno  
               NEXT FIELD gldp001 
         END CONSTRUCT 
         #160322-00040#1 ---s---
         INPUT BY NAME g_input.gldp007,g_master.gldp005,g_master.gldp006,g_input.b_gldp005,g_input.b_gldp006
            ATTRIBUTE(WITHOUT DEFAULTS)
            AFTER FIELD gldp005
               LET g_gldp005_t = g_master.gldp005
               
            AFTER FIELD gldp006
               LET g_gldp006_t = g_master.gldp006
               
            ON CHANGE gldp005
               
               CALL cl_set_combo_scc('gldp006','9973')
               CASE g_master.gldp005 
                  WHEN '1'                  
                     CALL cl_set_combo_scc_part('gldp006','9973','0,M,V,U,W,8,9')
                     LET g_master.gldp006 = 0
                  WHEN '2'
                     CALL cl_set_combo_scc_part('gldp006','9973','0,1,2,3,4,5,7')
                     LET g_master.gldp006 = 0
               END CASE        
            
               CALL cl_set_comp_entry('gldp006',TRUE)
               IF g_master.gldp005 = '3' OR g_master.gldp005 = '4' THEN
                  LET g_master.gldp006 = 0
                  DISPLAY BY NAME g_master.gldp006
                  CALL cl_set_comp_entry('gldp006',FALSE)                                   
                END IF         
         END INPUT
         #160322-00040#1 ---e---
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aglq925_detail_action_trans()
               LET g_master_idx = l_ac
               CALL aglq925_b_fill2()
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail2 TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               CALL aglq925_show_detail4()
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail3 TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 3
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body3.before_row"
               CALL aglq925_show_detail4()
               #end add-point
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail4 TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 4
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body4.before_row"
               CALL aglq925_show_detail4()
               #end add-point
 
            #自訂ACTION(detail_show,page_4)
            
 
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段define name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL aglq925_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible('sel,unsel,selall,selnone',FALSE) 
            CALL aglq925_set_no_visible()
            CALL aglq925_set_no_visible_b()
            CALL aglq925_set_visible_b()
            CALL aglq925_set_visible()
            #end add-point
            NEXT FIELD gldpld
 
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
 
            CALL aglq925_cs()
 
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
               LET g_export_node[2] = base.typeInfo.create(g_detail2)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_detail3)
               LET g_export_id[3]   = "s_detail3"
 
               LET g_export_node[4] = base.typeInfo.create(g_detail4)
               LET g_export_id[4]   = "s_detail4"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq925_fetch('F')
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
            CALL aglq925_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq925_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq925_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq925_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq925_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL aglq925_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL aglq925_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL aglq925_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL aglq925_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL aglq925_b_fill()
 
         
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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
 
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
 
{<section id="aglq925.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION aglq925_cs()
   #add-point:cs段define-客製 name="cs.define_customerization"
   
   #end add-point
   #add-point:cs段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_field STRING   #160322-00040#1        
   #end add-point
 
   #add-point:FUNCTION前置處理 name="cs.before_function"
   CALL g_browser.clear()
   #end add-point
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF g_wc2 = " 1=1" THEN
      #add-point:cs段單頭sql組成(未下單身條件) name="cs.sql_define_1"
      #160322-00040#1---s---   當來源碼為1調整時 須將合併帳套轉換至gldp002帳別
      IF g_master.gldp005 = '1' THEN
         LET l_field = 'gldp002' 
      ELSE
         LET l_field = 'gldpld' 
      END IF     
      IF g_master.gldp005 = 5 THEN
         LET g_sql = "SELECT UNIQUE gldpld,gldp001,gldp003,gldp004,gldp005, ",
                     "              gldp006,gldp008,gldp011,gldp014 ",
                     "  FROM gldp_t,gldq_t ",
                     " WHERE gldqdocno = gldpdocno AND gldqent =gldpent AND gldpent = '",g_enterprise,"' ",
                     "   AND gldqseq IS NOT NULL AND gldp007 = '",g_input.gldp007 ,"' AND " ,g_wc 
                     IF g_master.gldp006 <> '0' THEN                           
                        LET g_sql = g_sql CLIPPED," AND gldp006 ='",g_master.gldp006,"'    "
                     ELSE 
                        LET g_sql = g_sql CLIPPED, " AND gldp006 IN () "
                     END IF                   
                     LET g_sql = g_sql, " UNION ",
                      "SELECT UNIQUE gldp002,gldp001,gldp003,gldp004,gldp005, ",
                     "               gldp006,gldp008,gldp011,gldp014 ",
                     "  FROM gldp_t,gldq_t ",
                     " WHERE gldqdocno = gldpdocno AND gldqent =gldpent AND gldpent = '",g_enterprise,"' ",
                     "   AND gldqseq IS NOT NULL AND gldp007 = '",g_input.gldp007 ,"'  AND " ,g_wc 
                     IF g_master.gldp006 <> '0'  THEN   
                        LET g_sql = g_sql CLIPPED," AND gldp006 ='",g_master.gldp006,"'    "
                     ELSE 
                        LET g_sql = g_sql CLIPPED, " AND gldp006 IN () "
                     END IF                  
      ELSE
      #160322-00040#1---e---
        #LET g_sql = "SELECT UNIQUE gldpld, gldp001,gldp003,gldp004,gldp005, ",           #160322-00040#1
         LET g_sql = "SELECT UNIQUE ",l_field CLIPPED ,",gldp001,gldp003,gldp004,gldp005, ",
                      "              gldp006,gldp008,gldp011,gldp014 ",
                      "  FROM gldp_t ,gldq_t ", #160322-00040#1 add gldq_t
                      " WHERE gldqdocno = gldpdocno AND gldqent =gldpent AND gldpent = '",g_enterprise,"' ", #160322-00040#1
                      "   AND gldqseq IS NOT NULL AND gldp007 = '",g_input.gldp007 ,"'  AND " ,g_wc,      #160322-00040#1
                      "   AND gldp005 ='",g_master.gldp005,"' "     #160322-00040#1                  
                      #" ORDER BY gldpld, gldp001 "
         IF g_master.gldp006 = '0' THEN   
            CASE g_master.gldp005 
               WHEN '1' 
                  LET g_sql = g_sql CLIPPED, " AND gldp006 IN ('M','V','U','W','8','9') "
               WHEN '2'
                  LET g_sql = g_sql CLIPPED, " AND gldp006 IN ('1','2','3','4','5','7') "
            END CASE
            LET g_sql = g_sql CLIPPED," ORDER BY gldp003,gldp004   " 
            
         ELSE
            LET g_sql = g_sql CLIPPED," AND gldp006 ='",g_master.gldp006,"'    ", 
                                      " ORDER BY gldp003,gldp004               " 
         END IF
                    
      END IF         
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件) name="cs.sql_define_2"
      LET g_sql = "SELECT UNIQUE gldpld,gldp001,gldp003,gldp004,gldp005, ",
                  "              gldp006,gldp008,gldp011,gldp014 ",
                  "  FROM gldq_t,gldp_t ",
                  " WHERE gldqent = gldpent ",
                  "   AND gldqdocno = gldpdocno ",
                  "   AND ",g_wc,
                  "   AND ",g_wc2,
                  " ORDER BY gldpld, gldp001 "
      #end add-point
   END IF
 
   PREPARE aglq925_pre FROM g_sql
   DECLARE aglq925_curs SCROLL CURSOR WITH HOLD FOR aglq925_pre
   OPEN aglq925_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   LET g_cnt_sql = "SELECT COUNT(*) FROM ( ",g_sql," ) "
   #end add-point
   PREPARE aglq925_precount FROM g_cnt_sql
   EXECUTE aglq925_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL aglq925_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="aglq925.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION aglq925_fetch(p_flag)
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
 
   #end add-point
 
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   IF g_wc = " 1=2" THEN
      RETURN
   END IF

   LET g_cnt = 1
   FOREACH aglq925_curs INTO g_browser[g_cnt].gldpld, g_browser[g_cnt].gldp001,g_browser[g_cnt].gldp003,g_browser[g_cnt].gldp004,g_browser[g_cnt].gldp005,
                             g_browser[g_cnt].gldp006,g_browser[g_cnt].gldp008,g_browser[g_cnt].gldp011,g_browser[g_cnt].gldp014 
      IF cl_null(g_browser[g_cnt].gldpld) OR cl_null(g_browser[g_cnt].gldp006) THEN
         CALL g_browser.deleteElement(g_cnt)
         CONTINUE FOREACH
      END IF         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_browse THEN
         EXIT FOREACH
      END IF
   END FOREACH    
   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt  = g_browser.getLength()
   LET g_row_count = g_browser.getLength() #160322-00040#1
   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:3)
   #add-point:fetch段CURSOR移動 name="fetch.cursor_action"
   
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO b_gldpld,b_gldp001,b_gldp001_desc,b_gldp003,b_gldp004,b_gldp005,b_gldp006, 
          b_gldp008,b_gldp008_desc,b_gldp011,b_gldp011_desc,b_gldp014,b_gldp014_desc
      CALL g_detail.clear()
      CALL g_detail2.clear()
 
      CALL g_detail3.clear()
 
      CALL g_detail4.clear()
 
 
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
 
   LET g_master.gldpld  = g_browser[g_current_idx].gldpld
   
   LET g_master.gldp001 = g_browser[g_current_idx].gldp001
   LET g_master.gldp001_desc = s_desc_glda001_desc(g_master.gldp001)
   
   LET g_master.gldp003 = g_browser[g_current_idx].gldp003
   LET g_master.gldp004 = g_browser[g_current_idx].gldp004
   #160322-00040#1 ---s---
   
   #LET g_master.gldp005 = g_browser[g_current_idx].gldp005 
   #LET g_master.gldp006 = g_browser[g_current_idx].gldp006 
   LET g_gldp005_t = g_browser[g_current_idx].gldp005        
   LET g_gldp006_t = g_browser[g_current_idx].gldp006
   LET g_input.b_gldp005 = g_browser[g_current_idx].gldp005  
   LET g_input.b_gldp006 = g_browser[g_current_idx].gldp006    
   #160322-00040#1 ---e---
   
   LET g_master.gldp008 = g_browser[g_current_idx].gldp008
   LET g_master.gldp008_desc = s_desc_get_currency_desc(g_master.gldp008)
   
   LET g_master.gldp011 = g_browser[g_current_idx].gldp011
   LET g_master.gldp011_desc = s_desc_get_currency_desc(g_master.gldp011)
   
   LET g_master.gldp014 = g_browser[g_current_idx].gldp014
   LET g_master.gldp014_desc = s_desc_get_currency_desc(g_master.gldp014)
   
   CALL aglq925_set_no_visible()
   CALL aglq925_set_no_visible_b()
   CALL aglq925_set_visible_b()
   CALL aglq925_set_visible()
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL aglq925_show()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq925.show" >}
PRIVATE FUNCTION aglq925_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO b_gldpld,b_gldp001,b_gldp001_desc,b_gldp003,b_gldp004,b_gldp005,b_gldp006,b_gldp008, 
       b_gldp008_desc,b_gldp011,b_gldp011_desc,b_gldp014,b_gldp014_desc
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL aglq925_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq925.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq925_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_detail2.clear()
   CALL g_detail3.clear()
   CALL g_detail4.clear()
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:3)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql name="b_fill.sql"
   LET g_sql = "SELECT '',gldpdocno,gldpdocdt,gldp007,gldqseq,gldq001,'',gldq017,gldq018,gldq023, ",   #page1.detail1
               "          gldpdocno,gldpdocdt,gldp007,gldqseq,gldq001,'',gldq019,gldq020,gldq023, ",   #page2.detail2
               "          gldpdocno,gldpdocdt,gldp007,gldqseq,gldq001,'',gldq021,gldq022,gldq023, ",   #page3.detail3
               "          gldq003,gldq004,gldq005,gldq006,gldq007,gldq008,gldq009,gldq010,gldq011, ",  #page6.detail4
               "          gldq012,gldq013,gldq014,gldq015,gldq016 ",                                   #page6.detail4
               "  FROM gldq_t,gldp_t ",
               " WHERE gldqent = gldpent ",
               "   AND gldqdocno = gldpdocno AND gldp007 = '",g_input.gldp007 ,"'  ",
               "   AND gldqent = ? ",
              #"   AND gldpld = ?  ",  #160322-00040#1
               "   AND gldp001 = ? ",
               "   AND gldp003 = ? ",
               "   AND gldp004 = ? ",
               "   AND gldp005 = ? ",
               "   AND gldp006 =? "
               #160322-00040#1 ---s---
               CASE g_gldp005_t
                  WHEN '1' 
                     LET g_sql = g_sql CLIPPED, " AND gldp002 = '",g_master.gldpld,"' "
               OTHERWISE                  
                  LET g_sql = g_sql CLIPPED, " AND gldpld = '",g_master.gldpld,"' "
               END CASE
               #160322-00040#1 ---e---

   PREPARE aglq925_b_fill_pre FROM g_sql
   DECLARE aglq925_b_fill_cur CURSOR FOR aglq925_b_fill_pre    

   #end add-point
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   #160322-00040#1 ---s---
   #OPEN aglq925_b_fill_cur USING g_enterprise,    g_master.gldpld,g_master.gldp001,g_master.gldp003,g_master.gldp004,
                                 #g_master.gldp005,g_master.gldp006
   OPEN aglq925_b_fill_cur USING g_enterprise,g_master.gldp001,g_master.gldp003,g_master.gldp004,
                                 g_gldp005_t,g_gldp006_t
   #160322-00040#1 ---e---                              
   FOREACH aglq925_b_fill_cur INTO g_detail[l_ac].sel               ,g_detail[l_ac].gldqdocno      ,g_detail[l_ac].gldpdocdt ,g_detail[l_ac].gldp007  ,g_detail[l_ac].gldqseq ,
                                   g_detail[l_ac].gldq001           ,g_detail[l_ac].l_gldq001_desc ,g_detail[l_ac].gldq017   ,g_detail[l_ac].gldq018  ,g_detail[l_ac].gldq023 ,
                                   g_detail2[l_ac].gldqdocno        ,g_detail2[l_ac].gldpdocdt     ,g_detail2[l_ac].gldp007  ,g_detail2[l_ac].gldqseq ,g_detail2[l_ac].gldq001,
                                   g_detail2[l_ac].l_gldq001_desc_2 ,g_detail2[l_ac].gldq019       ,g_detail2[l_ac].gldq020  ,g_detail2[l_ac].gldq023 ,                        
                                   g_detail3[l_ac].gldqdocno        ,g_detail3[l_ac].gldpdocdt     ,g_detail3[l_ac].gldp007  ,g_detail3[l_ac].gldqseq ,g_detail3[l_ac].gldq001,
                                   g_detail3[l_ac].l_gldq001_desc_3 ,g_detail3[l_ac].gldq021       ,g_detail3[l_ac].gldq022  ,g_detail3[l_ac].gldq023 ,                        
                                   g_detail4[l_ac].gldq003          ,g_detail4[l_ac].gldq004       ,g_detail4[l_ac].gldq005  ,g_detail4[l_ac].gldq006 ,g_detail4[l_ac].gldq007, 
                                   g_detail4[l_ac].gldq008          ,g_detail4[l_ac].gldq009       ,g_detail4[l_ac].gldq010  ,g_detail4[l_ac].gldq011 ,g_detail4[l_ac].gldq012, 
                                   g_detail4[l_ac].gldq013          ,g_detail4[l_ac].gldq014       ,g_detail4[l_ac].gldq015  ,g_detail4[l_ac].gldq016    
      
      LET g_detail[l_ac].l_gldq001_desc    = s_desc_get_account_desc(g_master.gldpld,g_detail[l_ac].gldq001) 
      LET g_detail2[l_ac].l_gldq001_desc_2 = g_detail[l_ac].l_gldq001_desc
      LET g_detail3[l_ac].l_gldq001_desc_3 = g_detail[l_ac].l_gldq001_desc

      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
       
      LET l_ac = l_ac + 1
   END FOREACH
   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   CALL g_detail2.deleteElement(g_detail2.getLength())
   CALL g_detail3.deleteElement(g_detail3.getLength())
   CALL g_detail4.deleteElement(g_detail4.getLength())
   
   LET g_tot_cnt = g_detail.getLength()
   
   LET g_detail_idx2 = 1 
   CALL aglq925_show_detail4() 
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq925_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq925_detail_action_trans()
 
   CALL aglq925_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aglq925.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq925_b_fill2()
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
 
{<section id="aglq925.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq925_detail_show(ps_page)
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
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      
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
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq925.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION aglq925_maintain_prog()
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
 
{<section id="aglq925.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq925_detail_action_trans()
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
 
{<section id="aglq925.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq925_detail_index_setting()
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
 
{<section id="aglq925.mask_functions" >}
 &include "erp/agl/aglq925_mask.4gl"
 
{</section>}
 
{<section id="aglq925.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 顯示固定核算項
# Memo...........:
# Usage..........: CALL aglq925_show_detail4()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 151126 By lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq925_show_detail4()
   IF cl_null(g_detail_idx2) THEN
      RETURN
   END IF
   
   LET g_detail_show.l_gldq003      = g_detail4[g_detail_idx2].gldq003         
  # LET g_detail_show.l_gldq003_desc = s_desc_get_account_desc(g_master.gldpld,g_detail_show.l_gldq003)   #160322-00040#1
   LET g_detail_show.l_gldq003_desc = s_desc_get_department_desc(g_detail_show.l_gldq003)                 #160322-00040#1
     
   LET g_detail_show.l_gldq004      = g_detail4[g_detail_idx2].gldq004         
   LET g_detail_show.l_gldq004_desc = s_desc_get_department_desc(g_detail_show.l_gldq004)  
   
   LET g_detail_show.l_gldq005      = g_detail4[g_detail_idx2].gldq005         
   LET g_detail_show.l_gldq005_desc = s_desc_get_department_desc(g_detail_show.l_gldq005) 
   
   LET g_detail_show.l_gldq006      = g_detail4[g_detail_idx2].gldq006         
   LET g_detail_show.l_gldq006_desc = s_desc_get_acc_desc('287',g_detail_show.l_gldq006)
   
   LET g_detail_show.l_gldq007      = g_detail4[g_detail_idx2].gldq007         
   LET g_detail_show.l_gldq007_desc = s_desc_get_trading_partner_abbr_desc(g_detail_show.l_gldq007)
   
   LET g_detail_show.l_gldq008      = g_detail4[g_detail_idx2].gldq008         
   LET g_detail_show.l_gldq008_desc = s_desc_get_trading_partner_abbr_desc(g_detail_show.l_gldq008)
   
   LET g_detail_show.l_gldq009      = g_detail4[g_detail_idx2].gldq009         
   LET g_detail_show.l_gldq009_desc = s_desc_get_acc_desc('281',g_detail_show.l_gldq009)
   
   LET g_detail_show.l_gldq010      = g_detail4[g_detail_idx2].gldq010         
   LET g_detail_show.l_gldq010_desc = s_desc_get_rtaxl003_desc(g_detail_show.l_gldq010)
   
   LET g_detail_show.l_gldq011      = g_detail4[g_detail_idx2].gldq011 
   
   LET g_detail_show.l_gldq012      = g_detail4[g_detail_idx2].gldq012         
   LET g_detail_show.l_gldq012_desc = s_desc_get_oojdl003_desc(g_detail_show.l_gldq012)
   
   LET g_detail_show.l_gldq013      = g_detail4[g_detail_idx2].gldq013         
   LET g_detail_show.l_gldq013_desc = s_desc_get_acc_desc('2002',g_detail_show.l_gldq013)
   
   LET g_detail_show.l_gldq014      = g_detail4[g_detail_idx2].gldq014         
   LET g_detail_show.l_gldq014_desc = s_desc_get_person_desc(g_detail_show.l_gldq014)
   
   LET g_detail_show.l_gldq015      = g_detail4[g_detail_idx2].gldq015         
   LET g_detail_show.l_gldq016      = g_detail4[g_detail_idx2].gldq016  
   
   DISPLAY BY NAME g_detail_show.l_gldq003     ,g_detail_show.l_gldq003_desc, 
                   g_detail_show.l_gldq004     ,g_detail_show.l_gldq004_desc, 
                   g_detail_show.l_gldq005     ,g_detail_show.l_gldq005_desc, 
                   g_detail_show.l_gldq006     ,g_detail_show.l_gldq006_desc, 
                   g_detail_show.l_gldq007     ,g_detail_show.l_gldq007_desc, 
                   g_detail_show.l_gldq008     ,g_detail_show.l_gldq008_desc, 
                   g_detail_show.l_gldq009     ,g_detail_show.l_gldq009_desc, 
                   g_detail_show.l_gldq010     ,g_detail_show.l_gldq010_desc, 
                   g_detail_show.l_gldq011     , 
                   g_detail_show.l_gldq012     ,g_detail_show.l_gldq012_desc, 
                   g_detail_show.l_gldq013     ,g_detail_show.l_gldq013_desc, 
                   g_detail_show.l_gldq014     ,g_detail_show.l_gldq014_desc, 
                   g_detail_show.l_gldq015     , 
                   g_detail_show.l_gldq016     
END FUNCTION

################################################################################
# Descriptions...: 單頭欄位隱藏設定
# Memo...........:
# Usage..........: CALL aglq925_set_visible()
# Input parameter: 
# Return code....: 
# Date & Author..: 151126 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq925_set_visible()
   IF cl_null(g_master.gldp011) THEN
      CALL cl_set_comp_visible('lbl_b_gldp011,b_gldp011,b_gldp011_desc',FALSE)
   END IF
   
   IF cl_null(g_master.gldp014) THEN
      CALL cl_set_comp_visible('lbl_b_gldp014,b_gldp014,b_gldp014_desc',FALSE)
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 單頭欄位顯示設定
# Memo...........:
# Usage..........: CALL aglq925_set_no_visible()
# Input parameter: 
# Return code....: 
# Date & Author..: 151126 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq925_set_no_visible()
   CALL cl_set_comp_visible('lbl_b_gldp011,b_gldp011,b_gldp011_desc',TRUE)
   CALL cl_set_comp_visible('lbl_b_gldp014,b_gldp014,b_gldp014_desc',TRUE)
END FUNCTION

################################################################################
# Descriptions...: 單身欄位隱藏設定
# Memo...........:
# Usage..........: CALL aglq925_set_visible_b()
# Input parameter: 
# Return code....: 
# Date & Author..: 151126 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq925_set_visible_b()
   IF cl_null(g_master.gldp011) THEN
      CALL cl_set_comp_visible('page_3',FALSE)
   END IF
   
   IF cl_null(g_master.gldp014) THEN
      CALL cl_set_comp_visible('page_4',FALSE)
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 單身欄位顯示設定
# Memo...........:
# Usage..........: CALL aglq925_set_no_visible_b()
# Input parameter: 
# Return code....: 
# Date & Author..: 151126 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq925_set_no_visible_b()
   CALL cl_set_comp_visible('page_3',TRUE)
   CALL cl_set_comp_visible('page_4',TRUE)
END FUNCTION

 
{</section>}
 
