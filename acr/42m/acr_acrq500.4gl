#該程式已解開Section, 不再透過樣板產出!
{<section id="acrq500.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:1) Build-000088
#+ 
#+ Filename...: acrq500
#+ Description: 單一會員分析查詢作業
#+ Creator....: 02296(2014/05/29)
#+ Modifier...: 02296(2014/05/30)
#+ Buildtype..: 應用 q04 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="acrq500.global" >}
#160905-00007#1   2016-09-05  By08734        ent调整
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_master        RECORD
       mmaf001 LIKE type_t.chr30, 
   mmaf013 LIKE type_t.chr20, 
   mmaf008 LIKE type_t.chr500, 
   mmaf014 LIKE type_t.chr20, 
   mmaf009 LIKE type_t.chr500, 
   mmaf011 LIKE type_t.chr500, 
   sex LIKE type_t.chr80,
   sex_desc LIKE type_t.chr80,   
   age LIKE type_t.chr80, 
   mmaq018a LIKE type_t.num15_3, 
   mmaq016a LIKE type_t.num15_3, 
   decc021a LIKE type_t.num20_6, 
   decc021b LIKE type_t.num20_6, 
   mmaq013a LIKE type_t.dat, 
   daya LIKE type_t.num5, 
   weekend LIKE type_t.chr80, 
   rate LIKE type_t.num20_6, 
   mmaq015a LIKE type_t.num20_6, 
   rtia031a LIKE type_t.num20_6, 
   decc010a LIKE type_t.num20_6, 
   mmaq015b LIKE type_t.num20_6, 
   mmaq014a LIKE type_t.num5, 
   decc018a LIKE type_t.num20_6, 
   crba021a LIKE type_t.num15_3, 
   mmaq014b LIKE type_t.num5, 
   mmaq009a LIKE type_t.num20_6, 
   mmau009a LIKE type_t.num20_6, 
   mmau009b LIKE type_t.num20_6, 
   mmau009c LIKE type_t.num20_6, 
   mmau009d LIKE type_t.num20_6, 
   mmaucount LIKE type_t.num5, 
   mmau009e LIKE type_t.num20_6, 
   mmaqcount LIKE type_t.chr80, 
   mmaf020a LIKE type_t.chr10, 
   mmaf021a LIKE type_t.chr10, 
   radiogroup LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       sel            LIKE type_t.chr1,
       mmaq001 LIKE mmaq_t.mmaq001, 
   mmaq002 LIKE mmaq_t.mmaq002, 
   mmaq002_desc LIKE type_t.chr500, 
   mmaq003 LIKE mmaq_t.mmaq003, 
   mmaq003_desc LIKE type_t.chr500, 
   mmaq005 LIKE mmaq_t.mmaq005, 
   mmaq006 LIKE mmaq_t.mmaq006, 
   mmaq007 LIKE mmaq_t.mmaq007, 
   mmaq009 LIKE mmaq_t.mmaq009, 
   mmaq013 LIKE mmaq_t.mmaq013, 
   mmaq014 LIKE mmaq_t.mmaq014, 
   mmaq015 LIKE mmaq_t.mmaq015, 
   mmaq016 LIKE mmaq_t.mmaq016, 
   mmaq017 LIKE mmaq_t.mmaq017, 
   mmaq018 LIKE mmaq_t.mmaq018
       END RECORD
PRIVATE TYPE type_g_detail2 RECORD
       deca009f LIKE type_t.chr500, 
   deca009f_desc LIKE type_t.chr500, 
   deca010f LIKE type_t.chr500, 
   deca019f LIKE type_t.chr10, 
   deca019f_desc LIKE type_t.chr500, 
   deca022f LIKE type_t.num20_6, 
   decf027f LIKE type_t.num20_6, 
   deca030f LIKE type_t.num10, 
   deca025f LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_detail3 RECORD
       weeka LIKE type_t.chr80, 
   counta LIKE type_t.num20_6, 
   ratea LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_detail4 RECORD
       timea LIKE type_t.chr80, 
   timea_desc LIKE type_t.chr500, 
   moneya LIKE type_t.num20_6, 
   numbera LIKE type_t.num5, 
   rateb LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_detail5 RECORD
       calendar LIKE type_t.chr80, 
   moneyc LIKE type_t.num20_6, 
   numberc LIKE type_t.num5, 
   countc LIKE type_t.num5, 
   ratec LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_detail6 RECORD
       class LIKE type_t.chr80, 
   class_desc LIKE type_t.chr500, 
   moneyd LIKE type_t.num20_6, 
   numberd LIKE type_t.num5, 
   countd LIKE type_t.num5, 
   rated LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_detail7 RECORD
       oocq002a LIKE type_t.chr10, 
   oocq002a_desc LIKE type_t.chr500, 
   deca027s LIKE type_t.num20_6, 
   deca031s LIKE type_t.num20_6, 
   deca022s LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_detail8 RECORD
       deca002t LIKE type_t.chr20, 
   deca027t LIKE type_t.num20_6, 
   deca031t LIKE type_t.num20_6, 
   maxmoney LIKE type_t.num20_6, 
   avgmoney LIKE type_t.num20_6, 
   minmoney LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_detail9 RECORD
       rtjf025 LIKE type_t.dat, 
   rtjf003 LIKE type_t.num20_6, 
   rtjf022 LIKE type_t.num15_3
       END RECORD
 
PRIVATE TYPE type_g_detail10 RECORD
       weeku LIKE type_t.chr80, 
   rtjfsite LIKE type_t.chr10, 
   rtjfsite_desc LIKE type_t.chr500, 
   rtjf003u LIKE type_t.num20_6, 
   rtjf022u LIKE type_t.num15_3
       END RECORD
 
PRIVATE TYPE type_g_detail11 RECORD
       mmaq001v LIKE type_t.chr30, 
   mmaq002v LIKE type_t.chr10, 
   mmaq002v_desc LIKE type_t.chr500, 
   rtjf025v LIKE type_t.dat, 
   rtjfsitev LIKE type_t.chr10, 
   rtjfsitev_desc LIKE type_t.chr500, 
   rtjf003v LIKE type_t.num20_6, 
   rtjf022v LIKE type_t.num15_3
       END RECORD
 
PRIVATE TYPE type_g_detail12 RECORD
       rtjasite LIKE type_t.chr500, 
   rtjasite_desc LIKE type_t.chr500, 
   rtjadocno LIKE type_t.chr500, 
   rtja032 LIKE type_t.chr500, 
   rtja007 LIKE type_t.chr500, 
   rtja001 LIKE type_t.chr500, 
   rtjadocdt LIKE rtja_t.rtjadocdt, 
   rtja031 LIKE rtja_t.rtja031, 
   rtjb020 LIKE type_t.num20_6, 
   rtja016 LIKE rtja_t.rtja016
       END RECORD
 
PRIVATE TYPE type_g_detail13 RECORD
       yearw LIKE type_t.chr30, 
   ooga009 LIKE type_t.num5, 
   rankw LIKE type_t.num20_6, 
   rankw2 LIKE type_t.num20_6, 
   rankcount LIKE type_t.num20_6, 
   decc010 LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_detail14 RECORD
       crdc002 LIKE type_t.num5, 
   crdc003 LIKE type_t.num5, 
   crdc010 LIKE type_t.chr10, 
   crdc010_desc LIKE type_t.chr500, 
   crdcrate LIKE type_t.num15_3
       END RECORD
 
PRIVATE TYPE type_g_detail15 RECORD
       mmaq001x LIKE type_t.chr30, 
   mmaq002x LIKE type_t.chr10, 
   mmaq002x_desc LIKE type_t.chr500, 
   mmau006 LIKE mmau_t.mmau006, 
   mmaucountx LIKE type_t.num5, 
   mmau009 LIKE mmau_t.mmau009, 
   mmaq009x LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_detail16 RECORD
       ymonth LIKE type_t.chr10, 
   mmau018 LIKE type_t.chr500, 
   mmau018_desc LIKE type_t.chr500, 
   mmau009y LIKE type_t.num20_6, 
   mmaucounty LIKE type_t.num5, 
   mmau011 LIKE mmau_t.mmau011, 
   mmau012 LIKE mmau_t.mmau012
       END RECORD
 
PRIVATE TYPE type_g_detail17 RECORD
       mmau001 LIKE type_t.chr500, 
   mmaq002z LIKE type_t.chr10, 
   mmaq002z_desc LIKE type_t.chr500, 
   mmau006z LIKE type_t.dat, 
   mmau018z LIKE type_t.chr10, 
   mmau018z_desc LIKE type_t.chr500, 
   mmau009z LIKE type_t.num20_6, 
   mmau011z LIKE type_t.num20_6, 
   mmau012z LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_detail18 RECORD
       rtje001 LIKE type_t.chr500, 
   rtje002 LIKE rtje_t.rtje002, 
   rtje002_desc LIKE type_t.chr500, 
   rtje006 LIKE rtje_t.rtje006, 
   rtje004 LIKE rtje_t.rtje004
       END RECORD
 
PRIVATE TYPE type_g_detail19 RECORD
       rtjbseq LIKE type_t.chr500, 
   rtjb003 LIKE type_t.chr500, 
   rtjb004 LIKE type_t.chr500, 
   rtjb004_desc LIKE type_t.chr500, 
   rtjb008 LIKE rtjb_t.rtjb008, 
   rtjb009 LIKE rtjb_t.rtjb009, 
   rtjb010 LIKE rtjb_t.rtjb010, 
   rtjb013 LIKE rtjb_t.rtjb013, 
   rtjb013_desc LIKE type_t.chr500, 
   rtjb012 LIKE rtjb_t.rtjb012, 
   rtjb020 LIKE rtjb_t.rtjb020, 
   rtjb021 LIKE rtjb_t.rtjb021, 
   rtjb025 LIKE rtjb_t.rtjb025, 
   rtjb026 LIKE rtjb_t.rtjb026, 
   rtjb027 LIKE rtjb_t.rtjb027, 
   rtjb028 LIKE rtjb_t.rtjb028
       END RECORD
 
PRIVATE TYPE type_g_detail20 RECORD
       deca013a LIKE type_t.chr20, 
   deca013a_desc LIKE type_t.chr500, 
   deca031 LIKE type_t.num20_6, 
   deca033a LIKE type_t.num20_6, 
   deca027a LIKE type_t.num20_6, 
   deca025a LIKE type_t.num20_6, 
   deca026a LIKE type_t.num20_6, 
   deca028a LIKE type_t.num20_6, 
   deca028b LIKE type_t.num20_6, 
   deca030a LIKE type_t.num10
       END RECORD
 
PRIVATE TYPE type_g_detail21 RECORD
       deca002b LIKE type_t.chr10, 
   decasiteb LIKE type_t.chr10, 
   decasitea_desc LIKE type_t.chr500, 
   deca027b LIKE type_t.num20_6, 
   deca031b LIKE type_t.num20_6, 
   deca030b LIKE type_t.num10, 
   deca033b LIKE type_t.num20_6, 
   deca025b LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_detail22 RECORD
       deca009c LIKE type_t.chr500, 
   deca009c_desc LIKE type_t.chr500, 
   deca010c LIKE type_t.chr500, 
   deca019c LIKE type_t.chr10, 
   deca022c LIKE type_t.num20_6, 
   deca027c LIKE type_t.num20_6, 
   deca030c LIKE type_t.num10, 
   deca025c LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_detail23 RECORD
       deca016d LIKE type_t.chr10, 
   deca016d_desc LIKE type_t.chr500, 
   deca031d LIKE type_t.num20_6, 
   deca033d LIKE type_t.num20_6, 
   deca027d LIKE type_t.num20_6, 
   deca025d LIKE type_t.num20_6, 
   deca026d LIKE type_t.num20_6, 
   deca028d LIKE type_t.num20_6, 
   decacount LIKE type_t.num20_6, 
   deca030d LIKE type_t.num10
       END RECORD
 
PRIVATE TYPE type_g_detail24 RECORD
       deca002e LIKE type_t.chr10, 
   decasitee LIKE type_t.chr10, 
   decasitee_desc LIKE type_t.chr500, 
   deca027e LIKE type_t.num20_6, 
   deca031e LIKE type_t.num20_6, 
   deca030e LIKE type_t.num10, 
   deca033e LIKE type_t.num20_6, 
   deca025e LIKE type_t.num20_6
       END RECORD
 
 
 
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
 
DEFINE g_detail7     DYNAMIC ARRAY OF type_g_detail7
DEFINE g_detail7_t   type_g_detail7
 
DEFINE g_detail8     DYNAMIC ARRAY OF type_g_detail8
DEFINE g_detail8_t   type_g_detail8
 
DEFINE g_detail9     DYNAMIC ARRAY OF type_g_detail9
DEFINE g_detail9_t   type_g_detail9
 
DEFINE g_detail10     DYNAMIC ARRAY OF type_g_detail10
DEFINE g_detail10_t   type_g_detail10
 
DEFINE g_detail11     DYNAMIC ARRAY OF type_g_detail11
DEFINE g_detail11_t   type_g_detail11
 
DEFINE g_detail12     DYNAMIC ARRAY OF type_g_detail12
DEFINE g_detail12_t   type_g_detail12
 
DEFINE g_detail13     DYNAMIC ARRAY OF type_g_detail13
DEFINE g_detail13_t   type_g_detail13
 
DEFINE g_detail14     DYNAMIC ARRAY OF type_g_detail14
DEFINE g_detail14_t   type_g_detail14
 
DEFINE g_detail15     DYNAMIC ARRAY OF type_g_detail15
DEFINE g_detail15_t   type_g_detail15
 
DEFINE g_detail16     DYNAMIC ARRAY OF type_g_detail16
DEFINE g_detail16_t   type_g_detail16
 
DEFINE g_detail17     DYNAMIC ARRAY OF type_g_detail17
DEFINE g_detail17_t   type_g_detail17
 
DEFINE g_detail18     DYNAMIC ARRAY OF type_g_detail18
DEFINE g_detail18_t   type_g_detail18
 
DEFINE g_detail19     DYNAMIC ARRAY OF type_g_detail19
DEFINE g_detail19_t   type_g_detail19
 
DEFINE g_detail20     DYNAMIC ARRAY OF type_g_detail20
DEFINE g_detail20_t   type_g_detail20
 
DEFINE g_detail21     DYNAMIC ARRAY OF type_g_detail21
DEFINE g_detail21_t   type_g_detail21
 
DEFINE g_detail22     DYNAMIC ARRAY OF type_g_detail22
DEFINE g_detail22_t   type_g_detail22
 
DEFINE g_detail23     DYNAMIC ARRAY OF type_g_detail23
DEFINE g_detail23_t   type_g_detail23
 
DEFINE g_detail24     DYNAMIC ARRAY OF type_g_detail24
DEFINE g_detail24_t   type_g_detail24
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_cnt_sql             STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num5              #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num5
DEFINE g_detail_cnt          LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_master_idx          LIKE type_t.num5
DEFINE g_detail_idx          LIKE type_t.num5              #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num5
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_msg                 STRING
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_row_count           LIKE type_t.num10
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數(Module Variable)
 TYPE type_g_mmaf        RECORD
       mmaf001 LIKE type_t.chr30, 
       COUNT   LIKE type_t.num10
       END RECORD
DEFINE g_wc2_table1  STRING
DEFINE g_wc2_table2  STRING
DEFINE g_wc2_table3  STRING
DEFINE g_wc2_table4  STRING
DEFINE g_wc3         STRING
DEFINE l_year        LIKE type_t.num5
DEFINE l_year_str    STRING
DEFINE l_date1       LIKE type_t.dat
DEFINE l_date2       LIKE type_t.dat
DEFINE l_wc          STRING
DEFINE l_wc1          STRING
DEFINE l_flag        LIKE type_t.chr1   #品类级别
DEFINE l_year2        LIKE type_t.num5
DEFINE l_year_str2    STRING
DEFINE l_date3       LIKE type_t.dat
DEFINE l_year3       LIKE type_t.num5
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="acrq500.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("acr","")
 
   #add-point:作業初始化
   LET l_year = YEAR(g_today)
   LET l_year_str = l_year,'01','01'
   LET l_date1 = l_year_str
   LET l_year_str = l_year,'12','31'
   LET l_date2 = l_year_str
   LET l_wc = " deca002 >= '",l_date1,"' AND deca002 <= '",l_date2,"'"
   LET l_wc1 = " decc002 >= '",l_date1,"' AND decc002 <= '",l_date2,"'"
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   CALL acrq500_create_tmp()
   #end add-point
   LET g_forupd_sql = ""
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE acrq500_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE ",
               " FROM ",
               " WHERE  "
   #add-point:SQL_define
   
   #end add-point
   PREPARE acrq500_master_referesh FROM g_sql
 
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE acrq500_bcl CURSOR FROM g_forupd_sql
 
 
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      
      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrq500 WITH FORM cl_ap_formpath("acr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL acrq500_init()   
 
      #進入選單 Menu (="N")
      CALL acrq500_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_acrq500
      
   END IF 
   
   CLOSE acrq500_cl
   
   
 
   #add-point:作業離開前
   DROP TABLE acrq500_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="acrq500.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION acrq500_init()
 
   #add-point:init段define
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
#  LET g_selcolor    = "#D0E7FD"
   
      CALL cl_set_combo_scc('b_mmaq006','6515') 
  
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('weekend','30')
   CALL cl_set_combo_scc('rtja032','6544')
   CALL cl_set_combo_scc('rtje001','8310')
   CALL cl_set_combo_scc('weeka','30')
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="acrq500.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrq500_ui_dialog() 
   {<Local define>}
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_result STRING
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   {</Local define>}
   #add-point:ui_dialog段define

   #end add-point
 
   CLEAR FORM  
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_row = 0
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET g_main_hidden = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog 

   #end add-point
 
   
  
   WHILE li_exit = FALSE
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落

         #end add-point
 
         #add-point:construct段落

         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_detail.getLength() TO FORMONLY.cnt
               LET g_master_idx = l_ac
               CALL acrq500_b_fill2()
 
               #add-point:input段before row

               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail2 TO s_detail10.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 2
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail10")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail2.getLength() TO FORMONLY.cnt
               #end add-point
            #自訂ACTION(detail_show,page_2)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail3 TO s_detail11.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 3
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail11")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail3.getLength() TO FORMONLY.cnt
               #end add-point
            #自訂ACTION(detail_show,page_3)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail4 TO s_detail12.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 4
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail12")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail4.getLength() TO FORMONLY.cnt
               #end add-point
            #自訂ACTION(detail_show,page_4)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail5 TO s_detail13.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 5
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail13")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail5.getLength() TO FORMONLY.cnt
               CALL acrq500_b_fill7(l_ac)
               #end add-point
            #自訂ACTION(detail_show,page_5)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail6 TO s_detail14.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 6
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail14")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail6.getLength() TO FORMONLY.cnt
               #end add-point
            #自訂ACTION(detail_show,page_6)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail7 TO s_detail15.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 7
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail15")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail7.getLength() TO FORMONLY.cnt
               #end add-point
            #自訂ACTION(detail_show,page_7)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail8 TO s_detail16.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 8
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail16")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail8.getLength() TO FORMONLY.cnt
               
               #end add-point
            #自訂ACTION(detail_show,page_8)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail9 TO s_detail17.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 9
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail17")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail9.getLength() TO FORMONLY.cnt
               #end add-point
            #自訂ACTION(detail_show,page_9)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail10 TO s_detail18.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 10
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail18")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail10.getLength() TO FORMONLY.cnt
               #end add-point
            #自訂ACTION(detail_show,page_10)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail11 TO s_detail19.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 11
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail19")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail11.getLength() TO FORMONLY.cnt
               #end add-point
            #自訂ACTION(detail_show,page_11)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail12 TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 12
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail12.getLength() TO FORMONLY.cnt
               CALL acrq500_b_fill4()
               #end add-point
            #自訂ACTION(detail_show,page_12)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail13 TO s_detail20.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 13
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail20")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail13.getLength() TO FORMONLY.cnt
               
               #end add-point
            #自訂ACTION(detail_show,page_13)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail14 TO s_detail21.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 14
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail21")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail14.getLength() TO FORMONLY.cnt
               #end add-point
            #自訂ACTION(detail_show,page_14)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail15 TO s_detail22.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 15
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail22")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail15.getLength() TO FORMONLY.cnt
               #end add-point
            #自訂ACTION(detail_show,page_15)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail16 TO s_detail23.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 16
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail23")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail16.getLength() TO FORMONLY.cnt
               #end add-point
            #自訂ACTION(detail_show,page_16)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail17 TO s_detail24.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 17
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail24")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail17.getLength() TO FORMONLY.cnt
               #end add-point
            #自訂ACTION(detail_show,page_17)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail18 TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 18
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail18.getLength() TO FORMONLY.cnt
               #end add-point
            #自訂ACTION(detail_show,page_18)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail19 TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 19
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail19.getLength() TO FORMONLY.cnt
               #end add-point
            #自訂ACTION(detail_show,page_19)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail20 TO s_detail5.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 20
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail20.getLength() TO FORMONLY.cnt
               call acrq500_b_fill5(l_ac)
               #end add-point
            #自訂ACTION(detail_show,page_20)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail21 TO s_detail6.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 21
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail6")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail21.getLength() TO FORMONLY.cnt
               #end add-point
            #自訂ACTION(detail_show,page_21)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail22 TO s_detail7.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 22
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail7")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail22.getLength() TO FORMONLY.cnt
               #end add-point
            #自訂ACTION(detail_show,page_22)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail23 TO s_detail8.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 23
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail8")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail23.getLength() TO FORMONLY.cnt
               CALL acrq500_b_fill6(l_ac)
               #end add-point
            #自訂ACTION(detail_show,page_23)
            
         END DISPLAY
 
         DISPLAY ARRAY g_detail24 TO s_detail9.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 24
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail9")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               DISPLAY g_detail24.getLength() TO FORMONLY.cnt
               #end add-point
            #自訂ACTION(detail_show,page_24)
            
         END DISPLAY
 
 
 
         #add-point:ui_dialog段define

         #end add-point
    
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
  
         BEFORE DIALOG
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL acrq500_fetch('')
 
            #add-point:ui_dialog段before dialog

            #end add-point
            NEXT FIELD sel
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog

            #end add-point
            
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               LET g_main_hidden = 0
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_detail)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_detail2)
               LET g_export_id[2]   = "s_detail10"
               LET g_export_node[3] = base.typeInfo.create(g_detail3)
               LET g_export_id[3]   = "s_detail11"
               LET g_export_node[4] = base.typeInfo.create(g_detail4)
               LET g_export_id[4]   = "s_detail12"
               LET g_export_node[5] = base.typeInfo.create(g_detail5)
               LET g_export_id[5]   = "s_detail13"
               LET g_export_node[6] = base.typeInfo.create(g_detail6)
               LET g_export_id[6]   = "s_detail14"
               LET g_export_node[7] = base.typeInfo.create(g_detail7)
               LET g_export_id[7]   = "s_detail15"
               LET g_export_node[8] = base.typeInfo.create(g_detail8)
               LET g_export_id[8]   = "s_detail16"
               LET g_export_node[9] = base.typeInfo.create(g_detail9)
               LET g_export_id[9]   = "s_detail17"
               LET g_export_node[10] = base.typeInfo.create(g_detail10)
               LET g_export_id[10]   = "s_detail18"
               LET g_export_node[11] = base.typeInfo.create(g_detail11)
               LET g_export_id[11]   = "s_detail19"
               LET g_export_node[12] = base.typeInfo.create(g_detail12)
               LET g_export_id[12]   = "s_detail2"
               LET g_export_node[13] = base.typeInfo.create(g_detail13)
               LET g_export_id[13]   = "s_detail20"
               LET g_export_node[14] = base.typeInfo.create(g_detail14)
               LET g_export_id[14]   = "s_detail21"
               LET g_export_node[15] = base.typeInfo.create(g_detail15)
               LET g_export_id[15]   = "s_detail22"
               LET g_export_node[16] = base.typeInfo.create(g_detail16)
               LET g_export_id[16]   = "s_detail23"
               LET g_export_node[17] = base.typeInfo.create(g_detail17)
               LET g_export_id[17]   = "s_detail24"
               LET g_export_node[18] = base.typeInfo.create(g_detail18)
               LET g_export_id[18]   = "s_detail3"
               LET g_export_node[19] = base.typeInfo.create(g_detail19)
               LET g_export_id[19]   = "s_detail4"
               LET g_export_node[20] = base.typeInfo.create(g_detail20)
               LET g_export_id[20]   = "s_detail5"
               LET g_export_node[21] = base.typeInfo.create(g_detail21)
               LET g_export_id[21]   = "s_detail6"
               LET g_export_node[22] = base.typeInfo.create(g_detail22)
               LET g_export_id[22]   = "s_detail7"
               LET g_export_node[23] = base.typeInfo.create(g_detail23)
               LET g_export_id[23]   = "s_detail8"
               LET g_export_node[24] = base.typeInfo.create(g_detail24)
               LET g_export_id[24]   = "s_detail9"
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
            #end add-point
 
         ON ACTION exit
            CLEAR FORM
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            CLEAR FORM
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
 
            CALL acrq500_cs()
            NEXT FIELD sel   # 為了讓一開始的focus停留在單頭
      
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
 
         ON ACTION datarefresh   # 重新整理
            CALL acrq500_fetch('F')
 
         ON ACTION first   # 第一筆
            CALL acrq500_fetch('F')
 
         ON ACTION previous   # 上一筆
            CALL acrq500_fetch('P')
 
         ON ACTION jump   # 跳至第幾筆
            CALL acrq500_fetch('/')
 
         ON ACTION next   # 下一筆
            CALL acrq500_fetch('N')
 
         ON ACTION last   # 最後一筆
            CALL acrq500_fetch('L')
 
         
 
         
         #+ 此段落由子樣板a43產生
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION hdeca_query
            LET g_action_choice="hdeca_query"
            IF cl_auth_chk_act("hdeca_query") THEN
               
               #add-point:ON ACTION hdeca_query
               CALL cl_set_act_visible("accept,cancel", TRUE)
               LET l_ac = DIALOG.getCurrentRow("s_detail1") 
               IF not cl_null(g_master.mmaf001) THEN
                  CALL acrq500_construct_deca()
                  CALL acrq500_b_fill8()
               END IF 
               CALL cl_set_act_visible("accept,cancel", FALSE)               
               CONTINUE DIALOG
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query
               CALL cl_set_act_visible("accept,cancel", TRUE)
               CALL acrq500_query()
               CALL cl_set_act_visible("accept,cancel", FALSE)
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION high_query
            LET g_action_choice="high_query"
            IF cl_auth_chk_act("high_query") THEN
               
               #add-point:ON ACTION high_query
               LET l_ac = DIALOG.getCurrentRow("s_detail1") 
               IF not cl_null(g_master.mmaf001) THEN
                  CALL acrq500_construct_rtja()
                  CALL acrq500_b_fill3(g_wc3)
               END IF  
               CONTINUE DIALOG 
               #END add-point
               EXIT DIALOG
            END IF
 
 
      
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="acrq500.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION acrq500_cs()
   #add-point:cs段define
 
   #end add-point
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF g_wc2 = " 1=1" THEN
      #add-point:cs段單頭sql組成(未下單身條件)
      LET g_sql = " SELECT DISTINCT mmaf001 ",
                  "   FROM mmaf_t ",
                  "        LEFT JOIN mmag_t ON mmagent=mmafent AND mmag001=mmaf001 AND mmag002='01' AND mmag003='2016' ", 
                  "  WHERE mmafent=",g_enterprise," AND ",g_wc
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件)
      LET g_sql = " SELECT DISTINCT mmaf001 ",
                  "   FROM mmaf_t LEFT JOIN mmaq_t ON mmaqent=mmafent AND mmaq003=mmaf001 ",
                  "        LEFT JOIN mmag_t ON mmagent=mmafent AND mmag001=mmaf001 AND mmag002='01' AND mmag003='2016' ", 
                  "  WHERE mmafent=",g_enterprise," AND ",g_wc," AND ",g_wc2
      #end add-point
   END IF
 
   PREPARE acrq500_pre FROM g_sql
   DECLARE acrq500_curs SCROLL CURSOR WITH HOLD FOR acrq500_pre
   OPEN acrq500_curs
 
   #add-point:cs段單頭總筆數計算
   IF g_wc2 = " 1=1" THEN
      #add-point:cs段單頭sql組成(未下單身條件)
      LET g_cnt_sql = " SELECT count(mmaf001)",
                  "   FROM mmaf_t ",
                  "        LEFT JOIN mmag_t ON mmagent=mmafent AND mmag001=mmaf001 AND mmag002='01' AND mmag003='2016' ", 
                  "  WHERE mmafent=",g_enterprise," AND ",g_wc
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件)
      LET g_cnt_sql = " SELECT count(mmaf001) ",
                  "   FROM (SELECT DISTINCT mmaf001 ",
                  "   FROM mmaf_t LEFT JOIN mmaq_t ON mmaqent=mmafent AND mmaq003=mmaf001 ",
                  "        LEFT JOIN mmag_t ON mmagent=mmafent AND mmag001=mmaf001 AND mmag002='01' AND mmag003='2016' ", 
                  "  WHERE mmafent=",g_enterprise," AND ",g_wc," AND ",g_wc2,")"
      #end add-point
   END IF
   #end add-point
   PREPARE acrq500_precount FROM g_cnt_sql
   EXECUTE acrq500_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
   ELSE
      CALL acrq500_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="acrq500.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION acrq500_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define
   INITIALIZE g_master.* TO NULL
   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #+ 此段落由子樣板qs18產生
   #add-point:fetch段CURSOR移動

    CASE p_flag
        WHEN 'N' FETCH NEXT     acrq500_curs INTO g_master.mmaf001
        WHEN 'P' FETCH PREVIOUS acrq500_curs INTO g_master.mmaf001
        WHEN 'F' FETCH FIRST    acrq500_curs INTO g_master.mmaf001
        WHEN 'L' FETCH LAST     acrq500_curs INTO g_master.mmaf001
        WHEN '/'
            IF (NOT g_no_ask) THEN
               CALL cl_set_act_visible("accept,cancel", TRUE)
               CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
               LET INT_FLAG = 0  ######add for prompt bug
               PROMPT ls_msg CLIPPED,': ' FOR g_jump
                  #交談指令共用ACTION
                  &include "common_action.4gl" 
               END PROMPT
               IF INT_FLAG THEN
                   LET INT_FLAG = 0
                   EXIT CASE
               END IF
            END IF
            FETCH ABSOLUTE g_jump acrq500_curs INTO g_master.mmaf001
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF
            
            LET g_no_ask = FALSE
    END CASE
   #end add-point
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO mmaf001,mmaf013,mmaf008,mmaf014,mmaf009,mmaf011,sex,sex_desc,age,mmaq018a, 
          mmaq016a,decc021a,decc021b,mmaq013a,daya,weekend,rate,mmaq015a,rtia031a,decc010a,mmaq015b, 
          mmaq014a,decc018a,crba021a,mmaq014b,mmaq009a,mmau009a,mmau009b,mmau009c,mmau009d,mmaucount, 
          mmau009e,mmaqcount,mmaf020a,mmaf021a,radiogroup
      CALL g_detail.clear()
      CALL g_detail2.clear()
 
      CALL g_detail3.clear()
 
      CALL g_detail4.clear()
 
      CALL g_detail5.clear()
 
      CALL g_detail6.clear()
 
      CALL g_detail7.clear()
 
      CALL g_detail8.clear()
 
      CALL g_detail9.clear()
 
      CALL g_detail10.clear()
 
      CALL g_detail11.clear()
 
      CALL g_detail12.clear()
 
      CALL g_detail13.clear()
 
      CALL g_detail14.clear()
 
      CALL g_detail15.clear()
 
      CALL g_detail16.clear()
 
      CALL g_detail17.clear()
 
      CALL g_detail18.clear()
 
      CALL g_detail19.clear()
 
      CALL g_detail20.clear()
 
      CALL g_detail21.clear()
 
      CALL g_detail22.clear()
 
      CALL g_detail23.clear()
 
      CALL g_detail24.clear()
 
 
      #add-point:陣列清空

      #end add-point
      DISPLAY '' TO FORMONLY.h_index
      DISPLAY '' TO FORMONLY.h_count
      DISPLAY '' TO FORMONLY.idx
      DISPLAY '' TO FORMONLY.cnt
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '-100'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
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
 
   #add-point:fetch結束前
   IF NOT cl_null(g_master.mmaf001) THEN
      CALL acrq500_display_all()
   END IF   
   #end add-point
 
   #重新顯示
   CALL acrq500_show()
   LET l_ac = 1
   CALL acrq500_b_fill4()
   DISPLAY ARRAY g_detail18 TO s_detail3.*
      ATTRIBUTES(COUNT=g_detail_cnt)
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
    
   DISPLAY ARRAY g_detail19 TO s_detail4.*
      ATTRIBUTES(COUNT=g_detail_cnt)
      BEFORE DISPLAY
         EXIT DISPLAY
      
   END DISPLAY
END FUNCTION
 
{</section>}
 
{<section id="acrq500.show" >}
PRIVATE FUNCTION acrq500_show()
   #add-point:show段define
   
   #end add-point
 
   DISPLAY g_master.* TO mmaf001,mmaf013,mmaf008,mmaf014,mmaf009,mmaf011,sex,sex_desc,age,mmaq018a,mmaq016a, 
       decc021a,decc021b,mmaq013a,daya,weekend,rate,mmaq015a,rtia031a,decc010a,mmaq015b,mmaq014a,decc018a, 
       crba021a,mmaq014b,mmaq009a,mmau009a,mmau009b,mmau009c,mmau009d,mmaucount,mmau009e,mmaqcount,mmaf020a, 
       mmaf021a,radiogroup
 
   #讀入ref值
   #add-point:show段單身reference
   
   #end add-point
 
   CALL acrq500_b_fill()
END FUNCTION
 
{</section>}
 
{<section id="acrq500.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION acrq500_b_fill()
   {<Local define>}
   DEFINE ls_wc           STRING
   {</Local define>}
   #add-point:b_fill段define
   DEFINE l_sql           STRING
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_count         LIKE type_t.num10
   DEFINE i               LIKE type_t.num5
   DEFINE l_days          LIKE type_t.num5
   DEFINE l_month         LIKE type_t.num5
   DEFINE l_year          LIKE type_t.num5
   DEFINE l_date3         LIKE type_t.dat
   DEFINE l_date4         LIKE type_t.dat
   DEFINE l_startdate     LIKE type_t.dat
   DEFINE l_enddate       LIKE type_t.dat
   DEFINE l_crdc010       LIKE crdc_t.crdc010
   DEFINE l_rtjacount     LIKE type_t.num20_6
   DEFINE l_ratea         LIKE type_t.num20_6
   DEFINE l_rateb         LIKE type_t.num20_6
   DEFINE l_count12       LIKE type_t.num5
   DEFINE l_count1        LIKE type_t.num5
   DEFINE l_count2        LIKE type_t.num5
   DEFINE l_mmaf001       LIKE mmaf_t.mmaf001
   DEFINE l_decc010       LIKE type_t.num10
   DEFINE l_crdc010_sum   LIKE type_t.num10
   
   #end add-point
 
   #add-point:b_fill段sql_before
   IF cl_null(l_wc1) THEN
      LET l_wc1=" 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2=" 1=1"
   END IF
   LET l_ratea=0
   LET l_rateb=0
   LET l_count12=0
   LET l_count1=0
   #end add-point
 
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   CALL g_detail.clear()
 
   #add-point:陣列清空
   CALL g_detail.clear()
   CALL g_detail2.clear()
   CALL g_detail3.clear()
   CALL g_detail4.clear()
   CALL g_detail5.clear()
   CALL g_detail6.clear()
   CALL g_detail7.clear()
   CALL g_detail8.clear()
   CALL g_detail9.clear()
   CALL g_detail10.clear()
   CALL g_detail11.clear()
   CALL g_detail12.clear()
   CALL g_detail13.clear()
   CALL g_detail14.clear()
   CALL g_detail15.clear()
   CALL g_detail16.clear()
   CALL g_detail17.clear()
   CALL g_detail18.clear()
   CALL g_detail19.clear()
   CALL g_detail20.clear()
   CALL g_detail21.clear()
   CALL g_detail22.clear()
   CALL g_detail23.clear()
   CALL g_detail24.clear()
   LET g_cnt = l_ac
   LET l_sql = "SELECT 'N',mmaq001,mmaq002,'',mmaq003,'',mmaq005,mmaq006,mmaq007,mmaq009,mmaq013,mmaq014,",
               "      mmaq015,mmaq016,mmaq017,mmaq018 ",
               "  FROM mmaq_t ",
               " WHERE mmaqent=? AND mmaq003=? "
   IF NOT cl_null(g_wc2_table1) THEN
      LET l_sql = l_sql," AND ",g_wc2_table1
   END IF 
   LET l_sql = l_sql," ORDER BY mmaq001,mmaq002"   
   PREPARE l_sql_mmaq001_pre1 FROM l_sql
   DECLARE l_sql_mmaq001_cs1  CURSOR FOR l_sql_mmaq001_pre1
   
   LET l_sql = " SELECT DISTINCT rtjasite,'',rtjadocno,rtja032,rtja007,rtja001,rtjadocdt,rtja031,'',rtja016 ",
               "   FROM rtja_t LEFT JOIN mmaq_t ON rtja001 = mmaq001 AND rtjaent=mmaqent ",
               "  WHERE rtjaent=? AND mmaq003=? AND ",g_wc2_table1
   IF NOT cl_null(g_wc2_table2) THEN
      LET l_sql = l_sql," AND ",g_wc2_table2
   END IF 
   LET l_sql = l_sql," ORDER BY rtjadocno,rtja001 "    
   PREPARE l_sql_rtja_pre2 FROM l_sql
   DECLARE l_sql_rtja_cs2 CURSOR FOR l_sql_rtja_pre2
   
   LET l_sql = " SELECT DISTINCT rtje001,rtje002,'',rtje006,rtje004 ",
               "   FROM rtje_t ",
               "  WHERE rtjeent=? AND rtjedocno=? "
   IF NOT cl_null(g_wc2_table3) THEN
      LET l_sql = l_sql," AND ",g_wc2_table3
   END IF 
   LET l_sql = l_sql," ORDER BY rtje001,rtje002 "    
   PREPARE l_sql_rtje_pre3 FROM l_sql
   DECLARE l_sql_rtje_cs3 CURSOR FOR l_sql_rtje_pre3
   
   LET l_sql = " SELECT DISTINCT rtjbseq,rtjb003,rtjb004,'',rtjb008,rtjb009,rtjb010,rtjb013,'',rtjb012,rtjb020,rtjb021,rtjb025,rtjb026,rtjb027,rtjb028 ",
               "   FROM rtjb_t ",
               "  WHERE rtjbent=? AND rtjbdocno=? "
   IF NOT cl_null(g_wc2_table4) THEN
      LET l_sql = l_sql," AND ",g_wc2_table4
   END IF 
   LET l_sql = l_sql," ORDER BY rtjbseq,rtjb004 "    
   PREPARE l_sql_rtjb_pre4 FROM l_sql
   DECLARE l_sql_rtjb_cs4 CURSOR FOR l_sql_rtjb_pre4
   
   LET l_sql = " SELECT deca013,'',sum(deca031),sum(deca033),sum(deca027),sum(deca025-deca027),sum(deca026),sum(deca028),sum(deca028)/sum(deca026),sum(deca030) ",
               "   FROM deca_t ",
               "  WHERE decaent=? AND deca020 = ? GROUP BY deca013,'' "  
   LET l_sql = l_sql," ORDER BY deca013 "    
   PREPARE l_sql_deca_pre5 FROM l_sql
   DECLARE l_sql_deca_cs5 CURSOR FOR l_sql_deca_pre5
    
   
   LET l_sql = " SELECT to_char(deca002,'YYYYMM'),decasite,'',sum(deca027),sum(deca031),sum(deca030),sum(deca033),sum(deca025-deca027) ",
               "   FROM deca_t LEFT JOIN ooga_t ON ooga001=deca002 AND oogaent = decaent  ",
               "  WHERE decaent=? AND deca020 = ? AND deca013=? AND ",l_wc  
   LET l_sql = l_sql," GROUP BY to_char(deca002,'YYYYMM'),decasite,''  ORDER BY to_char(deca002,'YYYYMM'),decasite,'' "    
   PREPARE l_sql_deca_pre6 FROM l_sql
   DECLARE l_sql_deca_cs6 CURSOR FOR l_sql_deca_pre6

   LET l_sql = " SELECT deca009,'',deca010,deca019,sum(deca022),sum(deca027),sum(deca030),sum(deca025-deca027) ",
               "   FROM deca_t ",
               "  WHERE decaent=? AND deca020 = ? AND deca013=? GROUP BY deca009,'',deca010,deca019,'' "  
   LET l_sql = l_sql," ORDER BY deca009,'',deca010,deca019,'' "    
   PREPARE l_sql_deca_pre7 FROM l_sql
   DECLARE l_sql_deca_cs7 CURSOR FOR l_sql_deca_pre7
   
   LET l_sql = " SELECT deca016,'',sum(deca031),sum(deca033),sum(deca027),sum(deca025-deca027),sum(deca026),sum(deca028),sum(deca028)/sum(deca026),sum(deca030) ",
               "   FROM deca_t ",
               "  WHERE decaent=? AND deca020 = ? GROUP BY deca016,'' "  
   LET l_sql = l_sql," ORDER BY deca016 "    
   PREPARE l_sql_deca_pre8 FROM l_sql
   DECLARE l_sql_deca_cs8 CURSOR FOR l_sql_deca_pre8
    
   
   LET l_sql = " SELECT to_char(deca002,'YYYYMM'),decasite,'',sum(deca027),sum(deca031),sum(deca030),sum(deca033),sum(deca025-deca027) ",
               "   FROM deca_t LEFT JOIN ooga_t ON ooga001=deca002 AND oogaent = decaent  ",
               "  WHERE decaent=? AND deca020 = ? AND deca016=? AND ",l_wc 
   LET l_sql = l_sql," GROUP BY to_char(deca002,'YYYYMM'),decasite,'' ORDER BY to_char(deca002,'YYYYMM'),decasite,'' "    
   PREPARE l_sql_deca_pre9 FROM l_sql
   DECLARE l_sql_deca_cs9 CURSOR FOR l_sql_deca_pre9

   LET l_sql = " SELECT deca009,'',deca010,deca019,'',sum(deca022),sum(deca027),sum(deca030),sum(deca025-deca027) ",
               "   FROM deca_t ",
               "  WHERE decaent=? AND deca020 = ? AND deca016=?  "  
   LET l_sql = l_sql," GROUP BY deca009,'',deca010,deca019,''  ORDER BY deca009,'',deca010,deca019,'' "    
   PREPARE l_sql_deca_pre10 FROM l_sql
   DECLARE l_sql_deca_cs10 CURSOR FOR l_sql_deca_pre10
   
   SELECT COUNT(*) INTO l_count from decc_t where deccent = g_enterprise and decc001=g_master.mmaf001
   
   LET l_sql = " SELECT count(ooga002) ",
               "   FROM decc_t LEFT JOIN ooga_t ON ooga001=decc002 AND oogaent = deccent ",
               "  WHERE deccent=? AND decc001 = ?  AND ",l_wc1     
   PREPARE l_sql_deca_pre111 FROM l_sql
   EXECUTE l_sql_deca_pre111 USING g_enterprise,g_master.mmaf001 INTO l_count1
   
   LET l_sql = " SELECT ooga002,count(*),0 ",
               "   FROM decc_t LEFT JOIN ooga_t ON ooga001=decc002 AND oogaent = deccent ",
               "  WHERE deccent=? AND decc001 = ?  AND ",l_wc1  
   LET l_sql = l_sql," GROUP BY ooga002  ORDER BY ooga002 "    
   PREPARE l_sql_deca_pre11 FROM l_sql
   DECLARE l_sql_deca_cs11 CURSOR FOR l_sql_deca_pre11
   
   LET l_sql = " SELECT sum(a.rtjacount) ",
               "   FROM oocq_t,(SELECT rtja035,rtja031,1 AS rtjacount ",
               "                  FROM rtja_t WHERE rtjaent= ",g_enterprise,
               "                   AND rtja001 IN ( SELECT mmaq001 FROM mmaq_t WHERE mmaqent=? AND mmaq003=? ) ",
               "                   AND rtja032<>'4' ) a ",
               "  WHERE oocqent=",g_enterprise," AND oocq001='2108' AND (a.rtja035 BETWEEN oocq009 AND oocq010) "
   PREPARE l_sql_oocq_pre12 FROM l_sql
   EXECUTE l_sql_oocq_pre12 USING g_enterprise,g_master.mmaf001 INTO l_rtjacount
   
   LET l_sql = " SELECT count(*) ",
               "   FROM oocq_t,(SELECT rtja035,rtja031,1 AS rtjacount ",
               "                  FROM rtja_t WHERE rtjaent= ",g_enterprise,
               "                   AND rtja001 IN ( SELECT mmaq001 FROM mmaq_t WHERE mmaqent=? AND mmaq003=? ) ",
               "                   AND rtja032<>'4' ) a ",
               "  WHERE oocqent=",g_enterprise," AND oocq001='2108' AND (a.rtja035 BETWEEN oocq009 AND oocq010) "
   PREPARE l_sql_oocq_pre122 FROM l_sql
   EXECUTE l_sql_oocq_pre122 USING g_enterprise,g_master.mmaf001 INTO l_count12
   
   let l_sql = " SELECT oocq002,'',sum(a.rtja031),sum(a.rtjacount),0 ",
               "   FROM oocq_t,(SELECT rtja035,rtja031,1 AS rtjacount ",
               "                  FROM rtja_t WHERE rtjaent= ",g_enterprise,
               "                   AND rtja001 IN ( SELECT mmaq001 FROM mmaq_t WHERE mmaqent=? AND mmaq003=? ) ",
               "                   AND rtja032<>'4' ) a ",
               "  WHERE oocqent=",g_enterprise," AND oocq001='2108' AND (a.rtja035 BETWEEN oocq009 AND oocq010) "
   let l_sql = l_sql,"  group by oocq002,'' ORDER BY oocq002,'' " 
   PREPARE l_sql_deca_pre12 FROM l_sql
   DECLARE l_sql_deca_cs12 CURSOR FOR l_sql_deca_pre12

   let l_sql = " SELECT '',sum(decc010),SUM(decc016),COUNT(*),0 ",
               "   FROM decc_t ",
               "  WHERE decc001=? AND deccent=",g_enterprise," AND decc002 IN ( SELECT ooga001 FROM ooga_t ",
               "                      WHERE ooga004 IN (SELECT oocq002 FROM oocq_t ",
               "                                         WHERE oocqent = ",g_enterprise," AND oocq001='7'))"
               
   PREPARE l_sql_deca_pre131 FROM l_sql
   DECLARE l_sql_deca_cs131 CURSOR FOR l_sql_deca_pre131            
   
   LET l_sql = " SELECT ooga004,'',sum(decc010),sum(decc016),count(*),0 ",
               "   FROM ooga_t LEFT JOIN decc_t ON ooga001=decc002 AND oogaent = deccent ",
               "  WHERE deccent=? AND decc001=? AND ooga004 is not null AND ",l_wc1
   LET l_sql = l_sql," GROUP BY ooga004,''  ORDER BY ooga004,'' " 
   PREPARE l_sql_deca_pre141 FROM l_sql
   DECLARE l_sql_deca_cs141 CURSOR FOR l_sql_deca_pre141
   
   let l_sql = " SELECT '',sum(decc010),SUM(decc016),COUNT(*),0 ",
               "   FROM decc_t ",
               "  WHERE decc001=? AND deccent=",g_enterprise," AND decc002 IN ( SELECT ooga001 FROM ooga_t ",
               "                      WHERE ooga005 IN (SELECT oocq002 FROM oocq_t ",
               "                                         WHERE oocqent = ",g_enterprise," AND oocq001='8'))"
   PREPARE l_sql_deca_pre132 FROM l_sql
   DECLARE l_sql_deca_cs132 CURSOR FOR l_sql_deca_pre132 
   
   LET l_sql = " SELECT ooga005,'',sum(decc010),sum(decc016),count(*),0 ",
               "   FROM ooga_t LEFT JOIN decc_t ON ooga001=decc002 AND oogaent = deccent ",
               "  WHERE deccent=? AND decc001=? AND ooga005 is not null AND ",l_wc1
   LET l_sql = l_sql," GROUP BY ooga005,''  ORDER BY ooga005,'' " 
   PREPARE l_sql_deca_pre142 FROM l_sql
   DECLARE l_sql_deca_cs142 CURSOR FOR l_sql_deca_pre142
   
   let l_sql = " SELECT '',sum(decc010),SUM(decc016),COUNT(*),0 ",
               "   FROM decc_t ",
               "  WHERE decc001=? AND deccent=",g_enterprise," AND decc002 IN ( SELECT ooga001 FROM ooga_t ",
               "                      WHERE ooga006 IN (SELECT oocq002 FROM oocq_t ",
               "                                         WHERE oocqent = ",g_enterprise," AND oocq001='9'))"
   PREPARE l_sql_deca_pre133 FROM l_sql
   DECLARE l_sql_deca_cs133 CURSOR FOR l_sql_deca_pre133
   
   LET l_sql = " SELECT ooga006,'',sum(decc010),sum(decc016),count(*),0 ",
               "   FROM ooga_t LEFT JOIN decc_t ON ooga001=decc002 AND oogaent = deccent ",
               "  WHERE deccent=? AND decc001=? AND ooga006 is not null  AND ",l_wc1
   LET l_sql = l_sql," GROUP BY ooga006,''  ORDER BY ooga006,'' " 
   PREPARE l_sql_deca_pre143 FROM l_sql
   DECLARE l_sql_deca_cs143 CURSOR FOR l_sql_deca_pre143
   
   let l_sql = " SELECT '',sum(decc010),SUM(decc016),COUNT(*),0 ",
               "   FROM decc_t ",
               "  WHERE decc001=? AND deccent=",g_enterprise," AND decc002 IN ( SELECT ooga001 FROM ooga_t ",
               "                      WHERE ooga007 IN (SELECT oocq002 FROM oocq_t ",
               "                                         WHERE oocqent = ",g_enterprise," AND oocq001='10'))"
   PREPARE l_sql_deca_pre134 FROM l_sql
   DECLARE l_sql_deca_cs134 CURSOR FOR l_sql_deca_pre134
   
   LET l_sql = " SELECT ooga007,'',sum(decc010),sum(decc016),count(*),0 ",
               "   FROM ooga_t LEFT JOIN decc_t ON ooga001=decc002 AND oogaent = deccent ",
               "  WHERE deccent=? AND decc001=? AND ooga007 is not null  AND ",l_wc1
   LET l_sql = l_sql," GROUP BY ooga007,''  ORDER BY ooga007,'' " 
   PREPARE l_sql_deca_pre144 FROM l_sql
   DECLARE l_sql_deca_cs144 CURSOR FOR l_sql_deca_pre144
   
   let l_sql = " SELECT '',sum(decc010),SUM(decc016),COUNT(*),0 ",
               "   FROM decc_t ",
               "  WHERE decc001=? AND deccent=",g_enterprise," AND decc002 IN ( SELECT ooga001 FROM ooga_t ",
               "                      WHERE ooga008 IN (SELECT oocq002 FROM oocq_t ",
               "                                         WHERE oocqent = ",g_enterprise," AND oocq001='11'))"
               
   PREPARE l_sql_deca_pre135 FROM l_sql
   DECLARE l_sql_deca_cs135 CURSOR FOR l_sql_deca_pre135
   
   LET l_sql = " SELECT ooga008,'',sum(decc010),sum(decc016),count(*),0 ",
               "   FROM ooga_t LEFT JOIN decc_t ON ooga001=decc002 AND oogaent = deccent ",
               "  WHERE deccent=? AND decc001=? AND ooga008 is not null  AND ",l_wc1
   LET l_sql = l_sql," GROUP BY ooga008,''  ORDER BY ooga008,'' " 
   PREPARE l_sql_deca_pre145 FROM l_sql
   DECLARE l_sql_deca_cs145 CURSOR FOR l_sql_deca_pre145

   LET l_sql = " SELECT oocq002,'',sum(deca027),sum(deca031),sum(deca022) ",
               "   FROM oocq_t,deca_t ",
               "  WHERE decaent=? AND deca020=? AND oocqent=",g_enterprise," AND oocq001='2001' AND ((deca027/(case when deca022=0 then 1 when deca022<>0 then deca022 end)) BETWEEN oocq009 AND oocq010) "
   LET l_sql = l_sql,"  GROUP BY oocq002,'' ORDER BY oocq002,'' " 
   PREPARE l_sql_deca_pre15 FROM l_sql
   DECLARE l_sql_deca_cs15 CURSOR FOR l_sql_deca_pre15
   
   LET l_sql = " SELECT to_char(decc002,'YYYYMM'),sum(decc010),sum(decc016),0,sum(decc010)/sum(decc016),0 ",
               "   FROM decc_t LEFT JOIN ooga_t ON ooga001=decc002 AND oogaent = deccent  ",
               "  WHERE deccent=? AND decc001 = ?  AND ",l_wc1 
   LET l_sql = l_sql," GROUP BY to_char(decc002,'YYYYMM') ORDER BY to_char(decc002,'YYYYMM') "    
   PREPARE l_sql_deca_pre16 FROM l_sql
   DECLARE l_sql_deca_cs16 CURSOR FOR l_sql_deca_pre16
   
   LET l_sql = " SELECT rtjf025,sum(rtjf003),sum(rtjf022) ",
               "   FROM rtjf_t,mmaq_t ",
               "  WHERE rtjfent=?  ",
               "    AND mmaqent = rtjfent AND mmaq001 = rtjf004 AND mmaq003 = ? ",
               "    AND ",g_wc2,
               "    AND EXISTS(SELECT 1 FROM mman_t WHERE mmanent = rtjfent AND mman057 = rtjf002 AND mman001 = mmaq002) "           
   LET l_sql = l_sql," GROUP BY rtjf025 ORDER BY rtjf025 "    
   PREPARE l_sql_deca_pre17 FROM l_sql
   DECLARE l_sql_deca_cs17 CURSOR FOR l_sql_deca_pre17
   
   LET l_sql = " SELECT to_char(rtjf025,'YYYYMM'),rtjfsite,'',sum(rtjf003),sum(rtjf022) ",
               "   FROM rtjf_t,mmaq_t ",
               "  WHERE rtjfent=? ",
               "    AND mmaqent = rtjfent AND mmaq001 = rtjf004 AND mmaq003 = ? ",
               "    AND ",g_wc2,
               "    AND EXISTS(SELECT 1 FROM mman_t WHERE mmanent = rtjfent AND mman057 = rtjf002 AND mman001 = mmaq002) "   
   LET l_sql = l_sql," GROUP BY to_char(rtjf025,'YYYYMM'),rtjfsite,''  ORDER BY to_char(rtjf025,'YYYYMM'),rtjfsite,'' "    
   PREPARE l_sql_deca_pre18 FROM l_sql
   DECLARE l_sql_deca_cs18 CURSOR FOR l_sql_deca_pre18
   
   LET l_sql = " SELECT rtjf004,mmaq002,'',rtjf025,rtjfsite,'',sum(rtjf003),sum(rtjf022) ",
               "   FROM rtjf_t,mmaq_t ",
               "  WHERE rtjfent=? ",
               "    AND mmaqent = rtjfent AND mmaq001 = rtjf004 AND mmaq003 = ? ",
               "    AND ",g_wc2,
               "    AND EXISTS(SELECT 1 FROM mman_t WHERE mmanent = rtjfent AND mman057 = rtjf002 AND mman001 = mmaq002) "              
   LET l_sql = l_sql," GROUP BY rtjf004,mmaq002,'',rtjf025,rtjfsite,''  ORDER BY rtjf004,mmaq002,'',rtjf025,rtjfsite,'' "    
   PREPARE l_sql_deca_pre19 FROM l_sql
   DECLARE l_sql_deca_cs19 CURSOR FOR l_sql_deca_pre19
   
   
   LET l_sql = " SELECT UNIQUE to_char(decc002,'YYYY'),ooga009,'','','','' ",
               "   FROM decc_t  LEFT JOIN ooga_t ON oogaent = deccent AND ooga001 = decc002 ",
               "  WHERE deccent=? AND decc002 <='",l_date2,"' AND decc001 <> ' ' ",
               "    AND decc001 = ? "               
   LET l_sql = l_sql," ORDER BY to_char(decc002,'YYYY'),ooga009 "    
   PREPARE l_sql_deca_pre20 FROM l_sql
   DECLARE l_sql_deca_cs20 CURSOR FOR l_sql_deca_pre20
   
   LET l_sql = " SELECT crdc002,crdc003,crdc010,'','' ",
               "   FROM crdc_t  ",
               "  WHERE crdcent=?  AND crdc001=? "               
   LET l_sql = l_sql," ORDER BY crdc002,crdc003 "    
   PREPARE l_sql_deca_pre21 FROM l_sql
   DECLARE l_sql_deca_cs21 CURSOR FOR l_sql_deca_pre21
   
   LET l_sql = " SELECT mmaq001,mmaq002,'','','','',mmaq009 ",
               "   FROM mmaq_t  ",
               "  WHERE mmaqent=?  AND mmaq003=? "               
   LET l_sql = l_sql," ORDER BY mmaq001,mmaq002 "    
   PREPARE l_sql_deca_pre22 FROM l_sql
   DECLARE l_sql_deca_cs22 CURSOR FOR l_sql_deca_pre22
   
   LET l_sql = " SELECT to_char(mmau006,'YYYYMM'),mmau018,ooefl003,sum(mmau009),count(*),sum(mmau011),sum(mmau012) ",
               "   FROM mmau_t  LEFT JOIN ooefl_t ON mmauent = ooeflent AND mmau018=ooefl001 AND ooefl002='",g_dlang,"'",
               "  WHERE mmauent=?  AND mmau002=? "               
   LET l_sql = l_sql," GROUP BY to_char(mmau006,'YYYYMM'),mmau018,ooefl003  ORDER BY to_char(mmau006,'YYYYMM'),mmau018,ooefl003 "    
   PREPARE l_sql_deca_pre23 FROM l_sql
   DECLARE l_sql_deca_cs23 CURSOR FOR l_sql_deca_pre23
   
   
   LET l_sql = " SELECT mmau001,'','',mmau006,mmau018,ooefl003,mmau009,mmau011,mmau012 ",
               "   FROM mmau_t  LEFT JOIN ooefl_t ON mmauent = ooeflent AND mmau018=ooefl001 AND ooefl002='",g_dlang,"'",
               "  WHERE mmauent=?  AND mmau002=? "               
   LET l_sql = l_sql," ORDER BY mmau001,'','',mmau006 "    
   PREPARE l_sql_deca_pre24 FROM l_sql
   DECLARE l_sql_deca_cs24 CURSOR FOR l_sql_deca_pre24
   #end add-point
 
   
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #+ 此段落由子樣板qs09產生
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql
   OPEN l_sql_mmaq001_cs1 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_mmaq001_cs1 INTO g_detail[l_ac].sel,g_detail[l_ac].mmaq001,g_detail[l_ac].mmaq002,g_detail[l_ac].mmaq002_desc,g_detail[l_ac].mmaq003,g_detail[l_ac].mmaq003_desc,
      g_detail[l_ac].mmaq005,g_detail[l_ac].mmaq006,g_detail[l_ac].mmaq007,g_detail[l_ac].mmaq009,g_detail[l_ac].mmaq013,g_detail[l_ac].mmaq014,g_detail[l_ac].mmaq015,
      g_detail[l_ac].mmaq016,g_detail[l_ac].mmaq017,g_detail[l_ac].mmaq018
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      select mmanl003 into g_detail[l_ac].mmaq002_desc from mmanl_t
       where mmanlent = g_enterprise and mmanl001 = g_detail[l_ac].mmaq002
         and mmanl002 = g_dlang       
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
#   CALL g_detail.deleteElement(g_detail.getLength())
   LET l_ac = 1
   OPEN l_sql_rtja_cs2 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_rtja_cs2 INTO g_detail12[l_ac].rtjasite,g_detail12[l_ac].rtjasite_desc,g_detail12[l_ac].rtjadocno,g_detail12[l_ac].rtja032,g_detail12[l_ac].rtja007,g_detail12[l_ac].rtja001,
      g_detail12[l_ac].rtjadocdt,g_detail12[l_ac].rtja031,g_detail12[l_ac].rtjb020,g_detail12[l_ac].rtja016
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      select ooefl003 into g_detail12[l_ac].rtjasite_desc from ooefl_t
       where ooeflent = g_enterprise and ooefl001 = g_detail12[l_ac].rtjasite
         and ooefl002 = g_dlang
      SELECT SUM(rtjb020) INTO g_detail12[l_ac].rtjb020
        FROM rtjb_t
       WHERE rtjbent = g_enterprise
         AND rtjbdocno = g_detail12[l_ac].rtjadocno
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail12.deleteElement(g_detail12.getLength()) 
   LET l_cnt=g_cnt
   IF g_detail12.getLength()<g_cnt  THEN
      LET l_cnt = g_detail12.getLength()
   END IF
   IF cl_null(l_cnt) OR l_cnt=0 THEN
      LET l_cnt = 1
   END IF   
   LET l_ac = 1
   OPEN l_sql_rtje_cs3 USING g_enterprise,g_detail12[l_cnt].rtjadocno
   FOREACH  l_sql_rtje_cs3 INTO g_detail18[l_ac].rtje001,g_detail18[l_ac].rtje002,g_detail18[l_ac].rtje002_desc,g_detail18[l_ac].rtje006,g_detail18[l_ac].rtje004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT ooial003 INTO g_detail18[l_ac].rtje002_desc FROM ooial_t
       WHERE ooialent = g_enterprise AND ooial001 = g_detail18[l_ac].rtje002
         AND ooial002 = g_dlang
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail18.deleteElement(g_detail18.getLength())  
   LET l_ac = 1
   OPEN l_sql_rtjb_cs4 USING g_enterprise,g_detail12[l_cnt].rtjadocno
   FOREACH  l_sql_rtjb_cs4 INTO g_detail19[l_ac].rtjbseq,g_detail19[l_ac].rtjb003,g_detail19[l_ac].rtjb004,g_detail19[l_ac].rtjb004_desc,g_detail19[l_ac].rtjb008,
            g_detail19[l_ac].rtjb009,g_detail19[l_ac].rtjb010,g_detail19[l_ac].rtjb013,g_detail19[l_ac].rtjb013_desc,g_detail19[l_ac].rtjb012,g_detail19[l_ac].rtjb020,
            g_detail19[l_ac].rtjb021,g_detail19[l_ac].rtjb025,g_detail19[l_ac].rtjb026,g_detail19[l_ac].rtjb027,g_detail19[l_ac].rtjb028
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT imaal003 INTO g_detail19[l_ac].rtjb004_desc FROM imaal_t
       WHERE imaalent = g_enterprise AND imaal001 = g_detail19[l_ac].rtjb004
         AND imaal002 = g_dlang
      SELECT oocal003 INTO g_detail19[l_ac].rtjb013_desc FROM oocal_t
       WHERE oocalent = g_enterprise AND oocal001 = g_detail19[l_ac].rtjb013
         AND oocal002 = g_dlang
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail19.deleteElement(g_detail19.getLength())  

   LET l_ac = 1
   OPEN l_sql_deca_cs5 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs5 INTO g_detail20[l_ac].deca013a,g_detail20[l_ac].deca013a_desc,g_detail20[l_ac].deca031,g_detail20[l_ac].deca033a,g_detail20[l_ac].deca027a,
      g_detail20[l_ac].deca025a,g_detail20[l_ac].deca026a,g_detail20[l_ac].deca028a,g_detail20[l_ac].deca028b,g_detail20[l_ac].deca030a    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT oocql004 INTO g_detail20[l_ac].deca013a_desc FROM oocql_t
       WHERE oocqlent = g_enterprise AND oocql001 = '2002'
         AND oocql002 = g_detail20[l_ac].deca013a AND oocql003 = g_dlang
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail20.deleteElement(g_detail20.getLength())
   LET l_cnt=g_cnt
   IF g_detail20.getLength()<g_cnt  THEN
      LET l_cnt = g_detail20.getLength()
   END IF
   IF cl_null(l_cnt) OR l_cnt=0 THEN
      LET l_cnt = 1
   END IF   
   LET l_ac = 1   
   OPEN l_sql_deca_cs6 USING g_enterprise,g_master.mmaf001,g_detail20[l_cnt].deca013a
   FOREACH  l_sql_deca_cs6 INTO g_detail21[l_ac].deca002b,g_detail21[l_ac].decasiteb,g_detail21[l_ac].decasitea_desc,g_detail21[l_ac].deca027b,
      g_detail21[l_ac].deca031b,g_detail21[l_ac].deca030b,g_detail21[l_ac].deca033b,g_detail21[l_ac].deca025b
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT ooefl003 INTO g_detail21[l_ac].decasitea_desc FROM ooefl_t
       WHERE ooefl001 = g_detail21[l_ac].decasiteb AND ooefl002 = g_dlang
         AND ooeflent = g_enterprise
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail21.deleteElement(g_detail21.getLength())
   
   LET l_ac = 1   
   OPEN l_sql_deca_cs7 USING g_enterprise,g_master.mmaf001,g_detail20[l_cnt].deca013a
   FOREACH  l_sql_deca_cs7 INTO g_detail22[l_ac].deca009c,g_detail22[l_ac].deca009c_desc,g_detail22[l_ac].deca010c,g_detail22[l_ac].deca019c,
      g_detail22[l_ac].deca022c,g_detail22[l_ac].deca027c,g_detail22[l_ac].deca030c,g_detail22[l_ac].deca025c
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT imaal003 INTO g_detail22[l_ac].deca009c_desc FROM imaal_t
       WHERE imaalent = g_enterprise AND imaal001 = g_detail22[l_ac].deca009c
         AND imaal002 = g_dlang
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail22.deleteElement(g_detail22.getLength())
   
   
   
   LET l_ac = 1
   OPEN l_sql_deca_cs8 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs8 INTO g_detail23[l_ac].deca016d,g_detail23[l_ac].deca016d_desc,g_detail23[l_ac].deca031d,g_detail23[l_ac].deca033d,g_detail23[l_ac].deca027d,
      g_detail23[l_ac].deca025d,g_detail23[l_ac].deca026d,g_detail23[l_ac].deca028d,g_detail23[l_ac].decacount,g_detail23[l_ac].deca030d    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT rtaxl003 INTO g_detail23[l_ac].deca016d_desc FROM rtaxl_t
       WHERE rtaxlent = g_enterprise AND rtaxl001 = g_detail23[l_ac].deca016d
         AND rtaxl002 = g_dlang       
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail23.deleteElement(g_detail23.getLength())
   LET l_cnt=g_cnt
   IF g_detail23.getLength()<g_cnt  THEN
      LET l_cnt = g_detail23.getLength()
   END IF
   IF cl_null(l_cnt) OR l_cnt=0 THEN
      LET l_cnt = 1
   END IF   
   LET l_ac = 1   
   OPEN l_sql_deca_cs9 USING g_enterprise,g_master.mmaf001,g_detail23[l_cnt].deca016d
   FOREACH  l_sql_deca_cs9 INTO g_detail24[l_ac].deca002e,g_detail24[l_ac].decasitee,g_detail24[l_ac].decasitee_desc,g_detail24[l_ac].deca027e,
      g_detail24[l_ac].deca031e,g_detail24[l_ac].deca030e,g_detail24[l_ac].deca033e,g_detail24[l_ac].deca025e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT ooefl003 INTO g_detail24[l_ac].decasitee_desc FROM ooefl_t
       WHERE ooefl001 = g_detail24[l_ac].decasitee AND ooefl002 = g_dlang
         AND ooeflent = g_enterprise
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail24.deleteElement(g_detail24.getLength())
   
   LET l_ac = 1   
   OPEN l_sql_deca_cs10 USING g_enterprise,g_master.mmaf001,g_detail23[l_cnt].deca016d
   FOREACH  l_sql_deca_cs10 INTO g_detail2[l_ac].deca009f,g_detail2[l_ac].deca009f_desc,g_detail2[l_ac].deca010f,g_detail2[l_ac].deca019f,g_detail2[l_ac].deca019f_desc,
      g_detail2[l_ac].deca022f,g_detail2[l_ac].decf027f,g_detail2[l_ac].deca030f,g_detail2[l_ac].deca025f
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT imaal003 INTO g_detail2[l_ac].deca009f_desc FROM imaal_t
       WHERE imaalent = g_enterprise AND imaal001 = g_detail2[l_ac].deca009f
         AND imaal002 = g_dlang
      SELECT oocal003 INTO g_detail2[l_ac].deca019f_desc FROM oocal_t
       WHERE oocalent = g_enterprise AND oocal001 = g_detail2[l_ac].deca019f
         AND oocal002 = g_dlang       
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail2.deleteElement(g_detail2.getLength())
   
   LET l_ac = 1   
   OPEN l_sql_deca_cs11 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs11 INTO g_detail3[l_ac].weeka,g_detail3[l_ac].counta,g_detail3[l_ac].ratea
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      IF l_ac=l_count1 THEN
         LET g_detail3[l_ac].ratea=(1-l_ratea/100)*100
      ELSE
         LET g_detail3[l_ac].ratea=g_detail3[l_ac].counta/l_count*100
      END IF
      LET l_ratea = l_ratea + g_detail3[l_ac].ratea     
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail3.deleteElement(g_detail3.getLength())
   
   LET l_ac = 1   
   OPEN l_sql_deca_cs12 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs12 INTO g_detail4[l_ac].timea,g_detail4[l_ac].timea_desc,g_detail4[l_ac].moneya,g_detail4[l_ac].numbera,g_detail4[l_ac].rateb
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT oocql004 INTO  g_detail4[l_ac].timea_desc
        FROM oocql_t 
       WHERE oocqlent = g_enterprise AND oocql001 = '2108' AND oocql002 = g_detail4[l_ac].timea
         AND oocql003 = g_dlang
      IF l_ac=l_count12 THEN
         LET g_detail4[l_ac].rateb = (1-l_rateb/100)*100
      ELSE      
         LET g_detail4[l_ac].rateb =   g_detail4[l_ac].numbera/l_rtjacount*100
      END IF
      LET l_rateb = l_rateb+g_detail4[l_ac].rateb
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_detail4.deleteElement(g_detail4.getLength())
   
   FOR i=1 TO 5
      IF i=1 THEN
         EXECUTE  l_sql_deca_pre131 USING g_master.mmaf001 INTO g_detail5[i].calendar,g_detail5[i].moneyc,g_detail5[i].numberc,g_detail5[i].countc,g_detail5[i].ratec
         LET g_detail5[i].calendar='7'
         SELECT gzaal003 into g_detail5[i].calendar FROM gzaal_t WHERE gzaal001='7' AND gzaal002=g_dlang
          
         LET g_detail5[i].ratec = g_detail5[i].countc/l_count*100
      END IF
      IF i=2 THEN
         EXECUTE  l_sql_deca_pre132 USING g_master.mmaf001 INTO g_detail5[i].calendar,g_detail5[i].moneyc,g_detail5[i].numberc,g_detail5[i].countc,g_detail5[i].ratec
         LET g_detail5[i].calendar='8'
         SELECT gzaal003 into g_detail5[i].calendar FROM gzaal_t WHERE gzaal001='8' AND gzaal002=g_dlang
         LET g_detail5[i].ratec = g_detail5[i].countc/l_count*100
      END IF 
      IF i=3 THEN
         EXECUTE  l_sql_deca_pre133 USING g_master.mmaf001 INTO g_detail5[i].calendar,g_detail5[i].moneyc,g_detail5[i].numberc,g_detail5[i].countc,g_detail5[i].ratec
         LET g_detail5[i].calendar='9'
         SELECT gzaal003 into g_detail5[i].calendar FROM gzaal_t WHERE gzaal001='9' AND gzaal002=g_dlang
         LET g_detail5[i].ratec = g_detail5[i].countc/l_count*100
      END IF
      IF i=4 THEN
         EXECUTE  l_sql_deca_pre134 USING g_master.mmaf001 INTO g_detail5[i].calendar,g_detail5[i].moneyc,g_detail5[i].numberc,g_detail5[i].countc,g_detail5[i].ratec
         LET g_detail5[i].calendar='10'
         SELECT gzaal003 into g_detail5[i].calendar FROM gzaal_t WHERE gzaal001='10' AND gzaal002=g_dlang
         LET g_detail5[i].ratec = g_detail5[i].countc/l_count*100
      END IF
      IF i=5 THEN
         EXECUTE  l_sql_deca_pre135 USING g_master.mmaf001 INTO g_detail5[i].calendar,g_detail5[i].moneyc,g_detail5[i].numberc,g_detail5[i].countc,g_detail5[i].ratec
         LET g_detail5[i].calendar='11'
         SELECT gzaal003 into g_detail5[i].calendar FROM gzaal_t WHERE gzaal001='11' AND gzaal002=g_dlang
         LET g_detail5[i].ratec = g_detail5[i].countc/l_count*100
      END IF      
   END FOR
   LET l_cnt=g_cnt
   IF g_detail23.getLength()<g_cnt  THEN
      LET l_cnt = g_detail23.getLength()
   END IF
   IF cl_null(l_cnt) OR l_cnt=0 THEN
      LET l_cnt = 1
   END IF   
   LET l_ac = 1 
   if l_cnt = 1 then   
   OPEN l_sql_deca_cs141 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs141 INTO g_detail6[l_ac].class,g_detail6[l_ac].class_desc,g_detail6[l_ac].moneyd,g_detail6[l_ac].numberd,g_detail6[l_ac].countd,g_detail6[l_ac].rated
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET g_detail6[l_ac].rated = g_detail6[l_ac].countd/l_count*100
      SELECT oocql004 INTO g_detail6[l_ac].class_desc FROM oocql_t
       WHERE oocqlent = g_enterprise AND oocql001 = '7' AND oocql002 = g_detail6[l_ac].class 
         AND oocql003 = g_dlang
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail6.deleteElement(g_detail6.getLength())
   end if
   if l_cnt = 2 then   
   OPEN l_sql_deca_cs142 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs142 INTO g_detail6[l_ac].class,g_detail6[l_ac].class_desc,g_detail6[l_ac].moneyd,g_detail6[l_ac].numberd,g_detail6[l_ac].countd,g_detail6[l_ac].rated
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET g_detail6[l_ac].rated = g_detail6[l_ac].countd/l_count*100
      SELECT oocql004 INTO g_detail6[l_ac].class_desc FROM oocql_t
       WHERE oocqlent = g_enterprise AND oocql001 = '8' AND oocql002 = g_detail6[l_ac].class 
         AND oocql003 = g_dlang
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail6.deleteElement(g_detail6.getLength())
   end if
   if l_cnt = 3 then   
   OPEN l_sql_deca_cs143 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs143 INTO g_detail6[l_ac].class,g_detail6[l_ac].class_desc,g_detail6[l_ac].moneyd,g_detail6[l_ac].numberd,g_detail6[l_ac].countd,g_detail6[l_ac].rated
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET g_detail6[l_ac].rated = g_detail6[l_ac].countd/l_count*100
      SELECT oocql004 INTO g_detail6[l_ac].class_desc FROM oocql_t
       WHERE oocqlent = g_enterprise AND oocql001 = '9' AND oocql002 = g_detail6[l_ac].class 
         AND oocql003 = g_dlang
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail6.deleteElement(g_detail6.getLength())
   end if
   if l_cnt = 4 then   
   OPEN l_sql_deca_cs144 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs144 INTO g_detail6[l_ac].class,g_detail6[l_ac].class_desc,g_detail6[l_ac].moneyd,g_detail6[l_ac].numberd,g_detail6[l_ac].countd,g_detail6[l_ac].rated
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET g_detail6[l_ac].rated = g_detail6[l_ac].countd/l_count*100
      SELECT oocql004 INTO g_detail6[l_ac].class_desc FROM oocql_t
       WHERE oocqlent = g_enterprise AND oocql001 = '10' AND oocql002 = g_detail6[l_ac].class 
         AND oocql003 = g_dlang
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail6.deleteElement(g_detail6.getLength())
   end if
   if l_cnt = 5 then   
   OPEN l_sql_deca_cs145 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs145 INTO g_detail6[l_ac].class,g_detail6[l_ac].class_desc,g_detail6[l_ac].moneyd,g_detail6[l_ac].numberd,g_detail6[l_ac].countd,g_detail6[l_ac].rated
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET g_detail6[l_ac].rated = g_detail6[l_ac].countd/l_count*100
      SELECT oocql004 INTO g_detail6[l_ac].class_desc FROM oocql_t
       WHERE oocqlent = g_enterprise AND oocql001 = '11' AND oocql002 = g_detail6[l_ac].class 
         AND oocql003 = g_dlang
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail6.deleteElement(g_detail6.getLength())
   end if
   
   LET l_ac = 1   
   OPEN l_sql_deca_cs15 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs15 INTO g_detail7[l_ac].oocq002a,g_detail7[l_ac].oocq002a_desc,g_detail7[l_ac].deca027s,g_detail7[l_ac].deca031s,g_detail7[l_ac].deca022s
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT oocql004 INTO  g_detail7[l_ac].oocq002a_desc
        FROM oocql_t 
       WHERE oocqlent = g_enterprise AND oocql001 = '2001' AND oocql002 = g_detail7[l_ac].oocq002a
         AND oocql003 = g_dlang       
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail7.deleteElement(g_detail7.getLength())
   
   LET l_ac = 1   
   OPEN l_sql_deca_cs16 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs16 INTO g_detail8[l_ac].deca002t,g_detail8[l_ac].deca027t,g_detail8[l_ac].deca031t,g_detail8[l_ac].maxmoney,
      g_detail8[l_ac].avgmoney,g_detail8[l_ac].minmoney
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   
#      LET l_month=MONTH(g_today)-1
#      LET l_year = YEAR(g_today)
#      LET l_days = cl_days(l_year,l_month)
      LET l_date3 = g_detail8[l_ac].deca002t||'01'
#      SELECT TO_NUMBER(TO_CHAR(l_date3,'YYYY')) INTO l_year FROM dual
#      SELECT TO_NUMBER(TO_CHAR(l_date3,'MM')) INTO l_month FROM dual
#      LET l_days = cl_days(l_year,l_month)
      SELECT last_day(l_date3) INTO l_date4 FROM dual
#      LET l_date4 = g_detail8[l_ac].deca002t||l_days
      SELECT max(rtja031),min(rtja031) INTO  g_detail8[l_ac].maxmoney,g_detail8[l_ac].minmoney
        FROM rtja_t
       WHERE rtjaent = g_enterprise AND rtja001 IN (select mmaq001 FROM mmaq_t WHERE mmaqent = g_enterprise AND mmaq003=g_master.mmaf001 ) 
         AND rtjadocdt IN (select ooga001 FROM ooga_t WHERE oogaent = g_enterprise 
         AND ooga001>=to_date(l_date3) AND ooga001<=to_date(l_date4))          
                              
#      LET  g_detail8[l_ac].deca002t = l_year,g_detail8[l_ac].deca002t                             
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail8.deleteElement(g_detail8.getLength())
   
   LET l_ac = 1   
   OPEN l_sql_deca_cs17 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs17 INTO g_detail9[l_ac].rtjf025,g_detail9[l_ac].rtjf003,g_detail9[l_ac].rtjf022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
                                  
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail9.deleteElement(g_detail9.getLength())
   
   LET l_ac = 1   
   OPEN l_sql_deca_cs18 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs18 INTO g_detail10[l_ac].weeku,g_detail10[l_ac].rtjfsite,g_detail10[l_ac].rtjfsite_desc,
      g_detail10[l_ac].rtjf003u,g_detail10[l_ac].rtjf022u
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF      
      SELECT ooefl003 INTO  g_detail10[l_ac].rtjfsite_desc FROM ooefl_t
       WHERE ooeflent = g_enterprise AND ooefl001 = g_detail10[l_ac].rtjfsite
         AND ooefl002 = g_dlang
         
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail10.deleteElement(g_detail10.getLength())

   LET l_ac = 1   
   OPEN l_sql_deca_cs19 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs19 INTO g_detail11[l_ac].mmaq001v,g_detail11[l_ac].mmaq002v,g_detail11[l_ac].mmaq002v_desc,g_detail11[l_ac].rtjf025v,
                                 g_detail11[l_ac].rtjfsitev,g_detail11[l_ac].rtjfsitev_desc,g_detail11[l_ac].rtjf003v,g_detail11[l_ac].rtjf022v
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF      
      SELECT mmanl003 INTO g_detail11[l_ac].mmaq002v_desc
        FROM mmanl_t
       WHERE mmanlent = g_enterprise
         AND mmanl001 = g_detail11[l_ac].mmaq002v
         AND mmanl002 = g_dlang
      SELECT ooefl003 INTO  g_detail11[l_ac].rtjfsitev_desc FROM ooefl_t
       WHERE ooeflent = g_enterprise AND ooefl001 = g_detail11[l_ac].rtjfsitev
         AND ooefl002 = g_dlang
         
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail11.deleteElement(g_detail11.getLength())
   
   LET l_sql="SELECT mmaf001,decc010 FROM acrq500_tmp "
   PREPARE l_sql_tmp_pre1 FROM l_sql
   DECLARE l_sql_tmp_cs1 CURSOR FOR l_sql_tmp_pre1
   
   LET l_ac = 1   
   OPEN l_sql_deca_cs20 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs20 INTO g_detail13[l_ac].yearw,g_detail13[l_ac].ooga009,g_detail13[l_ac].rankw,
      g_detail13[l_ac].rankw2,g_detail13[l_ac].rankcount,g_detail13[l_ac].decc010
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET l_startdate =  MDY(1,1,g_detail13[l_ac].yearw)
      LET l_enddate =  MDY(12,1,g_detail13[l_ac].yearw)
      DELETE FROM acrq500_tmp
      LET l_sql=" INSERT INTO acrq500_tmp(mmaf001,decc010) ", 
                " SELECT decc001,decc010 FROM (SELECT decc001,sum(decc010) decc010 FROM decc_t,ooga_t ",
                "  WHERE (decc002 >='",l_startdate,"' AND decc002 <= '",l_enddate,"')",
                "    AND oogaent = deccent AND ooga001 = decc002 ",
                "    AND deccent = ",g_enterprise,
                "    AND ooga009 ='",g_detail13[l_ac].ooga009,"' ",
                "    AND decc001 <> ' '  ",
                "  GROUP BY decc001 ",
                "  ORDER BY decc010 DESC ) "
      PREPARE l_sql_tmp_pre FROM l_sql
      EXECUTE l_sql_tmp_pre
      
      
      LET l_count2=1
      FOREACH l_sql_tmp_cs1 INTO l_mmaf001,l_decc010
         IF g_master.mmaf001=l_mmaf001 THEN
            LET g_detail13[l_ac].decc010=l_decc010
            LET g_detail13[l_ac].rankw2=l_count2
            EXIT FOREACH
         END IF
         LET l_count2=l_count2+1
         LET l_mmaf001 = NULL
         LET l_decc010 = NULL
      END FOREACH
      
      SELECT decc010 INTO  g_detail13[l_ac].decc010
        FROM acrq500_tmp
       WHERE mmaf001 = g_master.mmaf001
       
      LET l_count = 0       
      SELECT count(distinct decc001) INTO l_count
        FROM decc_t,ooga_t
       WHERE (decc002 >=l_startdate AND decc002 <= l_enddate)
         AND deccent = g_enterprise
         AND deccent = oogaent
         AND decc002 = ooga001         
         AND ooga009 = g_detail13[l_ac].ooga009
         AND decc001 <> ' ' 
      LET g_detail13[l_ac].rankcount = l_count 
      IF NOT cl_null(g_detail13[l_ac].rankw2) THEN     
         LET g_detail13[l_ac].rankw = g_detail13[l_ac].rankw2 /l_count*100
      END IF      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail13.deleteElement(g_detail13.getLength())
   
   LET l_ac = 1   
   OPEN l_sql_deca_cs21 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs21 INTO g_detail14[l_ac].crdc002,g_detail14[l_ac].crdc003,g_detail14[l_ac].crdc010,g_detail14[l_ac].crdc010_desc,g_detail14[l_ac].crdcrate
     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF      
          
      SELECT COUNT(crdc010) INTO l_crdc010 FROM crdc_t 
       WHERE crdcent = g_enterprise 
         AND crdc002=g_detail14[l_ac].crdc002
         AND crdc010 = g_detail14[l_ac].crdc010
         AND crdc001 = g_master.mmaf001
      IF cl_null(l_crdc010) THEN 
         LET l_crdc010 = 0
      END IF 
      SELECT COUNT(crdc010) INTO l_crdc010_sum FROM crdc_t 
       WHERE crdcent = g_enterprise 
         AND crdc002=g_detail14[l_ac].crdc002
         AND crdc001 = g_master.mmaf001
      IF cl_null(l_crdc010_sum) THEN 
         LET l_crdc010_sum = 0
      END IF 
      LET  g_detail14[l_ac].crdcrate = l_crdc010/l_crdc010_sum*100
      
      SELECT oocql004 INTO g_detail14[l_ac].crdc010_desc
        FROM oocql_t
       WHERE oocqlent = g_enterprise
         AND oocql001 = '2111'
         AND oocql002 = g_detail14[l_ac].crdc010
         AND oocql003 = g_dlang
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail14.deleteElement(g_detail14.getLength())
   
   LET l_ac = 1   
   OPEN l_sql_deca_cs22 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs22 INTO g_detail15[l_ac].mmaq001x,g_detail15[l_ac].mmaq002x,g_detail15[l_ac].mmaq002x_desc,g_detail15[l_ac].mmau006,g_detail15[l_ac].mmaucountx,
      g_detail15[l_ac].mmau009,g_detail15[l_ac].mmaq009x
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF      
      SELECT count(*),max(mmau006),max(mmau009) 
        INTO g_detail15[l_ac].mmaucountx,g_detail15[l_ac].mmau006,g_detail15[l_ac].mmau009 
        FROM mmau_t
       WHERE mmauent = g_enterprise AND mmau002= g_master.mmaf001
         AND mmau001 = g_detail15[l_ac].mmaq001x
      SELECT mmanl003 INTO  g_detail15[l_ac].mmaq002x_desc FROM mmanl_t
       WHERE mmanl001 =  g_detail15[l_ac].mmaq002x AND mmanl002 = g_dlang AND mmanlent=g_enterprise     #160905-00007#1 add
         
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail15.deleteElement(g_detail15.getLength())
   
   LET l_ac = 1   
   OPEN l_sql_deca_cs23 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs23 INTO g_detail16[l_ac].ymonth,g_detail16[l_ac].mmau018,g_detail16[l_ac].mmau018_desc,g_detail16[l_ac].mmau009y,
      g_detail16[l_ac].mmaucounty,g_detail16[l_ac].mmau011,g_detail16[l_ac].mmau012
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF      

      SELECT mmanl003 INTO  g_detail15[l_ac].mmaq002x_desc FROM mmanl_t
       WHERE mmanl001 =  g_detail15[l_ac].mmaq002x AND mmanl002 = g_dlang AND mmanlent=g_enterprise    #160905-00007#1 add
         
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail16.deleteElement(g_detail16.getLength())
   
   LET l_ac = 1   
   OPEN l_sql_deca_cs24 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs24 INTO g_detail17[l_ac].mmau001,g_detail17[l_ac].mmaq002z,g_detail17[l_ac].mmaq002z_desc,g_detail17[l_ac].mmau006z,
      g_detail17[l_ac].mmau018z,g_detail17[l_ac].mmau018z_desc,g_detail17[l_ac].mmau009z,g_detail17[l_ac].mmau011z,g_detail17[l_ac].mmau012z
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF           
      SELECT mmaq002 INTO g_detail17[l_ac].mmaq002z FROM mmaq_t WHERE mmaqent = g_enterprise
         AND mmaq001 = g_detail17[l_ac].mmau001
      SELECT mmanl003 INTO  g_detail17[l_ac].mmaq002z_desc FROM mmanl_t
       WHERE mmanlent = g_enterprise AND mmanl001 = g_detail17[l_ac].mmaq002z
         AND mmanl002 = g_dlang       
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail17.deleteElement(g_detail17.getLength())
   
   #end add-point
 
 
 
   #add-point:b_fill段資料填充(其他單身)
   
   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整
 
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   IF g_detail_cnt > 0 THEN
      LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
 
   CALL acrq500_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="acrq500.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION acrq500_b_fill2()
   {<Local define>}
   DEFINE li_ac           LIKE type_t.num5
   {</Local define>}
   #add-point:b_fill2段define
   
   #end add-point
 
   LET li_ac = 1
 
   #單身組成
   #+ 此段落由子樣板qs11產生
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
   #add-point:sql組成
   
   #end add-point
 
 
 
 
   #add-point:單身填充後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="acrq500.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION acrq500_detail_show(ps_page)
   DEFINE ps_page   STRING
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
 
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_detail[l_ac].mmaq002
            CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_detail[l_ac].mmaq002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail[l_ac].mmaq002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_detail[l_ac].mmaq003
            CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_detail[l_ac].mmaq003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail[l_ac].mmaq003_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'4'",1) > 0 THEN
      #帶出公用欄位reference值page4
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'5'",1) > 0 THEN
      #帶出公用欄位reference值page5
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'6'",1) > 0 THEN
      #帶出公用欄位reference值page6
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'7'",1) > 0 THEN
      #帶出公用欄位reference值page7
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'8'",1) > 0 THEN
      #帶出公用欄位reference值page8
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'9'",1) > 0 THEN
      #帶出公用欄位reference值page9
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'10'",1) > 0 THEN
      #帶出公用欄位reference值page10
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'11'",1) > 0 THEN
      #帶出公用欄位reference值page11
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'12'",1) > 0 THEN
      #帶出公用欄位reference值page12
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'13'",1) > 0 THEN
      #帶出公用欄位reference值page13
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'14'",1) > 0 THEN
      #帶出公用欄位reference值page14
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'15'",1) > 0 THEN
      #帶出公用欄位reference值page15
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'16'",1) > 0 THEN
      #帶出公用欄位reference值page16
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'17'",1) > 0 THEN
      #帶出公用欄位reference值page17
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'18'",1) > 0 THEN
      #帶出公用欄位reference值page18
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'19'",1) > 0 THEN
      #帶出公用欄位reference值page19
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'20'",1) > 0 THEN
      #帶出公用欄位reference值page20
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'21'",1) > 0 THEN
      #帶出公用欄位reference值page21
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'22'",1) > 0 THEN
      #帶出公用欄位reference值page22
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'23'",1) > 0 THEN
      #帶出公用欄位reference值page23
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'24'",1) > 0 THEN
      #帶出公用欄位reference值page24
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="acrq500.other_function" readonly="Y" >}

#construct
PRIVATE FUNCTION acrq500_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define
   let l_year3 = null
   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_master.* TO NULL
   CALL g_detail.clear()
   CALL g_detail2.clear()
   CALL g_detail3.clear()
   CALL g_detail4.clear()
   CALL g_detail5.clear()
   CALL g_detail6.clear()
   CALL g_detail7.clear()
   CALL g_detail8.clear()
   CALL g_detail9.clear()
   CALL g_detail10.clear()
   CALL g_detail11.clear()
   CALL g_detail12.clear()
   CALL g_detail13.clear()
   CALL g_detail14.clear()
   CALL g_detail15.clear()
   CALL g_detail16.clear()
   CALL g_detail17.clear()
   CALL g_detail18.clear()
   CALL g_detail19.clear()
   CALL g_detail20.clear()
   CALL g_detail21.clear()
   CALL g_detail22.clear()
   CALL g_detail23.clear()
   CALL g_detail24.clear()
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT g_wc ON mmaf001,mmaf008,mmaf009,mmaf013,mmaf014,mmaf011,mmag004
           FROM mmaf001,mmaf008,mmaf009,mmaf013,mmaf014,mmaf011,sex
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            CALL cl_qbe_init()                        
            #end add-point 
            
         #公用欄位開窗相關處理
         
            
         #一般欄位開窗相關處理    
         #---------------------------<  Master  >---------------------------
         #----<<mmaf001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmaf001
            #add-point:BEFORE FIELD mmaf001
                                    
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaf001
            
            #add-point:AFTER FIELD mmaf001
                                    
            #END add-point
            
 
         #Ctrlp:construct.c.mmaf001
         ON ACTION controlp INFIELD mmaf001
            #add-point:ON ACTION controlp INFIELD mmaf001
                                                #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mmaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaf001  #顯示到畫面上

            NEXT FIELD mmaf001                     #返回原欄位
            #END add-point
 
         
         #----<<mmaf008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmaf008
            #add-point:BEFORE FIELD mmaf008
                                    
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaf008
            
            #add-point:AFTER FIELD mmaf008
                                    
            #END add-point
            
 
         #Ctrlp:construct.c.mmaf008
         ON ACTION controlp INFIELD mmaf008
            #add-point:ON ACTION controlp INFIELD mmaf008
                                    
            #END add-point
 
         #----<<mmaf009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmaf009
            #add-point:BEFORE FIELD mmaf009
                                    
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaf009
            
            #add-point:AFTER FIELD mmaf009
                                    
            #END add-point
            
 
         #Ctrlp:construct.c.mmaf009
         ON ACTION controlp INFIELD mmaf009
            #add-point:ON ACTION controlp INFIELD mmaf009
                                    
            #END add-point
 
         #----<<mmaf013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmaf013
            #add-point:BEFORE FIELD mmaf013
                                    
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaf013
            
            #add-point:AFTER FIELD mmaf013
                                    
            #END add-point
            
 
         #Ctrlp:construct.c.mmaf013
         ON ACTION controlp INFIELD mmaf013
            #add-point:ON ACTION controlp INFIELD mmaf013
                                    
            #END add-point
 
         #----<<mmaf014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmaf014
            #add-point:BEFORE FIELD mmaf014
                                    
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaf014
            
            #add-point:AFTER FIELD mmaf014
                                    
            #END add-point
            
 
         #Ctrlp:construct.c.mmaf014
         ON ACTION controlp INFIELD mmaf014
            #add-point:ON ACTION controlp INFIELD mmaf014
                                    
            #END add-point
 
 
         #此段落由子樣板a02產生
         AFTER FIELD mmaf011
            
            #add-point:AFTER FIELD mmaf011
                                    
            #END add-point
            
 
         #Ctrlp:construct.c.mmaf011
         ON ACTION controlp INFIELD mmaf011
            #add-point:ON ACTION controlp INFIELD mmaf011
                                    
            #END add-point
         ON ACTION controlp INFIELD sex
            #add-point:ON ACTION controlp INFIELD mmaf001
                                                #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2016'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sex  #顯示到畫面上

            NEXT FIELD sex                     #返回原欄位
         
      END CONSTRUCT
 
      #單身根據table分拆construct
       
      CONSTRUCT g_wc2_table1 ON mmaq001,mmaq002,mmaq005,mmaq006,mmaq007,mmaq009,mmaq013,
                                mmaq014,mmaq015,mmaq016,mmaq017,mmaq018
           FROM s_detail1[1].b_mmaq001,s_detail1[1].b_mmaq002,s_detail1[1].b_mmaq005,s_detail1[1].b_mmaq006,s_detail1[1].b_mmaq007,s_detail1[1].b_mmaq009,s_detail1[1].b_mmaq013,
                s_detail1[1].b_mmaq014,s_detail1[1].b_mmaq015,s_detail1[1].b_mmaq016,s_detail1[1].b_mmaq017,s_detail1[1].b_mmaq018
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
                                    
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<mmag002>>----
         #Ctrlp:construct.c.page1.mmaq001
         ON ACTION controlp INFIELD b_mmaq001
            #add-point:ON ACTION controlp INFIELD mmag002
                                                #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_mmaq001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_mmaq001  #顯示到畫面上
            NEXT FIELD b_mmaq001                     #返回原欄位


            #END add-point
         #----<<mmag003>>----
           
         #Ctrlp:construct.c.page1.mmag003
         ON ACTION controlp INFIELD b_mmaq002
            #add-point:ON ACTION controlp INFIELD mmag003
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_mman001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_mmaq002  #顯示到畫面上
            NEXT FIELD b_mmaq002                     #返回原欄位                        
            #END add-point
 
         #----<<mmag004>>----
         #Ctrlp:construct.c.page1.mmag004
         ON ACTION controlp INFIELD b_mmaq003
            #add-point:ON ACTION controlp INFIELD mmag004
                                                #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   CALL q_mmaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_mmaq003  #顯示到畫面上
            NEXT FIELD b_mmaq003                     #返回原欄位


            #END add-point         
            
 
         #----<<mmag004_desc>>----
   
       
      END CONSTRUCT
      
      INPUT l_year3 FROM  age
         BEFORE INPUT
            DISPLAY l_year3 TO age
         AFTER FIELD age
            IF NOT cl_null(l_year3)  THEN
               LET l_year2 = year(g_today)-(l_year3-1)
               LET l_year_str2 = l_year2,'01','01'
               let l_date3 = l_year_str2
               LET l_year_str2 = "mmaf015>='",l_date3,"' AND mmaf015<='",g_today,"' "
            END IF
          
      END INPUT
 
      BEFORE DIALOG
#         CALL cl_qbe_init()
         #add-point:cs段b_dialog
                           
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   #組合g_wc2
   IF cl_null(g_wc2_table1) THEN
      LET g_wc2_table1=" 1=1"
   END IF
   IF cl_null(g_wc2_table2) THEN
      LET g_wc2_table2=" 1=1"
   END IF
   IF cl_null(g_wc2_table3) THEN
      LET g_wc2_table3=" 1=1"
   END IF
   IF cl_null(g_wc2_table4) THEN
      LET g_wc2_table4=" 1=1"
   END IF
   LET g_wc2 = g_wc2_table1
   IF cl_null(g_wc) THEN
      LET g_wc=" 1=1"
   END IF
   IF NOT cl_null(l_year3) THEN
      LET g_wc = g_wc," AND ",l_year_str2
   END IF
#   IF g_wc2_table2 <> " 1=1" THEN
#      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
#   END IF
# 
#   IF g_wc2_table3 <> " 1=1" THEN
#      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
#   END IF
# 
#   IF g_wc2_table4 <> " 1=1" THEN
#      LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
#   END IF
 
 
 
 
   
   #add-point:cs段結束前
           
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
END FUNCTION

#construct
PRIVATE FUNCTION acrq500_construct_rtja()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define
   #end add-point    
 
   #清除畫面
   CALL g_detail12.clear()
   CALL g_detail18.clear()
   CALL g_detail19.clear()
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc3 TO NULL
   
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前
   DISPLAY ARRAY g_detail12 TO s_detail2.*
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
   DISPLAY ARRAY g_detail18 TO s_detail3.*
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
   DISPLAY ARRAY g_detail19 TO s_detail4.*
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單身根據table分拆construct
      
      CONSTRUCT g_wc2_table2 ON rtjasite,rtjadocno,rtja032,rtja007,rtja001,rtjadocdt,rtja031,rtja016
           FROM s_detail2[1].rtjasite,s_detail2[1].rtjadocno,s_detail2[1].rtja032,s_detail2[1].rtja007, 
               s_detail2[1].rtja001,s_detail2[1].rtjadocdt,s_detail2[1].rtja031,s_detail2[1].rtja016
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
                                    
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page2  >---------------------
         #----<<mmah002>>----
         #Ctrlp:construct.c.page2.mmah002
         ON ACTION controlp INFIELD rtjasite
            #add-point:ON ACTION controlp INFIELD mmah002
                                                #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtjasite  #顯示到畫面上

            NEXT FIELD rtjasite                     #返回原欄位


            #END add-point          
 
         #Ctrlp:construct.c.page2.mmah003
         ON ACTION controlp INFIELD rtjadocno
            #add-point:ON ACTION controlp INFIELD mmah003
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_rtjadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtjadocno  #顯示到畫面上

            NEXT FIELD rtjadocno                     #返回原欄位                        
            #END add-point
    
         ON ACTION controlp INFIELD rtja007
            #add-point:ON ACTION controlp INFIELD mmah003
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_rtia033()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtja007  #顯示到畫面上

            NEXT FIELD rtja007                     #返回原欄位                        
            #END add-point
         ON ACTION controlp INFIELD rtja001
            #add-point:ON ACTION controlp INFIELD mmah003
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " mmaq003 = '",g_master.mmaf001,"'"
            CALL q_mmaq001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtja001  #顯示到畫面上

            NEXT FIELD rtja001                     #返回原欄位                        
            #END add-point   
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON rtje001,rtje002,rtje006,rtje004
           FROM s_detail3[1].rtje001,s_detail3[1].rtje002,s_detail3[1].rtje006,s_detail3[1].rtje004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
                                    
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
         ON ACTION controlp INFIELD rtje002
            #add-point:ON ACTION controlp INFIELD mmah003
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooia001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtje002  #顯示到畫面上

            NEXT FIELD rtja001                     #返回原欄位      
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page3  >---------------------
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON rtjbseq,rtjb003,rtjb004,rtjb008,rtjb009,rtjb010,rtjb013,rtjb012,
                                rtjb020,rtjb021,rtjb025,rtjb026,rtjb027,rtjb028
           FROM s_detail4[1].rtjbseq,s_detail4[1].rtjb003,s_detail4[1].rtjb004,s_detail4[1].rtjb008,s_detail4[1].rtjb009,s_detail4[1].rtjb010,s_detail4[1].rtjb013,s_detail4[1].rtjb012,
                s_detail4[1].rtjb020,s_detail4[1].rtjb021,s_detail4[1].rtjb025,s_detail4[1].rtjb026,s_detail4[1].rtjb027,s_detail4[1].rtjb028
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
                                    
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page4  >---------------------
         #Ctrlp:construct.c.page4.mmaj002
         ON ACTION controlp INFIELD rtjb003
            #add-point:ON ACTION controlp INFIELD mmaj002
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtjb003  #顯示到畫面上

            NEXT FIELD rtjb003                     #返回原欄位
            #END add-point
         ON ACTION controlp INFIELD rtjb004
            #add-point:ON ACTION controlp INFIELD mmaj002
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imaa001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtjb004  #顯示到畫面上

            NEXT FIELD rtjb004                     #返回原欄位
            #END add-point
         ON ACTION controlp INFIELD rtjb013
            #add-point:ON ACTION controlp INFIELD mmaj002
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtjb013  #顯示到畫面上

            NEXT FIELD rtjb013                     #返回原欄位
            #END add-point
         ON ACTION controlp INFIELD rtjb025
            #add-point:ON ACTION controlp INFIELD mmaj002
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_inaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtjb025  #顯示到畫面上

            NEXT FIELD rtjb025                     #返回原欄位
            #END add-point  
         ON ACTION controlp INFIELD rtjb026
            #add-point:ON ACTION controlp INFIELD mmaj002
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_inag005_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtjb026  #顯示到畫面上

            NEXT FIELD rtjb026                     #返回原欄位
            #END add-point 
         ON ACTION controlp INFIELD rtjb027
            #add-point:ON ACTION controlp INFIELD mmaj002
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_inag006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtjb027  #顯示到畫面上

            NEXT FIELD rtjb027                     #返回原欄位
            #END add-point 
         ON ACTION controlp INFIELD rtjb028
            #add-point:ON ACTION controlp INFIELD mmaj002
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_inaa120()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtjb028  #顯示到畫面上

            NEXT FIELD rtjb028                     #返回原欄位
            #END add-point            
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
                        
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog
                           
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   #組合g_wc2
   IF cl_null(g_wc2_table2) THEN
      LET g_wc2_table2=" 1=1"
   END IF
   IF cl_null(g_wc2_table3) THEN
      LET g_wc2_table3=" 1=1"
   END IF
   IF cl_null(g_wc2_table4) THEN
      LET g_wc2_table4=" 1=1"
   END IF
   LET g_wc3 = g_wc2_table2
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc3 = g_wc3 ," AND ", g_wc2_table3
   END IF
 
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc3 = g_wc3 ," AND ", g_wc2_table4
   END IF
 
 
 
 
   
   #add-point:cs段結束前
           
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
END FUNCTION

#query
PRIVATE FUNCTION acrq500_query()
   LET INT_FLAG = 0    
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM      
   CALL g_detail.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL acrq500_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
#      CALL acrq500_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL acrq500_cs()
END FUNCTION

#display 單頭
PRIVATE FUNCTION acrq500_display_all()
   
   DEFINE l_num      LIKE type_t.num5
   DEFINE l_mmaf015  LIKE mmaf_t.mmaf015
   DEFINE l_year     LIKE type_t.num5
   DEFINE l_ooga009  LIKE ooga_t.ooga009
   DEFINE l_date1    LIKE type_t.dat
   DEFINE l_date2    LIKE type_t.dat
   DEFINE l_year_str LIKE type_t.chr10
   DEFINE l_wc       STRING
   DEFINE l_sql      STRING
   DEFINE l_count    LIKE type_t.num10
   DEFINE l_max      LIKE type_t.num10
   DEFINE l_ooga002  LIKE ooga_t.ooga002
   DEFINE l_mmaq014  LIKE mmaq_t.mmaq014
   DEFINE l_mmaq040  LIKE mmaq_t.mmaq040
   DEFINE g_mmaf            DYNAMIC ARRAY OF type_g_mmaf
   DEFINE g_mmaf_t          type_g_mmaf
   DEFINE l_cnt      LIKE type_t.num10 
   DEFINE l_str1     STRING
   DEFINE l_str2     STRING   
   
   
   SELECT mmaf001,mmaf008,mmaf009,mmaf013,mmaf014,mmaf011,mmaf015,mmaf020,mmaf021
     INTO g_master.mmaf001,g_master.mmaf008,g_master.mmaf009,g_master.mmaf013,g_master.mmaf014,g_master.mmaf011,
          l_mmaf015,g_master.mmaf020a,g_master.mmaf021a
     FROM mmaf_t
    WHERE mmafent = g_enterprise AND mmaf001 = g_master.mmaf001
   SELECT mmag004 INTO g_master.sex FROM mmag_t
    WHERE mmagent= g_enterprise AND mmag001 = g_master.mmaf001
      AND mmag002='01' AND mmag003='2016'
   SELECT oocql004 INTO  g_master.sex_desc FROM oocql_t
    WHERE oocqlent = g_enterprise AND oocql001 = '2016'
      AND oocql002 = g_master.sex AND oocql003 = g_dlang
   SELECT sum(mmaq018) INTO g_master.mmaq018a FROM mmaq_t
    WHERE mmaqent = g_enterprise AND mmaq003 = g_master.mmaf001 
#      AND mmaq006 = '3'   #mark by yangxf 
   SELECT sum(mmaq016) INTO g_master.mmaq016a FROM mmaq_t
    WHERE mmaqent = g_enterprise AND mmaq003 = g_master.mmaf001 
      AND mmaq006 <> '7'
   IF NOT cl_null( l_mmaf015) THEN     
      LET g_master.age = year(g_today)-year(l_mmaf015)+1  
   END IF
   LET l_year = year(g_today)   
   SELECT ooga009 INTO l_ooga009 FROM ooga_t
    WHERE oogaent = g_enterprise AND ooga001 = g_today
   LET l_year_str = l_year,'01','01'
   LET l_date1 = l_year_str
   LET l_year_str = l_year,'12','31'
   LET l_date2 = l_year_str
   LET l_wc = " ooga001 >= '",l_date1,"' AND ooga001 <= '",l_date2,"'"
   LET l_sql=" SELECT sum(decc021)",
             "   FROM decc_t LEFT JOIN ooga_t ON ooga001 = decc002 AND oogaent = deccent AND ooga009=",l_ooga009,
             "  WHERE deccent = ",g_enterprise," AND decc001 = '",g_master.mmaf001,"' ",
             "  AND ",l_wc
   PREPARE l_sql_decc021a FROM l_sql
   EXECUTE l_sql_decc021a INTO g_master.decc021a 
   LET l_sql=" SELECT sum(decc021),sum(decc010)",
             "   FROM decc_t LEFT JOIN ooga_t ON ooga001 = decc002 AND oogaent = deccent ",
             "  WHERE deccent = ",g_enterprise," AND decc001 = '",g_master.mmaf001,"' ",
             "  AND ",l_wc 
   PREPARE l_sql_decc021b FROM l_sql
   EXECUTE l_sql_decc021b INTO g_master.decc021b,g_master.decc010a             
#   SELECT sum(decc021) INTO g_master.decc021b 
#     FROM decc_t LEFT JOIN ooga_t ON ooga001 = decc002 AND oogaent = deccent
#    WHERE deccent = g_enterprise AND decc001 = g_master.mmaf001
#      AND (decc002 >= l_date1 AND decc002 <= l_date2) 
   SELECT max(mmaq013) INTO g_master.mmaq013a FROM mmaq_t
     WHERE mmaqent = g_enterprise AND mmaq003 = g_master.mmaf001 AND mmaq006<>'7'
   LET g_master.daya = g_today- g_master.mmaq013a
   LET l_count=0
   LET l_max = 0
   LET g_master.weekend = NULL
   LET l_sql=" SELECT count(*),ooga002 FROM decc_t LEFT JOIN ooga_t ON oogaent=oogaent AND ooga001=decc002",
             "  WHERE deccent = ",g_enterprise," AND decc001 = '",g_master.mmaf001,"' ",
             "  GROUP BY ooga002 "
   PREPARE l_sql_ooga_pre FROM l_sql
   DECLARE l_sql_ooga_cs CURSOR FOR l_sql_ooga_pre
   FOREACH l_sql_ooga_cs INTO l_count,l_ooga002
      IF l_count > l_max THEN
         LET l_max=l_count
         LET g_master.weekend = l_ooga002
      END IF
      LET l_count=0
      LET l_ooga002=null
   END FOREACH 
   SELECT sum(mmaq014),min(mmaq040),sum(mmaq015),sum(mmaq009)
     INTO l_mmaq014,l_mmaq040,g_master.mmaq015a,g_master.mmaq009a
     FROM mmaq_t
    WHERE mmaqent = g_enterprise AND mmaq003 = g_master.mmaf001 AND mmaq006<>'7'
   LET l_num=0
   LET l_num = g_today - l_mmaq040
   IF cl_null(l_num) OR l_num = 0 THEN
   ELSE
      LET g_master.rate = l_mmaq014/l_num
   END IF   
   LET g_master.mmaq014a = l_mmaq014
   IF cl_null(l_mmaq014) OR l_mmaq014=0 THEN
   ELSE
      LET g_master.mmaq015b = g_master.mmaq015a/l_mmaq014
   END IF      
   SELECT MAX(rtja031) INTO g_master.rtia031a 
     FROM rtja_t
    WHERE rtjaent = g_enterprise 
      AND rtja001 IN ( SELECT mmaq001 FROM mmaq_t WHERE mmaqent = g_enterprise AND mmaq003 = g_master.mmaf001 )
   SELECT sum(decc018) INTO g_master.decc018a FROM decc_t
    WHERE deccent = g_enterprise AND decc001 = g_master.mmaf001
   SELECT count(*) INTO g_master.crba021a FROM crba_t
    WHERE crba012 = g_master.mmaf001 AND crbastus IN ('Y','C') AND crbaent=g_enterprise #160905-00007#1 add
   IF cl_null(g_master.mmaq014a) OR g_master.mmaq014a=0 THEN
   ELSE
      LET g_master.mmaq014b = (g_master.mmaq014a-g_master.decc018a-g_master.crba021a)/g_master.mmaq014a*100 
   END IF

   SELECT sum(mmau009),max(mmau009),count(*)
     INTO g_master.mmau009a,g_master.mmau009d,g_master.mmaucount 
     FROM mmau_t
     WHERE mmauent = g_enterprise AND mmau002 = g_master.mmaf001
   IF cl_null(g_master.mmaucount) OR g_master.mmaucount=0 THEN
   ELSE
      LET g_master.mmau009e = g_master.mmau009a/g_master.mmaucount
   END IF
   
   LET l_sql=" SELECT sum(mmau009)",
             "   FROM mmau_t LEFT JOIN ooga_t ON ooga001 = to_date(cast(mmau006 as date))  AND oogaent = mmauent AND ooga009=",l_ooga009,
             "  WHERE mmauent = ",g_enterprise," AND mmau002 = '",g_master.mmaf001,"' ",
             "  AND ",l_wc 
   PREPARE l_sql_mmau009b FROM l_sql
   EXECUTE l_sql_mmau009b INTO g_master.mmau009b
   
   LET l_sql=" SELECT sum(mmau009)",
             "   FROM mmau_t LEFT JOIN ooga_t ON ooga001 = to_date(cast(mmau006 as date))  AND oogaent = mmauent ",
             "  WHERE mmauent = ",g_enterprise," AND mmau002 = '",g_master.mmaf001,"' ",
             "  AND ",l_wc 
   PREPARE l_sql_mmau009c FROM l_sql
   EXECUTE l_sql_mmau009c INTO g_master.mmau009c 
   SELECT count(*) INTO l_count FROM mmaf_t WHERE mmafent = g_enterprise #160905-00007#1 add
   LET l_sql = " SELECT mmaf001,nvl(SUM(mmaq015),0) COUNT FROM mmaf_t LEFT JOIN mmaq_t ON mmaq003 = mmaf001 AND mmaqent = mmafent AND mmaq006<>'7' ",
               "  WHERE  mmafent =",g_enterprise,
               "  GROUP BY mmaf001 ORDER BY COUNT DESC"
   PREPARE l_sql_mmaf001_pre FROM l_sql
   DECLARE l_sql_mmaf001_cs CURSOR FOR l_sql_mmaf001_pre
   LET l_cnt = 1
   CALL g_mmaf.clear()
   FOREACH l_sql_mmaf001_cs INTO  g_mmaf[l_cnt].mmaf001,g_mmaf[l_cnt].count
      IF sqlca.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = sqlca.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      IF g_mmaf[l_cnt].mmaf001 = g_master.mmaf001 THEN
         let l_str1=l_cnt
         let l_str2=l_count
         LET g_master.mmaqcount = l_str1.trim(),"/",l_str2.trim()
         EXIT FOREACH
      END IF
      LET l_cnt = l_cnt+1
   END FOREACH   
END FUNCTION

#fill rtja,rtje,rtjb
PRIVATE FUNCTION acrq500_b_fill3(p_wc)
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   DEFINE ls_chk          LIKE type_t.chr1
   define l_sql           string
   DEFINE l_cnt           LIKE type_t.num5
   define p_wc            string
   
   CALL g_detail12.clear()
   CALL g_detail18.clear()
   CALL g_detail19.clear()
   IF cl_null(p_wc) THEN
      LET p_wc = " 1=1"
   END IF
   
   LET li_ac = l_ac 
   LET l_sql = " SELECT DISTINCT rtjasite,'',rtjadocno,rtja032,rtja007,rtja001,rtjadocdt,rtja031,'',rtja016 ",
               "   FROM rtja_t LEFT JOIN mmaq_t ON rtja001 = mmaq001 AND rtjaent=mmaqent ",
               "               LEFT JOIN rtjb_t ON rtjadocno = rtjbdocno AND rtjaent = rtjbent ",
               "               LEFT JOIN rtje_t ON rtjadocno = rtjedocno AND rtjaent = rtjeent ",
               "  WHERE rtjaent=? AND mmaq003=? AND ",p_wc 
   LET l_sql = l_sql," ORDER BY rtjadocno,rtja001 "    
   PREPARE l_sql_rtja_pre21 FROM l_sql
   DECLARE l_sql_rtja_cs21 CURSOR FOR l_sql_rtja_pre21
   LET l_sql = " SELECT DISTINCT rtje001,rtje002,'',rtje006,rtje004 ",
               "   FROM rtje_t ",
               "  WHERE rtjeent=? AND rtjedocno=? "
   IF NOT cl_null(g_wc2_table3) THEN
      LET l_sql = l_sql," AND ",g_wc2_table3
   END IF 
   LET l_sql = l_sql," ORDER BY rtje001,rtje002 "    
   PREPARE l_sql_rtje_pre31 FROM l_sql
   DECLARE l_sql_rtje_cs31 CURSOR FOR l_sql_rtje_pre31
   LET l_sql = " SELECT DISTINCT rtjbseq,rtjb003,rtjb004,'',rtjb008,rtjb009,rtjb010,rtjb013,'',rtjb012,rtjb020,rtjb021,rtjb025,rtjb026,rtjb027,rtjb028 ",
               "   FROM rtjb_t ",
               "  WHERE rtjbent=? AND rtjbdocno=? "
   IF NOT cl_null(g_wc2_table4) THEN
      LET l_sql = l_sql," AND ",g_wc2_table4
   END IF 
   LET l_sql = l_sql," ORDER BY rtjbseq,rtjb004 "    
   PREPARE l_sql_rtjb_pre41 FROM l_sql
   DECLARE l_sql_rtjb_cs41 CURSOR FOR l_sql_rtjb_pre41
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #+ 此段落由子樣板qs09產生
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql
   
   LET l_ac = 1
   OPEN l_sql_rtja_cs21 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_rtja_cs21 INTO g_detail12[l_ac].rtjasite,g_detail12[l_ac].rtjasite_desc,g_detail12[l_ac].rtjadocno,g_detail12[l_ac].rtja032,g_detail12[l_ac].rtja007,g_detail12[l_ac].rtja001,
      g_detail12[l_ac].rtjadocdt,g_detail12[l_ac].rtja031,g_detail12[l_ac].rtjb020,g_detail12[l_ac].rtja016
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      select ooefl003 into g_detail12[l_ac].rtjasite_desc from ooefl_t
       where ooeflent = g_enterprise and ooefl001 = g_detail12[l_ac].rtjasite
         and ooefl002 = g_dlang
      SELECT SUM(rtjb020) INTO g_detail12[l_ac].rtjb020
        FROM rtjb_t
       WHERE rtjbent = g_enterprise
         AND rtjbdocno = g_detail12[l_ac].rtjadocno
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail12.deleteElement(g_detail12.getLength()) 
   LET l_cnt=g_cnt
   IF g_detail12.getLength()<g_cnt  THEN
      LET l_cnt = g_detail12.getLength()
   END IF
   IF cl_null(l_cnt) OR l_cnt=0 THEN
      LET l_cnt = 1
   END IF   
   LET l_ac = 1
   OPEN l_sql_rtje_cs31 USING g_enterprise,g_detail12[l_cnt].rtjadocno
   FOREACH  l_sql_rtje_cs31 INTO g_detail18[l_ac].rtje001,g_detail18[l_ac].rtje002,g_detail18[l_ac].rtje002_desc,g_detail18[l_ac].rtje006,g_detail18[l_ac].rtje004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT ooial003 INTO g_detail18[l_ac].rtje002_desc FROM ooial_t
       WHERE ooialent = g_enterprise AND ooial001 = g_detail18[l_ac].rtje002
         AND ooial002 = g_dlang
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail18.deleteElement(g_detail18.getLength())  
   LET l_ac = 1
   OPEN l_sql_rtjb_cs41 USING g_enterprise,g_detail12[l_cnt].rtjadocno
   FOREACH  l_sql_rtjb_cs41 INTO g_detail19[l_ac].rtjbseq,g_detail19[l_ac].rtjb003,g_detail19[l_ac].rtjb004,g_detail19[l_ac].rtjb004_desc,g_detail19[l_ac].rtjb008,
            g_detail19[l_ac].rtjb009,g_detail19[l_ac].rtjb010,g_detail19[l_ac].rtjb013,g_detail19[l_ac].rtjb013_desc,g_detail19[l_ac].rtjb012,g_detail19[l_ac].rtjb020,
            g_detail19[l_ac].rtjb021,g_detail19[l_ac].rtjb025,g_detail19[l_ac].rtjb026,g_detail19[l_ac].rtjb027,g_detail19[l_ac].rtjb028
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT imaal003 INTO g_detail19[l_ac].rtjb004_desc FROM imaal_t
       WHERE imaalent = g_enterprise AND imaal001 = g_detail19[l_ac].rtjb004
         AND imaal002 = g_dlang
      SELECT oocal003 INTO g_detail19[l_ac].rtjb013_desc FROM oocal_t
       WHERE oocalent = g_enterprise AND oocal001 = g_detail19[l_ac].rtjb013
         AND oocal002 = g_dlang
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail19.deleteElement(g_detail19.getLength())    
   #end add-point
 
   #add-point:陣列長度調整
   LET l_ac = li_ac
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail12.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   IF g_detail_cnt > 0 THEN
      LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
END FUNCTION

#fill rtje,rtjb
PRIVATE FUNCTION acrq500_b_fill4()
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   DEFINE ls_chk          LIKE type_t.chr1
   define l_sql           string
   DEFINE l_cnt           LIKE type_t.num5
   
   CALL g_detail18.clear()
   CALL g_detail19.clear()
   
   LET li_ac = l_ac 
   
   LET l_sql = " SELECT rtje001,rtje002,'',rtje006,rtje004 ",
               "   FROM rtje_t ",
               "  WHERE rtjeent=? AND rtjedocno=? "
   IF NOT cl_null(g_wc2_table3) THEN
      LET l_sql = l_sql," AND ",g_wc2_table3
   END IF 
   LET l_sql = l_sql," ORDER BY rtje001,rtje002 "    
   PREPARE l_sql_rtje_pre32 FROM l_sql
   DECLARE l_sql_rtje_cs32 CURSOR FOR l_sql_rtje_pre32
   LET l_sql = " SELECT rtjbseq,rtjb003,rtjb004,'',rtjb008,rtjb009,rtjb010,rtjb013,'',rtjb012,rtjb020,rtjb021,rtjb025,rtjb026,rtjb027,rtjb028 ",
               "   FROM rtjb_t ",
               "  WHERE rtjbent=? AND rtjbdocno=? "
   IF NOT cl_null(g_wc2_table4) THEN
      LET l_sql = l_sql," AND ",g_wc2_table4
   END IF 
   LET l_sql = l_sql," ORDER BY rtjbseq,rtjb004 "    
   PREPARE l_sql_rtjb_pre42 FROM l_sql
   DECLARE l_sql_rtjb_cs42 CURSOR FOR l_sql_rtjb_pre42
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #+ 此段落由子樣板qs09產生
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql
   
   LET l_ac = 1
   LET l_cnt=li_ac
   IF g_detail12.getLength()<g_cnt  THEN
      LET l_cnt = g_detail12.getLength()
   END IF
   IF cl_null(l_cnt) OR l_cnt=0 THEN
      LET l_cnt = 1
   END IF   
   LET l_ac = 1
   OPEN l_sql_rtje_cs32 USING g_enterprise,g_detail12[l_cnt].rtjadocno
   FOREACH  l_sql_rtje_cs32 INTO g_detail18[l_ac].rtje001,g_detail18[l_ac].rtje002,g_detail18[l_ac].rtje002_desc,g_detail18[l_ac].rtje006,g_detail18[l_ac].rtje004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT ooial003 INTO g_detail18[l_ac].rtje002_desc FROM ooial_t
       WHERE ooialent = g_enterprise AND ooial001 = g_detail18[l_ac].rtje002
         AND ooial002 = g_dlang
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail18.deleteElement(g_detail18.getLength())  
   LET l_ac = 1
   OPEN l_sql_rtjb_cs42 USING g_enterprise,g_detail12[l_cnt].rtjadocno
   FOREACH  l_sql_rtjb_cs42 INTO g_detail19[l_ac].rtjbseq,g_detail19[l_ac].rtjb003,g_detail19[l_ac].rtjb004,g_detail19[l_ac].rtjb004_desc,g_detail19[l_ac].rtjb008,
            g_detail19[l_ac].rtjb009,g_detail19[l_ac].rtjb010,g_detail19[l_ac].rtjb013,g_detail19[l_ac].rtjb013_desc,g_detail19[l_ac].rtjb012,g_detail19[l_ac].rtjb020,
            g_detail19[l_ac].rtjb021,g_detail19[l_ac].rtjb025,g_detail19[l_ac].rtjb026,g_detail19[l_ac].rtjb027,g_detail19[l_ac].rtjb028
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT imaal003 INTO g_detail19[l_ac].rtjb004_desc FROM imaal_t
       WHERE imaalent = g_enterprise AND imaal001 = g_detail19[l_ac].rtjb004
         AND imaal002 = g_dlang
      SELECT oocal003 INTO g_detail19[l_ac].rtjb013_desc FROM oocal_t
       WHERE oocalent = g_enterprise AND oocal001 = g_detail19[l_ac].rtjb013
         AND oocal002 = g_dlang
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail19.deleteElement(g_detail19.getLength())    
   #end add-point
 
   #add-point:陣列長度調整
   let l_ac=li_ac
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail12.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   IF g_detail_cnt > 0 THEN
      LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
END FUNCTION

#填充单身###########################
PRIVATE FUNCTION acrq500_b_fill5(pi_idx)
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   DEFINE ls_chk          LIKE type_t.chr1
   define l_sql           string
   DEFINE l_cnt           LIKE type_t.num5
   
   CALL g_detail21.clear()
   CALL g_detail22.clear()
   
   LET li_ac = l_ac
   LET l_cnt = pi_idx   
   LET l_sql = " SELECT to_char(deca002,'YYYYMM'),decasite,'',sum(deca027),sum(deca031),sum(deca030),sum(deca033),sum(deca025-deca027) ",
               "   FROM deca_t LEFT JOIN ooga_t ON ooga001=deca002 AND oogaent = decaent  ",
               "  WHERE decaent=? AND deca020 = ? AND deca013=? AND ",l_wc  
   LET l_sql = l_sql," GROUP BY to_char(deca002,'YYYYMM'),decasite,'' ORDER BY to_char(deca002,'YYYYMM'),decasite,'' "    
   PREPARE l_sql_deca_pre61 FROM l_sql
   DECLARE l_sql_deca_cs61 CURSOR FOR l_sql_deca_pre61

   LET l_sql = " SELECT deca009,'',deca010,deca019,sum(deca022),sum(deca027),sum(deca030),sum(deca025-deca027) ",
               "   FROM deca_t ",
               "  WHERE decaent=? AND deca020 = ? AND deca013=? GROUP BY deca009,'',deca010,deca019,'' "  
   LET l_sql = l_sql," ORDER BY deca009,'',deca010,deca019,'' "    
   PREPARE l_sql_deca_pre71 FROM l_sql
   DECLARE l_sql_deca_cs71 CURSOR FOR l_sql_deca_pre71
   
   LET l_ac = 1   
   OPEN l_sql_deca_cs6 USING g_enterprise,g_master.mmaf001,g_detail20[l_cnt].deca013a
   FOREACH  l_sql_deca_cs6 INTO g_detail21[l_ac].deca002b,g_detail21[l_ac].decasiteb,g_detail21[l_ac].decasitea_desc,g_detail21[l_ac].deca027b,
      g_detail21[l_ac].deca031b,g_detail21[l_ac].deca030b,g_detail21[l_ac].deca033b,g_detail21[l_ac].deca025b
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT ooefl003 INTO g_detail21[l_ac].decasitea_desc FROM ooefl_t
       WHERE ooefl001 = g_detail21[l_ac].decasiteb AND ooefl002 = g_dlang
         AND ooeflent = g_enterprise
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail21.deleteElement(g_detail21.getLength())
   
   LET l_ac = 1   
   OPEN l_sql_deca_cs7 USING g_enterprise,g_master.mmaf001,g_detail20[l_cnt].deca013a
   FOREACH  l_sql_deca_cs7 INTO g_detail22[l_ac].deca009c,g_detail22[l_ac].deca009c_desc,g_detail22[l_ac].deca010c,g_detail22[l_ac].deca019c,
      g_detail22[l_ac].deca022c,g_detail22[l_ac].deca027c,g_detail22[l_ac].deca030c,g_detail22[l_ac].deca025c
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT imaal003 INTO g_detail22[l_ac].deca009c_desc FROM imaal_t
       WHERE imaalent = g_enterprise AND imaal001 = g_detail22[l_ac].deca009c
         AND imaal002 = g_dlang
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail22.deleteElement(g_detail22.getLength())
   
   let l_ac=li_ac
   
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail20.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   IF g_detail_cnt > 0 THEN
      LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
END FUNCTION

#查询条件
PRIVATE FUNCTION acrq500_construct_deca()
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   LET l_flag = NULL
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      
      INPUT l_flag from radiogroup
                      
         BEFORE INPUT
            #add-point:cs段before_construct
                                    
            #end add-point 
      END INPUT
       
 
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

##填充单身
PRIVATE FUNCTION acrq500_b_fill6(pi_idx)
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   DEFINE ls_chk          LIKE type_t.chr1
   DEFINE l_sql           STRING
   DEFINE l_cnt           LIKE type_t.num5
   
   CALL g_detail24.clear()
   CALL g_detail2.clear()
   
   LET li_ac = l_ac
   let l_cnt = pi_idx   
   
#   LET l_sql = " SELECT rtax001,'',sum(deca031),sum(deca033),sum(deca027),sum(deca025-deca027),sum(deca026),sum(deca028),sum(deca028)/sum(deca026),sum(deca030) ",
#               "   FROM deca_t",
#               "  WHERE decaent=? AND deca020 = ?  "  
#   LET l_sql = l_sql," GROUP BY deca016,'' ORDER BY deca016 "    
#   PREPARE l_sql_deca_pre81 FROM l_sql
#   DECLARE l_sql_deca_cs81 CURSOR FOR l_sql_deca_pre81
    
   
   LET l_sql = " SELECT to_char(deca002,'YYYYMM'),decasite,'',sum(deca027),sum(deca031),sum(deca030),sum(deca033),sum(deca025-deca027) ",
               "   FROM deca_t LEFT JOIN ooga_t ON ooga001=deca002 AND oogaent = decaent  ",
               "  WHERE decaent=? AND deca020 = ? AND deca016 IN (select rtax001 FROM rtax_t WHERE rtaxent=",g_enterprise," START WITH rtax001=? CONNECT BY NOCYCLE PRIOR rtax001=rtax003 ) " 
   LET l_sql = l_sql," GROUP BY to_char(deca002,'YYYYMM'),decasite,''  ORDER BY to_char(deca002,'YYYYMM'),decasite,''"    
   PREPARE l_sql_deca_pre91 FROM l_sql
   DECLARE l_sql_deca_cs91 CURSOR FOR l_sql_deca_pre91

   LET l_sql = " SELECT deca009,'',deca010,deca019,sum(deca022),sum(deca027),sum(deca030),sum(deca025-deca027) ",
               "   FROM deca_t ",
               "  WHERE decaent=? AND deca020 = ? AND deca016 IN (select rtax001 FROM rtax_t WHERE rtaxent=",g_enterprise," START WITH rtax001=? CONNECT BY NOCYCLE PRIOR rtax001=rtax003 )  "  
   LET l_sql = l_sql," GROUP BY deca009,'',deca010,deca019,''  ORDER BY deca009,'',deca010,deca019,'' "    
   PREPARE l_sql_deca_pre101 FROM l_sql
   DECLARE l_sql_deca_cs101 CURSOR FOR l_sql_deca_pre101
   
   IF cl_null(l_cnt) OR l_cnt=0 THEN
      LET l_cnt = 1
   END IF   
   LET l_ac = 1   
   OPEN l_sql_deca_cs91 USING g_enterprise,g_master.mmaf001,g_detail23[l_cnt].deca016d
   FOREACH  l_sql_deca_cs91 INTO g_detail24[l_ac].deca002e,g_detail24[l_ac].decasitee,g_detail24[l_ac].decasitee_desc,g_detail24[l_ac].deca027e,
      g_detail24[l_ac].deca031e,g_detail24[l_ac].deca030e,g_detail24[l_ac].deca033e,g_detail24[l_ac].deca025e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT ooefl003 INTO g_detail24[l_ac].decasitee_desc FROM ooefl_t
       WHERE ooefl001 = g_detail24[l_ac].decasitee AND ooefl002 = g_dlang
         AND ooeflent = g_enterprise
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail24.deleteElement(g_detail24.getLength())
   
   LET l_ac = 1   
   OPEN l_sql_deca_cs101 USING g_enterprise,g_master.mmaf001,g_detail23[l_cnt].deca016d
   FOREACH  l_sql_deca_cs101 INTO g_detail2[l_ac].deca009f,g_detail2[l_ac].deca009f_desc,g_detail2[l_ac].deca010f,g_detail2[l_ac].deca019f,
      g_detail2[l_ac].deca022f,g_detail2[l_ac].decf027f,g_detail2[l_ac].deca030f,g_detail2[l_ac].deca025f
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT imaal003 INTO g_detail2[l_ac].deca009f_desc FROM imaal_t
       WHERE imaalent = g_enterprise AND imaal001 = g_detail2[l_ac].deca009f
         AND imaal002 = g_dlang
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail2.deleteElement(g_detail2.getLength())
   
   let l_ac=li_ac
   
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail23.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   IF g_detail_cnt > 0 THEN
      LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
END FUNCTION

#填充单身
PRIVATE FUNCTION acrq500_b_fill7(pi_idx)
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   DEFINE ls_chk          LIKE type_t.chr1
   DEFINE l_sql           STRING
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_count         LIKE type_t.num20_6
   
   CALL g_detail6.clear()
   
   LET li_ac = l_ac
   LET l_cnt = pi_idx         
   SELECT count(*) into l_count
     FROM decc_t 
    WHERE deccent = g_enterprise 
      AND decc001= g_master.mmaf001
   LET l_sql = " SELECT ooga004,'',sum(decc010),sum(decc016),count(*),0 ",
               "   FROM ooga_t LEFT JOIN decc_t ON ooga001=decc002 AND oogaent = decaent ",
               "  WHERE deccent=? AND decc001=? AND ",l_wc
   LET l_sql = l_sql," GROUP BY ooga004,''  ORDER BY ooga004,'' " 
   PREPARE l_sql_deca_pre1411 FROM l_sql
   DECLARE l_sql_deca_cs1411 CURSOR FOR l_sql_deca_pre1411
    
   
   LET l_sql = " SELECT ooga005,'',sum(decc010),sum(decc016),count(*),0 ",
               "   FROM ooga_t LEFT JOIN decc_t ON ooga001=decc002 AND oogaent = decaent ",
               "  WHERE deccent=? AND decc001=? AND ",l_wc
   LET l_sql = l_sql," GROUP BY ooga005,''  ORDER BY ooga005,'' " 
   PREPARE l_sql_deca_pre1421 FROM l_sql
   DECLARE l_sql_deca_cs1421 CURSOR FOR l_sql_deca_pre1421
   
   
   LET l_sql = " SELECT ooga006,'',sum(decc010),sum(decc016),count(*),0 ",
               "   FROM ooga_t LEFT JOIN decc_t ON ooga001=decc002 AND oogaent = decaent ",
               "  WHERE deccent=? AND decc001=? AND ",l_wc
   LET l_sql = l_sql," GROUP BY ooga006,''  ORDER BY ooga006,'' " 
   PREPARE l_sql_deca_pre1431 FROM l_sql
   DECLARE l_sql_deca_cs1431 CURSOR FOR l_sql_deca_pre1431
   
   
   LET l_sql = " SELECT ooga007,'',sum(decc010),sum(decc016),count(*),0 ",
               "   FROM ooga_t LEFT JOIN decc_t ON ooga001=decc002 AND oogaent = decaent ",
               "  WHERE deccent=? AND decc001=? AND ",l_wc
   LET l_sql = l_sql," GROUP BY ooga007,''  ORDER BY ooga007,'' " 
   PREPARE l_sql_deca_pre1441 FROM l_sql
   DECLARE l_sql_deca_cs1441 CURSOR FOR l_sql_deca_pre1441
   
   
   LET l_sql = " SELECT ooga008,'',sum(decc010),sum(decc016),count(*),0 ",
               "   FROM ooga_t LEFT JOIN decc_t ON ooga001=decc002 AND oogaent = decaent ",
               "  WHERE deccent=? AND decc001=? AND ",l_wc
   LET l_sql = l_sql," GROUP BY ooga008,''  ORDER BY ooga008,'' " 
   PREPARE l_sql_deca_pre1451 FROM l_sql
   DECLARE l_sql_deca_cs1451 CURSOR FOR l_sql_deca_pre1451
   
   LET l_ac = 1 
   if l_cnt = 1 then   
   OPEN l_sql_deca_cs141 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs141 INTO g_detail6[l_ac].class,g_detail6[l_ac].class_desc,g_detail6[l_ac].moneyd,g_detail6[l_ac].numberd,g_detail6[l_ac].countd,g_detail6[l_ac].rated
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT oocql004 INTO g_detail6[l_ac].class_desc FROM oocql_t
       WHERE oocqlent = g_enterprise AND oocql001 = '7' AND oocql002 = g_detail6[l_ac].class 
         AND oocql003 = g_dlang
      let g_detail6[l_ac].rated = g_detail6[l_ac].countd/l_count
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail6.deleteElement(g_detail6.getLength())
   end if
   if l_cnt = 2 then   
   OPEN l_sql_deca_cs142 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs142 INTO g_detail6[l_ac].class,g_detail6[l_ac].class_desc,g_detail6[l_ac].moneyd,g_detail6[l_ac].numberd,g_detail6[l_ac].countd,g_detail6[l_ac].rated
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT oocql004 INTO g_detail6[l_ac].class_desc FROM oocql_t
       WHERE oocqlent = g_enterprise AND oocql001 = '8' AND oocql002 = g_detail6[l_ac].class 
         AND oocql003 = g_dlang
      let g_detail6[l_ac].rated = g_detail6[l_ac].countd/l_count         
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail6.deleteElement(g_detail6.getLength())
   end if
   if l_cnt = 3 then   
   OPEN l_sql_deca_cs143 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs143 INTO g_detail6[l_ac].class,g_detail6[l_ac].class_desc,g_detail6[l_ac].moneyd,g_detail6[l_ac].numberd,g_detail6[l_ac].countd,g_detail6[l_ac].rated
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT oocql004 INTO g_detail6[l_ac].class_desc FROM oocql_t
       WHERE oocqlent = g_enterprise AND oocql001 = '9' AND oocql002 = g_detail6[l_ac].class 
         AND oocql003 = g_dlang
      let g_detail6[l_ac].rated = g_detail6[l_ac].countd/l_count         
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail6.deleteElement(g_detail6.getLength())
   end if
   if l_cnt = 4 then   
   OPEN l_sql_deca_cs144 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs144 INTO g_detail6[l_ac].class,g_detail6[l_ac].class_desc,g_detail6[l_ac].moneyd,g_detail6[l_ac].numberd,g_detail6[l_ac].countd,g_detail6[l_ac].rated
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT oocql004 INTO g_detail6[l_ac].class_desc FROM oocql_t
       WHERE oocqlent = g_enterprise AND oocql001 = '10' AND oocql002 = g_detail6[l_ac].class 
         AND oocql003 = g_dlang
      let g_detail6[l_ac].rated = g_detail6[l_ac].countd/l_count         
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail6.deleteElement(g_detail6.getLength())
   end if
   if l_cnt = 5 then   
   OPEN l_sql_deca_cs145 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs145 INTO g_detail6[l_ac].class,g_detail6[l_ac].class_desc,g_detail6[l_ac].moneyd,g_detail6[l_ac].numberd,g_detail6[l_ac].countd,g_detail6[l_ac].rated
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT oocql004 INTO g_detail6[l_ac].class_desc FROM oocql_t
       WHERE oocqlent = g_enterprise AND oocql001 = '11' AND oocql002 = g_detail6[l_ac].class 
         AND oocql003 = g_dlang
      let g_detail6[l_ac].rated = g_detail6[l_ac].countd/l_count         
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail6.deleteElement(g_detail6.getLength())
   end if
   let l_ac = li_ac
END FUNCTION

##建立临时表
PRIVATE FUNCTION acrq500_create_tmp()
         DROP TABLE acrq500_tmp
         CREATE TEMP TABLE acrq500_tmp(  
            mmaf001    VARCHAR(30),       #会员编号
            decc010    DECIMAL(20,6),       #消费金额
            rank       INTEGER);     
END FUNCTION

##fill 品类
PRIVATE FUNCTION acrq500_b_fill8()
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   DEFINE ls_chk          LIKE type_t.chr1
   DEFINE l_sql           STRING
   DEFINE l_cnt           LIKE type_t.num5
   
   CALL g_detail23.clear()
   CALL g_detail24.clear()
   CALL g_detail2.clear()
   
   LET li_ac = l_ac
   
   IF NOT cl_null(l_flag) AND l_flag<>5 THEN
#      IF NOT cl_null(l_flag) AND l_flag<>5 THEN
#         LET l_flag=l_flag+1
#      END IF
      LET l_sql = " SELECT rtaw001,'',sum(deca031),sum(deca033),sum(deca027),sum(deca025-deca027),sum(deca026),sum(deca028),sum(deca028)/sum(deca026),sum(deca030) ",
               "   FROM deca_t,rtaw_t ",
               "  WHERE decaent=? AND deca020 = ? ",
               "    AND rtawent = decaent AND rtaw003= '",l_flag,"'",
               "    AND rtaw002 = deca016 ",
               " GROUP BY rtaw001,'' "  
      LET l_sql = l_sql," ORDER BY rtaw001 " 
   ELSE
      LET l_sql = " SELECT deca016,'',sum(deca031),sum(deca033),sum(deca027),sum(deca025-deca027),sum(deca026),sum(deca028),sum(deca028)/sum(deca026),sum(deca030) ",
               "   FROM deca_t ",
               "  WHERE decaent=? AND deca020 = ? GROUP BY deca016,'' "  
      LET l_sql = l_sql," ORDER BY deca016 " 
   END IF   
   PREPARE l_sql_deca_pre82 FROM l_sql
   DECLARE l_sql_deca_cs82 CURSOR FOR l_sql_deca_pre82
    
   IF NOT cl_null(l_flag) AND l_flag<>5 THEN
      LET l_sql = " SELECT to_char(deca002,'YYYYMM'),decasite,'',sum(deca027),sum(deca031),sum(deca030),sum(deca033),sum(deca025-deca027) ",
                  "   FROM rtaw_t,deca_t LEFT JOIN ooga_t ON ooga001=deca002 AND oogaent = decaent  ",
                  "  WHERE decaent=? AND deca020 = ? AND deca016 = rtaw002 AND rtaw001 = ? AND rtawent = decaent  AND ",l_wc 
      LET l_sql = l_sql," GROUP BY to_char(deca002,'YYYYMM'),decasite,'' ORDER BY to_char(deca002,'YYYYMM'),decasite,'' "    
   ELSE
      LET l_sql = " SELECT to_char(deca002,'YYYYMM'),decasite,'',sum(deca027),sum(deca031),sum(deca030),sum(deca033),sum(deca025-deca027) ",
                  "   FROM deca_t LEFT JOIN ooga_t ON ooga001=deca002 AND oogaent = decaent  ",
                  "  WHERE decaent=? AND deca020 = ? AND deca016 = ? AND ",l_wc 
      LET l_sql = l_sql," GROUP BY to_char(deca002,'YYYYMM'),decasite,'' ORDER BY to_char(deca002,'YYYYMM'),decasite,'' "    
   END IF 
   PREPARE l_sql_deca_pre92 FROM l_sql
   DECLARE l_sql_deca_cs92 CURSOR FOR l_sql_deca_pre92

   IF NOT cl_null(l_flag) AND l_flag<>5 THEN
      LET l_sql = " SELECT deca009,'',deca010,deca019,'',sum(deca022),sum(deca027),sum(deca030),sum(deca025-deca027) ",
                  "   FROM deca_t,rtaw_t ",
                  "  WHERE decaent=? AND deca020 = ?  AND rtaw001 = ?  AND deca016 = rtaw002 AND rtawent = decaent  "  
      LET l_sql = l_sql," GROUP BY deca009,'',deca010,deca019,''  ORDER BY deca009,'',deca010,deca019,'' "  
   ELSE
      LET l_sql = " SELECT deca009,'',deca010,deca019,'',sum(deca022),sum(deca027),sum(deca030),sum(deca025-deca027) ",
                  "   FROM deca_t ",
                  "  WHERE decaent=? AND deca020 = ? AND deca016 = ?  "  
      LET l_sql = l_sql," GROUP BY deca009,'',deca010,deca019,''  ORDER BY deca009,'',deca010,deca019,'' "  
   END IF 
   PREPARE l_sql_deca_pre102 FROM l_sql
   DECLARE l_sql_deca_cs102 CURSOR FOR l_sql_deca_pre102
   
   LET l_ac = 1
   OPEN l_sql_deca_cs82 USING g_enterprise,g_master.mmaf001
   FOREACH  l_sql_deca_cs82 INTO g_detail23[l_ac].deca016d,g_detail23[l_ac].deca016d_desc,g_detail23[l_ac].deca031d,g_detail23[l_ac].deca033d,g_detail23[l_ac].deca027d,
      g_detail23[l_ac].deca025d,g_detail23[l_ac].deca026d,g_detail23[l_ac].deca028d,g_detail23[l_ac].decacount,g_detail23[l_ac].deca030d    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT rtaxl003 INTO g_detail23[l_ac].deca016d_desc FROM rtaxl_t
       WHERE rtaxlent = g_enterprise AND rtaxl001 = g_detail23[l_ac].deca016d
         AND rtaxl002 = g_dlang       
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail23.deleteElement(g_detail23.getLength())
   LET l_cnt=g_cnt
   IF g_detail23.getLength()<g_cnt  THEN
      LET l_cnt = g_detail23.getLength()
   END IF
   IF cl_null(l_cnt) OR l_cnt=0 THEN
      LET l_cnt = 1
   END IF   
   LET l_ac = 1   
   OPEN l_sql_deca_cs92 USING g_enterprise,g_master.mmaf001,g_detail23[l_cnt].deca016d
   FOREACH  l_sql_deca_cs92 INTO g_detail24[l_ac].deca002e,g_detail24[l_ac].decasitee,g_detail24[l_ac].decasitee_desc,g_detail24[l_ac].deca027e,
      g_detail24[l_ac].deca031e,g_detail24[l_ac].deca030e,g_detail24[l_ac].deca033e,g_detail24[l_ac].deca025e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT ooefl003 INTO g_detail24[l_ac].decasitee_desc FROM ooefl_t
       WHERE ooefl001 = g_detail24[l_ac].decasitee AND ooefl002 = g_dlang
         AND ooeflent = g_enterprise
               
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail24.deleteElement(g_detail24.getLength())
   
   LET l_ac = 1   
   OPEN l_sql_deca_cs102 USING g_enterprise,g_master.mmaf001,g_detail23[l_cnt].deca016d
   FOREACH  l_sql_deca_cs102 INTO g_detail2[l_ac].deca009f,g_detail2[l_ac].deca009f_desc,g_detail2[l_ac].deca010f,g_detail2[l_ac].deca019f,g_detail2[l_ac].deca019f_desc,
      g_detail2[l_ac].deca022f,g_detail2[l_ac].decf027f,g_detail2[l_ac].deca030f,g_detail2[l_ac].deca025f
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      SELECT imaal003 INTO g_detail2[l_ac].deca009f_desc FROM imaal_t
       WHERE imaalent = g_enterprise AND imaal001 = g_detail2[l_ac].deca009f
         AND imaal002 = g_dlang
      SELECT oocal003 INTO g_detail2[l_ac].deca019f_desc FROM oocal_t
       WHERE oocalent = g_enterprise AND oocal001 = g_detail2[l_ac].deca019f
         AND oocal002 = g_dlang       
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail2.deleteElement(g_detail2.getLength())
   LET l_ac = li_ac
END FUNCTION

 
{</section>}
 
