#該程式未解開Section, 採用最新樣板產出!
{<section id="asfq005.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-05-18 01:43:34), PR版次:0005(2017-02-08 13:47:08)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000079
#+ Filename...: asfq005
#+ Description: 工單用料模擬作業
#+ Creator....: 04543(2014-08-28 10:10:05)
#+ Modifier...: 00593 -SD/PR- 04441
 
{</section>}
 
{<section id="asfq005.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160503-00030#7   16/05/19  By Sarah   效能改善
#170208-00014#1   17/02/08  By Whitney [滿足備料需求否]改由[預計結存量balances]判斷
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
   sfaa003 LIKE sfaa_t.sfaa003, 
   sfaadocno LIKE sfaa_t.sfaadocno, 
   sfaadocdt LIKE sfaa_t.sfaadocdt, 
   sfaa002 LIKE sfaa_t.sfaa002, 
   sfaa002_desc LIKE type_t.chr500, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   sfaa010_desc LIKE type_t.chr500, 
   sfaa010_desc1 LIKE type_t.chr500, 
   sfaa012 LIKE sfaa_t.sfaa012, 
   sfaa013 LIKE sfaa_t.sfaa013, 
   sfaa013_desc LIKE type_t.chr500, 
   sfaa019 LIKE sfaa_t.sfaa019, 
   sfaa020 LIKE sfaa_t.sfaa020, 
   sfaastus LIKE sfaa_t.sfaastus
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_ac2             LIKE type_t.num5
DEFINE g_click           DYNAMIC ARRAY OF type_g_sfaa_d

TYPE type_tm      RECORD
              notyet     LIKE type_t.chr1,   #包含未發料工單
              less       LIKE type_t.chr1    #僅顯示欠料項目
                  END RECORD
DEFINE tm  type_tm


 TYPE type_g_sfba_d RECORD
       docno         LIKE sfba_t.sfbadocno,
       seq           LIKE sfba_t.sfbaseq,
       seq1          LIKE sfba_t.sfbaseq1,
       sfba006       LIKE sfba_t.sfba006,
       sfba006_desc  LIKE type_t.chr500,
       sfba006_desc1 LIKE type_t.chr500,
       sfba021       LIKE sfba_t.sfba021,
       sfba021_desc  LIKE type_t.chr500,
       sfba014       LIKE sfba_t.sfba014,
       sfba014_desc  LIKE type_t.chr500,       
       sfba013       LIKE sfba_t.sfba013,
       sfba016       LIKE sfba_t.sfba016,
       notoffer      LIKE type_t.num20_6,       
       sfba019       LIKE sfba_t.sfba019,
       sfba019_desc  LIKE type_t.chr500,
       sfba020       LIKE sfba_t.sfba020,
       sfba020_desc  LIKE type_t.chr500,
       inag008       LIKE inag_t.inag008,       
       prepare       LIKE type_t.num20_6,
       inan010       LIKE inan_t.inan010,
       canuse        LIKE type_t.num20_6,
       expect        LIKE type_t.num20_6,
       need          LIKE type_t.num20_6,
       road          LIKE type_t.num20_6,
       make          LIKE type_t.num20_6,
       check         LIKE type_t.num20_6,
       buy           LIKE type_t.num20_6,   #請購量150116
       byorder       LIKE type_t.num20_6,   #受訂量150116
       preuse        LIKE type_t.num20_6,   #預計可用量
       balances      LIKE type_t.num20_6,   #預計結存量150116
       complete      LIKE type_t.chr10

          END RECORD
 
DEFINE g_sfba_d  DYNAMIC ARRAY OF type_g_sfba_d
DEFINE g_sfba2_d DYNAMIC ARRAY OF type_g_sfba_d
DEFINE g_sql1               STRING                        #組 sql 用  #160503-00030#7 add
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
 
{<section id="asfq005.main" >}
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
   DECLARE asfq005_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE asfq005_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
#160503-00030#7-s
   #若報廢量=0，備料量 = 應發量 - 已發量 - 委外代買量
   #若報廢量>0，備料量 = 應發量 - 已發量 - 委外代買量 + 報廢量 - 超領量
   LET g_sql = "SELECT sfba014,",
               "    SUM(CASE",
               "           WHEN (COALESCE(sfba017,0) = 0) OR ((COALESCE(sfba017,0) - COALESCE(sfba025,0)) < 0) THEN",
               "              (COALESCE(sfba013,0) - COALESCE(sfba016,0) - COALESCE(sfba015,0))",
               "           ELSE",
               "              (COALESCE(sfba013,0) - COALESCE(sfba016,0) - COALESCE(sfba015,0) + COALESCE(sfba017,0) - COALESCE(sfba025,0))",
               "        END)",
               "  FROM sfaa_t,sfba_t",
               " WHERE sfaaent = sfbaent AND sfaaent = ?",
               "   AND sfaasite = sfbasite AND sfaasite = ?",
               "   AND sfaadocno = sfbadocno",
               "   AND sfaastus NOT IN ('X','C','M') ",
               "   AND COALESCE(sfba013,0) - COALESCE(sfba016,0) - COALESCE(sfba015,0) <> 0",
               "   AND sfaa003 <> '4'",
               "   AND sfba006 = ?",
               "   AND COALESCE(sfba021,' ') = ?"
   LET g_sql1 = g_sql," GROUP BY sfba014"
   LET g_sql1 = cl_sql_add_mask(g_sql1)              #遮蔽特定資料
   PREPARE asfq005_expect_pre FROM g_sql1
   DECLARE asfq005_expect_cs CURSOR FOR asfq005_expect_pre
   
   LET g_sql1 = g_sql,"   AND sfba019 =?",
                      " GROUP BY sfba014"
   LET g_sql1 = cl_sql_add_mask(g_sql1)              #遮蔽特定資料
   PREPARE asfq005_expect_pre1 FROM g_sql1
   DECLARE asfq005_expect_cs1 CURSOR FOR asfq005_expect_pre1
   
   LET g_sql1 = g_sql,"   AND sfba019 =?",
                      "   AND sfba020 =?",
                      " GROUP BY sfba014"
   LET g_sql1 = cl_sql_add_mask(g_sql1)              #遮蔽特定資料
   PREPARE asfq005_expect_pre2 FROM g_sql1
   DECLARE asfq005_expect_cs2 CURSOR FOR asfq005_expect_pre2
   
   #受訂量 = 訂單量 - 已出貨量
   LET g_sql = "SELECT SUM(COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd016,0)+COALESCE(xmdd034,0)),xmdd004",
               "  FROM xmdd_t,xmda_t,xmdc_t ",
               " WHERE xmdaent = xmddent ",
               "   AND xmdaent = xmdcent ",
               "   AND xmdaent = ?",
               "   AND xmdasite = xmddsite ",
               "   AND xmdasite = xmdcsite ",
               "   AND xmdasite = ?",
               "   AND xmdadocno = xmdddocno ",
               "   AND xmdadocno = xmdcdocno ",
               "   AND xmddseq = xmdcseq ",
               "   AND xmdc045 NOT IN ('2','3','4') ",
               "   AND xmdastus = 'Y' ",
               "   AND (COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd016,0)+COALESCE(xmdd034,0)) <> 0",
               "   AND xmdd001 = ?",
               "   AND COALESCE(xmdd002,' ') = COALESCE(?,' ')",
               " GROUP BY xmdd004"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asfq005_byorder_pre FROM g_sql
   DECLARE asfq005_byorder_cur CURSOR FOR asfq005_byorder_pre
   
   LET g_sql = "SELECT inag007,SUM(COALESCE(inag008,0))",
               "  FROM inag_t",
               " WHERE inagent = ?",
               "   AND inagsite = ?",
               "   AND inag001 = ?",
               "   AND inag002 = ?",
               "   AND inag010 = 'Y'"   
   LET g_sql1 = g_sql," GROUP BY inag007"
   LET g_sql1 = cl_sql_add_mask(g_sql1)              #遮蔽特定資料
   PREPARE asfq005_inag008_pre FROM g_sql1
   DECLARE asfq005_inag008_cs CURSOR FOR asfq005_inag008_pre
   
   LET g_sql1 = g_sql,"   AND inag004 =?",
                      " GROUP BY inag007"
   LET g_sql1 = cl_sql_add_mask(g_sql1)              #遮蔽特定資料
   PREPARE asfq005_inag008_pre1 FROM g_sql1
   DECLARE asfq005_inag008_cs1 CURSOR FOR asfq005_inag008_pre1
   
   LET g_sql1 = g_sql,"   AND inag004 =?",
                      "   AND inag005 =?",
                      " GROUP BY inag007"
   LET g_sql1 = cl_sql_add_mask(g_sql1)              #遮蔽特定資料
   PREPARE asfq005_inag008_pre2 FROM g_sql1
   DECLARE asfq005_inag008_cs2 CURSOR FOR asfq005_inag008_pre2   
      

   #採購單位、分批採購數量-已收貨量+驗退量+倉退換貨量
   LET g_sql = "SELECT pmdo004,",
               "       SUM(COALESCE(pmdo006,0)) - SUM(COALESCE(pmdo015,0)) + SUM(COALESCE(pmdo016,0)) + SUM(COALESCE(pmdo017,0))",
               "  FROM pmdl_t,pmdn_t,pmdo_t",
               " WHERE pmdlent = pmdnent AND pmdnent = pmdoent AND pmdoent = ?",
               "   AND pmdldocno = pmdndocno AND pmdndocno = pmdodocno",
               "   AND pmdnseq = pmdoseq",
               "   AND pmdlstus = 'Y'",
               "   AND pmdnunit = '?",  #收貨據點
               "   AND COALESCE(pmdo006,0) + COALESCE(pmdo016,0) + COALESCE(pmdo017,0) > COALESCE(pmdo015,0)",    #尚有未收貨的數量
               "   AND pmdo001 = ?",
               "   AND COALESCE(pmdo002,' ') = ?"
   LET g_sql1 = g_sql," GROUP BY pmdo004"
   LET g_sql1 = cl_sql_add_mask(g_sql1)              #遮蔽特定資料
   PREPARE asfq005_road_pre FROM g_sql1
   DECLARE asfq005_road_cs CURSOR FOR asfq005_road_pre
   
   LET g_sql1 = g_sql,"   AND pmdn028 =?",
                      " GROUP BY pmdo004"
   LET g_sql1 = cl_sql_add_mask(g_sql1)              #遮蔽特定資料
   PREPARE asfq005_road_pre1 FROM g_sql1
   DECLARE asfq005_road_cs1 CURSOR FOR asfq005_road_pre1
   
   LET g_sql1 = g_sql,"   AND pmdn028 =?",
                      "   AND pmdn029 =?",
                      " GROUP BY pmdo004"
   LET g_sql1 = cl_sql_add_mask(g_sql1)              #遮蔽特定資料
   PREPARE asfq005_road_pre2 FROM g_sql1
   DECLARE asfq005_road_cs2 CURSOR FOR asfq005_road_pre2


   #製造單位、預計產出量-實際出產數量
   LET g_sql = "SELECT sfac004,",
               "       SUM(COALESCE(sfac003,0)) - SUM(COALESCE(sfac005,0))",
               "  FROM sfaa_t,sfac_t",
               " WHERE sfaaent = sfacent AND sfacent = ?",
               "   AND sfaasite = sfacsite AND sfacsite = ?",
               "   AND sfaadocno = sfacdocno",
               "   AND sfaastus = 'F'",   #已發出
               "   AND sfac001 = ?",
               "   AND COALESCE(sfac006,' ') = ?",
               "   AND COALESCE(sfac003,0) > COALESCE(sfac005,0)",    #尚有在製造
               " GROUP BY sfac004"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asfq005_make_pre FROM g_sql
   DECLARE asfq005_make_cs CURSOR FOR asfq005_make_pre

   #收貨單位、收貨數量-已入庫量
   LET g_sql = "SELECT pmdu009,",
               "       SUM(COALESCE(pmdu010,0)) - SUM(COALESCE(pmdu014,0))",
               "  FROM pmds_t,pmdu_t",
               " WHERE pmdsent = pmduent AND pmduent = ?",
               "   AND pmdssite = pmdusite AND pmdusite = ?",
               "   AND pmdsdocno = pmdudocno",               
               "   AND pmds000 = '1'",            #apmt520採購收貨單
               "   AND pmdu001 = ?",
               "   AND COALESCE(pmdu002,' ') = ?"
      LET g_sql1 = g_sql," GROUP BY pmdu009"
   LET g_sql1 = cl_sql_add_mask(g_sql1)              #遮蔽特定資料
   PREPARE asfq005_check_pre FROM g_sql1
   DECLARE asfq005_check_cs CURSOR FOR asfq005_check_pre
   
   LET g_sql1 = g_sql,"   AND pmdu006 =?",
                      " GROUP BY pmdu009"
   LET g_sql1 = cl_sql_add_mask(g_sql1)              #遮蔽特定資料
   PREPARE asfq005_check_pre1 FROM g_sql1
   DECLARE asfq005_check_cs1 CURSOR FOR asfq005_check_pre1
   
   LET g_sql1 = g_sql,"   AND pmdu006 =?",
                      "   AND pmdu007 =?",
                      " GROUP BY pmdu009"
   LET g_sql1 = cl_sql_add_mask(g_sql1)              #遮蔽特定資料
   PREPARE asfq005_check_pre2 FROM g_sql1
   DECLARE asfq005_check_cs2 CURSOR FOR asfq005_check_pre2
   
   #請購量 = 請購需求量 - 已轉採購量
   LET g_sql = " SELECT SUM(COALESCE(pmdb006,0)-COALESCE(pmdb049,0)),pmdb007",
               "   FROM pmda_t,pmdb_t",
               "  WHERE pmdaent = pmdbent AND pmdaent = ?",
               "    AND pmdasite = ?",
               "    AND pmdadocno = pmdbdocno ",
               "    AND COALESCE(pmdb006,0) <> COALESCE(pmdb049,0) ",
               "    AND pmdb032 NOT IN ('2','3','4') ",
               "    AND pmdastus <> 'X' AND pmdastus <> 'C'",
               "    AND pmdb004 = ?",
               "    AND COALESCE(pmdb005,' ') = COALESCE(?,' ')",
               "  GROUP BY pmdb007"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asfq005_buy_pre FROM g_sql
   DECLARE asfq005_buy_cur CURSOR FOR asfq005_buy_pre
#160503-00030#7-e
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asfq005_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfq005 WITH FORM cl_ap_formpath("asf",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asfq005_init()   
 
      #進入選單 Menu (="N")
      CALL asfq005_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asfq005
      
   END IF 
   
   CLOSE asfq005_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asfq005.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION asfq005_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_sql       STRING   #160503-00030#7 add
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('b_sfaastus','13','C,D,F,M,N,R,W,Y,X')
 
      CALL cl_set_combo_scc('b_sfaa003','4007') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('b_sfaastus','13','F,Y')  #僅抓取"已確認"及"已發出"之工單
   CALL cl_set_combo_scc('sfaa003','4007')
   
   LET tm.notyet = 'N'
   LET tm.less = 'N'
   
   CALL asfq005_create_tmep()
   #end add-point
 
   CALL asfq005_default_search()
END FUNCTION
 
{</section>}
 
{<section id="asfq005.default_search" >}
PRIVATE FUNCTION asfq005_default_search()
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
 
{<section id="asfq005.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfq005_ui_dialog() 
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
 
   
   CALL asfq005_b_fill()
  
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
 
         CALL asfq005_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
 
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON sfaa003,sfaadocno,sfaadocdt,sfaa002,
                                   sfaa010,sfaa012,sfaa019,sfaa020,sfba006
                                   
            ON ACTION controlp INFIELD sfaadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.where = "sfaastus IN ('Y','F')"      #僅抓取"已確認"及"已發出"之工單
               
               CALL q_sfaadocno_1()
               DISPLAY g_qryparam.return1 TO sfaadocno
               NEXT FIELD sfaadocno
         
            ON ACTION controlp INFIELD sfaa002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO sfaa002
               NEXT FIELD sfaa002
         
            ON ACTION controlp INFIELD sfaa010
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001_9()
               DISPLAY g_qryparam.return1 TO sfaa010
               NEXT FIELD sfaa010

            ON ACTION controlp INFIELD sfba006
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001_10()
               DISPLAY g_qryparam.return1 TO sfba006
               NEXT FIELD sfba006

         END CONSTRUCT
         
         INPUT BY NAME tm.notyet,tm.less ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT

            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF
               
         END INPUT         
         
         #end add-point
     
         DISPLAY ARRAY g_sfaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL asfq005_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL asfq005_b_fill2()
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
         DISPLAY ARRAY g_sfba_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
            
            BEFORE ROW
 
         END DISPLAY
         
         DISPLAY ARRAY g_sfba2_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
            
            BEFORE ROW
 
         END DISPLAY         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL asfq005_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = g_detail_idx
            DISPLAY g_detail_idx TO FORMONLY.h_index
            DISPLAY g_sfaa_d.getLength() TO FORMONLY.h_count
            LET g_master_idx = l_ac
            CALL asfq005_b_fill2()
            #end add-point
            NEXT FIELD sfaa003
 
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
            CALL asfq005_b_fill()
 
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
               LET g_export_node[2] = base.typeInfo.create(g_sfba2_d)
               LET g_export_id[2]   = "s_detail3"
               LET g_export_node[2] = base.typeInfo.create(g_sfba_d)
               LET g_export_id[2]   = "s_detail2"
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL asfq005_b_fill()
 
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
            CALL asfq005_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL asfq005_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL asfq005_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL asfq005_b_fill()
 
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
            CALL asfq005_filter()
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
         ON ACTION simulate
            LET g_action_choice="simulate"
            IF cl_auth_chk_act("simulate") THEN
               
               #add-point:ON ACTION simulate name="menu.simulate"
               CALL asfq005_simulate()
               CALL asfq005_b_fill2()   #160503-00030#7 add                
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
         
         ON ACTION modify_detail
            FOR li_idx = 1 TO g_sfaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  IF g_sfaa_d[li_idx].sel = 'Y' THEN
                     LET g_sfaa_d[li_idx].sel = 'N'
                  ELSE
                     LET g_sfaa_d[li_idx].sel = 'Y'
                  END IF
               END IF
            END FOR
   
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="asfq005.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asfq005_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
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
 
   CALL g_sfaa_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   DELETE FROM asfq005_temp   #清空temp_table
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',sfaa003,sfaadocno,sfaadocdt,sfaa002,'',sfaa010,'','',sfaa012, 
       sfaa013,'',sfaa019,sfaa020,sfaastus  ,DENSE_RANK() OVER( ORDER BY sfaa_t.sfaadocno) AS RANK FROM sfaa_t", 
 
 
 
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
#160503-00030#7-s
   LET ls_sql_rank = "SELECT  UNIQUE '',sfaa003,sfaadocno,sfaadocdt,sfaa002,",
                     "        '',sfaa010,'','',sfaa012,sfaa013,'',",
                     "        (SELECT ooag011 FROM ooag_t WHERE ooagent=sfaaent AND ooag001=sfaa002) sfaa002_desc,",
                     "        sfaa010,",
                     "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='",g_dlang,"') sfaa010_desc,",
                     "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='",g_dlang,"') sfaa010_desc1,",
                     "        sfaa012,sfaa013,", 
                     "        (SELECT oocal003 FROM oocal_t WHERE oocalent=sfaaent AND oocal001=sfaa013 AND oocal002='"||g_dlang,"') sfaa013_desc,",
                     "        sfaa019,sfaa020,sfaastus  ,DENSE_RANK() OVER( ORDER BY sfaa_t.sfaadocno) AS RANK ",
                     "  FROM sfaa_t LEFT OUTER JOIN sfba_t ON sfbaent = sfaaent AND sfaadocno = sfbadocno",
                     " WHERE sfaaent= ? AND 1=1 AND ", ls_wc,
                     "   AND sfaasite = '",g_site,"'",
                     "   AND sfaastus IN ('Y','F')",      #僅抓取"已確認"及"已發出"之工單                     
                     "   AND (COALESCE(sfba013,0)-COALESCE(sfba015,0)-COALESCE(sfba016,0)) > 0"  #只抓有欠料的資料
   IF tm.notyet = 'N'  THEN      #不包含未發料工單 → 表示只抓已發出工單、已發料數量 > 0的資料
      LET ls_sql_rank = ls_sql_rank,
                        "   AND sfaastus = 'F'",
                        "   AND COALESCE(sfba016,0) > 0"
   END IF
   
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("sfaa_t"),
                     " ORDER BY sfaa_t.sfaadocno"
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre_1 FROM g_sql  #總筆數
   EXECUTE b_fill_cnt_pre_1 USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre_1
#160503-00030#7-e

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
 
   LET g_sql = "SELECT '',sfaa003,sfaadocno,sfaadocdt,sfaa002,'',sfaa010,'','',sfaa012,sfaa013,'',sfaa019, 
       sfaa020,sfaastus",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  UNIQUE 'Y',sfaa003,sfaadocno,sfaadocdt,sfaa002,",
#160503-00030#7-s
#               "        '',sfaa010,'','',sfaa012,sfaa013,'',",
               "        (SELECT ooag011 FROM ooag_t WHERE ooagent=sfaaent AND ooag001=sfaa002) sfaa002_desc,",
               "        sfaa010,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='",g_dlang,"') sfaa010_desc,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='",g_dlang,"') sfaa010_desc1,",
               "        sfaa012,sfaa013,", 
               "        (SELECT oocal003 FROM oocal_t WHERE oocalent=sfaaent AND oocal001=sfaa013 AND oocal002='"||g_dlang,"') sfaa013_desc,",
#160503-00030#7-e
               "        sfaa019,sfaa020,sfaastus",
               "  FROM sfaa_t LEFT OUTER JOIN sfba_t ON sfbaent = sfaaent AND sfaadocno = sfbadocno",
               " WHERE sfaaent= ? AND 1=1 AND ", ls_wc,
               "   AND sfaasite = '",g_site,"'",
               "   AND sfaastus IN ('Y','F')"      #僅抓取"已確認"及"已發出"之工單
#160503-00030#7-s
   #只抓有欠料的資料 sfaa013-sfaa015-sfaa016 > 0
   LET g_sql = g_sql,
               "   AND (COALESCE(sfba013,0)-COALESCE(sfba015,0)-COALESCE(sfba016,0)) > 0"
   IF tm.notyet = 'N'  THEN      #不包含未發料工單 → 表示只抓已發出工單、已發料數量 > 0的資料
      LET g_sql = g_sql,
                  "   AND sfaastus = 'F'",
                  "   AND COALESCE(sfba016,0) > 0"
   END IF            
#160503-00030#7-e
   LET g_sql = g_sql, cl_sql_add_filter("sfaa_t"),
                      " ORDER BY sfaa_t.sfaadocno"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asfq005_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asfq005_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_sfaa_d[l_ac].sel,g_sfaa_d[l_ac].sfaa003,g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfaadocdt, 
       g_sfaa_d[l_ac].sfaa002,g_sfaa_d[l_ac].sfaa002_desc,g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa010_desc, 
       g_sfaa_d[l_ac].sfaa010_desc1,g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa013,g_sfaa_d[l_ac].sfaa013_desc, 
       g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,g_sfaa_d[l_ac].sfaastus
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
#160503-00030#7-s
#      #工單單身全部無欠料排除
#      IF NOT asfq005_detail_chk('1',g_sfaa_d[l_ac].sfaadocno) THEN
#         CONTINUE FOREACH
#      END IF
#
#      IF tm.notyet = 'N'  THEN      #不包含未發料工單
#         IF g_sfaa_d[l_ac].sfaastus <> 'F' THEN
#            CONTINUE FOREACH
#         END IF
#
#         #工單單身全部未發料排除
#         IF NOT asfq005_detail_chk('2',g_sfaa_d[l_ac].sfaadocno) THEN
#            CONTINUE FOREACH
#         END IF
#      END IF
#160503-00030#7-e
      #end add-point
 
      CALL asfq005_detail_show("'1'")
 
      CALL asfq005_sfaa_t_mask()
 
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
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_sfaa_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE asfq005_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL asfq005_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL asfq005_detail_action_trans()
 
   LET l_ac = 1
   IF g_sfaa_d.getLength() > 0 THEN
      CALL asfq005_b_fill2()
   END IF
 
      CALL asfq005_filter_show('sfaa003','b_sfaa003')
   CALL asfq005_filter_show('sfaadocno','b_sfaadocno')
   CALL asfq005_filter_show('sfaadocdt','b_sfaadocdt')
   CALL asfq005_filter_show('sfaa002','b_sfaa002')
   CALL asfq005_filter_show('sfaa010','b_sfaa010')
   CALL asfq005_filter_show('sfaa012','b_sfaa012')
   CALL asfq005_filter_show('sfaa013','b_sfaa013')
   CALL asfq005_filter_show('sfaa019','b_sfaa019')
   CALL asfq005_filter_show('sfaa020','b_sfaa020')
   CALL asfq005_filter_show('sfaastus','b_sfaastus')
 
 
END FUNCTION
 
{</section>}
 
{<section id="asfq005.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asfq005_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_success       LIKE type_t.num5   
   DEFINE l_sfba019       LIKE type_t.chr30           #160503-00030#7 add
   DEFINE l_sfba020       LIKE type_t.chr30           #160503-00030#7 add
   DEFINE l_sfba014       LIKE sfba_t.sfba014         #160503-00030#7 add
   DEFINE l_num           LIKE type_t.num20_6         #160503-00030#7 add
   DEFINE l_sum_num       LIKE type_t.num20_6         #160503-00030#7 add   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   IF l_ac = 0 THEN LET l_ac = 1 END IF   #160503-00030#7
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   CALL g_sfba_d.clear()
   CALL g_sfba2_d.clear()
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   LET g_sql = "SELECT docno,seq,seq1,",
#160503-00030#7-s
#               "       sfba006,sfba021,sfba014,",
               "       sfba006,sfba006_desc,sfba006_desc1,sfba021,sfba021_desc,sfba014,sfba014_desc,",
#160503-00030#7-e
               "       sfba013,sfba016,notoffer,",
               "       sfba019,",
               "       sfba019_desc,",   #160503-00030#7
               "       sfba020,",
               "       sfba020_desc,",   #160503-00030#7
               "       inag008,prepare,",
               "       inan010,canuse,expect,need,road,",
               "       make,checknum,preuse,complete,",
               "       buy,byorder,balances",        #150116
               "  FROM asfq005_temp",
               " WHERE docno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asfq005_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR asfq005_pb2
 
   LET l_ac2 = 1

   OPEN b_fill_curs2 USING g_sfaa_d[l_ac].sfaadocno   
   FOREACH b_fill_curs2 INTO g_sfba_d[l_ac2].docno,g_sfba_d[l_ac2].seq,g_sfba_d[l_ac2].seq1,
                             g_sfba_d[l_ac2].sfba006,
                             g_sfba_d[l_ac2].sfba006_desc,g_sfba_d[l_ac2].sfba006_desc1,  #160503-00030#7 add
                             g_sfba_d[l_ac2].sfba021,
                             g_sfba_d[l_ac2].sfba021_desc,  #160503-00030#7 add
                             g_sfba_d[l_ac2].sfba014,
                             g_sfba_d[l_ac2].sfba014_desc,  #160503-00030#7 add
                             g_sfba_d[l_ac2].sfba013,g_sfba_d[l_ac2].sfba016,g_sfba_d[l_ac2].notoffer,
                             g_sfba_d[l_ac2].sfba019,
                             g_sfba_d[l_ac2].sfba019_desc,  #160503-00030#7 add
                             g_sfba_d[l_ac2].sfba020,
                             g_sfba_d[l_ac2].sfba020_desc,  #160503-00030#7 add
                             g_sfba_d[l_ac2].inag008,g_sfba_d[l_ac2].prepare,
                             g_sfba_d[l_ac2].inan010,g_sfba_d[l_ac2].canuse,g_sfba_d[l_ac2].expect,
                             g_sfba_d[l_ac2].need,g_sfba_d[l_ac2].road,
                             g_sfba_d[l_ac2].make,g_sfba_d[l_ac2].check,
                             g_sfba_d[l_ac2].preuse,g_sfba_d[l_ac2].complete,
                             g_sfba_d[l_ac2].buy,g_sfba_d[l_ac2].byorder,g_sfba_d[l_ac2].balances   #150116
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF

#160503-00030#7-s
#      #料號
#      CALL s_desc_get_item_desc(g_sfba_d[l_ac2].sfba006) RETURNING g_sfba_d[l_ac2].sfba006_desc,g_sfba_d[l_ac2].sfba006_desc1
#      #產品特徵
#      CALL s_feature_description(g_sfba_d[l_ac2].sfba006,g_sfba_d[l_ac2].sfba021) RETURNING l_success,g_sfba_d[l_ac2].sfba021_desc
#      #單位
#      CALL s_desc_get_unit_desc(g_sfba_d[l_ac2].sfba014) RETURNING g_sfba_d[l_ac2].sfba014_desc
#      #庫位
#      CALL s_desc_get_stock_desc(g_site,g_sfba_d[l_ac2].sfba019) RETURNING g_sfba_d[l_ac2].sfba019_desc
#      #儲位
#      CALL s_desc_get_locator_desc(g_site,g_sfba_d[l_ac2].sfba019,g_sfba_d[l_ac2].sfba020) RETURNING g_sfba_d[l_ac2].sfba020_desc
#160503-00030#7-e

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
      LET l_ac2 = l_ac2 + 1

   END FOREACH
 
   CALL g_sfba_d.deleteElement(g_sfba_d.getLength())

   LET g_sql = "SELECT '','','',",
#160503-00030#7-s
#               "       sfba006,sfba021,sfba014,",
               "       sfba006,sfba006_desc,sfba006_desc1,sfba021,sfba021_desc,sfba014,sfba014_desc,",
#160503-00030#7-e
               "       SUM(sfba013),SUM(sfba016),SUM(notoffer),",
               "       sfba019,",
               "       sfba019_desc,",   #160503-00030#7
               "       sfba020,",
               "       sfba020_desc,",   #160503-00030#7
               "       inag008,prepare,",
               "       inan010,canuse,'','',road,",
#170208-00014#1-s
#               "       make,checknum,'','',",
               "       make,checknum,'',complete,",
#170208-00014#1-e
               "       buy,byorder,balances",        #150116
               "  FROM asfq005_temp",
#160503-00030#7-s
#               " GROUP BY sfba006,sfba021,sfba014,sfba019,sfba020,",
               " GROUP BY sfba006,sfba006_desc,sfba006_desc1,sfba021,sfba021_desc,sfba014,sfba014_desc,sfba019,sfba019_desc,sfba020,sfba020_desc,",
#160503-00030#7-e
               "          inag008,prepare,",
               "          inan010,canuse,road,",
#170208-00014#1-s
#               "          make,checknum,",
               "          make,checknum,complete,",
#170208-00014#1-e
               "          buy,byorder,balances"

   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asfq005_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR asfq005_pb3
 
   LET l_ac2 = 1
   
   FOREACH b_fill_curs3 INTO g_sfba2_d[l_ac2].docno,g_sfba2_d[l_ac2].seq,g_sfba2_d[l_ac2].seq1,
                             g_sfba2_d[l_ac2].sfba006,
                             g_sfba2_d[l_ac2].sfba006_desc,g_sfba2_d[l_ac2].sfba006_desc1,  #160503-00030#7 add
                             g_sfba2_d[l_ac2].sfba021,
                             g_sfba2_d[l_ac2].sfba021_desc,  #160503-00030#7 add
                             g_sfba2_d[l_ac2].sfba014,
                             g_sfba2_d[l_ac2].sfba014_desc,  #160503-00030#7 add
                             g_sfba2_d[l_ac2].sfba013,g_sfba2_d[l_ac2].sfba016,g_sfba2_d[l_ac2].notoffer,
                             g_sfba2_d[l_ac2].sfba019,
                             g_sfba2_d[l_ac2].sfba019_desc,  #160503-00030#7 add
                             g_sfba2_d[l_ac2].sfba020,
                             g_sfba2_d[l_ac2].sfba020_desc,  #160503-00030#7 add                             
                             g_sfba2_d[l_ac2].inag008,g_sfba2_d[l_ac2].prepare,
                             g_sfba2_d[l_ac2].inan010,g_sfba2_d[l_ac2].canuse,g_sfba2_d[l_ac2].expect,g_sfba2_d[l_ac2].need,g_sfba2_d[l_ac2].road,
                             g_sfba2_d[l_ac2].make,g_sfba2_d[l_ac2].check,g_sfba2_d[l_ac2].preuse,g_sfba2_d[l_ac2].complete,
                             g_sfba2_d[l_ac2].buy,g_sfba2_d[l_ac2].byorder,g_sfba2_d[l_ac2].balances   #150116
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF

#160503-00030#7-s
#      #料號
#      CALL s_desc_get_item_desc(g_sfba2_d[l_ac2].sfba006) RETURNING g_sfba2_d[l_ac2].sfba006_desc,g_sfba2_d[l_ac2].sfba006_desc1
#      #產品特徵
#      CALL s_feature_description(g_sfba2_d[l_ac2].sfba006,g_sfba2_d[l_ac2].sfba021) RETURNING l_success,g_sfba2_d[l_ac2].sfba021_desc
#      #單位
#      CALL s_desc_get_unit_desc(g_sfba2_d[l_ac2].sfba014) RETURNING g_sfba2_d[l_ac2].sfba014_desc
#      #庫位
#      CALL s_desc_get_stock_desc(g_site,g_sfba2_d[l_ac2].sfba019) RETURNING g_sfba2_d[l_ac2].sfba019_desc   
#      #儲位
#      CALL s_desc_get_locator_desc(g_site,g_sfba2_d[l_ac2].sfba019,g_sfba2_d[l_ac2].sfba020) RETURNING g_sfba2_d[l_ac2].sfba020_desc
#160503-00030#7-e

      #工單預計備料量
#160503-00030#7-s
#      CALL asfq005_expect_count(g_sfba2_d[l_ac2].sfba006,g_sfba2_d[l_ac2].sfba021,g_sfba2_d[l_ac2].sfba014,g_sfba2_d[l_ac2].sfba019,g_sfba2_d[l_ac2].sfba020,'')
#           RETURNING g_sfba2_d[l_ac2].expect
      LET g_sfba2_d[l_ac2].expect = 0
      LET l_num = 0
      LET l_sum_num = 0
      IF cl_null(g_sfba2_d[l_ac2].sfba019) AND cl_null(g_sfba2_d[l_ac2].sfba020) THEN
         FOREACH asfq005_expect_cs USING g_enterprise,g_site,g_sfba2_d[l_ac2].sfba006,g_sfba2_d[l_ac2].sfba021
            INTO l_sfba014,g_sfba2_d[l_ac2].expect
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()             
               EXIT FOREACH
            END IF
         
            #換算成發料單位
            IF cl_null(l_sfba014) OR cl_null(g_sfba2_d[l_ac2].sfba014) THEN
               LET l_num = 0
            ELSE
               IF l_sfba014 <> g_sfba2_d[l_ac2].sfba014 THEN
                  CALL s_aooi250_convert_qty(g_sfba2_d[l_ac2].sfba006,l_sfba014,g_sfba2_d[l_ac2].sfba014,g_sfba2_d[l_ac2].expect) RETURNING l_success,l_num
                  IF NOT l_success THEN
                     LET l_num = 0
                  END IF
               ELSE
                  LET l_num = g_sfba2_d[l_ac2].expect
               END IF
            END IF
         
            LET l_sum_num = l_sum_num + l_num      
         END FOREACH
         LET g_sfba2_d[l_ac2].expect = l_sum_num
      END IF
      
      IF NOT cl_null(g_sfba2_d[l_ac2].sfba019) AND cl_null(g_sfba2_d[l_ac2].sfba020) THEN
         FOREACH asfq005_expect_cs1 USING g_enterprise,g_site,g_sfba2_d[l_ac2].sfba006,g_sfba2_d[l_ac2].sfba021,g_sfba2_d[l_ac2].sfba019
            INTO l_sfba014,g_sfba2_d[l_ac2].expect
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()             
               EXIT FOREACH
            END IF
         
            #換算成發料單位
            IF cl_null(l_sfba014) OR cl_null(g_sfba2_d[l_ac2].sfba014) THEN
               LET l_num = 0
            ELSE
               IF l_sfba014 <> g_sfba2_d[l_ac2].sfba014 THEN
                  CALL s_aooi250_convert_qty(g_sfba2_d[l_ac2].sfba006,l_sfba014,g_sfba2_d[l_ac2].sfba014,g_sfba2_d[l_ac2].expect) RETURNING l_success,l_num
                  IF NOT l_success THEN
                     LET l_num = 0
                  END IF
               ELSE
                  LET l_num = g_sfba2_d[l_ac2].expect
               END IF
            END IF
         
            LET l_sum_num = l_sum_num + l_num      
         END FOREACH
         LET g_sfba2_d[l_ac2].expect = l_sum_num
      END IF
      
      IF NOT cl_null(g_sfba2_d[l_ac2].sfba019) AND NOT cl_null(g_sfba2_d[l_ac2].sfba020) THEN  #有限定儲位
         FOREACH asfq005_expect_cs2 USING g_enterprise,g_site,g_sfba2_d[l_ac2].sfba006,g_sfba2_d[l_ac2].sfba021,g_sfba2_d[l_ac2].sfba019,g_sfba2_d[l_ac2].sfba020
            INTO l_sfba014,g_sfba2_d[l_ac2].expect
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()             
               EXIT FOREACH
            END IF
         
            #換算成發料單位
            IF cl_null(l_sfba014) OR cl_null(g_sfba2_d[l_ac2].sfba014) THEN
               LET l_num = 0
            ELSE
               IF l_sfba014 <> g_sfba2_d[l_ac2].sfba014 THEN
                  CALL s_aooi250_convert_qty(g_sfba2_d[l_ac2].sfba006,l_sfba014,g_sfba2_d[l_ac2].sfba014,g_sfba2_d[l_ac2].expect) RETURNING l_success,l_num
                  IF NOT l_success THEN
                     LET l_num = 0
                  END IF
               ELSE
                  LET l_num = g_sfba2_d[l_ac2].expect
               END IF
            END IF
         
            LET l_sum_num = l_sum_num + l_num      
         END FOREACH
         LET g_sfba2_d[l_ac2].expect = l_sum_num
      END IF
#160503-00030#7-e           
      #LET g_sfba2_d[l_ac2].expect = g_sfba2_d[l_ac2].expect - g_sfba2_d[l_ac2].notoffer  #減去當筆未發量

      #本次預計需求量
      LET g_sfba2_d[l_ac2].need = 0
      
      #預計可用量 = 庫存可用量 - 受訂量 - 工單預計備料量 + 請購量 + 在途量 + 在驗量 + 在製量  150116
      LET g_sfba2_d[l_ac2].preuse = g_sfba2_d[l_ac2].inag008 - g_sfba2_d[l_ac2].byorder - g_sfba2_d[l_ac2].expect + g_sfba2_d[l_ac2].buy + g_sfba2_d[l_ac2].road + g_sfba2_d[l_ac2].check + g_sfba2_d[l_ac2].make
     #LET g_sfba2_d[l_ac2].preuse = g_sfba2_d[l_ac2].canuse - g_sfba2_d[l_ac2].need + g_sfba2_d[l_ac2].road + g_sfba2_d[l_ac2].make + g_sfba2_d[l_ac2].check

      #1.是：可用餘量 - 本次預計需求量 >= 未發數量
      #2.否：可用餘量 + 在途 + 在製 + 在驗 < 未發
      #3.需人工判斷：其他

#170208-00014#1-s
#      #滿足備料需求否
#      CASE      
#         WHEN g_sfba2_d[l_ac2].canuse - g_sfba2_d[l_ac2].need >= g_sfba2_d[l_ac2].notoffer
#            LET g_sfba2_d[l_ac2].complete = '1' #是
#         OTHERWISE
#            LET g_sfba2_d[l_ac2].complete = '2' #否
##141216取消"需人工判斷"
##         WHEN g_sfba2_d[l_ac2].canuse + g_sfba2_d[l_ac2].road + g_sfba2_d[l_ac2].make + g_sfba2_d[l_ac2].check < g_sfba2_d[l_ac2].notoffer
##            LET g_sfba2_d[l_ac2].complete = '2' #否
##         OTHERWISE
##            LET g_sfba2_d[l_ac2].complete = '3' #需人工判斷
#      END CASE
#170208-00014#1-e


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
      LET l_ac2 = l_ac2 + 1

   END FOREACH
 
   CALL g_sfba2_d.deleteElement(g_sfba2_d.getLength())
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="asfq005.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asfq005_detail_show(ps_page)
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
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body.reference"
#160503-00030#7-s
#      CALL s_aooi200_get_slip_desc(g_sfaa_d[l_ac].sfaadocno) RETURNING g_sfaa_d[l_ac].sfaadocno_desc
#      DISPLAY BY NAME g_sfaa_d[l_ac].sfaadocno_desc
#
#      CALL s_desc_get_person_desc(g_sfaa_d[l_ac].sfaa002) RETURNING g_sfaa_d[l_ac].sfaa002_desc
#      DISPLAY BY NAME g_sfaa_d[l_ac].sfaa002_desc
#
#      CALL s_desc_get_item_desc(g_sfaa_d[l_ac].sfaa010) RETURNING g_sfaa_d[l_ac].sfaa010_desc,g_sfaa_d[l_ac].sfaa010_desc1
#      DISPLAY BY NAME g_sfaa_d[l_ac].sfaa010_desc
#      DISPLAY BY NAME g_sfaa_d[l_ac].sfaa010_desc1
#
#      CALL s_desc_get_unit_desc(g_sfaa_d[l_ac].sfaa013) RETURNING g_sfaa_d[l_ac].sfaa013_desc
#      DISPLAY BY NAME g_sfaa_d[l_ac].sfaa013_desc
#160503-00030#7-e
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfq005.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION asfq005_filter()
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
      CONSTRUCT g_wc_filter ON sfaa003,sfaadocno,sfaadocdt,sfaa002,sfaa010,sfaa012,sfaa013,sfaa019,sfaa020, 
          sfaastus
                          FROM s_detail1[1].b_sfaa003,s_detail1[1].b_sfaadocno,s_detail1[1].b_sfaadocdt, 
                              s_detail1[1].b_sfaa002,s_detail1[1].b_sfaa010,s_detail1[1].b_sfaa012,s_detail1[1].b_sfaa013, 
                              s_detail1[1].b_sfaa019,s_detail1[1].b_sfaa020,s_detail1[1].b_sfaastus
 
         BEFORE CONSTRUCT
                     DISPLAY asfq005_filter_parser('sfaa003') TO s_detail1[1].b_sfaa003
            DISPLAY asfq005_filter_parser('sfaadocno') TO s_detail1[1].b_sfaadocno
            DISPLAY asfq005_filter_parser('sfaadocdt') TO s_detail1[1].b_sfaadocdt
            DISPLAY asfq005_filter_parser('sfaa002') TO s_detail1[1].b_sfaa002
            DISPLAY asfq005_filter_parser('sfaa010') TO s_detail1[1].b_sfaa010
            DISPLAY asfq005_filter_parser('sfaa012') TO s_detail1[1].b_sfaa012
            DISPLAY asfq005_filter_parser('sfaa013') TO s_detail1[1].b_sfaa013
            DISPLAY asfq005_filter_parser('sfaa019') TO s_detail1[1].b_sfaa019
            DISPLAY asfq005_filter_parser('sfaa020') TO s_detail1[1].b_sfaa020
            DISPLAY asfq005_filter_parser('sfaastus') TO s_detail1[1].b_sfaastus
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_sfaa003>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa003
            #add-point:ON ACTION controlp INFIELD b_sfaa003 name="construct.c.filter.page1.b_sfaa003"
            
            #END add-point
 
 
         #----<<b_sfaadocno>>----
         #Ctrlp:construct.c.page1.b_sfaadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaadocno
            #add-point:ON ACTION controlp INFIELD b_sfaadocno name="construct.c.filter.page1.b_sfaadocno"
            #應用 a08 樣板自動產生(Version:3)
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
 
 
         #----<<b_sfaa002>>----
         #Ctrlp:construct.c.page1.b_sfaa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa002
            #add-point:ON ACTION controlp INFIELD b_sfaa002 name="construct.c.filter.page1.b_sfaa002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfaa002  #顯示到畫面上
            NEXT FIELD b_sfaa002                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_sfaa002_desc>>----
         #----<<b_sfaa010>>----
         #Ctrlp:construct.c.page1.b_sfaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa010
            #add-point:ON ACTION controlp INFIELD b_sfaa010 name="construct.c.filter.page1.b_sfaa010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfaa010  #顯示到畫面上
            NEXT FIELD b_sfaa010                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_sfaa010_desc>>----
         #----<<b_sfaa010_desc1>>----
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
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfaa013  #顯示到畫面上
            NEXT FIELD b_sfaa013                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_sfaa013_desc>>----
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
 
 
         #----<<b_sfaastus>>----
         #Ctrlp:construct.c.filter.page1.b_sfaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaastus
            #add-point:ON ACTION controlp INFIELD b_sfaastus name="construct.c.filter.page1.b_sfaastus"
            
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
 
      CALL asfq005_filter_show('sfaa003','b_sfaa003')
   CALL asfq005_filter_show('sfaadocno','b_sfaadocno')
   CALL asfq005_filter_show('sfaadocdt','b_sfaadocdt')
   CALL asfq005_filter_show('sfaa002','b_sfaa002')
   CALL asfq005_filter_show('sfaa010','b_sfaa010')
   CALL asfq005_filter_show('sfaa012','b_sfaa012')
   CALL asfq005_filter_show('sfaa013','b_sfaa013')
   CALL asfq005_filter_show('sfaa019','b_sfaa019')
   CALL asfq005_filter_show('sfaa020','b_sfaa020')
   CALL asfq005_filter_show('sfaastus','b_sfaastus')
 
 
   CALL asfq005_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="asfq005.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION asfq005_filter_parser(ps_field)
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
 
{<section id="asfq005.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION asfq005_filter_show(ps_field,ps_object)
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
   LET ls_condition = asfq005_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="asfq005.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION asfq005_detail_action_trans()
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
 
{<section id="asfq005.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION asfq005_detail_index_setting()
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
 
{<section id="asfq005.mask_functions" >}
 &include "erp/asf/asfq005_mask.4gl"
 
{</section>}
 
{<section id="asfq005.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 產生備料資訊
# Memo...........:
# Usage..........: CALL asfq005_simulate()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 140828 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq005_simulate()
   DEFINE l_sql       STRING
   DEFINE l_wc        STRING
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_j         LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_imae081   LIKE imae_t.imae081
   DEFINE l_sfba019   LIKE type_t.chr30           #160503-00030#7 add
   DEFINE l_sfba020   LIKE type_t.chr30           #160503-00030#7 add
   DEFINE l_sfba014   LIKE sfba_t.sfba014         #160503-00030#7 add
   DEFINE l_num       LIKE type_t.num20_6         #160503-00030#7 add
   DEFINE l_sum_num   LIKE type_t.num20_6         #160503-00030#7 add
   DEFINE l_xmdd004   LIKE xmdd_t.xmdd004         #160503-00030#7 add
   DEFINE l_inag007   LIKE inag_t.inag007         #160503-00030#7 add  #庫存單位
   DEFINE l_pmdo004   LIKE pmdo_t.pmdo004         #160503-00030#7 add
   DEFINE l_pmdb007   LIKE pmdb_t.pmdb007         #160503-00030#7 add
   DEFINE l_sfac004   LIKE pmdu_t.pmdu009         #160503-00030#7 add
   DEFINE l_pmdu009   LIKE pmdu_t.pmdu009         #160503-00030#7 add
   DEFINE l_sfba      RECORD
             sfbadocno     LIKE sfba_t.sfbadocno,
             sfbaseq       LIKE sfba_t.sfbaseq,
             sfbaseq1      LIKE sfba_t.sfbaseq1,
             sfba006       LIKE sfba_t.sfba006,
             sfba006_desc  LIKE type_t.chr500,    #160503-00030#7 add
             sfba006_desc1 LIKE type_t.chr500,    #160503-00030#7 add
             sfba021       LIKE sfba_t.sfba021,
             sfba021_desc  LIKE type_t.chr500,    #160503-00030#7 add
             sfba014       LIKE sfba_t.sfba014,
             sfba014_desc  LIKE type_t.chr500,    #160503-00030#7 add
             sfba013       LIKE sfba_t.sfba013,
             sfba015       LIKE sfba_t.sfba015,
             sfba016       LIKE sfba_t.sfba016,
             sfba019       LIKE sfba_t.sfba019,
             sfba019_desc  LIKE type_t.chr500,    #160503-00030#7 add
             sfba020       LIKE sfba_t.sfba020,
             sfba020_desc  LIKE type_t.chr500,    #160503-00030#7 add

             notoffer      LIKE sfba_t.sfba013,
             inag008       LIKE inag_t.inag008,
             prepare       LIKE type_t.num20_6,
             inan010       LIKE inan_t.inan010,
             canuse        LIKE type_t.num20_6,
             expect        LIKE type_t.num20_6,
             need          LIKE type_t.num20_6,
             road          LIKE type_t.num20_6,
             make          LIKE type_t.num20_6,
             check         LIKE type_t.num20_6,
             buy           LIKE type_t.num20_6,   #請購量150116
             byorder       LIKE type_t.num20_6,   #受訂量150116
             preuse        LIKE type_t.num20_6,   #預計可用量
             balances      LIKE type_t.num20_6,   #預計結存量150116
             complete      LIKE type_t.chr1
                      END RECORD                      

   CALL g_click.clear()     
   DELETE FROM asfq005_temp   #清空temp_table
  
   #先蒐集選取的工單
   LET l_wc = ''
   LET l_j = 1
   FOR l_i = 1 TO g_sfaa_d.getLength()
       IF g_sfaa_d[l_i].sel <> "Y" THEN
          CONTINUE FOR
       END IF
          
       LET l_wc = l_wc,"'",g_sfaa_d[l_i].sfaadocno,"',"

       LET g_click[l_j].* = g_sfaa_d[l_i].*
       LET l_j = l_j + 1
   END FOR

   IF l_wc.getLength() > 0 THEN
      LET l_wc = l_wc.subString(1,l_wc.getLength()-1)
      LET l_wc = '(',l_wc,')'
   ELSE            
      RETURN    #沒有勾選直接返回
   END IF

   CALL g_sfaa_d.clear()   #過濾掉沒打勾的單據
   FOR l_i = 1 TO g_click.getLength()
      LET g_sfaa_d[l_i].* = g_click[l_i].*
   END FOR

#160503-00030#7-s mod
#   LET l_sql = "SELECT sfbadocno,sfbaseq,sfbaseq1,sfba006,",
#               "       sfba013,sfba014,sfba015,sfba016,sfba019,",
#               "       sfba020,sfba021",
#               "  FROM sfba_t",
#               " WHERE sfbaent = ",g_enterprise,
#               "   AND sfbadocno IN ",l_wc ,
#               " ORDER BY sfbadocno,sfbaseq,sfbaseq1"
   LET l_sql = "SELECT sfbadocno,sfbaseq,sfbaseq1,sfba006,",
               "       (SELECT imaal003 FROM imaal_t WHERE imaalent=sfbaent AND imaal001=sfba006 AND imaal002='",g_dlang,"') sfba006_desc,",
               "       (SELECT imaal004 FROM imaal_t WHERE imaalent=sfbaent AND imaal001=sfba006 AND imaal002='",g_dlang,"') sfba006_desc1,",
               "       COALESCE(sfba013,0),sfba014,",
               "       (SELECT oocal003 FROM oocal_t WHERE oocalent=sfbaent AND oocal001=sfba014 AND oocal002='"||g_dlang,"') sfba014_desc,",
               "       COALESCE(sfba015,0),COALESCE(sfba016,0),",
               "       sfba019,",
               "       (SELECT inayl003 FROM inayl_t WHERE inaylent=sfbaent AND inayl001=sfba019 AND inayl002='"||g_dlang||"') sfba019_desc,",
               "       sfba020,",
               "       (SELECT inab003 FROM inab_t WHERE inabent=sfbaent AND inabsite=sfbasite AND inab001=sfba019 AND inab002=sfba020) sfba020_desc,",
               "       sfba021,",
               "       (SELECT inaml004 FROM inaml_t WHERE inamlent=sfbaent AND inaml001=sfba006 AND inaml002=sfba021 AND inaml003='"||g_dlang||"') sfba021_desc,",
               "       COALESCE((COALESCE(sfba013,0)-COALESCE(sfba015,0)-COALESCE(sfba016,0)),0),",
               "       (SELECT imae081 FROM imae_t WHERE imaeent=sfbaent AND imaesite=sfbasite AND imae001=sfba006)",
               "  FROM sfba_t",
               " WHERE sfbaent = ",g_enterprise,
               "   AND sfbadocno IN ",l_wc
#160503-00030#7-e mod

#160503-00030#7-s add
   #僅顯示欠料項目 (未發數量sfba013-sfba015-sfba016 > 0 表示有欠料)
   IF tm.less = 'Y' THEN
      LET l_sql = l_sql, " AND COALESCE((COALESCE(sfba013,0)-COALESCE(sfba015,0)-COALESCE(sfba016,0)),0) > 0"
   END IF
#160503-00030#7-e add

   LET l_sql = l_sql, " ORDER BY sfbadocno,sfbaseq,sfbaseq1"
  
   PREPARE asfq005_detail_pre FROM l_sql
   DECLARE asfq005_detail_cs CURSOR FOR asfq005_detail_pre
  
   LET l_i = 1
   INITIALIZE l_sfba.* TO NULL
   FOREACH asfq005_detail_cs INTO l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,
                                  l_sfba.sfba006,
                                  l_sfba.sfba006_desc,l_sfba.sfba006_desc1,  #160503-00030#7
                                  l_sfba.sfba013,
                                  l_sfba.sfba014,
                                  l_sfba.sfba014_desc,  #160503-00030#7
                                  l_sfba.sfba015,
                                  l_sfba.sfba016,
                                  l_sfba.sfba019,
                                  l_sfba.sfba019_desc,  #160503-00030#7
                                  l_sfba.sfba020,
                                  l_sfba.sfba020_desc,  #160503-00030#7
                                  l_sfba.sfba021
                                 ,l_sfba.sfba021_desc,l_sfba.notoffer,l_imae081  #160503-00030#7
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF

#160503-00030#7-s mark
#      #應發數量
#      IF cl_null(l_sfba.sfba013) THEN
#         LET l_sfba.sfba013 = 0
#      END IF
#      
#      #委外代買數量
#      IF cl_null(l_sfba.sfba015) THEN
#         LET l_sfba.sfba015 = 0
#      END IF
#
#      #已發數量
#      IF cl_null(l_sfba.sfba016) THEN
#         LET l_sfba.sfba016 = 0
#      END IF
#
#      #未發數量
#      LET l_sfba.notoffer = l_sfba.sfba013 - l_sfba.sfba015 - l_sfba.sfba016
#      IF l_sfba.notoffer < 0 OR cl_null(l_sfba.notoffer) THEN
#         LET l_sfba.notoffer = 0
#      END IF
#
#      #僅顯示欠料項目
#      IF tm.less = 'Y' AND l_sfba.notoffer <= 0 THEN
#         CONTINUE FOREACH
#      END IF
#
#      #發料單位150116
#      LET l_imae081 = ''
#      SELECT imae081 INTO l_imae081
#        FROM imae_t
#       WHERE imaeent = g_enterprise
#         AND imaesite = g_site
#         AND imae001 = l_sfba.sfba006
#160503-00030#7-e mark

      IF NOT cl_null(l_imae081) AND l_sfba.sfba014 <> l_imae081 THEN
         #應發數量
         CALL s_aooi250_convert_qty(l_sfba.sfba006,l_sfba.sfba014,l_imae081,l_sfba.sfba013) RETURNING l_success,l_sfba.sfba013
      
         #委外代買數量
         CALL s_aooi250_convert_qty(l_sfba.sfba006,l_sfba.sfba014,l_imae081,l_sfba.sfba015) RETURNING l_success,l_sfba.sfba015
      
         #已發數量
         CALL s_aooi250_convert_qty(l_sfba.sfba006,l_sfba.sfba014,l_imae081,l_sfba.sfba016) RETURNING l_success,l_sfba.sfba016
 
         #未發數量
         CALL s_aooi250_convert_qty(l_sfba.sfba006,l_sfba.sfba014,l_imae081,l_sfba.notoffer) RETURNING l_success,l_sfba.notoffer
         
         #發料單位
         LET l_sfba.sfba014 = l_imae081
      END IF

      #庫存量
#160503-00030#7-s
#      CALL asfq005_inag008_sel(l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba019,l_sfba.sfba020,l_sfba.sfba014) RETURNING l_sfba.inag008
      LET l_sfba.inag008 = 0
      LET l_num = 0
      LET l_sum_num = 0
      IF NOT cl_null(l_sfba.sfba006) THEN
         IF cl_null(l_sfba.sfba019) AND cl_null(l_sfba.sfba020) THEN
            FOREACH asfq005_inag008_cs USING g_enterprise,g_site,l_sfba.sfba006,l_sfba.sfba021
               INTO l_inag007,l_sfba.inag008
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "FOREACH:" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()             
                  EXIT FOREACH
               END IF      
               #換算成發料單位
               IF cl_null(l_inag007) OR cl_null(l_sfba.sfba014) THEN
                  LET l_num = 0
               ELSE
                  IF l_inag007 <> l_sfba.sfba014 THEN
                     CALL s_aooi250_convert_qty(l_sfba.sfba006,l_inag007,l_sfba.sfba014,l_sfba.inag008) RETURNING l_success,l_num
                     IF NOT l_success THEN
                        LET l_num = 0
                     END IF
                  ELSE
                     LET l_num = l_sfba.inag008
                  END IF
               END IF      
               LET l_sum_num = l_sum_num + l_num     
            END FOREACH
            LET l_sfba.inag008 = l_sum_num    
         END IF
         IF NOT cl_null(l_sfba.sfba019) AND cl_null(l_sfba.sfba020) THEN
            FOREACH asfq005_inag008_cs1 USING g_enterprise,g_site,l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba019
               INTO l_inag007,l_sfba.inag008
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "FOREACH:" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()             
                  EXIT FOREACH
               END IF      
               #換算成發料單位
               IF cl_null(l_inag007) OR cl_null(l_sfba.sfba014) THEN
                  LET l_num = 0
               ELSE
                  IF l_inag007 <> l_sfba.sfba014 THEN
                     CALL s_aooi250_convert_qty(l_sfba.sfba006,l_inag007,l_sfba.sfba014,l_sfba.inag008) RETURNING l_success,l_num
                     IF NOT l_success THEN
                        LET l_num = 0
                     END IF
                  ELSE
                     LET l_num = l_sfba.inag008
                  END IF
               END IF      
               LET l_sum_num = l_sum_num + l_num     
            END FOREACH
            LET l_sfba.inag008 = l_sum_num         
         END IF
         IF NOT cl_null(l_sfba.sfba019) AND NOT cl_null(l_sfba.sfba020) THEN
            FOREACH asfq005_inag008_cs2 USING g_enterprise,g_site,l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba019,l_sfba.sfba020
               INTO l_inag007,l_sfba.inag008
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "FOREACH:" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()             
                  EXIT FOREACH
               END IF      
               #換算成發料單位
               IF cl_null(l_inag007) OR cl_null(l_sfba.sfba014) THEN
                  LET l_num = 0
               ELSE
                  IF l_inag007 <> l_sfba.sfba014 THEN
                     CALL s_aooi250_convert_qty(l_sfba.sfba006,l_inag007,l_sfba.sfba014,l_sfba.inag008) RETURNING l_success,l_num
                     IF NOT l_success THEN
                        LET l_num = 0
                     END IF
                  ELSE
                     LET l_num = l_sfba.inag008
                  END IF
               END IF      
               LET l_sum_num = l_sum_num + l_num     
            END FOREACH
            LET l_sfba.inag008 = l_sum_num
         END IF
      END IF
#160503-00030#7-e

      #備置量，150116拿掉
      LET l_sfba.prepare = 0

      #在揀量，150116拿掉
      #CALL asfq005_inan010_sel(l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba019,l_sfba.sfba020,l_sfba.sfba014) RETURNING l_sfba.inan010
      LET l_sfba.inan010 = 0

      #可用餘量，150116拿掉
      #LET l_sfba.canuse = l_sfba.inag008 - l_sfba.inan010 - l_sfba.prepare
      LET l_sfba.canuse = 0

      #工單預計備料量
#160503-00030#7-s
#      CALL asfq005_expect_count(l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba014,l_sfba.sfba019,l_sfba.sfba020,'') RETURNING l_sfba.expect
      LET l_sfba.expect = 0
      LET l_num = 0
      LET l_sum_num = 0
      IF cl_null(l_sfba.sfba019) AND cl_null(l_sfba.sfba020) THEN
         FOREACH asfq005_expect_cs USING g_enterprise,g_site,l_sfba.sfba006,l_sfba.sfba021
            INTO l_sfba014,l_sfba.expect
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()             
               EXIT FOREACH
            END IF
         
            #換算成發料單位
            IF cl_null(l_sfba014) OR cl_null(l_sfba.sfba014) THEN
               LET l_num = 0
            ELSE
               IF l_sfba014 <> l_sfba.sfba014 THEN
                  CALL s_aooi250_convert_qty(l_sfba.sfba006,l_sfba014,l_sfba.sfba014,l_sfba.expect) RETURNING l_success,l_num
                  IF NOT l_success THEN
                     LET l_num = 0
                  END IF
               ELSE
                  LET l_num = l_sfba.expect
               END IF
            END IF
         
            LET l_sum_num = l_sum_num + l_num      
         END FOREACH
         LET l_sfba.expect = l_sum_num
      END IF
      
      IF NOT cl_null(l_sfba.sfba019) AND cl_null(l_sfba.sfba020) THEN
         FOREACH asfq005_expect_cs1 USING g_enterprise,g_site,l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba019
            INTO l_sfba014,l_sfba.expect
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()             
               EXIT FOREACH
            END IF
         
            #換算成發料單位
            IF cl_null(l_sfba014) OR cl_null(l_sfba.sfba014) THEN
               LET l_num = 0
            ELSE
               IF l_sfba014 <> l_sfba.sfba014 THEN
                  CALL s_aooi250_convert_qty(l_sfba.sfba006,l_sfba014,l_sfba.sfba014,l_sfba.expect) RETURNING l_success,l_num
                  IF NOT l_success THEN
                     LET l_num = 0
                  END IF
               ELSE
                  LET l_num = l_sfba.expect
               END IF
            END IF
         
            LET l_sum_num = l_sum_num + l_num      
         END FOREACH
         LET l_sfba.expect = l_sum_num
      END IF
      
      IF NOT cl_null(l_sfba.sfba019) AND NOT cl_null(l_sfba.sfba020) THEN
         FOREACH asfq005_expect_cs2 USING g_enterprise,g_site,l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba019,l_sfba.sfba020
            INTO l_sfba014,l_sfba.expect
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()             
               EXIT FOREACH
            END IF
         
            #換算成發料單位
            IF cl_null(l_sfba014) OR cl_null(l_sfba.sfba014) THEN
               LET l_num = 0
            ELSE
               IF l_sfba014 <> l_sfba.sfba014 THEN
                  CALL s_aooi250_convert_qty(l_sfba.sfba006,l_sfba014,l_sfba.sfba014,l_sfba.expect) RETURNING l_success,l_num
                  IF NOT l_success THEN
                     LET l_num = 0
                  END IF
               ELSE
                  LET l_num = l_sfba.expect
               END IF
            END IF
         
            LET l_sum_num = l_sum_num + l_num      
         END FOREACH
         LET l_sfba.expect = l_sum_num
      END IF
#160503-00030#7-e
      #LET l_sfba.expect = l_sfba.expect - l_sfba.notoffer  #減去當筆未發量

      #本次預計需求量
#160503-00030#7-s mod
#畫面上已經將此欄位隱藏,故程式裡也不需要計算了
#      CALL asfq005_expect_count(l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba014,l_sfba.sfba019,l_sfba.sfba020,l_wc) RETURNING l_sfba.need
      LET l_sfba.need = 0
#160503-00030#7-e mod
      #LET l_sfba.need = l_sfba.need - l_sfba.notoffer      #減去當筆未發量

      #在途量
#160503-00030#7-s
#      CALL asfq005_road_count(l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba014,l_sfba.sfba019,l_sfba.sfba020) RETURNING l_sfba.road
      LET l_sfba.road = 0
      LET l_num = 0
      LET l_sum_num = 0
      IF NOT cl_null(l_sfba.sfba006) THEN
         IF cl_null(l_sfba.sfba019) AND cl_null(l_sfba.sfba020) THEN
            FOREACH asfq005_road_cs USING g_enterprise,g_site,l_sfba.sfba006,l_sfba.sfba021
               INTO l_pmdo004,l_sfba.road
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "FOREACH:" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()                
                  EXIT FOREACH
               END IF
            
               #換算成發料單位
               IF cl_null(l_pmdo004) OR cl_null(l_sfba.sfba014) THEN
                  LET l_num = 0
               ELSE
                  IF l_pmdo004 <> l_sfba.sfba014 THEN
                     CALL s_aooi250_convert_qty(l_sfba.sfba006,l_pmdo004,l_sfba.sfba014,l_sfba.road) RETURNING l_success,l_num
                     IF NOT l_success THEN
                        LET l_num = 0
                     END IF
                  ELSE
                     LET l_num = l_sfba.road
                  END IF
               END IF      
               LET l_sum_num = l_sum_num + l_num      
            END FOREACH      
            LET l_sfba.road = l_sum_num
         END IF
         IF NOT cl_null(l_sfba.sfba019) AND cl_null(l_sfba.sfba020) THEN
            FOREACH asfq005_road_cs1 USING g_enterprise,g_site,l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba019
               INTO l_pmdo004,l_sfba.road
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "FOREACH:" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()                
                  EXIT FOREACH
               END IF
            
               #換算成發料單位
               IF cl_null(l_pmdo004) OR cl_null(l_sfba.sfba014) THEN
                  LET l_num = 0
               ELSE
                  IF l_pmdo004 <> l_sfba.sfba014 THEN
                     CALL s_aooi250_convert_qty(l_sfba.sfba006,l_pmdo004,l_sfba.sfba014,l_sfba.road) RETURNING l_success,l_num
                     IF NOT l_success THEN
                        LET l_num = 0
                     END IF
                  ELSE
                     LET l_num = l_sfba.road
                  END IF
               END IF      
               LET l_sum_num = l_sum_num + l_num      
            END FOREACH      
            LET l_sfba.road = l_sum_num
         END IF
         IF NOT cl_null(l_sfba.sfba019) AND NOT cl_null(l_sfba.sfba020) THEN
            FOREACH asfq005_road_cs2 USING g_enterprise,g_site,l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba019,l_sfba.sfba020
               INTO l_pmdo004,l_sfba.road
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "FOREACH:" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()                
                  EXIT FOREACH
               END IF
            
               #換算成發料單位
               IF cl_null(l_pmdo004) OR cl_null(l_sfba.sfba014) THEN
                  LET l_num = 0
               ELSE
                  IF l_pmdo004 <> l_sfba.sfba014 THEN
                     CALL s_aooi250_convert_qty(l_sfba.sfba006,l_pmdo004,l_sfba.sfba014,l_sfba.road) RETURNING l_success,l_num
                     IF NOT l_success THEN
                        LET l_num = 0
                     END IF
                  ELSE
                     LET l_num = l_sfba.road
                  END IF
               END IF      
               LET l_sum_num = l_sum_num + l_num      
            END FOREACH      
            LET l_sfba.road = l_sum_num
         END IF
      END IF
#160503-00030#7-e

      #在製量
#160503-00030#7-s
#      CALL asfq005_make_count(l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba014) RETURNING l_sfba.make
      LET l_sfba.make = 0
      LET l_num = 0
      LET l_sum_num = 0
      IF NOT cl_null(l_sfba.sfba006) THEN
         FOREACH asfq005_make_cs USING g_enterprise,g_site,l_sfba.sfba006,l_sfba.sfba021
            INTO l_sfac004,l_sfba.make
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()                
               EXIT FOREACH
            END IF
         
            #換算成發料單位
            IF cl_null(l_sfac004) OR cl_null(l_sfba.sfba014) THEN
               LET l_num = 0
            ELSE
               IF l_sfac004 <> l_sfba.sfba014 THEN
                  CALL s_aooi250_convert_qty(l_sfba.sfba006,l_sfac004,l_sfba.sfba014,l_sfba.make) RETURNING l_success,l_num
                  IF NOT l_success THEN
                     LET l_num = 0
                  END IF
               ELSE
                  LET l_num = l_sfba.make
               END IF
            END IF
            LET l_sum_num = l_sum_num + l_num 
         END FOREACH
         LET l_sfba.make = l_sum_num
      END IF
#160503-00030#7-e

      #在驗量
#160503-00030#7-s
#      CALL asfq005_check_count(l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba014,l_sfba.sfba019,l_sfba.sfba020) RETURNING l_sfba.check
      LET l_sfba.check = 0
      LET l_num = 0
      LET l_sum_num = 0
      IF NOT cl_null(l_sfba.sfba006) THEN
         IF cl_null(l_sfba.sfba019) AND cl_null(l_sfba.sfba020) THEN
            FOREACH asfq005_check_cs USING g_enterprise,g_site,l_sfba.sfba006,l_sfba.sfba021
               INTO l_pmdu009,l_sfba.check
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "FOREACH:" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()                
                  EXIT FOREACH
               END IF
            
               #換算成發料單位
               IF cl_null(l_pmdu009) OR cl_null(l_sfba.sfba014) THEN
                  LET l_num = 0
               ELSE
                  IF l_pmdu009 <> l_sfba.sfba014 THEN
                     CALL s_aooi250_convert_qty(l_sfba.sfba006,l_pmdu009,l_sfba.sfba014,l_sfba.check) RETURNING l_success,l_num
                     IF NOT l_success THEN
                        LET l_num = 0
                     END IF
                  ELSE
                     LET l_num = l_sfba.check
                  END IF
               END IF
               LET l_sum_num = l_sum_num + l_num 
            END FOREACH
            LET l_sfba.check = l_sum_num
         END IF
         IF NOT cl_null(l_sfba.sfba019) AND cl_null(l_sfba.sfba020) THEN
            FOREACH asfq005_check_cs1 USING g_enterprise,g_site,l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba019
               INTO l_pmdu009,l_sfba.check
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "FOREACH:" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()                
                  EXIT FOREACH
               END IF
            
               #換算成發料單位
               IF cl_null(l_pmdu009) OR cl_null(l_sfba.sfba014) THEN
                  LET l_num = 0
               ELSE
                  IF l_pmdu009 <> l_sfba.sfba014 THEN
                     CALL s_aooi250_convert_qty(l_sfba.sfba006,l_pmdu009,l_sfba.sfba014,l_sfba.check) RETURNING l_success,l_num
                     IF NOT l_success THEN
                        LET l_num = 0
                     END IF
                  ELSE
                     LET l_num = l_sfba.check
                  END IF
               END IF
               LET l_sum_num = l_sum_num + l_num 
            END FOREACH
            LET l_sfba.check = l_sum_num
         END IF
         IF NOT cl_null(l_sfba.sfba019) AND NOT cl_null(l_sfba.sfba020) THEN
            FOREACH asfq005_check_cs2 USING g_enterprise,g_site,l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba019,l_sfba.sfba020
               INTO l_pmdu009,l_sfba.check
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "FOREACH:" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()                
                  EXIT FOREACH
               END IF
            
               #換算成發料單位
               IF cl_null(l_pmdu009) OR cl_null(l_sfba.sfba014) THEN
                  LET l_num = 0
               ELSE
                  IF l_pmdu009 <> l_sfba.sfba014 THEN
                     CALL s_aooi250_convert_qty(l_sfba.sfba006,l_pmdu009,l_sfba.sfba014,l_sfba.check) RETURNING l_success,l_num
                     IF NOT l_success THEN
                        LET l_num = 0
                     END IF
                  ELSE
                     LET l_num = l_sfba.check
                  END IF
               END IF
               LET l_sum_num = l_sum_num + l_num 
            END FOREACH
            LET l_sfba.check = l_sum_num
         END IF
      END IF
#160503-00030#7-e

      #請購量 = 請購需求量 - 已轉採購量   150116
#160503-00030#7-s
#      CALL asfq005_buy_count(l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba014) RETURNING l_sfba.buy
      LET l_num = 0
      LET l_sum_num = 0
      FOREACH asfq005_buy_cur USING g_enterprise,g_site,l_sfba.sfba006,l_sfba.sfba021
         INTO l_sfba.buy,l_pmdb007
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:asfq005_buy_cur"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()    
            LET l_success = FALSE
            EXIT FOREACH
         END IF   
         IF l_pmdb007 <> l_sfba.sfba014 THEN
            CALL s_aooi250_convert_qty(l_sfba.sfba006,l_pmdb007,l_sfba.sfba014,l_sfba.buy) RETURNING l_success,l_num
            IF NOT l_success THEN
               LET l_num = 0
            END IF
         ELSE
            LET l_num = l_sfba.buy
         END IF  
         LET l_sum_num = l_sum_num + l_num
      END FOREACH      
      LET l_sfba.buy = l_sum_num
#160503-00030#7-e
         
      #受訂量 = 訂單量 - 已出貨量 150116
#160503-00030#7-s
#      CALL asfq005_byorder_count(l_sfba.sfba006,l_sfba.sfba021,l_sfba.sfba014) RETURNING l_sfba.byorder
      LET l_num = 0
      LET l_sum_num = 0
      FOREACH asfq005_byorder_cur USING g_enterprise,g_site,l_sfba.sfba006,l_sfba.sfba021
         INTO l_sfba.byorder,l_xmdd004
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:asfq005_byorder_cur"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()    
            LET l_success = FALSE
            EXIT FOREACH
         END IF   
         IF l_xmdd004 <> l_sfba.sfba014 THEN
            CALL s_aooi250_convert_qty(l_sfba.sfba006,l_xmdd004,l_sfba.sfba014,l_sfba.byorder) RETURNING l_success,l_num
            IF NOT l_success THEN
               LET l_num = 0
            END IF
         ELSE
            LET l_num = l_sfba.byorder
         END IF         
         LET l_sum_num = l_sum_num + l_num
      END FOREACH
      LET l_sfba.byorder = l_sum_num
#160503-00030#7-e

      #預計可用量 = 庫存可用量 - 受訂量 - 工單預計備料量 + 請購量 + 在途量 + 在驗量 + 在製量  150116
      LET l_sfba.preuse = l_sfba.inag008 - l_sfba.byorder - l_sfba.expect + l_sfba.buy + l_sfba.road + l_sfba.check + l_sfba.make
      #LET l_sfba.preuse = l_sfba.canuse - l_sfba.need + l_sfba.road + l_sfba.make + l_sfba.check      
      
      #預計結存量 = 預計可用量 - 本次需求數量  150116
      LET l_sfba.balances = l_sfba.preuse - l_sfba.need

      #1.是：可用餘量 - 本次預計需求量 >= 未發數量
      #2.否：可用餘量 + 在途 + 在製 + 在驗 < 未發
      #3.需人工判斷：其他

      #滿足備料需求否
      CASE
         #170208-00014#1-s
         #WHEN l_sfba.canuse - l_sfba.need >= l_sfba.notoffer
         WHEN l_sfba.balances >= l_sfba.notoffer
         #170208-00014#1-e
            LET l_sfba.complete = '1' #是
         OTHERWISE
            LET l_sfba.complete = '2' #否
#141216取消"需人工判斷"
#         WHEN l_sfba.canuse + l_sfba.road + l_sfba.make + l_sfba.check < l_sfba.notoffer
#            LET l_sfba.complete = '2' #否#            
#         OTHERWISE
#            LET l_sfba.complete = '3' #需人工判斷
      END CASE
      
      INSERT INTO asfq005_temp(docno,seq,seq1,
                               sfba006,
                               sfba006_desc,sfba006_desc1,  #160503-00030#7
                               sfba021,
                               sfba021_desc,  #160503-00030#7
                               sfba014,
                               sfba014_desc,  #160503-00030#7
                               sfba013,sfba016,notoffer,
                               sfba019,
                               sfba019_desc,  #160503-00030#7
                               sfba020,
                               sfba020_desc,  #160503-00030#7
                               inag008,prepare,
                               inan010,canuse,expect,need,road,
                               make,checknum,preuse,complete,
                               buy,byorder,balances)   #150116
      VALUES(l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,
             l_sfba.sfba006,
             l_sfba.sfba006_desc,l_sfba.sfba006_desc1,  #160503-00030#7
             l_sfba.sfba021,
             l_sfba.sfba021_desc,  #160503-00030#7
             l_sfba.sfba014,
             l_sfba.sfba014_desc,  #160503-00030#7
             l_sfba.sfba013,l_sfba.sfba016,l_sfba.notoffer,
             l_sfba.sfba019,
             l_sfba.sfba019_desc,  #160503-00030#7
             l_sfba.sfba020,
             l_sfba.sfba020_desc,  #160503-00030#7
             l_sfba.inag008,l_sfba.prepare,
             l_sfba.inan010,l_sfba.canuse,l_sfba.expect,l_sfba.need,l_sfba.road,
             l_sfba.make,l_sfba.check,l_sfba.preuse,l_sfba.complete,
             l_sfba.buy,l_sfba.byorder,l_sfba.balances)   #150116
             
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF  
   END FOREACH
   
END FUNCTION

################################################################################
# Descriptions...: 工單項序是否欠料檢查
# Memo...........:
# Usage..........: CALL asfq005_lack_chk(p_type,p_sfbadocno,p_sfbaseq,p_sfbaseq1)
#                  RETURNING r_success
# Input parameter: p_type         1.無欠料檢查2.無發料檢查
#                : p_sfbadocno    工單單號
#                : p_sfbaseq      項次
#                : p_sfbaseq1     項序
# Return code....: r_success      執行結果(欠料、已發料回傳True)
#                : 
# Date & Author..: 140828 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq005_lack_chk(p_type,p_sfbadocno,p_sfbaseq,p_sfbaseq1)
   DEFINE p_type         LIKE type_t.chr1
   DEFINE p_sfbadocno    LIKE sfba_t.sfbadocno
   DEFINE p_sfbaseq      LIKE sfba_t.sfbaseq
   DEFINE p_sfbaseq1     LIKE sfba_t.sfbaseq1   
   DEFINE r_success      LIKE type_t.num5
   
   DEFINE l_sfba013      LIKE sfba_t.sfba013   #應發數量
   DEFINE l_sfba015      LIKE sfba_t.sfba015   #委外代買數量
   DEFINE l_sfba016      LIKE sfba_t.sfba016   #已發數量
   
   DEFINE l_num          LIKE sfba_t.sfba013
   DEFINE l_num1         LIKE sfba_t.sfba013
   
   LET r_success = TRUE
   
   LET l_sfba013 = ''
   LET l_sfba015 = ''
   LET l_sfba016 = ''
   
   SELECT sfba013,sfba015,sfba016
     INTO l_sfba013,l_sfba015,l_sfba016
     FROM sfba_t
    WHERE sfbaent = g_enterprise
      AND sfbadocno = p_sfbadocno
      AND sfbaseq = p_sfbaseq
      AND sfbaseq1 = p_sfbaseq1
   
   IF cl_null(l_sfba013) THEN
      LET l_sfba013 = 0
   END IF

   IF cl_null(l_sfba015) THEN
      LET l_sfba015 = 0
   END IF

   IF cl_null(l_sfba016) THEN
      LET l_sfba016 = 0
   END IF

   LET l_num = l_sfba013 - l_sfba015 - l_sfba016  #未發數量
   LET l_num1 = l_sfba015 + l_sfba016
   
   CASE p_type
      WHEN '1' #1.無欠料檢查
         IF l_num <= 0 THEN  #已無欠料
            LET r_success = FALSE
         END IF
         
      WHEN '2' #2.無發料檢查
         IF l_sfba016 = 0 THEN #未發料
            LET r_success = FALSE
         END IF
   END CASE

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 工單單身檢查
# Memo...........:
# Usage..........: CALL asfq005_detail_chk(p_sfbadocno)
#                  RETURNING r_success
# Input parameter: p_type        1.無欠料檢查2.無發料檢查
#                : p_sfbadocno   工單單號
# Return code....: r_success     檢查結果(欠料、已發料回傳True)
#                : 
# Date & Author..: 140828 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq005_detail_chk(p_type,p_sfbadocno)
   DEFINE p_type          LIKE type_t.chr1
   DEFINE p_sfbadocno     LIKE sfba_t.sfbadocno
   DEFINE r_success       LIKE type_t.num5
   
   DEFINE l_sql           STRING
   DEFINE l_sfbaseq       LIKE sfba_t.sfbaseq
   DEFINE l_sfbaseq1      LIKE sfba_t.sfbaseq1

   LET r_success = TRUE
   
   LET l_sql = "SELECT sfbaseq,sfbaseq1",
               "  FROM sfba_t",
               " WHERE sfbaent = ",g_enterprise,
               "   AND sfbadocno = '",p_sfbadocno,"'"
               
   PREPARE asfq005_chk_pre FROM l_sql
   DECLARE asfq005_chk_cs CURSOR FOR asfq005_chk_pre

   OPEN asfq005_chk_cs

   FOREACH asfq005_chk_cs INTO l_sfbaseq,l_sfbaseq1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         LET r_success = FALSE 
         EXIT FOREACH
      END IF

      #工單項序是否欠料檢查
      CALL asfq005_lack_chk(p_type,p_sfbadocno,l_sfbaseq,l_sfbaseq1)
      RETURNING r_success
      
      IF r_success THEN
         RETURN r_success
      END IF
   END FOREACH

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 計算庫存可用量
# Memo...........:
# Usage..........: CALL asfq005_inag008_sel(p_inag001,p_inag002,p_inag004,p_inag005,p_inag007)
#                  RETURNING r_inag008
# Input parameter: p_inag001   料號
#                : p_inag002   產品特徵
#                : p_inag004   限定庫位
#                : p_inag005   限定儲位
#                : p_inag007   發料單位
# Return code....: r_inag008   庫存可用量
#                : 
# Date & Author..: 140829 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq005_inag008_sel(p_inag001,p_inag002,p_inag004,p_inag005,p_inag007)
   DEFINE p_inag001   LIKE inag_t.inag001   #料件編號
   DEFINE p_inag002   LIKE inag_t.inag002   #產品特徵  
   DEFINE p_inag004   LIKE inag_t.inag004   #限定庫位
   DEFINE p_inag005   LIKE inag_t.inag005   #限定儲位
   DEFINE p_inag007   LIKE inag_t.inag007   #發料單位
   
   DEFINE r_inag008   LIKE inag_t.inag008   #帳面庫存數量
   
   DEFINE l_sql       STRING
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_inag007   LIKE inag_t.inag007   #庫存單位
   DEFINE l_inag008   LIKE inag_t.inag008   #帳面庫存數量

#160503-00030#7-s mark
#   LET r_inag008 = 0
#   
#   #料號
#   IF cl_null(p_inag001) THEN
#      RETURN r_inag008
#   END IF
#   
#   #產品特徵
#   IF cl_null(p_inag002) THEN
#      LET p_inag002 = ' '
#   END IF   
#   
#   LET l_sql = "SELECT inag007,SUM(COALESCE(inag008,0))",
#               "  FROM inag_t",
#               " WHERE inagent = ",g_enterprise,
#               "   AND inagsite = '",g_site,"'",
#               "   AND inag001 = '",p_inag001,"'",
#               "   AND inag002 = '",p_inag002,"'",
#               "   AND inag010 = 'Y'"
#               
#   IF NOT cl_null(p_inag004) THEN  #有限定庫位
#      LET l_sql = l_sql," AND inag004 = '",p_inag004,"'"
#   END IF
#
#   IF NOT cl_null(p_inag005) THEN  #有限定儲位
#      LET l_sql = l_sql," AND inag005 = '",p_inag005,"'"
#   END IF
#
#   LET l_sql = l_sql," GROUP BY inag007"
#
#   PREPARE asfq005_inag008_pre FROM l_sql
#   DECLARE asfq005_inag008_cs CURSOR FOR asfq005_inag008_pre
#   
#   OPEN asfq005_inag008_cs
#   FOREACH asfq005_inag008_cs INTO l_inag007,l_inag008
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
#          
#         EXIT FOREACH
#      END IF
#   
#      #換算成發料單位
#      IF cl_null(l_inag007) OR cl_null(p_inag007) THEN
#         LET l_inag008 = 0
#      ELSE
#         IF l_inag007 <> p_inag007 THEN
#            CALL s_aooi250_convert_qty(p_inag001,l_inag007,p_inag007,l_inag008) RETURNING l_success,l_inag008
#            IF NOT l_success THEN
#               LET l_inag008 = 0
#            END IF
#         END IF
#      END IF
#   
#      LET r_inag008 = r_inag008 + l_inag008
#   
#   END FOREACH
#
#   RETURN r_inag008
#160503-00030#7-e mark

END FUNCTION

################################################################################
# Descriptions...: 計算在揀量
# Memo...........:
# Usage..........: CALL asfq005_inan010_sel(p_inan001,p_inan002,p_inan004,p_inan005,p_inan007)
#                  RETURNING r_inan010
# Input parameter: p_inan001   料號
#                : p_inan002   產品特徵
#                : p_inan004   限定庫位
#                : p_inan005   限定儲位
#                : p_inan007   發料單位
# Return code....: r_inan010   在揀量
# Date & Author..: 140829 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq005_inan010_sel(p_inan001,p_inan002,p_inan004,p_inan005,p_inan007)
   DEFINE p_inan001   LIKE inan_t.inan001   #料件編號
   DEFINE p_inan002   LIKE inan_t.inan002   #產品特徵  
   DEFINE p_inan004   LIKE inan_t.inan004   #限定庫位
   DEFINE p_inan005   LIKE inan_t.inan005   #限定儲位
   DEFINE p_inan007   LIKE inan_t.inan007   #發料單位
   
   DEFINE r_inan010   LIKE inan_t.inan010   #在揀量
   
   DEFINE l_sql       STRING
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_inan007   LIKE inan_t.inan007   #在揀單位
   DEFINE l_inan010   LIKE inan_t.inan010   #在揀量
   
   LET r_inan010 = 0
   
   #料號
   IF cl_null(p_inan001) THEN
      RETURN r_inan010
   END IF
   
   #產品特徵
   IF cl_null(p_inan002) THEN
      LET p_inan002 = ' '
   END IF   
   
   LET l_sql = "SELECT inan007,SUM(COALESCE(inan010,0))",
               "  FROM inan_t",
               " WHERE inanent = ",g_enterprise,
               "   AND inansite = '",g_site,"'",
               "   AND inan001 = '",p_inan001,"'",
               "   AND inan002 = '",p_inan002,"'"
               
   IF NOT cl_null(p_inan004) THEN  #有限定庫位
      LET l_sql = l_sql," AND inan004 = '",p_inan004,"'"
   END IF

   IF NOT cl_null(p_inan005) THEN  #有限定儲位
      LET l_sql = l_sql," AND inan005 = '",p_inan005,"'"
   END IF

   LET l_sql = l_sql," GROUP BY inan007"

   PREPARE asfq005_inan010_pre FROM l_sql
   DECLARE asfq005_inan010_cs CURSOR FOR asfq005_inan010_pre
   
   OPEN asfq005_inan010_cs
   FOREACH asfq005_inan010_cs INTO l_inan007,l_inan010
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
          
         EXIT FOREACH
      END IF
   
      #換算成發料單位
      IF cl_null(l_inan007) OR cl_null(p_inan007) THEN
         LET l_inan010 = 0
      ELSE
         IF l_inan007 <> p_inan007 THEN
            CALL s_aooi250_convert_qty(p_inan001,l_inan007,p_inan007,l_inan010) RETURNING l_success,l_inan010
            IF NOT l_success THEN
               LET l_inan010 = 0
            END IF
         END IF
      END IF
   
      LET r_inan010 = r_inan010 + l_inan010
   
   END FOREACH

   RETURN r_inan010
END FUNCTION

################################################################################
# Descriptions...: 工單預計備料量計算
# Memo...........:
# Usage..........: CALL asfq005_expect_count(p_sfba006,p_sfba021,p_sfba014,p_sfba019,p_sfba020,p_wc)
#                  RETURNING r_num
# Input parameter: p_sfba006   發料料號
#                : p_sfba021   產品特徵
#                : p_sfba014   單位
#                : p_sfba019   庫位
#                : p_sfba020   儲位
#                : p_wc        勾選條件
# Return code....: r_num       備料量
#                : 
# Date & Author..: 140829 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq005_expect_count(p_sfba006,p_sfba021,p_sfba014,p_sfba019,p_sfba020,p_wc)
   DEFINE p_sfba006   LIKE sfba_t.sfba006    #發料料號
   DEFINE p_sfba021   LIKE sfba_t.sfba021    #產品特徵   
   DEFINE p_sfba014   LIKE sfba_t.sfba014    #單位   
   DEFINE p_sfba019   LIKE sfba_t.sfba019    #庫位
   DEFINE p_sfba020   LIKE sfba_t.sfba020    #儲位
   DEFINE p_wc        STRING                 #勾選條件
   DEFINE r_num       LIKE type_t.num20_6    #備料量
   
   DEFINE l_sql       STRING
   DEFINE l_sfba014   LIKE sfba_t.sfba014
   DEFINE l_num       LIKE type_t.num20_6
   DEFINE l_success   LIKE type_t.num5

#160503-00030#7-s mark
#   LET r_num = 0
#
#   #料號
#   IF cl_null(p_sfba006) THEN
#      RETURN r_num
#   END IF
#
#   IF cl_null(p_sfba021) THEN
#      LET p_sfba021 = ' '
#   END IF
#
#   #若報廢量=0，備料量 = 應發量 - 已發量 - 委外代買量
#   #若報廢量>0，備料量 = 應發量 - 已發量 - 委外代買量 + 報廢量 - 超領量
#   LET l_sql = "SELECT sfba014,",
#               "       (CASE",
#               "           WHEN (COALESCE(sfba017,0) = 0) OR ((COALESCE(sfba017,0) - COALESCE(sfba025,0)) < 0) THEN",
#               "              (COALESCE(sfba013,0) - COALESCE(sfba016,0) - COALESCE(sfba015,0))",
#               "           ELSE",
#               "              (COALESCE(sfba013,0) - COALESCE(sfba016,0) - COALESCE(sfba015,0) + COALESCE(sfba017,0) - COALESCE(sfba025,0))",
#               "        END)",
#               "  FROM sfaa_t,sfba_t",
#               " WHERE sfaaent = sfbaent AND sfaaent = ",g_enterprise,
#               "   AND sfaasite = sfbasite AND sfaasite = '",g_site,"'",
#               "   AND sfaadocno = sfbadocno",
#               "   AND sfaastus NOT IN ('X','C','M') ",
#               "   AND COALESCE(sfba013,0) - COALESCE(sfba016,0) - COALESCE(sfba015,0) <> 0",
#               "   AND sfaa003 <> '4'",
#              #"   AND sfaa057 = '1'",  #150710 mark #參照asfq004修改
#               "   AND sfba006 = '",p_sfba006,"'",
#               "   AND COALESCE(sfba021,' ') = '",p_sfba021,"'"
#         
##150116修改邏輯
##   #應發數量 - 委外代買數量 - 已發數量   
##   LET l_sql = "SELECT sfba014,",
##               "       SUM(COALESCE(sfba013,0)) - SUM(COALESCE(sfba015,0)) - SUM(COALESCE(sfba016,0))",
##               "  FROM sfaa_t,sfba_t",
##               " WHERE sfaaent = sfbaent AND sfbaent = ",g_enterprise,
##               "   AND sfaasite = sfbasite AND sfbasite = '",g_site,"'",
##               "   AND sfaadocno = sfbadocno",
##               "   AND sfaastus = 'F'",              #已發出
##               "   AND COALESCE(sfba013,0) > COALESCE(sfba015,0) + COALESCE(sfba016,0)",  #還有未發數量
##               "   AND sfba006 = '",p_sfba006,"'",
##               "   AND COALESCE(sfba021,' ') = '",p_sfba021,"'"
#
#   IF NOT cl_null(p_sfba019) THEN  #有限定庫位
#      LET l_sql = l_sql," AND sfba019 = '",p_sfba019,"'"
#   END IF
#
#   IF NOT cl_null(p_sfba020) THEN  #有限定儲位
#      LET l_sql = l_sql," AND sfba020 = '",p_sfba020,"'"
#   END IF
#
#   IF NOT cl_null(p_wc) THEN
#      LET l_sql = l_sql," AND sfbadocno IN ",p_wc
#   END IF
#
#   PREPARE asfq005_expect_pre FROM l_sql
#   DECLARE asfq005_expect_cs CURSOR FOR asfq005_expect_pre
#   
#   OPEN asfq005_expect_cs
#   FOREACH asfq005_expect_cs INTO l_sfba014,l_num
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
#          
#         EXIT FOREACH
#      END IF
#   
#      #換算成發料單位
#      IF cl_null(l_sfba014) OR cl_null(p_sfba014) THEN
#         LET l_num = 0
#      ELSE
#         IF l_sfba014 <> p_sfba014 THEN
#            CALL s_aooi250_convert_qty(p_sfba006,l_sfba014,p_sfba014,l_num) RETURNING l_success,l_num
#            IF NOT l_success THEN
#               LET l_num = 0
#            END IF
#         END IF
#      END IF
#   
#      LET r_num = r_num + l_num
#   
#   END FOREACH
#   
#   RETURN r_num
#160503-00030#7-e mark

END FUNCTION

################################################################################
# Descriptions...: 在途量計算
# Memo...........:
# Usage..........: CALL asfq005_road_count(p_pmdo001,p_pmdo002,p_pmdo004,p_pmdn028,p_pmdn029)
#                  RETURNING r_num
# Input parameter: p_pmdo001   料件編號
#                : p_pmdo002   產品特徵
#                : p_pmdo004   單位
#                : p_pmdn028   庫位
#                : p_pmdn029   儲位
# Return code....: r_num       在途量
#                : 
# Date & Author..: 140901 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq005_road_count(p_pmdo001,p_pmdo002,p_pmdo004,p_pmdn028,p_pmdn029)
   DEFINE p_pmdo001   LIKE pmdo_t.pmdo001    #料號編號
   DEFINE p_pmdo002   LIKE pmdo_t.pmdo002    #產品特徵   
   DEFINE p_pmdo004   LIKE pmdo_t.pmdo004    #單位
   DEFINE p_pmdn028   LIKE pmdn_t.pmdn028    #庫位
   DEFINE p_pmdn029   LIKE pmdn_t.pmdn029    #儲位
   DEFINE r_num       LIKE type_t.num20_6    #在途量

   DEFINE l_sql       STRING
   DEFINE l_pmdo004   LIKE pmdo_t.pmdo004
   DEFINE l_num       LIKE type_t.num20_6  
   DEFINE l_success   LIKE type_t.num5   

#160503-00030#7-s mark
#   LET r_num = 0
#
#   #料號
#   IF cl_null(p_pmdo001) THEN
#      RETURN r_num
#   END IF
#
#   IF cl_null(p_pmdo002) THEN
#      LET p_pmdo002 = ' '
#   END IF
#
#   #採購單位、分批採購數量-已收貨量+驗退量+倉退換貨量
#   LET l_sql = "SELECT pmdo004,",
#               "       SUM(COALESCE(pmdo006,0)) - SUM(COALESCE(pmdo015,0)) + SUM(COALESCE(pmdo016,0)) + SUM(COALESCE(pmdo017,0))",
#               "  FROM pmdl_t,pmdn_t,pmdo_t",
#               " WHERE pmdlent = pmdnent AND pmdnent = pmdoent AND pmdoent = ",g_enterprise,
#               "   AND pmdldocno = pmdndocno AND pmdndocno = pmdodocno",
#               "   AND pmdnseq = pmdoseq",
#               "   AND pmdlstus = 'Y'",
#               "   AND pmdnunit = '",g_site,"'",   #收貨據點
#               "   AND COALESCE(pmdo006,0) + COALESCE(pmdo016,0) + COALESCE(pmdo017,0) > COALESCE(pmdo015,0)",    #尚有未收貨的數量
#               "   AND pmdo001 = '",p_pmdo001,"'",
#               "   AND COALESCE(pmdo002,' ') = '",p_pmdo002,"'"
#               
#               
#   IF NOT cl_null(p_pmdn028) THEN  #有限定庫位
#      LET l_sql = l_sql," AND pmdn028 = '",p_pmdn028,"'"
#   END IF
#
#   IF NOT cl_null(p_pmdn029) THEN  #有限定儲位
#      LET l_sql = l_sql," AND pmdn029 = '",p_pmdn029,"'"
#   END IF               
#               
#   LET l_sql = l_sql," GROUP BY pmdo004"
#
#   PREPARE asfq005_road_pre FROM l_sql
#   DECLARE asfq005_road_cs CURSOR FOR asfq005_road_pre
#   
#   OPEN asfq005_road_cs
#   FOREACH asfq005_road_cs INTO l_pmdo004,l_num
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
#          
#         EXIT FOREACH
#      END IF
#   
#      #換算成發料單位
#      IF cl_null(l_pmdo004) OR cl_null(p_pmdo004) THEN
#         LET l_num = 0
#      ELSE
#         IF l_pmdo004 <> p_pmdo004 THEN
#            CALL s_aooi250_convert_qty(p_pmdo001,l_pmdo004,p_pmdo004,l_num) RETURNING l_success,l_num
#            IF NOT l_success THEN
#               LET l_num = 0
#            END IF
#         END IF
#      END IF
#   
#      LET r_num = r_num + l_num
#   
#   END FOREACH
#   
#   RETURN r_num   
#160503-00030#7-e mark
   
END FUNCTION

################################################################################
# Descriptions...: 在製量計算
# Memo...........:
# Usage..........: CALL asfq005_make_count(p_sfac001,p_sfac006,p_sfac004)
#                  RETURNING r_num
# Input parameter: p_sfac001    料件編號
#                : p_sfac006    產品特徵
#                : p_sfac004    單位
# Return code....: r_num        在製量
#                : 
# Date & Author..: 140901 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq005_make_count(p_sfac001,p_sfac006,p_sfac004)
   DEFINE p_sfac001   LIKE sfac_t.sfac001    #料號編號
   DEFINE p_sfac006   LIKE sfac_t.sfac006    #產品特徵   
   DEFINE p_sfac004   LIKE sfac_t.sfac004    #單位

   DEFINE r_num       LIKE type_t.num20_6    #在製量

   DEFINE l_sql       STRING
   DEFINE l_sfac004   LIKE pmdu_t.pmdu009
   DEFINE l_num       LIKE sfac_t.sfac004
   DEFINE l_success   LIKE type_t.num5

#160503-00030#7-s mark
#   LET r_num = 0
#
#   #料號
#   IF cl_null(p_sfac001) THEN
#      RETURN r_num
#   END IF
#
#   IF cl_null(p_sfac006) THEN
#      LET p_sfac006 = ' '
#   END IF
#
#   #製造單位、預計產出量-實際出產數量
#   LET l_sql = "SELECT sfac004,",
#               "       SUM(COALESCE(sfac003,0)) - SUM(COALESCE(sfac005,0))",
#               "  FROM sfaa_t,sfac_t",
#               " WHERE sfaaent = sfacent AND sfacent = ",g_enterprise,
#               "   AND sfaasite = sfacsite AND sfacsite = '",g_site,"'",
#               "   AND sfaadocno = sfacdocno",
#               "   AND sfaastus = 'F'",   #已發出
#               "   AND sfac001 = '",p_sfac001,"'",
#               "   AND COALESCE(sfac006,' ') = '",p_sfac006,"'",
#               "   AND COALESCE(sfac003,0) > COALESCE(sfac005,0)",    #尚有在製造
#               " GROUP BY sfac004"
#                  
#   PREPARE asfq005_make_pre FROM l_sql
#   DECLARE asfq005_make_cs CURSOR FOR asfq005_make_pre
#   
#   OPEN asfq005_make_cs
#   FOREACH asfq005_make_cs INTO l_sfac004,l_num
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
#          
#         EXIT FOREACH
#      END IF
#   
#      #換算成發料單位
#      IF cl_null(l_sfac004) OR cl_null(p_sfac004) THEN
#         LET l_num = 0
#      ELSE
#         IF l_sfac004 <> p_sfac004 THEN
#            CALL s_aooi250_convert_qty(p_sfac001,l_sfac004,p_sfac004,l_num) RETURNING l_success,l_num
#            IF NOT l_success THEN
#               LET l_num = 0
#            END IF
#         END IF
#      END IF
#   
#      LET r_num = r_num + l_num
#   
#   END FOREACH
#   
#   RETURN r_num
#160503-00030#7-e mark
   
END FUNCTION

################################################################################
# Descriptions...: 在驗量計算
# Memo...........:
# Usage..........: CALL asfq005_check_count(p_pmdu001,p_pmdu002,p_pmdu009,p_pmdu006,p_pmdu007)
#                  RETURNING r_num
# Input parameter: p_pmdu001    料件編號
#                : p_pmdu002    產品特徵
#                : p_pmdu009    單位
#                : p_pmdu006    庫位
#                : p_pmdu007    儲位
# Return code....: r_num        在驗量
#                : 
# Date & Author..: 140901 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq005_check_count(p_pmdu001,p_pmdu002,p_pmdu009,p_pmdu006,p_pmdu007)
   DEFINE p_pmdu001   LIKE pmdu_t.pmdu001    #料號編號
   DEFINE p_pmdu002   LIKE pmdu_t.pmdu002    #產品特徵   
   DEFINE p_pmdu009   LIKE pmdu_t.pmdu009    #單位
   DEFINE p_pmdu006   LIKE pmdu_t.pmdu006    #庫位
   DEFINE p_pmdu007   LIKE pmdu_t.pmdu007    #儲位
   DEFINE r_num       LIKE type_t.num20_6    #在驗量

   DEFINE l_sql       STRING
   DEFINE l_pmdu009   LIKE pmdu_t.pmdu009
   DEFINE l_num       LIKE type_t.num20_6
   DEFINE l_success   LIKE type_t.num5

#160503-00030#7-s mark
#   LET r_num = 0
#
#   #料號
#   IF cl_null(p_pmdu001) THEN
#      RETURN r_num
#   END IF
#
#   IF cl_null(p_pmdu002) THEN
#      LET p_pmdu002 = ' '
#   END IF
#
#   #收貨單位、收貨數量-已入庫量
#   LET l_sql = "SELECT pmdu009,",
#               "       SUM(COALESCE(pmdu010,0)) - SUM(COALESCE(pmdu014,0))",
#               "  FROM pmds_t,pmdu_t",
#               " WHERE pmdsent = pmduent AND pmduent = ",g_enterprise,
#               "   AND pmdssite = pmdusite AND pmdusite = '",g_site,"'",
#               "   AND pmdsdocno = pmdudocno",               
#               "   AND pmds000 = '1'",            #apmt520採購收貨單
#               "   AND pmdu001 = '",p_pmdu001,"'",
#               "   AND COALESCE(pmdu002,' ') = '",p_pmdu002,"'"
#
#   IF NOT cl_null(p_pmdu006) THEN  #有限定庫位
#      LET l_sql = l_sql," AND pmdu006 = '",p_pmdu006,"'"
#   END IF
#
#   IF NOT cl_null(p_pmdu007) THEN  #有限定儲位
#      LET l_sql = l_sql," AND pmdu007 = '",p_pmdu007,"'"
#   END IF
#
#   LET l_sql = l_sql," GROUP BY pmdu009"
#
#   PREPARE asfq005_check_pre FROM l_sql
#   DECLARE asfq005_check_cs CURSOR FOR asfq005_check_pre
#   
#   OPEN asfq005_check_cs
#   FOREACH asfq005_check_cs INTO l_pmdu009,l_num
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
#          
#         EXIT FOREACH
#      END IF
#   
#      #換算成發料單位
#      IF cl_null(l_pmdu009) OR cl_null(p_pmdu009) THEN
#         LET l_num = 0
#      ELSE
#         IF l_pmdu009 <> p_pmdu009 THEN
#            CALL s_aooi250_convert_qty(p_pmdu001,l_pmdu009,p_pmdu009,l_num) RETURNING l_success,l_num
#            IF NOT l_success THEN
#               LET l_num = 0
#            END IF
#         END IF
#      END IF
#   
#      LET r_num = r_num + l_num
#   
#   END FOREACH
#   
#   RETURN r_num
#160503-00030#7-e mark
   
END FUNCTION

################################################################################
# Descriptions...: 建立temp table
# Memo...........:
# Usage..........: CALL asfq005_create_tmep()
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 141006 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq005_create_tmep()
       
   CREATE TEMP TABLE asfq005_temp(
      docno          VARCHAR(20),
      seq            INTEGER,
      seq1           INTEGER,
      sfba006        VARCHAR(40),
      sfba006_desc   VARCHAR(500),         #160503-00030#7 add
      sfba006_desc1  VARCHAR(500),         #160503-00030#7 add
      sfba021        VARCHAR(256),
      sfba021_desc   VARCHAR(500),         #160503-00030#7 add
      sfba014        VARCHAR(10),
      sfba014_desc   VARCHAR(500),         #160503-00030#7 add
      sfba013        DECIMAL(20,6),
      sfba016        DECIMAL(20,6),
      notoffer       DECIMAL(20,6),
      sfba019        VARCHAR(10),
      sfba019_desc   VARCHAR(500),         #160503-00030#7 add
      sfba020        VARCHAR(10),
      sfba020_desc   VARCHAR(500),         #160503-00030#7 add
      inag008        DECIMAL(20,6),
      prepare        DECIMAL(20,6),
      inan010        DECIMAL(20,6),
      canuse         DECIMAL(20,6),
      expect         DECIMAL(20,6),
      need           DECIMAL(20,6),
      road           DECIMAL(20,6),
      make           DECIMAL(20,6),
      checknum       DECIMAL(20,6),
      buy            DECIMAL(20,6),
      byorder        DECIMAL(20,6),
      preuse         DECIMAL(20,6),
      balances       DECIMAL(20,6),
      complete       VARCHAR(10)
   )
   
END FUNCTION

################################################################################
# Descriptions...: 請購量
# Memo...........:
# Usage..........: CALL asfq005_buy_count(p_sfba006,p_sfba021,p_sfba014)
#                  RETURNING r_buy
# Input parameter: DEFINE p_sfba006     LIKE sfba_t.sfba006   #料件編號
#                : DEFINE p_sfba021     LIKE sfba_t.sfba021   #產品特徵
#                : DEFINE p_sfba014     LIKE sfba_t.sfba014   #單位
# Return code....: DEFINE r_buy         LIKE type_t.num20_6   #請購量
#                : 
# Date & Author..: 150116 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq005_buy_count(p_sfba006,p_sfba021,p_sfba014)
   DEFINE p_sfba006     LIKE sfba_t.sfba006   #料件編號
   DEFINE p_sfba021     LIKE sfba_t.sfba021   #產品特徵
   DEFINE p_sfba014     LIKE sfba_t.sfba014   #單位
   DEFINE r_buy         LIKE type_t.num20_6   #請購量

   DEFINE l_sql         STRING
   DEFINE l_buy         LIKE type_t.num20_6
   DEFINE l_pmdb007     LIKE pmdb_t.pmdb007
   DEFINE l_success     LIKE type_t.num5

#160503-00030#7-s mark
#   LET r_buy = 0
#   LET l_success = TRUE
#
#   #請購量 = 請購需求量 - 已轉採購量
#   LET l_sql = " SELECT SUM(COALESCE(pmdb006,0)-COALESCE(pmdb049,0)),pmdb007",
#               "   FROM pmda_t,pmdb_t",
#               "  WHERE pmdaent = pmdbent AND pmdaent = ",g_enterprise,
#               "    AND pmdasite = '",g_site,"'",
#               "    AND pmdadocno = pmdbdocno ",
#               "    AND COALESCE(pmdb006,0) <> COALESCE(pmdb049,0) ",
#               "    AND pmdb032 NOT IN ('2','3','4') ",
#               "    AND pmdastus <> 'X' AND pmdastus <> 'C'",
#               "    AND pmdb004 = '",p_sfba006,"'",
#               "    AND COALESCE(pmdb005,' ') = COALESCE('",p_sfba021,"',' ')",
#               "  GROUP BY pmdb007"
#
#   PREPARE asfq005_buy_pre FROM l_sql
#   DECLARE asfq005_buy_cur CURSOR FOR asfq005_buy_pre
# 
#   FOREACH asfq005_buy_cur INTO l_buy,l_pmdb007
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.extend = "FOREACH:asfq005_buy_cur"
#         LET g_errparam.code   = SQLCA.sqlcode
#         LET g_errparam.popup  = TRUE
#         CALL cl_err()
# 
#         LET l_success = FALSE
#         EXIT FOREACH
#      END IF
#
#      IF l_pmdb007 <> p_sfba014 THEN
#         CALL s_aooi250_convert_qty(p_sfba006,l_pmdb007,p_sfba014,l_buy) RETURNING l_success,l_buy
#      END IF
#
#      IF NOT l_success THEN
#         EXIT FOREACH
#      END IF
#      
#      LET r_buy = r_buy + l_buy
#   END FOREACH
#
#   IF NOT l_success THEN
#      LET r_buy = 0
#      RETURN r_buy
#   END IF
#
#   RETURN r_buy
#160503-00030#7-e mark

END FUNCTION

################################################################################
# Descriptions...: 受訂量
# Memo...........:
# Usage..........: CALL asfq005_byorder_count(p_sfba006,p_sfba021,p_sfba014)
#                  RETURNING r_byorder
# Input parameter: DEFINE p_sfba006     LIKE sfba_t.sfba006   #料件編號
#                : DEFINE p_sfba021     LIKE sfba_t.sfba021   #產品特徵
#                : DEFINE p_sfba014     LIKE sfba_t.sfba014   #單位
# Return code....: DEFINE r_byorder     LIKE type_t.num20_6   #受訂量
#                : 
# Date & Author..: 150116 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq005_byorder_count(p_sfba006,p_sfba021,p_sfba014)
   DEFINE p_sfba006     LIKE sfba_t.sfba006   #料件編號
   DEFINE p_sfba021     LIKE sfba_t.sfba021   #產品特徵
   DEFINE p_sfba014     LIKE sfba_t.sfba014   #單位
   DEFINE r_byorder     LIKE type_t.num20_6   #受訂量

   DEFINE l_sql         STRING
   DEFINE l_byorder     LIKE type_t.num20_6
   DEFINE l_xmdd004     LIKE xmdd_t.xmdd004
   DEFINE l_success     LIKE type_t.num5

#160503-00030#7-s mark
#   LET r_byorder = 0
#   LET l_success = TRUE
#
#   #受訂量 = 訂單量 - 已出貨量
#   LET l_sql = " SELECT SUM(COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd016,0)+COALESCE(xmdd034,0)),xmdd004",
#               "   FROM xmdd_t,xmda_t,xmdc_t ",
#               "  WHERE xmdaent = xmddent ",
#               "    AND xmdaent = xmdcent ",
#               "    AND xmdaent = ",g_enterprise,
#               "    AND xmdasite = xmddsite ",
#               "    AND xmdasite = xmdcsite ",
#               "    AND xmdasite = '",g_site,"'",
#               "    AND xmdadocno = xmdddocno ",
#               "    AND xmdadocno = xmdcdocno ",
#               "    AND xmddseq = xmdcseq ",
#               "    AND xmdc045 NOT IN ('2','3','4') ",
#               "    AND xmdastus = 'Y' ",
#               "    AND (COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd016,0)+COALESCE(xmdd034,0)) <> 0",
#               "    AND xmdd001 = '",p_sfba006,"'",
#               "    AND COALESCE(xmdd002,' ') = COALESCE('",p_sfba021,"',' ')",
#               "  GROUP BY xmdd004"
#
#   PREPARE asfq005_byorder_pre FROM l_sql
#   DECLARE asfq005_byorder_cur CURSOR FOR asfq005_byorder_pre
#
#    FOREACH asfq005_byorder_cur INTO l_byorder,l_xmdd004
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.extend = "FOREACH:asfq005_byorder_cur"
#         LET g_errparam.code   = SQLCA.sqlcode
#         LET g_errparam.popup  = TRUE
#         CALL cl_err()
# 
#         LET l_success = FALSE
#         EXIT FOREACH
#      END IF
#
#      IF l_xmdd004 <> p_sfba014 THEN
#         CALL s_aooi250_convert_qty(p_sfba006,l_xmdd004,p_sfba014,l_byorder) RETURNING l_success,l_byorder
#      END IF
#
#      IF NOT l_success THEN
#         EXIT FOREACH
#      END IF
#      
#      LET r_byorder = r_byorder + l_byorder
#   END FOREACH
#
#   IF NOT l_success THEN
#      LET r_byorder = 0
#      RETURN r_byorder
#   END IF
#
#   RETURN r_byorder
#160503-00030#7-e mark

END FUNCTION

 
{</section>}
 
