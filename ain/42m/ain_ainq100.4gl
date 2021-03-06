#該程式未解開Section, 採用最新樣板產出!
{<section id="ainq100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:33(2016-12-01 19:00:13), PR版次:0033(2017-01-03 10:06:28)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000161
#+ Filename...: ainq100
#+ Description: 料件庫存查詢作業
#+ Creator....: 01534(2014-07-30 10:00:45)
#+ Modifier...: 01534 -SD/PR- 07423
 
{</section>}
 
{<section id="ainq100.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160105-00006#1  2016/01/06 By ywtsai 工單在製量需扣除收貨數量
#160223-00021#1  2016/02/25 By lixh  20160225  參考數量根據參數(S-BAS-0028)設置顯示隱藏
#160510-00019#3  2016/05/26 By lixh  20160523  效能优化
#160523-00081#1  2016/06/01 By Ann_Huang  修正供需明細頁籤，2:受訂量，沒有對應的對象訊息
#160602-00022#1  2016/06/08 By lixh       inagsite =>inaisite
#160512-00004#2  2016/06/18 By dorislai   增加製造日期欄位(inad014)
#160512-00004#1  2016/06/20 By Whitney    inai012製造日期改抓inae010
#160512-00004#5  2016/06/28 By dorislai   隱藏製造日期(inad014、inae010)
#160704-00024#1  2016/07/05 By ywtsai     修正160510-00019#3於SQL寫錯字與產品特徵說明被mark的問題
#160815-00026#1  2016/08/22 By lixh       增加在捡量页签
#161024-00052#1  2016/10/24 By lixh       在抓取採購單資料時，stus判斷改為<>結案、作廢的都抓,寫要把未確認的單據也納入計算
#161101-00086#1  2016/11/03 By wuxja      库存备注栏位改抓inad012栏位
#161103-00001#1  2016/11/08 By wuxja      订单时b_fill的sql有误，少了FROM
#161006-00018#28 2016/11/17 By lixh       1.ainq100在揀量、備置量的部分都改成直接抓inan的資料呈現
#.........................................2.增加顯示備置明細
#161202-00014#1  2016/12/02 By lixh       数量为NULL，造成单位转换报错
#161212-00080#1  2016/12/21 By dujuan     按照料件查询时，供给明细当中的工单在制量数据查不出来。
#161202-00053#1  2016/12/28 By dujuan     ainq100 供需明细的日期显示为单据日期--->应该更改为供给或需求日期
#170101-00007#1  2016/01/03 By fionchen   調整歷史異動頁籤無顯示參考單位與參考數量問題
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
PRIVATE TYPE type_g_imaa_d RECORD
       
       sel LIKE type_t.chr1, 
   imaa001 LIKE imaa_t.imaa001, 
   imaa001_desc LIKE type_t.chr500, 
   imaa001_desc_desc LIKE type_t.chr500, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_desc LIKE type_t.chr500, 
   imaa006 LIKE imaa_t.imaa006, 
   imaa006_desc LIKE type_t.chr500, 
   imaf013 LIKE imaf_t.imaf013, 
   imaf051 LIKE imaf_t.imaf051, 
   imaf051_desc LIKE type_t.chr500, 
   imaf111 LIKE imaf_t.imaf111, 
   imaf111_desc LIKE type_t.chr500, 
   imaf141 LIKE imaf_t.imaf141, 
   imaf141_desc LIKE type_t.chr500, 
   imae011 LIKE imae_t.imae011, 
   imae011_desc LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_ac2                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE l_ac3                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE l_ac4                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE l_ac5                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE l_ac6                  LIKE type_t.num5
DEFINE l_ac7                  LIKE type_t.num5              #160815-00026#1
DEFINE g_detail_idx3          LIKE type_t.num5
DEFINE g_detail_idx4          LIKE type_t.num5
DEFINE g_detail_idx5          LIKE type_t.num5
DEFINE g_detail_idx6          LIKE type_t.num5
DEFINE g_detail_idx7          LIKE type_t.num5              #160815-00026#1
DEFINE g_detail_cnt2          LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_cnt3          LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_cnt4          LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_cnt5          LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_cnt6          LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_cnt7          LIKE type_t.num5              #單身 總筆數(所有資料)  #160815-00026#1
 TYPE type_g_imaa2_d RECORD
   date     LIKE inag_t.inag014,
   type     LIKE type_t.chr10,
   gj_num   LIKE inag_t.inag008, 
   xq_num   LIKE inag_t.inag008, 
   stock    LIKE inag_t.inag008, 
   ck_num   LIKE inag_t.inag008, 
   docno    LIKE inaj_t.inaj001, 
   seq      LIKE inaj_t.inaj002,
   object   LIKE inaj_t.inaj001,
   object_desc  LIKE type_t.chr500, 
   ck_docno LIKE inaj_t.inaj001,   
   ooag001  LIKE ooag_t.ooag001,
   ooag011  LIKE ooag_t.ooag011,
   ooeg001  LIKE ooeg_t.ooeg001,
   ooeg001_desc LIKE ooefl_t.ooefl003,
   prog     LIKE inaj_t.inaj035,
   sfaa010        LIKE sfaa_t.sfaa010,   #2015/09/03 by stellar add
   sfaa010_desc   LIKE type_t.chr500,    #2015/09/03 by stellar add
   sfaa010_desc1  LIKE type_t.chr500     #2015/09/03 by stellar add
       END RECORD
       
 TYPE type_g_imaa3_d RECORD
   type     LIKE type_t.chr10,
   gj_num   LIKE inag_t.inag008, 
   xq_num   LIKE inag_t.inag008, 
   stock    LIKE inag_t.inag008,
   ck_num   LIKE inag_t.inag008
       END RECORD       
       
 TYPE type_g_inag_d RECORD
   inagsite  LIKE inag_t.inagsite,
   inag004 LIKE inag_t.inag004, 
   inag004_desc LIKE type_t.chr500, 
   inag005 LIKE inag_t.inag005, 
   inag005_desc LIKE type_t.chr500, 
   inag006 LIKE inag_t.inag006, 
   inag002 LIKE inag_t.inag002, 
   inag002_desc LIKE type_t.chr500, 
   inag003 LIKE inag_t.inag003, 
   inag007 LIKE inag_t.inag007, 
   inag007_desc LIKE type_t.chr500, 
   inag008 LIKE inag_t.inag008, 
   inag033 LIKE inag_t.inag033,
   inan010 LIKE inan_t.inan010,
   inag021 LIKE inag_t.inag021,
   inag024 LIKE inag_t.inag024,
   inag024_desc LIKE type_t.chr500, 
   inag025 LIKE inag_t.inag025,
   inag010 LIKE inag_t.inag010,
   inag011 LIKE inag_t.inag011,
   inag012 LIKE inag_t.inag012,
   inaa015 LIKE inaa_t.inaa015,
   inad014 LIKE inad_t.inad014, #160512-00004#2-add
   inag018 LIKE inag_t.inag018,
   inag022 LIKE inag_t.inag022
       END RECORD
 
 TYPE type_g_inaj_d RECORD
   inaj022 LIKE inaj_t.inaj022, 
   inaj024 LIKE inaj_t.inaj024, 
   inaj015 LIKE inaj_t.inaj015, 
   inaj035 LIKE inaj_t.inaj035,
   inaj035_desc LIKE type_t.chr500,
   inaj011 LIKE inaj_t.inaj011, 
   inaj012 LIKE inaj_t.inaj012, 
   inaj012_desc LIKE type_t.chr500,
   inaj001 LIKE inaj_t.inaj001, 
   inaj002 LIKE inaj_t.inaj002,
   inaj006 LIKE inaj_t.inaj006,
   inaj006_desc LIKE type_t.chr500,
   inaj007 LIKE inaj_t.inaj007,
   inaj008 LIKE inaj_t.inaj008,
   inaj008_desc LIKE type_t.chr500,
   inaj009 LIKE inaj_t.inaj009,
   inaj009_desc LIKE type_t.chr500,
   inaj010 LIKE inaj_t.inaj010,    
   inaj026 LIKE inaj_t.inaj026,
   inaj026_desc LIKE type_t.chr500,
   inaj027 LIKE inaj_t.inaj027,   
   inaj044 LIKE inaj_t.inaj044,
   inaj018 LIKE inaj_t.inaj018,
   inaj018_desc LIKE type_t.chr500, 
   inaj025 LIKE inaj_t.inaj025, 
   inaj025_desc LIKE type_t.chr500, 
   inaj017 LIKE inaj_t.inaj017, 
   inaj017_desc LIKE type_t.chr500     
       END RECORD
 
 TYPE type_g_inai_d RECORD
   inai004 LIKE inai_t.inai004, 
   inai004_desc LIKE type_t.chr500, 
   inai005 LIKE inai_t.inai005, 
   inai005_desc LIKE type_t.chr500,
   inai006 LIKE inai_t.inai006, 
   inai002 LIKE inai_t.inai002,
   inai002_desc LIKE type_t.chr500,   
   inai003 LIKE inai_t.inai003, 
   inai007 LIKE inai_t.inai007, 
   inai008 LIKE inai_t.inai008, 
   inai009 LIKE inai_t.inai009, 
   inai009_desc LIKE type_t.chr500,
   inai011 LIKE inai_t.inai011, 
  #inai012 LIKE inai_t.inai012  #160512-00004#1 by whitney mark
   inae010 LIKE inae_t.inae010  #160512-00004#1 by whitney add
       END RECORD
#160815-00026#1-s
PRIVATE TYPE type_g_inap_d RECORD
       inapsite LIKE type_t.chr500, 
   inap004 LIKE type_t.chr500, 
   inap004_desc LIKE type_t.chr500, 
   inap004_desc_1 LIKE type_t.chr500, 
   inap005 LIKE type_t.chr500, 
   inap005_desc LIKE type_t.chr500, 
   inap006 LIKE type_t.chr30, 
   inap007 LIKE type_t.chr10, 
   inap007_desc LIKE type_t.chr500, 
   inap008 LIKE type_t.chr10, 
   inap008_desc LIKE type_t.chr500, 
   inap009 LIKE type_t.chr30, 
   inap014 LIKE type_t.chr10, 
   inap001 LIKE type_t.chr500, 
   inap002 LIKE type_t.chr500, 
   inap003 LIKE type_t.chr500, 
   xmdrseq2 LIKE xmdr_t.xmdrseq2,
   inap016 LIKE type_t.dat, 
   inap013 LIKE type_t.num20_6, 
   inap017 LIKE type_t.chr20, 
   inap017_desc LIKE type_t.chr500, 
   inap018 LIKE type_t.chr10, 
   inap018_desc LIKE type_t.chr500
       END RECORD
DEFINE g_inap_d            DYNAMIC ARRAY OF type_g_inap_d  
#160815-00026#1-e
DEFINE g_inag_d            DYNAMIC ARRAY OF type_g_inag_d
DEFINE g_inag_d_t          type_g_inag_d
DEFINE g_inai_d            DYNAMIC ARRAY OF type_g_inai_d
DEFINE g_inai_d_t          type_g_inai_d
DEFINE g_inaj_d            DYNAMIC ARRAY OF type_g_inaj_d
DEFINE g_inaj_d_t          type_g_inaj_d
DEFINE g_imaa2_d           DYNAMIC ARRAY OF type_g_imaa2_d
DEFINE g_imaa2_d_t         type_g_imaa2_d
DEFINE g_imaa3_d           DYNAMIC ARRAY OF type_g_imaa3_d
DEFINE g_imaa3_d_t         type_g_imaa3_d
DEFINE g_gxdate            LIKE type_t.chr1
DEFINE g_lsdate            LIKE type_t.chr1
DEFINE g_invent            LIKE type_t.chr1
DEFINE g_sum1              LIKE inag_t.inag008
DEFINE g_sum2              LIKE inag_t.inag008
DEFINE g_sum3              LIKE inag_t.inag008
DEFINE g_bdate             LIKE inag_t.inag014
DEFINE g_qbehidden         LIKE type_t.num5
DEFINE g_wc1               STRING
DEFINE g_wc3               STRING
DEFINE g_wc4               STRING
DEFINE g_wc5               STRING
DEFINE g_wc6               STRING
DEFINE g_wc7               STRING    #2015/09/03 by stellar add
DEFINE g_qbe_type          LIKE type_t.chr1
DEFINE g_gj_sum            LIKE inag_t.inag009
DEFINE g_xq_sum            LIKE inag_t.inag009
DEFINE g_sql1              STRING
DEFINE g_sql2              STRING
GLOBALS
   DEFINE  p_bmba003    LIKE bmba_t.bmba003
END GLOBALS
DEFINE g_date    DATETIME YEAR TO SECOND
#end add-point
 
#模組變數(Module Variables)
DEFINE g_imaa_d            DYNAMIC ARRAY OF type_g_imaa_d
DEFINE g_imaa_d_t          type_g_imaa_d
 
 
 
 
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
 
{<section id="ainq100.main" >}
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
   CALL cl_ap_init("ain","")
 
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
   DECLARE ainq100_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE ainq100_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ainq100_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainq100 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ainq100_init()   
 
      #進入選單 Menu (="N")
      CALL ainq100_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
#      CALL ainq100_query()
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ainq100
      
   END IF 
   
   CLOSE ainq100_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="ainq100.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION ainq100_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_today   LIKE inag_t.inag014
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_imaf013','2022') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('type','1020')
   CALL cl_set_combo_scc('types','1020')
   CALL cl_set_combo_scc('invent','1021')
   CALL cl_set_combo_scc_part('lsdate','1021','1,2,3,4,5')
#   CALL cl_set_combo_scc_part('gxdate','1021','1,2,3,4,5')  
   CALL cl_set_combo_scc('imaf013','2022') 
   CALL cl_set_combo_scc('inaj015','24')   
   CALL cl_set_combo_scc('qbe_type','2215')
   LET g_qbe_type = '1'
   LET g_gxdate = '5'
   LET g_invent = '6'
   LET g_lsdate = '1'
   DISPLAY g_qbe_type TO qbe_type
#   DISPLAY g_gxdate TO gxdate
   DISPLAY g_invent TO invent
   DISPLAY g_lsdate TO lsdate   
   LET l_today = g_today -30
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN  
      CALL cl_set_comp_visible("inag002,inag002_desc",FALSE) 
   END IF  
   IF g_qbe_type = '1' THEN
      CALL cl_set_comp_visible("group_6",TRUE)
      CALL cl_set_comp_visible("group_7,group_8,group_9,group_10",FALSE) 
      CALL cl_set_comp_visible("group_11",FALSE)   #2015/09/03 by stellar add
   END IF
   #若不使用參考單位，將參考數量隱藏
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN
      CALL cl_set_comp_visible("ck_nums,ck_num,inag024,inag024_desc,inag025,inaj026,inaj026_desc,inaj027",FALSE)   #160223-00021#1 add by lixh 20160225
   END IF 
   LET g_date = cl_get_current()
   #end add-point
 
   CALL ainq100_default_search()
END FUNCTION
 
{</section>}
 
{<section id="ainq100.default_search" >}
PRIVATE FUNCTION ainq100_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " imaa001 = '", g_argv[01], "' AND "
   END IF
 
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   IF NOT cl_null(g_argv[01]) THEN
      LET g_qbe_type = g_argv[01]
   END IF
#依料号查询
   LET g_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " imaa001 = '", g_argv[02], "' AND "
   END IF

   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
#依工单查询
   LET g_wc1 = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc1 = g_wc1, " sfaadocno = '", g_argv[02], "' AND "
   END IF

   IF NOT cl_null(g_wc1) THEN
      LET g_wc1 = g_wc1.subString(1,g_wc1.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc1 = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc1) THEN
         LET g_wc1 = " 1=2"
      END IF
   END IF 

#依订单查询
   LET g_wc3 = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc3 = g_wc3, " xmdcdocno = '", g_argv[02], "' AND "
   END IF

   IF NOT cl_null(g_wc3) THEN
      LET g_wc3 = g_wc3.subString(1,g_wc3.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc3 = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc3) THEN
         LET g_wc3 = " 1=2"
      END IF
   END IF
   
#依料号查询
   LET g_wc4 = ''
   IF NOT cl_null(g_argv[02]) THEN
#      LET g_wc4 = g_wc4, " bmba001 = '", g_argv[02], "' AND "
      LET g_wc4 = g_wc4, " bmaa001 = '", g_argv[02], "' AND "   #add by lixh 20150108
   END IF

   IF NOT cl_null(g_wc4) THEN
      LET g_wc4 = g_wc4.subString(1,g_wc4.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc4 = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc4) THEN
         LET g_wc4 = " 1=2"
      END IF
   END IF  
   
   #2015/09/03 by stellar add ----- (S)
   #依出貨單查詢
   LET g_wc7 = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc7 = g_wc7," xmdkdocno = '",g_argv[02],"' AND " 
   END IF
   
   IF NOT cl_null(g_wc7) THEN
      LET g_wc7 = g_wc7.subString(1,g_wc7.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc7 = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc7) THEN
         LET g_wc7 = " 1=2"
      END IF
   END IF
   
   CALL ainq100_qbe_visible()
   #2015/09/03 by stellar add ----- (E)
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainq100.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainq100_ui_dialog() 
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
   DEFINE l_yy      LIKE type_t.num5
   DEFINE l_mm      LIKE type_t.num5   
   
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
#   CALL ainq100_construct()
   LET g_qbehidden = 0
   #end add-point
 
   
   CALL ainq100_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_imaa_d.clear()
 
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
 
         CALL ainq100_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"

         INPUT g_qbe_type,g_invent,g_lsdate FROM qbe_type,invent,lsdate
               ATTRIBUTE(WITHOUT DEFAULTS)         
            BEFORE INPUT
               IF cl_null(g_qbe_type) THEN LET g_qbe_type = '1' END IF
#               IF cl_null(g_gxdate) THEN LET g_gxdate = '5' END IF
               IF cl_null(g_invent) THEN LET g_invent = '6' END IF
               IF cl_null(g_lsdate) THEN LET g_lsdate = '1' END IF                

#               DISPLAY g_sum1 TO sum1
#               DISPLAY g_sum2 TO sum2
#               DISPLAY g_sum3 TO sum3  
             
            ON CHANGE qbe_type
               IF g_qbe_type = '1' THEN
                  CALL cl_set_comp_visible("group_6",TRUE)
                  CALL cl_set_comp_visible("group_7,group_8,group_9,group_10",FALSE)  
                  CALL cl_set_comp_visible("group_11",FALSE)   #2015/09/03 by stellar add
               END IF             
               IF g_qbe_type = '2' THEN
                  CALL cl_set_comp_visible("group_7",TRUE)
                  CALL cl_set_comp_visible("group_6,group_8,group_9,group_10",FALSE) 
                  CALL cl_set_comp_visible("group_11",FALSE)   #2015/09/03 by stellar add
               END IF 
               IF g_qbe_type = '3' THEN
                  CALL cl_set_comp_visible("group_8",TRUE)
                  CALL cl_set_comp_visible("group_6,group_7,group_9,group_10",FALSE) 
                  CALL cl_set_comp_visible("group_11",FALSE)   #2015/09/03 by stellar add
               END IF 
               IF g_qbe_type = '4' THEN
                  CALL cl_set_comp_visible("group_9",TRUE)
                  CALL cl_set_comp_visible("group_6,group_7,group_8,group_10",FALSE) 
                  CALL cl_set_comp_visible("group_11",FALSE)   #2015/09/03 by stellar add
               END IF        
               IF g_qbe_type = '5' THEN
                  CALL cl_set_comp_visible("group_10",TRUE)
                  CALL cl_set_comp_visible("group_6,group_7,group_8,group_9",FALSE) 
                  CALL cl_set_comp_visible("group_11",FALSE)   #2015/09/03 by stellar add
               END IF        
               #2015/09/03 by stellar add ----- (S)
               IF g_qbe_type = '6' THEN
                  CALL cl_set_comp_visible("group_11",TRUE)
                  CALL cl_set_comp_visible("group_6,group_7,group_8,group_9,group_10",FALSE)
               END IF
               #2015/09/03 by stellar add ----- (E)
               IF g_qbe_type <> '2' THEN   #add by lixh 20150906
                  CALL ainq100_b_fill()
               END IF                      #add by lixh 20150906
               CALL ui.interface.refresh()
               
#            ON CHANGE gxdate
#               CALL ainq100_b_fill2()
#               CALL ui.interface.refresh()
            AFTER INPUT
#               IF g_qbe_type = '4' AND (cl_null(g_wc4) OR  g_wc4 = " 1=1") THEN
#                  NEXT FIELD bmaa001
#               END IF  
               
            ON CHANGE invent
               CALL ainq100_b_fill3()
               CALL ui.interface.refresh()  

            ON CHANGE lsdate
               CALL ainq100_b_fill4()
               CALL ui.interface.refresh() 
               
         END INPUT
       
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON imaa001,imaa009,imaa006,imaf013,imaf051,imaf111,imaf141,imae011
                      
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD imaa001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaf001_15()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa001  #顯示到畫面上
         
               NEXT FIELD imaa001
               
            ON ACTION controlp INFIELD imaa009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
         
               NEXT FIELD imaa009
               
            ON ACTION controlp INFIELD imaa006
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooca001_1()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa006   #顯示到畫面上
         
               NEXT FIELD imaa006
                           
            ON ACTION controlp INFIELD imaf051
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imcc051()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaf051   #顯示到畫面上
         
               NEXT FIELD imaf051 
             
            ON ACTION controlp INFIELD imaf111
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imcd111()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaf111   #顯示到畫面上
         
               NEXT FIELD imaf111             
               
            ON ACTION controlp INFIELD imaf141
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '203'
               CALL q_oocq002()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaf141   #顯示到畫面上
         
               NEXT FIELD imaf141  
               
            ON ACTION controlp INFIELD imae011
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imcf011()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO imae011   #顯示到畫面上
         
               NEXT FIELD imae011               
               
         END CONSTRUCT
         
         CONSTRUCT BY NAME g_wc1 ON sfaadocno,sfaadocdt,sfaa002
                      
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD sfaadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_sfaadocno_8()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaadocno        #顯示到畫面上
         
               NEXT FIELD sfaadocno
               
            ON ACTION controlp INFIELD sfaa002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa002          #顯示到畫面上
         
               NEXT FIELD sfaa002              
               
         END CONSTRUCT     

         CONSTRUCT BY NAME g_wc3 ON xmdadocno,xmdadocdt,xmda002
                      
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD xmdadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_xmdadocno()                             #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdadocno        #顯示到畫面上
         
               NEXT FIELD xmdadocno
               
            ON ACTION controlp INFIELD xmda002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmda002      #顯示到畫面上
         
               NEXT FIELD xmda002              
               
         END CONSTRUCT    
         
         CONSTRUCT BY NAME g_wc4 ON bmaa001
                      
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD bmaa001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_bmaa001_4()                             #呼叫開窗
               DISPLAY g_qryparam.return1 TO bmaa001          #顯示到畫面上
         
               NEXT FIELD bmaa001      
               
               
            AFTER CONSTRUCT
#                IF cl_null(g_wc4) OR  g_wc4 = " 1=1" THEN
#                   NEXT FIELD bmaa001
#                END IF
                
         END CONSTRUCT   
         
         CONSTRUCT BY NAME g_wc6 ON bmba003
                      
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD bmba003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001_5()                             #呼叫開窗
               DISPLAY g_qryparam.return1 TO bmba003          #顯示到畫面上
         
               NEXT FIELD bmba003    
               
         END CONSTRUCT   

         #2015/09/03 by stellar add ----- (S)
         CONSTRUCT BY NAME g_wc7 ON xmdkdocno,xmdkdocdt
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD xmdkdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_xmdkdocno()
               DISPLAY g_qryparam.return1 TO xmdkdocno
               NEXT FIELD xmdkdocno
               
         END CONSTRUCT
         #2015/09/03 by stellar add ----- (E)
         #end add-point
     
         DISPLAY ARRAY g_imaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL ainq100_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL ainq100_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
             
               CALL ainq100_b_fill3()
               CALL ainq100_b_fill5()
               CALL ainq100_b_fill7()  #160815-00026#1
#               DISPLAY g_sum1 TO sum1
#               DISPLAY g_sum2 TO sum2
#               DISPLAY g_sum3 TO sum3 
                       
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_imaa2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2)
 
            BEFORE DISPLAY
               LET g_current_page = 1
#               DISPLAY g_sum1 TO sum1
#               DISPLAY g_sum2 TO sum2
#               DISPLAY g_sum3 TO sum3     
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac2 = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_imaa2_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac2
               
            ON ACTION modify_detail
               LET g_action_choice="modify_detail"
               IF cl_auth_chk_act("query") THEN
                  LET la_param.prog = g_imaa2_d[l_ac2].prog
                  LET la_param.param[1] = g_imaa2_d[l_ac2].docno
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
                  EXIT DIALOG
               END IF             
   
               
         END DISPLAY
         
         DISPLAY ARRAY g_imaa3_d TO s_detail6.* ATTRIBUTE(COUNT=g_detail_cnt6)
 
            BEFORE DISPLAY
               LET g_current_page = 1  
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail6")
               LET l_ac6 = g_detail_idx6
               DISPLAY g_detail_idx6 TO FORMONLY.h_index
               DISPLAY g_imaa3_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac6
                                        
         END DISPLAY         
         
         DISPLAY ARRAY g_inag_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt3)
 
            BEFORE DISPLAY
               LET g_current_page = 1 
#               DISPLAY g_sum1 TO sum1
#               DISPLAY g_sum2 TO sum2
#               DISPLAY g_sum3 TO sum3                
            BEFORE ROW
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac3 = g_detail_idx3
               DISPLAY g_detail_idx3 TO FORMONLY.h_index
               DISPLAY g_inag_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac3
               CALL ainq100_b_fill4()
               CALL ainq100_b_fill5()
               CALL ainq100_b_fill7()  #160815-00026#1
#               DISPLAY g_sum1 TO sum1
#               DISPLAY g_sum2 TO sum2
#               DISPLAY g_sum3 TO sum3                 
         END DISPLAY   

         DISPLAY ARRAY g_inaj_d TO s_detail4.* ATTRIBUTE(COUNT=g_detail_cnt4)
 
            BEFORE DISPLAY
               LET g_current_page = 1
#               DISPLAY g_sum1 TO sum1
#               DISPLAY g_sum2 TO sum2
#               DISPLAY g_sum3 TO sum3     
            BEFORE ROW
               LET g_detail_idx4 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac4 = g_detail_idx4
               DISPLAY g_detail_idx4 TO FORMONLY.h_index
               DISPLAY g_inaj_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac4
               
            ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("query") THEN
               LET la_param.prog = g_inaj_d[l_ac4].inaj035
               LET la_param.param[1] = g_inaj_d[l_ac4].inaj001
               LET ls_js = util.JSON.stringify( la_param )
               CALL cl_cmdrun(ls_js)
               EXIT DIALOG
            END IF                  
         END DISPLAY  
         
         DISPLAY ARRAY g_inai_d TO s_detail5.* ATTRIBUTE(COUNT=g_detail_cnt5)
 
            BEFORE DISPLAY
               LET g_current_page = 1
#               DISPLAY g_sum1 TO sum1
#               DISPLAY g_sum2 TO sum2
#               DISPLAY g_sum3 TO sum3     
            BEFORE ROW
               LET g_detail_idx5 = DIALOG.getCurrentRow("s_detail5")
               LET l_ac5 = g_detail_idx5
               DISPLAY g_detail_idx5 TO FORMONLY.h_index
               DISPLAY g_inai_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac5
#               DISPLAY g_sum1 TO sum1
#               DISPLAY g_sum2 TO sum2
#               DISPLAY g_sum3 TO sum3                  
         END DISPLAY  

         DISPLAY ARRAY g_inap_d TO s_detail7.* ATTRIBUTE(COUNT=g_detail_cnt7)
 
            BEFORE DISPLAY
               LET g_current_page = 1   
            BEFORE ROW
               LET g_detail_idx7 = DIALOG.getCurrentRow("s_detail7")
               LET l_ac7 = g_detail_idx7
               DISPLAY g_detail_idx7 TO FORMONLY.h_index
               DISPLAY g_inap_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac7                  
         END DISPLAY 
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL ainq100_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_combo_scc('imaf013','2022') 
#            DISPLAY g_sum1 TO sum1
#            DISPLAY g_sum2 TO sum2
#            DISPLAY g_sum3 TO sum3
            CALL cl_set_act_visible("insert", FALSE)
            NEXT FIELD imaa001
            
            #end add-point
            NEXT FIELD qbe_type
 
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
            CALL ainq100_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_imaa_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"

               LET g_export_node[2] = base.typeInfo.create(g_imaa2_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_imaa3_d)
               LET g_export_id[3]   = "s_detail6"
               LET g_export_node[4] = base.typeInfo.create(g_inag_d)
               LET g_export_id[4]   = "s_detail3"
               LET g_export_node[5] = base.typeInfo.create(g_inaj_d)
               LET g_export_id[5]   = "s_detail4"
               LET g_export_node[6] = base.typeInfo.create(g_inai_d)
               LET g_export_id[6]   = "s_detail5"               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL ainq100_b_fill()
 
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
            CALL ainq100_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL ainq100_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL ainq100_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL ainq100_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_imaa_d.getLength()
               LET g_imaa_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_imaa_d.getLength()
               LET g_imaa_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_imaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_imaa_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_imaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_imaa_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL ainq100_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION bin_query
            LET g_action_choice="bin_query"
            IF cl_auth_chk_act("bin_query") THEN
               
               #add-point:ON ACTION bin_query name="menu.bin_query"
               IF l_ac <> 0 AND NOT cl_null(l_ac) THEN
                  LET l_yy = YEAR(g_today)
                  LET l_mm = MONTH(g_today)
#                  IF l_mm = 1 THEN
#                     LET l_mm = 12
#                     LET l_yy = l_yy - 1
#                  ELSE
#                     LET l_mm = l_mm - 1
#                  END IF                  
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = 'ainq210'
                  LET la_param.param[1] = g_imaa_d[l_ac].imaa001
                  LET la_param.param[2] = ' '
                  LET la_param.param[3] = ' '
                  LET la_param.param[4] = ' '
                  LET la_param.param[5] = ' '
                  LET la_param.param[6] = ' '
                  LET la_param.param[7] = l_yy
                  LET la_param.param[8] = l_mm
                  LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
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
               CALL ainq100_query()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION replace_query
            LET g_action_choice="replace_query"
            IF cl_auth_chk_act("replace_query") THEN
               
               #add-point:ON ACTION replace_query name="menu.replace_query"
               #使用JSON格式組合參數與作業編號(串查)
               IF l_ac <> 0 AND NOT cl_null(l_ac) THEN
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = 'abmm217'
                  LET la_param.param[1] = g_site
                  LET la_param.param[2] = ' '
                  LET la_param.param[3] = ' '
                  LET la_param.param[4] = g_imaa_d[l_ac].imaa001
                  LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION bom_query
            LET g_action_choice="bom_query"
            IF cl_auth_chk_act("bom_query") THEN
               
               #add-point:ON ACTION bom_query name="menu.bom_query"
               LET p_bmba003 = g_imaa_d[l_ac].imaa001
               CALL ainq100_01(p_bmba003)
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
#         ON ACTION qbehidden
#            IF g_qbehidden = 1 THEN
#               LET g_qbehidden = 0 
#            ELSE
#               LET g_qbehidden = 1 
#            END IF     
#            IF g_qbehidden = 1 THEN
#               CALL cl_set_comp_visible("page_queryplan,page_qbe ", FALSE) 
#            ELSE
#               CALL cl_set_comp_visible("page_queryplan,page_qbe ", TRUE)             
#            END IF               
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="ainq100.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ainq100_b_fill()
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
 
   CALL g_imaa_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   IF cl_null(g_wc1) THEN
      LET g_wc1 = " 1=1"
   END IF 
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF    
   IF cl_null(g_wc4) THEN
      LET g_wc4 = " 1=1"
   END IF    
   IF cl_null(g_wc6) THEN
      LET g_wc6 = " 1=1"
   END IF      
   #2015/09/03 by stellar add ----- (S)
   IF cl_null(g_wc7) THEN
      LET g_wc7 = " 1=1"
   END IF
   #2015/09/03 by stellar add ----- (E)
   CALL g_inag_d.clear()
   CALL g_imaa2_d.clear()
   CALL g_inai_d.clear()
   CALL g_inaj_d.clear()
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',imaa001,'','',imaa009,'',imaa006,'','','','','','','','','', 
       ''  ,DENSE_RANK() OVER( ORDER BY imaa_t.imaa001) AS RANK FROM imaa_t",
 
 
                     "",
                     " WHERE imaaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("imaa_t"),
                     " ORDER BY imaa_t.imaa001"
 
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
 
   LET g_sql = "SELECT '',imaa001,'','',imaa009,'',imaa006,'','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   IF g_qbe_type = '1' THEN
#      LET g_sql = "SELECT  UNIQUE 'N',imaa001,'','',imaa009,'',imaa006,'',imaf013,imaf051,'',imaf111,'',imaf141,'',imae011,'' FROM imaa_t,imaf_t,imae_t ",
#    
#    
#                  "",
#                  " WHERE imaaent = imafent AND imaa001 = imaf001 AND imaeent = imafent AND imaesite = imafsite AND imaf001 = imae001 ",
#                  "   AND imafsite = '",g_site,"'",
#                  "   AND imaaent= ? AND 1=1 AND ", ls_wc

      #160510-00019#3-s
      LET g_sql = " SELECT  UNIQUE '',imaa001,",
                  "         (SELECT imaal003 FROM imaal_t WHERE imaalent = imafent AND imaal001 = imaf001 AND imaal002 = '",g_lang,"')  imaa001_desc, ",
                  "         (SELECT imaal004 FROM imaal_t WHERE imaalent = imafent AND imaal001 = imaf001 AND imaal002 = '",g_lang,"')  imaa001_desc_desc, ",
                  "          imaa009,",
                  "         (SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=imaa009 AND rtaxl002='"||g_dlang||"') imaa009_desc, ",
                  "         imaa006,",
                  "         (SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=imaa006 AND oocal002='"||g_dlang||"') imaa006_desc, ",
                  "         imaf013,imaf051, ",
                  "         (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '201' AND oocql002 = imaf051 AND oocql003 = '"||g_dlang||"') imaf051_desc,",
                  "         imaf111,",
                  "         (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '202' AND oocql002 = imaf111 AND oocql003 = '"||g_dlang||"') imaf111_desc,", 
                  "         imaf141,",
                  "         (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '203' AND oocql002 = imaf141 AND oocql003 = '"||g_dlang||"') imaf141_desc,",   
                  "         imae011,",
                  "         (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '204' AND oocql002 = imae011 AND oocql003 = '"||g_dlang||"') imae011_desc",  
                  "   FROM imaa_t,imaf_t,imae_t ",
                  " WHERE imaaent = imafent AND imaa001 = imaf001 AND imaeent = imafent AND imaesite = imafsite AND imaf001 = imae001 ",
                  "   AND imafsite = '",g_site,"'",
                  "   AND imaaent= ? AND 1=1 AND ", ls_wc                  
      #160510-00019#3-e           
      LET g_sql = g_sql, cl_sql_add_filter("imaa_t"),
                         " ORDER BY imaa_t.imaa001"
   END IF 
   
   IF g_qbe_type = '2' THEN    #工單

      LET g_sql1 = " SELECT UNIQUE 'N',sfaa010,t1.imaal003,t1.imaal004,imaa009,t2.rtaxl003,imaa006,t3.oocal003,imaf013,imaf051,t4.oocql004,imaf111,t5.oocql004,imaf141,t6.oocql004,imae011,t7.oocql004 FROM sfaa_t ",
                   "   LEFT OUTER JOIN imaa_t ON sfaaent = imaaent AND sfaa010 = imaa001 ",
                   "   LEFT OUTER JOIN imaf_t ON sfaaent = imafent AND sfaa010 = imaf001 AND sfaasite = imafsite ",
                   "   LEFT OUTER JOIN imae_t ON sfaaent = imaeent AND sfaa010 = imae001 AND sfaasite = imaesite ",
                   "   LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=sfaa010 AND t1.imaal002='"||g_dlang||"' ",
                   "   LEFT JOIN rtaxl_t t2 ON t2.rtaxlent='"||g_enterprise||"' AND t2.rtaxl001=imaa009 AND t2.rtaxl002='"||g_dlang||"'",
                   "   LEFT JOIN oocal_t t3 ON t3.oocalent='"||g_enterprise||"' AND t3.oocal001=imaa006 AND t3.oocal002='"||g_dlang||"'",
                   "   LEFT JOIN oocql_t t4 ON t4.oocqlent='"||g_enterprise||"' AND t4.oocql001='201' AND t4.oocql002=imaf051 AND t4.oocql003='"||g_dlang||"'",
                   "   LEFT JOIN oocql_t t5 ON t5.oocqlent='"||g_enterprise||"' AND t5.oocql001='202' AND t5.oocql002=imaf111 AND t5.oocql003='"||g_dlang||"'",
                   "   LEFT JOIN oocql_t t6 ON t4.oocqlent='"||g_enterprise||"' AND t6.oocql001='203' AND t6.oocql002=imaf141 AND t6.oocql003='"||g_dlang||"'",
                   "   LEFT JOIN oocql_t t7 ON t7.oocqlent='"||g_enterprise||"' AND t7.oocql001='204' AND t7.oocql002=imae011 AND t7.oocql003='"||g_dlang||"'",                  
                   "  WHERE sfaasite = '",g_site,"'",
                   "    AND sfaaent= ? AND 1=1 AND ", g_wc1
      LET g_wc5 =  cl_replace_str(g_wc1,'sfaadocno','sfbadocno')
      LET g_sql2 = " SELECT UNIQUE 'N',sfba006,t1.imaal003,t1.imaal004,imaa009,t2.rtaxl003,imaa006,t3.oocal003,imaf013,imaf051,t4.oocql004,imaf111,t5.oocql004,imaf141,t6.oocql004,imae011,t7.oocql004 FROM sfba_t ",
                   "   LEFT OUTER JOIN imaa_t ON sfbaent = imaaent AND sfba006 = imaa001 ",
                   "   LEFT OUTER JOIN imaf_t ON sfbaent = imafent AND sfba006 = imaf001 AND sfbasite = imafsite ",
                   "   LEFT OUTER JOIN imae_t ON sfbaent = imaeent AND sfba006 = imae001 AND sfbasite = imaesite ",
                   "   LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=sfba006 AND t1.imaal002='"||g_dlang||"' ",
                   "   LEFT JOIN rtaxl_t t2 ON t2.rtaxlent='"||g_enterprise||"' AND t2.rtaxl001=imaa009 AND t2.rtaxl002='"||g_dlang||"'",
                   "   LEFT JOIN oocal_t t3 ON t3.oocalent='"||g_enterprise||"' AND t3.oocal001=imaa006 AND t3.oocal002='"||g_dlang||"'",
                   "   LEFT JOIN oocql_t t4 ON t4.oocqlent='"||g_enterprise||"' AND t4.oocql001='201' AND t4.oocql002=imaf051 AND t4.oocql003='"||g_dlang||"'",
                   "   LEFT JOIN oocql_t t5 ON t5.oocqlent='"||g_enterprise||"' AND t5.oocql001='202' AND t5.oocql002=imaf111 AND t5.oocql003='"||g_dlang||"'",
                   "   LEFT JOIN oocql_t t6 ON t4.oocqlent='"||g_enterprise||"' AND t6.oocql001='203' AND t6.oocql002=imaf141 AND t6.oocql003='"||g_dlang||"'",
                   "   LEFT JOIN oocql_t t7 ON t7.oocqlent='"||g_enterprise||"' AND t7.oocql001='204' AND t7.oocql002=imae011 AND t7.oocql003='"||g_dlang||"'",                     
                   "  WHERE sfbasite = '",g_site,"'",
                   "    AND sfbaent= ",g_enterprise," AND 1=1 AND ", g_wc5
                                     
      LET g_sql = g_sql1," UNION ",g_sql2
       
      LET g_sql = g_sql, cl_sql_add_filter("sfaa_t"),
                         " ORDER BY sfaa010"       
   END IF
   IF g_qbe_type = '3' THEN    #訂單
#      LET g_sql = " SELECT UNIQUE '',xmdc001,'','',imaa009,'',imaa006,'',imaf013,imaf051,'',imaf111,'',imaf141,'',imae011,'' FROM xmdc_t ",
#                  "   LEFT OUTER JOIN imaa_t ON xmdcent = imaaent AND xmdc001 = imaa001 ",
#                  "   LEFT OUTER JOIN imaf_t ON xmdcent = imafent AND xmdc001 = imaf001 AND xmdcsite = imafsite ",
#                  "   LEFT OUTER JOIN imae_t ON xmdcent = imaeent AND xmdc001 = imae001 AND xmdcsite = imaesite ",
#                  "  WHERE imafsite = '",g_site,"'",
#                  "    AND xmdcent= ? AND 1=1 AND ", g_wc3
      #160510-00019#3-s
      #LET g_sql = " SELECT UNIQUE 'N',xmdc001,'','',imaa009,'',imaa006,'',imaf013,imaf051,'',imaf111,'',imaf141,'',imae011,'' FROM xmda_t,xmdc_t ",
      LET g_sql = " SELECT UNIQUE '',xmdc001,",
                  "         (SELECT imaal003 FROM imaal_t WHERE imaalent = xmdcent AND imaal001 = xmdc001 AND imaal002 = '",g_lang,"')  imaa001_desc, ", 
                  "         (SELECT imaal004 FROM imaal_t WHERE imaalent = xmdcent AND imaal001 = xmdc001 AND imaal002 = '",g_lang,"')  imaa001_desc_desc, ",                    
                  "         imaa009,",
                  "         (SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=imaa009 AND rtaxl002='"||g_dlang||"') imaa009_desc, ",
                  "         imaa006 ,",
                  "         (SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=imaa006 AND oocal002='"||g_dlang||"') imaa006_desc, ",
                  "         imaf013,imaf051, ",
                  "         (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '201' AND oocql002 = imaf051 AND oocql003 = '"||g_dlang||"') imaf051_desc,",
                  "         imaf111,",
                  "         (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '202' AND oocql002 = imaf111 AND oocql003 = '"||g_dlang||"') imaf111_desc,", 
                  "         imaf141,",
                  "         (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '203' AND oocql002 = imaf141 AND oocql003 = '"||g_dlang||"') imaf141_desc,",   
                  "         imae011,",
                  "         (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '204' AND oocql002 = imae011 AND oocql003 = '"||g_dlang||"') imae011_desc",                   
      #160510-00019#3-e
                  "   FROM xmda_t,xmdc_t ",   #161103-00001#1 add
                  "   LEFT OUTER JOIN imaa_t ON xmdcent = imaaent AND xmdc001 = imaa001 ",
                  "   LEFT OUTER JOIN imaf_t ON xmdcent = imafent AND xmdc001 = imaf001 AND xmdcsite = imafsite ",
                  "   LEFT OUTER JOIN imae_t ON xmdcent = imaeent AND xmdc001 = imae001 AND xmdcsite = imaesite ",
                  "  WHERE xmdaent = xmdcent AND xmdasite = xmdcsite AND xmdadocno = xmdcdocno ",  #add by lixh 20150326
                  "    AND imafsite = '",g_site,"'",
                  "    AND xmdcent= ? AND 1=1 AND ", g_wc3
      LET g_sql = g_sql, cl_sql_add_filter("xmdc_t"),
                         " ORDER BY xmdc_t.xmdc001"      
   END IF
   
   IF g_qbe_type = '4' THEN    #BOM
#      LET g_sql = " SELECT UNIQUE '',bmba003,'','',imaa009,'',imaa006,'',imaf013,imaf051,'',imaf111,'',imaf141,'',imae011,'' FROM bmaa_t,bmba_t ",
#                  "   LEFT OUTER JOIN imaa_t ON bmbaent = imaaent AND bmba003 = imaa001 ",
#                  "   LEFT OUTER JOIN imaf_t ON bmbaent = imafent AND bmba003 = imaf001 AND bmbasite = imafsite ",
#                  "   LEFT OUTER JOIN imae_t ON bmbaent = imaeent AND bmba003 = imae001 AND bmbasite = imaesite ", 
#                  "  WHERE bmaaent = bmbaent ",
#                  "    AND bmaasite = bmbasite ",
#                  "    AND bmaa001 = bmba001 ",
#                  "    AND bmaa002 = bmba002 ",
#                  "    AND bmbasite = '",g_site,"'",
#                  "    AND bmaaent= ? AND 1=1 AND ", g_wc4
#      LET g_sql = g_sql, cl_sql_add_filter("bmba_t"),
#                         " ORDER BY bmba_t.bmba003" 
       #160510-00019#3-s
      #LET g_sql1 = " SELECT UNIQUE 'N',bmaa001,'','',imaa009,'',imaa006,'',imaf013,imaf051,'',imaf111,'',imaf141,'',imae011,'' FROM bmaa_t ",
      LET g_sql1 = " SELECT UNIQUE 'N',bmaa001,t1.imaal003,t1.imaal004,imaa009,t2.rtaxl003,imaa006,t3.oocal003,",
                   "                   imaf013,imaf051,t4.oocql004,imaf111,t5.oocql004,imaf141,t6.oocql004,imae011,t7.oocql004 FROM bmaa_t ",
       #160510-00019#3-e             
                                      
                   "   LEFT OUTER JOIN imaa_t ON bmaaent = imaaent AND bmaa001 = imaa001 ",
                   "   LEFT OUTER JOIN imaf_t ON bmaaent = imafent AND bmaa001 = imaf001 AND bmaasite = imafsite ",
                   "   LEFT OUTER JOIN imae_t ON bmaaent = imaeent AND bmaa001 = imae001 AND bmaasite = imaesite ",
                   "   LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=bmaa001 AND t1.imaal002='"||g_dlang||"' ",
                   "   LEFT JOIN rtaxl_t t2 ON t2.rtaxlent='"||g_enterprise||"' AND t2.rtaxl001=imaa009 AND t2.rtaxl002='"||g_dlang||"'",
                   "   LEFT JOIN oocal_t t3 ON t3.oocalent='"||g_enterprise||"' AND t3.oocal001=imaa006 AND t3.oocal002='"||g_dlang||"'",
                   "   LEFT JOIN oocql_t t4 ON t4.oocqlent='"||g_enterprise||"' AND t4.oocql001='201' AND t4.oocql002=imaf051 AND t4.oocql003='"||g_dlang||"'",
                   "   LEFT JOIN oocql_t t5 ON t5.oocqlent='"||g_enterprise||"' AND t5.oocql001='202' AND t5.oocql002=imaf111 AND t5.oocql003='"||g_dlang||"'",
                   "   LEFT JOIN oocql_t t6 ON t4.oocqlent='"||g_enterprise||"' AND t6.oocql001='203' AND t6.oocql002=imaf141 AND t6.oocql003='"||g_dlang||"'",
                   "   LEFT JOIN oocql_t t7 ON t7.oocqlent='"||g_enterprise||"' AND t7.oocql001='204' AND t7.oocql002=imae011 AND t7.oocql003='"||g_dlang||"'",                     
                   "  WHERE imafsite = '",g_site,"'",                   
                   "    AND bmaaent= ? AND 1=1 AND ", g_wc4
      #160510-00019#3-s             
      #LET g_sql2 = " SELECT UNIQUE 'N',bmba003,'','',imaa009,'',imaa006,'',imaf013,imaf051,'',imaf111,'',imaf141,'',imae011,'' FROM bmaa_t,bmba_t ",
      LET g_sql2 = " SELECT UNIQUE 'N',bmba003,t1.imaal003,t1.imaal004,imaa009,t2.rtaxl003,imaa006,t3.oocal003,imaf013,",
                   " imaf051,t4.oocql004,imaf111,t5.oocql004,imaf141,t6.oocql004,imae011,t7.oocql004 FROM bmaa_t,bmba_t ",             
      #160510-00019#3-e      
                   "   LEFT OUTER JOIN imaa_t ON bmbaent = imaaent AND bmba003 = imaa001 ",
                   "   LEFT OUTER JOIN imaf_t ON bmbaent = imafent AND bmba003 = imaf001 AND bmbasite = imafsite ",
                   "   LEFT OUTER JOIN imae_t ON bmbaent = imaeent AND bmba003 = imae001 AND bmbasite = imaesite ", 
                   "   LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=bmba003 AND t1.imaal002='"||g_dlang||"' ",
                   "   LEFT JOIN rtaxl_t t2 ON t2.rtaxlent='"||g_enterprise||"' AND t2.rtaxl001=imaa009 AND t2.rtaxl002='"||g_dlang||"'",
                   "   LEFT JOIN oocal_t t3 ON t3.oocalent='"||g_enterprise||"' AND t3.oocal001=imaa006 AND t3.oocal002='"||g_dlang||"'",
                   "   LEFT JOIN oocql_t t4 ON t4.oocqlent='"||g_enterprise||"' AND t4.oocql001='201' AND t4.oocql002=imaf051 AND t4.oocql003='"||g_dlang||"'",
                   "   LEFT JOIN oocql_t t5 ON t5.oocqlent='"||g_enterprise||"' AND t5.oocql001='202' AND t5.oocql002=imaf111 AND t5.oocql003='"||g_dlang||"'",
                   "   LEFT JOIN oocql_t t6 ON t4.oocqlent='"||g_enterprise||"' AND t6.oocql001='203' AND t6.oocql002=imaf141 AND t6.oocql003='"||g_dlang||"'",
                   "   LEFT JOIN oocql_t t7 ON t7.oocqlent='"||g_enterprise||"' AND t7.oocql001='204' AND t7.oocql002=imae011 AND t7.oocql003='"||g_dlang||"'",                    
                   "  WHERE bmaaent = bmbaent ",
                   "    AND bmaaent = ",g_enterprise,  #151012-00011 by whitney add
                   "    AND bmaasite = bmbasite ",
                   "    AND bmaa001 = bmba001 ",
                   "    AND bmaa002 = bmba002 ",
                   "    AND bmbasite = '",g_site,"'",
                   "    AND bmba005 <= SYSDATE ",
                   "    AND (bmba006 >= SYSDATE OR bmba006 IS NULL) ",                   
                   "    AND bmaaent= ",g_enterprise," AND 1=1 AND ", g_wc4
      LET g_sql = g_sql1," UNION ",g_sql2            
      LET g_sql = g_sql, cl_sql_add_filter("bmaa_t"),
                         " ORDER BY bmaa001"  
   END IF   
   
   IF g_qbe_type = '5' THEN    #BOM元件  
      LET g_sql1 = "SELECT DISTINCT bmba001,bmba002,bmba003 ",
                   "  FROM bmba_t",      
                   " WHERE bmbaent = ",g_enterprise," AND bmbasite = '",g_site,"' AND ",g_wc6,
                   "  AND to_char(bmba005,'YY/MM/DD hh24:mi:ss')<='",g_date,"'",
                   "  AND (bmba006 IS NULL OR to_char(bmba006,'YY/MM/DD hh24:mi:ss')>'",g_date,"')"                   
                  
      LET g_sql2 = " SELECT DISTINCT bmba001,bmba002 FROM bmba_t ",
                  "  WHERE bmbasite = '",g_site,"'",
                  "  START WITH (bmba001,bmba002,bmba003) IN(",g_sql1,")",
                  "  CONNECT BY PRIOR bmba001 = bmba003 AND PRIOR bmba002 = bmba002 AND bmbasite = '",g_site,"' ORDER BY bmba001 "    
      #160510-00019#3-s             
      #LET g_sql =  " SELECT UNIQUE 'N',bmaa001,'','',imaa009,'',imaa006,'',imaf013,imaf051,'',imaf111,'',imaf141,'',imae011,'' ",
      LET g_sql = " SELECT UNIQUE 'N',bmaa001, ",
                  "        (SELECT imaal003 FROM imaal_t WHERE imaalent = bmaaent AND imaal001 = bmaa001 AND imaal002 = '",g_lang,"')  imaa001_desc, ",
                  "        (SELECT imaal004 FROM imaal_t WHERE imaalent = bmaaent AND imaal001 = bmaa001 AND imaal002 = '",g_lang,"')  imaa001_desc_desc, ",
                  "          imaa009,",
                  "         (SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=imaa009 AND rtaxl002='"||g_dlang||"') imaa009_desc, ",
                  "         imaa006,",
                  "         (SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=imaa006 AND oocal002='"||g_dlang||"') imaa006_desc, ",
                  "         imaf013,imaf051, ",
                  "         (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '201' AND oocql002 = imaf051 AND oocql003 = '"||g_dlang||"') imaf051_desc,",
                  "         imaf111,",
                  "         (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '202' AND oocql002 = imaf111 AND oocql003 = '"||g_dlang||"') imaf111_desc,", 
                  "         imaf141,",
                  "         (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '203' AND oocql002 = imaf141 AND oocql003 = '"||g_dlang||"') imaf141_desc,",   
                  "         imae011,",
                  "         (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '204' AND oocql002 = imae011 AND oocql003 = '"||g_dlang||"') imae011_desc",                   
      #160510-00019#3-e 
                   "   FROM bmaa_t a ",
                   "   LEFT OUTER JOIN bmba_t ON a.bmaaent = bmbaent AND a.bmaasite = bmbasite AND a.bmaa001 = bmba001 AND a.bmaa002 = bmba002 ",
                   "   LEFT OUTER JOIN imaa_t ON bmbaent = imaaent AND bmba001 = imaa001 ",
                   "   LEFT OUTER JOIN imaf_t ON bmbaent = imafent AND bmba001 = imaf001 AND bmbasite = imafsite ",
                   "   LEFT OUTER JOIN imae_t ON bmbaent = imaeent AND bmba001 = imae001 AND bmbasite = imaesite ",",",
                   " (",g_sql2,") b ",
                   " WHERE a.bmaa001 = b.bmba001 AND a.bmaa002 = b.bmba002 ",
                   "   AND bmaaent = ? ",
                   "   AND bmaasite = '",g_site,"'",
#                   "   AND to_char(bmba005,'YY/MM/DD hh24:mi:ss')<='",g_date,"'",
#                   "   AND (bmba006 IS NULL OR to_char(bmba006,'YY/MM/DD hh24:mi:ss')>'",g_date,"')",
                   "    AND bmba005 <= SYSDATE ",
                   "    AND (bmba006 >= SYSDATE OR bmba006 IS NULL) ",  
                   
                   "   AND bmaastus = 'Y' ",
                   " ORDER BY bmaa001 "                                     
   END IF
   
   #2015/09/03 by stellar add ----- (S)
   IF g_qbe_type = '6' THEN    #出貨單
      #160510-00019#3-s
      #LET g_sql = "SELECT UNIQUE '',xmdl008,'','',imaa009,'',imaa006,'',imaf013,imaf051,'',imaf111,'',imaf141,'',imae011,'' ",
      LET g_sql = " SELECT UNIQUE '',xmdl008, ",      
                  "         (SELECT imaal003 FROM imaal_t WHERE imaalent = xmdlent AND imaal001 = xmdl008 AND imaal002 = '",g_lang,"')  imaa001_desc, ",
                  "         (SELECT imaal004 FROM imaal_t WHERE imaalent = xmdlent AND imaal001 = xmdl008 AND imaal002 = '",g_lang,"')  imaa001_desc_desc, ",
                  "          imaa009,",
                  "         (SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=imaa009 AND rtaxl002='"||g_dlang||"') imaa009_desc, ",
                  "         imaa006,",
                  "         (SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=imaa006 AND oocal002='"||g_dlang||"') imaa006_desc, ",
                  "         imaf013,imaf051, ",
                  "         (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '201' AND oocql002 = imaf051 AND oocql003 = '"||g_dlang||"') imaf051_desc,",
                  "         imaf111,",
                  "         (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '202' AND oocql002 = imaf111 AND oocql003 = '"||g_dlang||"') imaf111_desc,", 
                  "         imaf141,",
                  "         (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '203' AND oocql002 = imaf141 AND oocql003 = '"||g_dlang||"') imaf141_desc,",   
                  "         imae011,",
                  "         (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '204' AND oocql002 = imae011 AND oocql003 = '"||g_dlang||"') imae011_desc",       
      #160510-00019#3-e 
      
                  "  FROM xmdk_t,xmdl_t ",
                  "  LEFT OUTER JOIN imaa_t ON xmdlent = imaaent AND xmdl008 = imaa001 ",
                  "  LEFT OUTER JOIN imaf_t ON xmdlent = imafent AND xmdl008 = imaf001 AND xmdlsite = imafsite ",
                  "  LEFT OUTER JOIN imae_t ON xmdlent = imafent AND xmdl008 = imae001 AND xmdlsite = imaesite ",
                  " WHERE xmdkent = xmdlent ",
                  "   AND xmdksite = xmdlsite ",
                  "   AND xmdkdocno = xmdldocno ",
                  "   AND xmdksite = '",g_site,"'",
                  "   AND xmdkent = ? ",
                  "   AND ",g_wc7 CLIPPED
      LET g_sql = g_sql,cl_sql_add_filter("xmdl_t"),
                  " ORDER BY xmdl_t.xmdl008 "    
   END IF
   #2015/09/03 by stellar add ----- (E)
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE ainq100_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ainq100_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_imaa_d[l_ac].sel,g_imaa_d[l_ac].imaa001,g_imaa_d[l_ac].imaa001_desc,g_imaa_d[l_ac].imaa001_desc_desc, 
       g_imaa_d[l_ac].imaa009,g_imaa_d[l_ac].imaa009_desc,g_imaa_d[l_ac].imaa006,g_imaa_d[l_ac].imaa006_desc, 
       g_imaa_d[l_ac].imaf013,g_imaa_d[l_ac].imaf051,g_imaa_d[l_ac].imaf051_desc,g_imaa_d[l_ac].imaf111, 
       g_imaa_d[l_ac].imaf111_desc,g_imaa_d[l_ac].imaf141,g_imaa_d[l_ac].imaf141_desc,g_imaa_d[l_ac].imae011, 
       g_imaa_d[l_ac].imae011_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #mark by lixh 20150424
#      IF g_qbe_type = '1' AND g_wc = " 1=1" THEN
#         CALL g_imaa_d.clear()
#         EXIT FOREACH
#      END IF   
#
#      IF g_qbe_type = '2' AND g_wc1 = " 1=1" THEN
#         CALL g_imaa_d.clear()
#         EXIT FOREACH
#      END IF  
#      
#      IF g_qbe_type = '3' AND g_wc3 = " 1=1" THEN
#         CALL g_imaa_d.clear()
#         EXIT FOREACH
#      END IF          
      #mark by lixh 20150424     
      IF g_qbe_type = '4' AND g_wc4 = " 1=1" THEN
         CALL g_imaa_d.clear()
         EXIT FOREACH
      END IF
      
      IF g_qbe_type = '5' AND g_wc6 = " 1=1" THEN
         CALL g_imaa_d.clear()
         EXIT FOREACH
      END IF      
      #end add-point
 
      CALL ainq100_detail_show("'1'")
 
      CALL ainq100_imaa_t_mask()
 
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

   LET g_detail_idx = 1
   CALL ainq100_b_fill3()
   CALL ainq100_b_fill5()
   CALL ainq100_b_fill7()  #160815-00026#1   
   #end add-point
 
   CALL g_imaa_d.deleteElement(g_imaa_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_imaa_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE ainq100_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL ainq100_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL ainq100_detail_action_trans()
 
   LET l_ac = 1
   IF g_imaa_d.getLength() > 0 THEN
      CALL ainq100_b_fill2()
   END IF
 
      CALL ainq100_filter_show('imaa001','b_imaa001')
   CALL ainq100_filter_show('imaa009','b_imaa009')
   CALL ainq100_filter_show('imaa006','b_imaa006')
   CALL ainq100_filter_show('imaf013','b_imaf013')
   CALL ainq100_filter_show('imaf051','b_imaf051')
   CALL ainq100_filter_show('imaf111','b_imaf111')
   CALL ainq100_filter_show('imaf141','b_imaf141')
   CALL ainq100_filter_show('imae011','b_imae011')
 
 
END FUNCTION
 
{</section>}
 
{<section id="ainq100.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ainq100_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING 
   DEFINE l_xmdd004       LIKE xmdd_t.xmdd004
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_rate          LIKE inaj_t.inaj014
   DEFINE l_stock         LIKE inag_t.inag009
   DEFINE l_gj_sum        LIKE inag_t.inag009
   DEFINE l_xq_sum        LIKE inag_t.inag009
   DEFINE l_ck_sum        LIKE inag_t.inag009
   DEFINE l_sfba014       LIKE sfba_t.sfba014
   DEFINE l_sfaa013       LIKE sfaa_t.sfaa013
   DEFINE l_pmdb007       LIKE pmdb_t.pmdb007
   DEFINE l_pmdt019       LIKE pmdt_t.pmdt019
   DEFINE l_inag032       LIKE inag_t.inag032
   DEFINE l_qcba016       LIKE qcba_t.qcba016
   DEFINE l_inag008       LIKE inag_t.inag008
   DEFINE l_sum_inag008   LIKE inag_t.inag008
   DEFINE l_zj_sum        LIKE inag_t.inag009 
   DEFINE l_pmdo004       LIKE pmdo_t.pmdo004
   DEFINE l_sfbaseq1      LIKE sfba_t.sfbaseq1
   DEFINE l_yy            LIKE type_t.num5 
   DEFINE l_mm            LIKE type_t.num5
   DEFINE l_dd            LIKE type_t.num5   
   DEFINE l_sql1          STRING
   DEFINE l_sql2          STRING
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   #清除畫面
#   CLEAR FORM  
   CALL g_imaa2_d.clear()
   CALL g_imaa3_d.clear()    
   LET l_sql = '' 
   IF g_detail_cnt <= 0 THEN
      RETURN
   END IF 
   LET l_yy = YEAR(g_today)
   LET l_mm = MONTH(g_today)
   LET l_dd = DAY(g_today)   
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   IF g_detail_idx = 0 OR cl_null(g_detail_idx) THEN
      RETURN
   END IF 

#   LET l_sql = " SELECT inag008,inag032 FROM inag_t ",
   LET l_sql = " SELECT COALESCE(inag008,0),inag007 FROM inag_t ",   
               "  WHERE inagent = ",g_enterprise,  #151012-00011 by whitney modify
               "    AND inagsite = '",g_site,"'",
               "    AND inag001 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND inag010 = 'Y' "
#   IF g_gxdate = 1 THEN #一個月 
#      CALL s_date_get_last_date(g_today) RETURNING g_bdate        
#   END IF
#   IF g_gxdate = 2 THEN
#      IF l_mm = 12 THEN
#         LET l_yy = l_yy + 1
#         LET l_mm = 1
#         LET g_bdate = MDY(l_mm,31,l_yy)                     
#      ELSE 
#         LET g_bdate = MDY(l_mm+1,l_dd,l_yy) 
#         CALL s_date_get_last_date(g_bdate) RETURNING g_bdate            
#      END IF  
#   END IF     
#   IF g_gxdate = 3 THEN
#      IF l_mm >= 11 THEN
#         IF l_mm = 11 THEN
#            LET l_yy = l_yy + 1
#            LET l_mm = 1
#            LET g_bdate = MDY(l_mm,31,l_yy)            
#         END IF
#         IF l_mm = 12 THEN
#            LET l_yy = l_yy + 1
#            LET l_mm = 2
#            LET g_bdate = MDY(l_mm,l_dd,l_yy)  
#            CALL s_date_get_last_date(g_bdate) RETURNING g_bdate  
#         END IF          
#      ELSE 
#         LET g_bdate = MDY(l_mm+2,l_dd,l_yy)   
#         CALL s_date_get_last_date(g_bdate) RETURNING g_bdate         
#      END IF 
#   END IF
#   IF g_gxdate = 4 THEN
#      IF l_mm >= 8 THEN
#         IF l_mm = 1 THEN 
#            LET l_yy = l_yy + 1
#            LET l_mm = 1
#            LET g_bdate = MDY(l_mm,31,l_yy) 
#         END IF
#         IF l_mm = 9 THEN 
#            LET l_yy = l_yy + 1
#            LET l_mm = 2
#            LET g_bdate = MDY(l_mm,l_dd,l_yy)
#            CALL s_date_get_last_date(g_bdate) RETURNING g_bdate                  
#         END IF 
#         IF l_mm = 10 THEN 
#            LET l_yy = l_yy + 1
#            LET l_mm = 3
#            LET g_bdate = MDY(l_mm,l_dd,l_yy) 
#            CALL s_date_get_last_date(g_bdate) RETURNING g_bdate      
#         END IF    
#         IF l_mm = 11 THEN 
#            LET l_yy = l_yy + 1
#            LET l_mm = 4
#            LET g_bdate = MDY(l_mm,l_dd,l_yy)   
#            CALL s_date_get_last_date(g_bdate) RETURNING g_bdate                  
#         END IF  
#         IF l_mm = 12 THEN 
#            LET l_yy = l_yy + 1
#            LET l_mm = 5
#            LET g_bdate = MDY(l_mm,l_dd,l_yy)   
#            CALL s_date_get_last_date(g_bdate) RETURNING g_bdate                  
#         END IF                      
#      ELSE    
#         LET g_bdate = MDY(l_mm+5,l_dd,l_yy) 
#         CALL s_date_get_last_date(g_bdate) RETURNING g_bdate               
#      END IF
#   END IF 
#   IF g_gxdate <> '5' THEN
##      LET l_sql = l_sql," AND inag015 BETWEEN '",g_today,"'"," AND '",g_bdate,"'"   
#      LET l_sql = l_sql," AND inag015 < = '",g_bdate,"'"  
#   END IF    
   PREPARE ainq100_inag008_pre FROM l_sql
   DECLARE ainq100_inag008_cur CURSOR FOR ainq100_inag008_pre
   LET l_stock = 0
   LET l_gj_sum = 0
   LET l_xq_sum = 0
   LET l_zj_sum = 0
   LET l_sum_inag008 = 0
   LET l_ac2 = 1
   LET l_ac6 = 1
   LET g_gj_sum = 0
   LET g_xq_sum = 0   
   FOREACH ainq100_inag008_cur INTO l_inag008,l_inag032
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()    
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_inag032) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_inag032,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET l_inag008 = l_inag008 * r_rate
#         END IF 
         CALL s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_inag032,g_imaa_d[g_detail_idx].imaa006,l_inag008)
             RETURNING r_success,l_inag008 
      END IF  
      LET l_sum_inag008 = l_sum_inag008 + l_inag008    

   END FOREACH 
#   IF l_ac2 = 1 THEN 
#       LET g_imaa2_d[1].type = '1' 
#       LET g_imaa2_d[1].gj_num = 0
#       LET l_ac2 = 2
#   END IF   
   
   IF cl_null(l_sum_inag008) THEN
      LET l_sum_inag008 = 0
   END IF   
   LET g_imaa2_d[1].type = '1'    
   LET g_imaa2_d[1].gj_num = l_sum_inag008
   LET g_imaa2_d[1].xq_num = 0
   LET g_imaa2_d[1].ck_num = 0
   LET g_imaa2_d[1].stock = l_sum_inag008  
   LET g_imaa3_d[1].type = '1' 
   LET g_imaa3_d[1].gj_num = l_sum_inag008      
   LET g_imaa3_d[1].xq_num = 0
   LET g_imaa3_d[1].ck_num = 0
   LET g_imaa3_d[1].stock = l_sum_inag008    
   LET g_gj_sum = l_sum_inag008        
   LET l_sql = ""
   #受訂量(需求)
   LET l_ac2 = 2  
   #160510-00019#3-s
   #LET l_sql = " SELECT xmdadocdt,'2',0,(COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd016,0)+COALESCE(xmdd034,0)),0,0,xmdddocno,xmddseq,'','',xmda008,xmda002,'',xmda003,'','axmt500', ",
  #LET l_sql = " SELECT xmdadocdt,'2',0,(COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd016,0)+COALESCE(xmdd034,0)),0,0,xmdddocno,xmddseq,'','',xmda008,xmda002,",        #160523-00081#1 --- mark
   LET l_sql = " SELECT xmdc012,'2',0,(COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd016,0)+COALESCE(xmdd034,0)),0,0,xmdddocno,xmddseq,",                              #160523-00081#1 --- add    #161202-00053#1---dujuan----xmdadocdt  改为xmdc012 
               " xmda004,(SELECT pmaal004 FROM pmaal_t WHERE pmaalent = xmdaent AND pmaal001 = xmda004 AND pmaal002 = '",g_lang,"') pmaal004 ,xmda008,xmda002,",                #160523-00081#1 --- add   
               "        (SELECT ooag011 FROM ooag_t WHERE ooagent = xmdaent AND ooag001 = xmda002 ) xmda002_desc ,",
               "        xmda003,",
               "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = xmdaent AND ooefl001 = xmda003 AND ooefl002 = '"||g_lang||"')  xmda003_desc ,",  
               "'axmt500',",              
   #160510-00019#3-e
               "        xmdd004,",
               "        '','','' ",   #2015/09/03 by stellar add
               "        FROM xmdd_t,xmda_t,xmdc_t ",
               "  WHERE xmdaent = xmddent ",
               "    AND xmdasite = xmddsite ",
               "    AND xmdadocno = xmdddocno ",
               #150104 by whitney add start
               "    AND xmdaent = xmdcent ",
               "    AND xmdasite = xmdcsite ",
               "    AND xmdadocno = xmdcdocno ",
               "    AND xmddseq = xmdcseq ",
               "    AND xmdc045 NOT IN ('2','3','4') ",
               #150104 by whitney add end               
               "    AND xmdasite = '",g_site,"'",               
               "    AND xmdaent = ",g_enterprise,  #151012-00011 by whitney modify
              # "    AND xmdastus = 'Y' ",
               "    AND xmdastus IN ('Y','H')",    #add by lixh 20151105
               "    AND xmdd001 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND (COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd016,0)+COALESCE(xmdd034,0)) <> 0"
               
#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND xmdadocdt <= '",g_bdate,"'" 
#   END IF   
   LET l_sql = l_sql,"  ORDER BY xmdadocdt,xmdddocno,xmddseq "   
   PREPARE ainq100_xmdd_pre FROM l_sql
   DECLARE ainq100_xmdd_cur CURSOR FOR ainq100_xmdd_pre
   LET l_stock = g_imaa2_d[1].stock
   LET l_gj_sum = 0
   LET l_xq_sum = 0
   FOREACH ainq100_xmdd_cur INTO g_imaa2_d[l_ac2].date,g_imaa2_d[l_ac2].type,g_imaa2_d[l_ac2].gj_num,g_imaa2_d[l_ac2].xq_num,
                                    g_imaa2_d[l_ac2].stock,g_imaa2_d[l_ac2].ck_num,g_imaa2_d[l_ac2].docno,g_imaa2_d[l_ac2].seq,g_imaa2_d[l_ac2].object,g_imaa2_d[l_ac2].object_desc,
                                    g_imaa2_d[l_ac2].ck_docno,g_imaa2_d[l_ac2].ooag001,g_imaa2_d[l_ac2].ooag011,
                                    g_imaa2_d[l_ac2].ooeg001,g_imaa2_d[l_ac2].ooeg001_desc,g_imaa2_d[l_ac2].prog,l_xmdd004,
                                    g_imaa2_d[l_ac2].sfaa010,g_imaa2_d[l_ac2].sfaa010_desc,g_imaa2_d[l_ac2].sfaa010_desc1   #2015/09/03 by stellar add

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_xmdd004) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_xmdd004,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa2_d[l_ac2].xq_num = g_imaa2_d[l_ac2].xq_num * r_rate
#         END IF    

         IF cl_null(g_imaa2_d[l_ac2].xq_num) THEN LET g_imaa2_d[l_ac2].xq_num = 0 END IF   #161202-00014#1
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_xmdd004,g_imaa_d[g_detail_idx].imaa006,g_imaa2_d[l_ac2].xq_num)
            RETURNING r_success,g_imaa2_d[l_ac2].xq_num 
      END IF
      
#160510-00019#3-s mark       
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooag001) THEN
#         CALL s_desc_get_person_desc(g_imaa2_d[l_ac2].ooag001) RETURNING g_imaa2_d[l_ac2].ooag011
#      END IF
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooeg001) THEN
#         CALL s_desc_get_department_desc(g_imaa2_d[l_ac2].ooeg001) RETURNING g_imaa2_d[l_ac2].ooeg001_desc
#      END IF   
#160510-00019#3-e mark

      
      LET l_xq_sum = l_xq_sum + g_imaa2_d[l_ac2].xq_num
      LET g_imaa2_d[l_ac2].stock = l_stock - g_imaa2_d[l_ac2].xq_num
      LET l_stock = g_imaa2_d[l_ac2].stock
      IF g_imaa2_d[l_ac2].xq_num <= 0 THEN  #add by lixh 20141121
         CONTINUE FOREACH
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
   IF l_xq_sum <> 0 THEN
      LET l_ac6 = l_ac6 + 1
      LET g_xq_sum = g_xq_sum + l_xq_sum
      LET g_imaa3_d[l_ac6].type = '2'  
      LET g_imaa3_d[l_ac6].gj_num = l_gj_sum      
      LET g_imaa3_d[l_ac6].xq_num = l_xq_sum 
      LET g_imaa3_d[l_ac6].ck_num = 0
      LET g_imaa3_d[l_ac6].stock = g_gj_sum-g_xq_sum
   END IF      
   LET l_sql = ''
   LET l_xq_sum = 0
   LET l_gj_sum = 0
   LET l_ck_sum = 0
   #工單備料量(需求)
   #160510-00019#3-s 
#   LET l_sql1 = " SELECT sfaadocdt,'3',0,(COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0)+DECODE(SIGN(COALESCE(sfba017,0)-COALESCE(sfba025,0)),-1,0,(COALESCE(sfba017,0)-COALESCE(sfba025,0)))),0,0,sfbadocno,sfbaseq,sfaa017,'',sfaa022,sfaa002,'','','','asft300',sfba014,sfbaseq1,",
#                "        sfaa010,'','' ",   #2015/09/03 by stellar add
   LET l_sql1 = " SELECT sfaa019,'3',0,(COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0)+DECODE(SIGN(COALESCE(sfba017,0)-COALESCE(sfba025,0)),-1,0,(COALESCE(sfba017,0)-COALESCE(sfba025,0)))),0,0,sfbadocno,sfbaseq,sfaa017,",  #161202-00053#1---dujuan----sfaadocdt  改为sfaa019 
                "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = sfaaent AND ooefl001 = sfaa017 AND ooefl002 = '",g_lang,"') sfaa017_desc ,",
                "         sfaa022,sfaa002, ",
                "        (SELECT ooag011 FROM ooag_t WHERE ooagent = sfaaent AND ooag001 = sfaa002 ) sfaa002_desc,",
                "        '','','asft300',sfba014,sfbaseq1,sfaa010,",
                "        (SELECT imaal003 FROM imaal_t WHERE imaalent = sfaaent AND imaal001 = sfaa010 AND imaal002 = '",g_lang,"') sfaa010_desc,",
                "        (SELECT imaal004 FROM imaal_t WHERE imaalent = sfaaent AND imaal001 = sfaa010 AND imaal002 = '",g_lang,"') sfaa010_desc_desc",
    
   #160510-00019#3-s    
   
               " FROM sfaa_t,sfba_t ",
               "  WHERE sfaaent = sfbaent ", 
               "    AND sfaadocno = sfbadocno ",
               "    AND sfaaent = ",g_enterprise,  #151012-00011 by whitney modify
               "    AND sfaasite = '",g_site,"'",
               "    AND sfba006 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND sfaa003 <> '4' ",
               "    AND sfaastus <> 'X'",
               "    AND sfaastus <> 'C'",
               "    AND sfaastus <> 'M'",
#               "    AND sfaa057 = '1' ",  #mark by lixh 20150604
               "    AND (COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0)+DECODE(SIGN(COALESCE(sfba017,0)-COALESCE(sfba025,0)),-1,0,(COALESCE(sfba017,0)-COALESCE(sfba025,0)))) <> 0 ",
               "    AND COALESCE(sfba017,0) > 0  "
   #160510-00019#3-s                
#   LET l_sql2 = " SELECT sfaadocdt,'3',0,(COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0)+COALESCE(sfba017,0)),0,0,sfbadocno,sfbaseq,sfaa017,'',sfaa022,sfaa002,'','','','asft300',sfba014,sfbaseq1, ",
#                "        sfaa010,'','' ",   #2015/09/03 by stellar add
   LET l_sql2 = " SELECT sfaa019,'3',0,(COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0)+COALESCE(sfba017,0)),0,0,sfbadocno,sfbaseq,sfaa017,",   #161202-00053#1---dujuan----sfaadocdt  改为sfaa019 
                "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = sfaaent AND ooefl001 = sfaa017 AND ooefl002 = '",g_lang,"') sfaa017_desc ,",
                "         sfaa022,sfaa002, ",
                "        (SELECT ooag011 FROM ooag_t WHERE ooagent = sfaaent AND ooag001 = sfaa002 ) sfaa002_desc,",
                "        '','','asft300',sfba014,sfbaseq1,sfaa010,",
                "        (SELECT imaal003 FROM imaal_t WHERE imaalent = sfaaent AND imaal001 = sfaa010 AND imaal002 = '",g_lang,"') sfaa010_desc,",
                "        (SELECT imaal004 FROM imaal_t WHERE imaalent = sfaaent AND imaal001 = sfaa010 AND imaal002 = '",g_lang,"') sfaa010_desc_desc",
   #160510-00019#3-e
   
               "   FROM sfaa_t,sfba_t ",
               "  WHERE sfaaent = sfbaent ", 
               "    AND sfaadocno = sfbadocno ",
               "    AND sfaaent = ",g_enterprise,  #151012-00011 by whitney modify
               "    AND sfaasite = '",g_site,"'",
               "    AND sfba006 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND sfaa003 <> '4' ",
               "    AND sfaastus <> 'X'",
               "    AND sfaastus <> 'C'",
               "    AND sfaastus <> 'M'",
#               "    AND sfaa057 = '1' ",    #mark by lixh 20150604
               "    AND (COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0)+COALESCE(sfba017,0)) <> 0 ",
               "    AND COALESCE(sfba017,0) = 0  "               
   LET l_sql = l_sql1, " UNION ",l_sql2            
#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND sfaadocdt <= '",g_bdate,"'"
#   END IF      
   LET l_sql = l_sql,"  ORDER BY sfaa019,sfbadocno,sfbaseq "   #161202-00053#1---dujuan----sfaadocdt  改为sfaa019 
   PREPARE ainq100_sfba_pre FROM l_sql
   DECLARE ainq100_sfba_cur CURSOR FOR ainq100_sfba_pre 
   FOREACH ainq100_sfba_cur INTO g_imaa2_d[l_ac2].date,g_imaa2_d[l_ac2].type,g_imaa2_d[l_ac2].gj_num,g_imaa2_d[l_ac2].xq_num,
                                 g_imaa2_d[l_ac2].stock,g_imaa2_d[l_ac2].ck_num,g_imaa2_d[l_ac2].docno,g_imaa2_d[l_ac2].seq,g_imaa2_d[l_ac2].object,g_imaa2_d[l_ac2].object_desc,
                                 g_imaa2_d[l_ac2].ck_docno,g_imaa2_d[l_ac2].ooag001,g_imaa2_d[l_ac2].ooag011,
                                 g_imaa2_d[l_ac2].ooeg001,g_imaa2_d[l_ac2].ooeg001_desc,g_imaa2_d[l_ac2].prog,l_sfba014,l_sfbaseq1,
                                 g_imaa2_d[l_ac2].sfaa010,g_imaa2_d[l_ac2].sfaa010_desc,g_imaa2_d[l_ac].sfaa010_desc1   #2015/09/03 by stellar add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF
      IF cl_null(g_imaa2_d[l_ac2].ck_num) THEN LET g_imaa2_d[l_ac2].ck_num = 0 END IF     #161006-00018#28    
      CALL s_asft300_07(g_imaa2_d[l_ac2].docno,g_imaa2_d[l_ac2].seq,l_sfbaseq1) RETURNING r_success,g_imaa2_d[l_ac2].ck_num
      #161202-00014#1-S   
      IF cl_null(g_imaa2_d[l_ac2].xq_num) THEN LET g_imaa2_d[l_ac2].xq_num = 0 END IF
      IF cl_null(g_imaa2_d[l_ac2].ck_num) THEN LET g_imaa2_d[l_ac2].ck_num = 0 END IF 
      #161202-00014#1-E   
      IF NOT cl_null(l_sfba014) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_sfba014,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa2_d[l_ac2].xq_num = g_imaa2_d[l_ac2].xq_num * r_rate
#         END IF   
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_sfba014,g_imaa_d[g_detail_idx].imaa006,g_imaa2_d[l_ac2].xq_num)
            RETURNING r_success,g_imaa2_d[l_ac2].xq_num 
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_sfba014,g_imaa_d[g_detail_idx].imaa006,g_imaa2_d[l_ac2].ck_num)
            RETURNING r_success,g_imaa2_d[l_ac2].ck_num            
      END IF
      
#160510-00019#3-s mark      
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooag001) THEN
#         CALL s_desc_get_person_desc(g_imaa2_d[l_ac2].ooag001) RETURNING g_imaa2_d[l_ac2].ooag011
#      END IF
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooeg001) THEN
#         CALL s_desc_get_department_desc(g_imaa2_d[l_ac2].ooeg001) RETURNING g_imaa2_d[l_ac2].ooeg001_desc
#      END IF   
#      IF NOT cl_null(g_imaa2_d[l_ac2].object) THEN     
#         CALL s_desc_get_department_desc(g_imaa2_d[l_ac2].object) RETURNING g_imaa2_d[l_ac2].object_desc
#      END IF   
#      
#      #2015/09/03 by stellar add ----- (S)
#      IF NOT cl_null(g_imaa2_d[l_ac2].sfaa010) THEN
#         CALL s_desc_get_item_desc(g_imaa2_d[l_ac2].sfaa010)
#              RETURNING g_imaa2_d[l_ac2].sfaa010_desc,g_imaa2_d[l_ac2].sfaa010_desc1
#      END IF
#      #2015/09/03 by stellar add ----- (E)
#160510-00019#3-e mark       
      IF g_imaa2_d[l_ac2].xq_num <= 0 THEN  #add by lixh 20141121
         CONTINUE FOREACH
      END IF       
      LET l_xq_sum = l_xq_sum + g_imaa2_d[l_ac2].xq_num
      LET l_ck_sum = l_ck_sum + g_imaa2_d[l_ac2].ck_num 
      LET g_imaa2_d[l_ac2].stock = l_stock - g_imaa2_d[l_ac2].xq_num
      LET l_stock = g_imaa2_d[l_ac2].stock      
      LET l_ac2 = l_ac2 + 1 
      
   END FOREACH 
   
   IF l_xq_sum <> 0 THEN
      LET l_ac6 = l_ac6 + 1   
      LET g_xq_sum = g_xq_sum + l_xq_sum
      LET g_imaa3_d[l_ac6].type = '3'  
      LET g_imaa3_d[l_ac6].gj_num = l_gj_sum     
      LET g_imaa3_d[l_ac6].xq_num = l_xq_sum 
      LET g_imaa3_d[l_ac6].ck_num = l_ck_sum
      LET g_imaa3_d[l_ac6].stock = g_gj_sum-g_xq_sum
   END IF 
   
   LET l_sql = ''
   LET l_xq_sum = 0
   LET l_gj_sum = 0   
   #供需類型：請購量(供給)
   #160510-00019#3-s
#   LET l_sql = " SELECT pmdb030,'4',(COALESCE(pmdb006,0)-COALESCE(pmdb049,0)),0,0,0,pmdbdocno,pmdbseq,pmdb015,'',pmdb001,pmda002,'',pmda003,'','apmt400',pmdb007, ",
#               "        '','','' ",   #2015/09/03 by stellar add
   LET l_sql = " SELECT pmdb030,'4',(COALESCE(pmdb006,0)-COALESCE(pmdb049,0)),0,0,0,pmdbdocno,pmdbseq,pmdb015,",
               "        (SELECT inaml003 FROM inaml_t WHERE inamlent = pmdbent AND inaml001 = pmdb015 AND inaml002 = '",g_lang,"') inaml003,",
               "        pmdb001,pmda002," ,
               "        (SELECT ooag011 FROM ooag_t WHERE ooagent = pmdaent AND ooag001 = pmda002) ooag011,",    
               "        pmda003,",
               "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdaent AND ooefl001 = pmda003 AND ooefl002 = '",g_lang,"') ooefl003,",         
               "        'apmt400',pmdb007,'','','' ",               
   #160510-00019#3-e            
               "   FROM pmda_t,pmdb_t ",
               "  WHERE pmdaent = pmdbent ",
               "    AND pmdaent = ",g_enterprise,  #151012-00011 by whitney modify
               "    AND pmdasite = '",g_site,"'",
               "    AND pmdadocno = pmdbdocno ",
               "    AND pmdb004 = '",g_imaa_d[g_detail_idx].imaa001,"'", 
               "    AND COALESCE(pmdb006,0) <> COALESCE(pmdb049,0) ",
               "    AND pmdb032 NOT IN ('2','3','4') ",  #150104 by whitney add               
               "    AND pmdastus <> 'X' AND pmdastus <> 'C' "
                          
#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND pmdb030 <= '",g_bdate,"'"
#   END IF    
   LET l_sql = l_sql,"  ORDER BY pmdb030,pmdbdocno,pmdbseq "      
   PREPARE ainq100_pmda_pre FROM l_sql
   DECLARE ainq100_pmda_cur CURSOR FOR ainq100_pmda_pre 
   FOREACH ainq100_pmda_cur INTO g_imaa2_d[l_ac2].date,g_imaa2_d[l_ac2].type,g_imaa2_d[l_ac2].gj_num,g_imaa2_d[l_ac2].xq_num,
                                 g_imaa2_d[l_ac2].stock,g_imaa2_d[l_ac2].ck_num,g_imaa2_d[l_ac2].docno,g_imaa2_d[l_ac2].seq,g_imaa2_d[l_ac2].object,g_imaa2_d[l_ac2].object_desc,
                                 g_imaa2_d[l_ac2].ck_docno,g_imaa2_d[l_ac2].ooag001,g_imaa2_d[l_ac2].ooag011,
                                 g_imaa2_d[l_ac2].ooeg001,g_imaa2_d[l_ac2].ooeg001_desc,g_imaa2_d[l_ac2].prog,l_pmdb007,
                                 g_imaa2_d[l_ac2].sfaa010,g_imaa2_d[l_ac2].sfaa010_desc,g_imaa2_d[l_ac2].sfaa010_desc1   #2015/09/03 by stellar add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF cl_null(g_imaa2_d[l_ac2].gj_num) THEN LET g_imaa2_d[l_ac2].gj_num = 0 END IF #161202-00014#1
      IF NOT cl_null(l_pmdb007) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_pmdb007,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa2_d[l_ac2].gj_num = g_imaa2_d[l_ac2].gj_num * r_rate
#         END IF    
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_pmdb007,g_imaa_d[g_detail_idx].imaa006,g_imaa2_d[l_ac2].gj_num)
            RETURNING r_success,g_imaa2_d[l_ac2].gj_num 
      END IF
#160510-00019#3-s   mark   
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooag001) THEN
#         CALL s_desc_get_person_desc(g_imaa2_d[l_ac2].ooag001) RETURNING g_imaa2_d[l_ac2].ooag011
#      END IF
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooeg001) THEN
#         CALL s_desc_get_department_desc(g_imaa2_d[l_ac2].ooeg001) RETURNING g_imaa2_d[l_ac2].ooeg001_desc
#      END IF      
#      IF NOT cl_null(g_imaa2_d[l_ac2].object) THEN      
#         CALL s_desc_get_trading_partner_abbr_desc(g_imaa2_d[l_ac2].object) RETURNING g_imaa2_d[l_ac2].object_desc 
#      END IF 
#160510-00019#3-s   mark
      IF g_imaa2_d[l_ac2].gj_num <= 0 THEN
         CONTINUE FOREACH
      END IF
      LET l_gj_sum = l_gj_sum + g_imaa2_d[l_ac2].gj_num
      LET g_imaa2_d[l_ac2].stock = l_stock + g_imaa2_d[l_ac2].gj_num
      LET l_stock = g_imaa2_d[l_ac2].stock      
      LET l_ac2 = l_ac2 + 1 
      
   END FOREACH   
   IF l_gj_sum <> 0 THEN
      LET l_ac6 = l_ac6 + 1   
      LET g_gj_sum = g_gj_sum + l_gj_sum
      LET g_imaa3_d[l_ac6].type = '4'  
      LET g_imaa3_d[l_ac6].gj_num = l_gj_sum     
      LET g_imaa3_d[l_ac6].xq_num = l_xq_sum 
      LET g_imaa3_d[l_ac6].ck_num = 0
      LET g_imaa3_d[l_ac6].stock = g_gj_sum-g_xq_sum
   END IF 
   #採購量(供給)
   LET l_sql = ''
   LET l_gj_sum = 0
   LET l_xq_sum = 0
   #add by lixh 20150825 add pmdo019(採購有已收貨入庫量，收貨入庫單的狀態未過帳，採購量要列出來)=>20150922 還原
   #160510-00019#3-s
#   LET l_sql = " SELECT pmdldocdt,'5',(COALESCE(pmdo006,0)-COALESCE(pmdo015,0)+COALESCE(pmdo016,0)+COALESCE(pmdo017,0)),0,0,0,pmdodocno,pmdoseq,pmdl004,'',pmdl008,pmdl002,'',pmdl003,'','apmt500',pmdo004, ",
#               "        '','','' ",   #2015/09/03 by stellar add
   LET l_sql = " SELECT pmdo012,'5',(COALESCE(pmdo006,0)-COALESCE(pmdo015,0)+COALESCE(pmdo016,0)+COALESCE(pmdo017,0)),0,0,0,pmdodocno,pmdoseq,pmdl004,",   #161202-00053#1---dujuan----pmdldocdt  改为pmdo012
               "        (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = pmdlent AND pmaal001 = pmdl004 AND pmaal002 = '",g_lang,"') pmaal004,",
               "        pmdl008,pmdl002,",
               "        (SELECT ooag011 FROM ooag_t WHERE ooagent = pmdlent AND ooag001 = pmdl002 ) ooag011 ,",
               "        pmdl003,",
               "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdlent AND ooefl001 = pmdl003 AND ooefl002 = '",g_lang,"') ooefl003 ,",
               "        'apmt500',pmdo004,'','','' ",               
   #160510-00019#3-e               
               "   FROM pmdl_t,pmdo_t,pmdn_t",
               "  WHERE pmdlent = pmdoent ",
               "    AND pmdlent = ",g_enterprise,  #151012-00011 by whitney add
               "    AND pmdosite = '",g_site,"'",
               "    AND pmdldocno = pmdodocno ",
               #150104 by whitney add start
               "    AND pmdnent = pmdlent ",
               "    AND pmdnsite = pmdlsite ",
               "    AND pmdndocno = pmdldocno ",
               "    AND pmdnseq = pmdoseq ",
               "    AND pmdn045 NOT IN ('2','3','4') ",
               #150104 by whitney add end               
               "    AND pmdo001 = '",g_imaa_d[g_detail_idx].imaa001,"'", 
              # "    AND pmdlstus <> 'X' AND pmdlstus <> 'C' ",
               #"    AND pmdlstus IN ('Y','H') ",         #add by lixh 20151105
               "    AND pmdlstus NOT IN ('X','C') ",      #161024-00052#1
               "    AND (COALESCE(pmdo006,0)-COALESCE(pmdo015,0)+COALESCE(pmdo016,0)+COALESCE(pmdo017,0)) <> 0 ",
               "    AND pmdl005 <> '2' "   #add by lixh 20150114
                            
#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND pmdldocdt <= '",g_bdate,"'"
#   END IF    
   LET l_sql = l_sql,"  ORDER BY pmdo012,pmdodocno,pmdoseq "     #161202-00053#1---dujuan----pmdldocdt  改为pmdo012 
   PREPARE ainq100_pmdl_pre FROM l_sql
   DECLARE ainq100_pmdl_cur CURSOR FOR ainq100_pmdl_pre 
   FOREACH ainq100_pmdl_cur INTO g_imaa2_d[l_ac2].date,g_imaa2_d[l_ac2].type,g_imaa2_d[l_ac2].gj_num,g_imaa2_d[l_ac2].xq_num,
                                 g_imaa2_d[l_ac2].stock,g_imaa2_d[l_ac2].ck_num,g_imaa2_d[l_ac2].docno,g_imaa2_d[l_ac2].seq,g_imaa2_d[l_ac2].object,g_imaa2_d[l_ac2].object_desc,
                                 g_imaa2_d[l_ac2].ck_docno,g_imaa2_d[l_ac2].ooag001,g_imaa2_d[l_ac2].ooag011,
                                 g_imaa2_d[l_ac2].ooeg001,g_imaa2_d[l_ac2].ooeg001_desc,g_imaa2_d[l_ac2].prog,l_pmdo004,
                                 g_imaa2_d[l_ac2].sfaa010,g_imaa2_d[l_ac2].sfaa010_desc,g_imaa2_d[l_ac2].sfaa010_desc1   #2015/09/03 by stellar add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_pmdo004) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_pmdo004,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa2_d[l_ac2].gj_num = g_imaa2_d[l_ac2].gj_num * r_rate
#         END IF   
         IF cl_null(g_imaa2_d[l_ac2].gj_num) THEN LET g_imaa2_d[l_ac2].gj_num = 0 END IF  #161202-00014#1
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_pmdo004,g_imaa_d[g_detail_idx].imaa006,g_imaa2_d[l_ac2].gj_num)
            RETURNING r_success,g_imaa2_d[l_ac2].gj_num
      END IF
      #160510-00019#3-s  mark
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooag001) THEN
#         CALL s_desc_get_person_desc(g_imaa2_d[l_ac2].ooag001) RETURNING g_imaa2_d[l_ac2].ooag011
#      END IF
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooeg001) THEN
#         CALL s_desc_get_department_desc(g_imaa2_d[l_ac2].ooeg001) RETURNING g_imaa2_d[l_ac2].ooeg001_desc
#      END IF      
#      IF NOT cl_null(g_imaa2_d[l_ac2].object) THEN      
#         CALL s_desc_get_trading_partner_abbr_desc(g_imaa2_d[l_ac2].object) RETURNING g_imaa2_d[l_ac2].object_desc 
#      END IF   
      #160510-00019#3-e  mark     
      IF g_imaa2_d[l_ac2].gj_num <= 0 THEN
         CONTINUE FOREACH
      END IF      
      LET l_gj_sum = l_gj_sum + g_imaa2_d[l_ac2].gj_num
      LET g_imaa2_d[l_ac2].stock = l_stock + g_imaa2_d[l_ac2].gj_num
      LET l_stock = g_imaa2_d[l_ac2].stock      
      LET l_ac2 = l_ac2 + 1 
      
   END FOREACH     
   IF l_gj_sum <> 0 THEN
      LET l_ac6 = l_ac6 + 1   
      LET g_gj_sum = g_gj_sum + l_gj_sum
      LET g_imaa3_d[l_ac6].type = '5'  
      LET g_imaa3_d[l_ac6].gj_num = l_gj_sum     
      LET g_imaa3_d[l_ac6].xq_num = l_xq_sum 
      LET g_imaa3_d[l_ac6].ck_num = 0
      LET g_imaa3_d[l_ac6].stock = g_gj_sum-g_xq_sum
   END IF 
   #工單在製量(供給)
   LET l_sql = ''
   LET l_gj_sum = 0
   LET l_xq_sum = 0
#160105-00006#1 mark---start---
#  LET l_sql = " SELECT sfaadocdt,'6',(COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)),0,0,0,sfaadocno,0,sfaa017,'',sfaa006,sfaa002,'','','','asft300',sfaa013, ",
#              "        sfaa010,'','' ",   #2015/09/03 by stellar add
#              "   FROM sfaa_t ",
#              "  WHERE sfaaent = ",g_enterprise,  #151012-00011 by whitney modify
#              "    AND sfaasite = '",g_site,"'",
#              "    AND sfaa010 = '",g_imaa_d[g_detail_idx].imaa001,"'",
#              "    AND sfaa003 <> '4' ",
#              "    AND sfaastus <> 'X'",
#              "    AND sfaastus <> 'C'",
#              "    AND sfaastus <> 'M'",   #add by lixh 20150213
#              "    AND sfaa057 = '1' ",
#              "    AND (COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)) <> 0"
#160105-00006#1 mark---end---
#160105-00006#1 add---start---
   #160510-00019#3-s   
#   LET l_sql = " SELECT sfaadocdt,'6',sfaa012-COALESCE(pmdt020,0),0,0,0,sfaadocno,0,sfaa017,'',sfaa006,sfaa002,'','','','asft300',sfaa013, ",
#               "        sfaa010,'','' FROM ",
   LET l_sql = " SELECT sfaa019,'6',sfaa012-COALESCE(pmdt020,0),0,0,0,sfaadocno,0,sfaa017,",  #161202-00053---dujuan----sfaadocdt  改为sfaa019
               "        (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = sfaaent AND pmaal001 = sfaa017 AND pmaal002 = '",g_lang,"') pmaal004,",
               "        sfaa006,sfaa002, ",
               "        (SELECT ooag011 FROM ooag_t  ", # WHERE ooag_t ",#161212-00080#1------dujaun----mark---去掉 WHERE ooag_t
               "         WHERE ooagent = sfaaent AND ooag001 = sfaa002 ) ooag011 ,",
               "        '','','asft300',sfaa013,sfaa010,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent = sfaaent AND imaal001 = sfaa010 AND imaal002 = '",g_lang,"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent = sfaaent AND imaal001 = sfaa010 AND imaal002 = '",g_lang,"') imaal004 FROM ",
   #160510-00019#3-e
               " (SELECT sfaaent,sfaa019,(COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)) sfaa012,sfaadocno,sfaa017,sfaa006,sfaa002,sfaa013,sfaa010 FROM sfaa_t ", #161212-00080#1------dujaun----mark---SELECT sfaadocdt,改为SELECT sfaaent,sfaadocdt,     #161202-00053---dujuan----sfaadocdt  改为sfaa019
               " WHERE sfaaent = ",g_enterprise,
               "   AND sfaasite = '",g_site,"'",
               "   AND sfaa010 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "   AND sfaa003 <> '4' ",
               "   AND sfaastus <> 'X'",
               "   AND sfaastus <> 'C'",
               "   AND sfaastus <> 'M'",
               "   AND sfaa057 = '1' ",
               "   AND (COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)) <> 0) T1",
               " LEFT OUTER JOIN ",
               " (SELECT pmdl008,pmdt001,pmdt002,SUM(COALESCE(pmdt020,0)) pmdt020 FROM pmds_t,pmdt_t,pmdn_t,pmdl_t ",
               " WHERE pmdsent = pmdtent ",
               "   AND pmdssite = '",g_site,"'",
               "   AND pmdsdocno = pmdtdocno ",
               "   AND pmds000 = '8' ",
               "   AND pmds011 = '2' ",
               "   AND pmdsstus = 'Y' ",
               "   AND pmdt006 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "   AND (COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)) <> 0 ",
               "   AND pmdlent = '",g_enterprise,"'",
               "   AND pmdldocno = pmdndocno ",
               "   AND pmdndocno = pmdt001 ",
               "   AND pmdnseq = pmdt002 ",
               " GROUP BY pmdl008,pmdt001,pmdt002) T2",
               " ON T2.pmdl008 = T1.sfaadocno"         
#160105-00006#1 add---end---

#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND sfaadocdt <= '",g_bdate,"'"
#   END IF  
   LET l_sql = l_sql,"  ORDER BY sfaa019,sfaadocno "     #161202-00053---dujuan----sfaadocdt  改为sfaa019         
   PREPARE ainq100_sfaa_pre1 FROM l_sql
   DECLARE ainq100_sfaa_cur1 CURSOR FOR ainq100_sfaa_pre1
   FOREACH ainq100_sfaa_cur1 INTO g_imaa2_d[l_ac2].date,g_imaa2_d[l_ac2].type,g_imaa2_d[l_ac2].gj_num,g_imaa2_d[l_ac2].xq_num,
                                  g_imaa2_d[l_ac2].stock,g_imaa2_d[l_ac2].ck_num,g_imaa2_d[l_ac2].docno,g_imaa2_d[l_ac2].seq,g_imaa2_d[l_ac2].object,g_imaa2_d[l_ac2].object_desc,
                                  g_imaa2_d[l_ac2].ck_docno,g_imaa2_d[l_ac2].ooag001,g_imaa2_d[l_ac2].ooag011,
                                  g_imaa2_d[l_ac2].ooeg001,g_imaa2_d[l_ac2].ooeg001_desc,g_imaa2_d[l_ac2].prog,l_sfaa013,
                                  g_imaa2_d[l_ac2].sfaa010,g_imaa2_d[l_ac2].sfaa010_desc,g_imaa2_d[l_ac2].sfaa010_desc1   #2015/09/03 by stellar add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_sfaa013) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_sfaa013,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa2_d[l_ac2].gj_num = g_imaa2_d[l_ac2].gj_num * r_rate
#         END IF  
         IF cl_null(g_imaa2_d[l_ac2].gj_num) THEN LET g_imaa2_d[l_ac2].gj_num = 0 END IF  #161202-00014#1
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_sfaa013,g_imaa_d[g_detail_idx].imaa006,g_imaa2_d[l_ac2].gj_num)
            RETURNING r_success,g_imaa2_d[l_ac2].gj_num
      END IF
      #160510-00019#3-s mark
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooag001) THEN
#         CALL s_desc_get_person_desc(g_imaa2_d[l_ac2].ooag001) RETURNING g_imaa2_d[l_ac2].ooag011
#      END IF
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooeg001) THEN
#         CALL s_desc_get_department_desc(g_imaa2_d[l_ac2].ooeg001) RETURNING g_imaa2_d[l_ac2].ooeg001_desc
#      END IF    
#      IF NOT cl_null(g_imaa2_d[l_ac2].object) THEN     
#         CALL s_desc_get_department_desc(g_imaa2_d[l_ac2].object) RETURNING g_imaa2_d[l_ac2].object_desc
#      END IF 
#      
#      #2015/09/03 by stellar add ----- (S)
#      IF NOT cl_null(g_imaa2_d[l_ac2].sfaa010) THEN
#         CALL s_desc_get_item_desc(g_imaa2_d[l_ac2].sfaa010)
#              RETURNING g_imaa2_d[l_ac2].sfaa010_desc,g_imaa2_d[l_ac2].sfaa010_desc1
#      END IF
#      #2015/09/03 by stellar add ----- (E)
      #160510-00019#3-e mark
      
      IF g_imaa2_d[l_ac2].gj_num <= 0 THEN
         CONTINUE FOREACH
      END IF      
      LET l_gj_sum = l_gj_sum + g_imaa2_d[l_ac2].gj_num
      LET g_imaa2_d[l_ac2].stock = l_stock + g_imaa2_d[l_ac2].gj_num
      LET l_stock = g_imaa2_d[l_ac2].stock      
      LET l_ac2 = l_ac2 + 1 
      
   END FOREACH 
   IF l_gj_sum <> 0 THEN
      LET l_ac6 = l_ac6 + 1   
      LET g_gj_sum = g_gj_sum + l_gj_sum
      LET g_imaa3_d[l_ac6].type = '6'  
      LET g_imaa3_d[l_ac6].gj_num = l_gj_sum     
      LET g_imaa3_d[l_ac6].xq_num = l_xq_sum 
      LET g_imaa3_d[l_ac6].ck_num = 0
      LET g_imaa3_d[l_ac6].stock = g_gj_sum-g_xq_sum
   END IF    
   #委外在製量(供給)
   LET l_sql = ''
   LET l_gj_sum = 0
   LET l_xq_sum = 0   
#wujie 151023 --begin 扣除委外IQC在验量  用工单里含委外IQC的量-(工单关联到采购单+项次的收货未入库量)   
#   LET l_sql = " SELECT sfaadocdt,'7',(COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)),0,0,0,sfaadocno,0,sfaa017,'',sfaa006,sfaa002,'','','','asft300',sfaa013, ",
#               "        sfaa010,'','' ",   #2015/09/03 by stellar add
#               "   FROM sfaa_t ",
#               "  WHERE sfaaent = ",g_enterprise,  #151012-00011 by whitney modify
#               "    AND sfaasite = '",g_site,"'",               
#               "    AND sfaa010 = '",g_imaa_d[g_detail_idx].imaa001,"'",
#               "    AND sfaa003 <> '4' ",
#               "    AND sfaastus <> 'X'",
#               "    AND sfaastus <> 'C'",
#               "    AND sfaastus <> 'M'",   #add by lixh 20150213
#               "    AND sfaa057 = '2' ",
#               "    AND (COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)) <> 0"
  #160510-00019#3-s mod
   #LET l_sql = " SELECT sfaadocdt,'7',sfaa012-COALESCE(pmdt020,0),0,0,0,sfaadocno,0,sfaa017,'',sfaa006,sfaa002,'','','','asft300',sfaa013 FROM ",
   LET l_sql = " SELECT sfaa019,'7',sfaa012-COALESCE(pmdt020,0),0,0,0,sfaadocno,0,sfaa017," ,    #161202-00053#1---dujuan----sfaadocdt  改为sfaa019
               "        (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = sfaaent AND pmaal001 = sfaa017 AND pmaal002 = '",g_lang,"') pmaal004, ",
               "        sfaa006,sfaa002,",
               "        (SELECT ooag011 FROM ooag_t WHERE ooagent = sfaaent AND ooag001 = sfaa002 ) ooag011,",
               "        '','','asft300',sfaa013,sfaa010,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent = sfaaent AND imaal001 = sfaa010 AND imaal002 = '",g_lang,"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent = sfaaent AND imaal001 = sfaa010 AND imaal002 = '",g_lang,"') imaal004 FROM ",
  #160510-00019#3-e mod               
               " (SELECT sfaa019,(COALESCE(sfaa012,0)-COALESCE(sfaa050  ,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)) sfaa012,sfaadocno,sfaa017,sfaa006,sfaa002,sfaa013,sfaa010,sfaaent FROM sfaa_t ",   #161202-00053#1---dujuan----sfaadocdt  改为sfaa019  加了,sfaa010,sfaaent
               "  WHERE sfaaent = '",g_enterprise,"'",
               "    AND sfaasite = '",g_site,"'",               
               "    AND sfaa010 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND sfaa003 <> '4' ",
               "    AND sfaastus <> 'X'",
               "    AND sfaastus <> 'C'",
               "    AND sfaastus <> 'M'",   
               "    AND sfaa057 = '2' ",
               "    AND (COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)) <> 0) T1",
               " LEFT OUTER JOIN ",
               "(SELECT pmdl008,pmdt001,pmdt002,SUM(COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)) pmdt020 FROM pmds_t,pmdt_t,pmdn_t,pmdl_t ",
               "  WHERE pmdsent = pmdtent ",
               "    AND pmdssite = '",g_site,"'",
               "    AND pmdsdocno = pmdtdocno ",
               "    AND pmds000 = '8' ",   
               "    AND pmds011 = '2' ",                  
               "    AND pmdsstus = 'Y' ",
               "    AND pmdt006 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND (COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)) <> 0 ",
               "    AND pmdlent = pmdnent AND pmdldocno = pmdndocno",
               "    AND pmdlent = '",g_enterprise,"'",
               "    AND pmdndocno = pmdt001",
               "    AND pmdnseq   = pmdt002",   
               "  GROUP BY pmdl008,pmdt001,pmdt002) T2",
               "  ON T2.pmdl008 = T1.sfaadocno"   
#wujie 151023 --end                 
               
#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND sfaadocdt <= '",g_bdate,"'"
#   END IF 
   LET l_sql = l_sql,"  ORDER BY sfaa019,sfaadocno "     #161202-00053---dujuan----sfaadocdt  改为sfaa019
   PREPARE ainq100_sfaa_pre2 FROM l_sql
   DECLARE ainq100_sfaa_cur2 CURSOR FOR ainq100_sfaa_pre2
   FOREACH ainq100_sfaa_cur2 INTO g_imaa2_d[l_ac2].date,g_imaa2_d[l_ac2].type,g_imaa2_d[l_ac2].gj_num,g_imaa2_d[l_ac2].xq_num,
                                  g_imaa2_d[l_ac2].stock,g_imaa2_d[l_ac2].ck_num,g_imaa2_d[l_ac2].docno,g_imaa2_d[l_ac2].seq,g_imaa2_d[l_ac2].object,g_imaa2_d[l_ac2].object_desc,
                                  g_imaa2_d[l_ac2].ck_docno,g_imaa2_d[l_ac2].ooag001,g_imaa2_d[l_ac2].ooag011,
                                  g_imaa2_d[l_ac2].ooeg001,g_imaa2_d[l_ac2].ooeg001_desc,g_imaa2_d[l_ac2].prog,l_sfaa013,
                                  g_imaa2_d[l_ac2].sfaa010,g_imaa2_d[l_ac2].sfaa010_desc,g_imaa2_d[l_ac2].sfaa010_desc1   #2015/09/03 by stellar add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_sfaa013) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_sfaa013,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa2_d[l_ac2].gj_num = g_imaa2_d[l_ac2].gj_num * r_rate
#         END IF 
         IF cl_null(g_imaa2_d[l_ac2].gj_num) THEN LET g_imaa2_d[l_ac2].gj_num = 0 END IF #161202-00014#1
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_sfaa013,g_imaa_d[g_detail_idx].imaa006,g_imaa2_d[l_ac2].gj_num)
            RETURNING r_success,g_imaa2_d[l_ac2].gj_num
      END IF
      #160510-00019#3-s mark
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooag001) THEN
#         CALL s_desc_get_person_desc(g_imaa2_d[l_ac2].ooag001) RETURNING g_imaa2_d[l_ac2].ooag011
#      END IF
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooeg001) THEN
#         CALL s_desc_get_department_desc(g_imaa2_d[l_ac2].ooeg001) RETURNING g_imaa2_d[l_ac2].ooeg001_desc
#      END IF    
#      IF NOT cl_null(g_imaa2_d[l_ac2].object) THEN     
#         CALL s_desc_get_department_desc(g_imaa2_d[l_ac2].object) RETURNING g_imaa2_d[l_ac2].object_desc
#      END IF   
#      
#      #2015/09/03 by stellar add ----- (S)
#      IF NOT cl_null(g_imaa2_d[l_ac2].sfaa010) THEN
#         CALL s_desc_get_item_desc(g_imaa2_d[l_ac2].sfaa010)
#              RETURNING g_imaa2_d[l_ac2].sfaa010_desc,g_imaa2_d[l_ac2].sfaa010_desc1
#      END IF
#      #2015/09/03 by stellar add ----- (E)
      #160510-00019#3-e mark
      
      IF g_imaa2_d[l_ac2].gj_num <= 0 THEN
         CONTINUE FOREACH
      END IF      
      LET l_gj_sum = l_gj_sum + g_imaa2_d[l_ac2].gj_num
      LET g_imaa2_d[l_ac2].stock = l_stock + g_imaa2_d[l_ac2].gj_num
      LET l_stock = g_imaa2_d[l_ac2].stock      
      LET l_ac2 = l_ac2 + 1 
      
   END FOREACH 
   IF l_gj_sum <> 0 THEN
      LET l_ac6 = l_ac6 + 1   
      LET g_gj_sum = g_gj_sum + l_gj_sum
      LET g_imaa3_d[l_ac6].type = '7'  
      LET g_imaa3_d[l_ac6].gj_num = l_gj_sum     
      LET g_imaa3_d[l_ac6].xq_num = l_xq_sum 
      LET g_imaa3_d[l_ac6].ck_num = 0
      LET g_imaa3_d[l_ac6].stock = g_gj_sum-g_xq_sum
   END IF 

#wujie 151013 --begin   
   #委外IQC在驗量(參考數量) 
   LET l_sql = ''
   LET l_gj_sum = 0
   LET l_xq_sum = 0   
   #160510-00019#3-s mod 
   #LET l_sql = " SELECT pmdsdocdt,'10',0,0,0,(COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)),pmdtdocno,pmdtseq,pmds007,'',pmdt001,pmds002,'',pmds003,'','apmt530',pmdt019 FROM pmds_t,pmdt_t ",
   LET l_sql = " SELECT pmdsdocdt,'10',0,0,0,(COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)),pmdtdocno,pmdtseq,pmds007,",
               "        (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = pmdsent AND pmaal001 = pmds007 AND pmaal002 = '",g_lang,"') pmaal004 ,",               
               "        pmdt001,pmds002,",
               "        (SELECT ooag011 FROM ooag_t WHERE ooagent = pmdsent AND ooag001 = pmds002 ) ooag011,",
               "        pmds003,",
               "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdsent AND ooefl001 = pmds001 AND ooefl002 = '",g_lang,") ooefl003,",
               "        'apmt530',pmdt019 FROM pmds_t,pmdt_t ",
               
   #160510-00019#3-e mod 
               "  WHERE pmdsent = pmdtent ",
               "    AND pmdssite = '",g_site,"'",
               "    AND pmdsdocno = pmdtdocno ",
#               "    AND pmds000 = '12' ",
#               "    AND pmds011 IN ('2','6')",
               "    AND pmds000 = '8' ",   #add by lixh 20150210
               "    AND pmds011 = '2' ",   #add by lixh 20150210                
               "    AND pmdsstus = 'Y' ",
               "    AND pmdt006 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND (COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)) <> 0 "
               
               
#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND pmdsdocdt <= '",g_bdate,"'"
#   END IF 
   LET l_sql = l_sql,"  ORDER BY pmdsdocdt,pmdtdocno,pmdtseq"   
   PREPARE ainq100_pmds_pre1 FROM l_sql
   DECLARE ainq100_pmds_cur1 CURSOR FOR ainq100_pmds_pre1
   LET l_ck_sum = 0
   FOREACH ainq100_pmds_cur1 INTO g_imaa2_d[l_ac2].date,g_imaa2_d[l_ac2].type,g_imaa2_d[l_ac2].gj_num,g_imaa2_d[l_ac2].xq_num,
                                  g_imaa2_d[l_ac2].stock,g_imaa2_d[l_ac2].ck_num,g_imaa2_d[l_ac2].docno,g_imaa2_d[l_ac2].seq,g_imaa2_d[l_ac2].object,g_imaa2_d[l_ac2].object_desc,
                                  g_imaa2_d[l_ac2].ck_docno,g_imaa2_d[l_ac2].ooag001,g_imaa2_d[l_ac2].ooag011,
                                  g_imaa2_d[l_ac2].ooeg001,g_imaa2_d[l_ac2].ooeg001_desc,g_imaa2_d[l_ac2].prog,l_pmdt019
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_pmdt019) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_pmdt019,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa2_d[l_ac2].ck_num = g_imaa2_d[l_ac2].ck_num * r_rate
#         END IF
         IF cl_null(g_imaa2_d[l_ac2].ck_num) THEN LET g_imaa2_d[l_ac2].ck_num = 0 END IF #161202-00014#1
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_pmdt019,g_imaa_d[g_detail_idx].imaa006,g_imaa2_d[l_ac2].ck_num)
            RETURNING r_success,g_imaa2_d[l_ac2].ck_num
      END IF
      IF g_imaa2_d[l_ac2].ck_num <= 0 THEN
         CONTINUE FOREACH
      END IF
      #160510-00019#3-s mark
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooag001) THEN
#         CALL s_desc_get_person_desc(g_imaa2_d[l_ac2].ooag001) RETURNING g_imaa2_d[l_ac2].ooag011
#      END IF
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooeg001) THEN
#         CALL s_desc_get_department_desc(g_imaa2_d[l_ac2].ooeg001) RETURNING g_imaa2_d[l_ac2].ooeg001_desc
#      END IF  
#      IF NOT cl_null(g_imaa2_d[l_ac2].object) THEN      
#         CALL s_desc_get_trading_partner_abbr_desc(g_imaa2_d[l_ac2].object) RETURNING g_imaa2_d[l_ac2].object_desc 
#      END IF  
      #160510-00019#3-e mark      
      LET g_imaa2_d[l_ac2].stock = l_stock 
      
      LET l_ac2 = l_ac2 + 1 
      
   END FOREACH    
   IF l_ck_sum <> 0 THEN
      LET l_ac6 = l_ac6 + 1   
      LET g_gj_sum = g_gj_sum + l_gj_sum
      LET g_imaa3_d[l_ac6].type = '10'  
      LET g_imaa3_d[l_ac6].gj_num = l_gj_sum     
      LET g_imaa3_d[l_ac6].xq_num = l_xq_sum 
      LET g_imaa3_d[l_ac6].ck_num = l_ck_sum
      LET g_imaa3_d[l_ac6].stock = g_gj_sum-g_xq_sum
      
      #add by lixh 20150827
      IF l_ac6 > 1 AND g_imaa3_d[l_ac6-1].type = '7' THEN
         LET g_imaa3_d[l_ac6-1].gj_num = g_imaa3_d[l_ac6-1].gj_num - g_imaa3_d[l_ac6].gj_num
         LET g_imaa3_d[l_ac6-1].stock = g_imaa3_d[l_ac6-1].stock - g_imaa3_d[l_ac6].gj_num
         LET g_imaa3_d[l_ac6].stock = g_gj_sum-g_xq_sum-g_imaa3_d[l_ac6].gj_num
         LET g_gj_sum = g_gj_sum - l_gj_sum
      END IF
      #add by lixh 20150827
   END IF
#wujie 151013 --end  

   #IQC在驗量(供給)
   LET l_sql = ''
   LET l_gj_sum = 0
   LET l_xq_sum = 0
#160510-00019#3-s mod    
#   LET l_sql = " SELECT pmdsdocdt,'8',(COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)),0,0,0,pmdtdocno,pmdtseq,pmds007,'',pmdt001,pmds002,'',pmds003,'','apmt530',pmdt019, ",
#               "        '','','' ",   #2015/09/03 by stellar add
   LET l_sql = " SELECT pmdsdocdt,'8',(COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)),0,0,0,pmdtdocno,pmdtseq,pmds007,",
               "        (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = pmdsent AND pmaal001 = pmds007 AND pmaal002 = '",g_lang,"') pmaal004 ",
               "        pmdt001,pmds002,",
               "        (SELECT ooag011 FROM ooag_t WHERE ooagent = pmdsent AND ooag001 = pmds002 ) ooag011,",
               "        pmds003,",   
               "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdsent AND ooefl001 = pmds003 AND ooefl002 = '",g_lang,"') ooefl003 ",
               "        'apmt530',pmdt019,'','','' ", 
#160510-00019#3-e mod                
               "   FROM pmds_t,pmdt_t ",
               "  WHERE pmdsent = pmdtent ",
               "    AND pmdsent = ",g_enterprise,  #151012-00011 by whitney add
               "    AND pmdssite = '",g_site,"'",
               "    AND pmdsdocno = pmdtdocno ",
               "    AND pmds000 IN ('1','2','3','4') ",
               "    AND pmds011 IN ('1','3','7','8','9','10')",
#               "    AND pmds000 IN ('1','2','8') ",                  #add by lixh 20150210
#               "    AND pmds011 IN ('1','2','3','7','8','9','10')",  #add by lixh 20150210 
               "    AND pmdsstus = 'Y' ",
               "    AND pmdt006 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND (COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)) <> 0 "
               
               
#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND pmdsdocdt <= '",g_bdate,"'"
#   END IF 
   LET l_sql = l_sql,"  ORDER BY pmdsdocdt,pmdtdocno,pmdtseq "   
   PREPARE ainq100_pmds_pre FROM l_sql
   DECLARE ainq100_pmds_cur CURSOR FOR ainq100_pmds_pre
   FOREACH ainq100_pmds_cur INTO g_imaa2_d[l_ac2].date,g_imaa2_d[l_ac2].type,g_imaa2_d[l_ac2].gj_num,g_imaa2_d[l_ac2].xq_num,
                                 g_imaa2_d[l_ac2].stock,g_imaa2_d[l_ac2].ck_num,g_imaa2_d[l_ac2].docno,g_imaa2_d[l_ac2].seq,g_imaa2_d[l_ac2].object,g_imaa2_d[l_ac2].object_desc,
                                 g_imaa2_d[l_ac2].ck_docno,g_imaa2_d[l_ac2].ooag001,g_imaa2_d[l_ac2].ooag011,
                                 g_imaa2_d[l_ac2].ooeg001,g_imaa2_d[l_ac2].ooeg001_desc,g_imaa2_d[l_ac2].prog,l_pmdt019,
                                 g_imaa2_d[l_ac2].sfaa010,g_imaa2_d[l_ac2].sfaa010_desc,g_imaa2_d[l_ac2].sfaa010_desc1   #2015/09/03 by stellar add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_pmdt019) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_pmdt019,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa2_d[l_ac2].gj_num = g_imaa2_d[l_ac2].gj_num * r_rate
#         END IF   
         IF cl_null(g_imaa2_d[l_ac2].gj_num) THEN LET g_imaa2_d[l_ac2].gj_num = 0 END IF #161202-00014#1
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_pmdt019,g_imaa_d[g_detail_idx].imaa006,g_imaa2_d[l_ac2].gj_num)
            RETURNING r_success,g_imaa2_d[l_ac2].gj_num
      END IF
      #160510-00019#3-s
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooag001) THEN
#         CALL s_desc_get_person_desc(g_imaa2_d[l_ac2].ooag001) RETURNING g_imaa2_d[l_ac2].ooag011
#      END IF
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooeg001) THEN
#         CALL s_desc_get_department_desc(g_imaa2_d[l_ac2].ooeg001) RETURNING g_imaa2_d[l_ac2].ooeg001_desc
#      END IF 
#      IF NOT cl_null(g_imaa2_d[l_ac2].object) THEN      
#         CALL s_desc_get_trading_partner_abbr_desc(g_imaa2_d[l_ac2].object) RETURNING g_imaa2_d[l_ac2].object_desc 
#      END IF 
      #160510-00019#3-e      
      IF g_imaa2_d[l_ac2].gj_num <= 0 THEN
         CONTINUE FOREACH
      END IF      
      LET l_gj_sum = l_gj_sum + g_imaa2_d[l_ac2].gj_num
      LET g_imaa2_d[l_ac2].stock = l_stock + g_imaa2_d[l_ac2].gj_num
      LET l_stock = g_imaa2_d[l_ac2].stock      
      LET l_ac2 = l_ac2 + 1 
      
   END FOREACH      
   IF l_gj_sum <> 0 THEN
      LET l_ac6 = l_ac6 + 1   
      LET g_gj_sum = g_gj_sum + l_gj_sum
      LET g_imaa3_d[l_ac6].type = '8'  
      LET g_imaa3_d[l_ac6].gj_num = l_gj_sum     
      LET g_imaa3_d[l_ac6].xq_num = l_xq_sum 
      LET g_imaa3_d[l_ac6].ck_num = 0
      LET g_imaa3_d[l_ac6].stock = g_gj_sum-g_xq_sum
   END IF   
   #FQC在驗量(供給) 
   LET l_sql = ''
   LET l_gj_sum = 0
   LET l_xq_sum = 0
   #160510-00019#3-s
#   LET l_sql = " SELECT qcbadocdt,'9',(COALESCE(qcba017,0)-COALESCE(qcba023,0)),0,0,0,qcbadocno,qcbaseq,qcba005,'',qcba003,qcba900,'',qcba901,'','aqct300',qcba016, ",
#               "        '','','' ",   #2015/09/03 by stellar add
   LET l_sql = " SELECT qcbadocdt,'9',(COALESCE(qcba017,0)-COALESCE(qcba023,0)),0,0,0,qcbadocno,qcbaseq,qcba005,",
               "        (SELECT pmaal004 FROM pmaal_t WHERE pmaaletn = qcbaent AND pmaal001 = qcba005 AND pmaal001 = '",g_lang,"' ) pmaal004,",
               "        qcba003,qcba900,",
               "        (SELECT ooag011 FROM ooag_t WHERE ooagent = qcbaent AND ooag001 = qcba900 ) ooag011 ,",
               "        qcba901,",
               "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = qcbaent AND ooefl001 = qcba901 AND ooefl002 = '",g_lang,"') ooefl003 ",
               "        'aqct300',qcba016,'','','' ",
               
   #160510-00019#3-e
               "   FROM qcba_t ",
               "  WHERE qcbaent = ",g_enterprise,  #151012-00011 by whitney modify
               "    AND qcbasite = '",g_site,"'",
               "    AND qcba000 = '2' ",
               "    AND qcbastus = 'Y' ",
               "    AND qcba010 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND qcba013 = '",g_imaa_d[g_detail_idx].imae011,"'",
               "    AND COALESCE(qcba017,0) <> COALESCE(qcba023,0) "
               

#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND qcbadocdt <= '",g_bdate,"'"
#   END IF 
   LET l_sql = l_sql,"  ORDER BY qcbadocdt,qcbadocno,qcbaseq "   
   PREPARE ainq100_qcba_pre FROM l_sql
   DECLARE ainq100_qcba_cur CURSOR FOR ainq100_qcba_pre
   FOREACH ainq100_qcba_cur INTO g_imaa2_d[l_ac2].date,g_imaa2_d[l_ac2].type,g_imaa2_d[l_ac2].gj_num,g_imaa2_d[l_ac2].xq_num,
                                 g_imaa2_d[l_ac2].stock,g_imaa2_d[l_ac2].ck_num,g_imaa2_d[l_ac2].docno,g_imaa2_d[l_ac2].seq,g_imaa2_d[l_ac2].object,g_imaa2_d[l_ac2].object_desc,
                                 g_imaa2_d[l_ac2].ck_docno,g_imaa2_d[l_ac2].ooag001,g_imaa2_d[l_ac2].ooag011,
                                 g_imaa2_d[l_ac2].ooeg001,g_imaa2_d[l_ac2].ooeg001_desc,g_imaa2_d[l_ac2].prog,l_qcba016,
                                 g_imaa2_d[l_ac2].sfaa010,g_imaa2_d[l_ac2].sfaa010_desc,g_imaa2_d[l_ac2].sfaa010_desc1   #2015/09/03 by stellar add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_qcba016) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_qcba016,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa2_d[l_ac2].gj_num = g_imaa2_d[l_ac2].gj_num * r_rate
#         END IF  
         IF cl_null(g_imaa2_d[l_ac2].gj_num) THEN LET g_imaa2_d[l_ac2].gj_num = 0 END IF   #161202-00014#1
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_qcba016,g_imaa_d[g_detail_idx].imaa006,g_imaa2_d[l_ac2].gj_num)
            RETURNING r_success,g_imaa2_d[l_ac2].gj_num
      END IF
      #160510-00019#3-s
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooag001) THEN
#         CALL s_desc_get_person_desc(g_imaa2_d[l_ac2].ooag001) RETURNING g_imaa2_d[l_ac2].ooag011
#      END IF
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooeg001) THEN
#         CALL s_desc_get_department_desc(g_imaa2_d[l_ac2].ooeg001) RETURNING g_imaa2_d[l_ac2].ooeg001_desc
#      END IF    
#      IF NOT cl_null(g_imaa2_d[l_ac2].object) THEN      
#         CALL s_desc_get_trading_partner_abbr_desc(g_imaa2_d[l_ac2].object) RETURNING g_imaa2_d[l_ac2].object_desc 
#      END IF 
      #160510-00019#3-e      
      IF g_imaa2_d[l_ac2].gj_num <= 0 THEN
         CONTINUE FOREACH
      END IF      
      LET l_gj_sum = l_gj_sum + g_imaa2_d[l_ac2].gj_num
      LET g_imaa2_d[l_ac2].stock = l_stock + g_imaa2_d[l_ac2].gj_num
      LET l_stock = g_imaa2_d[l_ac2].stock  
      
      LET l_ac2 = l_ac2 + 1 
      
   END FOREACH     
   IF l_gj_sum <> 0 THEN
      LET l_ac6 = l_ac6 + 1   
      LET g_gj_sum = g_gj_sum + l_gj_sum
      LET g_imaa3_d[l_ac6].type = '9'  
      LET g_imaa3_d[l_ac6].gj_num = l_gj_sum     
      LET g_imaa3_d[l_ac6].xq_num = l_xq_sum 
      LET g_imaa3_d[l_ac6].ck_num = 0
      LET g_imaa3_d[l_ac6].stock = g_gj_sum-g_xq_sum
   END IF
##wujie 151013 --begin   
#   #委外IQC在驗量(參考數量) 
#   LET l_sql = ''
#   LET l_gj_sum = 0
#   LET l_xq_sum = 0   
#   LET l_sql = " SELECT pmdsdocdt,'10',0,0,0,(COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)),pmdtdocno,pmdtseq,pmds007,'',pmdt001,pmds002,'',pmds003,'','apmt530',pmdt019, ",
#               "        '','','' ",   #2015/09/03 by stellar add
#               "   FROM pmds_t,pmdt_t ",
#               "  WHERE pmdsent = pmdtent ",
#               "    AND pmdsent = ",g_enterprise,  #151012-00011 by whitney add
#               "    AND pmdssite = '",g_site,"'",
#               "    AND pmdsdocno = pmdtdocno ",
##               "    AND pmds000 = '12' ",
##               "    AND pmds011 IN ('2','6')",
#               "    AND pmds000 = '8' ",   #add by lixh 20150210
#               "    AND pmds011 = '2' ",   #add by lixh 20150210                
#               "    AND pmdsstus = 'Y' ",
#               "    AND pmdt006 = '",g_imaa_d[g_detail_idx].imaa001,"'",
#               "    AND (COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)) <> 0 "
#               
#               
##   IF g_gxdate <> '5' THEN
##      LET l_sql = l_sql," AND pmdsdocdt <= '",g_bdate,"'"
##   END IF 
#   LET l_sql = l_sql,"  ORDER BY pmdsdocdt,pmdtdocno,pmdtseq"   
#   PREPARE ainq100_pmds_pre1 FROM l_sql
#   DECLARE ainq100_pmds_cur1 CURSOR FOR ainq100_pmds_pre1
#   LET l_ck_sum = 0
#   FOREACH ainq100_pmds_cur1 INTO g_imaa2_d[l_ac2].date,g_imaa2_d[l_ac2].type,g_imaa2_d[l_ac2].gj_num,g_imaa2_d[l_ac2].xq_num,
#                                  g_imaa2_d[l_ac2].stock,g_imaa2_d[l_ac2].ck_num,g_imaa2_d[l_ac2].docno,g_imaa2_d[l_ac2].seq,g_imaa2_d[l_ac2].object,g_imaa2_d[l_ac2].object_desc,
#                                  g_imaa2_d[l_ac2].ck_docno,g_imaa2_d[l_ac2].ooag001,g_imaa2_d[l_ac2].ooag011,
#                                  g_imaa2_d[l_ac2].ooeg001,g_imaa2_d[l_ac2].ooeg001_desc,g_imaa2_d[l_ac2].prog,l_pmdt019,
#                                  g_imaa2_d[l_ac2].sfaa010,g_imaa2_d[l_ac2].sfaa010_desc,g_imaa2_d[l_ac2].sfaa010_desc1   #2015/09/03 by stellar add
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()         
#         EXIT FOREACH
#      END IF  
#      IF NOT cl_null(l_pmdt019) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
##         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_pmdt019,g_imaa_d[g_detail_idx].imaa006)
##              RETURNING r_success,r_rate   
##         IF r_success THEN
##            LET g_imaa2_d[l_ac2].ck_num = g_imaa2_d[l_ac2].ck_num * r_rate
##         END IF    
#         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_pmdt019,g_imaa_d[g_detail_idx].imaa006,g_imaa2_d[l_ac2].ck_num)
#            RETURNING r_success,g_imaa2_d[l_ac2].ck_num
#      END IF
#      IF g_imaa2_d[l_ac2].ck_num <= 0 THEN
#         CONTINUE FOREACH
#      END IF
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooag001) THEN
#         CALL s_desc_get_person_desc(g_imaa2_d[l_ac2].ooag001) RETURNING g_imaa2_d[l_ac2].ooag011
#      END IF
#      IF NOT cl_null(g_imaa2_d[l_ac2].ooeg001) THEN
#         CALL s_desc_get_department_desc(g_imaa2_d[l_ac2].ooeg001) RETURNING g_imaa2_d[l_ac2].ooeg001_desc
#      END IF  
#      IF NOT cl_null(g_imaa2_d[l_ac2].object) THEN      
#         CALL s_desc_get_trading_partner_abbr_desc(g_imaa2_d[l_ac2].object) RETURNING g_imaa2_d[l_ac2].object_desc 
#      END IF        
#      LET g_imaa2_d[l_ac2].stock = l_stock 
#      
#      LET l_ac2 = l_ac2 + 1 
#      
#   END FOREACH    
#   IF l_ck_sum <> 0 THEN
#      LET l_ac6 = l_ac6 + 1   
#      LET g_gj_sum = g_gj_sum + l_gj_sum
#      LET g_imaa3_d[l_ac6].type = '10'  
#      LET g_imaa3_d[l_ac6].gj_num = l_gj_sum     
#      LET g_imaa3_d[l_ac6].xq_num = l_xq_sum 
#      LET g_imaa3_d[l_ac6].ck_num = l_ck_sum
#      LET g_imaa3_d[l_ac6].stock = g_gj_sum-g_xq_sum
#   END IF   
##wujie 151013 --end
   #備置量(參考數量)
   LET l_sql = ''
   LET l_gj_sum = 0
   LET l_xq_sum = 0
   LET l_ck_sum = 0
   LET l_sql = " SELECT '','11',0,0,0,SUM(COALESCE(inag021,0)),'','','','','','','','','','',inag032, ",
               "        '','','' ",   #2015/09/03 by stellar add
               "   FROM inag_t ",
               "  WHERE inagent = ",g_enterprise,  #151012-00011 by whitney modify
               "    AND inagsite = '",g_site,"'",
               "    AND inag001 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND inag010 = 'Y' "

   PREPARE ainq100_inag_pre1 FROM l_sql
   DECLARE ainq100_inag_cur1 CURSOR FOR ainq100_inag_pre1
   FOREACH ainq100_inag_cur1 INTO g_imaa2_d[l_ac2].date,g_imaa2_d[l_ac2].type,g_imaa2_d[l_ac2].gj_num,g_imaa2_d[l_ac2].xq_num,
                                  g_imaa2_d[l_ac2].stock,g_imaa2_d[l_ac2].ck_num,g_imaa2_d[l_ac2].docno,g_imaa2_d[l_ac2].seq,g_imaa2_d[l_ac2].object,g_imaa2_d[l_ac2].object_desc,
                                  g_imaa2_d[l_ac2].ck_docno,g_imaa2_d[l_ac2].ooag001,g_imaa2_d[l_ac2].ooag011,
                                  g_imaa2_d[l_ac2].ooeg001,g_imaa2_d[l_ac2].ooeg001_desc,g_imaa2_d[l_ac2].prog,l_inag032,
                                  g_imaa2_d[l_ac2].sfaa010,g_imaa2_d[l_ac2].sfaa010_desc,g_imaa2_d[l_ac2].sfaa010_desc1   #2015/09/03 by stellar add

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_inag032) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
      
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_inag032,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa2_d[l_ac2].ck_num = g_imaa2_d[l_ac2].ck_num * r_rate
#         END IF 
         IF cl_null(g_imaa2_d[l_ac2].ck_num) THEN LET g_imaa2_d[l_ac2].ck_num = 0 END IF  #161202-00014#1
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_inag032,g_imaa_d[g_detail_idx].imaa006,g_imaa2_d[l_ac2].ck_num)
            RETURNING r_success,g_imaa2_d[l_ac2].ck_num
      END IF
      IF NOT cl_null(g_imaa2_d[l_ac2].ooag001) THEN
         CALL s_desc_get_person_desc(g_imaa2_d[l_ac2].ooag001) RETURNING g_imaa2_d[l_ac2].ooag011
      END IF
      IF NOT cl_null(g_imaa2_d[l_ac2].ooeg001) THEN
         CALL s_desc_get_department_desc(g_imaa2_d[l_ac2].ooeg001) RETURNING g_imaa2_d[l_ac2].ooeg001_desc
      END IF  
      IF g_imaa2_d[l_ac2].ck_num <= 0 THEN
         CONTINUE FOREACH
      END IF
      LET g_imaa2_d[l_ac2].stock = l_stock       
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
   IF l_ck_sum <> 0 THEN
      LET l_ac6 = l_ac6 + 1   
      LET g_gj_sum = g_gj_sum + l_gj_sum
      LET g_imaa3_d[l_ac6].type = '10'  
      LET g_imaa3_d[l_ac6].gj_num = l_gj_sum     
      LET g_imaa3_d[l_ac6].xq_num = l_xq_sum 
      LET g_imaa3_d[l_ac6].ck_num = l_ck_sum
      LET g_imaa3_d[l_ac6].stock = g_gj_sum-g_xq_sum
   END IF    
   IF l_ac2 > 1 THEN
#      CALL g_imaa2_d.deleteElement(g_imaa2_d.getLength())    
      LET g_imaa2_d[l_ac2].type = '12'
      LET g_imaa2_d[l_ac2].gj_num = g_gj_sum
      LET g_imaa2_d[l_ac2].xq_num = g_xq_sum
      LET g_imaa2_d[l_ac2].stock = g_gj_sum - g_xq_sum
   ELSE
      LET g_imaa2_d[2].type = '12'
      LET g_imaa2_d[2].gj_num = g_gj_sum
      LET g_imaa2_d[2].xq_num = g_xq_sum
      LET g_imaa2_d[2].stock = g_gj_sum - g_xq_sum      
   END IF    
   LET g_imaa3_d[l_ac6+1].type = '12'
   LET g_imaa3_d[l_ac6+1].gj_num = g_gj_sum
   LET g_imaa3_d[l_ac6+1].xq_num = g_xq_sum
   LET g_imaa3_d[l_ac6+1].stock = g_gj_sum - g_xq_sum   
#   LET l_ac2 = l_ac2 - 1   
   LET l_zj_sum = l_gj_sum - l_xq_sum
#   DISPLAY l_gj_sum TO sum1
#   DISPLAY l_xq_sum TO sum2
#   DISPLAY l_zj_sum TO sum3
#   LET g_sum1 = l_gj_sum
#   LET g_sum2 = l_xq_sum
#   LET g_sum3 = l_zj_sum
   
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="ainq100.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION ainq100_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa001
            LET ls_sql = "SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_imaa_d[l_ac].imaa001_desc = '', g_rtn_fields[1] , ''
            LET g_imaa_d[l_ac].imaa001_desc_desc = '', g_rtn_fields[2] , ''            
            DISPLAY BY NAME g_imaa_d[l_ac].imaa001_desc
            DISPLAY BY NAME g_imaa_d[l_ac].imaa001_desc_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa009
            LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_imaa_d[l_ac].imaa009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaa_d[l_ac].imaa009_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa006
            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_imaa_d[l_ac].imaa006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaa_d[l_ac].imaa006_desc
            
            CALL s_desc_get_acc_desc('201',g_imaa_d[l_ac].imaf051) RETURNING g_imaa_d[l_ac].imaf051_desc
            DISPLAY BY NAME g_imaa_d[l_ac].imaf051_desc
            CALL s_desc_get_acc_desc('202',g_imaa_d[l_ac].imaf111) RETURNING g_imaa_d[l_ac].imaf111_desc
            DISPLAY BY NAME g_imaa_d[l_ac].imaf111_desc  
            CALL s_desc_get_acc_desc('203',g_imaa_d[l_ac].imaf141) RETURNING g_imaa_d[l_ac].imaf141_desc
            DISPLAY BY NAME g_imaa_d[l_ac].imaf141_desc   
            CALL s_desc_get_acc_desc('204',g_imaa_d[l_ac].imae011) RETURNING g_imaa_d[l_ac].imae011_desc
            DISPLAY BY NAME g_imaa_d[l_ac].imae011_desc           
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainq100.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION ainq100_filter()
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
      CONSTRUCT g_wc_filter ON imaa001,imaa009,imaa006,imaf013,imaf051,imaf111,imaf141,imae011
                          FROM s_detail1[1].b_imaa001,s_detail1[1].b_imaa009,s_detail1[1].b_imaa006, 
                              s_detail1[1].b_imaf013,s_detail1[1].b_imaf051,s_detail1[1].b_imaf111,s_detail1[1].b_imaf141, 
                              s_detail1[1].b_imae011
 
         BEFORE CONSTRUCT
                     DISPLAY ainq100_filter_parser('imaa001') TO s_detail1[1].b_imaa001
            DISPLAY ainq100_filter_parser('imaa009') TO s_detail1[1].b_imaa009
            DISPLAY ainq100_filter_parser('imaa006') TO s_detail1[1].b_imaa006
            DISPLAY ainq100_filter_parser('imaf013') TO s_detail1[1].b_imaf013
            DISPLAY ainq100_filter_parser('imaf051') TO s_detail1[1].b_imaf051
            DISPLAY ainq100_filter_parser('imaf111') TO s_detail1[1].b_imaf111
            DISPLAY ainq100_filter_parser('imaf141') TO s_detail1[1].b_imaf141
            DISPLAY ainq100_filter_parser('imae011') TO s_detail1[1].b_imae011
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_imaa001>>----
         #Ctrlp:construct.c.page1.b_imaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa001
            #add-point:ON ACTION controlp INFIELD b_imaa001 name="construct.c.filter.page1.b_imaa001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa001  #顯示到畫面上
            NEXT FIELD b_imaa001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa001_desc>>----
         #----<<b_imaa001_desc_desc>>----
         #----<<b_imaa009>>----
         #Ctrlp:construct.c.page1.b_imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa009
            #add-point:ON ACTION controlp INFIELD b_imaa009 name="construct.c.filter.page1.b_imaa009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa009  #顯示到畫面上
            NEXT FIELD b_imaa009                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa009_desc>>----
         #----<<b_imaa006>>----
         #Ctrlp:construct.c.page1.b_imaa006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa006
            #add-point:ON ACTION controlp INFIELD b_imaa006 name="construct.c.filter.page1.b_imaa006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa006  #顯示到畫面上
            NEXT FIELD b_imaa006                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa006_desc>>----
         #----<<b_imaf013>>----
         #Ctrlp:construct.c.filter.page1.b_imaf013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf013
            #add-point:ON ACTION controlp INFIELD b_imaf013 name="construct.c.filter.page1.b_imaf013"
            
            #END add-point
 
 
         #----<<b_imaf051>>----
         #Ctrlp:construct.c.page1.b_imaf051
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf051
            #add-point:ON ACTION controlp INFIELD b_imaf051 name="construct.c.filter.page1.b_imaf051"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imck001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaf051  #顯示到畫面上
            NEXT FIELD b_imaf051                     #返回原欄位
    


            #END add-point
 
 
         #----<<imaf051_desc>>----
         #----<<b_imaf111>>----
         #Ctrlp:construct.c.page1.b_imaf111
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf111
            #add-point:ON ACTION controlp INFIELD b_imaf111 name="construct.c.filter.page1.b_imaf111"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imcd111()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaf111  #顯示到畫面上
            NEXT FIELD b_imaf111                     #返回原欄位
    


            #END add-point
 
 
         #----<<imaf111_desc>>----
         #----<<b_imaf141>>----
         #Ctrlp:construct.c.page1.b_imaf141
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf141
            #add-point:ON ACTION controlp INFIELD b_imaf141 name="construct.c.filter.page1.b_imaf141"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '203'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaf141  #顯示到畫面上
            NEXT FIELD b_imaf141                     #返回原欄位
    


            #END add-point
 
 
         #----<<imaf141_desc>>----
         #----<<b_imae011>>----
         #Ctrlp:construct.c.page1.b_imae011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imae011
            #add-point:ON ACTION controlp INFIELD b_imae011 name="construct.c.filter.page1.b_imae011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imcf011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imae011  #顯示到畫面上
            NEXT FIELD b_imae011                     #返回原欄位
    


            #END add-point
 
 
         #----<<imae011_desc>>----
 
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
 
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
#          ON ACTION controlp INFIELD b_imaa001
#             INITIALIZE g_qryparam.* TO NULL
#             LET g_qryparam.state = 'c'
#             LET g_qryparam.reqry = FALSE
#             CALL q_imaf001_15()                           #呼叫開窗
#             DISPLAY g_qryparam.return1 TO b_imaa001  #顯示到畫面上
#
#             NEXT FIELD b_imaa001
#             
#          ON ACTION controlp INFIELD b_imaa009
#             INITIALIZE g_qryparam.* TO NULL
#             LET g_qryparam.state = 'c'
#             LET g_qryparam.reqry = FALSE
#             CALL q_rtax001()                       #呼叫開窗
#             DISPLAY g_qryparam.return1 TO b_imaa009  #顯示到畫面上
#
#             NEXT FIELD b_imaa009
#             
#          ON ACTION controlp INFIELD b_imaa006
#             INITIALIZE g_qryparam.* TO NULL
#             LET g_qryparam.state = 'c'
#             LET g_qryparam.reqry = FALSE
#             CALL q_ooca001_1()                      #呼叫開窗
#             DISPLAY g_qryparam.return1 TO b_imaa006   #顯示到畫面上
#
#             NEXT FIELD b_imaa006
#                         
#          ON ACTION controlp INFIELD b_imaf051
#             INITIALIZE g_qryparam.* TO NULL
#             LET g_qryparam.state = 'c'
#             LET g_qryparam.reqry = FALSE
#             CALL q_imck001()                      #呼叫開窗
#             DISPLAY g_qryparam.return1 TO b_imaf051   #顯示到畫面上
#
#             NEXT FIELD b_imaf051 
#           
#          ON ACTION controlp INFIELD b_imaf111
#             INITIALIZE g_qryparam.* TO NULL
#             LET g_qryparam.state = 'c'
#             LET g_qryparam.reqry = FALSE
#             CALL q_imcd111()                      #呼叫開窗
#             DISPLAY g_qryparam.return1 TO b_imaf111   #顯示到畫面上
#
#             NEXT FIELD b_imaf111             
#             
#          ON ACTION controlp INFIELD b_imaf141
#             INITIALIZE g_qryparam.* TO NULL
#             LET g_qryparam.state = 'c'
#             LET g_qryparam.reqry = FALSE
#             LET g_qryparam.arg1 = '203'
#             CALL q_oocq002()                      #呼叫開窗
#             DISPLAY g_qryparam.return1 TO b_imaf141   #顯示到畫面上
#
#             NEXT FIELD b_imaf141  
#             
#          ON ACTION controlp INFIELD b_imae011
#             INITIALIZE g_qryparam.* TO NULL
#             LET g_qryparam.state = 'c'
#             LET g_qryparam.reqry = FALSE
#             CALL q_imcf011()                      #呼叫開窗
#             DISPLAY g_qryparam.return1 TO b_imae011   #顯示到畫面上
#
#             NEXT FIELD b_imae011         
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
 
      CALL ainq100_filter_show('imaa001','b_imaa001')
   CALL ainq100_filter_show('imaa009','b_imaa009')
   CALL ainq100_filter_show('imaa006','b_imaa006')
   CALL ainq100_filter_show('imaf013','b_imaf013')
   CALL ainq100_filter_show('imaf051','b_imaf051')
   CALL ainq100_filter_show('imaf111','b_imaf111')
   CALL ainq100_filter_show('imaf141','b_imaf141')
   CALL ainq100_filter_show('imae011','b_imae011')
 
 
   CALL ainq100_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="ainq100.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION ainq100_filter_parser(ps_field)
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
 
{<section id="ainq100.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION ainq100_filter_show(ps_field,ps_object)
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
   LET ls_condition = ainq100_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="ainq100.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION ainq100_detail_action_trans()
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
 
{<section id="ainq100.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION ainq100_detail_index_setting()
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
            IF g_imaa_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_imaa_d.getLength() AND g_imaa_d.getLength() > 0
            LET g_detail_idx = g_imaa_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_imaa_d.getLength() THEN
               LET g_detail_idx = g_imaa_d.getLength()
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
 
{<section id="ainq100.mask_functions" >}
 &include "erp/ain/ainq100_mask.4gl"
 
{</section>}
 
{<section id="ainq100.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 開啟查詢
# Memo...........:
# Usage..........: CALL ainq100_query()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainq100_query()
DEFINE ls_wc   STRING    
   #清除畫面
#   CLEAR FORM  
   CALL g_imaa_d.clear()
   CALL g_imaa2_d.clear()
   CALL g_inai_d.clear()
   CALL g_inaj_d.clear()
   CALL g_inag_d.clear()   
   
   LET ls_wc = g_wc
   CALL ainq100_construct()
   
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL ainq100_b_fill()
      RETURN
   END IF
   CALL ainq100_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 欄位查詢
# Memo...........:
# Usage..........: CALL ainq100_construct()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainq100_construct()
#   CLEAR FORM
   CALL g_imaa_d.clear()
   CALL g_imaa2_d.clear()
   CALL g_inai_d.clear()
   CALL g_inaj_d.clear()
   CALL g_inag_d.clear()
   LET g_action_choice = ""
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc_filter TO NULL
   LET g_qryparam.state = 'c'
   CALL cl_set_combo_scc('imaf013','2022')
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
       CONSTRUCT BY NAME g_wc ON imaa001,imaa009,imaa006,imaf013,imaf051,imaf111,imaf141,imae011
                    
          BEFORE CONSTRUCT
          
          ON ACTION controlp INFIELD imaa001
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             CALL q_imaf001_15()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO imaa001  #顯示到畫面上

             NEXT FIELD imaa001
             
          ON ACTION controlp INFIELD imaa009
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             CALL q_rtax001()                       #呼叫開窗
             DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上

             NEXT FIELD imaa009
             
          ON ACTION controlp INFIELD imaa006
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             CALL q_ooca001_1()                      #呼叫開窗
             DISPLAY g_qryparam.return1 TO imaa006   #顯示到畫面上

             NEXT FIELD imaa006
                         
          ON ACTION controlp INFIELD imaf051
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             CALL q_imcc051()                      #呼叫開窗
             DISPLAY g_qryparam.return1 TO imaf051   #顯示到畫面上

             NEXT FIELD imaf051 
           
          ON ACTION controlp INFIELD imaf111
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             CALL q_imcd111()                      #呼叫開窗
             DISPLAY g_qryparam.return1 TO imaf111   #顯示到畫面上

             NEXT FIELD imaf111             
             
          ON ACTION controlp INFIELD imaf141
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.arg1 = '203'
             CALL q_oocq002()                      #呼叫開窗
             DISPLAY g_qryparam.return1 TO imaf141   #顯示到畫面上

             NEXT FIELD imaf141  
             
          ON ACTION controlp INFIELD imae011
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             CALL q_imcf011()                      #呼叫開窗
             DISPLAY g_qryparam.return1 TO imae011   #顯示到畫面上

             NEXT FIELD imae011               
             
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
# Descriptions...: 庫存明細資料
# Memo...........:
# Usage..........: CALL ainq100_b_fill3()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainq100_b_fill3()
DEFINE  l_sql    STRING
DEFINE  l_sql1   STRING
DEFINE  l_sql2   STRING
DEFINE  r_success        LIKE type_t.num5
DEFINE  r_rate           LIKE inaj_t.inaj014
DEFINE  l_yy             LIKE type_t.num5 
DEFINE  l_mm             LIKE type_t.num5
DEFINE  l_dd             LIKE type_t.num5 

   #清除畫面
#   CLEAR FORM  
   CALL g_inag_d.clear() 
   LET l_yy = YEAR(g_today)
   LET l_mm = MONTH(g_today)
   LET l_dd = DAY(g_today)    
   IF g_detail_idx <> 0 AND NOT cl_null(g_detail_idx) THEN
      IF NOT cl_null(g_imaa_d[g_detail_idx].imaa001) THEN
         #160510-00019#3-s
         #LET l_sql1 = " SELECT inagsite,inag004,'',inag005,'',inag006,inag002,'',inag003,inag007,'',COALESCE(inag008,0),COALESCE(inag033,0),inag024,'',inag025,inag010,inag011,inag012,'',inad011,inag022 FROM inag_t ",

         LET l_sql1 = " SELECT DISTINCT inagsite,inag004,",
                      "        (SELECT inayl003 FROM inayl_t WHERE inaylent = inagent AND inayl001 = inag004 AND inayl002 = '",g_lang,"') inayl003,",
                      "        inag005 ,",
                      "        (SELECT inab003 FROM inab_t WHERE inabent = inagent AND inabsite = inagsite AND inab001 = inag004 AND inab002 = inag005 ) inab003 ,",
                      "        inag006,inag002,",
                      "        (SELECT inaml002 FROM inaml_t WHERE inamlent = inagent AND inaml001 = inag002 AND inaml002 = '",g_lang,"') inaml002,",
                      "        inag003,inag007,",
                      "        (SELECT oocal003 FROM oocal_t WHERE oocalent = inagent AND oocal001 = inag007 AND oocal002 = '",g_lang,"' ) oocal003,",
                      "        COALESCE(inag008,0),COALESCE(inag033,0),inan010,inag021,inag024, ",  #161006-00018#18 add inan010,inag021
                      "        (SELECT oocal003 FROM oocal_t WHERE oocalent = inagent AND oocal001 = inag024 AND oocal002 = '",g_lang,"' ) oocal003_2,", 
                      "        inag025,inag010,inag011,inag012,inaa015,inad014,inad011,inad012 FROM inag_t ", #160512-00004#2-add-'inad014'  #161101-00086#1 inag022-->inad012
                      
         #160510-00019#3-e   
                      "   LEFT JOIN inan_t ON inanent = inagent AND inansite = inagsite AND inan001 = inag001 AND inan002 = inag002 AND inan004 =inag004 AND inan005 =inag005 AND inan006 =inag006 AND inan000 = '1' ",  #161006-00018#18              
                      "   LEFT JOIN inad_t ON inadent = inagent AND inadsite = inagsite AND inad001 = inag001 AND inad002 = inag002 AND inad003 =inag006 ",
                      "   LEFT JOIN inaa_t ON inaaent = inagent AND inaasite = inagsite AND inaa001 = inag004 ",  #160510-00019#3
                      "  WHERE inagent = ",g_enterprise,  #151012-00011 by whitney modify
                      "    AND inagsite = '",g_site,"'",
                      "    AND inag001 = '",g_imaa_d[g_detail_idx].imaa001,"'"
#         IF NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#            LET l_sql1 = l_sql1," AND inag032 = '",g_imaa_d[g_detail_idx].imaa006,"'"
#         END IF 
         LET l_sql2 = l_sql1," AND inag008 = 0 " 
         
         IF g_invent <> '5' THEN
            LET l_sql1 = l_sql1," AND inag008 <> 0 "   
         END IF    
         IF g_invent <> '5' AND g_invent <> '6' THEN
            IF g_invent = 1 THEN  #一個月
               LET g_bdate = MDY(l_mm,1,l_yy)         
            END IF
            IF g_invent = 2 THEN
               IF l_mm = 1 THEN 
                  LET l_yy = l_yy - 1
                  LET l_mm = 12
                  LET g_bdate = MDY(l_mm,1,l_yy)  
               ELSE 
                  LET g_bdate = MDY(l_mm-1,1,l_yy)         
               END IF
            END IF     
            IF g_invent = 3 THEN
               IF l_mm <= 2 THEN
                  IF l_mm = 1 THEN 
                     LET l_yy = l_yy - 1
                     LET l_mm = 11
                     LET g_bdate = MDY(l_mm,1,l_yy)  
                  END IF
                  IF l_mm = 2 THEN 
                     LET l_yy = l_yy - 1
                     LET l_mm = 12
                     LET g_bdate = MDY(l_mm,1,l_yy)  
                  END IF     
               ELSE 
                  LET g_bdate = MDY(l_mm-2,1,l_yy)         
               END IF
            END IF
            IF g_invent = 4 THEN   #六個月
              IF l_mm <= 5 THEN
                 IF l_mm = 1 THEN 
                    LET l_yy = l_yy - 1
                    LET l_mm = 8
                    LET g_bdate = MDY(l_mm,1,l_yy)  
                 END IF
                 IF l_mm = 2 THEN 
                    LET l_yy = l_yy - 1
                    LET l_mm = 9
                    LET g_bdate = MDY(l_mm,1,l_yy)  
                 END IF 
                 IF l_mm = 3 THEN 
                    LET l_yy = l_yy - 1
                    LET l_mm = 10
                    LET g_bdate = MDY(l_mm,1,l_yy)  
                 END IF    
                 IF l_mm = 4 THEN 
                    LET l_yy = l_yy - 1
                    LET l_mm = 11
                    LET g_bdate = MDY(l_mm,1,l_yy)  
                 END IF  
                 IF l_mm = 5 THEN 
                    LET l_yy = l_yy - 1
                    LET l_mm = 12
                    LET g_bdate = MDY(l_mm,1,l_yy)  
                 END IF                     
              ELSE 
                 LET g_bdate = MDY(l_mm-5,1,l_yy)         
              END IF
            END IF    
#            LET l_sql2 = l_sql2," AND inag015 BETWEEN '",g_bdate,"'"," AND '",g_today,"'"   
            LET l_sql2 = l_sql2," AND inag015 > = '",g_bdate,"'"
            LET l_sql = l_sql1," UNION ",l_sql2, " ORDER BY inag004,inag005,inag006 "      
         ELSE
            LET l_sql = l_sql1         
         END IF   
         PREPARE ainq100_inag_pre FROM l_sql
         DECLARE ainq100_inag_cur CURSOR FOR ainq100_inag_pre
         LET l_ac3 = 1
         FOREACH ainq100_inag_cur INTO g_inag_d[l_ac3].inagsite,g_inag_d[l_ac3].inag004,g_inag_d[l_ac3].inag004_desc,g_inag_d[l_ac3].inag005,g_inag_d[l_ac3].inag005_desc,g_inag_d[l_ac3].inag006,g_inag_d[l_ac3].inag002,
                                       g_inag_d[l_ac3].inag002_desc,g_inag_d[l_ac3].inag003,g_inag_d[l_ac3].inag007,g_inag_d[l_ac3].inag007_desc,g_inag_d[l_ac3].inag008,g_inag_d[l_ac3].inag033,
                                       g_inag_d[l_ac3].inan010,g_inag_d[l_ac3].inag021,   #161006-00018#18 
                                       g_inag_d[l_ac3].inag024,g_inag_d[l_ac3].inag024_desc,g_inag_d[l_ac3].inag025,   #160510-00019#3 add
                                       g_inag_d[l_ac3].inag010,g_inag_d[l_ac3].inag011,
                                       g_inag_d[l_ac3].inag012,g_inag_d[l_ac3].inaa015,
                                       g_inag_d[l_ac3].inad014, #160512-00004#2-add
                                       g_inag_d[l_ac3].inag018,g_inag_d[l_ac3].inag022
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()         
               EXIT FOREACH
            END IF  
            #160510-00019#3-s mark
             CALL s_feature_description(g_imaa_d[g_detail_idx].imaa001,g_inag_d[l_ac3].inag002)     #160704-00024#1 remark
                 RETURNING r_success,g_inag_d[l_ac3].inag002_desc                                   #160704-00024#1 remark
#                
#            CALL s_desc_get_stock_desc(g_inag_d[l_ac3].inagsite,g_inag_d[l_ac3].inag004) 
#                 RETURNING g_inag_d[l_ac3].inag004_desc
#            CALL s_desc_get_locator_desc(g_inag_d[l_ac3].inagsite,g_inag_d[l_ac3].inag004,g_inag_d[l_ac3].inag005) 
#                 RETURNING g_inag_d[l_ac3].inag005_desc
#            CALL s_desc_get_unit_desc(g_inag_d[l_ac3].inag007) RETURNING g_inag_d[l_ac3].inag007_desc 
#            SELECT inaa015 INTO g_inag_d[l_ac3].inaa015 FROM inaa_t
#             WHERE inaaent = g_enterprise
#               AND inaasite = g_inag_d[l_ac3].inagsite
#               AND inaa001 = g_inag_d[l_ac3].inag004
            #160510-00019#3-e   mark 
            
            IF NOT cl_null(g_inag_d[l_ac3].inag007) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#               CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,g_inag_d[l_ac3].inag007,g_imaa_d[g_detail_idx].imaa006)
#                    RETURNING r_success,r_rate   
#               IF r_success THEN
#                  LET g_inag_d[l_ac3].inag033 = g_inag_d[l_ac3].inag008 * r_rate
#               END IF 
               IF cl_null(g_inag_d[l_ac3].inag008) THEN LET g_inag_d[l_ac3].inag008 = 0 END IF  #161202-00014#1
               CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,g_inag_d[l_ac3].inag007,g_imaa_d[g_detail_idx].imaa006,g_inag_d[l_ac3].inag008)
                    RETURNING r_success,g_inag_d[l_ac3].inag033
            END IF                               
               
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
         LET l_ac3 = 1
         LET g_detail_idx3 = 1
         CALL ainq100_b_fill4()         
         LET g_detail_cnt3 = l_ac3 - 1       
         DISPLAY ARRAY g_inag_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt3)
            BEFORE DISPLAY 
               EXIT DISPLAY
         END DISPLAY         
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 庫存交易明細
# Memo...........:
# Usage..........: CALL ainq100_b_fill4()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainq100_b_fill4()
DEFINE l_sql           STRING
DEFINE l_yy            LIKE type_t.num5 
DEFINE l_mm            LIKE type_t.num5
DEFINE l_dd            LIKE type_t.num5 
DEFINE l_inaj004       LIKE inaj_t.inaj004
DEFINE r_success       LIKE type_t.num5

#清除畫面
#   CLEAR FORM  
   CALL g_inaj_d.clear() 
   IF g_detail_idx = 0 OR cl_null(g_detail_idx) THEN
      RETURN
   END IF 
   LET l_yy = YEAR(g_today)
   LET l_mm = MONTH(g_today)
   LET l_dd = DAY(g_today) 
   #庫存明細與歷史異動兩個頁籤的資料改為不聯動,所以inaj008,inaj009,inaj010條件mark
#   LET l_sql = " SELECT inaj022,inaj024,inaj015,inaj035,'',inaj011,inaj001,inaj002,inaj044,inaj018,'',inaj025,'',inaj017,'',inaj004 FROM inaj_t ",
   #160510-00019#3-s
#   LET l_sql = " SELECT inaj022,inaj024,inaj015,inaj035,'',COALESCE(inaj011,0),inaj012,'', ", 
#               "         inaj001,inaj002,inaj006,'',inaj007,inaj008,'',inaj009,'',inaj010,inaj044,inaj018,'',inaj025,'',inaj017,'',inaj004 FROM inaj_t ", 
   LET l_sql = " SELECT DISTINCT inaj022,inaj024,inaj015,inaj035,",
               "        (SELECT gzzal003 FROM gzzal_t WHERE gzzal001 = inaj035 AND gzzal002 = '",g_lang,"') gzzal003,",
               "        COALESCE(inaj011,0),inaj012, ",    
               #"        (SELECT ooacl003 FROM oocal_t WHERE oocalent = inajent AND oocal001 = inaj012 AND oocal002 = '",g_lang,"') oocal003,",   #160704-00024#1 mark
               "        (SELECT oocal003 FROM oocal_t WHERE oocalent = inajent AND oocal001 = inaj012 AND oocal002 = '",g_lang,"') oocal003,",    #160704-00024#1 add
               "        inaj001,inaj002,inaj006,",
               "        (SELECT inaml002 FROM inaml_t WHERE inamlent = inajent AND inaml001 = inaj006 AND inaml002 = '",g_lang,"') inaml002,",
               "        inaj007,inaj008,",
               "        (SELECT inayl003 FROM inayl_t WHERE inaylent = inajent AND inayl001 = inaj008 AND inayl002 = '",g_lang,"') inayl003,",
               "        inaj009,",
              #"        (SELECT inab003 FROM inab_t WHERE inabent = inajent AND inabsite = inagsite AND inab001 = inaj009 AND inab002 = inag005 ) inab003 ,",    #160704-00024#1 mark
               "        (SELECT inab003 FROM inab_t WHERE inabent = inajent AND inabsite = inajsite AND inab001 = inaj009 AND inab002 = inaj005 ) inab003 ,",    #160704-00024#1 add
               "        inaj010,inaj044,inaj018,",
               "        (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = inajent AND pmaal001 = inaj018 AND pmaal002 = '",g_lang,"') pmaal004,",
               "        inaj025,",
               "        (SELECT ooag011 FROM ooag_t WHERE ooagent = inajent AND ooag001 = inaj025) ooag011,",
               "        inaj017, ",
               "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = inajent AND ooefl001 = inaj017 AND ooefl002 = '",g_lang,"') ooefl003 ,",
              #"        inaj004 FROM inaj_t ",                        #170101-00007#1 mark
               "        inaj004,inaj026,inaj027 FROM inaj_t ",        #170101-00007#1 add              
               
   #160510-00019#3-e               
               "  WHERE inajent = ",g_enterprise,  #151012-00011 by whitney modify
               "    AND inajsite = '",g_site,"'",
#               "    AND inaj008 = '",g_inag_d[g_detail_idx3].inag004,"'",
#               "    AND inaj009 = '",g_inag_d[g_detail_idx3].inag005,"'",
#               "    AND inaj010 = '",g_inag_d[g_detail_idx3].inag006,"'",
               "    AND inaj005 = '",g_imaa_d[g_detail_idx].imaa001,"'"
               
   IF g_lsdate = '1' THEN
      LET g_bdate = MDY(l_mm,1,l_yy)         
   END IF      
   IF g_lsdate = '2' THEN
      IF l_mm <=1 THEN
         IF l_mm = 1 THEN 
            LET l_yy = l_yy - 1
            LET l_mm = 12
            LET g_bdate = MDY(l_mm,1,l_yy)  
         END IF        
      ELSE 
         LET g_bdate = MDY(l_mm-1,1,l_yy)         
      END IF
   END IF    
   IF g_lsdate = '3' THEN
      IF l_mm <= 2 THEN
         IF l_mm = 1 THEN 
            LET l_yy = l_yy - 1
            LET l_mm = 11
            LET g_bdate = MDY(l_mm,1,l_yy)  
         END IF
         IF l_mm = 2 THEN 
            LET l_yy = l_yy - 1
            LET l_mm = 12
            LET g_bdate = MDY(l_mm,1,l_yy)  
         END IF        
      ELSE 
         LET g_bdate = MDY(l_mm-2,1,l_yy)         
      END IF
   END IF 
   IF g_lsdate = '4' THEN    #六個月
      IF l_mm <= 5 THEN
         IF l_mm = 1 THEN 
            LET l_yy = l_yy - 1
            LET l_mm = 8
            LET g_bdate = MDY(l_mm,1,l_yy)  
         END IF
         IF l_mm = 2 THEN 
            LET l_yy = l_yy - 1
            LET l_mm = 9
            LET g_bdate = MDY(l_mm,1,l_yy)  
         END IF 
         IF l_mm = 3 THEN 
            LET l_yy = l_yy - 1
            LET l_mm = 10
            LET g_bdate = MDY(l_mm,1,l_yy)  
         END IF    
         IF l_mm = 4 THEN 
            LET l_yy = l_yy - 1
            LET l_mm = 11
            LET g_bdate = MDY(l_mm,1,l_yy)  
         END IF  
         IF l_mm = 5 THEN 
            LET l_yy = l_yy - 1
            LET l_mm = 12
            LET g_bdate = MDY(l_mm,1,l_yy)  
         END IF                     
      ELSE 
         LET g_bdate = MDY(l_mm-5,1,l_yy)         
      END IF
   END IF    
   IF g_lsdate <> '5' THEN
      LET l_sql = l_sql," AND inaj022 >= '",g_bdate,"'"
   END IF   
   PREPARE ainq100_inaj_pre FROM l_sql
   DECLARE ainq100_inaj_cur CURSOR FOR ainq100_inaj_pre      
   LET l_ac4 = 1   
   FOREACH ainq100_inaj_cur INTO g_inaj_d[l_ac4].inaj022,g_inaj_d[l_ac4].inaj024,g_inaj_d[l_ac4].inaj015,g_inaj_d[l_ac4].inaj035,g_inaj_d[l_ac4].inaj035_desc,
                                 g_inaj_d[l_ac4].inaj011,g_inaj_d[l_ac4].inaj012,g_inaj_d[l_ac4].inaj012_desc, 
                                 g_inaj_d[l_ac4].inaj001,g_inaj_d[l_ac4].inaj002,g_inaj_d[l_ac4].inaj006,g_inaj_d[l_ac4].inaj006_desc,g_inaj_d[l_ac4].inaj007,
                                 g_inaj_d[l_ac4].inaj008,g_inaj_d[l_ac4].inaj008_desc,g_inaj_d[l_ac4].inaj009,g_inaj_d[l_ac4].inaj009_desc,g_inaj_d[l_ac4].inaj010,
                                 g_inaj_d[l_ac4].inaj044,g_inaj_d[l_ac4].inaj018,g_inaj_d[l_ac4].inaj018_desc,
                                 g_inaj_d[l_ac4].inaj025,g_inaj_d[l_ac4].inaj025_desc,g_inaj_d[l_ac4].inaj017,g_inaj_d[l_ac4].inaj017_desc,l_inaj004
                                ,g_inaj_d[l_ac4].inaj026,g_inaj_d[l_ac4].inaj027      #170101-00007#1 add 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      
         EXIT FOREACH
      END IF   
      #160510-00019#3-s mark   
#      CALL s_desc_get_unit_desc(g_inaj_d[l_ac4].inaj012) RETURNING g_inaj_d[l_ac4].inaj012_desc
#      CALL s_desc_get_stock_desc(g_site,g_inaj_d[l_ac4].inaj008) RETURNING g_inaj_d[l_ac4].inaj008_desc
#      CALL s_desc_get_locator_desc(g_site,g_inaj_d[l_ac4].inaj008,g_inaj_d[l_ac4].inaj009) RETURNING g_inaj_d[l_ac4].inaj009_desc
#      CALL s_feature_description(g_imaa_d[g_detail_idx].imaa001,g_inaj_d[l_ac4].inaj006)
#           RETURNING r_success,g_inaj_d[l_ac4].inaj006_desc       
      #160510-00019#3-e mark
      LET g_inaj_d[l_ac4].inaj011 = g_inaj_d[l_ac4].inaj011 * l_inaj004
      #160510-00019#3-s mark
#      IF NOT cl_null(g_inaj_d[l_ac4].inaj025) THEN
#         CALL s_desc_get_person_desc(g_inaj_d[l_ac4].inaj025) RETURNING g_inaj_d[l_ac4].inaj025_desc
#      END IF
#      IF NOT cl_null(g_inaj_d[l_ac4].inaj017) THEN
#         CALL s_desc_get_department_desc(g_inaj_d[l_ac4].inaj017) RETURNING g_inaj_d[l_ac4].inaj017_desc
#      END IF  
#      IF NOT cl_null(g_inaj_d[l_ac4].inaj035) THEN     
#         CALL s_desc_get_prog_desc(g_inaj_d[l_ac4].inaj035) RETURNING g_inaj_d[l_ac4].inaj035_desc
#      END IF
      #160510-00019#3-e mark      
      LET l_ac4 = l_ac4 + 1      
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
   CALL g_inaj_d.deleteElement(g_inaj_d.getLength())   
   LET g_detail_cnt4 = l_ac4 - 1       
   DISPLAY ARRAY g_inaj_d TO s_detail4.* ATTRIBUTE(COUNT=g_detail_cnt4)
      BEFORE DISPLAY 
         EXIT DISPLAY
   END DISPLAY       
END FUNCTION

################################################################################
# Descriptions...: 批序號明細
# Memo...........:
# Usage..........: CALL ainq100_b_fill5()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainq100_b_fill5()
DEFINE  l_sql    STRING
   #清除畫面
#   CLEAR FORM  
   CALL g_inai_d.clear() 
   IF g_detail_idx = 0 OR cl_null(g_detail_idx) THEN
      RETURN
   END IF   
   IF cl_null(g_imaa_d[g_detail_idx].imaa001) OR cl_null(g_inag_d[g_detail_idx3].inag004) THEN
      RETURN
   END IF
   #160510-00019#3-s 
   #LET l_sql = " SELECT inai004,'',inai005,'',inai006,inai002,'',inai003,inai007,inai008,inai009,'',COALESCE(inai011,0),inai012 FROM inai_t ",
   LET l_sql = " SELECT DISTINCT inai004,",
               "(SELECT inayl003 FROM inayl_t WHERE inaylent = inaient AND inayl001 = inai004 AND inayl002 = '",g_lang,"') inayl003,",
               "        inai005 ,",
               "(SELECT inab003 FROM inab_t WHERE inabent = inaient AND inabsite = inaisite AND inab001 = inai004 AND inab002 = inai005 ) inab003 ,",  #160602-00022#1 inagsite =>inaisite
               "        inai006,inai002,",
               "(SELECT inaml002 FROM inaml_t WHERE inamlent = inaient AND inaml001 = inai002 AND inaml002 = '",g_lang,"') inaml002,",
               "        inai003,inai007,inai008,inai009,",
               "(SELECT oocal003 FROM oocal_t WHERE oocalent = inaient AND oocal001 = inai009 AND oocal003 = '",g_lang,"') oocal003,",
               "        COALESCE(inai011,0),inae010 FROM inai_t ",  #160512-00004#1 by whitney modify inai012->inae010
   #160510-00019#3-e
               "   LEFT JOIN inae_t ON inaeent=inaient AND inae001=inai001 AND inaesite=inaisite AND inae002=inai002 AND inae003=inai007 AND inae004=inai008 ",  #160512-00004#1 by whitney add
               "  WHERE inaient = ",g_enterprise,  #151012-00011 by whitney modify
               "    AND inaisite = '",g_site,"'"
   IF NOT cl_null(g_imaa_d[g_detail_idx].imaa001) THEN    
      LET l_sql = l_sql, " AND inai001 = '",g_imaa_d[g_detail_idx].imaa001,"'"
   END IF   
   IF NOT cl_null(g_inag_d[g_detail_idx3].inag004) THEN    
      LET l_sql = l_sql, " AND inai004 = '",g_inag_d[g_detail_idx3].inag004,"'"
   END IF 
   IF NOT cl_null(g_inag_d[g_detail_idx3].inag005) THEN    
      LET l_sql = l_sql, " AND inai005 = '",g_inag_d[g_detail_idx3].inag005,"'"
   END IF  
   IF NOT cl_null(g_inag_d[g_detail_idx3].inag006) THEN    
      LET l_sql = l_sql, " AND inai006 = '",g_inag_d[g_detail_idx3].inag006,"'"
   END IF  
   IF NOT cl_null(g_inag_d[g_detail_idx3].inag002) THEN    
      LET l_sql = l_sql, " AND inai002 = '",g_inag_d[g_detail_idx3].inag002,"'"
   END IF     
   IF NOT cl_null(g_inag_d[g_detail_idx3].inag003) THEN    
      LET l_sql = l_sql, " AND inai003 = '",g_inag_d[g_detail_idx3].inag003,"'"
   END IF  
   IF NOT cl_null(g_inag_d[g_detail_idx3].inag007) THEN    
      LET l_sql = l_sql, " AND inai009 = '",g_inag_d[g_detail_idx3].inag007,"'"
   END IF     
  
   PREPARE ainq100_inai_pre FROM l_sql
   DECLARE ainq100_inai_cur CURSOR FOR ainq100_inai_pre  
   
   LET l_ac5 = 1
   FOREACH ainq100_inai_cur INTO g_inai_d[l_ac5].inai004,g_inai_d[l_ac5].inai004_desc,g_inai_d[l_ac5].inai005,g_inai_d[l_ac5].inai005_desc,
                                 g_inai_d[l_ac5].inai006,g_inai_d[l_ac5].inai002,g_inai_d[l_ac5].inai002_desc,g_inai_d[l_ac5].inai003,g_inai_d[l_ac5].inai007,g_inai_d[l_ac5].inai008,
                                 g_inai_d[l_ac5].inai009,g_inai_d[l_ac5].inai009_desc,g_inai_d[l_ac5].inai011,g_inai_d[l_ac5].inae010  #160512-00004#1 by whitney modify inai012->inae010
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
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
   CALL g_inai_d.deleteElement(g_inai_d.getLength())   
   LET g_detail_cnt5 = l_ac5 - 1       
   DISPLAY ARRAY g_inai_d TO s_detail5.* ATTRIBUTE(COUNT=g_detail_cnt5)
      BEFORE DISPLAY 
         EXIT DISPLAY
   END DISPLAY     
END FUNCTION

################################################################################
# Descriptions...: 供需匯總
# Memo...........:
# Usage..........: CALL ainq100_b_fill6()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainq100_b_fill6()
   #暫時沒有用
   DEFINE l_sql           STRING 
   DEFINE l_xmdd004       LIKE xmdd_t.xmdd004
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_rate          LIKE inaj_t.inaj014
   DEFINE l_stock         LIKE inag_t.inag009
   DEFINE l_gj_sum        LIKE inag_t.inag009
   DEFINE l_xq_sum        LIKE inag_t.inag009
   DEFINE l_sfba014       LIKE sfba_t.sfba014
   DEFINE l_sfaa013       LIKE sfaa_t.sfaa013
   DEFINE l_pmdb007       LIKE pmdb_t.pmdb007
   DEFINE l_pmdt019       LIKE pmdt_t.pmdt019
   DEFINE l_inag032       LIKE inag_t.inag032
   DEFINE l_qcba016       LIKE qcba_t.qcba016
   DEFINE l_inag008       LIKE inag_t.inag008
   DEFINE l_sum_inag008   LIKE inag_t.inag008
   DEFINE l_zj_sum        LIKE inag_t.inag009 
   DEFINE l_pmdo004       LIKE pmdo_t.pmdo004
   DEFINE l_yy            LIKE type_t.num5 
   DEFINE l_mm            LIKE type_t.num5
   DEFINE l_dd            LIKE type_t.num5 
   DEFINE li_ac           LIKE type_t.num5
   DEFINE l_sfbadocno     LIKE sfba_t.sfbadocno
   DEFINE l_sfbaseq       LIKE sfba_t.sfbaseq
   DEFINE l_sfbaseq1      LIKE sfba_t.sfbaseq1
   DEFINE l_ck_num        LIKE inag_t.inag009
   DEFINE s_ck_num        LIKE inag_t.inag009
   
   LET l_sql = " SELECT COALESCE(inag008,0),inag007 FROM inag_t ",
               "  WHERE inagent = ",g_enterprise,  #151012-00011 by whitney modify
               "    AND inagsite = '",g_site,"'",
               "    AND inag001 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND inag010 = 'Y' "
#   IF g_gxdate = 1 THEN #一個月 
#      CALL s_date_get_last_date(g_today) RETURNING g_bdate        
#   END IF
#   IF g_gxdate = 2 THEN
#      IF l_mm = 12 THEN
#         LET l_yy = l_yy + 1
#         LET l_mm = 1
#         LET g_bdate = MDY(l_mm,31,l_yy)                     
#      ELSE 
#         LET g_bdate = MDY(l_mm+1,l_dd,l_yy) 
#         CALL s_date_get_last_date(g_bdate) RETURNING g_bdate            
#      END IF  
#   END IF     
#   IF g_gxdate = 3 THEN
#      IF l_mm >= 11 THEN
#         IF l_mm = 11 THEN
#            LET l_yy = l_yy + 1
#            LET l_mm = 1
#            LET g_bdate = MDY(l_mm,31,l_yy)            
#         END IF
#         IF l_mm = 12 THEN
#            LET l_yy = l_yy + 1
#            LET l_mm = 2
#            LET g_bdate = MDY(l_mm,l_dd,l_yy)  
#            CALL s_date_get_last_date(g_bdate) RETURNING g_bdate  
#         END IF          
#      ELSE 
#         LET g_bdate = MDY(l_mm+2,l_dd,l_yy)   
#         CALL s_date_get_last_date(g_bdate) RETURNING g_bdate         
#      END IF 
#   END IF
#   IF g_gxdate = 4 THEN
#      IF l_mm >= 8 THEN
#         IF l_mm = 1 THEN 
#            LET l_yy = l_yy + 1
#            LET l_mm = 1
#            LET g_bdate = MDY(l_mm,31,l_yy) 
#         END IF
#         IF l_mm = 9 THEN 
#            LET l_yy = l_yy + 1
#            LET l_mm = 2
#            LET g_bdate = MDY(l_mm,l_dd,l_yy)
#            CALL s_date_get_last_date(g_bdate) RETURNING g_bdate                  
#         END IF 
#         IF l_mm = 10 THEN 
#            LET l_yy = l_yy + 1
#            LET l_mm = 3
#            LET g_bdate = MDY(l_mm,l_dd,l_yy) 
#            CALL s_date_get_last_date(g_bdate) RETURNING g_bdate      
#         END IF    
#         IF l_mm = 11 THEN 
#            LET l_yy = l_yy + 1
#            LET l_mm = 4
#            LET g_bdate = MDY(l_mm,l_dd,l_yy)   
#            CALL s_date_get_last_date(g_bdate) RETURNING g_bdate                  
#         END IF  
#         IF l_mm = 12 THEN 
#            LET l_yy = l_yy + 1
#            LET l_mm = 5
#            LET g_bdate = MDY(l_mm,l_dd,l_yy)   
#            CALL s_date_get_last_date(g_bdate) RETURNING g_bdate                  
#         END IF                      
#      ELSE    
#         LET g_bdate = MDY(l_mm+5,l_dd,l_yy) 
#         CALL s_date_get_last_date(g_bdate) RETURNING g_bdate               
#      END IF
#   END IF 
#   IF g_gxdate <> '5' THEN  
#      LET l_sql = l_sql," AND inag015 < = '",g_bdate,"'"  
#   END IF    
   PREPARE ainq100_inag008_pre2 FROM l_sql
   DECLARE ainq100_inag008_cur2 CURSOR FOR ainq100_inag008_pre2
   LET l_ac6 = 1
   LET l_stock = 0
   LET l_gj_sum = 0
   LET l_xq_sum = 0
   LET l_zj_sum = 0
   LET l_sum_inag008 = 0

   FOREACH ainq100_inag008_cur2 INTO l_inag008,l_inag032
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()    
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_inag032) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_inag032,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET l_inag008 = l_inag008 * r_rate
#         END IF 
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_inag032,g_imaa_d[g_detail_idx].imaa006,l_inag008)
              RETURNING r_success,l_inag008
      END IF  
      LET l_sum_inag008 = l_sum_inag008 + l_inag008    

   END FOREACH 
  
   LET g_imaa2_d[1].type = '1' 
   IF cl_null(l_sum_inag008) THEN
      LET l_sum_inag008 = 0
   END IF   
   LET g_imaa2_d[1].gj_num = l_sum_inag008
   LET g_imaa2_d[1].xq_num = 0
   LET g_imaa2_d[1].ck_num = 0
   LET g_imaa2_d[1].stock = l_sum_inag008  
   LET l_sql = ""
   #受訂量(需求)
   LET l_ac6 = 2
   LET l_sql = " SELECT '2',0,SUM(COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd015,0)+COALESCE(xmdd016,0)),0,0,xmdd004 FROM xmdd_t,xmda_t,xmdc_t ",
               "  WHERE xmdaent = xmddent ",
               "    AND xmdasite = xmddsite ",
               "    AND xmdadocno = xmdddocno ",
               #150104 by whitney add start
               "    AND xmdaent = xmdcent ",
               "    AND xmdasite = xmdcsite ",
               "    AND xmdadocno = xmdcdocno ",
               "    AND xmddseq = xmdcseq ",
               "    AND xmdc045 NOT IN ('2','3','4') ",
               #150104 by whitney add end               
               "    AND xmdasite = '",g_site,"'",               
               "    AND xmdaent = ",g_enterprise,  #151012-00011 by whitney modify
               #"    AND xmdastus = 'Y' ",
               "    AND xmdastus IN ('Y','H')",    #add by lixh 20151105
               "    AND xmdd001 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND (COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd015,0)+COALESCE(xmdd016,0)) <> 0"
               
#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND xmdadocdt <= '",g_bdate,"'" 
#   END IF   
   LET l_sql = l_sql,"  ORDER BY xmdadocdt,xmdddocno,xmddseq "   
   PREPARE ainq100_xmdd_pre2 FROM l_sql
   DECLARE ainq100_xmdd_cur2 CURSOR FOR ainq100_xmdd_pre2
   LET l_stock = g_imaa2_d[1].stock
   LET l_gj_sum = g_imaa2_d[1].gj_num
   LET l_xq_sum = 0
   FOREACH ainq100_xmdd_cur2 INTO g_imaa3_d[l_ac6].type,g_imaa3_d[l_ac6].gj_num,g_imaa3_d[l_ac6].xq_num,
                                    g_imaa3_d[l_ac6].stock,g_imaa3_d[l_ac6].ck_num,l_xmdd004

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_xmdd004) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_xmdd004,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa3_d[l_ac6].xq_num = g_imaa3_d[l_ac6].xq_num * r_rate
#         END IF    
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_xmdd004,g_imaa_d[g_detail_idx].imaa006,g_imaa3_d[l_ac6].xq_num)
              RETURNING r_success,g_imaa3_d[l_ac6].xq_num
      END IF
  
      LET l_xq_sum = l_xq_sum + g_imaa3_d[l_ac6].xq_num
      LET g_imaa3_d[l_ac6].stock = l_stock - g_imaa3_d[l_ac6].xq_num
      LET l_stock = g_imaa3_d[l_ac6].stock
      LET l_ac6 = l_ac6 + 1 
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
   LET l_sql = ''
   #工單備料量(需求)
   LET l_sql = " SELECT '3',0,SUM(COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0)+COALESCE(sfba017,0)-COALESCE(sfba025,0)),0,0,sfba014 FROM sfaa_t,sfba_t ",
               "  WHERE sfaaent = sfbaent ", 
               "    AND sfaadocno = sfbadocno ",
               "    AND sfaaent = ",g_enterprise,  #151012-00011 by whitney modify
               "    AND sfaasite = '",g_site,"'",
               "    AND sfba006 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND sfaa003 <> '4' ",
               "    AND sfaastus <> 'X'",
               "    AND sfaastus <> 'C'",
               "    AND sfaa057 = '1' ",
               "    AND (COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0)+COALESCE(sfba017,0)-COALESCE(sfba025,0)) <> 0 "
               
#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND sfaadocdt <= '",g_bdate,"'"
#   END IF      
   LET l_sql = l_sql,"  ORDER BY sfaadocdt,sfbadocno,sfbaseq "   
   PREPARE ainq100_sfba_pre2 FROM l_sql
   DECLARE ainq100_sfba_cur2 CURSOR FOR ainq100_sfba_pre2 
   FOREACH ainq100_sfba_cur2 INTO g_imaa3_d[l_ac6].type,g_imaa3_d[l_ac6].gj_num,g_imaa3_d[l_ac6].xq_num,
                                 g_imaa3_d[l_ac6].stock,l_sfba014
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_sfba014) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_sfba014,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa3_d[l_ac6].xq_num = g_imaa3_d[l_ac6].xq_num * r_rate
#         END IF    
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_sfba014,g_imaa_d[g_detail_idx].imaa006,g_imaa3_d[l_ac6].xq_num)
              RETURNING r_success,g_imaa3_d[l_ac6].xq_num
      END IF
      
      LET l_xq_sum = l_xq_sum + g_imaa3_d[l_ac6].xq_num
      LET g_imaa3_d[l_ac6].stock = l_stock - g_imaa3_d[l_ac6].xq_num
      LET l_stock = g_imaa3_d[l_ac6].stock      
      LET l_ac6 = l_ac6 + 1 
      
   END FOREACH 
   LET l_sql = ''
   LET l_sql = " SELECT sfbadocno,sfbaseq,sfbaseq1,sfba014 FROM sfaa_t,sfba_t ",
               "  WHERE sfaaent = sfbaent ", 
               "    AND sfaadocno = sfbadocno ",
               "    AND sfaaent = ",g_enterprise,  #151012-00011 by whitney modify
               "    AND sfaasite = '",g_site,"'",
               "    AND sfba006 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND sfaa003 <> '4' ",
               "    AND sfaastus <> 'X'",
               "    AND sfaastus <> 'C'",
               "    AND sfaa057 = '1' ",
               "    AND (COALESCE(sfba013,0)-COALESCE(sfba016,0)-COALESCE(sfba015,0)+COALESCE(sfba017,0)-COALESCE(sfba025,0)) <> 0 " 
   LET l_sql = l_sql,"  ORDER BY sfaadocdt,sfbadocno,sfbaseq "   
   PREPARE ainq100_sfba_pre2_ck FROM l_sql
   DECLARE ainq100_sfba_cur2_ck CURSOR FOR ainq100_sfba_pre2_ck 
   LET s_ck_num = 0
   FOREACH ainq100_sfba_cur2_ck INTO l_sfbadocno,l_sfbaseq,l_sfbaseq1,l_sfba014
      CALL s_asft300_07(l_sfbadocno,l_sfbaseq,l_sfbaseq1) RETURNING r_success,l_ck_num
      CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_sfba014,g_imaa_d[g_detail_idx].imaa006,l_ck_num)
           RETURNING r_success,l_ck_num   
      LET s_ck_num = s_ck_num + l_ck_num       
   END FOREACH
   IF s_ck_num <> 0 THEN
      LET g_imaa3_d[l_ac6].ck_num = s_ck_num 
   END IF
   
   LET l_sql = ''
   #供需類型：請購量(供給)
   LET l_sql = " SELECT '4',SUM(COALESCE(pmdb006,0)-COALESCE(pmdb049,0)),0,0,0,pmdb007 FROM pmda_t,pmdb_t ",
               "  WHERE pmdaent = pmdbent ",
               "    AND pmdaent = ",g_enterprise,  #151012-00011 by whitney add
               "    AND pmdasite = '",g_site,"'",
               "    AND pmdadocno = pmdbdocno ",
               "    AND pmdb004 = '",g_imaa_d[g_detail_idx].imaa001,"'", 
               "    AND COALESCE(pmdb006,0) <> COALESCE(pmdb049,0) ",
               "    AND pmdb032 NOT IN ('2','3','4') ",  #150104 by whitney add
               "    AND pmdastus <> 'X' AND pmdastus <> 'C' "
                          
#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND pmdb030 <= '",g_bdate,"'"
#   END IF    
   LET l_sql = l_sql,"  ORDER BY pmdb030,pmdbdocno,pmdbseq "      
   PREPARE ainq100_pmda_pre2 FROM l_sql
   DECLARE ainq100_pmda_cur2 CURSOR FOR ainq100_pmda_pre2 
   FOREACH ainq100_pmda_cur2 INTO g_imaa3_d[l_ac6].type,g_imaa3_d[l_ac6].gj_num,g_imaa3_d[l_ac6].xq_num,
                                 g_imaa3_d[l_ac6].stock,l_pmdb007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_pmdb007) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_pmdb007,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa3_d[l_ac6].gj_num = g_imaa3_d[l_ac6].gj_num * r_rate
#         END IF    
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_pmdb007,g_imaa_d[g_detail_idx].imaa006,g_imaa3_d[l_ac6].gj_num)
              RETURNING r_success,g_imaa3_d[l_ac6].gj_num
      END IF
         
      LET l_gj_sum = l_gj_sum + g_imaa3_d[l_ac6].gj_num
      LET g_imaa3_d[l_ac6].stock = l_stock + g_imaa3_d[l_ac6].gj_num
      LET l_stock = g_imaa3_d[l_ac6].stock      
      LET l_ac6 = l_ac6 + 1 
      
   END FOREACH   

   #採購量(供給)
   
   LET l_sql = " SELECT '5',SUM(COALESCE(pmdo006,0)-COALESCE(pmdo015,0)+COALESCE(pmdo016,0)+COALESCE(pmdo017,0)),0,0,0,pmdo004 FROM pmdl_t,pmdo_t,pmdn_t ",
               "  WHERE pmdlent = pmdoent ",
               "    AND pmdlent = ",g_enterprise,  #151012-00011 by whitney add
               "    AND pmdosite = '",g_site,"'",
               "    AND pmdldocno = pmdodocno ",
               #150104 by whitney add start
               "    AND pmdnent = pmdlent ",
               "    AND pmdnsite = pmdlsite ",
               "    AND pmdndocno = pmdldocno ",
               "    AND pmdnseq = pmdoseq ",
               "    AND pmdn045 NOT IN ('2','3','4') ",
               #150104 by whitney add end               
               "    AND pmdo001 = '",g_imaa_d[g_detail_idx].imaa001,"'", 
              # "    AND pmdlstus <> 'X' AND pmdlstus <> 'C' ",
               "    AND pmdlstus IN ('Y','H') ",         #add by lixh 20151105
               "    AND (COALESCE(pmdo006,0)-COALESCE(pmdo015,0)+COALESCE(pmdo016,0)+COALESCE(pmdo017,0)) <> 0 "
                            
#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND pmdldocdt <= '",g_bdate,"'"
#   END IF    
   LET l_sql = l_sql,"  ORDER BY pmdldocdt,pmdodocno,pmdoseq "     
   PREPARE ainq100_pmdl_pre2 FROM l_sql
   DECLARE ainq100_pmdl_cur2 CURSOR FOR ainq100_pmdl_pre2 
   FOREACH ainq100_pmdl_cur2 INTO g_imaa3_d[l_ac6].type,g_imaa3_d[l_ac6].gj_num,g_imaa3_d[l_ac6].xq_num,
                                 g_imaa3_d[l_ac6].stock,l_pmdo004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_pmdo004) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_pmdo004,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa3_d[l_ac6].gj_num = g_imaa3_d[l_ac6].gj_num * r_rate
#         END IF    
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_pmdo004,g_imaa_d[g_detail_idx].imaa006,g_imaa3_d[l_ac6].gj_num)
              RETURNING r_success,g_imaa3_d[l_ac6].gj_num
      END IF        
      LET l_gj_sum = l_gj_sum + g_imaa3_d[l_ac6].gj_num
      LET g_imaa3_d[l_ac6].stock = l_stock + g_imaa3_d[l_ac6].gj_num
      LET l_stock = g_imaa3_d[l_ac6].stock      
      LET l_ac6 = l_ac6 + 1 
      
   END FOREACH     

   #工單在製量(供給)
   LET l_sql = " SELECT '6',SUM(COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)),0,0,0,sfaa013 FROM sfaa_t ",
               "  WHERE sfaaent = ",g_enterprise,  #151012-00011 by whitney modify
               "    AND sfaasite = '",g_site,"'",
               "    AND sfaa010 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND sfaa003 <> '4' ",
               "    AND sfaastus <> 'X'",
               "    AND sfaastus <> 'C'",
               "    AND sfaa057 = '1' ",
               "    AND (COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)) <> 0"
                    
#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND sfaadocdt <= '",g_bdate,"'"
#   END IF  
   LET l_sql = l_sql,"  ORDER BY sfaadocdt,sfaadocno "             
   PREPARE ainq100_sfaa_pre3 FROM l_sql
   DECLARE ainq100_sfaa_cur3 CURSOR FOR ainq100_sfaa_pre3
   FOREACH ainq100_sfaa_cur3 INTO g_imaa3_d[l_ac6].type,g_imaa3_d[l_ac6].gj_num,g_imaa3_d[l_ac6].xq_num,
                                  g_imaa3_d[l_ac6].stock,l_sfaa013
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_sfaa013) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_sfaa013,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa3_d[l_ac6].gj_num = g_imaa3_d[l_ac6].gj_num * r_rate
#         END IF    
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_sfaa013,g_imaa_d[g_detail_idx].imaa006,g_imaa3_d[l_ac6].gj_num)
              RETURNING r_success,g_imaa3_d[l_ac6].gj_num
      END IF    
      LET l_gj_sum = l_gj_sum + g_imaa3_d[l_ac6].gj_num
      LET g_imaa3_d[l_ac6].stock = l_stock + g_imaa3_d[l_ac6].gj_num
      LET l_stock = g_imaa3_d[l_ac6].stock      
      LET l_ac6 = l_ac6 + 1 
      
   END FOREACH 
   #委外在製量(供給)
   LET l_sql = " SELECT '7',SUM(COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)),0,0,0,sfaa013 FROM sfaa_t ",
               "  WHERE sfaaent = ",g_enterprise,  #151012-00011 by whitney modify
               "    AND sfaasite = '",g_site,"'",               
               "    AND sfaa010 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND sfaa003 <> '4' ",
               "    AND sfaastus <> 'X'",
               "    AND sfaastus <> 'C'",
               "    AND sfaa057 = '2' ",
               "    AND (COALESCE(sfaa012,0)-COALESCE(sfaa050,0)-COALESCE(sfaa051,0)-COALESCE(sfaa056,0)-COALESCE(sfaa055,0)) <> 0"
               
               
#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND sfaadocdt <= '",g_bdate,"'"
#   END IF 
   LET l_sql = l_sql,"  ORDER BY sfaadocdt,sfaadocno "    
   PREPARE ainq100_sfaa_pre4 FROM l_sql
   DECLARE ainq100_sfaa_cur4 CURSOR FOR ainq100_sfaa_pre4
   FOREACH ainq100_sfaa_cur4 INTO g_imaa3_d[l_ac6].type,g_imaa3_d[l_ac6].gj_num,g_imaa3_d[l_ac6].xq_num,
                                  g_imaa3_d[l_ac6].stock,l_sfaa013
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_sfaa013) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_sfaa013,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa3_d[l_ac6].gj_num = g_imaa3_d[l_ac6].gj_num * r_rate
#         END IF    
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_sfaa013,g_imaa_d[g_detail_idx].imaa006,g_imaa3_d[l_ac6].gj_num)
              RETURNING r_success,g_imaa3_d[l_ac6].gj_num
      END IF       
      LET l_gj_sum = l_gj_sum + g_imaa3_d[l_ac6].gj_num
      LET g_imaa3_d[l_ac6].stock = l_stock + g_imaa3_d[l_ac6].gj_num
      LET l_stock = g_imaa3_d[l_ac6].stock      
      LET l_ac6 = l_ac6 + 1 
      
   END FOREACH 
   
   #IQC在驗量(供給)
   LET l_sql = " SELECT '8',SUM(COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)),0,0,0,pmdt019 FROM pmds_t,pmdt_t ",
               "  WHERE pmdsent = pmdtent ",
               "    AND pmdsent = ",g_enterprise,  #151012-00011 by whitney add
               "    AND pmdssite = '",g_site,"'",
               "    AND pmdsdocno = pmdtdocno ",
               "    AND pmds000 IN ('1','2','3','4') ",
               "    AND pmds011 IN ('1','3','7','8','9','10')",
               "    AND pmdsstus = 'Y' ",
               "    AND pmdt006 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND (COALESCE(pmdt020,0)-COALESCE(pmdt054,0)-COALESCE(pmdt055,0)) <> 0 "
               
               
#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND pmdsdocdt <= '",g_bdate,"'"
#   END IF 
   LET l_sql = l_sql,"  ORDER BY pmdsdocdt,pmdtdocno,pmdtseq "   
   PREPARE ainq100_pmds_pre2 FROM l_sql
   DECLARE ainq100_pmds_cur2 CURSOR FOR ainq100_pmds_pre2
   FOREACH ainq100_pmds_cur2 INTO g_imaa3_d[l_ac6].type,g_imaa3_d[l_ac6].gj_num,g_imaa3_d[l_ac6].xq_num,
                                 g_imaa3_d[l_ac6].stock,l_pmdt019
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_pmdt019) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_pmdt019,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa3_d[l_ac6].gj_num = g_imaa3_d[l_ac6].gj_num * r_rate
#         END IF    
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_pmdt019,g_imaa_d[g_detail_idx].imaa006,g_imaa3_d[l_ac6].gj_num)
              RETURNING r_success,g_imaa3_d[l_ac6].gj_num
      END IF       
      LET l_gj_sum = l_gj_sum + g_imaa3_d[l_ac6].gj_num
      LET g_imaa3_d[l_ac6].stock = l_stock + g_imaa3_d[l_ac6].gj_num
      LET l_stock = g_imaa3_d[l_ac6].stock      
      LET l_ac6 = l_ac6 + 1 
      
   END FOREACH      
   
   #FQC在驗量(供給) 
   LET l_sql = " SELECT '9',SUM(COALESCE(qcba017,0)-COALESCE(qcba023,0)),0,0,0,qcba016 FROM qcba_t ",
               "  WHERE qcbaent = ",g_enterprise,  #151012-00011 by whitney modify
               "    AND qcbasite = '",g_site,"'",
               "    AND qcba000 = '2' ",
               "    AND qcbastus = 'Y' ",
               "    AND qcba010 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND qcba013 = '",g_imaa_d[g_detail_idx].imae011,"'",
               "    AND qcba017 <> qcba023 "
               

#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND qcbadocdt <= '",g_bdate,"'"
#   END IF 
   LET l_sql = l_sql,"  ORDER BY qcbadocdt,qcbadocno,qcbaseq "   
   PREPARE ainq100_qcba_pre2 FROM l_sql
   DECLARE ainq100_qcba_cur2 CURSOR FOR ainq100_qcba_pre2
   FOREACH ainq100_qcba_cur2 INTO g_imaa3_d[l_ac6].type,g_imaa3_d[l_ac6].gj_num,g_imaa3_d[l_ac6].xq_num,
                                  g_imaa3_d[l_ac6].stock,l_qcba016
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_qcba016) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_qcba016,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa3_d[l_ac6].gj_num = g_imaa3_d[l_ac6].gj_num * r_rate
#         END IF   
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_qcba016,g_imaa_d[g_detail_idx].imaa006,g_imaa3_d[l_ac6].gj_num)
              RETURNING r_success,g_imaa3_d[l_ac6].gj_num
      END IF        
      LET l_gj_sum = l_gj_sum + g_imaa3_d[l_ac6].gj_num
      LET g_imaa3_d[l_ac6].stock = l_stock + g_imaa3_d[l_ac6].gj_num
      LET l_stock = g_imaa3_d[l_ac6].stock  
      
      LET l_ac6 = l_ac6 + 1 
      
   END FOREACH     
   
   #委外IQC在驗量(參考數量) 
   LET l_sql = " SELECT '10',0,0,0,SUM(COALESCE(pmdt020,0)-COALESCE(pmdt055,0)-COALESCE(pmdt055,0)),pmdt019 FROM pmds_t,pmdt_t ",
               "  WHERE pmdsent = pmdtent ",
               "    AND pmdsent = ",g_enterprise,  #151012-00011 by whitney add
               "    AND pmdssite = '",g_site,"'",
               "    AND pmdsdocno = pmdtdocno ",
               "    AND pmds000 = '12' ",
               "    AND pmds011 IN ('2','6')",
               "    AND pmdsstus = 'Y' ",
               "    AND pmdt006 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND (COALESCE(pmdt020,0)-COALESCE(pmdt055,0)-COALESCE(pmdt055,0)) <> 0 "
               
               
#   IF g_gxdate <> '5' THEN
#      LET l_sql = l_sql," AND pmdsdocdt <= '",g_bdate,"'"
#   END IF 
   LET l_sql = l_sql,"  ORDER BY pmdsdocdt,pmdtdocno,pmdtseq"   
   PREPARE ainq100_pmds_pre3 FROM l_sql
   DECLARE ainq100_pmds_cur3 CURSOR FOR ainq100_pmds_pre3
   FOREACH ainq100_pmds_cur3 INTO g_imaa3_d[l_ac6].type,g_imaa3_d[l_ac6].gj_num,g_imaa3_d[l_ac6].xq_num,
                                  g_imaa3_d[l_ac6].stock,l_pmdt019
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_pmdt019) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_pmdt019,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa3_d[l_ac6].ck_num = g_imaa3_d[l_ac6].ck_num * r_rate
#         END IF    
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_pmdt019,g_imaa_d[g_detail_idx].imaa006,g_imaa3_d[l_ac6].ck_num)
              RETURNING r_success,g_imaa3_d[l_ac6].ck_num
      END IF       
      LET g_imaa3_d[l_ac6].stock = l_stock 
      
      LET l_ac6 = l_ac6 + 1 
      
   END FOREACH    

   #備置量(參考數量)
   LET l_sql = " SELECT '11',0,0,0,SUM(COALESCE(inag021,0)),inag032 FROM inag_t ",
               "  WHERE inagent = ",g_enterprise,  #151012-00011 by whitney modify
               "    AND inagsite = '",g_site,"'",
               "    AND inag001 = '",g_imaa_d[g_detail_idx].imaa001,"'",
               "    AND inag010 = 'Y' "

   PREPARE ainq100_inag_pre2 FROM l_sql
   DECLARE ainq100_inag_cur2 CURSOR FOR ainq100_inag_pre2
   FOREACH ainq100_inag_cur2 INTO g_imaa3_d[l_ac6].type,g_imaa3_d[l_ac6].gj_num,g_imaa3_d[l_ac6].xq_num,
                                  g_imaa3_d[l_ac6].stock,l_inag032
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_inag032) AND NOT cl_null(g_imaa_d[g_detail_idx].imaa006) THEN
      
#         CALL s_aimi190_get_convert(g_imaa_d[g_detail_idx].imaa001,l_inag032,g_imaa_d[g_detail_idx].imaa006)
#              RETURNING r_success,r_rate   
#         IF r_success THEN
#            LET g_imaa3_d[l_ac6].ck_num = g_imaa3_d[l_ac6].ck_num * r_rate
#         END IF    
         CALl s_aooi250_convert_qty(g_imaa_d[g_detail_idx].imaa001,l_inag032,g_imaa_d[g_detail_idx].imaa006,g_imaa3_d[l_ac6].ck_num)
              RETURNING r_success,g_imaa3_d[l_ac6].ck_num
      END IF
      LET g_imaa3_d[l_ac6].stock = l_stock       
      LET l_ac6 = l_ac6 + 1 
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
   IF l_ac2 > 1 THEN
      CALL g_imaa2_d.deleteElement(g_imaa2_d.getLength())    
   END IF  
   LET l_ac2 = l_ac2 - 1   
   LET l_zj_sum = l_gj_sum - l_xq_sum
#   DISPLAY l_gj_sum TO sum1
#   DISPLAY l_xq_sum TO sum2
#   DISPLAY l_zj_sum TO sum3
#   LET g_sum1 = l_gj_sum
#   LET g_sum2 = l_xq_sum
#   LET g_sum3 = l_zj_sum
END FUNCTION

################################################################################
# Descriptions...: 根據查詢條件的下拉選項，動態顯示/隱藏畫面QBE條件
# Memo...........:
# Usage..........: CALL ainq100_qbe_visible()
#                  
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/09/03 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION ainq100_qbe_visible()

   IF g_qbe_type = '1' THEN
       CALL cl_set_comp_visible("group_6",TRUE)
       CALL cl_set_comp_visible("group_7,group_8,group_9,group_10,group_11",FALSE)  
    END IF             
    IF g_qbe_type = '2' THEN
       CALL cl_set_comp_visible("group_7",TRUE)
       CALL cl_set_comp_visible("group_6,group_8,group_9,group_10,group_11",FALSE) 
    END IF 
    IF g_qbe_type = '3' THEN
       CALL cl_set_comp_visible("group_8",TRUE)
       CALL cl_set_comp_visible("group_6,group_7,group_9,group_10,group_11",FALSE) 
    END IF 
    IF g_qbe_type = '4' THEN
       CALL cl_set_comp_visible("group_9",TRUE)
       CALL cl_set_comp_visible("group_6,group_7,group_8,group_10,group_11",FALSE) 
    END IF        
    IF g_qbe_type = '5' THEN
       CALL cl_set_comp_visible("group_10",TRUE)
       CALL cl_set_comp_visible("group_6,group_7,group_8,group_9,group_11",FALSE) 
    END IF        
    IF g_qbe_type = '6' THEN
       CALL cl_set_comp_visible("group_11",TRUE)
       CALL cl_set_comp_visible("group_6,group_7,group_8,group_9,group_10",FALSE)
    END IF
    
END FUNCTION

################################################################################
# Descriptions...: 在捡量页签显示
# Memo...........:
# Usage..........: CALL ainq100_b_fill7()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainq100_b_fill7()
DEFINE  l_sql              STRING

   CALL g_inap_d.clear() 
   IF g_detail_idx = 0 OR cl_null(g_detail_idx) THEN
      RETURN
   END IF   
   IF cl_null(g_imaa_d[g_detail_idx].imaa001) OR cl_null(g_inag_d[g_detail_idx3].inag004) THEN
      RETURN
   END IF
   LET l_sql = " SELECT UNIQUE inapsite,inap004,t1.imaal003,t1.imaal004,inap005,t2.inaml004,inap006,inap007,t3.inayl003,inap008,t4.inab003,inap009,inap014,inap001,inap002,inap003,'',inap016,inap013,",   #161116-00015#1 add ''
               " inap017,t5.ooag011,inap018,t6.ooefl003 FROM inap_t ", 
               " LEFT JOIN inaa_t ON inapent = inaaent AND inapsite = inaasite AND inap007 = inaa001 ",
         
               " LEFT JOIN inag_t ON inapent = inagent AND inapsite = inagsite AND inap007 = inag004 AND inap004 = inag001 AND inap005 = inag002 AND inap006 = inag003 ",   #160225-00010#1
               " LEFT JOIN inad_t ON inapent = inadent AND inapsite = inadsite AND inap004 = inad001 AND inap005 = inad002 AND inap009 = inad003 ",
               " LEFT OUTER JOIN imaal_t t1 ON t1.imaal001 = inap004 AND t1.imaal002 = '",g_dlang,"' AND t1.imaalent = '",g_enterprise,"'",
               " LEFT OUTER JOIN inaml_t t2 ON t2.inaml001 = inap004 AND t2.inaml002 = inap005 AND t2.inaml003 = '",g_dlang,"' AND t2.inamlent = '",g_enterprise,"'",
               " LEFT OUTER JOIN inayl_t t3 ON t3.inayl001 = inap007 AND t3.inayl002 = '",g_dlang,"' AND inaylent = '",g_enterprise,"'",
               " LEFT OUTER JOIN inab_t t4 ON t4.inab001 = inap007 AND inab002 = inap008 AND inabsite = '",g_site,"'",
               " LEFT OUTER JOIN ooag_t t5 ON t5.ooag001 = inap017 AND t5.ooagent = '",g_enterprise,"'",
               " LEFT OUTER JOIN ooefl_t t6 ON t6.ooefl001 = inap018 AND t6.ooefl002 = '",g_dlang,"' AND t6.ooeflent = '",g_enterprise,"'",
               " ",
               
               
               " WHERE inapent=",g_enterprise,
               "   AND inapsite = '",g_site,"'" 
               
   IF NOT cl_null(g_imaa_d[g_detail_idx].imaa001) THEN    
      LET l_sql = l_sql," AND inap004='",g_imaa_d[g_detail_idx].imaa001,"'"
   END IF   
   
#   IF g_inag_d[g_detail_idx3].inag002 IS NOT NULL THEN
#      LET l_sql = l_sql," AND inap005='",g_inag_d[g_detail_idx3].inag002,"'"
#   END IF
#   IF g_inag_d[g_detail_idx3].inag003 IS NOT NULL THEN
#      LET l_sql = l_sql," AND inap006='",g_inag_d[g_detail_idx3].inag003,"'"
#   END IF
#   IF g_inag_d[g_detail_idx3].inag004 IS NOT NULL THEN
#      LET l_sql = l_sql," AND inap007='",g_inag_d[g_detail_idx3].inag004,"'"
#   END IF
#   IF NOT cl_null(g_inag_d[g_detail_idx3].inag005) THEN
#      LET l_sql = l_sql," AND inap008='",g_inag_d[g_detail_idx3].inag005,"'"
#   END IF
#   IF g_inag_d[g_detail_idx3].inag006 IS NOT NULL THEN
#      LET l_sql = l_sql," AND inap009='",g_inag_d[g_detail_idx3].inag006,"'"
#   END IF
   
   LET l_sql = l_sql, " ORDER BY inapsite,inap004,inap005,inap006,inap007,inap008,inap009,inap014,inap001,inap002,inap003"
      #end add-point
 
      LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
      PREPARE ainq100_pb2 FROM l_sql
      DECLARE b_fill_curs2 CURSOR FOR ainq100_pb2
 
   LET l_ac7 = 1
   FOREACH b_fill_curs2 INTO g_inap_d[l_ac7].inapsite,g_inap_d[l_ac7].inap004,g_inap_d[l_ac7].inap004_desc, 
       g_inap_d[l_ac7].inap004_desc_1,g_inap_d[l_ac7].inap005,g_inap_d[l_ac7].inap005_desc,g_inap_d[l_ac7].inap006, 
       g_inap_d[l_ac7].inap007,g_inap_d[l_ac7].inap007_desc,g_inap_d[l_ac7].inap008,g_inap_d[l_ac7].inap008_desc, 
       g_inap_d[l_ac7].inap009,g_inap_d[l_ac7].inap014,g_inap_d[l_ac7].inap001,g_inap_d[l_ac7].inap002, 
       g_inap_d[l_ac7].inap003,g_inap_d[l_ac7].xmdrseq2,g_inap_d[l_ac7].inap016,g_inap_d[l_ac7].inap013,g_inap_d[l_ac7].inap017,  #161006-00018#28 
       g_inap_d[l_ac7].inap017_desc,g_inap_d[l_ac7].inap018,g_inap_d[l_ac7].inap018_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill2"

      #end add-point
 
      CALL ainq100_detail_show("'7'")
 
      #CALL ainq100_inap_t_mask()
 
      IF l_ac7 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac7 = l_ac7 + 1
 
   END FOREACH
   
   #161006-00018#28-S
   #订单备置
   LET l_sql = " SELECT UNIQUE xmdrsite,xmdr001,t1.imaal003,t1.imaal004,xmdr002,t2.inaml004,xmdr003,xmdr004,t3.inayl003, ",
               "               xmdr005,t4.inab003,xmdr006,'axmt500',xmdrdocno,xmdrseq,xmdrseq1,xmdrseq2,'',xmdr008,xmda002,t5.ooag011,xmda003,t6.ooefl003 ",
               "   FROM xmdr_t ",
               "   LEFT JOIN xmda_t ON xmdaent = xmdrent AND xmdadocno = xmdrdocno ",
               "   LEFT JOIN inaa_t ON xmdrent = inaaent AND xmdrsite = inaasite AND xmdr004 = inaa001 ",             
               "   LEFT JOIN inag_t ON xmdrent = inagent AND xmdrsite = inagsite AND xmdr004 = inag004 AND xmdr001 = inag001 AND xmdr002 = inag002 AND xmdr003 = inag003 ",  
               "   LEFT JOIN inad_t ON xmdrent = inadent AND xmdrsite = inadsite AND xmdr001 = inad001 AND xmdr002 = inad002 AND xmdr003 = inad003 ",    
               "   LEFT OUTER JOIN imaal_t t1 ON t1.imaalent = xmdrent AND t1.imaal001 = xmdr001 AND t1.imaal002 = '",g_dlang,"' AND imaalent = ",g_enterprise,
               "   LEFT OUTER JOIN inaml_t t2 ON t2.inamlent = xmdrent AND t2.inaml001 = xmdr001 AND t2.inaml002 = xmdr002 AND t2.inaml003 = '",g_dlang,"' AND inamlent = ",g_enterprise,
               "   LEFT OUTER JOIN inayl_t t3 ON t3.inaylent = xmdrent AND t3.inayl001 = xmdr004 AND t3.inayl002 = '",g_dlang,"' AND inaylent = ",g_enterprise,   
               "   LEFT OUTER JOIN inab_t t4 ON t4.inabent = xmdrent AND t4.inabsite = xmdrsite AND t4.inab001 = xmdr004 AND t4.inab002 = xmdr005 ",     
               "   LEFT OUTER JOIN ooag_t t5 ON t5.ooagent = xmdaent AND t5.ooag001 = xmda002 ",
               "   LEFT OUTER JOIN ooefl_t t6 ON t6.ooeflent = xmdaent AND t6.ooefl001 = xmda003 AND t6.ooefl002 = '",g_dlang,"' ",               
               "  WHERE xmdrent = ",g_enterprise,
               "    AND xmdrsite = '",g_site,"'"

   IF NOT cl_null(g_imaa_d[g_detail_idx].imaa001) THEN    
      LET l_sql = l_sql," AND xmdr001='",g_imaa_d[g_detail_idx].imaa001,"'"
   END IF   
   LET l_sql = l_sql, " ORDER BY xmdrsite,xmdr001,xmdr002,xmdr003,xmdr004,xmdr005,xmdr006,xmdrdocno,xmdrseq,xmdrseq1,xmdrseq2"
 
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   
   PREPARE ainq100_pb3 FROM l_sql
   DECLARE b_fill_curs3 CURSOR FOR ainq100_pb3 
   FOREACH b_fill_curs3 INTO g_inap_d[l_ac7].inapsite,g_inap_d[l_ac7].inap004,g_inap_d[l_ac7].inap004_desc, 
       g_inap_d[l_ac7].inap004_desc_1,g_inap_d[l_ac7].inap005,g_inap_d[l_ac7].inap005_desc,g_inap_d[l_ac7].inap006, 
       g_inap_d[l_ac7].inap007,g_inap_d[l_ac7].inap007_desc,g_inap_d[l_ac7].inap008,g_inap_d[l_ac7].inap008_desc, 
       g_inap_d[l_ac7].inap009,g_inap_d[l_ac7].inap014,g_inap_d[l_ac7].inap001,g_inap_d[l_ac7].inap002, 
       g_inap_d[l_ac7].inap003,g_inap_d[l_ac7].xmdrseq2,g_inap_d[l_ac7].inap016,g_inap_d[l_ac7].inap013,g_inap_d[l_ac7].inap017,  #161006-00018#28 
       g_inap_d[l_ac7].inap017_desc,g_inap_d[l_ac7].inap018,g_inap_d[l_ac7].inap018_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF

      CALL ainq100_detail_show("'7'")
  
      IF l_ac7 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac7 = l_ac7 + 1
 
   END FOREACH
      
   #工单备置
   LET l_sql = " SELECT DISTINCT sfbbsite,sfbb001,t1.imaal003,t1.imaal004,sfbb002,t2.inaml004,sfbb003,sfbb004,t3.inayl003, ",
               "               sfbb005,t4.inab003,sfbb006,'asft300',sfbbdocno,sfbbseq,sfbbseq1,'','',sfbb008,sfaa002,t5.ooag011,t5.ooag003,'' ",
               "   FROM sfbb_t ",
               "   LEFT JOIN sfaa_t ON sfaaent = sfbbent AND sfaadocno = sfbbdocno ",
               "   LEFT JOIN inaa_t ON sfbbent = inaaent AND sfbbsite = inaasite AND sfbb004 = inaa001 ",             
               "   LEFT JOIN inag_t ON sfbbent = inagent AND sfbbsite = inagsite AND sfbb004 = inag004 AND sfbb001 = inag001 AND sfbb002 = inag002 AND sfbb003 = inag003 ",  
               "   LEFT JOIN inad_t ON sfbbent = inadent AND sfbbsite = inadsite AND sfbb001 = inad001 AND sfbb002 = inad002 AND sfbb003 = inad003 ",    
               "   LEFT OUTER JOIN imaal_t t1 ON t1.imaalent = sfbbent AND t1.imaal001 = sfbb001 AND t1.imaal002 = '",g_dlang,"' AND imaalent = ",g_enterprise,
               "   LEFT OUTER JOIN inaml_t t2 ON t2.inamlent = sfbbent AND t2.inaml001 = sfbb001 AND t2.inaml002 = sfbb002 AND t2.inaml003 = '",g_dlang,"' AND inamlent = ",g_enterprise,
               "   LEFT OUTER JOIN inayl_t t3 ON t3.inaylent = sfbbent AND t3.inayl001 = sfbb004 AND t3.inayl002 = '",g_dlang,"' AND inaylent = ",g_enterprise,   
               "   LEFT OUTER JOIN inab_t t4 ON t4.inabent = sfbbent AND t4.inabsite = sfbbsite AND t4.inab001 = sfbb004 AND t4.inab002 = sfbb005 ",  
               "   LEFT OUTER JOIN ooag_t t5 ON t5.ooagent = sfaaent AND t5.ooag001 = sfaa002 ",               
               "  WHERE sfbbent = ",g_enterprise,
               "    AND sfbbsite = '",g_site,"'"

   IF NOT cl_null(g_imaa_d[g_detail_idx].imaa001) THEN    
      LET l_sql = l_sql," AND sfbb001='",g_imaa_d[g_detail_idx].imaa001,"'"
   END IF   
   LET l_sql = l_sql, " ORDER BY sfbbsite,sfbb001,sfbb002,sfbb003,sfbb004,sfbb005,sfbb006,sfbbdocno,sfbbseq,sfbbseq1"
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   
   PREPARE ainq100_pb4 FROM l_sql
   DECLARE b_fill_curs4 CURSOR FOR ainq100_pb4 
   FOREACH b_fill_curs4 INTO g_inap_d[l_ac7].inapsite,g_inap_d[l_ac7].inap004,g_inap_d[l_ac7].inap004_desc, 
       g_inap_d[l_ac7].inap004_desc_1,g_inap_d[l_ac7].inap005,g_inap_d[l_ac7].inap005_desc,g_inap_d[l_ac7].inap006, 
       g_inap_d[l_ac7].inap007,g_inap_d[l_ac7].inap007_desc,g_inap_d[l_ac7].inap008,g_inap_d[l_ac7].inap008_desc, 
       g_inap_d[l_ac7].inap009,g_inap_d[l_ac7].inap014,g_inap_d[l_ac7].inap001,g_inap_d[l_ac7].inap002, 
       g_inap_d[l_ac7].inap003,g_inap_d[l_ac7].xmdrseq2,g_inap_d[l_ac7].inap016,g_inap_d[l_ac7].inap013,g_inap_d[l_ac7].inap017,  #161006-00018#28 
       g_inap_d[l_ac7].inap017_desc,g_inap_d[l_ac7].inap018,g_inap_d[l_ac7].inap018_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      CALL s_desc_get_department_desc(g_inap_d[l_ac7].inap018) RETURNING g_inap_d[l_ac7].inap018_desc
      CALL ainq100_detail_show("'7'")
  
      IF l_ac7 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac7 = l_ac7 + 1
 
   END FOREACH   
   #161006-00018#28-E
   
   LET l_ac7 = l_ac7 - 1
#Page7
   CALL g_inap_d.deleteElement(g_inap_d.getLength())
   
   LET g_detail_cnt7 = l_ac7 - 1       
   DISPLAY ARRAY g_inap_d TO s_detail7.* ATTRIBUTE(COUNT=g_detail_cnt7)
      BEFORE DISPLAY 
         EXIT DISPLAY
   END DISPLAY     
END FUNCTION

 
{</section>}
 
