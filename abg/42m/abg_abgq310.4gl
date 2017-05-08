#該程式未解開Section, 採用最新樣板產出!
{<section id="abgq310.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-12-19 18:55:47), PR版次:0002(2017-02-15 12:43:03)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgq310
#+ Description: 銷售預算查詢
#+ Creator....: 02599(2016-12-09 15:06:32)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="abgq310.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#170215-00006#1   2017/02/15  By 02599    当来源作业选择30.销售审核是，明细页签抓取资料时，增加限制条件：销售来源bgcj005 IN 汇总明细页签中预算组织对应销售来源
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
PRIVATE TYPE type_g_detail RECORD
       
       name LIKE type_t.chr500, 
   pid LIKE type_t.chr500, 
   id LIKE type_t.chr500, 
   exp LIKE type_t.chr500, 
   isnode LIKE type_t.chr500, 
   isExp LIKE type_t.num5, 
   expcode LIKE type_t.num5, 
   bgcj007 LIKE bgcj_t.bgcj007, 
   bgcj007_desc LIKE type_t.chr500, 
   bgcj047 LIKE bgcj_t.bgcj047, 
   bgcj047_desc LIKE type_t.chr500, 
   sel LIKE type_t.chr1
       END RECORD
PRIVATE TYPE type_g_detail2 RECORD
       seq LIKE type_t.num10, 
   bgcj007 LIKE bgcj_t.bgcj007, 
   bgcj007_1_desc LIKE type_t.chr500, 
   bgcj009 LIKE bgcj_t.bgcj009, 
   bgcj009_desc LIKE type_t.chr500, 
   bgcj049 LIKE bgcj_t.bgcj049, 
   bgcj049_desc LIKE type_t.chr500, 
   bgcj012 LIKE bgcj_t.bgcj012, 
   bgcj012_desc LIKE type_t.chr500, 
   bgcj013 LIKE bgcj_t.bgcj013, 
   bgcj013_desc LIKE type_t.chr500, 
   bgcj014 LIKE bgcj_t.bgcj014, 
   bgcj014_desc LIKE type_t.chr500, 
   bgcj015 LIKE bgcj_t.bgcj015, 
   bgcj015_desc LIKE type_t.chr500, 
   bgcj016 LIKE bgcj_t.bgcj016, 
   bgcj016_desc LIKE type_t.chr500, 
   bgcj017 LIKE bgcj_t.bgcj017, 
   bgcj017_desc LIKE type_t.chr500, 
   bgcj018 LIKE bgcj_t.bgcj018, 
   bgcj018_desc LIKE type_t.chr500, 
   bgcj019 LIKE bgcj_t.bgcj019, 
   bgcj019_desc LIKE type_t.chr500, 
   bgcj020 LIKE bgcj_t.bgcj020, 
   bgcj020_desc LIKE type_t.chr500, 
   bgcj021 LIKE bgcj_t.bgcj021, 
   bgcj021_desc LIKE type_t.chr500, 
   bgcj022 LIKE bgcj_t.bgcj022, 
   bgcj023 LIKE bgcj_t.bgcj023, 
   bgcj023_desc LIKE type_t.chr500, 
   bgcj024 LIKE bgcj_t.bgcj024, 
   bgcj024_desc LIKE type_t.chr500, 
   bgcj100 LIKE bgcj_t.bgcj100, 
   amt1 LIKE type_t.num20_6, 
   bamt1 LIKE type_t.num20_6, 
   amt2 LIKE type_t.num20_6, 
   bamt2 LIKE type_t.num20_6, 
   amt3 LIKE type_t.num20_6, 
   bamt3 LIKE type_t.num20_6, 
   amt4 LIKE type_t.num20_6, 
   bamt4 LIKE type_t.num20_6, 
   amt5 LIKE type_t.num20_6, 
   bamt5 LIKE type_t.num20_6, 
   amt6 LIKE type_t.num20_6, 
   bamt6 LIKE type_t.num20_6, 
   amt7 LIKE type_t.num20_6, 
   bamt7 LIKE type_t.num20_6, 
   amt8 LIKE type_t.num20_6, 
   bamt8 LIKE type_t.num20_6, 
   amt9 LIKE type_t.num20_6, 
   bamt9 LIKE type_t.num20_6, 
   amt10 LIKE type_t.num20_6, 
   bamt10 LIKE type_t.num20_6, 
   amt11 LIKE type_t.num20_6, 
   bamt11 LIKE type_t.num20_6, 
   amt12 LIKE type_t.num20_6, 
   bamt12 LIKE type_t.num20_6, 
   amt13 LIKE type_t.num20_6, 
   bamt13 LIKE type_t.num20_6, 
   sum1 LIKE type_t.num20_6, 
   bsum1 LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_detail3 RECORD
       seq2 LIKE type_t.num10, 
   bgcj007 LIKE bgcj_t.bgcj007, 
   bgcj007_2_desc LIKE type_t.chr500, 
   bgcj009 LIKE bgcj_t.bgcj009, 
   bgcj009_2_desc LIKE type_t.chr500, 
   bgcj049 LIKE bgcj_t.bgcj049, 
   bgcj049_2_desc LIKE type_t.chr500, 
   bgcj012 LIKE bgcj_t.bgcj012, 
   bgcj012_2_desc LIKE type_t.chr500, 
   bgcj013 LIKE bgcj_t.bgcj013, 
   bgcj013_2_desc LIKE type_t.chr500, 
   bgcj014 LIKE bgcj_t.bgcj014, 
   bgcj014_2_desc LIKE type_t.chr500, 
   bgcj015 LIKE bgcj_t.bgcj015, 
   bgcj015_2_desc LIKE type_t.chr500, 
   bgcj016 LIKE bgcj_t.bgcj016, 
   bgcj016_2_desc LIKE type_t.chr500, 
   bgcj017 LIKE bgcj_t.bgcj017, 
   bgcj017_2_desc LIKE type_t.chr500, 
   bgcj018 LIKE bgcj_t.bgcj018, 
   bgcj018_2_desc LIKE type_t.chr500, 
   bgcj019 LIKE bgcj_t.bgcj019, 
   bgcj019_2_desc LIKE type_t.chr500, 
   bgcj020 LIKE bgcj_t.bgcj020, 
   bgcj020_2_desc LIKE type_t.chr500, 
   bgcj021 LIKE bgcj_t.bgcj021, 
   bgcj021_2_desc LIKE type_t.chr500, 
   bgcj022 LIKE bgcj_t.bgcj022, 
   bgcj023 LIKE bgcj_t.bgcj023, 
   bgcj023_2_desc LIKE type_t.chr500, 
   bgcj024 LIKE bgcj_t.bgcj024, 
   bgcj024_2_desc LIKE type_t.chr500, 
   bgcj035 LIKE bgcj_t.bgcj035, 
   bgcj036 LIKE bgcj_t.bgcj036, 
   bgcj037 LIKE bgcj_t.bgcj037, 
   bgcj100 LIKE bgcj_t.bgcj100, 
   tnum1 LIKE type_t.num20_6, 
   tprice1 LIKE type_t.num20_6, 
   tamt1 LIKE type_t.num20_6, 
   tbamt1 LIKE type_t.num20_6, 
   tnum2 LIKE type_t.num20_6, 
   tprice2 LIKE type_t.num20_6, 
   tamt2 LIKE type_t.num20_6, 
   tbamt2 LIKE type_t.num20_6, 
   tnum3 LIKE type_t.num20_6, 
   tprice3 LIKE type_t.num20_6, 
   tamt3 LIKE type_t.num20_6, 
   tbamt3 LIKE type_t.num20_6, 
   tnum4 LIKE type_t.num20_6, 
   tprice4 LIKE type_t.num20_6, 
   tamt4 LIKE type_t.num20_6, 
   tbamt4 LIKE type_t.num20_6, 
   tnum5 LIKE type_t.num20_6, 
   tprice5 LIKE type_t.num20_6, 
   tamt5 LIKE type_t.num20_6, 
   tbamt5 LIKE type_t.num20_6, 
   tnum6 LIKE type_t.num20_6, 
   tprice6 LIKE type_t.num20_6, 
   tamt6 LIKE type_t.num20_6, 
   tbamt6 LIKE type_t.num20_6, 
   tnum7 LIKE type_t.num20_6, 
   tprice7 LIKE type_t.num20_6, 
   tamt7 LIKE type_t.num20_6, 
   tbamt7 LIKE type_t.num20_6, 
   tnum8 LIKE type_t.num20_6, 
   tprice8 LIKE type_t.num20_6, 
   tamt8 LIKE type_t.num20_6, 
   tbamt8 LIKE type_t.num20_6, 
   tnum9 LIKE type_t.num20_6, 
   tprice9 LIKE type_t.num20_6, 
   tamt9 LIKE type_t.num20_6, 
   tbamt9 LIKE type_t.num20_6, 
   tnum10 LIKE type_t.num20_6, 
   tprice10 LIKE type_t.num20_6, 
   tamt10 LIKE type_t.num20_6, 
   tbamt10 LIKE type_t.num20_6, 
   tnum11 LIKE type_t.num20_6, 
   tprice11 LIKE type_t.num20_6, 
   tamt11 LIKE type_t.num20_6, 
   tbamt11 LIKE type_t.num20_6, 
   tnum12 LIKE type_t.num20_6, 
   tprice12 LIKE type_t.num20_6, 
   tamt12 LIKE type_t.num20_6, 
   tbamt12 LIKE type_t.num20_6, 
   tnum13 LIKE type_t.num20_6, 
   tprice13 LIKE type_t.num20_6, 
   tamt13 LIKE type_t.num20_6, 
   tbamt13 LIKE type_t.num20_6, 
   sum2 LIKE type_t.num20_6, 
   bsum2 LIKE type_t.num20_6
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input           RECORD
       bgcj002           LIKE bgcj_t.bgcj002,
       bgcj002_desc      LIKE bgaal_t.bgaal003,
       bgcj003           LIKE bgcj_t.bgcj003,
       bgcj007           LIKE bgcj_t.bgcj007,
       bgcj007_desc      LIKE ooefl_t.ooefl003,
       lower             LIKE type_t.chr1, #含下層組織
       bgaa003           LIKE bgaa_t.bgaa003,
       bgcj001           LIKE bgcj_t.bgcj001,
       kind              LIKE type_t.chr1, #維度選項
       bgap004           LIKE type_t.chr1, #關係人選項
       stus              LIKE type_t.chr1, 
       show_curr         LIKE type_t.chr1, #顯示預算幣別
       #核算項顯示與否--str--
       hsx_bgcj009       LIKE type_t.chr1,
       hsx_bgcj012       LIKE type_t.chr1,
       hsx_bgcj017       LIKE type_t.chr1,
       hsx_bgcj022       LIKE type_t.chr1,
       hsx_bgcj049       LIKE type_t.chr1,
       hsx_bgcj013       LIKE type_t.chr1,
       hsx_bgcj018       LIKE type_t.chr1,
       hsx_bgcj023       LIKE type_t.chr1,
       hsx_bgcj014       LIKE type_t.chr1,
       hsx_bgcj019       LIKE type_t.chr1,
       hsx_bgcj024       LIKE type_t.chr1,
       hsx_bgcj015       LIKE type_t.chr1,
       hsx_bgcj020       LIKE type_t.chr1,
       hsx_bgcj016       LIKE type_t.chr1,
       hsx_bgcj021       LIKE type_t.chr1
       #核算項顯示與否--end
       END RECORD 
DEFINE g_max_period      LIKE type_t.num5
DEFINE g_bgaa010         LIKE bgaa_t.bgaa010
DEFINE g_bgaa011         LIKE bgaa_t.bgaa011
DEFINE g_sql_bgap004     STRING
DEFINE g_sql_stus        STRING
DEFINE g_bgai002         LIKE bgai_t.bgai002
DEFINE g_bgai008         LIKE bgai_t.bgai008
DEFINE g_bgaw1      DYNAMIC ARRAY OF VARCHAR(1) #位置在单头+显示为 Y，否则为 N
DEFINE g_bgaw2      DYNAMIC ARRAY OF VARCHAR(1) #位置在单身+显示为 Y，否则为 N
#记录单身三种核算项的显示情况
DEFINE g_hsx_visible     RECORD
       hsx_bgcj012       LIKE type_t.num5,
       hsx_bgcj013       LIKE type_t.num5,
       hsx_bgcj014       LIKE type_t.num5,
       hsx_bgcj015       LIKE type_t.num5,
       hsx_bgcj016       LIKE type_t.num5,
       hsx_bgcj017       LIKE type_t.num5,
       hsx_bgcj018       LIKE type_t.num5,
       hsx_bgcj019       LIKE type_t.num5,
       hsx_bgcj020       LIKE type_t.num5,
       hsx_bgcj021       LIKE type_t.num5,
       hsx_bgcj022       LIKE type_t.num5,
       hsx_bgcj023       LIKE type_t.num5,
       hsx_bgcj024       LIKE type_t.num5
       END RECORD
DEFINE g_bgal RECORD  #預算專案維護檔
       bgal005 LIKE bgal_t.bgal005, #部門
       bgal006 LIKE bgal_t.bgal006, #利潤/成本中心
       bgal007 LIKE bgal_t.bgal007, #區域
       bgal008 LIKE bgal_t.bgal008, #交易客商
       bgal009 LIKE bgal_t.bgal009, #收款客商
       bgal010 LIKE bgal_t.bgal010, #客群
       bgal011 LIKE bgal_t.bgal011, #產品類別
       bgal012 LIKE bgal_t.bgal012, #人員
       bgal013 LIKE bgal_t.bgal013, #專案編號
       bgal014 LIKE bgal_t.bgal014, #WBS
       bgal025 LIKE bgal_t.bgal025, #經營方式
       bgal026 LIKE bgal_t.bgal026, #通路
       bgal027 LIKE bgal_t.bgal027  #品牌
END RECORD
#多語言SQL
DEFINE g_get_sql   RECORD
       bgcj007     STRING,  #预算组织
       bgcj013     STRING,  #部门
       bgcj014     STRING,  #责任中心
       bgcj015     STRING,  #区域
       bgcj016     STRING,  #收付款客商
       bgcj017     STRING,  #账款客商
       bgcj018     STRING,  #客群
       bgcj019     STRING,  #产品类别
       bgcj012     STRING,  #人员
       bgcj020     STRING,  #专案编号
       bgcj021     STRING,  #WBS
       bgcj022     STRING,  #经营方式
       bgcj023     STRING,  #渠道
       bgcj024     STRING   #品牌  
                   END RECORD 
DEFINE g_flag          LIKE type_t.chr1
#用于显示可打印页签
DEFINE gr_page         DYNAMIC ARRAY OF RECORD
       l_sel           LIKE type_t.chr1,
       l_page          LIKE type_t.chr50
       END RECORD
DEFINE g_accept        LIKE type_t.chr1
DEFINE g_page_name     DYNAMIC ARRAY OF VARCHAR(200)      
DEFINE g_data_cnt      LIKE type_t.num5
DEFINE g_bgaa008       LIKE bgaa_t.bgaa008
DEFINE g_bgcj049_sql   STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_detail            DYNAMIC ARRAY OF type_g_detail
DEFINE g_detail_t          type_g_detail
DEFINE g_detail2     DYNAMIC ARRAY OF type_g_detail2
DEFINE g_detail2_t   type_g_detail2
 
DEFINE g_detail3     DYNAMIC ARRAY OF type_g_detail3
DEFINE g_detail3_t   type_g_detail3
 
 
 
 DEFINE g_browser_root  DYNAMIC ARRAY OF INTEGER   #root資料所在
 
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
 
{<section id="abgq310.main" >}
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
   CALL cl_ap_init("abg","")
 
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
   DECLARE abgq310_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abgq310_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgq310_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgq310 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgq310_init()   
 
      #進入選單 Menu (="N")
      CALL abgq310_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgq310
      
   END IF 
   
   CLOSE abgq310_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE abgq310_tmp1
   DROP TABLE abgq310_tmp2
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgq310.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abgq310_init()
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
   
      CALL cl_set_combo_scc('b_bgcj022','6013') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('bgcj005','8952') 
   CALL cl_set_combo_scc('bgcj022_2','6013') #核算项说明组成SQL
   #预算组织
   CALL s_fin_get_department_sql('ta3','bgcjent','bgcj007') RETURNING g_get_sql.bgcj007
   #部門
   CALL s_fin_get_department_sql('ta4','bgcjent','bgcj013') RETURNING g_get_sql.bgcj013
   #利润成本中心
   CALL s_fin_get_department_sql('ta5','bgcjent','bgcj014') RETURNING g_get_sql.bgcj014
   #区域
   CALL s_fin_get_acc_sql('ta6','bgcjent','287','bgcj015') RETURNING g_get_sql.bgcj015
   #收付款客商
   CALL s_fin_get_trading_partner_abbr_sql('ta7','bgcjent','bgcj016') RETURNING g_get_sql.bgcj016
   #账款客商
   CALL s_fin_get_trading_partner_abbr_sql('ta8','bgcjent','bgcj017') RETURNING g_get_sql.bgcj017
   #客群
   CALL s_fin_get_acc_sql('ta9','bgcjent','281','bgcj018') RETURNING g_get_sql.bgcj018
   #产品类别
   CALL s_fin_get_rtaxl003_sql('ta10','bgcjent','bgcj019') RETURNING g_get_sql.bgcj019
   #人员
   CALL s_fin_get_person_sql('ta11','bgcjent','bgcj012') RETURNING g_get_sql.bgcj012
   #专案
   CALL s_fin_get_project_sql('ta12','bgcjent','bgcj020') RETURNING g_get_sql.bgcj020
   #WBS
   CALL s_fin_get_wbs_sql('ta13','bgcjent','bgcj020','bgcj021') RETURNING g_get_sql.bgcj021
   #经营方式
   LET g_get_sql.bgcj022 = "(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='6013' AND gzcbl002=bgcj022 AND gzcbl003='"||g_dlang||"')"
   #渠道
   CALL s_fin_get_oojdl003_sql('ta14','bgcjent','bgcj023') RETURNING g_get_sql.bgcj023
   #品牌
   CALL s_fin_get_acc_sql('ta15','bgcjent','2002','bgcj024') RETURNING g_get_sql.bgcj024
   #报表临时表
   CALL abgq310_create_print_tmp()
   #end add-point
 
   CALL abgq310_default_search()
END FUNCTION
 
{</section>}
 
{<section id="abgq310.default_search" >}
PRIVATE FUNCTION abgq310_default_search()
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
 
{<section id="abgq310.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abgq310_ui_dialog() 
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
   LET g_wc = " 1=2"
   #end add-point
 
   
   CALL abgq310_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail.clear()
         CALL g_detail2.clear()
 
         CALL g_detail3.clear()
 
 
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
 
         CALL abgq310_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL abgq310_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL abgq310_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            #應用 qs20 樣板自動產生(Version:3)
            ON EXPAND (g_row_index)
               #樹展開
               CALL abgq310_tree_expand(g_row_index)
               LET g_detail[g_row_index].isExp = 1
 
            ON COLLAPSE (g_row_index)
               #樹關閉
 
 
 
 
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
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
               CALL abgq310_b_fill3(g_detail_idx2)
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
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL abgq310_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            NEXT FIELD b_bgcj007
            #end add-point
            NEXT FIELD bgcj002
 
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
            CALL abgq310_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_detail)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_detail2)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_detail3)
               LET g_export_id[3]   = "s_detail3"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL abgq310_b_fill()
 
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
            CALL abgq310_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL abgq310_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL abgq310_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL abgq310_b_fill()
 
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
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALl abgq310_output()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALl abgq310_output()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               CALL abgq310_query()
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
 
{<section id="abgq310.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgq310_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql           STRING
   DEFINE l_type          LIKE type_t.chr50
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL g_detail.clear()
   CALL g_detail2.clear()
   CALL g_detail3.clear()
   IF g_wc = " 1=2" THEN
      RETURN
   END IF
   
   #预算样式
   IF g_input.kind='1' THEN
      CALL s_abg2_get_bgai002(g_input.bgcj002,g_input.bgcj007,'01') RETURNING g_bgai002,g_bgai008
      CALL s_abg2_get_bgaw(g_bgai008) RETURNING g_bgaw1,g_bgaw2
   END IF
   #1.当版本没有值时，表示没有tree，则影藏单身中的tree
   #2.当没有勾选‘含下层组织’时，不显示tree
   #当不显示tree时，不用抓取资料，跳过b_fill，直接进入b_fill2抓取单身二资料
   IF NOT (NOT cl_null(g_bgaa010) AND g_input.lower = 'Y') THEN
      CALL abgq310_b_fill2()
      RETURN
   END IF
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
 
   CALL g_detail.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:3)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql name="b_fill.sql"
   LET l_sql="SELECT ooed004,t01.ooefl003,ooed005,t02.ooefl003 ",
             "  FROM ooed_t",
             "  LEFT JOIN ooefl_t t01 ON t01.ooeflent=",g_enterprise," AND t01.ooefl001=ooed004 AND t01.ooefl002='",g_dlang,"'",
             "  LEFT JOIN ooefl_t t02 ON t02.ooeflent=",g_enterprise," AND t02.ooefl001=ooed005 AND t02.ooefl002='",g_dlang,"'",
             " WHERE ooedent = ",g_enterprise,
             "   AND ooed001 = '4' AND ooed002 = '",g_bgaa011,"' ",
             "   AND ooed003 = '",g_bgaa010,"'",
             "   AND ooed004 = '",g_input.bgcj007,"' ",
             " ORDER BY ooed004"
             
   PREPARE abgq310_b_fill_pr FROM l_sql
   DECLARE abgq310_b_fill_cs CURSOR FOR abgq310_b_fill_pr
   LET l_ac = g_cnt
   LET g_cnt = 1
   LET l_type = "0"   
 
   FOREACH abgq310_b_fill_cs INTO g_detail[g_cnt].bgcj007,g_detail[g_cnt].bgcj007_desc,g_detail[g_cnt].bgcj047,g_detail[g_cnt].bgcj047_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
    
         EXIT FOREACH
      END IF
      
      LET g_detail[g_cnt].pid  = l_type
      LET g_detail[g_cnt].id   = l_type, '.', g_cnt USING "<<<"
      LET g_detail[g_cnt].exp  = FALSE
      LET g_detail[g_cnt].isnode = abgq310_chk_isnode(g_cnt)
      CALL abgq310_desc_show(g_cnt)
   
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH  
   #end add-point
 
 
 
 
 
   #應用 qs10 樣板自動產生(Version:3)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   CALL abgq310_b_fill2()
   RETURN
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_detail.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL abgq310_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL abgq310_detail_action_trans()
 
   LET l_ac = 1
   IF g_detail.getLength() > 0 THEN
      CALL abgq310_b_fill2()
   END IF
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abgq310.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abgq310_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_ac2           LIKE type_t.num10
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_sql1          STRING
   DEFINE l_sql2          STRING
   DEFINE l_sql           STRING
   DEFINE l_str           STRING
   DEFINE l_site_str      STRING
   DEFINE l_sql_bgcj007   STRING
   DEFINE l_sql_hsx       STRING
   DEFINE l_sum           LIKE bgcj_t.bgcj102
   DEFINE l_amt           LIKE bgcj_t.bgcj102
   DEFINE l_cnt           LIKE type_t.num10
   DEFINE l_curr_sum      RECORD
          amt1 LIKE type_t.num20_6, 
          bamt1 LIKE type_t.num20_6, 
          amt2 LIKE type_t.num20_6, 
          bamt2 LIKE type_t.num20_6, 
          amt3 LIKE type_t.num20_6, 
          bamt3 LIKE type_t.num20_6, 
          amt4 LIKE type_t.num20_6, 
          bamt4 LIKE type_t.num20_6, 
          amt5 LIKE type_t.num20_6, 
          bamt5 LIKE type_t.num20_6, 
          amt6 LIKE type_t.num20_6, 
          bamt6 LIKE type_t.num20_6, 
          amt7 LIKE type_t.num20_6, 
          bamt7 LIKE type_t.num20_6, 
          amt8 LIKE type_t.num20_6, 
          bamt8 LIKE type_t.num20_6, 
          amt9 LIKE type_t.num20_6, 
          bamt9 LIKE type_t.num20_6, 
          amt10 LIKE type_t.num20_6, 
          bamt10 LIKE type_t.num20_6, 
          amt11 LIKE type_t.num20_6, 
          bamt11 LIKE type_t.num20_6, 
          amt12 LIKE type_t.num20_6, 
          bamt12 LIKE type_t.num20_6, 
          amt13 LIKE type_t.num20_6, 
          bamt13 LIKE type_t.num20_6,
          sum1 LIKE type_t.num20_6,
          bsum1 LIKE type_t.num20_6
          END RECORD
   DEFINE l_bgcj100_o       LIKE bgcj_t.bgcj100 #记录币别旧值  
   DEFINE l_desc            STRING  #小计   
   DEFINE l_seq             LIKE bgcj_t.bgcjseq
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs11 樣板自動產生(Version:3)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
   #add-point:sql組成 name="b_fill2.fill"
   CALL g_detail2.clear()
   CALL g_detail3.clear()
   #预算组织条件
   IF g_detail.getLength()=0 THEN #表示查询出所有满足条件的预算组织资料
      LET l_sql_bgcj007=" AND bgcj007='",g_input.bgcj007,"'"
   ELSE
      IF g_input.bgcj001<>'30' THEN
         #明細
         #有权限的下层组织
         CALL s_abg2_get_site(g_input.bgcj002,g_detail[g_detail_idx].bgcj007,'01') RETURNING l_site_str
         LET l_sql_bgcj007=" AND bgcj007 IN ",l_site_str
      ELSE
         #匯總
         LET l_sql_bgcj007=" AND bgcj007='",g_detail[g_detail_idx].bgcj007,"'"
      END IF
   END IF
   
   CALL abgq310_sel_hsx() RETURNING l_str
   LET g_sql="SELECT DISTINCT bgcj007,",g_get_sql.bgcj007,l_str,",bgcj100 ",
             "  FROM bgcj_t ",
             " WHERE bgcjent=",g_enterprise,
             "   AND bgcj001='",g_input.bgcj001,"'",
             "   AND bgcj002='",g_input.bgcj002,"'",
             "   AND bgcj003='",g_input.bgcj003,"'",
             l_sql_bgcj007,
             "   AND ",g_wc,g_sql_bgap004,g_sql_stus,
             " ORDER BY bgcj007,bgcj009,bgcj049,bgcj012,bgcj013,bgcj014,",
             "          bgcj015,bgcj016,bgcj017,bgcj018,bgcj019,bgcj020,",
             "          bgcj021,bgcj022,bgcj023,bgcj024 "
   PREPARE abgq310_b_fill2_pr FROM g_sql
   DECLARE abgq310_b_fill2_cs CURSOR FOR abgq310_b_fill2_pr
   
   #抓取对应的每期金额
   LET l_str="SELECT SUM(bgcj102),SUM(bgcj102*bgcj101)",
             "  FROM bgcj_t ",
             " WHERE bgcjent=",g_enterprise,
             "   AND bgcj001='",g_input.bgcj001,"'",
             "   AND bgcj002='",g_input.bgcj002,"'",
             "   AND bgcj003='",g_input.bgcj003,"'",
             "   AND bgcj008=?",
             "   AND ",g_wc,g_sql_bgap004,g_sql_stus
   
   #按币别小计
   LET l_curr_sum.amt1  = 0
   LET l_curr_sum.bamt1 = 0
   LET l_curr_sum.amt2  = 0
   LET l_curr_sum.bamt2 = 0
   LET l_curr_sum.amt3  = 0
   LET l_curr_sum.bamt3 = 0
   LET l_curr_sum.amt4  = 0
   LET l_curr_sum.bamt4 = 0
   LET l_curr_sum.amt5  = 0
   LET l_curr_sum.bamt5 = 0
   LET l_curr_sum.amt6  = 0
   LET l_curr_sum.bamt6 = 0
   LET l_curr_sum.amt7  = 0
   LET l_curr_sum.bamt7 = 0
   LET l_curr_sum.amt8  = 0
   LET l_curr_sum.bamt8 = 0
   LET l_curr_sum.amt9  = 0
   LET l_curr_sum.bamt9 = 0
   LET l_curr_sum.amt10 = 0
   LET l_curr_sum.bamt10= 0
   LET l_curr_sum.amt11 = 0
   LET l_curr_sum.bamt11= 0
   LET l_curr_sum.amt12 = 0
   LET l_curr_sum.bamt12= 0
   LET l_curr_sum.amt13 = 0
   LET l_curr_sum.bamt13= 0
   LET l_curr_sum.sum1  = 0
   LET l_curr_sum.bsum1 = 0
   #小计：
   LET l_desc = cl_getmsg('aap-00287',g_dlang)
   LET l_seq = 0
   LET l_ac2 = 1
   FOREACH abgq310_b_fill2_cs INTO g_detail2[l_ac2].bgcj007,g_detail2[l_ac2].bgcj007_1_desc,g_detail2[l_ac2].bgcj009,
      g_detail2[l_ac2].bgcj049,g_detail2[l_ac2].bgcj049_desc,g_detail2[l_ac2].bgcj012,g_detail2[l_ac2].bgcj012_desc,
      g_detail2[l_ac2].bgcj013,g_detail2[l_ac2].bgcj013_desc,g_detail2[l_ac2].bgcj014,g_detail2[l_ac2].bgcj014_desc,
      g_detail2[l_ac2].bgcj015,g_detail2[l_ac2].bgcj015_desc,g_detail2[l_ac2].bgcj016,g_detail2[l_ac2].bgcj016_desc,
      g_detail2[l_ac2].bgcj017,g_detail2[l_ac2].bgcj017_desc,g_detail2[l_ac2].bgcj018,g_detail2[l_ac2].bgcj018_desc,
      g_detail2[l_ac2].bgcj019,g_detail2[l_ac2].bgcj019_desc,g_detail2[l_ac2].bgcj020,g_detail2[l_ac2].bgcj020_desc,
      g_detail2[l_ac2].bgcj021,g_detail2[l_ac2].bgcj021_desc,g_detail2[l_ac2].bgcj022,
      g_detail2[l_ac2].bgcj023,g_detail2[l_ac2].bgcj023_desc,g_detail2[l_ac2].bgcj024,g_detail2[l_ac2].bgcj024_desc,
      g_detail2[l_ac2].bgcj100
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
    
         EXIT FOREACH
      END IF
      #項次
      LET g_detail2[l_ac2].seq = l_seq + 1
      LET l_seq = l_seq + 1
      #合計
      LET g_detail2[l_ac2].sum1 = 0
      LET g_detail2[l_ac2].bsum1 = 0
      
      #根据核算项的显示有否组成核算项条件
      CALL abgq310_hsx_where(l_ac2) RETURNING l_sql_hsx
      LET l_sql=l_str,
                " AND bgcj007 = '",g_detail2[l_ac2].bgcj007,"'",
                " AND ",l_sql_hsx,
                " AND bgcj100='",g_detail2[l_ac2].bgcj100,"'"
      PREPARE abgq310_b_fill2_sum_pr FROM l_sql
      
      FOR l_i = 1 TO g_max_period
         LET l_sum = 0
         LET l_amt = 0
         EXECUTE abgq310_b_fill2_sum_pr USING l_i INTO l_sum,l_amt
         IF cl_null(l_sum) THEN LET l_sum = 0 END IF
         IF cl_null(l_amt) THEN LET l_amt = 0 END IF
         IF g_input.show_curr='Y' THEN
            CALL s_curr_round(g_detail2[l_ac2].bgcj007,g_input.bgaa003,l_amt,2) RETURNING l_amt
         END IF 
         CASE l_i
            WHEN 1
               LET g_detail2[l_ac2].amt1 = l_sum
               LET g_detail2[l_ac2].bamt1 = l_amt
            WHEN 2
               LET g_detail2[l_ac2].amt2 = l_sum
               LET g_detail2[l_ac2].bamt2 = l_amt
            WHEN 3
               LET g_detail2[l_ac2].amt3 = l_sum
               LET g_detail2[l_ac2].bamt3 = l_amt
            WHEN 4
               LET g_detail2[l_ac2].amt4 = l_sum
               LET g_detail2[l_ac2].bamt4 = l_amt
            WHEN 5
               LET g_detail2[l_ac2].amt5 = l_sum
               LET g_detail2[l_ac2].bamt5 = l_amt
            WHEN 6
               LET g_detail2[l_ac2].amt6 = l_sum
               LET g_detail2[l_ac2].bamt6 = l_amt
            WHEN 7
               LET g_detail2[l_ac2].amt7 = l_sum
               LET g_detail2[l_ac2].bamt7 = l_amt
            WHEN 8
               LET g_detail2[l_ac2].amt8 = l_sum
               LET g_detail2[l_ac2].bamt8 = l_amt
            WHEN 9
               LET g_detail2[l_ac2].amt9 = l_sum
               LET g_detail2[l_ac2].bamt9 = l_amt
            WHEN 10
               LET g_detail2[l_ac2].amt10 = l_sum
               LET g_detail2[l_ac2].bamt10 = l_amt
            WHEN 11
               LET g_detail2[l_ac2].amt11 = l_sum
               LET g_detail2[l_ac2].bamt11 = l_amt
            WHEN 12
               LET g_detail2[l_ac2].amt12 = l_sum
               LET g_detail2[l_ac2].bamt12 = l_amt
            WHEN 13
               LET g_detail2[l_ac2].amt13 = l_sum
               LET g_detail2[l_ac2].bamt13 = l_amt
         END CASE
         #合計
         LET g_detail2[l_ac2].sum1 = g_detail2[l_ac2].sum1 + l_sum
         LET g_detail2[l_ac2].bsum1 = g_detail2[l_ac2].bsum1 + l_amt
      END FOR
      
      #按照币别小计
      IF cl_null(l_bgcj100_o) THEN
         LET l_bgcj100_o = g_detail2[l_ac2].bgcj100
         #按币别小计
         LET l_curr_sum.amt1  = l_curr_sum.amt1  + g_detail2[l_ac2].amt1 
         LET l_curr_sum.bamt1 = l_curr_sum.bamt1 + g_detail2[l_ac2].bamt1
         LET l_curr_sum.amt2  = l_curr_sum.amt2  + g_detail2[l_ac2].amt2 
         LET l_curr_sum.bamt2 = l_curr_sum.bamt2 + g_detail2[l_ac2].bamt2
         LET l_curr_sum.amt3  = l_curr_sum.amt3  + g_detail2[l_ac2].amt3 
         LET l_curr_sum.bamt3 = l_curr_sum.bamt3 + g_detail2[l_ac2].bamt3
         LET l_curr_sum.amt4  = l_curr_sum.amt4  + g_detail2[l_ac2].amt4 
         LET l_curr_sum.bamt4 = l_curr_sum.bamt4 + g_detail2[l_ac2].bamt4
         LET l_curr_sum.amt5  = l_curr_sum.amt5  + g_detail2[l_ac2].amt5 
         LET l_curr_sum.bamt5 = l_curr_sum.bamt5 + g_detail2[l_ac2].bamt5
         LET l_curr_sum.amt6  = l_curr_sum.amt6  + g_detail2[l_ac2].amt6 
         LET l_curr_sum.bamt6 = l_curr_sum.bamt6 + g_detail2[l_ac2].bamt6
         LET l_curr_sum.amt7  = l_curr_sum.amt7  + g_detail2[l_ac2].amt7 
         LET l_curr_sum.bamt7 = l_curr_sum.bamt7 + g_detail2[l_ac2].bamt7
         LET l_curr_sum.amt8  = l_curr_sum.amt8  + g_detail2[l_ac2].amt8 
         LET l_curr_sum.bamt8 = l_curr_sum.bamt8 + g_detail2[l_ac2].bamt8
         LET l_curr_sum.amt9  = l_curr_sum.amt9  + g_detail2[l_ac2].amt9 
         LET l_curr_sum.bamt9 = l_curr_sum.bamt9 + g_detail2[l_ac2].bamt9 
         LET l_curr_sum.amt10 = l_curr_sum.amt10 + g_detail2[l_ac2].amt10 
         LET l_curr_sum.bamt10= l_curr_sum.bamt10+ g_detail2[l_ac2].bamt10
         LET l_curr_sum.amt11 = l_curr_sum.amt11 + g_detail2[l_ac2].amt11 
         LET l_curr_sum.bamt11= l_curr_sum.bamt11+ g_detail2[l_ac2].bamt11
         LET l_curr_sum.amt12 = l_curr_sum.amt12 + g_detail2[l_ac2].amt12 
         LET l_curr_sum.bamt12= l_curr_sum.bamt12+ g_detail2[l_ac2].bamt12
         LET l_curr_sum.amt13 = l_curr_sum.amt13 + g_detail2[l_ac2].amt13 
         LET l_curr_sum.bamt13= l_curr_sum.bamt13+ g_detail2[l_ac2].bamt13
         LET l_curr_sum.sum1  = l_curr_sum.sum1  + g_detail2[l_ac2].sum1
         LET l_curr_sum.bsum1 = l_curr_sum.bsum1 + g_detail2[l_ac2].bsum1
      ELSE
         IF l_bgcj100_o <> g_detail2[l_ac2].bgcj100 THEN
            #增加一行币别小计：
            LET g_detail2[l_ac2+1].* = g_detail2[l_ac2].*
            LET g_detail2[l_ac2+1].seq = g_detail2[l_ac2].seq
            LET g_detail2[l_ac2].seq = NULL
            LET g_detail2[l_ac2].bgcj007_1_desc = NULL
            LET g_detail2[l_ac2].bgcj009_desc = NULL
            LET g_detail2[l_ac2].bgcj049_desc = NULL
            LET g_detail2[l_ac2].bgcj012_desc = NULL
            LET g_detail2[l_ac2].bgcj013_desc = NULL
            LET g_detail2[l_ac2].bgcj014_desc = NULL
            LET g_detail2[l_ac2].bgcj015_desc = NULL
            LET g_detail2[l_ac2].bgcj016_desc = NULL
            LET g_detail2[l_ac2].bgcj017_desc = NULL
            LET g_detail2[l_ac2].bgcj018_desc = NULL
            LET g_detail2[l_ac2].bgcj019_desc = NULL
            LET g_detail2[l_ac2].bgcj020_desc = NULL
            LET g_detail2[l_ac2].bgcj021_desc = NULL
            LET g_detail2[l_ac2].bgcj023_desc = NULL
            LET g_detail2[l_ac2].bgcj024_desc = NULL
            LET g_detail2[l_ac2].bgcj100 = l_bgcj100_o,l_desc
            LET g_detail2[l_ac2].amt1 = l_curr_sum.amt1
            LET g_detail2[l_ac2].bamt1 = l_curr_sum.bamt1
            LET g_detail2[l_ac2].amt2 = l_curr_sum.amt2
            LET g_detail2[l_ac2].bamt2 = l_curr_sum.bamt2
            LET g_detail2[l_ac2].amt3 = l_curr_sum.amt3
            LET g_detail2[l_ac2].bamt3 = l_curr_sum.bamt3
            LET g_detail2[l_ac2].amt4 = l_curr_sum.amt4
            LET g_detail2[l_ac2].bamt4 = l_curr_sum.bamt4
            LET g_detail2[l_ac2].amt5 = l_curr_sum.amt5
            LET g_detail2[l_ac2].bamt5 = l_curr_sum.bamt5
            LET g_detail2[l_ac2].amt6 = l_curr_sum.amt6
            LET g_detail2[l_ac2].bamt6 = l_curr_sum.bamt6
            LET g_detail2[l_ac2].amt7 = l_curr_sum.amt7
            LET g_detail2[l_ac2].bamt7 = l_curr_sum.bamt7
            LET g_detail2[l_ac2].amt8 = l_curr_sum.amt8
            LET g_detail2[l_ac2].bamt8 = l_curr_sum.bamt8
            LET g_detail2[l_ac2].amt9 = l_curr_sum.amt9
            LET g_detail2[l_ac2].bamt9 = l_curr_sum.bamt9
            LET g_detail2[l_ac2].amt10 = l_curr_sum.amt10
            LET g_detail2[l_ac2].bamt10 = l_curr_sum.bamt10
            LET g_detail2[l_ac2].amt11 = l_curr_sum.amt11
            LET g_detail2[l_ac2].bamt11 = l_curr_sum.bamt11
            LET g_detail2[l_ac2].amt12 = l_curr_sum.amt12
            LET g_detail2[l_ac2].bamt12 = l_curr_sum.bamt12
            LET g_detail2[l_ac2].amt13 = l_curr_sum.amt13
            LET g_detail2[l_ac2].bamt13 = l_curr_sum.bamt13
            LET g_detail2[l_ac2].sum1 = l_curr_sum.sum1
            LET g_detail2[l_ac2].bsum1 = l_curr_sum.bsum1
            
            #按币别小计:汇总金额
            LET l_ac2 = l_ac2 + 1
            LET l_bgcj100_o = g_detail2[l_ac2].bgcj100 
            LET l_curr_sum.amt1  = g_detail2[l_ac2].amt1 
            LET l_curr_sum.bamt1 = g_detail2[l_ac2].bamt1
            LET l_curr_sum.amt2  = g_detail2[l_ac2].amt2 
            LET l_curr_sum.bamt2 = g_detail2[l_ac2].bamt2
            LET l_curr_sum.amt3  = g_detail2[l_ac2].amt3 
            LET l_curr_sum.bamt3 = g_detail2[l_ac2].bamt3
            LET l_curr_sum.amt4  = g_detail2[l_ac2].amt4 
            LET l_curr_sum.bamt4 = g_detail2[l_ac2].bamt4
            LET l_curr_sum.amt5  = g_detail2[l_ac2].amt5 
            LET l_curr_sum.bamt5 = g_detail2[l_ac2].bamt5
            LET l_curr_sum.amt6  = g_detail2[l_ac2].amt6 
            LET l_curr_sum.bamt6 = g_detail2[l_ac2].bamt6
            LET l_curr_sum.amt7  = g_detail2[l_ac2].amt7 
            LET l_curr_sum.bamt7 = g_detail2[l_ac2].bamt7
            LET l_curr_sum.amt8  = g_detail2[l_ac2].amt8 
            LET l_curr_sum.bamt8 = g_detail2[l_ac2].bamt8
            LET l_curr_sum.amt9  = g_detail2[l_ac2].amt9 
            LET l_curr_sum.bamt9 = g_detail2[l_ac2].bamt9 
            LET l_curr_sum.amt10 = g_detail2[l_ac2].amt10 
            LET l_curr_sum.bamt10= g_detail2[l_ac2].bamt10
            LET l_curr_sum.amt11 = g_detail2[l_ac2].amt11 
            LET l_curr_sum.bamt11= g_detail2[l_ac2].bamt11
            LET l_curr_sum.amt12 = g_detail2[l_ac2].amt12 
            LET l_curr_sum.bamt12= g_detail2[l_ac2].bamt12
            LET l_curr_sum.amt13 = g_detail2[l_ac2].amt13 
            LET l_curr_sum.bamt13= g_detail2[l_ac2].bamt13
            LET l_curr_sum.sum1  = g_detail2[l_ac2].sum1
            LET l_curr_sum.bsum1 = g_detail2[l_ac2].bsum1
         ELSE
            #按币别小计：累计金额
            LET l_curr_sum.amt1  = l_curr_sum.amt1  + g_detail2[l_ac2].amt1 
            LET l_curr_sum.bamt1 = l_curr_sum.bamt1 + g_detail2[l_ac2].bamt1
            LET l_curr_sum.amt2  = l_curr_sum.amt2  + g_detail2[l_ac2].amt2 
            LET l_curr_sum.bamt2 = l_curr_sum.bamt2 + g_detail2[l_ac2].bamt2
            LET l_curr_sum.amt3  = l_curr_sum.amt3  + g_detail2[l_ac2].amt3 
            LET l_curr_sum.bamt3 = l_curr_sum.bamt3 + g_detail2[l_ac2].bamt3
            LET l_curr_sum.amt4  = l_curr_sum.amt4  + g_detail2[l_ac2].amt4 
            LET l_curr_sum.bamt4 = l_curr_sum.bamt4 + g_detail2[l_ac2].bamt4
            LET l_curr_sum.amt5  = l_curr_sum.amt5  + g_detail2[l_ac2].amt5 
            LET l_curr_sum.bamt5 = l_curr_sum.bamt5 + g_detail2[l_ac2].bamt5
            LET l_curr_sum.amt6  = l_curr_sum.amt6  + g_detail2[l_ac2].amt6 
            LET l_curr_sum.bamt6 = l_curr_sum.bamt6 + g_detail2[l_ac2].bamt6
            LET l_curr_sum.amt7  = l_curr_sum.amt7  + g_detail2[l_ac2].amt7 
            LET l_curr_sum.bamt7 = l_curr_sum.bamt7 + g_detail2[l_ac2].bamt7
            LET l_curr_sum.amt8  = l_curr_sum.amt8  + g_detail2[l_ac2].amt8 
            LET l_curr_sum.bamt8 = l_curr_sum.bamt8 + g_detail2[l_ac2].bamt8
            LET l_curr_sum.amt9  = l_curr_sum.amt9  + g_detail2[l_ac2].amt9 
            LET l_curr_sum.bamt9 = l_curr_sum.bamt9 + g_detail2[l_ac2].bamt9 
            LET l_curr_sum.amt10 = l_curr_sum.amt10 + g_detail2[l_ac2].amt10 
            LET l_curr_sum.bamt10= l_curr_sum.bamt10+ g_detail2[l_ac2].bamt10
            LET l_curr_sum.amt11 = l_curr_sum.amt11 + g_detail2[l_ac2].amt11 
            LET l_curr_sum.bamt11= l_curr_sum.bamt11+ g_detail2[l_ac2].bamt11
            LET l_curr_sum.amt12 = l_curr_sum.amt12 + g_detail2[l_ac2].amt12 
            LET l_curr_sum.bamt12= l_curr_sum.bamt12+ g_detail2[l_ac2].bamt12
            LET l_curr_sum.amt13 = l_curr_sum.amt13 + g_detail2[l_ac2].amt13 
            LET l_curr_sum.bamt13= l_curr_sum.bamt13+ g_detail2[l_ac2].bamt13
            LET l_curr_sum.sum1  = l_curr_sum.sum1  + g_detail2[l_ac2].sum1
            LET l_curr_sum.bsum1 = l_curr_sum.bsum1 + g_detail2[l_ac2].bsum1
         END IF
      END IF
      
      #说明
      #预算组织
      LET g_detail2[l_ac2].bgcj007_1_desc = g_detail2[l_ac2].bgcj007," ",g_detail2[l_ac2].bgcj007_1_desc
      #料号、品名、规格
      CALL abgq310_get_bgcj009_desc(g_detail2[l_ac2].bgcj009) RETURNING g_detail2[l_ac2].bgcj009_desc
      LET g_detail2[l_ac2].bgcj009_desc = g_detail2[l_ac2].bgcj009,"  ",g_detail2[l_ac2].bgcj009_desc
      #预算细项
      LET g_detail2[l_ac2].bgcj049_desc = g_detail2[l_ac2].bgcj049," ",g_detail2[l_ac2].bgcj049_desc
      #人员
      LET g_detail2[l_ac2].bgcj012_desc = g_detail2[l_ac2].bgcj012," ",g_detail2[l_ac2].bgcj012_desc
      #部门
      LET g_detail2[l_ac2].bgcj013_desc = g_detail2[l_ac2].bgcj013," ",g_detail2[l_ac2].bgcj013_desc
      #成本利润中心
      LET g_detail2[l_ac2].bgcj014_desc = g_detail2[l_ac2].bgcj014," ",g_detail2[l_ac2].bgcj014_desc
      #区域
      LET g_detail2[l_ac2].bgcj015_desc = g_detail2[l_ac2].bgcj015," ",g_detail2[l_ac2].bgcj015_desc
      #收付款客商
      LET g_detail2[l_ac2].bgcj016_desc = g_detail2[l_ac2].bgcj016," ",g_detail2[l_ac2].bgcj016_desc
      #账款客商
      LET g_detail2[l_ac2].bgcj017_desc = g_detail2[l_ac2].bgcj017," ",g_detail2[l_ac2].bgcj017_desc
      #客群
      LET g_detail2[l_ac2].bgcj018_desc = g_detail2[l_ac2].bgcj018," ",g_detail2[l_ac2].bgcj018_desc
      #产品类型
      LET g_detail2[l_ac2].bgcj019_desc = g_detail2[l_ac2].bgcj019," ",g_detail2[l_ac2].bgcj019_desc
      #专案
      LET g_detail2[l_ac2].bgcj020_desc = g_detail2[l_ac2].bgcj020," ",g_detail2[l_ac2].bgcj020_desc
      #WBS
      LET g_detail2[l_ac2].bgcj021_desc = g_detail2[l_ac2].bgcj021," ",g_detail2[l_ac2].bgcj021_desc
      #渠道
      LET g_detail2[l_ac2].bgcj023_desc = g_detail2[l_ac2].bgcj023," ",g_detail2[l_ac2].bgcj023_desc
      #品牌
      LET g_detail2[l_ac2].bgcj024_desc = g_detail2[l_ac2].bgcj024," ",g_detail2[l_ac2].bgcj024_desc
      
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH 
   IF l_ac2 > 1 THEN
      #增加一行币别小计：
      LET g_detail2[l_ac2].bgcj100 = g_detail2[l_ac2-1].bgcj100,l_desc
      LET g_detail2[l_ac2].amt1 = l_curr_sum.amt1
      LET g_detail2[l_ac2].bamt1 = l_curr_sum.bamt1
      LET g_detail2[l_ac2].amt2 = l_curr_sum.amt2
      LET g_detail2[l_ac2].bamt2 = l_curr_sum.bamt2
      LET g_detail2[l_ac2].amt3 = l_curr_sum.amt3
      LET g_detail2[l_ac2].bamt3 = l_curr_sum.bamt3
      LET g_detail2[l_ac2].amt4 = l_curr_sum.amt4
      LET g_detail2[l_ac2].bamt4 = l_curr_sum.bamt4
      LET g_detail2[l_ac2].amt5 = l_curr_sum.amt5
      LET g_detail2[l_ac2].bamt5 = l_curr_sum.bamt5
      LET g_detail2[l_ac2].amt6 = l_curr_sum.amt6
      LET g_detail2[l_ac2].bamt6 = l_curr_sum.bamt6
      LET g_detail2[l_ac2].amt7 = l_curr_sum.amt7
      LET g_detail2[l_ac2].bamt7 = l_curr_sum.bamt7
      LET g_detail2[l_ac2].amt8 = l_curr_sum.amt8
      LET g_detail2[l_ac2].bamt8 = l_curr_sum.bamt8
      LET g_detail2[l_ac2].amt9 = l_curr_sum.amt9
      LET g_detail2[l_ac2].bamt9 = l_curr_sum.bamt9
      LET g_detail2[l_ac2].amt10 = l_curr_sum.amt10
      LET g_detail2[l_ac2].bamt10 = l_curr_sum.bamt10
      LET g_detail2[l_ac2].amt11 = l_curr_sum.amt11
      LET g_detail2[l_ac2].bamt11 = l_curr_sum.bamt11
      LET g_detail2[l_ac2].amt12 = l_curr_sum.amt12
      LET g_detail2[l_ac2].bamt12 = l_curr_sum.bamt12
      LET g_detail2[l_ac2].amt13 = l_curr_sum.amt13
      LET g_detail2[l_ac2].bamt13 = l_curr_sum.bamt13
      LET g_detail2[l_ac2].sum1 = l_curr_sum.sum1
      LET g_detail2[l_ac2].bsum1 = l_curr_sum.bsum1
   ELSE
      CALL g_detail2.deleteElement(g_detail2.getLength())
   END IF
   #end add-point
 
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   LET g_error_show = 0
 
   LET g_detail_cnt = g_detail2.getLength()

   #重新計算單身筆數並呈現
   CALL abgq310_detail_action_trans()
 
   LET l_ac2 = 1
   IF g_detail2.getLength() > 0 THEN
      CALL abgq310_b_fill3(l_ac2)
   END IF
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="abgq310.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION abgq310_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_detail[l_ac].bgcj007
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail[l_ac].bgcj007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail[l_ac].bgcj007_desc

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
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abgq310.tree_expand" >}
#應用 qs21 樣板自動產生(Version:7)
#+ tree節點展開程式段
PRIVATE FUNCTION abgq310_tree_expand(p_id)
   #add-point:tree_expand段define-客製 name="tree_expand.define_customerization"
   
   #end add-point
   DEFINE p_id          LIKE type_t.num10
   DEFINE l_id          LIKE type_t.num10
   DEFINE l_cnt         LIKE type_t.num10
   DEFINE l_keyvalue    LIKE type_t.chr50
   DEFINE l_typevalue   LIKE type_t.chr50
   DEFINE l_type        LIKE type_t.chr50
   DEFINE l_sql         LIKE type_t.chr500
   DEFINE ls_source     LIKE type_t.chr500
   DEFINE ls_exp_code   LIKE type_t.chr500
   DEFINE l_return      LIKE type_t.num5
   #add-point:tree_expand段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="tree_expand.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="tree_expand.before_function"
   
   #end add-point
 
   #若已經展開
   IF g_detail[p_id].isExp = 1 THEN
      RETURN
   END IF
 
   LET l_return = FALSE
 
   CASE g_detail[p_id].expcode
      WHEN -1
         CALL g_detail.deleteElement(p_id)
      WHEN 0
         RETURN
      WHEN 1
         #add-point:tree_expand段資料來源table name="tree_expand.expcode_1"
         
         #end add-point
         LET ls_exp_code = "exp_code"
      WHEN 2
         #add-point:tree_expand段資料來源table name="tree_expand.expcode_2"
         
         #end add-point
         LET ls_exp_code = "'2'"
   END CASE
 
 
   #add-point:tree_expand段sql組成 name="tree_expand.sql"
   LET l_sql="SELECT DISTINCT '','','','FALSE','','',1,ooed004,t01.ooefl003,ooed005,t02.ooefl003 ",
             "  FROM ooed_t",
             "  LEFT JOIN ooefl_t t01 ON t01.ooeflent=",g_enterprise," AND t01.ooefl001=ooed004 AND t01.ooefl002='",g_dlang,"'",
             "  LEFT JOIN ooefl_t t02 ON t02.ooeflent=",g_enterprise," AND t02.ooefl001=ooed005 AND t02.ooefl002='",g_dlang,"'",
             " WHERE ooedent = ",g_enterprise,
             "   AND ooed001 = '4'",
             "   AND ooed002 = '",g_bgaa011,"' ",
             "   AND ooed003 = '",g_bgaa010,"'",
             "   AND ooed004 <> ooed005 ",
             "   AND ooed005 = '",g_detail[p_id].bgcj007,"' ",
             " ORDER BY ooed004"
   #end add-point
 
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE tree_expand_pre FROM l_sql
   DECLARE tree_expand_cur CURSOR FOR tree_expand_pre
 
   LET l_id = p_id + 1
   CALL g_detail.insertElement(l_id)
   LET l_cnt = 1
   FOREACH tree_expand_cur INTO g_detail[l_id].*
      #(ver:7) ---start---
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "tree_expand_cur FOREACH:",SQLERRMESSAGE
         LET g_errparam.code   = SQLCA.SQLCODE
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      #(ver:7) --- end ---
      #pid=父節點id
      LET g_detail[l_id].pid = g_detail[p_id].id
      #
      #id=本身節點id(採流水號遞增)
      LET g_detail[l_id].id = g_detail[p_id].id||"."||l_cnt
      #
      #isnode=確認該節點是否有子孫
      CALL abgq310_desc_show(l_id)
      LET g_detail[l_id].isnode = abgq310_chk_isnode(l_id)
      LET l_id = l_id + 1
      CALL g_detail.insertElement(l_id)
      LET l_cnt = l_cnt + 1
 
      LET l_return = TRUE
   END FOREACH
 
   #刪除空資料
   CALL g_detail.deleteElement(l_id)
 
END FUNCTION
 
{</section>}
 
{<section id="abgq310.desc_show" >}
#應用 qs22 樣板自動產生(Version:7)
#+ tree節點名稱顯示程式段
PRIVATE FUNCTION abgq310_desc_show(pi_ac)
   #add-point:desc_show段define-客製 name="desc_show.define_customerization"
   
   #end add-point
   DEFINE pi_ac   LIKE type_t.num10
   DEFINE li_tmp  LIKE type_t.num10
   #add-point:desc_show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="desc_show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="desc_show.before_function"
   
   #end add-point
 
   LET li_tmp = l_ac
   LET l_ac = pi_ac
 
   #add-point:desc處理 name="desc_show.name"
   LET g_detail[l_ac].name=g_detail[l_ac].bgcj007,"(",g_detail[l_ac].bgcj007_desc,")"
   #end add-point
 
   LET l_ac = li_tmp
 
END FUNCTION
 
{</section>}
 
{<section id="abgq310.chk_isnode" >}
#應用 qs23 樣板自動產生(Version:5)
#+ 搜尋該節點下是否還有子節點
PRIVATE FUNCTION abgq310_chk_isnode(pi_id)
   #add-point:chk_isnode段define-客製 name="chk_isnode.define_customerization"
   
   #end add-point
   DEFINE pi_id    LIKE type_t.num10
   DEFINE li_cnt   LIKE type_t.num10
   #add-point:chk_isnode段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="chk_isnode.define"
   
   #end add-point
 
 
   #add-point:chk_isnode段筆數計算sql組成 name="chk_isnode.row_count_sql"
   LET li_cnt = 0
   SELECT COUNT(1) INTO li_cnt FROM ooed_t 
    WHERE ooedent =g_enterprise
      AND ooed001 = '4' 
      AND ooed002 = g_bgaa011
      AND ooed003 = g_bgaa010
      AND ooed005 = g_detail[pi_id].bgcj007
   
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
   #end add-point
 
   PREPARE abgq310_chk_isnode_pre FROM g_sql
 
   CASE g_detail[pi_id].expcode
      WHEN -1
         RETURN FALSE
      WHEN 0
         RETURN FALSE
      WHEN 1
         #add-point:chk_isnode段sql執行 name="chk_isnode.execute_sql_1"
         EXECUTE abgq310_chk_isnode_pre INTO li_cnt
         #end add-point
      WHEN 2
         #add-point:chk_isnode段sql執行 name="chk_isnode.execute_sql_2"
         EXECUTE abgq310_chk_isnode_pre INTO li_cnt
         #end add-point
   END CASE
 
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abgq310.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION abgq310_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   LET g_tot_cnt = g_detail2.getLength()
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
 
{<section id="abgq310.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION abgq310_detail_index_setting()
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
            IF g_detail.getLength() > 0 THEN
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
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abgq310.mask_functions" >}
 &include "erp/abg/abgq310_mask.4gl"
 
{</section>}
 
{<section id="abgq310.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查詢操作
# Memo...........:
# Usage..........: CALL abgq310_query()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/12/09 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq310_query()
   DEFINE ls_wc            LIKE type_t.chr500
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_bgaa002        LIKE bgaa_t.bgaa002
   DEFINE l_bgaa003        LIKE bgaa_t.bgaa003
   DEFINE l_bgaa006        LIKE bgaa_t.bgaa006
   DEFINE l_bgcj005        LIKE bgcj_t.bgcj005
   DEFINE l_site_str       STRING
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_detail.clear()
   CALL g_detail2.clear()
   CALL g_detail3.clear()
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter = " 1=1"
   LET g_detail_page_action = ""
   LET g_pagestart = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac
   #預設查詢條件
   IF cl_null(g_input.lower) THEN
      LET g_input.lower = 'Y'
   END IF
   IF cl_null(g_input.bgcj001) THEN
      LET g_input.bgcj001 = '20'
      CALL cl_set_comp_visible('bgcj007_2_desc',FALSE)
   END IF
   IF cl_null(g_input.bgap004) THEN
      LET g_input.bgap004 = '3'
   END IF
   IF cl_null(g_input.stus) THEN
      LET g_input.stus = '4'
   END IF
   IF cl_null(g_input.show_curr) THEN
      LET g_input.show_curr = 'Y'
   END IF
   #維度選項
   IF cl_null(g_input.kind) THEN
      LET g_input.kind = '2'
      LET g_input.hsx_bgcj009 = 'Y'
      LET g_input.hsx_bgcj049 = 'Y'
      LET g_input.hsx_bgcj012 = 'N'
      LET g_input.hsx_bgcj013 = 'N'
      LET g_input.hsx_bgcj014 = 'N'
      LET g_input.hsx_bgcj015 = 'N'
      LET g_input.hsx_bgcj016 = 'N'
      LET g_input.hsx_bgcj017 = 'N'
      LET g_input.hsx_bgcj018 = 'N'
      LET g_input.hsx_bgcj019 = 'N'
      LET g_input.hsx_bgcj020 = 'N'
      LET g_input.hsx_bgcj021 = 'N'
      LET g_input.hsx_bgcj022 = 'N'
      LET g_input.hsx_bgcj023 = 'N'
      LET g_input.hsx_bgcj024 = 'N'
      CALL cl_set_comp_visible("bgcj012_desc,bgcj013_desc,bgcj014_desc,bgcj015_desc,bgcj016_desc,bgcj017_desc,
                                bgcj018_desc,bgcj019_desc,bgcj020_desc,bgcj021_desc,b_bgcj022,bgcj023_desc,bgcj024_desc",FALSE)
   END IF
   IF g_input.kind = '2' THEN
      CALL cl_set_comp_visible('group_2',TRUE)
   ELSE
      CALL cl_set_comp_visible('group_2',FALSE)
   END IF
 
   DISPLAY BY NAME g_input.bgcj002,g_input.bgcj002_desc,g_input.bgcj003,g_input.bgcj007,g_input.bgcj007_desc,
                   g_input.lower,g_input.bgaa003,g_input.bgcj001,g_input.kind,g_input.bgap004,g_input.stus,
                   g_input.show_curr,g_input.hsx_bgcj009,g_input.hsx_bgcj012,g_input.hsx_bgcj017,
                   g_input.hsx_bgcj022,g_input.hsx_bgcj049,g_input.hsx_bgcj013,g_input.hsx_bgcj018,
                   g_input.hsx_bgcj023,g_input.hsx_bgcj014,g_input.hsx_bgcj019,g_input.hsx_bgcj024,
                   g_input.hsx_bgcj015,g_input.hsx_bgcj020,g_input.hsx_bgcj016,g_input.hsx_bgcj021
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      INPUT BY NAME g_input.bgcj002,g_input.bgcj003,g_input.bgcj007,g_input.lower,g_input.bgcj001,g_input.kind,
                    g_input.bgap004,g_input.stus,g_input.show_curr,g_input.hsx_bgcj009,g_input.hsx_bgcj012,
                    g_input.hsx_bgcj017,g_input.hsx_bgcj022,g_input.hsx_bgcj049,g_input.hsx_bgcj013,
                    g_input.hsx_bgcj018,g_input.hsx_bgcj023,g_input.hsx_bgcj014,g_input.hsx_bgcj019,
                    g_input.hsx_bgcj024,g_input.hsx_bgcj015,g_input.hsx_bgcj020,g_input.hsx_bgcj016,
                    g_input.hsx_bgcj021
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
      
         AFTER FIELD bgcj002
            IF NOT cl_null(g_input.bgcj002) THEN
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_input.bgcj002
               LET g_errshow = TRUE
               LET g_chkparam.err_str[1] = "abg-00008:sub-01302|abgi010|",cl_get_progname("abgi010",g_lang,"2"),"|:EXEPROGabgi010"

               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_bgaa001") THEN
                  #预算编号需是使用预测的（bgaa006=1.使用）
                  SELECT bgaa006 INTO l_bgaa006 FROM bgaa_t WHERE bgaaent=g_enterprise AND bgaa001=g_input.bgcj002
                  IF l_bgaa006 <> '1' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00292'
                     LET g_errparam.extend = g_input.bgcj002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.bgcj002 = ''
                     LET g_input.bgcj002_desc = ''
                     DISPLAY BY NAME g_input.bgcj002_desc
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_input.bgcj002 = ''
                  LET g_input.bgcj002_desc = ''
                  DISPLAY BY NAME g_input.bgcj002_desc
                  NEXT FIELD CURRENT
               END IF
               
               #检查预算编号+版本是否存在
               IF NOT cl_null(g_input.bgcj003) THEN
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt FROM bgcj_t
                   WHERE bgcjent=g_enterprise AND bgcj002=g_input.bgcj002
                     AND bgcj003=g_input.bgcj003 AND bgcjstus<>'X'
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00310'
                     LET g_errparam.extend = g_input.bgcj002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.bgcj002 = ''
                     LET g_input.bgcj002_desc = ''
                     DISPLAY BY NAME g_input.bgcj002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               SELECT bgaa003 INTO g_input.bgaa003 FROM bgaa_t
                WHERE bgaaent=g_enterprise AND bgaa001=g_input.bgcj002
               DISPLAY BY NAME g_input.bgaa003
               #抓取預算週期和預算期別
               CALL s_abgt340_sel_bgaa(g_input.bgcj002) RETURNING l_bgaa002,l_bgaa003,g_max_period
               #當期別不為13期時，影藏13期的數量、單價、銷售金額欄位
               IF g_max_period < 13 THEN
                  CALL cl_set_comp_visible("amt13,bamt13,tnum13,tprice13,tamt13,tbamt13",FALSE)
               ELSE
                  CALL cl_set_comp_visible("amt13,tnum13,tprice13,tamt13",TRUE)
                  IF g_input.show_curr = 'Y' THEN
                     CALL cl_set_comp_visible("bamt13,tbamt13",TRUE)
                  END IF
               END IF
            END IF
            CALL s_desc_get_budget_desc(g_input.bgcj002) RETURNING g_input.bgcj002_desc
            DISPLAY BY NAME g_input.bgcj002_desc
         
         AFTER FIELD bgcj003
            IF NOT cl_null(g_input.bgcj003) THEN
               #检查预算编号+版本是否存在
               IF NOT cl_null(g_input.bgcj002) THEN
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt FROM bgcj_t
                   WHERE bgcjent=g_enterprise AND bgcj002=g_input.bgcj002
                     AND bgcj003=g_input.bgcj003 AND bgcjstus<>'X'
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00310'
                     LET g_errparam.extend = g_input.bgcj003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.bgcj003 = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
         AFTER FIELD bgcj007
            IF NOT cl_null(g_input.bgcj007) THEN
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_input.bgcj007
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                
               IF NOT cl_chk_exist("v_ooef001") THEN
                  #檢查失敗時後續處理
                  LET g_input.bgcj007 = ''
                  LET g_input.bgcj007_desc = ''
                  DISPLAY BY NAME g_input.bgcj007_desc
                  NEXT FIELD CURRENT
               END IF
               
               #檢查預算組織是否在abgi090中可操作的組織中
               CALL s_abg2_bgai004_chk(g_input.bgcj002,'',g_input.bgcj007,'01')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend =g_input.bgcj007
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.bgcj007 = ''
                  LET g_input.bgcj007_desc = ''
                  DISPLAY BY NAME g_input.bgcj007_desc
                  NEXT FIELD CURRENT
               END IF
               
            END IF
         
         ON CHANGE bgcj001
            IF g_input.bgcj001 = '30' THEN
               CALL cl_set_comp_visible('bgcj007_2_desc',TRUE)
            ELSE
               CALL cl_set_comp_visible('bgcj007_2_desc',FALSE)
            END IF

         ON CHANGE kind
            IF g_input.kind = '2' THEN
               CALL cl_set_comp_visible('group_2',TRUE)
            ELSE
               CALL cl_set_comp_visible('group_2',FALSE)
            END IF
         
         ON CHANGE show_curr
            IF g_input.show_curr = 'Y' THEN
               CALL cl_set_comp_visible('bamt1,bamt2,bamt3,bamt4,bamt5,bamt6,bamt7,bamt8,bamt9,bamt10,bamt11,bamt12',TRUE)
               CALL cl_set_comp_visible('tbamt1,tbamt2,bamt3,tbamt4,tbamt5,tbamt6,tbamt7,tbamt8,tbamt9,tbamt10,tbamt11,tbamt12',TRUE)
               IF g_max_period = 13 THEN
                  CALL cl_set_comp_visible('bamt13,tbamt13',TRUE)
               END IF
            ELSE
               CALL cl_set_comp_visible('bamt1,bamt2,bamt3,bamt4,bamt5,bamt6,bamt7,bamt8,bamt9,bamt10,bamt11,bamt12,bamt13',FALSE)
               CALL cl_set_comp_visible('tbamt1,tbamt2,bamt3,tbamt4,tbamt5,tbamt6,tbamt7,tbamt8,tbamt9,tbamt10,tbamt11,tbamt12,tbamt13',FALSE)
            END IF
            
         ON CHANGE hsx_bgcj009
            IF g_input.hsx_bgcj009 = 'Y' THEN
               CALL cl_set_comp_visible('bgcj009_desc',TRUE)
            ELSE
               CALL cl_set_comp_visible('bgcj009_desc',FALSE)
            END IF
            
         ON CHANGE hsx_bgcj049
            IF g_input.hsx_bgcj049 = 'Y' THEN
               CALL cl_set_comp_visible('bgcj049_desc',TRUE)
            ELSE
               CALL cl_set_comp_visible('bgcj049_desc',FALSE)
            END IF
         
         ON CHANGE hsx_bgcj012
            IF g_input.hsx_bgcj012 = 'Y' THEN
               CALL cl_set_comp_visible('bgcj012_desc',TRUE)
            ELSE
               CALL cl_set_comp_visible('bgcj012_desc',FALSE)
            END IF
         
         ON CHANGE hsx_bgcj013
            IF g_input.hsx_bgcj013 = 'Y' THEN
               CALL cl_set_comp_visible('bgcj013_desc',TRUE)
            ELSE
               CALL cl_set_comp_visible('bgcj013_desc',FALSE)
            END IF
         
         ON CHANGE hsx_bgcj014
            IF g_input.hsx_bgcj014 = 'Y' THEN
               CALL cl_set_comp_visible('bgcj014_desc',TRUE)
            ELSE
               CALL cl_set_comp_visible('bgcj014_desc',FALSE)
            END IF
            
         ON CHANGE hsx_bgcj015
            IF g_input.hsx_bgcj015 = 'Y' THEN
               CALL cl_set_comp_visible('bgcj015_desc',TRUE)
            ELSE
               CALL cl_set_comp_visible('bgcj015_desc',FALSE)
            END IF
            
         ON CHANGE hsx_bgcj016
            IF g_input.hsx_bgcj016 = 'Y' THEN
               CALL cl_set_comp_visible('bgcj016_desc',TRUE)
            ELSE
               CALL cl_set_comp_visible('bgcj016_desc',FALSE)
            END IF
            
         ON CHANGE hsx_bgcj017
            IF g_input.hsx_bgcj017 = 'Y' THEN
               CALL cl_set_comp_visible('bgcj017_desc',TRUE)
            ELSE
               CALL cl_set_comp_visible('bgcj017_desc',FALSE)
            END IF
            
         ON CHANGE hsx_bgcj018
            IF g_input.hsx_bgcj018 = 'Y' THEN
               CALL cl_set_comp_visible('bgcj018_desc',TRUE)
            ELSE
               CALL cl_set_comp_visible('bgcj018_desc',FALSE)
            END IF
            
         ON CHANGE hsx_bgcj019
            IF g_input.hsx_bgcj019 = 'Y' THEN
               CALL cl_set_comp_visible('bgcj019_desc',TRUE)
            ELSE
               CALL cl_set_comp_visible('bgcj019_desc',FALSE)
            END IF
            
         ON CHANGE hsx_bgcj020
            IF g_input.hsx_bgcj020 = 'Y' THEN
               CALL cl_set_comp_visible('bgcj020_desc',TRUE)
            ELSE
               CALL cl_set_comp_visible('bgcj020_desc',FALSE)
            END IF
            
         ON CHANGE hsx_bgcj021
            IF g_input.hsx_bgcj021 = 'Y' THEN
               CALL cl_set_comp_visible('bgcj021_desc',TRUE)
            ELSE
               CALL cl_set_comp_visible('bgcj021_desc',FALSE)
            END IF
            
         ON CHANGE hsx_bgcj022
            IF g_input.hsx_bgcj022 = 'Y' THEN
               CALL cl_set_comp_visible('b_bgcj022',TRUE)
            ELSE
               CALL cl_set_comp_visible('b_bgcj022',FALSE)
            END IF
            
         ON CHANGE hsx_bgcj023
            IF g_input.hsx_bgcj023 = 'Y' THEN
               CALL cl_set_comp_visible('bgcj023_desc',TRUE)
            ELSE
               CALL cl_set_comp_visible('bgcj023_desc',FALSE)
            END IF
            
         ON CHANGE hsx_bgcj024
            IF g_input.hsx_bgcj024 = 'Y' THEN
               CALL cl_set_comp_visible('bgcj024_desc',TRUE)
            ELSE
               CALL cl_set_comp_visible('bgcj024_desc',FALSE)
            END IF

         ON ACTION controlp INFIELD bgcj002
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'i'
           LET g_qryparam.reqry = FALSE
           #給予arg
           LET g_qryparam.arg1 = "" #
           LET g_qryparam.where = " bgaa006 = '1' " 
           CALL q_bgaa001()
           LET g_input.bgcj002 = g_qryparam.return1
           DISPLAY g_input.bgcj002 TO bgcj002 
           NEXT FIELD bgcj002
           
         ON ACTION controlp INFIELD bgcj007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_input.bgcj007             #給予default值
            LET g_qryparam.default2 = "" 
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " ooef205 = 'Y'"
            #檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site(g_input.bgcj002,'',g_user,'01') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_site_str
            
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_input.bgcj007 = g_qryparam.return1  
            DISPLAY g_input.bgcj007 TO bgcj007 
            NEXT FIELD bgcj007                          #返回原欄位  
      END INPUT
      
      #單身根據table分拆construct
      CONSTRUCT g_wc ON bgcj005,bgcj009,bgcj049
           FROM bgcj005,bgcj009,bgcj049
                      
         BEFORE CONSTRUCT
         
         AFTER FIELD bgcj005
            CALL FGL_DIALOG_GETBUFFER() RETURNING l_bgcj005
            
         ON ACTION controlp INFIELD bgcj009
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF l_bgcj005 = '4' THEN
               CALL q_bgcc001()
            ElSE
               CALL q_bgas001()
            END IF
            DISPLAY g_qryparam.return1 TO bgcj009  #顯示到畫面上
            NEXT FIELD bgcj009
         
         ON ACTION controlp INFIELD bgcj049
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgae001()
            DISPLAY g_qryparam.return1 TO bgcj049  #顯示到畫面上
            NEXT FIELD bgcj049
            
      END CONSTRUCT
      
      BEFORE DIALOG
      
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
 
   END DIALOG
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = " 1=2"
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1 "
   END IF
   #企业关系人否
   LET g_sql_bgap004=''
   CASE g_input.bgap004   
      WHEN '1' #1.企业关系人
         LET g_sql_bgap004=" AND bgcj016 IN (SELECT bgap001 FROM bgap_t WHERE bgapent=",g_enterprise,
                           "                 AND bgap004='Y' AND bgapstus='Y' )"
      
      WHEN '2' #2.非企业关系人
         LET g_sql_bgap004=" AND bgcj016 IN (SELECT bgap001 FROM bgap_t WHERE bgapent=",g_enterprise,
                           "                 AND bgap004='N' AND bgapstus='Y' )"
   END CASE
   #单据状态
   LET g_sql_stus=''
   CASE g_input.stus
      WHEN '1' #未确认
         LET g_sql_stus=" AND bgcjstus='N'"
      WHEN '2' #确认
         LET g_sql_stus=" AND bgcjstus='Y'"
      WHEN '3' #终审
         LET g_sql_stus=" AND bgcjstus='FC'"
      WHEN '4' #全部
         LET g_sql_stus=" AND bgcjstus<>'X'"
   END CASE
   
   #抓取预算编号对应的最上层组织和版本
   SELECT bgaa010,bgaa011,bgaa008 
     INTO g_bgaa010,g_bgaa011,g_bgaa008 
     FROM bgaa_t
    WHERE bgaaent=g_enterprise AND bgaa001=g_input.bgcj002
   #当版本没有值时，表示没有tree，则影藏单身中的tree
   IF cl_null(g_bgaa010) THEN
      CALL cl_set_comp_visible('s_detail1',FALSE)
   ELSE
      IF g_input.lower = 'N' THEN
         CALL cl_set_comp_visible('s_detail1',FALSE)
      ELSE
         CALL cl_set_comp_visible('s_detail1',TRUE)
      END IF
   END IF
   #预算细项说明sql语句
   LET g_bgcj049_sql= "(SELECT bgael003 FROM bgael_t WHERE bgaelent="||g_enterprise||" AND bgael006='"||g_bgaa008||"' AND bgael001=bgcj049 AND bgael002='"||g_dlang||"')"
   
   LET g_error_show = 1
   CALL abgq310_b_fill()
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
# Descriptions...: 根据条件设置查询汇总的核算项栏位
# Memo...........:
# Usage..........: CALL abgq310_sel_hsx()
#                  RETURNING r_str
# Input parameter: 
# Return code....: r_str    查询的核算项栏位  
# Date & Author..: 2016/12/16 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq310_sel_hsx()
   DEFINE r_str        STRING

   LET r_str=''
   IF g_input.kind='2' THEN
      #预算料号
      IF g_input.hsx_bgcj009 = 'Y' THEN
         LET r_str=r_str,",bgcj009"
      ELSE
         LET r_str=r_str,",'' bgcj009"
      END IF
      #预算细项
      IF g_input.hsx_bgcj049 = 'Y' THEN
         LET r_str=r_str,",bgcj049,",g_bgcj049_sql
      ELSE
         LET r_str=r_str,",'' bgcj049,''"
      END IF
      #人员
      IF g_input.hsx_bgcj012 = 'Y' THEN
         LET r_str=r_str,",bgcj012,",g_get_sql.bgcj012
      ELSE
         LET r_str=r_str,",'' bgcj012,''"
      END IF
      #部门
      IF g_input.hsx_bgcj013 = 'Y' THEN
         LET r_str=r_str,",bgcj013,",g_get_sql.bgcj013
      ELSE
         LET r_str=r_str,",'' bgcj013,''"
      END IF
      #成本利润中心
      IF g_input.hsx_bgcj014 = 'Y' THEN
         LET r_str=r_str,",bgcj014,",g_get_sql.bgcj014
      ELSE
         LET r_str=r_str,",'' bgcj014,''"
      END IF
      #区域
      IF g_input.hsx_bgcj015 = 'Y' THEN
         LET r_str=r_str,",bgcj015,",g_get_sql.bgcj015
      ELSE
         LET r_str=r_str,",'' bgcj015,''"
      END IF
      #收付款客商
      IF g_input.hsx_bgcj016 = 'Y' THEN
         LET r_str=r_str,",bgcj016,",g_get_sql.bgcj016
      ELSE
         LET r_str=r_str,",'' bgcj016,''"
      END IF
      #账款客商
      IF g_input.hsx_bgcj017 = 'Y' THEN
         LET r_str=r_str,",bgcj017,",g_get_sql.bgcj017
      ELSE
         LET r_str=r_str,",'' bgcj017,''"
      END IF
      #客群
      IF g_input.hsx_bgcj018 = 'Y' THEN
         LET r_str=r_str,",bgcj018,",g_get_sql.bgcj018
      ELSE
         LET r_str=r_str,",'' bgcj018,''"
      END IF
      #产品类别
      IF g_input.hsx_bgcj019 = 'Y' THEN
         LET r_str=r_str,",bgcj019,",g_get_sql.bgcj019
      ELSE
         LET r_str=r_str,",'' bgcj019,''"
      END IF
      #专案
      IF g_input.hsx_bgcj020 = 'Y' THEN
         LET r_str=r_str,",bgcj020,",g_get_sql.bgcj020
      ELSE
         LET r_str=r_str,",'' bgcj020,''"
      END IF
      #WBS
      IF g_input.hsx_bgcj021 = 'Y' THEN
         LET r_str=r_str,",bgcj021,",g_get_sql.bgcj021
      ELSE
         LET r_str=r_str,",'' bgcj021,''"
      END IF
      #经营方式
      IF g_input.hsx_bgcj022 = 'Y' THEN
         LET r_str=r_str,",bgcj022"
      ELSE
         LET r_str=r_str,",'' bgcj022"
      END IF
      #渠道
      IF g_input.hsx_bgcj023 = 'Y' THEN
         LET r_str=r_str,",bgcj023,",g_get_sql.bgcj023
      ELSE
         LET r_str=r_str,",'' bgcj023,''"
      END IF
      #品牌
      IF g_input.hsx_bgcj024 = 'Y' THEN
         LET r_str=r_str,",bgcj024,",g_get_sql.bgcj024
      ELSE
         LET r_str=r_str,",'' bgcj024,''"
      END IF
   ELSE
      #预算料号
      IF g_bgaw1[2] = 'Y' OR g_bgaw2[2] = 'Y' THEN
         LET r_str=r_str,",bgcj009,bgcj049,",g_bgcj049_sql
         CALL cl_set_comp_visible('bgcj009_desc,bgcj049_desc',TRUE)
      ELSE
         LET r_str=r_str,",'' bgcj009,'' bgcj049,''"
         CALL cl_set_comp_visible('bgcj009_desc,bgcj049_desc',FALSE)
      END IF
      #人员
      IF g_bgaw1[13] = 'Y' OR g_bgaw2[13] = 'Y' THEN
         LET r_str=r_str,",bgcj012,",g_get_sql.bgcj012
         CALL cl_set_comp_visible('bgcj012_desc',TRUE)
      ELSE
         LET r_str=r_str,",'' bgcj012,''"
         CALL cl_set_comp_visible('bgcj012_desc',FALSE)
      END IF
      #部门
      IF g_bgaw1[3] = 'Y' OR g_bgaw2[3] = 'Y' THEN
         LET r_str=r_str,",bgcj013,",g_get_sql.bgcj013
         CALL cl_set_comp_visible('bgcj013_desc',TRUE)
      ELSE
         LET r_str=r_str,",'' bgcj013,''"
         CALL cl_set_comp_visible('bgcj013_desc',FALSE)
      END IF
      #成本利润中心
      IF g_bgaw1[4] = 'Y' OR g_bgaw2[4] = 'Y' THEN
         LET r_str=r_str,",bgcj014,",g_get_sql.bgcj014
         CALL cl_set_comp_visible('bgcj014_desc',TRUE)
      ELSE
         LET r_str=r_str,",'' bgcj014,''"
         CALL cl_set_comp_visible('bgcj014_desc',FALSE)
      END IF
      #区域
      IF g_bgaw1[5] = 'Y' OR g_bgaw2[5] = 'Y' THEN
         LET r_str=r_str,",bgcj015,",g_get_sql.bgcj015
         CALL cl_set_comp_visible('bgcj015_desc',TRUE)
      ELSE
         LET r_str=r_str,",'' bgcj015,''"
         CALL cl_set_comp_visible('bgcj015_desc',FALSE)
      END IF
      #收付款客商
      IF g_bgaw1[6] = 'Y' OR g_bgaw2[6] = 'Y' THEN
         LET r_str=r_str,",bgcj016,",g_get_sql.bgcj016
         CALL cl_set_comp_visible('bgcj016_desc',TRUE)
      ELSE
         LET r_str=r_str,",'' bgcj016,''"
         CALL cl_set_comp_visible('bgcj016_desc',FALSE)
      END IF
      #账款客商
      IF g_bgaw1[7] = 'Y' OR g_bgaw2[7] = 'Y' THEN
         LET r_str=r_str,",bgcj017,",g_get_sql.bgcj017
         CALL cl_set_comp_visible('bgcj017_desc',TRUE)
      ELSE
         LET r_str=r_str,",'' bgcj017,''"
         CALL cl_set_comp_visible('bgcj017_desc',FALSE)
      END IF
      #客群
      IF g_bgaw1[8] = 'Y' OR g_bgaw2[8] = 'Y' THEN
         LET r_str=r_str,",bgcj018,",g_get_sql.bgcj018
         CALL cl_set_comp_visible('bgcj018_desc',TRUE)
      ELSE
         LET r_str=r_str,",'' bgcj018,''"
         CALL cl_set_comp_visible('bgcj018_desc',FALSE)
      END IF
      #产品类别
      IF g_bgaw1[9] = 'Y' OR g_bgaw2[9] = 'Y' THEN
         LET r_str=r_str,",bgcj019,",g_get_sql.bgcj019
         CALL cl_set_comp_visible('bgcj019_desc',TRUE)
      ELSE
         LET r_str=r_str,",'' bgcj019,''"
         CALL cl_set_comp_visible('bgcj019_desc',FALSE)
      END IF
      #专案
      IF g_bgaw1[14] = 'Y' OR g_bgaw2[14] = 'Y' THEN
         LET r_str=r_str,",bgcj020,",g_get_sql.bgcj020
         CALL cl_set_comp_visible('bgcj020_desc',TRUE)
      ELSE
         LET r_str=r_str,",'' bgcj020,''"
         CALL cl_set_comp_visible('bgcj020_desc',FALSE)
      END IF
      #WBS
      IF g_bgaw1[15] = 'Y' OR g_bgaw2[15] = 'Y' THEN
         LET r_str=r_str,",bgcj021,",g_get_sql.bgcj021
         CALL cl_set_comp_visible('bgcj021_desc',TRUE)
      ELSE
         LET r_str=r_str,",'' bgcj021,''"
         CALL cl_set_comp_visible('bgcj021_desc',FALSE)
      END IF
      #经营方式
      IF g_bgaw1[10] = 'Y' OR g_bgaw2[10] = 'Y' THEN
         LET r_str=r_str,",bgcj022"
         CALL cl_set_comp_visible('b_bgcj022',TRUE)
      ELSE
         LET r_str=r_str,",'' bgcj022"
         CALL cl_set_comp_visible('b_bgcj022',FALSE)
      END IF
      #渠道
      IF g_bgaw1[11] = 'Y' OR g_bgaw2[11] = 'Y' THEN
         LET r_str=r_str,",bgcj023,",g_get_sql.bgcj023
         CALL cl_set_comp_visible('bgcj023_desc',TRUE)
      ELSE
         LET r_str=r_str,",'' bgcj023,''"
         CALL cl_set_comp_visible('bgcj023_desc',FALSE)
      END IF
      #品牌
      IF g_bgaw1[12] = 'Y' OR g_bgaw2[12] = 'Y' THEN
         LET r_str=r_str,",bgcj024,",g_get_sql.bgcj024
         CALL cl_set_comp_visible('bgcj024_desc',TRUE)
      ELSE
         LET r_str=r_str,",'' bgcj024,''"
         CALL cl_set_comp_visible('bgcj024_desc',FALSE)
      END IF
   END IF
   
   RETURN r_str
END FUNCTION

################################################################################
# Descriptions...: 下层组织明细资料填充
# Memo...........:
# Usage..........: CALL abgq310_b_fill3(pi_idx)
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/12/16 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq310_b_fill3(pi_idx)
   DEFINE pi_idx         LIKE type_t.num10
   DEFINE l_ac3          LIKE type_t.num10
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_sql1         STRING
   DEFINE l_sql2         STRING
   DEFINE l_sql          STRING
   DEFINE l_str          STRING
   DEFINE l_str2         STRING
   DEFINE l_sql_hsx      STRING
   DEFINE l_site_str     STRING
   DEFINE l_num          LIKE bgcj_t.bgcj045
   DEFINE l_sum          LIKE bgcj_t.bgcj102
   DEFINE l_amt          LIKE bgcj_t.bgcj102
   DEFINE l_price        LIKE bgcj_t.bgcj046
   DEFINE l_bgcj001      LIKE bgcj_t.bgcj001
   DEFINE l_bgcj007      LIKE bgcj_t.bgcj007
   DEFINE l_bgcj009      LIKE bgcj_t.bgcj009
   DEFINE l_bgcj049      LIKE bgcj_t.bgcj049
   DEFINE l_bgcj005_str  STRING  #170215-00006#1 add
   
   CALL g_detail3.clear()
   IF pi_idx <=0 THEN
      RETURN
   END IF 
   #当点选的所在行是币别小计时，不用抓取明细
   IF cl_null(g_detail2[pi_idx].bgcj007) THEN
      RETURN
   END IF
   
   LET l_ac3=1
   
   LET l_sql1="  FROM bgcj_t",
              " WHERE bgcjent=",g_enterprise,
              "   AND bgcj002='",g_input.bgcj002,"'",
              "   AND bgcj003='",g_input.bgcj003,"'",
              "   AND bgcj100='",g_detail2[pi_idx].bgcj100,"'"
   #根据核算项的显示有否组成核算项条件
   CALL abgq310_hsx_where(pi_idx) RETURNING l_sql_hsx
   LET l_sql1=l_sql1," AND ",l_sql_hsx,
                     " AND ",g_wc,g_sql_bgap004,g_sql_stus
    
   LET l_sql2=" ORDER BY bgcj009,bgcj049,bgcj012,bgcj013,bgcj014,bgcj015,bgcj016,bgcj017,",
              "          bgcj018,bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,bgcj024"
   
   #当来源作业为10.销售模拟或20.销售预算时，已经是最明显资料，只要抓取核算项汇总资料即可   
   IF g_input.bgcj001<>'30' THEN
      LET l_sql="SELECT DISTINCT bgcj007,bgcj009,bgcj049 ",
                l_sql1,
                "   AND bgcj001='",g_input.bgcj001,"'",
                "   AND bgcj007='",g_detail2[pi_idx].bgcj007,"'",
                " ORDER BY bgcj007,bgcj009,bgcj049"
      LET l_bgcj001 = g_input.bgcj001
   ELSE
   #当来源作业为30.销售审核时，先判断预算组织是否是最底层预算组织，如果不是要下展到最底层，抓取明细资料abgt340      
      #根据预算组织逐层下展至最底层组织      
      #有权限的下层组织
      #170215-00006#1--add--str--
      LET l_bgcj005_str=" AND bgcj005 IN (SELECT DISTINCT bgcj005 FROM bgcj_t ",
                        "                  WHERE bgcjent=",g_enterprise," AND bgcj001='30'",
                        "                    AND bgcj002='",g_input.bgcj002,"'",
                        "                    AND bgcj003='",g_input.bgcj003,"'",
                        "                    AND bgcj007='",g_detail2[pi_idx].bgcj007,"'",
                        "       )"
      #170215-00006#1--add--end
      CALL s_abg2_get_site(g_input.bgcj002,g_detail2[pi_idx].bgcj007,'01') RETURNING l_site_str
      LET l_sql = "SELECT DISTINCT bgcj007,bgcj009,bgcj049 ",
                  l_sql1,
                  "   AND bgcj007 IN ",l_site_str,
                  l_bgcj005_str,  #170215-00006#1 add
                  "   AND bgcj001='20' ",
                  "   AND bgcj006='1' ",
                  " ORDER BY bgcj007,bgcj009,bgcj049 "
      LET l_bgcj001 = '20'
   END IF
   PREPARE abgq310_b_fill3_pr FROM l_sql
   DECLARE abgq310_b_fill3_cs CURSOR FOR abgq310_b_fill3_pr
   
   #初始单身三核算项全部不显示
   LET g_hsx_visible.hsx_bgcj012=0
   LET g_hsx_visible.hsx_bgcj013=0
   LET g_hsx_visible.hsx_bgcj014=0
   LET g_hsx_visible.hsx_bgcj015=0
   LET g_hsx_visible.hsx_bgcj016=0
   LET g_hsx_visible.hsx_bgcj017=0
   LET g_hsx_visible.hsx_bgcj018=0
   LET g_hsx_visible.hsx_bgcj019=0
   LET g_hsx_visible.hsx_bgcj020=0
   LET g_hsx_visible.hsx_bgcj021=0
   LET g_hsx_visible.hsx_bgcj022=0
   LET g_hsx_visible.hsx_bgcj023=0
   LET g_hsx_visible.hsx_bgcj024=0
   
   
   FOREACH abgq310_b_fill3_cs INTO l_bgcj007,l_bgcj009,l_bgcj049
      #根据abgi110中启用核算项情况抓取资料汇总
      CALL abgq310_hsx_bgal(l_bgcj007,l_bgcj049) RETURNING l_str
      LET l_sql="SELECT DISTINCT bgcj007,",g_get_sql.bgcj007,",bgcj009,bgcj049,",g_bgcj049_sql,l_str,
                "      ,bgcj035,bgcj036,bgcj037,bgcj100 ",
                l_sql1,
                " AND bgcj007='",l_bgcj007,"'",
                " AND bgcj009='",l_bgcj009,"'",
                " AND bgcj049='",l_bgcj049,"'"
      #170215-00006#1--mod--str--
#                l_sql2      
      #当来源作业是30.销售预算汇总时，增加bgcj005销售来源限制
      IF g_input.bgcj001='30' THEN
         LET l_sql=l_sql,l_bgcj005_str
      END IF
      LET l_sql=l_sql,l_sql2
      #170215-00006#1--mod--end
      
      PREPARE abgq310_b_fill3_hsx_pr FROM l_sql
      DECLARE abgq310_b_fill3_hsx_cs CURSOR FOR abgq310_b_fill3_hsx_pr
      FOREACH abgq310_b_fill3_hsx_cs INTO g_detail3[l_ac3].bgcj007,g_detail3[l_ac3].bgcj007_2_desc,g_detail3[l_ac3].bgcj009,
         g_detail3[l_ac3].bgcj049,g_detail3[l_ac3].bgcj049_2_desc,g_detail3[l_ac3].bgcj012,g_detail3[l_ac3].bgcj012_2_desc,
         g_detail3[l_ac3].bgcj013,g_detail3[l_ac3].bgcj013_2_desc,g_detail3[l_ac3].bgcj014,g_detail3[l_ac3].bgcj014_2_desc,
         g_detail3[l_ac3].bgcj015,g_detail3[l_ac3].bgcj015_2_desc,g_detail3[l_ac3].bgcj016,g_detail3[l_ac3].bgcj016_2_desc,
         g_detail3[l_ac3].bgcj017,g_detail3[l_ac3].bgcj017_2_desc,g_detail3[l_ac3].bgcj018,g_detail3[l_ac3].bgcj018_2_desc,
         g_detail3[l_ac3].bgcj019,g_detail3[l_ac3].bgcj019_2_desc,g_detail3[l_ac3].bgcj020,g_detail3[l_ac3].bgcj020_2_desc,
         g_detail3[l_ac3].bgcj021,g_detail3[l_ac3].bgcj021_2_desc,g_detail3[l_ac3].bgcj022,
         g_detail3[l_ac3].bgcj023,g_detail3[l_ac3].bgcj023_2_desc,g_detail3[l_ac3].bgcj024,g_detail3[l_ac3].bgcj024_2_desc,
         g_detail3[l_ac3].bgcj035,g_detail3[l_ac3].bgcj036,g_detail3[l_ac3].bgcj037,g_detail3[l_ac3].bgcj100
      
         #項次
         LET g_detail3[l_ac3].seq2 = l_ac3
         #合計
         LET g_detail3[l_ac3].sum2 = 0
         LET g_detail3[l_ac3].bsum2 = 0
         
         #根据单身三核算项值组出核算项where条件
         LET l_str2=''
         CALL abgq310_hsx_where_3(l_ac3) RETURNING l_str2
         LET l_sql="SELECT SUM(bgcj045),SUM(bgcj102),SUM(bgcj102*bgcj101) ",
                   l_sql1,
                   " AND bgcj001='",l_bgcj001,"'",
                   " AND bgcj007='",g_detail3[l_ac3].bgcj007,"'",
                   " AND bgcj009='",g_detail3[l_ac3].bgcj009,"'",
                   " AND bgcj049='",g_detail3[l_ac3].bgcj049,"'",
                   " AND bgcj008=? ",
                   l_str2,
                   " AND bgcj035='",g_detail3[l_ac3].bgcj035,"'",
                   " AND bgcj036='",g_detail3[l_ac3].bgcj036,"'",
                   " AND bgcj037='",g_detail3[l_ac3].bgcj037,"'"
         #170215-00006#1--add--str--
         #当来源作业是30.销售预算汇总时，增加bgcj005销售来源限制
         IF g_input.bgcj001='30' THEN
            LET l_sql=l_sql,l_bgcj005_str
         END IF
         #170215-00006#1--add--end
         PREPARE abgq310_b_fill3_amt_pr FROM l_sql
         FOR l_i = 1 TO g_max_period
            LET l_sum=0
            LET l_amt=0
            LET l_num=0
            LET l_price = 0
            EXECUTE abgq310_b_fill3_amt_pr USING l_i INTO l_num,l_sum,l_amt
            IF cl_null(l_num) THEN LET l_num = 0 END IF
            IF cl_null(l_sum) THEN LET l_sum = 0 END IF
            IF cl_null(l_amt) THEN LET l_amt = 0 END IF
            LET l_price = l_sum/l_num
            CALL s_curr_round(g_detail3[l_ac3].bgcj007,g_detail3[l_ac3].bgcj100,l_price,1) 
               RETURNING l_price
            IF g_input.show_curr='Y' THEN
               CALL s_curr_round(g_detail3[l_ac3].bgcj007,g_input.bgaa003,l_amt,2) RETURNING l_amt
            END IF
            CASE l_i
               WHEN 1
                  LET g_detail3[l_ac3].tnum1 = l_num
                  LET g_detail3[l_ac3].tprice1 = l_price
                  LET g_detail3[l_ac3].tamt1 = l_sum
                  LET g_detail3[l_ac3].tbamt1 = l_amt
               WHEN 2
                  LET g_detail3[l_ac3].tnum2 = l_num
                  LET g_detail3[l_ac3].tprice2 = l_price
                  LET g_detail3[l_ac3].tamt2 = l_sum
                  LET g_detail3[l_ac3].tbamt2 = l_amt
               WHEN 3
                  LET g_detail3[l_ac3].tnum3 = l_num
                  LET g_detail3[l_ac3].tprice3 = l_price
                  LET g_detail3[l_ac3].tamt3 = l_sum
                  LET g_detail3[l_ac3].tbamt3 = l_amt
               WHEN 4
                  LET g_detail3[l_ac3].tnum4 = l_num
                  LET g_detail3[l_ac3].tprice4 = l_price
                  LET g_detail3[l_ac3].tamt4 = l_sum
                  LET g_detail3[l_ac3].tbamt4 = l_amt
               WHEN 5
                  LET g_detail3[l_ac3].tnum5 = l_num
                  LET g_detail3[l_ac3].tprice5 = l_price
                  LET g_detail3[l_ac3].tamt5 = l_sum
                  LET g_detail3[l_ac3].tbamt5 = l_amt
               WHEN 6
                  LET g_detail3[l_ac3].tnum6 = l_num
                  LET g_detail3[l_ac3].tprice6 = l_price
                  LET g_detail3[l_ac3].tamt6 = l_sum
                  LET g_detail3[l_ac3].tbamt6 = l_amt
               WHEN 7
                  LET g_detail3[l_ac3].tnum7 = l_num
                  LET g_detail3[l_ac3].tprice7 = l_price
                  LET g_detail3[l_ac3].tamt7 = l_sum
                  LET g_detail3[l_ac3].tbamt7 = l_amt
               WHEN 8
                  LET g_detail3[l_ac3].tnum8 = l_num
                  LET g_detail3[l_ac3].tprice8 = l_price
                  LET g_detail3[l_ac3].tamt8 = l_sum
                  LET g_detail3[l_ac3].tbamt8 = l_amt
               WHEN 9
                  LET g_detail3[l_ac3].tnum9 = l_num
                  LET g_detail3[l_ac3].tprice9 = l_price
                  LET g_detail3[l_ac3].tamt9 = l_sum
                  LET g_detail3[l_ac3].tbamt9 = l_amt
               WHEN 10
                  LET g_detail3[l_ac3].tnum10 = l_num
                  LET g_detail3[l_ac3].tprice10 = l_price
                  LET g_detail3[l_ac3].tamt10 = l_sum
                  LET g_detail3[l_ac3].tbamt10 = l_amt
               WHEN 11
                  LET g_detail3[l_ac3].tnum11 = l_num
                  LET g_detail3[l_ac3].tprice11 = l_price
                  LET g_detail3[l_ac3].tamt11 = l_sum
                  LET g_detail3[l_ac3].tbamt11 = l_amt
               WHEN 12
                  LET g_detail3[l_ac3].tnum12 = l_num
                  LET g_detail3[l_ac3].tprice12 = l_price
                  LET g_detail3[l_ac3].tamt12 = l_sum
                  LET g_detail3[l_ac3].tbamt12 = l_amt
               WHEN 13
                  LET g_detail3[l_ac3].tnum13 = l_num
                  LET g_detail3[l_ac3].tprice13 = l_price
                  LET g_detail3[l_ac3].tamt13 = l_sum
                  LET g_detail3[l_ac3].tbamt13 = l_amt
            END CASE
            #合計
            LET g_detail3[l_ac3].sum2 = g_detail3[l_ac3].sum2 + l_sum
            LET g_detail3[l_ac3].bsum2 = g_detail3[l_ac3].bsum2 + l_amt            
         END FOR
         
         #说明
         #预算组织
         LET g_detail3[l_ac3].bgcj007_2_desc = g_detail3[l_ac3].bgcj007," ",g_detail3[l_ac3].bgcj007_2_desc
         #料号、品名、规格
         CALL abgq310_get_bgcj009_desc(g_detail3[l_ac3].bgcj009) RETURNING g_detail3[l_ac3].bgcj009_2_desc
         LET g_detail3[l_ac3].bgcj009_2_desc = g_detail3[l_ac3].bgcj009,"  ",g_detail3[l_ac3].bgcj009_2_desc
         #预算细项
         LET g_detail3[l_ac3].bgcj049_2_desc = g_detail3[l_ac3].bgcj049,"  ",g_detail3[l_ac3].bgcj049_2_desc
         #人员
         LET g_detail3[l_ac3].bgcj012_2_desc = g_detail3[l_ac3].bgcj012," ",g_detail3[l_ac3].bgcj012_2_desc
         #部门
         LET g_detail3[l_ac3].bgcj013_2_desc = g_detail3[l_ac3].bgcj013," ",g_detail3[l_ac3].bgcj013_2_desc
         #成本利润中心
         LET g_detail3[l_ac3].bgcj014_2_desc = g_detail3[l_ac3].bgcj014," ",g_detail3[l_ac3].bgcj014_2_desc
         #区域
         LET g_detail3[l_ac3].bgcj015_2_desc = g_detail3[l_ac3].bgcj015," ",g_detail3[l_ac3].bgcj015_2_desc
         #收付款客商
         LET g_detail3[l_ac3].bgcj016_2_desc = g_detail3[l_ac3].bgcj016," ",g_detail3[l_ac3].bgcj016_2_desc
         #账款客商
         LET g_detail3[l_ac3].bgcj017_2_desc = g_detail3[l_ac3].bgcj017," ",g_detail3[l_ac3].bgcj017_2_desc
         #客群
         LET g_detail3[l_ac3].bgcj018_2_desc = g_detail3[l_ac3].bgcj018," ",g_detail3[l_ac3].bgcj018_2_desc
         #产品类型
         LET g_detail3[l_ac3].bgcj019_2_desc = g_detail3[l_ac3].bgcj019," ",g_detail3[l_ac3].bgcj019_2_desc
         #专案
         LET g_detail3[l_ac3].bgcj020_2_desc = g_detail3[l_ac3].bgcj020," ",g_detail3[l_ac3].bgcj020_2_desc
         #WBS
         LET g_detail3[l_ac3].bgcj021_2_desc = g_detail3[l_ac3].bgcj021," ",g_detail3[l_ac3].bgcj021_2_desc
         #渠道
         LET g_detail3[l_ac3].bgcj023_2_desc = g_detail3[l_ac3].bgcj023," ",g_detail3[l_ac3].bgcj023_2_desc
         #品牌
         LET g_detail3[l_ac3].bgcj024_2_desc = g_detail3[l_ac3].bgcj024," ",g_detail3[l_ac3].bgcj024_2_desc
         LET l_ac3=l_ac3+1
      END FOREACH  
   END FOREACH
   LET l_ac3=l_ac3-1
   CALL g_detail3.deleteElement(g_detail3.getLength())
   #单身三核算项显示
   CALL cl_set_comp_visible('bgcj012_2_desc',g_hsx_visible.hsx_bgcj012)
   CALL cl_set_comp_visible('bgcj013_2_desc',g_hsx_visible.hsx_bgcj013)
   CALL cl_set_comp_visible('bgcj014_2_desc',g_hsx_visible.hsx_bgcj014)
   CALL cl_set_comp_visible('bgcj015_2_desc',g_hsx_visible.hsx_bgcj015)
   CALL cl_set_comp_visible('bgcj016_2_desc',g_hsx_visible.hsx_bgcj016)
   CALL cl_set_comp_visible('bgcj017_2_desc',g_hsx_visible.hsx_bgcj017)
   CALL cl_set_comp_visible('bgcj018_2_desc',g_hsx_visible.hsx_bgcj018)
   CALL cl_set_comp_visible('bgcj019_2_desc',g_hsx_visible.hsx_bgcj019)
   CALL cl_set_comp_visible('bgcj020_2_desc',g_hsx_visible.hsx_bgcj020)
   CALL cl_set_comp_visible('bgcj021_2_desc',g_hsx_visible.hsx_bgcj021)
   CALL cl_set_comp_visible('bgcj022_2',g_hsx_visible.hsx_bgcj022)
   CALL cl_set_comp_visible('bgcj023_2_desc',g_hsx_visible.hsx_bgcj023)
   CALL cl_set_comp_visible('bgcj024_2_desc',g_hsx_visible.hsx_bgcj024)
END FUNCTION

################################################################################
# Descriptions...: 由单身二中核算项资料组成的核算项条件
# Memo...........:
# Usage..........: CALL abgq310_hsx_where(p_ac)
#                  RETURNING r_where
# Input parameter: p_ac           单身二行号
# Return code....: r_where        核算项组成的where条件
# Date & Author..: 2016/12/16 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq310_hsx_where(p_ac)
   DEFINE p_ac         LIKE type_t.num10
   DEFINE r_where      STRING
   
   LET r_where=' 1=1 '
   IF p_ac<=0 THEN
      RETURN r_where
   END IF
   
   IF g_input.kind='2' THEN
      #预算料号
      IF g_input.hsx_bgcj009 = 'Y' THEN
         LET r_where=r_where," AND bgcj009='",g_detail2[p_ac].bgcj009,"'"
      END IF
      #预算细项
      IF g_input.hsx_bgcj049 = 'Y' THEN
         LET r_where=r_where," AND bgcj049='",g_detail2[p_ac].bgcj049,"'"
      END IF
      #人员
      IF g_input.hsx_bgcj012 = 'Y' THEN
         LET r_where=r_where," AND bgcj012='",g_detail2[p_ac].bgcj012,"'"
      END IF
      #部门
      IF g_input.hsx_bgcj013 = 'Y' THEN
         LET r_where=r_where," AND bgcj013='",g_detail2[p_ac].bgcj013,"'"
      END IF
      #成本利润中心
      IF g_input.hsx_bgcj014 = 'Y' THEN
         LET r_where=r_where," AND bgcj014='",g_detail2[p_ac].bgcj014,"'"
      END IF
      #区域
      IF g_input.hsx_bgcj015 = 'Y' THEN
         LET r_where=r_where," AND bgcj015='",g_detail2[p_ac].bgcj015,"'"
      END IF
      #收付款客商
      IF g_input.hsx_bgcj016 = 'Y' THEN
         LET r_where=r_where," AND bgcj016='",g_detail2[p_ac].bgcj016,"'"
      END IF
      #账款客商
      IF g_input.hsx_bgcj017 = 'Y' THEN
         LET r_where=r_where," AND bgcj017='",g_detail2[p_ac].bgcj017,"'"
      END IF
      #客群
      IF g_input.hsx_bgcj018 = 'Y' THEN
         LET r_where=r_where," AND bgcj018='",g_detail2[p_ac].bgcj018,"'"
      END IF
      #产品类别
      IF g_input.hsx_bgcj019 = 'Y' THEN
         LET r_where=r_where," AND bgcj019='",g_detail2[p_ac].bgcj019,"'"
      END IF
      #专案
      IF g_input.hsx_bgcj020 = 'Y' THEN
         LET r_where=r_where," AND bgcj020='",g_detail2[p_ac].bgcj020,"'"
      END IF
      #WBS
      IF g_input.hsx_bgcj021 = 'Y' THEN
         LET r_where=r_where," AND bgcj021='",g_detail2[p_ac].bgcj021,"'"
      END IF
      #经营方式
      IF g_input.hsx_bgcj022 = 'Y' THEN
         LET r_where=r_where," AND bgcj022='",g_detail2[p_ac].bgcj022,"'"
      END IF
      #渠道
      IF g_input.hsx_bgcj023 = 'Y' THEN
         LET r_where=r_where," AND bgcj023='",g_detail2[p_ac].bgcj023,"'"
      END IF
      #品牌
      IF g_input.hsx_bgcj024 = 'Y' THEN
         LET r_where=r_where," AND bgcj024='",g_detail2[p_ac].bgcj024,"'"
      END IF
   ELSE
      #预算料号
      IF g_bgaw1[2] = 'Y' OR g_bgaw2[2] = 'Y' THEN
         LET r_where=r_where," AND bgcj009='",g_detail2[p_ac].bgcj009,"'",
                             " AND bgcj049='",g_detail2[p_ac].bgcj049,"'"
      END IF
      #人员
      IF g_bgaw1[13] = 'Y' OR g_bgaw2[13] = 'Y' THEN
         LET r_where=r_where," AND bgcj012='",g_detail2[p_ac].bgcj012,"'"
      END IF
      #部门
      IF g_bgaw1[3] = 'Y' OR g_bgaw2[3] = 'Y' THEN
         LET r_where=r_where," AND bgcj013='",g_detail2[p_ac].bgcj013,"'"
      END IF
      #成本利润中心
      IF g_bgaw1[4] = 'Y' OR g_bgaw2[4] = 'Y' THEN
         LET r_where=r_where," AND bgcj014='",g_detail2[p_ac].bgcj014,"'"
      END IF
      #区域
      IF g_bgaw1[5] = 'Y' OR g_bgaw2[5] = 'Y' THEN
         LET r_where=r_where," AND bgcj015='",g_detail2[p_ac].bgcj015,"'"
      END IF
      #收付款客商
      IF g_bgaw1[6] = 'Y' OR g_bgaw2[6] = 'Y' THEN
         LET r_where=r_where," AND bgcj016='",g_detail2[p_ac].bgcj016,"'"
      END IF
      #账款客商
      IF g_bgaw1[7] = 'Y' OR g_bgaw2[7] = 'Y' THEN
         LET r_where=r_where," AND bgcj017='",g_detail2[p_ac].bgcj017,"'"
      END IF
      #客群
      IF g_bgaw1[8] = 'Y' OR g_bgaw2[8] = 'Y' THEN
         LET r_where=r_where," AND bgcj018='",g_detail2[p_ac].bgcj018,"'"
      END IF
      #产品类别
      IF g_bgaw1[9] = 'Y' OR g_bgaw2[9] = 'Y' THEN
         LET r_where=r_where," AND bgcj019='",g_detail2[p_ac].bgcj019,"'"
      END IF
      #专案
      IF g_bgaw1[14] = 'Y' OR g_bgaw2[14] = 'Y' THEN
         LET r_where=r_where," AND bgcj020='",g_detail2[p_ac].bgcj020,"'"
      END IF
      #WBS
      IF g_bgaw1[15] = 'Y' OR g_bgaw2[15] = 'Y' THEN
         LET r_where=r_where," AND bgcj021='",g_detail2[p_ac].bgcj021,"'"
      END IF
      #经营方式
      IF g_bgaw1[10] = 'Y' OR g_bgaw2[10] = 'Y' THEN
         LET r_where=r_where," AND bgcj022='",g_detail2[p_ac].bgcj022,"'"
      END IF
      #渠道
      IF g_bgaw1[11] = 'Y' OR g_bgaw2[11] = 'Y' THEN
         LET r_where=r_where," AND bgcj023='",g_detail2[p_ac].bgcj023,"'"
      END IF
      #品牌
      IF g_bgaw1[12] = 'Y' OR g_bgaw2[12] = 'Y' THEN
         LET r_where=r_where," AND bgcj024='",g_detail2[p_ac].bgcj024,"'"
      END IF
   END IF
   
   RETURN r_where
END FUNCTION

################################################################################
# Descriptions...: 抓取abgi110中启用的核算项
# Memo...........:
# Usage..........: CALL abgq310_hsx_bgal(p_bgal002,p_bgal003)
#                  RETURNING r_str
# Input parameter: p_bgal002      预算组织
#                : p_bgal003      预算细项
# Return code....: r_str          核算项组成的字符串
# Date & Author..: 2016/12/16 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq310_hsx_bgal(p_bgal002,p_bgal003)
   DEFINE p_bgal002    LIKE bgal_t.bgal002
   DEFINE p_bgal003    LIKE bgal_t.bgal003
   DEFINE r_str        STRING
   
   
   LET r_str=""
   #抓取预算细项对应启用核算项设置
   SELECT bgal005,bgal006,bgal007,bgal008,bgal009,
          bgal010,bgal011,bgal012,bgal013,bgal014,
          bgal025,bgal026,bgal027 
     INTO g_bgal.bgal005,g_bgal.bgal006,g_bgal.bgal007,g_bgal.bgal008,g_bgal.bgal009,
          g_bgal.bgal010,g_bgal.bgal011,g_bgal.bgal012,g_bgal.bgal013,g_bgal.bgal014,
          g_bgal.bgal025,g_bgal.bgal026,g_bgal.bgal027
     FROM bgal_t 
    WHERE bgalent=g_enterprise AND bgal001=g_input.bgcj002
      AND bgal002=p_bgal002 AND bgal003=p_bgal003
         
   #人员
   IF g_bgal.bgal012 = 'Y' THEN
      LET g_hsx_visible.hsx_bgcj012=1
      LET r_str= r_str,",bgcj012,",g_get_sql.bgcj012
   ELSE
      LET r_str= r_str,",'' bgcj012,''"
   END IF
   #部门
   IF g_bgal.bgal005 = 'Y' THEN
      LET g_hsx_visible.hsx_bgcj013=1
      LET r_str= r_str,",bgcj013,",g_get_sql.bgcj013
   ELSE
      LET r_str= r_str,",'' bgcj013,''"
   END IF
   #利润成本中心
   IF g_bgal.bgal006 = 'Y'  THEN
      LET g_hsx_visible.hsx_bgcj014=1
      LET r_str= r_str,",bgcj014,",g_get_sql.bgcj014
   ELSE
      LET r_str= r_str,",'' bgcj014,''"
   END IF
   #区域
   IF g_bgal.bgal007 = 'Y'  THEN
      LET g_hsx_visible.hsx_bgcj015=1
      LET r_str= r_str,",bgcj015,",g_get_sql.bgcj015
   ELSE
      LET r_str= r_str,",'' bgcj015,''"
   END IF
   #收付款客商
   IF g_bgal.bgal008 = 'Y'  THEN
      LET g_hsx_visible.hsx_bgcj016=1
      LET r_str= r_str,",bgcj016,",g_get_sql.bgcj016
   ELSE
      LET r_str= r_str,",'' bgcj016,''"
   END IF
   #账款客商
   IF g_bgal.bgal009 = 'Y'  THEN
      LET g_hsx_visible.hsx_bgcj017=1
      LET r_str= r_str,",bgcj017,",g_get_sql.bgcj017
   ELSE
      LET r_str= r_str,",'' bgcj017,''"
   END IF
   #客群
   IF g_bgal.bgal010 = 'Y'  THEN
      LET g_hsx_visible.hsx_bgcj018=1
      LET r_str= r_str,",bgcj018,",g_get_sql.bgcj018
   ELSE
      LET r_str= r_str,",'' bgcj018,''"
   END IF
   #产品类别
   IF g_bgal.bgal011 = 'Y' THEN
      LET g_hsx_visible.hsx_bgcj019=1
      LET r_str= r_str,",bgcj019,",g_get_sql.bgcj019
   ELSE
      LET r_str= r_str,",'' bgcj019,''"
   END IF
   #专案
   IF g_bgal.bgal013 = 'Y' THEN
      LET g_hsx_visible.hsx_bgcj020=1
      LET r_str= r_str,",bgcj020,",g_get_sql.bgcj020
   ELSE
      LET r_str= r_str,",'' bgcj020,''"
   END IF
   #WBS
   IF g_bgal.bgal014 = 'Y' THEN
      LET g_hsx_visible.hsx_bgcj021=1
      LET r_str= r_str,",bgcj021,",g_get_sql.bgcj021
   ELSE
      LET r_str= r_str,",'' bgcj021,''"
   END IF 
   #经营方式
   IF g_bgal.bgal025 = 'Y' THEN
      LET g_hsx_visible.hsx_bgcj022=1
      LET r_str= r_str,",bgcj022"
   ELSE
      LET r_str= r_str,",'' bgcj022"
   END IF
   #通路
   IF g_bgal.bgal026 = 'Y' THEN
      LET g_hsx_visible.hsx_bgcj023=1
      LET r_str= r_str,",bgcj023,",g_get_sql.bgcj023
   ELSE
      LET r_str= r_str,",'' bgcj023,''"
   END IF
   #品牌
   IF g_bgal.bgal027 = 'Y' THEN
      LET g_hsx_visible.hsx_bgcj024=1
      LET r_str= r_str,",bgcj024,",g_get_sql.bgcj024
   ELSE
      LET r_str= r_str,",'' bgcj024,''"
   END IF
   RETURN r_str
END FUNCTION

################################################################################
# Descriptions...: 根据预算细项对应abgi100启用核算项设置，组成核算项where条件
# Memo...........:
# Usage..........: CALL abgq310_hsx_where_3(p_ac)
#                  RETURNING r_where
# Input parameter: p_ac           单身三行号
# Return code....: r_where        组出核算项条件
# Date & Author..: 2016/12/16 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq310_hsx_where_3(p_ac)
   DEFINE p_ac        LIKE type_t.num10
   DEFINE r_where      STRING
   
   LET r_where=' AND 1=1 '
   IF p_ac<=0 THEN
      RETURN r_where
   END IF
   #人员
   IF g_bgal.bgal012 = 'Y' THEN
      LET r_where=r_where," AND bgcj012='",g_detail3[p_ac].bgcj012,"'"
   END IF
   #部门
   IF g_bgal.bgal005 = 'Y' THEN
      LET r_where=r_where," AND bgcj013='",g_detail3[p_ac].bgcj013,"'"
   END IF
   #成本利润中心
   IF g_bgal.bgal006 = 'Y' THEN
      LET r_where=r_where," AND bgcj014='",g_detail3[p_ac].bgcj014,"'"
   END IF
   #区域
   IF g_bgal.bgal007 = 'Y' THEN
      LET r_where=r_where," AND bgcj015='",g_detail3[p_ac].bgcj015,"'"
   END IF
   #收付款客商
   IF g_bgal.bgal008 = 'Y' THEN
      LET r_where=r_where," AND bgcj016='",g_detail3[p_ac].bgcj016,"'"
   END IF
   #账款客商
   IF g_bgal.bgal009 = 'Y' THEN
      LET r_where=r_where," AND bgcj017='",g_detail3[p_ac].bgcj017,"'"
   END IF
   #客群
   IF g_bgal.bgal010 = 'Y' THEN
      LET r_where=r_where," AND bgcj018='",g_detail3[p_ac].bgcj018,"'"
   END IF
   #产品类别
   IF g_bgal.bgal011 = 'Y' THEN
      LET r_where=r_where," AND bgcj019='",g_detail3[p_ac].bgcj019,"'"
   END IF
   #专案
   IF g_bgal.bgal013 = 'Y' THEN
      LET r_where=r_where," AND bgcj020='",g_detail3[p_ac].bgcj020,"'"
   END IF
   #WBS
   IF g_bgal.bgal014 = 'Y' THEN
      LET r_where=r_where," AND bgcj021='",g_detail3[p_ac].bgcj021,"'"
   END IF
   #经营方式
   IF g_bgal.bgal025 = 'Y' THEN
      LET r_where=r_where," AND bgcj022='",g_detail3[p_ac].bgcj022,"'"
   END IF
   #渠道
   IF g_bgal.bgal026 = 'Y' THEN
      LET r_where=r_where," AND bgcj023='",g_detail3[p_ac].bgcj023,"'"
   END IF
   #品牌
   IF g_bgal.bgal027 = 'Y' THEN
      LET r_where=r_where," AND bgcj024='",g_detail3[p_ac].bgcj024,"'"
   END IF
   
   RETURN r_where
END FUNCTION

################################################################################
# Descriptions...: 抓取料号或是影响因子说明
# Memo...........:
# Usage..........: CALL abgq310_get_bgcj009_desc(p_bgcj009)
#                  RETURNING r_desc
# Input parameter: p_bgcj009      料号或影响因子编号
# Return code....: r_desc         说明
# Date & Author..: 2016/12/25 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq310_get_bgcj009_desc(p_bgcj009)
   DEFINE p_bgcj009       LIKE bgcj_t.bgcj009
   DEFINE r_desc          LIKE bgccl_t.bgccl003
   DEFINE l_bgasl003      LIKE bgasl_t.bgasl003
   DEFINE l_bgasl004      LIKE bgasl_t.bgasl004
   
   LET r_desc = ''
   LET l_bgasl003 = ''
   LET l_bgasl004 = ''
   SELECT bgasl003,bgasl004 INTO l_bgasl003,l_bgasl004
     FROM bgasl_t
    WHERE bgaslent = g_enterprise
      AND bgasl001 = p_bgcj009
      AND bgasl002 = g_dlang
      
   IF SQLCA.sqlcode = 100 THEN
      SELECT bgccl003 INTO r_desc
        FROM bgccl_t
       WHERE bgcclent = g_enterprise
         AND bgccl001 = p_bgcj009
         AND bgccl002 = g_dlang
   ELSE
      LET r_desc = l_bgasl003," ",l_bgasl004
   END IF
   
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 打印
# Memo...........:
# Usage..........: CALL abgq310_output()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/12/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq310_output()
DEFINE l_i,l_j              LIKE type_t.num10
DEFINE l_bgcj022_desc       LIKE type_t.chr500
DEFINE l_xg_visible         STRING
DEFINE l_xg_visible2        STRING

   LET g_accept = 'N'   
   #弹出窗口显示可打印的页签，供用户选择需打印页签   
   CALL abgq310_output_to_getpage()
  
   #取消打印操作
   IF g_accept = 'N' THEN
      RETURN
   END IF
   #打印勾选的页签
   FOR l_j =1 TO g_data_cnt
      IF gr_page[l_j].l_sel = 'Y' THEN
         #符合条件数据
         IF g_page_name[l_j] = 'page_qbe' THEN
            #打印勾选的页签
            DELETE FROM abgq310_tmp1
            FOR l_i = 1 TO g_detail2.getLength()
               #经营方式
               IF NOT cl_null(g_detail2[l_i].bgcj022) THEN
                  LET l_bgcj022_desc = ''
                  SELECT gzcbl004 INTO l_bgcj022_desc FROM gzcbl_t 
                  WHERE gzcbl001='6013' AND gzcbl002=g_detail2[l_i].bgcj022 AND gzcbl003=g_dlang
                  LET l_bgcj022_desc = g_detail2[l_i].bgcj022,l_bgcj022_desc
               END IF
               
               INSERT INTO abgq310_tmp1
               VALUES(g_enterprise,g_detail2[l_i].seq,g_detail2[l_i].bgcj007,g_detail2[l_i].bgcj007_1_desc,
               g_detail2[l_i].bgcj009,g_detail2[l_i].bgcj009_desc,g_detail2[l_i].bgcj049,g_detail2[l_i].bgcj049_desc,
               g_detail2[l_i].bgcj012,g_detail2[l_i].bgcj012_desc,g_detail2[l_i].bgcj013,g_detail2[l_i].bgcj013_desc,
               g_detail2[l_i].bgcj014,g_detail2[l_i].bgcj014_desc,g_detail2[l_i].bgcj015,g_detail2[l_i].bgcj015_desc,
               g_detail2[l_i].bgcj016,g_detail2[l_i].bgcj016_desc,g_detail2[l_i].bgcj017,g_detail2[l_i].bgcj017_desc,
               g_detail2[l_i].bgcj018,g_detail2[l_i].bgcj018_desc,g_detail2[l_i].bgcj019,g_detail2[l_i].bgcj019_desc,
               g_detail2[l_i].bgcj020,g_detail2[l_i].bgcj020_desc,g_detail2[l_i].bgcj021,g_detail2[l_i].bgcj021_desc,
               g_detail2[l_i].bgcj022,l_bgcj022_desc,g_detail2[l_i].bgcj023,g_detail2[l_i].bgcj023_desc,
               g_detail2[l_i].bgcj024,g_detail2[l_i].bgcj024_desc,g_detail2[l_i].bgcj100,
               g_detail2[l_i].amt1,g_detail2[l_i].bamt1,g_detail2[l_i].amt2,g_detail2[l_i].bamt2,
               g_detail2[l_i].amt3,g_detail2[l_i].bamt3,g_detail2[l_i].amt4,g_detail2[l_i].bamt4,
               g_detail2[l_i].amt5,g_detail2[l_i].bamt5,g_detail2[l_i].amt6,g_detail2[l_i].bamt6,
               g_detail2[l_i].amt7,g_detail2[l_i].bamt7,g_detail2[l_i].amt8,g_detail2[l_i].bamt8,
               g_detail2[l_i].amt9,g_detail2[l_i].bamt9,g_detail2[l_i].amt10,g_detail2[l_i].bamt10,
               g_detail2[l_i].amt11,g_detail2[l_i].bamt11,g_detail2[l_i].amt12,g_detail2[l_i].bamt12,
               g_detail2[l_i].amt13,g_detail2[l_i].bamt13,g_detail2[l_i].sum1,g_detail2[l_i].bsum1,l_i
               )
            END FOR
            CALL abgq310_xg_visible(g_page_name[l_j]) RETURNING l_xg_visible
            CALL abgq310_x01(' 1=1','abgq310_tmp1',l_xg_visible)
         END IF
         #明细数据
         IF g_page_name[l_j] = 'page_1' THEN
            #打印勾选的页签
            DELETE FROM abgq310_tmp2
            FOR l_i = 1 TO g_detail3.getLength()
               #经营方式
               IF NOT cl_null(g_detail3[l_i].bgcj022) THEN
                  LET l_bgcj022_desc = ''
                  SELECT gzcbl004 INTO l_bgcj022_desc FROM gzcbl_t 
                  WHERE gzcbl001='6013' AND gzcbl002=g_detail3[l_i].bgcj022 AND gzcbl003=g_dlang
                  LET l_bgcj022_desc = g_detail3[l_i].bgcj022,l_bgcj022_desc
               END IF
               
               INSERT INTO abgq310_tmp2
               VALUES(g_enterprise,g_detail3[l_i].seq2,g_detail3[l_i].bgcj007,g_detail3[l_i].bgcj007_2_desc,
               g_detail3[l_i].bgcj009,g_detail3[l_i].bgcj009_2_desc,g_detail3[l_i].bgcj049,g_detail3[l_i].bgcj049_2_desc,
               g_detail3[l_i].bgcj012,g_detail3[l_i].bgcj012_2_desc,g_detail3[l_i].bgcj013,g_detail3[l_i].bgcj013_2_desc,
               g_detail3[l_i].bgcj014,g_detail3[l_i].bgcj014_2_desc,g_detail3[l_i].bgcj015,g_detail3[l_i].bgcj015_2_desc,
               g_detail3[l_i].bgcj016,g_detail3[l_i].bgcj016_2_desc,g_detail3[l_i].bgcj017,g_detail3[l_i].bgcj017_2_desc,
               g_detail3[l_i].bgcj018,g_detail3[l_i].bgcj018_2_desc,g_detail3[l_i].bgcj019,g_detail3[l_i].bgcj019_2_desc,
               g_detail3[l_i].bgcj020,g_detail3[l_i].bgcj020_2_desc,g_detail3[l_i].bgcj021,g_detail3[l_i].bgcj021_2_desc,
               g_detail3[l_i].bgcj022,l_bgcj022_desc,g_detail3[l_i].bgcj023,g_detail3[l_i].bgcj023_2_desc,
               g_detail3[l_i].bgcj024,g_detail3[l_i].bgcj024_2_desc,g_detail3[l_i].bgcj035,g_detail3[l_i].bgcj036,
               g_detail3[l_i].bgcj037,g_detail3[l_i].bgcj100,
               g_detail3[l_i].tnum1,g_detail3[l_i].tprice1,g_detail3[l_i].tamt1,g_detail3[l_i].tbamt1,
               g_detail3[l_i].tnum2,g_detail3[l_i].tprice2,g_detail3[l_i].tamt2,g_detail3[l_i].tbamt2,
               g_detail3[l_i].tnum3,g_detail3[l_i].tprice3,g_detail3[l_i].tamt3,g_detail3[l_i].tbamt3,
               g_detail3[l_i].tnum4,g_detail3[l_i].tprice4,g_detail3[l_i].tamt4,g_detail3[l_i].tbamt4,
               g_detail3[l_i].tnum5,g_detail3[l_i].tprice5,g_detail3[l_i].tamt5,g_detail3[l_i].tbamt5,
               g_detail3[l_i].tnum6,g_detail3[l_i].tprice6,g_detail3[l_i].tamt6,g_detail3[l_i].tbamt6,
               g_detail3[l_i].tnum7,g_detail3[l_i].tprice7,g_detail3[l_i].tamt7,g_detail3[l_i].tbamt7,
               g_detail3[l_i].tnum8,g_detail3[l_i].tprice8,g_detail3[l_i].tamt8,g_detail3[l_i].tbamt8,
               g_detail3[l_i].tnum9,g_detail3[l_i].tprice9,g_detail3[l_i].tamt9,g_detail3[l_i].tbamt9,
               g_detail3[l_i].tnum10,g_detail3[l_i].tprice10,g_detail3[l_i].tamt10,g_detail3[l_i].tbamt10,
               g_detail3[l_i].tnum11,g_detail3[l_i].tprice11,g_detail3[l_i].tamt11,g_detail3[l_i].tbamt11,
               g_detail3[l_i].tnum11,g_detail3[l_i].tprice12,g_detail3[l_i].tamt12,g_detail3[l_i].tbamt12,
               g_detail3[l_i].tnum13,g_detail3[l_i].tprice13,g_detail3[l_i].tamt13,g_detail3[l_i].tbamt13,
               g_detail3[l_i].sum2,g_detail3[l_i].bsum2,l_i
               )
            END FOR
            CALL abgq310_xg_visible(g_page_name[l_j]) RETURNING l_xg_visible
            CALL abgq310_x02(' 1=1','abgq310_tmp2',l_xg_visible)
         END IF
      END IF
   END FOR
   
END FUNCTION

################################################################################
# Descriptions...: 建立打印临时表
# Memo...........:
# Usage..........: CALL abgq310_create_print_tmp()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/12/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq310_create_print_tmp()
   DROP TABLE abgq310_tmp1
   CREATE TEMP TABLE abgq310_tmp1(
   bgcjent  SMALLINT,
   seq  INTEGER,
   bgcj007  VARCHAR(10), 
   bgcj007_desc  VARCHAR(500), 
   bgcj009  VARCHAR(40), 
   bgcj009_desc  VARCHAR(500), 
   bgcj049  VARCHAR(24),
   bgcj049_desc  VARCHAR(500),
   bgcj012  VARCHAR(20), 
   bgcj012_desc  VARCHAR(500), 
   bgcj013  VARCHAR(10), 
   bgcj013_desc  VARCHAR(500), 
   bgcj014  VARCHAR(10), 
   bgcj014_desc  VARCHAR(500), 
   bgcj015  VARCHAR(10), 
   bgcj015_desc  VARCHAR(500), 
   bgcj016  VARCHAR(10), 
   bgcj016_desc  VARCHAR(500), 
   bgcj017  VARCHAR(10), 
   bgcj017_desc  VARCHAR(500), 
   bgcj018  VARCHAR(10), 
   bgcj018_desc  VARCHAR(500), 
   bgcj019  VARCHAR(10), 
   bgcj019_desc  VARCHAR(500), 
   bgcj020  VARCHAR(20), 
   bgcj020_desc  VARCHAR(500), 
   bgcj021  VARCHAR(30), 
   bgcj021_desc  VARCHAR(500), 
   bgcj022  VARCHAR(10), 
   bgcj022_desc  VARCHAR(500),
   bgcj023  VARCHAR(10), 
   bgcj023_desc  VARCHAR(500), 
   bgcj024  VARCHAR(10), 
   bgcj024_desc  VARCHAR(500), 
   bgcj100  VARCHAR(10),
   amt1  DECIMAL(20,6), 
   bamt1  DECIMAL(20,6), 
   amt2  DECIMAL(20,6), 
   bamt2  DECIMAL(20,6), 
   amt3  DECIMAL(20,6), 
   bamt3  DECIMAL(20,6), 
   amt4  DECIMAL(20,6), 
   bamt4  DECIMAL(20,6), 
   amt5  DECIMAL(20,6), 
   bamt5  DECIMAL(20,6), 
   amt6  DECIMAL(20,6), 
   bamt6  DECIMAL(20,6), 
   amt7  DECIMAL(20,6), 
   bamt7  DECIMAL(20,6), 
   amt8  DECIMAL(20,6), 
   bamt8  DECIMAL(20,6), 
   amt9  DECIMAL(20,6), 
   bamt9  DECIMAL(20,6), 
   amt10  DECIMAL(20,6), 
   bamt10  DECIMAL(20,6), 
   amt11  DECIMAL(20,6), 
   bamt11  DECIMAL(20,6), 
   amt12  DECIMAL(20,6), 
   bamt12  DECIMAL(20,6), 
   amt13  DECIMAL(20,6), 
   bamt13  DECIMAL(20,6),
   sum1  DECIMAL(20,6), 
   bsum1  DECIMAL(20,6),
   idx  INTEGER
   )
   
   DROP TABLE abgq310_tmp2
   CREATE TEMP TABLE abgq310_tmp2(
   bgcjent  SMALLINT,
   seq  INTEGER,
   bgcj007  VARCHAR(10), 
   bgcj007_desc  VARCHAR(500), 
   bgcj009  VARCHAR(40), 
   bgcj009_desc  VARCHAR(500), 
   bgcj049  VARCHAR(24), 
   bgcj049_desc  VARCHAR(500),
   bgcj012  VARCHAR(20), 
   bgcj012_desc  VARCHAR(500), 
   bgcj013  VARCHAR(10), 
   bgcj013_desc  VARCHAR(500), 
   bgcj014  VARCHAR(10), 
   bgcj014_desc  VARCHAR(500), 
   bgcj015  VARCHAR(10), 
   bgcj015_desc  VARCHAR(500), 
   bgcj016  VARCHAR(10), 
   bgcj016_desc  VARCHAR(500), 
   bgcj017  VARCHAR(10), 
   bgcj017_desc  VARCHAR(500), 
   bgcj018  VARCHAR(10), 
   bgcj018_desc  VARCHAR(500), 
   bgcj019  VARCHAR(10), 
   bgcj019_desc  VARCHAR(500), 
   bgcj020  VARCHAR(20), 
   bgcj020_desc  VARCHAR(500), 
   bgcj021  VARCHAR(30), 
   bgcj021_desc  VARCHAR(500), 
   bgcj022  VARCHAR(10),
   bgcj022_desc  VARCHAR(500),
   bgcj023  VARCHAR(10), 
   bgcj023_desc  VARCHAR(500), 
   bgcj024  VARCHAR(10), 
   bgcj024_desc  VARCHAR(500), 
   bgcj035  VARCHAR(10), 
   bgcj036  VARCHAR(1), 
   bgcj037  VARCHAR(10), 
   bgcj100  VARCHAR(10), 
   tnum1  DECIMAL(20,6), 
   tprice1  DECIMAL(20,6), 
   tamt1  DECIMAL(20,6), 
   tbamt1  DECIMAL(20,6), 
   tnum2  DECIMAL(20,6), 
   tprice2  DECIMAL(20,6), 
   tamt2  DECIMAL(20,6), 
   tbamt2  DECIMAL(20,6), 
   tnum3  DECIMAL(20,6), 
   tprice3  DECIMAL(20,6), 
   tamt3  DECIMAL(20,6), 
   tbamt3  DECIMAL(20,6), 
   tnum4  DECIMAL(20,6), 
   tprice4  DECIMAL(20,6), 
   tamt4  DECIMAL(20,6), 
   tbamt4  DECIMAL(20,6), 
   tnum5  DECIMAL(20,6), 
   tprice5  DECIMAL(20,6), 
   tamt5  DECIMAL(20,6), 
   tbamt5  DECIMAL(20,6), 
   tnum6  DECIMAL(20,6), 
   tprice6  DECIMAL(20,6), 
   tamt6  DECIMAL(20,6), 
   tbamt6  DECIMAL(20,6), 
   tnum7  DECIMAL(20,6), 
   tprice7  DECIMAL(20,6), 
   tamt7  DECIMAL(20,6), 
   tbamt7  DECIMAL(20,6), 
   tnum8  DECIMAL(20,6), 
   tprice8  DECIMAL(20,6), 
   tamt8  DECIMAL(20,6), 
   tbamt8  DECIMAL(20,6), 
   tnum9  DECIMAL(20,6), 
   tprice9  DECIMAL(20,6), 
   tamt9  DECIMAL(20,6), 
   tbamt9  DECIMAL(20,6), 
   tnum10  DECIMAL(20,6), 
   tprice10  DECIMAL(20,6), 
   tamt10  DECIMAL(20,6), 
   tbamt10  DECIMAL(20,6), 
   tnum11  DECIMAL(20,6), 
   tprice11  DECIMAL(20,6), 
   tamt11  DECIMAL(20,6), 
   tbamt11  DECIMAL(20,6), 
   tnum12  DECIMAL(20,6), 
   tprice12  DECIMAL(20,6), 
   tamt12  DECIMAL(20,6), 
   tbamt12  DECIMAL(20,6), 
   tnum13  DECIMAL(20,6), 
   tprice13  DECIMAL(20,6), 
   tamt13  DECIMAL(20,6), 
   tbamt13  DECIMAL(20,6),
   sum2  DECIMAL(20,6), 
   bsum2  DECIMAL(20,6),
   idx  INTEGER
   )
END FUNCTION

################################################################################
# Descriptions...: 弹出窗口显示可打印的页签，供用户选择需打印页签
# Memo...........:
# Usage..........: CALL abgq310_output_to_getpage()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/12/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq310_output_to_getpage()
   DEFINE w                     ui.Window
   DEFINE twindow               om.DomNode
   DEFINE l_text                STRING
   DEFINE li_ac                 LIKE type_t.num5
   DEFINE ldig_curr             ui.Dialog
   
   LET w = ui.Window.getCurrent()
   LET twindow = w.getNode()

   CALL gr_page.clear()
   CALL abgq310_output_to_result_set(twindow)

   IF g_data_cnt <> 0 THEN
      OPEN WINDOW w_pageqry_xg WITH FORM cl_ap_formpath("lib","cl_export_s01")
         ATTRIBUTE(STYLE="openwin")
      CALL cl_ui_init()   

      LET INT_FLAG = FALSE         #避免被其他函式影響
      #設定開窗識別碼的說明
      LET gwin_curr = ui.Window.forName("w_pageqry_xg")
      LET l_text = cl_getmsg('agl-00375',g_lang)
      CALL gwin_curr.setText(l_text)

      #勾选需打印页签
      DIALOG ATTRIBUTES(UNBUFFERED)
         INPUT ARRAY gr_page FROM s_detail1.*
            ATTRIBUTES(COUNT=g_data_cnt,
                       APPEND ROW=FALSE, INSERT ROW=FALSE, DELETE ROW=FALSE)
     
            BEFORE ROW
               LET li_ac = DIALOG.getCurrentRow("s_detail1")
     
            ON CHANGE l_sel   #改變勾選狀態
         END INPUT
     
         BEFORE DIALOG
            LET ldig_curr = ui.Dialog.getCurrent()
     
         ON ACTION btn_accept 
            LET g_accept = 'Y'
            EXIT DIALOG
     
         ON ACTION btn_cancel
            LET g_accept = 'N'
            LET INT_FLAG = TRUE
            EXIT DIALOG
     
         ON ACTION close 
            LET g_accept = 'N'
            LET INT_FLAG = TRUE
            EXIT DIALOG
      END DIALOG

      IF INT_FLAG THEN
         LET INT_FLAG = 0
      END IF

      CLOSE WINDOW w_pageqry_xg
   END IF
END FUNCTION

################################################################################
# Descriptions...: 抓取单身需要打印的页签资料，填入选择子画面单身汇总
# Memo...........:
# Usage..........: CALL abgq310_output_to_result_set(nRoot)
#                  RETURNING 回传参数
# Input parameter: nRoot          当前程序画面
# Return code....: 
# Date & Author..: 2016/12/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq310_output_to_result_set(nRoot)
   DEFINE nRoot                 om.DomNode
   DEFINE lst_page              om.NodeList         #<Page>节点列表
   DEFINE page                  om.DomNode          #<Page>节点
   DEFINE lst_table             om.NodeList         #<Table>节点列表
   DEFINE l_i                   LIKE type_t.num5
   DEFINE l_j                   LIKE type_t.num5
   DEFINE l_k                   LIKE type_t.num5
   DEFINE l_m                   LIKE type_t.num5
   DEFINE n_table               om.DomNode
   DEFINE l_check               LIKE type_t.chr1

   CALL gr_page.clear()
   CALL g_page_name.clear()
   
   LET lst_page = nRoot.selectByTagName("Page")
   LET l_i = 1
   FOR l_j = 1 TO lst_page.getLength()
       LET page = lst_page.item(l_j)
       #判断Page节点是否隐藏
       IF (page.getAttribute("hidden") IS NULL OR page.getAttribute("hidden") = 0) THEN   
          LET lst_table = page.selectByTagName("Table")
          IF lst_table.getLength() <> 0 THEN 
             LET l_check = 'N'
             FOR l_m = 1 TO lst_table.getLength()
                #得到当前Table节点
                LET n_table = lst_table.item(l_m)
                IF (n_table.getAttribute("isTree") IS NULL OR n_table.getAttribute("isTree") = 0) THEN
                   LET l_check = 'Y'
                   EXIT FOR
                END IF
             END FOR
             IF l_check = 'Y' THEN
                #若page名称like"*page_1"预设不打勾
                IF page.getAttribute("name") MATCHES "*page_1*" THEN
                   LET gr_page[l_i].l_sel = 'N'
                ELSE
                   LET gr_page[l_i].l_sel = 'Y'
                END IF
                LET gr_page[l_i].l_page = page.getAttribute("text")
                LET g_page_name[l_i] = page.getAttribute("name")
                LET l_i = l_i + 1
             END IF
          END IF
      END IF  
   END FOR
   LET l_i = l_i - 1
   LET g_data_cnt = l_i

END FUNCTION

################################################################################
# Descriptions...: 根据核算项显示情况设置核算项栏位是否显示
# Memo...........:
# Usage..........: CALL abgq310_xg_visible(p_page_name)
#                  RETURNING r_xg_visible
# Input parameter: p_page_name   打印页签名称
# Return code....: r_xg_visible  影藏栏位
# Date & Author..: 2017/01/12 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq310_xg_visible(p_page_name)
DEFINE p_page_name     STRING
DEFINE r_xg_visible    STRING

   LET r_xg_visible = '' 
   #符合条件页签
   IF p_page_name = 'page_qbe' THEN
      IF g_input.kind='2' THEN      
         #预算料号
         IF g_input.hsx_bgcj009 = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj009_desc"
         END IF
         #预算细项
         IF g_input.hsx_bgcj049 = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|bgcj049"
         END IF
         #人员
         IF g_input.hsx_bgcj012 = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj012_desc"
         END IF
         #部门
         IF g_input.hsx_bgcj013 = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj013_desc"
         END IF
         #成本利润中心
         IF g_input.hsx_bgcj014 = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj014_desc"
         END IF
         #区域
         IF g_input.hsx_bgcj015 = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj015_desc"
         END IF
         #收付款客商
         IF g_input.hsx_bgcj016 = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj016_desc"
         END IF
         #账款客商
         IF g_input.hsx_bgcj017 = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj017_desc"
         END IF
         #客群
         IF g_input.hsx_bgcj018 = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj018_desc"
         END IF
         #产品类别
         IF g_input.hsx_bgcj019 = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj019_desc"
         END IF
         #专案
         IF g_input.hsx_bgcj020 = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj020_desc"
         END IF
         #WBS
         IF g_input.hsx_bgcj021 = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj021_desc"
         END IF
         #经营方式
         IF g_input.hsx_bgcj022 = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj022_desc"
         END IF
         #渠道
         IF g_input.hsx_bgcj023 = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj023_desc"
         END IF
         #品牌
         IF g_input.hsx_bgcj024 = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj024_desc"
         END IF
      ELSE      
         #预算料号
         IF g_bgaw1[2] = 'N' AND g_bgaw2[2] = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj009_desc|bgcj049"
         END IF
         #人员
         IF g_bgaw1[13] = 'N' AND g_bgaw2[13] = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj012_desc"
         END IF
         #部门
         IF g_bgaw1[3] = 'N' AND g_bgaw2[3] = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj013_desc"
         END IF
         #成本利润中心
         IF g_bgaw1[4] = 'N' AND g_bgaw2[4] = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj014_desc"
         END IF
         #区域
         IF g_bgaw1[5] = 'N' AND g_bgaw2[5] = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj015_desc"
         END IF
         #收付款客商
         IF g_bgaw1[6] = 'N' AND g_bgaw2[6] = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj016_desc"
         END IF
         #账款客商
         IF g_bgaw1[7] = 'N' AND g_bgaw2[7] = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj017_desc"
         END IF
         #客群
         IF g_bgaw1[8] = 'N' AND g_bgaw2[8] = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj018_desc"
         END IF
         #产品类别
         IF g_bgaw1[9] = 'N' AND g_bgaw2[9] = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj019_desc"
         END IF
         #专案
         IF g_bgaw1[14] = 'N' AND g_bgaw2[14] = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj020_desc"
         END IF
         #WBS
         IF g_bgaw1[15] = 'N' AND g_bgaw2[15] = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj021_desc"
         END IF
         #经营方式
         IF g_bgaw1[10] = 'N' AND g_bgaw2[10] = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj022_desc"
         END IF
         #渠道
         IF g_bgaw1[11] = 'N' AND g_bgaw2[11] = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj023_desc"
         END IF
         #品牌
         IF g_bgaw1[12] = 'N' AND g_bgaw2[12] = 'N' THEN
            LET r_xg_visible=r_xg_visible,"|l_bgcj024_desc"
         END IF
      END IF
   END IF
   
   #明细页签，当不会30:汇总时，明细页签不显示预算组织   
   IF p_page_name = 'page_1' THEN
      #预算组织
      IF g_input.bgcj001 <> '30' THEN
         LET r_xg_visible=r_xg_visible,"|l_bgcj007_desc"
      END IF
      #人员
      IF g_hsx_visible.hsx_bgcj012 = 0 THEN
         LET r_xg_visible=r_xg_visible,"|l_bgcj012_desc"
      END IF
      #部门
      IF g_hsx_visible.hsx_bgcj013 = 0 THEN
         LET r_xg_visible=r_xg_visible,"|l_bgcj013_desc"
      END IF
      #利润成本中心
      IF g_hsx_visible.hsx_bgcj014 = 0 THEN
         LET r_xg_visible=r_xg_visible,"|l_bgcj014_desc"
      END IF
      #区域
      IF g_hsx_visible.hsx_bgcj015 = 0 THEN
         LET r_xg_visible=r_xg_visible,"|l_bgcj015_desc"
      END IF
      #收付款客商
      IF g_hsx_visible.hsx_bgcj016 = 0 THEN
         LET r_xg_visible=r_xg_visible,"|l_bgcj016_desc"
      END IF
      #账款客商
      IF g_hsx_visible.hsx_bgcj017 = 0 THEN
         LET r_xg_visible=r_xg_visible,"|l_bgcj017_desc"
      END IF
      #客群
      IF g_hsx_visible.hsx_bgcj018 = 0 THEN
         LET r_xg_visible=r_xg_visible,"|l_bgcj018_desc"
      END IF
      #产品类别
      IF g_hsx_visible.hsx_bgcj019 = 0 THEN
         LET r_xg_visible=r_xg_visible,"|l_bgcj019_desc"
      END IF
      #专案
      IF g_hsx_visible.hsx_bgcj020 = 0 THEN
         LET r_xg_visible=r_xg_visible,"|l_bgcj020_desc"
      END IF
      #WBS
      IF g_hsx_visible.hsx_bgcj021 = 0 THEN
         LET r_xg_visible=r_xg_visible,"|l_bgcj021_desc"
      END IF
      #经营方式
      IF g_hsx_visible.hsx_bgcj022 = 0 THEN
         LET r_xg_visible=r_xg_visible,"|l_bgcj022_desc"
      END IF
      #渠道
      IF g_hsx_visible.hsx_bgcj023 = 0 THEN
         LET r_xg_visible=r_xg_visible,"|l_bgcj023_desc"
      END IF
      #品牌
      IF g_hsx_visible.hsx_bgcj024 = 0 THEN
         LET r_xg_visible=r_xg_visible,"|l_bgcj024_desc"
      END IF
   END IF
   IF g_input.show_curr = 'N' THEN
      LET r_xg_visible=r_xg_visible,"|l_bamt1|l_bamt2|l_bamt3|l_bamt4|l_bamt5|l_bamt6|l_bamt7|l_bamt8|l_bamt9|l_bamt10|l_bamt11|l_bamt12|l_bamt13"
   END IF
   IF g_max_period < 13 THEN
      LET r_xg_visible=r_xg_visible,"|l_amt13|l_bamt13"
      IF p_page_name = 'page_1' THEN
         LET r_xg_visible=r_xg_visible,"|l_num13|l_price13"
      END IF
   END IF
   RETURN r_xg_visible
END FUNCTION

 
{</section>}
 
