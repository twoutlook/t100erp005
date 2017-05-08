#該程式已解開Section, 不再透過樣板產出!
{<section id="axcq571.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-11-24 14:38:18), PR版次:0005(2017-03-02 16:10:38)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: axcq571
#+ Description: 製程在製元件成本查詢
#+ Creator....: 01534(2016-11-24 14:38:18)
#+ Modifier...: 01534 -SD/PR- 01534
 
{</section>}
 
{<section id="axcq571.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"
#170111-00019#1   2017/01/11  By lixh   增加差異轉出(xcha310)顯示
#161121-00018#1   2017/01/17  By lixh   增加差異轉出(xcha310)顯示(同#170111-00019#1),方便追单
#170302-00034#1   2017/03/02  By lixh   axcq502串查传参有误
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
       xchacomp LIKE xcha_t.xchacomp, 
   xchacomp_desc LIKE type_t.chr80, 
   xchald LIKE xcha_t.xchald, 
   xchald_desc LIKE type_t.chr80, 
   xcha003 LIKE xcha_t.xcha003, 
   xcha003_desc LIKE type_t.chr80, 
   xcha004 LIKE xcha_t.xcha004, 
   xcha005 LIKE xcha_t.xcha005, 
   xcha006 LIKE xcha_t.xcha006, 
   xcha009 LIKE xcha_t.xcha009, 
   xcha009_desc LIKE type_t.chr80, 
   xcha009_desc_1 LIKE type_t.chr80, 
   xcha007 LIKE xcha_t.xcha007, 
   xcha007_desc LIKE type_t.chr80, 
   xcha008 LIKE xcha_t.xcha008, 
   xcha010 LIKE xcha_t.xcha010, 
   imag014 LIKE type_t.chr10, 
   imag014_desc LIKE type_t.chr80, 
   xcha012 LIKE xcha_t.xcha012, 
   xcha012_desc LIKE type_t.chr80, 
   xcha011 LIKE xcha_t.xcha011, 
   xcha002 LIKE xcha_t.xcha002, 
   xcha002_desc LIKE type_t.chr80, 
   sfaa048 LIKE type_t.dat, 
   xcbb006 LIKE type_t.num5
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       item LIKE type_t.chr100, 
   xcha001 LIKE xcha_t.xcha001, 
   xcha102 LIKE xcha_t.xcha102, 
   xcha204 LIKE xcha_t.xcha204, 
   xcha202 LIKE xcha_t.xcha202, 
   xcha304 LIKE xcha_t.xcha304, 
   xcha306 LIKE xcha_t.xcha306, 
   xcha308 LIKE xcha_t.xcha308, 
   xcha302 LIKE xcha_t.xcha302, 
   xcha310 LIKE xcha_t.xcha310,  #170111-00019#1 #161121-00018#1
   xcha902 LIKE xcha_t.xcha902
       END RECORD
PRIVATE TYPE type_g_detail2 RECORD
       item2 LIKE type_t.chr100, 
   xchb102 LIKE xchb_t.xchb102, 
   xchb204 LIKE xchb_t.xchb204, 
   xchb202 LIKE xchb_t.xchb202, 
   xchb208 LIKE xchb_t.xchb208, 
   xchb306 LIKE xchb_t.xchb306, 
   xchb210 LIKE xchb_t.xchb210, 
   xchb302 LIKE xchb_t.xchb302, 
   xchb304 LIKE xchb_t.xchb304, 
   xchb308 LIKE xchb_t.xchb308, 
   xchb310 LIKE xchb_t.xchb310, 
   xchb902 LIKE xchb_t.xchb902
       END RECORD
 
PRIVATE TYPE type_g_detail3 RECORD
       item3 LIKE type_t.chr100, 
   xcha001 LIKE xcha_t.xcha001, 
   xcha102a LIKE type_t.chr500, 
   xcha204a LIKE type_t.chr500, 
   xcha202a LIKE type_t.chr500, 
   xcha304a LIKE type_t.chr500, 
   xcha306a LIKE type_t.chr500, 
   xcha308a LIKE type_t.chr500, 
   xcha302a LIKE type_t.chr500, 
   xcha310a LIKE type_t.chr500, #170111-00019#1 #161121-00018#1
   xcha902a LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_detail4 RECORD
       item4 LIKE type_t.chr100, 
   xchb102a LIKE type_t.chr500, 
   xchb204a LIKE type_t.chr500, 
   xchb202a LIKE type_t.chr500, 
   xchb208a LIKE type_t.chr500, 
   xchb306a LIKE type_t.chr500, 
   xchb210a LIKE type_t.chr500, 
   xchb302a LIKE type_t.chr500, 
   xchb304a LIKE type_t.chr500, 
   xchb308a LIKE type_t.chr500, 
   xchb310a LIKE type_t.chr500, 
   xchb902a LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_detail5 RECORD
       item5 LIKE type_t.chr100, 
   xcha001 LIKE xcha_t.xcha001, 
   xcha102b LIKE type_t.chr500, 
   xcha204b LIKE type_t.chr500, 
   xcha202b LIKE type_t.chr500, 
   xcha304b LIKE type_t.chr500, 
   xcha306b LIKE type_t.chr500, 
   xcha308b LIKE type_t.chr500, 
   xcha302b LIKE type_t.chr500, 
   xcha310b LIKE type_t.chr500, #170111-00019#1  #161121-00018#1
   xcha902b LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_detail6 RECORD
       item6 LIKE type_t.chr100, 
   xchb102b LIKE type_t.chr500, 
   xchb204b LIKE type_t.chr500, 
   xchb202b LIKE type_t.chr500, 
   xchb208b LIKE type_t.chr500, 
   xchb306b LIKE type_t.chr500, 
   xchb210b LIKE type_t.chr500, 
   xchb302b LIKE type_t.chr500, 
   xchb304b LIKE type_t.chr500, 
   xchb308b LIKE type_t.chr500, 
   xchb310b LIKE type_t.chr500, 
   xchb902b LIKE type_t.chr500
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc3                 STRING
DEFINE g_wc_cs_ld            STRING                
DEFINE g_wc_cs_comp          STRING 
DEFINE g_para_data           LIKE type_t.chr80     #采用成本域否  
DEFINE g_para_data1          LIKE type_t.chr80     #采用特性否  
PRIVATE TYPE type_browser RECORD
         xchacomp LIKE xcha_t.xchacomp,  
         xchald   LIKE xcha_t.xchald, 
         xcha002  LIKE xcha_t.xcha002,
         xcha003  LIKE xcha_t.xcha003,
         xcha004  LIKE xcha_t.xcha004,
         xcha005  LIKE xcha_t.xcha005,
         xcha006  LIKE xcha_t.xcha006,
         xcha007  LIKE xcha_t.xcha007,
         xcha008  LIKE xcha_t.xcha008,
         xchb009  LIKE xchb_t.xchb009,
         xchb010  LIKE xchb_t.xchb010,
         xchb011  LIKE xchb_t.xchb011,
         xchb014  LIKE xchb_t.xchb014,
         xchb015  LIKE xchb_t.xchb015
       END RECORD
PRIVATE type type_g_xchb_m        RECORD
         xchb009            LIKE xchb_t.xchb009,
         xchb009_desc       LIKE type_t.chr80,
         xchb009_desc_1     LIKE type_t.chr80,
         xchb010            LIKE xchb_t.xchb010,
         imag014_2          LIKE imag_t.imag012,
         imag014_2_desc     LIKE type_t.chr80,
         xcbb006_2          LIKE xcbb_t.xcbb006,
         xchb011            LIKE xchb_t.xchb011,
         xchb002            LIKE xchb_t.xchb002,
         xchb014            LIKE xchb_t.xchb014,
         xchb014_desc       LIKE type_t.chr80,
         xchb015            LIKE xchb_t.xchb015                  
       END RECORD
       
PRIVATE type type_g_xchb_m2        RECORD
         xchb009_2            LIKE xchb_t.xchb009,
         xchb009_2_desc       LIKE type_t.chr80,
         xchb009_2_desc_1     LIKE type_t.chr80,
         xchb010_2            LIKE xchb_t.xchb010,
         imag014_3            LIKE imag_t.imag012,
         imag014_3_desc       LIKE type_t.chr80,
         xcbb006_3            LIKE xcbb_t.xcbb006,
         xchb011_2            LIKE xchb_t.xchb011,
         xchb002_2            LIKE xchb_t.xchb002, 
         xchb014_2            LIKE xchb_t.xchb014,
         xchb014_2_desc       LIKE type_t.chr80,
         xchb015_2            LIKE xchb_t.xchb015          
       END RECORD
PRIVATE type type_g_xchb_m3        RECORD
         xchb009_3            LIKE xchb_t.xchb009,
         xchb009_3_desc       LIKE type_t.chr80,
         xchb009_3_desc_1     LIKE type_t.chr80,
         xchb010_3            LIKE xchb_t.xchb010,
         imag014_4            LIKE imag_t.imag012,
         imag014_4_desc       LIKE type_t.chr80,
         xcbb006_4            LIKE xcbb_t.xcbb006,
         xchb011_3            LIKE xchb_t.xchb011,
         xchb002_3            LIKE xchb_t.xchb002,
         xchb014_3            LIKE xchb_t.xchb014,
         xchb014_3_desc       LIKE type_t.chr80,
         xchb015_3            LIKE xchb_t.xchb015          
       END RECORD       
DEFINE g_browser    DYNAMIC ARRAY OF type_browser  
DEFINE g_xchb_m     type_g_xchb_m
DEFINE g_xchb_m2    type_g_xchb_m2
DEFINE g_xchb_m3    type_g_xchb_m3
DEFINE g_glaa015    LIKE glaa_t.glaa015
DEFINE g_glaa019    LIKE glaa_t.glaa019
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
 
DEFINE g_detail5     DYNAMIC ARRAY OF type_g_detail5
DEFINE g_detail5_t   type_g_detail5
 
DEFINE g_detail6     DYNAMIC ARRAY OF type_g_detail6
DEFINE g_detail6_t   type_g_detail6
 
 
 
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
 
{<section id="axcq571.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld   
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp 
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
   DECLARE axcq571_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   LET g_sql = " SELECT DISTINCT t0.xchacomp,t0.xchald,t0.xcha003,t0.xcha004,t0.xcha005,t0.xcha006,t0.xcha009, 
       t0.xcha007,t0.xcha008,t0.xcha010,t0.xcha012,t0.xcha011,t0.xcha002,t1.ooefl003 ,t2.glaal002 ,t3.xcatl003 , 
       t4.imaal003 ,t5.oocql004 ,t7.pjabl003 ,t8.xcbfl003",
               " FROM xcha_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xchacomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.xchald AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t3 ON t3.xcatlent="||g_enterprise||" AND t3.xcatl001=t0.xcha003 AND t3.xcatl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=t0.xcha009 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='221' AND t5.oocql002=t0.xcha007 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pjabl_t t7 ON t7.pjablent="||g_enterprise||" AND t7.pjabl001=t0.xcha012 AND t7.pjabl002='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t8 ON t8.xcbflent="||g_enterprise||" AND t8.xcbflcomp=t0.xchacomp AND t8.xcbfl001=t0.xcha002 AND t8.xcbfl002='"||g_dlang||"' ",
 
               " WHERE t0.xchaent = " ||g_enterprise|| " AND t0.xchald = ? AND t0.xcha002 = ? AND t0.xcha003 = ? AND t0.xcha004 = ? AND t0.xcha005 = ? AND t0.xcha006 = ? AND t0.xcha007 = ? AND t0.xcha008 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #end add-point
   PREPARE axcq571_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq571_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq571 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq571_init()   
 
      #進入選單 Menu (="N")
      CALL axcq571_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq571
      
   END IF 
   
   CLOSE axcq571_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq571.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq571_init()
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
   CALL cl_set_act_visible("qbehidden",FALSE) 
   #end add-point
 
   CALL axcq571_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axcq571.default_search" >}
PRIVATE FUNCTION axcq571_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   IF NOT cl_null(g_argv[01]) AND cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"

   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF 
   
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc," AND xchacomp = '",g_argv[01],"'"      
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc," AND xchald = '",g_argv[02],"'"      
   END IF  
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc," AND xcha002 = '",g_argv[03],"'"      
   END IF   
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc," AND xcha003 = '",g_argv[04],"'"      
   END IF 
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc," AND xcha004 = '",g_argv[05],"'"      
   END IF   
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc," AND xcha005 = '",g_argv[06],"'"      
   END IF   
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc," AND xcha006 = '",g_argv[07],"'"      
   END IF      
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc," AND xcha007 = '",g_argv[08],"'"      
   END IF      
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc," AND xcha008 = '",g_argv[09],"'"      
   END IF      
  LET g_wc3 = g_wc   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq571.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq571_ui_dialog() 
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
   DEFINE l_wc                    STRING
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

   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL axcq571_cs()
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
 
         CALL g_detail5.clear()
 
         CALL g_detail6.clear()
 
 
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
 
         CALL axcq571_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"

         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
#         CONSTRUCT g_wc3 ON xchacomp,xchald,xcha003,xcha004,xcha005,xcha006,xcha009,xcha007,xcha008, 
#                            xcha010,xcha012,xcha011,xcha002
#                       FROM b_xchacomp,b_xchald,b_xcha003,b_xcha004,b_xcha005,b_xcha006,b_xcha009,b_xcha007,b_xcha008, 
#                            b_xcha010,b_xcha012,b_xcha011,b_xcha002
#                            
#            BEFORE CONSTRUCT 
#            
#            ON ACTION controlp INFIELD b_xchacomp
#               #add-point:ON ACTION controlp INFIELD xchacomp name="construct.c.xchacomp"
#               #應用 a08 樣板自動產生(Version:3)
#               #開窗c段
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c' 
#               LET g_qryparam.reqry = FALSE
#               #增加法人過濾條件
#               IF NOT cl_null(g_wc_cs_comp) THEN
#                  LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
#               END IF            
#               CALL q_ooef001_2()                           #呼叫開窗
#               DISPLAY g_qryparam.return1 TO b_xchacomp   #顯示到畫面上
#               NEXT FIELD b_xchacomp                    #返回原欄位                           
#                        
#            ON ACTION controlp INFIELD b_xchald
#               #add-point:ON ACTION controlp INFIELD xchald name="construct.c.xchald"
#               #應用 a08 樣板自動產生(Version:3)
#               #開窗c段
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c' 
#               LET g_qryparam.reqry = FALSE
#               LET g_qryparam.arg1 = g_user
#               LET g_qryparam.arg2 = g_dept 
#               IF NOT cl_null(g_wc_cs_ld) THEN
#                  LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
#               END IF            
#               CALL q_authorised_ld()                           #呼叫開窗
#               DISPLAY g_qryparam.return1 TO b_xchald  #顯示到畫面上
#               NEXT FIELD b_xchald                     #返回原欄位
#               
#            ON ACTION controlp INFIELD b_xcha003
#               #add-point:ON ACTION controlp INFIELD xcha003 name="construct.c.xcha003"
#               #應用 a08 樣板自動產生(Version:3)
#               #開窗c段
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c' 
#               LET g_qryparam.reqry = FALSE
#               CALL q_xcat001()                           #呼叫開窗
#               DISPLAY g_qryparam.return1 TO b_xcha003  #顯示到畫面上
#               NEXT FIELD b_xcha003                      
#         
#            ON ACTION controlp INFIELD b_xcha006
#               #add-point:ON ACTION controlp INFIELD xcha006 name="construct.c.xcha006"
#               #應用 a08 樣板自動產生(Version:3)
#               #開窗c段
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c' 
#               LET g_qryparam.reqry = FALSE
#               LET g_qryparam.arg1 = 'F'
#               LET g_qryparam.where = " sfaa061 = 'Y' "
#               CALL q_sfaadocno_1()                           #呼叫開窗
#               DISPLAY g_qryparam.return1 TO b_xcha006  #顯示到畫面上
#               NEXT FIELD b_xcha006     
#               
#            ON ACTION controlp INFIELD b_xcha009
#               #add-point:ON ACTION controlp INFIELD xcha009 name="construct.c.xcha009"
#               #應用 a08 樣板自動產生(Version:3)
#               #開窗c段
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c' 
#               LET g_qryparam.reqry = FALSE
#               CALL q_imaf001()                           #呼叫開窗
#               DISPLAY g_qryparam.return1 TO b_xcha009  #顯示到畫面上
#               NEXT FIELD b_xcha009                     #返回原欄位
#         
#            ON ACTION controlp INFIELD b_xcha007
#               #add-point:ON ACTION controlp INFIELD xcha007 name="construct.c.xcha007"
#               #應用 a08 樣板自動產生(Version:3)
#               #開窗c段
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c' 
#               LET g_qryparam.reqry = FALSE
#               LET g_qryparam.arg1 = '221'
#               CALL q_oocq002()                           #呼叫開窗
#               DISPLAY g_qryparam.return1 TO b_xcha007  #顯示到畫面上
#               NEXT FIELD b_xcha007      
#               
#            ON ACTION controlp INFIELD b_xcha010
#               #add-point:ON ACTION controlp INFIELD xcha010 name="construct.c.xcha010"
#               #應用 a08 樣板自動產生(Version:3)
#               #開窗c段
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c' 
#               LET g_qryparam.reqry = FALSE
#               CALL q_inam002_2()                           #呼叫開窗
#               DISPLAY g_qryparam.return1 TO b_xcha010  #顯示到畫面上
#               NEXT FIELD b_xcha010                     #返回原欄位
#               
#            ON ACTION controlp INFIELD b_xcha012
#               #add-point:ON ACTION controlp INFIELD xcha012 name="construct.c.xcha012"
#               #應用 a08 樣板自動產生(Version:3)
#               #開窗c段
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c' 
#               LET g_qryparam.reqry = FALSE
#               CALL q_pjba001()                           #呼叫開窗
#               DISPLAY g_qryparam.return1 TO b_xcha012  #顯示到畫面上
#               NEXT FIELD b_xcha012                     #返回原欄位   
#         
#            ON ACTION controlp INFIELD b_xcha002
#               #add-point:ON ACTION controlp INFIELD xcha002 name="construct.c.xcha002"
#               #應用 a08 樣板自動產生(Version:3)
#               #開窗c段
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c' 
#               LET g_qryparam.reqry = FALSE
#               CALL q_xcbf001()                           #呼叫開窗
#               DISPLAY g_qryparam.return1 TO b_xcha002  #顯示到畫面上
#               NEXT FIELD b_xcha002                     #返回原欄位
#               
#         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq571_detail_action_trans()
               LET g_master_idx = l_ac
               CALL axcq571_b_fill2()
 
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

               #end add-point
 
            #自訂ACTION(detail_show,page_4)
            
 
            #add-point:page4自定義行為 name="ui_dialog.body4.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail5 TO s_detail5.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 5
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body5.before_row"

               #end add-point
 
            #自訂ACTION(detail_show,page_5)
            
 
            #add-point:page5自定義行為 name="ui_dialog.body5.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail6 TO s_detail6.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 6
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail6")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body6.before_row"

               #end add-point
 
            #自訂ACTION(detail_show,page_6)
            
 
            #add-point:page6自定義行為 name="ui_dialog.body6.action"

            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段define name="ui_dialog.more_displayarray"

         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL axcq571_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("qbehidden",FALSE)
            
#            CALL s_axc_set_site_default() RETURNING g_master.xchacomp,g_master.xchald,g_master.xcha004,g_master.xcha005,g_master.xcha003
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_master.xchacomp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_master.xchacomp_desc = '', g_rtn_fields[1] , ''
#            #根據參數顯示隱藏成本域 和 料件特性
#            IF cl_null(g_master.xchacomp) THEN
#               CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
#               CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否       
#            ELSE
#               CALL cl_get_para(g_enterprise,g_master.xchacomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
#               CALL cl_get_para(g_enterprise,g_master.xchacomp,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否       
#            END IF
#                       
#            IF g_para_data = 'Y' THEN
#               CALL cl_set_comp_visible('xcha002,xcha002_desc',TRUE)                    
#            ELSE
#               CALL cl_set_comp_visible('xcha002,xcha002_desc',FALSE)                
#            END IF         
#        
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_master.xchald
#            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_master.xchald_desc = '', g_rtn_fields[1] , ''
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_master.xcha003
#            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_master.xcha003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY g_master.* TO b_xchacomp,b_xchacomp_desc,b_xchald,b_xchald_desc,b_xcha003,b_xcha003_desc, 
#                b_xcha004,b_xcha005,b_xcha006,b_xcha009,b_xcha009_desc,b_xcha009_desc_1,b_xcha007,b_xcha007_desc, 
#                b_xcha008,b_xcha010,imag014,imag014_desc,b_xcha012,b_xcha012_desc,b_xcha011,b_xcha002,b_xcha002_desc, 
#                sfaa048,xcbb006         
         
            #NEXT FIELD b_xchacomp

            #end add-point
            #NEXT FIELD xchacomp
 
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
 
            CALL axcq571_cs()
 
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
 
               LET g_export_node[5] = base.typeInfo.create(g_detail5)
               LET g_export_id[5]   = "s_detail5"
 
               LET g_export_node[6] = base.typeInfo.create(g_detail6)
               LET g_export_id[6]   = "s_detail6"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"

               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq571_fetch('F')
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
            CALL axcq571_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq571_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq571_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq571_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq571_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq571_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL axcq571_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL axcq571_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL axcq571_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL axcq571_b_fill()
 
         
         
         
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
               LET l_wc = " xchacomp = '",g_master.xchacomp,"' AND xchald = '",g_master.xchald,"' AND xchaent = ",g_enterprise,
                          " AND xcha002 = '",g_master.xcha002,"' AND xcha003 = '",g_master.xcha003,"' AND xcha004 = '",g_master.xcha004,"' ",
                          " AND xcha005 = '",g_master.xcha005,"' AND xcha006 = '",g_master.xcha006,"' AND xcha007 = '",g_master.xcha007,"' ",
                          " AND xcha008 = '",g_master.xcha008,"' "
               CALL axcr571_x01(l_wc,'Y')
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET l_wc = " xchacomp = '",g_master.xchacomp,"' AND xchald = '",g_master.xchald,"' AND xchaent = ",g_enterprise,
                          " AND xcha002 = '",g_master.xcha002,"' AND xcha003 = '",g_master.xcha003,"' AND xcha004 = '",g_master.xcha004,"' ",
                          " AND xcha005 = '",g_master.xcha005,"' AND xcha006 = '",g_master.xcha006,"' AND xcha007 = '",g_master.xcha007,"' ",
                          " AND xcha008 = '",g_master.xcha008,"' "
               CALL axcr571_x01(l_wc,'Y')
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_axcq500_02
            LET g_action_choice="prog_axcq500_02"
            IF cl_auth_chk_act("prog_axcq500_02") THEN
               
               #add-point:ON ACTION prog_axcq500_02 name="menu.prog_axcq500_02"
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'axcq500'
               LET la_param.param[1] = g_master.xchacomp
               LET la_param.param[2] = g_master.xchald
               LET la_param.param[3] = g_master.xcha002
               LET la_param.param[4] = g_master.xcha003
               LET la_param.param[5] = g_master.xcha004
               LET la_param.param[6] = g_master.xcha005
               LET la_param.param[7] = g_xchb_m.xchb009
               IF g_xchb_m.xchb010 IS NULL THEN LET g_xchb_m.xchb010 = ' ' END IF
               LET la_param.param[8] = g_xchb_m.xchb010   
               LET la_param.param[9] = g_xchb_m.xchb011
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js) 
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               CALL axcq571_query()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_axcq501
            LET g_action_choice="prog_axcq501"
            IF cl_auth_chk_act("prog_axcq501") THEN
               
               #add-point:ON ACTION prog_axcq501 name="menu.prog_axcq501"
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'axcq501'
               LET la_param.param[1] = g_master.xchacomp
               LET la_param.param[2] = g_master.xchald
               LET la_param.param[3] = g_master.xcha003
               LET la_param.param[4] = g_master.xcha004
               LET la_param.param[5] = g_master.xcha005
               LET la_param.param[6] = g_master.xcha009
               LET la_param.param[7] = g_master.xcha010
               LET la_param.param[8] = g_master.xcha002               
               LET la_param.param[9] = g_master.xcha006
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js) 
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_axcq500_01
            LET g_action_choice="prog_axcq500_01"
            IF cl_auth_chk_act("prog_axcq500_01") THEN
               
               #add-point:ON ACTION prog_axcq500_01 name="menu.prog_axcq500_01"
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'axcq500'
               LET la_param.param[1] = g_master.xchacomp
               LET la_param.param[2] = g_master.xchald
               LET la_param.param[3] = g_master.xcha002
               LET la_param.param[4] = g_master.xcha003
               LET la_param.param[5] = g_master.xcha004
               LET la_param.param[6] = g_master.xcha005
               LET la_param.param[7] = g_master.xcha009
               IF g_master.xcha010 IS NULL THEN LET g_master.xcha010 = ' ' END IF   
               LET la_param.param[8] = g_master.xcha010   
               LET la_param.param[9] = g_master.xcha011                 
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js) 
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_axcq502
            LET g_action_choice="prog_axcq502"
            IF cl_auth_chk_act("prog_axcq502") THEN
               
               #add-point:ON ACTION prog_axcq502 name="menu.prog_axcq502"
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'axcq502'
               LET la_param.param[1] = g_master.xchacomp
               LET la_param.param[2] = g_master.xchald
               LET la_param.param[3] = g_master.xcha003
               LET la_param.param[4] = g_master.xcha004
               LET la_param.param[5] = g_master.xcha005
               LET la_param.param[6] = g_master.xcha006
               LET la_param.param[7] = g_master.xcha002
               LET la_param.param[8] = g_xchb_m.xchb009 
               IF g_xchb_m.xchb010 IS NULL THEN LET g_xchb_m.xchb010 = ' ' END IF
               #LET la_param.param[8] = g_xchb_m.xchb010     #170302-00034#1
               LET la_param.param[9] = g_xchb_m.xchb010      #170302-00034#1            
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js) 
               #END add-point
               
               
            END IF
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
#         ON ACTION accept
#           ACCEPT DIALOG
#      
#         ON ACTION cancel
#            LET INT_FLAG = 1
#            EXIT DIALOG
       
#         #交談指令共用ACTION
#         &include "common_action.4gl"
#            CONTINUE DIALOG
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
 
{<section id="axcq571.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION axcq571_cs()
   #add-point:cs段define-客製 name="cs.define_customerization"
   
   #end add-point
   #add-point:cs段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_sub_sql    STRING
   DEFINE g_cnt_sql2   STRING
   #end add-point
 
   #add-point:FUNCTION前置處理 name="cs.before_function"
   
   #end add-point
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF g_wc2 = " 1=1" THEN
      #add-point:cs段單頭sql組成(未下單身條件) name="cs.sql_define_1"
 
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件) name="cs.sql_define_2"
      
      #end add-point
   END IF
 
   PREPARE axcq571_pre FROM g_sql
   DECLARE axcq571_curs SCROLL CURSOR WITH HOLD FOR axcq571_pre
   OPEN axcq571_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   IF cl_null(g_wc3) THEN LET g_wc3 = " 1=1" END IF
   LET g_sql = " SELECT DISTINCT xchacomp,xchald,xcha002,xcha003,xcha004,xcha005,xcha006,xcha007,xcha008, ",
               "                 xchb009,xchb010,xchb011,xchb014,xchb015,xcbt008 ",   
               "   FROM xcha_t INNER JOIN xchb_t ON xchaent = xchbent AND xchald = xchbld AND xcha001 = xchb001  ",               
               "    AND xcha002 = xchb002 AND xcha003 = xchb003 AND xcha004 = xchb004 AND xcha005 = xchb005 ",
               "    AND xcha006 = xchb006 AND xcha007 = xchb007 AND xcha008 = xchb008 ",
               "   LEFT OUTER JOIN xcbt_t ON xcbtent = xchaent AND xcbtcomp = xchacomp AND xcbt001 = xcha004 ",
               "    AND xcbt002 = xcha005 AND xcbt003 = xcha006 AND xcbt004 = xcha007 AND xcbt005 = xcha008 ",               
               "  WHERE xchaent = " ||g_enterprise|| " AND ",g_wc3,
               "  ORDER BY xchald,xcha002,xcha003,xcha004,xcha005,xcha006,xcbt008"
               
   LET g_sql = cl_sql_add_mask(g_sql)    
   PREPARE axcq571_pre2 FROM g_sql
   DECLARE axcq571_curs2 CURSOR WITH HOLD FOR axcq571_pre2  
   
   LET l_sub_sql = " SELECT DISTINCT xchald,xcha002,xcha003,xcha004,xcha005,xcha006,xcha007,xcha008, ",
                   "                  xchb009,xchb010,xchb011,xchb014,xchb015 ",  
                   "   FROM xcha_t INNER JOIN xchb_t ON xchaent = xchbent AND xchald = xchbld AND xcha001 = xchb001  ",
                   "    AND xcha002 = xchb002 AND xcha003 = xchb003 AND xcha004 = xchb004 AND xcha005 = xchb005 ",
                   "    AND xcha006 = xchb006 AND xcha007 = xchb007 AND xcha008 = xchb008 ",   
                   "   WHERE xchaent = '",g_enterprise,"'",
                   "     AND ",g_wc3
                   
   LET g_cnt_sql2 = " SELECT COUNT(1) FROM (",l_sub_sql,")"     
   PREPARE axcq571_precount2 FROM g_cnt_sql2
   EXECUTE axcq571_precount2 INTO g_row_count  
   LET g_cnt = 1
   FOREACH axcq571_curs2 INTO g_browser[g_cnt].xchacomp,g_browser[g_cnt].xchald,g_browser[g_cnt].xcha002,g_browser[g_cnt].xcha003,g_browser[g_cnt].xcha004,g_browser[g_cnt].xcha005,
                              g_browser[g_cnt].xcha006,g_browser[g_cnt].xcha007,g_browser[g_cnt].xcha008,g_browser[g_cnt].xchb009,g_browser[g_cnt].xchb010,g_browser[g_cnt].xchb011,
                              g_browser[g_cnt].xchb014,g_browser[g_cnt].xchb015
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF                              
      LET g_cnt = g_cnt + 1
   END FOREACH 
   IF cl_null(g_browser[g_cnt].xchald) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_row_count = g_browser.getLength() 
   CALL axcq571_fetch("F")
   CALL axcq571_b_fill()
   RETURN 
   #end add-point
   PREPARE axcq571_precount FROM g_cnt_sql
   EXECUTE axcq571_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL axcq571_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="axcq571.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION axcq571_fetch(p_flag)
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_sql      STRING
   DEFINE l_sql2     STRING
   #end add-point
 
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:3)
   #add-point:fetch段CURSOR移動 name="fetch.cursor_action"
   INITIALIZE g_master.* TO NULL
   LET l_sql = " SELECT DISTINCT t0.xchacomp,t0.xchald,t0.xcha003,t0.xcha004,t0.xcha005,t0.xcha006,t0.xcha009, 
       t0.xcha007,t0.xcha008,t0.xcha010,t0.xcha012,t0.xcha011,t0.xcha002,t1.ooefl003 ,t2.glaal002 ,t3.xcatl003 , 
       t4.imaal003 ,t4.imaal004,t5.oocql004 ,t7.pjabl003 ,t8.xcbfl003",
               " FROM xcha_t t0",
               " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xchacomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.xchald AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t3 ON t3.xcatlent="||g_enterprise||" AND t3.xcatl001=t0.xcha003 AND t3.xcatl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=t0.xcha009 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='221' AND t5.oocql002=t0.xcha007 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pjabl_t t7 ON t7.pjablent="||g_enterprise||" AND t7.pjabl001=t0.xcha012 AND t7.pjabl002='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t8 ON t8.xcbflent="||g_enterprise||" AND t8.xcbflcomp=t0.xchacomp AND t8.xcbfl001=t0.xcha002 AND t8.xcbfl002='"||g_dlang||"' ", 
               " WHERE t0.xchaent = " ||g_enterprise|| " AND t0.xchald = ? AND t0.xcha001 = ? AND t0.xcha002 = ? AND t0.xcha003 = ? AND t0.xcha004 = ? AND t0.xcha005 = ? AND t0.xcha006 = ? AND t0.xcha007 = ? AND t0.xcha008 = ?"

   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE axcq571_xcha_pre FROM l_sql
   #DECLARE axcq571_xcha_curs CURSOR FROM axcq571_xcha_pre
   
   LET l_sql2 = " SELECT xchb002,xchb009,xchb010,xchb011,t1.imaal003,t1.imaal004 FROM xchb_t t0 ",
                " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=t0.xchb009 AND t1.imaal002='"||g_dlang||"' ",
                "  WHERE t0.xchbent = ",g_enterprise,
                "    AND t0.xchbld = ? AND t0.xchb001 = ? AND t0.xchb002 = ? AND t0.xchb003 = ? AND t0.xchb004 = ? AND t0.xchb005 = ? AND t0.xchb006 = ? ",
                "    AND t0.xchb007 = ? AND t0.xchb008 = ? AND t0.xchb009 = ? AND t0.xchb010 = ? AND t0.xchb011 = ?  AND t0.xchb014 = ? AND t0.xchb015 = ? " 

   PREPARE axcq571_xchb_pre FROM l_sql2
   #DECLARE axcq571_xchb_curs CURSOR FROM axcq571_xchb_pre
   
   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'P' LET g_current_idx = g_current_idx - 1
      WHEN 'N' LET g_current_idx = g_current_idx + 1
      WHEN 'L' LET g_current_idx = g_row_count
      WHEN '/' LET g_current_idx = g_jump
   END CASE
   DISPLAY g_current_idx TO FORMONLY.h_index
   DISPLAY g_row_count TO FORMONLY.h_count
   #代表沒有資料
   IF g_current_idx = 0 THEN
      RETURN
   END IF   
   CALL cl_navigator_setting( g_current_idx, g_row_count )
     
   LET g_glaa015 = ''
   LET g_glaa019 = '' 
   SELECT glaa015,glaa019 INTO g_glaa015,g_glaa019
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_browser[g_current_idx].xchald 

   CALL cl_set_comp_visible('page_3,page_1',TRUE)
   IF g_glaa015 = 'N' THEN
      CALL cl_set_comp_visible('page_3',FALSE)
   END IF
   IF g_glaa019 = 'N' THEN
      CALL cl_set_comp_visible('page_1',FALSE)
   END IF
   LET g_master.xchacomp = g_browser[g_current_idx].xchacomp
   LET g_master.xchald = g_browser[g_current_idx].xchald
   LET g_master.xcha002 = g_browser[g_current_idx].xcha002
   LET g_master.xcha003 = g_browser[g_current_idx].xcha003
   LET g_master.xcha004 = g_browser[g_current_idx].xcha004
   LET g_master.xcha005 = g_browser[g_current_idx].xcha005
   LET g_master.xcha006 = g_browser[g_current_idx].xcha006
   LET g_master.xcha007 = g_browser[g_current_idx].xcha007
   LET g_master.xcha008 = g_browser[g_current_idx].xcha008   
   LET g_xchb_m.xchb009 = g_browser[g_current_idx].xchb009
   LET g_xchb_m.xchb010 = g_browser[g_current_idx].xchb010
   LET g_xchb_m.xchb011 = g_browser[g_current_idx].xchb011
   LET g_xchb_m.xchb014 = g_browser[g_current_idx].xchb014
   LET g_xchb_m.xchb015 = g_browser[g_current_idx].xchb015
   CALL s_desc_get_acc_desc('221',g_xchb_m.xchb014) RETURNING g_xchb_m.xchb014_desc
   SELECT DISTINCT xcha009,xcha010,xcha011,xcha012 
     INTO g_master.xcha009,g_master.xcha010,g_master.xcha011,g_master.xcha012
     FROM xcha_t
    WHERE xchaent = g_enterprise
      AND xchald = g_master.xchald
      AND xcha002 = g_master.xcha002  
      AND xcha003 = g_master.xcha003
      AND xcha004 = g_master.xcha004
      AND xcha005 = g_master.xcha005
      AND xcha006 = g_master.xcha006
      AND xcha007 = g_master.xcha007
      AND xcha008 = g_master.xcha008
      
#根据工单抓返工否，结案日期
   SELECT sfaa048 INTO g_master.sfaa048
     FROM sfaa_t
    WHERE sfaaent   = g_enterprise
      AND sfaadocno = g_master.xcha006
#抓成本阶
   SELECT DISTINCT xcbb006 INTO g_master.xcbb006
     FROM xcbb_t
    WHERE xcbbent  = g_enterprise
      AND xcbbcomp = g_master.xchacomp
      AND xcbb001  = g_master.xcha004
      AND xcbb002  = g_master.xcha005
      AND xcbb003  = g_master.xcha009   #不写特性，因为相同料号不同特性的xcbb成本阶一样的
      AND xcbb004  = g_master.xcha010
      
   IF SQLCA.SQLCODE=100 OR cl_null(g_master.xcha010) THEN
      SELECT DISTINCT xcbb006 INTO g_master.xcbb006
        FROM xcbb_t
       WHERE xcbbent  = g_enterprise
         AND xcbbcomp = g_master.xchacomp
         AND xcbb001  = g_master.xcha004
         AND xcbb002  = g_master.xcha005
         AND xcbb003  = g_master.xcha009  
   END IF   
   
   #單頭
   EXECUTE axcq571_xcha_pre USING g_master.xchald,'1',g_master.xcha002,g_master.xcha003,g_master.xcha004,g_master.xcha005,
                                  g_master.xcha006,g_master.xcha007,g_master.xcha008
                             INTO g_master.xchacomp,g_master.xchald,g_master.xcha003,g_master.xcha004,g_master.xcha005,g_master.xcha006,g_master.xcha009,g_master.xcha007, 
                                  g_master.xcha008,g_master.xcha010,g_master.xcha012,g_master.xcha011,g_master.xcha002,g_master.xchacomp_desc,g_master.xchald_desc,g_master.xcha003_desc, 
                                  g_master.xcha009_desc,g_master.xcha009_desc_1,g_master.xcha007_desc,g_master.xcha012_desc,g_master.xcha002_desc   
   
   SELECT imag014 INTO g_master.imag014
     FROM imag_t
    WHERE imagent  = g_enterprise
      AND imagsite = g_master.xchacomp
      AND imag001  = g_master.xcha009
   
   CALL s_desc_get_unit_desc(g_master.imag014)
         RETURNING g_master.imag014_desc 
         
   EXECUTE axcq571_xchb_pre USING g_master.xchald,g_master.xcha002,g_master.xcha003,g_master.xcha004,g_master.xcha005,
                                  g_master.xcha006,g_master.xcha007,g_master.xcha008,g_xchb_m.xchb009,g_xchb_m.xchb010,
                                  g_xchb_m.xchb011,g_xchb_m.xchb014,g_xchb_m.xchb015        
                             INTO g_xchb_m.xchb002,g_xchb_m.xchb009,g_xchb_m.xchb010,g_xchb_m.xchb011,
                                  g_xchb_m.xchb009_desc,g_xchb_m.xchb009_desc_1 
     


   DISPLAY g_master.* TO b_xchacomp,b_xchacomp_desc,b_xchald,b_xchald_desc,b_xcha003,b_xcha003_desc, 
       b_xcha004,b_xcha005,b_xcha006,b_xcha009,b_xcha009_desc,b_xcha009_desc_1,b_xcha007,b_xcha007_desc, 
       b_xcha008,b_xcha010,imag014,imag014_desc,b_xcha012,b_xcha012_desc,b_xcha011,b_xcha002,b_xcha002_desc, 
       sfaa048,xcbb006 
       
   CALL axcq571_show()    
   RETURN
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO b_xchacomp,b_xchacomp_desc,b_xchald,b_xchald_desc,b_xcha003,b_xcha003_desc, 
          b_xcha004,b_xcha005,b_xcha006,b_xcha009,b_xcha009_desc,b_xcha009_desc_1,b_xcha007,b_xcha007_desc, 
          b_xcha008,b_xcha010,imag014,imag014_desc,b_xcha012,b_xcha012_desc,b_xcha011,b_xcha002,b_xcha002_desc, 
          sfaa048,xcbb006
      CALL g_detail.clear()
      CALL g_detail2.clear()
 
      CALL g_detail3.clear()
 
      CALL g_detail4.clear()
 
      CALL g_detail5.clear()
 
      CALL g_detail6.clear()
 
 
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
   
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL axcq571_show()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq571.show" >}
PRIVATE FUNCTION axcq571_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO b_xchacomp,b_xchacomp_desc,b_xchald,b_xchald_desc,b_xcha003,b_xcha003_desc, 
       b_xcha004,b_xcha005,b_xcha006,b_xcha009,b_xcha009_desc,b_xcha009_desc_1,b_xcha007,b_xcha007_desc, 
       b_xcha008,b_xcha010,imag014,imag014_desc,b_xcha012,b_xcha012_desc,b_xcha011,b_xcha002,b_xcha002_desc, 
       sfaa048,xcbb006
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   DISPLAY g_xchb_m.xchb009,g_xchb_m.xchb009_desc,g_xchb_m.xchb009_desc_1,g_xchb_m.xchb010,g_xchb_m.imag014_2,g_xchb_m.imag014_2_desc,g_xchb_m.xcbb006_2,g_xchb_m.xchb011,g_xchb_m.xchb002,
           g_xchb_m.xchb014,g_xchb_m.xchb014_desc,g_xchb_m.xchb015   
        TO xchb009,xchb009_desc,xchb009_desc_1,xchb010,imag014_2,imag014_2_desc,xcbb006_2,xchb011,xchb002,xchb014,xchb014_desc,xchb015
        
   DISPLAY g_xchb_m2.xchb009_2,g_xchb_m2.xchb009_2_desc,g_xchb_m2.xchb009_2_desc_1,g_xchb_m2.xchb010_2,g_xchb_m2.imag014_3,g_xchb_m2.imag014_3_desc,g_xchb_m2.xcbb006_3,g_xchb_m2.xchb011_2,g_xchb_m2.xchb002_2,
           g_xchb_m2.xchb014_2,g_xchb_m2.xchb014_2_desc,g_xchb_m2.xchb015_2
        TO xchb009_2,xchb009_2_desc,xchb009_2_desc_1,xchb010_2,imag014_3,imag014_3_desc,xcbb006_3,xchb011_2,xchb002_2,xchb014_2,xchb014_2_desc,xchb015_2       

   DISPLAY g_xchb_m3.xchb009_3,g_xchb_m3.xchb009_3_desc,g_xchb_m3.xchb009_3_desc_1,g_xchb_m3.xchb010_3,g_xchb_m3.imag014_4,g_xchb_m3.imag014_4_desc,g_xchb_m3.xcbb006_4,g_xchb_m3.xchb011_3,g_xchb_m3.xchb002_3,
           g_xchb_m3.xchb014_3,g_xchb_m3.xchb014_3_desc,g_xchb_m3.xchb015_3
        TO xchb009_3,xchb009_3_desc,xchb009_3_desc_1,xchb010_3,imag014_4,imag014_4_desc,xcbb006_4,xchb011_3,xchb002_3,xchb014_3,xchb014_3_desc,xchb015_3     
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL axcq571_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq571.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq571_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql           STRING
   DEFINE l_msg           STRING
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   IF cl_null(g_master.xchacomp) THEN
      RETURN 
   END IF
   CALL g_detail2.clear()
   CALL g_detail3.clear()
   CALL g_detail4.clear()
   CALL g_detail5.clear()
   CALL g_detail6.clear()
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:3)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql name="b_fill.sql"
   LET l_sql = " SELECT DISTINCT '',xcha001 xcha001_1,xcha101,xcha203,xcha201,xcha303,xcha305,xcha307,xcha301,xcha309,xcha901,",   #170111-00019#1 add xcha309  #161121-00018#1
               "                 '',xcha001 xcha001_2,xcha102,xcha204,xcha202,xcha304,xcha306,xcha308,xcha302,xcha310,xcha902  ",  #170111-00019#1 add xcha310  #161121-00018#1
               "   FROM xcha_t ",
               "  WHERE xchaent = ? AND xchald = ? AND xcha001 = ? AND xcha002 = ? AND xcha003 = ? AND xcha004 = ? AND xcha005 = ?",
               "    AND xcha006 = ? AND xcha007 = ? AND xcha008 = ?"
               
   LET l_sql = l_sql, " ORDER BY xchald,xcha001,xcha002,xcha003,xcha004,xcha005,xcha006,xcha007,xcha008 "
    
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE axcq571_pb FROM l_sql
   DECLARE b_fill_cs CURSOR FOR axcq571_pb
   
   OPEN b_fill_cs USING g_enterprise,g_master.xchald,'1',g_master.xcha002,g_master.xcha003,g_master.xcha004,g_master.xcha005,
                        g_master.xcha006,g_master.xcha007,g_master.xcha008
                                  
   FETCH b_fill_cs INTO g_detail[1].item,g_detail[1].xcha001,g_detail[1].xcha102,g_detail[1].xcha204,g_detail[1].xcha202,g_detail[1].xcha304,g_detail[1].xcha306,g_detail[1].xcha308,g_detail[1].xcha302,g_detail[1].xcha310,g_detail[1].xcha902,  #170111-00019#1 add xcha310  #161121-00018#1 
                        g_detail[2].item,g_detail[2].xcha001,g_detail[2].xcha102,g_detail[2].xcha204,g_detail[2].xcha202,g_detail[2].xcha304,g_detail[2].xcha306,g_detail[2].xcha308,g_detail[2].xcha302,g_detail[2].xcha310,g_detail[2].xcha902   #170111-00019#1 add xcha310  #161121-00018#1
    
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "FETCH b_fill_cs" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE b_fill_cs
      FREE b_fill_cs  
      RETURN
   END IF

   #填充第一列的项目内容
   LET l_msg = cl_getmsg('axc-00657',g_lang)   #数量
   LET g_detail[1].item = l_msg      
   LET l_msg = cl_getmsg('axc-00321',g_lang)   #成本金額
   LET g_detail[2].item = l_msg   

   IF g_glaa015 ='Y' THEN 
      OPEN b_fill_cs USING g_enterprise,g_master.xchald,'2',g_master.xcha002,g_master.xcha003,g_master.xcha004,g_master.xcha005,
                           g_master.xcha006,g_master.xcha007,g_master.xcha008
                                     
      FETCH b_fill_cs INTO g_detail3[1].item3,g_detail3[1].xcha001,g_detail3[1].xcha102a,g_detail3[1].xcha204a,g_detail3[1].xcha202a,g_detail3[1].xcha304a,g_detail3[1].xcha306a,g_detail3[1].xcha308a,g_detail3[1].xcha302a,g_detail3[1].xcha310a,g_detail3[1].xcha902a, #170111-00019#1 add xcha310  #161121-00018#1 
                           g_detail3[2].item3,g_detail3[2].xcha001,g_detail3[2].xcha102a,g_detail3[2].xcha204a,g_detail3[2].xcha202a,g_detail3[2].xcha304a,g_detail3[2].xcha306a,g_detail3[2].xcha308a,g_detail3[2].xcha302a,g_detail3[2].xcha310a,g_detail3[2].xcha902a  #170111-00019#1 add xcha310  #161121-00018#1
       
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FETCH b_fill_cs" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CLOSE b_fill_cs
         FREE b_fill_cs  
         RETURN
      END IF
     
      #填充第一列的项目内容
      LET l_msg = cl_getmsg('axc-00657',g_lang)   #数量
      LET g_detail3[1].item3 = l_msg      
      LET l_msg = cl_getmsg('axc-00321',g_lang)   #成本金額
      LET g_detail3[2].item3 = l_msg 
   END IF
   
   IF g_glaa019 ='Y' THEN 
      OPEN b_fill_cs USING g_enterprise,g_master.xchald,'3',g_master.xcha002,g_master.xcha003,g_master.xcha004,g_master.xcha005,
                           g_master.xcha006,g_master.xcha007,g_master.xcha008
                                     
      FETCH b_fill_cs INTO g_detail5[1].item5,g_detail5[1].xcha001,g_detail5[1].xcha102b,g_detail5[1].xcha204b,g_detail5[1].xcha202b,g_detail5[1].xcha304b,g_detail5[1].xcha306b,g_detail5[1].xcha308b,g_detail5[1].xcha302b,g_detail5[1].xcha310b,g_detail5[1].xcha902b,  #170111-00019#1 add xcha310  #161121-00018#1
                           g_detail5[2].item5,g_detail5[2].xcha001,g_detail5[2].xcha102b,g_detail5[2].xcha204b,g_detail5[2].xcha202b,g_detail5[2].xcha304b,g_detail5[2].xcha306b,g_detail5[2].xcha308b,g_detail5[2].xcha302b,g_detail5[2].xcha310b,g_detail5[2].xcha902b   #170111-00019#1 add xcha310  #161121-00018#1
       
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FETCH b_fill_cs" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CLOSE b_fill_cs
         FREE b_fill_cs  
         RETURN
      END IF
     
      #填充第一列的项目内容
      LET l_msg = cl_getmsg('axc-00657',g_lang)   #数量
      LET g_detail5[1].item5 = l_msg      
      LET l_msg = cl_getmsg('axc-00321',g_lang)   #成本金額
      LET g_detail5[2].item5 = l_msg 
   END IF
   
   CLOSE b_fill_cs
   FREE b_fill_cs  
   #填充元件單身
   LET l_sql = " SELECT '',xchb101,xchb203,xchb201,xchb207,xchb305,xchb209,xchb301,xchb303,xchb307,xchb309,xchb901,",
               "        '',xchb102a,xchb204a,xchb202a,xchb208a,xchb306a,xchb210a,xchb302a,xchb304a,xchb308a,xchb310a,xchb902a, ",
               "        '',xchb102b,xchb204b,xchb202b,xchb208b,xchb306b,xchb210b,xchb302b,xchb304b,xchb308b,xchb310b,xchb902b, ",
               "        '',xchb102c,xchb204c,xchb202c,xchb208c,xchb306c,xchb210c,xchb302c,xchb304c,xchb308c,xchb310c,xchb902c, ",
               "        '',xchb102d,xchb204d,xchb202d,xchb208d,xchb306d,xchb210d,xchb302d,xchb304d,xchb308d,xchb310d,xchb902d, ",
               "        '',xchb102e,xchb204e,xchb202e,xchb208e,xchb306e,xchb210e,xchb302e,xchb304e,xchb308e,xchb310e,xchb902e, ",
               "        '',xchb102f,xchb204f,xchb202f,xchb208f,xchb306f,xchb210f,xchb302f,xchb304f,xchb308f,xchb310f,xchb902f, ",
               "        '',xchb102g,xchb204g,xchb202g,xchb208g,xchb306g,xchb210g,xchb302g,xchb304g,xchb308g,xchb310g,xchb902g, ",
               "        '',xchb102h,xchb204h,xchb202h,xchb208h,xchb306h,xchb210h,xchb302h,xchb304h,xchb308h,xchb310h,xchb902h, ",
               "        '',xchb102,xchb204,xchb202,xchb208,xchb306,xchb210,xchb302,xchb304,xchb308,xchb310,xchb902 ",
               "  FROM xchb_t ",
               " WHERE xchbent = ",g_enterprise,
               "   AND xchbld = ? AND xchb001 = ? AND xchb002 = ? AND xchb003 = ? AND xchb004 = ? AND xchb005 = ? AND xchb006 = ? ",
               "   AND xchb007 = ? AND xchb008 = ? AND xchb009 = ? AND xchb010 = ? AND xchb011 = ? AND xchb014 = ? AND xchb015 = ? "
               
   LET l_sql = l_sql, " ORDER BY xchb_t.xchb001"
   
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE axcq571_pb2 FROM l_sql
   DECLARE b_fill_cs2 CURSOR FOR axcq571_pb2
   
   OPEN b_fill_cs2 USING g_master.xchald,'1',g_master.xcha002,g_master.xcha003,g_master.xcha004,g_master.xcha005,
                         g_master.xcha006,g_master.xcha007,g_master.xcha008,g_xchb_m.xchb009,g_xchb_m.xchb010,g_xchb_m.xchb011,
                         g_xchb_m.xchb014,g_xchb_m.xchb015
   
   FETCH b_fill_cs2 INTO g_detail2[1].item2,g_detail2[1].xchb102,g_detail2[1].xchb204,g_detail2[1].xchb202,g_detail2[1].xchb208,g_detail2[1].xchb306,g_detail2[1].xchb210,g_detail2[1].xchb302,g_detail2[1].xchb304,g_detail2[1].xchb308,g_detail2[1].xchb310,g_detail2[1].xchb902,
                         g_detail2[2].item2,g_detail2[2].xchb102,g_detail2[2].xchb204,g_detail2[2].xchb202,g_detail2[2].xchb208,g_detail2[2].xchb306,g_detail2[2].xchb210,g_detail2[2].xchb302,g_detail2[2].xchb304,g_detail2[2].xchb308,g_detail2[2].xchb310,g_detail2[2].xchb902,
                         g_detail2[3].item2,g_detail2[3].xchb102,g_detail2[3].xchb204,g_detail2[3].xchb202,g_detail2[3].xchb208,g_detail2[3].xchb306,g_detail2[3].xchb210,g_detail2[3].xchb302,g_detail2[3].xchb304,g_detail2[3].xchb308,g_detail2[3].xchb310,g_detail2[3].xchb902,
                         g_detail2[4].item2,g_detail2[4].xchb102,g_detail2[4].xchb204,g_detail2[4].xchb202,g_detail2[4].xchb208,g_detail2[4].xchb306,g_detail2[4].xchb210,g_detail2[4].xchb302,g_detail2[4].xchb304,g_detail2[4].xchb308,g_detail2[4].xchb310,g_detail2[4].xchb902,
                         g_detail2[5].item2,g_detail2[5].xchb102,g_detail2[5].xchb204,g_detail2[5].xchb202,g_detail2[5].xchb208,g_detail2[5].xchb306,g_detail2[5].xchb210,g_detail2[5].xchb302,g_detail2[5].xchb304,g_detail2[5].xchb308,g_detail2[5].xchb310,g_detail2[5].xchb902,  
                         g_detail2[6].item2,g_detail2[6].xchb102,g_detail2[6].xchb204,g_detail2[6].xchb202,g_detail2[6].xchb208,g_detail2[6].xchb306,g_detail2[6].xchb210,g_detail2[6].xchb302,g_detail2[6].xchb304,g_detail2[6].xchb308,g_detail2[6].xchb310,g_detail2[6].xchb902,  
                         g_detail2[7].item2,g_detail2[7].xchb102,g_detail2[7].xchb204,g_detail2[7].xchb202,g_detail2[7].xchb208,g_detail2[7].xchb306,g_detail2[7].xchb210,g_detail2[7].xchb302,g_detail2[7].xchb304,g_detail2[7].xchb308,g_detail2[7].xchb310,g_detail2[7].xchb902,  
                         g_detail2[8].item2,g_detail2[8].xchb102,g_detail2[8].xchb204,g_detail2[8].xchb202,g_detail2[8].xchb208,g_detail2[8].xchb306,g_detail2[8].xchb210,g_detail2[8].xchb302,g_detail2[8].xchb304,g_detail2[8].xchb308,g_detail2[8].xchb310,g_detail2[8].xchb902,  
                         g_detail2[9].item2,g_detail2[9].xchb102,g_detail2[9].xchb204,g_detail2[9].xchb202,g_detail2[9].xchb208,g_detail2[9].xchb306,g_detail2[9].xchb210,g_detail2[9].xchb302,g_detail2[9].xchb304,g_detail2[9].xchb308,g_detail2[9].xchb310,g_detail2[9].xchb902,
                         g_detail2[10].item2,g_detail2[10].xchb102,g_detail2[10].xchb204,g_detail2[10].xchb202,g_detail2[10].xchb208,g_detail2[10].xchb306,g_detail2[10].xchb210,g_detail2[10].xchb302,g_detail2[10].xchb304,g_detail2[10].xchb308,g_detail2[10].xchb310,g_detail2[10].xchb902                         
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "FETCH b_fill_cs2" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE b_fill_cs2
      FREE b_fill_cs2  
      RETURN
   END IF
   
   #填充第一列的项目内容
   LET l_msg = cl_getmsg('axc-00657',g_lang)   #数量
   LET g_detail2[1].item2 = l_msg 
   LET l_msg = cl_getmsg('axc-00315',g_lang)   #材料
   LET g_detail2[2].item2 = l_msg   
   LET l_msg = cl_getmsg('axc-00308',g_lang)   #人工 
   LET g_detail2[3].item2 = l_msg
   LET l_msg = cl_getmsg('axc-00797',g_lang)   #委外
   LET g_detail2[4].item2 = l_msg    
   LET l_msg = cl_getmsg('axc-00310',g_lang)   #制费一
   LET g_detail2[5].item2 = l_msg       
   LET l_msg = cl_getmsg('axc-00311',g_lang)   #制费二
   LET g_detail2[6].item2 = l_msg 
   LET l_msg = cl_getmsg('axc-00312',g_lang)   #制费三
   LET g_detail2[7].item2 = l_msg 
   LET l_msg = cl_getmsg('axc-00313',g_lang)   #制费四
   LET g_detail2[8].item2 = l_msg 
   LET l_msg = cl_getmsg('axc-00314',g_lang)   #制费五
   LET g_detail2[9].item2 = l_msg    
   LET l_msg = cl_getmsg('aps-00134',g_lang)   #合計
   LET g_detail2[10].item2 = l_msg  

#   LET g_detail2[10].xchb102 = g_detail2[2].xchb102 + g_detail2[3].xchb102 + g_detail2[4].xchb102 + g_detail2[5].xchb102
#                             + g_detail2[6].xchb102 + g_detail2[7].xchb102 + g_detail2[8].xchb102 + g_detail2[9].xchb102
#   LET g_detail2[10].xchb204 = g_detail2[2].xchb204 + g_detail2[3].xchb204 + g_detail2[4].xchb204 + g_detail2[5].xchb204
#                             + g_detail2[6].xchb204 + g_detail2[7].xchb204 + g_detail2[8].xchb204 + g_detail2[9].xchb204
#   LET g_detail2[10].xchb202 = g_detail2[2].xchb202 + g_detail2[3].xchb202 + g_detail2[4].xchb202 + g_detail2[5].xchb202
#                             + g_detail2[6].xchb202 + g_detail2[7].xchb202 + g_detail2[8].xchb202 + g_detail2[9].xchb202
#   LET g_detail2[10].xchb208 = g_detail2[2].xchb208 + g_detail2[3].xchb208 + g_detail2[4].xchb208 + g_detail2[5].xchb208
#                             + g_detail2[6].xchb208 + g_detail2[7].xchb208 + g_detail2[8].xchb208 + g_detail2[9].xchb208
#   LET g_detail2[10].xchb306 = g_detail2[2].xchb306 + g_detail2[3].xchb306 + g_detail2[4].xchb306 + g_detail2[5].xchb306
#                             + g_detail2[6].xchb306 + g_detail2[7].xchb306 + g_detail2[8].xchb306 + g_detail2[9].xchb306
#   LET g_detail2[10].xchb210 = g_detail2[2].xchb210 + g_detail2[3].xchb210 + g_detail2[4].xchb210 + g_detail2[5].xchb210
#                             + g_detail2[6].xchb210 + g_detail2[7].xchb210 + g_detail2[8].xchb210 + g_detail2[9].xchb210
#   LET g_detail2[10].xchb302 = g_detail2[2].xchb302 + g_detail2[3].xchb302 + g_detail2[4].xchb302 + g_detail2[5].xchb302
#                             + g_detail2[6].xchb302 + g_detail2[7].xchb302 + g_detail2[8].xchb302 + g_detail2[9].xchb302  
#   LET g_detail2[10].xchb304 = g_detail2[2].xchb304 + g_detail2[3].xchb304 + g_detail2[4].xchb304 + g_detail2[5].xchb304
#                             + g_detail2[6].xchb304 + g_detail2[7].xchb304 + g_detail2[8].xchb304 + g_detail2[9].xchb304
#   LET g_detail2[10].xchb308 = g_detail2[2].xchb308 + g_detail2[3].xchb308 + g_detail2[4].xchb308 + g_detail2[5].xchb308
#                             + g_detail2[6].xchb308 + g_detail2[7].xchb308 + g_detail2[8].xchb308 + g_detail2[9].xchb308
#   LET g_detail2[10].xchb310 = g_detail2[2].xchb310 + g_detail2[3].xchb310 + g_detail2[4].xchb310 + g_detail2[5].xchb310
#                             + g_detail2[6].xchb310 + g_detail2[7].xchb310 + g_detail2[8].xchb310 + g_detail2[9].xchb310
#   LET g_detail2[10].xchb902 = g_detail2[2].xchb902 + g_detail2[3].xchb902 + g_detail2[4].xchb902 + g_detail2[5].xchb902
#                             + g_detail2[6].xchb902 + g_detail2[7].xchb902 + g_detail2[8].xchb902 + g_detail2[9].xchb902

   IF g_glaa015 ='Y' THEN 
      OPEN b_fill_cs2 USING g_master.xchald,'2',g_master.xcha002,g_master.xcha003,g_master.xcha004,g_master.xcha005,
                            g_master.xcha006,g_master.xcha007,g_master.xcha008,g_xchb_m.xchb009,g_xchb_m.xchb010,g_xchb_m.xchb011,
                            g_xchb_m.xchb014,g_xchb_m.xchb015
      
      FETCH b_fill_cs2 INTO g_detail4[1].item4,g_detail4[1].xchb102a,g_detail4[1].xchb204a,g_detail4[1].xchb202a,g_detail4[1].xchb208a,g_detail4[1].xchb306a,g_detail4[1].xchb210a,g_detail4[1].xchb302a,g_detail4[1].xchb304a,g_detail4[1].xchb308a,g_detail4[1].xchb310a,g_detail4[1].xchb902a,
                            g_detail4[2].item4,g_detail4[2].xchb102a,g_detail4[2].xchb204a,g_detail4[2].xchb202a,g_detail4[2].xchb208a,g_detail4[2].xchb306a,g_detail4[2].xchb210a,g_detail4[2].xchb302a,g_detail4[2].xchb304a,g_detail4[2].xchb308a,g_detail4[2].xchb310a,g_detail4[2].xchb902a,
                            g_detail4[3].item4,g_detail4[3].xchb102a,g_detail4[3].xchb204a,g_detail4[3].xchb202a,g_detail4[3].xchb208a,g_detail4[3].xchb306a,g_detail4[3].xchb210a,g_detail4[3].xchb302a,g_detail4[3].xchb304a,g_detail4[3].xchb308a,g_detail4[3].xchb310a,g_detail4[3].xchb902a,
                            g_detail4[4].item4,g_detail4[4].xchb102a,g_detail4[4].xchb204a,g_detail4[4].xchb202a,g_detail4[4].xchb208a,g_detail4[4].xchb306a,g_detail4[4].xchb210a,g_detail4[4].xchb302a,g_detail4[4].xchb304a,g_detail4[4].xchb308a,g_detail4[4].xchb310a,g_detail4[4].xchb902a,
                            g_detail4[5].item4,g_detail4[5].xchb102a,g_detail4[5].xchb204a,g_detail4[5].xchb202a,g_detail4[5].xchb208a,g_detail4[5].xchb306a,g_detail4[5].xchb210a,g_detail4[5].xchb302a,g_detail4[5].xchb304a,g_detail4[5].xchb308a,g_detail4[5].xchb310a,g_detail4[5].xchb902a,  
                            g_detail4[6].item4,g_detail4[6].xchb102a,g_detail4[6].xchb204a,g_detail4[6].xchb202a,g_detail4[6].xchb208a,g_detail4[6].xchb306a,g_detail4[6].xchb210a,g_detail4[6].xchb302a,g_detail4[6].xchb304a,g_detail4[6].xchb308a,g_detail4[6].xchb310a,g_detail4[6].xchb902a,  
                            g_detail4[7].item4,g_detail4[7].xchb102a,g_detail4[7].xchb204a,g_detail4[7].xchb202a,g_detail4[7].xchb208a,g_detail4[7].xchb306a,g_detail4[7].xchb210a,g_detail4[7].xchb302a,g_detail4[7].xchb304a,g_detail4[7].xchb308a,g_detail4[7].xchb310a,g_detail4[7].xchb902a,  
                            g_detail4[8].item4,g_detail4[8].xchb102a,g_detail4[8].xchb204a,g_detail4[8].xchb202a,g_detail4[8].xchb208a,g_detail4[8].xchb306a,g_detail4[8].xchb210a,g_detail4[8].xchb302a,g_detail4[8].xchb304a,g_detail4[8].xchb308a,g_detail4[8].xchb310a,g_detail4[8].xchb902a,  
                            g_detail4[9].item4,g_detail4[9].xchb102a,g_detail4[9].xchb204a,g_detail4[9].xchb202a,g_detail4[9].xchb208a,g_detail4[9].xchb306a,g_detail4[9].xchb210a,g_detail4[9].xchb302a,g_detail4[9].xchb304a,g_detail4[9].xchb308a,g_detail4[9].xchb310a,g_detail4[9].xchb902a,
                            g_detail4[10].item4,g_detail4[10].xchb102a,g_detail4[10].xchb204a,g_detail4[10].xchb202a,g_detail4[10].xchb208a,g_detail4[10].xchb306a,g_detail4[10].xchb210a,g_detail4[10].xchb302a,g_detail4[10].xchb304a,g_detail4[10].xchb308a,g_detail4[10].xchb310a,g_detail4[10].xchb902a                             
                                                        
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FETCH b_fill_cs2" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CLOSE b_fill_cs2
         FREE b_fill_cs2  
         RETURN
      
      
         #填充第一列的项目内容
         LET l_msg = cl_getmsg('axc-00657',g_lang)   #数量
         LET g_detail4[1].item4 = l_msg 
         LET l_msg = cl_getmsg('axc-00315',g_lang)   #材料
         LET g_detail4[2].item4 = l_msg   
         LET l_msg = cl_getmsg('axc-00308',g_lang)   #人工 
         LET g_detail4[3].item4 = l_msg
         LET l_msg = cl_getmsg('axc-00797',g_lang)   #委外
         LET g_detail4[4].item4 = l_msg    
         LET l_msg = cl_getmsg('axc-00310',g_lang)   #制费一
         LET g_detail4[5].item4 = l_msg       
         LET l_msg = cl_getmsg('axc-00311',g_lang)   #制费二
         LET g_detail4[6].item4 = l_msg 
         LET l_msg = cl_getmsg('axc-00312',g_lang)   #制费三
         LET g_detail4[7].item4 = l_msg 
         LET l_msg = cl_getmsg('axc-00313',g_lang)   #制费四
         LET g_detail4[8].item4 = l_msg 
         LET l_msg = cl_getmsg('axc-00314',g_lang)   #制费五
         LET g_detail4[9].item4 = l_msg    
         LET l_msg = cl_getmsg('aps-00134',g_lang)   #合計
         LET g_detail4[10].item4 = l_msg  
       
#         LET g_detail4[10].xchb102a = g_detail4[2].xchb102a + g_detail4[3].xchb102a + g_detail4[4].xchb102a + g_detail4[5].xchb102a
#                                    + g_detail4[6].xchb102a + g_detail4[7].xchb102a + g_detail4[8].xchb102a + g_detail4[9].xchb102a
#         LET g_detail4[10].xchb204a = g_detail4[2].xchb204a + g_detail4[3].xchb204a + g_detail4[4].xchb204a + g_detail4[5].xchb204a
#                                    + g_detail4[6].xchb204a + g_detail4[7].xchb204a + g_detail4[8].xchb204a + g_detail4[9].xchb204a
#         LET g_detail4[10].xchb202a = g_detail4[2].xchb202a + g_detail4[3].xchb202a + g_detail4[4].xchb202a + g_detail4[5].xchb202a
#                                    + g_detail4[6].xchb202a + g_detail4[7].xchb202a + g_detail4[8].xchb202a + g_detail4[9].xchb202a
#         LET g_detail4[10].xchb208a = g_detail4[2].xchb208a + g_detail4[3].xchb208a + g_detail4[4].xchb208a + g_detail4[5].xchb208a
#                                    + g_detail4[6].xchb208a + g_detail4[7].xchb208a + g_detail4[8].xchb208a + g_detail4[9].xchb208a
#         LET g_detail4[10].xchb306a = g_detail4[2].xchb306a + g_detail4[3].xchb306a + g_detail4[4].xchb306a + g_detail4[5].xchb306a
#                                    + g_detail4[6].xchb306a + g_detail4[7].xchb306a + g_detail4[8].xchb306a + g_detail4[9].xchb306a
#         LET g_detail4[10].xchb210a = g_detail4[2].xchb210a + g_detail4[3].xchb210a + g_detail4[4].xchb210a + g_detail4[5].xchb210a
#                                    + g_detail4[6].xchb210a + g_detail4[7].xchb210a + g_detail4[8].xchb210a + g_detail4[9].xchb210a
#         LET g_detail4[10].xchb302a = g_detail4[2].xchb302a + g_detail4[3].xchb302a + g_detail4[4].xchb302a + g_detail4[5].xchb302a
#                                    + g_detail4[6].xchb302a + g_detail4[7].xchb302a + g_detail4[8].xchb302a + g_detail4[9].xchb302a  
#         LET g_detail4[10].xchb304a = g_detail4[2].xchb304a + g_detail4[3].xchb304a + g_detail4[4].xchb304a + g_detail4[5].xchb304a
#                                    + g_detail4[6].xchb304a + g_detail4[7].xchb304a + g_detail4[8].xchb304a + g_detail4[9].xchb304a
#         LET g_detail4[10].xchb308a = g_detail4[2].xchb308a + g_detail4[3].xchb308a + g_detail4[4].xchb308a + g_detail4[5].xchb308a
#                                    + g_detail4[6].xchb308a + g_detail4[7].xchb308a + g_detail4[8].xchb308a + g_detail4[9].xchb308a
#         LET g_detail4[10].xchb310a = g_detail4[2].xchb310a + g_detail4[3].xchb310a + g_detail4[4].xchb310a + g_detail4[5].xchb310a
#                                    + g_detail4[6].xchb310a + g_detail4[7].xchb310a + g_detail4[8].xchb310a + g_detail4[9].xchb310a
#         LET g_detail4[10].xchb902a = g_detail4[2].xchb902a + g_detail4[3].xchb902a + g_detail4[4].xchb902a + g_detail4[5].xchb902a
#                                    + g_detail4[6].xchb902a + g_detail4[7].xchb902a + g_detail4[8].xchb902a + g_detail4[9].xchb902a
      END IF
   END IF

   IF g_glaa019 ='Y' THEN 
      OPEN b_fill_cs2 USING g_master.xchald,'3',g_master.xcha002,g_master.xcha003,g_master.xcha004,g_master.xcha005,
                            g_master.xcha006,g_master.xcha007,g_master.xcha008,g_xchb_m.xchb009,g_xchb_m.xchb010,g_xchb_m.xchb011,
                            g_xchb_m.xchb014,g_xchb_m.xchb015
      
      FETCH b_fill_cs2 INTO g_detail6[1].item6,g_detail6[1].xchb102b,g_detail6[1].xchb204b,g_detail6[1].xchb202b,g_detail6[1].xchb208b,g_detail6[1].xchb306b,g_detail6[1].xchb210b,g_detail6[1].xchb302b,g_detail6[1].xchb304b,g_detail6[1].xchb308b,g_detail6[1].xchb310b,g_detail6[1].xchb902b,
                            g_detail6[2].item6,g_detail6[2].xchb102b,g_detail6[2].xchb204b,g_detail6[2].xchb202b,g_detail6[2].xchb208b,g_detail6[2].xchb306b,g_detail6[2].xchb210b,g_detail6[2].xchb302b,g_detail6[2].xchb304b,g_detail6[2].xchb308b,g_detail6[2].xchb310b,g_detail6[2].xchb902b,
                            g_detail6[3].item6,g_detail6[3].xchb102b,g_detail6[3].xchb204b,g_detail6[3].xchb202b,g_detail6[3].xchb208b,g_detail6[3].xchb306b,g_detail6[3].xchb210b,g_detail6[3].xchb302b,g_detail6[3].xchb304b,g_detail6[3].xchb308b,g_detail6[3].xchb310b,g_detail6[3].xchb902b,
                            g_detail6[4].item6,g_detail6[4].xchb102b,g_detail6[4].xchb204b,g_detail6[4].xchb202b,g_detail6[4].xchb208b,g_detail6[4].xchb306b,g_detail6[4].xchb210b,g_detail6[4].xchb302b,g_detail6[4].xchb304b,g_detail6[4].xchb308b,g_detail6[4].xchb310b,g_detail6[4].xchb902b,
                            g_detail6[5].item6,g_detail6[5].xchb102b,g_detail6[5].xchb204b,g_detail6[5].xchb202b,g_detail6[5].xchb208b,g_detail6[5].xchb306b,g_detail6[5].xchb210b,g_detail6[5].xchb302b,g_detail6[5].xchb304b,g_detail6[5].xchb308b,g_detail6[5].xchb310b,g_detail6[5].xchb902b,  
                            g_detail6[6].item6,g_detail6[6].xchb102b,g_detail6[6].xchb204b,g_detail6[6].xchb202b,g_detail6[6].xchb208b,g_detail6[6].xchb306b,g_detail6[6].xchb210b,g_detail6[6].xchb302b,g_detail6[6].xchb304b,g_detail6[6].xchb308b,g_detail6[6].xchb310b,g_detail6[6].xchb902b,  
                            g_detail6[7].item6,g_detail6[7].xchb102b,g_detail6[7].xchb204b,g_detail6[7].xchb202b,g_detail6[7].xchb208b,g_detail6[7].xchb306b,g_detail6[7].xchb210b,g_detail6[7].xchb302b,g_detail6[7].xchb304b,g_detail6[7].xchb308b,g_detail6[7].xchb310b,g_detail6[7].xchb902b,  
                            g_detail6[8].item6,g_detail6[8].xchb102b,g_detail6[8].xchb204b,g_detail6[8].xchb202b,g_detail6[8].xchb208b,g_detail6[8].xchb306b,g_detail6[8].xchb210b,g_detail6[8].xchb302b,g_detail6[8].xchb304b,g_detail6[8].xchb308b,g_detail6[8].xchb310b,g_detail6[8].xchb902b,  
                            g_detail6[9].item6,g_detail6[9].xchb102b,g_detail6[9].xchb204b,g_detail6[9].xchb202b,g_detail6[9].xchb208b,g_detail6[9].xchb306b,g_detail6[9].xchb210b,g_detail6[9].xchb302b,g_detail6[9].xchb304b,g_detail6[9].xchb308b,g_detail6[9].xchb310b,g_detail6[9].xchb902b,
                            g_detail6[10].item6,g_detail6[10].xchb102b,g_detail6[10].xchb204b,g_detail6[10].xchb202b,g_detail6[10].xchb208b,g_detail6[10].xchb306b,g_detail6[10].xchb210b,g_detail6[10].xchb302b,g_detail6[10].xchb304b,g_detail6[10].xchb308b,g_detail6[10].xchb310b,g_detail6[10].xchb902b
                            
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FETCH b_fill_cs2" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CLOSE b_fill_cs2
         FREE b_fill_cs2  
         RETURN
      ELSE
         #填充第一列的项目内容
         LET l_msg = cl_getmsg('axc-00657',g_lang)   #数量
         LET g_detail6[1].item6 = l_msg 
         LET l_msg = cl_getmsg('axc-00315',g_lang)   #材料
         LET g_detail6[2].item6 = l_msg   
         LET l_msg = cl_getmsg('axc-00308',g_lang)   #人工 
         LET g_detail6[3].item6 = l_msg
         LET l_msg = cl_getmsg('axc-00797',g_lang)   #委外
         LET g_detail6[4].item6 = l_msg    
         LET l_msg = cl_getmsg('axc-00310',g_lang)   #制费一
         LET g_detail6[5].item6 = l_msg       
         LET l_msg = cl_getmsg('axc-00311',g_lang)   #制费二
         LET g_detail6[6].item6 = l_msg 
         LET l_msg = cl_getmsg('axc-00312',g_lang)   #制费三
         LET g_detail6[7].item6 = l_msg 
         LET l_msg = cl_getmsg('axc-00313',g_lang)   #制费四
         LET g_detail6[8].item6 = l_msg 
         LET l_msg = cl_getmsg('axc-00314',g_lang)   #制费五
         LET g_detail6[9].item6 = l_msg    
         LET l_msg = cl_getmsg('aps-00134',g_lang)   #合計
         LET g_detail6[10].item6 = l_msg  
       
#         LET g_detail6[10].xchb102b = g_detail6[2].xchb102b + g_detail6[3].xchb102b + g_detail6[4].xchb102b + g_detail6[5].xchb102b
#                                    + g_detail6[6].xchb102b + g_detail6[7].xchb102b + g_detail6[8].xchb102b + g_detail6[9].xchb102b
#         LET g_detail6[10].xchb204b = g_detail6[2].xchb204b + g_detail6[3].xchb204b + g_detail6[4].xchb204b + g_detail6[5].xchb204b
#                                    + g_detail6[6].xchb204b + g_detail6[7].xchb204b + g_detail6[8].xchb204b + g_detail6[9].xchb204b
#         LET g_detail6[10].xchb202b = g_detail6[2].xchb202b + g_detail6[3].xchb202b + g_detail6[4].xchb202b + g_detail6[5].xchb202b
#                                    + g_detail6[6].xchb202b + g_detail6[7].xchb202b + g_detail6[8].xchb202b + g_detail6[9].xchb202b
#         LET g_detail6[10].xchb208b = g_detail6[2].xchb208b + g_detail6[3].xchb208b + g_detail6[4].xchb208b + g_detail6[5].xchb208b
#                                    + g_detail6[6].xchb208b + g_detail6[7].xchb208b + g_detail6[8].xchb208b + g_detail6[9].xchb208b
#         LET g_detail6[10].xchb306b = g_detail6[2].xchb306b + g_detail6[3].xchb306b + g_detail6[4].xchb306b + g_detail6[5].xchb306b
#                                    + g_detail6[6].xchb306b + g_detail6[7].xchb306b + g_detail6[8].xchb306b + g_detail6[9].xchb306b
#         LET g_detail6[10].xchb210b = g_detail6[2].xchb210b + g_detail6[3].xchb210b + g_detail6[4].xchb210b + g_detail6[5].xchb210b
#                                    + g_detail6[6].xchb210b + g_detail6[7].xchb210b + g_detail6[8].xchb210b + g_detail6[9].xchb210b
#         LET g_detail6[10].xchb302b = g_detail6[2].xchb302b + g_detail6[3].xchb302b + g_detail6[4].xchb302b + g_detail6[5].xchb302b
#                                    + g_detail6[6].xchb302b + g_detail6[7].xchb302b + g_detail6[8].xchb302b + g_detail6[9].xchb302b  
#         LET g_detail6[10].xchb304b = g_detail6[2].xchb304b + g_detail6[3].xchb304b + g_detail6[4].xchb304b + g_detail6[5].xchb304b
#                                    + g_detail6[6].xchb304b + g_detail6[7].xchb304b + g_detail6[8].xchb304b + g_detail6[9].xchb304b
#         LET g_detail6[10].xchb308b = g_detail6[2].xchb308b + g_detail6[3].xchb308b + g_detail6[4].xchb308b + g_detail6[5].xchb308b
#                                    + g_detail6[6].xchb308b + g_detail6[7].xchb308b + g_detail6[8].xchb308b + g_detail6[9].xchb308b
#         LET g_detail6[10].xchb310b = g_detail6[2].xchb310b + g_detail6[3].xchb310b + g_detail6[4].xchb310b + g_detail6[5].xchb310b
#                                    + g_detail6[6].xchb310b + g_detail6[7].xchb310b + g_detail6[8].xchb310b + g_detail6[9].xchb310b
#         LET g_detail6[10].xchb902b = g_detail6[2].xchb902b + g_detail6[3].xchb902b + g_detail6[4].xchb902b + g_detail6[5].xchb902b
#                                    + g_detail6[6].xchb902b + g_detail6[7].xchb902b + g_detail6[8].xchb902b + g_detail6[9].xchb902b
      END IF  
   END IF
   
   CLOSE b_fill_cs2
   FREE b_fill_cs2  

   LET g_xchb_m2.xchb009_2 = g_xchb_m.xchb009
   LET g_xchb_m2.xchb009_2_desc = g_xchb_m.xchb009_desc
   LET g_xchb_m2.xchb009_2_desc_1 = g_xchb_m.xchb009_desc_1   
   LET g_xchb_m2.xchb010_2 = g_xchb_m.xchb010
   LET g_xchb_m2.xchb011_2 = g_xchb_m.xchb011
   LET g_xchb_m2.xchb002_2 = g_xchb_m.xchb002
   LET g_xchb_m2.xchb014_2 = g_xchb_m.xchb014
   LET g_xchb_m2.xchb014_2_desc = g_xchb_m.xchb014_desc
   LET g_xchb_m2.xchb015_2 = g_xchb_m.xchb015
   
   IF g_xchb_m2.xchb009_2 <> 'MAIN' THEN
      CALL s_desc_get_item_desc(g_xchb_m2.xchb009_2) RETURNING g_xchb_m2.xchb009_2_desc,g_xchb_m2.xchb009_2_desc_1
 
      SELECT imag014 INTO g_xchb_m.imag014_2
        FROM imag_t
       WHERE imagent  = g_enterprise
         AND imagsite = g_master.xchacomp
         AND imag001  = g_xchb_m.xchb009
      
      CALL s_desc_get_unit_desc(g_xchb_m.imag014_2)
            RETURNING g_xchb_m.imag014_2_desc  
   END IF         
   LET g_xchb_m2.imag014_3 = g_xchb_m.imag014_2
   LET g_xchb_m3.imag014_4 = g_xchb_m.imag014_2   
   LET g_xchb_m2.imag014_3_desc = g_xchb_m.imag014_2_desc 
   LET g_xchb_m3.imag014_4_desc = g_xchb_m.imag014_2_desc 
   
   LET g_xchb_m3.xchb009_3 = g_xchb_m.xchb009
   LET g_xchb_m3.xchb010_3 = g_xchb_m.xchb010
   LET g_xchb_m3.xchb011_3 = g_xchb_m.xchb011
   LET g_xchb_m3.xchb002_3 = g_xchb_m.xchb002
   LET g_xchb_m3.xchb009_3_desc = g_xchb_m.xchb009_desc
   LET g_xchb_m3.xchb009_3_desc_1 = g_xchb_m.xchb009_desc_1
   LET g_xchb_m3.xchb014_3 = g_xchb_m.xchb014
   LET g_xchb_m3.xchb014_3_desc = g_xchb_m.xchb014_desc
   LET g_xchb_m3.xchb015_3 = g_xchb_m.xchb015   
#抓成本阶
   SELECT DISTINCT xcbb006 INTO g_master.xcbb006
     FROM xcbb_t
    WHERE xcbbent  = g_enterprise
      AND xcbbcomp = g_master.xchacomp
      AND xcbb001  = g_master.xcha004
      AND xcbb002  = g_master.xcha005
      AND xcbb003  = g_master.xcha009   #不写特性，因为相同料号不同特性的xcbb成本阶一样的
      AND xcbb004  = g_master.xcha010
      
   IF SQLCA.SQLCODE=100 OR cl_null(g_master.xcha010) THEN
      SELECT DISTINCT xcbb006 INTO g_master.xcbb006
        FROM xcbb_t
       WHERE xcbbent  = g_enterprise
         AND xcbbcomp = g_master.xchacomp
         AND xcbb001  = g_master.xcha004
         AND xcbb002  = g_master.xcha005
         AND xcbb003  = g_master.xcha009  
   END IF 
   
#抓成本阶
   IF g_xchb_m.xchb009 <> 'MAIN' THEN
      SELECT DISTINCT xcbb006 INTO g_xchb_m.xcbb006_2
        FROM xcbb_t
       WHERE xcbbent  = g_enterprise
         AND xcbbcomp = g_master.xchacomp
         AND xcbb001  = g_master.xcha004
         AND xcbb002  = g_master.xcha005
         AND xcbb003  = g_xchb_m.xchb009   #不写特性，因为相同料号不同特性的xcbb成本阶一样的
         AND xcbb004  = g_xchb_m.xchb010
         
      IF SQLCA.SQLCODE=100 OR cl_null(g_xchb_m.xchb010) THEN
         SELECT DISTINCT xcbb006 INTO g_xchb_m.xcbb006_2
           FROM xcbb_t
          WHERE xcbbent  = g_enterprise
            AND xcbbcomp = g_master.xchacomp
            AND xcbb001  = g_master.xcha004
            AND xcbb002  = g_master.xcha005
            AND xcbb003  = g_xchb_m.xchb009 
      END IF 
   END IF   
   LET g_xchb_m2.xcbb006_3 = g_xchb_m.xcbb006_2
   LET g_xchb_m3.xcbb006_4 = g_xchb_m.xcbb006_2
   
   DISPLAY g_master.* TO b_xchacomp,b_xchacomp_desc,b_xchald,b_xchald_desc,b_xcha003,b_xcha003_desc, 
       b_xcha004,b_xcha005,b_xcha006,b_xcha009,b_xcha009_desc,b_xcha009_desc_1,b_xcha007,b_xcha007_desc, 
       b_xcha008,b_xcha010,imag014,imag014_desc,b_xcha012,b_xcha012_desc,b_xcha011,b_xcha002,b_xcha002_desc, 
       sfaa048,xcbb006
       
   DISPLAY g_xchb_m.xchb009,g_xchb_m.xchb009_desc,g_xchb_m.xchb009_desc_1,g_xchb_m.xchb010,g_xchb_m.imag014_2,g_xchb_m.imag014_2_desc,g_xchb_m.xcbb006_2,g_xchb_m.xchb011,g_xchb_m.xchb002,
           g_xchb_m.xchb014,g_xchb_m.xchb014_desc,g_xchb_m.xchb015   
        TO xchb009,xchb009_desc,xchb009_desc_1,xchb010,imag014_2,imag014_2_desc,xcbb006_2,xchb011,xchb002,xchb014,xchb014_desc,xchb015
        
   DISPLAY g_xchb_m2.xchb009_2,g_xchb_m2.xchb009_2_desc,g_xchb_m2.xchb009_2_desc_1,g_xchb_m2.xchb010_2,g_xchb_m2.imag014_3,g_xchb_m2.imag014_3_desc,g_xchb_m2.xcbb006_3,g_xchb_m2.xchb011_2,g_xchb_m2.xchb002_2,
           g_xchb_m2.xchb014_2,g_xchb_m2.xchb014_2_desc,g_xchb_m2.xchb015_2
        TO xchb009_2,xchb009_2_desc,xchb009_2_desc_1,xchb010_2,imag014_3,imag014_3_desc,xcbb006_3,xchb011_2,xchb002_2,xchb014_2,xchb014_2_desc,xchb015_2       

   DISPLAY g_xchb_m3.xchb009_3,g_xchb_m3.xchb009_3_desc,g_xchb_m3.xchb009_3_desc_1,g_xchb_m3.xchb010_3,g_xchb_m3.imag014_4,g_xchb_m3.imag014_4_desc,g_xchb_m3.xcbb006_4,g_xchb_m3.xchb011_3,g_xchb_m3.xchb002_3,
           g_xchb_m3.xchb014_3,g_xchb_m3.xchb014_3_desc,g_xchb_m3.xchb015_3
        TO xchb009_3,xchb009_3_desc,xchb009_3_desc_1,xchb010_3,imag014_4,imag014_4_desc,xcbb006_4,xchb011_3,xchb002_3,xchb014_3,xchb014_3_desc,xchb015_3    
   LET g_detail_cnt = g_detail.getLength()       
   RETURN       
             
                    
                   
              
                   
                     
                     
   #end add-point
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq571_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq571_detail_action_trans()
 
   CALL axcq571_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq571.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq571_b_fill2()
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
 
{<section id="axcq571.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq571_detail_show(ps_page)
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
 
   IF ps_page.getIndexOf("'5'",1) > 0 THEN
      #帶出公用欄位reference值page5
      
 
      #add-point:show段單身reference name="detail_show.body5.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'6'",1) > 0 THEN
      #帶出公用欄位reference值page6
      
 
      #add-point:show段單身reference name="detail_show.body6.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq571.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION axcq571_maintain_prog()
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
 
{<section id="axcq571.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axcq571_detail_action_trans()
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
 
{<section id="axcq571.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axcq571_detail_index_setting()
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
 
{<section id="axcq571.mask_functions" >}
 &include "erp/axc/axcq571_mask.4gl"
 
{</section>}
 
{<section id="axcq571.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 條件查詢
# Memo...........:
# Usage..........: CALL axcq571_query()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq571_query()
   
   LET INT_FLAG = 0
   CLEAR FORM
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   #LET ls_wc = g_wc
   #LET g_master_idx = l_ac

   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count 
   
   CALL axcq571_construct()
   
   CALL axcq571_cs()
   CALL axcq571_fetch("F")
   CALL axcq571_b_fill()
   #end add-point
        
   LET g_error_show = 1
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
   END IF   
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axcq571_construct()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq571_construct()
   CALL g_detail.clear()
   LET g_action_choice = ""
   INITIALIZE g_wc3 TO NULL
   INITIALIZE g_wc_filter TO NULL
   LET g_qryparam.state = 'c'
   CALL g_detail.clear()
   CALL g_detail2.clear()
   CALL g_detail3.clear()
   CALL g_detail4.clear()
   CALL g_detail5.clear()
   CALL g_detail6.clear()   
   CALL g_browser.clear()   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)         
             
      CONSTRUCT g_wc3 ON xchacomp,xchald,xcha003,xcha004,xcha005,xcha006,xcha009,xcha007,xcha008, 
                         xcha010,xcha012,xcha011,xcha002,xchb009,xchb010,xchb014,xchb015
                    FROM b_xchacomp,b_xchald,b_xcha003,b_xcha004,b_xcha005,b_xcha006,b_xcha009,b_xcha007,b_xcha008, 
                         b_xcha010,b_xcha012,b_xcha011,b_xcha002,xchb009,xchb010,xchb014,xchb015
                         
         BEFORE CONSTRUCT 
            INITIALIZE g_master.* TO NULL
            CALL s_axc_set_site_default() RETURNING g_master.xchacomp,g_master.xchald,g_master.xcha004,g_master.xcha005,g_master.xcha003
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xchacomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xchacomp_desc = '', g_rtn_fields[1] , ''
            #根據參數顯示隱藏成本域 和 料件特性
            IF cl_null(g_master.xchacomp) THEN
               CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
               CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否       
            ELSE
               CALL cl_get_para(g_enterprise,g_master.xchacomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
               CALL cl_get_para(g_enterprise,g_master.xchacomp,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否       
            END IF
                       
            IF g_para_data = 'Y' THEN
               CALL cl_set_comp_visible('xcha002,xcha002_desc',TRUE)                    
            ELSE
               CALL cl_set_comp_visible('xcha002,xcha002_desc',FALSE)                
            END IF         
        
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xchald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xchald_desc = '', g_rtn_fields[1] , ''
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xcha003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcha003_desc = '', g_rtn_fields[1] , ''
        
            DISPLAY g_master.* TO b_xchacomp,b_xchacomp_desc,b_xchald,b_xchald_desc,b_xcha003,b_xcha003_desc, 
                b_xcha004,b_xcha005,b_xcha006,b_xcha009,b_xcha009_desc,b_xcha009_desc_1,b_xcha007,b_xcha007_desc, 
                b_xcha008,b_xcha010,imag014,imag014_desc,b_xcha012,b_xcha012_desc,b_xcha011,b_xcha002,b_xcha002_desc, 
                sfaa048,xcbb006               
                            
         ON ACTION controlp INFIELD b_xchacomp
            #add-point:ON ACTION controlp INFIELD xchacomp name="construct.c.xchacomp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF            
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xchacomp   #顯示到畫面上
            NEXT FIELD b_xchacomp                    #返回原欄位                           
                     
         ON ACTION controlp INFIELD b_xchald
            #add-point:ON ACTION controlp INFIELD xchald name="construct.c.xchald"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept 
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF            
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xchald  #顯示到畫面上
            NEXT FIELD b_xchald                     #返回原欄位
            
         ON ACTION controlp INFIELD b_xcha003
            #add-point:ON ACTION controlp INFIELD xcha003 name="construct.c.xcha003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcha003  #顯示到畫面上
            NEXT FIELD b_xcha003                      
      
         ON ACTION controlp INFIELD b_xcha006
            #add-point:ON ACTION controlp INFIELD xcha006 name="construct.c.xcha006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = 'F'
            LET g_qryparam.where = " sfaa061 = 'Y' "
            CALL q_sfaadocno_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcha006  #顯示到畫面上
            NEXT FIELD b_xcha006     
            
         ON ACTION controlp INFIELD b_xcha009
            #add-point:ON ACTION controlp INFIELD xcha009 name="construct.c.xcha009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcha009  #顯示到畫面上
            NEXT FIELD b_xcha009                     #返回原欄位
      
         ON ACTION controlp INFIELD b_xcha007
            #add-point:ON ACTION controlp INFIELD xcha007 name="construct.c.xcha007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '221'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcha007  #顯示到畫面上
            NEXT FIELD b_xcha007      
            
         ON ACTION controlp INFIELD b_xcha010
            #add-point:ON ACTION controlp INFIELD xcha010 name="construct.c.xcha010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inam002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcha010  #顯示到畫面上
            NEXT FIELD b_xcha010                     #返回原欄位
            
         ON ACTION controlp INFIELD b_xcha012
            #add-point:ON ACTION controlp INFIELD xcha012 name="construct.c.xcha012"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcha012  #顯示到畫面上
            NEXT FIELD b_xcha012                     #返回原欄位   
      
         ON ACTION controlp INFIELD b_xcha002
            #add-point:ON ACTION controlp INFIELD xcha002 name="construct.c.xcha002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcha002  #顯示到畫面上
            NEXT FIELD b_xcha002                     #返回原欄位

         ON ACTION controlp INFIELD xchb009
            #add-point:ON ACTION controlp INFIELD xcha009 name="construct.c.xcha009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xchb009  #顯示到畫面上
            NEXT FIELD xchb009                     #返回原欄位
            
         ON ACTION controlp INFIELD xchb010
            #add-point:ON ACTION controlp INFIELD xcha009 name="construct.c.xcha009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inam002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xchb010        #顯示到畫面上
            NEXT FIELD xchb010                           #返回原欄位

         ON ACTION controlp INFIELD xchb014
            #add-point:ON ACTION controlp INFIELD xcha009 name="construct.c.xcha009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '221'
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xchb014  #顯示到畫面上
            NEXT FIELD xchb014                     #返回原欄位
            
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
END FUNCTION

 
{</section>}
 
