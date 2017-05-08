#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq854.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-09-19 09:39:12), PR版次:0003(2016-10-24 11:00:27)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000009
#+ Filename...: aglq854
#+ Description: 科目核算項多期間二維查詢
#+ Creator....: 02599(2016-08-31 16:32:31)
#+ Modifier...: 02599 -SD/PR- 06821
 
{</section>}
 
{<section id="aglq854.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160727-00005#2      2016/09/18  By 02599   最後一列增加【合計】字段,依余額型態:1.發生額時,合計各期數值;2.累計額時,合計=最後一期的數值
#161021-00037#2      2016/10/24  By 06821   組織類型與職能開窗調整
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
GLOBALS "../../cfg/top_report.inc"
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_glar_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   glar001 LIKE glar_t.glar001, 
   glar001_desc LIKE type_t.chr500, 
   glar012 LIKE glar_t.glar012, 
   glar012_desc LIKE type_t.chr500, 
   glar013 LIKE glar_t.glar013, 
   glar013_desc LIKE type_t.chr500, 
   glar014 LIKE glar_t.glar014, 
   glar014_desc LIKE type_t.chr500, 
   glar015 LIKE glar_t.glar015, 
   glar015_desc LIKE type_t.chr500, 
   glar016 LIKE glar_t.glar016, 
   glar016_desc LIKE type_t.chr500, 
   glar017 LIKE glar_t.glar017, 
   glar017_desc LIKE type_t.chr500, 
   glar018 LIKE glar_t.glar018, 
   glar018_desc LIKE type_t.chr500, 
   glar019 LIKE glar_t.glar019, 
   glar019_desc LIKE type_t.chr500, 
   glar051 LIKE glar_t.glar051, 
   glar052 LIKE glar_t.glar052, 
   glar052_desc LIKE type_t.chr500, 
   glar053 LIKE glar_t.glar053, 
   glar053_desc LIKE type_t.chr500, 
   glar020 LIKE glar_t.glar020, 
   glar020_desc LIKE type_t.chr500, 
   glar022 LIKE glar_t.glar022, 
   glar022_desc LIKE type_t.chr500, 
   glar023 LIKE glar_t.glar023, 
   glar023_desc LIKE type_t.chr500, 
   glar024 LIKE glar_t.glar024, 
   glar024_desc LIKE type_t.chr500, 
   glar025 LIKE glar_t.glar025, 
   glar025_desc LIKE type_t.chr500, 
   glar026 LIKE glar_t.glar026, 
   glar026_desc LIKE type_t.chr500, 
   glar027 LIKE glar_t.glar027, 
   glar027_desc LIKE type_t.chr500, 
   glar028 LIKE glar_t.glar028, 
   glar028_desc LIKE type_t.chr500, 
   glar029 LIKE glar_t.glar029, 
   glar029_desc LIKE type_t.chr500, 
   glar030 LIKE glar_t.glar030, 
   glar030_desc LIKE type_t.chr500, 
   glar031 LIKE glar_t.glar031, 
   glar031_desc LIKE type_t.chr500, 
   glar032 LIKE glar_t.glar032, 
   glar032_desc LIKE type_t.chr500, 
   glar033 LIKE glar_t.glar033, 
   glar033_desc LIKE type_t.chr500, 
   amt1 LIKE type_t.num20_6, 
   amt2 LIKE type_t.num20_6, 
   amt3 LIKE type_t.num20_6, 
   amt4 LIKE type_t.num20_6, 
   amt5 LIKE type_t.num20_6, 
   amt6 LIKE type_t.num20_6, 
   amt7 LIKE type_t.num20_6, 
   amt8 LIKE type_t.num20_6, 
   amt9 LIKE type_t.num20_6, 
   amt10 LIKE type_t.num20_6, 
   amt11 LIKE type_t.num20_6, 
   amt12 LIKE type_t.num20_6, 
   sum1 LIKE type_t.num20_6 
       END RECORD
PRIVATE TYPE type_g_glar2_d RECORD
       glar001 LIKE glar_t.glar001, 
   glar001_2_desc LIKE type_t.chr500, 
   glar012 LIKE glar_t.glar012, 
   glar012_2_desc LIKE type_t.chr500, 
   glar013 LIKE glar_t.glar013, 
   glar013_2_desc LIKE type_t.chr500, 
   glar014 LIKE glar_t.glar014, 
   glar014_2_desc LIKE type_t.chr500, 
   glar015 LIKE glar_t.glar015, 
   glar015_2_desc LIKE type_t.chr500, 
   glar016 LIKE glar_t.glar016, 
   glar016_2_desc LIKE type_t.chr500, 
   glar017 LIKE glar_t.glar017, 
   glar017_2_desc LIKE type_t.chr500, 
   glar018 LIKE glar_t.glar018, 
   glar018_2_desc LIKE type_t.chr500, 
   glar019 LIKE glar_t.glar019, 
   glar019_2_desc LIKE type_t.chr500, 
   glar051 LIKE glar_t.glar051, 
   glar052 LIKE glar_t.glar052, 
   glar052_2_desc LIKE type_t.chr500, 
   glar053 LIKE glar_t.glar053, 
   glar053_2_desc LIKE type_t.chr500, 
   glar020 LIKE glar_t.glar020, 
   glar020_2_desc LIKE type_t.chr500, 
   glar022 LIKE glar_t.glar022, 
   glar022_2_desc LIKE type_t.chr500, 
   glar023 LIKE glar_t.glar023, 
   glar023_2_desc LIKE type_t.chr500, 
   glar024 LIKE glar_t.glar024, 
   glar024_2_desc LIKE type_t.chr500, 
   glar025 LIKE glar_t.glar025, 
   glar025_2_desc LIKE type_t.chr500, 
   glar026 LIKE glar_t.glar026, 
   glar026_2_desc LIKE type_t.chr500, 
   glar027 LIKE glar_t.glar027, 
   glar027_2_desc LIKE type_t.chr500, 
   glar028 LIKE glar_t.glar028, 
   glar028_2_desc LIKE type_t.chr500, 
   glar029 LIKE glar_t.glar029, 
   glar029_2_desc LIKE type_t.chr500, 
   glar030 LIKE glar_t.glar030, 
   glar030_2_desc LIKE type_t.chr500, 
   glar031 LIKE glar_t.glar031, 
   glar031_2_desc LIKE type_t.chr500, 
   glar032 LIKE glar_t.glar032, 
   glar032_2_desc LIKE type_t.chr500, 
   glar033 LIKE glar_t.glar033, 
   glar033_2_desc LIKE type_t.chr500, 
   amt201 LIKE type_t.num20_6, 
   amt202 LIKE type_t.num20_6, 
   amt203 LIKE type_t.num20_6, 
   amt204 LIKE type_t.num20_6, 
   amt205 LIKE type_t.num20_6, 
   amt206 LIKE type_t.num20_6, 
   amt207 LIKE type_t.num20_6, 
   amt208 LIKE type_t.num20_6, 
   amt209 LIKE type_t.num20_6, 
   amt210 LIKE type_t.num20_6, 
   amt211 LIKE type_t.num20_6, 
   amt212 LIKE type_t.num20_6, 
   sum2 LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_glar3_d RECORD
       glar001 LIKE glar_t.glar001, 
   glar001_3_desc LIKE type_t.chr500, 
   glar012 LIKE glar_t.glar012, 
   glar012_3_desc LIKE type_t.chr500, 
   glar013 LIKE glar_t.glar013, 
   glar013_3_desc LIKE type_t.chr500, 
   glar014 LIKE glar_t.glar014, 
   glar014_3_desc LIKE type_t.chr500, 
   glar015 LIKE glar_t.glar015, 
   glar015_3_desc LIKE type_t.chr500, 
   glar016 LIKE glar_t.glar016, 
   glar016_3_desc LIKE type_t.chr500, 
   glar017 LIKE glar_t.glar017, 
   glar017_3_desc LIKE type_t.chr500, 
   glar018 LIKE glar_t.glar018, 
   glar018_3_desc LIKE type_t.chr500, 
   glar019 LIKE glar_t.glar019, 
   glar019_3_desc LIKE type_t.chr500, 
   glar051 LIKE glar_t.glar051, 
   glar052 LIKE glar_t.glar052, 
   glar052_3_desc LIKE type_t.chr500, 
   glar053 LIKE glar_t.glar053, 
   glar053_3_desc LIKE type_t.chr500, 
   glar020 LIKE glar_t.glar020, 
   glar020_3_desc LIKE type_t.chr500, 
   glar022 LIKE glar_t.glar022, 
   glar022_3_desc LIKE type_t.chr500, 
   glar023 LIKE glar_t.glar023, 
   glar023_3_desc LIKE type_t.chr500, 
   glar024 LIKE glar_t.glar024, 
   glar024_3_desc LIKE type_t.chr500, 
   glar025 LIKE glar_t.glar025, 
   glar025_3_desc LIKE type_t.chr500, 
   glar026 LIKE glar_t.glar026, 
   glar026_3_desc LIKE type_t.chr500, 
   glar027 LIKE glar_t.glar027, 
   glar027_3_desc LIKE type_t.chr500, 
   glar028 LIKE glar_t.glar028, 
   glar028_3_desc LIKE type_t.chr500, 
   glar029 LIKE glar_t.glar029, 
   glar029_3_desc LIKE type_t.chr500, 
   glar030 LIKE glar_t.glar030, 
   glar030_3_desc LIKE type_t.chr500, 
   glar031 LIKE glar_t.glar031, 
   glar031_3_desc LIKE type_t.chr500, 
   glar032 LIKE glar_t.glar032, 
   glar032_3_desc LIKE type_t.chr500, 
   glar033 LIKE glar_t.glar033, 
   glar033_3_desc LIKE type_t.chr500, 
   amt301 LIKE type_t.num20_6, 
   amt302 LIKE type_t.num20_6, 
   amt303 LIKE type_t.num20_6, 
   amt304 LIKE type_t.num20_6, 
   amt305 LIKE type_t.num20_6, 
   amt306 LIKE type_t.num20_6, 
   amt307 LIKE type_t.num20_6, 
   amt308 LIKE type_t.num20_6, 
   amt309 LIKE type_t.num20_6, 
   amt310 LIKE type_t.num20_6, 
   amt311 LIKE type_t.num20_6, 
   amt312 LIKE type_t.num20_6, 
   sum3 LIKE type_t.num20_6
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_bookno        LIKE glap_t.glapld
DEFINE g_glaa002       LIKE glaa_t.glaa002
DEFINE g_glaa003       LIKE glaa_t.glaa003
DEFINE g_glaa004       LIKE glaa_t.glaa004
DEFINE g_glaa013       LIKE glaa_t.glaa013
DEFINE g_glaa015       LIKE glaa_t.glaa015
DEFINE g_glaa017       LIKE glaa_t.glaa017
DEFINE g_glaa018       LIKE glaa_t.glaa018
DEFINE g_glaa019       LIKE glaa_t.glaa019
DEFINE g_glaa021       LIKE glaa_t.glaa021
DEFINE g_glaa022       LIKE glaa_t.glaa022
#查询条件定义
DEFINE tm              RECORD
       glaald          LIKE glaa_t.glaald,
       glaald_desc     LIKE glaal_t.glaal002,
       glaacomp        LIKE glaa_t.glaacomp,
       glaacomp_desc   LIKE ooefl_t.ooefl003,
       glaa001         LIKE glaa_t.glaa001,
       glaa016         LIKE glaa_t.glaa016,
       glaa020         LIKE glaa_t.glaa020,
       sdate           LIKE glap_t.glapdocdt,  #起始日期
       syear           LIKE glap_t.glap002,    #起始年度
       smonth          LIKE glap_t.glap004,    #起始期別
       edate           LIKE glap_t.glapdocdt,  #截止日期
       eyear           LIKE glap_t.glap002,    #截止年度
       emonth          LIKE glap_t.glap004,    #截止期別
       ctype           LIKE type_t.chr1,       #多本位幣
       kind            LIKE type_t.chr1,       #余额型态
       show_acc        LIKE type_t.chr1,       #显示统治科目
       glac005	        LIKE glac_t.glac005,    #科目层级
       stus            LIKE type_t.chr1,       #凭证状态
       glac009	        LIKE glac_t.glac009,    #是否为内部管理科目
       show_ce         LIKE type_t.chr1,       #含月结凭证
       show_ye         LIKE type_t.chr1,       #含年结凭证
       comp            LIKE type_t.chr1,       #以下核算项显示否
       glad007         LIKE type_t.chr1,
       glad008         LIKE type_t.chr1,
       glad009         LIKE type_t.chr1,
       glad010         LIKE type_t.chr1,
       glad027         LIKE type_t.chr1,
       glad011         LIKE type_t.chr1,
       glad012         LIKE type_t.chr1,
       glad031         LIKE type_t.chr1,
       glad032         LIKE type_t.chr1,
       glad033         LIKE type_t.chr1,
       glad013         LIKE type_t.chr1,
       glad015         LIKE type_t.chr1,
       glad016         LIKE type_t.chr1,
       glad017         LIKE type_t.chr1,
       glad018         LIKE type_t.chr1,
       glad019         LIKE type_t.chr1,
       glad020         LIKE type_t.chr1,
       glad021         LIKE type_t.chr1,
       glad022         LIKE type_t.chr1,
       glad023         LIKE type_t.chr1,
       glad024         LIKE type_t.chr1,
       glad025         LIKE type_t.chr1,
       glad026         LIKE type_t.chr1
       END RECORD  
DEFINE g_wc_glar001    STRING
#多語言SQL
DEFINE g_get_sql       RECORD
       glar012         STRING,  #营运据点
       glar013         STRING,  #部门
       glar014         STRING,  #责任中心
       glar015         STRING,  #区域
       glar016         STRING,  #收付款客商
       glar017         STRING,  #账款客商
       glar018         STRING,  #客群
       glar019         STRING,  #产品类别
       glar020         STRING,  #人员
       glar022         STRING,  #专案编号
       glar023         STRING,  #WBS
       glar052         STRING,  #渠道
       glar053         STRING   #品牌  
                       END RECORD  
DEFINE g_xg_visible    STRING     #XG欄位隱藏條件 
DEFINE g_col_mm        LIKE type_t.num5  #单身显示的期别个数
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glar_d
DEFINE g_master_t                   type_g_glar_d
DEFINE g_glar_d          DYNAMIC ARRAY OF type_g_glar_d
DEFINE g_glar_d_t        type_g_glar_d
DEFINE g_glar2_d   DYNAMIC ARRAY OF type_g_glar2_d
DEFINE g_glar2_d_t type_g_glar2_d
 
DEFINE g_glar3_d   DYNAMIC ARRAY OF type_g_glar3_d
DEFINE g_glar3_d_t type_g_glar3_d
 
 
      
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
 
{<section id="aglq854.main" >}
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
   DECLARE aglq854_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq854_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq854_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq854 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq854_init()   
 
      #進入選單 Menu (="N")
      CALL aglq854_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq854
      
   END IF 
   
   CLOSE aglq854_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq854.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq854_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('stus','9922')
   CALL cl_set_combo_scc_part('kind','9925','1,2')
   
   CALL aglq854_create_temp_table()
   #核算项说明组成SQL
   #营运据点
   CALL s_fin_get_department_sql('ta3','glarent','glar012') RETURNING g_get_sql.glar012
   #部門
   CALL s_fin_get_department_sql('ta4','glarent','glar013') RETURNING g_get_sql.glar013
   #利润成本中心
   CALL s_fin_get_department_sql('ta5','glarent','glar014') RETURNING g_get_sql.glar014
   #区域
   CALL s_fin_get_acc_sql('ta6','glarent','287','glar015') RETURNING g_get_sql.glar015
   #收付款客商
   CALL s_fin_get_trading_partner_abbr_sql('ta7','glarent','glar016') RETURNING g_get_sql.glar016
   #账款客商
   CALL s_fin_get_trading_partner_abbr_sql('ta8','glarent','glar017') RETURNING g_get_sql.glar017
   #客群
   CALL s_fin_get_acc_sql('ta9','glarent','281','glar018') RETURNING g_get_sql.glar018
   #产品类别
   CALL s_fin_get_rtaxl003_sql('ta10','glarent','glar019') RETURNING g_get_sql.glar019
   #人员
   CALL s_fin_get_person_sql('ta11','glarent','glar020') RETURNING g_get_sql.glar020
   #专案
   CALL s_fin_get_project_sql('ta12','glarent','glar022') RETURNING g_get_sql.glar022
   #WBS
   CALL s_fin_get_wbs_sql('ta13','glarent','glar022','glar023') RETURNING g_get_sql.glar023
   #渠道
   CALL s_fin_get_oojdl003_sql('ta14','glarent','glar052') RETURNING g_get_sql.glar052
   #品牌
   CALL s_fin_get_acc_sql('ta15','glarent','2002','glar053') RETURNING g_get_sql.glar053
   #end add-point
 
   CALL aglq854_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aglq854.default_search" >}
PRIVATE FUNCTION aglq854_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glarld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " glar001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " glar002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " glar003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " glar004 = '", g_argv[05], "' AND "
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
 
{<section id="aglq854.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq854_ui_dialog()
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
   
   #end add-point 
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
         
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL aglq854_b_fill()
   ELSE
      CALL aglq854_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glar_d.clear()
         CALL g_glar2_d.clear()
 
         CALL g_glar3_d.clear()
 
 
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
 
         CALL aglq854_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glar_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq854_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq854_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
         DISPLAY ARRAY g_glar2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_glar2_d.getLength() TO FORMONLY.h_count
               CALL aglq854_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point  
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_glar3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_glar3_d.getLength() TO FORMONLY.h_count
               CALL aglq854_fetch()
               LET g_master_idx = l_ac
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
            CALL aglq854_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aglq854_output()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aglq854_output()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglq854_query()
               #add-point:ON ACTION query name="menu.query"
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
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
            CALL aglq854_filter()
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
            CALL aglq854_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glar_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_glar2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_glar3_d)
               LET g_export_id[3]   = "s_detail3"
 
 
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
            CALL aglq854_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq854_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq854_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq854_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glar_d.getLength()
               LET g_glar_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glar_d.getLength()
               LET g_glar_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glar_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glar_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glar_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glar_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         
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
 
{<section id="aglq854.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq854_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
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
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_str           STRING
   DEFINE l_str2          STRING
   DEFINE l_str3          STRING
   DEFINE l_i             LIKE type_t.num5
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   IF cl_null(tm.glaald) THEN
      CALL aglq854_default()
   END IF 
   LET l_str = NULL
   LET l_str2 = NULL
   LET l_str3 = NULL
   FOR l_i = 1 TO 12
      IF cl_null(l_str) THEN 
         LET l_str = l_str,"amt",l_i USING '<<<' CLIPPED
      ELSE
         LET l_str = l_str,",amt",l_i USING '<<<' CLIPPED       
      END IF
      IF cl_null(l_str2) THEN 
         LET l_str2 = l_str2,"amt",l_i + 200 USING '<<<' CLIPPED
      ELSE
         LET l_str2 = l_str2,",amt",l_i + 200 USING '<<<' CLIPPED       
      END IF
      IF cl_null(l_str3) THEN 
         LET l_str3 = l_str3,"amt",l_i + 300 USING '<<<' CLIPPED
      ELSE
         LET l_str3 = l_str3,",amt",l_i + 300 USING '<<<' CLIPPED       
      END IF
   END FOR
   CALL cl_set_comp_visible(l_str,FALSE)
   CALL cl_set_comp_visible(l_str2,FALSE)
   CALL cl_set_comp_visible(l_str3,FALSE)
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glar_d.clear()
   CALL g_glar2_d.clear()
 
   CALL g_glar3_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON glar012,glar013,glar014,glar015,glar016,glar017,glar018,glar019,glar051, 
          glar052,glar053,glar020,glar022,glar023,glar024,glar025,glar026,glar027,glar028,glar029,glar030, 
          glar031,glar032,glar033
           FROM s_detail1[1].b_glar012,s_detail1[1].b_glar013,s_detail1[1].b_glar014,s_detail1[1].b_glar015, 
               s_detail1[1].b_glar016,s_detail1[1].b_glar017,s_detail1[1].b_glar018,s_detail1[1].b_glar019, 
               s_detail1[1].b_glar051,s_detail1[1].b_glar052,s_detail1[1].b_glar053,s_detail1[1].b_glar020, 
               s_detail1[1].b_glar022,s_detail1[1].b_glar023,s_detail1[1].b_glar024,s_detail1[1].b_glar025, 
               s_detail1[1].b_glar026,s_detail1[1].b_glar027,s_detail1[1].b_glar028,s_detail1[1].b_glar029, 
               s_detail1[1].b_glar030,s_detail1[1].b_glar031,s_detail1[1].b_glar032,s_detail1[1].b_glar033 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_glar001>>----
         #----<<glar001_desc>>----
         #----<<b_glar012>>----
         #Ctrlp:construct.c.page1.b_glar012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar012
            #add-point:ON ACTION controlp INFIELD b_glar012 name="construct.c.page1.b_glar012"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef201 = 'Y' "   #161021-00037#2 add
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar012  #顯示到畫面上
            NEXT FIELD b_glar012                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar012
            #add-point:BEFORE FIELD b_glar012 name="construct.b.page1.b_glar012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar012
            
            #add-point:AFTER FIELD b_glar012 name="construct.a.page1.b_glar012"
            
            #END add-point
            
 
 
         #----<<b_glar012_desc>>----
         #----<<b_glar013>>----
         #Ctrlp:construct.c.page1.b_glar013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar013
            #add-point:ON ACTION controlp INFIELD b_glar013 name="construct.c.page1.b_glar013"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y'"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar013  #顯示到畫面上
            NEXT FIELD b_glar013                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar013
            #add-point:BEFORE FIELD b_glar013 name="construct.b.page1.b_glar013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar013
            
            #add-point:AFTER FIELD b_glar013 name="construct.a.page1.b_glar013"
            
            #END add-point
            
 
 
         #----<<b_glar013_desc>>----
         #----<<b_glar014>>----
         #Ctrlp:construct.c.page1.b_glar014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar014
            #add-point:ON ACTION controlp INFIELD b_glar014 name="construct.c.page1.b_glar014"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar014  #顯示到畫面上
            NEXT FIELD b_glar014                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar014
            #add-point:BEFORE FIELD b_glar014 name="construct.b.page1.b_glar014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar014
            
            #add-point:AFTER FIELD b_glar014 name="construct.a.page1.b_glar014"
            
            #END add-point
            
 
 
         #----<<b_glar014_desc>>----
         #----<<b_glar015>>----
         #Ctrlp:construct.c.page1.b_glar015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar015
            #add-point:ON ACTION controlp INFIELD b_glar015 name="construct.c.page1.b_glar015"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar015  #顯示到畫面上
            NEXT FIELD b_glar015                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar015
            #add-point:BEFORE FIELD b_glar015 name="construct.b.page1.b_glar015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar015
            
            #add-point:AFTER FIELD b_glar015 name="construct.a.page1.b_glar015"
            
            #END add-point
            
 
 
         #----<<b_glar015_desc>>----
         #----<<b_glar016>>----
         #Ctrlp:construct.c.page1.b_glar016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar016
            #add-point:ON ACTION controlp INFIELD b_glar016 name="construct.c.page1.b_glar016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar016  #顯示到畫面上
            NEXT FIELD b_glar016                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar016
            #add-point:BEFORE FIELD b_glar016 name="construct.b.page1.b_glar016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar016
            
            #add-point:AFTER FIELD b_glar016 name="construct.a.page1.b_glar016"
            
            #END add-point
            
 
 
         #----<<b_glar016_desc>>----
         #----<<b_glar017>>----
         #Ctrlp:construct.c.page1.b_glar017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar017
            #add-point:ON ACTION controlp INFIELD b_glar017 name="construct.c.page1.b_glar017"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar017  #顯示到畫面上
            NEXT FIELD b_glar017                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar017
            #add-point:BEFORE FIELD b_glar017 name="construct.b.page1.b_glar017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar017
            
            #add-point:AFTER FIELD b_glar017 name="construct.a.page1.b_glar017"
            
            #END add-point
            
 
 
         #----<<b_glar017_desc>>----
         #----<<b_glar018>>----
         #Ctrlp:construct.c.page1.b_glar018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar018
            #add-point:ON ACTION controlp INFIELD b_glar018 name="construct.c.page1.b_glar018"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar018  #顯示到畫面上
            NEXT FIELD b_glar018                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar018
            #add-point:BEFORE FIELD b_glar018 name="construct.b.page1.b_glar018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar018
            
            #add-point:AFTER FIELD b_glar018 name="construct.a.page1.b_glar018"
            
            #END add-point
            
 
 
         #----<<b_glar018_desc>>----
         #----<<b_glar019>>----
         #Ctrlp:construct.c.page1.b_glar019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar019
            #add-point:ON ACTION controlp INFIELD b_glar019 name="construct.c.page1.b_glar019"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar019  #顯示到畫面上
            NEXT FIELD b_glar019                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar019
            #add-point:BEFORE FIELD b_glar019 name="construct.b.page1.b_glar019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar019
            
            #add-point:AFTER FIELD b_glar019 name="construct.a.page1.b_glar019"
            
            #END add-point
            
 
 
         #----<<b_glar019_desc>>----
         #----<<b_glar051>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar051
            #add-point:BEFORE FIELD b_glar051 name="construct.b.page1.b_glar051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar051
            
            #add-point:AFTER FIELD b_glar051 name="construct.a.page1.b_glar051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glar051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar051
            #add-point:ON ACTION controlp INFIELD b_glar051 name="construct.c.page1.b_glar051"
            
            #END add-point
 
 
         #----<<b_glar052>>----
         #Ctrlp:construct.c.page1.b_glar052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar052
            #add-point:ON ACTION controlp INFIELD b_glar052 name="construct.c.page1.b_glar052"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oojdstus='Y' "
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar052  #顯示到畫面上
            NEXT FIELD b_glar052                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar052
            #add-point:BEFORE FIELD b_glar052 name="construct.b.page1.b_glar052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar052
            
            #add-point:AFTER FIELD b_glar052 name="construct.a.page1.b_glar052"
            
            #END add-point
            
 
 
         #----<<b_glar052_desc>>----
         #----<<b_glar053>>----
         #Ctrlp:construct.c.page1.b_glar053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar053
            #add-point:ON ACTION controlp INFIELD b_glar053 name="construct.c.page1.b_glar053"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar053  #顯示到畫面上
            NEXT FIELD b_glar053                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar053
            #add-point:BEFORE FIELD b_glar053 name="construct.b.page1.b_glar053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar053
            
            #add-point:AFTER FIELD b_glar053 name="construct.a.page1.b_glar053"
            
            #END add-point
            
 
 
         #----<<b_glar053_desc>>----
         #----<<b_glar020>>----
         #Ctrlp:construct.c.page1.b_glar020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar020
            #add-point:ON ACTION controlp INFIELD b_glar020 name="construct.c.page1.b_glar020"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar020  #顯示到畫面上
            NEXT FIELD b_glar020                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar020
            #add-point:BEFORE FIELD b_glar020 name="construct.b.page1.b_glar020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar020
            
            #add-point:AFTER FIELD b_glar020 name="construct.a.page1.b_glar020"
            
            #END add-point
            
 
 
         #----<<b_glar020_desc>>----
         #----<<b_glar022>>----
         #Ctrlp:construct.c.page1.b_glar022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar022
            #add-point:ON ACTION controlp INFIELD b_glar022 name="construct.c.page1.b_glar022"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar022  #顯示到畫面上
            NEXT FIELD b_glar022                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar022
            #add-point:BEFORE FIELD b_glar022 name="construct.b.page1.b_glar022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar022
            
            #add-point:AFTER FIELD b_glar022 name="construct.a.page1.b_glar022"
            
            #END add-point
            
 
 
         #----<<b_glar022_desc>>----
         #----<<b_glar023>>----
         #Ctrlp:construct.c.page1.b_glar023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar023
            #add-point:ON ACTION controlp INFIELD b_glar023 name="construct.c.page1.b_glar023"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pjbb012 ='1'"
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar023  #顯示到畫面上
            NEXT FIELD b_glar023                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar023
            #add-point:BEFORE FIELD b_glar023 name="construct.b.page1.b_glar023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar023
            
            #add-point:AFTER FIELD b_glar023 name="construct.a.page1.b_glar023"
            
            #END add-point
            
 
 
         #----<<b_glar023_desc>>----
         #----<<b_glar024>>----
         #Ctrlp:construct.c.page1.b_glar024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar024
            #add-point:ON ACTION controlp INFIELD b_glar024 name="construct.c.page1.b_glar024"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar024()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar024  #顯示到畫面上
            NEXT FIELD b_glar024                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar024
            #add-point:BEFORE FIELD b_glar024 name="construct.b.page1.b_glar024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar024
            
            #add-point:AFTER FIELD b_glar024 name="construct.a.page1.b_glar024"
            
            #END add-point
            
 
 
         #----<<b_glar024_desc>>----
         #----<<b_glar025>>----
         #Ctrlp:construct.c.page1.b_glar025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar025
            #add-point:ON ACTION controlp INFIELD b_glar025 name="construct.c.page1.b_glar025"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar025()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar025  #顯示到畫面上
            NEXT FIELD b_glar025                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar025
            #add-point:BEFORE FIELD b_glar025 name="construct.b.page1.b_glar025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar025
            
            #add-point:AFTER FIELD b_glar025 name="construct.a.page1.b_glar025"
            
            #END add-point
            
 
 
         #----<<b_glar025_desc>>----
         #----<<b_glar026>>----
         #Ctrlp:construct.c.page1.b_glar026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar026
            #add-point:ON ACTION controlp INFIELD b_glar026 name="construct.c.page1.b_glar026"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar026()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar026  #顯示到畫面上
            NEXT FIELD b_glar026                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar026
            #add-point:BEFORE FIELD b_glar026 name="construct.b.page1.b_glar026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar026
            
            #add-point:AFTER FIELD b_glar026 name="construct.a.page1.b_glar026"
            
            #END add-point
            
 
 
         #----<<b_glar026_desc>>----
         #----<<b_glar027>>----
         #Ctrlp:construct.c.page1.b_glar027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar027
            #add-point:ON ACTION controlp INFIELD b_glar027 name="construct.c.page1.b_glar027"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar027()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar027  #顯示到畫面上
            NEXT FIELD b_glar027                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar027
            #add-point:BEFORE FIELD b_glar027 name="construct.b.page1.b_glar027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar027
            
            #add-point:AFTER FIELD b_glar027 name="construct.a.page1.b_glar027"
            
            #END add-point
            
 
 
         #----<<b_glar027_desc>>----
         #----<<b_glar028>>----
         #Ctrlp:construct.c.page1.b_glar028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar028
            #add-point:ON ACTION controlp INFIELD b_glar028 name="construct.c.page1.b_glar028"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar028()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar028  #顯示到畫面上
            NEXT FIELD b_glar028                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar028
            #add-point:BEFORE FIELD b_glar028 name="construct.b.page1.b_glar028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar028
            
            #add-point:AFTER FIELD b_glar028 name="construct.a.page1.b_glar028"
            
            #END add-point
            
 
 
         #----<<b_glar028_desc>>----
         #----<<b_glar029>>----
         #Ctrlp:construct.c.page1.b_glar029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar029
            #add-point:ON ACTION controlp INFIELD b_glar029 name="construct.c.page1.b_glar029"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar029()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar029  #顯示到畫面上
            NEXT FIELD b_glar029                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar029
            #add-point:BEFORE FIELD b_glar029 name="construct.b.page1.b_glar029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar029
            
            #add-point:AFTER FIELD b_glar029 name="construct.a.page1.b_glar029"
            
            #END add-point
            
 
 
         #----<<b_glar029_desc>>----
         #----<<b_glar030>>----
         #Ctrlp:construct.c.page1.b_glar030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar030
            #add-point:ON ACTION controlp INFIELD b_glar030 name="construct.c.page1.b_glar030"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar030()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar030  #顯示到畫面上
            NEXT FIELD b_glar030                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar030
            #add-point:BEFORE FIELD b_glar030 name="construct.b.page1.b_glar030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar030
            
            #add-point:AFTER FIELD b_glar030 name="construct.a.page1.b_glar030"
            
            #END add-point
            
 
 
         #----<<b_glar030_desc>>----
         #----<<b_glar031>>----
         #Ctrlp:construct.c.page1.b_glar031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar031
            #add-point:ON ACTION controlp INFIELD b_glar031 name="construct.c.page1.b_glar031"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar031()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar031  #顯示到畫面上
            NEXT FIELD b_glar031                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar031
            #add-point:BEFORE FIELD b_glar031 name="construct.b.page1.b_glar031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar031
            
            #add-point:AFTER FIELD b_glar031 name="construct.a.page1.b_glar031"
            
            #END add-point
            
 
 
         #----<<b_glar031_desc>>----
         #----<<b_glar032>>----
         #Ctrlp:construct.c.page1.b_glar032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar032
            #add-point:ON ACTION controlp INFIELD b_glar032 name="construct.c.page1.b_glar032"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar032()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar032  #顯示到畫面上
            NEXT FIELD b_glar032                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar032
            #add-point:BEFORE FIELD b_glar032 name="construct.b.page1.b_glar032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar032
            
            #add-point:AFTER FIELD b_glar032 name="construct.a.page1.b_glar032"
            
            #END add-point
            
 
 
         #----<<b_glar032_desc>>----
         #----<<b_glar033>>----
         #Ctrlp:construct.c.page1.b_glar033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar033
            #add-point:ON ACTION controlp INFIELD b_glar033 name="construct.c.page1.b_glar033"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar033()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar033  #顯示到畫面上
            NEXT FIELD b_glar033                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar033
            #add-point:BEFORE FIELD b_glar033 name="construct.b.page1.b_glar033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar033
            
            #add-point:AFTER FIELD b_glar033 name="construct.a.page1.b_glar033"
            
            #END add-point
            
 
 
         #----<<b_glar033_desc>>----
         #----<<amt1>>----
         #----<<amt2>>----
         #----<<amt3>>----
         #----<<amt4>>----
         #----<<amt5>>----
         #----<<amt6>>----
         #----<<amt7>>----
         #----<<amt8>>----
         #----<<amt9>>----
         #----<<amt10>>----
         #----<<amt11>>----
         #----<<amt12>>----
         #----<<sum1>>----
         #----<<glar001_2_desc>>----
         #----<<glar012_2_desc>>----
         #----<<glar013_2_desc>>----
         #----<<glar014_2_desc>>----
         #----<<glar015_2_desc>>----
         #----<<glar016_2_desc>>----
         #----<<glar017_2_desc>>----
         #----<<glar018_2_desc>>----
         #----<<glar019_2_desc>>----
         #----<<glar052_2_desc>>----
         #----<<glar053_2_desc>>----
         #----<<glar020_2_desc>>----
         #----<<glar022_2_desc>>----
         #----<<glar023_2_desc>>----
         #----<<glar024_2_desc>>----
         #----<<glar025_2_desc>>----
         #----<<glar026_2_desc>>----
         #----<<glar027_2_desc>>----
         #----<<glar028_2_desc>>----
         #----<<glar029_2_desc>>----
         #----<<glar030_2_desc>>----
         #----<<glar031_2_desc>>----
         #----<<glar032_2_desc>>----
         #----<<glar033_2_desc>>----
         #----<<amt201>>----
         #----<<amt202>>----
         #----<<amt203>>----
         #----<<amt204>>----
         #----<<amt205>>----
         #----<<amt206>>----
         #----<<amt207>>----
         #----<<amt208>>----
         #----<<amt209>>----
         #----<<amt210>>----
         #----<<amt211>>----
         #----<<amt212>>----
         #----<<sum2>>----
         #----<<glar001_3_desc>>----
         #----<<glar012_3_desc>>----
         #----<<glar013_3_desc>>----
         #----<<glar014_3_desc>>----
         #----<<glar015_3_desc>>----
         #----<<glar016_3_desc>>----
         #----<<glar017_3_desc>>----
         #----<<glar018_3_desc>>----
         #----<<glar019_3_desc>>----
         #----<<glar052_3_desc>>----
         #----<<glar053_3_desc>>----
         #----<<glar020_3_desc>>----
         #----<<glar022_3_desc>>----
         #----<<glar023_3_desc>>----
         #----<<glar024_3_desc>>----
         #----<<glar025_3_desc>>----
         #----<<glar026_3_desc>>----
         #----<<glar027_3_desc>>----
         #----<<glar028_3_desc>>----
         #----<<glar029_3_desc>>----
         #----<<glar030_3_desc>>----
         #----<<glar031_3_desc>>----
         #----<<glar032_3_desc>>----
         #----<<glar033_3_desc>>----
         #----<<amt301>>----
         #----<<amt302>>----
         #----<<amt303>>----
         #----<<amt304>>----
         #----<<amt305>>----
         #----<<amt306>>----
         #----<<amt307>>----
         #----<<amt308>>----
         #----<<amt309>>----
         #----<<amt310>>----
         #----<<amt311>>----
         #----<<amt312>>----
         #----<<sum3>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      CONSTRUCT g_wc_glar001 ON glar001 FROM glar001
                      
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD glar001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_glaa004) THEN
               LET g_qryparam.where = "glac001 = '",g_glaa004,"'"
            END IF
            CALL aglt310_04()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO glar001
            NEXT FIELD glar001                     #返回原欄位
               
      END CONSTRUCT
      
      INPUT BY NAME tm.glaald,tm.sdate,tm.syear,tm.smonth,tm.edate,tm.eyear,tm.emonth,
                    tm.ctype,tm.kind,tm.show_acc,tm.glac005,tm.stus,
                    tm.glac009,tm.show_ce,tm.show_ye,tm.comp,tm.glad007,tm.glad008,tm.glad009,
                    tm.glad010,tm.glad027,tm.glad011,tm.glad012,tm.glad031,tm.glad032,tm.glad033,
                    tm.glad013,tm.glad015,tm.glad016,tm.glad017,tm.glad018,tm.glad019,tm.glad020,
                    tm.glad021,tm.glad022,tm.glad023,tm.glad024,tm.glad025,tm.glad026
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
         
         AFTER FIELD glaald
            IF cl_null(tm.glaald) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'acr-00015'
               LET g_errparam.extend = tm.glaald
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD CURRENT
            ELSE
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = tm.glaald
               IF NOT cl_chk_exist("v_glaald") THEN
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_ld_chk_authorization(g_user,tm.glaald) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00165'
                  LET g_errparam.extend = tm.glaald
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               CALL aglq854_glaald_desc(tm.glaald)
               DISPLAY tm.glaald_desc,tm.glaacomp,tm.glaacomp_desc,tm.glaa001,tm.glaa016,tm.glaa020
               TO glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020
            END IF
            
         AFTER FIELD sdate
            IF NOT cl_null(tm.sdate) THEN
               CALL s_get_accdate(g_glaa003,tm.sdate,'','')
               RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               IF l_flag='N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD sdate
               END IF
               IF NOT cl_null(tm.edate) THEN
                  IF tm.sdate>tm.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00116'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD sdate
                  END IF
                  LET tm.syear=l_glav002
                  LET tm.smonth=l_glav006
                  DISPLAY tm.syear,tm.smonth TO syear,smonth 
                  IF tm.syear <> tm.eyear THEN
                     LET l_cnt = 0
                     SELECT COUNT(DISTINCT glav002||glav006) INTO l_cnt FROM glav_t
                      WHERE glavent=g_enterprise AND glav001=g_glaa003 
                        AND glav004 BETWEEN tm.sdate AND tm.edate
                     IF l_cnt > 12 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'agl-00482'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                        
                        NEXT FIELD sdate
                     END IF
                  END IF
               END IF
            END IF
            
         AFTER FIELD edate
            IF NOT cl_null(tm.edate) THEN
               CALL s_get_accdate(g_glaa003,tm.edate,'','')
               RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               IF l_flag='N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD edate
               END IF
               IF NOT cl_null(tm.sdate) THEN
                  IF tm.sdate>tm.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00117'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD edate
                  END IF
                  LET tm.eyear=l_glav002
                  LET tm.emonth=l_glav006
                  DISPLAY tm.eyear,tm.emonth TO eyear,emonth 
                  IF tm.syear <> tm.eyear THEN
                     LET l_cnt = 0
                     SELECT COUNT(DISTINCT glav002||glav006) INTO l_cnt FROM glav_t
                      WHERE glavent=g_enterprise AND glav001=g_glaa003 
                        AND glav004 BETWEEN tm.sdate AND tm.edate
                     IF l_cnt > 12 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'agl-00482'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                        
                        NEXT FIELD edate
                     END IF
                  END IF
               END IF
               
            END IF        
            
         ON CHANGE ctype
            IF tm.ctype MATCHES '[0123]' THEN
               CALL aglq854_set_curr_show()
            ELSE
               NEXT FIELD ctype
            END IF
         
         AFTER FIELD kind
            IF tm.kind NOT MATCHES '[12]' THEN
               NEXT FIELD kind
            END IF
               
         AFTER FIELD show_acc
            IF tm.show_acc NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_acc
            END IF
         
         AFTER FIELD glac005
            IF NOT cl_ap_chk_Range(tm.glac005,"1","1","99","1","azz-00087",1) THEN
               NEXT FIELD glac005
            END IF
         
         AFTER FIELD stus
            IF tm.stus NOT MATCHES '[123]' THEN
               NEXT FIELD stus
            END IF
            
         AFTER FIELD glac009
            IF tm.glac009 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glac009
            END IF
            
         AFTER FIELD show_ce
            IF tm.show_ce NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ce
            END IF
         
         AFTER FIELD show_ye
            IF tm.show_ye NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ye
            END IF
         
         ON CHANGE comp
            IF tm.comp NOT MATCHES '[yYnN]' THEN
               NEXT FIELD comp
            END IF
            IF tm.comp='Y' THEN
               CALL cl_set_comp_visible("b_glar012,b_glar012_desc,glar012_2,glar012_2_desc,glar012_3,glar012_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar012,b_glar012_desc,glar012_2,glar012_2_desc,glar012_3,glar012_3_desc",FALSE)
            END IF
            
         ON CHANGE glad007
            IF tm.glad007 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad007
            END IF
            IF tm.glad007='Y' THEN
               CALL cl_set_comp_visible("b_glar013,b_glar013_desc,glar013_2,glar013_2_desc,glar013_3,glar013_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar013,b_glar013_desc,glar013_2,glar013_2_desc,glar013_3,glar013_3_desc",FALSE)
            END IF
            
         ON CHANGE glad008
            IF tm.glad008 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad008
            END IF
            IF tm.glad008='Y' THEN
               CALL cl_set_comp_visible("b_glar014,b_glar014_desc,glar014_2,glar014_2_desc,glar014_3,glar014_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar014,b_glar014_desc,glar014_2,glar014_2_desc,glar014_3,glar014_3_desc",FALSE)
            END IF
            
         ON CHANGE glad009
            IF tm.glad009 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad009
            END IF
            IF tm.glad009='Y' THEN
               CALL cl_set_comp_visible("b_glar015,b_glar015_desc,glar015_2,glar015_2_desc,glar015_3,glar015_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar015,b_glar015_desc,glar015_2,glar015_2_desc,glar015_3,glar015_3_desc",FALSE)
            END IF
         
         ON CHANGE glad010
            IF tm.glad010 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad010
            END IF
            IF tm.glad010='Y' THEN
               CALL cl_set_comp_visible("b_glar016,b_glar016_desc,glar016_2,glar016_2_desc,glar016_3,glar016_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar016,b_glar016_desc,glar016_2,glar016_2_desc,glar016_3,glar016_3_desc",FALSE)
            END IF
            
         ON CHANGE glad027
            IF tm.glad027 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad027
            END IF
            IF tm.glad027='Y' THEN
               CALL cl_set_comp_visible("b_glar017,b_glar017_desc,glar017_2,glar017_2_desc,glar017_3,glar017_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar017,b_glar017_desc,glar017_2,glar017_2_desc,glar017_3,glar017_3_desc",FALSE)
            END IF
            
         ON CHANGE glad011
            IF tm.glad011 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad011
            END IF
            IF tm.glad011='Y' THEN
               CALL cl_set_comp_visible("b_glar018,b_glar018_desc,glar018_2,glar018_2_desc,glar018_3,glar018_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar018,b_glar018_desc,glar018_2,glar018_2_desc,glar018_3,glar018_3_desc",FALSE)
            END IF
            
         ON CHANGE glad012
            IF tm.glad012 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad012
            END IF
            IF tm.glad012='Y' THEN
               CALL cl_set_comp_visible("b_glar019,b_glar019_desc,glar019_2,glar019_2_desc,glar019_3,glar019_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar019,b_glar019_desc,glar019_2,glar019_2_desc,glar019_3,glar019_3_desc",FALSE)
            END IF
         
         #經營方式
         ON CHANGE glad031
            IF tm.glad031 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad031
            END IF
            IF tm.glad031='Y' THEN
               CALL cl_set_comp_visible("b_glar051,glar051_2,glar051_3",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar051,glar051_2,glar051_3",FALSE)
            END IF
            
         #渠道
         ON CHANGE glad032
            IF tm.glad032 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad032
            END IF
            IF tm.glad032='Y' THEN
               CALL cl_set_comp_visible("b_glar052,b_glar052_desc,glar052_2,glar052_2_desc,glar052_3,glar052_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar052,b_glar052_desc,glar052_2,glar052_2_desc,glar052_3,glar052_3_desc",FALSE)
            END IF
            
         #品牌
         ON CHANGE glad033
            IF tm.glad033 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad033
            END IF
            IF tm.glad033='Y' THEN
               CALL cl_set_comp_visible("b_glar053,b_glar053_desc,glar053_2,glar053_2_desc,glar053_3,glar053_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar053,b_glar053_desc,glar053_2,glar053_2_desc,glar053_3,glar053_3_desc",FALSE)
            END IF
            
         ON CHANGE glad013
            IF tm.glad013 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad013
            END IF
            IF tm.glad013='Y' THEN
               CALL cl_set_comp_visible("b_glar020,b_glar020_desc,glar020_2,glar020_2_desc,glar020_3,glar020_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar020,b_glar020_desc,glar020_2,glar020_2_desc,glar020_3,glar020_3_desc",FALSE)
            END IF 

         ON CHANGE glad015
            IF tm.glad015 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad015
            END IF
            IF tm.glad015='Y' THEN
               CALL cl_set_comp_visible("b_glar022,b_glar022_desc,glar022_2,glar022_2_desc,glar022_3,glar022_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar022,b_glar022_desc,glar022_2,glar022_2_desc,glar022_3,glar022_3_desc",FALSE)
            END IF
            
         ON CHANGE glad016
            IF tm.glad016 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad016
            END IF
            IF tm.glad016='Y' THEN
               CALL cl_set_comp_visible("b_glar023,b_glar023_desc,glar023_2,glar023_2_desc,glar023_3,glar023_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar023,b_glar023_desc,glar023_2,glar023_2_desc,glar023_3,glar023_3_desc",FALSE)
            END IF
            
         ON CHANGE glad017
            IF tm.glad017 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad017
            END IF
            IF tm.glad017='Y' THEN
               CALL cl_set_comp_visible("b_glar024,b_glar024_desc,glar024_2,glar024_2_desc,glar024_3,glar024_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar024,b_glar024_desc,glar024_2,glar024_2_desc,glar024_3,glar024_3_desc",FALSE)
            END IF
            
         ON CHANGE glad018
            IF tm.glad018 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad018
            END IF
            IF tm.glad018='Y' THEN
               CALL cl_set_comp_visible("b_glar025,b_glar025_desc,glar025_2,glar025_2_desc,glar025_3,glar025_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar025,b_glar025_desc,glar025_2,glar025_2_desc,glar025_3,glar025_3_desc",FALSE)
            END IF
            
         ON CHANGE glad019
            IF tm.glad019 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad019
            END IF
            IF tm.glad019='Y' THEN
               CALL cl_set_comp_visible("b_glar026,b_glar026_desc,glar026_2,glar026_2_desc,glar026_3,glar026_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar026,b_glar026_desc,glar026_2,glar026_2_desc,glar026_3,glar026_3_desc",FALSE)
            END IF
            
         ON CHANGE glad020
            IF tm.glad020 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad020
            END IF
            IF tm.glad020='Y' THEN
               CALL cl_set_comp_visible("b_glar027,b_glar027_desc,glar027_2,glar027_2_desc,glar027_3,glar027_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar027,b_glar027_desc,glar027_2,glar027_2_desc,glar027_3,glar027_3_desc",FALSE)
            END IF
            
         ON CHANGE glad021
            IF tm.glad021 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad021
            END IF
            IF tm.glad021='Y' THEN
               CALL cl_set_comp_visible("b_glar028,b_glar028_desc,glar028_2,glar028_2_desc,glar028_3,glar028_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar028,b_glar028_desc,glar028_2,glar028_2_desc,glar028_3,glar028_3_desc",FALSE)
            END IF
            
         ON CHANGE glad022
            IF tm.glad022 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad022
            END IF
            IF tm.glad022='Y' THEN
               CALL cl_set_comp_visible("b_glar029,b_glar029_desc,glar029_2,glar029_2_desc,glar029_3,glar029_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar029,b_glar029_desc,glar029_2,glar029_2_desc,glar029_3,glar029_3_desc",FALSE)
            END IF
            
         ON CHANGE glad023
            IF tm.glad023 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad023
            END IF
            IF tm.glad023='Y' THEN
               CALL cl_set_comp_visible("b_glar030,b_glar030_desc,glar030_2,glar030_2_desc,glar030_3,glar030_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar030,b_glar030_desc,glar030_2,glar030_2_desc,glar030_3,glar030_3_desc",FALSE)
            END IF
            
         ON CHANGE glad024
            IF tm.glad024 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad024
            END IF
            IF tm.glad024='Y' THEN
               CALL cl_set_comp_visible("b_glar031,b_glar031_desc,glar031_2,glar031_2_desc,glar031_3,glar031_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar031,b_glar031_desc,glar031_2,glar031_2_desc,glar031_3,glar031_3_desc",FALSE)
            END IF
            
         ON CHANGE glad025
            IF tm.glad025 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad025
            END IF
            IF tm.glad025='Y' THEN
               CALL cl_set_comp_visible("b_glar032,b_glar032_desc,glar032_2,glar032_2_desc,glar032_3,glar032_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar032,b_glar032_desc,glar032_2,glar032_2_desc,glar032_3,glar032_3_desc",FALSE)
            END IF
            
         ON CHANGE glad026
            IF tm.glad026 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad026
            END IF
            IF tm.glad026='Y' THEN
               CALL cl_set_comp_visible("b_glar033,b_glar033_desc,glar033_2,glar033_2_desc,glar033_3,glar033_3_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar033,b_glar033_desc,glar033_2,glar033_2_desc,glar033_3,glar033_3_desc",FALSE)
            END IF
         
         ON ACTION controlp INFIELD glaald
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = tm.glaald
            LET g_qryparam.arg1 = g_user 
            LET g_qryparam.arg2 = g_dept 
            CALL q_authorised_ld() 
            LET tm.glaald = g_qryparam.return1     
            DISPLAY tm.glaald TO glaald
            CALL aglq854_glaald_desc(tm.glaald)
            DISPLAY tm.glaald_desc,tm.glaacomp,tm.glaacomp_desc,tm.glaa001,tm.glaa016,tm.glaa020
            TO glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020
            NEXT FIELD glaald   
            
         AFTER INPUT 
            
      END INPUT
      
      BEFORE DIALOG
         #預設
         CALL cl_set_comp_visible('group_4',TRUE)
         DISPLAY tm.glaald,tm.glaald_desc,tm.glaacomp,tm.glaacomp_desc,tm.glaa001,tm.glaa016,tm.glaa020,
                 tm.sdate,tm.syear,tm.smonth,tm.edate,tm.eyear,tm.emonth,tm.ctype,tm.kind,
                 tm.show_acc,tm.glac005,tm.stus,tm.glac009,tm.show_ce,tm.show_ye  
         TO glaald,glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020,
            sdate,syear,smonth,edate,eyear,emonth,ctype,kind,
            show_acc,glac005,stus,glac009,show_ce,show_ye       
         NEXT FIELD glaald
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
   IF cl_null(g_wc_glar001) THEN LET g_wc_glar001 = " 1=1" END IF
   CALL cl_set_comp_visible('group_4',FALSE)
   #end add-point
        
   LET g_error_show = 1
   CALL aglq854_b_fill()
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
 
{<section id="aglq854.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq854_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL aglq854_get_data()
   RETURN
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',glar001,'',glar012,'',glar013,'',glar014,'',glar015,'',glar016, 
       '',glar017,'',glar018,'',glar019,'',glar051,glar052,'',glar053,'',glar020,'',glar022,'',glar023, 
       '',glar024,'',glar025,'',glar026,'',glar027,'',glar028,'',glar029,'',glar030,'',glar031,'',glar032, 
       '',glar033,'','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY glar_t.glarld, 
       glar_t.glar001,glar_t.glar002,glar_t.glar003,glar_t.glar004) AS RANK FROM glar_t",
 
 
                     "",
                     " WHERE glarent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glar_t"),
                     " ORDER BY glar_t.glarld,glar_t.glar001,glar_t.glar002,glar_t.glar003,glar_t.glar004"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
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
 
   LET g_sql = "SELECT '',glar001,'',glar012,'',glar013,'',glar014,'',glar015,'',glar016,'',glar017, 
       '',glar018,'',glar019,'',glar051,glar052,'',glar053,'',glar020,'',glar022,'',glar023,'',glar024, 
       '',glar025,'',glar026,'',glar027,'',glar028,'',glar029,'',glar030,'',glar031,'',glar032,'',glar033, 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq854_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq854_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glar_d.clear()
   CALL g_glar2_d.clear()   
 
   CALL g_glar3_d.clear()   
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glar_d[l_ac].sel,g_glar_d[l_ac].glar001,g_glar_d[l_ac].glar001_desc,g_glar_d[l_ac].glar012, 
       g_glar_d[l_ac].glar012_desc,g_glar_d[l_ac].glar013,g_glar_d[l_ac].glar013_desc,g_glar_d[l_ac].glar014, 
       g_glar_d[l_ac].glar014_desc,g_glar_d[l_ac].glar015,g_glar_d[l_ac].glar015_desc,g_glar_d[l_ac].glar016, 
       g_glar_d[l_ac].glar016_desc,g_glar_d[l_ac].glar017,g_glar_d[l_ac].glar017_desc,g_glar_d[l_ac].glar018, 
       g_glar_d[l_ac].glar018_desc,g_glar_d[l_ac].glar019,g_glar_d[l_ac].glar019_desc,g_glar_d[l_ac].glar051, 
       g_glar_d[l_ac].glar052,g_glar_d[l_ac].glar052_desc,g_glar_d[l_ac].glar053,g_glar_d[l_ac].glar053_desc, 
       g_glar_d[l_ac].glar020,g_glar_d[l_ac].glar020_desc,g_glar_d[l_ac].glar022,g_glar_d[l_ac].glar022_desc, 
       g_glar_d[l_ac].glar023,g_glar_d[l_ac].glar023_desc,g_glar_d[l_ac].glar024,g_glar_d[l_ac].glar024_desc, 
       g_glar_d[l_ac].glar025,g_glar_d[l_ac].glar025_desc,g_glar_d[l_ac].glar026,g_glar_d[l_ac].glar026_desc, 
       g_glar_d[l_ac].glar027,g_glar_d[l_ac].glar027_desc,g_glar_d[l_ac].glar028,g_glar_d[l_ac].glar028_desc, 
       g_glar_d[l_ac].glar029,g_glar_d[l_ac].glar029_desc,g_glar_d[l_ac].glar030,g_glar_d[l_ac].glar030_desc, 
       g_glar_d[l_ac].glar031,g_glar_d[l_ac].glar031_desc,g_glar_d[l_ac].glar032,g_glar_d[l_ac].glar032_desc, 
       g_glar_d[l_ac].glar033,g_glar_d[l_ac].glar033_desc,g_glar_d[l_ac].amt1,g_glar_d[l_ac].amt2,g_glar_d[l_ac].amt3, 
       g_glar_d[l_ac].amt4,g_glar_d[l_ac].amt5,g_glar_d[l_ac].amt6,g_glar_d[l_ac].amt7,g_glar_d[l_ac].amt8, 
       g_glar_d[l_ac].amt9,g_glar_d[l_ac].amt10,g_glar_d[l_ac].amt11,g_glar_d[l_ac].amt12,g_glar_d[l_ac].sum1, 
       g_glar2_d[l_ac].glar001,g_glar2_d[l_ac].glar001_2_desc,g_glar2_d[l_ac].glar012,g_glar2_d[l_ac].glar012_2_desc, 
       g_glar2_d[l_ac].glar013,g_glar2_d[l_ac].glar013_2_desc,g_glar2_d[l_ac].glar014,g_glar2_d[l_ac].glar014_2_desc, 
       g_glar2_d[l_ac].glar015,g_glar2_d[l_ac].glar015_2_desc,g_glar2_d[l_ac].glar016,g_glar2_d[l_ac].glar016_2_desc, 
       g_glar2_d[l_ac].glar017,g_glar2_d[l_ac].glar017_2_desc,g_glar2_d[l_ac].glar018,g_glar2_d[l_ac].glar018_2_desc, 
       g_glar2_d[l_ac].glar019,g_glar2_d[l_ac].glar019_2_desc,g_glar2_d[l_ac].glar051,g_glar2_d[l_ac].glar052, 
       g_glar2_d[l_ac].glar052_2_desc,g_glar2_d[l_ac].glar053,g_glar2_d[l_ac].glar053_2_desc,g_glar2_d[l_ac].glar020, 
       g_glar2_d[l_ac].glar020_2_desc,g_glar2_d[l_ac].glar022,g_glar2_d[l_ac].glar022_2_desc,g_glar2_d[l_ac].glar023, 
       g_glar2_d[l_ac].glar023_2_desc,g_glar2_d[l_ac].glar024,g_glar2_d[l_ac].glar024_2_desc,g_glar2_d[l_ac].glar025, 
       g_glar2_d[l_ac].glar025_2_desc,g_glar2_d[l_ac].glar026,g_glar2_d[l_ac].glar026_2_desc,g_glar2_d[l_ac].glar027, 
       g_glar2_d[l_ac].glar027_2_desc,g_glar2_d[l_ac].glar028,g_glar2_d[l_ac].glar028_2_desc,g_glar2_d[l_ac].glar029, 
       g_glar2_d[l_ac].glar029_2_desc,g_glar2_d[l_ac].glar030,g_glar2_d[l_ac].glar030_2_desc,g_glar2_d[l_ac].glar031, 
       g_glar2_d[l_ac].glar031_2_desc,g_glar2_d[l_ac].glar032,g_glar2_d[l_ac].glar032_2_desc,g_glar2_d[l_ac].glar033, 
       g_glar2_d[l_ac].glar033_2_desc,g_glar2_d[l_ac].amt201,g_glar2_d[l_ac].amt202,g_glar2_d[l_ac].amt203, 
       g_glar2_d[l_ac].amt204,g_glar2_d[l_ac].amt205,g_glar2_d[l_ac].amt206,g_glar2_d[l_ac].amt207,g_glar2_d[l_ac].amt208, 
       g_glar2_d[l_ac].amt209,g_glar2_d[l_ac].amt210,g_glar2_d[l_ac].amt211,g_glar2_d[l_ac].amt212,g_glar2_d[l_ac].sum2, 
       g_glar3_d[l_ac].glar001,g_glar3_d[l_ac].glar001_3_desc,g_glar3_d[l_ac].glar012,g_glar3_d[l_ac].glar012_3_desc, 
       g_glar3_d[l_ac].glar013,g_glar3_d[l_ac].glar013_3_desc,g_glar3_d[l_ac].glar014,g_glar3_d[l_ac].glar014_3_desc, 
       g_glar3_d[l_ac].glar015,g_glar3_d[l_ac].glar015_3_desc,g_glar3_d[l_ac].glar016,g_glar3_d[l_ac].glar016_3_desc, 
       g_glar3_d[l_ac].glar017,g_glar3_d[l_ac].glar017_3_desc,g_glar3_d[l_ac].glar018,g_glar3_d[l_ac].glar018_3_desc, 
       g_glar3_d[l_ac].glar019,g_glar3_d[l_ac].glar019_3_desc,g_glar3_d[l_ac].glar051,g_glar3_d[l_ac].glar052, 
       g_glar3_d[l_ac].glar052_3_desc,g_glar3_d[l_ac].glar053,g_glar3_d[l_ac].glar053_3_desc,g_glar3_d[l_ac].glar020, 
       g_glar3_d[l_ac].glar020_3_desc,g_glar3_d[l_ac].glar022,g_glar3_d[l_ac].glar022_3_desc,g_glar3_d[l_ac].glar023, 
       g_glar3_d[l_ac].glar023_3_desc,g_glar3_d[l_ac].glar024,g_glar3_d[l_ac].glar024_3_desc,g_glar3_d[l_ac].glar025, 
       g_glar3_d[l_ac].glar025_3_desc,g_glar3_d[l_ac].glar026,g_glar3_d[l_ac].glar026_3_desc,g_glar3_d[l_ac].glar027, 
       g_glar3_d[l_ac].glar027_3_desc,g_glar3_d[l_ac].glar028,g_glar3_d[l_ac].glar028_3_desc,g_glar3_d[l_ac].glar029, 
       g_glar3_d[l_ac].glar029_3_desc,g_glar3_d[l_ac].glar030,g_glar3_d[l_ac].glar030_3_desc,g_glar3_d[l_ac].glar031, 
       g_glar3_d[l_ac].glar031_3_desc,g_glar3_d[l_ac].glar032,g_glar3_d[l_ac].glar032_3_desc,g_glar3_d[l_ac].glar033, 
       g_glar3_d[l_ac].glar033_3_desc,g_glar3_d[l_ac].amt301,g_glar3_d[l_ac].amt302,g_glar3_d[l_ac].amt303, 
       g_glar3_d[l_ac].amt304,g_glar3_d[l_ac].amt305,g_glar3_d[l_ac].amt306,g_glar3_d[l_ac].amt307,g_glar3_d[l_ac].amt308, 
       g_glar3_d[l_ac].amt309,g_glar3_d[l_ac].amt310,g_glar3_d[l_ac].amt311,g_glar3_d[l_ac].amt312,g_glar3_d[l_ac].sum3 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_glar_d[l_ac].statepic = cl_get_actipic(g_glar_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aglq854_detail_show("'1'")      
 
      CALL aglq854_glar_t_mask()
 
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
   
 
   
   CALL g_glar_d.deleteElement(g_glar_d.getLength())   
   CALL g_glar2_d.deleteElement(g_glar2_d.getLength())
 
   CALL g_glar3_d.deleteElement(g_glar3_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_glar_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq854_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq854_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq854_detail_action_trans()
 
   IF g_glar_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq854_fetch()
   END IF
   
      CALL aglq854_filter_show('glar012','b_glar012')
   CALL aglq854_filter_show('glar013','b_glar013')
   CALL aglq854_filter_show('glar014','b_glar014')
   CALL aglq854_filter_show('glar015','b_glar015')
   CALL aglq854_filter_show('glar016','b_glar016')
   CALL aglq854_filter_show('glar017','b_glar017')
   CALL aglq854_filter_show('glar018','b_glar018')
   CALL aglq854_filter_show('glar019','b_glar019')
   CALL aglq854_filter_show('glar051','b_glar051')
   CALL aglq854_filter_show('glar052','b_glar052')
   CALL aglq854_filter_show('glar053','b_glar053')
   CALL aglq854_filter_show('glar020','b_glar020')
   CALL aglq854_filter_show('glar022','b_glar022')
   CALL aglq854_filter_show('glar023','b_glar023')
   CALL aglq854_filter_show('glar024','b_glar024')
   CALL aglq854_filter_show('glar025','b_glar025')
   CALL aglq854_filter_show('glar026','b_glar026')
   CALL aglq854_filter_show('glar027','b_glar027')
   CALL aglq854_filter_show('glar028','b_glar028')
   CALL aglq854_filter_show('glar029','b_glar029')
   CALL aglq854_filter_show('glar030','b_glar030')
   CALL aglq854_filter_show('glar031','b_glar031')
   CALL aglq854_filter_show('glar032','b_glar032')
   CALL aglq854_filter_show('glar033','b_glar033')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq854.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq854_fetch()
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
 
{<section id="aglq854.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq854_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   DEFINE l_glad0171     LIKE glad_t.glad0171
   DEFINE l_glad0181     LIKE glad_t.glad0181
   DEFINE l_glad0191     LIKE glad_t.glad0191
   DEFINE l_glad0201     LIKE glad_t.glad0201
   DEFINE l_glad0211     LIKE glad_t.glad0211
   DEFINE l_glad0221     LIKE glad_t.glad0221
   DEFINE l_glad0231     LIKE glad_t.glad0231
   DEFINE l_glad0241     LIKE glad_t.glad0241
   DEFINE l_glad0251     LIKE glad_t.glad0251
   DEFINE l_glad0261     LIKE glad_t.glad0261
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
      #自由核算項
      SELECT glad0171,glad0181,glad0191,glad0201,glad0211,glad0221,
             glad0231,glad0221,glad0251,glad0261
       INTO  l_glad0171,l_glad0181,l_glad0191,l_glad0201,l_glad0211,l_glad0221,
             l_glad0231,l_glad0241,l_glad0251,l_glad0261
       FROM  glad_t
       WHERE gladent = g_enterprise
         AND gladld = g_glaald
         AND glad001 = g_glar_d[l_ac].glar001
      IF tm.glad017='Y' AND NOT cl_null(g_glar_d[l_ac].glar024) THEN
         CALL s_voucher_free_account_desc(l_glad0171,g_glar_d[l_ac].glar024) RETURNING g_glar_d[l_ac].glar024_desc
      END IF
      IF tm.glad018='Y' AND NOT cl_null(g_glar_d[l_ac].glar025) THEN
         CALL s_voucher_free_account_desc(l_glad0181,g_glar_d[l_ac].glar025) RETURNING g_glar_d[l_ac].glar025_desc
      END IF
      IF tm.glad019='Y' AND NOT cl_null(g_glar_d[l_ac].glar026) THEN
         CALL s_voucher_free_account_desc(l_glad0191,g_glar_d[l_ac].glar026) RETURNING g_glar_d[l_ac].glar026_desc
      END IF
      IF tm.glad020='Y' AND NOT cl_null(g_glar_d[l_ac].glar027) THEN
         CALL s_voucher_free_account_desc(l_glad0201,g_glar_d[l_ac].glar027) RETURNING g_glar_d[l_ac].glar027_desc
      END IF
      IF tm.glad021='Y' AND NOT cl_null(g_glar_d[l_ac].glar028) THEN
         CALL s_voucher_free_account_desc(l_glad0211,g_glar_d[l_ac].glar028) RETURNING g_glar_d[l_ac].glar028_desc
      END IF
      IF tm.glad022='Y' AND NOT cl_null(g_glar_d[l_ac].glar029) THEN
         CALL s_voucher_free_account_desc(l_glad0221,g_glar_d[l_ac].glar029) RETURNING g_glar_d[l_ac].glar029_desc
      END IF
      IF tm.glad023='Y' AND NOT cl_null(g_glar_d[l_ac].glar030) THEN
         CALL s_voucher_free_account_desc(l_glad0231,g_glar_d[l_ac].glar030) RETURNING g_glar_d[l_ac].glar030_desc
      END IF
      IF tm.glad024='Y' AND NOT cl_null(g_glar_d[l_ac].glar031) THEN
         CALL s_voucher_free_account_desc(l_glad0241,g_glar_d[l_ac].glar031) RETURNING g_glar_d[l_ac].glar031_desc
      END IF
      IF tm.glad025='Y' AND NOT cl_null(g_glar_d[l_ac].glar032) THEN
         CALL s_voucher_free_account_desc(l_glad0251,g_glar_d[l_ac].glar032) RETURNING g_glar_d[l_ac].glar032_desc
      END IF
      IF tm.glad026='Y' AND NOT cl_null(g_glar_d[l_ac].glar033) THEN 
         CALL s_voucher_free_account_desc(l_glad0261,g_glar_d[l_ac].glar033) RETURNING g_glar_d[l_ac].glar033_desc
      END IF
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
 
{<section id="aglq854.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq854_filter()
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
      CONSTRUCT g_wc_filter ON glar012,glar013,glar014,glar015,glar016,glar017,glar018,glar019,glar051, 
          glar052,glar053,glar020,glar022,glar023,glar024,glar025,glar026,glar027,glar028,glar029,glar030, 
          glar031,glar032,glar033
                          FROM s_detail1[1].b_glar012,s_detail1[1].b_glar013,s_detail1[1].b_glar014, 
                              s_detail1[1].b_glar015,s_detail1[1].b_glar016,s_detail1[1].b_glar017,s_detail1[1].b_glar018, 
                              s_detail1[1].b_glar019,s_detail1[1].b_glar051,s_detail1[1].b_glar052,s_detail1[1].b_glar053, 
                              s_detail1[1].b_glar020,s_detail1[1].b_glar022,s_detail1[1].b_glar023,s_detail1[1].b_glar024, 
                              s_detail1[1].b_glar025,s_detail1[1].b_glar026,s_detail1[1].b_glar027,s_detail1[1].b_glar028, 
                              s_detail1[1].b_glar029,s_detail1[1].b_glar030,s_detail1[1].b_glar031,s_detail1[1].b_glar032, 
                              s_detail1[1].b_glar033
 
         BEFORE CONSTRUCT
                     DISPLAY aglq854_filter_parser('glar012') TO s_detail1[1].b_glar012
            DISPLAY aglq854_filter_parser('glar013') TO s_detail1[1].b_glar013
            DISPLAY aglq854_filter_parser('glar014') TO s_detail1[1].b_glar014
            DISPLAY aglq854_filter_parser('glar015') TO s_detail1[1].b_glar015
            DISPLAY aglq854_filter_parser('glar016') TO s_detail1[1].b_glar016
            DISPLAY aglq854_filter_parser('glar017') TO s_detail1[1].b_glar017
            DISPLAY aglq854_filter_parser('glar018') TO s_detail1[1].b_glar018
            DISPLAY aglq854_filter_parser('glar019') TO s_detail1[1].b_glar019
            DISPLAY aglq854_filter_parser('glar051') TO s_detail1[1].b_glar051
            DISPLAY aglq854_filter_parser('glar052') TO s_detail1[1].b_glar052
            DISPLAY aglq854_filter_parser('glar053') TO s_detail1[1].b_glar053
            DISPLAY aglq854_filter_parser('glar020') TO s_detail1[1].b_glar020
            DISPLAY aglq854_filter_parser('glar022') TO s_detail1[1].b_glar022
            DISPLAY aglq854_filter_parser('glar023') TO s_detail1[1].b_glar023
            DISPLAY aglq854_filter_parser('glar024') TO s_detail1[1].b_glar024
            DISPLAY aglq854_filter_parser('glar025') TO s_detail1[1].b_glar025
            DISPLAY aglq854_filter_parser('glar026') TO s_detail1[1].b_glar026
            DISPLAY aglq854_filter_parser('glar027') TO s_detail1[1].b_glar027
            DISPLAY aglq854_filter_parser('glar028') TO s_detail1[1].b_glar028
            DISPLAY aglq854_filter_parser('glar029') TO s_detail1[1].b_glar029
            DISPLAY aglq854_filter_parser('glar030') TO s_detail1[1].b_glar030
            DISPLAY aglq854_filter_parser('glar031') TO s_detail1[1].b_glar031
            DISPLAY aglq854_filter_parser('glar032') TO s_detail1[1].b_glar032
            DISPLAY aglq854_filter_parser('glar033') TO s_detail1[1].b_glar033
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_glar001>>----
         #----<<glar001_desc>>----
         #----<<b_glar012>>----
         #Ctrlp:construct.c.page1.b_glar012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar012
            #add-point:ON ACTION controlp INFIELD b_glar012 name="construct.c.filter.page1.b_glar012"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef201 = 'Y' "   #161021-00037#2 add
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar012  #顯示到畫面上
            NEXT FIELD b_glar012                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar012_desc>>----
         #----<<b_glar013>>----
         #Ctrlp:construct.c.page1.b_glar013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar013
            #add-point:ON ACTION controlp INFIELD b_glar013 name="construct.c.filter.page1.b_glar013"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar013  #顯示到畫面上
            NEXT FIELD b_glar013                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar013_desc>>----
         #----<<b_glar014>>----
         #Ctrlp:construct.c.page1.b_glar014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar014
            #add-point:ON ACTION controlp INFIELD b_glar014 name="construct.c.filter.page1.b_glar014"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar014  #顯示到畫面上
            NEXT FIELD b_glar014                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar014_desc>>----
         #----<<b_glar015>>----
         #Ctrlp:construct.c.page1.b_glar015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar015
            #add-point:ON ACTION controlp INFIELD b_glar015 name="construct.c.filter.page1.b_glar015"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar015  #顯示到畫面上
            NEXT FIELD b_glar015                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar015_desc>>----
         #----<<b_glar016>>----
         #Ctrlp:construct.c.page1.b_glar016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar016
            #add-point:ON ACTION controlp INFIELD b_glar016 name="construct.c.filter.page1.b_glar016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar016  #顯示到畫面上
            NEXT FIELD b_glar016                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar016_desc>>----
         #----<<b_glar017>>----
         #Ctrlp:construct.c.page1.b_glar017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar017
            #add-point:ON ACTION controlp INFIELD b_glar017 name="construct.c.filter.page1.b_glar017"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar017  #顯示到畫面上
            NEXT FIELD b_glar017                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar017_desc>>----
         #----<<b_glar018>>----
         #Ctrlp:construct.c.page1.b_glar018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar018
            #add-point:ON ACTION controlp INFIELD b_glar018 name="construct.c.filter.page1.b_glar018"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar018  #顯示到畫面上
            NEXT FIELD b_glar018                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar018_desc>>----
         #----<<b_glar019>>----
         #Ctrlp:construct.c.page1.b_glar019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar019
            #add-point:ON ACTION controlp INFIELD b_glar019 name="construct.c.filter.page1.b_glar019"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar019  #顯示到畫面上
            NEXT FIELD b_glar019                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar019_desc>>----
         #----<<b_glar051>>----
         #Ctrlp:construct.c.filter.page1.b_glar051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar051
            #add-point:ON ACTION controlp INFIELD b_glar051 name="construct.c.filter.page1.b_glar051"
            
            #END add-point
 
 
         #----<<b_glar052>>----
         #Ctrlp:construct.c.page1.b_glar052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar052
            #add-point:ON ACTION controlp INFIELD b_glar052 name="construct.c.filter.page1.b_glar052"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar052  #顯示到畫面上
            NEXT FIELD b_glar052                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar052_desc>>----
         #----<<b_glar053>>----
         #Ctrlp:construct.c.page1.b_glar053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar053
            #add-point:ON ACTION controlp INFIELD b_glar053 name="construct.c.filter.page1.b_glar053"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar053  #顯示到畫面上
            NEXT FIELD b_glar053                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar053_desc>>----
         #----<<b_glar020>>----
         #Ctrlp:construct.c.page1.b_glar020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar020
            #add-point:ON ACTION controlp INFIELD b_glar020 name="construct.c.filter.page1.b_glar020"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar020  #顯示到畫面上
            NEXT FIELD b_glar020                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar020_desc>>----
         #----<<b_glar022>>----
         #Ctrlp:construct.c.page1.b_glar022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar022
            #add-point:ON ACTION controlp INFIELD b_glar022 name="construct.c.filter.page1.b_glar022"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar022  #顯示到畫面上
            NEXT FIELD b_glar022                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar022_desc>>----
         #----<<b_glar023>>----
         #Ctrlp:construct.c.page1.b_glar023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar023
            #add-point:ON ACTION controlp INFIELD b_glar023 name="construct.c.filter.page1.b_glar023"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar023  #顯示到畫面上
            NEXT FIELD b_glar023                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar023_desc>>----
         #----<<b_glar024>>----
         #Ctrlp:construct.c.page1.b_glar024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar024
            #add-point:ON ACTION controlp INFIELD b_glar024 name="construct.c.filter.page1.b_glar024"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar024()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar024  #顯示到畫面上
            NEXT FIELD b_glar024                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar024_desc>>----
         #----<<b_glar025>>----
         #Ctrlp:construct.c.page1.b_glar025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar025
            #add-point:ON ACTION controlp INFIELD b_glar025 name="construct.c.filter.page1.b_glar025"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar025()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar025  #顯示到畫面上
            NEXT FIELD b_glar025                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar025_desc>>----
         #----<<b_glar026>>----
         #Ctrlp:construct.c.page1.b_glar026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar026
            #add-point:ON ACTION controlp INFIELD b_glar026 name="construct.c.filter.page1.b_glar026"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar026()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar026  #顯示到畫面上
            NEXT FIELD b_glar026                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar026_desc>>----
         #----<<b_glar027>>----
         #Ctrlp:construct.c.page1.b_glar027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar027
            #add-point:ON ACTION controlp INFIELD b_glar027 name="construct.c.filter.page1.b_glar027"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar027()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar027  #顯示到畫面上
            NEXT FIELD b_glar027                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar027_desc>>----
         #----<<b_glar028>>----
         #Ctrlp:construct.c.page1.b_glar028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar028
            #add-point:ON ACTION controlp INFIELD b_glar028 name="construct.c.filter.page1.b_glar028"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar028()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar028  #顯示到畫面上
            NEXT FIELD b_glar028                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar028_desc>>----
         #----<<b_glar029>>----
         #Ctrlp:construct.c.page1.b_glar029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar029
            #add-point:ON ACTION controlp INFIELD b_glar029 name="construct.c.filter.page1.b_glar029"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar029()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar029  #顯示到畫面上
            NEXT FIELD b_glar029                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar029_desc>>----
         #----<<b_glar030>>----
         #Ctrlp:construct.c.page1.b_glar030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar030
            #add-point:ON ACTION controlp INFIELD b_glar030 name="construct.c.filter.page1.b_glar030"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar030()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar030  #顯示到畫面上
            NEXT FIELD b_glar030                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar030_desc>>----
         #----<<b_glar031>>----
         #Ctrlp:construct.c.page1.b_glar031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar031
            #add-point:ON ACTION controlp INFIELD b_glar031 name="construct.c.filter.page1.b_glar031"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar031()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar031  #顯示到畫面上
            NEXT FIELD b_glar031                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar031_desc>>----
         #----<<b_glar032>>----
         #Ctrlp:construct.c.page1.b_glar032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar032
            #add-point:ON ACTION controlp INFIELD b_glar032 name="construct.c.filter.page1.b_glar032"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar032()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar032  #顯示到畫面上
            NEXT FIELD b_glar032                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar032_desc>>----
         #----<<b_glar033>>----
         #Ctrlp:construct.c.page1.b_glar033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar033
            #add-point:ON ACTION controlp INFIELD b_glar033 name="construct.c.filter.page1.b_glar033"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glar033()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar033  #顯示到畫面上
            NEXT FIELD b_glar033                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glar033_desc>>----
         #----<<amt1>>----
         #----<<amt2>>----
         #----<<amt3>>----
         #----<<amt4>>----
         #----<<amt5>>----
         #----<<amt6>>----
         #----<<amt7>>----
         #----<<amt8>>----
         #----<<amt9>>----
         #----<<amt10>>----
         #----<<amt11>>----
         #----<<amt12>>----
         #----<<sum1>>----
         #----<<glar001_2_desc>>----
         #----<<glar012_2_desc>>----
         #----<<glar013_2_desc>>----
         #----<<glar014_2_desc>>----
         #----<<glar015_2_desc>>----
         #----<<glar016_2_desc>>----
         #----<<glar017_2_desc>>----
         #----<<glar018_2_desc>>----
         #----<<glar019_2_desc>>----
         #----<<glar052_2_desc>>----
         #----<<glar053_2_desc>>----
         #----<<glar020_2_desc>>----
         #----<<glar022_2_desc>>----
         #----<<glar023_2_desc>>----
         #----<<glar024_2_desc>>----
         #----<<glar025_2_desc>>----
         #----<<glar026_2_desc>>----
         #----<<glar027_2_desc>>----
         #----<<glar028_2_desc>>----
         #----<<glar029_2_desc>>----
         #----<<glar030_2_desc>>----
         #----<<glar031_2_desc>>----
         #----<<glar032_2_desc>>----
         #----<<glar033_2_desc>>----
         #----<<amt201>>----
         #----<<amt202>>----
         #----<<amt203>>----
         #----<<amt204>>----
         #----<<amt205>>----
         #----<<amt206>>----
         #----<<amt207>>----
         #----<<amt208>>----
         #----<<amt209>>----
         #----<<amt210>>----
         #----<<amt211>>----
         #----<<amt212>>----
         #----<<sum2>>----
         #----<<glar001_3_desc>>----
         #----<<glar012_3_desc>>----
         #----<<glar013_3_desc>>----
         #----<<glar014_3_desc>>----
         #----<<glar015_3_desc>>----
         #----<<glar016_3_desc>>----
         #----<<glar017_3_desc>>----
         #----<<glar018_3_desc>>----
         #----<<glar019_3_desc>>----
         #----<<glar052_3_desc>>----
         #----<<glar053_3_desc>>----
         #----<<glar020_3_desc>>----
         #----<<glar022_3_desc>>----
         #----<<glar023_3_desc>>----
         #----<<glar024_3_desc>>----
         #----<<glar025_3_desc>>----
         #----<<glar026_3_desc>>----
         #----<<glar027_3_desc>>----
         #----<<glar028_3_desc>>----
         #----<<glar029_3_desc>>----
         #----<<glar030_3_desc>>----
         #----<<glar031_3_desc>>----
         #----<<glar032_3_desc>>----
         #----<<glar033_3_desc>>----
         #----<<amt301>>----
         #----<<amt302>>----
         #----<<amt303>>----
         #----<<amt304>>----
         #----<<amt305>>----
         #----<<amt306>>----
         #----<<amt307>>----
         #----<<amt308>>----
         #----<<amt309>>----
         #----<<amt310>>----
         #----<<amt311>>----
         #----<<amt312>>----
         #----<<sum3>>----
   
 
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
   
      CALL aglq854_filter_show('glar012','b_glar012')
   CALL aglq854_filter_show('glar013','b_glar013')
   CALL aglq854_filter_show('glar014','b_glar014')
   CALL aglq854_filter_show('glar015','b_glar015')
   CALL aglq854_filter_show('glar016','b_glar016')
   CALL aglq854_filter_show('glar017','b_glar017')
   CALL aglq854_filter_show('glar018','b_glar018')
   CALL aglq854_filter_show('glar019','b_glar019')
   CALL aglq854_filter_show('glar051','b_glar051')
   CALL aglq854_filter_show('glar052','b_glar052')
   CALL aglq854_filter_show('glar053','b_glar053')
   CALL aglq854_filter_show('glar020','b_glar020')
   CALL aglq854_filter_show('glar022','b_glar022')
   CALL aglq854_filter_show('glar023','b_glar023')
   CALL aglq854_filter_show('glar024','b_glar024')
   CALL aglq854_filter_show('glar025','b_glar025')
   CALL aglq854_filter_show('glar026','b_glar026')
   CALL aglq854_filter_show('glar027','b_glar027')
   CALL aglq854_filter_show('glar028','b_glar028')
   CALL aglq854_filter_show('glar029','b_glar029')
   CALL aglq854_filter_show('glar030','b_glar030')
   CALL aglq854_filter_show('glar031','b_glar031')
   CALL aglq854_filter_show('glar032','b_glar032')
   CALL aglq854_filter_show('glar033','b_glar033')
 
    
   CALL aglq854_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq854.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq854_filter_parser(ps_field)
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
 
{<section id="aglq854.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq854_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq854_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq854.insert" >}
#+ insert
PRIVATE FUNCTION aglq854_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq854.modify" >}
#+ modify
PRIVATE FUNCTION aglq854_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq854.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq854_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq854.delete" >}
#+ delete
PRIVATE FUNCTION aglq854_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq854.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq854_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   LET g_tot_cnt = g_glar_d.getLength()
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
 
{<section id="aglq854.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq854_detail_index_setting()
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
            IF g_glar_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_glar_d.getLength() AND g_glar_d.getLength() > 0
            LET g_detail_idx = g_glar_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_glar_d.getLength() THEN
               LET g_detail_idx = g_glar_d.getLength()
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
 
{<section id="aglq854.mask_functions" >}
 &include "erp/agl/aglq854_mask.4gl"
 
{</section>}
 
{<section id="aglq854.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 预设画面栏位资料
# Memo...........:
# Usage..........: CALL aglq854_default()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/09/02 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq854_default()
   DEFINE l_success          LIKE type_t.num5
   DEFINE l_flag            LIKE type_t.chr1
   DEFINE l_errno           LIKE type_t.chr100
   DEFINE l_glav002         LIKE glav_t.glav002
   DEFINE l_glav005         LIKE glav_t.glav005
   DEFINE l_sdate_s         LIKE glav_t.glav004
   DEFINE l_sdate_e         LIKE glav_t.glav004
   DEFINE l_glav006         LIKE glav_t.glav006
   DEFINE l_pdate_s         LIKE glav_t.glav004
   DEFINE l_pdate_e         LIKE glav_t.glav004
   DEFINE l_glav007         LIKE glav_t.glav007
   DEFINE l_wdate_s         LIKE glav_t.glav004
   DEFINE l_wdate_e         LIKE glav_t.glav004
   
   IF cl_null(tm.glaald) THEN
       CALL s_ld_bookno()  RETURNING l_success,tm.glaald
   END IF
   IF NOT cl_null(tm.glaald) THEN
      CALL aglq854_glaald_desc(tm.glaald)
   END IF
   #多本位币
   LET tm.ctype='0'
   CALL cl_set_comp_visible('page_2,page_3',FALSE)
   #起始截止日期、年度、期别
   IF NOT cl_null(g_glaa003) THEN
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
      LET tm.sdate = l_pdate_s
      LET tm.edate = l_pdate_e
      LET tm.syear = l_glav002
      LET tm.eyear = l_glav002
      LET tm.smonth= l_glav006
      LET tm.emonth= l_glav006
   ELSE
      LET tm.sdate = g_today
      LET tm.syear = YEAR(g_today)
      LET tm.smonth = MONTH(g_today)
      LET tm.edate = tm.sdate      
      LET tm.eyear = tm.syear
      LET tm.emonth = tm.smonth
   END IF
   #餘額形態
   LET tm.kind='1'
   #統制科目
   LET tm.show_acc='N'
   #科目層級
   LET tm.glac005=99
   #單據狀態
   LET tm.stus='1'
   #含內部管理科目
   LET tm.glac009='Y'
   #含月結傳票
   LET tm.show_ce='Y'
   #含年結傳票
   LET tm.show_ye='Y'
   #核算項
   LET tm.comp='Y'
   LET tm.glad007='N'
   LET tm.glad008='N'
   LET tm.glad009='N'
   LET tm.glad010='N'
   LET tm.glad027='N'
   LET tm.glad011='N'
   LET tm.glad012='N'
   LET tm.glad031='N'
   LET tm.glad032='N'
   LET tm.glad033='N'
   LET tm.glad013='N'
   LET tm.glad015='N'
   LET tm.glad016='N'
   LET tm.glad017='N'
   LET tm.glad018='N'
   LET tm.glad019='N'
   LET tm.glad020='N'
   LET tm.glad021='N'
   LET tm.glad022='N'
   LET tm.glad023='N'
   LET tm.glad024='N'
   LET tm.glad025='N'
   LET tm.glad026='N'
   CALL cl_set_comp_visible("b_glar013,b_glar013_desc,b_glar014,b_glar014_desc,b_glar015,b_glar015_desc,b_glar016,b_glar016_desc,b_glar017,b_glar017_desc,b_glar018,b_glar018_desc",FALSE)
   CALL cl_set_comp_visible("b_glar019,b_glar019_desc,b_glar051,b_glar052,b_glar052_desc,b_glar053,b_glar053_desc,b_glar020,b_glar020_desc,b_glar022,b_glar022_desc",FALSE)
   CALL cl_set_comp_visible("b_glar023,b_glar023_desc,b_glar024,b_glar024_desc,b_glar025,b_glar025_desc,b_glar026,b_glar026_desc,",FALSE)
   CALL cl_set_comp_visible("b_glar027,b_glar027_desc,b_glar028,b_glar028_desc,b_glar029,b_glar029_desc,b_glar030,b_glar030_desc,",FALSE)
   CALL cl_set_comp_visible("b_glar031,b_glar031_desc,b_glar032,b_glar032_desc,b_glar033,b_glar033_desc",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aglq854_glaald_desc(p_glaald)
# Input parameter: p_glaald       账套编号
# Return code....: 
# Date & Author..: 2016/09/02 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq854_glaald_desc(p_glaald)
   DEFINE p_glaald           LIKE glaa_t.glaald
   
   #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
   SELECT glaacomp,glaa001,glaa002,glaa003,glaa004,glaa013,
          glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
          glaa021,glaa022
     INTO tm.glaacomp,tm.glaa001,g_glaa002,g_glaa003,g_glaa004,g_glaa013,
          g_glaa015,tm.glaa016,g_glaa017,g_glaa018,g_glaa019,tm.glaa020,
          g_glaa021,g_glaa022
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glaald 
   CALL s_desc_get_ld_desc(p_glaald) RETURNING tm.glaald_desc
   CALL s_desc_get_department_desc(tm.glaacomp) RETURNING tm.glaacomp_desc
   
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
END FUNCTION

################################################################################
# Descriptions...: 根据选择的多本位币，设置单身显示栏位
# Memo...........:
# Usage..........: CALL aglq854_set_curr_show()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/09/02 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq854_set_curr_show()
   #顯示本位幣二
   IF tm.ctype='1' THEN
      CALL cl_set_comp_visible("page_2",TRUE)
   ELSE
      CALL cl_set_comp_visible("page_2",FALSE)
   END IF
   #顯示本位幣三
   IF tm.ctype='2' THEN
      CALL cl_set_comp_visible("page_3",TRUE)
   ELSE
      CALL cl_set_comp_visible("page_3",FALSE)
   END IF
   #全部
   IF tm.ctype='3' THEN
      CALL cl_set_comp_visible("page_2,page_3",TRUE)
   END IF
   
   IF tm.ctype = '1' OR tm.ctype = '3' THEN
      IF tm.comp = 'Y' THEN
         CALL cl_set_comp_visible("glar012_2,glar012_2_desc",TRUE)
      ELSE
         CALL cl_set_comp_visible("glar012_2,glar012_2_desc",FALSE)
      END IF
      
      IF tm.glad007='Y' THEN
         CALL cl_set_comp_visible("glar013_2,glar013_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar013_2,glar013_2_desc",FALSE)
      END IF
            
      IF tm.glad008='Y' THEN
         CALL cl_set_comp_visible("glar014_2,glar014_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar014_2,glar014_2_desc",FALSE)
      END IF                                                
                                                            
      IF tm.glad009='Y' THEN                                
         CALL cl_set_comp_visible("glar015_2,glar015_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar015_2,glar015_2_desc",FALSE)
      END IF                                                
                                                            
      IF tm.glad010='Y' THEN                                
         CALL cl_set_comp_visible("glar016_2,glar016_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar016_2,glar016_2_desc",FALSE)
      END IF
            
      IF tm.glad027='Y' THEN
         CALL cl_set_comp_visible("glar017_2,glar017_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar017_2,glar017_2_desc",FALSE)
      END IF                                                
                                                            
      IF tm.glad011='Y' THEN                                
         CALL cl_set_comp_visible("glar018_2,glar018_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar018_2,glar018_2_desc",FALSE)
      END IF                                                
                                                            
      IF tm.glad012='Y' THEN                                
         CALL cl_set_comp_visible("glar019_2,glar019_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar019_2,glar019_2_desc",FALSE)
      END IF
      
      IF tm.glad031='Y' THEN
         CALL cl_set_comp_visible("glar051_2",TRUE)
      ELSE                                   
         CALL cl_set_comp_visible("glar051_2",FALSE)
      END IF
            
      IF tm.glad032='Y' THEN
         CALL cl_set_comp_visible("glar052_2,glar052_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar052_2,glar052_2_desc",FALSE)
      END IF                                                
                                                            
      IF tm.glad033='Y' THEN                                
         CALL cl_set_comp_visible("glar053_2,glar053_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar053_2,glar053_2_desc",FALSE)
      END IF                        
                                    
      IF tm.glad013='Y' THEN        
         CALL cl_set_comp_visible("glar020_2,glar020_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar020_2,glar020_2_desc",FALSE)
      END IF                                                
                                                            
      IF tm.glad015='Y' THEN                                
         CALL cl_set_comp_visible("glar022_2,glar022_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar022_2,glar022_2_desc",FALSE)
      END IF                                                
                                                            
      IF tm.glad016='Y' THEN                                
         CALL cl_set_comp_visible("glar023_2,glar023_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar023_2,glar023_2_desc",FALSE)
      END IF                                                
                                                            
      IF tm.glad017='Y' THEN                                
         CALL cl_set_comp_visible("glar024_2,glar024_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar024_2,glar024_2_desc",FALSE)
      END IF
            
      IF tm.glad018='Y' THEN
         CALL cl_set_comp_visible("glar025_2,glar025_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar025_2,glar025_2_desc",FALSE)
      END IF                                                
                                                            
      IF tm.glad019='Y' THEN                                
         CALL cl_set_comp_visible("glar026_2,glar026_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar026_2,glar026_2_desc",FALSE)
      END IF                                                
                                                            
      IF tm.glad020='Y' THEN                                
         CALL cl_set_comp_visible("glar027_2,glar027_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar027_2,glar027_2_desc",FALSE)
      END IF
            
      IF tm.glad021='Y' THEN
         CALL cl_set_comp_visible("glar028_2,glar028_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar028_2,glar028_2_desc",FALSE)
      END IF                                                
                                                            
      IF tm.glad022='Y' THEN                                
         CALL cl_set_comp_visible("glar029_2,glar029_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar029_2,glar029_2_desc",FALSE)
      END IF                                                
                                                            
      IF tm.glad023='Y' THEN                                
         CALL cl_set_comp_visible("glar030_2,glar030_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar030_2,glar030_2_desc",FALSE)
      END IF                        
                                    
      IF tm.glad024='Y' THEN        
         CALL cl_set_comp_visible("glar031_2,glar031_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar031_2,glar031_2_desc",FALSE)
      END IF                                                
                                                            
      IF tm.glad025='Y' THEN                                
         CALL cl_set_comp_visible("glar032_2,glar032_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar032_2,glar032_2_desc",FALSE)
      END IF                                                
                                                            
      IF tm.glad026='Y' THEN                                
         CALL cl_set_comp_visible("glar033_2,glar033_2_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar033_2,glar033_2_desc",FALSE)
      END IF
   END IF
   
   IF tm.ctype = '1' OR tm.ctype = '3' THEN
      IF tm.comp = 'Y' THEN
         CALL cl_set_comp_visible("glar012_3,glar012_3_desc",TRUE)
      ELSE
         CALL cl_set_comp_visible("glar012_3,glar012_3_desc",FALSE)
      END IF
      
      IF tm.glad007='Y' THEN
         CALL cl_set_comp_visible("glar013_3,glar013_3_desc",TRUE)
      ELSE                                                  
         CALL cl_set_comp_visible("glar013_3,glar013_3_desc",FALSE)
      END IF
            
      IF tm.glad008='Y' THEN
         CALL cl_set_comp_visible("glar014_3,glar014_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar014_3,glar014_3_desc",FALSE)
      END IF                       
                                   
      IF tm.glad009='Y' THEN       
         CALL cl_set_comp_visible("glar015_3,glar015_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar015_3,glar015_3_desc",FALSE)
      END IF                       
                                   
      IF tm.glad010='Y' THEN       
         CALL cl_set_comp_visible("glar016_3,glar016_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar016_3,glar016_3_desc",FALSE)
      END IF
            
      IF tm.glad027='Y' THEN
         CALL cl_set_comp_visible("glar017_3,glar017_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar017_3,glar017_3_desc",FALSE)
      END IF                       
                                   
      IF tm.glad011='Y' THEN       
         CALL cl_set_comp_visible("glar018_3,glar018_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar018_3,glar018_3_desc",FALSE)
      END IF                       
                                   
      IF tm.glad012='Y' THEN       
         CALL cl_set_comp_visible("glar019_3,glar019_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar019_3,glar019_3_desc",FALSE)
      END IF
      
      IF tm.glad031='Y' THEN
         CALL cl_set_comp_visible("glar051_3",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar051_3",FALSE)
      END IF
            
      IF tm.glad032='Y' THEN
         CALL cl_set_comp_visible("glar052_3,glar052_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar052_3,glar052_3_desc",FALSE)
      END IF                        
                                    
      IF tm.glad033='Y' THEN        
         CALL cl_set_comp_visible("glar053_3,glar053_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar053_3,glar053_3_desc",FALSE)
      END IF                       
                                   
      IF tm.glad013='Y' THEN       
         CALL cl_set_comp_visible("glar020_3,glar020_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar020_3,glar020_3_desc",FALSE)
      END IF                        
                                    
      IF tm.glad015='Y' THEN        
         CALL cl_set_comp_visible("glar022_3,glar022_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar022_3,glar022_3_desc",FALSE)
      END IF                       
                                   
      IF tm.glad016='Y' THEN       
         CALL cl_set_comp_visible("glar023_3,glar023_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar023_3,glar023_3_desc",FALSE)
      END IF                        
                                    
      IF tm.glad017='Y' THEN        
         CALL cl_set_comp_visible("glar024_3,glar024_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar024_3,glar024_3_desc",FALSE)
      END IF                        
                                    
      IF tm.glad018='Y' THEN        
         CALL cl_set_comp_visible("glar025_3,glar025_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar025_3,glar025_3_desc",FALSE)
      END IF                       
                                   
      IF tm.glad019='Y' THEN       
         CALL cl_set_comp_visible("glar026_3,glar026_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar026_3,glar026_3_desc",FALSE)
      END IF                        
                                    
      IF tm.glad020='Y' THEN        
         CALL cl_set_comp_visible("glar027_3,glar027_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar027_3,glar027_3_desc",FALSE)
      END IF                        
                                    
      IF tm.glad021='Y' THEN        
         CALL cl_set_comp_visible("glar028_3,glar028_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar028_3,glar028_3_desc",FALSE)
      END IF                       
                                   
      IF tm.glad022='Y' THEN       
         CALL cl_set_comp_visible("glar029_3,glar029_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar029_3,glar029_3_desc",FALSE)
      END IF                        
                                    
      IF tm.glad023='Y' THEN        
         CALL cl_set_comp_visible("glar030_3,glar030_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar030_3,glar030_3_desc",FALSE)
      END IF                        
                                    
      IF tm.glad024='Y' THEN        
         CALL cl_set_comp_visible("glar031_3,glar031_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar031_3,glar031_3_desc",FALSE)
      END IF                        
                                    
      IF tm.glad025='Y' THEN        
         CALL cl_set_comp_visible("glar032_3,glar032_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar032_3,glar032_3_desc",FALSE)
      END IF                       
                                   
      IF tm.glad026='Y' THEN       
         CALL cl_set_comp_visible("glar033_3,glar033_3_desc",TRUE)
      ELSE                         
         CALL cl_set_comp_visible("glar033_3,glar033_3_desc",FALSE)
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 抓取科目及核算项资料,并按照查询时间范围逐期计算金额
# Memo...........:
# Usage..........: CALL aglq854_get_data()
# Input parameter: 
# Return code....:
# Date & Author..: 2016/09/05 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq854_get_data()
DEFINE l_wc_glaq002             STRING
DEFINE l_wc                     STRING
DEFINE l_wc_glac002             STRING
DEFINE l_sql,l_sql1             STRING
DEFINE l_sql2,l_sql3            STRING
DEFINE l_str,l_str1,l_str2      STRING
DEFINE l_str3,l_str4            STRING
DEFINE l_sdate,l_edate          LIKE glav_t.glav004
DEFINE l_flag                   LIKE type_t.num5
DEFINE l_success                LIKE type_t.num5
DEFINE l_glac002                LIKE glac_t.glac002
DEFINE l_glac002_o              LIKE glac_t.glac002
DEFINE l_glac003                LIKE glac_t.glac003
DEFINE l_glac008                LIKE glac_t.glac008
DEFINE l_glaq002                STRING
DEFINE l_get_sql                RECORD
       glar012                  STRING,  #营运据点
       glar013                  STRING,  #部门
       glar014                  STRING,  #责任中心
       glar015                  STRING,  #区域
       glar016                  STRING,  #收付款客商
       glar017                  STRING,  #账款客商
       glar018                  STRING,  #客群
       glar019                  STRING,  #产品类别
       glar020                  STRING,  #人员
       glar022                  STRING,  #专案编号
       glar023                  STRING,  #WBS
       glar052                  STRING,  #渠道
       glar053                  STRING   #品牌  
                                END RECORD  
DEFINE l_hsx                    LIKE type_t.num5 
DEFINE l_sql_pr1                STRING
DEFINE l_sql_pr2                STRING
DEFINE l_sql_ye                 STRING
DEFINE l_sql_ce                 STRING
DEFINE l_sql_nch                STRING
DEFINE l_yy_desc                STRING
DEFINE l_mm_desc                STRING
DEFINE l_desc                   STRING
DEFINE l_glac002_str            STRING
DEFINE l_yy                     LIKE glav_t.glav002
DEFINE l_mm                     LIKE glav_t.glav006
DEFINE l_i,l_j,l_index          LIKE type_t.num5
DEFINE l_hsx_glar,l_hsx_glaq    STRING
DEFINE l_max_period             LIKE glav_t.glav006
DEFINE l_amt1,l_amt2,l_amt3     LIKE type_t.num20_6
DEFINE l_amt4,l_amt5,l_amt6     LIKE type_t.num20_6
DEFINE l_amt7,l_amt8,l_amt9     LIKE type_t.num20_6

   CALL g_glar_d.clear()   
   CALL g_glar2_d.clear()
   CALL g_glar3_d.clear()
   LET g_col_mm=0  #单身显示的期别个数
   #核算項條件篩選
   LET l_wc_glaq002=cl_replace_str(g_wc_glar001,'glar001','glaq002')
   LET l_wc=cl_replace_str(g_wc,'glar012','glaq017')
   LET l_wc=cl_replace_str(l_wc,'glar013','glaq018')
   LET l_wc=cl_replace_str(l_wc,'glar014','glaq019')
   LET l_wc=cl_replace_str(l_wc,'glar015','glaq020')
   LET l_wc=cl_replace_str(l_wc,'glar016','glaq021')
   LET l_wc=cl_replace_str(l_wc,'glar017','glaq022')
   LET l_wc=cl_replace_str(l_wc,'glar018','glaq023')
   LET l_wc=cl_replace_str(l_wc,'glar019','glaq024')
   LET l_wc=cl_replace_str(l_wc,'glar051','glaq051')
   LET l_wc=cl_replace_str(l_wc,'glar052','glaq052')
   LET l_wc=cl_replace_str(l_wc,'glar053','glaq053')
   LET l_wc=cl_replace_str(l_wc,'glar020','glaq025')
   LET l_wc=cl_replace_str(l_wc,'glar022','glaq027')
   LET l_wc=cl_replace_str(l_wc,'glar023','glaq028')
   #自由核算項
   LET l_wc=cl_replace_str(l_wc,'glar024','glaq029')
   LET l_wc=cl_replace_str(l_wc,'glar025','glaq030')
   LET l_wc=cl_replace_str(l_wc,'glar026','glaq031')
   LET l_wc=cl_replace_str(l_wc,'glar027','glaq032')
   LET l_wc=cl_replace_str(l_wc,'glar028','glaq033')
   LET l_wc=cl_replace_str(l_wc,'glar029','glaq034')
   LET l_wc=cl_replace_str(l_wc,'glar030','glaq035')
   LET l_wc=cl_replace_str(l_wc,'glar031','glaq036')
   LET l_wc=cl_replace_str(l_wc,'glar032','glaq037')
   LET l_wc=cl_replace_str(l_wc,'glar033','glaq038')
   
   LET l_wc_glac002=cl_replace_str(g_wc_glar001,'glar001','glac002')
   
   #顯示統制科目否
   IF tm.show_acc<>'Y' THEN
      LET l_sql1=l_sql1," AND glac003<>'1' "
   END IF
   #科目層級
   IF NOT cl_null(tm.glac005) THEN
      LET l_sql1=l_sql1," AND glac005<=",tm.glac005
   END IF
   #含內部管理科目否
   IF tm.glac009<>'Y' THEN
      LET l_sql1=l_sql1," AND glac009<>'Y' "
   END IF
   #顯示年結YE憑證否
   IF tm.show_ye<>'Y' THEN
      LET l_sql2=" AND glap007<>'YE' "
   END IF
   
   #單據狀態
   CASE
      WHEN tm.stus='1'
         LET l_sql3=" AND glapstus='S' "
      WHEN tm.stus='2'
         LET l_sql3=" AND glapstus IN ('Y','S') "
      WHEN tm.stus='3'
         LET l_sql3=" AND glapstus IN ('N','Y','S') "
   END CASE
   
   #核算項
   CALL aglq854_fix_acc_get_sql() RETURNING l_str,l_str1,l_str2,l_str3,l_str4
   
   #判断查询时间范围是否为整期间范围
   #起始期别的第一天
   SELECT MIN(glav004) INTO l_sdate FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear AND glav006=tm.smonth
   #截止期别的最后一天
   SELECT MAX(glav004) INTO l_edate FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.eyear AND glav006=tm.emonth
   IF tm.sdate = l_sdate AND tm.edate = l_edate THEN
      LET l_flag = TRUE   #整期间
   ELSE
      LET l_flag = FALSE  #破期
   END IF
   
   DELETE FROM aglq854_tmp
   LET l_success = TRUE
   CALL cl_err_collect_init()
   
   #当不显示统制科目或显示统治科目&凭证状态=1.已过账&整期间
   #科目+核算项一起抓取
   IF tm.show_acc = 'N' OR (tm.show_acc='Y' AND tm.stus = '1' AND l_flag = TRUE) THEN
      #抓取余额档glar_t中资料
      IF tm.stus = '1' AND l_flag = TRUE THEN
         LET g_sql="SELECT DISTINCT glarent,glar001",l_str,
                   "  FROM glar_t ",
                   " WHERE glarent=",g_enterprise," AND glarld='",tm.glaald,"'",
                   "   AND glar001 IN (SELECT glac002 FROM glac_t ",
                   "                    WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                   "                      AND glacstus='Y' ",l_sql1," )",
                   "   AND ",g_wc_glar001,
                   "   AND ",g_wc,l_str3
         #發生額
         IF tm.kind='1' THEN
            IF tm.syear = tm.eyear THEN
               LET g_sql=g_sql," AND glar002=",tm.syear," AND glar003 BETWEEN ",tm.smonth," AND ",tm.emonth
            ELSE
               #因为限制了只可以查12个期别，所以之后是前后两年，所以可以这样限制
               LET g_sql=g_sql," AND ((glar002=",tm.syear," AND glar003>=",tm.smonth,")",
                               "   OR (glar002=",tm.eyear," AND glar003<=",tm.emonth,")",
                               "     )"
            END IF
         ELSE  #累計額
            IF tm.syear = tm.eyear THEN
               LET g_sql=g_sql," AND glar002 ='",tm.syear,"' AND glar003<=",tm.emonth
            ELSE
               LET g_sql=g_sql," AND (glar002 ='",tm.syear," OR (glar002=",tm.eyear," AND glar003<=",tm.emonth,"))"
            END IF
         END IF 
      ELSE
      #抓取凭证glaq_t中资料
         LET g_sql="SELECT DISTINCT glaqent,glaq002",l_str1,
                   "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   " WHERE glaqent=",g_enterprise," AND glaqld='",tm.glaald,"' ",
                   "   AND glaq002 IN (SELECT glac002 FROM glac_t ",
                   "                    WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                   "                      AND glacstus='Y' ",l_sql1," )",
                   "   AND ",l_wc_glaq002,
                   "   AND ",l_wc,l_str4,
                   l_sql2,l_sql3
         #發生額
         IF tm.kind='1' THEN
            LET g_sql=g_sql," AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'"
         ELSE
            LET g_sql=g_sql," AND glap002 >=",tm.syear," AND glapdocdt <='",tm.edate,"'"
         END IF
      END IF
      LET g_sql="INSERT INTO aglq854_tmp (glarent,glar001",l_str,") ",g_sql
      PREPARE aglq854_ins_tmp_pr FROM g_sql
      EXECUTE aglq854_ins_tmp_pr
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'EXECUTE aglq854_ins_tmp_pr'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
      END IF
   ELSE
      #当没有勾选核算项时，只要查询科目
      IF cl_null(l_str) THEN
         LET g_sql="INSERT INTO aglq854_tmp(glarent,glar001) ",
                   "  SELECT DISTINCT glacent,glac002 FROM glac_t",
                   "   WHERE glacent=",g_enterprise,
                   "     AND glac001='",g_glaa004,"'",
                   "     AND glacstus='Y' ",
                   "     AND ",l_wc_glac002,l_sql1
         PREPARE aglq854_ins_tmp_pr1 FROM g_sql
         EXECUTE aglq854_ins_tmp_pr1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'EXECUTE aglq854_ins_tmp_pr1'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET l_success = FALSE
         END IF          
      ELSE
         #先抓取科目，然后通过科目抓取核算项
         #抓出所有符合條件的會計科目
         LET g_sql="SELECT DISTINCT glac002,glac003 FROM glac_t",
                   " WHERE glacent=",g_enterprise,
                   "   AND glac001='",g_glaa004,"'",
                   "   AND glacstus='Y' ",
                   "   AND ",l_wc_glac002,l_sql1,
                   " ORDER BY glac002"
         PREPARE aglq854_sel_glac_pr FROM g_sql
         DECLARE aglq854_sel_glac_cs CURSOR FOR aglq854_sel_glac_pr
   
         #科目遍歷
         FOREACH aglq854_sel_glac_cs INTO l_glac002,l_glac003
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'FOREACH aglq854_sel_glac_cs'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            
            #当科目为统制科目时，抓取科目对应的明细科目或者独立科目
            LET l_glaq002 = ''
            IF l_glac003 = '1' THEN
               CALL s_voucher_get_glac_str(g_glaa004,l_glac002) RETURNING l_glaq002
            END IF
            #当该统治科目没有下层明细科目时，抓取该科目本身资料
            IF cl_null(l_glaq002) THEN
               LET l_glaq002 = " AND glaq002 ='",l_glac002,"'"
            ELSE
               LET l_glaq002 = " AND glaq002 IN (",l_glaq002,")"
            END IF
            
            #当非统制科目时直接将科目+核算项插入临时表
            #当统制科目时，抓取核算项资料，将统制科目+核算项插入临时表
            IF l_glac003 <> '1' THEN
               #當勾選了顯示核算項等條件后，依勾選條件遍歷查詢資料
               LET g_sql="INSERT INTO aglq854_tmp(glarent,glar001",l_str,") ",
                         " SELECT DISTINCT glaqent,glaq002",l_str1,
                         "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                         " WHERE glaqent=",g_enterprise," AND glaqld='",tm.glaald,"' ",
                         "   AND ",l_wc,l_glaq002,
                         l_sql2,l_sql3,l_str4
               #發生額
               IF tm.kind='1' THEN
                  LET g_sql=g_sql," AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'"
               ELSE
                  LET g_sql=g_sql," AND glap002 >=",tm.syear," AND glapdocdt <='",tm.edate,"'"
               END IF
               
               PREPARE aglq854_ins_tmp_pr2 FROM g_sql
               EXECUTE aglq854_ins_tmp_pr2
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'EXECUTE aglq854_ins_tmp_pr2'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
            ELSE
               LET g_sql="INSERT INTO aglq854_tmp(glarent,glar001",l_str,") ",
                         " SELECT DISTINCT glaqent,'",l_glac002,"'",l_str1,
                         "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                         " WHERE glaqent=",g_enterprise," AND glaqld='",tm.glaald,"' ",
                         "   AND ",l_wc,l_glaq002,
                         l_sql2,l_sql3,l_str4
               #發生額
               IF tm.kind='1' THEN
                  LET g_sql=g_sql," AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'"
               ELSE
                  LET g_sql=g_sql," AND glap002 >=",tm.syear," AND glapdocdt <='",tm.edate,"'"
               END IF
               
               PREPARE aglq854_ins_tmp_pr3 FROM g_sql
               EXECUTE aglq854_ins_tmp_pr3
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'EXECUTE aglq854_ins_tmp_pr3'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
            END IF
         END FOREACH
      END IF
   END IF
   #判断是否抓取到科目及核算项资料，如果没有，提示无符合条件资料
   LET l_i = 0
   SELECT COUNT(1) INTO l_i FROM aglq854_tmp
   IF cl_null(l_i) THEN LET l_i=0 END IF
   IF l_i = 0 THEN
      CALL cl_err_collect_show()
      LET g_detail_cnt=0
      RETURN
   END IF
   #####################################################################################################
   #####################################################################################################
   #填充单身，抓取科目及核算项说明，按照查询年期逐期计算金额
   #抓取说明的sql语句
   LET l_get_sql.*=g_get_sql.*
   #营运据点
   IF tm.comp <> 'Y' THEN
      LET l_get_sql.glar012 = "''"
   END IF
   #部门
   IF tm.glad007 <> 'Y' THEN 
      LET l_get_sql.glar013 = "''"
   END IF
   #利润/成本中心
   IF tm.glad008 <> 'Y' THEN 
      LET l_get_sql.glar014 = "''"
   END IF
   #区域
   IF tm.glad009 <> 'Y' THEN 
      LET l_get_sql.glar015 = "''"
   END IF
   #收付款客商
   IF tm.glad010 <> 'Y' THEN 
      LET l_get_sql.glar016 = "''"
   END IF
   #账款客商
   IF tm.glad027 <> 'Y' THEN 
      LET l_get_sql.glar017 = "''"
   END IF
   #客群
   IF tm.glad011 <> 'Y' THEN 
      LET l_get_sql.glar018 = "''"
   END IF
   #产品类别
   IF tm.glad012 <> 'Y' THEN 
      LET l_get_sql.glar019 = "''"
   END IF
   #渠道
   IF tm.glad032 <> 'Y' THEN 
      LET l_get_sql.glar052 = "''"
   END IF
   #品牌
   IF tm.glad033 <> 'Y' THEN 
      LET l_get_sql.glar053 = "''"
   END IF
   #人员
   IF tm.glad013 <> 'Y' THEN 
      LET l_get_sql.glar020 = "''"
   END IF
   #专案
   IF tm.glad015 <> 'Y' THEN 
      LET l_get_sql.glar022 = "''"
   END IF
   #WBS
   IF tm.glad016 <> 'Y' THEN 
      LET l_get_sql.glar023 = "''"
   END IF
   #判断是否勾选自由核算项项
   IF tm.glad017 = 'Y' OR tm.glad018 = 'Y' OR tm.glad019 = 'Y' OR tm.glad020 = 'Y' OR tm.glad021 = 'Y' OR
      tm.glad022 = 'Y' OR tm.glad023 = 'Y' OR tm.glad024 = 'Y' OR tm.glad025 = 'Y' OR tm.glad026 = 'Y' THEN
      LET l_hsx=TRUE
   ELSE
      LET l_hsx=FALSE
   END IF
   LET g_sql="SELECT UNIQUE glar001,t01.glacl004,glar012,",l_get_sql.glar012,",glar013,",l_get_sql.glar013,",",
             "       glar014,",l_get_sql.glar014,",glar015,",l_get_sql.glar015,",glar016,",l_get_sql.glar016,",",
             "       glar017,",l_get_sql.glar017,",glar018,",l_get_sql.glar018,",glar019,",l_get_sql.glar019,",",
             "       glar051,glar052,",l_get_sql.glar052,",glar053,",l_get_sql.glar053,",glar020,",l_get_sql.glar020,",",
             "       glar022,",l_get_sql.glar022,",glar023,",l_get_sql.glar023,",",
             "       glar024,glar025,glar026,glar027,glar028,glar029,glar030,",
             "       glar031,glar032,glar033,glac003,glac008",
             "  FROM aglq854_tmp ",
             "  LEFT JOIN glacl_t t01 ON glaclent=",g_enterprise," AND glacl001='",g_glaa004,"' AND glacl002=glar001 AND glacl003='",g_dlang,"'",
             "  LEFT JOIN glac_t ON glacent=",g_enterprise," AND glac001='",g_glaa004,"' AND glac002=glar001",
             " ORDER BY glar001,glar012,glar013,glar014,glar015,glar016,glar017,glar018,glar019,",
             "          glar051,glar052,glar053,glar020,glar022,glar023,glar024,glar025,glar026,",
             "          glar027,glar028,glar029,glar030,glar031,glar032,glar033 "
   PREPARE aglq854_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR aglq854_pb1
   
   #############################################抓取金额SQL(S)#############################################
   #發生額
   IF tm.kind = '1' THEN
      #凭证状态为已过账，时间区间为整期间，抓取余额档glar_t资料
      IF tm.stus = '1' AND l_flag = TRUE THEN
         LET l_sql_pr1="SELECT SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037)",
                       "  FROM glar_t ",
                       " WHERE glarent=",g_enterprise," AND glarld='",tm.glaald,"'",
                       "   AND glar002=? AND glar003=? "
         #不含年结YE凭证
         IF tm.show_ye<>'Y' THEN
            LET l_sql_ye="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                         "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                         " WHERE glaqent=",g_enterprise," AND glapld = '",tm.glaald,"' ",
                         "   AND glap002=? AND glap004=? ",
                         "   AND glap007='YE' AND glapstus='S'"
         END IF
      ELSE
         #抓取凭证glaq_t资料
         LET l_sql_pr2="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                       "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                       " WHERE glaqent=",g_enterprise," AND glapld = '",tm.glaald,"' ",
                       "   AND glapdocdt BETWEEN ? AND ? ",
                       l_sql2,l_sql3
      END IF
      #不含月结凭证
      IF tm.show_ce<>'Y' THEN
         LET l_sql_ce="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                      "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      " WHERE glaqent=",g_enterprise," AND glapld = '",tm.glaald,"' ",
                      "   AND glapdocdt BETWEEN ? AND ? ",
                      l_sql2,l_sql3
      END IF
   ELSE
   #累計額
      #凭证状态为已过账，时间区间为整期间，抓取余额档glar_t资料
      IF tm.stus = '1' AND l_flag = TRUE THEN
         LET l_sql_pr1="SELECT SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037)",
                       "  FROM glar_t ",
                       " WHERE glarent=",g_enterprise," AND glarld='",tm.glaald,"'",
                       "   AND glar002=? AND glar003<=? "
         #不含年结YE凭证
         IF tm.show_ye<>'Y' THEN
            LET l_sql_ye="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                         "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                         " WHERE glaqent=",g_enterprise," AND glapld = '",tm.glaald,"' ",
                         "   AND glap002=? AND glap004<=? ",
                         "   AND glap007='YE' AND glapstus='S'"
         END IF
      ELSE
      #抓取凭证glaq_t资料
         LET l_sql_pr2="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                       "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                       " WHERE glaqent=",g_enterprise," AND glapld = '",tm.glaald,"' ",
                       "   AND glap002=? AND glapdocdt <=? ",
                       l_sql2,l_sql3
         #年初数
         LET l_sql_nch="SELECT SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037)",
                       "  FROM glar_t ",
                       " WHERE glarent=",g_enterprise," AND glarld='",tm.glaald,"'",
                       "   AND glar002=? AND glar003=0 "
      END IF
      #不含月结凭证
      IF tm.show_ce<>'Y' THEN
         LET l_sql_ce="SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                      "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      " WHERE glaqent=",g_enterprise," AND glapld = '",tm.glaald,"' ",
                      "   AND glap002=? AND glapdocdt <=? ",
                      l_sql2,l_sql3
      END IF
   END IF
   #############################################抓取金额SQL(E)#############################################
   
   LET l_ac = 1
   LET l_glac002_o = NULL
   LET l_yy_desc=cl_getmsg("agl-00274",g_dlang) #年
   LET l_mm_desc=cl_getmsg("axc-00589",g_dlang) #期 
   
   FOREACH b_fill_curs1 INTO g_glar_d[l_ac].glar001,g_glar_d[l_ac].glar001_desc,g_glar_d[l_ac].glar012, 
       g_glar_d[l_ac].glar012_desc,g_glar_d[l_ac].glar013,g_glar_d[l_ac].glar013_desc,g_glar_d[l_ac].glar014, 
       g_glar_d[l_ac].glar014_desc,g_glar_d[l_ac].glar015,g_glar_d[l_ac].glar015_desc,g_glar_d[l_ac].glar016, 
       g_glar_d[l_ac].glar016_desc,g_glar_d[l_ac].glar017,g_glar_d[l_ac].glar017_desc,g_glar_d[l_ac].glar018, 
       g_glar_d[l_ac].glar018_desc,g_glar_d[l_ac].glar019,g_glar_d[l_ac].glar019_desc,g_glar_d[l_ac].glar051, 
       g_glar_d[l_ac].glar052,g_glar_d[l_ac].glar052_desc,g_glar_d[l_ac].glar053,g_glar_d[l_ac].glar053_desc, 
       g_glar_d[l_ac].glar020,g_glar_d[l_ac].glar020_desc,g_glar_d[l_ac].glar022,g_glar_d[l_ac].glar022_desc, 
       g_glar_d[l_ac].glar023,g_glar_d[l_ac].glar023_desc,g_glar_d[l_ac].glar024,g_glar_d[l_ac].glar025, 
       g_glar_d[l_ac].glar026,g_glar_d[l_ac].glar027,g_glar_d[l_ac].glar028,g_glar_d[l_ac].glar029, 
       g_glar_d[l_ac].glar030,g_glar_d[l_ac].glar031,g_glar_d[l_ac].glar032,g_glar_d[l_ac].glar033, 
       l_glac003,l_glac008
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      #勾选自由核算项时抓取说明
      IF l_hsx = TRUE THEN
         CALL aglq854_detail_show("'1'")
      END IF
      #显示本位币二
      IF tm.ctype = '1' OR tm.ctype = '3' THEN
         LET g_glar2_d[l_ac].glar001 = g_glar_d[l_ac].glar001
         LET g_glar2_d[l_ac].glar001_2_desc = g_glar_d[l_ac].glar001_desc
         LET g_glar2_d[l_ac].glar012 = g_glar_d[l_ac].glar012 
         LET g_glar2_d[l_ac].glar012_2_desc = g_glar_d[l_ac].glar012_desc
         LET g_glar2_d[l_ac].glar013 = g_glar_d[l_ac].glar013
         LET g_glar2_d[l_ac].glar013_2_desc = g_glar_d[l_ac].glar013_desc
         LET g_glar2_d[l_ac].glar014 = g_glar_d[l_ac].glar014
         LET g_glar2_d[l_ac].glar014_2_desc = g_glar_d[l_ac].glar014_desc
         LET g_glar2_d[l_ac].glar015 = g_glar_d[l_ac].glar015
         LET g_glar2_d[l_ac].glar015_2_desc = g_glar_d[l_ac].glar015_desc
         LET g_glar2_d[l_ac].glar016  = g_glar_d[l_ac].glar016 
         LET g_glar2_d[l_ac].glar016_2_desc = g_glar_d[l_ac].glar016_desc
         LET g_glar2_d[l_ac].glar017 = g_glar_d[l_ac].glar017
         LET g_glar2_d[l_ac].glar017_2_desc = g_glar_d[l_ac].glar017_desc
         LET g_glar2_d[l_ac].glar018 = g_glar_d[l_ac].glar018
         LET g_glar2_d[l_ac].glar018_2_desc = g_glar_d[l_ac].glar018_desc
         LET g_glar2_d[l_ac].glar019 = g_glar_d[l_ac].glar019
         LET g_glar2_d[l_ac].glar019_2_desc = g_glar_d[l_ac].glar019_desc
         LET g_glar2_d[l_ac].glar051  = g_glar_d[l_ac].glar051 
         LET g_glar2_d[l_ac].glar052 = g_glar_d[l_ac].glar052
         LET g_glar2_d[l_ac].glar052_2_desc = g_glar_d[l_ac].glar052_desc
         LET g_glar2_d[l_ac].glar053 = g_glar_d[l_ac].glar053
         LET g_glar2_d[l_ac].glar053_2_desc = g_glar_d[l_ac].glar053_desc
         LET g_glar2_d[l_ac].glar020 = g_glar_d[l_ac].glar020
         LET g_glar2_d[l_ac].glar020_2_desc = g_glar_d[l_ac].glar020_desc
         LET g_glar2_d[l_ac].glar022 = g_glar_d[l_ac].glar022
         LET g_glar2_d[l_ac].glar022_2_desc = g_glar_d[l_ac].glar022_desc 
         LET g_glar2_d[l_ac].glar023 = g_glar_d[l_ac].glar023
         LET g_glar2_d[l_ac].glar023_2_desc = g_glar_d[l_ac].glar023_desc
         LET g_glar2_d[l_ac].glar024 = g_glar_d[l_ac].glar024
         LET g_glar2_d[l_ac].glar024_2_desc = g_glar_d[l_ac].glar024_desc 
         LET g_glar2_d[l_ac].glar025 = g_glar_d[l_ac].glar025
         LET g_glar2_d[l_ac].glar025_2_desc = g_glar_d[l_ac].glar025_desc
         LET g_glar2_d[l_ac].glar026 = g_glar_d[l_ac].glar026
         LET g_glar2_d[l_ac].glar026_2_desc = g_glar_d[l_ac].glar026_desc 
         LET g_glar2_d[l_ac].glar027 = g_glar_d[l_ac].glar027
         LET g_glar2_d[l_ac].glar027_2_desc = g_glar_d[l_ac].glar027_desc
         LET g_glar2_d[l_ac].glar028 = g_glar_d[l_ac].glar028
         LET g_glar2_d[l_ac].glar028_2_desc = g_glar_d[l_ac].glar028_desc
         LET g_glar2_d[l_ac].glar029 = g_glar_d[l_ac].glar029
         LET g_glar2_d[l_ac].glar029_2_desc = g_glar_d[l_ac].glar029_desc
         LET g_glar2_d[l_ac].glar030 = g_glar_d[l_ac].glar030
         LET g_glar2_d[l_ac].glar030_2_desc = g_glar_d[l_ac].glar030_desc 
         LET g_glar2_d[l_ac].glar031 = g_glar_d[l_ac].glar031
         LET g_glar2_d[l_ac].glar031_2_desc = g_glar_d[l_ac].glar031_desc
         LET g_glar2_d[l_ac].glar032 = g_glar_d[l_ac].glar032
         LET g_glar2_d[l_ac].glar032_2_desc = g_glar_d[l_ac].glar032_desc 
         LET g_glar2_d[l_ac].glar033 = g_glar_d[l_ac].glar033
         LET g_glar2_d[l_ac].glar033_2_desc = g_glar_d[l_ac].glar033_desc
      END IF
      #显示本位币三
      IF tm.ctype = '2' OR tm.ctype = '3' THEN
         LET g_glar3_d[l_ac].glar001 = g_glar_d[l_ac].glar001
         LET g_glar3_d[l_ac].glar001_3_desc = g_glar_d[l_ac].glar001_desc
         LET g_glar3_d[l_ac].glar012 = g_glar_d[l_ac].glar012 
         LET g_glar3_d[l_ac].glar012_3_desc = g_glar_d[l_ac].glar012_desc
         LET g_glar3_d[l_ac].glar013 = g_glar_d[l_ac].glar013
         LET g_glar3_d[l_ac].glar013_3_desc = g_glar_d[l_ac].glar013_desc
         LET g_glar3_d[l_ac].glar014 = g_glar_d[l_ac].glar014
         LET g_glar3_d[l_ac].glar014_3_desc = g_glar_d[l_ac].glar014_desc
         LET g_glar3_d[l_ac].glar015 = g_glar_d[l_ac].glar015
         LET g_glar3_d[l_ac].glar015_3_desc = g_glar_d[l_ac].glar015_desc
         LET g_glar3_d[l_ac].glar016  = g_glar_d[l_ac].glar016 
         LET g_glar3_d[l_ac].glar016_3_desc = g_glar_d[l_ac].glar016_desc
         LET g_glar3_d[l_ac].glar017 = g_glar_d[l_ac].glar017
         LET g_glar3_d[l_ac].glar017_3_desc = g_glar_d[l_ac].glar017_desc
         LET g_glar3_d[l_ac].glar018 = g_glar_d[l_ac].glar018
         LET g_glar3_d[l_ac].glar018_3_desc = g_glar_d[l_ac].glar018_desc
         LET g_glar3_d[l_ac].glar019 = g_glar_d[l_ac].glar019
         LET g_glar3_d[l_ac].glar019_3_desc = g_glar_d[l_ac].glar019_desc
         LET g_glar3_d[l_ac].glar051  = g_glar_d[l_ac].glar051 
         LET g_glar3_d[l_ac].glar052 = g_glar_d[l_ac].glar052
         LET g_glar3_d[l_ac].glar052_3_desc = g_glar_d[l_ac].glar052_desc
         LET g_glar3_d[l_ac].glar053 = g_glar_d[l_ac].glar053
         LET g_glar3_d[l_ac].glar053_3_desc = g_glar_d[l_ac].glar053_desc
         LET g_glar3_d[l_ac].glar020 = g_glar_d[l_ac].glar020
         LET g_glar3_d[l_ac].glar020_3_desc = g_glar_d[l_ac].glar020_desc
         LET g_glar3_d[l_ac].glar022 = g_glar_d[l_ac].glar022
         LET g_glar3_d[l_ac].glar022_3_desc = g_glar_d[l_ac].glar022_desc 
         LET g_glar3_d[l_ac].glar023 = g_glar_d[l_ac].glar023
         LET g_glar3_d[l_ac].glar023_3_desc = g_glar_d[l_ac].glar023_desc
         LET g_glar3_d[l_ac].glar024 = g_glar_d[l_ac].glar024
         LET g_glar3_d[l_ac].glar024_3_desc = g_glar_d[l_ac].glar024_desc 
         LET g_glar3_d[l_ac].glar025 = g_glar_d[l_ac].glar025
         LET g_glar3_d[l_ac].glar025_3_desc = g_glar_d[l_ac].glar025_desc
         LET g_glar3_d[l_ac].glar026 = g_glar_d[l_ac].glar026
         LET g_glar3_d[l_ac].glar026_3_desc = g_glar_d[l_ac].glar026_desc 
         LET g_glar3_d[l_ac].glar027 = g_glar_d[l_ac].glar027
         LET g_glar3_d[l_ac].glar027_3_desc = g_glar_d[l_ac].glar027_desc
         LET g_glar3_d[l_ac].glar028 = g_glar_d[l_ac].glar028
         LET g_glar3_d[l_ac].glar028_3_desc = g_glar_d[l_ac].glar028_desc
         LET g_glar3_d[l_ac].glar029 = g_glar_d[l_ac].glar029
         LET g_glar3_d[l_ac].glar029_3_desc = g_glar_d[l_ac].glar029_desc
         LET g_glar3_d[l_ac].glar030 = g_glar_d[l_ac].glar030
         LET g_glar3_d[l_ac].glar030_3_desc = g_glar_d[l_ac].glar030_desc 
         LET g_glar3_d[l_ac].glar031 = g_glar_d[l_ac].glar031
         LET g_glar3_d[l_ac].glar031_3_desc = g_glar_d[l_ac].glar031_desc
         LET g_glar3_d[l_ac].glar032 = g_glar_d[l_ac].glar032
         LET g_glar3_d[l_ac].glar032_3_desc = g_glar_d[l_ac].glar032_desc 
         LET g_glar3_d[l_ac].glar033 = g_glar_d[l_ac].glar033
         LET g_glar3_d[l_ac].glar033_3_desc = g_glar_d[l_ac].glar033_desc
      END IF
      
      #根据科目+核算项逐期抓取金额
      #############################################抓取金额SQL(S)##############################################
      LET l_glac002=g_glar_d[l_ac].glar001
      IF cl_null(l_glac002_o) OR l_glac002_o <> l_glac002 THEN
         #当科目是统治科目时，抓取下层明细科目
         IF l_glac003 = '1' THEN
            #抓取科目对应的明细科目或者独立科目
            CALL s_voucher_get_glac_str(g_glaa004,l_glac002) RETURNING l_glaq002
         ELSE
            LET l_glaq002 = "'",l_glac002,"'"
         END IF
         
         IF tm.show_ce <> 'Y' THEN
            LET l_glac002_str = " AND glac002 IN (",l_glaq002,")"
         END IF
         
         #当该统治科目没有下层明细科目时，抓取该科目本身资料
         IF cl_null(l_glaq002) THEN
            LET l_glaq002 = " AND glaq002='",l_glac002,"'"
         ELSE
            LET l_glaq002 = " AND glaq002 IN (",l_glaq002,")"
         END IF
         
         LET l_glac002_o = l_glac002 #记录旧值
      END IF
      
      #核算项组成sql条件语句
      CALL aglq854_fix_acc_sql() RETURNING l_hsx_glar,l_hsx_glaq
      
      #凭证状态为已过账，时间区间为整期间，抓取余额档glar_t资料
      IF tm.stus = '1' AND l_flag = TRUE THEN
         LET l_sql=l_sql_pr1," AND glar001 ='",g_glar_d[l_ac].glar001,"'",l_hsx_glar
         PREPARE aglq854_sum_pr1 FROM l_sql
         #不含年结YE凭证
         IF tm.show_ye<>'Y' THEN
            LET l_sql=l_sql_ye,l_glaq002,l_hsx_glaq
            PREPARE aglq854_ye_pr1 FROM l_sql
         END IF
      ELSE
      #抓取凭证glaq_t资料
         LET l_sql=l_sql_pr2,l_glaq002,l_hsx_glaq
         PREPARE aglq854_sum_pr2 FROM l_sql
         #累計額
         IF tm.kind = '2' THEN
            #年初数
            LET l_sql=l_sql_nch," AND glar001 ='",g_glar_d[l_ac].glar001,"'",l_hsx_glar
            PREPARE aglq854_nch_pr1 FROM l_sql
         END IF
      END IF
      #不含月结凭证
      IF tm.show_ce<>'Y' THEN
         LET l_sql=l_sql_ce,l_glaq002,l_hsx_glaq,
                   "   AND (",
                   "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                   "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                   "                                         AND glac007='6' ",l_glac002_str,"))",
                   "         OR ",
                   "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                   "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                   "                                         AND glac010 <> 'N' ",
                   "                                         AND glac007='5' ",l_glac002_str,"))",
                   "       )"
         PREPARE aglq854_ce_pr1 FROM l_sql
      END IF
      #############################################抓取金额SQL(E)##############################################
      
      #########################################按照年期逐年抓取金额(S)##########################################
      #160727-00005#2--add--str--
      #合計列金額初始化
      LET g_glar_d[l_ac].sum1=0
      LET g_glar2_d[l_ac].sum2=0
      LET g_glar3_d[l_ac].sum3=0
      #160727-00005#2--add--end
      
      LET l_i=1 #记录查询了几个期间
      FOR l_yy = tm.syear TO tm.eyear
         IF l_yy = tm.syear THEN
            LET l_mm = tm.smonth
         ELSE
            LET l_mm = 1
         END IF
         IF l_yy = tm.eyear THEN
            LET l_max_period = tm.emonth
         ELSE
            #獲取現行會計週期最大期別
            SELECT MAX(glav006) INTO l_max_period FROM glav_t 
            WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=l_yy
         END IF
         WHILE l_mm <= l_max_period
            #抓取该期别起始和截止日期
            SELECT MIN(glav004),MAX(glav004) INTO l_sdate,l_edate FROM glav_t
            WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=l_yy AND glav006=l_mm
            IF l_yy=tm.syear AND l_mm = tm.smonth THEN #表示第一期
               LET l_sdate = tm.sdate
            END IF
            IF l_yy=tm.eyear AND l_mm = tm.emonth THEN #表示最后第一期
               LET l_edate = tm.edate
            END IF
            LET l_amt1=0    
            LET l_amt2=0     
            LET l_amt3=0
            LET l_amt4=0    
            LET l_amt5=0     
            LET l_amt6=0
            LET l_amt7=0    
            LET l_amt8=0     
            LET l_amt9=0
            #發生額
            IF tm.kind = '1' THEN
               #凭证状态为已过账，时间区间为整期间，抓取余额档glar_t资料
               IF tm.stus = '1' AND l_flag = TRUE THEN
                  EXECUTE aglq854_sum_pr1 USING l_yy,l_mm INTO l_amt1,l_amt2,l_amt3
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = 'EXECUTE aglq854_sum_pr1'
                      LET g_errparam.code   = SQLCA.sqlcode
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
                  IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
                  IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
                  #不含年结YE凭证
                  IF tm.show_ye<>'Y' THEN
                     EXECUTE aglq854_ye_pr1 USING l_yy,l_mm INTO l_amt4,l_amt5,l_amt6
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = 'EXECUTE aglq854_ye_pr1'
                         LET g_errparam.code   = SQLCA.sqlcode
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         LET l_success = FALSE
                     END IF
                     IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
                     IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
                     IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
                     LET l_amt1=l_amt1-l_amt4
                     LET l_amt2=l_amt2-l_amt5
                     LET l_amt3=l_amt3-l_amt6
                  END IF
               ELSE
               #抓取凭证glaq_t资料
                  EXECUTE aglq854_sum_pr2 USING l_sdate,l_edate INTO l_amt1,l_amt2,l_amt3
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = 'EXECUTE aglq854_sum_pr2'
                      LET g_errparam.code   = SQLCA.sqlcode
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
                  IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
                  IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
               END IF
               #不含月结凭证
               IF tm.show_ce<>'Y' THEN
                  EXECUTE aglq854_ce_pr1 USING l_sdate,l_edate INTO l_amt7,l_amt8,l_amt9
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = 'EXECUTE aglq854_ce_pr1'
                      LET g_errparam.code   = SQLCA.sqlcode
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
                  IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
                  IF cl_null(l_amt9) THEN LET l_amt9=0 END IF
                  LET l_amt1=l_amt1-l_amt7
                  LET l_amt2=l_amt2-l_amt8
                  LET l_amt3=l_amt3-l_amt9
               END IF
             ELSE  
            #累計額
               #凭证状态为已过账，时间区间为整期间，抓取余额档glar_t资料
               IF tm.stus = '1' AND l_flag = TRUE THEN
                  EXECUTE aglq854_sum_pr1 USING l_yy,l_mm INTO l_amt1,l_amt2,l_amt3
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = 'EXECUTE aglq854_sum_pr1'
                      LET g_errparam.code   = SQLCA.sqlcode
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
                  IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
                  IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
                  #不含年结YE凭证
                  IF tm.show_ye<>'Y' THEN
                     EXECUTE aglq854_ye_pr1 USING l_yy,l_mm INTO l_amt4,l_amt5,l_amt6
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = 'EXECUTE aglq854_ye_pr1'
                         LET g_errparam.code   = SQLCA.sqlcode
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         LET l_success = FALSE
                     END IF
                     IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
                     IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
                     IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
                     LET l_amt1=l_amt1-l_amt4
                     LET l_amt2=l_amt2-l_amt5
                     LET l_amt3=l_amt3-l_amt6
                  END IF
               ELSE
               #抓取凭证glaq_t资料
                  EXECUTE aglq854_sum_pr2 USING l_yy,l_edate INTO l_amt1,l_amt2,l_amt3
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = 'EXECUTE aglq854_sum_pr2'
                      LET g_errparam.code   = SQLCA.sqlcode
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
                  IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
                  IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
                  #年初数
                  EXECUTE aglq854_nch_pr1 USING l_yy INTO l_amt4,l_amt5,l_amt6
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = 'EXECUTE aglq854_nch_pr1'
                      LET g_errparam.code   = SQLCA.sqlcode
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
                  IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
                  IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
                  LET l_amt1=l_amt1+l_amt4
                  LET l_amt2=l_amt2+l_amt5
                  LET l_amt3=l_amt3+l_amt6
               END IF
               #不含月结凭证
               IF tm.show_ce<>'Y' THEN
                  EXECUTE aglq854_ce_pr1 USING l_yy,l_edate INTO l_amt7,l_amt8,l_amt9
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = 'EXECUTE aglq854_ce_pr1'
                      LET g_errparam.code   = SQLCA.sqlcode
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
                  IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
                  IF cl_null(l_amt9) THEN LET l_amt9=0 END IF
                  LET l_amt1=l_amt1-l_amt7
                  LET l_amt2=l_amt2-l_amt8
                  LET l_amt3=l_amt3-l_amt9
               END IF
            END IF
            
            #根据科目的余额型态显示结果
            IF l_glac008 ='2' THEN #贷余=贷-借
               LET l_amt1 = l_amt1 * -1
               LET l_amt2 = l_amt3 * -1
               LET l_amt2 = l_amt3 * -1
            END IF
           
            #160727-00005#2--add--str--
            #發生額時，合計列金額=各期金額合計
            IF tm.kind = '1' THEN
               LET g_glar_d[l_ac].sum1 = g_glar_d[l_ac].sum1 + l_amt1
               LET g_glar2_d[l_ac].sum2 = g_glar2_d[l_ac].sum2 + l_amt2
               LET g_glar3_d[l_ac].sum3 = g_glar3_d[l_ac].sum3 + l_amt3
            END IF
            #160727-00005#2--add--end
      
            CASE l_i
               WHEN 1 
                  LET g_glar_d[l_ac].amt1=l_amt1
                  LET g_glar2_d[l_ac].amt201=l_amt2          
                  LET g_glar3_d[l_ac].amt301=l_amt3
               WHEN 2 
                  LET g_glar_d[l_ac].amt2=l_amt1
                  LET g_glar2_d[l_ac].amt202=l_amt2          
                  LET g_glar3_d[l_ac].amt302=l_amt3
               WHEN 3 
                  LET g_glar_d[l_ac].amt3=l_amt1
                  LET g_glar2_d[l_ac].amt203=l_amt2          
                  LET g_glar3_d[l_ac].amt303=l_amt3
               WHEN 4 
                  LET g_glar_d[l_ac].amt4=l_amt1
                  LET g_glar2_d[l_ac].amt204=l_amt2          
                  LET g_glar3_d[l_ac].amt304=l_amt3
               WHEN 5 
                  LET g_glar_d[l_ac].amt5=l_amt1
                  LET g_glar2_d[l_ac].amt205=l_amt2          
                  LET g_glar3_d[l_ac].amt305=l_amt3
               WHEN 6 
                  LET g_glar_d[l_ac].amt6=l_amt1
                  LET g_glar2_d[l_ac].amt206=l_amt2          
                  LET g_glar3_d[l_ac].amt306=l_amt3
               WHEN 7 
                  LET g_glar_d[l_ac].amt7=l_amt1
                  LET g_glar2_d[l_ac].amt207=l_amt2          
                  LET g_glar3_d[l_ac].amt307=l_amt3
               WHEN 8 
                  LET g_glar_d[l_ac].amt8=l_amt1
                  LET g_glar2_d[l_ac].amt208=l_amt2          
                  LET g_glar3_d[l_ac].amt308=l_amt3
               WHEN 9 
                  LET g_glar_d[l_ac].amt9=l_amt1
                  LET g_glar2_d[l_ac].amt209=l_amt2          
                  LET g_glar3_d[l_ac].amt309=l_amt3
               WHEN 10 
                  LET g_glar_d[l_ac].amt10=l_amt1
                  LET g_glar2_d[l_ac].amt210=l_amt2          
                  LET g_glar3_d[l_ac].amt310=l_amt3
               WHEN 11 
                  LET g_glar_d[l_ac].amt11=l_amt1
                  LET g_glar2_d[l_ac].amt211=l_amt2          
                  LET g_glar3_d[l_ac].amt311=l_amt3
               WHEN 12 
                  LET g_glar_d[l_ac].amt12=l_amt1
                  LET g_glar2_d[l_ac].amt212=l_amt2          
                  LET g_glar3_d[l_ac].amt312=l_amt3
            END CASE
             
            ######################设置金额栏位说明显示(S)######################
            IF l_ac = 1 THEN
               #金额栏位說明格式‘2016年09期’
               LET l_desc=l_yy USING "&&&&",l_yy_desc,l_mm USING '&&',l_mm_desc
               LET l_index = l_i USING "<<<<"
               CALL cl_set_comp_att_text("amt" || l_index,l_desc)
               IF tm.ctype='1' OR tm.ctype='3' THEN
                  LET l_index = l_i+200 USING "<<<<"
                  CALL cl_set_comp_att_text("amt" || l_index,l_desc)
               END IF
               IF tm.ctype='2' OR tm.ctype='3' THEN
                  LET l_index = l_i+300 USING "<<<<"
                  CALL cl_set_comp_att_text("amt" || l_index,l_desc)
               END IF
            END IF
            ######################设置金额栏位说明显示(E)######################
            LET l_i=l_i+1
            LET l_mm=l_mm+1 
         END WHILE
      END FOR
      
      #160727-00005#2--add--str--
      #累計餘額時，合計列金額=最後一期金額
      IF tm.kind = '2' THEN
         LET g_glar_d[l_ac].sum1 = l_amt1
         LET g_glar2_d[l_ac].sum2 = l_amt2
         LET g_glar3_d[l_ac].sum3 = l_amt3
      END IF
      #160727-00005#2--add--end
      
      ######################设置金额栏位的显示(S)######################
      IF l_ac = 1 THEN
         LET l_str = NULL 
         LET l_str2= NULL
         LET l_str3= NULL 
         LET l_i = l_i - 1
         LET g_col_mm=l_i  #单身显示的期别个数
         FOR l_j = 1 TO l_i
            IF cl_null(l_str) THEN 
               LET l_str = l_str CLIPPED,"amt" CLIPPED,l_j USING '<<<<' 
            ELSE
               LET l_str = l_str CLIPPED,",amt" CLIPPED,l_j USING '<<<<' 
            END IF
            IF tm.ctype='1' OR tm.ctype='3' THEN
               IF cl_null(l_str2) THEN 
                  LET l_str2 = l_str2 CLIPPED,"amt" CLIPPED,l_j + 200 USING '<<<<' 
               ELSE
                  LET l_str2 = l_str2 CLIPPED,",amt" CLIPPED,l_j + 200 USING '<<<<' 
               END IF
            END IF
            IF tm.ctype='2' OR tm.ctype='3' THEN
               IF cl_null(l_str3) THEN 
                   LET l_str3 = l_str3 CLIPPED,"amt",l_j + 300 USING '<<<<'
                ELSE
                   LET l_str3 = l_str3 CLIPPED,",amt",l_j + 300 USING '<<<<'       
                END IF
            END IF
         END FOR
         CALL cl_set_comp_visible(l_str,TRUE)
         IF tm.ctype='1' OR tm.ctype='3' THEN
            CALL cl_set_comp_visible(l_str2,TRUE)
         END IF
         IF tm.ctype='2' OR tm.ctype='3' THEN
            CALL cl_set_comp_visible(l_str3,TRUE)
         END IF
      END IF
      ######################设置金额栏位的显示(S)######################
      #########################################按照年期逐年抓取金额(E)##########################################
      
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
   CALL cl_err_collect_show()
   CALL g_glar_d.deleteElement(g_glar_d.getLength())   
   CALL g_glar2_d.deleteElement(g_glar2_d.getLength())
   CALL g_glar3_d.deleteElement(g_glar3_d.getLength())
   LET g_detail_cnt = g_glar_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
END FUNCTION

################################################################################
# Descriptions...: 根據核算項勾選組SQL語句
# Memo...........:
# Usage..........: CALL aglq854_fix_acc_get_sql()
#                  RETURNING r_sql,r_sql1
# Return code....: r_sql    關於glar_t的SQL語句
#                : r_sql1   關於glaq_t的SQL語句
# Date & Author..: 2016/09/05 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq854_fix_acc_get_sql()
   DEFINE r_sql,r_sql1,r_sql2,r_sql3,r_sql4   STRING 
   
   LET r_sql= ''
   LET r_sql1=''
   LET r_sql2=''
   LET r_sql3=''
   LET r_sql4=''
   IF tm.comp='Y' THEN
      LET r_sql =r_sql,",glar012"
      LET r_sql1=r_sql1,",glaq017"
      LET r_sql2=r_sql2,",glaq017 glar012"
      LET r_sql3=r_sql3," glar012 <> ' '"
      LET r_sql4=r_sql4," glaq017 <> ' '"
   END IF
   
   IF tm.glad007='Y' THEN
      LET r_sql =r_sql,",glar013"
      LET r_sql1=r_sql1,",glaq018"
      LET r_sql2=r_sql2,",glaq018 glar013"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar013 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar013 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq018 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq018 <> ' '"
      END IF
   END IF
   
   IF tm.glad008='Y' THEN
      LET r_sql =r_sql,",glar014"
      LET r_sql1=r_sql1,",glaq019"
      LET r_sql2=r_sql2,",glaq019 glar014"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar014 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar014 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq019 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq019 <> ' '"
      END IF
   END IF
   
   IF tm.glad009='Y' THEN
      LET r_sql =r_sql,",glar015"
      LET r_sql1=r_sql1,",glaq020"
      LET r_sql2=r_sql2,",glaq020 glar015"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar015 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar015 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq020 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq020 <> ' '"
      END IF
   END IF
   
   IF tm.glad010='Y' THEN
      LET r_sql =r_sql,",glar016"
      LET r_sql1=r_sql1,",glaq021"
      LET r_sql2=r_sql2,",glaq021 glar016"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar016 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar016 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq021 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq021 <> ' '"
      END IF
   END IF
   
   IF tm.glad027='Y' THEN
      LET r_sql =r_sql,",glar017"
      LET r_sql1=r_sql1,",glaq022"
      LET r_sql2=r_sql2,",glaq022 glar017"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar017 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar017 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq022 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq022 <> ' '"
      END IF
   END IF
   
   IF tm.glad011='Y' THEN
      LET r_sql =r_sql,",glar018"
      LET r_sql1=r_sql1,",glaq023"
      LET r_sql2=r_sql2,",glaq023 glar018"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar018 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar018 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq023 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq023 <> ' '"
      END IF
   END IF
   
   IF tm.glad012='Y' THEN
      LET r_sql =r_sql,",glar019"
      LET r_sql1=r_sql1,",glaq024"
      LET r_sql2=r_sql2,",glaq024 glar019"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar019 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar019 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq024 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq024 <> ' '"
      END IF
   END IF
   
   #經營方式
   IF tm.glad031='Y' THEN
      LET r_sql =r_sql,",glar051"
      LET r_sql1=r_sql1,",glaq051"
      LET r_sql2=r_sql2,",glaq051 glar051"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar051 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar051 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq051 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq051 <> ' '"
      END IF
   END IF
   
   #渠道
   IF tm.glad032='Y' THEN
      LET r_sql =r_sql,",glar052"
      LET r_sql1=r_sql1,",glaq052"
      LET r_sql2=r_sql2,",glaq052 glar052"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar052 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar052 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq052 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq052 <> ' '"
      END IF
   END IF
   
   #品牌
   IF tm.glad033='Y' THEN
      LET r_sql =r_sql,",glar053"
      LET r_sql1=r_sql1,",glaq053"
      LET r_sql2=r_sql2,",glaq053 glar053"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar053 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar053 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq053 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq053 <> ' '"
      END IF
   END IF
   
   IF tm.glad013='Y' THEN
      LET r_sql =r_sql,",glar020"
      LET r_sql1=r_sql1,",glaq025"
      LET r_sql2=r_sql2,",glaq025 glar020"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar020 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar020 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq025 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq025 <> ' '"
      END IF
   END IF
   
   IF tm.glad015='Y' THEN
      LET r_sql =r_sql,",glar022"
      LET r_sql1=r_sql1,",glaq027"
      LET r_sql2=r_sql2,",glaq027 glar022"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar022 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar022 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq027 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq027 <> ' '"
      END IF
   END IF
   
   IF tm.glad016='Y' THEN
      LET r_sql =r_sql,",glar023"
      LET r_sql1=r_sql1,",glaq028"
      LET r_sql2=r_sql2,",glaq028 glar023"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar023 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar023 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq028 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq028 <> ' '"
      END IF
   END IF
   
   IF tm.glad017='Y' THEN
      LET r_sql =r_sql,",glar024"
      LET r_sql1=r_sql1,",glaq029"
      LET r_sql2=r_sql2,",glaq029 glar024"
   END IF
   
   IF tm.glad018='Y' THEN
      LET r_sql =r_sql,",glar025"
      LET r_sql1=r_sql1,",glaq030"
      LET r_sql2=r_sql2,",glaq030 glar025"
   END IF
   
   IF tm.glad019='Y' THEN
      LET r_sql =r_sql,",glar026"
      LET r_sql1=r_sql1,",glaq031"
      LET r_sql2=r_sql2,",glaq031 glar026"
   END IF
   
   IF tm.glad020='Y' THEN
      LET r_sql =r_sql,",glar027"
      LET r_sql1=r_sql1,",glaq032"
      LET r_sql2=r_sql2,",glaq032 glar027"
   END IF
   
   IF tm.glad021='Y' THEN
      LET r_sql =r_sql,",glar028"
      LET r_sql1=r_sql1,",glaq033"
      LET r_sql2=r_sql2,",glaq033 glar028"
   END IF
   
   IF tm.glad022='Y' THEN
      LET r_sql =r_sql,",glar029"
      LET r_sql1=r_sql1,",glaq034"
      LET r_sql2=r_sql2,",glaq034 glar029"
   END IF
   
   IF tm.glad023='Y' THEN
      LET r_sql =r_sql,",glar030"
      LET r_sql1=r_sql1,",glaq035"
      LET r_sql2=r_sql2,",glaq035 glar030"
   END IF
   
   IF tm.glad024='Y' THEN
      LET r_sql =r_sql,",glar031"
      LET r_sql1=r_sql1,",glaq036"
      LET r_sql2=r_sql2,",glaq036 glar031"
   END IF
   
   IF tm.glad025='Y' THEN
      LET r_sql =r_sql,",glar032"
      LET r_sql1=r_sql1,",glaq037"
      LET r_sql2=r_sql2,",glaq037 glar032"
   END IF
   
   IF tm.glad026='Y' THEN
      LET r_sql =r_sql,",glar033"
      LET r_sql1=r_sql1,",glaq038"
      LET r_sql2=r_sql2,",glaq038 glar033"
   END IF
   IF NOT cl_null(r_sql3) THEN
      LET r_sql3=" AND ( ",r_sql3," )"
   END IF
   IF NOT cl_null(r_sql4) THEN
      LET r_sql4=" AND ( ",r_sql4," )"
   END IF
   RETURN r_sql,r_sql1,r_sql2,r_sql3,r_sql4
END FUNCTION

################################################################################
# Descriptions...: 创建临时表
# Memo...........:
# Usage..........: CALL aglq854_create_temp_table()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/09/07 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq854_create_temp_table()
  DROP TABLE aglq854_tmp
   CREATE TEMP TABLE aglq854_tmp(
   glarent      LIKE glar_t.glarent,
   glar001      LIKE glar_t.glar001,
   glar012      LIKE glar_t.glar012,
   glar013      LIKE glar_t.glar013,
   glar014      LIKE glar_t.glar014,
   glar015      LIKE glar_t.glar015,
   glar016      LIKE glar_t.glar016,
   glar017      LIKE glar_t.glar017,
   glar018      LIKE glar_t.glar018,
   glar019      LIKE glar_t.glar019,
   glar051      LIKE glar_t.glar051,
   glar052      LIKE glar_t.glar052,
   glar053      LIKE glar_t.glar053,
   glar020      LIKE glar_t.glar020,
   glar022      LIKE glar_t.glar022,
   glar023      LIKE glar_t.glar023,
   glar024      LIKE glar_t.glar024,
   glar025      LIKE glar_t.glar025,
   glar026      LIKE glar_t.glar026,
   glar027      LIKE glar_t.glar027,
   glar028      LIKE glar_t.glar028,
   glar029      LIKE glar_t.glar029,
   glar030      LIKE glar_t.glar030,
   glar031      LIKE glar_t.glar031,
   glar032      LIKE glar_t.glar032,
   glar033      LIKE glar_t.glar033
   )
   DROP TABLE aglq854_tmp01
   CREATE TEMP TABLE aglq854_tmp01(
   glarent      LIKE glar_t.glarent,
   glarld       LIKE glar_t.glarld,
   glaald_desc LIKE type_t.chr500,
   glaacomp_desc LIKE type_t.chr500,
   glaa001_desc LIKE type_t.chr500,
   sdate LIKE type_t.chr500,
   edate LIKE type_t.chr500,
   ctype LIKE type_t.chr500,
   glac005 LIKE glac_t.glac005,
   stus LIKE type_t.chr500,
   glar001 LIKE glar_t.glar001, 
   glar001_desc LIKE type_t.chr500, 
   glar012 LIKE glar_t.glar012, 
   glar012_desc LIKE type_t.chr500, 
   glar013 LIKE glar_t.glar013, 
   glar013_desc LIKE type_t.chr500, 
   glar014 LIKE glar_t.glar014, 
   glar014_desc LIKE type_t.chr500, 
   glar015 LIKE glar_t.glar015, 
   glar015_desc LIKE type_t.chr500, 
   glar016 LIKE glar_t.glar016, 
   glar016_desc LIKE type_t.chr500, 
   glar017 LIKE glar_t.glar017, 
   glar017_desc LIKE type_t.chr500, 
   glar018 LIKE glar_t.glar018, 
   glar018_desc LIKE type_t.chr500, 
   glar019 LIKE glar_t.glar019, 
   glar019_desc LIKE type_t.chr500, 
   glar051 LIKE glar_t.glar051, 
   glar052 LIKE glar_t.glar052, 
   glar052_desc LIKE type_t.chr500, 
   glar053 LIKE glar_t.glar053, 
   glar053_desc LIKE type_t.chr500, 
   glar020 LIKE glar_t.glar020, 
   glar020_desc LIKE type_t.chr500, 
   glar022 LIKE glar_t.glar022, 
   glar022_desc LIKE type_t.chr500, 
   glar023 LIKE glar_t.glar023, 
   glar023_desc LIKE type_t.chr500, 
   glar024 LIKE glar_t.glar024, 
   glar024_desc LIKE type_t.chr500, 
   glar025 LIKE glar_t.glar025, 
   glar025_desc LIKE type_t.chr500, 
   glar026 LIKE glar_t.glar026, 
   glar026_desc LIKE type_t.chr500, 
   glar027 LIKE glar_t.glar027, 
   glar027_desc LIKE type_t.chr500, 
   glar028 LIKE glar_t.glar028, 
   glar028_desc LIKE type_t.chr500, 
   glar029 LIKE glar_t.glar029, 
   glar029_desc LIKE type_t.chr500, 
   glar030 LIKE glar_t.glar030, 
   glar030_desc LIKE type_t.chr500, 
   glar031 LIKE glar_t.glar031, 
   glar031_desc LIKE type_t.chr500, 
   glar032 LIKE glar_t.glar032, 
   glar032_desc LIKE type_t.chr500, 
   glar033 LIKE glar_t.glar033, 
   glar033_desc LIKE type_t.chr500, 
   amt1 LIKE type_t.num20_6, 
   amt2 LIKE type_t.num20_6, 
   amt3 LIKE type_t.num20_6, 
   amt4 LIKE type_t.num20_6, 
   amt5 LIKE type_t.num20_6, 
   amt6 LIKE type_t.num20_6, 
   amt7 LIKE type_t.num20_6, 
   amt8 LIKE type_t.num20_6, 
   amt9 LIKE type_t.num20_6, 
   amt10 LIKE type_t.num20_6, 
   amt11 LIKE type_t.num20_6, 
   amt12 LIKE type_t.num20_6,
   sum1 LIKE type_t.num20_6,   #160727-00005#2 add
   amt201 LIKE type_t.num20_6, 
   amt202 LIKE type_t.num20_6, 
   amt203 LIKE type_t.num20_6, 
   amt204 LIKE type_t.num20_6, 
   amt205 LIKE type_t.num20_6, 
   amt206 LIKE type_t.num20_6, 
   amt207 LIKE type_t.num20_6, 
   amt208 LIKE type_t.num20_6, 
   amt209 LIKE type_t.num20_6, 
   amt210 LIKE type_t.num20_6, 
   amt211 LIKE type_t.num20_6, 
   amt212 LIKE type_t.num20_6,
   sum2 LIKE type_t.num20_6,    #160727-00005#2 add
   amt301 LIKE type_t.num20_6, 
   amt302 LIKE type_t.num20_6, 
   amt303 LIKE type_t.num20_6, 
   amt304 LIKE type_t.num20_6, 
   amt305 LIKE type_t.num20_6, 
   amt306 LIKE type_t.num20_6, 
   amt307 LIKE type_t.num20_6, 
   amt308 LIKE type_t.num20_6, 
   amt309 LIKE type_t.num20_6, 
   amt310 LIKE type_t.num20_6, 
   amt311 LIKE type_t.num20_6, 
   amt312 LIKE type_t.num20_6,
   sum3 LIKE type_t.num20_6,    #160727-00005#2 add
   seq    LIKE type_t.num10
   )
END FUNCTION

################################################################################
# Descriptions...: 根据传入的核算项值组成SQL语句
# Memo...........:
# Usage..........: CALL aglq854_fix_acc_sql()
#                  RETURNING r_sql,r_sql1
# Input parameter: 
# Return code....: r_sql，r_sql1 組合SQL語句
# Date & Author..: 2016/09/07 By 02599
# Modify.........: 
################################################################################
PRIVATE FUNCTION aglq854_fix_acc_sql()
   DEFINE r_sql,r_sql1         STRING
   
   LET r_sql=''
   LET r_sql1=''
      
   IF tm.comp='Y' THEN
      LET r_sql=r_sql," AND glar012='",g_glar_d[l_ac].glar012,"'"
      LET r_sql1=r_sql1," AND glaq017='",g_glar_d[l_ac].glar012,"'"
   END IF
   
   IF tm.glad007='Y' THEN
      LET r_sql=r_sql," AND glar013='",g_glar_d[l_ac].glar013,"'"
      LET r_sql1=r_sql1," AND glaq018='",g_glar_d[l_ac].glar013,"'"
   END IF
   
   IF tm.glad008='Y' THEN
      LET r_sql=r_sql," AND glar014='",g_glar_d[l_ac].glar014,"'"
      LET r_sql1=r_sql1," AND glaq019='",g_glar_d[l_ac].glar014,"'"
   END IF
   
   IF tm.glad009='Y' THEN
      LET r_sql=r_sql," AND glar015='",g_glar_d[l_ac].glar015,"'"
      LET r_sql1=r_sql1," AND glaq020='",g_glar_d[l_ac].glar015,"'"
   END IF
   
   IF tm.glad010='Y' THEN
      LET r_sql=r_sql," AND glar016='",g_glar_d[l_ac].glar016,"'"
      LET r_sql1=r_sql1," AND glaq021='",g_glar_d[l_ac].glar016,"'"
   END IF
   
   IF tm.glad027='Y' THEN
      LET r_sql=r_sql," AND glar017='",g_glar_d[l_ac].glar017,"'"
      LET r_sql1=r_sql1," AND glaq022='",g_glar_d[l_ac].glar017,"'"
   END IF
      
   IF tm.glad011='Y' THEN
      LET r_sql=r_sql," AND glar018='",g_glar_d[l_ac].glar018,"'"
      LET r_sql1=r_sql1," AND glaq023='",g_glar_d[l_ac].glar018,"'"
   END IF
   
   IF tm.glad012='Y' THEN
      LET r_sql=r_sql," AND glar019='",g_glar_d[l_ac].glar019,"'"
      LET r_sql1=r_sql1," AND glaq024='",g_glar_d[l_ac].glar019,"'"
   END IF
   
   #經營方式
   IF tm.glad031='Y' THEN
      LET r_sql=r_sql," AND glar051='",g_glar_d[l_ac].glar051,"'"
      LET r_sql1=r_sql1," AND glaq051='",g_glar_d[l_ac].glar051,"'"
   END IF
   #渠道
   IF tm.glad032='Y' THEN
      LET r_sql=r_sql," AND glar052='",g_glar_d[l_ac].glar052,"'"
      LET r_sql1=r_sql1," AND glaq052='",g_glar_d[l_ac].glar052,"'"
   END IF
   #品牌
   IF tm.glad033='Y' THEN
      LET r_sql=r_sql," AND glar053='",g_glar_d[l_ac].glar053,"'"
      LET r_sql1=r_sql1," AND glaq053='",g_glar_d[l_ac].glar053,"'"
   END IF
   
   IF tm.glad013='Y' THEN
      LET r_sql=r_sql," AND glar020='",g_glar_d[l_ac].glar020,"'"
      LET r_sql1=r_sql1," AND glaq025='",g_glar_d[l_ac].glar020,"'"
   END IF
   
   IF tm.glad015='Y' THEN
      LET r_sql=r_sql," AND glar022='",g_glar_d[l_ac].glar022,"'"
      LET r_sql1=r_sql1," AND glaq027='",g_glar_d[l_ac].glar022,"'"
   END IF
   
   IF tm.glad016='Y' THEN
      LET r_sql=r_sql," AND glar023='",g_glar_d[l_ac].glar023,"'"
      LET r_sql1=r_sql1," AND glaq028='",g_glar_d[l_ac].glar023,"'"
   END IF
   
   IF tm.glad017='Y' THEN
      LET r_sql=r_sql," AND glar024='",g_glar_d[l_ac].glar024,"'"
      LET r_sql1=r_sql1," AND glaq029='",g_glar_d[l_ac].glar024,"'"
   END IF
   
   IF tm.glad018='Y' THEN
      LET r_sql=r_sql," AND glar025='",g_glar_d[l_ac].glar025,"'"
      LET r_sql1=r_sql1," AND glaq030='",g_glar_d[l_ac].glar025,"'"
   END IF
   
   IF tm.glad019='Y' THEN
      LET r_sql=r_sql," AND glar026='",g_glar_d[l_ac].glar026,"'"
      LET r_sql1=r_sql1," AND glaq031='",g_glar_d[l_ac].glar026,"'"
   END IF
   
   IF tm.glad020='Y' THEN
      LET r_sql=r_sql," AND glar027='",g_glar_d[l_ac].glar027,"'"
      LET r_sql1=r_sql1," AND glaq032='",g_glar_d[l_ac].glar027,"'"
   END IF
   
   IF tm.glad021='Y' THEN
      LET r_sql=r_sql," AND glar028='",g_glar_d[l_ac].glar028,"'"
      LET r_sql1=r_sql1," AND glaq033='",g_glar_d[l_ac].glar028,"'"
   END IF
   
   IF tm.glad022='Y' THEN
      LET r_sql=r_sql," AND glar029='",g_glar_d[l_ac].glar029,"'"
      LET r_sql1=r_sql1," AND glaq034='",g_glar_d[l_ac].glar029,"'"
   END IF
   
   IF tm.glad023='Y' THEN
      LET r_sql=r_sql," AND glar030='",g_glar_d[l_ac].glar030,"'"
      LET r_sql1=r_sql1," AND glaq035='",g_glar_d[l_ac].glar030,"'"
   END IF
   
   IF tm.glad024='Y' THEN
      LET r_sql=r_sql," AND glar031='",g_glar_d[l_ac].glar031,"'"
      LET r_sql1=r_sql1," AND glaq036='",g_glar_d[l_ac].glar031,"'"
   END IF
   
   IF tm.glad025='Y' THEN
      LET r_sql=r_sql," AND glar032='",g_glar_d[l_ac].glar032,"'"
      LET r_sql1=r_sql1," AND glaq037='",g_glar_d[l_ac].glar032,"'"
   END IF
   
   IF tm.glad026='Y' THEN
      LET r_sql=r_sql," AND glar033='",g_glar_d[l_ac].glar033,"'"
      LET r_sql1=r_sql1," AND glaq038='",g_glar_d[l_ac].glar033,"'"
   END IF
   
   RETURN r_sql,r_sql1
END FUNCTION

################################################################################
# Descriptions...: 报表
# Memo...........:
# Usage..........: CALL aglq854_output()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/09/09 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq854_output()
DEFINE l_i,l_count      LIKE type_t.num5
DEFINE l_glaald_desc    LIKE type_t.chr500,
       l_glaacomp_desc  LIKE type_t.chr500,
       l_glaa001_desc   LIKE type_t.chr500,
       l_sdate          LIKE type_t.chr500,
       l_edate          LIKE type_t.chr500,
       l_ctype          LIKE type_t.chr500,
       l_stus           LIKE type_t.chr500,
       l_glar051        LIKE type_t.chr500
DEFINE l_yy_desc                STRING
DEFINE l_mm_desc                STRING
DEFINE l_desc                   STRING
DEFINE l_yy                     LIKE glav_t.glav002
DEFINE l_mm                     LIKE glav_t.glav006
DEFINE l_max_period             LIKE glav_t.glav006
       
   DELETE FROM aglq854_tmp01 
   LET l_count = g_glar_d.getLength()
   
   LET l_glaald_desc = tm.glaald," ",tm.glaald_desc
   LET l_glaacomp_desc = tm.glaacomp," ",tm.glaacomp_desc
   LET l_glaa001_desc = tm.glaa001," ",tm.glaa016," ",tm.glaa020
   LET l_sdate = tm.sdate," ",tm.syear," ",tm.smonth
   LET l_edate = tm.edate," ",tm.eyear," ",tm.emonth
   LET l_ctype = tm.ctype,":",s_desc_gzcbl004_desc('9921',tm.ctype)
   LET l_stus = tm.stus,":",s_desc_gzcbl004_desc('9922',tm.stus)
   
   FOR l_i = 1 TO l_count
      #output函数中FOR循环INSERT语句中的数组下表错误给了l_ac应该是l_i
      IF NOT cl_null(g_glar_d[l_i].glar051) THEN #160727-00005#2 add
         LET l_glar051 = g_glar_d[l_i].glar051,":",s_desc_gzcbl004_desc('6013',g_glar_d[l_i].glar051)
      END IF #160727-00005#2 add
      INSERT INTO aglq854_tmp01 
      VALUES(g_enterprise,tm.glaald,l_glaald_desc,l_glaacomp_desc,l_glaa001_desc,l_sdate,l_edate,
         l_ctype,tm.glac005,l_stus,g_glar_d[l_i].glar001,g_glar_d[l_i].glar001_desc,
         g_glar_d[l_i].glar012,g_glar_d[l_i].glar012_desc,g_glar_d[l_i].glar013,g_glar_d[l_i].glar013_desc,
         g_glar_d[l_i].glar014,g_glar_d[l_i].glar014_desc,g_glar_d[l_i].glar015,g_glar_d[l_i].glar015_desc,
         g_glar_d[l_i].glar016,g_glar_d[l_i].glar016_desc,g_glar_d[l_i].glar017,g_glar_d[l_i].glar017_desc,
         g_glar_d[l_i].glar018,g_glar_d[l_i].glar018_desc,g_glar_d[l_i].glar019,g_glar_d[l_i].glar019_desc,
         l_glar051,g_glar_d[l_i].glar052,g_glar_d[l_i].glar052_desc,
         g_glar_d[l_i].glar053,g_glar_d[l_i].glar053_desc,g_glar_d[l_i].glar020,g_glar_d[l_i].glar020_desc,
         g_glar_d[l_i].glar022,g_glar_d[l_i].glar022_desc,g_glar_d[l_i].glar023,g_glar_d[l_i].glar023_desc,
         g_glar_d[l_i].glar024,g_glar_d[l_i].glar024_desc,g_glar_d[l_i].glar025,g_glar_d[l_i].glar025_desc,
         g_glar_d[l_i].glar026,g_glar_d[l_i].glar026_desc,g_glar_d[l_i].glar027,g_glar_d[l_i].glar027_desc,
         g_glar_d[l_i].glar028,g_glar_d[l_i].glar028_desc,g_glar_d[l_i].glar029,g_glar_d[l_i].glar029_desc,
         g_glar_d[l_i].glar030,g_glar_d[l_i].glar030_desc,g_glar_d[l_i].glar031,g_glar_d[l_i].glar031_desc,
         g_glar_d[l_i].glar032,g_glar_d[l_i].glar032_desc,g_glar_d[l_i].glar033,g_glar_d[l_i].glar033_desc,
         g_glar_d[l_i].amt1,g_glar_d[l_i].amt2,g_glar_d[l_i].amt3,g_glar_d[l_i].amt4,g_glar_d[l_i].amt5,
         g_glar_d[l_i].amt6,g_glar_d[l_i].amt7,g_glar_d[l_i].amt8,g_glar_d[l_i].amt9,g_glar_d[l_i].amt10,
         g_glar_d[l_i].amt11,g_glar_d[l_i].amt12,g_glar_d[l_i].sum1,                                       #160727-00005#2 add sum1
         g_glar2_d[l_i].amt201,g_glar2_d[l_i].amt202,g_glar2_d[l_i].amt203,g_glar2_d[l_i].amt204,
         g_glar2_d[l_i].amt205,g_glar2_d[l_i].amt206,g_glar2_d[l_i].amt207,g_glar2_d[l_i].amt208,
         g_glar2_d[l_i].amt209,g_glar2_d[l_i].amt210,g_glar2_d[l_i].amt211,g_glar2_d[l_i].amt212,g_glar2_d[l_i].sum2, #160727-00005#2 add sum2
         g_glar3_d[l_i].amt301,g_glar3_d[l_i].amt302,g_glar3_d[l_i].amt303,g_glar3_d[l_i].amt304,
         g_glar3_d[l_i].amt305,g_glar3_d[l_i].amt306,g_glar3_d[l_i].amt307,g_glar3_d[l_i].amt308,
         g_glar3_d[l_i].amt309,g_glar3_d[l_i].amt310,g_glar3_d[l_i].amt311,g_glar3_d[l_i].amt312,g_glar3_d[l_i].sum3, #160727-00005#2 add sum3
         l_i)
   END FOR

   CALL aglq854_xg_visible()
   
   #栏位说明
   LET l_yy_desc=cl_getmsg("agl-00274",g_dlang) #年
   LET l_mm_desc=cl_getmsg("axc-00589",g_dlang) #期
   LET l_i=1
   FOR l_yy = tm.syear TO tm.eyear
      IF l_yy = tm.syear THEN
         LET l_mm = tm.smonth
      ELSE
         LET l_mm = 1
      END IF
      IF l_yy = tm.eyear THEN
         LET l_max_period = tm.emonth
      ELSE
         #獲取現行會計週期最大期別
         SELECT MAX(glav006) INTO l_max_period FROM glav_t 
         WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=l_yy
      END IF
      WHILE l_mm <= l_max_period
         #金额栏位說明格式‘2016年09期’
         LET l_desc=l_yy USING "&&&&",l_yy_desc,l_mm USING '&&',l_mm_desc
         LET g_xg_fieldname[59 + l_i] = l_desc
         IF tm.ctype='1' OR tm.ctype='3' THEN
            LET g_xg_fieldname[72 + l_i] = l_desc  #160727-00005#2 mod 71-->72
         END IF
         IF tm.ctype='2' OR tm.ctype='3' THEN
            LET g_xg_fieldname[84 + l_i] = l_desc  #160727-00005#2 mod 83-->84
         END IF
         LET l_mm=l_mm+1
         LET l_i=l_i+1
      END WHILE
   END FOR
   CALL aglq854_x01(' 1=1','aglq854_tmp01',g_xg_visible)
END FUNCTION

################################################################################
# Descriptions...: 传入XG报表隐藏栏位设置
# Memo...........:
# Usage..........: CALL aglq854_xg_visible()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/09/09 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq854_xg_visible()
DEFINE l_i                  LIKE type_t.num5
DEFINE l_str,l_str2,l_str3  STRING

   LET g_xg_visible = NULL
   #隐藏没有用到的金额栏位
   FOR l_i=g_col_mm+1 TO 12 
      LET l_str='l_amt',l_i USING "<<<<"
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,l_str
      #顯示本位幣二
      IF tm.ctype='1' OR tm.ctype='3' THEN
         LET l_str2='l_amt',l_i+200 USING "<<<<"
         IF NOT cl_null(g_xg_visible) THEN
            LET g_xg_visible = g_xg_visible CLIPPED,"|"
         END IF
         LET g_xg_visible = g_xg_visible CLIPPED,l_str2
      END IF
      #顯示本位幣三
      IF tm.ctype='2' OR tm.ctype='3'  THEN
         LET l_str3='l_amt',l_i+300 USING "<<<<"
         IF NOT cl_null(g_xg_visible) THEN
            LET g_xg_visible = g_xg_visible CLIPPED,"|"
         END IF
         LET g_xg_visible = g_xg_visible CLIPPED,l_str3
      END IF
   END FOR
   #顯示本位幣三,不显示本位币二
   IF tm.ctype='2' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_amt201|l_amt202|l_amt203|l_amt204|l_amt205|l_amt206|l_amt207|l_amt208|l_amt209|l_amt210|l_amt211|l_amt212"
      LET g_xg_visible = g_xg_visible CLIPPED,"|l_sum2"  #160727-00005#2 add
   END IF
   #顯示本位幣二，不显示本位币三
   IF tm.ctype='1' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_amt301|l_amt302|l_amt303|l_amt304|l_amt305|l_amt306|l_amt307|l_amt308|l_amt309|l_amt310|l_amt311|l_amt312"
      LET g_xg_visible = g_xg_visible CLIPPED,"|l_sum3"  #160727-00005#2 add
   END IF
   #只顯示本位幣一，不显示本位币二三
   IF tm.ctype='0' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_amt201|l_amt202|l_amt203|l_amt204|l_amt205|l_amt206|l_amt207|l_amt208|l_amt209|l_amt210|l_amt211|l_amt212|l_amt301|l_amt302|l_amt303|l_amt304|l_amt305|l_amt306|l_amt307|l_amt308|l_amt309|l_amt310|l_amt311|l_amt312"
      LET g_xg_visible = g_xg_visible CLIPPED,"|l_sum2|l_sum3"  #160727-00005#2 add
   END IF
   
   IF tm.comp='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar012|l_glar012_desc"
   END IF
   
   IF tm.glad007='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar013|l_glar013_desc"
   END IF
   
   IF tm.glad008='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar014|l_glar014_desc"
   END IF
   
   IF tm.glad009='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar015|l_glar015_desc"
   END IF
   
   IF tm.glad010='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar016|l_glar016_desc"
   END IF
   
   IF tm.glad027='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar017|l_glar017_desc"
   END IF
   
   IF tm.glad011='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar018|l_glar018_desc"
   END IF
   
   IF tm.glad012='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar019|l_glar019_desc"
   END IF
   
   #經營方式
   IF tm.glad031='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_glar051"
   END IF
   
   #渠道
   IF tm.glad032='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar052|l_glar052_desc"
   END IF
   
   #品牌
   IF tm.glad033='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar053|l_glar053_desc"
   END IF
   
   IF tm.glad013='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar020|l_glar020_desc"
   END IF 
    
   IF tm.glad015='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar022|l_glar022_desc"
   END IF
   
   IF tm.glad016='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar023|l_glar023_desc"
   END IF
   
   IF tm.glad017='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar024|l_glar024_desc"
   END IF
   
   IF tm.glad018='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar025|l_glar025_desc"
   END IF
   
   IF tm.glad019='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar026|l_glar026_desc"
   END IF
   
   IF tm.glad020='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar027|l_glar027_desc"
   END IF
   
   IF tm.glad021='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar028|l_glar028_desc"
   END IF
   
   IF tm.glad022='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar029|l_glar029_desc"
   END IF
   
   IF tm.glad023='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar030|l_glar030_desc"
   END IF
   
   IF tm.glad024='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar031|l_glar031_desc"
   END IF
   
   IF tm.glad025='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar032|l_glar032_desc"
   END IF
   
   IF tm.glad026='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar033|l_glar033_desc"
   END IF
   
END FUNCTION

 
{</section>}
 
